Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC73FC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 11:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931C121901
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 11:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931C121901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsiU-0006Yn-Qx
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 07:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1hpsiK-000666-IB
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hpsiJ-0003Ke-Am
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:12:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hpsiG-000380-Ld; Tue, 23 Jul 2019 07:12:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DD7B830BD1BC;
 Tue, 23 Jul 2019 11:12:06 +0000 (UTC)
Received: from thuth.com (reserved-198-198.str.redhat.com [10.33.198.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 474AA5C234;
 Tue, 23 Jul 2019 11:12:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org,
	alex.bennee@linaro.org
Date: Tue, 23 Jul 2019 13:12:01 +0200
Message-Id: <20190723111201.1926-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 23 Jul 2019 11:12:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] tests/qemu-iotests: Don't use 'seq' in the
 iotests
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
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'seq' command is not available by default on OpenBSD, so these
iotests are currently failing there. It could be installed as 'gseq'
from the coreutils package - but since it is using a different name
there and we are running the iotests with the "bash" shell anyway,
let's simply use the built-in double parentheses for the for-loops
instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/007            | 2 +-
 tests/qemu-iotests/011            | 2 +-
 tests/qemu-iotests/032            | 2 +-
 tests/qemu-iotests/035            | 2 +-
 tests/qemu-iotests/037            | 2 +-
 tests/qemu-iotests/046            | 2 +-
 tests/qemu-iotests/common.pattern | 4 ++--
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index 6abd402423..7d3544b479 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -48,7 +48,7 @@ echo
 echo "creating image"
 _make_test_img 1M
=20
-for i in `seq 1 10`; do
+for ((i=3D1;i<=3D10;i++)); do
     echo "savevm $i"
     $QEMU -nographic -hda "$TEST_IMG" -serial none -monitor stdio >/dev/=
null 2>&1 <<EOF
 savevm test-$i
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index 8b1fce069a..56f704b5b9 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -49,7 +49,7 @@ _make_test_img $size
=20
 echo
 echo "overlapping I/O"
-for i in `seq 1 10`; do
+for ((i=3D1;i<=3D10;i++)); do
     let mb=3D1024*1024
     let off1=3D$i*$mb
     let off2=3D$off1+512
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index 23c216c549..988a8c5d8f 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -52,7 +52,7 @@ _make_test_img 64M
=20
 # Allocate every other cluster so that afterwards a big write request wi=
ll
 # actually loop a while and issue many I/O requests for the lower layer
-for i in $(seq 0 128 4096); do echo "write ${i}k 64k"; done | $QEMU_IO "=
$TEST_IMG" | _filter_qemu_io
+for ((i=3D0;i<=3D4096;i+=3D128)); do echo "write ${i}k 64k"; done | $QEM=
U_IO "$TEST_IMG" | _filter_qemu_io
=20
 echo
 echo =3D=3D=3D AIO request during close =3D=3D=3D
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index ad6fa3115a..d950a0dd1e 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -49,7 +49,7 @@ echo "creating image"
 _make_test_img $size
=20
 generate_requests() {
-    for i in $(seq 0 63); do
+    for ((i=3D0;i<=3D63;i++)); do
         echo "aio_write ${i}M 512"
         echo "aio_write ${i}M 512"
         echo "aio_write ${i}M 512"
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index 819a2a52d2..4946b9be92 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -61,7 +61,7 @@ backing_io()
     local pattern=3D0
     local cur_sec=3D0
=20
-    for i in $(seq 0 $((sectors - 1))); do
+    for ((i=3D0;i<=3D$((sectors - 1));i++)); do
         cur_sec=3D$((offset / 512 + i))
         pattern=3D$(( ( (cur_sec % 256) + (cur_sec / 256)) % 256 ))
=20
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 543355c64f..4e03ead7b1 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -55,7 +55,7 @@ backing_io()
     local pattern=3D0
     local cur_sec=3D0
=20
-    for i in $(seq 0 $((sectors - 1))); do
+    for ((i=3D0;i<=3D$((sectors - 1));i++)); do
         cur_sec=3D$((offset / 65536 + i))
         pattern=3D$(( ( (cur_sec % 128) + (cur_sec / 128)) % 128 ))
=20
diff --git a/tests/qemu-iotests/common.pattern b/tests/qemu-iotests/commo=
n.pattern
index 25aa0d01c1..4f5e5bcea0 100644
--- a/tests/qemu-iotests/common.pattern
+++ b/tests/qemu-iotests/common.pattern
@@ -22,7 +22,7 @@ do_is_allocated() {
     local step=3D$3
     local count=3D$4
=20
-    for i in `seq 1 $count`; do
+    for ((i=3D1;i<=3D$count;i++)); do
         echo alloc $(( start + (i - 1) * step )) $size
     done
 }
@@ -40,7 +40,7 @@ do_io() {
     local pattern=3D$6
=20
     echo =3D=3D=3D IO: pattern $pattern >&2
-    for i in `seq 1 $count`; do
+    for ((i=3D1;i<=3D$count;i++)); do
         echo $op -P $pattern $(( start + (i - 1) * step )) $size
     done
 }
--=20
2.21.0


