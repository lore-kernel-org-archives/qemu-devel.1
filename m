Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A53C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2482B206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2482B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPor-0001kl-T5
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO9D-0006AU-2b
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO9A-0000E1-WE
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO96-0000BM-V4; Tue, 01 Oct 2019 15:49:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 20909309BF02;
 Tue,  1 Oct 2019 19:49:16 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADBDE60E1C;
 Tue,  1 Oct 2019 19:49:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 51/67] iotests/228: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:59 +0200
Message-Id: <20191001194715.2796-52-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 01 Oct 2019 19:49:16 +0000 (UTC)
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
 tests/qemu-iotests/228 | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
index e507db4f27..ad7966fc8f 100755
--- a/tests/qemu-iotests/228
+++ b/tests/qemu-iotests/228
@@ -21,8 +21,9 @@
 # Creator/Owner: Max Reitz <mreitz@redhat.com>
=20
 import iotests
-from iotests import log, qemu_img, filter_testfiles, filter_imgfmt, \
-        filter_qmp_testfiles, filter_qmp_imgfmt, filter_json_filename
+from iotests import log, create_test_image, remove_test_image, \
+        filter_testfiles, filter_imgfmt, filter_qmp_testfiles, \
+        filter_qmp_imgfmt, filter_json_filename
=20
 # Need backing file and change-backing-file support
 iotests.script_initialize(supported_fmts=3D['qcow2', 'qed'])
@@ -46,14 +47,14 @@ def log_node_info(node):
     log('')
=20
=20
-with iotests.FilePath('base.img') as base_img_path, \
-     iotests.FilePath('top.img') as top_img_path, \
+with iotests.ImagePath('base.img') as base_img_path, \
+     iotests.ImagePath('top.img') as top_img_path, \
      iotests.VM() as vm:
=20
-    assert qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M'=
) =3D=3D 0
+    assert create_test_image(base_img_path, '64M') =3D=3D 0
     # Choose a funny way to describe the backing filename
-    assert qemu_img('create', '-f', iotests.imgfmt, '-b',
-                    'file:' + base_img_path, top_img_path) =3D=3D 0
+    assert create_test_image(top_img_path,
+                             backing_file=3D('file:' + base_img_path)) =3D=
=3D 0
=20
     vm.launch()
=20
@@ -167,8 +168,8 @@ with iotests.FilePath('base.img') as base_img_path, \
     # (because qemu cannot "canonicalize"/"resolve" the backing
     # filename unless the backing file is opened implicitly with the
     # overlay)
-    assert qemu_img('create', '-f', iotests.imgfmt, '-b', base_img_path,
-                    top_img_path) =3D=3D 0
+    remove_test_image(top_img_path)
+    assert create_test_image(top_img_path, backing_file=3Dbase_img_path)=
 =3D=3D 0
=20
     # You can only reliably override backing options by using a node
     # reference (or by specifying file.filename, but, well...)
--=20
2.21.0


