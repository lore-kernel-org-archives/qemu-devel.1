Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED20C4727F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF722396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="funJJ1D6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF722396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLX8y-0003we-E7
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLX6O-0002BX-1p; Thu, 24 Sep 2020 15:40:24 -0400
Received: from mail-eopbgr30093.outbound.protection.outlook.com
 ([40.107.3.93]:8707 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLX6M-00085Q-A3; Thu, 24 Sep 2020 15:40:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KH34U0xOcA4nWKutmkA+fb7dF/KhPm5HH9WRQOxUrlLxwuSNNW0bHnNToHR4JpyRQZiZaM92o7ErKDuSnIaYvIFSp7Hzgh5b8kHzRIvAIIYnok/FUYCz4kucjvvzTEEAZuVemDykqVexbWbD74h0/+4powQ2C+VempHPDcMLe8A32UGSdD3XiZUIpJDhwkwZxN6Tfr5/wEg9NOIr8REd/MjSxYdW/rSmtSM+ri1opKEEP/+8s9+VdGCXVDDl2OM0HDxdsUdWKCWrz8WFB9/bEy6o1lFmkUiH8VGaNoVrhyFQPINnF0W+uGoBXnrrEM7zmVeoX43FxgBQVdK+5JP7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+58a/LB3xSKkKutG4S7iaGWfFnh9DqSQ2RIdOK+eFyk=;
 b=OS6bwyLDSwhuV19wjEnz52eoRg0/pBVoVGAOoinX+JXcWBsjmlnhN405rsP4qYhPvts3qLI6sdFxLwV+thMQu6IVjh1jDCI7k365wFWWpEMv7uFJTmXLaX3rOx7j3iDz733MICQXyxN5zt7PJkpZs0SA+cNdOpBGjUnrIMIOCPawxwbEMCFAzfDpqoi+qsZPlzBwvW52032dqWik+BtEN+PfxpmCN4CX0yycLGwC6ABPK7loi2/OkC8UOdKtSqq0m8L4ePoUcWyVSHm+WOX1SoTJNfzJF3C/Hz9Fp6vAFqy2FU+CG5ZC1OY12N6WnSNKJvbTHK/Zjdk0kNe5tC0xlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+58a/LB3xSKkKutG4S7iaGWfFnh9DqSQ2RIdOK+eFyk=;
 b=funJJ1D66CIYN3Snn/2A9xfJ7x/kkQQcDiqde9HXDyQ6897pPVD2xfALvtDUvw19e6qrg8ygGpGd3vzdoZEeeAC9HylqWPRedgtH4PLyJCMQuceQPGoNsNe+8rkuytDvJO66hvGLlYCd7npGjuFw9wX9Qfnn24Rc4VQvJyOUP/s=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3288.eurprd08.prod.outlook.com (2603:10a6:209:47::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 19:40:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 19:40:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com, eblake@redhat.com,
 Alberto Garcia <berto@igalia.com>
Subject: [PATCH v7 2/5] block/io: bdrv_common_block_status_above: support
 include_base
Date: Thu, 24 Sep 2020 22:40:00 +0300
Message-Id: <20200924194003.22080-3-vsementsov@virtuozzo.com>
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
 15.20.3433.14 via Frontend Transport; Thu, 24 Sep 2020 19:40:15 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf2a3607-3d43-4fe6-8612-08d860c1a979
X-MS-TrafficTypeDiagnostic: AM6PR08MB3288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3288E37B410F56B0E76C869DC1390@AM6PR08MB3288.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brKHj7A7BO8Riaqiq+NcEaVkpjm8dTxUzxmxDgKsllXp2lfMCKOYvNaVyJTG/KTMLUvCPXOLzNPS5ukJVIUvUwW12Gb1ZXl6cSW9aef2GsOZcQMVkWblvu87Ft0z0B+NoZuhURf7WFMLvdLfkskUZerQiIRc2xeq/rKvKNVkhHj3ieZo0GHpbkzHe0Glkl0mI2hSJ3mZezi6EUPzStz07damDHZoUr7tEz/LmS03+8Z8vP4oMgtc02e9ddXYlXlkCIH9M5p8RpQ0A8QM5LOjxPT9UHiWv9E74LvMgbJuTQZOLlnL77zeRvKmlIxEeuyRzBoO1t8P33Hql7vuCbYn7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(366004)(396003)(346002)(136003)(8676002)(66946007)(5660300002)(6916009)(8936002)(1076003)(26005)(66476007)(52116002)(478600001)(66556008)(4326008)(6666004)(186003)(6506007)(16526019)(6486002)(2616005)(6512007)(2906002)(36756003)(956004)(86362001)(83380400001)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vczn48eHebnloMFHQ/OVUSDf+XCcju0BQ3ZMLEwU4jujZSRJ2gX/ePqGvsUoELEXrfRYx7/xofiSRdwN2RptEuT0apbaNNR3rkoeqAMRWHHT6XPDR+yATb/yJN70vKOMb4f04qhudMfeHaWDWTrrmRu1diRb2szUyib3jS362JXV82Vdsoc2xAhKBjHEVXkWOWs2q5B60+92nsxHcbPo0jdzODuDvJepgWcv3JLFh7/mDNPwzLWVCExG0tAaO5tpCt/2h80TnKpk1EGNj8Glst/PwI2FICVITJ5/Sqg0Q9DP9jYvTp4OpFClvk0vCact2rLVQKGJHwXELTWGzcpTKK0fqUHPZ1biLWzjI4k6q8ULDjwfJ5BnbF/JSxj2s9b64Lj/R2j2VBt3klHEaYclLJGUXhUo3vpYFcPFD0EauAVBu4XjQdh7Sc8oiXPMHmD6ZV+GTfOel0nIbCSVUc0vJ///Ahx7cz0Uk1WEMRBD3lvR/w8Eu+ZXRzv9Vs5CvLW9TxB7hJ3BorQvZMsqkGOwT6XjnrlFIwbPVyVf8EwQjpx8fIpfSG8Q5WaMrg42cyjw4TnVpHL0biX7s0PZ8ao6k6emIHZVqUSUi+MO7/Bc4kWo00l7+az0ht1Z0QlPtnXQFEQJ/j6+ACLS2a+9xzvJsw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2a3607-3d43-4fe6-8612-08d860c1a979
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:40:16.2726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5h5rQqFGVpUcSl88FIAQeqe7kEqawmK8+G35eRQS6EQHyvfX5XeweNjQXlIjkvKdnTp3bS02B+wCP/uh4fM7YXj0YQnIXFUHZwYpeO8l/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3288
Received-SPF: pass client-ip=40.107.3.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 15:40:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In order to reuse bdrv_common_block_status_above in
bdrv_is_allocated_above, let's support include_base parameter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/coroutines.h |  2 ++
 block/io.c         | 21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index f69179f5ef..1cb3128b94 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -41,6 +41,7 @@ bdrv_pwritev(BdrvChild *child, int64_t offset, unsigned int bytes,
 int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   BlockDriverState *base,
+                                  bool include_base,
                                   bool want_zero,
                                   int64_t offset,
                                   int64_t bytes,
@@ -50,6 +51,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
 int generated_co_wrapper
 bdrv_common_block_status_above(BlockDriverState *bs,
                                BlockDriverState *base,
+                               bool include_base,
                                bool want_zero,
                                int64_t offset,
                                int64_t bytes,
diff --git a/block/io.c b/block/io.c
index 4697e67a85..b88c7a6314 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2343,6 +2343,7 @@ early_out:
 int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   BlockDriverState *base,
+                                  bool include_base,
                                   bool want_zero,
                                   int64_t offset,
                                   int64_t bytes,
@@ -2354,10 +2355,11 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     BlockDriverState *p;
     int64_t eof = 0;
 
-    assert(bs != base);
+    assert(include_base || bs != base);
+    assert(!include_base || base); /* Can't include NULL base */
 
     ret = bdrv_co_block_status(bs, want_zero, offset, bytes, pnum, map, file);
-    if (ret < 0 || *pnum == 0 || ret & BDRV_BLOCK_ALLOCATED) {
+    if (ret < 0 || *pnum == 0 || ret & BDRV_BLOCK_ALLOCATED || bs == base) {
         return ret;
     }
 
@@ -2368,7 +2370,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     assert(*pnum <= bytes);
     bytes = *pnum;
 
-    for (p = bdrv_filter_or_cow_bs(bs); p != base;
+    for (p = bdrv_filter_or_cow_bs(bs); include_base || p != base;
          p = bdrv_filter_or_cow_bs(p))
     {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
@@ -2406,6 +2408,11 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
             break;
         }
 
+        if (p == base) {
+            assert(include_base);
+            break;
+        }
+
         /*
          * OK, [offset, offset + *pnum) region is unallocated on this layer,
          * let's continue the diving.
@@ -2425,7 +2432,7 @@ int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
                             int64_t offset, int64_t bytes, int64_t *pnum,
                             int64_t *map, BlockDriverState **file)
 {
-    return bdrv_common_block_status_above(bs, base, true, offset, bytes,
+    return bdrv_common_block_status_above(bs, base, false, true, offset, bytes,
                                           pnum, map, file);
 }
 
@@ -2442,9 +2449,9 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
     int ret;
     int64_t dummy;
 
-    ret = bdrv_common_block_status_above(bs, bdrv_filter_or_cow_bs(bs), false,
-                                         offset, bytes, pnum ? pnum : &dummy,
-                                         NULL, NULL);
+    ret = bdrv_common_block_status_above(bs, bs, true, false, offset,
+                                         bytes, pnum ? pnum : &dummy, NULL,
+                                         NULL);
     if (ret < 0) {
         return ret;
     }
-- 
2.21.3


