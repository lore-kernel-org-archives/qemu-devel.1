Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956AAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D5520882
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ysk0V+ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D5520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCnN-0004Ns-4c
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQU-0003Ne-Ht; Tue, 16 Jun 2020 10:18:58 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQS-0006wl-RE; Tue, 16 Jun 2020 10:18:58 -0400
Received: by mail-oi1-x244.google.com with SMTP id j189so19336198oih.10;
 Tue, 16 Jun 2020 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=h429QYiD1bg+WMlm+glXw9EZ2TWraTLlcvNO6XKq5+Y=;
 b=Ysk0V+ewYqMMR0+gah7P2IQV88KYfhL3UsEqFDLtLQ5dWQqf9yajAhX0Pp4AVqvq8n
 YmMzunhImD0RI1nmthXt8nHxY0w+lJ3rPi2tpLGpWNxcR56hYaNOw5R74tKzrEGUR0dS
 dqyMrWHlolLYVOcNPTQ/9b6lL0grayg/2mpIYUOfHyzLNDZX5dZ80mm3k294WxMGFiKh
 zWEXwhCHOdesBKSAYiFHFzUxD1TAJ+jys9gjOlOE3DI9rbSrPriiqG8CWdMtR6L7gho+
 htz2cZ3Z9wwPKp5FHkQxvTFuoDYtVEGlit8PJCNpFdEbD9fHDmNAwzjPlSOMKM18ZVpd
 F4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=h429QYiD1bg+WMlm+glXw9EZ2TWraTLlcvNO6XKq5+Y=;
 b=iwOrMWXcfRoSz9hGahhaDWFvhM2siLMtjm4IxnhPwDSa9KsWJFQJixnBhKCapbYMWS
 80agSvSROmLsaUD5lERnTK6EXSj3nnrSCRvhcv/vjBPsihqYdil37ud4tuSkIc23rks5
 s8GalNfuD1xXvWPmQ0OlCNRHa6DJKNrs3KoAB8oUoxEc4/QZf0+DMbPvvAgGmvHaTDR+
 xPNc83ALeRjR9DEkShlVLSTY6rX23m714M6XLr+2hFsL0hb29R+TXI8q1EjvbwgeYhCX
 uGN8m6OO3HzBWLiNi4XKZoSLfFwMnMbkmBOQPy5L/1reW+NfJsuoNYotGG822hzu8qHe
 bcVA==
X-Gm-Message-State: AOAM530YEJTGadyLnISZNQeRMWaU2qo54juJko8DtvYWdajgy3PLpwx5
 zQtrHIT/qW4cvrVJX64LCQeu+uGM
X-Google-Smtp-Source: ABdhPJzlw1ib20DQePfdRx/1qhY4BU9r9KlsF1/qWQYjM49TgKeCy0G3phnZW6xg+mqWshcKaQp1BA==
X-Received: by 2002:aca:4b4f:: with SMTP id y76mr3695526oia.34.1592317134822; 
 Tue, 16 Jun 2020 07:18:54 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id e26sm2952616otp.50.2020.06.16.07.18.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:52 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 54/78] block/block-copy: fix progress calculation
Date: Tue, 16 Jun 2020 09:15:23 -0500
Message-Id: <20200616141547.24664-55-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Assume we have two regions, A and B, and region B is in-flight now,
region A is not yet touched, but it is unallocated and should be
skipped.

Correspondingly, as progress we have

  total = A + B
  current = 0

If we reset unallocated region A and call progress_reset_callback,
it will calculate 0 bytes dirty in the bitmap and call
job_progress_set_remaining, which will set

   total = current + 0 = 0 + 0 = 0

So, B bytes are actually removed from total accounting. When job
finishes we'll have

   total = 0
   current = B

, which doesn't sound good.

This is because we didn't considered in-flight bytes, actually when
calculating remaining, we should have set (in_flight + dirty_bytes)
as remaining, not only dirty_bytes.

To fix it, let's refactor progress calculation, moving it to block-copy
itself instead of fixing callback. And, of course, track in_flight
bytes count.

We still have to keep one callback, to maintain backup job bytes_read
calculation, but it will go on soon, when we turn the whole backup
process into one block_copy call.

Cc: qemu-stable@nongnu.org
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <20200311103004.7649-3-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit d0ebeca14a585f352938062ef8ddde47fe4d39f9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/backup.c             | 13 ++-----------
 block/block-copy.c         | 16 ++++++++++++----
 include/block/block-copy.h | 15 +++++----------
 3 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index cf62b1a38c..5f3bd2415a 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -57,15 +57,6 @@ static void backup_progress_bytes_callback(int64_t bytes, void *opaque)
     BackupBlockJob *s = opaque;
 
     s->bytes_read += bytes;
-    job_progress_update(&s->common.job, bytes);
-}
-
-static void backup_progress_reset_callback(void *opaque)
-{
-    BackupBlockJob *s = opaque;
-    uint64_t estimate = bdrv_get_dirty_count(s->bcs->copy_bitmap);
-
-    job_progress_set_remaining(&s->common.job, estimate);
 }
 
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
@@ -461,8 +452,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->cluster_size = cluster_size;
     job->len = len;
 
-    block_copy_set_callbacks(bcs, backup_progress_bytes_callback,
-                             backup_progress_reset_callback, job);
+    block_copy_set_progress_callback(bcs, backup_progress_bytes_callback, job);
+    block_copy_set_progress_meter(bcs, &job->common.job.progress);
 
     /* Required permissions are already taken by backup-top target */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
diff --git a/block/block-copy.c b/block/block-copy.c
index 79798a1567..e2d7b3b887 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -127,17 +127,20 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
     return s;
 }
 
-void block_copy_set_callbacks(
+void block_copy_set_progress_callback(
         BlockCopyState *s,
         ProgressBytesCallbackFunc progress_bytes_callback,
-        ProgressResetCallbackFunc progress_reset_callback,
         void *progress_opaque)
 {
     s->progress_bytes_callback = progress_bytes_callback;
-    s->progress_reset_callback = progress_reset_callback;
     s->progress_opaque = progress_opaque;
 }
 
+void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm)
+{
+    s->progress = pm;
+}
+
 /*
  * block_copy_do_copy
  *
@@ -269,7 +272,9 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
 
     if (!ret) {
         bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
-        s->progress_reset_callback(s->progress_opaque);
+        progress_set_remaining(s->progress,
+                               bdrv_get_dirty_count(s->copy_bitmap) +
+                               s->in_flight_bytes);
     }
 
     *count = bytes;
@@ -331,15 +336,18 @@ int coroutine_fn block_copy(BlockCopyState *s,
         trace_block_copy_process(s, start);
 
         bdrv_reset_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
+        s->in_flight_bytes += chunk_end - start;
 
         co_get_from_shres(s->mem, chunk_end - start);
         ret = block_copy_do_copy(s, start, chunk_end, error_is_read);
         co_put_to_shres(s->mem, chunk_end - start);
+        s->in_flight_bytes -= chunk_end - start;
         if (ret < 0) {
             bdrv_set_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
             break;
         }
 
+        progress_work_done(s->progress, chunk_end - start);
         s->progress_bytes_callback(chunk_end - start, s->progress_opaque);
         start = chunk_end;
         ret = 0;
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 0a161724d7..9def00068c 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -26,7 +26,6 @@ typedef struct BlockCopyInFlightReq {
 } BlockCopyInFlightReq;
 
 typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
-typedef void (*ProgressResetCallbackFunc)(void *opaque);
 typedef struct BlockCopyState {
     /*
      * BdrvChild objects are not owned or managed by block-copy. They are
@@ -36,6 +35,7 @@ typedef struct BlockCopyState {
     BdrvChild *source;
     BdrvChild *target;
     BdrvDirtyBitmap *copy_bitmap;
+    int64_t in_flight_bytes;
     int64_t cluster_size;
     bool use_copy_range;
     int64_t copy_size;
@@ -60,15 +60,9 @@ typedef struct BlockCopyState {
      */
     bool skip_unallocated;
 
+    ProgressMeter *progress;
     /* progress_bytes_callback: called when some copying progress is done. */
     ProgressBytesCallbackFunc progress_bytes_callback;
-
-    /*
-     * progress_reset_callback: called when some bytes reset from copy_bitmap
-     * (see @skip_unallocated above). The callee is assumed to recalculate how
-     * many bytes remain based on the dirty bit count of copy_bitmap.
-     */
-    ProgressResetCallbackFunc progress_reset_callback;
     void *progress_opaque;
 
     SharedResource *mem;
@@ -79,12 +73,13 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      BdrvRequestFlags write_flags,
                                      Error **errp);
 
-void block_copy_set_callbacks(
+void block_copy_set_progress_callback(
         BlockCopyState *s,
         ProgressBytesCallbackFunc progress_bytes_callback,
-        ProgressResetCallbackFunc progress_reset_callback,
         void *progress_opaque);
 
+void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm);
+
 void block_copy_state_free(BlockCopyState *s);
 
 int64_t block_copy_reset_unallocated(BlockCopyState *s,
-- 
2.17.1


