Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6D5C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B45220774
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MS2oPolh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B45220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7Ju-0008O5-HC
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78W-000759-Ji
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU770-0005Gq-Uy
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:48 -0400
Received: from mail-eopbgr60129.outbound.protection.outlook.com
 ([40.107.6.129]:22328 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU75t-0003Xs-6H; Thu, 30 Apr 2020 07:11:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Htbju1lOhFWDzlt4R7HSFTCS6f5Vk6Odm/AHL068JmcTO7FW7Uj2Xiwe5qrJN0p4Oow/+7P1Y9xzw0RxEGq4VN9fgO0+rLXS0YLOC7J2Pm5gvt2T4T4ubLq7z1R1jP2n+D4XDmBGDTHEaX96OZt0g4qk7s6bwAFS9TN38GiX+rJltfjMlCshR0kfTqG8dej3Kt+X67s+AYS57l6XzIhy/+wu/4V1mYOed97CxYb8Mjk1TX0k+34t+L3ksIlncTB8Fq8Vwrf7arYxKohBy+mbZ3N0l97HdDVqOghOpTzEgJoeW8jknDabooBRw5WELXMXrplwfCUtYkq3izko24GADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFCFonnyj2ur+Ohf+6JgB7bHgAgqHjZJlgG6pCgp5BI=;
 b=NN7iKxMiWcDQJbKJZwiWYdJnYO5kdJWt3PFrfE7Nxgm6cuBidLs3FYZ2cc5REckFepPErNf/etBWOthrdPYDNXqMpL9+81lQv4ZEmKICs0MwkhlW7r8ZWKcCPEm0NsZ5xjldTRZDwI+gUHVbo6f1gkdkFh9e0KiXzED/wMcO9FXZz5kngrZAtVjdv577UPJGzq4bY6YmfChj1cjdzXGsoys8CyVuU9dKthIngpLVnu57ovkyUbvrlJoIw1rBI1KljpdEu/SRC0oQRF0IN0Cy3AfdItMhkw4aX2n7xljHVLPnX12eLput6oVAbRwcVth1Uh/4ORlWv3Az7jKNryQV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFCFonnyj2ur+Ohf+6JgB7bHgAgqHjZJlgG6pCgp5BI=;
 b=MS2oPolhDw81Tpt2j4Ko1fzK+/I+xDxwuqBKHoxpFKBHNMJdk0XUGiXsJ4IK3Kk08c+h3R9aoG0qHKkWzMwA8T+znUKY6uuwLobLeM5jfaoYkEdEaVZbgvYq8jis6IVyuwkSm8iba6HXQ6QavocW1a1AiB0V145W9QKGQQSByAU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 11:11:02 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:11:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 10/17] block/io: support int64_t bytes in read/write
 wrappers
Date: Thu, 30 Apr 2020 14:10:26 +0300
Message-Id: <20200430111033.29980-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200430111033.29980-1-vsementsov@virtuozzo.com>
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 AM0P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:11:01 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d87cfd9-07a0-4b1e-f763-08d7ecf72b79
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5447B15D5AFFD900581DF8D6C1AA0@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(376002)(396003)(366004)(66556008)(6512007)(107886003)(316002)(6506007)(26005)(52116002)(186003)(478600001)(956004)(2616005)(16526019)(66476007)(2906002)(86362001)(5660300002)(66946007)(6486002)(6916009)(7416002)(36756003)(8936002)(1076003)(6666004)(8676002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxLYp2j6GsqnyRx/hj4xn4c3lhAFH3pP6CjRvA7MvgyXsRuqeAd1h7UwRYCBAxiCh1nNQbznhaf5sYeHkS8u1yuN4DO2Rl5rxaCVD1RnGBC/JE7Scuh9tc/fUFK4TR2xRYX592Z1lJTWj5uU2JW7mZtFgJjJq/mdxb7KiHaUvlomj4RCUTxaz4VDp9qfRLuq7Ox+Y+3k0gmG01aUn88APaHtGY5rHKZQfaglBfyX8G0CytvB3Y1Bsdf97LmlDVlZYlHQjDcw0uFpFOctzOqSVyKDBYxAdAa1SPU8IB4TgKnrPHkn72RGlGXOPuGHmXWuHkMypv60qUV1K0S5E1fHd1mosXK3HV3hEvu5FAJ31o3mMD8t9u1O6bKE8o81xs4dvlpv7HdQD7zhglIZllagnUVtw9GubvU6A9wjN92NfLvhWUU5T7qi/miZVjprnoN0
X-MS-Exchange-AntiSpam-MessageData: 30Q/nxD0FgykoMNhjO9iEOr+36TXY/SY9uHgKDZFy9SutEhN0Pif+yemRl4lRWzWgd9DiVnMSeafzpeb7EZDOVSlHq6v7LoxYeorNfsc77uRQYr8yB96zvMTv+FCggDpFNOCsvj7pLN1irLJlmQ6uJan0U67DbE/TIw62mTx8SbtIiNzA1zxNfRjj7q92G/UczXpc29/0Pq6SLXVfnqJXq+ky21BuNH5fBh0rnBexT9xyMIH0jCYXW34FGXapTDTzeDvoDI4UmqSSCg+xQHC/6M7sBQn0AfbirK9LLKyDG76xbYzEWJ8JYmXnFWq/i/nn7A0uB/2G0Q6TK1/NcV9pgoJLdDaDkgB9qcH+T/Vhz1ZULVQJjjxC18G0rJD8MB91hRuh4hN0lS6NYPo95M5ewx7p493Ni1E/vobnPFFtSpnTU8UJXZ/GGRo/U7PjJ64jUCjNMOAWDSie2VbPoT6Oecx5fPV64QdigrqJ3MEdwqr0wgmJ5ON1Zd258CZPpFxfk2oFttneE4hHwxaPheSno4ZIl5camO41SCkVT72+XRDB7QYC7mD0hsRPNDNIb2uu6Ev61yz+LlWnJBxR0Iu1sZyvsxo2VNEev9hgRY6zh9Ji3VLgoe5/wL21I68qMZBvpSrmjmKOikPbpLY4WdWr6qghc0ivfURaPf+H2FSCaWlN2nHKclw9x/gLAyH2J9PM5Xq+yBDUs7GbGE5vPeOGIb7UuQROvJ6jlAkB3RoSD5BVKBL9FfxZE0Gx9VgjofTZTlO1qQgBYS6lD6MoF/Kl0M4tpo1AkWDCO+DVex+IJ4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d87cfd9-07a0-4b1e-f763-08d7ecf72b79
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:11:02.8596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlt/nRVT39se/FAC7Bs0ookBSLuEBUhJGjDRY5FWuk3vFC7zA6dU24pFKpAv+68arxGbZcGiulD6NqVBpEMtjBNBDPH/+tD/akNfIpFkCk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
Received-SPF: pass client-ip=40.107.6.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 07:11:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.6.129
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com,
 den@openvz.org, sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com,
 stefanha@redhat.com, namei.unix@gmail.com, pbonzini@redhat.com,
 jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths.

Main motivation is realization of 64-bit write_zeroes operation for
fast zeroing large disk chunks, up to the whole disk.

We chose signed type, to be consistent with off_t (which is signed) and
with possibility for signed return type (where negative value means
error).

Now, when bdrv_co_preadv_part() and bdrv_co_pwritev_part() updated,
update all their wrappers.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h     | 11 ++++++-----
 include/block/block_int.h |  4 ++--
 block/blkverify.c         |  2 +-
 block/io.c                | 19 ++++++++++---------
 block/trace-events        |  2 +-
 5 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index b05995fe9c..1688e7fa55 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -318,14 +318,15 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
 void bdrv_reopen_commit(BDRVReopenState *reopen_state);
 void bdrv_reopen_abort(BDRVReopenState *reopen_state);
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                       int bytes, BdrvRequestFlags flags);
+                       int64_t bytes, BdrvRequestFlags flags);
 int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags);
-int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes);
+int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int64_t bytes);
 int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov);
-int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes);
+int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf,
+                int64_t bytes);
 int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov);
 int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
-                     const void *buf, int count);
+                     const void *buf, int64_t bytes);
 /*
  * Efficiently zero a region of the disk image.  Note that this is a regular
  * I/O request like read or write and should have a reasonable size.  This
@@ -333,7 +334,7 @@ int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
  * because it may allocate memory for the entire region.
  */
 int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                                       int bytes, BdrvRequestFlags flags);
+                                       int64_t bytes, BdrvRequestFlags flags);
 BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     const char *backing_file);
 void bdrv_refresh_filename(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3c2a1d741a..b4b42d0cd6 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -972,13 +972,13 @@ extern BlockDriver bdrv_raw;
 extern BlockDriver bdrv_qcow2;
 
 int coroutine_fn bdrv_co_preadv(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
     int64_t offset, int64_t bytes,
     QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
     int64_t offset, int64_t bytes,
diff --git a/block/blkverify.c b/block/blkverify.c
index ba6b1853ae..667e60d832 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -31,7 +31,7 @@ typedef struct BlkverifyRequest {
     uint64_t bytes;
     int flags;
 
-    int (*request_fn)(BdrvChild *, int64_t, unsigned int, QEMUIOVector *,
+    int (*request_fn)(BdrvChild *, int64_t, int64_t, QEMUIOVector *,
                       BdrvRequestFlags);
 
     int ret;                    /* test image result */
diff --git a/block/io.c b/block/io.c
index d7fd429345..7564153dbe 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1507,7 +1507,7 @@ static bool bdrv_pad_request(BlockDriverState *bs,
 }
 
 int coroutine_fn bdrv_co_preadv(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags)
 {
     return bdrv_co_preadv_part(child, offset, bytes, qiov, 0, flags);
@@ -1933,7 +1933,7 @@ out:
  * Handle a write request in coroutine context
  */
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags)
 {
     return bdrv_co_pwritev_part(child, offset, bytes, qiov, 0, flags);
@@ -2023,7 +2023,7 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
 
 /* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
 static int coroutine_fn
-bdrv_do_pwrite_zeroes(BdrvChild *child, int64_t offset, int bytes,
+bdrv_do_pwrite_zeroes(BdrvChild *child, int64_t offset, int64_t bytes,
                       BdrvRequestFlags flags)
 {
     trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
@@ -2037,7 +2037,7 @@ bdrv_do_pwrite_zeroes(BdrvChild *child, int64_t offset, int bytes,
 }
 
 int coroutine_fn
-bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset, int bytes,
+bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset, int64_t bytes,
                       BdrvRequestFlags flags)
 {
     int ret;
@@ -2109,7 +2109,7 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
 }
 
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                       int bytes, BdrvRequestFlags flags)
+                       int64_t bytes, BdrvRequestFlags flags)
 {
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
 
@@ -2118,7 +2118,7 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
 }
 
 /* See bdrv_pwrite() for the return codes */
-int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
+int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int64_t bytes)
 {
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
@@ -2148,7 +2148,8 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
  * -EINVAL      Invalid offset or number of bytes
  * -EACCES      Trying to write a read-only device
  */
-int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes)
+int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf,
+                int64_t bytes)
 {
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
@@ -2166,11 +2167,11 @@ int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes)
  * Returns 0 on success, -errno in error cases.
  */
 int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
-                     const void *buf, int count)
+                     const void *buf, int64_t bytes)
 {
     int ret;
 
-    ret = bdrv_pwrite(child, offset, buf, count);
+    ret = bdrv_pwrite(child, offset, buf, bytes);
     if (ret < 0) {
         return ret;
     }
diff --git a/block/trace-events b/block/trace-events
index dd367a9b19..13ad9af0d8 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -13,7 +13,7 @@ blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 # io.c
 bdrv_co_preadv_part(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
 bdrv_co_pwritev_part(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
-bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags 0x%x"
+bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
 bdrv_co_do_copy_on_readv(void *bs, int64_t offset, int64_t bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %" PRId64 " bytes %" PRId64 " cluster_offset %" PRId64 " cluster_bytes %" PRId64
 bdrv_co_copy_range_from(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
 bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
-- 
2.21.0


