Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34F5C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:30:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971C12087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971C12087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48671 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO23T-0002JA-SI
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:30:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rp-000883-JR
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1ro-00048a-IT
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO1rl-00045E-0z; Tue, 07 May 2019 11:18:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4FEFE8553D;
	Tue,  7 May 2019 15:18:48 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D6E535D9CC;
	Tue,  7 May 2019 15:18:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 17:18:19 +0200
Message-Id: <20190507151819.17401-12-mreitz@redhat.com>
In-Reply-To: <20190507151819.17401-1-mreitz@redhat.com>
References: <20190507151819.17401-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 07 May 2019 15:18:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/11] iotests: Fix iotests 110 and 126
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A recent patch results in qemu-img reporting the backing file format of
vmdk images as vmdk.  This broke iotests 110 and 126.

Fixes: 7502be838e2fb62cc00f9e55f632e0b88ead5e6e
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190415154129.31021-1-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/110 | 10 +++++++---
 tests/qemu-iotests/126 | 10 +++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index fad672c1ae..33b169ffd4 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -53,8 +53,12 @@ TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
 _make_test_img -b "$TEST_IMG_REL.base" 64M
 # qemu should be able to reconstruct the filename, so relative backing n=
ames
 # should work
+# (We have to filter the backing file format because vmdk always
+# reports it (as vmdk), whereas other image formats would do so only
+# with the backing_fmt creation option, which neither vmdk nor qcow
+# support)
 TEST_IMG=3D"json:{'driver':'$IMGFMT','file':{'driver':'file','filename':=
'$TEST_IMG'}}" \
-    _img_info | _filter_img_info
+    _img_info | _filter_img_info | grep -v 'backing file format'
=20
 echo
 echo '=3D=3D=3D Non-reconstructable filename =3D=3D=3D'
@@ -78,7 +82,7 @@ TEST_IMG=3D"json:{
             }
         ]
     }
-}" _img_info | _filter_img_info
+}" _img_info | _filter_img_info | grep -v 'backing file format'
=20
 echo
 echo '=3D=3D=3D Backing name is always relative to the backed image =3D=3D=
=3D'
@@ -110,7 +114,7 @@ TEST_IMG=3D"json:{
             }
         ]
     }
-}" _img_info | _filter_img_info
+}" _img_info | _filter_img_info | grep -v 'backing file format'
=20
=20
 # success, all done
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index 96dc048d59..e3ee65c606 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -62,8 +62,12 @@ TOP_IMG=3D"$TEST_DIR/image:top.$IMGFMT"
 TEST_IMG=3D$BASE_IMG _make_test_img 64M
 TEST_IMG=3D$TOP_IMG _make_test_img -b ./image:base.$IMGFMT
=20
-# The default cluster size depends on the image format
-TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size'
+# (1) The default cluster size depends on the image format
+# (2) vmdk only supports vmdk backing files, so it always reports the
+#     format of its backing file as such (but neither it nor qcow
+#     support the backing_fmt creation option, so we cannot use that to
+#     harmonize the output across all image formats this test supports)
+TEST_IMG=3D$TOP_IMG _img_info | grep -ve 'cluster_size' -e 'backing file=
 format'
=20
 _rm_test_img "$BASE_IMG"
 _rm_test_img "$TOP_IMG"
@@ -79,7 +83,7 @@ TOP_IMG=3D"file:image:top.$IMGFMT"
 TEST_IMG=3D$BASE_IMG _make_test_img 64M
 TEST_IMG=3D$TOP_IMG _make_test_img -b "$BASE_IMG"
=20
-TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size'
+TEST_IMG=3D$TOP_IMG _img_info | grep -ve 'cluster_size' -e 'backing file=
 format'
=20
 _rm_test_img "$BASE_IMG"
 _rm_test_img "image:top.$IMGFMT"
--=20
2.20.1


