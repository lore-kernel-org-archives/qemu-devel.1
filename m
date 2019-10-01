Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CADECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD72215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD72215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFP2n-0004sD-SM
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8m-0005ZO-VA
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8l-0008QV-SU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO8j-0008P2-P1; Tue, 01 Oct 2019 15:48:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0A33310C094A;
 Tue,  1 Oct 2019 19:48:53 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9684D60C5D;
 Tue,  1 Oct 2019 19:48:52 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 41/67] iotests/202: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:49 +0200
Message-Id: <20191001194715.2796-42-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 01 Oct 2019 19:48:53 +0000 (UTC)
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
 tests/qemu-iotests/202 | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/202 b/tests/qemu-iotests/202
index 1271ac9459..f2a77fbe9b 100755
--- a/tests/qemu-iotests/202
+++ b/tests/qemu-iotests/202
@@ -23,18 +23,19 @@
 # against regressions.
=20
 import iotests
+from iotests import create_test_image
=20
 iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
-with iotests.FilePath('disk0.img') as disk0_img_path, \
-     iotests.FilePath('disk1.img') as disk1_img_path, \
+with iotests.ImagePath('disk0.img') as disk0_img_path, \
+     iotests.ImagePath('disk1.img') as disk1_img_path, \
      iotests.FilePath('disk0-snap.img') as disk0_snap_img_path, \
      iotests.FilePath('disk1-snap.img') as disk1_snap_img_path, \
      iotests.VM() as vm:
=20
     img_size =3D '10M'
-    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, disk0_img_path=
, img_size)
-    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, disk1_img_path=
, img_size)
+    create_test_image(disk0_img_path, img_size)
+    create_test_image(disk1_img_path, img_size)
=20
     iotests.log('Launching VM...')
     vm.launch()
--=20
2.21.0


