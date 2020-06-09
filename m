Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85D7C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DCC206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JlKqTSz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DCC206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jif2M-0000EN-IQ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0l-0006in-3v; Tue, 09 Jun 2020 10:13:55 -0400
Received: from mail-am6eur05on2133.outbound.protection.outlook.com
 ([40.107.22.133]:27969 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0j-0007gx-PJ; Tue, 09 Jun 2020 10:13:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ud35Ws4E0XRb1EQga3L5lMyXaUvosNMkOwxk2CeJki3OsQ6A6XRZ3djZmyv9b1UiwOvFKGten+jDkBHS+AkNNBYGT6BmaZwb9kgErE2pS3+LPK7EXb3NlH7Kd44Ae64+w1S+tORc1PbzXEJGED9P3R7WBSdj1BZW5eXZNOgR64NGFglTGehUbuLwE1W2pJDREv5OfXdP7y3+gGnNtuu+Y2Si6ecLT5ulvmYYvOn10hNkOB3piLqfjTwyX4QtISVeUtknk+oI7fRllrsKZNmoxIxy+2nB0aG7+sKNr33NYHUWzzg0yNkp0NS1d2jgZODFUTzqQJeazTwu1DxlFUJtFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+eJbX2MZPPDkO/kDijUBqa41+ytN7yNNrsdw0gTcnY=;
 b=m+31HcMbYnSazg1E8X5Ir0TWRh4oV+yMGrIl04EXjGw2CS5KKVhFcFKg9A/O8C+nPwSAF27CxJwlPLiaSXi+ObC2jIrLUkPONpGCofgp2elxXOGW6fYOiFMSEIlxSlehXoDFeb4hhKg7dXZN4iuxoH+bsMA/hEteiMmZAsJMyaX+/+RSj9vypLXLp3ti/A1ldXezfCNpztCePAeQqmHZvxy5HRzh6xKPD7UxksyvBidbsDRTJf+YM1bwI4UanfGEnrARUq4n+fsqq7cyPpdhCBeiSRYSpwg55Mp6bF5ZfoxO+tSGwFKDjF5BAXfrPULUWB71gv+2/Wjp2sSJ/++Avw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+eJbX2MZPPDkO/kDijUBqa41+ytN7yNNrsdw0gTcnY=;
 b=JlKqTSz3qXudxZCACObVjwfiED/3csVe5RDky+Lppap4R4zsCu+Jwjfk2ZuO2a2HDISwzVbgBU0JGTlRgngqnASC91x3p97ZMPw7m1qb+c5v3JddtLcVJA6n+ZgHlWDDqSlwvCjAct8idRlrtaOWk4upIEoKFJFnVY1fEt06b0s=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 14:13:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 14:13:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 1/7] block: return error-code from bdrv_invalidate_cache
Date: Tue,  9 Jun 2020 17:13:23 +0300
Message-Id: <20200609141329.3945-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200609141329.3945-1-vsementsov@virtuozzo.com>
References: <20200609141329.3945-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.180) by
 FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.20 via Frontend Transport; Tue, 9 Jun 2020 14:13:47 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.180]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c334a75-7d6f-437b-a98f-08d80c7f53b0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB549406A5C4290E4BCA58FD5DC1820@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Btr7mcGfXPulhkL7L0Hg95xA69UcLkGAMs1E67uWBsk69NZLc0rZ9bYFg3w7coiG7E0J3GkWeog3JTSYKCi8vSsNosMLe7zx4ym8n34Az1inOYDN4eHUs42KyWbrEZajSz8hG6XPqvblG2pk3h8Kucw/uiuN9c0/o4xvoiCFVqOpt1Md300Yqz8bLfZ236dHmLBIuy/J+w0ZQmOCo6pWRUz70wlYkPI5mLR/12FJwCV9tMjA0O7vthe+1ahF7lQTbSNd8tsixBg2jRELwMwSOgjSi7VIaEKCvS14Ba+KtF6E+bjOgrcnsWZDwSUKNKcvyBAauJ02BFmVJ8N1SSZwLH7M5txW+Q6ipttwKOgInpbueN+hFmxgvDZMGsOTzx83
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39850400004)(346002)(2906002)(6512007)(8676002)(83380400001)(6506007)(16526019)(186003)(26005)(6486002)(478600001)(36756003)(69590400007)(6666004)(8936002)(52116002)(6916009)(66476007)(66946007)(5660300002)(66556008)(1076003)(86362001)(4326008)(2616005)(316002)(107886003)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: PxLfiMKOw93kf1ZZpSJ11j6I7di+cxF3JKCPfsf029wt/yr4WTQJRKsF+7JlT3nb4lcJLbCqZwljT/iEieAihz8kEsg/GwJEl/RaEHFOiUNkoQfswRrO9Bs0nxDiX8VwmgIMDTd/y0C43kMP0fEVg/qQdD3kmBO36bNE/o4m81d9phDUpIB8QH/II1BQml3WazRCLlZ+79dA5q4niAI+gnG9yWT0RX94HG5frkhv8XUWwaxEpJbkOnzBvq2DG1rBYtdBSgl+0bdxMEzV9UBuRkDD8F0lsu7sbpffoFUl3gymDl75Yd7WwqyFB+6cojLcIvjldke6Nbf7OTg5PUKmsgRtRKHQwMqj5oSECMSDgDeBp9wrKlXiZQFBLqhHGWa/1RrC5z0K074I2vmPYFhGmHkWKGAcykSIch9pV3gEScX684ebciDEZC/44AETizFB4FMcMXqYftNgVEJy3GnQxzjqPUpHGKtjxJbOTbJ4rlOTSeXuY3btb3PJ6+tNKWu8
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c334a75-7d6f-437b-a98f-08d80c7f53b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 14:13:47.9104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpEaFPfGraMQPKL3rJIHZ1GgcA7WClYQxmMuYc5GnP49wbU32vsu9OfvLjDt96GIx1sHOo6pJj6B9Ngk6ZdVsohw4RsaoGoFQ9Bkxlp0LMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
Received-SPF: pass client-ip=40.107.22.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 10:13:47
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the only coroutine wrapper from block.c and block/io.c which
doesn't return a value, so let's convert it to the common behavior, to
simplify moving to generated coroutine wrappers in a further commit.

Also, bdrv_invalidate_cache is a void function, returning error only
through **errp parameter, which is considered to be bad practice, as
it forces callers to define and propagate local_err variable, so
conversion is good anyway.

This patch leaves the conversion of .bdrv_co_invalidate_cache() driver
callbacks and bdrv_invalidate_cache_all() for another day.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/block.h |  2 +-
 block.c               | 32 ++++++++++++++++++--------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 25e299605e..46965a7780 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -464,7 +464,7 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb);
 int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf);
 
 /* Invalidate any cached metadata used by image formats */
-void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
+int bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
 void bdrv_invalidate_cache_all(Error **errp);
 int bdrv_inactivate_all(void);
 
diff --git a/block.c b/block.c
index 8416376c9b..b01551f21c 100644
--- a/block.c
+++ b/block.c
@@ -5643,8 +5643,8 @@ void bdrv_init_with_whitelist(void)
     bdrv_init();
 }
 
-static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
-                                                  Error **errp)
+static int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
+                                                 Error **errp)
 {
     BdrvChild *child, *parent;
     uint64_t perm, shared_perm;
@@ -5653,14 +5653,14 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
     BdrvDirtyBitmap *bm;
 
     if (!bs->drv)  {
-        return;
+        return -ENOMEDIUM;
     }
 
     QLIST_FOREACH(child, &bs->children, next) {
         bdrv_co_invalidate_cache(child->bs, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            return;
+            return -EINVAL;
         }
     }
 
@@ -5684,7 +5684,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
         if (ret < 0) {
             bs->open_flags |= BDRV_O_INACTIVE;
             error_propagate(errp, local_err);
-            return;
+            return ret;
         }
         bdrv_set_perm(bs, perm, shared_perm);
 
@@ -5693,7 +5693,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
             if (local_err) {
                 bs->open_flags |= BDRV_O_INACTIVE;
                 error_propagate(errp, local_err);
-                return;
+                return -EINVAL;
             }
         }
 
@@ -5705,7 +5705,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
         if (ret < 0) {
             bs->open_flags |= BDRV_O_INACTIVE;
             error_setg_errno(errp, -ret, "Could not refresh total sector count");
-            return;
+            return ret;
         }
     }
 
@@ -5715,27 +5715,30 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
             if (local_err) {
                 bs->open_flags |= BDRV_O_INACTIVE;
                 error_propagate(errp, local_err);
-                return;
+                return -EINVAL;
             }
         }
     }
+
+    return 0;
 }
 
 typedef struct InvalidateCacheCo {
     BlockDriverState *bs;
     Error **errp;
     bool done;
+    int ret;
 } InvalidateCacheCo;
 
 static void coroutine_fn bdrv_invalidate_cache_co_entry(void *opaque)
 {
     InvalidateCacheCo *ico = opaque;
-    bdrv_co_invalidate_cache(ico->bs, ico->errp);
+    ico->ret = bdrv_co_invalidate_cache(ico->bs, ico->errp);
     ico->done = true;
     aio_wait_kick();
 }
 
-void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
+int bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
 {
     Coroutine *co;
     InvalidateCacheCo ico = {
@@ -5752,22 +5755,23 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
         bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !ico.done);
     }
+
+    return ico.ret;
 }
 
 void bdrv_invalidate_cache_all(Error **errp)
 {
     BlockDriverState *bs;
-    Error *local_err = NULL;
     BdrvNextIterator it;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
+        int ret;
 
         aio_context_acquire(aio_context);
-        bdrv_invalidate_cache(bs, &local_err);
+        ret = bdrv_invalidate_cache(bs, errp);
         aio_context_release(aio_context);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (ret < 0) {
             bdrv_next_cleanup(&it);
             return;
         }
-- 
2.21.0


