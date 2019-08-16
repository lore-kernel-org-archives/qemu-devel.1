Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0EFC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 15:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35307206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 15:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35307206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyeGS-0004qb-7D
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 11:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyeBR-0007s8-Kt
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 11:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyeBO-0001dQ-7m
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 11:30:29 -0400
Received: from relay.sw.ru ([185.231.240.75]:60434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyeBH-0001Qc-0v; Fri, 16 Aug 2019 11:30:19 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyeBD-0007x1-CO; Fri, 16 Aug 2019 18:30:15 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Fri, 16 Aug 2019 18:30:11 +0300
Message-Id: <20190816153015.447957-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190816153015.447957-1-vsementsov@virtuozzo.com>
References: <20190816153015.447957-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4 1/5] tests/qemu-iotests: Fix qemu-io related
 output in 026.out.nocache
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu-io now prefixes its error and warnings with "qemu-io:".
36b9986b08787019e fixed a lot of iotests output but forget about
026.out.nocache. Fix it too.

Fixes: 99e98d7c9fc1a1639fad ("qemu-io: Use error_[gs]et_progname()")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/026.out.nocache | 168 ++++++++++++++---------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.out.nocache
index 1ca6cda15c..6dda95dfb4 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -14,8 +14,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 5; imm: off; once: off; write 
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 
 1 leaked clusters were found on the image.
@@ -23,8 +23,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 5; imm: off; once: off; write -b
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 
 1 leaked clusters were found on the image.
@@ -42,8 +42,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 28; imm: off; once: off; write 
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
 1 leaked clusters were found on the image.
@@ -51,8 +51,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
 1 leaked clusters were found on the image.
@@ -136,8 +136,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 5; imm: off; once: off; write 
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -146,8 +146,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_update; errno: 5; imm: off; once: off; write -b
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -168,8 +168,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 28; imm: off; once: off; write 
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -178,8 +178,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_update; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -198,15 +198,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_alloc_write; errno: 5; imm: off; once: off; write 
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_alloc_write; errno: 5; imm: off; once: off; write -b
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 
 1 leaked clusters were found on the image.
@@ -224,15 +224,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_alloc_write; errno: 28; imm: off; once: off; write 
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_alloc_write; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
 1 leaked clusters were found on the image.
@@ -250,15 +250,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: write_aio; errno: 5; imm: off; once: off; write 
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: write_aio; errno: 5; imm: off; once: off; write -b
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -274,15 +274,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: write_aio; errno: 28; imm: off; once: off; write 
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: write_aio; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -298,15 +298,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_load; errno: 5; imm: off; once: off; write 
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_load; errno: 5; imm: off; once: off; write -b
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -322,15 +322,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_load; errno: 28; imm: off; once: off; write 
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_load; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -346,15 +346,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_update_part; errno: 5; imm: off; once: off; write 
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_update_part; errno: 5; imm: off; once: off; write -b
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -370,15 +370,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_update_part; errno: 28; imm: off; once: off; write 
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_update_part; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -394,15 +394,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc; errno: 5; imm: off; once: off; write 
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc; errno: 5; imm: off; once: off; write -b
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -418,15 +418,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc; errno: 28; imm: off; once: off; write 
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -485,8 +485,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write 
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
 55 leaked clusters were found on the image.
@@ -494,8 +494,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
 251 leaked clusters were found on the image.
@@ -513,15 +513,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write 
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -537,8 +537,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write 
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
 10 leaked clusters were found on the image.
@@ -546,8 +546,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
 23 leaked clusters were found on the image.
@@ -565,8 +565,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write 
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
 10 leaked clusters were found on the image.
@@ -574,8 +574,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
 23 leaked clusters were found on the image.
@@ -593,8 +593,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write 
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
 10 leaked clusters were found on the image.
@@ -602,8 +602,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
 23 leaked clusters were found on the image.
@@ -639,8 +639,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_grow_write_table; errno: 5; imm: off; once: off
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -651,8 +651,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_grow_write_table; errno: 28; imm: off; once: off
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -663,8 +663,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_grow_activate_table; errno: 5; imm: off; once: off
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 
 96 leaked clusters were found on the image.
@@ -677,8 +677,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_grow_activate_table; errno: 28; imm: off; once: off
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
 96 leaked clusters were found on the image.
-- 
2.18.0


