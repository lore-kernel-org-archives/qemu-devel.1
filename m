Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE903ECE58D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9782A2070B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9782A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHS5o-0008L6-HU
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 08:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iHRrs-0003P7-SP
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iHRrr-0005NU-4N
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:12:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iHRrn-0005L9-6e; Mon, 07 Oct 2019 08:11:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64391308FC22;
 Mon,  7 Oct 2019 12:11:54 +0000 (UTC)
Received: from localhost (unknown [10.36.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D5801001B39;
 Mon,  7 Oct 2019 12:11:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/16] tests/qemu-iotests: use AIOMODE with various tests
Date: Mon,  7 Oct 2019 13:09:36 +0100
Message-Id: <20191007120937.5862-16-stefanha@redhat.com>
In-Reply-To: <20191007120937.5862-1-stefanha@redhat.com>
References: <20191007120937.5862-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 07 Oct 2019 12:11:54 +0000 (UTC)
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
Cc: oleksandr@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@mail.ru>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/028 |  3 ++-
 tests/qemu-iotests/058 |  2 +-
 tests/qemu-iotests/089 |  4 ++--
 tests/qemu-iotests/091 |  7 ++++---
 tests/qemu-iotests/109 |  3 ++-
 tests/qemu-iotests/147 |  5 +++--
 tests/qemu-iotests/181 | 10 +++++-----
 tests/qemu-iotests/183 |  7 ++++---
 tests/qemu-iotests/185 | 17 ++++++++++++-----
 tests/qemu-iotests/200 |  3 ++-
 tests/qemu-iotests/201 | 10 +++++-----
 11 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 71301ec6e5..eb69ef7872 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -108,7 +108,8 @@ echo block-backup
 echo
=20
 qemu_comm_method=3D"monitor"
-_launch_qemu -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk
+_launch_qemu -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},aio=3D${AI=
OMODE},\
+id=3Ddisk
 h=3D$QEMU_HANDLE
 if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
     QEMU_COMM_TIMEOUT=3D7
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 8c3212a72f..38d1ed90c0 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -64,7 +64,7 @@ nbd_snapshot_img=3D"nbd:unix:$nbd_unix_socket"
 converted_image=3D$TEST_IMG.converted
=20
 # Use -f raw instead of -f $IMGFMT for the NBD connection
-QEMU_IO_NBD=3D"$QEMU_IO -f raw --cache=3D$CACHEMODE"
+QEMU_IO_NBD=3D"$QEMU_IO -f raw --cache=3D$CACHEMODE --aio=3D$AIOMODE"
=20
 echo
 echo "=3D=3D preparing image =3D=3D"
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index ad029f1f09..059ad75e28 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -64,7 +64,7 @@ $QEMU_IO -c 'write -P 42 0 512' -c 'write -P 23 512 512=
' \
=20
 $QEMU_IMG convert -f raw -O $IMGFMT "$TEST_IMG.base" "$TEST_IMG"
=20
-$QEMU_IO_PROG --cache $CACHEMODE \
+$QEMU_IO_PROG --cache $CACHEMODE --aio $AIOMODE \
          -c 'read -P 42 0 512' -c 'read -P 23 512 512' \
          -c 'read -P 66 1024 512' "json:{
     \"driver\": \"$IMGFMT\",
@@ -111,7 +111,7 @@ $QEMU_IO -c 'write -P 42 0x38000 512' "$TEST_IMG" | _=
filter_qemu_io
=20
 # The "image.filename" part tests whether "a": { "b": "c" } and "a.b": "=
c" do
 # the same (which they should).
-$QEMU_IO_PROG --cache $CACHEMODE \
+$QEMU_IO_PROG --cache $CACHEMODE --aio $AIOMODE  \
      -c 'read -P 42 0x38000 512' "json:{
     \"driver\": \"$IMGFMT\",
     \"file\": {
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index f4b44659ae..9fd45a2c94 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -60,14 +60,15 @@ echo =3D=3D=3D Starting QEMU VM1 =3D=3D=3D
 echo
=20
 qemu_comm_method=3D"monitor"
-_launch_qemu -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk
+_launch_qemu -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},aio=3D${AI=
OMODE},\
+             id=3Ddisk
 h1=3D$QEMU_HANDLE
=20
 echo
 echo =3D=3D=3D Starting QEMU VM2 =3D=3D=3D
 echo
-_launch_qemu -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk =
\
-             -incoming "exec: cat '${MIG_FIFO}'"
+_launch_qemu -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},aio=3D${AI=
OMODE},\
+             id=3Ddisk -incoming "exec: cat '${MIG_FIFO}'"
 h2=3D$QEMU_HANDLE
=20
 echo
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index 9897ceb6cd..451709689a 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -52,7 +52,8 @@ run_qemu()
     local qmp_format=3D"$3"
     local qmp_event=3D"$4"
=20
-    _launch_qemu -drive file=3D"${source_img}",format=3Draw,cache=3D${CA=
CHEMODE},id=3Dsrc
+    _launch_qemu -drive file=3D"${source_img}",format=3Draw,cache=3D${CA=
CHEMODE},\
+                 aio=3D${AIOMODE},id=3Dsrc
     _send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'qmp_capabilities' }" "ret=
urn"
=20
     _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index ab8480b9a4..6bc50ff5d9 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -24,7 +24,7 @@ import socket
 import stat
 import time
 import iotests
-from iotests import cachemode, imgfmt, qemu_img, qemu_nbd, qemu_nbd_earl=
y_pipe
+from iotests import cachemode, aiomode, imgfmt, qemu_img, qemu_nbd, qemu=
_nbd_early_pipe
=20
 NBD_PORT_START      =3D 32768
 NBD_PORT_END        =3D NBD_PORT_START + 1024
@@ -134,7 +134,8 @@ class BuiltinNBD(NBDBlockdevAddBase):
         self.server.add_drive_raw('if=3Dnone,id=3Dnbd-export,' +
                                   'file=3D%s,' % test_img +
                                   'format=3D%s,' % imgfmt +
-                                  'cache=3D%s' % cachemode)
+                                  'cache=3D%s' % cachemode +
+                                  'aio=3D%s' % aiomode)
         self.server.launch()
=20
     def tearDown(self):
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index e317e63422..547c1b47b0 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -58,21 +58,21 @@ qemu_comm_method=3D"monitor"
=20
 if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
     _launch_qemu \
-        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk
+        -drive "${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,id=3Ddi=
sk
 else
     _launch_qemu \
-        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFM=
T,id=3Ddisk
+        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,=
driver=3D$IMGFMT,id=3Ddisk
 fi
 src=3D$QEMU_HANDLE
=20
 if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
     _launch_qemu \
-        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk \
+        -drive "${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,id=3Ddi=
sk \
         -incoming "unix:${MIG_SOCKET}"
 else
     _launch_qemu \
-        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFM=
T,id=3Ddisk \
-        -incoming "unix:${MIG_SOCKET}"
+        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,=
driver=3D$IMGFMT,\
+        id=3Ddisk -incoming "unix:${MIG_SOCKET}"
 fi
 dest=3D$QEMU_HANDLE
=20
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index 04fb344d08..057fdf0514 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -56,13 +56,14 @@ echo
 qemu_comm_method=3D"qmp"
=20
 _launch_qemu \
-    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,driver=3D$IMGFMT,id=3D=
disk
+    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,aio=3D$AIOMODE,\
+    driver=3D$IMGFMT,id=3Ddisk
 src=3D$QEMU_HANDLE
 _send_qemu_cmd $src "{ 'execute': 'qmp_capabilities' }" 'return'
=20
 _launch_qemu \
-    -drive file=3D"${TEST_IMG}.dest",cache=3D$CACHEMODE,driver=3D$IMGFMT=
,id=3Ddisk \
-    -incoming "unix:${MIG_SOCKET}"
+    -drive file=3D"${TEST_IMG}.dest",cache=3D$CACHEMODE,aio=3D$AIOMODE,\
+    driver=3D$IMGFMT,id=3Ddisk -incoming "unix:${MIG_SOCKET}"
 dest=3D$QEMU_HANDLE
 _send_qemu_cmd $dest "{ 'execute': 'qmp_capabilities' }" 'return'
=20
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 454ff600cc..1c74a0ef5a 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -54,7 +54,8 @@ echo
 qemu_comm_method=3D"qmp"
=20
 _launch_qemu \
-    -drive file=3D"${TEST_IMG}.base",cache=3D$CACHEMODE,driver=3D$IMGFMT=
,id=3Ddisk
+    -drive file=3D"${TEST_IMG}.base",cache=3D$CACHEMODE,aio=3D$AIOMODE,\
+    driver=3D$IMGFMT,id=3Ddisk
 h=3D$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
=20
@@ -125,7 +126,8 @@ echo =3D=3D=3D Start active commit job and exit qemu =
=3D=3D=3D
 echo
=20
 _launch_qemu \
-    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,driver=3D$IMGFMT,id=3D=
disk
+    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,aio=3D$AIOMODE,driver=
=3D$IMGFMT,\
+    id=3Ddisk
 h=3D$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
=20
@@ -147,7 +149,8 @@ echo =3D=3D=3D Start mirror job and exit qemu =3D=3D=3D
 echo
=20
 _launch_qemu \
-    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,driver=3D$IMGFMT,id=3D=
disk
+    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,aio=3D$AIOMODE,driver=
=3D$IMGFMT,\
+    id=3Ddisk
 h=3D$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
=20
@@ -172,7 +175,9 @@ echo =3D=3D=3D Start backup job and exit qemu =3D=3D=3D
 echo
=20
 _launch_qemu \
-    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,driver=3D$IMGFMT,id=3D=
disk
+    _launch_qemu \
+    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,aio=3D$AIOMODE,driver=
=3D$IMGFMT,\
+    id=3Ddisk
 h=3D$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
=20
@@ -196,7 +201,9 @@ echo =3D=3D=3D Start streaming job and exit qemu =3D=3D=
=3D
 echo
=20
 _launch_qemu \
-    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,driver=3D$IMGFMT,id=3D=
disk
+    _launch_qemu \
+    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,aio=3D$AIOMODE,driver=
=3D$IMGFMT,\
+    id=3Ddisk
 h=3D$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
=20
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index 72d431f251..b554dd947b 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -66,7 +66,8 @@ echo =3D=3D=3D Starting QEMU VM =3D=3D=3D
 echo
 qemu_comm_method=3D"qmp"
 _launch_qemu -object iothread,id=3Diothread0 $virtio_scsi \
-             -drive file=3D"${TEST_IMG}",media=3Ddisk,if=3Dnone,cache=3D=
$CACHEMODE,id=3Ddrive_sysdisk,format=3D$IMGFMT \
+             -drive file=3D"${TEST_IMG}",media=3Ddisk,if=3Dnone,cache=3D=
$CACHEMODE,\
+             aio=3D$AIOMODE,id=3Ddrive_sysdisk,format=3D$IMGFMT \
              -device scsi-hd,drive=3Ddrive_sysdisk,bus=3Dscsi0.0,id=3Dsy=
sdisk,bootindex=3D0
 h1=3D$QEMU_HANDLE
=20
diff --git a/tests/qemu-iotests/201 b/tests/qemu-iotests/201
index 7abf740fe4..48837c4f30 100755
--- a/tests/qemu-iotests/201
+++ b/tests/qemu-iotests/201
@@ -58,21 +58,21 @@ qemu_comm_method=3D"monitor"
=20
 if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
     _launch_qemu \
-        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk
+        -drive "${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,id=3Ddi=
sk
 else
     _launch_qemu \
-        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFM=
T,id=3Ddisk
+        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,=
driver=3D$IMGFMT,id=3Ddisk
 fi
 src=3D$QEMU_HANDLE
=20
 if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
     _launch_qemu \
-        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk \
+        -drive "${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,id=3Ddi=
sk \
         -incoming "unix:${MIG_SOCKET}"
 else
     _launch_qemu \
-        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFM=
T,id=3Ddisk \
-        -incoming "unix:${MIG_SOCKET}"
+        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,=
driver=3D$IMGFMT,\
+        id=3Ddisk -incoming "unix:${MIG_SOCKET}"
 fi
 dest=3D$QEMU_HANDLE
=20
--=20
2.21.0


