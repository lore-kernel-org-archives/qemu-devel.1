Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1E5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6CB2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSnA6cr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6CB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA997-0004V1-D8
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95U-0004fQ-Oa
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:24 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95S-0004ma-Ho
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:24 -0400
Received: by mail-wm1-x333.google.com with SMTP id x5so7696175wmi.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Ygr0uj6t9xPd8aCefwuAXcYRZVoEMDhVPJTRyZnGj00=;
 b=SSnA6cr11UTftlh7zaBK1WJbFKwuAFKOKrhIHSetDs+Ed+rT8fqp681VQrLhyLAlxa
 HNu+Lsu7fBnVhmuPtXVTsQzVgjAaLxB2kHbuEmX9InmMTBNUcs2SWtzIpqVjdJHaKjKS
 dBM5TbW4KaZOuo+byKKoUeizbbOqarMFe7tyhB6QTQcBFku0dnAtzE0by8QOLyFxKwM0
 qIPmTZLWZMwSxatuOZpZa/0sjnRzN/0v+056VCvDrPzweoR9SLuCfbSYQs04gas37BBT
 3DH1OSv0CyYQim4VaoeagS4KoeYkkHMfmh8CgFqqtMepldMAaXUGnm+j9oaog7c9aMdi
 hQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ygr0uj6t9xPd8aCefwuAXcYRZVoEMDhVPJTRyZnGj00=;
 b=dYUho7VNHSUSbbNmsbp6Nm1ORHzB1MJ9XKIwROlLdemjd34AjsP4k+nQc87eLHbMXF
 xaudbGJ91U4sCZQ4G9rUL5sYdcWSrPJzBhgndhzqWvbJMhKJTucgvfTwGtbw3ecophWb
 rUCK5ja7/CUoRAmsaOVssEAtIDFYn12Ygi41ElncvMArQVSFl0+tGTFgANrrfgoAmG1F
 nmIiOyEekdRq1lU3jPa/1uOcNDhFrzN1EANIh9zsFpo4OsFrUnFZrXB68sdi79q/LrvG
 fPTHeefhN6bI2xMtla+GpMwphhjkhH6Ep4f0tX/D49Q38++ZKfND2BRYRXmZ/ltbbVIA
 BVJQ==
X-Gm-Message-State: AOAM5316xxHeYkJggeqHvZlbaFZ07K6rJ2ZLFsZboQF88JhKvLrhFy/J
 ufDFvKANwZYXZ64rPmJtKkf1+BUOICCZXAdk
X-Google-Smtp-Source: ABdhPJxMNKT8kDLR7WoegoQcCNkjDDPFHeQo5j+WC898cos1HSUSJDPQCTN9nO6IcnmMyH6BJid4PQ==
X-Received: by 2002:a7b:c2e1:: with SMTP id e1mr961789wmk.27.1598262500754;
 Mon, 24 Aug 2020 02:48:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/27] hw/arm/smmu-common: Manage IOTLB block entries
Date: Mon, 24 Aug 2020 10:47:50 +0100
Message-Id: <20200824094811.15439-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

At the moment each entry in the IOTLB corresponds to a page sized
mapping (4K, 16K or 64K), even if the page belongs to a mapped
block. In case of block mapping this unefficiently consumes IOTLB
entries.

Change the value of the entry so that it reflects the actual
mapping it belongs to (block or page start address and size).

Also the level/tg of the entry is encoded in the key. In subsequent
patches we will enable range invalidation. This latter is able
to provide the level/tg of the entry.

Encoding the level/tg directly in the key will allow to invalidate
using g_hash_table_remove() when num_pages equals to 1.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200728150815.11446-6-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmu-internal.h       |  7 ++++
 include/hw/arm/smmu-common.h | 10 ++++--
 hw/arm/smmu-common.c         | 67 ++++++++++++++++++++++++++----------
 hw/arm/smmuv3.c              |  6 ++--
 hw/arm/trace-events          |  2 +-
 5 files changed, 67 insertions(+), 25 deletions(-)

diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index 3104f768cd2..55147f29be4 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -97,4 +97,11 @@ uint64_t iova_level_offset(uint64_t iova, int inputsize,
 }
 
 #define SMMU_IOTLB_ASID(key) ((key).asid)
+
+typedef struct SMMUIOTLBPageInvInfo {
+    int asid;
+    uint64_t iova;
+    uint64_t mask;
+} SMMUIOTLBPageInvInfo;
+
 #endif
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 79c2c6486ad..ece62c36523 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -97,6 +97,8 @@ typedef struct SMMUPciBus {
 typedef struct SMMUIOTLBKey {
     uint64_t iova;
     uint16_t asid;
+    uint8_t tg;
+    uint8_t level;
 } SMMUIOTLBKey;
 
 typedef struct SMMUState {
@@ -159,12 +161,14 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
 
 #define SMMU_IOTLB_MAX_SIZE 256
 
-SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg, hwaddr iova);
+SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
+                                SMMUTransTableInfo *tt, hwaddr iova);
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
-SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova);
+SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova,
+                                uint8_t tg, uint8_t level);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
-void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova);
+void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova);
 
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
 void smmu_inv_notifiers_all(SMMUState *s);
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 398e958bb44..2922deec6fc 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -39,7 +39,7 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
 
     /* Jenkins hash */
     a = b = c = JHASH_INITVAL + sizeof(*key);
-    a += key->asid;
+    a += key->asid + key->level + key->tg;
     b += extract64(key->iova, 0, 32);
     c += extract64(key->iova, 32, 32);
 
@@ -51,24 +51,41 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
 
 static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
 {
-    const SMMUIOTLBKey *k1 = v1;
-    const SMMUIOTLBKey *k2 = v2;
+    SMMUIOTLBKey *k1 = (SMMUIOTLBKey *)v1, *k2 = (SMMUIOTLBKey *)v2;
 
-    return (k1->asid == k2->asid) && (k1->iova == k2->iova);
+    return (k1->asid == k2->asid) && (k1->iova == k2->iova) &&
+           (k1->level == k2->level) && (k1->tg == k2->tg);
 }
 
-SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova)
+SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova,
+                                uint8_t tg, uint8_t level)
 {
-    SMMUIOTLBKey key = {.asid = asid, .iova = iova};
+    SMMUIOTLBKey key = {.asid = asid, .iova = iova, .tg = tg, .level = level};
 
     return key;
 }
 
 SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
-                                hwaddr iova)
+                                SMMUTransTableInfo *tt, hwaddr iova)
 {
-    SMMUIOTLBKey key = smmu_get_iotlb_key(cfg->asid, iova);
-    SMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
+    uint8_t tg = (tt->granule_sz - 10) / 2;
+    uint8_t inputsize = 64 - tt->tsz;
+    uint8_t stride = tt->granule_sz - 3;
+    uint8_t level = 4 - (inputsize - 4) / stride;
+    SMMUTLBEntry *entry = NULL;
+
+    while (level <= 3) {
+        uint64_t subpage_size = 1ULL << level_shift(level, tt->granule_sz);
+        uint64_t mask = subpage_size - 1;
+        SMMUIOTLBKey key;
+
+        key = smmu_get_iotlb_key(cfg->asid, iova & ~mask, tg, level);
+        entry = g_hash_table_lookup(bs->iotlb, &key);
+        if (entry) {
+            break;
+        }
+        level++;
+    }
 
     if (entry) {
         cfg->iotlb_hits++;
@@ -89,13 +106,14 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
 {
     SMMUIOTLBKey *key = g_new0(SMMUIOTLBKey, 1);
+    uint8_t tg = (new->granule - 10) / 2;
 
     if (g_hash_table_size(bs->iotlb) >= SMMU_IOTLB_MAX_SIZE) {
         smmu_iotlb_inv_all(bs);
     }
 
-    *key = smmu_get_iotlb_key(cfg->asid, new->entry.iova);
-    trace_smmu_iotlb_insert(cfg->asid, new->entry.iova);
+    *key = smmu_get_iotlb_key(cfg->asid, new->entry.iova, tg, new->level);
+    trace_smmu_iotlb_insert(cfg->asid, new->entry.iova, tg, new->level);
     g_hash_table_insert(bs->iotlb, key, new);
 }
 
@@ -114,12 +132,26 @@ static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
     return SMMU_IOTLB_ASID(*iotlb_key) == asid;
 }
 
-inline void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova)
+static gboolean smmu_hash_remove_by_asid_iova(gpointer key, gpointer value,
+                                              gpointer user_data)
 {
-    SMMUIOTLBKey key = smmu_get_iotlb_key(asid, iova);
+    SMMUTLBEntry *iter = (SMMUTLBEntry *)value;
+    IOMMUTLBEntry *entry = &iter->entry;
+    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
+    SMMUIOTLBKey iotlb_key = *(SMMUIOTLBKey *)key;
+
+    if (info->asid >= 0 && info->asid != SMMU_IOTLB_ASID(iotlb_key)) {
+        return false;
+    }
+    return (info->iova & ~entry->addr_mask) == entry->iova;
+}
+
+inline void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova)
+{
+    SMMUIOTLBPageInvInfo info = {.asid = asid, .iova = iova};
 
     trace_smmu_iotlb_inv_iova(asid, iova);
-    g_hash_table_remove(s->iotlb, &key);
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_iova, &info);
 }
 
 inline void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
@@ -246,9 +278,6 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
     baseaddr = extract64(tt->ttb, 0, 48);
     baseaddr &= ~indexmask;
 
-    tlbe->entry.iova = iova;
-    tlbe->entry.addr_mask = (1 << granule_sz) - 1;
-
     while (level <= 3) {
         uint64_t subpage_size = 1ULL << level_shift(level, granule_sz);
         uint64_t mask = subpage_size - 1;
@@ -298,7 +327,9 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
             goto error;
         }
 
-        tlbe->entry.translated_addr = gpa + (iova & mask);
+        tlbe->entry.translated_addr = gpa;
+        tlbe->entry.iova = iova & ~mask;
+        tlbe->entry.addr_mask = mask;
         tlbe->entry.perm = PTE_AP_TO_PERM(ap);
         tlbe->level = level;
         tlbe->granule = granule_sz;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index db74d27add5..b717bde8320 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -674,7 +674,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     page_mask = (1ULL << (tt->granule_sz)) - 1;
     aligned_addr = addr & ~page_mask;
 
-    cached_entry = smmu_iotlb_lookup(bs, cfg, aligned_addr);
+    cached_entry = smmu_iotlb_lookup(bs, cfg, tt, aligned_addr);
     if (cached_entry) {
         if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
             status = SMMU_TRANS_ERROR;
@@ -744,7 +744,7 @@ epilogue:
     case SMMU_TRANS_SUCCESS:
         entry.perm = flag;
         entry.translated_addr = cached_entry->entry.translated_addr +
-                                    (addr & page_mask);
+                                    (addr & cached_entry->entry.addr_mask);
         entry.addr_mask = cached_entry->entry.addr_mask;
         trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
                                        entry.translated_addr, entry.perm);
@@ -972,7 +972,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
 
             trace_smmuv3_cmdq_tlbi_nh_vaa(vmid, addr);
             smmuv3_inv_notifiers_iova(bs, -1, addr);
-            smmu_iotlb_inv_all(bs);
+            smmu_iotlb_inv_iova(bs, -1, addr);
             break;
         }
         case SMMU_CMD_TLBI_NH_VA:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index b808a1bfc19..f74d3e920f1 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -16,7 +16,7 @@ smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
 smmu_iotlb_lookup_hit(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
 smmu_iotlb_lookup_miss(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
-smmu_iotlb_insert(uint16_t asid, uint64_t addr) "IOTLB ++ asid=%d addr=0x%"PRIx64
+smmu_iotlb_insert(uint16_t asid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d addr=0x%"PRIx64" tg=%d level=%d"
 
 # smmuv3.c
 smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
-- 
2.20.1


