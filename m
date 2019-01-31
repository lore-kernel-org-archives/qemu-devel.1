Received: from eggs.gnu.org ([209.51.188.92]:50408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gp248-0007rE-S2
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 21:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gp247-0005pA-Qm
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 21:26:56 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 30 Jan 2019 21:26:48 -0500
Message-Id: <20190131022648.14264-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests/236: fix transaction kwarg order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

It's not enough to order the kwargs for consistent QMP log output,
we must also sort any sub-dictionaries in lists that appear as values.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
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
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index cbedfaf1df..76ad52b358 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -76,15 +76,16 @@ def qemu_img(*args):
         sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode, ' '.join(qemu_img_args + list(args))))
     return exitcode
 
-def ordered_kwargs(kwargs):
-    # kwargs prior to 3.6 are not ordered, so:
-    od = OrderedDict()
-    for k, v in sorted(kwargs.items()):
-        if isinstance(v, dict):
-            od[k] = ordered_kwargs(v)
-        else:
-            od[k] = v
-    return od
+def ordered_qmp(qmsg):
+    # Dictionaries are not ordered prior to 3.6, therefore:
+    if isinstance(qmsg, list):
+        return [ordered_qmp(atom) for atom in qmsg]
+    if isinstance(qmsg, dict):
+        od = OrderedDict()
+        for k, v in sorted(qmsg.items()):
+            od[k] = ordered_qmp(v)
+        return od
+    return qmsg
 
 def qemu_img_create(*args):
     args = list(args)
@@ -491,7 +492,7 @@ class VM(qtest.QEMUQtestMachine):
     def qmp_log(self, cmd, filters=[], indent=None, **kwargs):
         full_cmd = OrderedDict((
             ("execute", cmd),
-            ("arguments", ordered_kwargs(kwargs))
+            ("arguments", ordered_qmp(kwargs))
         ))
         log(full_cmd, filters, indent=indent)
         result = self.qmp(cmd, **kwargs)
-- 
2.17.2
