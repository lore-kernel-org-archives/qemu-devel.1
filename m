Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C1CC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8B220835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8B220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCN46-0007ME-H5
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 08:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iCMye-0003bq-Rh
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iCMyd-0007Gc-Ij
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:58:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57383)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iCMyY-000710-FA; Mon, 23 Sep 2019 07:57:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2B23A10DCC81;
 Mon, 23 Sep 2019 11:57:52 +0000 (UTC)
Received: from localhost (unknown [10.40.205.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73E6D600C4;
 Mon, 23 Sep 2019 11:57:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/4] iotests: Add test for failing mirror complete
Date: Mon, 23 Sep 2019 13:57:28 +0200
Message-Id: <20190923115728.28250-5-mreitz@redhat.com>
In-Reply-To: <20190923115728.28250-1-mreitz@redhat.com>
References: <20190923115728.28250-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Mon, 23 Sep 2019 11:57:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/041     | 44 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |  4 ++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 8568426311..d7be30b62b 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1121,6 +1121,50 @@ class TestOrphanedSource(iotests.QMPTestCase):
                              target=3D'dest-ro')
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
+    def test_failing_permission_in_complete(self):
+        self.assert_no_active_block_jobs()
+
+        # Unshare consistent-read on the target
+        # (The mirror job does not care)
+        result =3D self.vm.qmp('blockdev-add',
+                             driver=3D'blkdebug',
+                             node_name=3D'dest-perm',
+                             image=3D'dest',
+                             unshare_child_perms=3D['consistent-read'])
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-mirror', job_id=3D'job', device=
=3D'src',
+                             sync=3D'full', target=3D'dest',
+                             filter_node_name=3D'mirror-filter')
+        self.assert_qmp(result, 'return', {})
+
+        # Require consistent-read on the source
+        # (We can only add this node once the job has started, or it
+        # will complain that it does not want to run on non-root nodes)
+        result =3D self.vm.qmp('blockdev-add',
+                             driver=3D'blkdebug',
+                             node_name=3D'src-perm',
+                             image=3D'src',
+                             take_child_perms=3D['consistent-read'])
+        self.assert_qmp(result, 'return', {})
+
+        # While completing, mirror will attempt to replace src by
+        # dest, which must fail because src-perm requires
+        # consistent-read but dest-perm does not share it; thus
+        # aborting the job when it is supposed to complete
+        self.complete_and_wait('job',
+                               completion_error=3D'Operation not permitt=
ed')
+
+        # Assert that all of our nodes are still there (except for the
+        # mirror filter, which should be gone despite the failure)
+        nodes =3D self.vm.qmp('query-named-block-nodes')['return']
+        nodes =3D [node['node-name'] for node in nodes]
+
+        for expect in ('src', 'src-perm', 'dest', 'dest-perm'):
+            self.assertTrue(expect in nodes, '%s disappeared' % expect)
+        self.assertFalse('mirror-filter' in nodes,
+                         'Mirror filter node did not disappear')
+
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'],
                  supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 2c448b4239..f496be9197 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-........................................................................=
..................
+........................................................................=
...................
 ----------------------------------------------------------------------
-Ran 90 tests
+Ran 91 tests
=20
 OK
--=20
2.21.0


