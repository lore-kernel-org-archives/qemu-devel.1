Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D437C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE832072F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BYCWXca7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE832072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jixfP-0006D1-9y
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 06:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixaa-00089g-Fu; Wed, 10 Jun 2020 06:04:08 -0400
Received: from mail-eopbgr130098.outbound.protection.outlook.com
 ([40.107.13.98]:48772 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixaZ-0005xX-8L; Wed, 10 Jun 2020 06:04:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqhtUIu2V+9aQaI1OWoFjrSDN6uIiCTF5T/pfIy20IWykQtg5yWYthT0SN/M1A3ZEZZTynZHXx6wpL0pYS6fGiFjsrFXvdy1HIeJlsZHr7UqqSCgoEU4lB1TVSiyzUvAdOpBBc4sAb0nmJ3AGI+2DTMoWLwepfTv/FzSABxrx8XuqMPURwB3W6FeEJd+CF9Na5JOLyS0o/Wz64i92QISJFxzRWZsq2q7MXBT94c/6PJ3T1XsVvzmMvmfCRKN790S+TduuFQ0s0d0mzglQoyjGqjAxWivMqw0HptJJ8Ximbj56gXWYHswoEED/x3MLz+71/LwxMp1DluKCZSLwdtY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdkEciUCSDw7LDQzG+bxUvcxlwX6Xi7xdsPRAuiFRuU=;
 b=UiLqUxe1ttJ0jo2fVvPvHV5SHT4tIc8sg9Yh5+4puszllkI2m68fbpJR2mNHyk/H1kbnvnjI6/YxKZL3FTZ3IbhtAxfqfiabdk5ECIYYy64PNBbDL/yMyuX0gNfEJPiofykkd5BjNVu3Qrc7Gg19cq6QLd9U24kN3I/Ql5quEy9ZG5Kg65OTQq3vLjYV6CCbEzyQxAH9+r0qfLAgAEgSds3UByYz9gVsjYwJxGQ7oNXOcXPmRJwGxk7qagV40EngPi9XOGLF1pdBcfxKO3fr9WqHiK/TzNeG2W7e2uv8zfHJxkWFYYrAiZMpMaRTTC/BicDeG5++HSoE1T0uyDFtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdkEciUCSDw7LDQzG+bxUvcxlwX6Xi7xdsPRAuiFRuU=;
 b=BYCWXca7ssVAEHp6TIuVEJnP+8I6sUBDm2tsC6fQB8XItjW4BIDBKvDFB/7aM22Ri6Zuxz/XG39bxayWIfoOqcfWdLAcCJYBMA6lTY4OVSGbHBem0oZgnCg3P/CJmzVJ4HBpH1M8495zWbKpy8AG/cbxqRNxajdelvrLiSdRNE0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5525.eurprd08.prod.outlook.com (2603:10a6:20b:107::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 10:03:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 10:03:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 3/7] block: declare some coroutine functions in
 block/coroutines.h
Date: Wed, 10 Jun 2020 13:03:32 +0300
Message-Id: <20200610100336.23451-4-vsementsov@virtuozzo.com>
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
 15.20.3088.19 via Frontend Transport; Wed, 10 Jun 2020 10:03:58 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b27796e-f88c-4b5d-79d0-08d80d2597f7
X-MS-TrafficTypeDiagnostic: AM7PR08MB5525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB552533BFA4B30BF357267CE0C1830@AM7PR08MB5525.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+zyqzikOiRj/HpeGOIt+Gb1VnmjwQYwXPnQhW48nhnJz4jtMeFHlp0BfzCnzHnR4/OCwsHNQeVFqDX/EXTocrSt5XtwNdRBYvJXxW301QvdMlOhDqabTkjaa3wM5t5cwV3oMmv7ofm8+oGVKMcbX6ts4M/LUpEGFcNw2LodqiS/gwp0sarR7cf44wNoSMP7DofGZNqXPt0RW493wdciUR0/692A0V2fOU9lk4U8uwbl3NTjPrGtGXYNlFqg0pA/wo0c9mVwRPeWVrhtNCtTnE+HXLmzNoMUVlSlSYUdJrltmCelR6pwHn0gc8G6I7jz4X3ZWzw5SDBDnd1+XGtQkZ5a2cPbNd01dwjx2+M3tOasFpPQlaj2OyKaqUl6bJxl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(346002)(136003)(366004)(376002)(396003)(478600001)(83380400001)(66556008)(66476007)(956004)(6666004)(316002)(5660300002)(6512007)(2616005)(36756003)(8936002)(107886003)(69590400007)(6916009)(6486002)(26005)(4326008)(66946007)(186003)(8676002)(6506007)(52116002)(1076003)(2906002)(86362001)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: r/4Ti6GAl6u28hWlXqa5tkN46TpJHaZq8xdGWZY0AlW0IogV8UwqIALWt/7a6Yc4nZ8rTz4WVG/uD6YO+QFM4wmeqBtnVsp27ZPiJnsxkvZZhctsaBC0rKKSLNeqYerj6oYS4kpO+Xc6xhQxYP9hqevCKSKKIuqTeCMK1OKLkifsqxfvsS5SLvz4vdoEKD/QEHS8FoSz04O3J6iH7Tt8bekDxzet0oH9j5Y27daEc7mnzbbWQaaSNK6Z3nza4UVaFcfBr5+xw/cJozPH9fC/7UosmhBJLxx26KzhjPjP5xo+VQuhbR/vI8c4xoMSR8OzZC5I38icKLggeFLKC28k5W75lWtoZq0MQgyBRBc802qMXQj4R5pxR6NahsSB8rso2Gzrjzg/LkUDdyT/tN3up79NELjyomuLeUeaHsgDqQrhikWYVYsTkfXrcmRt/m+8mUttyN3xvtYNb1szSqXiqb4mwe6auyesVqlOd8itG4w=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b27796e-f88c-4b5d-79d0-08d80d2597f7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 10:03:59.0112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsMdEyarpbtHJqnFlUsCsSYaw/HeNFg1OpJT6udXnlUZ+ye6xmyreSfIA4aVISpFkfTMo/4cj9brFJY4M7qglcSehTpwLGqcx1u4KTXf4a8=
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

We are going to keep coroutine-wrappers code (structure-packing
parameters, BDRV_POLL wrapper functions) in separate auto-generated
files. So, we'll need a header with declaration of original _co_
functions, for those which are static now. As well, we'll need
declarations for wrapper functions. Do these declarations now, as a
preparation step.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/coroutines.h | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 block.c            |  8 +++---
 block/io.c         | 34 +++++++++++------------
 3 files changed, 88 insertions(+), 21 deletions(-)
 create mode 100644 block/coroutines.h

diff --git a/block/coroutines.h b/block/coroutines.h
new file mode 100644
index 0000000000..9ce1730a09
--- /dev/null
+++ b/block/coroutines.h
@@ -0,0 +1,67 @@
+/*
+ * Block layer I/O functions
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef BLOCK_COROUTINES_INT_H
+#define BLOCK_COROUTINES_INT_H
+
+#include "block/block_int.h"
+
+int coroutine_fn bdrv_co_check(BlockDriverState *bs,
+                               BdrvCheckResult *res, BdrvCheckMode fix);
+int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp);
+
+int coroutine_fn
+bdrv_co_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
+             bool is_write, BdrvRequestFlags flags);
+int
+bdrv_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
+          bool is_write, BdrvRequestFlags flags);
+
+int coroutine_fn
+bdrv_co_common_block_status_above(BlockDriverState *bs,
+                                  BlockDriverState *base,
+                                  bool want_zero,
+                                  int64_t offset,
+                                  int64_t bytes,
+                                  int64_t *pnum,
+                                  int64_t *map,
+                                  BlockDriverState **file);
+int
+bdrv_common_block_status_above(BlockDriverState *bs,
+                               BlockDriverState *base,
+                               bool want_zero,
+                               int64_t offset,
+                               int64_t bytes,
+                               int64_t *pnum,
+                               int64_t *map,
+                               BlockDriverState **file);
+
+int coroutine_fn
+bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
+                   bool is_read);
+int
+bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
+                bool is_read);
+
+#endif /* BLOCK_COROUTINES_INT_H */
diff --git a/block.c b/block.c
index b01551f21c..2ca9267729 100644
--- a/block.c
+++ b/block.c
@@ -48,6 +48,7 @@
 #include "qemu/timer.h"
 #include "qemu/cutils.h"
 #include "qemu/id.h"
+#include "block/coroutines.h"
 
 #ifdef CONFIG_BSD
 #include <sys/ioctl.h>
@@ -4625,8 +4626,8 @@ static void bdrv_delete(BlockDriverState *bs)
  * free of errors) or -errno when an internal error occurred. The results of the
  * check are stored in res.
  */
-static int coroutine_fn bdrv_co_check(BlockDriverState *bs,
-                                      BdrvCheckResult *res, BdrvCheckMode fix)
+int coroutine_fn bdrv_co_check(BlockDriverState *bs,
+                               BdrvCheckResult *res, BdrvCheckMode fix)
 {
     if (bs->drv == NULL) {
         return -ENOMEDIUM;
@@ -5643,8 +5644,7 @@ void bdrv_init_with_whitelist(void)
     bdrv_init();
 }
 
-static int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
-                                                 Error **errp)
+int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
 {
     BdrvChild *child, *parent;
     uint64_t perm, shared_perm;
diff --git a/block/io.c b/block/io.c
index af6cb839bf..deb9ca8d82 100644
--- a/block/io.c
+++ b/block/io.c
@@ -29,6 +29,7 @@
 #include "block/blockjob.h"
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
+#include "block/coroutines.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -933,9 +934,9 @@ typedef struct RwCo {
     BdrvRequestFlags flags;
 } RwCo;
 
-static int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
-                                     QEMUIOVector *qiov, bool is_write,
-                                     BdrvRequestFlags flags)
+int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
+                              QEMUIOVector *qiov, bool is_write,
+                              BdrvRequestFlags flags)
 {
     if (is_write) {
         return bdrv_co_pwritev(child, offset, qiov->size, qiov, flags);
@@ -955,9 +956,9 @@ static int coroutine_fn bdrv_rw_co_entry(void *opaque)
 /*
  * Process a vectored synchronous request using coroutines
  */
-static int bdrv_prwv(BdrvChild *child, int64_t offset,
-                     QEMUIOVector *qiov, bool is_write,
-                     BdrvRequestFlags flags)
+int bdrv_prwv(BdrvChild *child, int64_t offset,
+              QEMUIOVector *qiov, bool is_write,
+              BdrvRequestFlags flags)
 {
     RwCo rwco = {
         .child = child,
@@ -2466,7 +2467,7 @@ early_out:
     return ret;
 }
 
-static int coroutine_fn
+int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   BlockDriverState *base,
                                   bool want_zero,
@@ -2523,12 +2524,12 @@ static int coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
  *
  * See bdrv_co_block_status_above() for details.
  */
-static int bdrv_common_block_status_above(BlockDriverState *bs,
-                                          BlockDriverState *base,
-                                          bool want_zero, int64_t offset,
-                                          int64_t bytes, int64_t *pnum,
-                                          int64_t *map,
-                                          BlockDriverState **file)
+int bdrv_common_block_status_above(BlockDriverState *bs,
+                                   BlockDriverState *base,
+                                   bool want_zero, int64_t offset,
+                                   int64_t bytes, int64_t *pnum,
+                                   int64_t *map,
+                                   BlockDriverState **file)
 {
     BdrvCoBlockStatusData data = {
         .bs = bs,
@@ -2644,7 +2645,7 @@ typedef struct BdrvVmstateCo {
     bool                is_read;
 } BdrvVmstateCo;
 
-static int coroutine_fn
+int coroutine_fn
 bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read)
 {
@@ -2676,9 +2677,8 @@ static int coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
     return bdrv_co_rw_vmstate(co->bs, co->qiov, co->pos, co->is_read);
 }
 
-static inline int
-bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
-                bool is_read)
+int bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
+                    bool is_read)
 {
     BdrvVmstateCo data = {
         .bs         = bs,
-- 
2.21.0


