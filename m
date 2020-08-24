Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB08C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BEF2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVwvcF2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BEF2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA97i-0001Ax-V5
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95R-0004X9-R0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95P-0004m9-S0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:21 -0400
Received: by mail-wr1-x433.google.com with SMTP id d16so7985425wrq.9
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=eLG591HhmYEyBGzCCdtTUbFXHHvlRfQlo+J7D04QrlU=;
 b=aVwvcF2n5I9Zo5ti7sg3Mwu9kazQ8pFzIQ+Qe4nO72gKukKHE25KHObir0J2wANV3Y
 X2w4VDemo276gZy66Zm0NiMtaeeZ7sULVWM/s5rfzbCf8iBpEFLOtd3ORjmCI6GVA3Sy
 GUUNcFhFXGMa0Ei0cgmiqER8USeFb9cNGEjkfsXxPD+RjbNH6z4On2r2HOedlWgA38mp
 xiGBUl4xnGvVVvx0SGYqch4SKIi2mr64gI4l7IHuuXt8Yo0V5XlxLIGhyLeM/gjvuSKV
 wz0FBp7H4DyKfmLASb0TXa3Kfxp/wJAI0J3ZcnVmG0+mLgDIgHO/cUc1wrmWvxy0gI5F
 6jhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eLG591HhmYEyBGzCCdtTUbFXHHvlRfQlo+J7D04QrlU=;
 b=WB3j6isNnb2cmntd8wA/nRPs2dUQf+CJPexZY4N1BhjpJ/d2+bdjUBk1Xy5w4tbUJc
 Ef3+hl2LMaA/D/EN5ln/uu2IqA/c9qUZ+4Bfu2MBwEWAltGMfMzyhqhYnPmnzoM/sRbo
 jtu7f9FWn1AR/Mh9BzuuW13SQwtbCpOW6MAexM5tuK9KjkWdjEwTuBDCucynTuc5UIiS
 eyaL4+akwlOdT4zOrvUgdSbvvMx5eh/npLL98O8ig3pWqGhLmcaHoJDgH70Zifus1SGR
 TdTjuOM+Lu0OnOGzez9aWwmMh8KhVxKtXBQqeqpz5JkLb3CxI1RUQAWBrSaTBGrpXuYN
 7m/g==
X-Gm-Message-State: AOAM531j3yN4AWJ5ksIHqz9JyqLovxfoI/Lgr9OkB1JoKnKGUPqbTgBJ
 qhk4We4boO8GVmGQfiK4mGsqt2B7iXeOYuM3
X-Google-Smtp-Source: ABdhPJy+fOWDWMSYceNcG4odV4DrQg3eKfGQyvCFzjBijW8mZcKwow84+ZLBiZMcHpuRwzVxvOT3rw==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr4798510wrn.231.1598262497036; 
 Mon, 24 Aug 2020 02:48:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/27] hw/arm/smmu-common: Add IOTLB helpers
Date: Mon, 24 Aug 2020 10:47:47 +0100
Message-Id: <20200824094811.15439-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Add two helpers: one to lookup for a given IOTLB entry and
one to insert a new entry. We also move the tracing there.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200728150815.11446-3-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h |  2 ++
 hw/arm/smmu-common.c         | 36 ++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3.c              | 26 ++------------------------
 hw/arm/trace-events          |  5 +++--
 4 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index ca4a4b1ad1e..1dceec5cb1f 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -153,6 +153,8 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
 
 #define SMMU_IOTLB_MAX_SIZE 256
 
+IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg, hwaddr iova);
+void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
 void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova);
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index a3f9e473985..f3aa581f807 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -32,6 +32,42 @@
 
 /* IOTLB Management */
 
+IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
+                                 hwaddr iova)
+{
+    SMMUIOTLBKey key = {.asid = cfg->asid, .iova = iova};
+    IOMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
+
+    if (entry) {
+        cfg->iotlb_hits++;
+        trace_smmu_iotlb_lookup_hit(cfg->asid, iova,
+                                    cfg->iotlb_hits, cfg->iotlb_misses,
+                                    100 * cfg->iotlb_hits /
+                                    (cfg->iotlb_hits + cfg->iotlb_misses));
+    } else {
+        cfg->iotlb_misses++;
+        trace_smmu_iotlb_lookup_miss(cfg->asid, iova,
+                                     cfg->iotlb_hits, cfg->iotlb_misses,
+                                     100 * cfg->iotlb_hits /
+                                     (cfg->iotlb_hits + cfg->iotlb_misses));
+    }
+    return entry;
+}
+
+void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry)
+{
+    SMMUIOTLBKey *key = g_new0(SMMUIOTLBKey, 1);
+
+    if (g_hash_table_size(bs->iotlb) >= SMMU_IOTLB_MAX_SIZE) {
+        smmu_iotlb_inv_all(bs);
+    }
+
+    key->asid = cfg->asid;
+    key->iova = entry->iova;
+    trace_smmu_iotlb_insert(cfg->asid, entry->iova);
+    g_hash_table_insert(bs->iotlb, key, entry);
+}
+
 inline void smmu_iotlb_inv_all(SMMUState *s)
 {
     trace_smmu_iotlb_inv_all();
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 57a79df55b5..cd2a2e7e148 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -636,7 +636,6 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         .addr_mask = ~(hwaddr)0,
         .perm = IOMMU_NONE,
     };
-    SMMUIOTLBKey key, *new_key;
 
     qemu_mutex_lock(&s->mutex);
 
@@ -675,16 +674,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     page_mask = (1ULL << (tt->granule_sz)) - 1;
     aligned_addr = addr & ~page_mask;
 
-    key.asid = cfg->asid;
-    key.iova = aligned_addr;
-
-    cached_entry = g_hash_table_lookup(bs->iotlb, &key);
+    cached_entry = smmu_iotlb_lookup(bs, cfg, aligned_addr);
     if (cached_entry) {
-        cfg->iotlb_hits++;
-        trace_smmu_iotlb_cache_hit(cfg->asid, aligned_addr,
-                                   cfg->iotlb_hits, cfg->iotlb_misses,
-                                   100 * cfg->iotlb_hits /
-                                   (cfg->iotlb_hits + cfg->iotlb_misses));
         if ((flag & IOMMU_WO) && !(cached_entry->perm & IOMMU_WO)) {
             status = SMMU_TRANS_ERROR;
             if (event.record_trans_faults) {
@@ -698,16 +689,6 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    cfg->iotlb_misses++;
-    trace_smmu_iotlb_cache_miss(cfg->asid, addr & ~page_mask,
-                                cfg->iotlb_hits, cfg->iotlb_misses,
-                                100 * cfg->iotlb_hits /
-                                (cfg->iotlb_hits + cfg->iotlb_misses));
-
-    if (g_hash_table_size(bs->iotlb) >= SMMU_IOTLB_MAX_SIZE) {
-        smmu_iotlb_inv_all(bs);
-    }
-
     cached_entry = g_new0(IOMMUTLBEntry, 1);
 
     if (smmu_ptw(cfg, aligned_addr, flag, cached_entry, &ptw_info)) {
@@ -753,10 +734,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         }
         status = SMMU_TRANS_ERROR;
     } else {
-        new_key = g_new0(SMMUIOTLBKey, 1);
-        new_key->asid = cfg->asid;
-        new_key->iova = aligned_addr;
-        g_hash_table_insert(bs->iotlb, new_key, cached_entry);
+        smmu_iotlb_insert(bs, cfg, cached_entry);
         status = SMMU_TRANS_SUCCESS;
     }
 
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 0acedcedc6f..b808a1bfc19 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -14,6 +14,9 @@ smmu_iotlb_inv_all(void) "IOTLB invalidate all"
 smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
 smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
+smmu_iotlb_lookup_hit(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
+smmu_iotlb_lookup_miss(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
+smmu_iotlb_insert(uint16_t asid, uint64_t addr) "IOTLB ++ asid=%d addr=0x%"PRIx64
 
 # smmuv3.c
 smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
@@ -46,8 +49,6 @@ smmuv3_cmdq_tlbi_nh_va(int vmid, int asid, uint64_t addr, bool leaf) "vmid =%d a
 smmuv3_cmdq_tlbi_nh_vaa(int vmid, uint64_t addr) "vmid =%d addr=0x%"PRIx64
 smmuv3_cmdq_tlbi_nh(void) ""
 smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
-smmu_iotlb_cache_hit(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
-smmu_iotlb_cache_miss(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid %d"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
-- 
2.20.1


