Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB88C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154BF207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JnLgTb1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154BF207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je2pX-0006MY-8m
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 16:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1je2oL-0004db-1D; Wed, 27 May 2020 16:38:01 -0400
Received: from mail-am6eur05on2112.outbound.protection.outlook.com
 ([40.107.22.112]:57342 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1je2oJ-0007uz-PN; Wed, 27 May 2020 16:38:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKNR0FOieIaLnQlWNH7MKxjkNX8OufzIbQhhU5zBqS5G0RbVPMJGKZ4ggwFwKGwly4jCbt7v35WvvDUOu2FMkGfIOSXUJmObTE7vCJEO2eaav03PMm6favoHiX0APauGXVkebKCv5nZBiV1vVo2E2RgVTPqDV9bktnxTm09ItGIKw8cTdDFXstuEklS1calP0cBv7SSCegeJXXR5htEaMUNVu83SBosGyAgRTDmQY1gsJZsblTHHd+Rw7VhtOxXu/3/z7yQnu+c8wyI63s2ahmefHuuexwacmhcG63y0fKEj6OrEaSik/jAy2V7x8xYiLI0U+XQ2Mv23ebwXweZ1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l1/Je0oKX1polil/IrnQHIDLaYdK+cWDoKIy1pfxsE=;
 b=UTLVh5/g56xTg0NeJi95Zne8MtRE7Aw2bKWzP+BpsVcZsYX0wo8VfG4pYnE/T0uImT8mQOqRq6CClrEfUm6UhXk8AA6bvHG6+EBGDapwVHOt5PPL7mXDglYbrm3dM1YXHhlTfgrSlAYbWZMY89SCm1SciB8vHi++CUFUKxAdesWg7WwKTgPbh7tps98VAzoUD7GewzbwDhchwIMGvcMyVXUfwRI3AJc/jTDFmXShNHP5fOqpNX4qR6oovK+2RiCgXQd5mL8A0gEww6rdhx8q37fFdFhXHNl2iB7BPMM/9rG1PKJ0alYnKtizVjiFS40jwug0ATjX8LBkTDsXr1Lx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l1/Je0oKX1polil/IrnQHIDLaYdK+cWDoKIy1pfxsE=;
 b=JnLgTb1Xrh3soK3Sf2VfGjdO5pJwUwvxU8L+e0icNkioUgxOfO2qVSwqJomC8nb4TqnTi/5i0KmrSdgnNiQRRalF1AJXyIjjq/mVEN4UntgiybCNQh0n93h68V/OZMmbu+kYMaos2GA0cBgf1KdbeoGbVAJNwCKX6bDZQgziVbk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 27 May
 2020 20:37:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 20:37:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 5/7] block: generate coroutine-wrapper code
Date: Wed, 27 May 2020 23:37:31 +0300
Message-Id: <20200527203733.16129-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200527203733.16129-1-vsementsov@virtuozzo.com>
References: <20200527203733.16129-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.148) by
 AM0PR10CA0101.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 20:37:52 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d4f6c2c-2184-4ae1-9ec8-08d8027dd4a6
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53362E8B6BB5B2FDBE54C7EAC1B10@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXg2MmWdYmG2Woy1Llxbof2sOUGDbCnqntinulPbw3Jzfg/lPlD0FZ/6JNgrj5qe04cl/zD5/NOL+fE+CzYebutD7w2Hf8sXyLqW2W6rP7v0oQyyAKKdZg5V/wC0nN0qUVndlePiJlaETo7NC5/1ftaTnUm+4XX7wIaw/BU4X6L5SIgSdHijphesV7B2VFbYGuunrq1tGKp9u9wc3srZksWGBLKSgqZp2+rorVKLNr5hRtKwzT3faMAPBw7q4WbmbZ97JSYn7sIreB9urFsr4ajem811BYu1QXa1fR/Ake8fqLoKM67dpKoyj//kxBNFiqJYlTTuL1RJfr8qpvc6ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(956004)(66556008)(66946007)(66476007)(8676002)(6486002)(6512007)(1076003)(478600001)(186003)(316002)(5660300002)(6916009)(30864003)(2616005)(6506007)(8936002)(16526019)(26005)(2906002)(6666004)(83380400001)(36756003)(4326008)(52116002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: J/MyL6EAasNtoMi3DuxhQqp/s0JcPpTfknrTBzc0B98BOVLLlGzTRqQ5KBvvrVol6UWdJWVz+YgW5YL3uCQga9NeFHAlP7qupSa3fWpbs+jZTHVYNOHTdG9jpxgc2CQ8NX5Dm8/yyzbuY8kuyQMkdgwyN5NySFk13wrM8mTEpWTt/H7d5OxKlBhb1Q/YHJQiOp53u2MPgf3fgCXmmtRksMPf+dl6P56urYstDJkloTOwlIlcu+m/45GDlZqwHopabpARCxtmDnHBlCAMGL8tVPTco+vRxBP3Bc/8QYBHfHm3Tk3Hj86AIvk6zZ/DzZ6vU8A4kogE108W29XgKfMwXplSm1m8OoBNvre8P70/r/t6On+DkqHMLxgELqTXvzCFPw5hbGiaJt13nobsgk93fcDrX+b/ng1uWl01dxGIGJg/8/vtZmR/ZP3Hbod1x5dXkLZvzGiAtQf50SzaQsIcsvKg17o4K/jnE9OIBS6+ZNU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4f6c2c-2184-4ae1-9ec8-08d8027dd4a6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 20:37:53.6957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFqKoZYT+4E8D6NZnWdbixWqXI9aDhxBiN9SpJRGAOaIyqMSwUxln1PAYlZJqREn2ctrzOjro9FVTQJdaA9iedDCobM1P3x4Uc1g6lI0+dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
Received-SPF: pass client-ip=40.107.22.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 16:37:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
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
 ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use code generation implemented in previous commit to generated
coroutine wrappers in block.c and block/io.c

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/coroutines.h    |   7 +-
 include/block/block.h |  17 ++-
 block.c               |  73 ------------
 block/io.c            | 260 ------------------------------------------
 4 files changed, 15 insertions(+), 342 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index 9ce1730a09..145a2d2645 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -26,6 +26,7 @@
 #define BLOCK_COROUTINES_INT_H
 
 #include "block/block_int.h"
+#include "block/generated-co-wrapper.h"
 
 int coroutine_fn bdrv_co_check(BlockDriverState *bs,
                                BdrvCheckResult *res, BdrvCheckMode fix);
@@ -34,7 +35,7 @@ int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp);
 int coroutine_fn
 bdrv_co_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
              bool is_write, BdrvRequestFlags flags);
-int
+int generated_co_wrapper
 bdrv_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
           bool is_write, BdrvRequestFlags flags);
 
@@ -47,7 +48,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   int64_t *pnum,
                                   int64_t *map,
                                   BlockDriverState **file);
-int
+int generated_co_wrapper
 bdrv_common_block_status_above(BlockDriverState *bs,
                                BlockDriverState *base,
                                bool want_zero,
@@ -60,7 +61,7 @@ bdrv_common_block_status_above(BlockDriverState *bs,
 int coroutine_fn
 bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read);
-int
+int generated_co_wrapper
 bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                 bool is_read);
 
diff --git a/include/block/block.h b/include/block/block.h
index 46965a7780..46c8b7816e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -9,6 +9,7 @@
 #include "block/dirty-bitmap.h"
 #include "block/blockjob.h"
 #include "qemu/hbitmap.h"
+#include "block/generated-co-wrapper.h"
 
 /* block.c */
 typedef struct BlockDriver BlockDriver;
@@ -398,8 +399,9 @@ void bdrv_refresh_filename(BlockDriverState *bs);
 int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
                                   PreallocMode prealloc, BdrvRequestFlags flags,
                                   Error **errp);
-int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
-                  PreallocMode prealloc, BdrvRequestFlags flags, Error **errp);
+int generated_co_wrapper
+bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
+              PreallocMode prealloc, BdrvRequestFlags flags, Error **errp);
 
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
@@ -441,7 +443,8 @@ typedef enum {
     BDRV_FIX_ERRORS   = 2,
 } BdrvCheckMode;
 
-int bdrv_check(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix);
+int generated_co_wrapper bdrv_check(BlockDriverState *bs, BdrvCheckResult *res,
+                                    BdrvCheckMode fix);
 
 /* The units of offset and total_work_size may be chosen arbitrarily by the
  * block driver; total_work_size may change during the course of the amendment
@@ -464,12 +467,13 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb);
 int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf);
 
 /* Invalidate any cached metadata used by image formats */
-int bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
+int generated_co_wrapper bdrv_invalidate_cache(BlockDriverState *bs,
+                                               Error **errp);
 void bdrv_invalidate_cache_all(Error **errp);
 int bdrv_inactivate_all(void);
 
 /* Ensure contents are flushed to disk.  */
-int bdrv_flush(BlockDriverState *bs);
+int generated_co_wrapper bdrv_flush(BlockDriverState *bs);
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs);
 int bdrv_flush_all(void);
 void bdrv_close_all(void);
@@ -484,7 +488,8 @@ void bdrv_drain_all(void);
     AIO_WAIT_WHILE(bdrv_get_aio_context(bs_),              \
                    cond); })
 
-int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
+int generated_co_wrapper bdrv_pdiscard(BdrvChild *child, int64_t offset,
+                                       int64_t bytes);
 int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
diff --git a/block.c b/block.c
index 2ca9267729..3046696f30 100644
--- a/block.c
+++ b/block.c
@@ -4640,43 +4640,6 @@ int coroutine_fn bdrv_co_check(BlockDriverState *bs,
     return bs->drv->bdrv_co_check(bs, res, fix);
 }
 
-typedef struct CheckCo {
-    BlockDriverState *bs;
-    BdrvCheckResult *res;
-    BdrvCheckMode fix;
-    int ret;
-} CheckCo;
-
-static void coroutine_fn bdrv_check_co_entry(void *opaque)
-{
-    CheckCo *cco = opaque;
-    cco->ret = bdrv_co_check(cco->bs, cco->res, cco->fix);
-    aio_wait_kick();
-}
-
-int bdrv_check(BlockDriverState *bs,
-               BdrvCheckResult *res, BdrvCheckMode fix)
-{
-    Coroutine *co;
-    CheckCo cco = {
-        .bs = bs,
-        .res = res,
-        .ret = -EINPROGRESS,
-        .fix = fix,
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_check_co_entry(&cco);
-    } else {
-        co = qemu_coroutine_create(bdrv_check_co_entry, &cco);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, cco.ret == -EINPROGRESS);
-    }
-
-    return cco.ret;
-}
-
 /*
  * Return values:
  * 0        - success
@@ -5723,42 +5686,6 @@ int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
     return 0;
 }
 
-typedef struct InvalidateCacheCo {
-    BlockDriverState *bs;
-    Error **errp;
-    bool done;
-    int ret;
-} InvalidateCacheCo;
-
-static void coroutine_fn bdrv_invalidate_cache_co_entry(void *opaque)
-{
-    InvalidateCacheCo *ico = opaque;
-    ico->ret = bdrv_co_invalidate_cache(ico->bs, ico->errp);
-    ico->done = true;
-    aio_wait_kick();
-}
-
-int bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
-{
-    Coroutine *co;
-    InvalidateCacheCo ico = {
-        .bs = bs,
-        .done = false,
-        .errp = errp
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_invalidate_cache_co_entry(&ico);
-    } else {
-        co = qemu_coroutine_create(bdrv_invalidate_cache_co_entry, &ico);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, !ico.done);
-    }
-
-    return ico.ret;
-}
-
 void bdrv_invalidate_cache_all(Error **errp)
 {
     BlockDriverState *bs;
diff --git a/block/io.c b/block/io.c
index f5b6ce3bf6..f9700cc897 100644
--- a/block/io.c
+++ b/block/io.c
@@ -892,15 +892,6 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
-typedef struct RwCo {
-    BdrvChild *child;
-    int64_t offset;
-    QEMUIOVector *qiov;
-    bool is_write;
-    int ret;
-    BdrvRequestFlags flags;
-} RwCo;
-
 int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
                               QEMUIOVector *qiov, bool is_write,
                               BdrvRequestFlags flags)
@@ -912,43 +903,6 @@ int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
     }
 }
 
-static void coroutine_fn bdrv_rw_co_entry(void *opaque)
-{
-    RwCo *rwco = opaque;
-
-    rwco->ret = bdrv_co_prwv(rwco->child, rwco->offset, rwco->qiov,
-                             rwco->is_write, rwco->flags);
-    aio_wait_kick();
-}
-
-/*
- * Process a vectored synchronous request using coroutines
- */
-int bdrv_prwv(BdrvChild *child, int64_t offset,
-              QEMUIOVector *qiov, bool is_write,
-              BdrvRequestFlags flags)
-{
-    Coroutine *co;
-    RwCo rwco = {
-        .child = child,
-        .offset = offset,
-        .qiov = qiov,
-        .is_write = is_write,
-        .ret = NOT_DONE,
-        .flags = flags,
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_rw_co_entry(&rwco);
-    } else {
-        co = qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
-        bdrv_coroutine_enter(child->bs, co);
-        BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
-    }
-    return rwco.ret;
-}
-
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags)
 {
@@ -2223,20 +2177,6 @@ int bdrv_flush_all(void)
     return result;
 }
 
-
-typedef struct BdrvCoBlockStatusData {
-    BlockDriverState *bs;
-    BlockDriverState *base;
-    bool want_zero;
-    int64_t offset;
-    int64_t bytes;
-    int64_t *pnum;
-    int64_t *map;
-    BlockDriverState **file;
-    int ret;
-    bool done;
-} BdrvCoBlockStatusData;
-
 int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
                                                 bool want_zero,
                                                 int64_t offset,
@@ -2488,56 +2428,6 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     return ret;
 }
 
-/* Coroutine wrapper for bdrv_block_status_above() */
-static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
-{
-    BdrvCoBlockStatusData *data = opaque;
-
-    data->ret = bdrv_co_common_block_status_above(data->bs, data->base,
-                                                  data->want_zero,
-                                                  data->offset, data->bytes,
-                                                  data->pnum, data->map,
-                                                  data->file);
-    data->done = true;
-    aio_wait_kick();
-}
-
-/*
- * Synchronous wrapper around bdrv_co_block_status_above().
- *
- * See bdrv_co_block_status_above() for details.
- */
-int bdrv_common_block_status_above(BlockDriverState *bs,
-                                   BlockDriverState *base,
-                                   bool want_zero, int64_t offset,
-                                   int64_t bytes, int64_t *pnum,
-                                   int64_t *map,
-                                   BlockDriverState **file)
-{
-    Coroutine *co;
-    BdrvCoBlockStatusData data = {
-        .bs = bs,
-        .base = base,
-        .want_zero = want_zero,
-        .offset = offset,
-        .bytes = bytes,
-        .pnum = pnum,
-        .map = map,
-        .file = file,
-        .done = false,
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_block_status_above_co_entry(&data);
-    } else {
-        co = qemu_coroutine_create(bdrv_block_status_above_co_entry, &data);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, !data.done);
-    }
-    return data.ret;
-}
-
 int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
                             int64_t offset, int64_t bytes, int64_t *pnum,
                             int64_t *map, BlockDriverState **file)
@@ -2631,14 +2521,6 @@ int bdrv_is_allocated_above(BlockDriverState *top,
     return 0;
 }
 
-typedef struct BdrvVmstateCo {
-    BlockDriverState    *bs;
-    QEMUIOVector        *qiov;
-    int64_t             pos;
-    bool                is_read;
-    int                 ret;
-} BdrvVmstateCo;
-
 int coroutine_fn
 bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read)
@@ -2664,34 +2546,6 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
     return ret;
 }
 
-static void coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
-{
-    BdrvVmstateCo *co = opaque;
-    co->ret = bdrv_co_rw_vmstate(co->bs, co->qiov, co->pos, co->is_read);
-    aio_wait_kick();
-}
-
-int bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
-                    bool is_read)
-{
-    if (qemu_in_coroutine()) {
-        return bdrv_co_rw_vmstate(bs, qiov, pos, is_read);
-    } else {
-        BdrvVmstateCo data = {
-            .bs         = bs,
-            .qiov       = qiov,
-            .pos        = pos,
-            .is_read    = is_read,
-            .ret        = -EINPROGRESS,
-        };
-        Coroutine *co = qemu_coroutine_create(bdrv_co_rw_vmstate_entry, &data);
-
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, data.ret == -EINPROGRESS);
-        return data.ret;
-    }
-}
-
 int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
                       int64_t pos, int size)
 {
@@ -2767,20 +2621,6 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb)
 /**************************************************************/
 /* Coroutine block device emulation */
 
-typedef struct FlushCo {
-    BlockDriverState *bs;
-    int ret;
-} FlushCo;
-
-
-static void coroutine_fn bdrv_flush_co_entry(void *opaque)
-{
-    FlushCo *rwco = opaque;
-
-    rwco->ret = bdrv_co_flush(rwco->bs);
-    aio_wait_kick();
-}
-
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 {
     int current_gen;
@@ -2893,40 +2733,6 @@ early_exit:
     return ret;
 }
 
-int bdrv_flush(BlockDriverState *bs)
-{
-    Coroutine *co;
-    FlushCo flush_co = {
-        .bs = bs,
-        .ret = NOT_DONE,
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_flush_co_entry(&flush_co);
-    } else {
-        co = qemu_coroutine_create(bdrv_flush_co_entry, &flush_co);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, flush_co.ret == NOT_DONE);
-    }
-
-    return flush_co.ret;
-}
-
-typedef struct DiscardCo {
-    BdrvChild *child;
-    int64_t offset;
-    int64_t bytes;
-    int ret;
-} DiscardCo;
-static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
-{
-    DiscardCo *rwco = opaque;
-
-    rwco->ret = bdrv_co_pdiscard(rwco->child, rwco->offset, rwco->bytes);
-    aio_wait_kick();
-}
-
 int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
                                   int64_t bytes)
 {
@@ -3041,28 +2847,6 @@ out:
     return ret;
 }
 
-int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
-{
-    Coroutine *co;
-    DiscardCo rwco = {
-        .child = child,
-        .offset = offset,
-        .bytes = bytes,
-        .ret = NOT_DONE,
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_pdiscard_co_entry(&rwco);
-    } else {
-        co = qemu_coroutine_create(bdrv_pdiscard_co_entry, &rwco);
-        bdrv_coroutine_enter(child->bs, co);
-        BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
-    }
-
-    return rwco.ret;
-}
-
 int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf)
 {
     BlockDriver *drv = bs->drv;
@@ -3460,47 +3244,3 @@ out:
 
     return ret;
 }
-
-typedef struct TruncateCo {
-    BdrvChild *child;
-    int64_t offset;
-    bool exact;
-    PreallocMode prealloc;
-    BdrvRequestFlags flags;
-    Error **errp;
-    int ret;
-} TruncateCo;
-
-static void coroutine_fn bdrv_truncate_co_entry(void *opaque)
-{
-    TruncateCo *tco = opaque;
-    tco->ret = bdrv_co_truncate(tco->child, tco->offset, tco->exact,
-                                tco->prealloc, tco->flags, tco->errp);
-    aio_wait_kick();
-}
-
-int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
-                  PreallocMode prealloc, BdrvRequestFlags flags, Error **errp)
-{
-    Coroutine *co;
-    TruncateCo tco = {
-        .child      = child,
-        .offset     = offset,
-        .exact      = exact,
-        .prealloc   = prealloc,
-        .flags      = flags,
-        .errp       = errp,
-        .ret        = NOT_DONE,
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_truncate_co_entry(&tco);
-    } else {
-        co = qemu_coroutine_create(bdrv_truncate_co_entry, &tco);
-        bdrv_coroutine_enter(child->bs, co);
-        BDRV_POLL_WHILE(child->bs, tco.ret == NOT_DONE);
-    }
-
-    return tco.ret;
-}
-- 
2.21.0


