-- Creating Database
CREATE DATABASE HR_DATABASE

SELECT * FROM HR_DATABASE.hrdata

-- Employee Count
SELECT SUM(employee_count) AS employee_count FROM HR_DATABASE.hrdata

-- Attrition Count
SELECT COUNT(attrition) AS attrition_count FROM HR_DATABASE.hrdata
WHERE attrition = "Yes"


-- Attrition Rate
SELECT ROUND(((SELECT COUNT(attrition) FROM HR_DATABASE.hrdata
WHERE attrition = "Yes")/SUM(employee_count))*100,2) AS attribution_rate FROM HR_DATABASE.hrdata


-- No. of Active Employee
SELECT SUM(employee_count) - (SELECT COUNT(attrition) FROM HR_DATABASE.hrdata WHERE attrition = "Yes") AS active_employee
FROM HR_DATABASE.hrdata


-- Average Age
SELECT ROUND(AVG(age),0) AS avg_age FROM HR_DATABASE.hrdata


-- Attrition by Gender
SELECT gender,COUNT(attrition) as attrition_count FROM HR_DATABASE.hrdata
WHERE attrition = "Yes"
GROUP BY gender
ORDER BY attrition_count desc


-- Department wise Attrition
SELECT department, attrition_count, ROUND(attrition_count/(SELECT COUNT(attrition) FROM HR_DATABASE.hrdata WHERE attrition = "Yes")*100,2) AS pct
FROM
(SELECT department, COUNT(attrition) AS attrition_count FROM HR_DATABASE.hrdata
WHERE attrition = "Yes"
GROUP BY department
ORDER BY attrition_count DESC) AS final


-- No of Employee by Age Group
SELECT age,SUM(employee_count) AS employee_count FROM HR_DATABASE.hrdata
GROUP BY age
ORDER BY age 


-- Education Field wise Attrition
SELECT education_field, COUNT(attrition) AS attrition_count FROM HR_DATABASE.hrdata
WHERE attrition = "Yes"
GROUP BY education_field
ORDER BY attrition_count DESC


-- Attrition Rate by Gender for different Age Group
SELECT age_band,gender,attrition_count,
ROUND(attrition_count/(SELECT COUNT(attrition) FROM HR_DATABASE.hrdata WHERE attrition = "Yes")*100,2) AS pct
FROM
(SELECT age_band, gender, COUNT(attrition) AS attrition_count
FROM HR_DATABASE.hrdata
WHERE attrition = "Yes"
GROUP BY age_band,gender
ORDER BY age_band,gender) AS final 


-- Job Satisfaction Rating
SELECT
  job_role,
  SUM(CASE WHEN job_satisfaction = 1 THEN employee_count END) AS one,
  SUM(CASE WHEN job_satisfaction = 2 THEN employee_count END) AS two,
  SUM(CASE WHEN job_satisfaction = 3 THEN employee_count END) AS three,
  SUM(CASE WHEN job_satisfaction = 4 THEN employee_count END) AS four
FROM HR_DATABASE.hrdata
GROUP BY job_role
ORDER BY job_role


-- Employee Count by Gender for Different Age Group
SELECT age_band, gender, SUM(employee_count) as employee_count FROM HR_DATABASE.hrdata
GROUP BY age_band,gender
ORDER BY age_band, gender DESC