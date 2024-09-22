create database swiggy_sales;

drop table swiggy;

CREATE TABLE swiggy(
   restaurant_no   INTEGER  NOT NULL 
  ,restaurant_name VARCHAR(50) NOT NULL
  ,city            VARCHAR(9) NOT NULL
  ,address         VARCHAR(204)
  ,rating          NUMERIC(3,1) NOT NULL
  ,cost_per_person INTEGER 
  ,cuisine         VARCHAR(49) NOT NULL
  ,restaurant_link VARCHAR(136) NOT NULL
  ,menu_category   VARCHAR(66)
  ,item            VARCHAR(188)
  ,price           VARCHAR(12) NOT NULL
  ,veg_or_nonveg   VARCHAR(7)
);

select * from swiggy; 

# HOW MANY RESTAURANTS HAVE A RATING GREATER THAN 4.5?

select count(distinct restaurant_name) as restaurant_rating from swiggy
where rating > 4.5 ;

select count(restaurant_name) from swiggy
where rating > 4.5;



# 2. WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?

select count(distinct restaurant_name) as restaurant_count, city as city_name from swiggy
group by city
order by restaurant_count desc
limit 1;

select count(distinct restaurant_name) as restuarant_name from swiggy
group by city
order by restuarant_name desc
limit 1 ;

WITH CityRestaurantCounts AS (
    SELECT 
        city AS city_name, 
        COUNT(DISTINCT restaurant_name) AS restaurant_count
    FROM 
        swiggy
    GROUP BY 
        city
)
SELECT 
    city_name, 
    restaurant_count
FROM 
    CityRestaurantCounts
ORDER BY 
    restaurant_count DESC
LIMIT 1;


# 3. HOW MANY RESTAURANTS HAVE THE WORD "PIZZA" IN THEIR NAME?

select count(distinct restaurant_name) as pizza_restuarant from swiggy
where restaurant_name like '% Pizza Hut %'; 

SELECT COUNT(*) FROM swiggy;

# 4. WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS IN THE DATASET?

SELECT * FROM swiggy;

select CUISINE, count(*) as CUISINE_count from swiggy
group by CUISINE
order by CUISINE_count desc
limit 5;


# 5. WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?

select avg(rating) as rating_avg, city as city_name from swiggy
group by city_name
order by rating_avg desc;

SELECT city AS city_name, AVG(rating) AS average_rating FROM swiggy
GROUP BY 
    city
ORDER BY 
    average_rating DESC;
    
    

# 6. WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED'  MENU CATEGORY FOR EACH RESTAURANT?

select * from swiggy;

select restaurant_name, max(price) as highest_price from swiggy
where menu_category = 'RECOMMENDED'
group by restaurant_name
order by highest_price desc ;

# 7. FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THAN INDIAN CUISINE. 

select distinct restaurant_name, max(cost_per_person) as expensive_rest from swiggy
where menu_category != 'INDIAN CUISINE'
group by restaurant_name
order by expensive_rest desc
limit 5;


# 8. FIND THE RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THE TOTAL AVERAGE COST OF ALL RESTAURANTS TOGETHER.

select * from swiggy;

SELECT DISTINCT
    restaurant_name, cost_per_person
FROM
    swiggy
WHERE
    cost_per_person > (SELECT 
            AVG(cost_per_person)
        FROM
            swiggy);

SELECT distinct restaurant_name, AVG(cost_per_person) AS avg_cost_per_person
FROM swiggy
GROUP BY restaurant_name
HAVING AVG(cost_per_person) > (SELECT AVG(cost_per_person) FROM swiggy);


# 9 .RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARE LOCATED IN DIFFERENT CITIES.

SELECT distinct restaurant_name, city FROM swiggy
WHERE restaurant_name IN (SELECT restaurant_name FROM swiggy
    GROUP BY restaurant_name
    HAVING COUNT(DISTINCT city) > 1
);

select distinct A1.restaurant_name, A1.city, 
A2.city
from swiggy
A1 join swiggy A2 on A1.restaurant_name = A2.restaurant_name
and
A1.city <> A2.city;


# 10.WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE'CATEGORY?

select * from swiggy;

select distinct restaurant_name, count(*) as menu_category from swiggy
where menu_category = 'MAIN COURSE' 
group by restaurant_name
order by menu_category desc
limit 10; 

# 11. LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN IN ALPHABETICAL ORDER OF RESTAURANT NAME.

SELECT restaurant_name, 
       (COUNT(CASE WHEN veg_or_nonveg = 'veg' THEN 1 END) * 100.0 / COUNT(*)) AS veg_percentage
FROM swiggy
GROUP BY restaurant_name
HAVING veg_percentage = 100.0
ORDER BY restaurant_name asc;

# 12.WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS? 

select distinct restaurant_name, avg(price) as lowest_price from swiggy
group by restaurant_name
order by lowest_price asc
limit 10 ;

# 13. WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?
 select * from swiggy;

select distinct restaurant_name, count(distinct menu_category) as category_items from swiggy
group by restaurant_name
order by category_items desc
limit 5;


# 14. WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?

select  * from swiggy;

select distinct restaurant_name,
(count(case when veg_or_nonveg='Non-veg' then 1 end)*100
/count(*)) as nonvegetarian_percentage
from swiggy
group by restaurant_name
order by nonvegetarian_percentage desc limit 1;