Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDD7C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94E3206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94E3206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIaUe-0000yU-Ae
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 11:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIaJa-0005sM-Im
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIaJZ-0004OM-Hf
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:25:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIaJW-0004Lc-Eg; Thu, 10 Oct 2019 11:25:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC6C410CBC4B;
 Thu, 10 Oct 2019 15:25:13 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB19810018F8;
 Thu, 10 Oct 2019 15:25:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 04/23] iotests: Filter $SOCK_DIR
Date: Thu, 10 Oct 2019 17:24:38 +0200
Message-Id: <20191010152457.17713-5-mreitz@redhat.com>
In-Reply-To: <20191010152457.17713-1-mreitz@redhat.com>
References: <20191010152457.17713-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 10 Oct 2019 15:25:13 +0000 (UTC)
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
 tests/qemu-iotests/common.filter | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
index 9f418b4881..cd42f5e7e3 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -43,7 +43,8 @@ _filter_qom_path()
 # replace occurrences of the actual TEST_DIR value with TEST_DIR
 _filter_testdir()
 {
-    $SED -e "s#$TEST_DIR/#TEST_DIR/#g"
+    $SED -e "s#$TEST_DIR/#TEST_DIR/#g" \
+         -e "s#$SOCK_DIR/#SOCK_DIR/#g"
 }
=20
 # replace occurrences of the actual IMGFMT value with IMGFMT
@@ -124,6 +125,7 @@ _filter_img_create()
     $SED -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
+        -e "s#$SOCK_DIR#SOCK_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
         -e 's#nbd:127.0.0.1:10810#TEST_DIR/t.IMGFMT#g' \
         -e "s# encryption=3Doff##g" \
@@ -160,6 +162,7 @@ _filter_img_info()
     $SED -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
+        -e "s#$SOCK_DIR#SOCK_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
         -e 's#nbd://127.0.0.1:10810$#TEST_DIR/t.IMGFMT#g' \
         -e 's#json.*vdisk-id.*vxhs"}}#TEST_DIR/t.IMGFMT#' \
@@ -218,7 +221,8 @@ _filter_nbd()
     # Filter out the TCP port number since this changes between runs.
     $SED -e '/nbd\/.*\.c:/d' \
         -e 's#127\.0\.0\.1:[0-9]*#127.0.0.1:PORT#g' \
-        -e "s#?socket=3D$TEST_DIR#?socket=3DTEST_DIR#g" \
+        -e "s#?socket=3D$SOCK_DIR#?socket=3DTEST_DIR#g" \
+        -e "s#?socket=3D$SOCK_DIR#?socket=3DSOCK_DIR#g" \
         -e 's#\(foo\|PORT/\?\|.sock\): Failed to .*$#\1#'
 }
=20
--=20
2.21.0


