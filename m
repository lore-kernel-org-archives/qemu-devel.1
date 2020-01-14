Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4C8C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F8524658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm3MUqvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F8524658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMpG-0007PI-0n
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1irMlq-000464-W3
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1irMln-00028n-Fm
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:02:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60492
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1irMln-00028U-Bn
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579010530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kEkHTgbYTovleLh4g7LPd5igtotu54yVMT23aloGjs0=;
 b=gm3MUqvqbu6y3DXLw8rc6sr0Mxz4F3skEwZbWYqJNlcmWnExB+i8jqEyU5sq5lEF3Pen7Y
 23sq798J4g2tDTdKd0Ggu2VGiH585++H23h4bo/9Y8I5K3EhiJ4AraMj5jcqIxikDyDrxD
 a7pEZU9J17FlB3s7O+KNbTqAYsyFYQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-xpKxiNBVM7uLNYZ2IjuoyA-1; Tue, 14 Jan 2020 09:02:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD03E800D53;
 Tue, 14 Jan 2020 14:02:07 +0000 (UTC)
Received: from thuth.com (unknown [10.36.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF0665DA32;
 Tue, 14 Jan 2020 14:02:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v3] iotests: Add more "skip_if_unsupported" statements to the
 python tests
Date: Tue, 14 Jan 2020 15:02:03 +0100
Message-Id: <20200114140203.24326-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: xpKxiNBVM7uLNYZ2IjuoyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The python code already contains a possibility to skip tests if the
corresponding driver is not available in the qemu binary - use it
in more spots to avoid that the tests are failing if the driver has
been disabled.

While we're at it, we can now also remove some of the old checks that
were using iotests.supports_quorum() - and which were apparently not
working as expected since the tests aborted instead of being skipped
when "quorum" was missing in the QEMU binary.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v3:
 - Remove the old iotests.supports_quorum()-based tests
 - Check for "throttle" in 245, too

 tests/qemu-iotests/030 |  4 +---
 tests/qemu-iotests/040 |  2 ++
 tests/qemu-iotests/041 | 39 +++------------------------------------
 tests/qemu-iotests/245 |  2 ++
 4 files changed, 8 insertions(+), 39 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index be35bde06f..0990681c1e 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -530,6 +530,7 @@ class TestQuorum(iotests.QMPTestCase):
     children =3D []
     backing =3D []
=20
+    @iotests.skip_if_unsupported(['quorum'])
     def setUp(self):
         opts =3D ['driver=3Dquorum', 'vote-threshold=3D2']
=20
@@ -560,9 +561,6 @@ class TestQuorum(iotests.QMPTestCase):
             os.remove(img)
=20
     def test_stream_quorum(self):
-        if not iotests.supports_quorum():
-            return
-
         self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'ma=
p', self.children[0]),
                             qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'ma=
p', self.backing[0]),
                             'image file map matches backing file before st=
reaming')
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 762ad1ebcb..74f62c3c4a 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -106,6 +106,7 @@ class TestSingleDrive(ImageCommitTestCase):
         self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 52=
4288', backing_img).find("verification failed"))
         self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xef 5242=
88 524288', backing_img).find("verification failed"))
=20
+    @iotests.skip_if_unsupported(['throttle'])
     def test_commit_with_filter_and_quit(self):
         result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group', =
id=3D'tg')
         self.assert_qmp(result, 'return', {})
@@ -125,6 +126,7 @@ class TestSingleDrive(ImageCommitTestCase):
         self.has_quit =3D True
=20
     # Same as above, but this time we add the filter after starting the jo=
b
+    @iotests.skip_if_unsupported(['throttle'])
     def test_commit_plus_filter_and_quit(self):
         result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group', =
id=3D'tg')
         self.assert_qmp(result, 'return', {})
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index d7be30b62b..c07437fda1 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -871,6 +871,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
     image_len =3D 1 * 1024 * 1024 # MB
     IMAGES =3D [ quorum_img1, quorum_img2, quorum_img3 ]
=20
+    @iotests.skip_if_unsupported(['quorum'])
     def setUp(self):
         self.vm =3D iotests.VM()
=20
@@ -891,9 +892,8 @@ class TestRepairQuorum(iotests.QMPTestCase):
         #assemble the quorum block device from the individual files
         args =3D { "driver": "quorum", "node-name": "quorum0",
                  "vote-threshold": 2, "children": [ "img0", "img1", "img2"=
 ] }
-        if iotests.supports_quorum():
-            result =3D self.vm.qmp("blockdev-add", **args)
-            self.assert_qmp(result, 'return', {})
+        result =3D self.vm.qmp("blockdev-add", **args)
+        self.assert_qmp(result, 'return', {})
=20
=20
     def tearDown(self):
@@ -906,9 +906,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
                 pass
=20
     def test_complete(self):
-        if not iotests.supports_quorum():
-            return
-
         self.assert_no_active_block_jobs()
=20
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0', device=3D'=
quorum0',
@@ -925,9 +922,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
                         'target image does not match source after mirrorin=
g')
=20
     def test_cancel(self):
-        if not iotests.supports_quorum():
-            return
-
         self.assert_no_active_block_jobs()
=20
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0', device=3D'=
quorum0',
@@ -942,9 +936,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.vm.shutdown()
=20
     def test_cancel_after_ready(self):
-        if not iotests.supports_quorum():
-            return
-
         self.assert_no_active_block_jobs()
=20
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0', device=3D'=
quorum0',
@@ -961,9 +952,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
                         'target image does not match source after mirrorin=
g')
=20
     def test_pause(self):
-        if not iotests.supports_quorum():
-            return
-
         self.assert_no_active_block_jobs()
=20
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0', device=3D'=
quorum0',
@@ -989,9 +977,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
                         'target image does not match source after mirrorin=
g')
=20
     def test_medium_not_found(self):
-        if not iotests.supports_quorum():
-            return
-
         if iotests.qemu_default_machine !=3D 'pc':
             return
=20
@@ -1003,9 +988,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
     def test_image_not_found(self):
-        if not iotests.supports_quorum():
-            return
-
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0', device=3D'=
quorum0',
                              sync=3D'full', node_name=3D'repair0', replace=
s=3D'img1',
                              mode=3D'existing', target=3Dquorum_repair_img=
,
@@ -1013,9 +995,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
     def test_device_not_found(self):
-        if not iotests.supports_quorum():
-            return
-
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0',
                              device=3D'nonexistent', sync=3D'full',
                              node_name=3D'repair0',
@@ -1024,9 +1003,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
     def test_wrong_sync_mode(self):
-        if not iotests.supports_quorum():
-            return
-
         result =3D self.vm.qmp('drive-mirror', device=3D'quorum0', job_id=
=3D'job0',
                              node_name=3D'repair0',
                              replaces=3D'img1',
@@ -1034,27 +1010,18 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
     def test_no_node_name(self):
-        if not iotests.supports_quorum():
-            return
-
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0', device=3D'=
quorum0',
                              sync=3D'full', replaces=3D'img1',
                              target=3Dquorum_repair_img, format=3Diotests.=
imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
     def test_nonexistent_replaces(self):
-        if not iotests.supports_quorum():
-            return
-
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0', device=3D'=
quorum0',
                              sync=3D'full', node_name=3D'repair0', replace=
s=3D'img77',
                              target=3Dquorum_repair_img, format=3Diotests.=
imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
     def test_after_a_quorum_snapshot(self):
-        if not iotests.supports_quorum():
-            return
-
         result =3D self.vm.qmp('blockdev-snapshot-sync', node_name=3D'img1=
',
                              snapshot_file=3Dquorum_snapshot_file,
                              snapshot_node_name=3D"snap1");
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index e66a23c5f0..d12b253065 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -478,6 +478,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
     # This test verifies that we can't change the children of a block
     # device during a reopen operation in a way that would create
     # cycles in the node graph
+    @iotests.skip_if_unsupported(['blkverify'])
     def test_graph_cycles(self):
         opts =3D []
=20
@@ -534,6 +535,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
=20
     # Misc reopen tests with different block drivers
+    @iotests.skip_if_unsupported(['quorum', 'throttle'])
     def test_misc_drivers(self):
         ####################
         ###### quorum ######
--=20
2.18.1


