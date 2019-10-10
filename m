Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05074C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC872064A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC872064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXTY-00026z-QJ
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWrG-0006qn-6L
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWrB-0008Gk-L9
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40682)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWr2-0008Bu-2s; Thu, 10 Oct 2019 07:43:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4DF1A315C03D;
 Thu, 10 Oct 2019 11:43:34 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A4605C231;
 Thu, 10 Oct 2019 11:43:32 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 14/36] iotests: prepare 124 and 257 bitmap querying for
 backup-top filter
Date: Thu, 10 Oct 2019 13:42:38 +0200
Message-Id: <20191010114300.7746-15-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 10 Oct 2019 11:43:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

After backup-top filter appearing it's not possible to see dirty
bitmaps in top node, so use node-name instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190920142056.12778-10-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/124        |  83 ++++----
 tests/qemu-iotests/257        |  49 ++---
 tests/qemu-iotests/257.out    | 364 +++++++++++++---------------------
 tests/qemu-iotests/iotests.py |  27 +++
 4 files changed, 219 insertions(+), 304 deletions(-)

diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index ca40ba3be2..d3e851e1ae 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -105,7 +105,7 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
         # Create a base image with a distinctive patterning
         drive0 =3D self.add_node('drive0')
         self.img_create(drive0['file'], drive0['fmt'])
-        self.vm.add_drive(drive0['file'])
+        self.vm.add_drive(drive0['file'], opts=3D'node-name=3Dnode0')
         self.write_default_pattern(drive0['file'])
         self.vm.launch()
=20
@@ -348,12 +348,14 @@ class TestIncrementalBackup(TestIncrementalBackupBa=
se):
                             ('0xfe', '16M', '256k'),
                             ('0x64', '32736k', '64k')))
         # Check the dirty bitmap stats
-        result =3D self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/name', 'bitm=
ap0')
-        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/count', 4587=
52)
-        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/granularity'=
, 65536)
-        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/status', 'ac=
tive')
-        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/persistent',=
 False)
+        self.assertTrue(self.vm.check_bitmap_status(
+            'node0', bitmap0.name, {
+                'name': 'bitmap0',
+                'count': 458752,
+                'granularity': 65536,
+                'status': 'active',
+                'persistent': False
+            }))
=20
         # Prepare a cluster_size=3D128k backup target without a backing =
file.
         (target, _) =3D bitmap0.new_target()
@@ -670,9 +672,8 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBa=
ckupBase):
         """
=20
         drive0 =3D self.drives[0]
-        # NB: The blkdebug script here looks for a "flush, read, read" p=
attern.
-        # The flush occurs in hmp_io_writes, the first read in device_ad=
d, and
-        # the last read during the block job.
+        # NB: The blkdebug script here looks for a "flush, read" pattern=
.
+        # The flush occurs in hmp_io_writes, and the read during the blo=
ck job.
         result =3D self.vm.qmp('blockdev-add',
                              node_name=3Ddrive0['id'],
                              driver=3Ddrive0['fmt'],
@@ -686,15 +687,11 @@ class TestIncrementalBackupBlkdebug(TestIncremental=
BackupBase):
                                      'event': 'flush_to_disk',
                                      'state': 1,
                                      'new_state': 2
-                                 },{
-                                     'event': 'read_aio',
-                                     'state': 2,
-                                     'new_state': 3
                                  }],
                                  'inject-error': [{
                                      'event': 'read_aio',
                                      'errno': 5,
-                                     'state': 3,
+                                     'state': 2,
                                      'immediately': False,
                                      'once': True
                                  }],
@@ -708,23 +705,15 @@ class TestIncrementalBackupBlkdebug(TestIncremental=
BackupBase):
                                           ('0xfe', '16M', '256k'),
                                           ('0x64', '32736k', '64k')))
=20
-        # For the purposes of query-block visibility of bitmaps, add a d=
rive
-        # frontend after we've written data; otherwise we can't use hmp-=
io
-        result =3D self.vm.qmp("device_add",
-                             id=3D"device0",
-                             drive=3Ddrive0['id'],
-                             driver=3D"virtio-blk")
-        self.assert_qmp(result, 'return', {})
-
         # Bitmap Status Check
-        query =3D self.vm.qmp('query-block')
-        ret =3D [bmap for bmap in query['return'][0]['dirty-bitmaps']
-               if bmap.get('name') =3D=3D bitmap.name][0]
-        self.assert_qmp(ret, 'count', 458752)
-        self.assert_qmp(ret, 'granularity', 65536)
-        self.assert_qmp(ret, 'status', 'active')
-        self.assert_qmp(ret, 'busy', False)
-        self.assert_qmp(ret, 'recording', True)
+        self.assertTrue(self.vm.check_bitmap_status(
+            drive0['id'], bitmap.name, {
+                'count': 458752,
+                'granularity': 65536,
+                'status': 'active',
+                'busy': False,
+                'recording': True
+            }))
=20
         # Start backup
         parent, _ =3D bitmap.last_target()
@@ -748,14 +737,14 @@ class TestIncrementalBackupBlkdebug(TestIncremental=
BackupBase):
                                         'operation': 'read'})
=20
         # Bitmap Status Check
-        query =3D self.vm.qmp('query-block')
-        ret =3D [bmap for bmap in query['return'][0]['dirty-bitmaps']
-               if bmap.get('name') =3D=3D bitmap.name][0]
-        self.assert_qmp(ret, 'count', 458752)
-        self.assert_qmp(ret, 'granularity', 65536)
-        self.assert_qmp(ret, 'status', 'frozen')
-        self.assert_qmp(ret, 'busy', True)
-        self.assert_qmp(ret, 'recording', True)
+        self.assertTrue(self.vm.check_bitmap_status(
+            drive0['id'], bitmap.name, {
+                'count': 458752,
+                'granularity': 65536,
+                'status': 'frozen',
+                'busy': True,
+                'recording': True
+            }))
=20
         # Resume and check incremental backup for consistency
         res =3D self.vm.qmp('block-job-resume', device=3Dbitmap.drive['i=
d'])
@@ -763,14 +752,14 @@ class TestIncrementalBackupBlkdebug(TestIncremental=
BackupBase):
         self.wait_qmp_backup(bitmap.drive['id'])
=20
         # Bitmap Status Check
-        query =3D self.vm.qmp('query-block')
-        ret =3D [bmap for bmap in query['return'][0]['dirty-bitmaps']
-               if bmap.get('name') =3D=3D bitmap.name][0]
-        self.assert_qmp(ret, 'count', 0)
-        self.assert_qmp(ret, 'granularity', 65536)
-        self.assert_qmp(ret, 'status', 'active')
-        self.assert_qmp(ret, 'busy', False)
-        self.assert_qmp(ret, 'recording', True)
+        self.assertTrue(self.vm.check_bitmap_status(
+            drive0['id'], bitmap.name, {
+                'count': 0,
+                'granularity': 65536,
+                'status': 'active',
+                'busy': False,
+                'recording': True
+            }))
=20
         # Finalize / Cleanup
         self.make_reference_backup(bitmap)
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 4a636d8ab2..6b368e1e70 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -188,25 +188,6 @@ class Drive:
         self.size =3D size
         self.node =3D name
=20
-def query_bitmaps(vm):
-    res =3D vm.qmp("query-block")
-    return {"bitmaps": {device['device'] or device['qdev']:
-                        device.get('dirty-bitmaps', []) for
-                        device in res['return']}}
-
-def get_bitmap(bitmaps, drivename, name, recording=3DNone):
-    """
-    get a specific bitmap from the object returned by query_bitmaps.
-    :param recording: If specified, filter results by the specified valu=
e.
-    """
-    for bitmap in bitmaps['bitmaps'][drivename]:
-        if bitmap.get('name', '') =3D=3D name:
-            if recording is None:
-                return bitmap
-            elif bitmap.get('recording') =3D=3D recording:
-                return bitmap
-    return None
-
 def blockdev_backup(vm, device, target, sync, **kwargs):
     # Strip any arguments explicitly nulled by the caller:
     kwargs =3D {key: val for key, val in kwargs.items() if val is not No=
ne}
@@ -249,8 +230,8 @@ def perform_writes(drive, n):
             pattern.size)
         log(cmd)
         log(drive.vm.hmp_qemu_io(drive.name, cmd))
-    bitmaps =3D query_bitmaps(drive.vm)
-    log(bitmaps, indent=3D2)
+    bitmaps =3D drive.vm.query_bitmaps()
+    log({'bitmaps': bitmaps}, indent=3D2)
     log('')
     return bitmaps
=20
@@ -370,7 +351,7 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitmap=
', failure=3DNone):
         # 1 - Writes and Reference Backup
         bitmaps =3D perform_writes(drive0, 1)
         ebitmap.dirty_group(1)
-        bitmap =3D get_bitmap(bitmaps, drive0.device, 'bitmap0')
+        bitmap =3D vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=3Dbitma=
ps)
         ebitmap.compare(bitmap)
         reference_backup(drive0, 1, fbackup1)
=20
@@ -388,12 +369,13 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitm=
ap', failure=3DNone):
             log('')
             bitmaps =3D perform_writes(drive0, 2)
             # Named bitmap (static, should be unchanged)
-            ebitmap.compare(get_bitmap(bitmaps, drive0.device, 'bitmap0'=
))
+            ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0',
+                                          bitmaps=3Dbitmaps))
             # Anonymous bitmap (dynamic, shows new writes)
             anonymous =3D EmulatedBitmap()
             anonymous.dirty_group(2)
-            anonymous.compare(get_bitmap(bitmaps, drive0.device, '',
-                                         recording=3DTrue))
+            anonymous.compare(vm.get_bitmap(drive0.node, '', recording=3D=
True,
+                                            bitmaps=3Dbitmaps))
=20
             # Simulate the order in which this will happen:
             # group 1 gets cleared first, then group two gets written.
@@ -405,8 +387,8 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitmap=
', failure=3DNone):
         vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse,
                    pre_finalize=3D_callback,
                    cancel=3D(failure =3D=3D 'simulated'))
-        bitmaps =3D query_bitmaps(vm)
-        log(bitmaps, indent=3D2)
+        bitmaps =3D vm.query_bitmaps()
+        log({'bitmaps': bitmaps}, indent=3D2)
         log('')
=20
         if bsync_mode =3D=3D 'always' and failure =3D=3D 'intermediate':
@@ -423,29 +405,30 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitm=
ap', failure=3DNone):
                 ebitmap.clear()
                 ebitmap.dirty_bits(range(fail_bit, SIZE // GRANULARITY))
=20
-        ebitmap.compare(get_bitmap(bitmaps, drive0.device, 'bitmap0'))
+        ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=3D=
bitmaps))
=20
         # 2 - Writes and Reference Backup
         bitmaps =3D perform_writes(drive0, 3)
         ebitmap.dirty_group(3)
-        ebitmap.compare(get_bitmap(bitmaps, drive0.device, 'bitmap0'))
+        ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=3D=
bitmaps))
         reference_backup(drive0, 2, fbackup2)
=20
         # 2 - Bitmap Backup (In failure modes, this is a recovery.)
         job =3D backup(drive0, 2, bsync2, "bitmap",
                      bitmap=3D"bitmap0", bitmap_mode=3Dbsync_mode)
         vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse)
-        bitmaps =3D query_bitmaps(vm)
-        log(bitmaps, indent=3D2)
+        bitmaps =3D vm.query_bitmaps()
+        log({'bitmaps': bitmaps}, indent=3D2)
         log('')
         if bsync_mode !=3D 'never':
             ebitmap.clear()
-        ebitmap.compare(get_bitmap(bitmaps, drive0.device, 'bitmap0'))
+        ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=3D=
bitmaps))
=20
         log('--- Cleanup ---\n')
         vm.qmp_log("block-dirty-bitmap-remove",
                    node=3Ddrive0.name, name=3D"bitmap0")
-        log(query_bitmaps(vm), indent=3D2)
+        bitmaps =3D vm.query_bitmaps()
+        log({'bitmaps': bitmaps}, indent=3D2)
         vm.shutdown()
         log('')
=20
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index 84b79d7bfe..c9b4b68232 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -19,9 +19,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -55,7 +53,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -111,7 +109,7 @@ write -P0x67 0x3fe0000 0x20000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -153,7 +151,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"data": {"device": "backup_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 655360,
@@ -182,7 +180,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 983040,
@@ -231,7 +229,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"data": {"device": "backup_2", "len": 983040, "offset": 983040, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 983040,
@@ -253,9 +251,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -285,9 +281,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -321,7 +315,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -370,7 +364,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 39=
3216, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -399,7 +393,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 917504,
@@ -448,7 +442,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"data": {"device": "backup_2", "len": 917504, "offset": 917504, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 917504,
@@ -470,9 +464,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -502,9 +494,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -538,7 +528,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -594,7 +584,7 @@ write -P0x67 0x3fe0000 0x20000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -636,7 +626,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"data": {"device": "backup_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 655360,
@@ -665,7 +655,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 983040,
@@ -714,7 +704,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"data": {"device": "backup_2", "len": 983040, "offset": 983040, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 983040,
@@ -736,9 +726,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -768,9 +756,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -804,7 +790,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -860,7 +846,7 @@ write -P0x67 0x3fe0000 0x20000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -902,7 +888,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"data": {"device": "backup_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 655360,
@@ -931,7 +917,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 983040,
@@ -980,7 +966,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"data": {"device": "backup_2", "len": 983040, "offset": 983040, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -1002,9 +988,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -1034,9 +1018,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -1070,7 +1052,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -1119,7 +1101,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 39=
3216, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -1148,7 +1130,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 917504,
@@ -1197,7 +1179,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"data": {"device": "backup_2", "len": 917504, "offset": 917504, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -1219,9 +1201,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -1251,9 +1231,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -1287,7 +1265,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -1343,7 +1321,7 @@ write -P0x67 0x3fe0000 0x20000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -1385,7 +1363,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"data": {"device": "backup_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -1414,7 +1392,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 786432,
@@ -1463,7 +1441,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"data": {"device": "backup_2", "len": 786432, "offset": 786432, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -1485,9 +1463,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -1517,9 +1493,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -1553,7 +1527,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -1609,7 +1583,7 @@ write -P0x67 0x3fe0000 0x20000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -1651,7 +1625,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"data": {"device": "backup_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -1680,7 +1654,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 786432,
@@ -1729,7 +1703,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"data": {"device": "backup_2", "len": 786432, "offset": 786432, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -1751,9 +1725,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -1783,9 +1755,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -1819,7 +1789,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -1868,7 +1838,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 39=
3216, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 327680,
@@ -1897,7 +1867,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 851968,
@@ -1946,7 +1916,7 @@ expecting 13 dirty sectors; have 13. OK!
 {"data": {"device": "backup_2", "len": 851968, "offset": 851968, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -1968,9 +1938,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -2000,9 +1968,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -2036,7 +2002,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -2092,7 +2058,7 @@ write -P0x67 0x3fe0000 0x20000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -2134,7 +2100,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"data": {"device": "backup_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -2163,7 +2129,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 786432,
@@ -2212,7 +2178,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"data": {"device": "backup_2", "len": 786432, "offset": 786432, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -2234,9 +2200,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -2266,9 +2230,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -2302,7 +2264,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -2358,7 +2320,7 @@ write -P0x67 0x3fe0000 0x20000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -2400,7 +2362,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 655360,
@@ -2429,7 +2391,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 983040,
@@ -2478,7 +2440,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"data": {"device": "backup_2", "len": 983040, "offset": 983040, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -2500,9 +2462,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -2532,9 +2492,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -2568,7 +2526,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -2617,7 +2575,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 67=
108864, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_=
JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}=
}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -2646,7 +2604,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 917504,
@@ -2695,7 +2653,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"data": {"device": "backup_2", "len": 917504, "offset": 917504, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -2717,9 +2675,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -2749,9 +2705,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -2785,7 +2739,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -2841,7 +2795,7 @@ write -P0x67 0x3fe0000 0x20000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -2883,7 +2837,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -2912,7 +2866,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 786432,
@@ -2961,7 +2915,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"data": {"device": "backup_2", "len": 786432, "offset": 786432, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -2983,9 +2937,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -3015,9 +2967,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -3051,7 +3001,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -3107,7 +3057,7 @@ write -P0x67 0x3fe0000 0x20000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -3149,7 +3099,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -3178,7 +3128,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 786432,
@@ -3227,7 +3177,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"data": {"device": "backup_2", "len": 786432, "offset": 786432, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -3249,9 +3199,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -3281,9 +3229,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -3317,7 +3263,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -3366,7 +3312,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 67=
108864, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_=
JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}=
}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 66125824,
@@ -3395,7 +3341,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 66453504,
@@ -3444,7 +3390,7 @@ expecting 1014 dirty sectors; have 1014. OK!
 {"data": {"device": "backup_2", "len": 66453504, "offset": 66453504, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -3466,9 +3412,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -3498,9 +3442,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -3534,7 +3476,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -3590,7 +3532,7 @@ write -P0x67 0x3fe0000 0x20000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -3632,7 +3574,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -3661,7 +3603,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 786432,
@@ -3710,7 +3652,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"data": {"device": "backup_2", "len": 786432, "offset": 786432, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -3732,9 +3674,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -3764,9 +3704,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -3800,7 +3738,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -3856,7 +3794,7 @@ write -P0x67 0x3fe0000 0x20000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -3898,7 +3836,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"data": {"device": "backup_1", "len": 458752, "offset": 458752, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 655360,
@@ -3927,7 +3865,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 983040,
@@ -3976,7 +3914,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"data": {"device": "backup_2", "len": 983040, "offset": 983040, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -3998,9 +3936,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -4030,9 +3966,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -4066,7 +4000,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -4115,7 +4049,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 45=
8752, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -4144,7 +4078,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 917504,
@@ -4193,7 +4127,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"data": {"device": "backup_2", "len": 917504, "offset": 917504, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -4215,9 +4149,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -4247,9 +4179,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -4283,7 +4213,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -4339,7 +4269,7 @@ write -P0x67 0x3fe0000 0x20000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -4381,7 +4311,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"data": {"device": "backup_1", "len": 458752, "offset": 458752, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -4410,7 +4340,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 786432,
@@ -4459,7 +4389,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"data": {"device": "backup_2", "len": 786432, "offset": 786432, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -4481,9 +4411,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -4513,9 +4441,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -4549,7 +4475,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -4605,7 +4531,7 @@ write -P0x67 0x3fe0000 0x20000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -4647,7 +4573,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"data": {"device": "backup_1", "len": 458752, "offset": 458752, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -4676,7 +4602,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 786432,
@@ -4725,7 +4651,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"data": {"device": "backup_2", "len": 786432, "offset": 786432, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -4747,9 +4673,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -4779,9 +4703,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -4815,7 +4737,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -4864,7 +4786,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"data": {"device": "backup_1", "error": "Input/output error", "len": 45=
8752, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -4893,7 +4815,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 917504,
@@ -4942,7 +4864,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"data": {"device": "backup_2", "len": 917504, "offset": 917504, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -4964,9 +4886,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
@@ -4996,9 +4916,7 @@ write -P0x6f 0x2000000 0x10000
 write -P0x76 0x3ff0000 0x10000
 {"return": ""}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Reference Backup #0 ---
@@ -5032,7 +4950,7 @@ write -P0x69 0x3fe0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 393216,
@@ -5088,7 +5006,7 @@ write -P0x67 0x3fe0000 0x20000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -5130,7 +5048,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"data": {"device": "backup_1", "len": 458752, "offset": 458752, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -5159,7 +5077,7 @@ write -P0xdd 0x3fc0000 0x10000
 {"return": ""}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 786432,
@@ -5208,7 +5126,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"data": {"device": "backup_2", "len": 786432, "offset": 786432, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
-    "device0": [
+    "drive0": [
       {
         "busy": false,
         "count": 0,
@@ -5230,9 +5148,7 @@ expecting 0 dirty sectors; have 0. OK!
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
 {"return": {}}
 {
-  "bitmaps": {
-    "device0": []
-  }
+  "bitmaps": {}
 }
=20
 --- Verification ---
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 9fb5181c3d..3a8f378f90 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -641,6 +641,33 @@ class VM(qtest.QEMUQtestMachine):
                 return x
         return None
=20
+    def query_bitmaps(self):
+        res =3D self.qmp("query-named-block-nodes")
+        return {device['node-name']: device['dirty-bitmaps']
+                for device in res['return'] if 'dirty-bitmaps' in device=
}
+
+    def get_bitmap(self, node_name, bitmap_name, recording=3DNone, bitma=
ps=3DNone):
+        """
+        get a specific bitmap from the object returned by query_bitmaps.
+        :param recording: If specified, filter results by the specified =
value.
+        :param bitmaps: If specified, use it instead of call query_bitma=
ps()
+        """
+        if bitmaps is None:
+            bitmaps =3D self.query_bitmaps()
+
+        for bitmap in bitmaps[node_name]:
+            if bitmap.get('name', '') =3D=3D bitmap_name:
+                if recording is None:
+                    return bitmap
+                elif bitmap.get('recording') =3D=3D recording:
+                    return bitmap
+        return None
+
+    def check_bitmap_status(self, node_name, bitmap_name, fields):
+        ret =3D self.get_bitmap(node_name, bitmap_name)
+
+        return fields.items() <=3D ret.items()
+
=20
 index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
=20
--=20
2.21.0


