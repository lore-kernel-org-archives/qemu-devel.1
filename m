Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8D8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D293A2072C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PVUSlgLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D293A2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbQ2y-0004nG-VI
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbQ27-0003RJ-Uh; Wed, 20 May 2020 10:49:23 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com
 ([40.107.8.134]:53643 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbQ25-0003F7-0H; Wed, 20 May 2020 10:49:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBxz7itjB0WW0b/XF6kB7tTnuOgyLpo9wpOXn6BwIkCkj28gTinKUhi8Pnr97RviM5HaXqFj//3zHXuAB06MyCWVWW/Lg5Esql2RCCwJLTzHeDSrp1T6oajF67zmyvYShaGHrBqOJhIscoFD16e7SmZIZlFJvpS0uaYbes1SPxZQDJsZGe0s8Z85Ka3NQ5nGm6N1iKgx4gf49ayXOkuExnXvAA0d3dXnnz2LCkHiDQUCl7pSDarXzEd4lbb+pQS8NrzswdvqtfknS9ZbA0GM7OkPSQTMcRogDRT0UYRTFSp9UpvQZ+ZAOhLteYzhPzHqk7ptHoe2prf0YP+y9BWHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdNMAxL87wBHu+UYVh/lImHRi5Q2gvzbM6xszZvBim0=;
 b=isdO2QcGTksvt37ECbyGHAL9QZNOUH6X/Vubge4DJnArxoKBqzsKMR3ouZTgTWzPInSdo1XcL+m+OfFbU/+GIlLzNKo/kB/1bcecWTxNB6T1/URKzUJDCUcGJEQAPuAxXUJnikTDvxX0ajXHx0P3dqQp/nE+a4lOXGe0AvJ4kdmzyhi+1XDUk6sfdTcsBeSf8Uwj8VaaYVa8TH7AY26BmldTXqgSyNvEL7sxfJdFMGVxnkJ3ypm5O8yzcL3YAq5IP8i6f2NKtNaEVIU3EU97r/Guz/hIymekSrKgRWxFW6LMw/QSrsUUToRbzkzxOnBrjCcbUO/XmlZqnWwxceEBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdNMAxL87wBHu+UYVh/lImHRi5Q2gvzbM6xszZvBim0=;
 b=PVUSlgLB6Cejr0CzFXYZfwWLeTKTe1fTOde1n3UOw4xpSQ1muDH+U47OQaiPXM72aAheiuIuvIj/M2O9WiylMN4WBZJv4fp49hkDL6Hg/ks/X1eTw2hWv+4/Pi0hfoRFFZ3lCrpWJaYgHBQWGXyPCMGTkRiOg++MitOWNYATRqs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5304.eurprd08.prod.outlook.com (2603:10a6:20b:10e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 20 May
 2020 14:49:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 14:49:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3] block: Factor out bdrv_run_co()
Date: Wed, 20 May 2020 17:49:01 +0300
Message-Id: <20200520144901.16589-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0126.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.147) by
 AM0PR10CA0126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24 via Frontend Transport; Wed, 20 May 2020 14:49:14 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8eabea3-c651-4427-f95e-08d7fcccf7bb
X-MS-TrafficTypeDiagnostic: AM7PR08MB5304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53045DAD07AF0DC031F81B80C1B60@AM7PR08MB5304.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0MGDJWBw4+JIa/NbdHx10mOMAfhZ47jGqwyCuqDhL1s70Xbettnky2t/LQcK6UT7iR1PUDbYYurofh4XsH2X2OMWdyU3bWaKb8ymz5TCSbIB1aNeui0SHcpcdSIbW6fy20h679ZK3niy9lBosjlt/xNSlgizSKoFRX0WhIGcJSW9gR9taWBBXK5vEoolDX6grib4Uh2SBT0CoFSBxK3CswlbVf0NDLwdUINTAeQq4Yw4o7NnX9TcVrhpQpm/ImkY430YFVAy3UTFc4RO10wELBCk8XUD0G1U6xcHO9nmxYZOaPsi5kTWwUgag9SVXQI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39850400004)(2616005)(6506007)(36756003)(5660300002)(956004)(186003)(16526019)(478600001)(8936002)(4326008)(2906002)(26005)(316002)(6916009)(66556008)(66946007)(66476007)(6512007)(1076003)(107886003)(52116002)(86362001)(8676002)(6666004)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: llNboUiiDf9kkLSNESvyfD5zxaBOFfczGtUZFEwVrdBUI7fyUcSHsX9tqYZnKFgfSHYUTxo4sny3yNLSbXyxDGL3pnsCzNuBYb2kQJQGQIBNpTnXq7WZxlmtVpDhDQfZC6YOKXS/T2QQWzWXNg54yB5BlXkgQ63Pes1EsBDgai5cdu+EvVkEOc8KHKNFInqdSNY1AMkRBokC9eG2dQlJm+brq1v27dMLpHjEqzNIZe3yHRAZy5YPjq8Z/GbwX0J/AR7J4YZddZDvrlGwOhfXA5l9aAG7qgc7lwnDaQu6KlH5gagtIMuyHTusgUwte5IOfC2Bzi3i6Hva1eURr/pItCakq1gSFkzFCnEW4f5EhO+fCL9cJFWfxOkV2W1jRXHWRwxdUY6whiofloyfoCH2TnuxaqUUDeOYno0GQ3i9uZH1C9/deHiBWv6vIL/mXrfrP7lTspodoBuanQjIEtPlOqpGLhVZ0fP9Z/+XhjP53Q6vTBF1hKZV85nuvElyWgsq
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8eabea3-c651-4427-f95e-08d7fcccf7bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 14:49:15.8413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkS8PAIhuWRQ/3ps++wH//8pqC144cMNOCkD8j2kekqBtctj937+llu5si8atHkL1who54E4RBpTVIyid1OgFlocAQ60ZFcbT5p8HtaSO4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5304
Received-SPF: pass client-ip=40.107.8.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 10:49:17
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
 philmd@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a few bdrv_*() functions that can either spawn a new coroutine
and wait for it with BDRV_POLL_WHILE() or use a fastpath if they are
alreeady running in a coroutine. All of them duplicate basically the
same code.

Factor the common code into a new function bdrv_run_co().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
   [Factor out bdrv_run_co_entry too]
---

v3: keep created coroutine in BdrvRunCo struct for debugging [Kevin]

 block/io.c | 193 ++++++++++++++++++++---------------------------------
 1 file changed, 72 insertions(+), 121 deletions(-)

diff --git a/block/io.c b/block/io.c
index 121ce17a49..df8f2a98d4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -35,8 +35,6 @@
 #include "qemu/main-loop.h"
 #include "sysemu/replay.h"
 
-#define NOT_DONE 0x7fffffff /* used while emulated sync operation in progress */
-
 /* Maximum bounce buffer for copy-on-read and write zeroes, in bytes */
 #define MAX_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
 
@@ -891,29 +889,63 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
+typedef int coroutine_fn BdrvRequestEntry(void *opaque);
+typedef struct BdrvRunCo {
+    BdrvRequestEntry *entry;
+    void *opaque;
+    int ret;
+    bool done;
+    Coroutine *co; /* Coroutine, running bdrv_run_co_entry, for debugging */
+} BdrvRunCo;
+
+static void coroutine_fn bdrv_run_co_entry(void *opaque)
+{
+    BdrvRunCo *arg = opaque;
+
+    arg->ret = arg->entry(arg->opaque);
+    arg->done = true;
+    aio_wait_kick();
+}
+
+static int bdrv_run_co(BlockDriverState *bs, BdrvRequestEntry *entry,
+                       void *opaque)
+{
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        return entry(opaque);
+    } else {
+        BdrvRunCo s = { .entry = entry, .opaque = opaque };
+
+        s.co = qemu_coroutine_create(bdrv_run_co_entry, &s);
+        bdrv_coroutine_enter(bs, s.co);
+
+        BDRV_POLL_WHILE(bs, !s.done);
+
+        return s.ret;
+    }
+}
+
 typedef struct RwCo {
     BdrvChild *child;
     int64_t offset;
     QEMUIOVector *qiov;
     bool is_write;
-    int ret;
     BdrvRequestFlags flags;
 } RwCo;
 
-static void coroutine_fn bdrv_rw_co_entry(void *opaque)
+static int coroutine_fn bdrv_rw_co_entry(void *opaque)
 {
     RwCo *rwco = opaque;
 
     if (!rwco->is_write) {
-        rwco->ret = bdrv_co_preadv(rwco->child, rwco->offset,
-                                   rwco->qiov->size, rwco->qiov,
-                                   rwco->flags);
+        return bdrv_co_preadv(rwco->child, rwco->offset,
+                              rwco->qiov->size, rwco->qiov,
+                              rwco->flags);
     } else {
-        rwco->ret = bdrv_co_pwritev(rwco->child, rwco->offset,
-                                    rwco->qiov->size, rwco->qiov,
-                                    rwco->flags);
+        return bdrv_co_pwritev(rwco->child, rwco->offset,
+                               rwco->qiov->size, rwco->qiov,
+                               rwco->flags);
     }
-    aio_wait_kick();
 }
 
 /*
@@ -923,25 +955,15 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
                         QEMUIOVector *qiov, bool is_write,
                         BdrvRequestFlags flags)
 {
-    Coroutine *co;
     RwCo rwco = {
         .child = child,
         .offset = offset,
         .qiov = qiov,
         .is_write = is_write,
-        .ret = NOT_DONE,
         .flags = flags,
     };
 
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_rw_co_entry(&rwco);
-    } else {
-        co = qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
-        bdrv_coroutine_enter(child->bs, co);
-        BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
-    }
-    return rwco.ret;
+    return bdrv_run_co(child->bs, bdrv_rw_co_entry, &rwco);
 }
 
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
@@ -2229,8 +2251,6 @@ typedef struct BdrvCoBlockStatusData {
     int64_t *pnum;
     int64_t *map;
     BlockDriverState **file;
-    int ret;
-    bool done;
 } BdrvCoBlockStatusData;
 
 int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
@@ -2484,16 +2504,14 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
 }
 
 /* Coroutine wrapper for bdrv_block_status_above() */
-static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
+static int coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
 {
     BdrvCoBlockStatusData *data = opaque;
 
-    data->ret = bdrv_co_block_status_above(data->bs, data->base,
-                                           data->want_zero,
-                                           data->offset, data->bytes,
-                                           data->pnum, data->map, data->file);
-    data->done = true;
-    aio_wait_kick();
+    return bdrv_co_block_status_above(data->bs, data->base,
+                                      data->want_zero,
+                                      data->offset, data->bytes,
+                                      data->pnum, data->map, data->file);
 }
 
 /*
@@ -2508,7 +2526,6 @@ static int bdrv_common_block_status_above(BlockDriverState *bs,
                                           int64_t *map,
                                           BlockDriverState **file)
 {
-    Coroutine *co;
     BdrvCoBlockStatusData data = {
         .bs = bs,
         .base = base,
@@ -2518,18 +2535,9 @@ static int bdrv_common_block_status_above(BlockDriverState *bs,
         .pnum = pnum,
         .map = map,
         .file = file,
-        .done = false,
     };
 
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_block_status_above_co_entry(&data);
-    } else {
-        co = qemu_coroutine_create(bdrv_block_status_above_co_entry, &data);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, !data.done);
-    }
-    return data.ret;
+    return bdrv_run_co(bs, bdrv_block_status_above_co_entry, &data);
 }
 
 int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
@@ -2630,7 +2638,6 @@ typedef struct BdrvVmstateCo {
     QEMUIOVector        *qiov;
     int64_t             pos;
     bool                is_read;
-    int                 ret;
 } BdrvVmstateCo;
 
 static int coroutine_fn
@@ -2658,33 +2665,25 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
     return ret;
 }
 
-static void coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
+static int coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
 {
     BdrvVmstateCo *co = opaque;
-    co->ret = bdrv_co_rw_vmstate(co->bs, co->qiov, co->pos, co->is_read);
-    aio_wait_kick();
+
+    return bdrv_co_rw_vmstate(co->bs, co->qiov, co->pos, co->is_read);
 }
 
 static inline int
 bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                 bool is_read)
 {
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
+    BdrvVmstateCo data = {
+        .bs         = bs,
+        .qiov       = qiov,
+        .pos        = pos,
+        .is_read    = is_read,
+    };
 
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, data.ret == -EINPROGRESS);
-        return data.ret;
-    }
+    return bdrv_run_co(bs, bdrv_co_rw_vmstate_entry, &data);
 }
 
 int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
@@ -2762,18 +2761,9 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb)
 /**************************************************************/
 /* Coroutine block device emulation */
 
-typedef struct FlushCo {
-    BlockDriverState *bs;
-    int ret;
-} FlushCo;
-
-
-static void coroutine_fn bdrv_flush_co_entry(void *opaque)
+static int coroutine_fn bdrv_flush_co_entry(void *opaque)
 {
-    FlushCo *rwco = opaque;
-
-    rwco->ret = bdrv_co_flush(rwco->bs);
-    aio_wait_kick();
+    return bdrv_co_flush(opaque);
 }
 
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
@@ -2890,36 +2880,20 @@ early_exit:
 
 int bdrv_flush(BlockDriverState *bs)
 {
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
+    return bdrv_run_co(bs, bdrv_flush_co_entry, bs);
 }
 
 typedef struct DiscardCo {
     BdrvChild *child;
     int64_t offset;
     int64_t bytes;
-    int ret;
 } DiscardCo;
-static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
+
+static int coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
 {
     DiscardCo *rwco = opaque;
 
-    rwco->ret = bdrv_co_pdiscard(rwco->child, rwco->offset, rwco->bytes);
-    aio_wait_kick();
+    return bdrv_co_pdiscard(rwco->child, rwco->offset, rwco->bytes);
 }
 
 int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
@@ -3038,24 +3012,13 @@ out:
 
 int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
 {
-    Coroutine *co;
     DiscardCo rwco = {
         .child = child,
         .offset = offset,
         .bytes = bytes,
-        .ret = NOT_DONE,
     };
 
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
+    return bdrv_run_co(child->bs, bdrv_pdiscard_co_entry, &rwco);
 }
 
 int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf)
@@ -3463,21 +3426,19 @@ typedef struct TruncateCo {
     PreallocMode prealloc;
     BdrvRequestFlags flags;
     Error **errp;
-    int ret;
 } TruncateCo;
 
-static void coroutine_fn bdrv_truncate_co_entry(void *opaque)
+static int coroutine_fn bdrv_truncate_co_entry(void *opaque)
 {
     TruncateCo *tco = opaque;
-    tco->ret = bdrv_co_truncate(tco->child, tco->offset, tco->exact,
-                                tco->prealloc, tco->flags, tco->errp);
-    aio_wait_kick();
+
+    return bdrv_co_truncate(tco->child, tco->offset, tco->exact,
+                            tco->prealloc, tco->flags, tco->errp);
 }
 
 int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
                   PreallocMode prealloc, BdrvRequestFlags flags, Error **errp)
 {
-    Coroutine *co;
     TruncateCo tco = {
         .child      = child,
         .offset     = offset,
@@ -3485,17 +3446,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
         .prealloc   = prealloc,
         .flags      = flags,
         .errp       = errp,
-        .ret        = NOT_DONE,
     };
 
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
+    return bdrv_run_co(child->bs, bdrv_truncate_co_entry, &tco);
 }
-- 
2.21.0


