Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1969EC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82DAC2396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="N+67AqMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DAC2396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLXAb-00066H-LU
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLX6P-0002Bp-AD; Thu, 24 Sep 2020 15:40:25 -0400
Received: from mail-eopbgr30115.outbound.protection.outlook.com
 ([40.107.3.115]:7591 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLX6N-0008DY-Bn; Thu, 24 Sep 2020 15:40:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcFNR2iwgO65DssyDtHHbPGsLAtfX258QZdlRN84ED6uIahFy/ECtwJgzLi2GgN/EKM6bU8Be0e3H8VvNbWWL6V24GJ8RzRQxOktGD4bF2BmMO29GhIsUg2wyFhNmqYCx6BfUaAsWnLpPdg66MsZmUPTTfr0/n8NRqwBSuVFcSoUVpjyKnthHJojqyGkJhC2tmKE7r9cdJlaFD00nwh0UtZRWsPf8wXjmDBF4ViRjSTz9Koo+A6FN87CDVxLvaXs9NNVRLBKdTnQzRPv2wHPuk1ebto69Ds2f2Anw/isdDrkp01F3Re8x7Mnbiz46Dk5EAaWP6p+NFAxmHVvMrdHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkRfw4kEUxTSccJbhh4IDctQLCYHDfA4QRm9EPfk7/M=;
 b=OWF34cebTv55hIrsfMtSRP9xOUW3hXPN0tMZnTQr5bYdkCaroOjtiD5IqNexYT1k3dK8NqLLzKaKTJzCUXMJn+FuhcYvmScuhLIErihIsCpZha/AoOxYnvuwQ0Dwnp7NN4eIf4s6g65xd+fZ5ZUH960ytX1nEbFOtgw9JjHsjkDRFFwdxEwp5XwJcMXDnmr7ec+/wmWnSAOyw1uqfrgPwQoaefhzPvpe3DrUFBvLS2MniMI1PNFdLL04WYdsY3lGsNw9HpaBfiGTefod8xP4CjNI99V5wjU593PhB7mkQWlAIytsjt4jNjjhfEKMvHRtBF5sixB3v6obV52bkTjmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkRfw4kEUxTSccJbhh4IDctQLCYHDfA4QRm9EPfk7/M=;
 b=N+67AqMTXVK66RikcD4hsOxKrNDFj5VTD1wl9Jhhs3wV1lxY79ikcGq38j/0/VPcfyv3g5s9XC12mPSKBCOE/y72N0lr7rMtbaZVmLlSR2EEmNPJr4CT7bWhWPIeTah5nI2rLoG8kpJc+l9t8DJcVLYxl3kNi+JV3tDJsMiqTkM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3288.eurprd08.prod.outlook.com (2603:10a6:209:47::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 19:40:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 19:40:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com, eblake@redhat.com,
 Alberto Garcia <berto@igalia.com>
Subject: [PATCH v7 1/5] block/io: fix bdrv_co_block_status_above
Date: Thu, 24 Sep 2020 22:39:59 +0300
Message-Id: <20200924194003.22080-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200924194003.22080-1-vsementsov@virtuozzo.com>
References: <20200924194003.22080-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0112.eurprd07.prod.outlook.com
 (2603:10a6:207:7::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.94) by
 AM3PR07CA0112.eurprd07.prod.outlook.com (2603:10a6:207:7::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Thu, 24 Sep 2020 19:40:14 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fc02405-c4e8-4c35-5348-08d860c1a8f7
X-MS-TrafficTypeDiagnostic: AM6PR08MB3288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3288395805B288EF232273BAC1390@AM6PR08MB3288.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5Fr0q3plh31MUQZ6c0CxL0vQH4C4Gw6b/a3W6ErZonl2eCTk0qfPJwLIcsRrB61ERPYNs97aNMfloIeU0Mnz2hkuKzRGe+ve00AETDIhZHwIHF772BL24EfmUqzvLk6hCYF8+3mPdc9IOawRMjK7gyv6dWsapYdCZSCnmuZxZcfe039qTdss5SEVeeRLvikVMoa6kubj7089YZnMc1lxVdDHCTvlTHzkLDARuRQFjU7fwDOIO5UqXBryM0lwd60kY//M0r7Kr0wLghBcd6uMZb72ryxWMjv9sZTIRKxgzME8oD5e56mFtpdDcLaY8Fgn5Q2TkBEO+EAzUXMFy2WZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(366004)(396003)(346002)(136003)(8676002)(66946007)(5660300002)(6916009)(8936002)(1076003)(26005)(66476007)(52116002)(478600001)(66556008)(4326008)(6666004)(186003)(6506007)(16526019)(6486002)(2616005)(6512007)(2906002)(36756003)(956004)(86362001)(83380400001)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wU0s+vSs1GPsI8E17nAL2XmhUjRrw3wxiYQO1ZXhHxkZemm1rW/QW4dnE8i8dTH1Xlk6a3FjT4FNrlSwiMV4G1EQUDenWicROsnJQY5MSKcyGZiZeVE5xYW1O2cI4Xtx3ZKcrCe0LQJ5wNi6yvNObImP5TPd14sWsPY8c2EGhOBfvpsQY7bheCh7S1g8Xzk6+SmDtl7gMHrBjW4VGmuD6ws+VqW4Bqzp3CfnjRmax83yIjTj6fZegNxlQamiXnDT/QI5KucWS8uAn9EIgt9EZMtrnId9p1IQpG4DivWYtkH4pZcklGJNRl2GO0XknhrDMg/lJKMnwEzqsfqdVnSjLtnHSv4j8kmg8GQi1jDm1lfeaP4o3ZQycqCCbylTtBHnzjgDGEcd8dVlOSS8Zh/2KtUVS7XYLOrQd8Mpow0ltWuqO8YL9PMxoZMc6A5I3o289RqnAEuQCqncWLnMj6fNE9D0mHBuzAn1a87SJvyjxQed3y8TVGFPn0k7lDkOqVDz/vvhM6uYCMF32UKEIrjCQ+9Gcn6fq+05yKECcfS/9A26bzNRS4dDTsaF3ZQF6t74mJP4+zjTI9NhjhCfj0m3NqeEZSRohWLrnuQQ72qgB6GQ0bdP89eB24RyCaYlxgqAuOPzva0XQI+IbwHqumoDJg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc02405-c4e8-4c35-5348-08d860c1a8f7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:40:15.4084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntR52+TFYMeF5tHoJQJu56yd0ScwDm8b3ZBXrD8oeynhM0oiNuzgf85HP7/vyc8QU703OPGs2nvopqjiKH2no9lNmcPuKDrkSe1V7LA+OUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3288
Received-SPF: pass client-ip=40.107.3.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 15:40:21
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

bdrv_co_block_status_above has several design problems with handling
short backing files:

1. With want_zeros=true, it may return ret with BDRV_BLOCK_ZERO but
without BDRV_BLOCK_ALLOCATED flag, when actually short backing file
which produces these after-EOF zeros is inside requested backing
sequence.

2. With want_zero=false, it may return pnum=0 prior to actual EOF,
because of EOF of short backing file.

Fix these things, making logic about short backing files clearer.

With fixed bdrv_block_status_above we also have to improve is_zero in
qcow2 code, otherwise iotest 154 will fail, because with this patch we
stop to merge zeros of different types (produced by fully unallocated
in the whole backing chain regions vs produced by short backing files).

Note also, that this patch leaves for another day the general problem
around block-status: misuse of BDRV_BLOCK_ALLOCATED as is-fs-allocated
vs go-to-backing.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/io.c    | 68 ++++++++++++++++++++++++++++++++++++++++-----------
 block/qcow2.c | 16 ++++++++++--
 2 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/block/io.c b/block/io.c
index 449b99b92c..4697e67a85 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2350,34 +2350,74 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   int64_t *map,
                                   BlockDriverState **file)
 {
+    int ret;
     BlockDriverState *p;
-    int ret = 0;
-    bool first = true;
+    int64_t eof = 0;
 
     assert(bs != base);
-    for (p = bs; p != base; p = bdrv_filter_or_cow_bs(p)) {
+
+    ret = bdrv_co_block_status(bs, want_zero, offset, bytes, pnum, map, file);
+    if (ret < 0 || *pnum == 0 || ret & BDRV_BLOCK_ALLOCATED) {
+        return ret;
+    }
+
+    if (ret & BDRV_BLOCK_EOF) {
+        eof = offset + *pnum;
+    }
+
+    assert(*pnum <= bytes);
+    bytes = *pnum;
+
+    for (p = bdrv_filter_or_cow_bs(bs); p != base;
+         p = bdrv_filter_or_cow_bs(p))
+    {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
         if (ret < 0) {
-            break;
+            return ret;
         }
-        if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
+        if (*pnum == 0) {
             /*
-             * Reading beyond the end of the file continues to read
-             * zeroes, but we can only widen the result to the
-             * unallocated length we learned from an earlier
-             * iteration.
+             * The top layer deferred to this layer, and because this layer is
+             * short, any zeroes that we synthesize beyond EOF behave as if they
+             * were allocated at this layer.
+             *
+             * We don't include BDRV_BLOCK_EOF into ret, as upper layer may be
+             * larger. We'll add BDRV_BLOCK_EOF if needed at function end, see
+             * below.
              */
+            assert(ret & BDRV_BLOCK_EOF);
             *pnum = bytes;
+            if (file) {
+                *file = p;
+            }
+            ret = BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED;
+            break;
         }
-        if (ret & (BDRV_BLOCK_ZERO | BDRV_BLOCK_DATA)) {
+        if (ret & BDRV_BLOCK_ALLOCATED) {
+            /*
+             * We've found the node and the status, we must break.
+             *
+             * Drop BDRV_BLOCK_EOF, as it's not for upper layer, which may be
+             * larger. We'll add BDRV_BLOCK_EOF if needed at function end, see
+             * below.
+             */
+            ret &= ~BDRV_BLOCK_EOF;
             break;
         }
-        /* [offset, pnum] unallocated on this layer, which could be only
-         * the first part of [offset, bytes].  */
-        bytes = MIN(bytes, *pnum);
-        first = false;
+
+        /*
+         * OK, [offset, offset + *pnum) region is unallocated on this layer,
+         * let's continue the diving.
+         */
+        assert(*pnum <= bytes);
+        bytes = *pnum;
     }
+
+    if (offset + *pnum == eof) {
+        ret |= BDRV_BLOCK_EOF;
+    }
+
     return ret;
 }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index b05512718c..a1bc16e202 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3860,8 +3860,20 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
     if (!bytes) {
         return true;
     }
-    res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
-    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
+
+    /*
+     * bdrv_block_status_above doesn't merge different types of zeros, for
+     * example, zeros which come from the region which is unallocated in
+     * the whole backing chain, and zeros which comes because of a short
+     * backing file. So, we need a loop.
+     */
+    do {
+        res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
+        offset += nr;
+        bytes -= nr;
+    } while (res >= 0 && (res & BDRV_BLOCK_ZERO) && nr && bytes);
+
+    return res >= 0 && (res & BDRV_BLOCK_ZERO) && bytes == 0;
 }
 
 static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
-- 
2.21.3


