Received: from eggs.gnu.org ([2001:4830:134:3::10]:55713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaX-0002AP-TE
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaT-000634-1B
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRjaS-00061X-Lz
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB159356D1
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 51A8A196AE
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 19:59:16 +0100
Message-Id: <20171220185924.32756-6-armbru@redhat.com>
In-Reply-To: <20171220185924.32756-1-armbru@redhat.com>
References: <20171220185924.32756-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/13] tests/qapi-schema/doc-bad-section: New,
 factored out of doc-good
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A negative test case crept into doc-good.json: invalid use of section
markup we currently fail to reject.  Move this into its own
doc-bad-section.json.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171002141341.24616-6-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/Makefile.include                 |  3 ++-
 tests/qapi-schema/doc-bad-section.err  |  0
 tests/qapi-schema/doc-bad-section.exit |  1 +
 tests/qapi-schema/doc-bad-section.json | 11 +++++++++++
 tests/qapi-schema/doc-bad-section.out  | 13 +++++++++++++
 tests/qapi-schema/doc-good.json        |  1 -
 tests/qapi-schema/doc-good.out         |  2 +-
 tests/qapi-schema/doc-good.texi        |  2 +-
 8 files changed, 29 insertions(+), 4 deletions(-)
 create mode 100644 tests/qapi-schema/doc-bad-section.err
 create mode 100644 tests/qapi-schema/doc-bad-section.exit
 create mode 100644 tests/qapi-schema/doc-bad-section.json
 create mode 100644 tests/qapi-schema/doc-bad-section.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b4bcc872f2..f8e20d9f5d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -416,6 +416,7 @@ qapi-schema +=3D command-int.json
 qapi-schema +=3D comments.json
 qapi-schema +=3D doc-bad-alternate-member.json
 qapi-schema +=3D doc-bad-command-arg.json
+qapi-schema +=3D doc-bad-section.json
 qapi-schema +=3D doc-bad-symbol.json
 qapi-schema +=3D doc-bad-union-member.json
 qapi-schema +=3D doc-before-include.json
@@ -433,10 +434,10 @@ qapi-schema +=3D doc-invalid-end2.json
 qapi-schema +=3D doc-invalid-return.json
 qapi-schema +=3D doc-invalid-section.json
 qapi-schema +=3D doc-invalid-start.json
-qapi-schema +=3D doc-missing.json
 qapi-schema +=3D doc-missing-colon.json
 qapi-schema +=3D doc-missing-expr.json
 qapi-schema +=3D doc-missing-space.json
+qapi-schema +=3D doc-missing.json
 qapi-schema +=3D doc-no-symbol.json
 qapi-schema +=3D double-data.json
 qapi-schema +=3D double-type.json
diff --git a/tests/qapi-schema/doc-bad-section.err b/tests/qapi-schema/do=
c-bad-section.err
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-bad-section.exit b/tests/qapi-schema/d=
oc-bad-section.exit
new file mode 100644
index 0000000000..573541ac97
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-section.exit
@@ -0,0 +1 @@
+0
diff --git a/tests/qapi-schema/doc-bad-section.json b/tests/qapi-schema/d=
oc-bad-section.json
new file mode 100644
index 0000000000..560df4b087
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-section.json
@@ -0,0 +1,11 @@
+# =3D section within an expression comment
+# BUG: not rejected
+
+##
+# @Enum:
+# =3D=3D Produces *invalid* texinfo
+# @one: The _one_ {and only}
+#
+# @two is undocumented
+##
+{ 'enum': 'Enum', 'data': [ 'one', 'two' ] }
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/do=
c-bad-section.out
new file mode 100644
index 0000000000..6fce84dd34
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -0,0 +1,13 @@
+enum Enum ['one', 'two']
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+    prefix QTYPE
+object q_empty
+doc symbol=3DEnum
+    body=3D
+=3D=3D Produces *invalid* texinfo
+    arg=3Done
+The _one_ {and only}
+    arg=3Dtwo
+
+    section=3D
+@two is undocumented
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
index cfdc0a8a81..97ab4625ff 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -51,7 +51,6 @@
=20
 ##
 # @Enum:
-# =3D=3D Produces *invalid* texinfo
 # @one: The _one_ {and only}
 #
 # @two is undocumented
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index 63ca25a8b9..c55e394e8a 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -77,7 +77,7 @@ Examples:
 - {braces}
 doc symbol=3DEnum
     body=3D
-=3D=3D Produces *invalid* texinfo
+
     arg=3Done
 The _one_ {and only}
     arg=3Dtwo
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
index c410626e4a..a331349756 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -76,7 +76,7 @@ Examples:
=20
 @deftp {Enum} Enum
=20
-@subsection Produces @strong{invalid} texinfo
+
=20
 @b{Values:}
 @table @asis
--=20
2.13.6
