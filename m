Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE914C47423
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CB4238A1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SELJZ0Mn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CB4238A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWSb-00058K-I8
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 14:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWOU-0001JN-HY; Thu, 24 Sep 2020 14:55:02 -0400
Received: from mail-eopbgr130114.outbound.protection.outlook.com
 ([40.107.13.114]:8257 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWOL-0002O2-3g; Thu, 24 Sep 2020 14:55:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnRVO8vYEMYCVLEFz4VoXxkh0JgNVSkQVZ2K6JCJzwdr4sDBh+xxjua2JwJr81weGL3OPvjyAqettg2mx2BWz6SkAgEP2jKKTYaLnReHY4cXDomTMuJ0/0iDw9q1yJ0pCfKKQ/lqDBGn0n75pDvTWETqGMr0EKkaBfqevFxaZ8O39KSdikrY8aT8+Qd0diZVqeA+kxftLgNjVmX/EkeDQreudlW1iNpV6jNLFoAuwZief1IxbzZZHm6xHlLOuSWq6Op7zatcXaqbJU1LW8bUEkHpxcOG3XPhckEbYs+oIzI4c7xoFBXG72K/JO6OFQiw2caiqEhROZKt/Mr9BW8d7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/skAuJOQTLyYKoeUDzpb83EM/Hud8EtD+2+bhAhYGx8=;
 b=MrN8ogmwTEAUeqI0+ujef1bIloglQmYpRPYMefEpT6JFJtlrNKmXEGm3mq2krLaFxeKFwK+QRT4tYhAwP+LmQsTmMoV8IoyFLXJN/bNl1GX8dY664hwrKZzwZOhRCO191i5UcU9gU/jBTYw3PqRWZi85C5wjcDwwK8zm3cEBAXDh0BCkVXS/rGJaAOvbc3dnZ484njA4BSF2G/4DSZsCBoecPJbNiBvnoHK9oz2xNX/C+HI8vb4nJ0nIfVJmXyI3WVuh7dp1gmdSZ7g29M+EzxG63hjUoHwQHh4GqUp6mp5TNDZ9wMG860c+15gouC38kg0L308dZFFMwIs/K9J4/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/skAuJOQTLyYKoeUDzpb83EM/Hud8EtD+2+bhAhYGx8=;
 b=SELJZ0Mn2ujHm8G08hb4DE67iTnGnU7LGXyvnAwKRrgyg87sK2xq/HMNxyT+PEPreL+IHVlYnHHZYo4taHXoSi9h3Aq+1XIRigZocob6S5lbY5PUMH28LLu3T/kpufyshG19ow9S/nQafegyuDHc9N4HXQs5zhyj4fchMmNVFb4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4341.eurprd08.prod.outlook.com (2603:10a6:20b:b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 18:54:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 18:54:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v9 3/7] block: declare some coroutine functions in
 block/coroutines.h
Date: Thu, 24 Sep 2020 21:54:10 +0300
Message-Id: <20200924185414.28642-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200924185414.28642-1-vsementsov@virtuozzo.com>
References: <20200924185414.28642-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0082.eurprd05.prod.outlook.com
 (2603:10a6:208:136::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.94) by
 AM0PR05CA0082.eurprd05.prod.outlook.com (2603:10a6:208:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Thu, 24 Sep 2020 18:54:35 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7217b8b6-b215-481c-d215-08d860bb4837
X-MS-TrafficTypeDiagnostic: AM6PR08MB4341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB43412EDB0D35E5AB33DF8ECAC1390@AM6PR08MB4341.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYL3QvlCovmsz2mCovgG1TB5S0agNw612vdob9bmmfwh180cC5C0Y46zgZAS3Hffzrx1tHZ2SjFBdBEfoIoxkC0Tnsr3JgTkX3sh5T2U5Y3eKNhnsGHtEeQpZHmoAyWivTz0dbGPd6ffREogpaa7Wh5k9ZZZNZXTUsAn1Ng1l/eQ+JbJ2vbX1bl+U4WBfnjpd7KxSbyyGMBM+V3S12BFL5vmA6CDsEdlFZICJHIv3YAKrInqWAwiiTNxX7YquQ6JRrL7Tnc1EyGuc0lzX1Yqua77QVpGcCA848luSIPXvVqSMUPl58wuPSfv3viVEU+DYAMgZ8YFNUNRzVB2DHQfIKmi4XFcH9W6YmxgtXJkj4/Kl2tJ05tfsC9hew4ntH89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39840400004)(316002)(83380400001)(66476007)(6506007)(186003)(16526019)(5660300002)(2906002)(36756003)(6666004)(8936002)(8676002)(66946007)(2616005)(956004)(52116002)(6512007)(66556008)(86362001)(26005)(4326008)(478600001)(6916009)(1076003)(7416002)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qixFXKNyugNl/b6I9BJMyOSMJ3xBZ25NY5sVPs23O5GZiHnqkbeh628xDnDuaOnl95LM6+5r6vz0hoOM3fR6th0itZ76sjYAESvxJ51vdaP3XF+cNfEFvDo8tgu+1D093gOtxBvY9bxNJpaeBX4r90yxQByUPkFHC7Aw03z66ytUvhQ2BkXObr8O57ZBmYYdr2mu2mOc1oM2fHQ7jI56EalTfM0h5v96FgPSEz+GnHguLd+hvHScogXIWrjLYEAwsaTz4FSu5exYPK6cP6g2EapVIA2lWHJF9WuP4Eg55F5VgF3m+JndXranPvTO1TcFfJQGRXdOPBOMzTIC7M3xdJjmHPzs0K5ycSBhPIYXhCQmor7v4LLlpkv1ePe+KdkEfG2wRoQSj6zA0NIfTGIZ7S05MwVOvxsU8S5MOusnuub7bCJW5nN3Z6qk8C+tVpbRW8J4R79gwEiB0hFUfWgAenwdjjxG2YacKQJkN1aisO1jb3oXoxmsqh5hO5xmxHnzutcMedX2ILE/wab17frpdocpm4yrGhsX6R7aHO5tKaVt8KK8QPxeK0wi7pBBEHQ8yFEBq+9aULwYi0Q/Ka4sEtvr15f/iWIP3MPtAoaBrhc9V1JP+bPY2Of3UzntCB6nHuM7zxXuR1H3p94S6eBKDA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7217b8b6-b215-481c-d215-08d860bb4837
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 18:54:36.1237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdo5KXqscCk+qJSyZ5mXQ9Xqhk//LMuf7qTZJiDfDW6IQNs4Y8yzbgv5KOhQx163RY90QIM4nQxuQMtozxH+wDvpDAL9zPehqK9JDPDnWz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4341
Received-SPF: pass client-ip=40.107.13.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:54:34
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

We are going to keep coroutine-wrappers code (structure-packing
parameters, BDRV_POLL wrapper functions) in separate auto-generated
files. So, we'll need a header with declaration of original _co_
functions, for those which are static now. As well, we'll need
declarations for wrapper functions. Do these declarations now, as a
preparation step.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
index 47b3845e14..6e2bfb93d8 100644
--- a/block.c
+++ b/block.c
@@ -48,6 +48,7 @@
 #include "qemu/timer.h"
 #include "qemu/cutils.h"
 #include "qemu/id.h"
+#include "block/coroutines.h"
 
 #ifdef CONFIG_BSD
 #include <sys/ioctl.h>
@@ -4676,8 +4677,8 @@ static void bdrv_delete(BlockDriverState *bs)
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
@@ -5781,8 +5782,7 @@ void bdrv_init_with_whitelist(void)
     bdrv_init();
 }
 
-static int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
-                                                 Error **errp)
+int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
 {
     BdrvChild *child, *parent;
     uint64_t perm, shared_perm;
diff --git a/block/io.c b/block/io.c
index 24a7de3463..897139a8b2 100644
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
@@ -2452,7 +2453,7 @@ early_out:
     return ret;
 }
 
-static int coroutine_fn
+int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   BlockDriverState *base,
                                   bool want_zero,
@@ -2509,12 +2510,12 @@ static int coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
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
@@ -2630,7 +2631,7 @@ typedef struct BdrvVmstateCo {
     bool                is_read;
 } BdrvVmstateCo;
 
-static int coroutine_fn
+int coroutine_fn
 bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read)
 {
@@ -2663,9 +2664,8 @@ static int coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
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
2.21.3


