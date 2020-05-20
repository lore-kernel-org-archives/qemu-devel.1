Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE79C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A55C20899
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZloAy2Ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A55C20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKDa-00036X-Jn
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbKCb-0000gs-5q; Wed, 20 May 2020 04:35:49 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com
 ([40.107.8.90]:21573 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbKCZ-0005RQ-UJ; Wed, 20 May 2020 04:35:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/VYUGyVSDTQn/8gWzyjEFdlrhAQ83orGYfX/u/YghMYENQjwSueT+tbJpmqR99thtOqIX/WFpF0+TVpJeIGlaRV+TKSWJbaryKN06a2DNTe+Aq3o/no68sKV3qiHPrHKf6JJ/Nw5o72Qeyb1OaC2IeSNYp8S6E/L+HyeyV1MEp2C6dwHZlBguKLJXbTt6sfxhkBPfBu2y2Rud3lP01FJc9Dxlm1UyWjASjmEm97OArljcnJFQHwJcvFSKmojcI+JVve7VmIDbzmf+f+teu5cpIrg1/6CY2BCx0c2EQ9yZz+dPrJn0kCJlQuDS1Q8t3DAq+upaB1aajkkw+BKIvGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CS7xwXSl8wZJavrF3vXnDVu/RKNJMA3gGBFuTghOknw=;
 b=a2jgMVjv+o2VNhkqsl32/oF3mDoB0bR3DvkxqCCQVxBkHNg7PGsp85JOz+QmoTL9FFTy4d1/s2qY+6gRXk9m7jvAT1MSVGnJrTSMq7CwCXDhsjnLIYfMroa8yXHnwWloPXzbqABNcSryZUAXN4V1q1Pu7fU6egAXbOIb7CnYctIV2sR4/5/cXXMU+QHPb95sxfozetVa7QAVZpMEnBOyFDWnlVWwwuReRJ6G30HIYg2sizU3poUiGi4zaVDEVHmE2XKaDwjSpIG0KeWDggB0UDZ8MJ6by9OB+1PMt4bHbdeq4Vq32W0sWSqRuCdEIqi6ofW9txrwM6kwJKucppNCfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CS7xwXSl8wZJavrF3vXnDVu/RKNJMA3gGBFuTghOknw=;
 b=ZloAy2YeG41m+Bvrhkg2kuxfmJzB4PytepZhrO/43n2R+8ruV63b6xaPIt6S2DMIBdTaSUrSGLSYWpfDSsFFEaIoIGuohHNBotTfD2z8tkMD8epInZn9qYCei2tbDs3aVzpXkHDGogYEy5IM9qAkLyWi42flfuw8p8bmfsCAp9s=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 08:35:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 08:35:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 1/5] block/io: fix bdrv_co_block_status_above
Date: Wed, 20 May 2020 11:35:16 +0300
Message-Id: <20200520083520.25793-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200520083520.25793-1-vsementsov@virtuozzo.com>
References: <20200520083520.25793-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0092.eurprd02.prod.outlook.com
 (2603:10a6:208:154::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.147) by
 AM0PR02CA0092.eurprd02.prod.outlook.com (2603:10a6:208:154::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Wed, 20 May 2020 08:35:42 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 522a8c4f-b2e4-415d-33af-08d7fc98c8eb
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5448BB133F9B572699F8DFF4C1B60@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcvbunlWx0FRNlpLEVzwEVmp4DOZUe1k05CJWfRB4DSLrM1ITZU9vmNClq9GXG/n7BsCly6DG8v+iRswbUj4vnhqUQ6KJAD6jLM51uyfbBp4+Eh6Ai2DUc1efwY+xwcOch4iQmUCagFz6PMkHIiJavU6RQtR8gaa1SuNyns43AubLodEsbNlYt/c3qU+SyKwLwnzU+LP+FWfLhT8kkQW9TiMcMxNFOwo+dTzFNnL+lWLT8IfDY0ai9VPgJj9imOIBoU+1NuStXeTRZJrAccLqcGNwM0rU2QY7g4AfJ2tI05IotGL1J5sz9i9WjCofO/bddqdYA3m7zDjE1+I1e1xez655t3VHhXG3hyfwn3Tc3zZn+iZUiY/3QjYo5euEGKJvvvOEWB6lqZTpTuPbzIBQ2NaJBHReBQPSz+G+kfyaWHdDeECRamFXNSv8dh1VLyWsMXDOcw+aP2+7tFZEq3SlloDslRa8JmadOfY2bUWL4Hawl/o6ne6Bkq03WHARvoE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(6506007)(26005)(8676002)(6486002)(52116002)(186003)(16526019)(1076003)(2906002)(86362001)(5660300002)(8936002)(36756003)(66556008)(4326008)(316002)(107886003)(478600001)(2616005)(69590400007)(956004)(6666004)(6512007)(66476007)(6916009)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rfKKQPCdIZhFvmBDygAX9fOpNW5u31RekW+u8nKfDZh9p7z1MY8Lb/nEDt9NktUyWXJ5N7zZvk6AOKIFEKTIO5EAcbM91Yhybtcl/AMRXZpASBFh9/3XjV4Xx7OMcEgTNKw+XdrYN7Sv2xOulAgXTrcW6A1r8/T2+tD+YcB9hyzD4Jv1bh9gKV0eFO7cRVWLyJ4PcoXqDku2kmfR4tH2TmE6bJdCjzU7c9FlrIg1W9/CRwDcJVbd1Lyo0+F2XyAO7OIifCpRaya8b8XklwF0zTdENKmet661PZYT2y+v0MGDloOS6DC0O9ed5eb3x7Z6GuyZ/tkJua1l4EAymSgzXC2iildvjFl2RLIwiMAjpU62WwaIEPneuyJQsCe35G2dSd3Nj+7WLeflkAAvtY4+CVoL+bbfbxFP8gjvnKhi5KL2kNFjrFXoq0tgK27cbFHSv/xM4CdrPiirM/4MwU7sJkYkbEhFdXwfHHMp3qzDvGoGZGAYmLbzINI3g2By0fhZ
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522a8c4f-b2e4-415d-33af-08d7fc98c8eb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 08:35:43.3704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzZgWnMRrq+j0/g55R/8dRgZjCr7M6odpQdkSJFX0h37hfakgswFUfVD7tj/HKaETx+iePTQDozvSAvPnWC5WP/Kvldv8B/Sc6rhMvFHpQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.8.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:35:42
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
index fe0ce39799..ac43c58c7e 100644
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
+     * example, zeros which comes from the region which is unallocated in
+     * the whole backing chain, and zeros which comes because of short backing
+     * file. So, we need a loop.
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


