Received: from eggs.gnu.org ([2001:4830:134:3::10]:43366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMZ9-000606-J3
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMZ5-0006r6-Cx
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMZ5-0006pp-7a
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:43 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:06:02 +0200
Message-Id: <20170911110623.24981-30-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 29/50] qapi: add tests for invalid alternate
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
index 44a3d8895e..4af0b0c2eb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -380,6 +380,7 @@ qapi-schema +=3D alternate-conflict-enum-int.json
 qapi-schema +=3D alternate-conflict-string.json
 qapi-schema +=3D alternate-conflict-bool-string.json
 qapi-schema +=3D alternate-conflict-num-string.json
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
