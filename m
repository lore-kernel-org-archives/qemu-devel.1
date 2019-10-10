Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405B3C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04FA220650
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FA220650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXHT-0003Oe-Nm
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWrD-0006jU-H1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWrB-0008GV-Cm
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41170)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWr5-0008Do-Hs; Thu, 10 Oct 2019 07:43:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A70FF3084249;
 Thu, 10 Oct 2019 11:43:38 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2399960920;
 Thu, 10 Oct 2019 11:43:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 16/36] iotests: 257: drop device_add
Date: Thu, 10 Oct 2019 13:42:40 +0200
Message-Id: <20191010114300.7746-17-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 10 Oct 2019 11:43:38 +0000 (UTC)
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

SCSI devices are unused in test, drop them.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190920142056.12778-12-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/257     |  8 -------
 tests/qemu-iotests/257.out | 44 --------------------------------------
 2 files changed, 52 deletions(-)

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 5d77202157..de8b45f094 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -325,12 +325,6 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitma=
p', failure=3DNone):
                    node_name=3Ddrive0.node,
                    driver=3Ddrive0.fmt,
                    file=3Dfile_config)
-        # Use share-rw to allow writes directly to the node;
-        # The anonymous block-backend for this configuration prevents us
-        # from using HMP's qemu-io commands to address the device.
-        vm.qmp_log("device_add", id=3D'device0',
-                   drive=3Ddrive0.node, driver=3D"scsi-hd",
-                   share_rw=3DTrue)
         log('')
=20
         # 0 - Writes and Reference Backup
@@ -467,8 +461,6 @@ def test_backup_api():
                    node_name=3Ddrive0.node,
                    driver=3Ddrive0.fmt,
                    file=3Dfile_config)
-        vm.qmp_log("device_add", id=3D'device0',
-                   drive=3Ddrive0.node, driver=3D"scsi-hd")
         log('')
=20
         target0 =3D Drive(backup_path, vm=3Dvm)
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index c9b4b68232..ec7e25877b 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -5,8 +5,6 @@
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -267,8 +265,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fba=
ckup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_dis=
k", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "s=
tate": 2}]}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -480,8 +476,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fba=
ckup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -742,8 +736,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fba=
ckup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -1004,8 +996,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fb=
ackup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_dis=
k", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "s=
tate": 2}]}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -1217,8 +1207,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -1479,8 +1467,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -1741,8 +1727,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_dis=
k", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "s=
tate": 2}]}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -1954,8 +1938,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -2216,8 +2198,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -2478,8 +2458,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_dis=
k", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "s=
tate": 2}]}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -2691,8 +2669,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -2953,8 +2929,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -3215,8 +3189,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_dis=
k", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "s=
tate": 2}]}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -3428,8 +3400,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -3690,8 +3660,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -3952,8 +3920,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_dis=
k", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "s=
tate": 2}]}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -4165,8 +4131,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -4427,8 +4391,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -4689,8 +4651,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_dis=
k", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "s=
tate": 2}]}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -4902,8 +4862,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
-{"return": {}}
=20
 --- Write #0 ---
=20
@@ -5164,8 +5122,6 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-f=
backup2" =3D=3D> Identical, OK!
=20
 {"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0"}}
-{"return": {}}
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
--=20
2.21.0


