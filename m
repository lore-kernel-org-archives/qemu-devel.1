Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD150C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64ACC2072F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GNziV8r9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64ACC2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jixc4-0001Jk-LB
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 06:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixaX-00083f-Pb; Wed, 10 Jun 2020 06:04:05 -0400
Received: from mail-am6eur05on2106.outbound.protection.outlook.com
 ([40.107.22.106]:48963 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixaV-0005xb-VZ; Wed, 10 Jun 2020 06:04:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W91eFXIxfzZEHifrG08JQFz61WFIe0NbH1h0JSVMJ/gThfSg/0CqhaiZYVBZXg4U3188TeZVLgDt7Ia/1ZUA4FPZ8MPVsAmtLnWFefteT1ueGpI3qXzpu2jruUYH5fC6PEl2sRpb/2Imcudhp5eJhVd2pcSea7gGDpu7wDYdjlV2PJrUNTcucXR7EB805lf1hpsTz2ncyLDIQF8mCpDkyub3GcJUhBVyLmPRNkugHj54aXEBEVfYjMp4zU1ttN1os5nVaVzMZ37Uk0S/7Tnjb/OCrhzKCpNYtmBy1ClHg5RTn2NgOzs7UyrAIi0R1eODFhZyjw89PsDebrQ/Z2QwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjPzmYBfiDPHfiBL16BBprs5d0lNibyUPzedg5Lw6to=;
 b=YVOsQl2Xr/QCzKmsWhLl7iVcyuzZQmo0/6bpq56Be2eSySMaj0ddRl0NL1/RVb8u5TlxUZoTDDpQVDrQJIiETAoLpfClwCKYEAWklUG3E/GQk4jqzz7f9oT18zLCruZJXg05lmefv40OIH28CtYh53S2wns55VEPdZr6jNi1+h9yTDIe2c9TgF6UTmWDApQmq7PYq+tn80Nzdh79xJ11b6F7/oyISaKUEbU5RLFwOwpLCANxCXfSlU+c6N+OvvrxnfhKYYd3Gqo1IuR+GnfuUAsN8lbYTwXp5cmOm97/jPA1vKvoaJTD7mfkjz7V2drCMMxj+fT1X/KmODRDXLw73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjPzmYBfiDPHfiBL16BBprs5d0lNibyUPzedg5Lw6to=;
 b=GNziV8r94nh2rAknDuF8Te3PkyCiuHXBgzqPp3PaObYhWlYCQb6ScRQ35u7cnUY+q3OlEHh6yoKFXl4ovMso1UWcCOyviQcH2gMOPqycMjE8TDO3MM/N4BjpHqCt6wcmx6/hiIK5rpDwT80m6rU5+9/VUMj9qH/hquB9rwuztOU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 10:04:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 10:04:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 5/7] block: generate coroutine-wrapper code
Date: Wed, 10 Jun 2020 13:03:34 +0300
Message-Id: <20200610100336.23451-6-vsementsov@virtuozzo.com>
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
 15.20.3088.19 via Frontend Transport; Wed, 10 Jun 2020 10:04:00 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86ebe264-6872-47ca-947f-08d80d259967
X-MS-TrafficTypeDiagnostic: AM7PR08MB5496:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5496ACE4AF22D116CB931D9AC1830@AM7PR08MB5496.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cueINTi2SduOv1lOSp8lhPllFYG4YTpQgegWm6uI684scvnt90NQc1gVSY4gWK/O5NYk3jpCXIEVDl+EBmpv1qB2LCLwhrxG2O/BkHR/u/9+vIK+HxkRaNr7rbnHTLsiKDzwNqL74IQkJv7L0u319R+0nWJOGoDi8p+APFeOVKAbjGmnnahMbjEDmbs9KgkMse53CfKT04py8rzxG6YjFJjvWyzm8Ny7qkagBLekgTZee2zrdB9L7xJmI3mtoFPcNtVn/ExiKlcBJRqjV9+fCQUftllOF+03RW6n+xLWDart8h8kp8dtp04rgo50tU/V2OeCg/1SQg++AMSbDUrrTbWNqUdjDEXkZ3+bIHZeZF6odDeMMKV8qawqoGR8gRG+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39850400004)(6486002)(316002)(8676002)(107886003)(8936002)(86362001)(52116002)(6916009)(478600001)(6512007)(6666004)(1076003)(4326008)(66556008)(83380400001)(5660300002)(30864003)(66946007)(66476007)(16526019)(36756003)(69590400007)(26005)(2906002)(956004)(6506007)(2616005)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: za0JsSijSxegS8+eKHYZ1056QInd8sazGg6ASS1C7+ND7hzlE5tNCJVNprd+EJlirfQN4e2/HHXpoUAZKSYPltWVIMj5zNAqY2+3euwM2qdII61HrqGeUOhaUT3tKn/wCCwaG1Td6VikrGiXSyeXVr8sRB5pvNj+kiAhlCI7z3EhK6txcjtV1nq9TKb5peEX/JoJsnLVmb7GqkjlNL1DAJwwPmaWIIiG0Oio4IJ3J9GsqqzWQVgMXuBNr2NdA9z9MSC4U0GrlID63o1NdR+sfc6yJn/z4u+7eD7sAHR3o2v35a/+QAjbkZ/Y343kv8sd1wPlcovFt50oe+6hYe4sVWnA5pGUeQPMsUsXjuFSrlzGZ7by9cKPvclSpczE1yLs5YeeWxnLmkkCI+Fn8H4Dkywku+zB3o7+b9VOrbIY1RM8NWe12nWWRAc2pWPtb2ZPZU14hRxN4PVCY6xy0cIt99LAmjzTw/r2ErFjGOp9OTM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ebe264-6872-47ca-947f-08d80d259967
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 10:04:01.3878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFU/tssRSbwliwLWZ8Z9WtSNr9TLeJX0RqeyJ/mHuAw/QtJJrBXMph2f6YlOCvYWOTQmm1E4u5aFbXwg7KUinAK9SsPpxEcs1jAlBUQwumw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496
Received-SPF: pass client-ip=40.107.22.106;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 06:04:02
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

Use code generation implemented in previous commit to generated
coroutine wrappers in block.c and block/io.c

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/coroutines.h    |   6 +-
 include/block/block.h |  16 ++--
 block.c               |  73 ---------------
 block/io.c            | 212 ------------------------------------------
 4 files changed, 13 insertions(+), 294 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index 9ce1730a09..c62b3a2697 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -34,7 +34,7 @@ int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp);
 int coroutine_fn
 bdrv_co_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
              bool is_write, BdrvRequestFlags flags);
-int
+int generated_co_wrapper
 bdrv_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
           bool is_write, BdrvRequestFlags flags);
 
@@ -47,7 +47,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   int64_t *pnum,
                                   int64_t *map,
                                   BlockDriverState **file);
-int
+int generated_co_wrapper
 bdrv_common_block_status_above(BlockDriverState *bs,
                                BlockDriverState *base,
                                bool want_zero,
@@ -60,7 +60,7 @@ bdrv_common_block_status_above(BlockDriverState *bs,
 int coroutine_fn
 bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read);
-int
+int generated_co_wrapper
 bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                 bool is_read);
 
diff --git a/include/block/block.h b/include/block/block.h
index 59a002e06f..9f94c59057 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -405,8 +405,9 @@ void bdrv_refresh_filename(BlockDriverState *bs);
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
@@ -448,7 +449,8 @@ typedef enum {
     BDRV_FIX_ERRORS   = 2,
 } BdrvCheckMode;
 
-int bdrv_check(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix);
+int generated_co_wrapper bdrv_check(BlockDriverState *bs, BdrvCheckResult *res,
+                                    BdrvCheckMode fix);
 
 /* The units of offset and total_work_size may be chosen arbitrarily by the
  * block driver; total_work_size may change during the course of the amendment
@@ -471,12 +473,13 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb);
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
@@ -491,7 +494,8 @@ void bdrv_drain_all(void);
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
index deb9ca8d82..36fbf9e1fa 100644
--- a/block/io.c
+++ b/block/io.c
@@ -890,50 +890,6 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
-typedef int coroutine_fn BdrvRequestEntry(void *opaque);
-typedef struct BdrvRunCo {
-    BdrvRequestEntry *entry;
-    void *opaque;
-    int ret;
-    bool done;
-    Coroutine *co; /* Coroutine, running bdrv_run_co_entry, for debugging */
-} BdrvRunCo;
-
-static void coroutine_fn bdrv_run_co_entry(void *opaque)
-{
-    BdrvRunCo *arg = opaque;
-
-    arg->ret = arg->entry(arg->opaque);
-    arg->done = true;
-    aio_wait_kick();
-}
-
-static int bdrv_run_co(BlockDriverState *bs, BdrvRequestEntry *entry,
-                       void *opaque)
-{
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        return entry(opaque);
-    } else {
-        BdrvRunCo s = { .entry = entry, .opaque = opaque };
-
-        s.co = qemu_coroutine_create(bdrv_run_co_entry, &s);
-        bdrv_coroutine_enter(bs, s.co);
-
-        BDRV_POLL_WHILE(bs, !s.done);
-
-        return s.ret;
-    }
-}
-
-typedef struct RwCo {
-    BdrvChild *child;
-    int64_t offset;
-    QEMUIOVector *qiov;
-    bool is_write;
-    BdrvRequestFlags flags;
-} RwCo;
-
 int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
                               QEMUIOVector *qiov, bool is_write,
                               BdrvRequestFlags flags)
@@ -945,32 +901,6 @@ int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
     }
 }
 
-static int coroutine_fn bdrv_rw_co_entry(void *opaque)
-{
-    RwCo *rwco = opaque;
-
-    return bdrv_co_prwv(rwco->child, rwco->offset, rwco->qiov,
-                        rwco->is_write, rwco->flags);
-}
-
-/*
- * Process a vectored synchronous request using coroutines
- */
-int bdrv_prwv(BdrvChild *child, int64_t offset,
-              QEMUIOVector *qiov, bool is_write,
-              BdrvRequestFlags flags)
-{
-    RwCo rwco = {
-        .child = child,
-        .offset = offset,
-        .qiov = qiov,
-        .is_write = is_write,
-        .flags = flags,
-    };
-
-    return bdrv_run_co(child->bs, bdrv_rw_co_entry, &rwco);
-}
-
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags)
 {
@@ -2245,18 +2175,6 @@ int bdrv_flush_all(void)
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
-} BdrvCoBlockStatusData;
-
 int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
                                                 bool want_zero,
                                                 int64_t offset,
@@ -2508,43 +2426,6 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     return ret;
 }
 
-/* Coroutine wrapper for bdrv_block_status_above() */
-static int coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
-{
-    BdrvCoBlockStatusData *data = opaque;
-
-    return bdrv_co_common_block_status_above(data->bs, data->base,
-                                             data->want_zero,
-                                             data->offset, data->bytes,
-                                             data->pnum, data->map, data->file);
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
-    BdrvCoBlockStatusData data = {
-        .bs = bs,
-        .base = base,
-        .want_zero = want_zero,
-        .offset = offset,
-        .bytes = bytes,
-        .pnum = pnum,
-        .map = map,
-        .file = file,
-    };
-
-    return bdrv_run_co(bs, bdrv_block_status_above_co_entry, &data);
-}
-
 int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
                             int64_t offset, int64_t bytes, int64_t *pnum,
                             int64_t *map, BlockDriverState **file)
@@ -2638,13 +2519,6 @@ int bdrv_is_allocated_above(BlockDriverState *top,
     return 0;
 }
 
-typedef struct BdrvVmstateCo {
-    BlockDriverState    *bs;
-    QEMUIOVector        *qiov;
-    int64_t             pos;
-    bool                is_read;
-} BdrvVmstateCo;
-
 int coroutine_fn
 bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read)
@@ -2670,26 +2544,6 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
     return ret;
 }
 
-static int coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
-{
-    BdrvVmstateCo *co = opaque;
-
-    return bdrv_co_rw_vmstate(co->bs, co->qiov, co->pos, co->is_read);
-}
-
-int bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
-                    bool is_read)
-{
-    BdrvVmstateCo data = {
-        .bs         = bs,
-        .qiov       = qiov,
-        .pos        = pos,
-        .is_read    = is_read,
-    };
-
-    return bdrv_run_co(bs, bdrv_co_rw_vmstate_entry, &data);
-}
-
 int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
                       int64_t pos, int size)
 {
@@ -2765,11 +2619,6 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb)
 /**************************************************************/
 /* Coroutine block device emulation */
 
-static int coroutine_fn bdrv_flush_co_entry(void *opaque)
-{
-    return bdrv_co_flush(opaque);
-}
-
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 {
     int current_gen;
@@ -2882,24 +2731,6 @@ early_exit:
     return ret;
 }
 
-int bdrv_flush(BlockDriverState *bs)
-{
-    return bdrv_run_co(bs, bdrv_flush_co_entry, bs);
-}
-
-typedef struct DiscardCo {
-    BdrvChild *child;
-    int64_t offset;
-    int64_t bytes;
-} DiscardCo;
-
-static int coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
-{
-    DiscardCo *rwco = opaque;
-
-    return bdrv_co_pdiscard(rwco->child, rwco->offset, rwco->bytes);
-}
-
 int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
                                   int64_t bytes)
 {
@@ -3014,17 +2845,6 @@ out:
     return ret;
 }
 
-int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
-{
-    DiscardCo rwco = {
-        .child = child,
-        .offset = offset,
-        .bytes = bytes,
-    };
-
-    return bdrv_run_co(child->bs, bdrv_pdiscard_co_entry, &rwco);
-}
-
 int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf)
 {
     BlockDriver *drv = bs->drv;
@@ -3422,35 +3242,3 @@ out:
 
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
-} TruncateCo;
-
-static int coroutine_fn bdrv_truncate_co_entry(void *opaque)
-{
-    TruncateCo *tco = opaque;
-
-    return bdrv_co_truncate(tco->child, tco->offset, tco->exact,
-                            tco->prealloc, tco->flags, tco->errp);
-}
-
-int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
-                  PreallocMode prealloc, BdrvRequestFlags flags, Error **errp)
-{
-    TruncateCo tco = {
-        .child      = child,
-        .offset     = offset,
-        .exact      = exact,
-        .prealloc   = prealloc,
-        .flags      = flags,
-        .errp       = errp,
-    };
-
-    return bdrv_run_co(child->bs, bdrv_truncate_co_entry, &tco);
-}
-- 
2.21.0


