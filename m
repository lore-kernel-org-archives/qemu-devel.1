Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A27CC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B41D2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B41D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDn1p-0003US-Ta
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDmmL-0003Lc-4N
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDmmJ-0007bC-Ti
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55884)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDmmH-0007Z7-8A; Fri, 27 Sep 2019 05:43:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 77EF5796E9;
 Fri, 27 Sep 2019 09:43:04 +0000 (UTC)
Received: from localhost (ovpn-204-76.brq.redhat.com [10.40.204.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D20E5D6B0;
 Fri, 27 Sep 2019 09:43:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 08/18] iotests: Replace IMGOPTS='' by --no-opts
Date: Fri, 27 Sep 2019 11:42:32 +0200
Message-Id: <20190927094242.11152-9-mreitz@redhat.com>
In-Reply-To: <20190927094242.11152-1-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 27 Sep 2019 09:43:04 +0000 (UTC)
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
 tests/qemu-iotests/071 | 4 ++--
 tests/qemu-iotests/174 | 2 +-
 tests/qemu-iotests/178 | 4 ++--
 tests/qemu-iotests/197 | 4 ++--
 tests/qemu-iotests/215 | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index fab526666b..4e31943244 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -58,7 +58,7 @@ echo
 echo "=3D=3D=3D Testing blkverify through filename =3D=3D=3D"
 echo
=20
-TEST_IMG=3D"$TEST_IMG.base" IMGOPTS=3D"" IMGFMT=3D"raw" _make_test_img $=
IMG_SIZE |\
+TEST_IMG=3D"$TEST_IMG.base" IMGFMT=3D"raw" _make_test_img --no-opts $IMG=
_SIZE |\
     _filter_imgfmt
 _make_test_img $IMG_SIZE
 $QEMU_IO -c "open -o driver=3Draw,file.driver=3Dblkverify,file.raw.filen=
ame=3D$TEST_IMG.base $TEST_IMG" \
@@ -73,7 +73,7 @@ echo
 echo "=3D=3D=3D Testing blkverify through file blockref =3D=3D=3D"
 echo
=20
-TEST_IMG=3D"$TEST_IMG.base" IMGOPTS=3D"" IMGFMT=3D"raw" _make_test_img $=
IMG_SIZE |\
+TEST_IMG=3D"$TEST_IMG.base" IMGFMT=3D"raw" _make_test_img --no-opts $IMG=
_SIZE |\
     _filter_imgfmt
 _make_test_img $IMG_SIZE
 $QEMU_IO -c "open -o driver=3Draw,file.driver=3Dblkverify,file.raw.filen=
ame=3D$TEST_IMG.base,file.test.driver=3D$IMGFMT,file.test.file.filename=3D=
$TEST_IMG" \
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index 0a952a73fd..e2f14a38c6 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -40,7 +40,7 @@ _unsupported_fmt raw
=20
=20
 size=3D256K
-IMGFMT=3Draw IMGKEYSECRET=3D IMGOPTS=3D _make_test_img $size | _filter_i=
mgfmt
+IMGFMT=3Draw IMGKEYSECRET=3D _make_test_img --no-opts $size | _filter_im=
gfmt
=20
 echo
 echo "=3D=3D reading wrong format should fail =3D=3D"
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 21231cadd3..75b5e8f314 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -62,8 +62,8 @@ $QEMU_IMG measure -O foo "$TEST_IMG" # unknown image fi=
le format
=20
 make_test_img_with_fmt() {
     # Shadow global variables within this function
-    local IMGFMT=3D"$1" IMGOPTS=3D""
-    _make_test_img "$2"
+    local IMGFMT=3D"$1"
+    _make_test_img --no-opts "$2"
 }
=20
 qemu_io_with_fmt() {
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 1d4f6786db..4d3d08ad6f 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -66,8 +66,8 @@ if [ "$IMGFMT" =3D "vpc" ]; then
 fi
 _make_test_img 4G
 $QEMU_IO -c "write -P 55 3G 1k" "$TEST_IMG" | _filter_qemu_io
-IMGPROTO=3Dfile IMGFMT=3Dqcow2 IMGOPTS=3D TEST_IMG_FILE=3D"$TEST_WRAP" \
-    _make_test_img -F "$IMGFMT" -b "$TEST_IMG" | _filter_img_create
+IMGPROTO=3Dfile IMGFMT=3Dqcow2 TEST_IMG_FILE=3D"$TEST_WRAP" \
+    _make_test_img --no-opts -F "$IMGFMT" -b "$TEST_IMG" | _filter_img_c=
reate
 $QEMU_IO -f qcow2 -c "write -z -u 1M 64k" "$TEST_WRAP" | _filter_qemu_io
=20
 # Ensure that a read of two clusters, but where one is already allocated=
,
diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
index 2eb377d682..55a1874dcd 100755
--- a/tests/qemu-iotests/215
+++ b/tests/qemu-iotests/215
@@ -63,8 +63,8 @@ if [ "$IMGFMT" =3D "vpc" ]; then
 fi
 _make_test_img 4G
 $QEMU_IO -c "write -P 55 3G 1k" "$TEST_IMG" | _filter_qemu_io
-IMGPROTO=3Dfile IMGFMT=3Dqcow2 IMGOPTS=3D TEST_IMG_FILE=3D"$TEST_WRAP" \
-    _make_test_img -F "$IMGFMT" -b "$TEST_IMG" | _filter_img_create
+IMGPROTO=3Dfile IMGFMT=3Dqcow2 TEST_IMG_FILE=3D"$TEST_WRAP" \
+    _make_test_img --no-opts -F "$IMGFMT" -b "$TEST_IMG" | _filter_img_c=
reate
 $QEMU_IO -f qcow2 -c "write -z -u 1M 64k" "$TEST_WRAP" | _filter_qemu_io
=20
 # Ensure that a read of two clusters, but where one is already allocated=
,
--=20
2.21.0


