Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B560AC3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A8423405
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A8423405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3jlu-0005Ak-4Z
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 12:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3jWT-0000Fz-QB
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3jWQ-0004lD-Mb
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:13:13 -0400
Received: from relay.sw.ru ([185.231.240.75]:60608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3jW1-0004Fd-62; Fri, 30 Aug 2019 12:12:47 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3jVm-0001X0-M3; Fri, 30 Aug 2019 19:12:30 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Fri, 30 Aug 2019 19:12:24 +0300
Message-Id: <20190830161228.54238-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190830161228.54238-1-vsementsov@virtuozzo.com>
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v10 10/14] iotests: 257: drop device_add
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SCSI devices are unused in test, drop them.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/257     |  8 -------
 tests/qemu-iotests/257.out | 44 --------------------------------------
 2 files changed, 52 deletions(-)

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 8185871285..05f1eef327 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -325,12 +325,6 @@ def test_bitmap_sync(bsync_mode, msync_mode='bitmap', failure=None):
                    node_name=drive0.node,
                    driver=drive0.fmt,
                    file=file_config)
-        # Use share-rw to allow writes directly to the node;
-        # The anonymous block-backend for this configuration prevents us
-        # from using HMP's qemu-io commands to address the device.
-        vm.qmp_log("device_add", id='device0',
-                   drive=drive0.node, driver="scsi-hd",
-                   share_rw=True)
         log('')
 
         # 0 - Writes and Reference Backup
@@ -467,8 +461,6 @@ def test_backup_api():
                    node_name=drive0.node,
                    driver=drive0.fmt,
                    file=file_config)
-        vm.qmp_log("device_add", id='device0',
-                   drive=drive0.node, driver="scsi-hd")
         log('')
 
         target0 = Drive(backup_path, vm=vm)
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index c9b4b68232..ec7e25877b 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -5,8 +5,6 @@
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -267,8 +265,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -480,8 +476,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -742,8 +736,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -1004,8 +996,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -1217,8 +1207,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -1479,8 +1467,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -1741,8 +1727,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -1954,8 +1938,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -2216,8 +2198,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -2478,8 +2458,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -2691,8 +2669,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -2953,8 +2929,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -3215,8 +3189,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -3428,8 +3400,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -3690,8 +3660,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -3952,8 +3920,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -4165,8 +4131,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -4427,8 +4391,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -4689,8 +4651,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -4902,8 +4862,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
 
 --- Write #0 ---
 
@@ -5164,8 +5122,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "scsi-hd", "id": "device0"}}
-{"return": {}}
 
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
-- 
2.18.0


