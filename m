Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F69C73C66
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0576D2073D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0576D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl193-0004e8-9M
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 21:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49282)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hl13t-0000Ve-SQ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hl13p-0004a2-FV
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hl13g-0004Ii-5o; Tue, 09 Jul 2019 21:06:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D7CB369CC;
 Wed, 10 Jul 2019 01:06:06 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 934991001B19;
 Wed, 10 Jul 2019 01:06:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 21:05:53 -0400
Message-Id: <20190710010556.32365-6-jsnow@redhat.com>
In-Reply-To: <20190710010556.32365-1-jsnow@redhat.com>
References: <20190710010556.32365-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 10 Jul 2019 01:06:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 5/8] iotests/257: test API failures
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/257     | 69 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/257.out | 85 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 2eb4f26c28..de8707cb19 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -450,10 +450,79 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitm=
ap', failure=3DNone):
         compare_images(img_path, fbackup2)
         log('')
=20
+def test_backup_api():
+    """
+    """
+    with iotests.FilePaths(['img', 'bsync1']) as \
+         (img_path, backup_path), \
+         iotests.VM() as vm:
+
+        log("\n=3D=3D=3D API failure tests =3D=3D=3D\n")
+        log('--- Preparing image & VM ---\n')
+        drive0 =3D Drive(img_path, vm=3Dvm)
+        drive0.img_create(iotests.imgfmt, SIZE)
+        vm.add_device("{},id=3Dscsi0".format(iotests.get_virtio_scsi_dev=
ice()))
+        vm.launch()
+
+        file_config =3D {
+            'driver': 'file',
+            'filename': drive0.path
+        }
+
+        vm.qmp_log('blockdev-add',
+                   filters=3D[iotests.filter_qmp_testfiles],
+                   node_name=3D"drive0",
+                   driver=3Ddrive0.fmt,
+                   file=3Dfile_config)
+        drive0.node =3D 'drive0'
+        drive0.device =3D 'device0'
+        vm.qmp_log("device_add", id=3Ddrive0.device,
+                   drive=3Ddrive0.name, driver=3D"scsi-hd")
+        log('')
+
+        target0 =3D Drive(backup_path, vm=3Dvm)
+        target0.create_target("backup_target", drive0.fmt, drive0.size)
+        log('')
+
+        vm.qmp_log("block-dirty-bitmap-add", node=3Ddrive0.name,
+                   name=3D"bitmap0", granularity=3DGRANULARITY)
+        log('')
+
+        log('-- Testing invalid QMP commands --\n')
+
+        error_cases =3D {
+            'incremental': {
+                None:        ['on-success', 'always', 'never', None],
+                'bitmap404': ['on-success', 'always', 'never', None],
+                'bitmap0':   ['always', 'never']
+            },
+            'bitmap': {
+                None:        ['on-success', 'always', 'never', None],
+                'bitmap404': ['on-success', 'always', 'never', None],
+                'bitmap0':   [None],
+            },
+        }
+
+        for sync_mode, config in error_cases.items():
+            log("-- Sync mode {:s} tests --\n".format(sync_mode))
+            for bitmap, policies in config.items():
+                for policy in policies:
+                    kwargs =3D { 'job_id': 'api_job' }
+                    if bitmap is not None:
+                        kwargs['bitmap'] =3D bitmap
+                    if policy is not None:
+                        kwargs['bitmap-mode'] =3D policy
+                    blockdev_backup(drive0.vm, drive0.name, "backup_targ=
et",
+                                    sync_mode, **kwargs)
+                    log('')
+
+
 def main():
     for bsync_mode in ("never", "on-success", "always"):
         for failure in ("simulated", "intermediate", None):
             test_bitmap_sync(bsync_mode, "bitmap", failure)
=20
+    test_backup_api()
+
 if __name__ =3D=3D '__main__':
     iotests.script_main(main, supported_fmts=3D['qcow2'])
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index 0abc96acd3..43f2e0f9c9 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -2245,3 +2245,88 @@ qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/P=
ID-fbackup1" =3D=3D> Identical, OK
 qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
 qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
=20
+
+=3D=3D=3D API failure tests =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0"}}
+{"return": {}}
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+-- Testing invalid QMP commands --
+
+-- Sync mode incremental tests --
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "job-id": "api_job", "sync": "incremental", "target=
": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'incremental' sync mode"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "job-id": "api_job", "sync": "incremental", "target": "=
backup_target"}}
+{"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'incremental' sync mode"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "job-id": "api_job", "sync": "incremental", "target": "b=
ackup_target"}}
+{"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'incremental' sync mode"}}
+
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "api_job", "sync": "incremental", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'incremental' sync mode"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync":=
 "incremental", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "in=
cremental", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'o=
n-success' when using sync mode 'incremental'"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "inc=
remental", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'o=
n-success' when using sync mode 'incremental'"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "job-id": "api_job", "sync": "incremental", "target": "ba=
ckup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "incr=
emental", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'o=
n-success' when using sync mode 'incremental'"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "incre=
mental", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'o=
n-success' when using sync mode 'incremental'"}}
+
+-- Sync mode bitmap tests --
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "b=
ackup_target"}}
+{"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'bitmap' sync mode"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backu=
p_target"}}
+{"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'bitmap' sync mode"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup=
_target"}}
+{"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'bitmap' sync mode"}}
+
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "api_job", "sync": "bitmap", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "must provide a valid bitmap=
 name for 'bitmap' sync mode"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync":=
 "bitmap", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "bi=
tmap", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "bit=
map", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup_=
target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup_ta=
rget"}}
+{"error": {"class": "GenericError", "desc": "Bitmap sync mode must be gi=
ven when providing a bitmap"}}
+
--=20
2.21.0


