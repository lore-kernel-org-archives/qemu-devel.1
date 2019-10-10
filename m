Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387DCC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B36214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B36214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIaMQ-0000JS-Rp
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 11:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIaJl-0005xv-CC
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIaJk-0004T3-80
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:25:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIaJg-0004Pt-BW; Thu, 10 Oct 2019 11:25:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96D60970F1;
 Thu, 10 Oct 2019 15:25:22 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 121BD5C1B5;
 Thu, 10 Oct 2019 15:25:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 07/23] iotests/140: Create socket in $SOCK_DIR
Date: Thu, 10 Oct 2019 17:24:41 +0200
Message-Id: <20191010152457.17713-8-mreitz@redhat.com>
In-Reply-To: <20191010152457.17713-1-mreitz@redhat.com>
References: <20191010152457.17713-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 10 Oct 2019 15:25:22 +0000 (UTC)
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
 tests/qemu-iotests/140     | 8 ++++----
 tests/qemu-iotests/140.out | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index b965b1dd5d..8d2ce5d9e3 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -34,7 +34,7 @@ _cleanup()
 {
     _cleanup_qemu
     _cleanup_test_img
-    rm -f "$TEST_DIR/nbd"
+    rm -f "$SOCK_DIR/nbd"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -69,7 +69,7 @@ _send_qemu_cmd $QEMU_HANDLE \
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'nbd-server-start',
        'arguments': { 'addr': { 'type': 'unix',
-                                'data': { 'path': '$TEST_DIR/nbd' }}}}" =
\
+                                'data': { 'path': '$SOCK_DIR/nbd' }}}}" =
\
     'return'
=20
 _send_qemu_cmd $QEMU_HANDLE \
@@ -78,7 +78,7 @@ _send_qemu_cmd $QEMU_HANDLE \
     'return'
=20
 $QEMU_IO_PROG -f raw -r -c 'read -P 42 0 64k' \
-    "nbd+unix:///drv?socket=3D$TEST_DIR/nbd" 2>&1 \
+    "nbd+unix:///drv?socket=3D$SOCK_DIR/nbd" 2>&1 \
     | _filter_qemu_io | _filter_nbd
=20
 _send_qemu_cmd $QEMU_HANDLE \
@@ -87,7 +87,7 @@ _send_qemu_cmd $QEMU_HANDLE \
     'return'
=20
 $QEMU_IO_PROG -f raw -r -c close \
-    "nbd+unix:///drv?socket=3D$TEST_DIR/nbd" 2>&1 \
+    "nbd+unix:///drv?socket=3D$SOCK_DIR/nbd" 2>&1 \
     | _filter_qemu_io | _filter_nbd
=20
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 67fe44a3e3..2511eb7369 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -8,7 +8,7 @@ wrote 65536/65536 bytes at offset 0
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
-qemu-io: can't open device nbd+unix:///drv?socket=3DTEST_DIR/nbd: Reques=
ted export not available
+qemu-io: can't open device nbd+unix:///drv?socket=3DSOCK_DIR/nbd: Reques=
ted export not available
 server reported: export 'drv' not present
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
--=20
2.21.0


