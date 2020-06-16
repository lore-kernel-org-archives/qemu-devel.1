Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7034AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276D120882
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/N7NDx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276D120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCou-0007xQ-91
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQS-0003Nc-IT; Tue, 16 Jun 2020 10:18:58 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:44311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQQ-0006vV-NJ; Tue, 16 Jun 2020 10:18:56 -0400
Received: by mail-oi1-x22d.google.com with SMTP id x202so19363408oix.11;
 Tue, 16 Jun 2020 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jFs70PZoIy1XIbQQYgl9tpKPoSsJPaMLiLMqPc7+5mM=;
 b=k/N7NDx9SLLQHabflOgD2RKa+qc/DmEiqET0sJo5/+btYaWJ1WrJ0kA4dL4j7Q80YC
 bLzMDzJUed1jldEYYssizR7qwiHtNxe79whtXhG7UOOTndYciKkOwS/o4951eDb4zVwB
 nIryLuk3XVRoULE/wCkMjjIMMIjzMspS/RpAZqJd/0FsaBfuA2Zu4XlM2Cc9RA+/60Vq
 GNhw0tQ2qzVj/1sriPFcl4mHt2cnqsAAW8dsm8GM20paEVS0qKxdj2CphZpZvIY+UfQf
 7mN7xv0EyVFNLUxwK8iQmtxm/6fYmxcziVtbKonNO0Rxp7v2MA3m77miyWk5eaDNigxT
 sbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=jFs70PZoIy1XIbQQYgl9tpKPoSsJPaMLiLMqPc7+5mM=;
 b=B0taLODJVDkwsjljJWjR8gElQ4FtbukCFOIPjxwwNnKM0+wSYfChiMO9zkKNEREZGf
 199KsY01honXb8UniXTYb4BmIlhXBgsQ6VYqQ5egZArO7Yl7f6MWwXjC/4Fow/FSid5T
 RQSvDd60eb8+l/auW3HWTwl6c8fGQS4nM9zFtgwSltM1/Cd7QcJk3P4b4Ri8IYLYxnAJ
 o+d2HOKTiY8fV9VnUqAljus8rCCu4uY7A0p3PwB7K6QQjNIL53aPWu2CeVFu9+h4L3Pl
 7UWbBZkdzakynbvuJ5+wjAJtXTK+0jN4ruftAFfxyYp1g+V0vRWdIE7rJV84EJOBvSsy
 Z+Eg==
X-Gm-Message-State: AOAM532LVskWrMSkGCFEeOn4VzjX0zo6Xz/9af1f+xynlRJAwLQy6heQ
 UNLs1+wVh9x4naf3gzaxIok+31IJ
X-Google-Smtp-Source: ABdhPJx4oyZef7Jclt0y78AegImh8kwqT2iB9Nyer0/wcZgDg12X2NG4kyCt6FcG5zsPGRD/B7AOyw==
X-Received: by 2002:aca:e157:: with SMTP id y84mr3446181oig.161.1592317132496; 
 Tue, 16 Jun 2020 07:18:52 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id w10sm4087599otp.44.2020.06.16.07.18.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:50 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 53/78] job: refactor progress to separate object
Date: Tue, 16 Jun 2020 09:15:22 -0500
Message-Id: <20200616141547.24664-54-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x22d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

We need it in separate to pass to the block-copy object in the next
commit.

Cc: qemu-stable@nongnu.org
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200311103004.7649-2-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 01fe1ca945345d3dc420d70c69488143dc0451b1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 blockjob.c                    | 16 +++++-----
 include/qemu/job.h            | 11 ++-----
 include/qemu/progress_meter.h | 58 +++++++++++++++++++++++++++++++++++
 job-qmp.c                     |  4 +--
 job.c                         |  6 ++--
 qemu-img.c                    |  6 ++--
 6 files changed, 76 insertions(+), 25 deletions(-)
 create mode 100644 include/qemu/progress_meter.h

diff --git a/blockjob.c b/blockjob.c
index c6e20e2fcd..701bd2588d 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -298,8 +298,8 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
     info->device    = g_strdup(job->job.id);
     info->busy      = atomic_read(&job->job.busy);
     info->paused    = job->job.pause_count > 0;
-    info->offset    = job->job.progress_current;
-    info->len       = job->job.progress_total;
+    info->offset    = job->job.progress.current;
+    info->len       = job->job.progress.total;
     info->speed     = job->speed;
     info->io_status = job->iostatus;
     info->ready     = job_is_ready(&job->job),
@@ -329,8 +329,8 @@ static void block_job_event_cancelled(Notifier *n, void *opaque)
 
     qapi_event_send_block_job_cancelled(job_type(&job->job),
                                         job->job.id,
-                                        job->job.progress_total,
-                                        job->job.progress_current,
+                                        job->job.progress.total,
+                                        job->job.progress.current,
                                         job->speed);
 }
 
@@ -349,8 +349,8 @@ static void block_job_event_completed(Notifier *n, void *opaque)
 
     qapi_event_send_block_job_completed(job_type(&job->job),
                                         job->job.id,
-                                        job->job.progress_total,
-                                        job->job.progress_current,
+                                        job->job.progress.total,
+                                        job->job.progress.current,
                                         job->speed,
                                         !!msg,
                                         msg);
@@ -378,8 +378,8 @@ static void block_job_event_ready(Notifier *n, void *opaque)
 
     qapi_event_send_block_job_ready(job_type(&job->job),
                                     job->job.id,
-                                    job->job.progress_total,
-                                    job->job.progress_current,
+                                    job->job.progress.total,
+                                    job->job.progress.current,
                                     job->speed);
 }
 
diff --git a/include/qemu/job.h b/include/qemu/job.h
index bd59cd8944..32aabb1c60 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -28,6 +28,7 @@
 
 #include "qapi/qapi-types-job.h"
 #include "qemu/queue.h"
+#include "qemu/progress_meter.h"
 #include "qemu/coroutine.h"
 #include "block/aio.h"
 
@@ -117,15 +118,7 @@ typedef struct Job {
     /** True if this job should automatically dismiss itself */
     bool auto_dismiss;
 
-    /**
-     * Current progress. The unit is arbitrary as long as the ratio between
-     * progress_current and progress_total represents the estimated percentage
-     * of work already done.
-     */
-    int64_t progress_current;
-
-    /** Estimated progress_current value at the completion of the job */
-    int64_t progress_total;
+    ProgressMeter progress;
 
     /**
      * Return code from @run and/or @prepare callback(s).
diff --git a/include/qemu/progress_meter.h b/include/qemu/progress_meter.h
new file mode 100644
index 0000000000..9a23ff071c
--- /dev/null
+++ b/include/qemu/progress_meter.h
@@ -0,0 +1,58 @@
+/*
+ * Helper functionality for some process progress tracking.
+ *
+ * Copyright (c) 2011 IBM Corp.
+ * Copyright (c) 2012, 2018 Red Hat, Inc.
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
+#ifndef QEMU_PROGRESS_METER_H
+#define QEMU_PROGRESS_METER_H
+
+typedef struct ProgressMeter {
+    /**
+     * Current progress. The unit is arbitrary as long as the ratio between
+     * current and total represents the estimated percentage
+     * of work already done.
+     */
+    uint64_t current;
+
+    /** Estimated current value at the completion of the process */
+    uint64_t total;
+} ProgressMeter;
+
+static inline void progress_work_done(ProgressMeter *pm, uint64_t done)
+{
+    pm->current += done;
+}
+
+static inline void progress_set_remaining(ProgressMeter *pm, uint64_t remaining)
+{
+    pm->total = pm->current + remaining;
+}
+
+static inline void progress_increase_remaining(ProgressMeter *pm,
+                                               uint64_t delta)
+{
+    pm->total += delta;
+}
+
+#endif /* QEMU_PROGRESS_METER_H */
diff --git a/job-qmp.c b/job-qmp.c
index fbfed25a00..fecc939ebd 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -143,8 +143,8 @@ static JobInfo *job_query_single(Job *job, Error **errp)
         .id                 = g_strdup(job->id),
         .type               = job_type(job),
         .status             = job->status,
-        .current_progress   = job->progress_current,
-        .total_progress     = job->progress_total,
+        .current_progress   = job->progress.current,
+        .total_progress     = job->progress.total,
         .has_error          = !!job->err,
         .error              = job->err ? \
                               g_strdup(error_get_pretty(job->err)) : NULL,
diff --git a/job.c b/job.c
index 04409b40aa..134a07b92e 100644
--- a/job.c
+++ b/job.c
@@ -369,17 +369,17 @@ void job_unref(Job *job)
 
 void job_progress_update(Job *job, uint64_t done)
 {
-    job->progress_current += done;
+    progress_work_done(&job->progress, done);
 }
 
 void job_progress_set_remaining(Job *job, uint64_t remaining)
 {
-    job->progress_total = job->progress_current + remaining;
+    progress_set_remaining(&job->progress, remaining);
 }
 
 void job_progress_increase_remaining(Job *job, uint64_t delta)
 {
-    job->progress_total += delta;
+    progress_increase_remaining(&job->progress, delta);
 }
 
 void job_event_cancelled(Job *job)
diff --git a/qemu-img.c b/qemu-img.c
index 95a24b9762..9ae07bbc80 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -881,9 +881,9 @@ static void run_block_job(BlockJob *job, Error **errp)
     do {
         float progress = 0.0f;
         aio_poll(aio_context, true);
-        if (job->job.progress_total) {
-            progress = (float)job->job.progress_current /
-                       job->job.progress_total * 100.f;
+        if (job->job.progress.total) {
+            progress = (float)job->job.progress.current /
+                       job->job.progress.total * 100.f;
         }
         qemu_progress_print(progress, 0);
     } while (!job_is_ready(&job->job) && !job_is_completed(&job->job));
-- 
2.17.1


