Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FE4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B190B2087F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B190B2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwXLi-00070Z-Rp
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 15:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iwXKf-0005Mq-VM
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iwXKd-0001BC-Af
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:19:33 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:41528 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iwXKc-0006g7-Q7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:19:31 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 1E3A71A2020;
 Tue, 28 Jan 2020 21:10:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 01EC81A1E9A;
 Tue, 28 Jan 2020 21:10:02 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] target/mips: Add implementation of GINVT instruction
Date: Tue, 28 Jan 2020 21:09:21 +0100
Message-Id: <1580242161-20333-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580242161-20333-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580242161-20333-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, Yongbok Kim <yongbok.kim@mips.com>,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yongbok Kim <yongbok.kim@mips.com>

Implement emulation of GINVT instruction. As QEMU doesn't support
caches and virtualization, this implementation covers only one
instruction (GINVT - Global Invalidate TLB) among all TLB-related
MIPS instructions.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1579883929-1517-5-git-send-email-aleksandar.markovic@rt-rk.com>
---
 disas/mips.c            |  10 ++++
 target/mips/cpu.h       |   2 +-
 target/mips/helper.c    |  20 ++++++--
 target/mips/helper.h    |   2 +
 target/mips/internal.h  |   1 +
 target/mips/op_helper.c | 129 +++++++++++++++++++++++++++++++++++++++++-------
 target/mips/translate.c |  46 ++++++++++++++++-
 7 files changed, 184 insertions(+), 26 deletions(-)

diff --git a/disas/mips.c b/disas/mips.c
index dfefe5e..b9a5204 100644
--- a/disas/mips.c
+++ b/disas/mips.c
@@ -1409,6 +1409,16 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"dvp",        "t",     0x41600024, 0xffe0ffff, TRAP|WR_t,            0, I32R6},
 {"evp",        "",      0x41600004, 0xffffffff, TRAP,                 0, I32R6},
 {"evp",        "t",     0x41600004, 0xffe0ffff, TRAP|WR_t,            0, I32R6},
+{"ginvi",      "v",     0x7c00003d, 0xfc1ffcff, TRAP | INSN_TLB,      0, I32R6},
+{"ginvt",      "v",     0x7c0000bd, 0xfc1ffcff, TRAP | INSN_TLB,      0, I32R6},
+{"crc32b",     "t,v,t", 0x7c00000f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I32R6},
+{"crc32h",     "t,v,t", 0x7c00004f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I32R6},
+{"crc32w",     "t,v,t", 0x7c00008f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I32R6},
+{"crc32d",     "t,v,t", 0x7c0000cf, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I64R6},
+{"crc32cb",    "t,v,t", 0x7c00010f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I32R6},
+{"crc32ch",    "t,v,t", 0x7c00014f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I32R6},
+{"crc32cw",    "t,v,t", 0x7c00018f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I32R6},
+{"crc32cd",    "t,v,t", 0x7c0001cf, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I64R6},
 
 /* MSA */
 {"sll.b",   "+d,+e,+f", 0x7800000d, 0xffe0003f, WR_VD|RD_VS|RD_VT,  0, MSA},
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7cf1b49..94d01ea 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -309,7 +309,7 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG04__USERLOCAL       2
 #define CP0_REG04__XCONTEXTCONFIG  3
 #define CP0_REG04__DBGCONTEXTID    4
-#define CP0_REG00__MMID            5
+#define CP0_REG04__MMID            5
 /* CP0 Register 05 */
 #define CP0_REG05__PAGEMASK        0
 #define CP0_REG05__PAGEGRAIN       1
diff --git a/target/mips/helper.c b/target/mips/helper.c
index 781930a..afd78b1 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -72,8 +72,13 @@ int r4k_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
                     target_ulong address, int rw, int access_type)
 {
     uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    uint32_t MMID = env->CP0_MemoryMapID;
+    bool mi = !!((env->CP0_Config5 >> CP0C5_MI) & 1);
+    uint32_t tlb_mmid;
     int i;
 
+    MMID = mi ? MMID : (uint32_t) ASID;
+
     for (i = 0; i < env->tlb->tlb_in_use; i++) {
         r4k_tlb_t *tlb = &env->tlb->mmu.r4k.tlb[i];
         /* 1k pages are not supported. */
@@ -84,8 +89,9 @@ int r4k_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
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
@@ -1418,14 +1424,20 @@ void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra)
     target_ulong addr;
     target_ulong end;
     uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    uint32_t MMID = env->CP0_MemoryMapID;
+    bool mi = !!((env->CP0_Config5 >> CP0C5_MI) & 1);
+    uint32_t tlb_mmid;
     target_ulong mask;
 
+    MMID = mi ? MMID : (uint32_t) ASID;
+
     tlb = &env->tlb->mmu.r4k.tlb[idx];
     /*
-     * The qemu TLB is flushed when the ASID changes, so no need to
+     * The qemu TLB is flushed when the ASID/MMID changes, so no need to
      * flush these entries again.
      */
-    if (tlb->G == 0 && tlb->ASID != ASID) {
+    tlb_mmid = mi ? tlb->MMID : (uint32_t) tlb->ASID;
+    if (tlb->G == 0 && tlb_mmid != MMID) {
         return;
     }
 
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 5b1f8bb..84fdd9f 100644
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
index 3f435b5..df55f84 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -95,6 +95,7 @@ struct r4k_tlb_t {
     target_ulong VPN;
     uint32_t PageMask;
     uint16_t ASID;
+    uint32_t MMID;
     unsigned int G:1;
     unsigned int C0:3;
     unsigned int C1:3;
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 7425a88..15d05a5 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1389,6 +1389,17 @@ void helper_mtc0_context(CPUMIPSState *env, target_ulong arg1)
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
@@ -1825,6 +1836,8 @@ void helper_mtc0_config5(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_Config5 = (env->CP0_Config5 & (~env->CP0_Config5_rw_bitmask)) |
                        (arg1 & env->CP0_Config5_rw_bitmask);
+    env->CP0_EntryHi_ASID_mask = (env->CP0_Config5 & (1 << CP0C5_MI)) ?
+            0x0 : (env->CP0_Config4 & (1 << CP0C4_AE)) ? 0x3ff : 0xff;
     compute_hflags(env);
 }
 
@@ -2268,6 +2281,7 @@ static void r4k_fill_tlb(CPUMIPSState *env, int idx)
     tlb->VPN &= env->SEGMask;
 #endif
     tlb->ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    tlb->MMID = env->CP0_MemoryMapID;
     tlb->PageMask = env->CP0_PageMask;
     tlb->G = env->CP0_EntryLo0 & env->CP0_EntryLo1 & 1;
     tlb->V0 = (env->CP0_EntryLo0 & 2) != 0;
@@ -2286,13 +2300,18 @@ static void r4k_fill_tlb(CPUMIPSState *env, int idx)
 
 void r4k_helper_tlbinv(CPUMIPSState *env)
 {
-    int idx;
-    r4k_tlb_t *tlb;
+    bool mi = !!((env->CP0_Config5 >> CP0C5_MI) & 1);
     uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    uint32_t MMID = env->CP0_MemoryMapID;
+    uint32_t tlb_mmid;
+    r4k_tlb_t *tlb;
+    int idx;
 
+    MMID = mi ? MMID : (uint32_t) ASID;
     for (idx = 0; idx < env->tlb->nb_tlb; idx++) {
         tlb = &env->tlb->mmu.r4k.tlb[idx];
-        if (!tlb->G && tlb->ASID == ASID) {
+        tlb_mmid = mi ? tlb->MMID : (uint32_t) tlb->ASID;
+        if (!tlb->G && tlb_mmid == MMID) {
             tlb->EHINV = 1;
         }
     }
@@ -2311,11 +2330,16 @@ void r4k_helper_tlbinvf(CPUMIPSState *env)
 
 void r4k_helper_tlbwi(CPUMIPSState *env)
 {
-    r4k_tlb_t *tlb;
-    int idx;
+    bool mi = !!((env->CP0_Config5 >> CP0C5_MI) & 1);
     target_ulong VPN;
-    uint16_t ASID;
+    uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    uint32_t MMID = env->CP0_MemoryMapID;
+    uint32_t tlb_mmid;
     bool EHINV, G, V0, D0, V1, D1, XI0, XI1, RI0, RI1;
+    r4k_tlb_t *tlb;
+    int idx;
+
+    MMID = mi ? MMID : (uint32_t) ASID;
 
     idx = (env->CP0_Index & ~0x80000000) % env->tlb->nb_tlb;
     tlb = &env->tlb->mmu.r4k.tlb[idx];
@@ -2323,7 +2347,6 @@ void r4k_helper_tlbwi(CPUMIPSState *env)
 #if defined(TARGET_MIPS64)
     VPN &= env->SEGMask;
 #endif
-    ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
     EHINV = (env->CP0_EntryHi & (1 << CP0EnHi_EHINV)) != 0;
     G = env->CP0_EntryLo0 & env->CP0_EntryLo1 & 1;
     V0 = (env->CP0_EntryLo0 & 2) != 0;
@@ -2335,11 +2358,12 @@ void r4k_helper_tlbwi(CPUMIPSState *env)
     XI1 = (env->CP0_EntryLo1 >> CP0EnLo_XI) &1;
     RI1 = (env->CP0_EntryLo1 >> CP0EnLo_RI) &1;
 
+    tlb_mmid = mi ? tlb->MMID : (uint32_t) tlb->ASID;
     /*
      * Discard cached TLB entries, unless tlbwi is just upgrading access
      * permissions on the current entry.
      */
-    if (tlb->VPN != VPN || tlb->ASID != ASID || tlb->G != G ||
+    if (tlb->VPN != VPN || tlb_mmid != MMID || tlb->G != G ||
         (!tlb->EHINV && EHINV) ||
         (tlb->V0 && !V0) || (tlb->D0 && !D0) ||
         (!tlb->XI0 && XI0) || (!tlb->RI0 && RI0) ||
@@ -2362,14 +2386,17 @@ void r4k_helper_tlbwr(CPUMIPSState *env)
 
 void r4k_helper_tlbp(CPUMIPSState *env)
 {
+    bool mi = !!((env->CP0_Config5 >> CP0C5_MI) & 1);
     r4k_tlb_t *tlb;
     target_ulong mask;
     target_ulong tag;
     target_ulong VPN;
-    uint16_t ASID;
+    uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    uint32_t MMID = env->CP0_MemoryMapID;
+    uint32_t tlb_mmid;
     int i;
 
-    ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    MMID = mi ? MMID : (uint32_t) ASID;
     for (i = 0; i < env->tlb->nb_tlb; i++) {
         tlb = &env->tlb->mmu.r4k.tlb[i];
         /* 1k pages are not supported. */
@@ -2379,8 +2406,9 @@ void r4k_helper_tlbp(CPUMIPSState *env)
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
@@ -2397,8 +2425,9 @@ void r4k_helper_tlbp(CPUMIPSState *env)
 #if defined(TARGET_MIPS64)
             tag &= env->SEGMask;
 #endif
-            /* Check ASID, virtual page number & size */
-            if ((tlb->G == 1 || tlb->ASID == ASID) && VPN == tag) {
+            tlb_mmid = mi ? tlb->MMID : (uint32_t) tlb->ASID;
+            /* Check ASID/MMID, virtual page number & size */
+            if ((tlb->G == 1 || tlb_mmid == MMID) && VPN == tag) {
                 r4k_mips_tlb_flush_extra(env, i);
                 break;
             }
@@ -2420,16 +2449,20 @@ static inline uint64_t get_entrylo_pfn_from_tlb(uint64_t tlb_pfn)
 
 void r4k_helper_tlbr(CPUMIPSState *env)
 {
+    bool mi = !!((env->CP0_Config5 >> CP0C5_MI) & 1);
+    uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    uint32_t MMID = env->CP0_MemoryMapID;
+    uint32_t tlb_mmid;
     r4k_tlb_t *tlb;
-    uint16_t ASID;
     int idx;
 
-    ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    MMID = mi ? MMID : (uint32_t) ASID;
     idx = (env->CP0_Index & ~0x80000000) % env->tlb->nb_tlb;
     tlb = &env->tlb->mmu.r4k.tlb[idx];
 
-    /* If this will change the current ASID, flush qemu's TLB.  */
-    if (ASID != tlb->ASID) {
+    tlb_mmid = mi ? tlb->MMID : (uint32_t) tlb->ASID;
+    /* If this will change the current ASID/MMID, flush qemu's TLB.  */
+    if (MMID != tlb_mmid) {
         cpu_mips_tlb_flush(env);
     }
 
@@ -2441,7 +2474,8 @@ void r4k_helper_tlbr(CPUMIPSState *env)
         env->CP0_EntryLo0 = 0;
         env->CP0_EntryLo1 = 0;
     } else {
-        env->CP0_EntryHi = tlb->VPN | tlb->ASID;
+        env->CP0_EntryHi = mi ? tlb->VPN : tlb->VPN | tlb->ASID;
+        env->CP0_MemoryMapID = tlb->MMID;
         env->CP0_PageMask = tlb->PageMask;
         env->CP0_EntryLo0 = tlb->G | (tlb->V0 << 1) | (tlb->D0 << 2) |
                         ((uint64_t)tlb->RI0 << CP0EnLo_RI) |
@@ -2484,6 +2518,63 @@ void helper_tlbinvf(CPUMIPSState *env)
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
index d51330c..d745bd2 100644
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
@@ -7131,6 +7133,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             tcg_gen_ext32s_tl(arg, arg);
             register_name = "UserLocal";
             break;
+        case CP0_REG04__MMID:
+            CP0_CHECK(ctx->mi);
+            gen_helper_mtc0_memorymapid(cpu_env, arg);
+            register_name = "MMID";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7871,6 +7878,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
             register_name = "UserLocal";
             break;
+        case CP0_REG04__MMID:
+            CP0_CHECK(ctx->mi);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_MemoryMapID));
+            register_name = "MMID";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -8629,6 +8641,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
             register_name = "UserLocal";
             break;
+        case CP0_REG04__MMID:
+            CP0_CHECK(ctx->mi);
+            gen_helper_mtc0_memorymapid(cpu_env, arg);
+            register_name = "MMID";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -9351,6 +9368,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
             register_name = "UserLocal";
             break;
+        case CP0_REG04__MMID:
+            CP0_CHECK(ctx->mi);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_MemoryMapID));
+            register_name = "MMID";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -27209,6 +27231,25 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
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
+        case 0:    /* GINVI */
+            /* Treat as NOP. */
+            break;
+        case 2:    /* GINVT */
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
@@ -30767,6 +30808,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
     ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
     ctx->mi = (env->CP0_Config5 >> CP0C5_MI) & 1;
+    ctx->gi = (env->CP0_Config5 >> CP0C5_GI) & 3;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx = MIPS_HFLAG_UM;
@@ -31227,8 +31269,8 @@ void cpu_state_reset(CPUMIPSState *env)
     if (env->CP0_Config3 & (1 << CP0C3_CMGCR)) {
         env->CP0_CMGCRBase = 0x1fbf8000 >> 4;
     }
-    env->CP0_EntryHi_ASID_mask = (env->CP0_Config4 & (1 << CP0C4_AE)) ?
-                                 0x3ff : 0xff;
+    env->CP0_EntryHi_ASID_mask = (env->CP0_Config5 & (1 << CP0C5_MI)) ?
+            0x0 : (env->CP0_Config4 & (1 << CP0C4_AE)) ? 0x3ff : 0xff;
     env->CP0_Status = (1 << CP0St_BEV) | (1 << CP0St_ERL);
     /*
      * Vectored interrupts not implemented, timer on int 7,
-- 
2.7.4


