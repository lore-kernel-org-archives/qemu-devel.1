Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523E2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B24B2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DAIimQEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B24B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcATe-00058K-3l
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jcAP3-0003rj-AM; Fri, 22 May 2020 12:20:09 -0400
Received: from mail-eopbgr140117.outbound.protection.outlook.com
 ([40.107.14.117]:21575 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jcAP2-0006pe-EP; Fri, 22 May 2020 12:20:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC7K6kP4ojH5PS/+rYlOhuq0oKS/jWBkXS2DQB43gHx8GGdUBy/OJZskGpcgENV+yUGrpksBpHGqJumfp5Y1yzUbUE3KU+Gq3tCrchkQeOY0mEd9NZI083eqyKooioJ7iWuV7csVDd/mp9Du+A8laGFMsziVvaMM72+dPjT2Su0sPCPi2po3U6sWRaKqsrCbpKhimvHBi8vi4rfBRGly0pvHMn+kkYwKyBkArIOwjc4cjhKrlaF8Pq714Z3bZ/OV9XBuGfWi/R9AjjdKT6jXVRvn5fcmjEm4/V7AqOfvD7jd17+FAxpf0N2MMThlxz4UeMQsgpDW0tRpYiRv2gyp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwC93dflJu1NuqVGT/tqBJDncOZgO2M3XxzvN1FEAFc=;
 b=g7D2ol7v7/kZwoC+AxjYOZ4ROX/NiM97X17z1Uv/ywO/uMFKR96RfvEQg6WX+u9i2W+tELZOAlO8W/DLkT2EqgG6kiFECqFlFlMzYYJ/gtGR+UKHbTU+Q/EUGp4HEoLNO0v3I5pvpXHUpso9RJMUttv82RtAj0rGXP9TNWwmVerQ6qtWbYxvFEnEZx31yz3tUTb6jHDBZZGNfh1MxcBZR6qUexM05P8Wfdd/xNZmfW3v6KFYgpPz4nAc6hcOsjKBrmF/uH1tl5rlcpRwJcVLOo6Q72L1pFMGLTwMDK+uUlO9i2iOcq3bk+/Ut2olgiGVDfeaww4Qv6Vt+qbWSh5RLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwC93dflJu1NuqVGT/tqBJDncOZgO2M3XxzvN1FEAFc=;
 b=DAIimQEqygVnkFih8JEAd1oAbvgh7C7fyFm/XmF4YQYPygCbqO+VB58EHM8aLwcGFd8n+AXUZAy0FFsWdBl+227GcogmsstgLXuWItsGWCNGDYEJHIF9Mti9hOZuhzeg14z7XJpoq04/ZLzO1BnKjVNK/ODOvJ+S1fvAZvMLqKg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB2813.eurprd08.prod.outlook.com (2603:10a6:802:1b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 22 May
 2020 16:20:05 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%6]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 16:20:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 2/3] block: declare some coroutine functions in
 block/coroutines.h
Date: Fri, 22 May 2020 19:19:49 +0300
Message-Id: <20200522161950.2839-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200522161950.2839-1-vsementsov@virtuozzo.com>
References: <20200522161950.2839-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0177.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::46) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 AM0PR01CA0177.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend
 Transport; Fri, 22 May 2020 16:20:04 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7ee84e5-b132-481a-04fc-08d7fe6bfcb5
X-MS-TrafficTypeDiagnostic: VI1PR08MB2813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB28132A926CAF93F61BCD2D50C1B40@VI1PR08MB2813.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3PHVRa1XzGeqwmrTfwTESZaUJ4Jm1VLW0uF3FNyD5cK5sCMoXW5zV2TomJOLq3fY86BM1iSm/aWArEtdE6ekemq00GW+sCe63aziO9eoejUaudrQ0PoNqdPx4NAEBeyAi77awXAuJtoxSEPbB/VFwkQ8yLeDGy31rkK+2GttuY3f4EtmosOcZ01rDGDIryafMVKXG8yM3c6HYOEIyU7vZusQEy3o3NakcvZrv9QdLRdDeHgAm2jOImop1VZR154EsgFs551kCd8L5Vx1nzcI/yKnkW70VWu45k1ZoCpktu80VO8a304zchXPVjTeTbttHrLF7bgLHeG6uTzbfOFjo8MvUMOdZrodlFWiwgaMQFhsd8qN1zslbsmeAQ4YgRCHQGIkd+WJOC4QmJqpNpCuM+RqSB/ZHeRswQaNSy6dCgEORKfdOwqv58i2rzgWx4r9TQIFsXeUaQ4jo9oJzo3/fOx3t0waRZSG7uCAIScGfJFC0TcT0bdSrYiuu8q9NuC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(186003)(1076003)(52116002)(26005)(6486002)(16526019)(2906002)(5660300002)(86362001)(8676002)(69590400007)(6916009)(4326008)(66556008)(6506007)(36756003)(478600001)(107886003)(316002)(66946007)(8936002)(6666004)(66476007)(6512007)(2616005)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: J2ZZ8cwdzNAQVS6E21WKzQub6+DGCDpBvsJfBQIvwfjhKL3OJpMeh7ekvGEJ29WlY+r6zHM9WVO3QQLLzcmM8gfbfkIPcMtT3QqRXL0Z+osVGHaCXWT6fLrPHyKSPbjt2KTBr0aWtCdExRe9+OhcIfE+A9MyMco25Lmze1nwbflwqPH4hTULjzmdWWw5LcM5sK0l6NIm86xUDwXzAvT7IZYYce+fu5JErx3WBY6l8L10L4d/aJIjUXkz+a3Tsf/ep8T3/obd7ubnYFCOV6UcLVWuuTb7XErs2ZTM2MaQbN0Pg16ZhZDXtFr3M1O76GExHDWwuuP5TJ3DUfqR6jZPzzAOfoEve3OSa2s9oifeanSGZWuXzFqCPuZTyhDNocrpkkj66mfEWYEv5IXVL5GuKk6Q3rmguqLekRmKTIjnbmLKGeVcbnVyATtTJneDqkMhM+QTC3M+2KQaOmyC+jeH1BWdFmbxjEctt7pNzjTJe84=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ee84e5-b132-481a-04fc-08d7fe6bfcb5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 16:20:05.2594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUJ+7wwImwBkWMkqcnA7INGqjaNtRwWknsUEPTsoVwqn90MHTUV9348yKDEY3BOorhj5xK+jh50rf/rWeaPGr1+rFsvdQL4dmjz+oV+fJ7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2813
Received-SPF: pass client-ip=40.107.14.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 12:20:04
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

We are going to keep coroutine-wrappers code (structure-packing
parameters, BDRV_POLL wrapper functions) in a separate auto-generated
files. So, we'll need a header with declaration of original _co_
functions, for those which are static now. As well, we'll need
declarations for wrapper functions. Do these declarations now, as a
preparation step.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/coroutines.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 block.c            |  8 ++++----
 block/io.c         | 34 +++++++++++++++++-----------------
 3 files changed, 64 insertions(+), 21 deletions(-)
 create mode 100644 block/coroutines.h

diff --git a/block/coroutines.h b/block/coroutines.h
new file mode 100644
index 0000000000..23ea6fd5b3
--- /dev/null
+++ b/block/coroutines.h
@@ -0,0 +1,43 @@
+#ifndef BLOCK_COROUTINES_INT_H
+#define BLOCK_COROUTINES_INT_H
+
+#include "block/block_int.h"
+
+int coroutine_fn bdrv_co_check(BlockDriverState *bs,
+                               BdrvCheckResult *res, BdrvCheckMode fix);
+void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp);
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
index 8416376c9b..7f06e82880 100644
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
 
-static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
-                                                  Error **errp)
+void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
 {
     BdrvChild *child, *parent;
     uint64_t perm, shared_perm;
diff --git a/block/io.c b/block/io.c
index bd00a70b47..f5b6ce3bf6 100644
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
@@ -900,9 +901,9 @@ typedef struct RwCo {
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
@@ -923,9 +924,9 @@ static void coroutine_fn bdrv_rw_co_entry(void *opaque)
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
     Coroutine *co;
     RwCo rwco = {
@@ -2446,7 +2447,7 @@ early_out:
     return ret;
 }
 
-static int coroutine_fn
+int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   BlockDriverState *base,
                                   bool want_zero,
@@ -2506,12 +2507,12 @@ static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
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
     Coroutine *co;
     BdrvCoBlockStatusData data = {
@@ -2638,7 +2639,7 @@ typedef struct BdrvVmstateCo {
     int                 ret;
 } BdrvVmstateCo;
 
-static int coroutine_fn
+int coroutine_fn
 bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read)
 {
@@ -2670,9 +2671,8 @@ static void coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
     aio_wait_kick();
 }
 
-static inline int
-bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
-                bool is_read)
+int bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
+                    bool is_read)
 {
     if (qemu_in_coroutine()) {
         return bdrv_co_rw_vmstate(bs, qiov, pos, is_read);
-- 
2.21.0


