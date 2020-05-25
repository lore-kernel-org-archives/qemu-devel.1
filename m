Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D659C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DA3207FB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="c4BS2Nb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DA3207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdA5t-0007O4-AA
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 06:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jdA2t-0001uh-0C; Mon, 25 May 2020 06:09:23 -0400
Received: from mail-am6eur05on2108.outbound.protection.outlook.com
 ([40.107.22.108]:58945 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jdA2q-0003zD-OP; Mon, 25 May 2020 06:09:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRr2IKr5qc/zO81Sv2fEN89LCs+4SvE0iGGBOzBZyOi0ZQTCInXGIFMwf0HCn/bFR40e19uANQ5ikiTX4vYYEjNywU3/XbaxeuUKJsKgsQagT59Sue/FqBsO5VvXFyFhQABVRRhto4WhFef3kJKHqwsRgIOCYew1R38lGf8/QZhHMLj/zaKQoNcUer9kuhIDXl65hSqMpaWxaoSYVeEdjy7GC91dWOHxvHNomTAFQfscUFiqonWnwWRYGk92K1GLcNpcMnBq68dvRZilBx0RkHSGEqsCPCP9KDdpL+FfjadtO8CutTxiPncMPx+oCsLUUxaDYCxiw3+LzF3AaV3lgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipfpRMpr+2IP+VFEVHCUdDjNAzMpc1C2taSBuzNlLeM=;
 b=nroyzDJsJms5mKrX1snxaFIlW00DXKAkLQ9YFlaGiyK84wQvamwYiQ0MxIhnOT2PLDHnfdVHL7Syzr21drSXwglu9wW0O1/MuCbvkX/T+3ltEpxpnyMjzS9Or1SpgD7FL1X55etVqjW9poErHJF4Eb5hu3/gNA3W+kYHDAN3UmQFFmgvXkhvzA4kT1G4o5EoDElKgNGBztjUIlL+pIylmv2Q72NO5pmuDCF1Qtyhr8i1E1vTJwdB6diuH1zuz6kt/PUIBA6egy4DGuyCWSOLODt0G3TRdTVYU5JVDp4KCVSPMcugZ8nTuUwJi1L09jR+b8KmPnHTm2B3aD/AJMLRDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipfpRMpr+2IP+VFEVHCUdDjNAzMpc1C2taSBuzNlLeM=;
 b=c4BS2Nb5Zz+11/sRJfEOu8eF7XXZ8EuXkLayyNO5kRgClVsbSH/hqH75Py4NmPCsS4cszyMK75OyVGRvzGDwzcDwPK6rF834gXQBa9sQ+7vZwDN3hgt4417a20xRUaJKFWh9wEtWUxM5XwPTXGfYc72HAcsb+TGTi37l13oa9Lk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5464.eurprd08.prod.outlook.com (2603:10a6:20b:10a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 10:09:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 10:09:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 3/5] block: generate coroutine-wrapper code
Date: Mon, 25 May 2020 13:07:59 +0300
Message-Id: <20200525100801.13859-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200525100801.13859-1-vsementsov@virtuozzo.com>
References: <20200525100801.13859-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.147) by
 AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 10:09:12 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d752cd47-9a4c-408a-5528-08d80093acad
X-MS-TrafficTypeDiagnostic: AM7PR08MB5464:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB546493088A98A858FAC14BC2C1B30@AM7PR08MB5464.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASwQyyS5cjShT5fLwEtcV6UNC59m0IgK17/igFuDnO4jx2Ieu6prSTiVlCjRQQp8Og+k6Wx/gm7B8Sp3Srvha4/UAyFwnL+6aDmH5gtSgVbOzHNOAs9GiKAmUgWQv2jUxfM+4FFW6Ib1kphkxSHYMtBPpUZdT1phnlYgGNz4aGE5vnruWQVmG88qRuNVp2GbHs2ZOFED+Ht+Z9FxD+JwOK8Bmzis2DPial3ewwsB8VAnyWNyWcvIcJEnVE3kt6vZwlnJbaOFeG52YqUHUYukINbeg2TRICsOg34ZZeiB2Lz7dchWbRmVYFuD8zp8ZgJK+9AYJP3SWH4CynraUG87t0ya139R3IeZ/RfsBq2+9alAocmg9SvOIAdKt9cdFU+Mooy4/iYc5aDU8eNh96M6bCDiDTd7bTmvmyf1iGv/3IkjPYmQQeIz3tgfhtsSytiZVYPLm1rI5WuTUQ6Y6DrmMd1/N7JlS9CgDCxmgKoa5hI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39840400004)(376002)(366004)(136003)(6666004)(6486002)(1076003)(316002)(52116002)(26005)(69590400007)(6916009)(6512007)(478600001)(107886003)(8676002)(6506007)(2616005)(8936002)(86362001)(16526019)(186003)(36756003)(2906002)(66556008)(66946007)(4326008)(5660300002)(66476007)(30864003)(956004)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zHAUh2IO2ETruTmEVr64b++rY9pdfgIA2Bpq0pAImIwR5ZmkniogpAs/srEjxrKD8j3iZibEVQxwFj3OCe4rehByiQ/RcHkvlz9vVwVlGtY3Hn7QDwEjMy2dy3U+YYATYz1NMBEa1yAdkWp/nqJdQ/4CTU3VuwUxk6l3le5OfwQzwsj+htSEUMxWAOoyIektuONU2V3YwKl5egu+bqvz0P9zO5jEP7xK4sb71UISC1Qqb9KbRHdfjOKyDBd5pYaTAt6xLdozDV2agvLTpORhePhPeC39jYWMnsNl19Tq2VsSWpfjzUQU05Ur5Fd92Ok1kHEM79KEPMvBOswRdjbJb37gz0yLNoyCW955ChHVt8D80KW7hVIB5d0TqPHTvi+TC4s2MiNyMflbYxxkWJU9sh1kJT3WUt8yH2c6E548W83X3+3JDNM/2lUNp7HKwr3HAyc2KYJtbuYyn+WbpCJwHrAeU1i8iLCauUdchDcZL+E=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d752cd47-9a4c-408a-5528-08d80093acad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 10:09:13.3075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwLMA2PmwIK1foI9YU5UvRC1Uej7nKYH/mWFvC8GoYiIPlSkD1XZOnGyPmOn/+F0ZxjUK4WChJHHZV2ffRzKelk3WSXGsHThTnyMwCTVecY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5464
Received-SPF: pass client-ip=40.107.22.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 06:09:15
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a very frequent pattern of creating coroutine from function
with several arguments:

  - create structure to pack parameters
  - create _entry function to call original function taking parameters
    from struct
  - do different magic to handle completion: set ret to NOT_DONE or
    EINPROGRESS, use separate bool for void functions
  - fill the struct and create coroutine from _entry function and this
    struct as a parameter
  - do coroutine enter and BDRV_POLL_WHILE loop

Let's reduce code duplication. Here:

Functional part (BDRV_POLL_WHILE loop, aio_wait_kick()) moved to
(non-generated) block/block-gen.h

Mechanical part (arguments packing, different kind of needed wrappers)
are generated from template by scripts/coroutine-wrapper.py to
resulting file block/block-gen.c

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 Makefile                             |   6 +
 Makefile.objs                        |   2 +-
 block/block-gen.h                    |  55 ++++++
 block/coroutines.h                   |   7 +-
 include/block/block.h                |  17 +-
 include/block/generated-co-wrapper.h |  35 ++++
 block.c                              |  70 --------
 block/io.c                           | 260 ---------------------------
 block/Makefile.objs                  |   1 +
 scripts/coroutine-wrapper.py         | 168 +++++++++++++++++
 10 files changed, 281 insertions(+), 340 deletions(-)
 create mode 100644 block/block-gen.h
 create mode 100644 include/block/generated-co-wrapper.h
 create mode 100755 scripts/coroutine-wrapper.py

diff --git a/Makefile b/Makefile
index 40e4f7677b..ec15b8ea89 100644
--- a/Makefile
+++ b/Makefile
@@ -159,6 +159,8 @@ generated-files-$(CONFIG_TRACE_UST) += trace-ust-all.c
 
 generated-files-y += module_block.h
 
+generated-files-y += block/block-gen.c
+
 TRACE_HEADERS = trace-root.h $(trace-events-subdirs:%=%/trace.h)
 TRACE_SOURCES = trace-root.c $(trace-events-subdirs:%=%/trace.c)
 TRACE_DTRACE =
@@ -175,6 +177,10 @@ generated-files-y += $(TRACE_SOURCES)
 generated-files-y += $(BUILD_DIR)/trace-events-all
 generated-files-y += .git-submodule-status
 
+COROUTINE_HEADERS = include/block/block.h block/coroutines.h
+block/block-gen.c: $(COROUTINE_HEADERS) $(SRC_PATH)/scripts/coroutine-wrapper.py
+	$(call quiet-command, cat $(COROUTINE_HEADERS) | $(SRC_PATH)/scripts/coroutine-wrapper.py > $@,"GEN","$(TARGET_DIR)$@")
+
 trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
 
 tracetool-y = $(SRC_PATH)/scripts/tracetool.py
diff --git a/Makefile.objs b/Makefile.objs
index 99774cfd25..8cb20f94c3 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -14,7 +14,7 @@ chardev-obj-y = chardev/
 authz-obj-y = authz/
 
 block-obj-y = block/ block/monitor/ nbd/ scsi/
-block-obj-y += block.o blockjob.o job.o
+block-obj-y += block.o blockjob.o job.o block/block-gen.o
 block-obj-y += qemu-io-cmds.o
 block-obj-$(CONFIG_REPLICATION) += replication.o
 
diff --git a/block/block-gen.h b/block/block-gen.h
new file mode 100644
index 0000000000..11a44247b7
--- /dev/null
+++ b/block/block-gen.h
@@ -0,0 +1,55 @@
+/*
+ * Block layer I/O functions
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ * Copyright (c) 2020 Virtuozzo International GmbH
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
+#ifndef BLOCK_BLOCK_GEN_H
+#define BLOCK_BLOCK_GEN_H
+
+#include "block/block_int.h"
+
+/* This function is called at the end of generated coroutine entries. */
+static inline void bdrv_poll_co__on_exit(void)
+{
+    aio_wait_kick();
+}
+
+/* Base structure for argument packing structures */
+typedef struct BdrvPollCo {
+    BlockDriverState *bs;
+    bool in_progress;
+    int ret;
+    Coroutine *co; /* Keep pointer here for debugging */
+} BdrvPollCo;
+
+static inline int bdrv_poll_co(BdrvPollCo *s)
+{
+    assert(!qemu_in_coroutine());
+
+    bdrv_coroutine_enter(s->bs, s->co);
+    BDRV_POLL_WHILE(s->bs, s->in_progress);
+
+    return s->ret;
+}
+
+#endif /* BLOCK_BLOCK_GEN_H */
diff --git a/block/coroutines.h b/block/coroutines.h
index 74278cfef2..e2047697d6 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -26,6 +26,7 @@
 #define BLOCK_COROUTINES_INT_H
 
 #include "block/block_int.h"
+#include "block/generated-co-wrapper.h"
 
 int coroutine_fn bdrv_co_check(BlockDriverState *bs,
                                BdrvCheckResult *res, BdrvCheckMode fix);
@@ -34,7 +35,7 @@ void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp);
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
index 25e299605e..aed6ffcc4f 100644
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
-void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
+void generated_co_wrapper bdrv_invalidate_cache(BlockDriverState *bs,
+                                                Error **errp);
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
diff --git a/include/block/generated-co-wrapper.h b/include/block/generated-co-wrapper.h
new file mode 100644
index 0000000000..62c6e053ba
--- /dev/null
+++ b/include/block/generated-co-wrapper.h
@@ -0,0 +1,35 @@
+/*
+ * Block layer I/O functions
+ *
+ * Copyright (c) 2020 Virtuozzo International GmbH
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
+#ifndef BLOCK_GENERATED_CO_WRAPPER_H
+#define BLOCK_GENERATED_CO_WRAPPER_H
+
+/*
+ * generated_co_wrapper
+ * Function specifier, which does nothing but marking functions to be
+ * generated by scripts/coroutine-wrapper.py
+ */
+#define generated_co_wrapper
+
+#endif /* BLOCK_GENERATED_CO_WRAPPER_H */
diff --git a/block.c b/block.c
index 7f06e82880..c1132ab323 100644
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
@@ -5721,39 +5684,6 @@ void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
     }
 }
 
-typedef struct InvalidateCacheCo {
-    BlockDriverState *bs;
-    Error **errp;
-    bool done;
-} InvalidateCacheCo;
-
-static void coroutine_fn bdrv_invalidate_cache_co_entry(void *opaque)
-{
-    InvalidateCacheCo *ico = opaque;
-    bdrv_co_invalidate_cache(ico->bs, ico->errp);
-    ico->done = true;
-    aio_wait_kick();
-}
-
-void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
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
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 3635b6b4c1..05e4d033c1 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -45,6 +45,7 @@ block-obj-y += crypto.o
 block-obj-y += aio_task.o
 block-obj-y += backup-top.o
 block-obj-y += filter-compress.o
+block-obj-y += block-gen.o
 common-obj-y += monitor/
 
 block-obj-y += stream.o
diff --git a/scripts/coroutine-wrapper.py b/scripts/coroutine-wrapper.py
new file mode 100755
index 0000000000..72115f7dd8
--- /dev/null
+++ b/scripts/coroutine-wrapper.py
@@ -0,0 +1,168 @@
+#!/usr/bin/env python3
+#
+# Generate coroutine wrappers for block subsystem.
+#
+# Copyright (c) 2020 Virtuozzo International GmbH.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import re
+from typing import List, Iterator
+
+header = '''/*
+ * File is generated by scripts/coroutine-wrapper.py
+ */
+
+#include "qemu/osdep.h"
+#include "block/coroutines.h"
+#include "block/block-gen.h"'''
+
+template = """
+
+/*
+ * Wrappers for $name$
+ */
+
+typedef struct $struct_name$ {
+    BdrvPollCo poll_state;
+    $fields$
+} $struct_name$;
+
+static void coroutine_fn $name$_entry(void *opaque)
+{
+    $struct_name$ *s = opaque;
+
+    $assign_ret$$name$($args_from_s$);
+
+    s->poll_state.in_progress = false;
+
+    bdrv_poll_co__on_exit();
+}
+
+$ret_type$ $wrapper_name$($args_def$)
+{
+    if (qemu_in_coroutine()) {
+        $do_return$$name$($arg_names$);
+    } else {
+        $struct_name$ s = {
+            .poll_state.bs = $bs$,
+            .poll_state.in_progress = true,
+
+            $initializers$
+        };
+
+        s.poll_state.co = qemu_coroutine_create($name$_entry, &s);
+
+        $do_return$bdrv_poll_co(&s.poll_state);
+    }
+}"""
+
+# We want to use python string.format() formatter, which uses curly brackets
+# as separators. But it's not comfortable with C. So, we used dollars instead,
+# and now is the time to escape curly brackets and convert dollars.
+template = template.replace('{', '{{').replace('}', '}}')
+template = re.sub(r'\$(\w+)\$', r'{\1}', template)
+
+
+class ParamDecl:
+    param_re = re.compile(r'(?P<decl>'
+                          r'(?P<type>.*[ *])'
+                          r'(?P<name>[a-z][a-z0-9_]*)'
+                          r')')
+
+    def __init__(self, param_decl: str) -> None:
+        m = self.param_re.match(param_decl.strip())
+        self.decl = m.group('decl')
+        self.type = m.group('type')
+        self.name = m.group('name')
+
+
+class FuncDecl:
+    def __init__(self, return_type: str, name: str, args: str) -> None:
+        self.return_type = return_type.strip()
+        self.name = name.strip()
+        self.args: List[ParamDecl] = []
+        self.args = [ParamDecl(arg) for arg in args.split(',')]
+
+    def get_args_decl(self) -> str:
+        return ', '.join(arg.decl for arg in self.args)
+
+    def get_arg_names(self) -> str:
+        return ', '.join(arg.name for arg in self.args)
+
+    def gen_struct_fields(self) -> str:
+        return '\n    '.join(f'{arg.decl};' for arg in self.args)
+
+    def gen_struct_initializers(self, indent: int) -> str:
+        sep = '\n' + ' ' * indent
+        return sep.join(f'.{a.name} = {a.name},' for a in self.args)
+
+
+# Match wrappers declaration, with generated_co_wrapper mark
+func_decl_re = re.compile(r'^(?P<return_type>(int|void))'
+                          r'\s*generated_co_wrapper\s*'
+                          r'(?P<wrapper_name>[a-z][a-z0-9_]*)'
+                          r'\((?P<args>[^)]*)\);$', re.MULTILINE)
+
+
+def func_decl_iter(text: str) -> Iterator:
+    for m in func_decl_re.finditer(text):
+        yield FuncDecl(return_type=m.group('return_type'),
+                       name=m.group('wrapper_name'),
+                       args=m.group('args'))
+
+
+def struct_name(func_name: str) -> str:
+    """some_function_name -> SomeFunctionName"""
+    words = func_name.split('_')
+    words = [w[0].upper() + w[1:] for w in words]
+    return ''.join(words)
+
+
+def make_wrapper(func: FuncDecl) -> str:
+    assert func.name.startswith('bdrv_')
+    co_name = 'bdrv_co_' + func.name[5:]
+
+    has_ret = func.return_type != 'void'
+
+    params = {
+        'name': co_name,
+        'do_return': 'return ' if has_ret else '',
+        'assign_ret': 's->poll_state.ret = ' if has_ret else '',
+        'struct_name': struct_name(co_name),
+        'wrapper_name': func.name,
+        'ret_type': func.return_type,
+        'args_def': func.get_args_decl(),
+        'arg_names': func.get_arg_names(),
+        'fields': func.gen_struct_fields(),
+        'initializers': func.gen_struct_initializers(12),
+        'args_from_s': ', '.join(f's->{a.name}' for a in func.args),
+    }
+
+    if func.args[0].type == 'BlockDriverState *':
+        params['bs'] = 'bs'
+    else:
+        assert func.args[0].type == 'BdrvChild *'
+        params['bs'] = 'child->bs'
+
+    return template.format(**params)
+
+
+if __name__ == '__main__':
+    import sys
+
+    print(header)
+    for func in func_decl_iter(sys.stdin.read()):
+        print(make_wrapper(func))
-- 
2.21.0


