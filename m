Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA3FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4DFC208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DFC208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQh2-0008Vh-SX
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kIQfM-0006oC-4j
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:11:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52398 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kIQfH-0005Xp-5Q
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:11:39 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 113619CD38B00366F12B;
 Wed, 16 Sep 2020 14:11:30 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 14:11:22 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v10 12/12] migration/dirtyrate: Add trace_calls to make it
 easier to debug
Date: Wed, 16 Sep 2020 14:22:07 +0800
Message-ID: <1600237327-33618-13-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600237327-33618-1-git-send-email-zhengchuan@huawei.com>
References: <1600237327-33618-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:11:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: zhengchuan@huawei.com, zhang.zhanghailiang@huawei.com, liq3ea@gmail.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add trace_calls to make it easier to debug

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
---
 migration/dirtyrate.c  | 9 +++++++++
 migration/trace-events | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 06f455d..f432840 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -22,6 +22,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "migration.h"
 #include "ram.h"
+#include "trace.h"
 #include "dirtyrate.h"
 
 static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
@@ -54,6 +55,7 @@ static bool is_sample_period_valid(int64_t sec)
 static int dirtyrate_set_state(int *state, int old_state, int new_state)
 {
     assert(new_state < DIRTY_RATE_STATUS__MAX);
+    trace_dirtyrate_set_state(DirtyRateStatus_str(new_state));
     if (atomic_cmpxchg(state, old_state, new_state) == old_state) {
         return 0;
     } else {
@@ -76,6 +78,8 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
     info->start_time = DirtyStat.start_time;
     info->calc_time = DirtyStat.calc_time;
 
+    trace_query_dirty_rate_info(DirtyRateStatus_str(CalculatingState));
+
     return info;
 }
 
@@ -123,6 +127,7 @@ static uint32_t get_ramblock_vfn_hash(struct RamblockDirtyInfo *info,
     crc = crc32(0, (info->ramblock_addr +
                 vfn * TARGET_PAGE_SIZE), TARGET_PAGE_SIZE);
 
+    trace_get_ramblock_vfn_hash(info->idstr, vfn, crc);
     return crc;
 }
 
@@ -201,6 +206,8 @@ static bool skip_sample_ramblock(RAMBlock *block)
      * Sample only blocks larger than MIN_RAMBLOCK_SIZE.
      */
     if (qemu_ram_get_used_length(block) < (MIN_RAMBLOCK_SIZE << 10)) {
+        trace_skip_sample_ramblock(block->idstr,
+                                   qemu_ram_get_used_length(block));
         return true;
     }
 
@@ -260,6 +267,7 @@ static void calc_page_dirty_rate(struct RamblockDirtyInfo *info)
     for (i = 0; i < info->sample_pages_count; i++) {
         crc = get_ramblock_vfn_hash(info, info->sample_page_vfn[i]);
         if (crc != info->hash_result[i]) {
+            trace_calc_page_dirty_rate(info->idstr, crc, info->hash_result[i]);
             info->sample_dirty_count++;
         }
     }
@@ -285,6 +293,7 @@ find_block_matched(RAMBlock *block, int count,
     if (infos[i].ramblock_addr != qemu_ram_get_host_addr(block) ||
         infos[i].ramblock_pages !=
             (qemu_ram_get_used_length(block) >> TARGET_PAGE_BITS)) {
+        trace_find_page_matched(block->idstr);
         return NULL;
     }
 
diff --git a/migration/trace-events b/migration/trace-events
index 4ab0a50..8c2b58f 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -312,3 +312,11 @@ dirty_bitmap_load_bits_zeroes(void) ""
 dirty_bitmap_load_header(uint32_t flags) "flags 0x%x"
 dirty_bitmap_load_enter(void) ""
 dirty_bitmap_load_success(void) ""
+
+# dirtyrate.c
+dirtyrate_set_state(const char *new_state) "new state %s"
+query_dirty_rate_info(const char *new_state) "current state %s"
+get_ramblock_vfn_hash(const char *idstr, uint64_t vfn, uint32_t crc) "ramblock name: %s, vfn: %"PRIu64 ", crc: %" PRIu32
+calc_page_dirty_rate(const char *idstr, uint32_t new_crc, uint32_t old_crc) "ramblock name: %s, new crc: %" PRIu32 ", old crc: %" PRIu32
+skip_sample_ramblock(const char *idstr, uint64_t ramblock_size) "ramblock name: %s, ramblock size: %" PRIu64
+find_page_matched(const char *idstr) "ramblock %s addr or size changed"
-- 
1.8.3.1


