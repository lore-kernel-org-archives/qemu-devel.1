Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFC0C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9493A20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9493A20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw4Pf-0005s5-HT
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 08:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52865)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hw4Jp-0001kF-QG
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hw4Jn-00018b-7a
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:52455 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hw4Jm-00017q-Oi
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:27 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 9E3C71A20B4;
 Fri,  9 Aug 2019 14:48:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 79F591A2028;
 Fri,  9 Aug 2019 14:48:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 14:46:37 +0200
Message-Id: <1565354819-1495-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565354819-1495-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1565354819-1495-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH for 4.2 v7 04/26] target/mips: Add support for
 emulation of GINVT instruction
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
Cc: arikalo@wavecomp.com, Yongbok Kim <yongbok.kim@mips.com>, philmd@redhat.com,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yongbok Kim <yongbok.kim@mips.com>

Implement emulation of GINVT instruction. As QEMU doesn't support
caches and virtualization, this implementation covers only GINVT
(Global Invalidate TLB) instruction among TLB-related instructions.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/mips.c            |   2 +
 target/mips/helper.c    |  24 ++++++++--
 target/mips/helper.h    |   2 +
 target/mips/internal.h  |   1 +
 target/mips/op_helper.c | 122 ++++++++++++++++++++++++++++++++++++++++++------
 target/mips/translate.c |  48 ++++++++++++++++++-
 6 files changed, 177 insertions(+), 22 deletions(-)

diff --git a/disas/mips.c b/disas/mips.c
index dfefe5e..c3a3059 100644
--- a/disas/mips.c
+++ b/disas/mips.c
@@ -1409,6 +1409,8 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"dvp",        "t",     0x41600024, 0xffe0ffff, TRAP|WR_t,            0, I32R6},
 {"evp",        "",      0x41600004, 0xffffffff, TRAP,                 0, I32R6},
 {"evp",        "t",     0x41600004, 0xffe0ffff, TRAP|WR_t,            0, I32R6},
+{"ginvi",      "v",     0x7c00003d, 0xfc1ffcff, TRAP | INSN_TLB,      0, I32R6},
+{"ginvt",      "v",     0x7c0000bd, 0xfc1ffcff, TRAP | INSN_TLB,      0, I32R6},
 
 /* MSA */
 {"sll.b",   "+d,+e,+f", 0x7800000d, 0xffe0003f, WR_VD|RD_VS|RD_VT,  0, MSA},
diff --git a/target/mips/helper.c b/target/mips/helper.c
index a2b6459..6e583d3 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -70,7 +70,12 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
                      target_ulong address, int rw, int access_type)
 {
     uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    uint32_t MMID = env->CP0_MemoryMapID;
+    bool mi = !!((env->CP0_Config5 >> CP0C5_MI) & 1);
     int i;
+    uint32_t tlb_mmid;
+
+    MMID = mi ? MMID : (uint32_t) ASID;
 
     for (i = 0; i < env->tlb->tlb_in_use; i++) {
         r4k_tlb_t *tlb = &env->tlb->mmu.r4k.tlb[i];
@@ -82,8 +87,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
         tag &= env->SEGMask;
 #endif
 
-        /* Check ASID, virtual page number & size */
-        if ((tlb->G == 1 || tlb->ASID == ASID) && VPN == tag && !tlb->EHINV) {
+        /* Check ASID/MMID, virtual page number & size */
+        tlb_mmid = mi ? tlb->MMID : (uint32_t) tlb->ASID;
+        if ((tlb->G == 1 || tlb_mmid == MMID) && VPN == tag && !tlb->EHINV) {
             /* TLB match */
             int n = !!(address & mask & ~(mask >> 1));
             /* Check access rights */
@@ -1397,12 +1403,20 @@ void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra)
     target_ulong addr;
     target_ulong end;
     uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    uint32_t MMID = env->CP0_MemoryMapID;
     target_ulong mask;
+    bool mi = !!((env->CP0_Config5 >> CP0C5_MI) & 1);
+    uint32_t tlb_mmid;
+
+    MMID = mi ? MMID : (uint32_t) ASID;
 
     tlb = &env->tlb->mmu.r4k.tlb[idx];
-    /* The qemu TLB is flushed when the ASID changes, so no need to
-       flush these entries again.  */
-    if (tlb->G == 0 && tlb->ASID != ASID) {
+    /*
+     * The qemu TLB is flushed when the ASID/MMID changes, so no need to
+     * flush these entries again.
+     */
+    tlb_mmid = mi ? tlb->MMID : (uint32_t) tlb->ASID;
+    if (tlb->G == 0 && tlb_mmid != MMID) {
         return;
     }
 
diff --git a/target/mips/helper.h b/target/mips/helper.h
index aad0951..c7d35bd 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -120,6 +120,7 @@ DEF_HELPER_2(mtc0_tcschefback, void, env, tl)
 DEF_HELPER_2(mttc0_tcschefback, void, env, tl)
 DEF_HELPER_2(mtc0_entrylo1, void, env, tl)
 DEF_HELPER_2(mtc0_context, void, env, tl)
+DEF_HELPER_2(mtc0_memorymapid, void, env, tl)
 DEF_HELPER_2(mtc0_pagemask, void, env, tl)
 DEF_HELPER_2(mtc0_pagegrain, void, env, tl)
 DEF_HELPER_2(mtc0_segctl0, void, env, tl)
@@ -376,6 +377,7 @@ DEF_HELPER_1(ei, tl, env)
 DEF_HELPER_1(eret, void, env)
 DEF_HELPER_1(eretnc, void, env)
 DEF_HELPER_1(deret, void, env)
+DEF_HELPER_3(ginvt, void, env, tl, i32)
 #endif /* !CONFIG_USER_ONLY */
 DEF_HELPER_1(rdhwr_cpunum, tl, env)
 DEF_HELPER_1(rdhwr_synci_step, tl, env)
diff --git a/target/mips/internal.h b/target/mips/internal.h
index f6d0d7a..d9216fb 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -92,6 +92,7 @@ struct r4k_tlb_t {
     target_ulong VPN;
     uint32_t PageMask;
     uint16_t ASID;
+    uint32_t MMID;
     unsigned int G:1;
     unsigned int C0:3;
     unsigned int C1:3;
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 279b800..3104904 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1409,6 +1409,17 @@ void helper_mtc0_context(CPUMIPSState *env, target_ulong arg1)
     env->CP0_Context = (env->CP0_Context & 0x007FFFFF) | (arg1 & ~0x007FFFFF);
 }
 
+void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
+{
+    int32_t old;
+    old = env->CP0_MemoryMapID;
+    env->CP0_MemoryMapID = (int32_t) arg1;
+    /* If the MemoryMapID changes, flush qemu's TLB.  */
+    if (old != env->CP0_MemoryMapID) {
+        cpu_mips_tlb_flush(env);
+    }
+}
+
 void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
 {
     uint64_t mask = arg1 >> (TARGET_PAGE_BITS + 1);
@@ -1857,6 +1868,8 @@ void helper_mtc0_config5(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_Config5 = (env->CP0_Config5 & (~env->CP0_Config5_rw_bitmask)) |
                        (arg1 & env->CP0_Config5_rw_bitmask);
+    env->CP0_EntryHi_ASID_mask = (env->CP0_Config5 & (1 << CP0C5_MI)) ? 0x0 :
+                        (env->CP0_Config4 & (1 << CP0C4_AE)) ? 0x3ff : 0xff;
     compute_hflags(env);
 }
 
@@ -2276,6 +2289,7 @@ static void r4k_fill_tlb(CPUMIPSState *env, int idx)
     tlb->VPN &= env->SEGMask;
 #endif
     tlb->ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    tlb->MMID = env->CP0_MemoryMapID;
     tlb->PageMask = env->CP0_PageMask;
     tlb->G = env->CP0_EntryLo0 & env->CP0_EntryLo1 & 1;
     tlb->V0 = (env->CP0_EntryLo0 & 2) != 0;
@@ -2294,13 +2308,18 @@ static void r4k_fill_tlb(CPUMIPSState *env, int idx)
 
 void r4k_helper_tlbinv(CPUMIPSState *env)
 {
+    bool mi = !!((env->CP0_Config5 >> CP0C5_MI) & 1);
     int idx;
     r4k_tlb_t *tlb;
     uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    uint32_t MMID = env->CP0_MemoryMapID;
+    uint32_t tlb_mmid;
 
+    MMID = mi ? MMID : (uint32_t) ASID;
     for (idx = 0; idx < env->tlb->nb_tlb; idx++) {
         tlb = &env->tlb->mmu.r4k.tlb[idx];
-        if (!tlb->G && tlb->ASID == ASID) {
+        tlb_mmid = mi ? tlb->MMID : (uint32_t) tlb->ASID;
+        if (!tlb->G && tlb_mmid == MMID) {
             tlb->EHINV = 1;
         }
     }
@@ -2319,11 +2338,16 @@ void r4k_helper_tlbinvf(CPUMIPSState *env)
 
 void r4k_helper_tlbwi(CPUMIPSState *env)
 {
+    bool mi = !!((env->CP0_Config5 >> CP0C5_MI) & 1);
     r4k_tlb_t *tlb;
     int idx;
     target_ulong VPN;
-    uint16_t ASID;
     bool EHINV, G, V0, D0, V1, D1, XI0, XI1, RI0, RI1;
+    uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    uint32_t MMID = env->CP0_MemoryMapID;
+    uint32_t tlb_mmid;
+
+    MMID = mi ? MMID : (uint32_t) ASID;
 
     idx = (env->CP0_Index & ~0x80000000) % env->tlb->nb_tlb;
     tlb = &env->tlb->mmu.r4k.tlb[idx];
@@ -2331,7 +2355,6 @@ void r4k_helper_tlbwi(CPUMIPSState *env)
 #if defined(TARGET_MIPS64)
     VPN &= env->SEGMask;
 #endif
-    ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
     EHINV = (env->CP0_EntryHi & (1 << CP0EnHi_EHINV)) != 0;
     G = env->CP0_EntryLo0 & env->CP0_EntryLo1 & 1;
     V0 = (env->CP0_EntryLo0 & 2) != 0;
@@ -2343,9 +2366,10 @@ void r4k_helper_tlbwi(CPUMIPSState *env)
     XI1 = (env->CP0_EntryLo1 >> CP0EnLo_XI) &1;
     RI1 = (env->CP0_EntryLo1 >> CP0EnLo_RI) &1;
 
+    tlb_mmid = mi ? tlb->MMID : (uint32_t) tlb->ASID;
     /* Discard cached TLB entries, unless tlbwi is just upgrading access
        permissions on the current entry. */
-    if (tlb->VPN != VPN || tlb->ASID != ASID || tlb->G != G ||
+    if (tlb->VPN != VPN || tlb_mmid != MMID || tlb->G != G ||
         (!tlb->EHINV && EHINV) ||
         (tlb->V0 && !V0) || (tlb->D0 && !D0) ||
         (!tlb->XI0 && XI0) || (!tlb->RI0 && RI0) ||
@@ -2368,14 +2392,17 @@ void r4k_helper_tlbwr(CPUMIPSState *env)
 
 void r4k_helper_tlbp(CPUMIPSState *env)
 {
+    bool mi = !!((env->CP0_Config5 >> CP0C5_MI) & 1);
     r4k_tlb_t *tlb;
     target_ulong mask;
     target_ulong tag;
     target_ulong VPN;
-    uint16_t ASID;
     int i;
+    uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    uint32_t MMID = env->CP0_MemoryMapID;
+    uint32_t tlb_mmid;
 
-    ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    MMID = mi ? MMID : (uint32_t) ASID;
     for (i = 0; i < env->tlb->nb_tlb; i++) {
         tlb = &env->tlb->mmu.r4k.tlb[i];
         /* 1k pages are not supported. */
@@ -2385,8 +2412,9 @@ void r4k_helper_tlbp(CPUMIPSState *env)
 #if defined(TARGET_MIPS64)
         tag &= env->SEGMask;
 #endif
-        /* Check ASID, virtual page number & size */
-        if ((tlb->G == 1 || tlb->ASID == ASID) && VPN == tag && !tlb->EHINV) {
+        tlb_mmid = mi ? tlb->MMID : (uint32_t) tlb->ASID;
+        /* Check ASID/MMID, virtual page number & size */
+        if ((tlb->G == 1 || tlb_mmid == MMID) && VPN == tag && !tlb->EHINV) {
             /* TLB match */
             env->CP0_Index = i;
             break;
@@ -2403,8 +2431,9 @@ void r4k_helper_tlbp(CPUMIPSState *env)
 #if defined(TARGET_MIPS64)
             tag &= env->SEGMask;
 #endif
-            /* Check ASID, virtual page number & size */
-            if ((tlb->G == 1 || tlb->ASID == ASID) && VPN == tag) {
+            tlb_mmid = mi ? tlb->MMID : (uint32_t) tlb->ASID;
+            /* Check ASID/MMID, virtual page number & size */
+            if ((tlb->G == 1 || tlb_mmid == MMID) && VPN == tag) {
                 r4k_mips_tlb_flush_extra (env, i);
                 break;
             }
@@ -2426,17 +2455,22 @@ static inline uint64_t get_entrylo_pfn_from_tlb(uint64_t tlb_pfn)
 
 void r4k_helper_tlbr(CPUMIPSState *env)
 {
+    bool mi = !!((env->CP0_Config5 >> CP0C5_MI) & 1);
     r4k_tlb_t *tlb;
-    uint16_t ASID;
     int idx;
+    uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    uint32_t MMID = env->CP0_MemoryMapID;
+    uint32_t tlb_mmid;
 
-    ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    MMID = mi ? MMID : (uint32_t) ASID;
     idx = (env->CP0_Index & ~0x80000000) % env->tlb->nb_tlb;
     tlb = &env->tlb->mmu.r4k.tlb[idx];
 
-    /* If this will change the current ASID, flush qemu's TLB.  */
-    if (ASID != tlb->ASID)
+    tlb_mmid = mi ? tlb->MMID : (uint32_t) tlb->ASID;
+    /* If this will change the current ASID/MMID, flush qemu's TLB.  */
+    if (MMID != tlb_mmid) {
         cpu_mips_tlb_flush(env);
+    }
 
     r4k_mips_tlb_flush_extra(env, env->tlb->nb_tlb);
 
@@ -2446,7 +2480,8 @@ void r4k_helper_tlbr(CPUMIPSState *env)
         env->CP0_EntryLo0 = 0;
         env->CP0_EntryLo1 = 0;
     } else {
-        env->CP0_EntryHi = tlb->VPN | tlb->ASID;
+        env->CP0_EntryHi = mi ? tlb->VPN : tlb->VPN | tlb->ASID;
+        env->CP0_MemoryMapID = tlb->MMID;
         env->CP0_PageMask = tlb->PageMask;
         env->CP0_EntryLo0 = tlb->G | (tlb->V0 << 1) | (tlb->D0 << 2) |
                         ((uint64_t)tlb->RI0 << CP0EnLo_RI) |
@@ -2489,6 +2524,63 @@ void helper_tlbinvf(CPUMIPSState *env)
     env->tlb->helper_tlbinvf(env);
 }
 
+static void global_invalidate_tlb(CPUMIPSState *env,
+                           uint32_t invMsgVPN2,
+                           uint8_t invMsgR,
+                           uint32_t invMsgMMid,
+                           bool invAll,
+                           bool invVAMMid,
+                           bool invMMid,
+                           bool invVA)
+{
+
+    int idx;
+    r4k_tlb_t *tlb;
+    bool VAMatch;
+    bool MMidMatch;
+
+    for (idx = 0; idx < env->tlb->nb_tlb; idx++) {
+        tlb = &env->tlb->mmu.r4k.tlb[idx];
+        VAMatch =
+            (((tlb->VPN & ~tlb->PageMask) == (invMsgVPN2 & ~tlb->PageMask))
+#ifdef TARGET_MIPS64
+            &&
+            (extract64(env->CP0_EntryHi, 62, 2) == invMsgR)
+#endif
+            );
+        MMidMatch = tlb->MMID == invMsgMMid;
+        if ((invAll && (idx > env->CP0_Wired)) ||
+            (VAMatch && invVAMMid && (tlb->G || MMidMatch)) ||
+            (VAMatch && invVA) ||
+            (MMidMatch && !(tlb->G) && invMMid)) {
+            tlb->EHINV = 1;
+        }
+    }
+    cpu_mips_tlb_flush(env);
+}
+
+void helper_ginvt(CPUMIPSState *env, target_ulong arg, uint32_t type)
+{
+    bool invAll = type == 0;
+    bool invVA = type == 1;
+    bool invMMid = type == 2;
+    bool invVAMMid = type == 3;
+    uint32_t invMsgVPN2 = arg & (TARGET_PAGE_MASK << 1);
+    uint8_t invMsgR = 0;
+    uint32_t invMsgMMid = env->CP0_MemoryMapID;
+    CPUState *other_cs = first_cpu;
+
+#ifdef TARGET_MIPS64
+    invMsgR = extract64(arg, 62, 2);
+#endif
+
+    CPU_FOREACH(other_cs) {
+        MIPSCPU *other_cpu = MIPS_CPU(other_cs);
+        global_invalidate_tlb(&other_cpu->env, invMsgVPN2, invMsgR, invMsgMMid,
+                              invAll, invVAMMid, invMMid, invVA);
+    }
+}
+
 /* Specials */
 target_ulong helper_di(CPUMIPSState *env)
 {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index b40468d..3f73be0 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -388,6 +388,7 @@ enum {
     OPC_BSHFL    = 0x20 | OPC_SPECIAL3,
     OPC_DBSHFL   = 0x24 | OPC_SPECIAL3,
     OPC_RDHWR    = 0x3B | OPC_SPECIAL3,
+    OPC_GINV     = 0x3D | OPC_SPECIAL3,
 
     /* Loongson 2E */
     OPC_MULT_G_2E   = 0x18 | OPC_SPECIAL3,
@@ -2548,6 +2549,7 @@ typedef struct DisasContext {
     bool abs2008;
     bool saar;
     bool mi;
+    int gi;
 } DisasContext;
 
 #define DISAS_STOP       DISAS_TARGET_0
@@ -7027,6 +7029,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             tcg_gen_ext32s_tl(arg, arg);
             register_name = "UserLocal";
             break;
+        case 5:
+            CP0_CHECK(ctx->mi);
+            gen_helper_mtc0_memorymapid(cpu_env, arg);
+            register_name = "MemoryMapID";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7763,6 +7770,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
             register_name = "UserLocal";
             break;
+        case 5:
+            CP0_CHECK(ctx->mi);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_MemoryMapID));
+            register_name = "MemoryMapID";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -8509,6 +8521,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
             register_name = "UserLocal";
             break;
+        case 5:
+            CP0_CHECK(ctx->mi);
+            gen_helper_mtc0_memorymapid(cpu_env, arg);
+            register_name = "MemoryMapID";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -9225,6 +9242,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
             register_name = "UserLocal";
             break;
+        case 5:
+            CP0_CHECK(ctx->mi);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_MemoryMapID));
+            register_name = "MemoryMapID";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -27072,6 +27094,27 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
             }
         }
         break;
+#ifndef CONFIG_USER_ONLY
+    case OPC_GINV:
+        if (unlikely(ctx->gi <= 1)) {
+            generate_exception_end(ctx, EXCP_RI);
+        }
+        check_cp0_enabled(ctx);
+        switch ((ctx->opcode >> 6) & 3) {
+        case 0:
+            /* GINVI */
+            /* Treat as NOP. */
+            break;
+        case 2:
+            /* GINVT */
+            gen_helper_0e1i(ginvt, cpu_gpr[rs], extract32(ctx->opcode, 8, 2));
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+#endif
 #if defined(TARGET_MIPS64)
     case R6_OPC_SCD:
         gen_st_cond(ctx, rt, rs, imm, MO_TEQ, false);
@@ -30005,6 +30048,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
     ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
     ctx->mi = (env->CP0_Config5 >> CP0C5_MI) & 1;
+    ctx->gi = (env->CP0_Config5 >> CP0C5_GI) & 3;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx = MIPS_HFLAG_UM;
@@ -30464,8 +30508,8 @@ void cpu_state_reset(CPUMIPSState *env)
     if (env->CP0_Config3 & (1 << CP0C3_CMGCR)) {
         env->CP0_CMGCRBase = 0x1fbf8000 >> 4;
     }
-    env->CP0_EntryHi_ASID_mask = (env->CP0_Config4 & (1 << CP0C4_AE)) ?
-                                 0x3ff : 0xff;
+    env->CP0_EntryHi_ASID_mask = (env->CP0_Config5 & (1 << CP0C5_MI)) ? 0x0 :
+                        (env->CP0_Config4 & (1 << CP0C4_AE)) ? 0x3ff : 0xff;
     env->CP0_Status = (1 << CP0St_BEV) | (1 << CP0St_ERL);
     /*
      * Vectored interrupts not implemented, timer on int 7,
-- 
2.7.4


