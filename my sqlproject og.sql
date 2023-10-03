create database project;

use project;

create table emp(
emp_no int primary key,
ename varchar(20),
job varchar(20),
mgr numeric,
hiredate date,
salary int ,
comission int,
dept_no int
);

create table dept(
dept_no int primary key,
dname varchar(15),
location varchar(20)
);



insert into emp(emp_no,ename,job,mgr,salary,dept_no) values(7369,'smith','clerk',7902,800,20);

insert into emp(emp_no,ename,job,mgr,salary,comission,dept_no) values(7499,'allen','salesman',7698,1600,300,30);
insert into emp(emp_no,ename,job,mgr,salary,comission,dept_no) values(7521,'ward','salesman',7698,1250,500,30);
insert into emp(emp_no,ename,job,mgr,salary,dept_no) values(7566,'jones','manager',7839,2975,20);
insert into emp(emp_no,ename,job,mgr,salary,comission,dept_no) values(7654,'martin','salesman',7698,1250,1400,30);
insert into emp(emp_no,ename,job,mgr,salary,dept_no) values(7698,'blake','manager',7839,2850,30);
insert into emp(emp_no,ename,job,mgr,salary,dept_no) values(7782,'clark','manager',7839,2450,10);
insert into emp(emp_no,ename,job,mgr,salary,dept_no) values(7788,'scott','analyst',7566,3000,20);
insert into emp(emp_no,ename,job,salary,dept_no) values(7839,'king','president',5000,10);
insert into emp(emp_no,ename,job,mgr,salary,comission,dept_no) values(7844,'turner','salesman',7698,1500,0,30);
insert into emp(emp_no,ename,job,mgr,salary,dept_no) values(7876,'adams','clerk',7788,1100,20),(7900,'james','clerk',7698,950,30);
insert into emp(emp_no,ename,job,mgr,salary,dept_no) values(7902,'ford','analyst',7566,3000,20),(7934,'miller','clerk',7782,1300,10);



select * from emp ;

insert into dept values(10,'accouting','new york'),(20,'research','dallas'),(30,'sales','chicago');
insert into dept values(40,'ops','boston');

select * from emp ;

select * from dept;

-- Display all the employees who are getting 2500 and excess salaries in department 20.
select ename ,salary from emp where salary >= 2500 and dept_no = 20;

-- Display all the managers working in 20 & 30 department.
select * from emp where job = 'clerk' and dept_no = 20 and 30 ;

-- Display all the managers who don’t have a manager
select ename,job from emp where job <> 'manager';


select ename,job from emp 
where comission >= 0;

-- Display all the ANALYSTs whose name doesn’t ends with ‘S’
select * from emp
where ename  not like '%s' and job = 'analyst';

-- Display all the employees who total salary is more than 2000.(Total Salary = Sal + Comm)
select ename,salary + comission as total_salary,job from emp;


select * from emp
where  comission >= 0 and dept_no <> 10 and 40;

-- Display all the employees who earning salary not in the range of 2500 and 5000 in department 10 & 20
select * from emp
where salary not  between 2500 and 5000 and dept_no = 10 and 20;

-- grouping

-- Display job-wise maximum salary.
select distinct max(salary) high_salary,job from emp
group by job;

select * from  emp;
select * from dept;

-- Display the departments that are having more than 3 employees under it.
select job,count(e.dept_no) count_of_emp from emp e
group by job
having count(e.dept_no) >2;

-- Display job-wise average salaries for the employees whose employee number is not from 7788 to 7790
select job,avg(salary) avg_salary from emp
where emp_no not in(7788 and 1190)
group by job;

create table skills(
id int,sname varchar(10));


insert into skills values(101,'asp');

select* from skills;

-- Select only the non-duplicate records.
select distinct * from skills;

-- Select only the duplicate records along-with their count
select count(id) count_of_id,sname from skills
group by sname
having count(sname) >1;

-- Select only the duplicate records that are duplicated only once.
select count(id) count_of_id,sname from skills
where id <> 101
group by sname
having count(sname);

select * from skills;
-- sub queries

-- Display all the employees who earn more than all the managers(job).
select * from emp where salary> all (select salary from emp where job='MANAGER');

-- Display all the employees who earn more than any the managers(job).
select * from emp where salary> any (select salary from emp where job='MANAGER');

-- Display empno,job and salary of all the analyst who are earning more than any of the manager
 select emp_no,job,salary from emp where job='ANALYST' and salary>any(select salary from emp where job='MANAGER');

-- select the department name and location of all employees working for clark
select dname,location from dept where dept_no in(select dept_no from emp where mgr in(select emp_no from emp where ename='CLARK'));

-- select all the employees working in dallas.
 select * from emp where dept_no in(select dept_no from dept where location='DALLAS')

-- Select 2nd maximum salary.
 select max(salary) from emp where salary <(select max(salary) from emp);

-- Display all the employees who earn more than all the managers(job).
select * from emp where salary> all (select salary from emp where job='MANAGER');

-- Display empno,job and salary of all the analyst who are earning more than any of the manager
 select emp_no,job,salary from emp where job='ANALYST' and salary>any(select salary from emp where job='MANAGER');

-- list the daprtment names which are having analysts.
 select dname from dept where dept_no in(select dept_no from emp where job ='ANALYST')

-- List the department names which have salesman in it.
select dname from dept where dept_no in(select dept_no from emp where job ='salesman');

-- second maximum salary
select distinct(salary) from emp
order by salary desc
limit 1 offset 1;

-- Display all the employees whose salary is greater than average salary of deartment 20.
select * from emp salary > (select avg(salary)  from emp
where dept_no = 20);

-- 3rd maximum salary
select max(salary) from emp where salary <(select max(salary) from emp);

-- joins

-- DISPLAY EMPLOYEE NAME AND DEPARTMENT NAME FOR EACH EMPLOYEE
Select e.ename,d.dname from emp e,dept d where e.dept_no=d.dept_no;

-- LIST EMPLOYEES WHO ARE WORKING IN RESEARCH DEPT AND THEY ARE MANAGER.
SELECT ENAME FROM EMP,DEPT WHERE DEPT.DEPT_NO=EMP.DEPT_NO AND DNAME = 'RESEARCH' AND JOB = 'MANAGER';

 
-- DISPLAY ALL THE SALESMEN WHO ARE NOT LOCATED AT DALLAS.
SELECT e.ENAME FROM EMP e,DEPT d WHERE e.DEPT_NO=d.DEPT_NO AND e.JOB='SALESMAN' AND d.DNAME<>'DALLAS';

-- SELECT DEPARTMENT NAME & LOCATION OF ALL THE EMPLOYEES WORKING FOR CLARK.
select d.dname,d.location from emp e , dept d where e.dept_no = d.dept_no and e.ename = 'clark';

-- SELECT ALL THE DEPARTMENTAL INFORMATION FOR ALL THE MANAGERS.
select d.* from dept d, emp e where d.dept_no = e.dept_no and e.job = 'manager' ;

-- Select all the employees who work in DALLAS
select e.ename, d.location from emp e inner join dept d on e.dept_no = d.dept_no 
where d.location = 'dallas';

-- GET ALL THE EMPLOYEES WHO WORK IN THE SAME DEPARTMENTS AS OF SCOTT.
SELECT DISTINCT A.ENAME FROM EMP A WHERE A.DEPT_NO=(SELECT DEPT_NO FROM EMP WHERE ENAME='SCOTT') AND A.ENAME<>'SCOTT';

-- LIST ALL THE EMPLOYEES WHO ARE EARNING MORE THAN THEIR MANAGERS.
SELECT A.ENAME ,A.SALary EMP_SAL, B.ENAME MANAGER,B.SALary MGR_SAL FROM EMP A,EMP B WHERE A.MGR=B.emp_NO AND A.SALary>B.SALary;

-- FETCH ALL THE EMPLOYEES WHO ARE EARNING SAME SALARIES.
Select a.ename,a.salary from emp a,emp b where a.salary = b.salary and a.emp_no <> b.emp_no;


--   -------------  the end ---------- --