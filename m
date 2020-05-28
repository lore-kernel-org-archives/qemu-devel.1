Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351D4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F373220776
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WqFrkuEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F373220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFaQ-0008Ob-3L
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeFZK-0006SG-Ac; Thu, 28 May 2020 06:15:22 -0400
Received: from mail-eopbgr140105.outbound.protection.outlook.com
 ([40.107.14.105]:20613 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeFZJ-0005Iy-C1; Thu, 28 May 2020 06:15:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnO5OKKkP/gAeOoz0N1gNNMP0QyvanKeBEiwKi1dJeIEBwv0Cov+YRHoLjhfWOnbVZdToh4z5zzh2NaLzurMR4fcdGvhP1fRzMEIouwTU3rDsL2Ti6grBZFCjoJ/WEqbdIeGNM7sCtlawQZLToU8/1AEtVdFDvmyvW+hpuSLk532x2T3STQqwC6m3tJxIVKh27LffdjLvjI1NVuKYwX6LGQSL9lMK9raf1zjOGoUbXigGGV8/fftbO9qGXaiB9a8OmY1Yisq1fTspB43MFzluItYc+iOxoaYHKUvAbgZp1MhK6bQDOUrxt8fZViP461GRhzhlvCUJPHi3TWG+0eoiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2StEwhYIL4tDcibdFY7OWSFbNZg8+mMWNl+C+YOQW98=;
 b=m/l8TyzRy/zhDZ+5FeMZCBuyNotoINyz8tt8EMNRfNVS9mD3VA0oztdc4qO4J6BOFBeOEKzTx2g7VXl0QHVVk9JIPdslDK97TJ7MEO1xnf+sqi6Ux+9YJqi+V5a+IG/B4nARrp4xxaH3KTSaWDXuaoC0m9qsqN8wcxnPrIPf9gevwnCgRyKW7pzE9NFGs3DebWZZTjPRxAmmYfgM3HhX4bJlOB20v6wYWWU9uYBleOCPbWKUBJVefQnpMBMMgTH7rLOw07hQQ7Dv7U+CXzodTgyM2kULNeRafMTaR23k0m4VpdusrmJbrF5ixwzTV/x/k9hKSRIDRH2Q0A9fN/a7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2StEwhYIL4tDcibdFY7OWSFbNZg8+mMWNl+C+YOQW98=;
 b=WqFrkuEvXzOu2gesJqlKA7f/C/kG/vL9DIkZnbrKsvWFqjKrf3m9UIznS95KWkkktU3tKmx2KSFrH95mdUK82TI+Db+mPQNa0kfxC/lZSMscIyzPQhGGRbYdVeTYeX47v3V33NSX6RqT4Wj3VCheFJW/hX47rZBcgoUrw09QHUA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 10:15:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 10:15:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 1/5] block/io: fix bdrv_co_block_status_above
Date: Thu, 28 May 2020 13:15:03 +0300
Message-Id: <20200528101507.151161-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200528101507.151161-1-vsementsov@virtuozzo.com>
References: <20200528101507.151161-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.178) by
 AM0PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:208:ac::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Thu, 28 May 2020 10:15:14 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc2dec2b-3e55-4eda-5d3e-08d802f003ef
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB531792D90CD575CA5D319B11C18E0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FS9UuQvd+7tibNSn7KSYZlrQkPMjy96a9EyriQOzhrN3CkHclPG35ESiOU3oESPYUYqUThAEsaqPXwy0Op7XO/qocpELlM5FdLNPCK3OcGmwP4dIyRidZ0CWLPgfP9LXnD5fsGfLErDhLF40tnB3MNpWGY2UKTEtQFDOX8JTiIZQUf5YkK92tJGwJ1rCx07Esnbr5gbF+g7P5gcciQwVTdFw3btceCPLnIXu/jz3kg3ahXtyXjYxIgrn01MbpVf6YAp6JBD67+Nbp05LQD7oYqWv/rlzO3xLK96s8tIysa0wGEBVWyS9UiHmN7JEh+I6f58tpoJtguJig9gYYxvmuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(366004)(376002)(136003)(346002)(1076003)(26005)(6486002)(5660300002)(8936002)(6916009)(52116002)(6506007)(478600001)(83380400001)(16526019)(186003)(4326008)(2616005)(6666004)(66946007)(36756003)(107886003)(6512007)(8676002)(66476007)(956004)(316002)(66556008)(2906002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0wHniv/6aA4/maoHILvpWCVORUtXsRDF5u+rQWosl+1KCMJZzik0LBVVN3O33lC0gaDJwGH7n+p6xxCfvmCLaE4XpdIiqEbLsk5HWc3+x9nc4Ug1sqfjvzMha4JMPLbJMmd42Io4Et4Jzw3ihSNrNpDpqKYbOr/KlhCIK0NsZx5QcUWZNAdBHfn98rm906yA/IGl6HP1BiSwDrudORk8bxS9Oz8gJW//Z+F7D6XvR8M74bPPKhV1FuAJ2Qy3KsTIIYJ39vmb/RFMs6fUyThP/dmhoAuYB8YZp6eXCUPXWaOnibi9gTWw08gP9JwywSkt05zQgJ2T43eBvhGl53aTYZhic514i94rZle7KDct70SX7G4nHnP2A5Ic3PkVnPCTyDAfKYMvHsEun75kNAECq9QP6UWA7DNf3uvqPEDf+SHwurQ+naTvnDE7xeRo2EeDPznDPJPOoWHZlu1dXnSq/4fwqmWSO96Xghglt5GOFLA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2dec2b-3e55-4eda-5d3e-08d802f003ef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 10:15:15.5669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eze69kNtwZHJMfkmRuS51n16B5OFIjMknsTxpitgTFGkQokgvB7QRs95GurPwU0YSdBxN9l8ubnQz0vMxlcK63NSzkmW+NtAMXcwlREhCoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.14.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:15:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/io.c    | 39 ++++++++++++++++++++++++++++++---------
 block/qcow2.c | 16 ++++++++++++++--
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/block/io.c b/block/io.c
index 121ce17a49..412b91b08f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2461,25 +2461,46 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
         if (ret < 0) {
-            break;
+            return ret;
         }
-        if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
+        if (*pnum == 0) {
+            if (first) {
+                return ret;
+            }
+
             /*
-             * Reading beyond the end of the file continues to read
-             * zeroes, but we can only widen the result to the
-             * unallocated length we learned from an earlier
-             * iteration.
+             * The top layer deferred to this layer, and because this layer is
+             * short, any zeroes that we synthesize beyond EOF behave as if they
+             * were allocated at this layer
              */
+            assert(ret & BDRV_BLOCK_EOF);
             *pnum = bytes;
+            if (file) {
+                *file = p;
+            }
+            return BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED;
         }
-        if (ret & (BDRV_BLOCK_ZERO | BDRV_BLOCK_DATA)) {
-            break;
+        if (ret & BDRV_BLOCK_ALLOCATED) {
+            /* We've found the node and the status, we must return. */
+
+            if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
+                /*
+                 * This level is also responsible for reads after EOF inside
+                 * the unallocated region in the previous level.
+                 */
+                *pnum = bytes;
+            }
+
+            return ret;
         }
+
         /* [offset, pnum] unallocated on this layer, which could be only
          * the first part of [offset, bytes].  */
-        bytes = MIN(bytes, *pnum);
+        assert(*pnum <= bytes);
+        bytes = *pnum;
         first = false;
     }
+
     return ret;
 }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index dfab8d2f6c..85e49776aa 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3827,8 +3827,20 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
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
2.18.0


