Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514CFC55178
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937F820BED
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qdS48w4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937F820BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFk3-0008MX-Fs
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaI-0005n4-KP; Wed, 21 Oct 2020 10:59:26 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com
 ([40.107.7.109]:36743 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaG-00085a-AJ; Wed, 21 Oct 2020 10:59:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbDyhYt4ivaH1OpFNXMUEI44ep956FMgBj2EvacG9nbvSnAdPjRQRZ0YbwRYMwU7TqWrLAkHF5l1YuTPrpuLTZq/mCzR5DtYaWNX5Ez9zNj2oRu0m15pAI3jL/ecVYGEpJCI2ql32mtocCWhtRcN9VmMGLjUpZB+51lwlZKNVhf27AzzOemrKQhjztv1MLIn+t/cM9FpnpILc71GoRNzSqWgWb9l4GTfFuweoxgdu9lXi5NnI3QsosJjRD1Z/YNxkcM6JU/qgk1glD2E/DJMfTq1pAQwEkmz5WzxfZsgCOEAm0ZImNcwmhbuXVRARKslqN/tc1maCSupKNgoHv8Z2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=687hmuyWvjwZgQ+nk9PUlLDrOovkaiK6JIJv01VVUMA=;
 b=NEAd/hUt8rNeucTs924x3KMy5sE33ryL29yWE8k4gteSm0rFicQX6XS9G/CnXUp0k3kvhTlqh0fd+tAH6RPUujAssp81WdxmXz5R0jsVcqVh8t/hfr/aY1+uMKLVyxjDaBUz38IpxLJGeBv12slndvVhsYChYJo/xCvoqnXlRlDA2i0V27py00RfuL3fptzc6hFMcn19iLkxFCX15+o8ZVOE0UBqirVFzbvYYl2CuUeR4jvc/tRrkUZ+F1ZxybLsEEczKzPDITx7p0HH7HEA9izau6JWURNwyl8jW7+lJLpPEaqI8QkGwzYunr3Peu6kqCk8Va0duqPH9DdIO5gvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=687hmuyWvjwZgQ+nk9PUlLDrOovkaiK6JIJv01VVUMA=;
 b=qdS48w4tjrsJi/5iiaIgX4tRv60kfBy3q5rkKQVuVSHpKzQhMqpZFnirf5O7eJYADoKg429YmwaeNKN3uGRUvjsxAm7BCYmlp8s2MJGueidIz+wctVviY6f2Vy+2zGR9atpyyajGC6JHpd3NlL0dXZZumzoeZmdPWOCp6e07xXE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 05/21] block: bdrv_mark_request_serialising: split
 non-waiting function
Date: Wed, 21 Oct 2020 17:58:43 +0300
Message-Id: <20201021145859.11201-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201021145859.11201-1-vsementsov@virtuozzo.com>
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7067125f-4d9f-462d-2586-08d875d1e1f2
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB447207E600FBCFFD6DD00039C11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: be/7dvBSVnYT3pshXU8XzSXpVhwrQC90k33tLyWpL0gfvpMJaH1lZs/4aAjT6yPo5DTCii+SI9OwPEx8eMWY67+HTNyu5fWUb7647JZQsiXx3/vbdpGplip1911Y/sIeofu1tpFa4CKk08lXV/RpqRt4KS0GfDeaNFySDniQPdD+LAJ4W9hSih9N0SnmCvqPYnSaQQM+DzIyMkieG1+p6u7Y4G2bEsC8XqFbtK4QgaLi+GIKeFOe8CYpYS+30xVho/dSEEQEMGTV51W/h64t91AFdxXkw4ZDMLM/k4HuBHNFGfewUUYMzj21I63RVK4cgS29auAsk3U+iIpvdpGZ0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39840400004)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jF+1M2XdLJjUGkVGPaQK+3IzLw5+aH/U74sSjAs6uaSlxpcm4iopgJ5M1aWOLHtQlTRbg2ecJxZfDVZrfolJmfu7BockoBCTTHipcneT100b772I/TJlawcAyswQ9F4o5sEi/t3ycCMYbjWmBk0VVJGFs9nNE8S2NzeyjDGyYgIIwjKxfYfYBxlv52vUKTgjRO4ttL0T9xbgDjwt5PGbpsx1cQr6KrwhUthZmNUXc2ZeLvG8/q2uN0cbOP/uKwjSd3AcZAa+tvNWC6Ez5iGFNFNKVFVia9G86UmPGKk+Z0n/Rm9wYdcgRddi8/vI7mfQpWO/+aW8g4KsReKMHmFbX8eHdzVl8jaH56DgU/xGu8qX3J9y4/mYq+7p9OCFnZq5NO4m12VAFJGUiIBSucy6FQbeCGVkSujSM/YJ4rMtJBthIHG2ndKEOiELVquMvDMkUSrshXaARISFy6U94g5C6whrkRh06p1WzSKTWFezrpTxt8UrZYl+9hKroBv88qoqikaJJIvbFczcsByqVGeJjqMqDYoBZdnJ91oEBD98Z4siqhwC7EMav9kysgocuIur7LWBaXZzgL/nPhZtahmdQglT9z0DN30R78WPGdTju6OcDfBzcS1G46k5NqljL6bX/MATNTSj2jPqt+VoyYdvOg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7067125f-4d9f-462d-2586-08d875d1e1f2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:17.3397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDJEgl+22iPuiC5dzLDSBEIp9KcvjfNxMHk92uO6QMQGbcoSv12fFgcEC7k/jwJvXHmXd94j54IURnY9usLBTSbIVd9f86uqny/l8WErImM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4472
Received-SPF: pass client-ip=40.107.7.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  3 ++-
 block/file-posix.c        |  2 +-
 block/io.c                | 35 +++++++++++++++++++++++------------
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 38cad9d15c..887b0668d8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1052,7 +1052,8 @@ extern unsigned int bdrv_drain_all_count;
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_parent);
 void bdrv_unapply_subtree_drain(BdrvChild *child, BlockDriverState *old_parent);
 
-bool coroutine_fn bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align);
+bool coroutine_fn bdrv_make_request_serialising(BdrvTrackedRequest *req,
+                                                uint64_t align);
 BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState *bs);
 
 int get_tmp_filename(char *filename, int size);
diff --git a/block/file-posix.c b/block/file-posix.c
index c63926d592..37d9266f6a 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2953,7 +2953,7 @@ raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int bytes,
         req->bytes = end - req->offset;
         req->overlap_bytes = req->bytes;
 
-        bdrv_mark_request_serialising(req, bs->bl.request_alignment);
+        bdrv_make_request_serialising(req, bs->bl.request_alignment);
     }
 #endif
 
diff --git a/block/io.c b/block/io.c
index 5c1a1b388b..24ff8d804b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -779,15 +779,14 @@ bdrv_wait_serialising_requests_locked(BdrvTrackedRequest *self)
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
         qatomic_inc(&req->bs->serialising_in_flight);
         req->serialising = true;
@@ -795,9 +794,6 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 
     req->overlap_offset = MIN(req->overlap_offset, overlap_offset);
     req->overlap_bytes = MAX(req->overlap_bytes, overlap_bytes);
-    waited = bdrv_wait_serialising_requests_locked(req);
-    qemu_co_mutex_unlock(&bs->reqs_lock);
-    return waited;
 }
 
 /**
@@ -883,6 +879,21 @@ static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self
     return waited;
 }
 
+bool coroutine_fn bdrv_make_request_serialising(BdrvTrackedRequest *req,
+                                                uint64_t align)
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
@@ -1395,7 +1406,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
          * with each other for the same cluster.  For example, in copy-on-read
          * it ensures that the CoR read and write operations are atomic and
          * guest writes cannot interleave between them. */
-        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
+        bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
     } else {
         bdrv_wait_serialising_requests(req);
     }
@@ -1806,7 +1817,7 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
     assert(!(flags & ~BDRV_REQ_MASK));
 
     if (flags & BDRV_REQ_SERIALISING) {
-        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
+        bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
     } else {
         bdrv_wait_serialising_requests(req);
     }
@@ -1972,7 +1983,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
 
     padding = bdrv_init_padding(bs, offset, bytes, &pad);
     if (padding) {
-        bdrv_mark_request_serialising(req, align);
+        bdrv_make_request_serialising(req, align);
 
         bdrv_padding_rmw_read(child, req, &pad, true);
 
@@ -2086,7 +2097,7 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
     }
 
     if (bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, &pad)) {
-        bdrv_mark_request_serialising(&req, align);
+        bdrv_make_request_serialising(&req, align);
         bdrv_padding_rmw_read(child, &req, &pad, false);
     }
 
@@ -3139,7 +3150,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
      * new area, we need to make sure that no write requests are made to it
      * concurrently or they might be overwritten by preallocation. */
     if (new_bytes) {
-        bdrv_mark_request_serialising(&req, 1);
+        bdrv_make_request_serialising(&req, 1);
     }
     if (bs->read_only) {
         error_setg(errp, "Image is read-only");
-- 
2.21.3


