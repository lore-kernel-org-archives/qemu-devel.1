Received: from eggs.gnu.org ([209.51.188.92]:39115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbo5-0007nH-Rw
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbo3-0008WI-Lk
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:45 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:35:14 +0100
Message-Id: <20190201163518.31157-24-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/27] iotests/236: fix transaction kwarg order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

It's not enough to order the kwargs for consistent QMP log output,
we must also sort any sub-dictionaries in lists that appear as values.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/236.out    | 56 +++++++++++++++++------------------
 tests/qemu-iotests/iotests.py | 21 ++++++-------
 2 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/tests/qemu-iotests/236.out b/tests/qemu-iotests/236.out
index 1dad24db0d..bb2d71ea5e 100644
--- a/tests/qemu-iotests/236.out
+++ b/tests/qemu-iotests/236.out
@@ -45,23 +45,23 @@ write -P0xcd 0x3ff0000 64k
     "actions": [
       {
         "data": {
-          "node": "drive0",
-          "name": "bitmapB"
+          "name": "bitmapB",
+          "node": "drive0"
         },
         "type": "block-dirty-bitmap-disable"
       },
       {
         "data": {
-          "node": "drive0",
+          "granularity": 65536,
           "name": "bitmapC",
-          "granularity": 65536
+          "node": "drive0"
         },
         "type": "block-dirty-bitmap-add"
       },
       {
         "data": {
-          "node": "drive0",
-          "name": "bitmapA"
+          "name": "bitmapA",
+          "node": "drive0"
         },
         "type": "block-dirty-bitmap-clear"
       },
@@ -105,30 +105,30 @@ write -P0xcd 0x3ff0000 64k
     "actions": [
       {
         "data": {
-          "node": "drive0",
-          "name": "bitmapB"
+          "name": "bitmapB",
+          "node": "drive0"
         },
         "type": "block-dirty-bitmap-disable"
       },
       {
         "data": {
-          "node": "drive0",
+          "granularity": 65536,
           "name": "bitmapC",
-          "granularity": 65536
+          "node": "drive0"
         },
         "type": "block-dirty-bitmap-add"
       },
       {
         "data": {
-          "node": "drive0",
-          "name": "bitmapC"
+          "name": "bitmapC",
+          "node": "drive0"
         },
         "type": "block-dirty-bitmap-disable"
       },
       {
         "data": {
-          "node": "drive0",
-          "name": "bitmapC"
+          "name": "bitmapC",
+          "node": "drive0"
         },
         "type": "block-dirty-bitmap-enable"
       }
@@ -158,15 +158,15 @@ write -P0xea 0x3fe0000 64k
     "actions": [
       {
         "data": {
-          "node": "drive0",
-          "name": "bitmapA"
+          "name": "bitmapA",
+          "node": "drive0"
         },
         "type": "block-dirty-bitmap-disable"
       },
       {
         "data": {
-          "node": "drive0",
-          "name": "bitmapC"
+          "name": "bitmapC",
+          "node": "drive0"
         },
         "type": "block-dirty-bitmap-disable"
       }
@@ -209,21 +209,21 @@ write -P0xea 0x3fe0000 64k
     "actions": [
       {
         "data": {
-          "node": "drive0",
           "disabled": true,
+          "granularity": 65536,
           "name": "bitmapD",
-          "granularity": 65536
+          "node": "drive0"
         },
         "type": "block-dirty-bitmap-add"
       },
       {
         "data": {
-          "node": "drive0",
-          "target": "bitmapD",
           "bitmaps": [
             "bitmapB",
             "bitmapC"
-          ]
+          ],
+          "node": "drive0",
+          "target": "bitmapD"
         },
         "type": "block-dirty-bitmap-merge"
       },
@@ -273,21 +273,21 @@ write -P0xea 0x3fe0000 64k
     "actions": [
       {
         "data": {
-          "node": "drive0",
           "disabled": true,
+          "granularity": 65536,
           "name": "bitmapD",
-          "granularity": 65536
+          "node": "drive0"
         },
         "type": "block-dirty-bitmap-add"
       },
       {
         "data": {
-          "node": "drive0",
-          "target": "bitmapD",
           "bitmaps": [
             "bitmapB",
             "bitmapC"
-          ]
+          ],
+          "node": "drive0",
+          "target": "bitmapD"
         },
         "type": "block-dirty-bitmap-merge"
       }
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 71214d46b5..b461f53abf 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -76,15 +76,16 @@ def qemu_img(*args):
         sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcod=
e, ' '.join(qemu_img_args + list(args))))
     return exitcode
=20
-def ordered_kwargs(kwargs):
-    # kwargs prior to 3.6 are not ordered, so:
-    od =3D OrderedDict()
-    for k, v in sorted(kwargs.items()):
-        if isinstance(v, dict):
-            od[k] =3D ordered_kwargs(v)
-        else:
-            od[k] =3D v
-    return od
+def ordered_qmp(qmsg):
+    # Dictionaries are not ordered prior to 3.6, therefore:
+    if isinstance(qmsg, list):
+        return [ordered_qmp(atom) for atom in qmsg]
+    if isinstance(qmsg, dict):
+        od =3D OrderedDict()
+        for k, v in sorted(qmsg.items()):
+            od[k] =3D ordered_qmp(v)
+        return od
+    return qmsg
=20
 def qemu_img_create(*args):
     args =3D list(args)
@@ -506,7 +507,7 @@ class VM(qtest.QEMUQtestMachine):
     def qmp_log(self, cmd, filters=3D[], indent=3DNone, **kwargs):
         full_cmd =3D OrderedDict((
             ("execute", cmd),
-            ("arguments", ordered_kwargs(kwargs))
+            ("arguments", ordered_qmp(kwargs))
         ))
         log(full_cmd, filters, indent=3Dindent)
         result =3D self.qmp(cmd, **kwargs)
--=20
2.20.1
