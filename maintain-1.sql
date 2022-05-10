
--table spaces info and free space
SELECT TABLESPACE_NAME, STATUS, CONTENTS FROM USER_TABLESPACES;
Select tablespace_name,(Sum(bytes)/1024/1024) Free_space_MB,(max(bytes)/1024/1024) Largest_Free_chunck_MB from dba_free_space GROUP BY tablespace_name;
select tablespace_name, sum(bytes)/(1024*1024) size_in_mb from dba_data_files group by tablespace_name;
select tablespace_name, sum(bytes)/(1024*1024) size_in_mb from dba_temp_files group by tablespace_name;
--data files info
select tablespace_name, file_name from dba_data_files union select tablespace_name, file_name from dba_temp_files;
--log files info
select GROUP#,TYPE,MEMBER from v$logfile;
--shows objects created in the last 24 hrs
select CREATED, OBJECT_NAME from USER_OBJECTS WHERE CREATED > sysdate - 1;
--shows the largest segments in the DB
select * from (select owner, segment_type, segment_name, bytes/1024/1024/1024 "SIZE (GB)" 
from dba_segments where segment_name not like 'BIN%' order by 4 desc) where rownum <= 10;

--show db processes
select spid, addr, username from V$PROCESS;

--show sessions
select saddr, sid, username, command from V$SESSION;

--show owners and extent counts
select distinct owner, count(*) from DBA_EXTENTS GROUP BY OWNER;
select * from (select distinct tablespace_name, count(*) from DBA_EXTENTS GROUP BY tablespace_name) where rownum <= 10;

--other areas of interest
show sga;
show parameter memory_target;

