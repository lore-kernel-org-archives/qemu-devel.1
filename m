Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8672C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5194D20C01
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5194D20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLCm-0003PL-JU
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKq9-00018U-CE
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKq7-0004ib-RQ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKq1-0004f1-Qu; Fri, 20 Sep 2019 11:28:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA1B218C8919;
 Fri, 20 Sep 2019 15:28:48 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 732DF5D6A7;
 Fri, 20 Sep 2019 15:28:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 18/22] iotests: Resolve TODOs in 041
Date: Fri, 20 Sep 2019 17:28:00 +0200
Message-Id: <20190920152804.12875-19-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Fri, 20 Sep 2019 15:28:48 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041 | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index d91f538276..ca126de3ff 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -921,8 +921,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
=20
         self.complete_and_wait(drive=3D"job0")
         self.assert_has_block_node("repair0", quorum_repair_img)
-        # TODO: a better test requiring some QEMU infrastructure will be=
 added
-        #       to check that this file is really driven by quorum
+        self.vm.assert_block_path('quorum0/children.1', 'repair0')
         self.vm.shutdown()
         self.assertTrue(iotests.compare_images(quorum_img2, quorum_repai=
r_img),
                         'target image does not match source after mirror=
ing')
@@ -1074,9 +1073,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
=20
         self.complete_and_wait('job0')
         self.assert_has_block_node("repair0", quorum_repair_img)
-        # TODO: a better test requiring some QEMU infrastructure will be=
 added
-        #       to check that this file is really driven by quorum
-        self.vm.shutdown()
+        self.vm.assert_block_path('quorum0/children.1', 'repair0')
=20
 # Test mirroring with a source that does not have any parents (not even =
a
 # BlockBackend)
--=20
2.21.0


