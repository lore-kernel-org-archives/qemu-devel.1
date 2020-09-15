Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE27C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E1320829
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l49PZVE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E1320829
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIE6F-00028l-P4
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIE4I-0000Cc-Up; Tue, 15 Sep 2020 12:44:34 -0400
Received: from mail-eopbgr70092.outbound.protection.outlook.com
 ([40.107.7.92]:52206 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIE4G-0007gp-Rx; Tue, 15 Sep 2020 12:44:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3Y+U+RslvonHKxPWrc5gMlaNdAr51pf8/cMvVjPVgdSCKmDWB3vI+H0mRoCbc26c84epiIRdqeySB7JY6VM+9nKDa3Tgy99uYb/yZP+/bW5yfQ3ijW7R2woCoi/VMPr9KN6h4QwyfCIeFoUQHe5bLUXdlGc69nd9j8SYc2DamGbzticRzlBHX5dj7SFgRdCCKk0xo/y+ikAOpaNwLnY6aK1j7ZkKoLv4QQ+2qETJzdhXg12lRU3vBjvCFiKRUrviphZFvdVKktTVImzO93U7bLrXt1U/3DvvoH4uURBHOtB2FDHvIO/Pj8AXQQJ9U0Jjy1VpLxBbBkTaEiCDBE6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTWy7sTjuGz74Kif+Hn35/zOvFhq4MPHkYxT2852UhQ=;
 b=RPvtXqqdPY7phiXW6QQoZxj3EAiBscD7YeGTkN8LaVE5Xn9QEgSS7pG4OxQpsk1m6OPXB+A/B+rJjyZBKWgCKm5HG9gE2M8O+6+BzJ2DFFbT7bRqy0HmLTmy4BI9KyD9EzcyAJz1P2TbEdZP+taov1jijfP4W5dxFM004Tng6/WNZAgD1ois4YhWGdsvNITNMXwIGltB+7Yg3se99hJ5GxXBKkUHrMXUnWii90GFBuPBm82xpLgmOO6bnylt0bEfiaOV5AnasnArYEkaAgYVqHyDQak1HdyniEykD8RsTe/g9u4U+OLFYuUcq1KgTP5MCan48o1R9IUd7g6KHMMdhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTWy7sTjuGz74Kif+Hn35/zOvFhq4MPHkYxT2852UhQ=;
 b=l49PZVE/hMugfaZA24BwG0nzNM90hzS3+iuQ8yTKo1PezG7K8F6ueWeK91+8mfRIfgUHX8pDixI29Jnea1wTLuDCCJADivao5z00r/MA1Rx8nvHIa2esezJJT2c4RjM8mnkhcIgGcMOIG6wqLY8yDCy+ckgQZ2ve+KyLQAgUGbo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 16:44:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 16:44:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com
Subject: [PATCH v8 1/7] block: return error-code from bdrv_invalidate_cache
Date: Tue, 15 Sep 2020 19:44:05 +0300
Message-Id: <20200915164411.20590-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200915164411.20590-1-vsementsov@virtuozzo.com>
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM0PR07CA0025.eurprd07.prod.outlook.com (2603:10a6:208:ac::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Tue, 15 Sep 2020 16:44:23 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60365c0e-2964-4c94-573b-08d859969a12
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB16520582A9001F48CC099FACC1200@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RH74FFdGqI87n1evAShi273OpPS6GZ9MCBHsthKPcChWFAXNXclSlB5knfT9X9QZzJiioRZLlY+81dTDwh4kZjLpgxkh/mDbKUOtAKtdrL8IcI/XhboccEsNsqCAkUadhtPAAsnwFr5jdrIosSD67IyxOEJ+iwOimwRy3AxkQtQ7mipUlFgbVdDTQMRPFjnYK9I2oroZTfj5ad64VdyyaC30z/jImaIgxbij8QM4vmy6aInE9GplZxvvNyN2vcNhwjG8dPvRYRBAzBm58AgEohAuBTcIbfLlANpa6zYmSYWXvRUXD0XsMmQHcEHjiXDA1ICmrLZdd6HLtoPGXStguNKGaBklMqN0ZgGXhREf0wZnq9refxNJmRqdma/ZYr6S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39840400004)(6916009)(6512007)(2906002)(83380400001)(36756003)(478600001)(1076003)(6486002)(86362001)(2616005)(956004)(8676002)(316002)(186003)(16526019)(5660300002)(66946007)(6666004)(52116002)(66476007)(8936002)(26005)(66556008)(6506007)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dpTSTwGwtd3ywRfmnFDdZiML0z39Y9jUaRSv7+tCVVP5f7fEqlsofSismwn2gGgkpd1At84YkpkVY3nWgVA3Pc7lJ3K+3jPLNRDjyd79vTf9nygMOhBkkNAy3C5SIa4xp2+sbBRPlY4zWyWk3XZMrmHqsY8wZOZhRQwoeo53xH9X6k2INavhWzy2aM7dr0RXTR1p/th62qtZPjRaxHzcpX5L2w4APVKp93BXe+wypfRz9+8LO3XzVNetKulgBu3eagtGbc5O7py2Vry5qxg2muZWbMi8IkvuqMAH8BzyLeV7NzDd6+mE851SRt+JP9k1lPgTkhjJ0GME2hhTaXtg0+8X85EjSeiByl5PeukBf6xvWG3I14JIfmvzHqgk+OktFaNmejSZQu6LxqpmGWHsMNjpJzbTKnnt04FIHgg6lngwe37foYWw+uY76on7TV+z0vXGGF8ZXBDS1ZbNzQT5D2rN6uA85izbbcqYKeOnGqu+KtZIUKp+xrqjCLomGgnqFMdNH2nJs5VdWish2a5YQkJ5WrnymhugJ+6r+nThJDrgO0i6RgzpGWsvbHCRXMMe2aMMSbx34IDZhcnUtueKnFagOgtIQpSlElrnODyPKaiwRRPTboNxzHxoyoWRnxbXjwYml+l4CKXFT81ULppIyA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60365c0e-2964-4c94-573b-08d859969a12
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 16:44:24.1050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/a9T/qs61pD7xx0R4IbxxVgDD30V2vfz/DR9ozk3ZOpust3GJccwS6QVoFnThgAiISLoq3tSzQL9CYT2lBF7RK5JEBzcjlG1I8x61PnVCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.7.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 12:44:24
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
index 6e36154061..8aef849a75 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -460,7 +460,7 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb);
 int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf);
 
 /* Invalidate any cached metadata used by image formats */
-void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
+int bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
 void bdrv_invalidate_cache_all(Error **errp);
 int bdrv_inactivate_all(void);
 
diff --git a/block.c b/block.c
index 2ba76b2c36..ccfe1d851b 100644
--- a/block.c
+++ b/block.c
@@ -5649,8 +5649,8 @@ void bdrv_init_with_whitelist(void)
     bdrv_init();
 }
 
-static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
-                                                  Error **errp)
+static int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
+                                                 Error **errp)
 {
     BdrvChild *child, *parent;
     uint64_t perm, shared_perm;
@@ -5659,14 +5659,14 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
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
 
@@ -5689,7 +5689,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
         ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, errp);
         if (ret < 0) {
             bs->open_flags |= BDRV_O_INACTIVE;
-            return;
+            return ret;
         }
         bdrv_set_perm(bs, perm, shared_perm);
 
@@ -5698,7 +5698,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
             if (local_err) {
                 bs->open_flags |= BDRV_O_INACTIVE;
                 error_propagate(errp, local_err);
-                return;
+                return -EINVAL;
             }
         }
 
@@ -5710,7 +5710,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
         if (ret < 0) {
             bs->open_flags |= BDRV_O_INACTIVE;
             error_setg_errno(errp, -ret, "Could not refresh total sector count");
-            return;
+            return ret;
         }
     }
 
@@ -5720,27 +5720,30 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
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
@@ -5757,22 +5760,23 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
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
2.21.3


