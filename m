Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EF5C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC52206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC52206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIaQ3-00043M-Hb
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 11:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIaJo-0005zo-3M
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIaJm-0004Tg-4f
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:25:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIaJi-0004Qc-HW; Thu, 10 Oct 2019 11:25:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A0AE210C0946;
 Thu, 10 Oct 2019 15:25:25 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 186AE3DE5;
 Thu, 10 Oct 2019 15:25:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 08/23] iotests/143: Create socket in $SOCK_DIR
Date: Thu, 10 Oct 2019 17:24:42 +0200
Message-Id: <20191010152457.17713-9-mreitz@redhat.com>
In-Reply-To: <20191010152457.17713-1-mreitz@redhat.com>
References: <20191010152457.17713-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 10 Oct 2019 15:25:25 +0000 (UTC)
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
 tests/qemu-iotests/143     | 6 +++---
 tests/qemu-iotests/143.out | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index 92249ac8da..f649b36195 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -29,7 +29,7 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_qemu
-    rm -f "$TEST_DIR/nbd"
+    rm -f "$SOCK_DIR/nbd"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -51,12 +51,12 @@ _send_qemu_cmd $QEMU_HANDLE \
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'nbd-server-start',
        'arguments': { 'addr': { 'type': 'unix',
-                                'data': { 'path': '$TEST_DIR/nbd' }}}}" =
\
+                                'data': { 'path': '$SOCK_DIR/nbd' }}}}" =
\
     'return'
=20
 # This should just result in a client error, not in the server crashing
 $QEMU_IO_PROG -f raw -c quit \
-    "nbd+unix:///no_such_export?socket=3D$TEST_DIR/nbd" 2>&1 \
+    "nbd+unix:///no_such_export?socket=3D$SOCK_DIR/nbd" 2>&1 \
     | _filter_qemu_io | _filter_nbd
=20
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
index ee71b5aa42..037d34a409 100644
--- a/tests/qemu-iotests/143.out
+++ b/tests/qemu-iotests/143.out
@@ -1,7 +1,7 @@
 QA output created by 143
 {"return": {}}
 {"return": {}}
-qemu-io: can't open device nbd+unix:///no_such_export?socket=3DTEST_DIR/=
nbd: Requested export not available
+qemu-io: can't open device nbd+unix:///no_such_export?socket=3DSOCK_DIR/=
nbd: Requested export not available
 server reported: export 'no_such_export' not present
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
--=20
2.21.0


