Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63C2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDB120872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDB120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Zol-0006dK-79
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 02:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i7ZmT-0004oG-3L
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i7ZmP-0007kx-QY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i7ZmP-0007k2-Aj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7CAA8309BDAA;
 Tue, 10 Sep 2019 06:37:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9FC36061E;
 Tue, 10 Sep 2019 06:37:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 489881165601; Tue, 10 Sep 2019 08:37:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 08:37:20 +0200
Message-Id: <20190910063724.28470-13-armbru@redhat.com>
In-Reply-To: <20190910063724.28470-1-armbru@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 10 Sep 2019 06:37:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 12/16] docs/devel/qapi-code-gen: Reorder
 sections for readability
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

Section "QMP/Guest agent schema" starts with a brief introduction,
then subsection "Comments", then subsection "Schema overview" (more
elaborate introduction), and only then talks about schema entities
like types, commands, and so forth.

Subsection "Comments" is long and tiring: almost 500 words, mostly
about doc comments.  Move the doc comment part to its own subsection
"Documentation comments" at the very end of "QMP/Guest agent schema".

Subsection "Schema overview" explains naming rules at considerable
length: 250 words.  Move this part to its own subsection "Naming rules
and reserved names" right after the subsections on schema entities.

Subsection "Enumeration types" is wedged between "Struct types" and
"Union types".  Move it before "Struct types".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 436 ++++++++++++++++++-----------------
 1 file changed, 221 insertions(+), 215 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index ec2d374483..663ef10a56 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -50,147 +50,6 @@ schema requires the use of JSON numbers or null.
 Comments are allowed; anything between an unquoted # and the following
 newline is ignored.
=20
-A multi-line comment that starts and ends with a '##' line is a
-documentation comment.  These are parsed by the documentation
-generator, which recognizes certain markup detailed below.
-
-
-=3D=3D=3D=3D Documentation markup =3D=3D=3D=3D
-
-Comment text starting with '=3D' is a section title:
-
-    # =3D Section title
-
-Double the '=3D' for a subsection title:
-
-    # =3D=3D Subsection title
-
-'|' denotes examples:
-
-    # | Text of the example, may span
-    # | multiple lines
-
-'*' starts an itemized list:
-
-    # * First item, may span
-    #   multiple lines
-    # * Second item
-
-You can also use '-' instead of '*'.
-
-A decimal number followed by '.' starts a numbered list:
-
-    # 1. First item, may span
-    #    multiple lines
-    # 2. Second item
-
-The actual number doesn't matter.  You could even use '*' instead of
-'2.' for the second item.
-
-Lists can't be nested.  Blank lines are currently not supported within
-lists.
-
-Additional whitespace between the initial '#' and the comment text is
-permitted.
-
-*foo* and _foo_ are for strong and emphasis styles respectively (they
-do not work over multiple lines). @foo is used to reference a name in
-the schema.
-
-Example:
-
-##
-# =3D Section
-# =3D=3D Subsection
-#
-# Some text foo with *strong* and _emphasis_
-# 1. with a list
-# 2. like that
-#
-# And some code:
-# | $ echo foo
-# | -> do this
-# | <- get that
-#
-##
-
-
-=3D=3D=3D=3D Expression documentation =3D=3D=3D=3D
-
-Expressions other than include and pragma directives may be preceded
-by a documentation block.  Such blocks are called expression
-documentation blocks.
-
-When documentation is required (see pragma 'doc-required'), expression
-documentation blocks are mandatory.
-
-The documentation block consists of a first line naming the
-expression, an optional overview, a description of each argument (for
-commands and events) or member (for structs, unions and alternates),
-and optional tagged sections.
-
-FIXME: the parser accepts these things in almost any order.
-
-Extensions added after the expression was first released carry a
-'(since x.y.z)' comment.
-
-A tagged section starts with one of the following words:
-"Note:"/"Notes:", "Since:", "Example"/"Examples", "Returns:", "TODO:".
-The section ends with the start of a new section.
-
-A 'Since: x.y.z' tagged section lists the release that introduced the
-expression.
-
-For example:
-
-##
-# @BlockStats:
-#
-# Statistics of a virtual block device or a block backing device.
-#
-# @device: If the stats are for a virtual block device, the name
-#          corresponding to the virtual block device.
-#
-# @node-name: The node name of the device. (since 2.3)
-#
-# ... more members ...
-#
-# Since: 0.14.0
-##
-{ 'struct': 'BlockStats',
-  'data': {'*device': 'str', '*node-name': 'str',
-           ... more members ... } }
-
-##
-# @query-blockstats:
-#
-# Query the @BlockStats for all virtual block devices.
-#
-# @query-nodes: If true, the command will query all the
-#               block nodes ... explain, explain ...  (since 2.3)
-#
-# Returns: A list of @BlockStats for each virtual block devices.
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-blockstats" }
-# <- {
-#      ... lots of output ...
-#    }
-#
-##
-{ 'command': 'query-blockstats',
-  'data': { '*query-nodes': 'bool' },
-  'returns': ['BlockStats'] }
-
-=3D=3D=3D=3D Free-form documentation =3D=3D=3D=3D
-
-A documentation block that isn't an expression documentation block is
-a free-form documentation block.  These may be used to provide
-additional text and structuring content.
-
=20
 =3D=3D=3D Schema overview =3D=3D=3D
=20
@@ -217,43 +76,6 @@ refers to a single-dimension array of that type; mult=
i-dimension
 arrays are not directly supported (although an array of a complex
 struct that contains an array member is possible).
=20
-All names must begin with a letter, and contain only ASCII letters,
-digits, hyphen, and underscore.  There are two exceptions: enum values
-may start with a digit, and names that are downstream extensions (see
-section Downstream extensions) start with underscore.
-
-Names beginning with 'q_' are reserved for the generator, which uses
-them for munging QMP names that resemble C keywords or other
-problematic strings.  For example, a member named "default" in qapi
-becomes "q_default" in the generated C code.
-
-Types, commands, and events share a common namespace.  Therefore,
-generally speaking, type definitions should always use CamelCase for
-user-defined type names, while built-in types are lowercase.
-
-Type names ending with 'Kind' or 'List' are reserved for the
-generator, which uses them for implicit union enums and array types,
-respectively.
-
-Command names, and member names within a type, should be all lower
-case with words separated by a hyphen.  However, some existing older
-commands and complex types use underscore; when extending such
-expressions, consistency is preferred over blindly avoiding
-underscore.
-
-Event names should be ALL_CAPS with words separated by underscore.
-
-Member name 'u' and names starting with 'has-' or 'has_' are reserved
-for the generator, which uses them for unions and for tracking
-optional members.
-
-Any name (command, event, type, member, or enum value) beginning with
-"x-" is marked experimental, and may be withdrawn or changed
-incompatibly in a future release.
-
-Pragma 'name-case-whitelist' lets you violate the rules on use of
-upper and lower case.  Use for new code is strongly discouraged.
-
 In the rest of this document, usage lines are given for each
 expression type, with literal strings written in lower case and
 placeholders written in capitals.  If a literal string includes a
@@ -328,6 +150,43 @@ Pragma 'name-case-whitelist' takes a list of names t=
hat may violate
 rules on use of upper- vs. lower-case letters.  Default is none.
=20
=20
+=3D=3D=3D Enumeration types =3D=3D=3D
+
+Usage: { 'enum': STRING, 'data': ARRAY-OF-STRING }
+       { 'enum': STRING, '*prefix': STRING, 'data': ARRAY-OF-STRING }
+
+An enumeration type is a dictionary containing a single 'data' key
+whose value is a list of strings.  An example enumeration is:
+
+ { 'enum': 'MyEnum', 'data': [ 'value1', 'value2', 'value3' ] }
+
+Nothing prevents an empty enumeration, although it is probably not
+useful.  The list of strings should be lower case; if an enum name
+represents multiple words, use '-' between words.  The string 'max' is
+not allowed as an enum value, and values should not be repeated.
+
+The enum constants will be named by using a heuristic to turn the
+type name into a set of underscore separated words. For the example
+above, 'MyEnum' will turn into 'MY_ENUM' giving a constant name
+of 'MY_ENUM_VALUE1' for the first value. If the default heuristic
+does not result in a desirable name, the optional 'prefix' member
+can be used when defining the enum.
+
+The enumeration values are passed as strings over the Client JSON
+Protocol, but are encoded as C enum integral values in generated code.
+While the C code starts numbering at 0, it is better to use explicit
+comparisons to enum values than implicit comparisons to 0; the C code
+will also include a generated enum member ending in _MAX for tracking
+the size of the enum, useful when using common functions for
+converting between strings and enum values.  Since the wire format
+always passes by name, it is acceptable to reorder or add new
+enumeration members in any location without breaking clients of Client
+JSON Protocol; however, removing enum values would break
+compatibility.  For any struct that has a member that will only contain
+a finite set of string values, using an enum type for that member is
+better than open-coding the member to be type 'str'.
+
+
 =3D=3D=3D Struct types =3D=3D=3D
=20
 Usage: { 'struct': STRING, 'data': DICT, '*base': STRUCT-NAME }
@@ -389,43 +248,6 @@ both members like this:
    "backing": "/some/place/my-backing-file" }
=20
=20
-=3D=3D=3D Enumeration types =3D=3D=3D
-
-Usage: { 'enum': STRING, 'data': ARRAY-OF-STRING }
-       { 'enum': STRING, '*prefix': STRING, 'data': ARRAY-OF-STRING }
-
-An enumeration type is a dictionary containing a single 'data' key
-whose value is a list of strings.  An example enumeration is:
-
- { 'enum': 'MyEnum', 'data': [ 'value1', 'value2', 'value3' ] }
-
-Nothing prevents an empty enumeration, although it is probably not
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
-converting between strings and enum values.  Since the wire format
-always passes by name, it is acceptable to reorder or add new
-enumeration members in any location without breaking clients of Client
-JSON Protocol; however, removing enum values would break
-compatibility.  For any struct that has a member that will only contain
-a finite set of string values, using an enum type for that member is
-better than open-coding the member to be type 'str'.
-
-
 =3D=3D=3D Union types =3D=3D=3D
=20
 Usage: { 'union': STRING, 'data': DICT }
@@ -744,6 +566,46 @@ This expanded form is necessary if you want to make =
the feature
 conditional (see below in "Configuring the schema").
=20
=20
+=3D=3D=3D Naming rules and reserved names =3D=3D=3D
+
+All names must begin with a letter, and contain only ASCII letters,
+digits, hyphen, and underscore.  There are two exceptions: enum values
+may start with a digit, and names that are downstream extensions (see
+section Downstream extensions) start with underscore.
+
+Names beginning with 'q_' are reserved for the generator, which uses
+them for munging QMP names that resemble C keywords or other
+problematic strings.  For example, a member named "default" in qapi
+becomes "q_default" in the generated C code.
+
+Types, commands, and events share a common namespace.  Therefore,
+generally speaking, type definitions should always use CamelCase for
+user-defined type names, while built-in types are lowercase.
+
+Type names ending with 'Kind' or 'List' are reserved for the
+generator, which uses them for implicit union enums and array types,
+respectively.
+
+Command names, and member names within a type, should be all lower
+case with words separated by a hyphen.  However, some existing older
+commands and complex types use underscore; when extending such
+expressions, consistency is preferred over blindly avoiding
+underscore.
+
+Event names should be ALL_CAPS with words separated by underscore.
+
+Member name 'u' and names starting with 'has-' or 'has_' are reserved
+for the generator, which uses them for unions and for tracking
+optional members.
+
+Any name (command, event, type, member, or enum value) beginning with
+"x-" is marked experimental, and may be withdrawn or changed
+incompatibly in a future release.
+
+Pragma 'name-case-whitelist' lets you violate the rules on use of
+upper and lower case.  Use for new code is strongly discouraged.
+
+
 =3D=3D=3D Downstream extensions =3D=3D=3D
=20
 QAPI schema names that are externally visible, say in the Client JSON
@@ -814,6 +676,150 @@ The presence of 'if' keys in the schema is reflecte=
d through to the
 introspection output depending on the build configuration.
=20
=20
+=3D=3D=3D Documentation comments =3D=3D=3D
+
+A multi-line comment that starts and ends with a '##' line is a
+documentation comment.  These are parsed by the documentation
+generator, which recognizes certain markup detailed below.
+
+
+=3D=3D=3D=3D Documentation markup =3D=3D=3D=3D
+
+Comment text starting with '=3D' is a section title:
+
+    # =3D Section title
+
+Double the '=3D' for a subsection title:
+
+    # =3D=3D Subsection title
+
+'|' denotes examples:
+
+    # | Text of the example, may span
+    # | multiple lines
+
+'*' starts an itemized list:
+
+    # * First item, may span
+    #   multiple lines
+    # * Second item
+
+You can also use '-' instead of '*'.
+
+A decimal number followed by '.' starts a numbered list:
+
+    # 1. First item, may span
+    #    multiple lines
+    # 2. Second item
+
+The actual number doesn't matter.  You could even use '*' instead of
+'2.' for the second item.
+
+Lists can't be nested.  Blank lines are currently not supported within
+lists.
+
+Additional whitespace between the initial '#' and the comment text is
+permitted.
+
+*foo* and _foo_ are for strong and emphasis styles respectively (they
+do not work over multiple lines).  @foo is used to reference a name in
+the schema.
+
+Example:
+
+##
+# =3D Section
+# =3D=3D Subsection
+#
+# Some text foo with *strong* and _emphasis_
+# 1. with a list
+# 2. like that
+#
+# And some code:
+# | $ echo foo
+# | -> do this
+# | <- get that
+#
+##
+
+
+=3D=3D=3D=3D Expression documentation =3D=3D=3D=3D
+
+Expressions other than include and pragma directives may be preceded
+by a documentation block.  Such blocks are called expression
+documentation blocks.
+
+When documentation is required (see pragma 'doc-required'), expression
+documentation blocks are mandatory.
+
+The documentation block consists of a first line naming the
+expression, an optional overview, a description of each argument (for
+commands and events) or member (for structs, unions and alternates),
+and optional tagged sections.
+
+FIXME: the parser accepts these things in almost any order.
+
+Extensions added after the expression was first released carry a
+'(since x.y.z)' comment.
+
+A tagged section starts with one of the following words:
+"Note:"/"Notes:", "Since:", "Example"/"Examples", "Returns:", "TODO:".
+The section ends with the start of a new section.
+
+A 'Since: x.y.z' tagged section lists the release that introduced the
+expression.
+
+For example:
+
+##
+# @BlockStats:
+#
+# Statistics of a virtual block device or a block backing device.
+#
+# @device: If the stats are for a virtual block device, the name
+#          corresponding to the virtual block device.
+#
+# @node-name: The node name of the device. (since 2.3)
+#
+# ... more members ...
+#
+# Since: 0.14.0
+##
+{ 'struct': 'BlockStats',
+  'data': {'*device': 'str', '*node-name': 'str',
+           ... more members ... } }
+
+##
+# @query-blockstats:
+#
+# Query the @BlockStats for all virtual block devices.
+#
+# @query-nodes: If true, the command will query all the
+#               block nodes ... explain, explain ...  (since 2.3)
+#
+# Returns: A list of @BlockStats for each virtual block devices.
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-blockstats" }
+# <- {
+#      ... lots of output ...
+#    }
+#
+##
+{ 'command': 'query-blockstats',
+  'data': { '*query-nodes': 'bool' },
+  'returns': ['BlockStats'] }
+
+=3D=3D=3D=3D Free-form documentation =3D=3D=3D=3D
+
+A documentation block that isn't an expression documentation block is
+a free-form documentation block.  These may be used to provide
+additional text and structuring content.
+
+
 =3D=3D Client JSON Protocol introspection =3D=3D
=20
 Clients of a Client JSON Protocol commonly need to figure out what
--=20
2.21.0


