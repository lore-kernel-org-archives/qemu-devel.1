Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD48C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E5D2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E5D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXQh-00068r-RT
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWr9-0006dr-LF
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWr8-0008Ev-8j
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWr3-0008CW-2y; Thu, 10 Oct 2019 07:43:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 560CB801663;
 Thu, 10 Oct 2019 11:43:36 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F10295D6B7;
 Thu, 10 Oct 2019 11:43:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 15/36] iotests: 257: drop unused Drive.device field
Date: Thu, 10 Oct 2019 13:42:39 +0200
Message-Id: <20191010114300.7746-16-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 10 Oct 2019 11:43:36 +0000 (UTC)
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

After previous commit Drive.device is actually unused. Drop it together
with .name property.  While being here reuse .node in qmp commands
instead of writing 'drive0' twice.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190920142056.12778-11-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/257 | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 6b368e1e70..5d77202157 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -148,11 +148,6 @@ class Drive:
         self.fmt =3D None
         self.size =3D None
         self.node =3D None
-        self.device =3D None
-
-    @property
-    def name(self):
-        return self.node or self.device
=20
     def img_create(self, fmt, size):
         self.fmt =3D fmt
@@ -201,7 +196,7 @@ def blockdev_backup(vm, device, target, sync, **kwarg=
s):
 def blockdev_backup_mktarget(drive, target_id, filepath, sync, **kwargs)=
:
     target_drive =3D Drive(filepath, vm=3Ddrive.vm)
     target_drive.create_target(target_id, drive.fmt, drive.size)
-    blockdev_backup(drive.vm, drive.name, target_id, sync, **kwargs)
+    blockdev_backup(drive.vm, drive.node, target_id, sync, **kwargs)
=20
 def reference_backup(drive, n, filepath):
     log("--- Reference Backup #{:d} ---\n".format(n))
@@ -229,7 +224,7 @@ def perform_writes(drive, n):
             pattern.offset,
             pattern.size)
         log(cmd)
-        log(drive.vm.hmp_qemu_io(drive.name, cmd))
+        log(drive.vm.hmp_qemu_io(drive.node, cmd))
     bitmaps =3D drive.vm.query_bitmaps()
     log({'bitmaps': bitmaps}, indent=3D2)
     log('')
@@ -324,18 +319,17 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitm=
ap', failure=3DNone):
                 }]
             }
=20
+        drive0.node =3D 'drive0'
         vm.qmp_log('blockdev-add',
                    filters=3D[iotests.filter_qmp_testfiles],
-                   node_name=3D"drive0",
+                   node_name=3Ddrive0.node,
                    driver=3Ddrive0.fmt,
                    file=3Dfile_config)
-        drive0.node =3D 'drive0'
-        drive0.device =3D 'device0'
         # Use share-rw to allow writes directly to the node;
         # The anonymous block-backend for this configuration prevents us
         # from using HMP's qemu-io commands to address the device.
-        vm.qmp_log("device_add", id=3Ddrive0.device,
-                   drive=3Ddrive0.name, driver=3D"scsi-hd",
+        vm.qmp_log("device_add", id=3D'device0',
+                   drive=3Ddrive0.node, driver=3D"scsi-hd",
                    share_rw=3DTrue)
         log('')
=20
@@ -343,7 +337,7 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitmap=
', failure=3DNone):
         perform_writes(drive0, 0)
         reference_backup(drive0, 0, fbackup0)
         log('--- Add Bitmap ---\n')
-        vm.qmp_log("block-dirty-bitmap-add", node=3Ddrive0.name,
+        vm.qmp_log("block-dirty-bitmap-add", node=3Ddrive0.node,
                    name=3D"bitmap0", granularity=3DGRANULARITY)
         log('')
         ebitmap =3D EmulatedBitmap()
@@ -358,7 +352,7 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitmap=
', failure=3DNone):
         # 1 - Test Backup (w/ Optional induced failure)
         if failure =3D=3D 'intermediate':
             # Activate blkdebug induced failure for second-to-next read
-            log(vm.hmp_qemu_io(drive0.name, 'flush'))
+            log(vm.hmp_qemu_io(drive0.node, 'flush'))
             log('')
         job =3D backup(drive0, 1, bsync1, msync_mode,
                      bitmap=3D"bitmap0", bitmap_mode=3Dbsync_mode)
@@ -426,7 +420,7 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitmap=
', failure=3DNone):
=20
         log('--- Cleanup ---\n')
         vm.qmp_log("block-dirty-bitmap-remove",
-                   node=3Ddrive0.name, name=3D"bitmap0")
+                   node=3Ddrive0.node, name=3D"bitmap0")
         bitmaps =3D vm.query_bitmaps()
         log({'bitmaps': bitmaps}, indent=3D2)
         vm.shutdown()
@@ -467,22 +461,21 @@ def test_backup_api():
             'filename': drive0.path
         }
=20
+        drive0.node =3D 'drive0'
         vm.qmp_log('blockdev-add',
                    filters=3D[iotests.filter_qmp_testfiles],
-                   node_name=3D"drive0",
+                   node_name=3Ddrive0.node,
                    driver=3Ddrive0.fmt,
                    file=3Dfile_config)
-        drive0.node =3D 'drive0'
-        drive0.device =3D 'device0'
-        vm.qmp_log("device_add", id=3Ddrive0.device,
-                   drive=3Ddrive0.name, driver=3D"scsi-hd")
+        vm.qmp_log("device_add", id=3D'device0',
+                   drive=3Ddrive0.node, driver=3D"scsi-hd")
         log('')
=20
         target0 =3D Drive(backup_path, vm=3Dvm)
         target0.create_target("backup_target", drive0.fmt, drive0.size)
         log('')
=20
-        vm.qmp_log("block-dirty-bitmap-add", node=3Ddrive0.name,
+        vm.qmp_log("block-dirty-bitmap-add", node=3Ddrive0.node,
                    name=3D"bitmap0", granularity=3DGRANULARITY)
         log('')
=20
@@ -521,7 +514,7 @@ def test_backup_api():
             log("-- Sync mode {:s} tests --\n".format(sync_mode))
             for bitmap in (None, 'bitmap404', 'bitmap0'):
                 for policy in error_cases[sync_mode][bitmap]:
-                    blockdev_backup(drive0.vm, drive0.name, "backup_targ=
et",
+                    blockdev_backup(drive0.vm, drive0.node, "backup_targ=
et",
                                     sync_mode, job_id=3D'api_job',
                                     bitmap=3Dbitmap, bitmap_mode=3Dpolic=
y)
                     log('')
--=20
2.21.0


