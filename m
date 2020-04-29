Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6FFC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B807321775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fK8a2ZwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B807321775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTma6-0007GR-Tb
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 09:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTmVB-00083j-Sg
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTmV2-000865-VU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:11:49 -0400
Received: from mail-eopbgr80118.outbound.protection.outlook.com
 ([40.107.8.118]:18917 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTmSp-0007bZ-5L; Wed, 29 Apr 2020 09:09:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvZ7KQbbg8nJGGxKPNVyBtnkvDFlcssYLi6m+A85dQHjfffuwrVp3iQnsojUOYJ9tO7TniyNKQtWrqUFvO2Q/RVsOVRG/8NLY3ZQuBFPXZucdjJvI45u982sGrgG8DetiGppa1vvt2l7vzfDt+9M/HLogZPlsuXtOHZLEYzgUauCeQKg1OGw7JL6zJC63fAFn9WP+wZShTq6v0k9WQr7lNtuuSX1hD4V2cBcL2dn/EnPU4/nGAXFe114viyYg+aib8T+lKGA+DAnhhZbKbbQQ+laoY+4ZIeCl8kx4+ZgThqabYw6PaU6phPNppXMCtIiFsa9arB5mZDLIA3GIMHzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQlosi03mxhactT/54a4+buxoex9q2Jrlj5nqM3FiOA=;
 b=AxnA7/JwrzhPLLciHUtzFKwkXwpBR/ImxHiueq35jgC1n2qLcxnq5rWG2ONPpErP2wZyGR5GH66wiQCh6fKVysk9o+tXz7c/0XprDCqlWfp/7YiyEuaH65g3qCvwa0igPWqWdbNpo1QbfuUMx3YDB2lgb22oJ1JNqJtqADcAWp6ZgQNPGBshniOttTZPF4SgW6cFQKXnkaJrZllXf/IEesstWdwGk9mUzMYOW0+wT4ti5Wou1w2V9xQRqfmzV7IYpgAfK1DTPTm3DwjT4V67i54VAf6qG+zYfo5kY8SXJweRcIIj+oAiY1X9B0EPVKPdtiCZ8XA5iiJKUM1en4vTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQlosi03mxhactT/54a4+buxoex9q2Jrlj5nqM3FiOA=;
 b=fK8a2ZwArSH43utvGaI4Vqt4l6bmwCkusqN+7IspV2EVJohD3jOQGC2GWcP6N5PefVFTHRJSB/vZtVKQIa+JX/bqY7gsfGnFqjjPptF0l/QZm1XRpjYFl/IzgSKiok+td08Jy9oGXpxm9MaIfJQ3/w6QM8bPh+1y22lC4zjSox8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5446.eurprd08.prod.outlook.com (2603:10a6:20b:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 13:09:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 13:09:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 5/5] block/block-copy: use aio-task-pool API
Date: Wed, 29 Apr 2020 16:08:47 +0300
Message-Id: <20200429130847.28124-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200429130847.28124-1-vsementsov@virtuozzo.com>
References: <20200429130847.28124-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0031.eurprd04.prod.outlook.com
 (2603:10a6:208:122::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.184) by
 AM0PR04CA0031.eurprd04.prod.outlook.com (2603:10a6:208:122::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Wed, 29 Apr 2020 13:09:17 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bc081e7-9fb6-4227-91ae-08d7ec3e85e2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5446534B880C0E3D23C21D87C1AD0@AM7PR08MB5446.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39840400004)(366004)(396003)(8936002)(16526019)(2616005)(107886003)(6512007)(66946007)(66556008)(66476007)(316002)(36756003)(6486002)(52116002)(5660300002)(186003)(6506007)(26005)(4326008)(956004)(1076003)(69590400007)(478600001)(6666004)(86362001)(2906002)(6916009)(8676002)(334744003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25pV9yH80vJDsvuEHYbreTJCaFLfXGUnpAknOnLPxgGQIsdUNIIA6eMdHtBk8aVq0skFchJpRBt0ZXeXCw+zYidpHGAysYwCg+AGyMqTsaKsuFYr5DSdnOGdDZWuNW0RTBoN5IUZFikQB1Dlbo3ZXJccAuJHvZzdlEpde/NKco9E/Z3uzGq+mVfOtz7jIujWe1pCF1WhF/0c2iko+LE3F9+nMN7bMgyYSRVmB1TBa/2bGRgh/NOKZvY0KeK9VVdkvHmwyLduQA85vyUwYVHb986p5qxUzIB6Pzx0E5zah2JMcrFI9oBwY2ol9dBVuznXpwzL3bT5Btu1MuJmZFjWjjBeva+riePikI2xCrkafidN9KPhhpVEUZC3xKROVfzvJ6E7LjJwF1DzPB46nbXnMIMc9n/1hsPqDGFf7aoJCTsneJbI41ZI2TmtwfGCkOoP7HsZxkmfCgvp+13vykJjmvZHpCs8L212u7HCXYZR+PwupOxRY5mFqbrpJamhGi3H5GSXi4o++du0j43Ga0oAiQ==
X-MS-Exchange-AntiSpam-MessageData: hsbiu3TBmw80CSHjCruFWquyC1ld1rK0IHeI4C6SgcTSdNmc1TP34DnBiCzm1yEN8/Xb3M+fGiClHGmoE2+Bx+TVRNb09wnRQ9gVJIP590ecY57+N1oB0Dfd2kp6bGRfJUGDp8ihmqDiz/msy+9zKoSoznNyXaS+a5FI/lXAxrimYgFueZYyfECENX6ZA33antqqAwOrpZUMXvS5eUTlv1yA7b4XCbyGAgt11KjUZ0uDEHwgFqQZqsQ/NlFDv0ZJ2L1ygFZrOFYB32uAXtE+fivvFA4A+TIcF60u1iOq3fHvkGiwBLjcCoddJcRIZwqvK6QxRH2ynEoku19sdABVPnqUxFj2ndg1/fPyCBqdvfLhXaf3NnVe5mrq9spYd75j2QR51gZvqp9KZ/d9rftEaQe7eTgMGsPUcex5vaxTIYmoNPcaat0w2bfJbq1rNcMdPMVkmFmY3pskpC7+2HsHWNGzg+1DzkNT6NdBPXwNwbWX5P+cu1p2pzdGdnfLryRkRIiyQL6rjaPjmoprNxhI7WSc98/U21CzGk6sMeunVDVnBUrOgkp3A8Ss5NgUtuX3VxtSBuFGXAnVXJ6UUTxeUMUxAAqIu+2OFm4jk2Y/wdoHcCTAmx21VFmg3xH5CrT+PIRM6FfbCTdCGW8K4SaLH/WCdHT6PWBDBU7O0DsRYw33h574jaV4XJKLsXmRDec/whO0AQIayfh4J7Bli2oJ9llA1xHBCtZuwe3sIVOeKb/mQVsoujkWv0+cFZkeEvct9S91OMZcCRsRhI+7eI/KpbhAvA1eoc5Y2vQu4cNu3GA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc081e7-9fb6-4227-91ae-08d7ec3e85e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 13:09:17.6412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eU5BFj+66ANdn2v7ZDGk4hOlH/wgGMZE845ja15EShNhACI4gSlE7F5NExZoKSkmMfYY8H/AK7BXSnoVaFq9nEgX1/GKxWtMtkLnZOQpRGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5446
Received-SPF: pass client-ip=40.107.8.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 09:09:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.8.118
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Run block_copy iterations in parallel in aio tasks.

Changes:
  - BlockCopyTask becomes aio task structure. Add zeroes field to pass
    it to block_copy_do_copy
  - add call state - it's a state of one call of block_copy(), shared
    between parallel tasks. For now used only to keep information about
    first error: is it read or not.
  - convert block_copy_dirty_clusters to aio-task loop.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 119 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 13 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index f560338647..03500680f7 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -19,15 +19,29 @@
 #include "block/block-copy.h"
 #include "sysemu/block-backend.h"
 #include "qemu/units.h"
+#include "qemu/coroutine.h"
+#include "block/aio_task.h"
 
 #define BLOCK_COPY_MAX_COPY_RANGE (16 * MiB)
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
+#define BLOCK_COPY_MAX_WORKERS 64
+
+static coroutine_fn int block_copy_task_entry(AioTask *task);
+
+typedef struct BlockCopyCallState {
+    bool failed;
+    bool error_is_read;
+} BlockCopyCallState;
 
 typedef struct BlockCopyTask {
+    AioTask task;
+
     BlockCopyState *s;
+    BlockCopyCallState *call_state;
     int64_t offset;
     int64_t bytes;
+    bool zeroes;
     QLIST_ENTRY(BlockCopyTask) list;
     CoQueue wait_queue; /* coroutines blocked on this task */
 } BlockCopyTask;
@@ -116,6 +130,7 @@ static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t offset,
  * the beginning of it.
  */
 static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
+                                             BlockCopyCallState *call_state,
                                              int64_t offset, int64_t bytes)
 {
     BlockCopyTask *task;
@@ -135,7 +150,9 @@ static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
 
     task = g_new(BlockCopyTask, 1);
     *task = (BlockCopyTask) {
+        .task.func = block_copy_task_entry,
         .s = s,
+        .call_state = call_state,
         .offset = offset,
         .bytes = bytes,
     };
@@ -263,6 +280,38 @@ void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm)
     s->progress = pm;
 }
 
+/*
+ * Takes ownership of @task
+ *
+ * If pool is NULL directly run the task, otherwise schedule it into the pool.
+ *
+ * Returns: task.func return code if pool is NULL
+ *          otherwise -ECANCELED if pool status is bad
+ *          otherwise 0 (successfully scheduled)
+ */
+static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
+                                            BlockCopyTask *task)
+{
+    if (!pool) {
+        int ret = task->task.func(&task->task);
+
+        g_free(task);
+        return ret;
+    }
+
+    aio_task_pool_wait_slot(pool);
+    if (aio_task_pool_status(pool) < 0) {
+        co_put_to_shres(task->s->mem, task->bytes);
+        block_copy_task_end(task, -ECANCELED);
+        g_free(task);
+        return -ECANCELED;
+    }
+
+    aio_task_pool_start_task(pool, &task->task);
+
+    return 0;
+}
+
 /*
  * block_copy_do_copy
  *
@@ -366,6 +415,27 @@ out:
     return ret;
 }
 
+static coroutine_fn int block_copy_task_entry(AioTask *task)
+{
+    BlockCopyTask *t = container_of(task, BlockCopyTask, task);
+    bool error_is_read;
+    int ret;
+
+    ret = block_copy_do_copy(t->s, t->offset, t->bytes, t->zeroes,
+                             &error_is_read);
+    if (ret < 0 && !t->call_state->failed) {
+        t->call_state->failed = true;
+        t->call_state->error_is_read = error_is_read;
+    } else {
+        progress_work_done(t->s->progress, t->bytes);
+        t->s->progress_bytes_callback(t->bytes, t->s->progress_opaque);
+    }
+    co_put_to_shres(t->s->mem, t->bytes);
+    block_copy_task_end(t, ret);
+
+    return ret;
+}
+
 static int block_copy_block_status(BlockCopyState *s, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
@@ -484,6 +554,8 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
     int ret = 0;
     bool found_dirty = false;
     int64_t end = offset + bytes;
+    AioTaskPool *aio = NULL;
+    BlockCopyCallState call_state = {false, false};
 
     /*
      * block_copy() user is responsible for keeping source and target in same
@@ -495,11 +567,11 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
 
-    while (bytes) {
-        g_autofree BlockCopyTask *task = NULL;
+    while (bytes && aio_task_pool_status(aio) == 0) {
+        BlockCopyTask *task;
         int64_t status_bytes;
 
-        task = block_copy_task_create(s, offset, bytes);
+        task = block_copy_task_create(s, &call_state, offset, bytes);
         if (!task) {
             /* No more dirty bits in the bitmap */
             trace_block_copy_skip_range(s, offset, bytes);
@@ -519,6 +591,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
         }
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
             block_copy_task_end(task, 0);
+            g_free(task);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -527,25 +600,45 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
             bytes = end - offset;
             continue;
         }
+        task->zeroes = ret & BDRV_BLOCK_ZERO;
 
         trace_block_copy_process(s, task->offset);
 
         co_get_from_shres(s->mem, task->bytes);
-        ret = block_copy_do_copy(s, task->offset, task->bytes,
-                                 ret & BDRV_BLOCK_ZERO, error_is_read);
-        co_put_to_shres(s->mem, task->bytes);
-        block_copy_task_end(task, ret);
-        if (ret < 0) {
-            return ret;
-        }
 
-        progress_work_done(s->progress, task->bytes);
-        s->progress_bytes_callback(task->bytes, s->progress_opaque);
         offset = task_end(task);
         bytes = end - offset;
+
+        if (!aio && bytes) {
+            aio = aio_task_pool_new(BLOCK_COPY_MAX_WORKERS);
+        }
+
+        ret = block_copy_task_run(aio, task);
+        if (ret < 0) {
+            goto out;
+        }
+    }
+
+out:
+    if (aio) {
+        aio_task_pool_wait_all(aio);
+
+        /*
+         * We are not really interested in -ECANCELED returned from
+         * block_copy_task_run. If it fails, it means some task already failed
+         * for real reason, let's return first failure.
+         * Still, assert that we don't rewrite failure by success.
+         */
+        assert(ret == 0 || aio_task_pool_status(aio) < 0);
+        ret = aio_task_pool_status(aio);
+
+        aio_task_pool_free(aio);
+    }
+    if (error_is_read && ret < 0) {
+        *error_is_read = call_state.error_is_read;
     }
 
-    return found_dirty;
+    return ret < 0 ? ret : found_dirty;
 }
 
 /*
-- 
2.21.0


