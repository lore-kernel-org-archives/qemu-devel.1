Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F445C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8A821906
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8A821906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPiF-00075b-I3
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO9B-00069F-2W
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO99-0000D1-3k
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43950)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO93-00007Z-1B; Tue, 01 Oct 2019 15:49:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 664113090FC9;
 Tue,  1 Oct 2019 19:49:11 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02D2D5C1D4;
 Tue,  1 Oct 2019 19:49:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 49/67] iotests/222: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:57 +0200
Message-Id: <20191001194715.2796-50-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 01 Oct 2019 19:49:11 +0000 (UTC)
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
 tests/qemu-iotests/222 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
index ffa88d4bb9..7ae76c1be1 100644
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -22,7 +22,7 @@
 # Creator/Owner: John Snow <jsnow@redhat.com>
=20
 import iotests
-from iotests import log, qemu_img, qemu_io, qemu_io_silent
+from iotests import log, create_test_image, qemu_io, qemu_io_silent
=20
 iotests.script_initialize(supported_fmts=3D['qcow2', 'qcow', 'qed', 'vmd=
k',
                                           'vhdx', 'raw'],
@@ -46,16 +46,16 @@ remainder =3D [("0xd5", "0x108000",  "32k"), # Right-=
end of partial-left [1]
              ("0xdc", "32M",       "32k"), # Left-end of partial-right [=
2]
              ("0xcd", "0x3ff0000", "64k")] # patterns[3]
=20
-with iotests.FilePath('base.img') as base_img_path, \
-     iotests.FilePath('fleece.img') as fleece_img_path, \
+with iotests.ImagePath('base.img') as base_img_path, \
+     iotests.ImagePath('fleece.img') as fleece_img_path, \
      iotests.FilePath('nbd.sock') as nbd_sock_path, \
      iotests.VM() as vm:
=20
     log('--- Setting up images ---')
     log('')
=20
-    assert qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M'=
) =3D=3D 0
-    assert qemu_img('create', '-f', "qcow2", fleece_img_path, '64M') =3D=
=3D 0
+    assert create_test_image(base_img_path, '64M') =3D=3D 0
+    assert create_test_image(fleece_img_path, '64M', fmt=3D'qcow2') =3D=3D=
 0
=20
     for p in patterns:
         qemu_io('-f', iotests.imgfmt,
--=20
2.21.0


