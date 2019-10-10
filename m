Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA0BC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D87F206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D87F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIaUb-0000rq-NL
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 11:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIaKM-0006jx-NS
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIaKL-0004ih-CI
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:26:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39836)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIaKI-0004hM-PD; Thu, 10 Oct 2019 11:26:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 05D5710C092E;
 Thu, 10 Oct 2019 15:26:02 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B86D50D04;
 Thu, 10 Oct 2019 15:26:01 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 20/23] iotests/223: Create socket in $SOCK_DIR
Date: Thu, 10 Oct 2019 17:24:54 +0200
Message-Id: <20191010152457.17713-21-mreitz@redhat.com>
In-Reply-To: <20191010152457.17713-1-mreitz@redhat.com>
References: <20191010152457.17713-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 10 Oct 2019 15:26:02 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/223 | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 2ba3d8124b..b5a80e50bb 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -28,7 +28,7 @@ _cleanup()
     nbd_server_stop
     _cleanup_test_img
     _cleanup_qemu
-    rm -f "$TEST_DIR/nbd"
+    rm -f "$SOCK_DIR/nbd"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -125,11 +125,11 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server=
-add",
   "arguments":{"device":"n"}}' "error" # Attempt add without server
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
   "arguments":{"addr":{"type":"unix",
-    "data":{"path":"'"$TEST_DIR/nbd"'"}}}}' "return"
+    "data":{"path":"'"$SOCK_DIR/nbd"'"}}}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
   "arguments":{"addr":{"type":"unix",
-    "data":{"path":"'"$TEST_DIR/nbd"1'"}}}}' "error" # Attempt second se=
rver
-$QEMU_NBD_PROG -L -k "$TEST_DIR/nbd"
+    "data":{"path":"'"$SOCK_DIR/nbd"1'"}}}}' "error" # Attempt second se=
rver
+$QEMU_NBD_PROG -L -k "$SOCK_DIR/nbd"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "bitmap":"b"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
@@ -145,14 +145,14 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server=
-add",
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "name":"n2", "writable":true,
   "bitmap":"b2"}}' "return"
-$QEMU_NBD_PROG -L -k "$TEST_DIR/nbd"
+$QEMU_NBD_PROG -L -k "$SOCK_DIR/nbd"
=20
 echo
 echo "=3D=3D=3D Contrast normal status to large granularity dirty-bitmap=
 =3D=3D=3D"
 echo
=20
 QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
-IMG=3D"driver=3Dnbd,export=3Dn,server.type=3Dunix,server.path=3D$TEST_DI=
R/nbd"
+IMG=3D"driver=3Dnbd,export=3Dn,server.type=3Dunix,server.path=3D$SOCK_DI=
R/nbd"
 $QEMU_IO -r -c 'r -P 0x22 512 512' -c 'r -P 0 512k 512k' -c 'r -P 0x11 1=
m 1m' \
   -c 'r -P 0x33 2m 2m' --image-opts "$IMG" | _filter_qemu_io
 $QEMU_IMG map --output=3Djson --image-opts \
@@ -164,7 +164,7 @@ echo
 echo "=3D=3D=3D Contrast to small granularity dirty-bitmap =3D=3D=3D"
 echo
=20
-IMG=3D"driver=3Dnbd,export=3Dn2,server.type=3Dunix,server.path=3D$TEST_D=
IR/nbd"
+IMG=3D"driver=3Dnbd,export=3Dn2,server.type=3Dunix,server.path=3D$SOCK_D=
IR/nbd"
 $QEMU_IMG map --output=3Djson --image-opts \
   "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b2" | _filter_qemu_img_map
=20
--=20
2.21.0


