Received: from eggs.gnu.org ([209.51.188.92]:55459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVO2-0007ND-Te
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVO1-0000VR-9V
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  8 Apr 2019 16:35:42 +0200
Message-Id: <20190408143543.3982-4-kwolf@redhat.com>
In-Reply-To: <20190408143543.3982-1-kwolf@redhat.com>
References: <20190408143543.3982-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] tests/qapi-schema: Error case tests for
 features in structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qapi-schema/features-bad-type.json      | 3 +++
 tests/qapi-schema/features-missing-name.json  | 3 +++
 tests/qapi-schema/features-name-bad-type.json | 3 +++
 tests/qapi-schema/features-no-list.json       | 3 +++
 tests/qapi-schema/features-unknown-key.json   | 3 +++
 tests/Makefile.include                        | 5 +++++
 tests/qapi-schema/features-bad-type.err       | 1 +
 tests/qapi-schema/features-bad-type.exit      | 1 +
 tests/qapi-schema/features-bad-type.out       | 0
 tests/qapi-schema/features-missing-name.err   | 1 +
 tests/qapi-schema/features-missing-name.exit  | 1 +
 tests/qapi-schema/features-missing-name.out   | 0
 tests/qapi-schema/features-name-bad-type.err  | 1 +
 tests/qapi-schema/features-name-bad-type.exit | 1 +
 tests/qapi-schema/features-name-bad-type.out  | 0
 tests/qapi-schema/features-no-list.err        | 1 +
 tests/qapi-schema/features-no-list.exit       | 1 +
 tests/qapi-schema/features-no-list.out        | 0
 tests/qapi-schema/features-unknown-key.err    | 2 ++
 tests/qapi-schema/features-unknown-key.exit   | 1 +
 tests/qapi-schema/features-unknown-key.out    | 0
 21 files changed, 31 insertions(+)
 create mode 100644 tests/qapi-schema/features-bad-type.json
 create mode 100644 tests/qapi-schema/features-missing-name.json
 create mode 100644 tests/qapi-schema/features-name-bad-type.json
 create mode 100644 tests/qapi-schema/features-no-list.json
 create mode 100644 tests/qapi-schema/features-unknown-key.json
 create mode 100644 tests/qapi-schema/features-bad-type.err
 create mode 100644 tests/qapi-schema/features-bad-type.exit
 create mode 100644 tests/qapi-schema/features-bad-type.out
 create mode 100644 tests/qapi-schema/features-missing-name.err
 create mode 100644 tests/qapi-schema/features-missing-name.exit
 create mode 100644 tests/qapi-schema/features-missing-name.out
 create mode 100644 tests/qapi-schema/features-name-bad-type.err
 create mode 100644 tests/qapi-schema/features-name-bad-type.exit
 create mode 100644 tests/qapi-schema/features-name-bad-type.out
 create mode 100644 tests/qapi-schema/features-no-list.err
 create mode 100644 tests/qapi-schema/features-no-list.exit
 create mode 100644 tests/qapi-schema/features-no-list.out
 create mode 100644 tests/qapi-schema/features-unknown-key.err
 create mode 100644 tests/qapi-schema/features-unknown-key.exit
 create mode 100644 tests/qapi-schema/features-unknown-key.out

diff --git a/tests/qapi-schema/features-bad-type.json b/tests/qapi-schema=
/features-bad-type.json
new file mode 100644
index 0000000000..57db5540e7
--- /dev/null
+++ b/tests/qapi-schema/features-bad-type.json
@@ -0,0 +1,3 @@
+{ 'struct': 'FeatureStruct0',
+  'data': { 'foo': 'int' },
+  'features': [ [ 'a feature cannot be an array' ] ] }
diff --git a/tests/qapi-schema/features-missing-name.json b/tests/qapi-sc=
hema/features-missing-name.json
new file mode 100644
index 0000000000..2314f97c00
--- /dev/null
+++ b/tests/qapi-schema/features-missing-name.json
@@ -0,0 +1,3 @@
+{ 'struct': 'FeatureStruct0',
+  'data': { 'foo': 'int' },
+  'features': [ { 'if': 'defined(NAMELESS_FEATURES)' } ] }
diff --git a/tests/qapi-schema/features-name-bad-type.json b/tests/qapi-s=
chema/features-name-bad-type.json
new file mode 100644
index 0000000000..b07139978a
--- /dev/null
+++ b/tests/qapi-schema/features-name-bad-type.json
@@ -0,0 +1,3 @@
+{ 'struct': 'FeatureStruct0',
+  'data': { 'foo': 'int' },
+  'features': [ { 'name': { 'feature-type': 'object' } } ] }
diff --git a/tests/qapi-schema/features-no-list.json b/tests/qapi-schema/=
features-no-list.json
new file mode 100644
index 0000000000..9484fd94fc
--- /dev/null
+++ b/tests/qapi-schema/features-no-list.json
@@ -0,0 +1,3 @@
+{ 'struct': 'FeatureStruct0',
+  'data': { 'foo': 'int' },
+  'features': 'bar' }
diff --git a/tests/qapi-schema/features-unknown-key.json b/tests/qapi-sch=
ema/features-unknown-key.json
new file mode 100644
index 0000000000..134df3b503
--- /dev/null
+++ b/tests/qapi-schema/features-unknown-key.json
@@ -0,0 +1,3 @@
+{ 'struct': 'FeatureStruct0',
+  'data': { 'foo': 'int' },
+  'features': [ { 'name': 'bar', 'colour': 'red' } ] }
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6b904d7430..d116ad770c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -377,6 +377,11 @@ qapi-schema +=3D event-boxed-empty.json
 qapi-schema +=3D event-case.json
 qapi-schema +=3D event-member-invalid-dict.json
 qapi-schema +=3D event-nest-struct.json
+qapi-schema +=3D features-bad-type.json
+qapi-schema +=3D features-missing-name.json
+qapi-schema +=3D features-name-bad-type.json
+qapi-schema +=3D features-no-list.json
+qapi-schema +=3D features-unknown-key.json
 qapi-schema +=3D flat-union-array-branch.json
 qapi-schema +=3D flat-union-bad-base.json
 qapi-schema +=3D flat-union-bad-discriminator.json
diff --git a/tests/qapi-schema/features-bad-type.err b/tests/qapi-schema/=
features-bad-type.err
new file mode 100644
index 0000000000..7ca7a08ab0
--- /dev/null
+++ b/tests/qapi-schema/features-bad-type.err
@@ -0,0 +1 @@
+tests/qapi-schema/features-bad-type.json:1: Feature names for struct 'Fe=
atureStruct0' must be strings
diff --git a/tests/qapi-schema/features-bad-type.exit b/tests/qapi-schema=
/features-bad-type.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/features-bad-type.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/features-bad-type.out b/tests/qapi-schema/=
features-bad-type.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/features-missing-name.err b/tests/qapi-sch=
ema/features-missing-name.err
new file mode 100644
index 0000000000..4f1d2715aa
--- /dev/null
+++ b/tests/qapi-schema/features-missing-name.err
@@ -0,0 +1 @@
+tests/qapi-schema/features-missing-name.json:1: Key 'name' is missing fr=
om feature of struct FeatureStruct0
diff --git a/tests/qapi-schema/features-missing-name.exit b/tests/qapi-sc=
hema/features-missing-name.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/features-missing-name.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/features-missing-name.out b/tests/qapi-sch=
ema/features-missing-name.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/features-name-bad-type.err b/tests/qapi-sc=
hema/features-name-bad-type.err
new file mode 100644
index 0000000000..8a68d7cb73
--- /dev/null
+++ b/tests/qapi-schema/features-name-bad-type.err
@@ -0,0 +1 @@
+tests/qapi-schema/features-name-bad-type.json:1: Feature names for struc=
t 'FeatureStruct0' must be strings
diff --git a/tests/qapi-schema/features-name-bad-type.exit b/tests/qapi-s=
chema/features-name-bad-type.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/features-name-bad-type.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/features-name-bad-type.out b/tests/qapi-sc=
hema/features-name-bad-type.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/features-no-list.err b/tests/qapi-schema/f=
eatures-no-list.err
new file mode 100644
index 0000000000..61ed68612b
--- /dev/null
+++ b/tests/qapi-schema/features-no-list.err
@@ -0,0 +1 @@
+tests/qapi-schema/features-no-list.json:1: Struct 'FeatureStruct0' requi=
res an array for 'features'
diff --git a/tests/qapi-schema/features-no-list.exit b/tests/qapi-schema/=
features-no-list.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/features-no-list.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/features-no-list.out b/tests/qapi-schema/f=
eatures-no-list.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/features-unknown-key.err b/tests/qapi-sche=
ma/features-unknown-key.err
new file mode 100644
index 0000000000..a1d693030d
--- /dev/null
+++ b/tests/qapi-schema/features-unknown-key.err
@@ -0,0 +1,2 @@
+tests/qapi-schema/features-unknown-key.json:1: Unknown key 'colour' in f=
eature of struct FeatureStruct0
+Valid keys are 'if', 'name'.
diff --git a/tests/qapi-schema/features-unknown-key.exit b/tests/qapi-sch=
ema/features-unknown-key.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/features-unknown-key.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/features-unknown-key.out b/tests/qapi-sche=
ma/features-unknown-key.out
new file mode 100644
index 0000000000..e69de29bb2
--=20
2.20.1
