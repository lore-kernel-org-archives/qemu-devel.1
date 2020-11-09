Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CE0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135162067D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1nJKtJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135162067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBLB-0005lI-15
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kcB8P-0006oM-BY
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:39:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kcB8N-0000Uc-Ch
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604943554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJw5+4Mr4LsXriOH357TibTTrG47bAafYktNDMxo9Wk=;
 b=T1nJKtJR+XGbEZz66Ad92JNeVXwZDODORRcb/EeJcMAmFmHfLH2xh9s75uE9Az5+NqD/ul
 yfRe+Z/Y6t7BXGXxOFTdmbWZ72zRbgI7hAQlfWae5nEc+A/JkJHfFR4RN0kdmToFM6eyLM
 epYSD340KC5+CFhbjSMTArqGZeOtYqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-O7B3kQzTPC2pgXhArf_HAg-1; Mon, 09 Nov 2020 12:39:10 -0500
X-MC-Unique: O7B3kQzTPC2pgXhArf_HAg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BD6D879510;
 Mon,  9 Nov 2020 17:39:09 +0000 (UTC)
Received: from localhost (ovpn-113-179.ams2.redhat.com [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D03AD614F5;
 Mon,  9 Nov 2020 17:39:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 12/15] block: Fix some code style problems,
 "foo* bar" should be "foo *bar"
Date: Mon,  9 Nov 2020 18:38:36 +0100
Message-Id: <20201109173839.2135984-13-mreitz@redhat.com>
In-Reply-To: <20201109173839.2135984-1-mreitz@redhat.com>
References: <20201109173839.2135984-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: shiliyang <shiliyang@huawei.com>

There have some code style problems be found when read the block driver code.
So I fixes some problems of this error, ERROR: "foo* bar" should be "foo *bar".

Signed-off-by: Liyang Shi <shiliyang@huawei.com>
Reported-by: Euler Robot <euler.robot@huawei.com>
---
 block/qcow2.h    |  6 +++---
 block/blkdebug.c |  2 +-
 block/dmg.c      |  2 +-
 block/qcow2.c    |  4 ++--
 block/vpc.c      | 10 +++++-----
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 2e0272a7b8..0678073b74 100644
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
index 1b0733238b..3a90ef2786 100644
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
@@ -3388,7 +3388,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     size_t cluster_size;
     int version;
     int refcount_order;
-    uint64_t* refcount_table;
+    uint64_t *refcount_table;
     int ret;
     uint8_t compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
 
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
2.28.0


