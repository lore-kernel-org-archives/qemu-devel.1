Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEE3C4740A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F8F208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F8F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Zwn-00070r-5y
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 02:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i7ZmR-0004mO-SG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i7ZmP-0007kZ-B2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45710)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i7ZmO-0007jP-T7
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0ED5E308449F;
 Tue, 10 Sep 2019 06:37:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB1E26012E;
 Tue, 10 Sep 2019 06:37:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 561C01165609; Tue, 10 Sep 2019 08:37:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 08:37:24 +0200
Message-Id: <20190910063724.28470-17-armbru@redhat.com>
In-Reply-To: <20190910063724.28470-1-armbru@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 10 Sep 2019 06:37:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 16/16] qapi: Tweak code to match
 docs/devel/qapi-code-gen.txt
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

The previous commit made qapi-code-gen.txt define "(top-level)
expression" as either "directive" or "definition".  The code still
uses "expression" when it really means "definition".  Tidy up.

The previous commit made qapi-code-gen.txt use "object" rather than
"dictionary".  The code still uses "dictionary".  Tidy up.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                        | 24 +++++++++----------
 tests/qapi-schema/args-invalid.err            |  2 +-
 tests/qapi-schema/doc-missing.err             |  2 +-
 tests/qapi-schema/doc-no-symbol.err           |  2 +-
 .../qapi-schema/enum-dict-member-unknown.err  |  2 +-
 tests/qapi-schema/pragma-non-dict.err         |  2 +-
 tests/qapi-schema/struct-data-invalid.err     |  2 +-
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index f4630a5dd3..e86d196e5f 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -103,11 +103,11 @@ class QAPISemError(QAPIError):
=20
 class QAPIDoc(object):
     """
-    A documentation comment block, either expression or free-form
+    A documentation comment block, either definition or free-form
=20
-    Expression documentation blocks consist of
+    Definition documentation blocks consist of
=20
-    * a body section: one line naming the expression, followed by an
+    * a body section: one line naming the definition, followed by an
       overview (any number of lines)
=20
     * argument sections: a description of each argument (for commands
@@ -200,9 +200,9 @@ class QAPIDoc(object):
         Process a line of documentation text in the body section.
=20
         If this a symbol line and it is the section's first line, this
-        is an expression documentation block for that symbol.
+        is a definition documentation block for that symbol.
=20
-        If it's an expression documentation block, another symbol line
+        If it's a definition documentation block, another symbol line
         begins the argument section for the argument named by it, and
         a section tag begins an additional section.  Start that
         section and append the line to it.
@@ -220,7 +220,7 @@ class QAPIDoc(object):
             if not self.symbol:
                 raise QAPIParseError(self._parser, "Invalid name")
         elif self.symbol:
-            # This is an expression documentation block
+            # This is a definition documentation block
             if name.startswith('@') and name.endswith(':'):
                 self._append_line =3D self._append_args_line
                 self._append_args_line(line)
@@ -428,7 +428,7 @@ class QAPISchemaParser(object):
                 pragma =3D expr['pragma']
                 if not isinstance(pragma, dict):
                     raise QAPISemError(
-                        info, "Value of 'pragma' must be a dictionary")
+                        info, "Value of 'pragma' must be an object")
                 for name, value in pragma.items():
                     self._pragma(name, value, info)
             else:
@@ -437,7 +437,7 @@ class QAPISchemaParser(object):
                 if cur_doc:
                     if not cur_doc.symbol:
                         raise QAPISemError(
-                            cur_doc.info, "Expression documentation requ=
ired")
+                            cur_doc.info, "Definition documentation requ=
ired")
                     expr_elem['doc'] =3D cur_doc
                 self.exprs.append(expr_elem)
             cur_doc =3D None
@@ -786,7 +786,7 @@ def check_type(info, source, value,
=20
     if not isinstance(value, OrderedDict):
         raise QAPISemError(info,
-                           "%s should be a dictionary or type name" % so=
urce)
+                           "%s should be an object or type name" % sourc=
e)
=20
     # value is a dictionary, check that each member is okay
     for (key, arg) in value.items():
@@ -968,8 +968,8 @@ def check_enum(expr, info):
                            "Enum '%s' requires a string for 'prefix'" % =
name)
=20
     for member in members:
-        source =3D "dictionary member of enum '%s'" % name
-        check_known_keys(info, source, member, ['name'], ['if'])
+        check_known_keys(info, "member of enum '%s'" % name, member,
+                         ['name'], ['if'])
         check_if(member, info)
         check_name(info, "Member of enum '%s'" % name, member['name'],
                    enum_member=3DTrue)
@@ -1078,7 +1078,7 @@ def check_exprs(exprs):
=20
         if not doc and doc_required:
             raise QAPISemError(info,
-                               "Expression missing documentation comment=
")
+                               "Definition missing documentation comment=
")
=20
         if 'enum' in expr:
             meta =3D 'enum'
diff --git a/tests/qapi-schema/args-invalid.err b/tests/qapi-schema/args-=
invalid.err
index fe1e94975b..bfb2e4133e 100644
--- a/tests/qapi-schema/args-invalid.err
+++ b/tests/qapi-schema/args-invalid.err
@@ -1 +1 @@
-tests/qapi-schema/args-invalid.json:1: 'data' for command 'foo' should b=
e a dictionary or type name
+tests/qapi-schema/args-invalid.json:1: 'data' for command 'foo' should b=
e an object or type name
diff --git a/tests/qapi-schema/doc-missing.err b/tests/qapi-schema/doc-mi=
ssing.err
index 7f2f326b30..3a377ddc57 100644
--- a/tests/qapi-schema/doc-missing.err
+++ b/tests/qapi-schema/doc-missing.err
@@ -1 +1 @@
-tests/qapi-schema/doc-missing.json:5: Expression missing documentation c=
omment
+tests/qapi-schema/doc-missing.json:5: Definition missing documentation c=
omment
diff --git a/tests/qapi-schema/doc-no-symbol.err b/tests/qapi-schema/doc-=
no-symbol.err
index 75f032a942..212984ff20 100644
--- a/tests/qapi-schema/doc-no-symbol.err
+++ b/tests/qapi-schema/doc-no-symbol.err
@@ -1 +1 @@
-tests/qapi-schema/doc-no-symbol.json:3: Expression documentation require=
d
+tests/qapi-schema/doc-no-symbol.json:3: Definition documentation require=
d
diff --git a/tests/qapi-schema/enum-dict-member-unknown.err b/tests/qapi-=
schema/enum-dict-member-unknown.err
index 2aae618be0..7fd9c032bf 100644
--- a/tests/qapi-schema/enum-dict-member-unknown.err
+++ b/tests/qapi-schema/enum-dict-member-unknown.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/enum-dict-member-unknown.json:2: Unknown key 'bad-key'=
 in dictionary member of enum 'MyEnum'
+tests/qapi-schema/enum-dict-member-unknown.json:2: Unknown key 'bad-key'=
 in member of enum 'MyEnum'
 Valid keys are 'if', 'name'.
diff --git a/tests/qapi-schema/pragma-non-dict.err b/tests/qapi-schema/pr=
agma-non-dict.err
index 75bc335aea..b358261050 100644
--- a/tests/qapi-schema/pragma-non-dict.err
+++ b/tests/qapi-schema/pragma-non-dict.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-non-dict.json:3: Value of 'pragma' must be a di=
ctionary
+tests/qapi-schema/pragma-non-dict.json:3: Value of 'pragma' must be an o=
bject
diff --git a/tests/qapi-schema/struct-data-invalid.err b/tests/qapi-schem=
a/struct-data-invalid.err
index 6644f4c2ad..4bf5bcc255 100644
--- a/tests/qapi-schema/struct-data-invalid.err
+++ b/tests/qapi-schema/struct-data-invalid.err
@@ -1 +1 @@
-tests/qapi-schema/struct-data-invalid.json:1: 'data' for struct 'foo' sh=
ould be a dictionary or type name
+tests/qapi-schema/struct-data-invalid.json:1: 'data' for struct 'foo' sh=
ould be an object or type name
--=20
2.21.0


