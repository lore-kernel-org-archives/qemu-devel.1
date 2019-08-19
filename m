Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADADC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 09:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB022184D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 09:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB022184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzdrh-0007Lx-1T
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 05:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hzdr0-0006l4-Hl
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 05:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hzdqz-0000l9-3c
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 05:21:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hzdqv-0000iA-FX; Mon, 19 Aug 2019 05:21:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8CD3D300BEAC;
 Mon, 19 Aug 2019 09:21:24 +0000 (UTC)
Received: from thuth.com (ovpn-116-127.ams2.redhat.com [10.36.116.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD5BE3480A;
 Mon, 19 Aug 2019 09:21:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 19 Aug 2019 11:21:18 +0200
Message-Id: <20190819092118.18920-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 19 Aug 2019 09:21:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] iotests: Add more "skip_if_unsupported"
 statements to the python tests
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The python code already contains a possibility to skip tests if the
corresponding driver is not available in the qemu binary - use it
in more spots to avoid that the tests are failing if the driver has
been disabled.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/030 |  3 +++
 tests/qemu-iotests/040 |  2 ++
 tests/qemu-iotests/041 | 14 +++++++++++++-
 tests/qemu-iotests/245 |  2 ++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 1b69f318c6..18ad24ccdf 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -530,6 +530,7 @@ class TestQuorum(iotests.QMPTestCase):
     children = []
     backing = []
 
+    @iotests.skip_if_unsupported(['quorum'])
     def setUp(self):
         opts = ['driver=quorum', 'vote-threshold=2']
 
@@ -552,6 +553,7 @@ class TestQuorum(iotests.QMPTestCase):
         self.vm.add_drive(path = None, opts = ','.join(opts))
         self.vm.launch()
 
+    @iotests.skip_if_unsupported(['quorum'])
     def tearDown(self):
         self.vm.shutdown()
         for img in self.children:
@@ -559,6 +561,7 @@ class TestQuorum(iotests.QMPTestCase):
         for img in self.backing:
             os.remove(img)
 
+    @iotests.skip_if_unsupported(['quorum'])
     def test_stream_quorum(self):
         if not iotests.supports_quorum():
             return
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index aa0b1847e3..0ec4fb71a9 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -110,6 +110,7 @@ class TestSingleDrive(ImageCommitTestCase):
         self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 524288', backing_img).find("verification failed"))
         self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xef 524288 524288', backing_img).find("verification failed"))
 
+    @iotests.skip_if_unsupported(['throttle'])
     def test_commit_with_filter_and_quit(self):
         result = self.vm.qmp('object-add', qom_type='throttle-group', id='tg')
         self.assert_qmp(result, 'return', {})
@@ -129,6 +130,7 @@ class TestSingleDrive(ImageCommitTestCase):
         self.has_quit = True
 
     # Same as above, but this time we add the filter after starting the job
+    @iotests.skip_if_unsupported(['throttle'])
     def test_commit_plus_filter_and_quit(self):
         result = self.vm.qmp('object-add', qom_type='throttle-group', id='tg')
         self.assert_qmp(result, 'return', {})
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 26bf1701eb..f45d20fbe0 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -817,6 +817,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
     image_len = 1 * 1024 * 1024 # MB
     IMAGES = [ quorum_img1, quorum_img2, quorum_img3 ]
 
+    @iotests.skip_if_unsupported(['quorum'])
     def setUp(self):
         self.vm = iotests.VM()
 
@@ -841,7 +842,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
             result = self.vm.qmp("blockdev-add", **args)
             self.assert_qmp(result, 'return', {})
 
-
+    @iotests.skip_if_unsupported(['quorum'])
     def tearDown(self):
         self.vm.shutdown()
         for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_file ]:
@@ -851,6 +852,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
             except OSError:
                 pass
 
+    @iotests.skip_if_unsupported(['quorum'])
     def test_complete(self):
         if not iotests.supports_quorum():
             return
@@ -870,6 +872,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assertTrue(iotests.compare_images(quorum_img2, quorum_repair_img),
                         'target image does not match source after mirroring')
 
+    @iotests.skip_if_unsupported(['quorum'])
     def test_cancel(self):
         if not iotests.supports_quorum():
             return
@@ -887,6 +890,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_has_block_node(None, quorum_img3)
         self.vm.shutdown()
 
+    @iotests.skip_if_unsupported(['quorum'])
     def test_cancel_after_ready(self):
         if not iotests.supports_quorum():
             return
@@ -906,6 +910,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assertTrue(iotests.compare_images(quorum_img2, quorum_repair_img),
                         'target image does not match source after mirroring')
 
+    @iotests.skip_if_unsupported(['quorum'])
     def test_pause(self):
         if not iotests.supports_quorum():
             return
@@ -934,6 +939,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assertTrue(iotests.compare_images(quorum_img2, quorum_repair_img),
                         'target image does not match source after mirroring')
 
+    @iotests.skip_if_unsupported(['quorum'])
     def test_medium_not_found(self):
         if not iotests.supports_quorum():
             return
@@ -948,6 +954,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
                              target=quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
+    @iotests.skip_if_unsupported(['quorum'])
     def test_image_not_found(self):
         if not iotests.supports_quorum():
             return
@@ -958,6 +965,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
                              format=iotests.imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
+    @iotests.skip_if_unsupported(['quorum'])
     def test_device_not_found(self):
         if not iotests.supports_quorum():
             return
@@ -969,6 +977,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
                              target=quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
+    @iotests.skip_if_unsupported(['quorum'])
     def test_wrong_sync_mode(self):
         if not iotests.supports_quorum():
             return
@@ -979,6 +988,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
                              target=quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
+    @iotests.skip_if_unsupported(['quorum'])
     def test_no_node_name(self):
         if not iotests.supports_quorum():
             return
@@ -988,6 +998,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
                              target=quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
+    @iotests.skip_if_unsupported(['quorum'])
     def test_nonexistent_replaces(self):
         if not iotests.supports_quorum():
             return
@@ -997,6 +1008,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
                              target=quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
+    @iotests.skip_if_unsupported(['quorum'])
     def test_after_a_quorum_snapshot(self):
         if not iotests.supports_quorum():
             return
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index bc1ceb9792..1bdc659ecd 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -478,6 +478,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
     # This test verifies that we can't change the children of a block
     # device during a reopen operation in a way that would create
     # cycles in the node graph
+    @iotests.skip_if_unsupported(['blkverify'])
     def test_graph_cycles(self):
         opts = []
 
@@ -534,6 +535,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
 
     # Misc reopen tests with different block drivers
+    @iotests.skip_if_unsupported(['quorum'])
     def test_misc_drivers(self):
         ####################
         ###### quorum ######
-- 
2.18.1


