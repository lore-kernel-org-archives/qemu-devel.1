Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7170C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF57920842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF57920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOx7-0007y0-RX
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8Q-00059e-Hz
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8P-0008Dj-Az
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO8M-0008CH-Qn; Tue, 01 Oct 2019 15:48:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 15E7C2541;
 Tue,  1 Oct 2019 19:48:30 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A375C5C1D4;
 Tue,  1 Oct 2019 19:48:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 31/67] iotests/148: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:39 +0200
Message-Id: <20191001194715.2796-32-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 01 Oct 2019 19:48:30 +0000 (UTC)
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
 tests/qemu-iotests/148 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/148 b/tests/qemu-iotests/148
index 8c11c53cba..a6df0ed983 100755
--- a/tests/qemu-iotests/148
+++ b/tests/qemu-iotests/148
@@ -21,6 +21,7 @@
=20
 import os
 import iotests
+from iotests import create_test_image, remove_test_image
=20
 imgs =3D (os.path.join(iotests.test_dir, 'quorum0.img'),
         os.path.join(iotests.test_dir, 'quorum1.img'),
@@ -51,7 +52,7 @@ sector =3D "%d"
         driveopts =3D ['driver=3Dquorum', 'vote-threshold=3D2']
         driveopts.append('read-pattern=3D%s' % self.read_pattern)
         for i in range(len(imgs)):
-            iotests.qemu_img('create', '-f', iotests.imgfmt, imgs[i], '1=
M')
+            create_test_image(imgs[i], '1M')
             self.create_blkdebug_file(img_conf[i], i + offset)
             driveopts.append('children.%d.driver=3D%s' % (i, iotests.img=
fmt))
             driveopts.append('children.%d.file.driver=3Dblkdebug' % i)
@@ -65,7 +66,7 @@ sector =3D "%d"
     def tearDown(self):
         self.vm.shutdown()
         for i in range(len(imgs)):
-            os.remove(imgs[i])
+            remove_test_image(imgs[i])
             os.remove(img_conf[i])
=20
     def do_check_event(self, node, sector =3D 0):
--=20
2.21.0


