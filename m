Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BB1C61DD8
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 04:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A202151B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 04:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A202151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYMIs-0001jp-Qa
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 00:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiliyang@huawei.com>)
 id 1kYLCL-0005IQ-Ju; Thu, 29 Oct 2020 23:35:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiliyang@huawei.com>)
 id 1kYLCI-0003eh-Vr; Thu, 29 Oct 2020 23:35:29 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CMny50nB8z70qL;
 Fri, 30 Oct 2020 11:35:25 +0800 (CST)
Received: from [10.108.235.13] (10.108.235.13) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 30 Oct 2020 11:35:12 +0800
Subject: [PATCH] block: Fix some code style problems, "foo* bar" should be
 "foo *bar"
References: <b7e77b38-6115-9a3d-5668-f51737476400@huawei.com>
To: <kwolf@redhat.com>, <mreitz@redhat.com>
From: shiliyang <shiliyang@huawei.com>
X-Forwarded-Message-Id: <b7e77b38-6115-9a3d-5668-f51737476400@huawei.com>
Message-ID: <3211f389-6d22-46c1-4a16-e6a2ba66f070@huawei.com>
Date: Fri, 30 Oct 2020 11:35:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <b7e77b38-6115-9a3d-5668-f51737476400@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.108.235.13]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=shiliyang@huawei.com;
 helo=szxga07-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 23:35:23
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2020 00:44:45 -0400
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
Cc: alex.chen@huawei.com, hunongda@huawei.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There have some code style problems be found when read the block driver code.
So I fixes some problems of this error, ERROR: "foo* bar" should be "foo *bar".

Signed-off-by: Liyang Shi <shiliyang@huawei.com>
Reported-by: Euler Robot <euler.robot@huawei.com>
---
 block/blkdebug.c |  2 +-
 block/dmg.c      |  2 +-
 block/qcow2.c    |  4 ++--
 block/qcow2.h    |  6 +++---
 block/vpc.c      | 10 +++++-----
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 54da719dd1..5fe6172da9 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -173,7 +173,7 @@ static int add_rule(void *opaque, QemuOpts *opts, Error **errp)
 {
     struct add_rule_data *d = opaque;
     BDRVBlkdebugState *s = d->s;
-    const char* event_name;
+    const char *event_name;
     int event;
     struct BlkdebugRule *rule;
     int64_t sector;
diff --git a/block/dmg.c b/block/dmg.c
index 0d6c317296..ef35a505f2 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -559,7 +559,7 @@ static void dmg_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.request_alignment = BDRV_SECTOR_SIZE; /* No sub-sector I/O */
 }

-static inline int is_sector_in_chunk(BDRVDMGState* s,
+static inline int is_sector_in_chunk(BDRVDMGState *s,
                 uint32_t chunk_num, uint64_t sector_num)
 {
     if (chunk_num >= s->n_chunks || s->sectors[chunk_num] > sector_num ||
diff --git a/block/qcow2.c b/block/qcow2.c
index b6cb4db8bb..0f94c43ce9 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -269,7 +269,7 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,

         case QCOW2_EXT_MAGIC_FEATURE_TABLE:
             if (p_feature_table != NULL) {
-                void* feature_table = g_malloc0(ext.len + 2 * sizeof(Qcow2Feature));
+                void *feature_table = g_malloc0(ext.len + 2 * sizeof(Qcow2Feature));
                 ret = bdrv_pread(bs->file, offset , feature_table, ext.len);
                 if (ret < 0) {
                     error_setg_errno(errp, -ret, "ERROR: ext_feature_table: "
@@ -3374,7 +3374,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     size_t cluster_size;
     int version;
     int refcount_order;
-    uint64_t* refcount_table;
+    uint64_t *refcount_table;
     int ret;
     uint8_t compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;

diff --git a/block/qcow2.h b/block/qcow2.h
index 125ea9679b..2da03e1d1e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -343,8 +343,8 @@ typedef struct BDRVQcow2State {
     uint64_t l1_table_offset;
     uint64_t *l1_table;

-    Qcow2Cache* l2_table_cache;
-    Qcow2Cache* refcount_block_cache;
+    Qcow2Cache *l2_table_cache;
+    Qcow2Cache *refcount_block_cache;
     QEMUTimer *cache_clean_timer;
     unsigned cache_clean_interval;

@@ -394,7 +394,7 @@ typedef struct BDRVQcow2State {
     uint64_t autoclear_features;

     size_t unknown_header_fields_size;
-    void* unknown_header_fields;
+    void *unknown_header_fields;
     QLIST_HEAD(, Qcow2UnknownHeaderExtension) unknown_header_ext;
     QTAILQ_HEAD (, Qcow2DiscardRegion) discards;
     bool cache_discards;
diff --git a/block/vpc.c b/block/vpc.c
index 890554277e..1ab55f9287 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -172,7 +172,7 @@ static QemuOptsList vpc_runtime_opts = {

 static QemuOptsList vpc_create_opts;

-static uint32_t vpc_checksum(uint8_t* buf, size_t size)
+static uint32_t vpc_checksum(uint8_t *buf, size_t size)
 {
     uint32_t res = 0;
     int i;
@@ -528,7 +528,7 @@ static inline int64_t get_image_offset(BlockDriverState *bs, uint64_t offset,
  *
  * Returns 0 on success and < 0 on error
  */
-static int rewrite_footer(BlockDriverState* bs)
+static int rewrite_footer(BlockDriverState *bs)
 {
     int ret;
     BDRVVPCState *s = bs->opaque;
@@ -548,7 +548,7 @@ static int rewrite_footer(BlockDriverState* bs)
  *
  * Returns the sectors' offset in the image file on success and < 0 on error
  */
-static int64_t alloc_block(BlockDriverState* bs, int64_t offset)
+static int64_t alloc_block(BlockDriverState *bs, int64_t offset)
 {
     BDRVVPCState *s = bs->opaque;
     int64_t bat_offset;
@@ -781,8 +781,8 @@ static int coroutine_fn vpc_co_block_status(BlockDriverState *bs,
  * the hardware EIDE and ATA-2 limit of 16 heads (max disk size of 127 GB)
  * and instead allow up to 255 heads.
  */
-static int calculate_geometry(int64_t total_sectors, uint16_t* cyls,
-    uint8_t* heads, uint8_t* secs_per_cyl)
+static int calculate_geometry(int64_t total_sectors, uint16_t *cyls,
+    uint8_t *heads, uint8_t *secs_per_cyl)
 {
     uint32_t cyls_times_heads;

-- 
2.17.1.windows.2



