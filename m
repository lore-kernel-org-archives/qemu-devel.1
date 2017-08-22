Received: from eggs.gnu.org ([2001:4830:134:3::10]:54904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9I6-0006yD-3w
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Hy-0006G0-Dx
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Hy-0006Ez-7D
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:14 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:39 +0200
Message-Id: <20170822132255.23945-39-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 38/54] qapi: add tests for invalid alternate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/Makefile.include                        | 1 +
 tests/qapi-schema/alternate-dict-invalid.err  | 1 +
 tests/qapi-schema/alternate-dict-invalid.exit | 1 +
 tests/qapi-schema/alternate-dict-invalid.json | 4 ++++
 tests/qapi-schema/alternate-dict-invalid.out  | 0
 5 files changed, 7 insertions(+)
 create mode 100644 tests/qapi-schema/alternate-dict-invalid.err
 create mode 100644 tests/qapi-schema/alternate-dict-invalid.exit
 create mode 100644 tests/qapi-schema/alternate-dict-invalid.json
 create mode 100644 tests/qapi-schema/alternate-dict-invalid.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e00cb9833b..316d81fa95 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -374,6 +374,7 @@ qapi-schema +=3D alternate-conflict-dict.json
 qapi-schema +=3D alternate-conflict-enum-bool.json
 qapi-schema +=3D alternate-conflict-enum-int.json
 qapi-schema +=3D alternate-conflict-string.json
+qapi-schema +=3D alternate-dict-invalid.json
 qapi-schema +=3D alternate-empty.json
 qapi-schema +=3D alternate-nested.json
 qapi-schema +=3D alternate-unknown.json
diff --git a/tests/qapi-schema/alternate-dict-invalid.err b/tests/qapi-sc=
hema/alternate-dict-invalid.err
new file mode 100644
index 0000000000..707c40f0f6
--- /dev/null
+++ b/tests/qapi-schema/alternate-dict-invalid.err
@@ -0,0 +1 @@
+tests/qapi-schema/alternate-dict-invalid.json:2: Member 'two' of alterna=
te 'Alt' should be a type name
diff --git a/tests/qapi-schema/alternate-dict-invalid.exit b/tests/qapi-s=
chema/alternate-dict-invalid.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/alternate-dict-invalid.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/alternate-dict-invalid.json b/tests/qapi-s=
chema/alternate-dict-invalid.json
new file mode 100644
index 0000000000..45f2c8ebef
--- /dev/null
+++ b/tests/qapi-schema/alternate-dict-invalid.json
@@ -0,0 +1,4 @@
+# invalid field dictionnary, missing type
+{ 'alternate': 'Alt',
+  'data': { 'one': 'str',
+            'two': { 'if': 'foo' } } }
diff --git a/tests/qapi-schema/alternate-dict-invalid.out b/tests/qapi-sc=
hema/alternate-dict-invalid.out
new file mode 100644
index 0000000000..e69de29bb2
--=20
2.14.1.146.gd35faa819
