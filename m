Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D366BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594B720691
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AFvesGWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594B720691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizjJ-0004ef-Ay
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 08:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jizTM-0000Ax-4Z; Wed, 10 Jun 2020 08:04:48 -0400
Received: from mail-eopbgr150135.outbound.protection.outlook.com
 ([40.107.15.135]:4365 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jizTL-0004Tg-1Q; Wed, 10 Jun 2020 08:04:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCUo4AXm0UEBxfWT+2/pAETNNnRFCnxVQksCbMSDeR6Pq/g1PyNj7vglaKYTvk57uSx82+me88fD93MruWEtGQPNdYGtjZfT+NO39TWt116jpXfsn+AV9yTYP/U/seH/6YKUD/4rM0BkANTZ/uMcJSn5R+eSMWZw0B9GoGxPvhx5RUNt3pBExMh/+B92YLQKe+ptxcoIkyQ3iFc7YZfimBnfV5+jueInaSgJH0GpdxiPm/tfnBfdqiRYnq5YzHWSqvLBzU9KN2Has7ibr0R28Plk0VMzAgOEk/TO6saQExhhGBGrdHb4jEiMgyVLt9UoqkngzthFdEVGrgBCJELxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HhtfWVjzBxvjaWDnQUHOi8GQ65R49n8NNIAhxk4ipw=;
 b=QNf+C0zOKeMqqYVT1Dfp6hMhshDp0hE5J23KDj7CvFB+THLPdn/XS6Dyp1wa1GPdD80QqZkLC2R0HhWxGTolMK2aw8UIB+sYIYgQoH/qHnvQ7jrGjTkvIHVyOdZm+iM/CGNjUkui0OFsHSMQxJ5i+mkEsHp0Z65bztdN3/U6Rjjb7ERnVEg2QKDMXbOqAKmSnHCgldoqJsoFcsgF57iTpVT3SJg8GUhfeG7Of+cNdJ+K/1NEkWwPcE58LZkF9AdXLu66FwAtEh92O4ygr0BHr38AZMGyB/mNvP1CtYBIBrXjlqyN8p22Zpa0g9kcmuafE1+sTQSAHta23WXRb5b8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HhtfWVjzBxvjaWDnQUHOi8GQ65R49n8NNIAhxk4ipw=;
 b=AFvesGWEv9p4pYBGFvnm7NAFn5Zivp38Ou+vJg/jDFAiYUZy5FLkCqq7eBZaK6lIDDazX5FSusLzuM7byfjRNSVcm7cTrBO6UgLhI60i6/ct9GA+xV2RAwPGFD2Xs+JmtaYN8GXvrLtpzx4C4Yorqf+Q4WslbryVKEXFnPpz+jc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 12:04:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 12:04:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 1/5] block/io: fix bdrv_co_block_status_above
Date: Wed, 10 Jun 2020 15:04:22 +0300
Message-Id: <20200610120426.12826-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610120426.12826-1-vsementsov@virtuozzo.com>
References: <20200610120426.12826-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0104.eurprd05.prod.outlook.com
 (2603:10a6:207:1::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.166) by
 AM3PR05CA0104.eurprd05.prod.outlook.com (2603:10a6:207:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 12:04:41 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0862f2cc-61ea-43fe-a434-08d80d36755e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB549563FB571B121EEB8F0C8CC1830@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hwj7Dxe/JTb6UAM/QJPo43wxB9IKO7knPE039gq/ExsCzi1l9Aekj3lqu0+8YUwLgzoyvoOf2XxPPA5asAwnwvbjAgRj/Vbfz7edThWvQRJRmHM+hlG2TSKmHNBRrYBuQHBvG+FEN3ciKz8h2/8gU5WORE9nzUyvM5x9mp1PgIaXQuF1peZ9QQxF8bJ3DCfqyVExuJa64ISSCmsFMBeD/TqRwA74rLRTEFbEbRfg3eESYg/2YVsM9LMQ18MERdDBKjUbkUW0K91+LBtjJVOsqILyZYqnrnTzYvrvqczS6ovn50c/c0+Vr7VBMr4WdkVTnhEQtFJ1hg5cxBtJnagpAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39840400004)(366004)(86362001)(8676002)(478600001)(2616005)(107886003)(8936002)(4326008)(956004)(52116002)(83380400001)(1076003)(36756003)(66476007)(5660300002)(6506007)(2906002)(316002)(26005)(6666004)(66946007)(16526019)(6486002)(66556008)(6512007)(6916009)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: RfGNh02zesZui2JxaI8LVqzLDOvgTGVw69QSJ1XtgAj/Zg7dko0CzLr7ArdmVmUHI2u7UaZGLbo/qcsAFloZLVGip4UtVO3HEYCwhH9hBOEyYxvUt6LOgcxh7yJjWw21qH43sZOnx0L9WUuk6seGcHqCVeTjIDgPtlVzxcSFNJKe+8myVNzUlpW9F/jN41DadTh0vqu9TslYBDJQe+ZPRcqyC8Aag1xjzS8no+CB4aSwtfHOnqTEZ2pbk+AqozbrRIprJ85cWT3ba2bpqk1Sl0Fbm4pBu2vjir8TpG7rHZV6X80S5DbCFY1nJi7egfjG6rdtRbabLb5ZZLjVLLPXqNQ/RAPvgHLAxR5DM/KJy03UWiuyJc6TOq32QpdXjdzI21mKtwp1ORhRBNUAVZKMT14dp++L0pZ8zpD5jbFGBVrAGyEBcAEKLP6B6Bo+0TpfjasQ27k0BxZDyVg9rwg4IpkWcSRO9BA/ZylCpBTwpkHhJCYXGYmFCe/E+lPimcsC
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0862f2cc-61ea-43fe-a434-08d80d36755e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 12:04:42.3557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtrtGKDHW3Pqr4MRiOhZpIkqmZJEz490eycKg4BX/5OZiOc26OOX8OX5RUj5AnHzKjVTBf0tYVPouOMkWeNJZfL7eNESfXHKUlraGIO5SbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.15.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 08:04:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
index 83ffc7d390..f2a89d9417 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2373,25 +2373,46 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
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
index 0cd2e6757e..ce4cf00770 100644
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
2.21.0


