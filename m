Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B77C4CEC5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 20:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8387206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 20:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8387206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8s4R-0003Ut-F1
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 16:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8rx8-0005yU-NN
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 16:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8rx6-0000bI-Ca
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 16:13:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8rx6-0000a9-2Q
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 16:13:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B567806A46;
 Fri, 13 Sep 2019 20:13:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5AF15C1B5;
 Fri, 13 Sep 2019 20:13:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 89E561138528; Fri, 13 Sep 2019 22:13:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 22:13:40 +0200
Message-Id: <20190913201349.24332-8-armbru@redhat.com>
In-Reply-To: <20190913201349.24332-1-armbru@redhat.com>
References: <20190913201349.24332-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 13 Sep 2019 20:13:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 07/16] qapi: Drop support for escape
 sequences other than \\
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

Since the previous commit restricted strings to printable ASCII,
\uXXXX's only use is obfuscation.  Drop it.

This leaves \\, \/, \', and \".  Since QAPI schema strings are all
names, and names are restricted to ASCII letters, digits, hyphen, and
underscore, none of them is useful.

The latter three have no test coverage.  Drop them.

Keep \\ to avoid (more) gratuitous incompatibility with JSON.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py                       | 26 +++-----------------
 tests/Makefile.include                       |  3 ---
 tests/qapi-schema/escape-outside-string.err  |  1 -
 tests/qapi-schema/escape-outside-string.exit |  1 -
 tests/qapi-schema/escape-outside-string.json |  3 ---
 tests/qapi-schema/escape-outside-string.out  |  0
 tests/qapi-schema/escape-too-big.err         |  1 -
 tests/qapi-schema/escape-too-big.exit        |  1 -
 tests/qapi-schema/escape-too-big.json        |  3 ---
 tests/qapi-schema/escape-too-big.out         |  0
 tests/qapi-schema/escape-too-short.err       |  1 -
 tests/qapi-schema/escape-too-short.exit      |  1 -
 tests/qapi-schema/escape-too-short.json      |  3 ---
 tests/qapi-schema/escape-too-short.out       |  0
 tests/qapi-schema/ident-with-escape.err      |  1 +
 tests/qapi-schema/ident-with-escape.exit     |  2 +-
 tests/qapi-schema/ident-with-escape.json     |  2 +-
 tests/qapi-schema/ident-with-escape.out      | 16 ------------
 tests/qapi-schema/unknown-escape.json        |  2 +-
 19 files changed, 7 insertions(+), 60 deletions(-)
 delete mode 100644 tests/qapi-schema/escape-outside-string.err
 delete mode 100644 tests/qapi-schema/escape-outside-string.exit
 delete mode 100644 tests/qapi-schema/escape-outside-string.json
 delete mode 100644 tests/qapi-schema/escape-outside-string.out
 delete mode 100644 tests/qapi-schema/escape-too-big.err
 delete mode 100644 tests/qapi-schema/escape-too-big.exit
 delete mode 100644 tests/qapi-schema/escape-too-big.json
 delete mode 100644 tests/qapi-schema/escape-too-big.out
 delete mode 100644 tests/qapi-schema/escape-too-short.err
 delete mode 100644 tests/qapi-schema/escape-too-short.exit
 delete mode 100644 tests/qapi-schema/escape-too-short.json
 delete mode 100644 tests/qapi-schema/escape-too-short.out

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 539b50f9ac..0fb1d1956a 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -524,29 +524,9 @@ class QAPISchemaParser(object):
                     if ch =3D=3D '\n':
                         raise QAPIParseError(self, 'Missing terminating =
"\'"')
                     if esc:
-                        # Note: we don't recognize escape sequences
-                        # for control characters
-                        if ch =3D=3D 'u':
-                            value =3D 0
-                            for _ in range(0, 4):
-                                ch =3D self.src[self.cursor]
-                                self.cursor +=3D 1
-                                if ch not in '0123456789abcdefABCDEF':
-                                    raise QAPIParseError(self,
-                                                         '\\u escape nee=
ds 4 '
-                                                         'hex digits')
-                                value =3D (value << 4) + int(ch, 16)
-                            # If Python 2 and 3 didn't disagree so much =
on
-                            # how to handle Unicode, then we could allow
-                            # Unicode string defaults.  But most of QAPI=
 is
-                            # ASCII-only, so we aren't losing much for n=
ow.
-                            if not value or value > 0x7f:
-                                raise QAPIParseError(self,
-                                                     'For now, \\u escap=
e '
-                                                     'only supports non-=
zero '
-                                                     'values up to \\u00=
7f')
-                            ch =3D chr(value)
-                        elif ch not in '\\/\'"':
+                        # Note: we recognize only \\ because we have
+                        # no use for funny characters in strings
+                        if ch !=3D '\\':
                             raise QAPIParseError(self,
                                                  "Unknown escape \\%s" %=
 ch)
                         esc =3D False
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 17c53bed52..023a4e4789 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -375,9 +375,6 @@ qapi-schema +=3D enum-int-member.json
 qapi-schema +=3D enum-member-case.json
 qapi-schema +=3D enum-missing-data.json
 qapi-schema +=3D enum-wrong-data.json
-qapi-schema +=3D escape-outside-string.json
-qapi-schema +=3D escape-too-big.json
-qapi-schema +=3D escape-too-short.json
 qapi-schema +=3D event-boxed-empty.json
 qapi-schema +=3D event-case.json
 qapi-schema +=3D event-member-invalid-dict.json
diff --git a/tests/qapi-schema/escape-outside-string.err b/tests/qapi-sch=
ema/escape-outside-string.err
deleted file mode 100644
index b9b8837fd2..0000000000
--- a/tests/qapi-schema/escape-outside-string.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/escape-outside-string.json:3:27: Stray "\"
diff --git a/tests/qapi-schema/escape-outside-string.exit b/tests/qapi-sc=
hema/escape-outside-string.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/escape-outside-string.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/escape-outside-string.json b/tests/qapi-sc=
hema/escape-outside-string.json
deleted file mode 100644
index 482f79554b..0000000000
--- a/tests/qapi-schema/escape-outside-string.json
+++ /dev/null
@@ -1,3 +0,0 @@
-# escape sequences are permitted only inside strings
-# { 'command': 'foo', 'data': {} }
-{ 'command': 'foo', 'data'\u003a{} }
diff --git a/tests/qapi-schema/escape-outside-string.out b/tests/qapi-sch=
ema/escape-outside-string.out
deleted file mode 100644
index e69de29bb2..0000000000
diff --git a/tests/qapi-schema/escape-too-big.err b/tests/qapi-schema/esc=
ape-too-big.err
deleted file mode 100644
index d9aeb5dc38..0000000000
--- a/tests/qapi-schema/escape-too-big.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/escape-too-big.json:3:14: For now, \u escape only supp=
orts non-zero values up to \u007f
diff --git a/tests/qapi-schema/escape-too-big.exit b/tests/qapi-schema/es=
cape-too-big.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/escape-too-big.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/escape-too-big.json b/tests/qapi-schema/es=
cape-too-big.json
deleted file mode 100644
index 62bcecd557..0000000000
--- a/tests/qapi-schema/escape-too-big.json
+++ /dev/null
@@ -1,3 +0,0 @@
-# we don't support full Unicode strings, yet
-# { 'command': '=C3=A9' }
-{ 'command': '\u00e9' }
diff --git a/tests/qapi-schema/escape-too-big.out b/tests/qapi-schema/esc=
ape-too-big.out
deleted file mode 100644
index e69de29bb2..0000000000
diff --git a/tests/qapi-schema/escape-too-short.err b/tests/qapi-schema/e=
scape-too-short.err
deleted file mode 100644
index 934de598ee..0000000000
--- a/tests/qapi-schema/escape-too-short.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/escape-too-short.json:3:14: \u escape needs 4 hex digi=
ts
diff --git a/tests/qapi-schema/escape-too-short.exit b/tests/qapi-schema/=
escape-too-short.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/escape-too-short.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/escape-too-short.json b/tests/qapi-schema/=
escape-too-short.json
deleted file mode 100644
index 6cb1dec8f7..0000000000
--- a/tests/qapi-schema/escape-too-short.json
+++ /dev/null
@@ -1,3 +0,0 @@
-# the \u escape requires 4 hex digits
-# { 'command': 'a' }
-{ 'command': '\u61' }
diff --git a/tests/qapi-schema/escape-too-short.out b/tests/qapi-schema/e=
scape-too-short.out
deleted file mode 100644
index e69de29bb2..0000000000
diff --git a/tests/qapi-schema/ident-with-escape.err b/tests/qapi-schema/=
ident-with-escape.err
index e69de29bb2..5517dcb4b1 100644
--- a/tests/qapi-schema/ident-with-escape.err
+++ b/tests/qapi-schema/ident-with-escape.err
@@ -0,0 +1 @@
+tests/qapi-schema/ident-with-escape.json:3:3: Unknown escape \u
diff --git a/tests/qapi-schema/ident-with-escape.exit b/tests/qapi-schema=
/ident-with-escape.exit
index 573541ac97..d00491fd7e 100644
--- a/tests/qapi-schema/ident-with-escape.exit
+++ b/tests/qapi-schema/ident-with-escape.exit
@@ -1 +1 @@
-0
+1
diff --git a/tests/qapi-schema/ident-with-escape.json b/tests/qapi-schema=
/ident-with-escape.json
index 56617501e7..76b4503d95 100644
--- a/tests/qapi-schema/ident-with-escape.json
+++ b/tests/qapi-schema/ident-with-escape.json
@@ -1,4 +1,4 @@
-# we allow escape sequences in strings, if they map back to ASCII
+# we don't recognize any \ escapes other than \\ (tested elsewhere)
 # { 'command': 'fooA', 'data': { 'bar1': 'str' } }
 { 'c\u006fmmand': '\u0066\u006f\u006FA',
   'd\u0061ta': { '\u0062\u0061\u00721': '\u0073\u0074\u0072' } }
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/=
ident-with-escape.out
index 39754eba8c..e69de29bb2 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -1,16 +0,0 @@
-module None
-object q_empty
-enum QType
-    prefix QTYPE
-    member none
-    member qnull
-    member qnum
-    member qstring
-    member qdict
-    member qlist
-    member qbool
-module ident-with-escape.json
-object q_obj_fooA-arg
-    member bar1: str optional=3DFalse
-command fooA q_obj_fooA-arg -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
diff --git a/tests/qapi-schema/unknown-escape.json b/tests/qapi-schema/un=
known-escape.json
index 8e6891e52a..8372e8024f 100644
--- a/tests/qapi-schema/unknown-escape.json
+++ b/tests/qapi-schema/unknown-escape.json
@@ -1,3 +1,3 @@
-# we only recognize JSON escape sequences, plus our \' extension (no \x)
+# we only recognize \\
 # { 'command': 'foo', 'data': {} }
 { 'command': 'foo', 'dat\x61':{} }
--=20
2.21.0


