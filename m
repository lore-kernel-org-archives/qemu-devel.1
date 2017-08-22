Received: from eggs.gnu.org ([2001:4830:134:3::10]:55180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JL-000820-B4
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JI-0006xc-59
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9JH-0006wj-T3
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:36 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:34 +0200
Message-Id: <20170822132255.23945-34-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 33/54] qapi: add some struct member tests
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
 tests/Makefile.include                    | 2 ++
 tests/qapi-schema/struct-if-invalid.err   | 1 +
 tests/qapi-schema/struct-if-invalid.exit  | 1 +
 tests/qapi-schema/struct-if-invalid.json  | 3 +++
 tests/qapi-schema/struct-if-invalid.out   | 0
 tests/qapi-schema/struct-member-type.err  | 0
 tests/qapi-schema/struct-member-type.exit | 1 +
 tests/qapi-schema/struct-member-type.json | 1 +
 tests/qapi-schema/struct-member-type.out  | 5 +++++
 9 files changed, 14 insertions(+)
 create mode 100644 tests/qapi-schema/struct-if-invalid.err
 create mode 100644 tests/qapi-schema/struct-if-invalid.exit
 create mode 100644 tests/qapi-schema/struct-if-invalid.json
 create mode 100644 tests/qapi-schema/struct-if-invalid.out
 create mode 100644 tests/qapi-schema/struct-member-type.err
 create mode 100644 tests/qapi-schema/struct-member-type.exit
 create mode 100644 tests/qapi-schema/struct-member-type.json
 create mode 100644 tests/qapi-schema/struct-member-type.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1c5ce6519e..e00cb9833b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -512,7 +512,9 @@ qapi-schema +=3D returns-whitelist.json
 qapi-schema +=3D struct-base-clash-deep.json
 qapi-schema +=3D struct-base-clash.json
 qapi-schema +=3D struct-data-invalid.json
+qapi-schema +=3D struct-if-invalid.json
 qapi-schema +=3D struct-member-invalid.json
+qapi-schema +=3D struct-member-type.json
 qapi-schema +=3D trailing-comma-list.json
 qapi-schema +=3D trailing-comma-object.json
 qapi-schema +=3D type-bypass-bad-gen.json
diff --git a/tests/qapi-schema/struct-if-invalid.err b/tests/qapi-schema/=
struct-if-invalid.err
new file mode 100644
index 0000000000..42245262a9
--- /dev/null
+++ b/tests/qapi-schema/struct-if-invalid.err
@@ -0,0 +1 @@
+tests/qapi-schema/struct-if-invalid.json:2: Member 'bar' of 'data' for s=
truct 'TestIfStruct' should be a type name
diff --git a/tests/qapi-schema/struct-if-invalid.exit b/tests/qapi-schema=
/struct-if-invalid.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/struct-if-invalid.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/struct-if-invalid.json b/tests/qapi-schema=
/struct-if-invalid.json
new file mode 100644
index 0000000000..466cdb61e1
--- /dev/null
+++ b/tests/qapi-schema/struct-if-invalid.json
@@ -0,0 +1,3 @@
+# check missing 'type'
+{ 'struct': 'TestIfStruct', 'data':
+  { 'foo': 'int', 'bar': { 'if': 'defined(TEST_IF_STRUCT_BAR)' } } }
diff --git a/tests/qapi-schema/struct-if-invalid.out b/tests/qapi-schema/=
struct-if-invalid.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-type.err b/tests/qapi-schema=
/struct-member-type.err
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/struct-member-type.exit b/tests/qapi-schem=
a/struct-member-type.exit
new file mode 100644
index 0000000000..573541ac97
--- /dev/null
+++ b/tests/qapi-schema/struct-member-type.exit
@@ -0,0 +1 @@
+0
diff --git a/tests/qapi-schema/struct-member-type.json b/tests/qapi-schem=
a/struct-member-type.json
new file mode 100644
index 0000000000..07de38fa4a
--- /dev/null
+++ b/tests/qapi-schema/struct-member-type.json
@@ -0,0 +1 @@
+{ 'struct': 'foo', 'data': { 'a': { 'type': 'str' } } }
diff --git a/tests/qapi-schema/struct-member-type.out b/tests/qapi-schema=
/struct-member-type.out
new file mode 100644
index 0000000000..2ea68909a9
--- /dev/null
+++ b/tests/qapi-schema/struct-member-type.out
@@ -0,0 +1,5 @@
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+    prefix QTYPE
+object foo
+    member a: str optional=3DFalse
+object q_empty
--=20
2.14.1.146.gd35faa819
