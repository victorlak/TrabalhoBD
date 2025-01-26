/* UTILIZANDO VARRAY */
CREATE or replace NONEDITIONABLE type pessoa_t as object (
    p_ID numeric,
    nome varchar (40),
    sobrenome varchar(40),
    dataDeNascimento date 
) not final

CREATE or replace NONEDITIONABLE type aluno_t under pessoa_t (
    status varchar (40)
) not final

CREATE or replace NONEDITIONABLE type professor_t under pessoa_t (
    rank varchar (40)
) not final

CREATE or replace NONEDITIONABLE type endereco_t as object (
    id_end numeric ,
    rua varchar (50),
    bairro varchar (35),
    uf char (2),
    cep varchar(9)
)

CREATE or replace NONEDITIONABLE type arrayProfessor_t as varray(50) of ref professor_t
CREATE or replace NONEDITIONABLE type arrayAluno_t as varray(50) of ref aluno_t

CREATE or replace NONEDITIONABLE type departamento_t as object (
    id_dpto numeric,
    nome varchar (40),
    coordenador ref professor_t,
    professores arrayProfessor_t,
    discentes arrayAluno_t
) not final 

CREATE or replace NONEDITIONABLE type campusClub_t object (
    id_campusC numeric,
    nome varchar(40),
    endereco ref endereco_t,
    orientador ref professor_t
    membros arrayAluno_t

) not final

CREATE table pessoa of pessoa_t
CREATE table aluno of aluno_t
CREATE table professor of professor_t
CREATE table departamento of departamento_t
CREATE table endereco of endereco_t
CREATE table campusClub of campusClub_t

alter table pessoa add primary key(p_ID)
alter table aluno add primary key(p_ID)
alter table professor add primary key(p_ID)
alter table departamento add primary key(id_dpto)
alter table endereco add primary key(id_end)
alter table campusClub add primary key(id_campusC)

/* UTILIZANDO NESTED TABLE*/

CREATE OR REPLACE NONEDITIONABLE TYPE pessoa_t AS OBJECT (
    p_ID NUMERIC,
    nome VARCHAR(40),
    sobrenome VARCHAR(40),
    dataDeNascimento DATE
) NOT FINAL;

CREATE OR REPLACE NONEDITIONABLE TYPE aluno_t UNDER pessoa_t (
    status VARCHAR(40)
) NOT FINAL;

CREATE OR REPLACE NONEDITIONABLE TYPE professor_t UNDER pessoa_t (
    rank VARCHAR(40)
) NOT FINAL;

CREATE OR REPLACE NONEDITIONABLE TYPE endereco_t AS OBJECT (
    id_end NUMERIC,
    rua VARCHAR(50),
    bairro VARCHAR(35),
    uf CHAR(2),
    cep VARCHAR(9)
);

CREATE OR REPLACE NONEDITIONABLE TYPE nestedProfessor_t AS TABLE OF REF professor_t;


CREATE OR REPLACE NONEDITIONABLE TYPE nestedAluno_t AS TABLE OF REF aluno_t;

CREATE OR REPLACE NONEDITIONABLE TYPE departamento_t AS OBJECT (
    id_dpto NUMERIC,
    nome VARCHAR(40),
    coordenador REF professor_t,
    professores nestedProfessor_t, 
    discentes nestedAluno_t       
) NOT FINAL;

CREATE OR REPLACE NONEDITIONABLE TYPE campusClub_t AS OBJECT (
    id_campusC NUMERIC,
    nome VARCHAR(40),
    endereco REF endereco_t,
    orientador REF professor_t,
    membros nestedAluno_t         
) NOT FINAL;


CREATE TABLE pessoa OF pessoa_t;
CREATE TABLE aluno OF aluno_t;
CREATE TABLE professor OF professor_t;
CREATE TABLE endereco OF endereco_t;


CREATE TABLE departamento OF departamento_t
    NESTED TABLE professores STORE AS professores_ntab
    NESTED TABLE discentes STORE AS discentes_ntab;


CREATE TABLE campusClub OF campusClub_t
    NESTED TABLE membros STORE AS membros_ntab;


ALTER TABLE pessoa ADD PRIMARY KEY (p_ID);
ALTER TABLE aluno ADD PRIMARY KEY (p_ID);
ALTER TABLE professor ADD PRIMARY KEY (p_ID);
ALTER TABLE endereco ADD PRIMARY KEY (id_end);
ALTER TABLE departamento ADD PRIMARY KEY (id_dpto);
ALTER TABLE campusClub ADD PRIMARY KEY (id_campusC);
