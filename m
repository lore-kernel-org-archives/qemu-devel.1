Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A272CC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589DC20661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wHGhMZgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589DC20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT51n-00031P-E1
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4v7-0008Dx-DJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4v6-0007lm-EN
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:41 -0400
Received: from mail-am6eur05on2133.outbound.protection.outlook.com
 ([40.107.22.133]:24288 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT4v3-0007iF-EP; Mon, 27 Apr 2020 10:39:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3Mg+VK/fp530GohjU5Bcy1tkbig6K/YzXgulzljCX4EGjKXWdLcxl4kaFKwfec3E7HUFlU+Mwc0OzxBY43tQd8u7RwL2Y25CSepP3SYPSlRAhKB26PtQeT1ZYlhDlNqDbAqHY0Pg8OC3GRqAXztZ3TtEcNLz7nVuZwnUU+Tcsxa1184BFifyqMLbs9RTFDnnLshOYcZoCDOnXppoptPX9A8hl1wMv5l0rDSi9QVHzMu1FzdGZIalxLE1hwocg+Szs+E5vHlM5I4WqGtdKBpbMFRv42OVmley8ytkJd9zD5Yw95nZ6FyrlbsGDL0QeEr7T8/kbKa+hdZ28Lw0FB59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E/AKrIBiKr9k6kN+BLGLW0KAf8ZeXORIcK0XuhwXnI=;
 b=mMTabXL8VdTZeMb2sfKASfq5h+/g5ycrEMkeGJPM51Pn91y07PEKqT0RvGCg64Tv6hI3tD6zfYzXuuYFnUrAVSrOtN8V1ytzrEyRUbAgZIr/tdN69B0k8DrF69Ti2tyRm2qfihn9NsoanQ48Bzs7H/be+huT75lnBs6xXAOWoJIG6fXpG3gLwtuvL6c3GULMMV7LdqjT+3gVrjgtz7JwNzGp4EPkEgZVFwfWkZlQT0qsyOtxFyMBzKtYAlfnlKQzN/a4EP67YqScwuyjFwoXXvvJo3EqmHy0xnH9eFofT5jzWP9K8U1+qg4WCtTpqP5GxGwEcjuOQ4hFwffeFxEfAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E/AKrIBiKr9k6kN+BLGLW0KAf8ZeXORIcK0XuhwXnI=;
 b=wHGhMZgLZZ9Oh3P4v8SGTl7z79q7IBrQ3uXg4q90nq8QL6to98ckiBFrEyfPiSQTg+HAoenyTnBXsIRlk6ZVlT21tBmB0OLleZhqG4MpxMzabPPHF1x/+ZvYLzX9sALicJ3uLWGyTSXr7TQJdhhazOrXHWKi2bjX9feXul0asNc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5527.eurprd08.prod.outlook.com (2603:10a6:20b:de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 14:39:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 14:39:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 6/9] block/io: expand in_flight inc/dec section:
 block-status
Date: Mon, 27 Apr 2020 17:39:04 +0300
Message-Id: <20200427143907.5710-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427143907.5710-1-vsementsov@virtuozzo.com>
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 14:39:34 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddfd52da-46bc-4a48-f7d3-08d7eab8ce47
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB552786A0A0B6F113FC168766C1AF0@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(396003)(366004)(136003)(346002)(5660300002)(107886003)(316002)(2906002)(6512007)(478600001)(6486002)(66946007)(66476007)(66556008)(69590400007)(1076003)(2616005)(956004)(81156014)(16526019)(86362001)(6506007)(52116002)(186003)(36756003)(8676002)(8936002)(6666004)(26005)(6916009)(4326008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TG951CHFtukKpezkK8HOduUm8JyXTCU5eu2QX+267++6otR2+CY94bjlOWQgBZjsWu11ER/ZO8CMDSGPNPQJv5dTuOFMrSp59zxUPZ3FOYKusXFVUutJf/Wf8V9lJb1dwRIsfJqQIFZw0OQJRYfuyOUyE8f4j7CM4/XLBHrtr92m5NCcYhfquuK/MvbGU524VQnZIyRZDSUeeLJSDvyQcGglosKXJLwhwnrh1QuSDpmpnoakbq7CJN9nwUyuYqAp17oW2FvwkgVhjmCtEQUpbj7/J8nxDKDIgEG20uOe+5MsrzIN/nxeVOOMO2xcrCoYQPaw6mvpI3n4qLeE9npEcxo2//s9e9EntFtUH9lUqdqWDj4WmMz1rMDDgXbHQJwVNWkCNCtqLE8BblhSLtKHXYy1yqwIg4hpJ7O0IeRZlsK8N1FMpEp8gc+/hPXirZfdY4FgmhyzvYo4WfZDjAhYUUYDHhe7pNzzwcaSdHAuUohveHXCc6Lz/MxsToS2UGcE
X-MS-Exchange-AntiSpam-MessageData: FitGfqN9LndXtl+ca+KM90gUAelAYjFp8J/wgEybB/FKackUFjM2naGfy3iH4Wq/cK4Ims6ey+Rbp/VWXhw745syh7FcizO1NSU9Wc+CpkdoGk+f7s7LgvXHWOh7eEheGktSO/cssJd6sljxczcRbzhfWDp/mDigmPFIPVW03pglo2lYnRWu39oauIj83dDDZKHdVkQGUWTbZokzbJfY0vpfDw2bcwY4hddUgz4r8peXZ6qpnsK4PLUyziRB2OHnBn72zms+VClMLtaJKy962XCFoPTx72/cPNLwiaN3kzaXhWiFBQXXlwXkt5bGHRWc8IVfofLdsDLad1N5Os2LGPyaWsiBsAZHB1959ylODeA/Auo5cByxOqFBwcgXXsGKaymUSs8TGFe6JR2BfsgqsYSSslHzydswwNfZPguSt1fZ/RXtyqGlj7QW0Wp8ZdGQUgwPqSOzPOh0x8/ZgI2y5ZH3E5/U+6WX7ngPRNMXCF8TSlWjwSlvl3xfakj9Ku+cWK/H8EkU7wTbUN+0m8Sn5dzhi4+kG163zLvvACYrvtqM7Dj8U0WDqUR3yrX/3TWPlRG+Ay20SrrSEz95hABZZgPAhFaicQA8LqtJX07sg6R9dbZiT0sPOYaFstcfSoD+T87MtkG5ef+kynA9yLY4LgNEA17DoKWAz63QAcGDHcDVsM7n4uTxxf7zAu3se22fqAQprjjZb1h3SmJv/pWbYFIDQGPvEYtGBeknUZ5zl2vZAMRpJDu0gj2V0TpFVu7HmmZ0ty3hvJRDNuOWroJuwkjHr1J3OKyj8SrYqg+k3ck=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfd52da-46bc-4a48-f7d3-08d7eab8ce47
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 14:39:35.3054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kh7Tz59AofkKUf50MQz1XtXM6dUB5xuUeg2WudRF8p4oTBHMLArGXyAc7MDMPjriRAAacgdoKAHabzJ3LB4syj3isBmGIKMufkJObskFEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
Received-SPF: pass client-ip=40.107.22.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 10:39:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.22.133
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's safer to expand in_flight request to start before enter to
coroutine in synchronous wrappers and end after BDRV_POLL_WHILE loop.
Note that qemu_coroutine_enter may only schedule the coroutine in some
circumstances.

block-status requests are complex, they involve querying different
block driver states across backing chain. Let's expand only in_flight
section for the top bs, keeping other sections as is.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 65 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/block/io.c b/block/io.c
index a91d8c1e21..1cb6f433e5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2303,6 +2303,10 @@ int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
  * _ZERO where possible; otherwise, the result favors larger 'pnum',
  * with a focus on accurate BDRV_BLOCK_ALLOCATED.
  *
+ * If 'inc_in_flight' is true, in_flight counter will be increased for bs during
+ * the operation. All nested block_status calls will increase the counter for
+ * corresponding bs anyway.
+ *
  * If 'offset' is beyond the end of the disk image the return value is
  * BDRV_BLOCK_EOF and 'pnum' is set to 0.
  *
@@ -2321,7 +2325,7 @@ int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
  * set to the host mapping and BDS corresponding to the guest offset.
  */
 static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
-                                             bool want_zero,
+                                             bool want_zero, bool inc_in_flight,
                                              int64_t offset, int64_t bytes,
                                              int64_t *pnum, int64_t *map,
                                              BlockDriverState **file)
@@ -2372,7 +2376,9 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         goto early_out;
     }
 
-    bdrv_inc_in_flight(bs);
+    if (inc_in_flight) {
+        bdrv_inc_in_flight(bs);
+    }
 
     /* Round out to request_alignment boundaries */
     align = bs->bl.request_alignment;
@@ -2409,7 +2415,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
 
     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
-        ret = bdrv_co_block_status(local_file, want_zero, local_map,
+        ret = bdrv_co_block_status(local_file, want_zero, true, local_map,
                                    *pnum, pnum, &local_map, &local_file);
         goto out;
     }
@@ -2436,7 +2442,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         int64_t file_pnum;
         int ret2;
 
-        ret2 = bdrv_co_block_status(local_file, want_zero, local_map,
+        ret2 = bdrv_co_block_status(local_file, want_zero, true, local_map,
                                     *pnum, &file_pnum, NULL, NULL);
         if (ret2 >= 0) {
             /* Ignore errors.  This is just providing extra information, it
@@ -2459,7 +2465,9 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     }
 
 out:
-    bdrv_dec_in_flight(bs);
+    if (inc_in_flight) {
+        bdrv_dec_in_flight(bs);
+    }
     if (ret >= 0 && offset + *pnum == total_size) {
         ret |= BDRV_BLOCK_EOF;
     }
@@ -2473,9 +2481,15 @@ early_out:
     return ret;
 }
 
+/*
+ * If 'inc_in_flight' is true, in_flight counter will be increased for bs during
+ * the operation. All block_status calls to the backing chain of bs will
+ * increase the counter for corresponding bs anyway.
+ */
 static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
                                                    BlockDriverState *base,
                                                    bool want_zero,
+                                                   bool inc_in_flight,
                                                    int64_t offset,
                                                    int64_t bytes,
                                                    int64_t *pnum,
@@ -2488,11 +2502,13 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
 
     assert(bs != base);
     for (p = bs; p != base; p = backing_bs(p)) {
-        ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
-                                   file);
+        ret = bdrv_co_block_status(p, want_zero, inc_in_flight,
+                                   offset, bytes, pnum, map, file);
         if (ret < 0) {
             break;
         }
+        inc_in_flight = true;
+
         if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
             /*
              * Reading beyond the end of the file continues to read
@@ -2514,15 +2530,16 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
 }
 
 static int coroutine_fn bdrv_co_is_allocated(BlockDriverState *bs,
+                                             bool inc_in_flight,
                                              int64_t offset, int64_t bytes,
                                              int64_t *pnum)
 {
     int ret;
     int64_t dummy;
 
-    ret = bdrv_co_block_status_above(bs, backing_bs(bs), false, offset,
-                                     bytes, pnum ? pnum : &dummy, NULL,
-                                     NULL);
+    ret = bdrv_co_block_status_above(bs, backing_bs(bs), false, inc_in_flight,
+                                     offset, bytes, pnum ? pnum : &dummy,
+                                     NULL, NULL);
     if (ret < 0) {
         return ret;
     }
@@ -2535,7 +2552,7 @@ static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
     BdrvCoBlockStatusData *data = opaque;
 
     data->ret = bdrv_co_block_status_above(data->bs, data->base,
-                                           data->want_zero,
+                                           data->want_zero, false,
                                            data->offset, data->bytes,
                                            data->pnum, data->map, data->file);
     data->done = true;
@@ -2567,6 +2584,8 @@ static int bdrv_common_block_status_above(BlockDriverState *bs,
         .done = false,
     };
 
+    bdrv_inc_in_flight(bs);
+
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
         bdrv_block_status_above_co_entry(&data);
@@ -2575,6 +2594,9 @@ static int bdrv_common_block_status_above(BlockDriverState *bs,
         bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !data.done);
     }
+
+    bdrv_dec_in_flight(bs);
+
     return data.ret;
 }
 
@@ -2624,15 +2646,19 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
  * words, the result is not necessarily the maximum possible range);
  * but 'pnum' will only be 0 when end of file is reached.
  *
+ * To be called between exactly one pair of bdrv_inc/dec_in_flight() for top bs.
+ * bdrv_do_is_allocated_above takes care of increasing in_fligth for other block
+ * driver states from bs backing chain.
  */
 static int coroutine_fn
-bdrv_co_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
+bdrv_do_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                            bool include_base, int64_t offset, int64_t bytes,
                            int64_t *pnum)
 {
     BlockDriverState *intermediate;
     int ret;
     int64_t n = bytes;
+    bool inc_in_flight = false;
 
     assert(base || !include_base);
 
@@ -2642,10 +2668,12 @@ bdrv_co_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
         int64_t size_inter;
 
         assert(intermediate);
-        ret = bdrv_co_is_allocated(intermediate, offset, bytes, &pnum_inter);
+        ret = bdrv_co_is_allocated(intermediate, inc_in_flight, offset, bytes,
+                                   &pnum_inter);
         if (ret < 0) {
             return ret;
         }
+        inc_in_flight = true;
         if (ret) {
             *pnum = pnum_inter;
             return 1;
@@ -2682,11 +2710,16 @@ typedef struct BdrvCoIsAllocatedAboveData {
     bool done;
 } BdrvCoIsAllocatedAboveData;
 
+/*
+ * To be called between exactly one pair of bdrv_inc/dec_in_flight() for top bs.
+ * bdrv_do_is_allocated_above takes care of increasing in_fligth for other block
+ * driver states from the backing chain.
+ */
 static void coroutine_fn bdrv_is_allocated_above_co_entry(void *opaque)
 {
     BdrvCoIsAllocatedAboveData *data = opaque;
 
-    data->ret = bdrv_co_is_allocated_above(data->top, data->base,
+    data->ret = bdrv_do_is_allocated_above(data->top, data->base,
                                            data->include_base,
                                            data->offset, data->bytes,
                                            data->pnum);
@@ -2709,6 +2742,8 @@ int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
         .done = false,
     };
 
+    bdrv_inc_in_flight(top);
+
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
         bdrv_is_allocated_above_co_entry(&data);
@@ -2718,6 +2753,8 @@ int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
         BDRV_POLL_WHILE(top, !data.done);
     }
 
+    bdrv_inc_in_flight(top);
+
     return data.ret;
 }
 
-- 
2.21.0


