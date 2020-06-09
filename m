Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047C7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFDF8206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YwPF60hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDF8206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jif4q-0003nh-Tw
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0p-0006py-0v; Tue, 09 Jun 2020 10:13:59 -0400
Received: from mail-am6eur05on2106.outbound.protection.outlook.com
 ([40.107.22.106]:18497 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0n-0007hk-P9; Tue, 09 Jun 2020 10:13:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpXM/71rEKGea7cR4xaiZvEHD1cuj6jR3pqSI3E/3BlsZfBQEQxIk0oOnXO2Uc0nqqpFMutx0KJBQ0SPfxMKTcl3TIyLpi/eONpj+ve6Il9+SEkiSSPU6g8CcchI9cuv1i7LGoFe5BetUBlXLa29td/+imke+hfFm5mgwlc5mqbL+iTiayNxjNo5ArpR6BEnZHwBP8DKiXa3lUK3NvxJ+VKNWVWWqco8LzhG19/MB95A0PQQmvQDVLN13HBQpQNd/AAV1jL92ht60RJ1gOZwv2ti12//yzfLqG1doAZyPxoXN7xzV8BY1CoBv5ay+/UGF36vi4bvI0mJFS6ir+WmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdkEciUCSDw7LDQzG+bxUvcxlwX6Xi7xdsPRAuiFRuU=;
 b=i3O+x8yK0gJqwvhZiBLoOVKuPdd5o+bCq1xCaVBJV+BfXskleVL3VX9sAW8pXcXKFhs1zn5YUZwE2txu/mUqcaeIgCTj7sv+R5UhSJk2mqxLOcN8FT4iH7BBBaqpwFWxksIZtaRDgphXE2odriGCBgHUwn9WLu0l5Xhg6V4aRBCeqwufxYYtsM6usxcIYuzEaHB9R1V48xPl41r3hqDKhphrdhQfIet6pnLy+BsjNpCjl9Huz+k9kty4cmfblG3uuKcuERoDAWHzz8n7yrZ3e8LSpGJ2mCFvStnv4/Q1OO7+7VLznSLc83df+3FFo7gT0+I79GKfEWhDeBgmpaqb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdkEciUCSDw7LDQzG+bxUvcxlwX6Xi7xdsPRAuiFRuU=;
 b=YwPF60hbBglXt7PwOShaUTLsMg5j8AejolDA4svSWqoS+JSGWBfW+o7Dto7W/8WdTIdMUS4t20RTzsnnc2enZill+tBVOammBtfs3+5s1RmHnvRa1tTURvMky7/OlKTLr4ZaqGJoGTltMVCtsnRVbF5yFJyRexPQuCIAp2lu9vg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 14:13:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 14:13:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 3/7] block: declare some coroutine functions in
 block/coroutines.h
Date: Tue,  9 Jun 2020 17:13:25 +0300
Message-Id: <20200609141329.3945-4-vsementsov@virtuozzo.com>
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
 15.20.3066.20 via Frontend Transport; Tue, 9 Jun 2020 14:13:49 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.180]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3322aa1-afe9-4525-d81b-08d80c7f54d7
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54942AA1F2EFF4182936FB5BC1820@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MS54o889E5LWjnuPjTDPvWv11TFj5YPlE4sPu6+Z0FNuJCTgf8nquG02CnNIiSiJpfihnWWSymG5koJhhgpEY6yRq8DhZ4S9cAXfPXb+8vVUZP0ebCLLCvcT0vi3X2i0zi/3e1KUBZb025PUJak7m/JVIzLdz6NTLq3rjxAB2AeELtEZ5nOWv6vFb0wH5REvs6pfjhpqIPdIDwBujBennG+617lzZ6dJ6ZvjH1JWRoEWWYkhargvFgZgheg9qr9BdLVbUTSQHMKjvxdj5KESJrjBsBRvSlm6rbt3U0OkZIWVMmfG355ofPm3iEK0EJjIpahspCjcM85aCrf6Jp7vbloR/keGZB7oCR9N0HeniUPgJMj4O1KVA1k6ehG0DrHz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39850400004)(346002)(2906002)(6512007)(8676002)(83380400001)(6506007)(16526019)(186003)(26005)(6486002)(478600001)(36756003)(69590400007)(6666004)(8936002)(52116002)(6916009)(66476007)(66946007)(5660300002)(66556008)(1076003)(86362001)(4326008)(2616005)(316002)(107886003)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kSVn/fHtDrveNLNQXIVkol9haBF9POPmkW7tX94n29Z06nabb364BJ9pFR8nBzkz8QDsR2V569Mw9lqC8Mo8DX1EcOcKl7i2uhJgsIBMaIsKMGvLAWcicLqcak1pdj1uY5/3vvDrz6P6Vx9hFzZGq1O1avRLXHp2Dzek8FTueYSrEKZ8Il+bw0w1yRjlT6wiYUB1RKTUJUK9iy3RqI8kT/+MJdCII5dcL/py/HDvUWXc/xWRS/ux7H0O/3YGpEGwrMJy5+rRR7aVr0CHEaPr/SFS5Qka+X+I4jJ4BgamWFzQMFONvANIwCn8pOO7LhwxHY/lh3EnYfZmw6MYunxqQYCQ0gY3fSLcl3KzRp8Pgj3+vVlnvBFXRTYLTlsIHU3QYNuErOPTNObUQNNoDWzak8OtiR6j49zTlJ9lZ6oDEawksx8WjnlaYwQpnFFIRVTBBM8g7byXVJI66hTemgI4+irXpoEvxp7Gd5DMmEtPv7c=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3322aa1-afe9-4525-d81b-08d80c7f54d7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 14:13:49.8070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDx3QOU0eZ3TecDMGrw/GsFxu/1FlY9+hlyQFdxg8PRDjf+15rQTPBg1f7UAh2Yro7IdHG63kRuZWkUOy6GVI5Ftd8idcUqu1AFM/GmyDSw=
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


