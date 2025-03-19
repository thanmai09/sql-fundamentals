DROP DATABASE IF EXISTS `Parks_and_Recreation`;
CREATE DATABASE `Parks_and_Recreation`;
USE `Parks_and_Recreation`;


CREATE TABLE employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id)
);

CREATE TABLE employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT
);


INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');


INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);



CREATE TABLE parks_departments (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name varchar(50) NOT NULL,
  PRIMARY KEY (department_id)
);

INSERT INTO parks_departments (department_name)
VALUES
('Parks and Recreation'),
('Animal Control'),
('Public Works'),
('Healthcare'),
('Library'),
('Finance');

select * from employee_demographics
where birth_date > '1985-01-01' AND gender = 'Male';


select * from employee_demographics
where first_name = 'Leslie' and age =  '44' or age > 55 ;


-- like statement
-- % and _
select * from parks_and_recreation.employee_demographics
where first_name like 'a___' and birth_date like '1977%';   #a%


-- GROUP BY
select gender, AVG(age) as avrage_age, max(age) as max_age , min(age) as min_age , count(age) as total from employee_demographics
group by gender;

select salary,occupation from employee_salary
group by salary,occupation;


-- ORDER BY 
select * from employee_demographics
order by first_name desc;

select * from employee_demographics
order by gender,age desc;

select * from employee_demographics
order by 5,4;  -- positions of the columns

select gender, avg(age) from employee_demographics
group by gender
having avg(age) > 40;

select occupation, avg(salary) from employee_salary
group by occupation
having avg(salary) >= 50000;

select occupation, avg(salary) from employee_salary
where occupation like '%manager%'
group by occupation;

-- limit
select * from parks_departments
order by department_name asc
limit 4, 1 ;

-- aliasing
select gender , avg(age) as average_age
from employee_demographics
group by gender
having avg(age) > 40;


-- joins 
select * from employee_salary;

select * from employee_demographics
inner join employee_salary
on employee_demographics.employee_id = employee_salary.employee_id;

select dem.employee_id, age, occupation from employee_demographics dem
inner join employee_salary sal
on dem.employee_id = sal.employee_id;

-- unions 
select first_name,last_name from employee_demographics 
UNION ALL
select first_name,last_name from employee_salary;

select first_name , last_name, 'Old'  as label from employee_demographics 
where age > 40 and gender = 'Male'
union
select first_name , last_name , 'Ols' as label  from employee_demographics
where age > 40
union
select first_name , last_name, 'Highly Paid Employee' as label from employee_salary
where salary > 70000;

-- string functions
select length('thanmaisree') as my_name;

 
select first_name, length(first_name) as lenof1 from employee_demographics
order by 2;

select lower('THANNUU') as low;
select upper('thanmai') as up;

select trim('              sky                    ') as tim;

select first_name , right(first_name, 4) as r8,left(first_name , 4) as lf from employee_demographics;

select first_name, substring(first_name , 3,2) as sub , birth_date , substring(birth_date , 6,2) as birth_month from employee_demographics;


-- replace 
select first_name , replace(first_name , 'A','z') from employee_demographics;


-- locate
select locate( 'S','Thanmai_Sree') as place;

select first_name, LOCATE( 'an', first_name) AS UJN from employee_demographics;

select first_name,last_name,
concat(first_name , ' ' , last_name) as concated from employee_demographics;

select first_name,last_name,AGE,
case
when age <= 30 then 'Young'
WHEN age between 31 and 49 then 'older'
when age >= 50 then "grand"
END  AS age_bracket
 from employee_demographics;
 
 
 select salary,
 CASE 
 when salary <= 50000 then 'middle'
 when salary between 50000 and 90000 then 'Rich'
 end as class
 from employee_salary;
 
 -- BONUS
 -- < 50000 = 5%
 -- > 50000 = 7%
 -- finance = 10% bonus 
 select first_name,last_name,salary,
 CASE
 when salary < 50000 THEN salary + (salary * 0.05)
 when salary >= 50000 then salary + (salary * 0.07)
end as new_salary,
 case 
 when dept_id = 6 then salary * .10
 end as bonus
 from employee_salary;
 
 
 select * from employee_demographics
 where employee_id in 
				    (select employee_id 
                    from employee_salary
                    where dept_id = 1);
                    
                    
select * from parks_departments;

select department_name from parks_departments
where department_name like 'P%';


select first_name,salary , 
(select avg(salary) from employee_salary)
from employee_salary;


select gender,avg(age),max(age),min(age),count(age) 
from employee_demographics
group by gender;

select gender,avg(salary) as avrg from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id
group by gender ;

select dem.first_name,dem.last_name, gender,avg(salary) OVER(partition by gender) as avrg from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

select dem.first_name,dem.last_name, gender,sum(salary) OVER(partition by gender) as sum from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

select dem.first_name,dem.last_name, gender,salary ,sum(salary) OVER(partition by gender ORDER BY dem.employee_id) as rolling_total
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

-- row number
select dem.first_name,dem.last_name, gender,salary ,
row_number() over(partition by gender order by salary desc) as rand,
rank() over(partition by gender order by salary desc) as rank_num,
dense_rank() over(partition by gender order by salary desc) as dense_num
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

-- CTEs (common table expressions)
select * from employee_salary;

select gender,max(age) as maxi
from employee_demographics
group by gender;


-- Temporary tables
create temporary table temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);


insert into temp_table
values ('thanmai','sree','hi_nanna');

select * from temp_table;

create temporary table salary_over_50k1
select salary from employee_salary 
where salary >= 50000;

select * from salary_over_50k1;     #only for temporary use


-- Stored procedures
DELIMITER $$
create procedure large_salaries()
begin 
select * from employee_salary
where salary >= 50000 ;     
select * from employee_salary
where salary >= 10000 ;     
END $$
DELIMITER ;
