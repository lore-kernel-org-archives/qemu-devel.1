Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AF4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADD32074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MkY6ncqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADD32074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfp8X-0007eX-6f
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouf-0005Mj-Nj; Mon, 01 Jun 2020 14:11:53 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com
 ([40.107.7.117]:10211 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfoue-00027N-63; Mon, 01 Jun 2020 14:11:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecI9ejsGvD2X3Ku+KNKX8UWF48sL5xxOP+ptD0TZtEZdSOfQ51w4+rtkCKlKNYAgZlqt8xPFUQ1VuODYPKNnS2Xr1E8NmUFXnezwt8cU2y1SqGnZqiW2jEt9vr81i7o2jWG8fqd6QbN0ThGUOmqkhvpk48ZVLZLqeb16sfYe7xmizaovbl9XzCgBBS+/3WpBG+6KtGV0mQZHIPIMqh2LVxqDLKscuj2+tJdY1yhNeuT16g7ht2Y1clxhwdxtl09CQ23x2qTsEIElDX4l4T6BeCgT2tgieyydO0M0DdSsIXRaITp5rMZc0XXKQ2i4qXrhBEmP9gAjZ3qlMbXAWNr5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjHYtl+u4jr6RDj4bCVeB4oPIsj6rpy14y2kySrZV5I=;
 b=ZPb+VDQHoTgQeub8Gxt3FsrOoQqef7MeIBad3ByMbo7WJk4xv1al2QuqSttKdUWvrPDgRttjZavdrhcovstJ4YFcPoWZ6LGWx5exiH4lWlXIjqBRJFwF6xelFjJUuclQ58pKx7LIdEviwVZK6/EyOlEffAKYdBzrscE5ofA5WACZK2WLQxUpi2TvHArbjt73158CLGCsgS2GBZKzF1dYL6LWZJ7SPI5mk0FCaSyu0U8NBsME6+YWCAoDnfQlRxAXn5O3KNtofChhgFM26zOvThnzelPd+nyBfIqdMniL5g0Y9pdgCL3KMSMWaFt0UiZu4vwZkeXFR0rntnet9EPLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjHYtl+u4jr6RDj4bCVeB4oPIsj6rpy14y2kySrZV5I=;
 b=MkY6ncqm1WDNd5HQRB7jVdoqBOWuS2whJ9yvrBY7c4Weue2K1HijRh4agNAMtexBmHYvm+gfI+tKJZN2Xa4Tztaia+FUDgu7OiEnZc5Rvvi+tIukOuz57exf0tcTTF5/aANkqfwAZh7WFkWxCgagYAAUrZYJ2PyObnWkFje1h0A=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 17/20] backup: move to block-copy
Date: Mon,  1 Jun 2020 21:11:15 +0300
Message-Id: <20200601181118.579-18-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200601181118.579-1-vsementsov@virtuozzo.com>
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.170) by
 AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:45 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2bafded-fe4b-40c6-0d6b-08d806573f0b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53177B9D061C37EC77C6AEA3C18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:112;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Nj8v6c8vfbjq/jTjVB7oDZhUQeTt+0TTbfJB/jF4iU0tKun4rSt0FEDMnp3XV12Y3zk9OprsrrbuKLaW4GUBlU8FhQHaOabBbIoLGTSUxP8Q0FvjcKHaeysytfKlYlqnrgXrpouEktD5UvfwN6WWBMEHAlYNjgbs6uEER11QwVpQisdyBMdXBEuQzummyvlApbmR9HQcVf9p256KTh9ZwoexpZrZhMOi6EHw1M9F02PVzTvOT7/8WLf+T9sPD3iHmywfwR9SD4glPjpXYj3+83OepepCreX4qd/PXEkJOHR39CFPoOSiUOetc5iiA8CTc4EOtAMTBBh+A/gLYm/8sGyXkSliGZLVRjyTiaAa7Q86Ve+EUMKPA39rtZSprLC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /EraILrVjG0yuxcSdSyHuAjWbH0ZiQodnZh8lkN4QpHX/uk2mej7YOhom2nt1u15yQ3I2kaTJxzSOhhcXjrfj+oIArZ32dIfWxaSHfjPxxkLXzUBsnBtpepAZYUeXTwEC2QADgF627GAYc5lnFWksf8/qRoQAsVMyfXW+xO4Q8Vko75VNu5HgrbSep3ikU7oa9RJ2SxtkxuruNu89cHJ/jsgaOZsoBs5GFfIYhnHjtM3FrkSfljFzdDp7cbcB2Pxf8+FCq/yyOB4hLFe/0BXx87URsf7Ur00GszNyjDdV4yyVwL9N5BF+jBwTGVgp5MK380xlNgDMwbcR4P2S4sijjQftI8/aMn338TVhC4ZELQpepp6cBWbUeY9PAzy+1Pe6afwKyjVaOrcrmmKatcF0GQ0D37XecE37q5MKHBCk6xYeiy0m9NsaCpSjTpvJASTqekn8UldjMQ9F97rbZaE10uyK6zvZIVkeZMWpQ+v6rc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bafded-fe4b-40c6-0d6b-08d806573f0b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:46.3809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w55USbS9jDSN9BM3kodvYSmIz6C8qm03XIuiGF8/RG9d7RKsEw3QXS8A76nY/pqB1pNxs7lj/tKTvOkpnwU4DjU9KTGcXNu2zVRE2lcOEK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:40
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This brings async request handling and block-status driven chunk sizes
to backup out of the box, which improves backup performance.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h |   9 +--
 block/backup.c             | 145 +++++++++++++++++++------------------
 block/block-copy.c         |  21 ++----
 3 files changed, 83 insertions(+), 92 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 370a194d3c..a3e11d3fa2 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -18,7 +18,6 @@
 #include "block/block.h"
 #include "qemu/co-shared-resource.h"
 
-typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
 typedef void (*BlockCopyAsyncCallbackFunc)(int ret, bool error_is_read,
                                            void *opaque);
 typedef struct BlockCopyState BlockCopyState;
@@ -29,11 +28,6 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      BdrvRequestFlags write_flags,
                                      Error **errp);
 
-void block_copy_set_progress_callback(
-        BlockCopyState *s,
-        ProgressBytesCallbackFunc progress_bytes_callback,
-        void *progress_opaque);
-
 void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm);
 
 void block_copy_state_free(BlockCopyState *s);
@@ -57,7 +51,8 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
                                      int64_t offset, int64_t bytes,
                                      bool ratelimit, int max_workers,
                                      int64_t max_chunk,
-                                     BlockCopyAsyncCallbackFunc cb);
+                                     BlockCopyAsyncCallbackFunc cb,
+                                     void *cb_opaque);
 
 /*
  * Set speed limit for block-copy instance. All block-copy operations related to
diff --git a/block/backup.c b/block/backup.c
index ec2676abc2..59c00f5293 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -44,42 +44,19 @@ typedef struct BackupBlockJob {
     BlockdevOnError on_source_error;
     BlockdevOnError on_target_error;
     uint64_t len;
-    uint64_t bytes_read;
     int64_t cluster_size;
     int max_workers;
     int64_t max_chunk;
 
     BlockCopyState *bcs;
+
+    BlockCopyCallState *bcs_call;
+    int ret;
+    bool error_is_read;
 } BackupBlockJob;
 
 static const BlockJobDriver backup_job_driver;
 
-static void backup_progress_bytes_callback(int64_t bytes, void *opaque)
-{
-    BackupBlockJob *s = opaque;
-
-    s->bytes_read += bytes;
-}
-
-static int coroutine_fn backup_do_cow(BackupBlockJob *job,
-                                      int64_t offset, uint64_t bytes,
-                                      bool *error_is_read)
-{
-    int ret = 0;
-    int64_t start, end; /* bytes */
-
-    start = QEMU_ALIGN_DOWN(offset, job->cluster_size);
-    end = QEMU_ALIGN_UP(bytes + offset, job->cluster_size);
-
-    trace_backup_do_cow_enter(job, start, offset, bytes);
-
-    ret = block_copy(job->bcs, start, end - start, error_is_read);
-
-    trace_backup_do_cow_return(job, offset, bytes, ret);
-
-    return ret;
-}
-
 static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
 {
     BdrvDirtyBitmap *bm;
@@ -159,54 +136,58 @@ static BlockErrorAction backup_error_action(BackupBlockJob *job,
     }
 }
 
-static bool coroutine_fn yield_and_check(BackupBlockJob *job)
+static void coroutine_fn backup_block_copy_callback(int ret, bool error_is_read,
+                                                    void *opaque)
 {
-    uint64_t delay_ns;
-
-    if (job_is_cancelled(&job->common.job)) {
-        return true;
-    }
-
-    /*
-     * We need to yield even for delay_ns = 0 so that bdrv_drain_all() can
-     * return. Without a yield, the VM would not reboot.
-     */
-    delay_ns = block_job_ratelimit_get_delay(&job->common, job->bytes_read);
-    job->bytes_read = 0;
-    job_sleep_ns(&job->common.job, delay_ns);
-
-    if (job_is_cancelled(&job->common.job)) {
-        return true;
-    }
+    BackupBlockJob *s = opaque;
 
-    return false;
+    s->bcs_call = NULL;
+    s->ret = ret;
+    s->error_is_read = error_is_read;
+    job_enter(&s->common.job);
 }
 
 static int coroutine_fn backup_loop(BackupBlockJob *job)
 {
-    bool error_is_read;
-    int64_t offset;
-    BdrvDirtyBitmapIter *bdbi;
-    int ret = 0;
+    while (true) { /* retry loop */
+        assert(!job->bcs_call);
+        job->bcs_call = block_copy_async(job->bcs, 0,
+                                         QEMU_ALIGN_UP(job->len,
+                                                       job->cluster_size),
+                                         true, job->max_workers, job->max_chunk,
+                                         backup_block_copy_callback, job);
 
-    bdbi = bdrv_dirty_iter_new(block_copy_dirty_bitmap(job->bcs));
-    while ((offset = bdrv_dirty_iter_next(bdbi)) != -1) {
-        do {
-            if (yield_and_check(job)) {
-                goto out;
+        while (job->bcs_call && !job->common.job.cancelled) {
+            /* wait and handle pauses */
+
+            job_pause_point(&job->common.job);
+
+            if (job->bcs_call && !job->common.job.cancelled) {
+                job_yield(&job->common.job);
             }
-            ret = backup_do_cow(job, offset, job->cluster_size, &error_is_read);
-            if (ret < 0 && backup_error_action(job, error_is_read, -ret) ==
-                           BLOCK_ERROR_ACTION_REPORT)
-            {
-                goto out;
+        }
+
+        if (!job->bcs_call && job->ret == 0) {
+            /* Success */
+            return 0;
+        }
+
+        if (job->common.job.cancelled) {
+            if (job->bcs_call) {
+                block_copy_cancel(job->bcs_call);
             }
-        } while (ret < 0);
+            return 0;
+        }
+
+        if (!job->bcs_call && job->ret < 0 &&
+            (backup_error_action(job, job->error_is_read, -job->ret) ==
+             BLOCK_ERROR_ACTION_REPORT))
+        {
+            return job->ret;
+        }
     }
 
- out:
-    bdrv_dirty_iter_free(bdbi);
-    return ret;
+    g_assert_not_reached();
 }
 
 static void backup_init_bcs_bitmap(BackupBlockJob *job)
@@ -246,9 +227,14 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
         int64_t count;
 
         for (offset = 0; offset < s->len; ) {
-            if (yield_and_check(s)) {
-                ret = -ECANCELED;
-                goto out;
+            if (job_is_cancelled(job)) {
+                return -ECANCELED;
+            }
+
+            job_pause_point(job);
+
+            if (job_is_cancelled(job)) {
+                return -ECANCELED;
             }
 
             ret = block_copy_reset_unallocated(s->bcs, offset, &count);
@@ -281,6 +267,25 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
     return ret;
 }
 
+static void coroutine_fn backup_pause(Job *job)
+{
+    BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
+
+    if (s->bcs_call) {
+        block_copy_cancel(s->bcs_call);
+    }
+}
+
+static void coroutine_fn backup_set_speed(BlockJob *job, int64_t speed)
+{
+    BackupBlockJob *s = container_of(job, BackupBlockJob, common);
+
+    if (s->bcs) {
+        /* In block_job_create we yet don't have bcs */
+        block_copy_set_speed(s->bcs, s->bcs_call, speed);
+    }
+}
+
 static const BlockJobDriver backup_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(BackupBlockJob),
@@ -291,7 +296,9 @@ static const BlockJobDriver backup_job_driver = {
         .commit                 = backup_commit,
         .abort                  = backup_abort,
         .clean                  = backup_clean,
-    }
+        .pause                  = backup_pause,
+    },
+    .set_speed = backup_set_speed,
 };
 
 static int64_t backup_calculate_cluster_size(BlockDriverState *target,
@@ -487,8 +494,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->max_workers = max_workers;
     job->max_chunk = max_chunk;
 
-    block_copy_set_progress_callback(bcs, backup_progress_bytes_callback, job);
     block_copy_set_progress_meter(bcs, &job->common.job.progress);
+    block_copy_set_speed(bcs, NULL, speed);
 
     /* Required permissions are already taken by backup-top target */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
diff --git a/block/block-copy.c b/block/block-copy.c
index b551feb6c2..6a9d891b63 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -39,6 +39,7 @@ typedef struct BlockCopyCallState {
     int64_t max_chunk;
     bool ratelimit;
     BlockCopyAsyncCallbackFunc cb;
+    void *cb_opaque;
 
     /* State */
     bool failed;
@@ -103,9 +104,6 @@ typedef struct BlockCopyState {
     bool skip_unallocated;
 
     ProgressMeter *progress;
-    /* progress_bytes_callback: called when some copying progress is done. */
-    ProgressBytesCallbackFunc progress_bytes_callback;
-    void *progress_opaque;
 
     SharedResource *mem;
 
@@ -287,15 +285,6 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
     return s;
 }
 
-void block_copy_set_progress_callback(
-        BlockCopyState *s,
-        ProgressBytesCallbackFunc progress_bytes_callback,
-        void *progress_opaque)
-{
-    s->progress_bytes_callback = progress_bytes_callback;
-    s->progress_opaque = progress_opaque;
-}
-
 void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm)
 {
     s->progress = pm;
@@ -443,7 +432,6 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
         t->call_state->error_is_read = error_is_read;
     } else {
         progress_work_done(t->s->progress, t->bytes);
-        t->s->progress_bytes_callback(t->bytes, t->s->progress_opaque);
     }
     co_put_to_shres(t->s->mem, t->bytes);
     block_copy_task_end(t, ret);
@@ -712,8 +700,7 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
     } while (ret > 0 && !call_state->cancelled);
 
     if (call_state->cb) {
-        call_state->cb(ret, call_state->error_is_read,
-                       call_state->s->progress_opaque);
+        call_state->cb(ret, call_state->error_is_read, call_state->cb_opaque);
     }
 
     if (call_state->canceller) {
@@ -754,7 +741,8 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
                                      int64_t offset, int64_t bytes,
                                      bool ratelimit, int max_workers,
                                      int64_t max_chunk,
-                                     BlockCopyAsyncCallbackFunc cb)
+                                     BlockCopyAsyncCallbackFunc cb,
+                                     void *cb_opaque)
 {
     BlockCopyCallState *call_state = g_new(BlockCopyCallState, 1);
     Coroutine *co = qemu_coroutine_create(block_copy_async_co_entry,
@@ -766,6 +754,7 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
         .bytes = bytes,
         .ratelimit = ratelimit,
         .cb = cb,
+        .cb_opaque = cb_opaque,
         .max_workers = max_workers ?: BLOCK_COPY_MAX_WORKERS,
         .max_chunk = max_chunk,
     };
-- 
2.21.0


