Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C69ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7175E2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7175E2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPMC-0005D8-9u
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO9D-0006AW-1r
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO9B-0000E6-0U
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36220)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO95-00009Z-0V; Tue, 01 Oct 2019 15:49:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8A99811D8;
 Tue,  1 Oct 2019 19:49:13 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6403D60C83;
 Tue,  1 Oct 2019 19:49:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 50/67] iotests/224: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:58 +0200
Message-Id: <20191001194715.2796-51-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 01 Oct 2019 19:49:13 +0000 (UTC)
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
 tests/qemu-iotests/224 | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/224 b/tests/qemu-iotests/224
index e227d3ab3c..e9f5729c33 100755
--- a/tests/qemu-iotests/224
+++ b/tests/qemu-iotests/224
@@ -21,8 +21,9 @@
 # Creator/Owner: Max Reitz <mreitz@redhat.com>
=20
 import iotests
-from iotests import log, qemu_img, qemu_io_silent, filter_qmp_testfiles,=
 \
-                    filter_qmp_imgfmt, filter_json_filename
+from iotests import log, create_test_image, qemu_io_silent, \
+                    filter_qmp_testfiles, filter_qmp_imgfmt, \
+                    filter_json_filename
 import json
 import re
=20
@@ -47,17 +48,14 @@ for filter_node_name in False, True:
     log('--- filter_node_name: %s ---' % filter_node_name)
     log('')
=20
-    with iotests.FilePath('base.img') as base_img_path, \
-         iotests.FilePath('mid.img') as mid_img_path, \
-         iotests.FilePath('top.img') as top_img_path, \
+    with iotests.ImagePath('base.img') as base_img_path, \
+         iotests.ImagePath('mid.img') as mid_img_path, \
+         iotests.ImagePath('top.img') as top_img_path, \
          iotests.VM() as vm:
=20
-        assert qemu_img('create', '-f', iotests.imgfmt,
-                        base_img_path, '64M') =3D=3D 0
-        assert qemu_img('create', '-f', iotests.imgfmt, '-b', base_img_p=
ath,
-                        mid_img_path) =3D=3D 0
-        assert qemu_img('create', '-f', iotests.imgfmt, '-b', mid_img_pa=
th,
-                        top_img_path) =3D=3D 0
+        assert create_test_image(base_img_path, '64M') =3D=3D 0
+        assert create_test_image(mid_img_path, backing_file=3Dbase_img_p=
ath) =3D=3D 0
+        assert create_test_image(top_img_path, backing_file=3Dmid_img_pa=
th) =3D=3D 0
=20
         # Something to commit
         assert qemu_io_silent(mid_img_path, '-c', 'write -P 1 0 1M') =3D=
=3D 0
--=20
2.21.0


