Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C14C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5E5206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5E5206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIaX8-0003s8-H7
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 11:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIaJj-0005vo-Ci
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIaJg-0004Q7-Cm
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:25:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIaJc-0004P0-9V; Thu, 10 Oct 2019 11:25:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 81BEB315C03D;
 Thu, 10 Oct 2019 15:25:19 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9447194B6;
 Thu, 10 Oct 2019 15:25:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 06/23] iotests/083: Create socket in $SOCK_DIR
Date: Thu, 10 Oct 2019 17:24:40 +0200
Message-Id: <20191010152457.17713-7-mreitz@redhat.com>
In-Reply-To: <20191010152457.17713-1-mreitz@redhat.com>
References: <20191010152457.17713-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 10 Oct 2019 15:25:19 +0000 (UTC)
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
 tests/qemu-iotests/083     |  6 +++---
 tests/qemu-iotests/083.out | 34 +++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
index b270550d3e..10fdfc8ebb 100755
--- a/tests/qemu-iotests/083
+++ b/tests/qemu-iotests/083
@@ -28,7 +28,7 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-	rm -f nbd.sock
+	rm -f "$SOCK_DIR/nbd.sock"
 	rm -f nbd-fault-injector.out
 	rm -f nbd-fault-injector.conf
 }
@@ -80,10 +80,10 @@ EOF
 	if [ "$proto" =3D "tcp" ]; then
 		nbd_addr=3D"127.0.0.1:0"
 	else
-		nbd_addr=3D"$TEST_DIR/nbd.sock"
+		nbd_addr=3D"$SOCK_DIR/nbd.sock"
 	fi
=20
-	rm -f "$TEST_DIR/nbd.sock"
+	rm -f "$SOCK_DIR/nbd.sock"
=20
         echo > "$TEST_DIR/nbd-fault-injector.out"
 	$PYTHON nbd-fault-injector.py $extra_args "$nbd_addr" "$TEST_DIR/nbd-fa=
ult-injector.conf" >"$TEST_DIR/nbd-fault-injector.out" 2>&1 &
diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
index eee6dd1379..2090ee693c 100644
--- a/tests/qemu-iotests/083.out
+++ b/tests/qemu-iotests/083.out
@@ -110,43 +110,43 @@ read failed: Input/output error
=20
 =3D=3D=3D Check disconnect before neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect after neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 8 neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 16 neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect before export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect after export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 4 export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 12 export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 16 export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect before neg2 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect after neg2 =3D=3D=3D
=20
@@ -154,11 +154,11 @@ read failed: Input/output error
=20
 =3D=3D=3D Check disconnect 8 neg2 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 10 neg2 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect before request =3D=3D=3D
=20
@@ -195,23 +195,23 @@ read 512/512 bytes at offset 0
=20
 =3D=3D=3D Check disconnect before neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 8 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 16 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 24 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 28 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect after neg-classic =3D=3D=3D
=20
--=20
2.21.0


