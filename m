Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89332C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638D12184C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638D12184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hijUD-0005WG-L6
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49161)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hij4I-0007yK-VU
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hij4H-0000Pv-1I
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:29:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hij4A-00086p-Sz; Wed, 03 Jul 2019 13:29:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 05B56A7F8;
 Wed,  3 Jul 2019 17:28:39 +0000 (UTC)
Received: from localhost (ovpn-204-65.brq.redhat.com [10.40.204.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F22591F25;
 Wed,  3 Jul 2019 17:28:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  3 Jul 2019 19:28:11 +0200
Message-Id: <20190703172813.6868-11-mreitz@redhat.com>
In-Reply-To: <20190703172813.6868-1-mreitz@redhat.com>
References: <20190703172813.6868-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 03 Jul 2019 17:28:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 10/12] iotests: Add new case to 030
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We recently removed the dependency of the stream job on its base node.
That makes it OK to use a commit filter node there.  Test that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Tested-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/030     | 25 +++++++++++++++++++++++++
 tests/qemu-iotests/030.out |  4 ++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 10fe1de89d..a0397072bc 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -363,6 +363,31 @@ class TestParallelOps(iotests.QMPTestCase):
         self.wait_until_completed()
         self.assert_no_active_block_jobs()
=20
+    # In this case the base node of the stream job is the commit job's
+    # filter node.  stream does not have a real dependency on its base
+    # node, so even though commit removes it when it is done, there is
+    # no conflict.
+    def test_overlapping_5(self):
+        self.assert_no_active_block_jobs()
+
+        # Commit from node2 into node0
+        result =3D self.vm.qmp('block-commit', device=3D'drive0',
+                             top_node=3D'node2', base_node=3D'node0',
+                             filter_node_name=3D'commit-filter', speed=3D=
1024*1024)
+        self.assert_qmp(result, 'return', {})
+
+        # Stream from node2 into node4
+        result =3D self.vm.qmp('block-stream', device=3D'node4',
+                             base_node=3D'commit-filter', job_id=3D'node=
4')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('block-job-set-speed', device=3D'drive0',=
 speed=3D0)
+        self.assert_qmp(result, 'return', {})
+
+        self.vm.run_job(job=3D'drive0', auto_dismiss=3DTrue, use_log=3DF=
alse)
+        self.vm.run_job(job=3D'node4', auto_dismiss=3DTrue, use_log=3DFa=
lse)
+        self.assert_no_active_block_jobs()
+
     # Test a block-stream and a block-commit job in parallel
     # Here the stream job is supposed to finish quickly in order to repr=
oduce
     # the scenario that triggers the bug fixed in 3d5d319e1221 and 1a63a=
907507
diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
index 4fd1c2dcd2..5eb508de07 100644
--- a/tests/qemu-iotests/030.out
+++ b/tests/qemu-iotests/030.out
@@ -1,5 +1,5 @@
-.........................
+..........................
 ----------------------------------------------------------------------
-Ran 25 tests
+Ran 26 tests
=20
 OK
--=20
2.21.0


