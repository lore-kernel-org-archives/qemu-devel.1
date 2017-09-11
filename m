Received: from eggs.gnu.org ([2001:4830:134:3::10]:42652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMY9-0004vh-P4
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMY5-00062w-QO
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMY5-00062j-HX
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:41 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:05:38 +0200
Message-Id: <20170911110623.24981-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 05/50] qapi: add tests for invalid 'if'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/Makefile.include                   | 3 +++
 tests/qapi-schema/bad-if-empty-list.err  | 1 +
 tests/qapi-schema/bad-if-empty-list.exit | 1 +
 tests/qapi-schema/bad-if-empty-list.json | 3 +++
 tests/qapi-schema/bad-if-empty-list.out  | 0
 tests/qapi-schema/bad-if-empty.err       | 1 +
 tests/qapi-schema/bad-if-empty.exit      | 1 +
 tests/qapi-schema/bad-if-empty.json      | 3 +++
 tests/qapi-schema/bad-if-empty.out       | 0
 tests/qapi-schema/bad-if.err             | 1 +
 tests/qapi-schema/bad-if.exit            | 1 +
 tests/qapi-schema/bad-if.json            | 3 +++
 tests/qapi-schema/bad-if.out             | 0
 13 files changed, 18 insertions(+)
 create mode 100644 tests/qapi-schema/bad-if-empty-list.err
 create mode 100644 tests/qapi-schema/bad-if-empty-list.exit
 create mode 100644 tests/qapi-schema/bad-if-empty-list.json
 create mode 100644 tests/qapi-schema/bad-if-empty-list.out
 create mode 100644 tests/qapi-schema/bad-if-empty.err
 create mode 100644 tests/qapi-schema/bad-if-empty.exit
 create mode 100644 tests/qapi-schema/bad-if-empty.json
 create mode 100644 tests/qapi-schema/bad-if-empty.out
 create mode 100644 tests/qapi-schema/bad-if.err
 create mode 100644 tests/qapi-schema/bad-if.exit
 create mode 100644 tests/qapi-schema/bad-if.json
 create mode 100644 tests/qapi-schema/bad-if.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index fae5715e9c..8dac7c9083 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -402,6 +402,9 @@ qapi-schema +=3D args-unknown.json
 qapi-schema +=3D bad-base.json
 qapi-schema +=3D bad-data.json
 qapi-schema +=3D bad-ident.json
+qapi-schema +=3D bad-if.json
+qapi-schema +=3D bad-if-empty.json
+qapi-schema +=3D bad-if-empty-list.json
 qapi-schema +=3D bad-type-bool.json
 qapi-schema +=3D bad-type-dict.json
 qapi-schema +=3D bad-type-int.json
diff --git a/tests/qapi-schema/bad-if-empty-list.err b/tests/qapi-schema/=
bad-if-empty-list.err
new file mode 100644
index 0000000000..75fe6497bc
--- /dev/null
+++ b/tests/qapi-schema/bad-if-empty-list.err
@@ -0,0 +1 @@
+tests/qapi-schema/bad-if-empty-list.json:2: 'if' condition [] is useless
diff --git a/tests/qapi-schema/bad-if-empty-list.exit b/tests/qapi-schema=
/bad-if-empty-list.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/bad-if-empty-list.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/bad-if-empty-list.json b/tests/qapi-schema=
/bad-if-empty-list.json
new file mode 100644
index 0000000000..94f2eb8670
--- /dev/null
+++ b/tests/qapi-schema/bad-if-empty-list.json
@@ -0,0 +1,3 @@
+# check empty 'if' list
+{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
+  'if': [] }
diff --git a/tests/qapi-schema/bad-if-empty-list.out b/tests/qapi-schema/=
bad-if-empty-list.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/bad-if-empty.err b/tests/qapi-schema/bad-i=
f-empty.err
new file mode 100644
index 0000000000..358bdc3e51
--- /dev/null
+++ b/tests/qapi-schema/bad-if-empty.err
@@ -0,0 +1 @@
+tests/qapi-schema/bad-if-empty.json:2: 'if' condition '' makes no sense
diff --git a/tests/qapi-schema/bad-if-empty.exit b/tests/qapi-schema/bad-=
if-empty.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/bad-if-empty.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/bad-if-empty.json b/tests/qapi-schema/bad-=
if-empty.json
new file mode 100644
index 0000000000..fe1dd4eca6
--- /dev/null
+++ b/tests/qapi-schema/bad-if-empty.json
@@ -0,0 +1,3 @@
+# check empty 'if'
+{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
+  'if': '' }
diff --git a/tests/qapi-schema/bad-if-empty.out b/tests/qapi-schema/bad-i=
f-empty.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/bad-if.err b/tests/qapi-schema/bad-if.err
new file mode 100644
index 0000000000..c2e3f5f44c
--- /dev/null
+++ b/tests/qapi-schema/bad-if.err
@@ -0,0 +1 @@
+tests/qapi-schema/bad-if.json:2: 'if' condition must be a string or a li=
st of strings
diff --git a/tests/qapi-schema/bad-if.exit b/tests/qapi-schema/bad-if.exi=
t
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/bad-if.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/bad-if.json b/tests/qapi-schema/bad-if.jso=
n
new file mode 100644
index 0000000000..3edd1a0bf2
--- /dev/null
+++ b/tests/qapi-schema/bad-if.json
@@ -0,0 +1,3 @@
+# check invalid 'if' type
+{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
+  'if': { 'value': 'defined(TEST_IF_STRUCT)' } }
diff --git a/tests/qapi-schema/bad-if.out b/tests/qapi-schema/bad-if.out
new file mode 100644
index 0000000000..e69de29bb2
--=20
2.14.1.146.gd35faa819
