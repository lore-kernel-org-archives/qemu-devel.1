Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA02C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D85207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D85207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5r0j-000590-C8
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 09:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1k5noh-00089V-7L; Wed, 12 Aug 2020 06:17:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59268 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1k5nod-00032t-Go; Wed, 12 Aug 2020 06:17:06 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 64C2ACDF4A67DC2B63FA;
 Wed, 12 Aug 2020 18:17:00 +0800 (CST)
Received: from localhost (10.174.187.253) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 12 Aug 2020
 18:16:52 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH RFC 07/10] block/: fix some comment spelling errors
Date: Wed, 12 Aug 2020 18:14:57 +0800
Message-ID: <20200812101500.2066-8-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20200812101500.2066-1-zhaolichang@huawei.com>
References: <20200812101500.2066-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.187.253]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:15:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 12 Aug 2020 09:40:49 -0400
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
Cc: zhaolichang <zhaolichang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the block folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
 block/block-copy.c | 2 +-
 block/linux-aio.c  | 2 +-
 block/mirror.c     | 2 +-
 block/vhdx.c       | 2 +-
 block/vhdx.h       | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index f7428a7..1dfd46a 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -318,7 +318,7 @@ static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
  * Do copy of cluster-aligned chunk. Requested region is allowed to exceed
  * s->len only to cover last cluster when s->len is not aligned to clusters.
  *
- * No sync here: nor bitmap neighter intersecting requests handling, only copy.
+ * No sync here: nor bitmap neither intersecting requests handling, only copy.
  *
  * Returns 0 on success.
  */
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 3c0527c..772ff86 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -222,7 +222,7 @@ static void qemu_laio_process_completions(LinuxAioState *s)
 
     /* If we are nested we have to notify the level above that we are done
      * by setting event_max to zero, upper level will then jump out of it's
-     * own `for` loop.  If we are the last all counters droped to zero. */
+     * own `for` loop.  If we are the last all counters dropped to zero. */
     s->event_max = 0;
     s->event_idx = 0;
 }
diff --git a/block/mirror.c b/block/mirror.c
index e8e8844..22d5741 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -478,7 +478,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
 
     job_pause_point(&s->common.job);
 
-    /* Find the number of consective dirty chunks following the first dirty
+    /* Find the number of consecutive dirty chunks following the first dirty
      * one, and wait for in flight requests in them. */
     bdrv_dirty_bitmap_lock(s->dirty_bitmap);
     while (nb_chunks * s->granularity < s->buf_size) {
diff --git a/block/vhdx.c b/block/vhdx.c
index 791eb90..84eedee 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1073,7 +1073,7 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    /* endian convert populated BAT field entires */
+    /* endian convert populated BAT field entries */
     for (i = 0; i < s->bat_entries; i++) {
         s->bat[i] = le64_to_cpu(s->bat[i]);
     }
diff --git a/block/vhdx.h b/block/vhdx.h
index 0b74924..e385e48 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -212,7 +212,7 @@ typedef struct QEMU_PACKED VHDXLogDataSector {
     uint32_t    sequence_high;          /* 4 MSB of 8 byte sequence_number */
     uint8_t     data[4084];             /* raw data, bytes 8-4091 (inclusive).
                                            see the data descriptor field for the
-                                           other mising bytes */
+                                           other missing bytes */
     uint32_t    sequence_low;           /* 4 LSB of 8 byte sequence_number */
 } VHDXLogDataSector;
 
@@ -257,7 +257,7 @@ typedef struct QEMU_PACKED VHDXMetadataTableHeader {
 
 #define VHDX_META_FLAGS_IS_USER         0x01    /* max 1024 entries */
 #define VHDX_META_FLAGS_IS_VIRTUAL_DISK 0x02    /* virtual disk metadata if set,
-                                                   otherwise file metdata */
+                                                   otherwise file metadata */
 #define VHDX_META_FLAGS_IS_REQUIRED     0x04    /* parse must understand this
                                                    entry to open the file */
 typedef struct QEMU_PACKED VHDXMetadataTableEntry {
-- 
2.26.2.windows.1



