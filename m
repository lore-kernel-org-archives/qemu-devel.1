Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A575C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EEAF2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EEAF2074F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS245-0004Li-B1
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 13:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kS21C-0001Eb-7U; Mon, 12 Oct 2020 13:53:55 -0400
Received: from relay.sw.ru ([185.231.240.75]:35132 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kS21A-0008He-GH; Mon, 12 Oct 2020 13:53:53 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kS20E-0047iC-Bs; Mon, 12 Oct 2020 20:52:54 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com
Subject: [PATCH v11 12/13] stream: remove unused backing-file name parameter
Date: Mon, 12 Oct 2020 20:43:24 +0300
Message-Id: <1602524605-481160-13-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 13:44:17
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich via <qemu-devel@nongnu.org>

The 'backing-file' argument is not used by the block-stream job. It
designates a backing file name to set in QCOW2 image header after the
block-stream job finished. A backing file name of the node above base
is used instead.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/stream.c            |  6 +-----
 blockdev.c                | 21 ++++++---------------
 include/block/block_int.h |  2 +-
 3 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 51462bd..d3e1812 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -34,7 +34,6 @@ typedef struct StreamBlockJob {
     BlockDriverState *base_overlay; /* COW overlay (stream from this) */
     BlockDriverState *above_base;   /* Node directly above the base */
     BlockdevOnError on_error;
-    char *backing_file_str;
     bool bs_read_only;
     bool chain_frozen;
 } StreamBlockJob;
@@ -103,8 +102,6 @@ static void stream_clean(Job *job)
         blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
-
-    g_free(s->backing_file_str);
 }
 
 static int coroutine_fn stream_run(Job *job, Error **errp)
@@ -220,7 +217,7 @@ static const BlockJobDriver stream_job_driver = {
 };
 
 void stream_start(const char *job_id, BlockDriverState *bs,
-                  BlockDriverState *base, const char *backing_file_str,
+                  BlockDriverState *base,
                   int creation_flags, int64_t speed,
                   BlockdevOnError on_error,
                   const char *filter_node_name,
@@ -295,7 +292,6 @@ void stream_start(const char *job_id, BlockDriverState *bs,
 
     s->base_overlay = base_overlay;
     s->above_base = above_base;
-    s->backing_file_str = g_strdup(backing_file_str);
     s->bs_read_only = bs_read_only;
     s->chain_frozen = true;
 
diff --git a/blockdev.c b/blockdev.c
index d719c47..019b6e0 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2498,7 +2498,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     BlockDriverState *base_bs = NULL;
     AioContext *aio_context;
     Error *local_err = NULL;
-    const char *base_name = NULL;
     int job_flags = JOB_DEFAULT;
 
     if (!has_on_error) {
@@ -2526,7 +2525,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
             goto out;
         }
         assert(bdrv_get_aio_context(base_bs) == aio_context);
-        base_name = base;
     }
 
     if (has_base_node) {
@@ -2541,7 +2539,11 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         }
         assert(bdrv_get_aio_context(base_bs) == aio_context);
         bdrv_refresh_filename(base_bs);
-        base_name = base_bs->filename;
+    }
+
+    if (has_backing_file) {
+        warn_report("Use of \"backing-file\" argument is deprecated; "
+                    "a backing file of the node above base is used instead");
     }
 
     /* Check for op blockers in the whole chain between bs and base */
@@ -2553,17 +2555,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         }
     }
 
-    /* if we are streaming the entire chain, the result will have no backing
-     * file, and specifying one is therefore an error */
-    if (base_bs == NULL && has_backing_file) {
-        error_setg(errp, "backing file specified, but streaming the "
-                         "entire chain");
-        goto out;
-    }
-
-    /* backing_file string overrides base bs filename */
-    base_name = has_backing_file ? backing_file : base_name;
-
     if (has_auto_finalize && !auto_finalize) {
         job_flags |= JOB_MANUAL_FINALIZE;
     }
@@ -2571,7 +2562,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         job_flags |= JOB_MANUAL_DISMISS;
     }
 
-    stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
+    stream_start(has_job_id ? job_id : NULL, bs, base_bs,
                  job_flags, has_speed ? speed : 0, on_error,
                  filter_node_name, &local_err);
     if (local_err) {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index a142867..4f523c3 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1151,7 +1151,7 @@ int is_windows_drive(const char *filename);
  * BlockDriverState.
  */
 void stream_start(const char *job_id, BlockDriverState *bs,
-                  BlockDriverState *base, const char *backing_file_str,
+                  BlockDriverState *base,
                   int creation_flags, int64_t speed,
                   BlockdevOnError on_error,
                   const char *filter_node_name,
-- 
1.8.3.1


