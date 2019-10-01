Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8754BECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E443215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E443215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPDM-0005Ds-Rh
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO9H-0006GZ-7C
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO9G-0000H0-5R
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO9D-0000FG-MH; Tue, 01 Oct 2019 15:49:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE8FB2A09D2;
 Tue,  1 Oct 2019 19:49:22 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89D69261D0;
 Tue,  1 Oct 2019 19:49:22 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 54/67] iotests/236: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:47:02 +0200
Message-Id: <20191001194715.2796-55-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 01 Oct 2019 19:49:23 +0000 (UTC)
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
 tests/qemu-iotests/236 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
index b88779eb0b..ef1d732510 100755
--- a/tests/qemu-iotests/236
+++ b/tests/qemu-iotests/236
@@ -20,7 +20,7 @@
 # owner=3Djsnow@redhat.com
=20
 import iotests
-from iotests import log
+from iotests import log, create_test_image
=20
 iotests.script_initialize(supported_fmts=3D['generic'])
 size =3D 64 * 1024 * 1024
@@ -41,11 +41,11 @@ def query_bitmaps(vm):
     return { "bitmaps": { device['device']: device.get('dirty-bitmaps', =
[]) for
                           device in res['return'] } }
=20
-with iotests.FilePath('img') as img_path, \
+with iotests.ImagePath('img') as img_path, \
      iotests.VM() as vm:
=20
     log('--- Preparing image & VM ---\n')
-    iotests.qemu_img_create('-f', iotests.imgfmt, img_path, str(size))
+    create_test_image(img_path, size)
     vm.add_drive(img_path)
     vm.launch()
=20
--=20
2.21.0


