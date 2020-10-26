Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFE8C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A792223C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="i4MGdT6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A792223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6Ix-0004mM-3g
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68w-0007ba-2o; Mon, 26 Oct 2020 13:18:50 -0400
Received: from mail-vi1eur05on2123.outbound.protection.outlook.com
 ([40.107.21.123]:17409 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68r-0008Ou-NT; Mon, 26 Oct 2020 13:18:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XglJM9E9Y+MXEYcTRVrpc298MFCurQuq3xKyORpz95l36hO8t6CvBIONSRiAbhSus38VVEOehEwdy9mnVvZE9QLPJ1Em8Kk1M5xVa85A6FwHmZJgSuIcn8iWMLRvEAqDZWpYkJ6KxDN1xstFNd8RsJLRwZPCmzpbaa26FBwQdgDh4pa4cLCzinBCVN8zuUNJpJzCdM4z731rc959MUPcTE4Gjxz1IL7mcuWUM99gIPDb4zlsacjsjfAd2sonSjQ+YFT679LbW3dyCGZ3XLfkY5FB09/FSbBUlq7iBliB0XB51+QQIMT4G2/Fy8SOBE5b636AJo7Y5BvQol8ebdGaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FJxWFu0ssGxkP4CBqP5rlHBIdGZcS9/F1/50aGq6yM=;
 b=Kr9hZE7SmlUnMoSppKd/sae7AlSH748Ehyu9QhfnFkvq3XsxfTbHCQneHPbXUXQn+bDBbLHFXaJO9epkk/GpTzJ5hgCvDKl7VXqe5rQXwqCwfCgi7c0gaAoejiO2EtExZfuFxsWlJv8k/8xXK/IXDOzZjvUwvVOzjg/HjfinNEf20zdXLT+dXrmffuGLQYNCsEmPeOPTtQeyClkpm0QAo6Sa5USHX3wMt4nYod5bZgpubO2oA0+X3MdrjELhew1x1vQ1pwxHqXA23bLF+kJeOfqITB8I0ufyVxSjo3UADdnGPZENtNivl1VXm0Fh2ncFME/f8FyorrSNC4dnwbAEMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FJxWFu0ssGxkP4CBqP5rlHBIdGZcS9/F1/50aGq6yM=;
 b=i4MGdT6TmrwBG9ZjgqkXfwxtyDJyQJne6BVWfEzdRnLegBqMTHIFFt4LmF86ru9iHi3zqrWhXhB6e6TiXg8lT1d1VB8Kljnu/tfUMZRpswoCx7aHINQhlma/6xNY4XVrCxbp43Fskj4jPODUL6jLNvIva9WEgRrrDMRxnG3eGn0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 07/25] block/block-copy: add ratelimit to block-copy
Date: Mon, 26 Oct 2020 20:17:57 +0300
Message-Id: <20201026171815.13233-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026171815.13233-1-vsementsov@virtuozzo.com>
References: <20201026171815.13233-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.99) by
 AM0PR02CA0101.eurprd02.prod.outlook.com (2603:10a6:208:154::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 17:18:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6e2d5f7-edc0-4e79-7a35-08d879d32c29
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032131D59F3CD52CD3CFA71C1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:372;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVNK34rQsHfbIuuajnVTtp/BEJZZPReC43VLo5piUUmm+SeeddBJKKyEY6IjAcz9M3BNySCOg5wLS3xEu3vBzLP0gIPIcxKaebvXpmA8xbPia84PMZQod6JxjQXIGVHvYCgGKuhz+RqtH4EHxH6TZh8G1QH0X7c2ctZDT3EmW9tybzGJLEmEl3sZwzqyWzsbq2H2fTpc5Q+un88cprAYauMVhbxMRbvoA6X6T8D6ZvZPcYg226SuU6WYBUNCp5ClU4qJfkTkUl1IcEfAZZeZnA087jBhLECuaLKyLwweqlsXIJzYi5ZLPJCeBPwstkT2s2IrzZc7wursFikdDBLDMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39840400004)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EXyZx3B58n1Nv23a1uv2w2gSGIBKEuX4cUX/unzo1ufd8O8f2r+BdyVkgnueagOg7qQbA+PMUrQkmb8iK5cJu93maSUUJDo9VudIqPu/w2OqALfrNvnf0vEe8WyHXEdQ9GorCS4zkLs0PbAyddgf5UbeSOfSpYpQWj8OWdNXT2K4Ie/2DWIEDIlSvUlAEtW3BJCwwUvuWEnxsN9G737CZ0yzn/lIdfXOqYc6q0JOhvIpmGN4MSaVsWO0X5JqRPYRL71c4tvVTfwyN9ZhOh25tSp7Hd3zXUZ4nqF73Lp4xkosESQNKWBhWdHIkcPtQQx8CflgO0bPVrrY24xSISAPLk18tpC/1bmu1oJT/kVnLRTIGtgN2XWafDVfDeg8NQ/+V8hmaYgS02HN4kiYsTqZ6f/ciq4TwjCYIK1kQy4wpckbg6gSvD44SdGFfYYokBFx2N1mjHHEM2eHVUYCLcwuwYgdEfHQ8giUaHaQOAuvck1sl7JKlHVDP2CqsS4J/cFhPqfZG0csjdsKiG2UvK5WRWZG3uxGFZPVtCSfcGAKyNWArjabOmPQCS6Hb398U+bbzGoCdcvL36treianT9d4+81mcVIzVfuo2UMFeNSm+xEJXVwTmj9RNzjWitbKsxyRolkakWMV1gglprlFevIz1A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e2d5f7-edc0-4e79-7a35-08d879d32c29
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:36.0096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJxHjt/+Q6ZzahQqvpzfWYnnwsC9HHdyzRXDQ1S9Q+Io2GBNLbpg1qbkarNe4oiY4ggVPIHDr4jxXGmrUsv75f6RR6c4ns07SZ0F5wkgMFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.21.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:43
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

We are going to directly use one async block-copy operation for backup
job, so we need rate limiter.

We want to maintain current backup behavior: only background copying is
limited and copy-before-write operations only participate in limit
calculation. Therefore we need one rate limiter for block-copy state
and boolean flag for block-copy call state for actual limitation.

Note, that we can't just calculate each chunk in limiter after
successful copying: it will not save us from starting a lot of async
sub-requests which will exceed limit too much. Instead let's use the
following scheme on sub-request creation:
1. If at the moment limit is not exceeded, create the request and
account it immediately.
2. If at the moment limit is already exceeded, drop create sub-request
and handle limit instead (by sleep).
With this approach we'll never exceed the limit more than by one
sub-request (which pretty much matches current backup behavior).

Note also, that if there is in-flight block-copy async call,
block_copy_kick() should be used after set-speed to apply new setup
faster. For that block_copy_kick() published in this patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h |  5 ++++-
 block/backup-top.c         |  2 +-
 block/backup.c             |  2 +-
 block/block-copy.c         | 46 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 57806e8a49..0fab64e12a 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -41,7 +41,7 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
                                      int64_t offset, int64_t *count);
 
 int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
-                            bool *error_is_read);
+                            bool ignore_ratelimit, bool *error_is_read);
 
 /*
  * Run block-copy in a coroutine, create corresponding BlockCopyCallState
@@ -73,6 +73,9 @@ bool block_copy_call_succeeded(BlockCopyCallState *call_state);
 bool block_copy_call_failed(BlockCopyCallState *call_state);
 int block_copy_call_status(BlockCopyCallState *call_state, bool *error_is_read);
 
+void block_copy_set_speed(BlockCopyState *s, uint64_t speed);
+void block_copy_kick(BlockCopyCallState *call_state);
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
 void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
 
diff --git a/block/backup-top.c b/block/backup-top.c
index 789acf6965..779956ddc2 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -61,7 +61,7 @@ static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint64_t offset,
     off = QEMU_ALIGN_DOWN(offset, s->cluster_size);
     end = QEMU_ALIGN_UP(offset + bytes, s->cluster_size);
 
-    return block_copy(s->bcs, off, end - off, NULL);
+    return block_copy(s->bcs, off, end - off, true, NULL);
 }
 
 static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
diff --git a/block/backup.c b/block/backup.c
index 4b07e9115d..09ff5a92ef 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -72,7 +72,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
 
     trace_backup_do_cow_enter(job, start, offset, bytes);
 
-    ret = block_copy(job->bcs, start, end - start, error_is_read);
+    ret = block_copy(job->bcs, start, end - start, true, error_is_read);
 
     trace_backup_do_cow_return(job, offset, bytes, ret);
 
diff --git a/block/block-copy.c b/block/block-copy.c
index 6bf1735b93..fa27450b14 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -26,6 +26,7 @@
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
 #define BLOCK_COPY_MAX_WORKERS 64
+#define BLOCK_COPY_SLICE_TIME 100000000ULL /* ns */
 
 static coroutine_fn int block_copy_task_entry(AioTask *task);
 
@@ -36,6 +37,7 @@ typedef struct BlockCopyCallState {
     int64_t bytes;
     int max_workers;
     int64_t max_chunk;
+    bool ignore_ratelimit;
     BlockCopyAsyncCallbackFunc cb;
     void *cb_opaque;
 
@@ -48,6 +50,7 @@ typedef struct BlockCopyCallState {
     /* State */
     int ret;
     bool finished;
+    QemuCoSleepState *sleep_state;
 
     /* OUT parameters */
     bool error_is_read;
@@ -111,6 +114,9 @@ typedef struct BlockCopyState {
     void *progress_opaque;
 
     SharedResource *mem;
+
+    uint64_t speed;
+    RateLimit rate_limit;
 } BlockCopyState;
 
 static BlockCopyTask *find_conflicting_task(BlockCopyState *s,
@@ -623,6 +629,21 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
         }
         task->zeroes = ret & BDRV_BLOCK_ZERO;
 
+        if (s->speed) {
+            if (!call_state->ignore_ratelimit) {
+                uint64_t ns = ratelimit_calculate_delay(&s->rate_limit, 0);
+                if (ns > 0) {
+                    block_copy_task_end(task, -EAGAIN);
+                    g_free(task);
+                    qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, ns,
+                                              &call_state->sleep_state);
+                    continue;
+                }
+            }
+
+            ratelimit_calculate_delay(&s->rate_limit, task->bytes);
+        }
+
         trace_block_copy_process(s, task->offset);
 
         co_get_from_shres(s->mem, task->bytes);
@@ -661,6 +682,13 @@ out:
     return ret < 0 ? ret : found_dirty;
 }
 
+void block_copy_kick(BlockCopyCallState *call_state)
+{
+    if (call_state->sleep_state) {
+        qemu_co_sleep_wake(call_state->sleep_state);
+    }
+}
+
 /*
  * block_copy_common
  *
@@ -707,12 +735,13 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
 }
 
 int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes,
-                            bool *error_is_read)
+                            bool ignore_ratelimit, bool *error_is_read)
 {
     BlockCopyCallState call_state = {
         .s = s,
         .offset = start,
         .bytes = bytes,
+        .ignore_ratelimit = ignore_ratelimit,
         .max_workers = BLOCK_COPY_MAX_WORKERS,
     };
 
@@ -798,3 +827,18 @@ void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip)
 {
     s->skip_unallocated = skip;
 }
+
+void block_copy_set_speed(BlockCopyState *s, uint64_t speed)
+{
+    s->speed = speed;
+    if (speed > 0) {
+        ratelimit_set_speed(&s->rate_limit, speed, BLOCK_COPY_SLICE_TIME);
+    }
+
+    /*
+     * Note: it's good to kick all call states from here, but it should be done
+     * only from a coroutine, to not crash if s->calls list changed while
+     * entering one call. So for now, the only user of this function kicks its
+     * only one call_state by hand.
+     */
+}
-- 
2.21.3


