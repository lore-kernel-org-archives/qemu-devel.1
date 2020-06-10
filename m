Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE88C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067152072F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ouRE3F1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067152072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jixdj-0003nn-7f
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 06:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixaW-00080g-QY; Wed, 10 Jun 2020 06:04:04 -0400
Received: from mail-eopbgr130098.outbound.protection.outlook.com
 ([40.107.13.98]:48772 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixaV-0005xX-RU; Wed, 10 Jun 2020 06:04:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJaP6aZJyKx005C6psIqrKGGHNWs2HwNNRHK3P6qDbRyzlPBh1/Ww+PTYzEF1Psiph6SeDT2qEeq+4WctU56jPicsrWNtHUnGQQjEX0mSZShw8P0IRarp+cyN5ZGxii+vrnEJGXx/lr/qggJcNUtRemPiLfVU0nMOyndOg3RrJPdGpV4ijaO0+T1G5AbuhNqhvBH8jpWiGCVE+WQSSiCypIdV6MrkJOoAY1hsdcCJt9+W+lfxGZyRshw7tiYrfOeIUYuTfoiEr8VNivmwtSR9FkmdZ3h4VOYsons86EOKzGrFWK839FU/wcZgAurwoIOLJIMI4Nzk+cWACFWcmOJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+eJbX2MZPPDkO/kDijUBqa41+ytN7yNNrsdw0gTcnY=;
 b=XBfMW/VspepZ/iI11u7wxEOjl53RGN9m/MItVe0OLe3FUpI/+mTK87qaFnnPMDcusEqbc8QUPIqTzuBZjOTPbJCrNoDwvuzqzr9xgFeEICD/taBL2lVtv40F6qq9eyHvLy/ocRXPQkNwoGRumumXSk72hKarUb+Odw4PTkF/nKRfi8sYXBCA/RhhMkW0TC8srYs89bA3dHgzVyoNz8iDSvU+LlfrKOwhopVHJr25ijwZ4NOvXYMfDMgn/fV8N5JT84WEWdb/+m9DW2Iw9aDosJUCTKBb2JtZV3P6YHfLa2SDTWTtDpFeL6H1UHAU03ENB3FZq2ZReBtFIMDb5HwdyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+eJbX2MZPPDkO/kDijUBqa41+ytN7yNNrsdw0gTcnY=;
 b=ouRE3F1OMt99SMM4aUcwbfVCA4Ym3+UWOjl2p+U9+c1sx8p+ehroLkvxFwK40gp9UXzHZ3gQY82oixz8LRUvDwMJGX1vzwl0w62nPsUPpgXo5DnrwDxeV+NsCNA32ii4JSz6iEmFARB67TTUMX2qQP3w9rI9JlkUQFdQq+kOJTs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5525.eurprd08.prod.outlook.com (2603:10a6:20b:107::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 10:03:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 10:03:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 1/7] block: return error-code from bdrv_invalidate_cache
Date: Wed, 10 Jun 2020 13:03:30 +0300
Message-Id: <20200610100336.23451-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610100336.23451-1-vsementsov@virtuozzo.com>
References: <20200610100336.23451-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:208:14::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.166) by
 AM0PR03CA0005.eurprd03.prod.outlook.com (2603:10a6:208:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Wed, 10 Jun 2020 10:03:56 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e3c8110-165c-4922-d9d3-08d80d2596d4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB55258A41CC5BDD529EF06D5CC1830@AM7PR08MB5525.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzv17o1Sxp+JE9BCn4OHEaSCWRTjIPp2N8AKPicmbCvc26CKnTDmuJuco110xJQ+XejPSblDqUAGCiLSTKePIsvZtPtyXpnUPsqTJP7uJZLO9ddN+Y5tJ64HYa+q0s/sbRmnI3wU8679kExsyqi38TgKivhDjoCpq2m/sD0q3u3AIKwLQ0zu2d8Hvd4Hm8FZpml5GW3CXnOx+LVwQalnmSrZjvWKXaknfL6u/RZUtIDDCDQ+e46RxQC6nw1Ba7NzlxhSxpDaJFIcUOHGzz28ewzcv+cEnMLNQ+qA/O+e1iXmB/mw+41p3FOF1ISlfWeA3dZYM4/OHSVo8KNFdGl57wFk+y5DJXc7gICqzfZC+K14bCIqjHnHcD4GKCnWH0nA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(346002)(136003)(366004)(376002)(396003)(478600001)(83380400001)(66556008)(66476007)(956004)(6666004)(316002)(5660300002)(6512007)(2616005)(36756003)(8936002)(107886003)(69590400007)(6916009)(6486002)(26005)(4326008)(66946007)(186003)(8676002)(6506007)(52116002)(1076003)(2906002)(86362001)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bDAxhkrZVKuRrz5RTednQfQPZgAoXIs1auZxu/8a7bODkW+OlOL9ZyexIicZ1SPriRpopF17lfr5dRtjs3xZx14hv9lW7+kmEKfnAfUbC0ss41gvCz4vc5z9nuKY5FLKgIOm8eoJ/hel7a2jqARtoIG+paQPe81e7fD4WYNR+0Z8CdlCoJXYl/h4zFhEPBY4G4SsIJsWtxxTmiaB9/EFS34CIWB0NpfAsbdzWiCd3cfYO5XR1nZcbKh5gzi+8xRSDqeBVK3gQam8I2sFgPst065XNK5WFYdquu30LbOpzJjKO/t4WzAEn69w27DLRaR6Q8Cx4/4q17wlo9d3ASEVvNNpfeMDocl3n7HfxjJtiYN/hRtiORk3Rbfb9svGWi/dFgMWq8b1huIW7cK+oKGJCaNKv/QbD7AXF7/qFgiXJZWrw0SlhSyCEt6FJAHgasSn3K8MPb0Hkkd3KtvClzLFBrgvuxSUvEKqSJ1RUqBsEEK9l8zGPrrcu+yPKMEZ+lk7
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3c8110-165c-4922-d9d3-08d80d2596d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 10:03:56.9991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wc37sLmV5yfVxmn+FLHMWHbkS9teN0CHdbE2ysp4gBarYLUhhQj0495Ujtn7xI53v7IxhNeM7IY2KOICIP5c4sVsCXqJcMQAyp55+pg+M0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5525
Received-SPF: pass client-ip=40.107.13.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 06:04:01
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


