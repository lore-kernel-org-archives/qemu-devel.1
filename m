Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADE7C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB75206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEnuT282"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB75206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA96P-0006Hz-Lb
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95R-0004Wh-KC
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:36631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95P-0004m6-Ly
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id b66so5278064wmb.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Cd8R68ZHaSHKjZW8Eyk+WRcqwD95a7/z6Pb3IRpJdeQ=;
 b=FEnuT282UUff71LZudsWXsMrO+PPgdenvrQvGWsGB/ZmL7p9NReN9BEehBGomHnN42
 4DGY44Ec+2x9unxlN18/xLI3XCfmmrDprL5xtDVT5KPVXJD2/V5vfxamTsLw2ATad9Cp
 LouKrVoE/ZynEG9kRwSBb+i3j1thw5SwOE/gMOLwhbYN+c6mzqWP3owQA3lRRUBYePP8
 feiB0eqXZqmVt+TwKcfh3mm5uWCwffzK9ho52I1lD9ln30n4bNRV0oaey5CM8kR2pFfC
 BBm/8b3YTZE3t4MvJEGF0pJVH5TnluZN0kFx98I7POsHsU/xZwMRyVQ8HNh98KLBY70L
 FXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cd8R68ZHaSHKjZW8Eyk+WRcqwD95a7/z6Pb3IRpJdeQ=;
 b=qDfrQTmvzMmfewpLRWTYRpuBNSv0Z/MaHUNiC+rD4pWcV0NFW3f5n4bBmhhVrhECfA
 kS67Rb5w5WmSqSrVqjvH09Khl3coT5VamMsJ2tD7+bU3XND1Cm2swN1c1Mcgyh7oWzH1
 XxWrcEgF/SFHhHPZx9SdsD5fzygVWywCtFT8ZWdCjuk1HI9mgPOEnNKdKMHTm15Se2XC
 OKStycr7maCw5kPlUDXE8m9vSul0bBHOaoeW6hH0qnE/GlDjYMTPXpZzP8hMtLW5nSJO
 Oy5VNdaNSv5TbInNIvhD9HykJPtOYFf1cQKY8GKeQaQFTfmSWuyH8fJBVAm++/2jPGdB
 /EKQ==
X-Gm-Message-State: AOAM532RZX+iom40TVOlsG7qsoDG0MnWZX4/Ko9CXaH9JzoY9o5jJ6qq
 SMdbWO4HfHOoYhGqjEITDbXsY+ECFwi2CC+m
X-Google-Smtp-Source: ABdhPJz7ZA7izrTHcGtGdMnMIFLBPH3SSCHpXeXEmZuJTUI1dj0QomgDzvsE1TikbAY9USwIWLxAZQ==
X-Received: by 2002:a1c:2854:: with SMTP id o81mr4660083wmo.61.1598262497992; 
 Mon, 24 Aug 2020 02:48:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/27] hw/arm/smmu: Introduce smmu_get_iotlb_key()
Date: Mon, 24 Aug 2020 10:47:48 +0100
Message-Id: <20200824094811.15439-5-peter.maydell@linaro.org>
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

Introduce the smmu_get_iotlb_key() helper and the
SMMU_IOTLB_ASID() macro. Also move smmu_get_iotlb_key and
smmu_iotlb_key_hash in the IOTLB related code section.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200728150815.11446-4-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmu-internal.h       |  1 +
 include/hw/arm/smmu-common.h |  1 +
 hw/arm/smmu-common.c         | 66 ++++++++++++++++++++----------------
 3 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index 7794d6d3947..3104f768cd2 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -96,4 +96,5 @@ uint64_t iova_level_offset(uint64_t iova, int inputsize,
             MAKE_64BIT_MASK(0, gsz - 3);
 }
 
+#define SMMU_IOTLB_ASID(key) ((key).asid)
 #endif
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 1dceec5cb1f..5f9f3535d2a 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -155,6 +155,7 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
 
 IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg, hwaddr iova);
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry);
+SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
 void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova);
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index f3aa581f807..7dc8541e8b4 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -32,10 +32,42 @@
 
 /* IOTLB Management */
 
+static guint smmu_iotlb_key_hash(gconstpointer v)
+{
+    SMMUIOTLBKey *key = (SMMUIOTLBKey *)v;
+    uint32_t a, b, c;
+
+    /* Jenkins hash */
+    a = b = c = JHASH_INITVAL + sizeof(*key);
+    a += key->asid;
+    b += extract64(key->iova, 0, 32);
+    c += extract64(key->iova, 32, 32);
+
+    __jhash_mix(a, b, c);
+    __jhash_final(a, b, c);
+
+    return c;
+}
+
+static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
+{
+    const SMMUIOTLBKey *k1 = v1;
+    const SMMUIOTLBKey *k2 = v2;
+
+    return (k1->asid == k2->asid) && (k1->iova == k2->iova);
+}
+
+SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova)
+{
+    SMMUIOTLBKey key = {.asid = asid, .iova = iova};
+
+    return key;
+}
+
 IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
                                  hwaddr iova)
 {
-    SMMUIOTLBKey key = {.asid = cfg->asid, .iova = iova};
+    SMMUIOTLBKey key = smmu_get_iotlb_key(cfg->asid, iova);
     IOMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
 
     if (entry) {
@@ -62,8 +94,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, IOMMUTLBEntry *entry)
         smmu_iotlb_inv_all(bs);
     }
 
-    key->asid = cfg->asid;
-    key->iova = entry->iova;
+    *key = smmu_get_iotlb_key(cfg->asid, entry->iova);
     trace_smmu_iotlb_insert(cfg->asid, entry->iova);
     g_hash_table_insert(bs->iotlb, key, entry);
 }
@@ -80,12 +111,12 @@ static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
     uint16_t asid = *(uint16_t *)user_data;
     SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
 
-    return iotlb_key->asid == asid;
+    return SMMU_IOTLB_ASID(*iotlb_key) == asid;
 }
 
 inline void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova)
 {
-    SMMUIOTLBKey key = {.asid = asid, .iova = iova};
+    SMMUIOTLBKey key = smmu_get_iotlb_key(asid, iova);
 
     trace_smmu_iotlb_inv_iova(asid, iova);
     g_hash_table_remove(s->iotlb, &key);
@@ -383,31 +414,6 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid)
     return NULL;
 }
 
-static guint smmu_iotlb_key_hash(gconstpointer v)
-{
-    SMMUIOTLBKey *key = (SMMUIOTLBKey *)v;
-    uint32_t a, b, c;
-
-    /* Jenkins hash */
-    a = b = c = JHASH_INITVAL + sizeof(*key);
-    a += key->asid;
-    b += extract64(key->iova, 0, 32);
-    c += extract64(key->iova, 32, 32);
-
-    __jhash_mix(a, b, c);
-    __jhash_final(a, b, c);
-
-    return c;
-}
-
-static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
-{
-    const SMMUIOTLBKey *k1 = v1;
-    const SMMUIOTLBKey *k2 = v2;
-
-    return (k1->asid == k2->asid) && (k1->iova == k2->iova);
-}
-
 /* Unmap the whole notifier's range */
 static void smmu_unmap_notifier_range(IOMMUNotifier *n)
 {
-- 
2.20.1


