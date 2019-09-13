Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D92C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 20:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B40CC206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 20:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40CC206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8s7a-0007bk-5E
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 16:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8rxE-00068i-Tb
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 16:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8rx8-0000dR-F8
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 16:14:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8rx7-0000c9-Tt
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 16:13:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 235EDC057867;
 Fri, 13 Sep 2019 20:13:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4ADC7600C6;
 Fri, 13 Sep 2019 20:13:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A5335113306C; Fri, 13 Sep 2019 22:13:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 22:13:48 +0200
Message-Id: <20190913201349.24332-16-armbru@redhat.com>
In-Reply-To: <20190913201349.24332-1-armbru@redhat.com>
References: <20190913201349.24332-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 13 Sep 2019 20:13:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 15/16] docs/devel/qapi-code-gen: Improve
 QAPI schema language doc
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We document the language by giving patterns of valid JSON objects.
The patterns contain placeholders we don't define anywhere; their
names have to speak for themselves.  I guess they do, but I'd prefer a
bit more rigor.  Provide a grammar instead, and rework the text
accordingly.

Documentation for QAPI schema conditionals (commit 967c885108,
6cc32b0e14, 87adbbffd4..3e270dcacc) and feature flags (commit
6a8c0b5102) was bolted on.  The sections documenting types, commands
and events don't mention them.  Section "Features" and "Configuring
the schema" then provide additional syntax for types, commands and
events.  I hate that.  Fix the sections documenting types, commands
and events to provide accurate syntax, and point to "Features" and
"Configuring the schema" for details.

We talk about "(top-level) expressions other than include and pragma".
Adopt more convenient terminology: a (top-level) expression is either
a directive (include or pragma) or a definition (anything else).

Avoid the terms "dictionary" and "key".  Stick to JSON terminology
"object" and "member name" instead.

While there, make spacing more consistent.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 596 ++++++++++++++++++++++-------------
 1 file changed, 372 insertions(+), 224 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index e75d680f6e..94f3054898 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -4,12 +4,12 @@ Copyright IBM Corp. 2011
 Copyright (C) 2012-2016 Red Hat, Inc.
=20
 This work is licensed under the terms of the GNU GPL, version 2 or
-later. See the COPYING file in the top-level directory.
+later.  See the COPYING file in the top-level directory.
=20
 =3D=3D Introduction =3D=3D
=20
 QAPI is a native C API within QEMU which provides management-level
-functionality to internal and external users. For external
+functionality to internal and external users.  For external
 users/processes, this interface is made available by a JSON-based wire
 format for the QEMU Monitor Protocol (QMP) for controlling qemu, as
 well as the QEMU Guest Agent (QGA) for communicating with the guest.
@@ -54,24 +54,49 @@ Differences:
=20
 * Numbers are not supported.
=20
-A QAPI schema consists of a series of top-level expressions (JSON
-objects).  Code and documentation is generated in schema definition
-order.  Code order should not matter.
+A second layer of syntax defines the sequences of JSON texts that are
+a correctly structured QAPI schema.  We provide a grammar for this
+syntax in an EBNF-like notation:
=20
-The order of keys within JSON objects does not matter unless
+* Production rules look like non-terminal =3D expression
+* Concatenation: expression A B matches expression A, then B
+* Alternation: expression A | B matches expression A or B
+* Repetition: expression A... matches zero or more occurrences of
+  expression A
+* Repetition: expression A, ... matches zero or more occurrences of
+  expression A separated by ,
+* Grouping: expression ( A ) matches expression A
+* JSON's structural characters are terminals: { } [ ] : ,
+* JSON's literal names are terminals: false true null
+* String literals enclosed in 'single quotes' are terminal, and match
+  this JSON string, with a leading '*' stripped off
+* When JSON object member's name starts with '*', the member is
+  optional.
+* The symbol STRING is a terminal, and matches any JSON string
+* The symbol BOOL is a terminal, and matches JSON false or true
+* ALL-CAPS words other than STRING are non-terminals
+
+The order of members within JSON objects does not matter unless
 explicitly noted.
=20
-There are eight kinds of top-level expressions: 'include', 'pragma',
-'command', 'struct', 'enum', 'union', 'alternate', and 'event'.  These
-are discussed in detail below.
-
-In the rest of this document, usage lines are given for each
-expression type, with literal strings written in lower case and
-placeholders written in capitals.  If a literal string includes a
-prefix of '*', that key/value pair can be omitted from the expression.
-For example, a usage statement that includes '*base':STRUCT-NAME
-means that an expression has an optional key 'base', which if present
-must have a value that forms a struct name.
+A QAPI schema consists of a series of top-level expressions:
+
+    SCHEMA =3D TOP-LEVEL-EXPR...
+
+The top-level expressions are all JSON objects.  Code and
+documentation is generated in schema definition order.  Code order
+should not matter.
+
+A top-level expressions is either a directive or a definition:
+
+    TOP-LEVEL-EXPR =3D DIRECTIVE | DEFINITION
+
+There are two kinds of directives and six kinds of definitions:
+
+    DIRECTIVE =3D INCLUDE | PRAGMA
+    DEFINITION =3D ENUM | STRUCT | UNION | ALTERNATE | COMMAND | EVENT
+
+These are discussed in detail below.
=20
=20
 =3D=3D=3D Built-in Types =3D=3D=3D
@@ -101,16 +126,16 @@ The following types are predefined, and map to C as=
 follows:
=20
 =3D=3D=3D Include directives =3D=3D=3D
=20
-Usage: { 'include': STRING }
+Syntax:
+    INCLUDE =3D { 'include': STRING }
=20
 The QAPI schema definitions can be modularized using the 'include' direc=
tive:
=20
  { 'include': 'path/to/file.json' }
=20
-The directive is evaluated recursively, and include paths are relative t=
o the
-file using the directive. Multiple includes of the same file are
-idempotent.  No other keys should appear in the expression, and the incl=
ude
-value should be a string.
+The directive is evaluated recursively, and include paths are relative
+to the file using the directive.  Multiple includes of the same file
+are idempotent.
=20
 As a matter of style, it is a good idea to have all files be
 self-contained, but at the moment, nothing prevents an included file
@@ -121,10 +146,12 @@ prevent incomplete include files.
=20
 =3D=3D=3D Pragma directives =3D=3D=3D
=20
-Usage: { 'pragma': DICT }
+Syntax:
+    PRAGMA =3D { 'pragma': { '*doc-required': BOOL,
+                           '*returns-whitelist': [ STRING, ... ],
+                           '*name-case-whitelist': [ STRING, ... ] } }
=20
 The pragma directive lets you control optional generator behavior.
-The dictionary's entries are pragma names and values.
=20
 Pragma's scope is currently the complete schema.  Setting the same
 pragma to different values in parts of the schema doesn't work.
@@ -141,60 +168,95 @@ rules on use of upper- vs. lower-case letters.  Def=
ault is none.
=20
 =3D=3D=3D Enumeration types =3D=3D=3D
=20
-Usage: { 'enum': STRING, 'data': ARRAY-OF-STRING }
-       { 'enum': STRING, '*prefix': STRING, 'data': ARRAY-OF-STRING }
+Syntax:
+    ENUM =3D { 'enum': STRING,
+             'data': [ ENUM-VALUE, ... ],
+             '*prefix': STRING,
+             '*if': COND }
+    ENUM-VALUE =3D STRING
+               | { 'name': STRING, '*if': COND }
=20
-An enumeration type is a dictionary containing a single 'data' key
-whose value is a list of strings.  An example enumeration is:
+Member 'enum' names the enum type.
+
+Each member of the 'data' array defines a value of the enumeration
+type.  The form STRING is shorthand for { 'name': STRING }.  The
+'name' values must be be distinct.
+
+Example:
=20
  { 'enum': 'MyEnum', 'data': [ 'value1', 'value2', 'value3' ] }
=20
 Nothing prevents an empty enumeration, although it is probably not
-useful.  The list of strings should be lower case; if an enum name
-represents multiple words, use '-' between words.  The string 'max' is
-not allowed as an enum value, and values should not be repeated.
-
-The enum constants will be named by using a heuristic to turn the
-type name into a set of underscore separated words. For the example
-above, 'MyEnum' will turn into 'MY_ENUM' giving a constant name
-of 'MY_ENUM_VALUE1' for the first value. If the default heuristic
-does not result in a desirable name, the optional 'prefix' member
-can be used when defining the enum.
-
-The enumeration values are passed as strings over the Client JSON
-Protocol, but are encoded as C enum integral values in generated code.
-While the C code starts numbering at 0, it is better to use explicit
-comparisons to enum values than implicit comparisons to 0; the C code
-will also include a generated enum member ending in _MAX for tracking
-the size of the enum, useful when using common functions for
-converting between strings and enum values.
-
-For any struct that has a member that will only contain a finite set
-of string values, using an enum type for that member is better than
-open-coding the member to be type 'str'.
+useful.
+
+On the wire, an enumeration type's value is represented by its
+(string) name.  In C, it's represented by an enumeration constant.
+These are of the form PREFIX_NAME, where PREFIX is derived from the
+enumeration type's name, and NAME from the value's name.  For the
+example above, the generator maps 'MyEnum' to MY_ENUM and 'value1' to
+VALUE1, resulting in the enumeration constant MY_ENUM_VALUE1.  The
+optional 'prefix' member overrides PREFIX.
+
+The generated C enumeration constants have values 0, 1, ..., N-1 (in
+QAPI schema order), where N is the number of values.  There is an
+additional enumeration constant PREFIX__MAX with value N.
+
+Do not use string or an integer type when an enumeration type can do
+the job satisfactorily.
+
+The optional 'if' member specifies a conditional.  See "Configuring
+the schema" below for more on this.
+
+
+=3D=3D=3D Type references and array types =3D=3D=3D
+
+Syntax:
+    TYPE-REF =3D STRING | ARRAY-TYPE
+    ARRAY-TYPE =3D [ STRING ]
+
+A string denotes the type named by the string.
+
+A one-element array containing a string denotes an array of the type
+named by the string.  Example: ['int'] denotes an array of 'int'.
+
=20
 =3D=3D=3D Struct types =3D=3D=3D
=20
-Usage: { 'struct': STRING, 'data': DICT, '*base': STRUCT-NAME }
+Syntax:
+    STRUCT =3D { 'struct': STRING,
+               'data': MEMBERS,
+               '*base': STRING,
+               '*if': COND,
+               '*features': FEATURES }
+    MEMBERS =3D { MEMBER, ... }
+    MEMBER =3D STRING : TYPE-REF
+           | STRING : { 'type': TYPE-REF, '*if': COND }
=20
-A struct is a dictionary containing a single 'data' key whose value is
-a dictionary; the dictionary may be empty.  This corresponds to a
-struct in C or an Object in JSON. Each value of the 'data' dictionary
-must be the name of a type, or a one-element array containing a type
-name.  An example of a struct is:
+Member 'struct' names the struct type.
+
+Each MEMBER of the 'data' object defines a member of the struct type.
+
+The MEMBER's STRING name consists of an optional '*' prefix and the
+struct member name.  If '*' is present, the member is optional.
+
+The MEMBER's value defines its properties, in particular its type.
+The form TYPE-REF is shorthand for { 'type': TYPE-REF }.
+
+Example:
=20
  { 'struct': 'MyType',
-   'data': { 'member1': 'str', 'member2': 'int', '*member3': 'str' } }
+   'data': { 'member1': 'str', 'member2': ['int'], '*member3': 'str' } }
=20
-The use of '*' as a prefix to the name means the member is optional in
-the corresponding JSON protocol usage.
+A struct type corresponds to a struct in C, and an object in JSON.
+The C struct's members are generated in QAPI schema order.
=20
-A struct definition can specify another struct as its base.
-In this case, the members of the base type are included as top-level mem=
bers
-of the new struct's dictionary in the Client JSON Protocol wire
-format. An example definition is:
+The optional 'base' member names a struct type whose members are to be
+included in this type.  They go first in the C struct.
=20
- { 'struct': 'BlockdevOptionsGenericFormat', 'data': { 'file': 'str' } }
+Example:
+
+ { 'struct': 'BlockdevOptionsGenericFormat',
+   'data': { 'file': 'str' } }
  { 'struct': 'BlockdevOptionsGenericCOWFormat',
    'base': 'BlockdevOptionsGenericFormat',
    'data': { '*backing': 'str' } }
@@ -205,18 +267,40 @@ both members like this:
  { "file": "/some/place/my-image",
    "backing": "/some/place/my-backing-file" }
=20
+The optional 'if' member specifies a conditional.  See "Configuring
+the schema" below for more on this.
+
+The optional 'features' member specifies features.  See "Features"
+below for more on this.
+
=20
 =3D=3D=3D Union types =3D=3D=3D
=20
-Usage: { 'union': STRING, 'data': DICT }
-or:    { 'union': STRING, 'data': DICT, 'base': STRUCT-NAME-OR-DICT,
-         'discriminator': ENUM-MEMBER-OF-BASE }
-
-Union types are used to let the user choose between several different
-variants for an object.  There are two flavors: simple (no
-discriminator or base), and flat (both discriminator and base).  A union
-type is defined using a data dictionary as explained in the following
-paragraphs.  Unions must have at least one branch.
+Syntax:
+    UNION =3D { 'union': STRING,
+              'data': BRANCHES,
+              '*if': COND }
+          | { 'union': STRING,
+              'data': BRANCHES,
+              'base': ( MEMBERS | STRING ),
+              'discriminator': STRING,
+              '*if': COND }
+    BRANCHES =3D { BRANCH, ... }
+    BRANCH =3D STRING : TYPE-REF
+           | STRING : { 'type': TYPE-REF, '*if': COND }
+
+Member 'union' names the union type.
+
+There are two flavors of union types: simple (no discriminator or
+base), and flat (both discriminator and base).
+
+Each BRANCH of the 'data' object defines a branch of the union.  A
+union must have at least one branch.
+
+The BRANCH's STRING name is the branch name.
+
+The BRANCH's value defines the branch's properties, in particular its
+type.  The form TYPE-REF is shorthand for { 'type': TYPE-REF }.
=20
 A simple union type defines a mapping from automatic discriminator
 values to data types like in this example:
@@ -229,8 +313,8 @@ values to data types like in this example:
    'data': { 'file': 'BlockdevOptionsFile',
              'qcow2': 'BlockdevOptionsQcow2' } }
=20
-In the Client JSON Protocol, a simple union is represented by a
-dictionary that contains the 'type' member as a discriminator, and a
+In the Client JSON Protocol, a simple union is represented by an
+object that contains the 'type' member as a discriminator, and a
 'data' member that is of the specified data type corresponding to the
 discriminator value, as in these examples:
=20
@@ -238,21 +322,27 @@ discriminator value, as in these examples:
  { "type": "qcow2", "data": { "backing": "/some/place/my-image",
                               "lazy-refcounts": true } }
=20
-The generated C code uses a struct containing a union. Additionally,
+The generated C code uses a struct containing a union.  Additionally,
 an implicit C enum 'NameKind' is created, corresponding to the union
 'Name', for accessing the various branches of the union.  The value
 for each branch can be of any type.
=20
-A flat union definition avoids nesting on the wire, and specifies a
-set of common members that occur in all variants of the union.  The
-'base' key must specify either a type name (the type must be a
-struct, not a union), or a dictionary representing an anonymous type.
-All branches of the union must be struct types, and the top-level
-members of the union dictionary on the wire will be combination of
-members from both the base type and the appropriate branch type (when
-merging two dictionaries, there must be no keys in common).  The
-'discriminator' member must be the name of a non-optional enum-typed
-member of the base struct.
+Flat unions permit arbitrary common members that occur in all variants
+of the union, not just a discriminator.  Their discriminators need not
+be named 'type'.  They also avoid nesting on the wire.
+
+The 'base' member defines the common members.  If it is a MEMBERS
+object, it defines common members just like a struct type's 'data'
+member defines struct type members.  If it is a STRING, it names a
+struct type whose members are the common members.
+
+All flat union branches must be of struct type.
+
+In the Client JSON Protocol, a flat union is represented by an object
+with the common members (from the base type) and the selected branch's
+members.  The two sets of member names must be disjoint.  Member
+'discriminator' must name a non-optional enum-typed member of the base
+struct.
=20
 The following example enhances the above simple union example by
 adding an optional common member 'read-only', renaming the
@@ -276,12 +366,13 @@ Resulting in these JSON objects:
 Notice that in a flat union, the discriminator name is controlled by
 the user, but because it must map to a base member with enum type, the
 code generator ensures that branches match the existing values of the
-enum. The order of the keys need not match the declaration of the enum.
-The keys need not cover all possible enum values. Omitted enum values
-are still valid branches that add no additional members to the data type=
.
-In the resulting generated C data types, a flat union is
-represented as a struct with the base members included directly, and
-then a union of structures for each branch of the struct.
+enum.  The order of branches need not match the order of the enum
+values.  The branches need not cover all possible enum values.
+Omitted enum values are still valid branches that add no additional
+members to the data type.  In the resulting generated C data types, a
+flat union is represented as a struct with the base members in QAPI
+schema order, and then a union of structures for each branch of the
+struct.
=20
 A simple union can always be re-written as a flat union where the base
 class has a single member named 'type', and where each branch of the
@@ -297,32 +388,47 @@ is identical on the wire to:
  { 'union': 'Flat': 'base': { 'type': 'Enum' }, 'discriminator': 'type',
    'data': { 'one': 'Branch1', 'two': 'Branch2' } }
=20
+The optional 'if' member specifies a conditional.  See "Configuring
+the schema" below for more on this.
+
=20
 =3D=3D=3D Alternate types =3D=3D=3D
=20
-Usage: { 'alternate': STRING, 'data': DICT }
+Syntax:
+    ALTERNATE =3D { 'alternate': STRING,
+                  'data': ALTERNATIVES,
+                  '*if': COND }
+    ALTERNATIVES =3D { ALTERNATIVE, ... }
+    ALTERNATIVE =3D STRING : TYPE-REF
+                | STRING : { 'type': STRING, '*if': COND }
=20
-An alternate type is one that allows a choice between two or more JSON
-data types (string, integer, number, or object, but currently not
-array) on the wire.  The definition is similar to a simple union type,
-where each branch of the union names a QAPI type.  For example:
+Member 'alternate' names the alternate type.
+
+Each ALTERNATIVE of the 'data' object defines a branch of the
+alternate.  An alternate must have at least one branch.
+
+The ALTERNATIVE's STRING name is the branch name.
+
+The ALTERNATIVE's value defines the branch's properties, in particular
+its type.  The form STRING is shorthand for { 'type': STRING }.
+
+Example:
=20
  { 'alternate': 'BlockdevRef',
    'data': { 'definition': 'BlockdevOptions',
              'reference': 'str' } }
=20
-Unlike a union, the discriminator string is never passed on the wire
-for the Client JSON Protocol.  Instead, the value's JSON type serves
-as an implicit discriminator, which in turn means that an alternate
-can only express a choice between types represented differently in
-JSON.  If a branch is typed as the 'bool' built-in, the alternate
-accepts true and false; if it is typed as any of the various numeric
+An alternate type is like a union type, except there is no
+discriminator on the wire.  Instead, the branch to use is inferred
+from the value.  An alternate can only express a choice between types
+represented differently on the wire.
+
+If a branch is typed as the 'bool' built-in, the alternate accepts
+true and false; if it is typed as any of the various numeric
 built-ins, it accepts a JSON number; if it is typed as a 'str'
 built-in or named enum type, it accepts a JSON string; if it is typed
 as the 'null' built-in, it accepts JSON null; and if it is typed as a
-complex type (struct or union), it accepts a JSON object.  Two
-different complex types, for instance, aren't permitted, because both
-are represented as a JSON object.
+complex type (struct or union), it accepts a JSON object.
=20
 The example alternate declaration above allows using both of the
 following example objects:
@@ -332,43 +438,52 @@ following example objects:
              "read-only": false,
              "filename": "/tmp/mydisk.qcow2" } }
=20
+The optional 'if' member specifies a conditional.  See "Configuring
+the schema" below for more on this.
+
=20
 =3D=3D=3D Commands =3D=3D=3D
=20
---- General Command Layout ---
+Syntax:
+    COMMAND =3D { 'command': STRING,
+                (
+                '*data': ( MEMBERS | STRING ),
+                |
+                'data': STRING,
+                'boxed': true,
+                )
+                '*returns': TYPE-REF,
+                '*success-response': false,
+                '*gen': false,
+                '*allow-oob': true,
+                '*allow-preconfig': true,
+                '*if': COND }
=20
-Usage: { 'command': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
-         '*returns': TYPE-NAME, '*boxed': true,
-         '*gen': false, '*success-response': false,
-         '*allow-oob': true, '*allow-preconfig': true }
+Member 'command' names the command.
=20
-Commands are defined by using a dictionary containing several members,
-where three members are most common.  The 'command' member is a
-mandatory string, and determines the "execute" value passed in a
-Client JSON Protocol command exchange.
+Member 'data' defines the arguments.  It defaults to an empty MEMBERS
+object.
=20
-The 'data' argument maps to the "arguments" dictionary passed in as
-part of a Client JSON Protocol command.  The 'data' member is optional
-and defaults to {} (an empty dictionary).  If present, it must be the
-string name of a complex type, or a dictionary that declares an
-anonymous type with the same semantics as a 'struct' expression.
+If 'data' is a MEMBERS object, then MEMBERS defines arguments just
+like a struct type's 'data' defines struct type members.
=20
-The 'returns' member describes what will appear in the "return" member
-of a Client JSON Protocol reply on successful completion of a command.
-The member is optional from the command declaration; if absent, the
-"return" member will be an empty dictionary.  If 'returns' is present,
-it must be the string name of a complex type, or a
-one-element array containing the name of a complex type.
-To return anything else, you have to list the command in pragma
-'returns-whitelist'.  If you do this, the command cannot be extended
-to return additional information in the future.  Use of
+If 'data' is a STRING, then STRING names a complex type whose members
+are the arguments.  A union type requires 'boxed': true.
+
+Member 'returns' defines the command's return type.  It defaults to an
+empty struct type.  It must normally be a complex type or an array of
+a complex type.  To return anything else, the command must be listed
+in pragma 'returns-whitelist'.  If you do this, extending the command
+to return additional information will be harder.  Use of
 'returns-whitelist' for new commands is strongly discouraged.
=20
-All commands in Client JSON Protocol use a dictionary to report
-failure, with no way to specify that in QAPI.  Where the error return
-is different than the usual GenericError class in order to help the
-client react differently to certain error conditions, it is worth
-documenting this in the comments before the command declaration.
+A command's error responses are not specified in the QAPI schema.
+Error conditions should be documented in comments.
+
+In the Client JSON Protocol, the value of the "execute" or "exec-oob"
+member is the command name.  The value of the "arguments" member then
+has to conform to the arguments, and the value of the success
+response's "return" member will conform to the return type.
=20
 Some example commands:
=20
@@ -386,23 +501,24 @@ which would validate this Client JSON Protocol tran=
saction:
  =3D> { "execute": "my-second-command" }
  <=3D { "return": [ { "value": "one" }, { } ] }
=20
-The generator emits a prototype for the user's function implementing
-the command.  Normally, 'data' is a dictionary for an anonymous type,
-or names a struct type (possibly empty, but not a union), and its
-members are passed as separate arguments to this function.  If the
-command definition includes a key 'boxed' with the boolean value true,
-then 'data' is instead the name of any non-empty complex type (struct
-or union), and a pointer to that QAPI type is passed as a single
-argument.
+The generator emits a prototype for the C function implementing the
+command.  The function itself needs to be written by hand.  See
+section "Code generated for commands" for examples.
+
+The function returns the return type.  When member 'boxed' is absent,
+it takes the command arguments as arguments one by one, in QAPI schema
+order.  Else it takes them wrapped in the C struct generated for the
+complex argument type.  It takes an additional Error ** argument in
+either case.
=20
 The generator also emits a marshalling function that extracts
 arguments for the user's function out of an input QDict, calls the
 user's function, and if it succeeded, builds an output QObject from
-its return value.
+its return value.  This is for use by the QMP monitor core.
=20
 In rare cases, QAPI cannot express a type-safe representation of a
 corresponding Client JSON Protocol command.  You then have to suppress
-generation of a marshalling function by including a key 'gen' with
+generation of a marshalling function by including a member 'gen' with
 boolean value false, and instead write your own function.  For
 example:
=20
@@ -416,13 +532,12 @@ use type-safe unions.
 Normally, the QAPI schema is used to describe synchronous exchanges,
 where a response is expected.  But in some cases, the action of a
 command is expected to change state in a way that a successful
-response is not possible (although the command will still return a
-normal dictionary error on failure).  When a successful reply is not
-possible, the command expression includes the optional key
-'success-response' with boolean value false.  So far, only QGA makes
-use of this member.
+response is not possible (although the command will still return an
+error object on failure).  When a successful reply is not possible,
+the command definition includes the optional member 'success-response'
+with boolean value false.  So far, only QGA makes use of this member.
=20
-Key 'allow-oob' declares whether the command supports out-of-band
+Member 'allow-oob' declares whether the command supports out-of-band
 (OOB) execution.  It defaults to false.  For example:
=20
  { 'command': 'migrate_recover',
@@ -455,8 +570,8 @@ other "slow" lock.
=20
 When in doubt, do not implement OOB execution support.
=20
-Key 'allow-preconfig' declares whether the command is available before
-the machine is built.  It defaults to false.  For example:
+Member 'allow-preconfig' declares whether the command is available
+before the machine is built.  It defaults to false.  For example:
=20
  { 'command': 'qmp_capabilities',
    'data': { '*enable': [ 'QMPCapability' ] },
@@ -465,16 +580,33 @@ the machine is built.  It defaults to false.  For e=
xample:
 QMP is available before the machine is built only when QEMU was
 started with --preconfig.
=20
+The optional 'if' member specifies a conditional.  See "Configuring
+the schema" below for more on this.
+
+
 =3D=3D=3D Events =3D=3D=3D
=20
-Usage: { 'event': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
-         '*boxed': true }
-
-Events are defined with the keyword 'event'.  When 'data' is also
-specified, additional info will be included in the event, with similar
-semantics to a 'struct' expression.  Finally there will be C API
-generated in qapi-events.h; when called by QEMU code, a message with
-timestamp will be emitted on the wire.
+Syntax:
+    EVENT =3D { 'event': STRING,
+              (
+              '*data': ( MEMBERS | STRING ),
+              |
+              'data': STRING,
+              'boxed': true,
+              )
+              '*if': COND }
+
+Member 'event' names the event.  This is the event name used in the
+Client JSON Protocol.
+
+Member 'data' defines the event-specific data.  It defaults to an
+empty MEMBERS object.
+
+If 'data' is a MEMBERS object, then MEMBERS defines event-specific
+data just like a struct type's 'data' defines struct type members.
+
+If 'data' is a STRING, then STRING names a complex type whose members
+are the event-specific data.  A union type requires 'boxed': true.
=20
 An example event is:
=20
@@ -487,42 +619,44 @@ Resulting in this JSON object:
   "data": { "b": "test string" },
   "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
=20
-The generator emits a function to send the event.  Normally, 'data' is
-a dictionary for an anonymous type, or names a struct type (possibly
-empty, but not a union), and its members are passed as separate
-arguments to this function.  If the event definition includes a key
-'boxed' with the boolean value true, then 'data' is instead the name
-of any non-empty complex type (struct or union), and a pointer to that
-QAPI type is passed as a single argument.
+The generator emits a function to send the event.  When member 'boxed'
+is absent, it takes event-specific data one by one, in QAPI schema
+order.  Else it takes them wrapped in the C struct generated for the
+complex type.  See section "Code generated for events" for examples.
+
+The optional 'if' member specifies a conditional.  See "Configuring
+the schema" below for more on this.
=20
=20
 =3D=3D=3D Features =3D=3D=3D
=20
+Syntax:
+    FEATURES =3D [ FEATURE, ... ]
+    FEATURE =3D STRING
+            | { 'name': STRING, '*if': COND }
+
 Sometimes, the behaviour of QEMU changes compatibly, but without a
-change in the QMP syntax (usually by allowing values or operations that
-previously resulted in an error). QMP clients may still need to know
-whether the extension is available.
+change in the QMP syntax (usually by allowing values or operations
+that previously resulted in an error).  QMP clients may still need to
+know whether the extension is available.
=20
 For this purpose, a list of features can be specified for a struct type.
 This is exposed to the client as a list of string, where each string
 signals that this build of QEMU shows a certain behaviour.
=20
-In the schema, features can be specified as simple strings, for example:
+Each member of the 'features' array defines a feature.  It can either
+be { 'name': STRING, '*if': COND }, or STRING, which is shorthand for
+{ 'name': STRING }.
+
+The optional 'if' member specifies a conditional.  See "Configuring
+the schema" below for more on this.
+
+Example:
=20
 { 'struct': 'TestType',
   'data': { 'number': 'int' },
   'features': [ 'allow-negative-numbers' ] }
=20
-Another option is to specify features as dictionaries, where the key
-'name' specifies the feature string to be exposed to clients:
-
-{ 'struct': 'TestType',
-  'data': { 'number': 'int' },
-  'features': [ { 'name': 'allow-negative-numbers' } ] }
-
-This expanded form is necessary if you want to make the feature
-conditional (see below in "Configuring the schema").
-
=20
 =3D=3D=3D Naming rules and reserved names =3D=3D=3D
=20
@@ -546,9 +680,8 @@ respectively.
=20
 Command names, and member names within a type, should be all lower
 case with words separated by a hyphen.  However, some existing older
-commands and complex types use underscore; when extending such
-expressions, consistency is preferred over blindly avoiding
-underscore.
+commands and complex types use underscore; when extending them,
+consistency is preferred over blindly avoiding underscore.
=20
 Event names should be ALL_CAPS with words separated by underscore.
=20
@@ -578,11 +711,14 @@ downstream command __com.redhat_drive-mirror.
=20
 =3D=3D=3D Configuring the schema =3D=3D=3D
=20
-The 'struct', 'enum', 'union', 'alternate', 'command' and 'event'
-top-level expressions can take an 'if' key.  Its value must be a string
-or a list of strings.  A string is shorthand for a list containing just
-that string.  The code generated for the top-level expression will then
-be guarded by #if COND for each COND in the list.
+Syntax:
+    COND =3D STRING
+         | [ STRING, ... ]
+
+All definitions take an optional 'if' member.  Its value must be a
+string or a list of strings.  A string is shorthand for a list
+containing just that string.  The code generated for the definition
+will then be guarded by #if STRING for each STRING in the COND list.
=20
 Example: a conditional struct
=20
@@ -597,29 +733,33 @@ gets its generated code guarded like this:
  #endif /* defined(HAVE_BAR) */
  #endif /* defined(CONFIG_FOO) */
=20
-Where a member can be defined with a single string value for its type,
-it is also possible to supply a dictionary instead with both 'type'
-and 'if' keys.
+Individual members of complex types, commands arguments, and
+event-specific data can also be made conditional.  This requires the
+longhand form of MEMBER.
=20
-Example: a conditional 'bar' member
+Example: a struct type with unconditional member 'foo' and conditional
+member 'bar'
=20
 { 'struct': 'IfStruct', 'data':
   { 'foo': 'int',
     'bar': { 'type': 'int', 'if': 'defined(IFCOND)'} } }
=20
-An enum value can be replaced by a dictionary with a 'name' and a 'if'
-key.
+A union's discriminator may not be conditional.
=20
-Example: a conditional 'bar' enum member.
+Likewise, individual enumeration values be conditional.  This requires
+the longhand form of ENUM-VALUE.
+
+Example: an enum type with unconditional value 'foo' and conditional
+value 'bar'
=20
 { 'enum': 'IfEnum', 'data':
   [ 'foo',
     { 'name' : 'bar', 'if': 'defined(IFCOND)' } ] }
=20
-Similarly, features can be specified as a dictionary with a 'name' and
-an 'if' key.
+Likewise, features can be conditional.  This requires the longhand
+form of FEATURE.
=20
-Example: a conditional 'allow-negative-numbers' feature
+Example: a struct with conditional feature 'allow-negative-numbers'
=20
 { 'struct': 'TestType',
   'data': { 'number': 'int' },
@@ -628,17 +768,30 @@ Example: a conditional 'allow-negative-numbers' fea=
ture
=20
 Please note that you are responsible to ensure that the C code will
 compile with an arbitrary combination of conditions, since the
-generators are unable to check it at this point.
+generator is unable to check it at this point.
=20
-The presence of 'if' keys in the schema is reflected through to the
-introspection output depending on the build configuration.
+The conditions apply to introspection as well, i.e. introspection
+shows a conditional entity only when the condition is satisfied in
+this particular build.
=20
=20
 =3D=3D=3D Documentation comments =3D=3D=3D
=20
 A multi-line comment that starts and ends with a '##' line is a
-documentation comment.  These are parsed by the documentation
-generator, which recognizes certain markup detailed below.
+documentation comment.
+
+If the documentation comment starts like
+
+    ##
+    # @SYMBOL:
+
+it documents the definition if SYMBOL, else it's free-form
+documentation.
+
+See below for more on definition documentation.
+
+Free-form documentation may be used to provide additional text and
+structuring content.
=20
=20
 =3D=3D=3D=3D Documentation markup =3D=3D=3D=3D
@@ -701,23 +854,24 @@ Example:
 ##
=20
=20
-=3D=3D=3D=3D Expression documentation =3D=3D=3D=3D
+=3D=3D=3D=3D Definition documentation =3D=3D=3D=3D
=20
-Expressions other than include and pragma directives may be preceded
-by a documentation block.  Such blocks are called expression
-documentation blocks.
+Definition documentation, if present, must immediately precede the
+definition it documents.
=20
-When documentation is required (see pragma 'doc-required'), expression
-documentation blocks are mandatory.
+When documentation is required (see pragma 'doc-required'), every
+definition must have documentation.
=20
-The documentation block consists of a first line naming the
-expression, an optional overview, a description of each argument (for
-commands and events) or member (for structs, unions and alternates),
-and optional tagged sections.
+Definition documentation starts with a line naming the definition,
+followed by an optional overview, a description of each argument (for
+commands and events), member (for structs and unions), branch (for
+alternates), or value (for enums), and finally optional tagged
+sections.
=20
 FIXME: the parser accepts these things in almost any order.
+FIXME: union branches should be described, too.
=20
-Extensions added after the expression was first released carry a
+Extensions added after the definition was first released carry a
 '(since x.y.z)' comment.
=20
 A tagged section starts with one of the following words:
@@ -725,7 +879,7 @@ A tagged section starts with one of the following wor=
ds:
 The section ends with the start of a new section.
=20
 A 'Since: x.y.z' tagged section lists the release that introduced the
-expression.
+definition.
=20
 For example:
=20
@@ -771,12 +925,6 @@ For example:
   'data': { '*query-nodes': 'bool' },
   'returns': ['BlockStats'] }
=20
-=3D=3D=3D=3D Free-form documentation =3D=3D=3D=3D
-
-A documentation block that isn't an expression documentation block is
-a free-form documentation block.  These may be used to provide
-additional text and structuring content.
-
=20
 =3D=3D Client JSON Protocol introspection =3D=3D
=20
@@ -862,7 +1010,7 @@ If the event carries no additional information, "arg=
-type" names an
 object type without members.  The event may not have a data member on
 the wire then.
=20
-Each command or event defined with dictionary-valued 'data' in the
+Each command or event defined with 'data' as MEMBERS object in the
 QAPI schema implicitly defines an object type.
=20
 Example: the SchemaInfo for EVENT_C from section Events
@@ -1044,7 +1192,7 @@ receive direction compatibility.
=20
 Any change to types used in both contexts need to consider both.
=20
-Members of enumeration types, complex types and alternate types may be
+Enumeration type values and complex and alternate type members may be
 reordered freely.  For enumerations and alternate types, this doesn't
 affect the wire encoding.  For complex types, this might make the
 implementation emit JSON object members in a different order, which
--=20
2.21.0


