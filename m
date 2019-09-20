Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F178C4CECD
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29591208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29591208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBK0M-0008MW-MJ
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBJmW-0004Za-Mv
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBJmV-0000tj-0B
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:21:08 -0400
Received: from relay.sw.ru ([185.231.240.75]:43802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBJmQ-0000g9-8P; Fri, 20 Sep 2019 10:21:02 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBJmN-0006b5-16; Fri, 20 Sep 2019 17:20:59 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v13 06/15] block/backup: fix block-comment style
Date: Fri, 20 Sep 2019 17:20:47 +0300
Message-Id: <20190920142056.12778-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142056.12778-1-vsementsov@virtuozzo.com>
References: <20190920142056.12778-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to fix comment style around block-copy functions before further
moving them to separate file to satisfy checkpatch. But do more: fix
all comments style. Also, seems like doubled first asterisk is not
forbidden, but drop it too for consistency.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 5dda1673ca..f5125984db 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -223,8 +223,10 @@ fail:
     return NULL;
 }
 
-/* Copy range to target with a bounce buffer and return the bytes copied. If
- * error occurred, return a negative error number */
+/*
+ * Copy range to target with a bounce buffer and return the bytes copied. If
+ * error occurred, return a negative error number
+ */
 static int coroutine_fn block_copy_with_bounce_buffer(BlockCopyState *s,
                                                       int64_t start,
                                                       int64_t end,
@@ -269,8 +271,10 @@ fail:
 
 }
 
-/* Copy range to target and return the bytes copied. If error occurred, return a
- * negative error number. */
+/*
+ * Copy range to target and return the bytes copied. If error occurred, return a
+ * negative error number.
+ */
 static int coroutine_fn block_copy_with_offload(BlockCopyState *s,
                                                 int64_t start,
                                                 int64_t end,
@@ -341,7 +345,7 @@ static int block_copy_is_cluster_allocated(BlockCopyState *s, int64_t offset,
     }
 }
 
-/**
+/*
  * Reset bits in copy_bitmap starting at offset if they represent unallocated
  * data in the image. May reset subsequent contiguous bits.
  * @return 0 when the cluster at @offset was unallocated,
@@ -592,8 +596,10 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
         return true;
     }
 
-    /* We need to yield even for delay_ns = 0 so that bdrv_drain_all() can
-     * return. Without a yield, the VM would not reboot. */
+    /*
+     * We need to yield even for delay_ns = 0 so that bdrv_drain_all() can
+     * return. Without a yield, the VM would not reboot.
+     */
     delay_ns = block_job_ratelimit_get_delay(&job->common, job->bytes_read);
     job->bytes_read = 0;
     job_sleep_ns(&job->common.job, delay_ns);
@@ -692,11 +698,15 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
     }
 
     if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
-        /* All bits are set in copy_bitmap to allow any cluster to be copied.
-         * This does not actually require them to be copied. */
+        /*
+         * All bits are set in copy_bitmap to allow any cluster to be copied.
+         * This does not actually require them to be copied.
+         */
         while (!job_is_cancelled(job)) {
-            /* Yield until the job is cancelled.  We just let our before_write
-             * notify callback service CoW requests. */
+            /*
+             * Yield until the job is cancelled.  We just let our before_write
+             * notify callback service CoW requests.
+             */
             job_yield(job);
         }
     } else {
-- 
2.21.0


