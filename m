Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E43C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:50:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646D12071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8Rzbdvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646D12071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA97h-00017i-JU
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95T-0004c8-M6
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:50541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95R-0004mP-9m
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id t2so7448283wma.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ArZ9QTqgUbPNGgXjOyzB+bi/eiKHbQx9hP7lHvaD3Rw=;
 b=M8Rzbdvf7HyCHjYUge4XdjczQ78OMpfRjAY0j/Surf2BvGX6EoR5rO3TdpKfZnkWOR
 qkDPVBhGxqHo1rqobVZ+8gV1CMcTeqT4jFxhUYUYMCMigbBvWRPcT2FcpDFcYTNkFJ5Y
 0BUdqN0k2wrKJevRjmQcLzb9D64ABNrr2Meu2xvUNMKxVExaa2YnPDILih27fY+HvtC0
 ZYTILYy/zQGgHy5us2Cy1fUqxtO10y0gI3Xu+nJNiFDa9xTBVR2GZEsJIAJPrGk24eg4
 F8dz5TfI3w8DUAUWQ3LiNzke8lHZhrgLbPmcJ+T8I2lavOmAoYCOV6NH7F3HnctzOQuQ
 XAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ArZ9QTqgUbPNGgXjOyzB+bi/eiKHbQx9hP7lHvaD3Rw=;
 b=HM/LjxtXn47cCFg3LxSPrU1KyxGwYNqJd433XKBlF+uaQ7w6iAL4pFwpcLLwXdSTkO
 mWD5uV45EllXj3YPbFP5w7Jzml8SBlz7953id4yG3zJt+kEaLj87Q4SdKF2lKIHZSk8Z
 +03euRGzOhv6WACcJHFiQ9hhTvMqZWx6KnZkdOIjAJMirTBKNbDne7V2UVOKvikefdKK
 vNrWCxlzY92yFgAsWVI5MEVbKzSFEPnUhIaijbexYe5/XT7WhdlefvnD71KUI0CrUUTQ
 lF17qmmqTULDR5mKNvvy2U/06v+VU7J7wxG3l9nuDpo/rQEn5abrImwNjY+rw28jsimY
 P5Jg==
X-Gm-Message-State: AOAM531hbXun5qcn4sinyxFTxSikQNZq1SF0lu+WalQsg1gndX9fvP9v
 TZ6zj0Vsm9c142HU7E6K2GsXdBzRLJOdrdfA
X-Google-Smtp-Source: ABdhPJwdkbKS8UjtZ5KQm4LOsibRDTkiJjgKziYGZ2K356MMjmyzk9S+V5KaOG8xscmYUVNK6uZuxw==
X-Received: by 2002:a7b:c251:: with SMTP id b17mr4757858wmj.148.1598262499255; 
 Mon, 24 Aug 2020 02:48:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/27] hw/arm/smmu: Introduce SMMUTLBEntry for PTW and IOTLB
 value
Date: Mon, 24 Aug 2020 10:47:49 +0100
Message-Id: <20200824094811.15439-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Introduce a specialized SMMUTLBEntry to store the result of
the PTW and cache in the IOTLB. This structure extends the
generic IOMMUTLBEntry struct with the level of the entry and
the granule size.

Those latter will be useful when implementing range invalidation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200728150815.11446-5-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h | 12 +++++++++---
 hw/arm/smmu-common.c         | 32 +++++++++++++++++---------------
 hw/arm/smmuv3.c              | 10 +++++-----
 3 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 5f9f3535d2a..79c2c6486ad 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -52,6 +52,12 @@ typedef struct SMMUTransTableInfo {
     uint8_t granule_sz;        /* granule page shift */
 } SMMUTransTableInfo;
 
+typedef struct SMMUTLBEntry {
+    IOMMUTLBEntry entry;
+    uint8_t level;
+    uint8_t granule;
+} SMMUTLBEntry;
+
 /*
  * Generic structure populated by derived SMMU devices
  * after decoding the configuration information and used as
@@ -140,7 +146,7 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
  * pair, according to @cfg translation config
  */
 int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
-             IOMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
+             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
 
 /**
  * select_tt - compute which translation table shall be used according to
@@ -153,8 +159,8 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
 
 #define SMMU_IOTLB_MAX_SIZE 256
 
-IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg, hwaddr iova);
-void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry);
+SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg, hwaddr iova);
+void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 7dc8541e8b4..398e958bb44 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -64,11 +64,11 @@ SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova)
     return key;
 }
 
-IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
-                                 hwaddr iova)
+SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
+                                hwaddr iova)
 {
     SMMUIOTLBKey key = smmu_get_iotlb_key(cfg->asid, iova);
-    IOMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
+    SMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
 
     if (entry) {
         cfg->iotlb_hits++;
@@ -86,7 +86,7 @@ IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
     return entry;
 }
 
-void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry)
+void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
 {
     SMMUIOTLBKey *key = g_new0(SMMUIOTLBKey, 1);
 
@@ -94,9 +94,9 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry)
         smmu_iotlb_inv_all(bs);
     }
 
-    *key = smmu_get_iotlb_key(cfg->asid, entry->iova);
-    trace_smmu_iotlb_insert(cfg->asid, entry->iova);
-    g_hash_table_insert(bs->iotlb, key, entry);
+    *key = smmu_get_iotlb_key(cfg->asid, new->entry.iova);
+    trace_smmu_iotlb_insert(cfg->asid, new->entry.iova);
+    g_hash_table_insert(bs->iotlb, key, new);
 }
 
 inline void smmu_iotlb_inv_all(SMMUState *s)
@@ -216,7 +216,7 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
  * @cfg: translation config
  * @iova: iova to translate
  * @perm: access type
- * @tlbe: IOMMUTLBEntry (out)
+ * @tlbe: SMMUTLBEntry (out)
  * @info: handle to an error info
  *
  * Return 0 on success, < 0 on error. In case of error, @info is filled
@@ -226,7 +226,7 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
  */
 static int smmu_ptw_64(SMMUTransCfg *cfg,
                        dma_addr_t iova, IOMMUAccessFlags perm,
-                       IOMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
+                       SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
     dma_addr_t baseaddr, indexmask;
     int stage = cfg->stage;
@@ -246,8 +246,8 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
     baseaddr = extract64(tt->ttb, 0, 48);
     baseaddr &= ~indexmask;
 
-    tlbe->iova = iova;
-    tlbe->addr_mask = (1 << granule_sz) - 1;
+    tlbe->entry.iova = iova;
+    tlbe->entry.addr_mask = (1 << granule_sz) - 1;
 
     while (level <= 3) {
         uint64_t subpage_size = 1ULL << level_shift(level, granule_sz);
@@ -298,14 +298,16 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
             goto error;
         }
 
-        tlbe->translated_addr = gpa + (iova & mask);
-        tlbe->perm = PTE_AP_TO_PERM(ap);
+        tlbe->entry.translated_addr = gpa + (iova & mask);
+        tlbe->entry.perm = PTE_AP_TO_PERM(ap);
+        tlbe->level = level;
+        tlbe->granule = granule_sz;
         return 0;
     }
     info->type = SMMU_PTW_ERR_TRANSLATION;
 
 error:
-    tlbe->perm = IOMMU_NONE;
+    tlbe->entry.perm = IOMMU_NONE;
     return -EINVAL;
 }
 
@@ -321,7 +323,7 @@ error:
  * return 0 on success
  */
 inline int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
-             IOMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
+                    SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
     if (!cfg->aa64) {
         /*
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index cd2a2e7e148..db74d27add5 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -626,7 +626,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUTranslationStatus status;
     SMMUState *bs = ARM_SMMU(s);
     uint64_t page_mask, aligned_addr;
-    IOMMUTLBEntry *cached_entry = NULL;
+    SMMUTLBEntry *cached_entry = NULL;
     SMMUTransTableInfo *tt;
     SMMUTransCfg *cfg = NULL;
     IOMMUTLBEntry entry = {
@@ -676,7 +676,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
 
     cached_entry = smmu_iotlb_lookup(bs, cfg, aligned_addr);
     if (cached_entry) {
-        if ((flag & IOMMU_WO) && !(cached_entry->perm & IOMMU_WO)) {
+        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
             status = SMMU_TRANS_ERROR;
             if (event.record_trans_faults) {
                 event.type = SMMU_EVT_F_PERMISSION;
@@ -689,7 +689,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    cached_entry = g_new0(IOMMUTLBEntry, 1);
+    cached_entry = g_new0(SMMUTLBEntry, 1);
 
     if (smmu_ptw(cfg, aligned_addr, flag, cached_entry, &ptw_info)) {
         g_free(cached_entry);
@@ -743,9 +743,9 @@ epilogue:
     switch (status) {
     case SMMU_TRANS_SUCCESS:
         entry.perm = flag;
-        entry.translated_addr = cached_entry->translated_addr +
+        entry.translated_addr = cached_entry->entry.translated_addr +
                                     (addr & page_mask);
-        entry.addr_mask = cached_entry->addr_mask;
+        entry.addr_mask = cached_entry->entry.addr_mask;
         trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
                                        entry.translated_addr, entry.perm);
         break;
-- 
2.20.1


