Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17059ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1CF215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1CF215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPD1-0004tj-KJ
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8y-0005pQ-OY
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8x-00005y-M6
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38156)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO8v-0008WJ-8c; Tue, 01 Oct 2019 15:49:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8196D10CC207;
 Tue,  1 Oct 2019 19:49:04 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DA5160619;
 Tue,  1 Oct 2019 19:49:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 46/67] iotests/216: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:54 +0200
Message-Id: <20191001194715.2796-47-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Tue, 01 Oct 2019 19:49:04 +0000 (UTC)
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
 tests/qemu-iotests/216 | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/216 b/tests/qemu-iotests/216
index 7574bcc09f..18f2611da6 100755
--- a/tests/qemu-iotests/216
+++ b/tests/qemu-iotests/216
@@ -20,7 +20,7 @@
 # Creator/Owner: Max Reitz <mreitz@redhat.com>
=20
 import iotests
-from iotests import log, qemu_img, qemu_io_silent
+from iotests import log, create_test_image, qemu_io_silent
=20
 # Need backing file support
 iotests.script_initialize(supported_fmts=3D['qcow2', 'qcow', 'qed', 'vmd=
k'])
@@ -42,17 +42,16 @@ log('')
 # A COR filter node, however, can request the proper permissions for
 # its child and therefore is not hit by this issue.
=20
-with iotests.FilePath('base.img') as base_img_path, \
-     iotests.FilePath('top.img') as top_img_path, \
+with iotests.ImagePath('base.img') as base_img_path, \
+     iotests.ImagePath('top.img') as top_img_path, \
      iotests.VM() as vm:
=20
     log('--- Setting up images ---')
     log('')
=20
-    assert qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M'=
) =3D=3D 0
+    assert create_test_image(base_img_path, '64M') =3D=3D 0
     assert qemu_io_silent(base_img_path, '-c', 'write -P 1 0M 1M') =3D=3D=
 0
-    assert qemu_img('create', '-f', iotests.imgfmt, '-b', base_img_path,
-                    top_img_path) =3D=3D 0
+    assert create_test_image(top_img_path, backing_file=3Dbase_img_path)=
 =3D=3D 0
     assert qemu_io_silent(top_img_path,  '-c', 'write -P 2 1M 1M') =3D=3D=
 0
=20
     log('Done')
--=20
2.21.0


