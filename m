Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665F4C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE98F21D42
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X8HDFQRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE98F21D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6Pu-0003wC-LS
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX697-0007ye-Vp; Mon, 26 Oct 2020 13:19:03 -0400
Received: from mail-eopbgr60093.outbound.protection.outlook.com
 ([40.107.6.93]:39555 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX695-0008NC-MV; Mon, 26 Oct 2020 13:19:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBsZna23t4+Ikiv4gbhtXWeFW8I/Tq5tTh8+pRppdGqpIgVVGsOYEZn/JfbCOinl9UmoKD1sWxbVejG088/Ukjy4ItOI8fvQnutLMvNL0wmzKKAB8Xjc6xdkTqmqjHRLDbbXguIOfZ3UJENjFRJdch3UtncFKjSNDXC1gdQA7NzfCcWhgbMQvcKfN+zfy/ZXywF5LJpQha5SQynJZUNGkVoUHuJ+PcH3MtOM+1U1QPo+8dDMfBl3VgsWH3RwueRTZlh27hFIB+rI5Jd3Ygc8eH+zgzbX+eRjKem0bi5U+shu0L0T5f+P5ZMmhJ0XM9S9q/cDvg+y+Dkk2pKra2Amlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx0AD2nDalj+UZZ19oaai0BKjf82AaY2SFIzo6HfKxQ=;
 b=SuMGO4nMg5NZyWDHYhhxDDEu6stNXWKWj2bJSZjYnPp7DbKrrQxhPPB5iDDrJnC/D1Ph2cZiJ0pQlZwfGYOsrh0iCqyFxLn3+yGjeUVqWhNOyhoA3c4F6zyjFnwHErp5lvym2lanHfelozkJTjtBiGTSFSnkvdKkM0HfASZlrerMmEP9KMdTV8qzQsHontzZJIL8DFJDmc3Be8h75ovxk4PWQ5eu1mk233jNk7SXeSKDvlWinRVXA2d95vtbLtmKF58uXPhhCGBJc8e8rl2f6WYghba2a5d7a70U4nEUHWL2o5/h6Y+dxdutXNprHo46AZKKM5mPTCrcM006yjJRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx0AD2nDalj+UZZ19oaai0BKjf82AaY2SFIzo6HfKxQ=;
 b=X8HDFQRcFDJ0a6ngphMHE4+EJZvy0Q9PCdDZolJ6Ipfiw10jahyReuTGTD0/4FI7X1Do1lp3sg6h1/9yK6lwDTcjvOkXjb/McMwNSv32SLjFoUkcALKzHxyLjYlL3A4Qfz/HNpXG8G8b+2zKBgV+U5wu/nAVd/5UDU5K8FGDN2c=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 19/25] backup: move to block-copy
Date: Mon, 26 Oct 2020 20:18:09 +0300
Message-Id: <20201026171815.13233-20-vsementsov@virtuozzo.com>
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
 Transport; Mon, 26 Oct 2020 17:18:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df76a4a4-04a5-473d-82b8-08d879d332a0
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032B72E78E13D9D44028B80C1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:94;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDx60VLWNz8ycDZvDhMJ1rCRQJbqv+Lkug2Y0Sf5paeh2mRtLH8c6hogeTrBDuPvdDcYVxL5FOeEipys8jiEFfIP+JvI1+kRNDrrUfNvpN+102gZiUpO/IXlVfV/stM4eIQ1biP3acCsWGn5YbXNjeEsA1fVrEwD6yl8UuUug9Y/TBWXK29xZcbdqKSFmVLRm61TCr6DJ/fRLgAw71eyyc/8cQvz0izxQubnLMmsVmhU6MphiR+idzr4N6PuJT6PW6pk1qd5kWe72XOFa9IU6+6rStr+U9LJQd10M9wzvRPDj4N1LwKCvK+v4HwVga4UW8lcXq4XWwM3xETfpTp7ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: us6NFxr2t64a7r6iZe9vCH/T60rGLxe7DwbsIsMiDZS+tKRuYVDPl0jbq0xeAZZdywtIWysKqU6/3UWGUAklxVkM4dN4ACHp/gSNzBcyd+pO5MFAtj98ywjXfV6PrdlXxXytWXtM/Oj2e9NRfGn1QGXd/nDDf1wOTU7RYXG4vKzTQuVrPpVbTQqpg83tAP1oD6u1LAs+TIpKrmkrffvXY734lhG9lP9KKS6/ndnK/NR6zih9bPHRC3ynXM1788eQ2p1bewTcRHcAENM+bkNF/1h64PutLo7/VK5pm/1oLo+owZ6i89hk+PXdzlk0RBH9IhJ/tveWceAixfQeNvGCrIH0A8tIaGLyhBa96JCl5z+2LFrjci3cllxh7DmVuKJEoUVp3z5cpl+uYITEW/Mdn3Hby53WOcqkGc2XBQMoEblziEPHsEUTWdEaiMVJlHe1oQZdo1mDS2RqzOQA0AGH/jKAaPK1dsYk3DX0iT7TpUrZY2IaSlR6Oz3pmKAeDArFUwJFdqzziY2YPRIwUnoBtnTmGZ4fIAroRd1u8hhxaRG452hYXyrR9N1nIilDv0HYws/7YhKSAyJZgOPdmYlThdbJzX3CM4/N7OtGHv9VxO8OqLTRAdgd+8Ph/D1sKiejUyxDOLrzTQciLI3xAJuFhw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df76a4a4-04a5-473d-82b8-08d879d332a0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:46.8620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r10bo6+EmLbNnX/F/i9QD6YTwSsihpJcfoFdZAzVG1pGvBH+DuGUxZeAkMkGv/ZgZL154JQNXc+IaQbb6xkoD/U4ZAKdZlVuSjHNnwuqiYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.6.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This brings async request handling and block-status driven chunk sizes
to backup out of the box, which improves backup performance.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 187 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 121 insertions(+), 66 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 449b763ce4..0d1cd64eab 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -44,41 +44,17 @@ typedef struct BackupBlockJob {
     BlockdevOnError on_source_error;
     BlockdevOnError on_target_error;
     uint64_t len;
-    uint64_t bytes_read;
     int64_t cluster_size;
     BackupPerf perf;
 
     BlockCopyState *bcs;
+
+    bool wait;
+    BlockCopyCallState *bg_bcs_call;
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
-    ret = block_copy(job->bcs, start, end - start, true, error_is_read);
-
-    trace_backup_do_cow_return(job, offset, bytes, ret);
-
-    return ret;
-}
-
 static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
 {
     BdrvDirtyBitmap *bm;
@@ -158,53 +134,97 @@ static BlockErrorAction backup_error_action(BackupBlockJob *job,
     }
 }
 
-static bool coroutine_fn yield_and_check(BackupBlockJob *job)
+static void coroutine_fn backup_block_copy_callback(void *opaque)
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
+    BackupBlockJob *s = opaque;
 
-    if (job_is_cancelled(&job->common.job)) {
-        return true;
+    if (s->wait) {
+        s->wait = false;
+        aio_co_wake(s->common.job.co);
+    } else {
+        job_enter(&s->common.job);
     }
-
-    return false;
 }
 
 static int coroutine_fn backup_loop(BackupBlockJob *job)
 {
-    bool error_is_read;
-    int64_t offset;
-    BdrvDirtyBitmapIter *bdbi;
+    BlockCopyCallState *s = NULL;
     int ret = 0;
+    bool error_is_read;
+    BlockErrorAction act;
+
+    while (true) { /* retry loop */
+        job->bg_bcs_call = s = block_copy_async(job->bcs, 0,
+                QEMU_ALIGN_UP(job->len, job->cluster_size),
+                job->perf.max_workers, job->perf.max_chunk,
+                backup_block_copy_callback, job);
+
+        while (!block_copy_call_finished(s) &&
+               !job_is_cancelled(&job->common.job))
+        {
+            job_yield(&job->common.job);
+        }
 
-    bdbi = bdrv_dirty_iter_new(block_copy_dirty_bitmap(job->bcs));
-    while ((offset = bdrv_dirty_iter_next(bdbi)) != -1) {
-        do {
-            if (yield_and_check(job)) {
-                goto out;
-            }
-            ret = backup_do_cow(job, offset, job->cluster_size, &error_is_read);
-            if (ret < 0 && backup_error_action(job, error_is_read, -ret) ==
-                           BLOCK_ERROR_ACTION_REPORT)
-            {
-                goto out;
-            }
-        } while (ret < 0);
+        if (!block_copy_call_finished(s) &&
+            job_is_cancelled(&job->common.job))
+        {
+            /*
+             * Note that we can't use job_yield() here, as it doesn't work for
+             * cancelled job.
+             */
+            block_copy_call_cancel(s);
+            job->wait = true;
+            qemu_coroutine_yield();
+            assert(block_copy_call_finished(s));
+            ret = 0;
+            goto out;
+        }
+
+        if (job_is_cancelled(&job->common.job) ||
+            block_copy_call_succeeded(s))
+        {
+            ret = 0;
+            goto out;
+        }
+
+        if (block_copy_call_cancelled(s)) {
+            /*
+             * Job is not cancelled but only block-copy call. This is possible
+             * after job pause. Now the pause is finished, start new block-copy
+             * iteration.
+             */
+            block_copy_call_free(s);
+            continue;
+        }
+
+        /* The only remaining case is failed block-copy call. */
+        assert(block_copy_call_failed(s));
+
+        ret = block_copy_call_status(s, &error_is_read);
+        act = backup_error_action(job, error_is_read, -ret);
+        switch (act) {
+        case BLOCK_ERROR_ACTION_REPORT:
+            goto out;
+        case BLOCK_ERROR_ACTION_STOP:
+            /*
+             * Go to pause prior to starting new block-copy call on the next
+             * iteration.
+             */
+            job_pause_point(&job->common.job);
+            break;
+        case BLOCK_ERROR_ACTION_IGNORE:
+            /* Proceed to new block-copy call to retry. */
+            break;
+        default:
+            abort();
+        }
+
+        block_copy_call_free(s);
     }
 
- out:
-    bdrv_dirty_iter_free(bdbi);
+out:
+    block_copy_call_free(s);
+    job->bg_bcs_call = NULL;
     return ret;
 }
 
@@ -245,7 +265,13 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
         int64_t count;
 
         for (offset = 0; offset < s->len; ) {
-            if (yield_and_check(s)) {
+            if (job_is_cancelled(job)) {
+                return -ECANCELED;
+            }
+
+            job_pause_point(job);
+
+            if (job_is_cancelled(job)) {
                 return -ECANCELED;
             }
 
@@ -278,6 +304,33 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
     return 0;
 }
 
+static void coroutine_fn backup_pause(Job *job)
+{
+    BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
+
+    if (s->bg_bcs_call && !block_copy_call_finished(s->bg_bcs_call)) {
+        block_copy_call_cancel(s->bg_bcs_call);
+        s->wait = true;
+        qemu_coroutine_yield();
+    }
+}
+
+static void coroutine_fn backup_set_speed(BlockJob *job, int64_t speed)
+{
+    BackupBlockJob *s = container_of(job, BackupBlockJob, common);
+
+    /*
+     * block_job_set_speed() is called first from block_job_create(), when we
+     * don't yet have s->bcs.
+     */
+    if (s->bcs) {
+        block_copy_set_speed(s->bcs, speed);
+        if (s->bg_bcs_call) {
+            block_copy_kick(s->bg_bcs_call);
+        }
+    }
+}
+
 static const BlockJobDriver backup_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(BackupBlockJob),
@@ -288,7 +341,9 @@ static const BlockJobDriver backup_job_driver = {
         .commit                 = backup_commit,
         .abort                  = backup_abort,
         .clean                  = backup_clean,
-    }
+        .pause                  = backup_pause,
+    },
+    .set_speed = backup_set_speed,
 };
 
 static int64_t backup_calculate_cluster_size(BlockDriverState *target,
@@ -485,8 +540,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->len = len;
     job->perf = *perf;
 
-    block_copy_set_progress_callback(bcs, backup_progress_bytes_callback, job);
     block_copy_set_progress_meter(bcs, &job->common.job.progress);
+    block_copy_set_speed(bcs, speed);
 
     /* Required permissions are already taken by backup-top target */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
-- 
2.21.3


