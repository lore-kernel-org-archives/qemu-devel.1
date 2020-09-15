Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225BAC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A781420809
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bwQBtzEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A781420809
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIE6F-00029i-Q3
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIE4N-0000Ef-6G; Tue, 15 Sep 2020 12:44:39 -0400
Received: from mail-eopbgr00131.outbound.protection.outlook.com
 ([40.107.0.131]:27107 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIE4L-0007he-56; Tue, 15 Sep 2020 12:44:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3E3BfpNbSuzA8KOLlkE6FxGYTiBr9oCRO914bW5oRpjXbzLGoxMFYrrZaqAshCSctw8Ac6U9fGFMr/me9ns+HNfZbtP08L/RckYL0tuuI7zGslcuGpTRQzeeU10wFj26b14qxAfY1XYfmnkvl3+q1j7B/5bVWU8Dxm8A+WYJsak54dM1erkHRUm0fYviD2DFTPW4GmpVcyOLqnK4z3XngX6U6idb7Lvi5PIgE2/Qub8WhQW1KV3j1LZ5ktFeZwKrnTTNI2pxNJerle1BWgGl7i/9emPH4mGMAe+WVNNtbAnBrjPwgqeIbIbNeTj1qurFvJ5g50mX7R4hY492qVUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXTc2vOBQaJj9s8IJxi73NFh1IaXpQ18epG4EPbK03A=;
 b=CejFbMnxr/wzknJ/pD0xCPHpX/NESiCevPTkRx+nj2r/kilxFSFPi+EMnsrcQwHDHNos6YWaSADXOi0L+gBsSYi2y5c+slx5sol6qWrKWnK41sxXAEbE8RF805UEykXXrc7vgbE6UWGicEVXVx4lZBUofJPHP1aZfsww2Kytj8qVecVAjb5W3g4o0xgtyj3d4JkxpT1cMnnDjMnv4COD7zfRhSzXM4j8bCY79JFkYR+DZc5Xdp/Y6j99qejJj4rB+T9KMQZXjdQ40WzzFYgaFiGCrm9oQYJMQM6Y40XWdeQHgfU9zXQRNifiRjCmGNhMlhY0bwxzz8bXSFZizoeJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXTc2vOBQaJj9s8IJxi73NFh1IaXpQ18epG4EPbK03A=;
 b=bwQBtzEjb5VXd1yAIenb3p0zLquMNQMFJhMgtNB111NczhPAdQAu8MMSEpWPALmFLy6Svz1aNTL5yG4UlG2rCUf6uoVOU6ztAv90Yx+UBGgP05gkw4iCJ4Slzwb3q7zGFGWD2M0/7EHsaSbrPhRaUCoozbpi21CyJpyH2YIpqkk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 16:44:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 16:44:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com
Subject: [PATCH v8 3/7] block: declare some coroutine functions in
 block/coroutines.h
Date: Tue, 15 Sep 2020 19:44:07 +0300
Message-Id: <20200915164411.20590-4-vsementsov@virtuozzo.com>
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
 15.20.3391.5 via Frontend Transport; Tue, 15 Sep 2020 16:44:25 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74a19726-ccdf-4d03-e3fb-08d859969b52
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB165245A74E1E1F75B34828F2C1200@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ybnpzw3g8i9hBTr5/bukS6h4MiuqfCv4MTKu8tnWeZu3IlGrL5KmIVajZohXkRg5tmJEcr68BwaToy7jipYBNtf4tfDWgjaovCjtoO5mvi5vIiJygScIa5baHmK2cpThjuna4JpI8yj5MCURUzv+oaDAwjciF1fd9DS5bTM2umMxFKF6YOgJAVvAyCKZG0C+D344SYNBSEqi38li+roDNfTOY7mI/u6kk0xqFOyp1kfa1iHfijJ0x4XgIu45sLcrXWahLBVFW0P8WCrN9nL3h4yOmbJdHpHwDYVrHo32tCiCEKS+/5CaZZQn6IrBPywUmnoooSpcaLFkquUe5KPySBZbY0IrY4qY/HWWV2WU9xgNfpLIKlhXKpHy2zOjlNZ1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39840400004)(6916009)(6512007)(2906002)(83380400001)(36756003)(478600001)(1076003)(6486002)(86362001)(2616005)(956004)(8676002)(316002)(186003)(16526019)(5660300002)(66946007)(6666004)(52116002)(66476007)(8936002)(26005)(66556008)(6506007)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wfJg3ePy4ZQ3FWpRARRc1NhFRIQ3KbL8N1HLZlnVkHklDDU2OoxEEGeyLqjs8bJiuKbdJM9Z/pj5x7BW6wJhpknWLR1OTVqezQ6Krh5ROplxY+PEKLT4dmn1p54o2AalP5V3eEmID15pLOd6RA0qyOsy9boQ0eacosMQwTdtXnowVJvJ/L8ZY1Xvv/HrMPAS08lodeH6Lt/W7spX73Pvp/qBuyZYZKkCLTbar2bztMyo5PlEJzZOSm5PzpfAT0RlFK9eXCL42Pz+/VGN6PlorKBe4fy6yXjQZUEY89z44BcqrVuGvo1RanEwUPYizQQmAGCD0/iIkD0zcqqCs17bW6RTTl/q+EekVmwJK1e9k+pWb5BWYlEYbDGFVXgsWJkAYl34mssSABqVIrJqLzI+2MeaGqEaUSoGae9lNfx8KgCIoADKdEpRBzBkhnWL7Is55pkQAAMJOPGO0KRE3ekD19EyMtKAI//q+6fn1AnqOUl6hC6rx/Zajs/KBKaAN9UK1J5EJO5QEttxeaSe7qOrQa+feiVLslgiK0nKuQbJSc+/0+08oaqudDuWA9uyLjWPTOEg9mSDRGT9ehGp72DfPThx943sI+eoXZCEK+iCOCuAhrfQBmo5o+Ia7IUl10B/uf/4qPU5ib4zzC26Lm/ikw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a19726-ccdf-4d03-e3fb-08d859969b52
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 16:44:26.0972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndVXZgkq6nv8+EDpdEqyBBB8aemSqFXuLg73JjeGtJKDBu503ZBvJb0jMgvsgnmIAnGpI2as84VJvsha252uN/eZYhC/4SM1JhFsmbw8SQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.0.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 12:44:35
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
index ccfe1d851b..ec5a8cbd7b 100644
--- a/block.c
+++ b/block.c
@@ -48,6 +48,7 @@
 #include "qemu/timer.h"
 #include "qemu/cutils.h"
 #include "qemu/id.h"
+#include "block/coroutines.h"
 
 #ifdef CONFIG_BSD
 #include <sys/ioctl.h>
@@ -4640,8 +4641,8 @@ static void bdrv_delete(BlockDriverState *bs)
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
@@ -5649,8 +5650,7 @@ void bdrv_init_with_whitelist(void)
     bdrv_init();
 }
 
-static int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
-                                                 Error **errp)
+int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
 {
     BdrvChild *child, *parent;
     uint64_t perm, shared_perm;
diff --git a/block/io.c b/block/io.c
index 2e2c89ce31..676c932caf 100644
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
@@ -2468,7 +2469,7 @@ early_out:
     return ret;
 }
 
-static int coroutine_fn
+int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   BlockDriverState *base,
                                   bool want_zero,
@@ -2525,12 +2526,12 @@ static int coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
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
@@ -2646,7 +2647,7 @@ typedef struct BdrvVmstateCo {
     bool                is_read;
 } BdrvVmstateCo;
 
-static int coroutine_fn
+int coroutine_fn
 bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read)
 {
@@ -2678,9 +2679,8 @@ static int coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
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


