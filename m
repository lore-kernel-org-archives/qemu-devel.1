Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC4DC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317442146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317442146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCkXC-0002tC-AW
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCk0p-0001M2-VA
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCk0j-0006xk-K7
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCk0i-0006uo-Nv
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D3834C0568FA
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52CF360E1C;
 Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E8FED1136425; Tue, 24 Sep 2019 14:33:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/37] qapi: Use quotes more consistently in frontend error
 messages
Date: Tue, 24 Sep 2019 14:33:22 +0200
Message-Id: <20190924123334.30645-26-armbru@redhat.com>
In-Reply-To: <20190924123334.30645-1-armbru@redhat.com>
References: <20190924123334.30645-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Consistently enclose error messages in double quotes.  Use single
quotes within, except for one case of "'".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190914153506.2151-8-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py                        | 37 ++++++++++---------
 tests/qapi-schema/bad-type-int.err            |  2 +-
 tests/qapi-schema/doc-missing-colon.err       |  2 +-
 tests/qapi-schema/duplicate-key.err           |  2 +-
 tests/qapi-schema/enum-int-member.err         |  2 +-
 tests/qapi-schema/escape-outside-string.err   |  1 +
 tests/qapi-schema/funny-char.err              |  2 +-
 tests/qapi-schema/funny-word.err              |  2 +-
 tests/qapi-schema/include-before-err.err      |  2 +-
 tests/qapi-schema/include-nested-err.err      |  2 +-
 tests/qapi-schema/leading-comma-list.err      |  2 +-
 tests/qapi-schema/leading-comma-object.err    |  2 +-
 tests/qapi-schema/missing-colon.err           |  2 +-
 tests/qapi-schema/missing-comma-list.err      |  2 +-
 tests/qapi-schema/missing-comma-object.err    |  2 +-
 tests/qapi-schema/non-objects.err             |  2 +-
 tests/qapi-schema/quoted-structural-chars.err |  2 +-
 tests/qapi-schema/trailing-comma-list.err     |  2 +-
 tests/qapi-schema/unclosed-list.err           |  2 +-
 tests/qapi-schema/unclosed-object.err         |  2 +-
 20 files changed, 38 insertions(+), 36 deletions(-)
 create mode 100644 tests/qapi-schema/escape-outside-string.err

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index f27860540b..142ab276ff 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -214,7 +214,7 @@ class QAPIDoc(object):
         # recognized, and get silently treated as ordinary text
         if not self.symbol and not self.body.text and line.startswith('@=
'):
             if not line.endswith(':'):
-                raise QAPIParseError(self._parser, "Line should end with=
 :")
+                raise QAPIParseError(self._parser, "Line should end with=
 ':'")
             self.symbol =3D line[1:-1]
             # FIXME invalid names other than the empty string aren't fla=
gged
             if not self.symbol:
@@ -470,7 +470,7 @@ class QAPISchemaParser(object):
             else:
                 fobj =3D open(incl_fname, 'r')
         except IOError as e:
-            raise QAPISemError(info, '%s: %s' % (e.strerror, incl_fname)=
)
+            raise QAPISemError(info, "%s: %s" % (e.strerror, incl_fname)=
)
         return QAPISchemaParser(fobj, previously_included, info)
=20
     def _pragma(self, name, value, info):
@@ -522,7 +522,7 @@ class QAPISchemaParser(object):
                     ch =3D self.src[self.cursor]
                     self.cursor +=3D 1
                     if ch =3D=3D '\n':
-                        raise QAPIParseError(self, 'Missing terminating =
"\'"')
+                        raise QAPIParseError(self, "Missing terminating =
\"'\"")
                     if esc:
                         # Note: we recognize only \\ because we have
                         # no use for funny characters in strings
@@ -559,7 +559,7 @@ class QAPISchemaParser(object):
                 self.line +=3D 1
                 self.line_pos =3D self.cursor
             elif not self.tok.isspace():
-                raise QAPIParseError(self, 'Stray "%s"' % self.tok)
+                raise QAPIParseError(self, "Stray '%s'" % self.tok)
=20
     def get_members(self):
         expr =3D OrderedDict()
@@ -567,24 +567,24 @@ class QAPISchemaParser(object):
             self.accept()
             return expr
         if self.tok !=3D "'":
-            raise QAPIParseError(self, 'Expected string or "}"')
+            raise QAPIParseError(self, "Expected string or '}'")
         while True:
             key =3D self.val
             self.accept()
             if self.tok !=3D ':':
-                raise QAPIParseError(self, 'Expected ":"')
+                raise QAPIParseError(self, "Expected ':'")
             self.accept()
             if key in expr:
-                raise QAPIParseError(self, 'Duplicate key "%s"' % key)
+                raise QAPIParseError(self, "Duplicate key '%s'" % key)
             expr[key] =3D self.get_expr(True)
             if self.tok =3D=3D '}':
                 self.accept()
                 return expr
             if self.tok !=3D ',':
-                raise QAPIParseError(self, 'Expected "," or "}"')
+                raise QAPIParseError(self, "Expected ',' or '}'")
             self.accept()
             if self.tok !=3D "'":
-                raise QAPIParseError(self, 'Expected string')
+                raise QAPIParseError(self, "Expected string")
=20
     def get_values(self):
         expr =3D []
@@ -592,20 +592,20 @@ class QAPISchemaParser(object):
             self.accept()
             return expr
         if self.tok not in "{['tfn":
-            raise QAPIParseError(self, 'Expected "{", "[", "]", string, =
'
-                                 'boolean or "null"')
+            raise QAPIParseError(
+                self, "Expected '{', '[', ']', string, boolean or 'null'=
")
         while True:
             expr.append(self.get_expr(True))
             if self.tok =3D=3D ']':
                 self.accept()
                 return expr
             if self.tok !=3D ',':
-                raise QAPIParseError(self, 'Expected "," or "]"')
+                raise QAPIParseError(self, "Expected ',' or ']'")
             self.accept()
=20
     def get_expr(self, nested):
         if self.tok !=3D '{' and not nested:
-            raise QAPIParseError(self, 'Expected "{"')
+            raise QAPIParseError(self, "Expected '{'")
         if self.tok =3D=3D '{':
             self.accept()
             expr =3D self.get_members()
@@ -616,8 +616,8 @@ class QAPISchemaParser(object):
             expr =3D self.val
             self.accept()
         else:
-            raise QAPIParseError(self, 'Expected "{", "[", string, '
-                                 'boolean or "null"')
+            raise QAPIParseError(
+                self, "Expected '{', '[', string, boolean or 'null'")
         return expr
=20
     def get_doc(self, info):
@@ -881,9 +881,10 @@ def check_union(expr, info):
                                "struct '%s'"
                                % (discriminator, base))
         if discriminator_value.get('if'):
-            raise QAPISemError(info, 'The discriminator %s.%s for union =
%s '
-                               'must not be conditional' %
-                               (base, discriminator, name))
+            raise QAPISemError(
+                info,
+                "The discriminator %s.%s for union %s must not be condit=
ional"
+                % (base, discriminator, name))
         enum_define =3D enum_types.get(discriminator_value['type'])
         # Do not allow string discriminator
         if not enum_define:
diff --git a/tests/qapi-schema/bad-type-int.err b/tests/qapi-schema/bad-t=
ype-int.err
index da89895404..2021fda5d1 100644
--- a/tests/qapi-schema/bad-type-int.err
+++ b/tests/qapi-schema/bad-type-int.err
@@ -1 +1 @@
-tests/qapi-schema/bad-type-int.json:3:13: Stray "1"
+tests/qapi-schema/bad-type-int.json:3:13: Stray '1'
diff --git a/tests/qapi-schema/doc-missing-colon.err b/tests/qapi-schema/=
doc-missing-colon.err
index 817398b8e4..b41d5078b0 100644
--- a/tests/qapi-schema/doc-missing-colon.err
+++ b/tests/qapi-schema/doc-missing-colon.err
@@ -1 +1 @@
-tests/qapi-schema/doc-missing-colon.json:4:1: Line should end with :
+tests/qapi-schema/doc-missing-colon.json:4:1: Line should end with ':'
diff --git a/tests/qapi-schema/duplicate-key.err b/tests/qapi-schema/dupl=
icate-key.err
index 6d02f83538..3af2f55174 100644
--- a/tests/qapi-schema/duplicate-key.err
+++ b/tests/qapi-schema/duplicate-key.err
@@ -1 +1 @@
-tests/qapi-schema/duplicate-key.json:3:10: Duplicate key "key"
+tests/qapi-schema/duplicate-key.json:3:10: Duplicate key 'key'
diff --git a/tests/qapi-schema/enum-int-member.err b/tests/qapi-schema/en=
um-int-member.err
index 071c5213d8..3f8d7b5b71 100644
--- a/tests/qapi-schema/enum-int-member.err
+++ b/tests/qapi-schema/enum-int-member.err
@@ -1 +1 @@
-tests/qapi-schema/enum-int-member.json:3:31: Stray "1"
+tests/qapi-schema/enum-int-member.json:3:31: Stray '1'
diff --git a/tests/qapi-schema/escape-outside-string.err b/tests/qapi-sch=
ema/escape-outside-string.err
new file mode 100644
index 0000000000..efee335ba0
--- /dev/null
+++ b/tests/qapi-schema/escape-outside-string.err
@@ -0,0 +1 @@
+tests/qapi-schema/escape-outside-string.json:3:27: Stray '\'
diff --git a/tests/qapi-schema/funny-char.err b/tests/qapi-schema/funny-c=
har.err
index bfc890cd9f..139ecf4eb8 100644
--- a/tests/qapi-schema/funny-char.err
+++ b/tests/qapi-schema/funny-char.err
@@ -1 +1 @@
-tests/qapi-schema/funny-char.json:2:36: Stray ";"
+tests/qapi-schema/funny-char.json:2:36: Stray ';'
diff --git a/tests/qapi-schema/funny-word.err b/tests/qapi-schema/funny-w=
ord.err
index 0a440574bd..18aedb4a99 100644
--- a/tests/qapi-schema/funny-word.err
+++ b/tests/qapi-schema/funny-word.err
@@ -1 +1 @@
-tests/qapi-schema/funny-word.json:1:3: Stray "c"
+tests/qapi-schema/funny-word.json:1:3: Stray 'c'
diff --git a/tests/qapi-schema/include-before-err.err b/tests/qapi-schema=
/include-before-err.err
index 55652751e1..2b26322170 100644
--- a/tests/qapi-schema/include-before-err.err
+++ b/tests/qapi-schema/include-before-err.err
@@ -1 +1 @@
-tests/qapi-schema/include-before-err.json:2:13: Expected ":"
+tests/qapi-schema/include-before-err.json:2:13: Expected ':'
diff --git a/tests/qapi-schema/include-nested-err.err b/tests/qapi-schema=
/include-nested-err.err
index 1b7b22706b..aec6207eb0 100644
--- a/tests/qapi-schema/include-nested-err.err
+++ b/tests/qapi-schema/include-nested-err.err
@@ -1,2 +1,2 @@
 In file included from tests/qapi-schema/include-nested-err.json:1:
-tests/qapi-schema/missing-colon.json:1:10: Expected ":"
+tests/qapi-schema/missing-colon.json:1:10: Expected ':'
diff --git a/tests/qapi-schema/leading-comma-list.err b/tests/qapi-schema=
/leading-comma-list.err
index f5c870bb9c..e021e42ad9 100644
--- a/tests/qapi-schema/leading-comma-list.err
+++ b/tests/qapi-schema/leading-comma-list.err
@@ -1 +1 @@
-tests/qapi-schema/leading-comma-list.json:2:13: Expected "{", "[", "]", =
string, boolean or "null"
+tests/qapi-schema/leading-comma-list.json:2:13: Expected '{', '[', ']', =
string, boolean or 'null'
diff --git a/tests/qapi-schema/leading-comma-object.err b/tests/qapi-sche=
ma/leading-comma-object.err
index f767b95544..3852f123d2 100644
--- a/tests/qapi-schema/leading-comma-object.err
+++ b/tests/qapi-schema/leading-comma-object.err
@@ -1 +1 @@
-tests/qapi-schema/leading-comma-object.json:1:3: Expected string or "}"
+tests/qapi-schema/leading-comma-object.json:1:3: Expected string or '}'
diff --git a/tests/qapi-schema/missing-colon.err b/tests/qapi-schema/miss=
ing-colon.err
index d9d66b377a..a255e51918 100644
--- a/tests/qapi-schema/missing-colon.err
+++ b/tests/qapi-schema/missing-colon.err
@@ -1 +1 @@
-tests/qapi-schema/missing-colon.json:1:10: Expected ":"
+tests/qapi-schema/missing-colon.json:1:10: Expected ':'
diff --git a/tests/qapi-schema/missing-comma-list.err b/tests/qapi-schema=
/missing-comma-list.err
index e73d2770d6..df3f553f39 100644
--- a/tests/qapi-schema/missing-comma-list.err
+++ b/tests/qapi-schema/missing-comma-list.err
@@ -1 +1 @@
-tests/qapi-schema/missing-comma-list.json:2:20: Expected "," or "]"
+tests/qapi-schema/missing-comma-list.json:2:20: Expected ',' or ']'
diff --git a/tests/qapi-schema/missing-comma-object.err b/tests/qapi-sche=
ma/missing-comma-object.err
index 52b3a8a1ec..0f691b8ddd 100644
--- a/tests/qapi-schema/missing-comma-object.err
+++ b/tests/qapi-schema/missing-comma-object.err
@@ -1 +1 @@
-tests/qapi-schema/missing-comma-object.json:2:3: Expected "," or "}"
+tests/qapi-schema/missing-comma-object.json:2:3: Expected ',' or '}'
diff --git a/tests/qapi-schema/non-objects.err b/tests/qapi-schema/non-ob=
jects.err
index 334f0c91ae..a972abd937 100644
--- a/tests/qapi-schema/non-objects.err
+++ b/tests/qapi-schema/non-objects.err
@@ -1 +1 @@
-tests/qapi-schema/non-objects.json:1:1: Expected "{"
+tests/qapi-schema/non-objects.json:1:1: Expected '{'
diff --git a/tests/qapi-schema/quoted-structural-chars.err b/tests/qapi-s=
chema/quoted-structural-chars.err
index 9b183841dd..6e036c8044 100644
--- a/tests/qapi-schema/quoted-structural-chars.err
+++ b/tests/qapi-schema/quoted-structural-chars.err
@@ -1 +1 @@
-tests/qapi-schema/quoted-structural-chars.json:1:1: Expected "{"
+tests/qapi-schema/quoted-structural-chars.json:1:1: Expected '{'
diff --git a/tests/qapi-schema/trailing-comma-list.err b/tests/qapi-schem=
a/trailing-comma-list.err
index 212e14ae28..601c4537c3 100644
--- a/tests/qapi-schema/trailing-comma-list.err
+++ b/tests/qapi-schema/trailing-comma-list.err
@@ -1 +1 @@
-tests/qapi-schema/trailing-comma-list.json:2:36: Expected "{", "[", stri=
ng, boolean or "null"
+tests/qapi-schema/trailing-comma-list.json:2:36: Expected '{', '[', stri=
ng, boolean or 'null'
diff --git a/tests/qapi-schema/unclosed-list.err b/tests/qapi-schema/uncl=
osed-list.err
index fb41a86abd..1cc3a094fe 100644
--- a/tests/qapi-schema/unclosed-list.err
+++ b/tests/qapi-schema/unclosed-list.err
@@ -1 +1 @@
-tests/qapi-schema/unclosed-list.json:1:20: Expected "," or "]"
+tests/qapi-schema/unclosed-list.json:1:20: Expected ',' or ']'
diff --git a/tests/qapi-schema/unclosed-object.err b/tests/qapi-schema/un=
closed-object.err
index db3deedd63..fd1a86b704 100644
--- a/tests/qapi-schema/unclosed-object.err
+++ b/tests/qapi-schema/unclosed-object.err
@@ -1 +1 @@
-tests/qapi-schema/unclosed-object.json:1:21: Expected "," or "}"
+tests/qapi-schema/unclosed-object.json:1:21: Expected ',' or '}'
--=20
2.21.0


