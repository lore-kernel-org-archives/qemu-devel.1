Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA81C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594F420B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594F420B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw4Ob-0002ON-L8
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 08:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52880)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hw4Jq-0001kz-42
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hw4Jo-00019I-3f
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:30 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:52502 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hw4Jn-00018I-Pp
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:28 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 0ECD51A216C;
 Fri,  9 Aug 2019 14:48:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id D27AB1A2028;
 Fri,  9 Aug 2019 14:48:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 14:46:41 +0200
Message-Id: <1565354819-1495-9-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565354819-1495-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1565354819-1495-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH for 4.2 v7 08/26] target/mips: Style
 improvements in helper.c
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
Cc: arikalo@wavecomp.com, philmd@redhat.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/helper.c | 98 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 38 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index 6e583d3..d7a2c77 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -39,8 +39,8 @@ enum {
 #if !defined(CONFIG_USER_ONLY)
 
 /* no MMU emulation */
-int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
-                        target_ulong address, int rw, int access_type)
+int no_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
+                       target_ulong address, int rw, int access_type)
 {
     *physical = address;
     *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -48,26 +48,28 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
 }
 
 /* fixed mapping MMU emulation */
-int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
-                           target_ulong address, int rw, int access_type)
+int fixed_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
+                          target_ulong address, int rw, int access_type)
 {
     if (address <= (int32_t)0x7FFFFFFFUL) {
-        if (!(env->CP0_Status & (1 << CP0St_ERL)))
+        if (!(env->CP0_Status & (1 << CP0St_ERL))) {
             *physical = address + 0x40000000UL;
-        else
+        } else {
             *physical = address;
-    } else if (address <= (int32_t)0xBFFFFFFFUL)
+        }
+    } else if (address <= (int32_t)0xBFFFFFFFUL) {
         *physical = address & 0x1FFFFFFF;
-    else
+    } else {
         *physical = address;
+    }
 
     *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
     return TLBRET_MATCH;
 }
 
 /* MIPS32/MIPS64 R4000-style MMU emulation */
-int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
-                     target_ulong address, int rw, int access_type)
+int r4k_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
+                    target_ulong address, int rw, int access_type)
 {
     uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
     uint32_t MMID = env->CP0_MemoryMapID;
@@ -105,8 +107,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
             if (rw != MMU_DATA_STORE || (n ? tlb->D1 : tlb->D0)) {
                 *physical = tlb->PFN[n] | (address & (mask >> 1));
                 *prot = PAGE_READ;
-                if (n ? tlb->D1 : tlb->D0)
+                if (n ? tlb->D1 : tlb->D0) {
                     *prot |= PAGE_WRITE;
+                }
                 if (!(n ? tlb->XI1 : tlb->XI0)) {
                     *prot |= PAGE_EXEC;
                 }
@@ -136,9 +139,10 @@ static int is_seg_am_mapped(unsigned int am, bool eu, int mmu_idx)
     int32_t adetlb_mask;
 
     switch (mmu_idx) {
-    case 3 /* ERL */:
-        /* If EU is set, always unmapped */
+    case 3:
+        /* ERL */
         if (eu) {
+            /* If EU is set, always unmapped */
             return 0;
         }
         /* fall through */
@@ -210,7 +214,7 @@ static int get_segctl_physical_address(CPUMIPSState *env, hwaddr *physical,
                                     pa & ~(hwaddr)segmask);
 }
 
-static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
+static int get_physical_address(CPUMIPSState *env, hwaddr *physical,
                                 int *prot, target_ulong real_address,
                                 int rw, int access_type, int mmu_idx)
 {
@@ -265,7 +269,8 @@ static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
     } else if (address < 0x4000000000000000ULL) {
         /* xuseg */
         if (UX && address <= (0x3FFFFFFFFFFFFFFFULL & env->SEGMask)) {
-            ret = env->tlb->map_address(env, physical, prot, real_address, rw, access_type);
+            ret = env->tlb->map_address(env, physical, prot, real_address, rw,
+                                        access_type);
         } else {
             ret = TLBRET_BADADDR;
         }
@@ -273,7 +278,8 @@ static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
         /* xsseg */
         if ((supervisor_mode || kernel_mode) &&
             SX && address <= (0x7FFFFFFFFFFFFFFFULL & env->SEGMask)) {
-            ret = env->tlb->map_address(env, physical, prot, real_address, rw, access_type);
+            ret = env->tlb->map_address(env, physical, prot, real_address, rw,
+                                        access_type);
         } else {
             ret = TLBRET_BADADDR;
         }
@@ -313,7 +319,8 @@ static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
         /* xkseg */
         if (kernel_mode && KX &&
             address <= (0xFFFFFFFF7FFFFFFFULL & env->SEGMask)) {
-            ret = env->tlb->map_address(env, physical, prot, real_address, rw, access_type);
+            ret = env->tlb->map_address(env, physical, prot, real_address, rw,
+                                        access_type);
         } else {
             ret = TLBRET_BADADDR;
         }
@@ -669,7 +676,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
 }
 
 static bool page_table_walk_refill(CPUMIPSState *env, vaddr address, int rw,
-        int mmu_idx)
+                                   int mmu_idx)
 {
     int gdw = (env->CP0_PWSize >> CP0PS_GDW) & 0x3F;
     int udw = (env->CP0_PWSize >> CP0PS_UDW) & 0x3F;
@@ -951,7 +958,8 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 }
 
 #ifndef CONFIG_USER_ONLY
-hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong address, int rw)
+hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong address,
+                                  int rw)
 {
     hwaddr physical;
     int prot;
@@ -1011,7 +1019,7 @@ static const char * const excp_names[EXCP_LAST + 1] = {
 };
 #endif
 
-target_ulong exception_resume_pc (CPUMIPSState *env)
+target_ulong exception_resume_pc(CPUMIPSState *env)
 {
     target_ulong bad_pc;
     target_ulong isa_mode;
@@ -1019,8 +1027,10 @@ target_ulong exception_resume_pc (CPUMIPSState *env)
     isa_mode = !!(env->hflags & MIPS_HFLAG_M16);
     bad_pc = env->active_tc.PC | isa_mode;
     if (env->hflags & MIPS_HFLAG_BMASK) {
-        /* If the exception was raised from a delay slot, come back to
-           the jump.  */
+        /*
+         * If the exception was raised from a delay slot, come back to
+         * the jump.
+         */
         bad_pc -= (env->hflags & MIPS_HFLAG_B16 ? 2 : 4);
     }
 
@@ -1102,10 +1112,12 @@ void mips_cpu_do_interrupt(CPUState *cs)
     switch (cs->exception_index) {
     case EXCP_DSS:
         env->CP0_Debug |= 1 << CP0DB_DSS;
-        /* Debug single step cannot be raised inside a delay slot and
-           resume will always occur on the next instruction
-           (but we assume the pc has always been updated during
-           code translation). */
+        /*
+         * Debug single step cannot be raised inside a delay slot and
+         * resume will always occur on the next instruction
+         * (but we assume the pc has always been updated during
+         * code translation).
+         */
         env->CP0_DEPC = env->active_tc.PC | !!(env->hflags & MIPS_HFLAG_M16);
         goto enter_debug_mode;
     case EXCP_DINT:
@@ -1117,7 +1129,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
     case EXCP_DBp:
         env->CP0_Debug |= 1 << CP0DB_DBp;
         /* Setup DExcCode - SDBBP instruction */
-        env->CP0_Debug = (env->CP0_Debug & ~(0x1fULL << CP0DB_DEC)) | 9 << CP0DB_DEC;
+        env->CP0_Debug = (env->CP0_Debug & ~(0x1fULL << CP0DB_DEC)) |
+                         (9 << CP0DB_DEC);
         goto set_DEPC;
     case EXCP_DDBS:
         env->CP0_Debug |= 1 << CP0DB_DDBS;
@@ -1138,8 +1151,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
         env->hflags |= MIPS_HFLAG_DM | MIPS_HFLAG_CP0;
         env->hflags &= ~(MIPS_HFLAG_KSU);
         /* EJTAG probe trap enable is not implemented... */
-        if (!(env->CP0_Status & (1 << CP0St_EXL)))
+        if (!(env->CP0_Status & (1 << CP0St_EXL))) {
             env->CP0_Cause &= ~(1U << CP0Ca_BD);
+        }
         env->active_tc.PC = env->exception_base + 0x480;
         set_hflags_for_handler(env);
         break;
@@ -1165,8 +1179,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
         }
         env->hflags |= MIPS_HFLAG_CP0;
         env->hflags &= ~(MIPS_HFLAG_KSU);
-        if (!(env->CP0_Status & (1 << CP0St_EXL)))
+        if (!(env->CP0_Status & (1 << CP0St_EXL))) {
             env->CP0_Cause &= ~(1U << CP0Ca_BD);
+        }
         env->active_tc.PC = env->exception_base;
         set_hflags_for_handler(env);
         break;
@@ -1182,12 +1197,16 @@ void mips_cpu_do_interrupt(CPUState *cs)
                 uint32_t pending = (env->CP0_Cause & CP0Ca_IP_mask) >> CP0Ca_IP;
 
                 if (env->CP0_Config3 & (1 << CP0C3_VEIC)) {
-                    /* For VEIC mode, the external interrupt controller feeds
-                     * the vector through the CP0Cause IP lines.  */
+                    /*
+                     * For VEIC mode, the external interrupt controller feeds
+                     * the vector through the CP0Cause IP lines.
+                     */
                     vector = pending;
                 } else {
-                    /* Vectored Interrupts
-                     * Mask with Status.IM7-IM0 to get enabled interrupts. */
+                    /*
+                     * Vectored Interrupts
+                     * Mask with Status.IM7-IM0 to get enabled interrupts.
+                     */
                     pending &= (env->CP0_Status >> CP0St_IM) & 0xff;
                     /* Find the highest-priority interrupt. */
                     while (pending >>= 1) {
@@ -1360,7 +1379,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
 
         env->active_tc.PC += offset;
         set_hflags_for_handler(env);
-        env->CP0_Cause = (env->CP0_Cause & ~(0x1f << CP0Ca_EC)) | (cause << CP0Ca_EC);
+        env->CP0_Cause = (env->CP0_Cause & ~(0x1f << CP0Ca_EC)) |
+                         (cause << CP0Ca_EC);
         break;
     default:
         abort();
@@ -1396,7 +1416,7 @@ bool mips_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra)
+void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra)
 {
     CPUState *cs = env_cpu(env);
     r4k_tlb_t *tlb;
@@ -1421,9 +1441,11 @@ void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra)
     }
 
     if (use_extra && env->tlb->tlb_in_use < MIPS_TLB_MAX) {
-        /* For tlbwr, we can shadow the discarded entry into
-           a new (fake) TLB entry, as long as the guest can not
-           tell that it's there.  */
+        /*
+         * For tlbwr, we can shadow the discarded entry into
+         * a new (fake) TLB entry, as long as the guest can not
+         * tell that it's there.
+         */
         env->tlb->mmu.r4k.tlb[env->tlb->tlb_in_use] = *tlb;
         env->tlb->tlb_in_use++;
         return;
-- 
2.7.4


