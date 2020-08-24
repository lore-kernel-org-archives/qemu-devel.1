Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC66C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB3B2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nBHVx29W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB3B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA999-0004bk-Bt
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95X-0004mt-BF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:27 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:36407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95V-0004my-4z
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:26 -0400
Received: by mail-wr1-x42d.google.com with SMTP id x7so1931800wro.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+IRaKpLNT6dm56V52rlALT3BSN1ENhS7a0LI65DSjGE=;
 b=nBHVx29WhIEO1OSStttvJRrCnhk7+qtGwwPE7b0SisUnQiZdTkSAVKBBnC4AvGh59V
 n8NlCAVrE5iLzfgJSMegu3WKn8qd/tbUhZfDg7S3kKpdcSAvQPlZ7YDrNG2vs+/2ZW9S
 2yosbs2rfs9Yx0eGS2gfg2ZIOI9BvT/KnckYktKrBZGvt7/iyfsWosJJSBPwa67CXaTj
 Hza4ZBl0Wi2XEn8hF+HrLQjV8+mkx3nidORJbROgrv9ELEeUPos1pT/ZySVpwpXATdtq
 tPSgjgnGmrwDVyQsy6nFp/itbRIsdcIab9t6CIH8EvUi/3YSSL/9uWSEiIQQ0sLnptCS
 z13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+IRaKpLNT6dm56V52rlALT3BSN1ENhS7a0LI65DSjGE=;
 b=F7Lk29YQXmXyzgt49uoDZNOi74DYviK9amGhHKcgW1A2NSv5y78V2QtlTIKySBsZ+i
 9X1ybmm/EW7o0N9y+KtuO+pExa0gw2EDaGQeTnHMfIFtZHrhQdsVcma8DELz5WmZ0m4t
 za5Nc8mZj+urzH4FPwt0lORyH3vBJquSWX6hHPoV+/66s1j2iGTMkMYi1AEJYCdHHA2m
 +VU4v1c8RSxDd5uvtlEm1dh7TLT8+hlSaCm1sTfxejTiYquRMxl9Rkouz2Md9n2TAKZ4
 zLMFsfLaWEeZF8ChyYr1ghf8+Wq3Pe9JDGgghOchHdvEV3WlvZ2QQbxri8BCbizZWrkD
 tYHQ==
X-Gm-Message-State: AOAM532CtlzeNdTAIZpuXVCn5yZ3I4cIQdmQPWpiK9j4c8Hp/Gm79pQU
 ZlaawnecsdHWnJNWNq33meFJIrJacoq2RHJS
X-Google-Smtp-Source: ABdhPJzqJeuMWBSgOXTlsRpdhF4GkAIiAbPwN1pqc6q1b/EuIeyrBkDr1Yu5jt0cbq/ti51UpG8RRQ==
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr5338101wra.150.1598262503282; 
 Mon, 24 Aug 2020 02:48:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/27] hw/arm/smmuv3: Get prepared for range invalidation
Date: Mon, 24 Aug 2020 10:47:52 +0100
Message-Id: <20200824094811.15439-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Enhance the smmu_iotlb_inv_iova() helper with range invalidation.
This uses the new fields passed in the NH_VA and NH_VAA commands:
the size of the range, the level and the granule.

As NH_VA and NH_VAA both use those fields, their decoding and
handling is factorized in a new smmuv3_s1_range_inval() helper.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200728150815.11446-8-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h     |  4 +++
 include/hw/arm/smmu-common.h |  3 +-
 hw/arm/smmu-common.c         | 25 +++++++++++---
 hw/arm/smmuv3.c              | 64 +++++++++++++++++++++++-------------
 hw/arm/trace-events          |  4 +--
 5 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 4112394129e..5babf72f7d5 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -298,6 +298,8 @@ enum { /* Command completion notification */
 };
 
 #define CMD_TYPE(x)         extract32((x)->word[0], 0 , 8)
+#define CMD_NUM(x)          extract32((x)->word[0], 12 , 5)
+#define CMD_SCALE(x)        extract32((x)->word[0], 20 , 5)
 #define CMD_SSEC(x)         extract32((x)->word[0], 10, 1)
 #define CMD_SSV(x)          extract32((x)->word[0], 11, 1)
 #define CMD_RESUME_AC(x)    extract32((x)->word[0], 12, 1)
@@ -310,6 +312,8 @@ enum { /* Command completion notification */
 #define CMD_RESUME_STAG(x)  extract32((x)->word[2], 0 , 16)
 #define CMD_RESP(x)         extract32((x)->word[2], 11, 2)
 #define CMD_LEAF(x)         extract32((x)->word[2], 0 , 1)
+#define CMD_TTL(x)          extract32((x)->word[2], 8 , 2)
+#define CMD_TG(x)           extract32((x)->word[2], 10, 2)
 #define CMD_STE_RANGE(x)    extract32((x)->word[2], 0 , 5)
 #define CMD_ADDR(x) ({                                        \
             uint64_t high = (uint64_t)(x)->word[3];           \
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index ece62c36523..4f6acf634cf 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -168,7 +168,8 @@ SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
-void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova);
+void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova,
+                         uint8_t tg, uint64_t num_pages, uint8_t ttl);
 
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
 void smmu_inv_notifiers_all(SMMUState *s);
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 2922deec6fc..8d89a86699a 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -143,15 +143,30 @@ static gboolean smmu_hash_remove_by_asid_iova(gpointer key, gpointer value,
     if (info->asid >= 0 && info->asid != SMMU_IOTLB_ASID(iotlb_key)) {
         return false;
     }
-    return (info->iova & ~entry->addr_mask) == entry->iova;
+    return ((info->iova & ~entry->addr_mask) == entry->iova) ||
+           ((entry->iova & ~info->mask) == info->iova);
 }
 
-inline void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova)
+inline void
+smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova,
+                    uint8_t tg, uint64_t num_pages, uint8_t ttl)
 {
-    SMMUIOTLBPageInvInfo info = {.asid = asid, .iova = iova};
+    if (ttl && (num_pages == 1)) {
+        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, iova, tg, ttl);
 
-    trace_smmu_iotlb_inv_iova(asid, iova);
-    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_iova, &info);
+        g_hash_table_remove(s->iotlb, &key);
+    } else {
+        /* if tg is not set we use 4KB range invalidation */
+        uint8_t granule = tg ? tg * 2 + 10 : 12;
+
+        SMMUIOTLBPageInvInfo info = {
+            .asid = asid, .iova = iova,
+            .mask = (num_pages * 1 << granule) - 1};
+
+        g_hash_table_foreach_remove(s->iotlb,
+                                    smmu_hash_remove_by_asid_iova,
+                                    &info);
+    }
 }
 
 inline void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e4a2cea7adc..89ab11fc36a 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -785,42 +785,49 @@ epilogue:
  * @n: notifier to be called
  * @asid: address space ID or negative value if we don't care
  * @iova: iova
+ * @tg: translation granule (if communicated through range invalidation)
+ * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
  */
 static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
                                IOMMUNotifier *n,
-                               int asid,
-                               dma_addr_t iova)
+                               int asid, dma_addr_t iova,
+                               uint8_t tg, uint64_t num_pages)
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
-    SMMUEventInfo event = {.inval_ste_allowed = true};
-    SMMUTransTableInfo *tt;
-    SMMUTransCfg *cfg;
     IOMMUTLBEntry entry;
+    uint8_t granule = tg;
 
-    cfg = smmuv3_get_config(sdev, &event);
-    if (!cfg) {
-        return;
-    }
+    if (!tg) {
+        SMMUEventInfo event = {.inval_ste_allowed = true};
+        SMMUTransCfg *cfg = smmuv3_get_config(sdev, &event);
+        SMMUTransTableInfo *tt;
 
-    if (asid >= 0 && cfg->asid != asid) {
-        return;
-    }
+        if (!cfg) {
+            return;
+        }
 
-    tt = select_tt(cfg, iova);
-    if (!tt) {
-        return;
+        if (asid >= 0 && cfg->asid != asid) {
+            return;
+        }
+
+        tt = select_tt(cfg, iova);
+        if (!tt) {
+            return;
+        }
+        granule = tt->granule_sz;
     }
 
     entry.target_as = &address_space_memory;
     entry.iova = iova;
-    entry.addr_mask = (1 << tt->granule_sz) - 1;
+    entry.addr_mask = num_pages * (1 << granule) - 1;
     entry.perm = IOMMU_NONE;
 
     memory_region_notify_one(n, &entry);
 }
 
-/* invalidate an asid/iova tuple in all mr's */
-static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova)
+/* invalidate an asid/iova range tuple in all mr's */
+static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova,
+                                      uint8_t tg, uint64_t num_pages)
 {
     SMMUDevice *sdev;
 
@@ -828,28 +835,39 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova)
         IOMMUMemoryRegion *mr = &sdev->iommu;
         IOMMUNotifier *n;
 
-        trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, iova);
+        trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, iova,
+                                        tg, num_pages);
 
         IOMMU_NOTIFIER_FOREACH(n, mr) {
-            smmuv3_notify_iova(mr, n, asid, iova);
+            smmuv3_notify_iova(mr, n, asid, iova, tg, num_pages);
         }
     }
 }
 
 static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
 {
+    uint8_t scale = 0, num = 0, ttl = 0;
     dma_addr_t addr = CMD_ADDR(cmd);
     uint8_t type = CMD_TYPE(cmd);
     uint16_t vmid = CMD_VMID(cmd);
     bool leaf = CMD_LEAF(cmd);
+    uint8_t tg = CMD_TG(cmd);
+    hwaddr num_pages = 1;
     int asid = -1;
 
+    if (tg) {
+        scale = CMD_SCALE(cmd);
+        num = CMD_NUM(cmd);
+        ttl = CMD_TTL(cmd);
+        num_pages = (num + 1) * (1 << (scale));
+    }
+
     if (type == SMMU_CMD_TLBI_NH_VA) {
         asid = CMD_ASID(cmd);
     }
-    trace_smmuv3_s1_range_inval(vmid, asid, addr, leaf);
-    smmuv3_inv_notifiers_iova(s, asid, addr);
-    smmu_iotlb_inv_iova(s, asid, addr);
+    trace_smmuv3_s1_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
+    smmuv3_inv_notifiers_iova(s, asid, addr, tg, num_pages);
+    smmu_iotlb_inv_iova(s, asid, addr, tg, num_pages, ttl);
 }
 
 static int smmuv3_cmdq_consume(SMMUv3State *s)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index c219fe9e828..3d905e0f7d0 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -45,11 +45,11 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%d - end=0x%d"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "streamid = %d"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid %d (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid %d (hits=%d, misses=%d, hit rate=%d)"
-smmuv3_s1_range_inval(int vmid, int asid, uint64_t addr, bool leaf) "vmid =%d asid =%d addr=0x%"PRIx64" leaf=%d"
+smmuv3_s1_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf) "vmid =%d asid =%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d"
 smmuv3_cmdq_tlbi_nh(void) ""
 smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid %d"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
-smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint64_t iova) "iommu mr=%s asid=%d iova=0x%"PRIx64
+smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
 
-- 
2.20.1


