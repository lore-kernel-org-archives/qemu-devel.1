Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48985C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069D720706
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGeq8dyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069D720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqU1-0008Bw-2j
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4l-0003YL-Cr
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:53876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4j-0006ka-4p
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id j18so9160575wmi.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=iTxcqRTY2S8VoqFThsxJvyU7UjcgzSkRiFgzJQqGrww=;
 b=RGeq8dywDLjUmhWT3hmpLLp3igIU7QmJZIU8kNAntX4nioDTEgdesdaphcOQje9hzt
 +SadvKuw1ejgzLS+3ljFK2X8xd+oYNwOOjZyAvCNLPtIJzNqDdse/5vIfIZ/nEGnvrWd
 sE3tmzu2d92EFqc2TrEpJoAKHj61T95dKBxWP2S2sap0ZadbZXnVXkqvahC8taEOrW13
 LZ8a94rEch2u5mFuo5/DQpXOecrkQ2gyuI/Htvmq0uefYi98wYAptyJ3IOn5L0ethsBj
 u6hXYnLAYR9ruFn5sWyM0+wZmN3occwLDbU/BuSARHsqr4to6Se1rBV1bImf3fU9Up0p
 kw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iTxcqRTY2S8VoqFThsxJvyU7UjcgzSkRiFgzJQqGrww=;
 b=Puvb9bST/lFQnfbqBzEFJeo4sTQnC8Xxll1IpLXhtrXqKYVLPijeCJ+L01+ZTnNvP9
 0OMxaiS1Ui/LxhVdHVppLbVOfyf6pVCX0sVAEyfqCykulTXMJBoQW6cRycrz5ubjCTOp
 scP2RNJrR0qfzx6qLccMjgSbbjEMbNgxsksCUcBwMoRbFFucbfppKcRWw4vOBwDk4VyY
 KdJnFNtt3RaUIywvv+ZL5eDG9yfCGjSmxUzaWhfE3BDL71du0UqLah7t+YxcO5msH4Os
 6fStQsUwj8FTlUKzT0649MEsvWTuFmJ1JpGmxgOdf5eFUgx1Vmo1OJoGZ7NRJCdXVLkT
 Ka3w==
X-Gm-Message-State: AOAM532XAlViNeNFixhOwmtIHf8K2O5m+OcgOHlh6h2NyVG9Uc+n6+j1
 4RWzH9B4v2E+UywkhQVzk3mif8GQfbxYkw==
X-Google-Smtp-Source: ABdhPJzmG9f8683z7PSB/p/cDCtbsWp7B19cGSdfuq4Gi4DZjecBUj2D9lr5bJe12u5piHZo6ObuHQ==
X-Received: by 2002:a1c:d5:: with SMTP id 204mr3874988wma.174.1593184531457;
 Fri, 26 Jun 2020 08:15:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/57] target/arm: Always pass cacheattr to get_phys_addr
Date: Fri, 26 Jun 2020 16:14:20 +0100
Message-Id: <20200626151424.30117-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Richard Henderson <richard.henderson@linaro.org>

We need to check the memattr of a page in order to determine
whether it is Tagged for MTE.  Between Stage1 and Stage2,
this becomes simpler if we always collect this data, instead
of occasionally being presented with NULL.

Use the nonnull attribute to allow the compiler to check that
all pointer arguments are non-null.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-42-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h  |  3 ++-
 target/arm/helper.c     | 60 ++++++++++++++++++++---------------------
 target/arm/m_helper.c   | 11 +++++---
 target/arm/tlb_helper.c |  4 ++-
 4 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 3306c4f8292..ae99725d2b5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1294,7 +1294,8 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                    MMUAccessType access_type, ARMMMUIdx mmu_idx,
                    hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
                    target_ulong *page_size,
-                   ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs);
+                   ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
+    __attribute__((nonnull));
 
 void arm_log_exception(int idx);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d220612a201..2072db2f92d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -44,7 +44,8 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
                                bool s1_is_el0,
                                hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
                                target_ulong *page_size_ptr,
-                               ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs);
+                               ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
+    __attribute__((nonnull));
 #endif
 
 static void switch_mode(CPUARMState *env, int mode);
@@ -11101,19 +11102,16 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         arm_tlb_bti_gp(txattrs) = true;
     }
 
-    if (cacheattrs != NULL) {
-        if (mmu_idx == ARMMMUIdx_Stage2) {
-            cacheattrs->attrs = convert_stage2_attrs(env,
-                                                     extract32(attrs, 0, 4));
-        } else {
-            /* Index into MAIR registers for cache attributes */
-            uint8_t attrindx = extract32(attrs, 0, 3);
-            uint64_t mair = env->cp15.mair_el[regime_el(env, mmu_idx)];
-            assert(attrindx <= 7);
-            cacheattrs->attrs = extract64(mair, attrindx * 8, 8);
-        }
-        cacheattrs->shareability = extract32(attrs, 6, 2);
+    if (mmu_idx == ARMMMUIdx_Stage2) {
+        cacheattrs->attrs = convert_stage2_attrs(env, extract32(attrs, 0, 4));
+    } else {
+        /* Index into MAIR registers for cache attributes */
+        uint8_t attrindx = extract32(attrs, 0, 3);
+        uint64_t mair = env->cp15.mair_el[regime_el(env, mmu_idx)];
+        assert(attrindx <= 7);
+        cacheattrs->attrs = extract64(mair, attrindx * 8, 8);
     }
+    cacheattrs->shareability = extract32(attrs, 6, 2);
 
     *phys_ptr = descaddr;
     *page_size_ptr = page_size;
@@ -11948,28 +11946,29 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
             ret = get_phys_addr_lpae(env, ipa, access_type, ARMMMUIdx_Stage2,
                                      mmu_idx == ARMMMUIdx_E10_0,
                                      phys_ptr, attrs, &s2_prot,
-                                     page_size, fi,
-                                     cacheattrs != NULL ? &cacheattrs2 : NULL);
+                                     page_size, fi, &cacheattrs2);
             fi->s2addr = ipa;
             /* Combine the S1 and S2 perms.  */
             *prot &= s2_prot;
 
-            /* Combine the S1 and S2 cache attributes, if needed */
-            if (!ret && cacheattrs != NULL) {
-                if (env->cp15.hcr_el2 & HCR_DC) {
-                    /*
-                     * HCR.DC forces the first stage attributes to
-                     *  Normal Non-Shareable,
-                     *  Inner Write-Back Read-Allocate Write-Allocate,
-                     *  Outer Write-Back Read-Allocate Write-Allocate.
-                     */
-                    cacheattrs->attrs = 0xff;
-                    cacheattrs->shareability = 0;
-                }
-                *cacheattrs = combine_cacheattrs(*cacheattrs, cacheattrs2);
+            /* If S2 fails, return early.  */
+            if (ret) {
+                return ret;
             }
 
-            return ret;
+            /* Combine the S1 and S2 cache attributes. */
+            if (env->cp15.hcr_el2 & HCR_DC) {
+                /*
+                 * HCR.DC forces the first stage attributes to
+                 *  Normal Non-Shareable,
+                 *  Inner Write-Back Read-Allocate Write-Allocate,
+                 *  Outer Write-Back Read-Allocate Write-Allocate.
+                 */
+                cacheattrs->attrs = 0xff;
+                cacheattrs->shareability = 0;
+            }
+            *cacheattrs = combine_cacheattrs(*cacheattrs, cacheattrs2);
+            return 0;
         } else {
             /*
              * For non-EL2 CPUs a stage1+stage2 translation is just stage 1.
@@ -12094,11 +12093,12 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     bool ret;
     ARMMMUFaultInfo fi = {};
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    ARMCacheAttrs cacheattrs = {};
 
     *attrs = (MemTxAttrs) {};
 
     ret = get_phys_addr(env, addr, 0, mmu_idx, &phys_addr,
-                        attrs, &prot, &page_size, &fi, NULL);
+                        attrs, &prot, &page_size, &fi, &cacheattrs);
 
     if (ret) {
         return -1;
diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 5e8a795d202..036454234c7 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -187,12 +187,13 @@ static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
     hwaddr physaddr;
     int prot;
     ARMMMUFaultInfo fi = {};
+    ARMCacheAttrs cacheattrs = {};
     bool secure = mmu_idx & ARM_MMU_IDX_M_S;
     int exc;
     bool exc_secure;
 
     if (get_phys_addr(env, addr, MMU_DATA_STORE, mmu_idx, &physaddr,
-                      &attrs, &prot, &page_size, &fi, NULL)) {
+                      &attrs, &prot, &page_size, &fi, &cacheattrs)) {
         /* MPU/SAU lookup failed */
         if (fi.type == ARMFault_QEMU_SFault) {
             if (mode == STACK_LAZYFP) {
@@ -279,13 +280,14 @@ static bool v7m_stack_read(ARMCPU *cpu, uint32_t *dest, uint32_t addr,
     hwaddr physaddr;
     int prot;
     ARMMMUFaultInfo fi = {};
+    ARMCacheAttrs cacheattrs = {};
     bool secure = mmu_idx & ARM_MMU_IDX_M_S;
     int exc;
     bool exc_secure;
     uint32_t value;
 
     if (get_phys_addr(env, addr, MMU_DATA_LOAD, mmu_idx, &physaddr,
-                      &attrs, &prot, &page_size, &fi, NULL)) {
+                      &attrs, &prot, &page_size, &fi, &cacheattrs)) {
         /* MPU/SAU lookup failed */
         if (fi.type == ARMFault_QEMU_SFault) {
             qemu_log_mask(CPU_LOG_INT,
@@ -1928,6 +1930,7 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx,
     V8M_SAttributes sattrs = {};
     MemTxAttrs attrs = {};
     ARMMMUFaultInfo fi = {};
+    ARMCacheAttrs cacheattrs = {};
     MemTxResult txres;
     target_ulong page_size;
     hwaddr physaddr;
@@ -1945,8 +1948,8 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx,
                       "...really SecureFault with SFSR.INVEP\n");
         return false;
     }
-    if (get_phys_addr(env, addr, MMU_INST_FETCH, mmu_idx,
-                      &physaddr, &attrs, &prot, &page_size, &fi, NULL)) {
+    if (get_phys_addr(env, addr, MMU_INST_FETCH, mmu_idx, &physaddr,
+                      &attrs, &prot, &page_size, &fi, &cacheattrs)) {
         /* the MPU lookup failed */
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_IACCVIOL_MASK;
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM, env->v7m.secure);
diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index 522a6442a48..89d90465a32 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -166,6 +166,7 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     int prot, ret;
     MemTxAttrs attrs = {};
     ARMMMUFaultInfo fi = {};
+    ARMCacheAttrs cacheattrs = {};
 
     /*
      * Walk the page table and (if the mapping exists) add the page
@@ -175,7 +176,8 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
      */
     ret = get_phys_addr(&cpu->env, address, access_type,
                         core_to_arm_mmu_idx(&cpu->env, mmu_idx),
-                        &phys_addr, &attrs, &prot, &page_size, &fi, NULL);
+                        &phys_addr, &attrs, &prot, &page_size,
+                        &fi, &cacheattrs);
     if (likely(!ret)) {
         /*
          * Map a single [sub]page. Regions smaller than our declared
-- 
2.20.1


