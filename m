Received: from eggs.gnu.org ([2001:4830:134:3::10]:55065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9J3-0007nS-Ek
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9J0-0006nJ-6y
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Iz-0006mn-TR
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:18 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:32 +0200
Message-Id: <20170822132255.23945-32-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 31/54] tests: add some enum members tests
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
 tests/Makefile.include                          | 2 ++
 tests/qapi-schema/enum-dict-member-invalid.err  | 1 +
 tests/qapi-schema/enum-dict-member-invalid.exit | 1 +
 tests/qapi-schema/enum-dict-member-invalid.json | 2 ++
 tests/qapi-schema/enum-dict-member-invalid.out  | 0
 tests/qapi-schema/enum-if-invalid.err           | 1 +
 tests/qapi-schema/enum-if-invalid.exit          | 1 +
 tests/qapi-schema/enum-if-invalid.json          | 3 +++
 tests/qapi-schema/enum-if-invalid.out           | 0
 9 files changed, 11 insertions(+)
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid.err
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid.exit
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid.json
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid.out
 create mode 100644 tests/qapi-schema/enum-if-invalid.err
 create mode 100644 tests/qapi-schema/enum-if-invalid.exit
 create mode 100644 tests/qapi-schema/enum-if-invalid.json
 create mode 100644 tests/qapi-schema/enum-if-invalid.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1f1d8f075b..1c5ce6519e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -436,6 +436,8 @@ qapi-schema +=3D enum-bad-name.json
 qapi-schema +=3D enum-bad-prefix.json
 qapi-schema +=3D enum-clash-member.json
 qapi-schema +=3D enum-dict-member.json
+qapi-schema +=3D enum-dict-member-invalid.json
+qapi-schema +=3D enum-if-invalid.json
 qapi-schema +=3D enum-int-member.json
 qapi-schema +=3D enum-member-case.json
 qapi-schema +=3D enum-missing-data.json
diff --git a/tests/qapi-schema/enum-dict-member-invalid.err b/tests/qapi-=
schema/enum-dict-member-invalid.err
new file mode 100644
index 0000000000..d12cca0df3
--- /dev/null
+++ b/tests/qapi-schema/enum-dict-member-invalid.err
@@ -0,0 +1 @@
+tests/qapi-schema/enum-dict-member-invalid.json:2: Dictionary member of =
enum 'MyEnum' must have a 'name' key
diff --git a/tests/qapi-schema/enum-dict-member-invalid.exit b/tests/qapi=
-schema/enum-dict-member-invalid.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/enum-dict-member-invalid.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/enum-dict-member-invalid.json b/tests/qapi=
-schema/enum-dict-member-invalid.json
new file mode 100644
index 0000000000..9cf8406867
--- /dev/null
+++ b/tests/qapi-schema/enum-dict-member-invalid.json
@@ -0,0 +1,2 @@
+# we reject any enum member that is not a string or a dict with 'name'
+{ 'enum': 'MyEnum', 'data': [ { 'value': 'str' } ] }
diff --git a/tests/qapi-schema/enum-dict-member-invalid.out b/tests/qapi-=
schema/enum-dict-member-invalid.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/enum-if-invalid.err b/tests/qapi-schema/en=
um-if-invalid.err
new file mode 100644
index 0000000000..236b703e88
--- /dev/null
+++ b/tests/qapi-schema/enum-if-invalid.err
@@ -0,0 +1 @@
+tests/qapi-schema/enum-if-invalid.json:2: 'if' condition requires a stri=
ng or a list of string
diff --git a/tests/qapi-schema/enum-if-invalid.exit b/tests/qapi-schema/e=
num-if-invalid.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/enum-if-invalid.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/enum-if-invalid.json b/tests/qapi-schema/e=
num-if-invalid.json
new file mode 100644
index 0000000000..60bd0ef1d7
--- /dev/null
+++ b/tests/qapi-schema/enum-if-invalid.json
@@ -0,0 +1,3 @@
+# check invalid 'if' type
+{ 'enum': 'TestIfEnum', 'data':
+  [ 'foo', { 'name' : 'bar', 'if': { 'val': 'foo' } } ] }
diff --git a/tests/qapi-schema/enum-if-invalid.out b/tests/qapi-schema/en=
um-if-invalid.out
new file mode 100644
index 0000000000..e69de29bb2
--=20
2.14.1.146.gd35faa819
