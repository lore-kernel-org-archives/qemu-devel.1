Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FB7ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E541920842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E541920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOx9-00084q-US
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8G-0004yO-Q8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8F-00088Z-PJ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO87-00083v-Jx; Tue, 01 Oct 2019 15:48:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0120B2A09A1;
 Tue,  1 Oct 2019 19:48:14 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E2C3100197A;
 Tue,  1 Oct 2019 19:48:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 24/67] iotests/096: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:32 +0200
Message-Id: <20191001194715.2796-25-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 01 Oct 2019 19:48:14 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/096 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/096 b/tests/qemu-iotests/096
index ab9cb47822..ee0cfbffe8 100755
--- a/tests/qemu-iotests/096
+++ b/tests/qemu-iotests/096
@@ -20,6 +20,7 @@
 #
=20
 import iotests
+from iotests import create_test_image, remove_test_image
 import os
=20
 class TestLiveSnapshot(iotests.QMPTestCase):
@@ -35,13 +36,13 @@ class TestLiveSnapshot(iotests.QMPTestCase):
         opts.append('throttling.group=3D%s' % self.group)
         opts.append('throttling.iops-total=3D%d' % self.iops)
         opts.append('throttling.iops-size=3D%d' % self.iops_size)
-        iotests.qemu_img('create', '-f', iotests.imgfmt, self.base_img, =
'100M')
+        create_test_image(self.base_img, '100M')
         self.vm =3D iotests.VM().add_drive(self.base_img, ','.join(opts)=
)
         self.vm.launch()
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(self.base_img)
+        remove_test_image(self.base_img)
         os.remove(self.target_img)
=20
     def checkConfig(self, active_layer):
--=20
2.21.0


