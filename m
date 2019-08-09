Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18DCC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5340A20C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5340A20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7iT-0001Ye-IN
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57807)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7YV-0004G2-9E
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7YT-0004ll-QU
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7YQ-0004j8-8s; Fri, 09 Aug 2019 12:15:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8AE44308FFB1;
 Fri,  9 Aug 2019 16:15:45 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA94610013A1;
 Fri,  9 Aug 2019 16:15:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:14:04 +0200
Message-Id: <20190809161407.11920-40-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 09 Aug 2019 16:15:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 39/42] iotests: Add filter commit test cases
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds some tests on how commit copes with filter nodes.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/040     | 177 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/040.out |   4 +-
 2 files changed, 179 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 6db9abf8e6..a0a0db8889 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -428,5 +428,182 @@ class TestReopenOverlay(ImageCommitTestCase):
     def test_reopen_overlay(self):
         self.run_commit_test(self.img1, self.img0)
=20
+class TestCommitWithFilters(iotests.QMPTestCase):
+    img0 =3D os.path.join(iotests.test_dir, '0.img')
+    img1 =3D os.path.join(iotests.test_dir, '1.img')
+    img2 =3D os.path.join(iotests.test_dir, '2.img')
+    img3 =3D os.path.join(iotests.test_dir, '3.img')
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, self.img0, '64M')
+        qemu_img('create', '-f', iotests.imgfmt, self.img1, '64M')
+        qemu_img('create', '-f', iotests.imgfmt, self.img2, '64M')
+        qemu_img('create', '-f', iotests.imgfmt, self.img3, '64M')
+
+        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 1 0M 1M', self.img=
0)
+        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 2 1M 1M', self.img=
1)
+        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 3 2M 1M', self.img=
2)
+        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 4 3M 1M', self.img=
3)
+
+        # Distributions of the patterns in the files; this is checked
+        # by tearDown() and should be changed by the test cases as is
+        # necessary
+        self.pattern_files =3D [self.img0, self.img1, self.img2, self.im=
g3]
+
+        self.vm =3D iotests.VM()
+        self.vm.launch()
+        self.has_quit =3D False
+
+        result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group'=
, id=3D'tg')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-add', **{
+                'node-name': 'top-filter',
+                'driver': 'throttle',
+                'throttle-group': 'tg',
+                'file': {
+                    'node-name': 'cow-3',
+                    'driver': iotests.imgfmt,
+                    'file': {
+                        'driver': 'file',
+                        'filename': self.img3
+                    },
+                    'backing': {
+                        'node-name': 'cow-2',
+                        'driver': iotests.imgfmt,
+                        'file': {
+                            'driver': 'file',
+                            'filename': self.img2
+                        },
+                        'backing': {
+                            'node-name': 'cow-1',
+                            'driver': iotests.imgfmt,
+                            'file': {
+                                'driver': 'file',
+                                'filename': self.img1
+                            },
+                            'backing': {
+                                'node-name': 'bottom-filter',
+                                'driver': 'throttle',
+                                'throttle-group': 'tg',
+                                'file': {
+                                    'node-name': 'cow-0',
+                                    'driver': iotests.imgfmt,
+                                    'file': {
+                                        'driver': 'file',
+                                        'filename': self.img0
+                                    }
+                                }
+                            }
+                        }
+                    }
+                }
+            })
+        self.assert_qmp(result, 'return', {})
+
+    def tearDown(self):
+        self.vm.shutdown(has_quit=3Dself.has_quit)
+
+        for index in range(len(self.pattern_files)):
+            result =3D qemu_io('-f', iotests.imgfmt,
+                             '-c', 'read -P %i %iM 1M' % (index + 1, ind=
ex),
+                             self.pattern_files[index])
+            self.assertFalse('Pattern verification failed' in result)
+
+        os.remove(self.img3)
+        os.remove(self.img2)
+        os.remove(self.img1)
+        os.remove(self.img0)
+
+    # Filters make for funny filenames, so we cannot just use
+    # self.imgX to get them
+    def get_filename(self, node):
+        return self.vm.node_info(node)['image']['filename']
+
+    def test_filterless_commit(self):
+        self.assert_no_active_block_jobs()
+        result =3D self.vm.qmp('block-commit',
+                             job_id=3D'commit',
+                             device=3D'top-filter',
+                             top_node=3D'cow-2',
+                             base_node=3D'cow-1')
+        self.assert_qmp(result, 'return', {})
+        self.wait_until_completed(drive=3D'commit')
+
+        self.assertIsNotNone(self.vm.node_info('cow-3'))
+        self.assertIsNone(self.vm.node_info('cow-2'))
+        self.assertIsNotNone(self.vm.node_info('cow-1'))
+
+        # 2 has been comitted into 1
+        self.pattern_files[2] =3D self.img1
+
+    def test_commit_through_filter(self):
+        self.assert_no_active_block_jobs()
+        result =3D self.vm.qmp('block-commit',
+                             job_id=3D'commit',
+                             device=3D'top-filter',
+                             top_node=3D'cow-1',
+                             base_node=3D'cow-0')
+        self.assert_qmp(result, 'return', {})
+        self.wait_until_completed(drive=3D'commit')
+
+        self.assertIsNotNone(self.vm.node_info('cow-2'))
+        self.assertIsNone(self.vm.node_info('cow-1'))
+        self.assertIsNone(self.vm.node_info('bottom-filter'))
+        self.assertIsNotNone(self.vm.node_info('cow-0'))
+
+        # 1 has been comitted into 0
+        self.pattern_files[1] =3D self.img0
+
+    def test_filtered_active_commit_with_filter(self):
+        # Add a device, so the commit job finds a parent it can change
+        # to point to the base node (so we can test that top-filter is
+        # dropped from the graph)
+        result =3D self.vm.qmp('device_add', id=3D'drv0', driver=3D'virt=
io-blk',
+                             drive=3D'top-filter')
+        self.assert_qmp(result, 'return', {})
+
+        # Try to release our reference to top-filter; that should not
+        # work because drv0 uses it
+        result =3D self.vm.qmp('blockdev-del', node_name=3D'top-filter')
+        self.assert_qmp(result, 'error/class', 'GenericError')
+        self.assert_qmp(result, 'error/desc', 'Node top-filter is in use=
')
+
+        self.assert_no_active_block_jobs()
+        result =3D self.vm.qmp('block-commit',
+                             job_id=3D'commit',
+                             device=3D'top-filter',
+                             base_node=3D'cow-2')
+        self.assert_qmp(result, 'return', {})
+        self.complete_and_wait(drive=3D'commit')
+
+        # Try to release our reference to top-filter again
+        result =3D self.vm.qmp('blockdev-del', node_name=3D'top-filter')
+        self.assert_qmp(result, 'return', {})
+
+        self.assertIsNone(self.vm.node_info('top-filter'))
+        self.assertIsNone(self.vm.node_info('cow-3'))
+        self.assertIsNotNone(self.vm.node_info('cow-2'))
+
+        # 3 has been comitted into 2
+        self.pattern_files[3] =3D self.img2
+
+    def test_filtered_active_commit_without_filter(self):
+        self.assert_no_active_block_jobs()
+        result =3D self.vm.qmp('block-commit',
+                             job_id=3D'commit',
+                             device=3D'top-filter',
+                             top_node=3D'cow-3',
+                             base_node=3D'cow-2')
+        self.assert_qmp(result, 'return', {})
+        self.complete_and_wait(drive=3D'commit')
+
+        self.assertIsNotNone(self.vm.node_info('top-filter'))
+        self.assertIsNone(self.vm.node_info('cow-3'))
+        self.assertIsNotNone(self.vm.node_info('cow-2'))
+
+        # 3 has been comitted into 2
+        self.pattern_files[3] =3D self.img2
+
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
index 220a5fa82c..fe58934d7a 100644
--- a/tests/qemu-iotests/040.out
+++ b/tests/qemu-iotests/040.out
@@ -1,5 +1,5 @@
-...............................................
+...................................................
 ----------------------------------------------------------------------
-Ran 47 tests
+Ran 51 tests
=20
 OK
--=20
2.21.0


