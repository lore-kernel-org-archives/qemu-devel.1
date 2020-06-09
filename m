Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB46C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 832B5206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F+2R1YwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832B5206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jif7H-0006dm-Or
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0r-0006vA-9v; Tue, 09 Jun 2020 10:14:01 -0400
Received: from mail-am6eur05on2106.outbound.protection.outlook.com
 ([40.107.22.106]:18497 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0p-0007hk-LJ; Tue, 09 Jun 2020 10:14:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1SvM8H+lbjvLv8+a2VkMD8DUjjhs97UBr3gxFIJvudd4dJ1/+veh9Snbu1+XZpAfkw2+LwaLIRIXwFDKlCPkrWTaPVfyw40jHpfbnt2n45/2ZXXl0KRj24T7OHsM3afzTMroULtszHU6QNysiFrrcV7Zsc56TCwj0SHzrHLsAscrQQLia7K29FjnjOUZKDLXckNvyB0Sm/ApDnA3xipZNgVkzG/nXV6RJh3XHz8F4fM6FySpYyX5yTne98reJ/8BL0lQ86liSV8RQcK6hEhJWeA0ATaV0hKUo8TLJfoXumOTkPzGf7cKtRZ7B4zHQA0ODOY+KBnqUlxPHL80m32Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHNmPReNB/FFQ2Oj7AfM9sIBpQdZfZsnC0Nu7dHRlVk=;
 b=gDGUxpDi4sdteizN4IbtpRT2tSaDlvRVSMKN1aCXvGdepi30f/ytzeBFqf2dg4aRz0QVU1CRST0lP6fCzrdNLCg4mqe54WTaaW+nXMT2t8yT9Ab0+Q1fAjuFBvloPY847sQua6RUTc1dduFJjak7knGaMK+m+LwUjpaFtICUNq/gbEMPWevErV1X5v6y2y7VnHD8E5jHgaQwj0LurKlWZrwGdKjJzp4lrr5/TziUqKwAj53ia8Yhb/e/gNPI4uVm1WWE53QrJ2M5nau3Q3YVecZnVmX7h361TRLM5u7Y4QFHKdJXkplYwjeN7SAfI6iqTUSHeUs7yOF3Ap7k57y7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHNmPReNB/FFQ2Oj7AfM9sIBpQdZfZsnC0Nu7dHRlVk=;
 b=F+2R1YwYqy/y12zZ6XfEdBxTdN9qEPu65tqIwwZcLB/UTCxSAtYoZW4B3vrsv8ssS8OpKP/qvS4CeT9WlxyX/sQzKxtBf+3jDSDr9OVZecj99tSowWhuDuhs+0ax1uQN6LBaL+vc+sm43Y42dzsTh2jGx/VG4h4COAGCpFKVB70=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 14:13:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 14:13:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 5/7] block: generate coroutine-wrapper code
Date: Tue,  9 Jun 2020 17:13:27 +0300
Message-Id: <20200609141329.3945-6-vsementsov@virtuozzo.com>
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
 15.20.3066.20 via Frontend Transport; Tue, 9 Jun 2020 14:13:50 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.180]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a12ca7f8-0f76-4b10-09a5-08d80c7f55f8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54943A2C7CED8F50EF2043DCC1820@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:79;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltCw9Zx6i5MHBrHzghq9bfo/JosovHwY6/O98m/vzvk5TEegpzW36tqBN/RRsnHkFchFuP810guPIFzI2xdUTViTOyUuLAUyULLfKo14DouoZR3J2cok8EHm4k/sBDQ4Dyrs29NMf+wIa0D8HBTh0Eenl7rfWmLKIMeWP549hnU66u01/KWCBTZKyU09XBahTHlk9AW9BOvU3Dl1GcscEiG3u8oLJuYt9k7CjBH5jHhEKuMg/S0AFCKrz7n8c4TZUrAlcM6LyRdKQY2XkGPmCRs2mK6JAOV5oR3ZyKnNBpeVI59pAOJPhZRc0pO3MNhKGoz/j6/No9zaCKXSO1UdXJ0vLong4sFmuhI6cs+QE4eNo4V+00PEA+8YcU4zEpw5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39850400004)(346002)(2906002)(6512007)(8676002)(83380400001)(6506007)(16526019)(186003)(26005)(6486002)(478600001)(36756003)(69590400007)(6666004)(8936002)(52116002)(6916009)(30864003)(66476007)(66946007)(5660300002)(66556008)(1076003)(86362001)(4326008)(2616005)(316002)(107886003)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qWkrsavfQt1Mc09PbJvIfUI7jDG9BWuAXctJfhiYZgUyxzIdK7UbDMgQWtIOB4yTJOc5akp+Yt4qSIS8L/aK9VBmLXEXLk9D6pCtZdhrJgMKkhD+eGPNTloOBAegqRFQWbvC0ezjVOoPO/UUIfUVMb3dHKWh+t487ohsm/0dshCKaZKVQ2RtwKERsk4dX/m+xiPLo6mLrndAUV9SlMXECjSn7E2bhs5obcJSYyMLriz4DvgSZ6/RVDj7mvZ7ztj6MT+NzFGpmAGna/t75VsBmPVf9c8mYph/uD56TIhOT3pDuFrCguxv6+a1ooArpaWZBN1LRx2CZkCadwudoawsvMo8rHnDB0RQ2I0ScH4LF1FxOQ+r6WdM2DGWZl8jE0hSngXj9T7hgmOIiUmCqlb10szp0sdsxxXHdlanjiKpWejHLfe/ICcHhuMIi8uPtVahoKXjBCwpiAZWWrNcvFsAnqt/Bq20m2c4Q2tSACs6IG0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12ca7f8-0f76-4b10-09a5-08d80c7f55f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 14:13:51.7346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5HgQH812Pn7QHxAxDE0fA4nm9V88qn4ujPH+J0tpbZYmRGTVAV/D2nwthHkrVG4mAtdc7c+rqxNl/75LdD195wKRvEtFFnhfL6NW0y7iZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
Received-SPF: pass client-ip=40.107.22.106;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 10:13:55
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

Use code generation implemented in previous commit to generated
coroutine wrappers in block.c and block/io.c

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/coroutines.h    |   7 +-
 include/block/block.h |  17 ++--
 block.c               |  73 ---------------
 block/io.c            | 212 ------------------------------------------
 4 files changed, 15 insertions(+), 294 deletions(-)

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


