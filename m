Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041F1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3952204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ETMLPRhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3952204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ZQq-00069v-UT
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 09:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZNx-00013x-W3; Fri, 14 Aug 2020 09:04:42 -0400
Received: from mail-eopbgr20139.outbound.protection.outlook.com
 ([40.107.2.139]:54037 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZNu-0006by-Ki; Fri, 14 Aug 2020 09:04:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKzAXs29I+gXmIzCoIPeHCryA/Jrbc+sDIhtwJ5/fIOSREQ8zrGtkURE8FttzdY15UILnG7XJ3VxaCHQeIfZMNcyFVZEeep4UOxy+hQcdKTBF7E3ekiyplX1Johf34XdJuAxfB+U5qAVcRcAk8zl2uApiZOdwZtEM1emEgnJER4zP00nnSAcPKCtUSGT0qh4AVGW91z/SIpb7hJBDxCCB87iRHhwpxB2dW1LnC6ILUL0IL09KYvjy+BeF77aTCoWS53CuIVl9YCeMEaJsBN6h4VL6dCVRndui7G4W4JW57pJvJU11vanxZALcTlfh+2+p0IJC92oOLX5GPk6NgKuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi8aKkjFpdA4s0JetTP2PfIGUeilQxfu+nNwrhx6E74=;
 b=JgVR6saPtQbAaGJtOTeKZzioSfdON6RcYeRxIRVCCTcEKiCWgoSvwvughz/rJ8UmMPQdodeKtpn+yA9NsFcOxyqZQ/XZlWLBXAQBneSSlpQG+8MxeiQl6tLHYjVkRVdPOFMibFoxyDZfLLiIJ31DoVJBVXPyXrhOH8CAar8gAWS3yv3huUb+i8SvrnIBR6Kr9/HFsTuHt4A/+mLC3NTXVGrJTMu4lDx7QHhmrDqTqOjwbF7s7FgXUkCtwBRLmLxJIMu/qFK3+327WIxHytZpfhz4KFPLvN2FNz38PdSrer8sppooFWV7gzpFCDnD0zEQpurHULmH0/Yta3BphkBHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi8aKkjFpdA4s0JetTP2PfIGUeilQxfu+nNwrhx6E74=;
 b=ETMLPRhfQhHWtQ8WrpvYaYTDP7fKBPN9jDeBY4MSHZoY8edEIrNgpEiJA5Z6xNaj2ZWhaNM3YuUX25zSqa4pepUFXMMFnN2APUYs2+UCpTBwy4lqiX2VcHqG1cM7bYAEXHan7aiwN7di/euZ23i1g6YvNcY984KZb8lgSg0r+SY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2981.eurprd08.prod.outlook.com (2603:10a6:209:44::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Fri, 14 Aug
 2020 13:04:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 13:04:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 5/9] block: bdrv_mark_request_serialising: split
 non-waiting function
Date: Fri, 14 Aug 2020 16:03:44 +0300
Message-Id: <20200814130348.20625-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814130348.20625-1-vsementsov@virtuozzo.com>
References: <20200814130348.20625-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.177) by
 AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 13:04:23 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1caa6b7d-f66f-46f0-cf65-08d84052916b
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB2981AE1F8C4E97AA38E7E1FFC1400@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBRkgiQvl1JSGfDtoh9MNzVPX3Nb3AUTgM7BF/sz69uTM1+ek0jZuNjc+ykuMNh6oE3b/WLKT+d+55Iod3EAQ9Y7VaS89Mhq9emq7iL7mZDAo9k5TvA3Fo7vUIU7zBGSCtTdK6URYG1cwH3CgEOfufQs7/WD+wLfQOWEqmKuGYXzSUI84Hxaj6bFhj57WeGPEE+PoKbkFtittFaeexO0gMnm2YCwTo9yPvyVQAZuGCMr4+f+xTXb70K3hWWG5qreKpaDDz4xNCtQsms7o1FvVQ22QvFJEsvcJmXEvt2YV1kiwgpd1jZoHL3gaTGD6ip5nE7TvjfDd9/AqkVmBMdfOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39840400004)(396003)(136003)(2616005)(956004)(86362001)(1076003)(6486002)(478600001)(8936002)(6512007)(6666004)(36756003)(83380400001)(5660300002)(8676002)(6506007)(16526019)(186003)(316002)(4326008)(66556008)(66476007)(66946007)(2906002)(107886003)(52116002)(6916009)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mn3OxSI+3um8W7ym3GM7ETe+s8AHJdKXpiLvHOtL7jepr43zgYiHEyiiyzKTPBbSo7GOw5hr/aW5UCEJKZVg/JHtKmj2+b+Ux9JIVrxJN5560BX9IrgmokEkG+EvpdQWdv+fwtvBKES+dgkPkI/H6BbNY9QWWCbSm2CVwn+pORvzhcOWJ+GCCA/MTGor4lHve8E0BjEQyTMz5azcqJyeBZ9STPV5SaT9GgnZRgYhaRJCrMKOI/NHMYXa/Vb66AHLW9NWDmAtlO/SbV+ZWH3Mcrc6hAv3avAIVgfy1MVPTnAPGqa9YBLZy4b26wGCkmmE9s+AFH/miwvPdpgnzwmIOduBu2FkIaCtNYV2WhIaELKeTATZAREv0vnbST7+6fEeIxUvtK6GCRBsic8dIHufaqCTjl+lkGaqABPh96C/O9WYNGU8+KK15AoLFp2BzHIa4zLBVVf+HWZLeR7xcNcaDfzlYGGs76DIFmuQ0b3cRfQaOR/SWwaK/GsLRtAvrZeWJsx6f/8WabjSSdqC98fIEQRnMmVv0mlaVV5UnaS/4gMrH/Z9PxceByUDgB/yFxfK48H4Tn3fHwH4vNYaf96/oP4+xJgfP4mShpoy1GYTf/2XNZWhOV84WGaM1JwUcFqKXuZX1vh7FLaR5jOoMykE/A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caa6b7d-f66f-46f0-cf65-08d84052916b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 13:04:24.6811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mHSEBrbTbD6M1loatJZjs9z04CkYDxT2nxLPLHGRTwmK4NP8maczt5XIyh1e39IM8LzZW7XPNF/FzgszKTk/Tkc9MOOL23ZxSUjop9fWbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
Received-SPF: pass client-ip=40.107.2.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 09:04:28
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
2.21.3


