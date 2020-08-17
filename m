Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2257EC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:29:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E6F2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="s4pGAY47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E6F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bSn-0002ay-0B
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFg-0007hd-0n; Mon, 17 Aug 2020 05:16:24 -0400
Received: from mail-eopbgr00134.outbound.protection.outlook.com
 ([40.107.0.134]:17743 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFd-00086n-VU; Mon, 17 Aug 2020 05:16:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxazwGmwxuzldJO79KxPVf2HE2Bmq5JsAhueYx05HXXp/S9v0mRHkfp/ejHFzZeKEbk2UdWuq9etlnhs/YJR8X5Yu5NAIAcDS8yK5s4EZEFyzUdZ3CqhWQAhh/AQVBeShevnENgqMQqQqN+D+eVcYdqSdsJ5jPfdhAIj89fE97/RfEJV1hsLoPcTNjQMEFATgVsiC396F61ysL/ZA1/YTvaJQHQVekO3K9Uz0ZZ9WFZARsacAD/yS6f+TsPcNaQV1/pfkqvB9dey6oB1+WXYsykOMKVulxy8uhi1M9yGCHxaG65aTD2t4LJsWC30XP+MN6bQQeHivIX+X257gFWJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7IEKRgVOtSDJFcE6H6Cui/rat+AChaZmS1cN/FnBVk=;
 b=LMvhvYr7M9qYQaX2zRXVHQRl0JW9CAqOjmP7PnFUlA0rvNBS3xi+ZIhrvC8O0TRs87d52/Ioz+w7wTRX35ApqZb5QbhFS/CMbdIq+TAwDAVTvw65E+uuu0TZmWFCTmgEa4DugJXGE3jsBQQi++syCUptXTXEHkonKcBxBzgytGv80CETQYqrrjvvKGvTVm3Yec/ntg4cMb7yMvaV1z4kgZqS7xm49kI+ig6As2wtJkGJtH4A4L2cYqAHx4QS/4LXSf4sN7g0px2/1TIkF5n2i9sYN0SEqjjWOq8N7jv3JdJS8LG/oxbMptkVncWhVekgt1qKZxXFisNBlTc+v4WnNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7IEKRgVOtSDJFcE6H6Cui/rat+AChaZmS1cN/FnBVk=;
 b=s4pGAY47nlmbmD8BNq8XYirc4SR/zHD9wamU1u/E5trg019u/cctvW7BAQkjCGx//yaOffILaZ6wqe/mS5d44oTZ1kIxoVynkx6u+JLPqglfH7/KXspMTWeSSJFU/FC+qNblPy7pRzCFT5YkseGb1fdd5UDJcY8zkqlM03Y62hQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4852.eurprd08.prod.outlook.com (2603:10a6:20b:cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Mon, 17 Aug
 2020 09:16:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 09:16:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 05/12] block: bdrv_mark_request_serialising: split
 non-waiting function
Date: Mon, 17 Aug 2020 12:15:46 +0300
Message-Id: <20200817091553.283155-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200817091553.283155-1-vsementsov@virtuozzo.com>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.174) by
 AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 09:16:06 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0b407c9-6c90-42d2-3007-08d8428e2c92
X-MS-TrafficTypeDiagnostic: AM6PR08MB4852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB485266C591B32DFFD460B99DC15F0@AM6PR08MB4852.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbgHYl5PptfCbwXiOUeJv1iOd3fqcpbPeNzqWtAPt7F9D6ajI25fyMWP7F7cJAECwlWiDYhFNxdU2DVJN3vC0lwyFX9CE5TxW+jK6tVYw03O81DGpX33lGOule1xrvIwbO+19kYNuWywqWEIBkXBhUyrIJFu87s3y4CZhgrtuXPJDZ8NSvbaQtUir9Naf3leoCjltx3r7HgaqepGuwqqCqFXUasaW99W4DyCLS/Gcz2sGn3W0n86KJb8XXyyCZug3I/+IsZpi9emSBAR2GV+I1uFL74Ope1o3qqpB2u8QvzeqL5n4ZNsZFiIxjqaYRpbXghwXUbiL2I/yZqg0xhE5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(52116002)(26005)(86362001)(16526019)(6506007)(186003)(6486002)(107886003)(8676002)(8936002)(478600001)(36756003)(4326008)(6916009)(316002)(2906002)(1076003)(6512007)(5660300002)(2616005)(66556008)(66476007)(6666004)(66946007)(956004)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ch+u5RhtRtG3cAvyYihbMt7CTTul4ZGz3COO2sjcDmfmJCntzet9wrJc3s7HvyqZpAwrx9ckuaFPKyIX9OFjHLnIILV9RVXs9uUTu3rVVkXpFIDwbE7zoZwjwoTBJXkcMbPdW3m50YJS/0m8pPIZKh1GmtYAr3GdzcI/4V9U9DUdO9XnNizDfvKTPD7+iexAQxbIRrAMkxNUb3pO2ajJ5he9k721/i3aiulpPuUOzWU+V01CdSSPi6o6qkfNbyR5cNX5NDaIS3Ak4XgWtKaX1pNLe/KHS1BhShqMmLg58nmeJQzIS1VNdmk1OPEyCgG+mdVDqB5isjXxzz2kxt7CuPq3gErw/zzGWxf7BKoz8VZ8cSU4zSaNupLSReVHna7KnJgaZEVs28+efIGHnKuCsn1Btz8KeWjwHwv0VaGeNAdIjXd/HS4kwcI1WltJXCGWRvW5v1ylwWMQaOM4onmt6PDe1F6f5gTrTPuY0bY+bwQ2k6X1mxV5hp1QvBIWuap8qZ8MRQbcuPofKPbJXAs6z6IYG+4fTLELVsPMVlVQdLXTIwyxMVTGuipeFuL0WG+ZpzhUzgQim5KsaAXUsg50O/q4qKye9rITOWJ8eYowwktaN4Wc7FpII3U6Kgg9RgZc3pmGme7Y9HpuqBvFXCKjQQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b407c9-6c90-42d2-3007-08d8428e2c92
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 09:16:07.4667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOiw+OCqR0gjkAggvXvhDb/sw2+LI17bgCiZyRE4+5pxT6it8zIeYzUdJJTb1C6rbGM1mSE2/WPt7rrKQocHlCBmDxTYvwAwp8u4VykQAVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4852
Received-SPF: pass client-ip=40.107.0.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:16:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We'll need a separate function, which will only "mark" request
serialising with specified align but not wait for conflicting
requests. So, it will be like old bdrv_mark_request_serialising(),
before merging bdrv_wait_serialising_requests_locked() into it.

To reduce the possible mess, let's do the following:

Public function that does both marking and waiting will be called
bdrv_make_request_serialising, and private function which will only
"mark" will be called tracked_request_set_serialising().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  3 ++-
 block/file-posix.c        |  2 +-
 block/io.c                | 34 ++++++++++++++++++++++------------
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 38dec0275b..4d56a1b141 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1039,7 +1039,8 @@ extern unsigned int bdrv_drain_all_count;
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_parent);
 void bdrv_unapply_subtree_drain(BdrvChild *child, BlockDriverState *old_parent);
 
-bool coroutine_fn bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align);
+bool coroutine_fn bdrv_make_request_serialising(BdrvTrackedRequest *req,
+                                                uint64_t align);
 BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState *bs);
 
 int get_tmp_filename(char *filename, int size);
diff --git a/block/file-posix.c b/block/file-posix.c
index 9a00d4190a..560d1c0a94 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2957,7 +2957,7 @@ raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int bytes,
         req->bytes = end - req->offset;
         req->overlap_bytes = req->bytes;
 
-        bdrv_mark_request_serialising(req, bs->bl.request_alignment);
+        bdrv_make_request_serialising(req, bs->bl.request_alignment);
     }
 #endif
 
diff --git a/block/io.c b/block/io.c
index 36bbe4b9b1..96b1b9cf5f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -778,15 +778,14 @@ bdrv_wait_serialising_requests_locked(BdrvTrackedRequest *self)
     return waited;
 }
 
-bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
+/* Called with req->bs->reqs_lock held */
+static void tracked_request_set_serialising(BdrvTrackedRequest *req,
+                                            uint64_t align)
 {
-    BlockDriverState *bs = req->bs;
     int64_t overlap_offset = req->offset & ~(align - 1);
     uint64_t overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
                                - overlap_offset;
-    bool waited;
 
-    qemu_co_mutex_lock(&bs->reqs_lock);
     if (!req->serialising) {
         atomic_inc(&req->bs->serialising_in_flight);
         req->serialising = true;
@@ -794,9 +793,6 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 
     req->overlap_offset = MIN(req->overlap_offset, overlap_offset);
     req->overlap_bytes = MAX(req->overlap_bytes, overlap_bytes);
-    waited = bdrv_wait_serialising_requests_locked(req);
-    qemu_co_mutex_unlock(&bs->reqs_lock);
-    return waited;
 }
 
 /**
@@ -882,6 +878,20 @@ static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self
     return waited;
 }
 
+bool bdrv_make_request_serialising(BdrvTrackedRequest *req, uint64_t align)
+{
+    bool waited;
+
+    qemu_co_mutex_lock(&req->bs->reqs_lock);
+
+    tracked_request_set_serialising(req, align);
+    waited = bdrv_wait_serialising_requests_locked(req);
+
+    qemu_co_mutex_unlock(&req->bs->reqs_lock);
+
+    return waited;
+}
+
 static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
                                    size_t size)
 {
@@ -1492,7 +1502,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
          * with each other for the same cluster.  For example, in copy-on-read
          * it ensures that the CoR read and write operations are atomic and
          * guest writes cannot interleave between them. */
-        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
+        bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
     } else {
         bdrv_wait_serialising_requests(req);
     }
@@ -1903,7 +1913,7 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
     assert(!(flags & ~BDRV_REQ_MASK));
 
     if (flags & BDRV_REQ_SERIALISING) {
-        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
+        bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
     } else {
         bdrv_wait_serialising_requests(req);
     }
@@ -2069,7 +2079,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
 
     padding = bdrv_init_padding(bs, offset, bytes, &pad);
     if (padding) {
-        bdrv_mark_request_serialising(req, align);
+        bdrv_make_request_serialising(req, align);
 
         bdrv_padding_rmw_read(child, req, &pad, true);
 
@@ -2183,7 +2193,7 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
     }
 
     if (bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, &pad)) {
-        bdrv_mark_request_serialising(&req, align);
+        bdrv_make_request_serialising(&req, align);
         bdrv_padding_rmw_read(child, &req, &pad, false);
     }
 
@@ -3347,7 +3357,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
      * new area, we need to make sure that no write requests are made to it
      * concurrently or they might be overwritten by preallocation. */
     if (new_bytes) {
-        bdrv_mark_request_serialising(&req, 1);
+        bdrv_make_request_serialising(&req, 1);
     }
     if (bs->read_only) {
         error_setg(errp, "Image is read-only");
-- 
2.18.0


