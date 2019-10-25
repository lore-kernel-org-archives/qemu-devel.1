Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D1DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9E02084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9E02084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO33Z-0000ZZ-M2
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iO2ig-00054r-54
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iO2iX-0002G7-GB
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34450 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iO2iW-0002Dq-I6
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:37 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id D738E1A21D5;
 Fri, 25 Oct 2019 18:44:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 42E2A1A21DF;
 Fri, 25 Oct 2019 18:44:29 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/20] target/mips: Clean up op_helper.c
Date: Fri, 25 Oct 2019 18:44:04 +0200
Message-Id: <1572021862-28273-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Mostly fix errors and warnings reported by 'checkpatch.pl -f'.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1571826227-10583-3-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/op_helper.c | 1010 +++++++++++++++++++++++++++++++----------------
 1 file changed, 663 insertions(+), 347 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 4de6465..18fcee4 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -64,8 +64,7 @@ static inline type do_##name(CPUMIPSState *env, target_ulong addr,      \
 static inline type do_##name(CPUMIPSState *env, target_ulong addr,      \
                              int mem_idx, uintptr_t retaddr)            \
 {                                                                       \
-    switch (mem_idx)                                                    \
-    {                                                                   \
+    switch (mem_idx) {                                                  \
     case 0: return (type) cpu_##insn##_kernel_ra(env, addr, retaddr);   \
     case 1: return (type) cpu_##insn##_super_ra(env, addr, retaddr);    \
     default:                                                            \
@@ -92,12 +91,17 @@ static inline void do_##name(CPUMIPSState *env, target_ulong addr,      \
 static inline void do_##name(CPUMIPSState *env, target_ulong addr,      \
                              type val, int mem_idx, uintptr_t retaddr)  \
 {                                                                       \
-    switch (mem_idx)                                                    \
-    {                                                                   \
-    case 0: cpu_##insn##_kernel_ra(env, addr, val, retaddr); break;     \
-    case 1: cpu_##insn##_super_ra(env, addr, val, retaddr); break;      \
+    switch (mem_idx) {                                                  \
+    case 0:                                                             \
+        cpu_##insn##_kernel_ra(env, addr, val, retaddr);                \
+        break;                                                          \
+    case 1:                                                             \
+        cpu_##insn##_super_ra(env, addr, val, retaddr);                 \
+        break;                                                          \
     default:                                                            \
-    case 2: cpu_##insn##_user_ra(env, addr, val, retaddr); break;       \
+    case 2:                                                             \
+        cpu_##insn##_user_ra(env, addr, val, retaddr);                  \
+        break;                                                          \
     case 3:                                                             \
         cpu_##insn##_error_ra(env, addr, val, retaddr);                 \
         break;                                                          \
@@ -114,7 +118,8 @@ HELPER_ST(sd, stq, uint64_t)
 /* 64 bits arithmetic for 32 bits hosts */
 static inline uint64_t get_HILO(CPUMIPSState *env)
 {
-    return ((uint64_t)(env->active_tc.HI[0]) << 32) | (uint32_t)env->active_tc.LO[0];
+    return ((uint64_t)(env->active_tc.HI[0]) << 32) |
+           (uint32_t)env->active_tc.LO[0];
 }
 
 static inline target_ulong set_HIT0_LO(CPUMIPSState *env, uint64_t HILO)
@@ -435,9 +440,10 @@ void helper_swr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
 }
 
 #if defined(TARGET_MIPS64)
-/* "half" load and stores.  We must do the memory access inline,
-   or fault handling won't work.  */
-
+/*
+ * "half" load and stores.  We must do the memory access inline,
+ * or fault handling won't work.
+ */
 #ifdef TARGET_WORDS_BIGENDIAN
 #define GET_LMASK64(v) ((v) & 7)
 #else
@@ -535,7 +541,7 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
-    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
+    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
         target_ulong i;
 
         for (i = 0; i < base_reglist; i++) {
@@ -557,7 +563,7 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
-    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
+    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
         target_ulong i;
 
         for (i = 0; i < base_reglist; i++) {
@@ -579,7 +585,7 @@ void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
-    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
+    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
         target_ulong i;
 
         for (i = 0; i < base_reglist; i++) {
@@ -600,7 +606,7 @@ void helper_sdm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
     target_ulong base_reglist = reglist & 0xf;
     target_ulong do_r31 = reglist & 0x10;
 
-    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
+    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
         target_ulong i;
 
         for (i = 0; i < base_reglist; i++) {
@@ -623,8 +629,10 @@ static bool mips_vpe_is_wfi(MIPSCPU *c)
     CPUState *cpu = CPU(c);
     CPUMIPSState *env = &c->env;
 
-    /* If the VPE is halted but otherwise active, it means it's waiting for
-       an interrupt.  */
+    /*
+     * If the VPE is halted but otherwise active, it means it's waiting for
+     * an interrupt.\
+     */
     return cpu->halted && mips_vpe_active(env);
 }
 
@@ -638,9 +646,11 @@ static bool mips_vp_is_wfi(MIPSCPU *c)
 
 static inline void mips_vpe_wake(MIPSCPU *c)
 {
-    /* Don't set ->halted = 0 directly, let it be done via cpu_has_work
-       because there might be other conditions that state that c should
-       be sleeping.  */
+    /*
+     * Don't set ->halted = 0 directly, let it be done via cpu_has_work
+     * because there might be other conditions that state that c should
+     * be sleeping.
+     */
     qemu_mutex_lock_iothread();
     cpu_interrupt(CPU(c), CPU_INTERRUPT_WAKE);
     qemu_mutex_unlock_iothread();
@@ -650,8 +660,10 @@ static inline void mips_vpe_sleep(MIPSCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
 
-    /* The VPE was shut off, really go to bed.
-       Reset any old _WAKE requests.  */
+    /*
+     * The VPE was shut off, really go to bed.
+     * Reset any old _WAKE requests.
+     */
     cs->halted = 1;
     cpu_reset_interrupt(cs, CPU_INTERRUPT_WAKE);
 }
@@ -684,9 +696,12 @@ static inline void mips_tc_sleep(MIPSCPU *cpu, int tc)
  * This function will transform @tc into a local index within the
  * returned #CPUMIPSState.
  */
-/* FIXME: This code assumes that all VPEs have the same number of TCs,
-          which depends on runtime setup. Can probably be fixed by
-          walking the list of CPUMIPSStates.  */
+
+/*
+ * FIXME: This code assumes that all VPEs have the same number of TCs,
+ *        which depends on runtime setup. Can probably be fixed by
+ *        walking the list of CPUMIPSStates.
+ */
 static CPUMIPSState *mips_cpu_map_tc(CPUMIPSState *env, int *tc)
 {
     MIPSCPU *cpu;
@@ -712,17 +727,21 @@ static CPUMIPSState *mips_cpu_map_tc(CPUMIPSState *env, int *tc)
     return &cpu->env;
 }
 
-/* The per VPE CP0_Status register shares some fields with the per TC
-   CP0_TCStatus registers. These fields are wired to the same registers,
-   so changes to either of them should be reflected on both registers.
-
-   Also, EntryHi shares the bottom 8 bit ASID with TCStauts.
-
-   These helper call synchronizes the regs for a given cpu.  */
+/*
+ * The per VPE CP0_Status register shares some fields with the per TC
+ * CP0_TCStatus registers. These fields are wired to the same registers,
+ * so changes to either of them should be reflected on both registers.
+ *
+ * Also, EntryHi shares the bottom 8 bit ASID with TCStauts.
+ *
+ * These helper call synchronizes the regs for a given cpu.
+ */
 
-/* Called for updates to CP0_Status.  Defined in "cpu.h" for gdbstub.c.  */
-/* static inline void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu,
-                                     int tc);  */
+/*
+ * Called for updates to CP0_Status.  Defined in "cpu.h" for gdbstub.c.
+ * static inline void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu,
+ *                                   int tc);
+ */
 
 /* Called for updates to CP0_TCStatus.  */
 static void sync_c0_tcstatus(CPUMIPSState *cpu, int tc,
@@ -805,10 +824,11 @@ target_ulong helper_mftc0_tcstatus(CPUMIPSState *env)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         return other->active_tc.CP0_TCStatus;
-    else
+    } else {
         return other->tcs[other_tc].CP0_TCStatus;
+    }
 }
 
 target_ulong helper_mfc0_tcbind(CPUMIPSState *env)
@@ -821,10 +841,11 @@ target_ulong helper_mftc0_tcbind(CPUMIPSState *env)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         return other->active_tc.CP0_TCBind;
-    else
+    } else {
         return other->tcs[other_tc].CP0_TCBind;
+    }
 }
 
 target_ulong helper_mfc0_tcrestart(CPUMIPSState *env)
@@ -837,10 +858,11 @@ target_ulong helper_mftc0_tcrestart(CPUMIPSState *env)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         return other->active_tc.PC;
-    else
+    } else {
         return other->tcs[other_tc].PC;
+    }
 }
 
 target_ulong helper_mfc0_tchalt(CPUMIPSState *env)
@@ -853,10 +875,11 @@ target_ulong helper_mftc0_tchalt(CPUMIPSState *env)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         return other->active_tc.CP0_TCHalt;
-    else
+    } else {
         return other->tcs[other_tc].CP0_TCHalt;
+    }
 }
 
 target_ulong helper_mfc0_tccontext(CPUMIPSState *env)
@@ -869,10 +892,11 @@ target_ulong helper_mftc0_tccontext(CPUMIPSState *env)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         return other->active_tc.CP0_TCContext;
-    else
+    } else {
         return other->tcs[other_tc].CP0_TCContext;
+    }
 }
 
 target_ulong helper_mfc0_tcschedule(CPUMIPSState *env)
@@ -885,10 +909,11 @@ target_ulong helper_mftc0_tcschedule(CPUMIPSState *env)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         return other->active_tc.CP0_TCSchedule;
-    else
+    } else {
         return other->tcs[other_tc].CP0_TCSchedule;
+    }
 }
 
 target_ulong helper_mfc0_tcschefback(CPUMIPSState *env)
@@ -901,10 +926,11 @@ target_ulong helper_mftc0_tcschefback(CPUMIPSState *env)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         return other->active_tc.CP0_TCScheFBack;
-    else
+    } else {
         return other->tcs[other_tc].CP0_TCScheFBack;
+    }
 }
 
 target_ulong helper_mfc0_count(CPUMIPSState *env)
@@ -987,8 +1013,9 @@ target_ulong helper_mfc0_watchhi(CPUMIPSState *env, uint32_t sel)
 target_ulong helper_mfc0_debug(CPUMIPSState *env)
 {
     target_ulong t0 = env->CP0_Debug;
-    if (env->hflags & MIPS_HFLAG_DM)
+    if (env->hflags & MIPS_HFLAG_DM) {
         t0 |= 1 << CP0DB_DM;
+    }
 
     return t0;
 }
@@ -999,10 +1026,11 @@ target_ulong helper_mftc0_debug(CPUMIPSState *env)
     int32_t tcstatus;
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         tcstatus = other->active_tc.CP0_Debug_tcstatus;
-    else
+    } else {
         tcstatus = other->tcs[other_tc].CP0_Debug_tcstatus;
+    }
 
     /* XXX: Might be wrong, check with EJTAG spec. */
     return (other->CP0_Debug & ~((1 << CP0DB_SSt) | (1 << CP0DB_Halt))) |
@@ -1076,14 +1104,16 @@ void helper_mtc0_mvpcontrol(CPUMIPSState *env, target_ulong arg1)
     uint32_t mask = 0;
     uint32_t newval;
 
-    if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP))
+    if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
         mask |= (1 << CP0MVPCo_CPA) | (1 << CP0MVPCo_VPC) |
                 (1 << CP0MVPCo_EVP);
-    if (env->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC))
+    }
+    if (env->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)) {
         mask |= (1 << CP0MVPCo_STLB);
+    }
     newval = (env->mvp->CP0_MVPControl & ~mask) | (arg1 & mask);
 
-    // TODO: Enable/disable shared TLB, enable/disable VPEs.
+    /* TODO: Enable/disable shared TLB, enable/disable VPEs. */
 
     env->mvp->CP0_MVPControl = newval;
 }
@@ -1097,10 +1127,12 @@ void helper_mtc0_vpecontrol(CPUMIPSState *env, target_ulong arg1)
            (1 << CP0VPECo_TE) | (0xff << CP0VPECo_TargTC);
     newval = (env->CP0_VPEControl & ~mask) | (arg1 & mask);
 
-    /* Yield scheduler intercept not implemented. */
-    /* Gating storage scheduler intercept not implemented. */
+    /*
+     * Yield scheduler intercept not implemented.
+     * Gating storage scheduler intercept not implemented.
+     */
 
-    // TODO: Enable/disable TCs.
+    /* TODO: Enable/disable TCs. */
 
     env->CP0_VPEControl = newval;
 }
@@ -1143,13 +1175,14 @@ void helper_mtc0_vpeconf0(CPUMIPSState *env, target_ulong arg1)
     uint32_t newval;
 
     if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
-        if (env->CP0_VPEConf0 & (1 << CP0VPEC0_VPA))
+        if (env->CP0_VPEConf0 & (1 << CP0VPEC0_VPA)) {
             mask |= (0xff << CP0VPEC0_XTC);
+        }
         mask |= (1 << CP0VPEC0_MVP) | (1 << CP0VPEC0_VPA);
     }
     newval = (env->CP0_VPEConf0 & ~mask) | (arg1 & mask);
 
-    // TODO: TC exclusive handling due to ERL/EXL.
+    /* TODO: TC exclusive handling due to ERL/EXL. */
 
     env->CP0_VPEConf0 = newval;
 }
@@ -1181,7 +1214,7 @@ void helper_mtc0_vpeconf1(CPUMIPSState *env, target_ulong arg1)
     /* UDI not implemented. */
     /* CP2 not implemented. */
 
-    // TODO: Handle FPU (CP1) binding.
+    /* TODO: Handle FPU (CP1) binding. */
 
     env->CP0_VPEConf1 = newval;
 }
@@ -1233,10 +1266,11 @@ void helper_mttc0_tcstatus(CPUMIPSState *env, target_ulong arg1)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         other->active_tc.CP0_TCStatus = arg1;
-    else
+    } else {
         other->tcs[other_tc].CP0_TCStatus = arg1;
+    }
     sync_c0_tcstatus(other, other_tc, arg1);
 }
 
@@ -1245,8 +1279,9 @@ void helper_mtc0_tcbind(CPUMIPSState *env, target_ulong arg1)
     uint32_t mask = (1 << CP0TCBd_TBE);
     uint32_t newval;
 
-    if (env->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC))
+    if (env->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)) {
         mask |= (1 << CP0TCBd_CurVPE);
+    }
     newval = (env->active_tc.CP0_TCBind & ~mask) | (arg1 & mask);
     env->active_tc.CP0_TCBind = newval;
 }
@@ -1258,8 +1293,9 @@ void helper_mttc0_tcbind(CPUMIPSState *env, target_ulong arg1)
     uint32_t newval;
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC))
+    if (other->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)) {
         mask |= (1 << CP0TCBd_CurVPE);
+    }
     if (other_tc == other->current_tc) {
         newval = (other->active_tc.CP0_TCBind & ~mask) | (arg1 & mask);
         other->active_tc.CP0_TCBind = newval;
@@ -1304,7 +1340,7 @@ void helper_mtc0_tchalt(CPUMIPSState *env, target_ulong arg1)
 
     env->active_tc.CP0_TCHalt = arg1 & 0x1;
 
-    // TODO: Halt TC / Restart (if allocated+active) TC.
+    /* TODO: Halt TC / Restart (if allocated+active) TC. */
     if (env->active_tc.CP0_TCHalt & 1) {
         mips_tc_sleep(cpu, env->current_tc);
     } else {
@@ -1318,12 +1354,13 @@ void helper_mttc0_tchalt(CPUMIPSState *env, target_ulong arg1)
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
     MIPSCPU *other_cpu = env_archcpu(other);
 
-    // TODO: Halt TC / Restart (if allocated+active) TC.
+    /* TODO: Halt TC / Restart (if allocated+active) TC. */
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         other->active_tc.CP0_TCHalt = arg1;
-    else
+    } else {
         other->tcs[other_tc].CP0_TCHalt = arg1;
+    }
 
     if (arg1 & 1) {
         mips_tc_sleep(other_cpu, other_tc);
@@ -1342,10 +1379,11 @@ void helper_mttc0_tccontext(CPUMIPSState *env, target_ulong arg1)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         other->active_tc.CP0_TCContext = arg1;
-    else
+    } else {
         other->tcs[other_tc].CP0_TCContext = arg1;
+    }
 }
 
 void helper_mtc0_tcschedule(CPUMIPSState *env, target_ulong arg1)
@@ -1358,10 +1396,11 @@ void helper_mttc0_tcschedule(CPUMIPSState *env, target_ulong arg1)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         other->active_tc.CP0_TCSchedule = arg1;
-    else
+    } else {
         other->tcs[other_tc].CP0_TCSchedule = arg1;
+    }
 }
 
 void helper_mtc0_tcschefback(CPUMIPSState *env, target_ulong arg1)
@@ -1374,10 +1413,11 @@ void helper_mttc0_tcschefback(CPUMIPSState *env, target_ulong arg1)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         other->active_tc.CP0_TCScheFBack = arg1;
-    else
+    } else {
         other->tcs[other_tc].CP0_TCScheFBack = arg1;
+    }
 }
 
 void helper_mtc0_entrylo1(CPUMIPSState *env, target_ulong arg1)
@@ -1703,9 +1743,15 @@ void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
         case 3:
             qemu_log(", ERL\n");
             break;
-        case MIPS_HFLAG_UM: qemu_log(", UM\n"); break;
-        case MIPS_HFLAG_SM: qemu_log(", SM\n"); break;
-        case MIPS_HFLAG_KM: qemu_log("\n"); break;
+        case MIPS_HFLAG_UM:
+            qemu_log(", UM\n");
+            break;
+        case MIPS_HFLAG_SM:
+            qemu_log(", SM\n");
+            break;
+        case MIPS_HFLAG_KM:
+            qemu_log("\n");
+            break;
         default:
             cpu_abort(env_cpu(env), "Invalid MMU mode!\n");
             break;
@@ -1860,21 +1906,26 @@ void helper_mtc0_maari(CPUMIPSState *env, target_ulong arg1)
 {
     int index = arg1 & 0x3f;
     if (index == 0x3f) {
-        /* Software may write all ones to INDEX to determine the
-           maximum value supported. */
+        /*
+         * Software may write all ones to INDEX to determine the
+         *  maximum value supported.
+         */
         env->CP0_MAARI = MIPS_MAAR_MAX - 1;
     } else if (index < MIPS_MAAR_MAX) {
         env->CP0_MAARI = index;
     }
-    /* Other than the all ones, if the
-       value written is not supported, then INDEX is unchanged
-       from its previous value. */
+    /*
+     * Other than the all ones, if the value written is not supported,
+     * then INDEX is unchanged from its previous value.
+     */
 }
 
 void helper_mtc0_watchlo(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 {
-    /* Watch exceptions for instructions, data loads, data stores
-       not implemented. */
+    /*
+     * Watch exceptions for instructions, data loads, data stores
+     * not implemented.
+     */
     env->CP0_WatchLo[sel] = (arg1 & ~0x7);
 }
 
@@ -1899,10 +1950,11 @@ void helper_mtc0_framemask(CPUMIPSState *env, target_ulong arg1)
 void helper_mtc0_debug(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_Debug = (env->CP0_Debug & 0x8C03FC1F) | (arg1 & 0x13300120);
-    if (arg1 & (1 << CP0DB_DM))
+    if (arg1 & (1 << CP0DB_DM)) {
         env->hflags |= MIPS_HFLAG_DM;
-    else
+    } else {
         env->hflags &= ~MIPS_HFLAG_DM;
+    }
 }
 
 void helper_mttc0_debug(CPUMIPSState *env, target_ulong arg1)
@@ -1912,10 +1964,11 @@ void helper_mttc0_debug(CPUMIPSState *env, target_ulong arg1)
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
     /* XXX: Might be wrong, check with EJTAG spec. */
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         other->active_tc.CP0_Debug_tcstatus = val;
-    else
+    } else {
         other->tcs[other_tc].CP0_Debug_tcstatus = val;
+    }
     other->CP0_Debug = (other->CP0_Debug &
                      ((1 << CP0DB_SSt) | (1 << CP0DB_Halt))) |
                      (arg1 & ~((1 << CP0DB_SSt) | (1 << CP0DB_Halt)));
@@ -1944,9 +1997,11 @@ void helper_mtc0_errctl(CPUMIPSState *env, target_ulong arg1)
 void helper_mtc0_taglo(CPUMIPSState *env, target_ulong arg1)
 {
     if (env->hflags & MIPS_HFLAG_ITC_CACHE) {
-        /* If CACHE instruction is configured for ITC tags then make all
-           CP0.TagLo bits writable. The actual write to ITC Configuration
-           Tag will take care of the read-only bits. */
+        /*
+         * If CACHE instruction is configured for ITC tags then make all
+         * CP0.TagLo bits writable. The actual write to ITC Configuration
+         * Tag will take care of the read-only bits.
+         */
         env->CP0_TagLo = arg1;
     } else {
         env->CP0_TagLo = arg1 & 0xFFFFFCF6;
@@ -1974,10 +2029,11 @@ target_ulong helper_mftgpr(CPUMIPSState *env, uint32_t sel)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         return other->active_tc.gpr[sel];
-    else
+    } else {
         return other->tcs[other_tc].gpr[sel];
+    }
 }
 
 target_ulong helper_mftlo(CPUMIPSState *env, uint32_t sel)
@@ -1985,10 +2041,11 @@ target_ulong helper_mftlo(CPUMIPSState *env, uint32_t sel)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         return other->active_tc.LO[sel];
-    else
+    } else {
         return other->tcs[other_tc].LO[sel];
+    }
 }
 
 target_ulong helper_mfthi(CPUMIPSState *env, uint32_t sel)
@@ -1996,10 +2053,11 @@ target_ulong helper_mfthi(CPUMIPSState *env, uint32_t sel)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         return other->active_tc.HI[sel];
-    else
+    } else {
         return other->tcs[other_tc].HI[sel];
+    }
 }
 
 target_ulong helper_mftacx(CPUMIPSState *env, uint32_t sel)
@@ -2007,10 +2065,11 @@ target_ulong helper_mftacx(CPUMIPSState *env, uint32_t sel)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         return other->active_tc.ACX[sel];
-    else
+    } else {
         return other->tcs[other_tc].ACX[sel];
+    }
 }
 
 target_ulong helper_mftdsp(CPUMIPSState *env)
@@ -2018,10 +2077,11 @@ target_ulong helper_mftdsp(CPUMIPSState *env)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         return other->active_tc.DSPControl;
-    else
+    } else {
         return other->tcs[other_tc].DSPControl;
+    }
 }
 
 void helper_mttgpr(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
@@ -2029,10 +2089,11 @@ void helper_mttgpr(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         other->active_tc.gpr[sel] = arg1;
-    else
+    } else {
         other->tcs[other_tc].gpr[sel] = arg1;
+    }
 }
 
 void helper_mttlo(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
@@ -2040,10 +2101,11 @@ void helper_mttlo(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         other->active_tc.LO[sel] = arg1;
-    else
+    } else {
         other->tcs[other_tc].LO[sel] = arg1;
+    }
 }
 
 void helper_mtthi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
@@ -2051,10 +2113,11 @@ void helper_mtthi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         other->active_tc.HI[sel] = arg1;
-    else
+    } else {
         other->tcs[other_tc].HI[sel] = arg1;
+    }
 }
 
 void helper_mttacx(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
@@ -2062,10 +2125,11 @@ void helper_mttacx(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         other->active_tc.ACX[sel] = arg1;
-    else
+    } else {
         other->tcs[other_tc].ACX[sel] = arg1;
+    }
 }
 
 void helper_mttdsp(CPUMIPSState *env, target_ulong arg1)
@@ -2073,22 +2137,23 @@ void helper_mttdsp(CPUMIPSState *env, target_ulong arg1)
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
 
-    if (other_tc == other->current_tc)
+    if (other_tc == other->current_tc) {
         other->active_tc.DSPControl = arg1;
-    else
+    } else {
         other->tcs[other_tc].DSPControl = arg1;
+    }
 }
 
 /* MIPS MT functions */
 target_ulong helper_dmt(void)
 {
-    // TODO
-     return 0;
+    /* TODO */
+    return 0;
 }
 
 target_ulong helper_emt(void)
 {
-    // TODO
+    /* TODO */
     return 0;
 }
 
@@ -2130,8 +2195,10 @@ target_ulong helper_evpe(CPUMIPSState *env)
 
 void helper_fork(target_ulong arg1, target_ulong arg2)
 {
-    // arg1 = rt, arg2 = rs
-    // TODO: store to TC register
+    /*
+     * arg1 = rt, arg2 = rs
+     * TODO: store to TC register
+     */
 }
 
 target_ulong helper_yield(CPUMIPSState *env, target_ulong arg)
@@ -2149,11 +2216,12 @@ target_ulong helper_yield(CPUMIPSState *env, target_ulong arg)
             }
         }
     } else if (arg1 == 0) {
-        if (0 /* TODO: TC underflow */) {
+        if (0) {
+            /* TODO: TC underflow */
             env->CP0_VPEControl &= ~(0x7 << CP0VPECo_EXCPT);
             do_raise_exception(env, EXCP_THREAD, GETPC());
         } else {
-            // TODO: Deallocate TC
+            /* TODO: Deallocate TC */
         }
     } else if (arg1 > 0) {
         /* Yield qualifier inputs not implemented. */
@@ -2193,8 +2261,10 @@ target_ulong helper_evp(CPUMIPSState *env)
         CPU_FOREACH(other_cs) {
             MIPSCPU *other_cpu = MIPS_CPU(other_cs);
             if ((&other_cpu->env != env) && !mips_vp_is_wfi(other_cpu)) {
-                /* If the VP is WFI, don't disturb its sleep.
-                 * Otherwise, wake it up. */
+                /*
+                 * If the VP is WFI, don't disturb its sleep.
+                 * Otherwise, wake it up.
+                 */
                 mips_vpe_wake(other_cpu);
             }
         }
@@ -2206,7 +2276,7 @@ target_ulong helper_evp(CPUMIPSState *env)
 
 #ifndef CONFIG_USER_ONLY
 /* TLB management */
-static void r4k_mips_tlb_flush_extra (CPUMIPSState *env, int first)
+static void r4k_mips_tlb_flush_extra(CPUMIPSState *env, int first)
 {
     /* Discard entries from env->tlb[first] onwards.  */
     while (env->tlb->tlb_in_use > first) {
@@ -2308,8 +2378,10 @@ void r4k_helper_tlbwi(CPUMIPSState *env)
     XI1 = (env->CP0_EntryLo1 >> CP0EnLo_XI) &1;
     RI1 = (env->CP0_EntryLo1 >> CP0EnLo_RI) &1;
 
-    /* Discard cached TLB entries, unless tlbwi is just upgrading access
-       permissions on the current entry. */
+    /*
+     * Discard cached TLB entries, unless tlbwi is just upgrading access
+     * permissions on the current entry.
+     */
     if (tlb->VPN != VPN || tlb->ASID != ASID || tlb->G != G ||
         (!tlb->EHINV && EHINV) ||
         (tlb->V0 && !V0) || (tlb->D0 && !D0) ||
@@ -2370,7 +2442,7 @@ void r4k_helper_tlbp(CPUMIPSState *env)
 #endif
             /* Check ASID, virtual page number & size */
             if ((tlb->G == 1 || tlb->ASID == ASID) && VPN == tag) {
-                r4k_mips_tlb_flush_extra (env, i);
+                r4k_mips_tlb_flush_extra(env, i);
                 break;
             }
         }
@@ -2400,8 +2472,9 @@ void r4k_helper_tlbr(CPUMIPSState *env)
     tlb = &env->tlb->mmu.r4k.tlb[idx];
 
     /* If this will change the current ASID, flush qemu's TLB.  */
-    if (ASID != tlb->ASID)
+    if (ASID != tlb->ASID) {
         cpu_mips_tlb_flush(env);
+    }
 
     r4k_mips_tlb_flush_extra(env, env->tlb->nb_tlb);
 
@@ -2476,10 +2549,12 @@ static void debug_pre_eret(CPUMIPSState *env)
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
         qemu_log("ERET: PC " TARGET_FMT_lx " EPC " TARGET_FMT_lx,
                 env->active_tc.PC, env->CP0_EPC);
-        if (env->CP0_Status & (1 << CP0St_ERL))
+        if (env->CP0_Status & (1 << CP0St_ERL)) {
             qemu_log(" ErrorEPC " TARGET_FMT_lx, env->CP0_ErrorEPC);
-        if (env->hflags & MIPS_HFLAG_DM)
+        }
+        if (env->hflags & MIPS_HFLAG_DM) {
             qemu_log(" DEPC " TARGET_FMT_lx, env->CP0_DEPC);
+        }
         qemu_log("\n");
     }
 }
@@ -2489,17 +2564,25 @@ static void debug_post_eret(CPUMIPSState *env)
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
         qemu_log("  =>  PC " TARGET_FMT_lx " EPC " TARGET_FMT_lx,
                 env->active_tc.PC, env->CP0_EPC);
-        if (env->CP0_Status & (1 << CP0St_ERL))
+        if (env->CP0_Status & (1 << CP0St_ERL)) {
             qemu_log(" ErrorEPC " TARGET_FMT_lx, env->CP0_ErrorEPC);
-        if (env->hflags & MIPS_HFLAG_DM)
+        }
+        if (env->hflags & MIPS_HFLAG_DM) {
             qemu_log(" DEPC " TARGET_FMT_lx, env->CP0_DEPC);
+        }
         switch (cpu_mmu_index(env, false)) {
         case 3:
             qemu_log(", ERL\n");
             break;
-        case MIPS_HFLAG_UM: qemu_log(", UM\n"); break;
-        case MIPS_HFLAG_SM: qemu_log(", SM\n"); break;
-        case MIPS_HFLAG_KM: qemu_log("\n"); break;
+        case MIPS_HFLAG_UM:
+            qemu_log(", UM\n");
+            break;
+        case MIPS_HFLAG_SM:
+            qemu_log(", SM\n");
+            break;
+        case MIPS_HFLAG_KM:
+            qemu_log("\n");
+            break;
         default:
             cpu_abort(env_cpu(env), "Invalid MMU mode!\n");
             break;
@@ -2609,8 +2692,9 @@ void helper_pmon(CPUMIPSState *env, int function)
     function /= 2;
     switch (function) {
     case 2: /* TODO: char inbyte(int waitflag); */
-        if (env->active_tc.gpr[4] == 0)
+        if (env->active_tc.gpr[4] == 0) {
             env->active_tc.gpr[2] = -1;
+        }
         /* Fall through */
     case 11: /* TODO: char inbyte (void); */
         env->active_tc.gpr[2] = -1;
@@ -2636,8 +2720,10 @@ void helper_wait(CPUMIPSState *env)
 
     cs->halted = 1;
     cpu_reset_interrupt(cs, CPU_INTERRUPT_WAKE);
-    /* Last instruction in the block, PC was updated before
-       - no need to recover PC and icount */
+    /*
+     * Last instruction in the block, PC was updated before
+     * - no need to recover PC and icount.
+     */
     raise_exception(env, EXCP_HLT);
 }
 
@@ -2731,13 +2817,15 @@ target_ulong helper_cfc1(CPUMIPSState *env, uint32_t reg)
         }
         break;
     case 25:
-        arg1 = ((env->active_fpu.fcr31 >> 24) & 0xfe) | ((env->active_fpu.fcr31 >> 23) & 0x1);
+        arg1 = ((env->active_fpu.fcr31 >> 24) & 0xfe) |
+               ((env->active_fpu.fcr31 >> 23) & 0x1);
         break;
     case 26:
         arg1 = env->active_fpu.fcr31 & 0x0003f07c;
         break;
     case 28:
-        arg1 = (env->active_fpu.fcr31 & 0x00000f83) | ((env->active_fpu.fcr31 >> 22) & 0x4);
+        arg1 = (env->active_fpu.fcr31 & 0x00000f83) |
+               ((env->active_fpu.fcr31 >> 22) & 0x4);
         break;
     default:
         arg1 = (int32_t)env->active_fpu.fcr31;
@@ -2802,19 +2890,24 @@ void helper_ctc1(CPUMIPSState *env, target_ulong arg1, uint32_t fs, uint32_t rt)
         if ((env->insn_flags & ISA_MIPS32R6) || (arg1 & 0xffffff00)) {
             return;
         }
-        env->active_fpu.fcr31 = (env->active_fpu.fcr31 & 0x017fffff) | ((arg1 & 0xfe) << 24) |
-                     ((arg1 & 0x1) << 23);
+        env->active_fpu.fcr31 = (env->active_fpu.fcr31 & 0x017fffff) |
+                                ((arg1 & 0xfe) << 24) |
+                                ((arg1 & 0x1) << 23);
         break;
     case 26:
-        if (arg1 & 0x007c0000)
+        if (arg1 & 0x007c0000) {
             return;
-        env->active_fpu.fcr31 = (env->active_fpu.fcr31 & 0xfffc0f83) | (arg1 & 0x0003f07c);
+        }
+        env->active_fpu.fcr31 = (env->active_fpu.fcr31 & 0xfffc0f83) |
+                                (arg1 & 0x0003f07c);
         break;
     case 28:
-        if (arg1 & 0x007c0000)
+        if (arg1 & 0x007c0000) {
             return;
-        env->active_fpu.fcr31 = (env->active_fpu.fcr31 & 0xfefff07c) | (arg1 & 0x00000f83) |
-                     ((arg1 & 0x4) << 22);
+        }
+        env->active_fpu.fcr31 = (env->active_fpu.fcr31 & 0xfefff07c) |
+                                (arg1 & 0x00000f83) |
+                                ((arg1 & 0x4) << 22);
         break;
     case 31:
         env->active_fpu.fcr31 = (arg1 & env->active_fpu.fcr31_rw_bitmask) |
@@ -2828,8 +2921,10 @@ void helper_ctc1(CPUMIPSState *env, target_ulong arg1, uint32_t fs, uint32_t rt)
     }
     restore_fp_status(env);
     set_float_exception_flags(0, &env->active_fpu.fp_status);
-    if ((GET_FP_ENABLE(env->active_fpu.fcr31) | 0x20) & GET_FP_CAUSE(env->active_fpu.fcr31))
+    if ((GET_FP_ENABLE(env->active_fpu.fcr31) | 0x20) &
+        GET_FP_CAUSE(env->active_fpu.fcr31)) {
         do_raise_exception(env, EXCP_FPE, GETPC());
+    }
 }
 
 int ieee_ex_to_mips(int xcpt)
@@ -2857,7 +2952,8 @@ int ieee_ex_to_mips(int xcpt)
 
 static inline void update_fcr31(CPUMIPSState *env, uintptr_t pc)
 {
-    int tmp = ieee_ex_to_mips(get_float_exception_flags(&env->active_fpu.fp_status));
+    int tmp = ieee_ex_to_mips(get_float_exception_flags(
+                                  &env->active_fpu.fp_status));
 
     SET_FP_CAUSE(env->active_fpu.fcr31, tmp);
 
@@ -2872,10 +2968,12 @@ static inline void update_fcr31(CPUMIPSState *env, uintptr_t pc)
     }
 }
 
-/* Float support.
-   Single precition routines have a "s" suffix, double precision a
-   "d" suffix, 32bit integer "w", 64bit integer "l", paired single "ps",
-   paired single lower "pl", paired single upper "pu".  */
+/*
+ * Float support.
+ * Single precition routines have a "s" suffix, double precision a
+ * "d" suffix, 32bit integer "w", 64bit integer "l", paired single "ps",
+ * paired single lower "pl", paired single upper "pu".
+ */
 
 /* unary operations, modifying fp status  */
 uint64_t helper_float_sqrt_d(CPUMIPSState *env, uint64_t fdt0)
@@ -3056,7 +3154,8 @@ uint64_t helper_float_round_l_d(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t dt2;
 
-    set_float_rounding_mode(float_round_nearest_even, &env->active_fpu.fp_status);
+    set_float_rounding_mode(float_round_nearest_even,
+                            &env->active_fpu.fp_status);
     dt2 = float64_to_int64(fdt0, &env->active_fpu.fp_status);
     restore_rounding_mode(env);
     if (get_float_exception_flags(&env->active_fpu.fp_status)
@@ -3071,7 +3170,8 @@ uint64_t helper_float_round_l_s(CPUMIPSState *env, uint32_t fst0)
 {
     uint64_t dt2;
 
-    set_float_rounding_mode(float_round_nearest_even, &env->active_fpu.fp_status);
+    set_float_rounding_mode(float_round_nearest_even,
+                            &env->active_fpu.fp_status);
     dt2 = float32_to_int64(fst0, &env->active_fpu.fp_status);
     restore_rounding_mode(env);
     if (get_float_exception_flags(&env->active_fpu.fp_status)
@@ -3086,7 +3186,8 @@ uint32_t helper_float_round_w_d(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t wt2;
 
-    set_float_rounding_mode(float_round_nearest_even, &env->active_fpu.fp_status);
+    set_float_rounding_mode(float_round_nearest_even,
+                            &env->active_fpu.fp_status);
     wt2 = float64_to_int32(fdt0, &env->active_fpu.fp_status);
     restore_rounding_mode(env);
     if (get_float_exception_flags(&env->active_fpu.fp_status)
@@ -3101,7 +3202,8 @@ uint32_t helper_float_round_w_s(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t wt2;
 
-    set_float_rounding_mode(float_round_nearest_even, &env->active_fpu.fp_status);
+    set_float_rounding_mode(float_round_nearest_even,
+                            &env->active_fpu.fp_status);
     wt2 = float32_to_int32(fst0, &env->active_fpu.fp_status);
     restore_rounding_mode(env);
     if (get_float_exception_flags(&env->active_fpu.fp_status)
@@ -3116,7 +3218,8 @@ uint64_t helper_float_trunc_l_d(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t dt2;
 
-    dt2 = float64_to_int64_round_to_zero(fdt0, &env->active_fpu.fp_status);
+    dt2 = float64_to_int64_round_to_zero(fdt0,
+                                         &env->active_fpu.fp_status);
     if (get_float_exception_flags(&env->active_fpu.fp_status)
         & (float_flag_invalid | float_flag_overflow)) {
         dt2 = FP_TO_INT64_OVERFLOW;
@@ -3697,7 +3800,8 @@ uint64_t helper_float_recip1_ps(CPUMIPSState *env, uint64_t fdt0)
     uint32_t fst2;
     uint32_t fsth2;
 
-    fst2 = float32_div(float32_one, fdt0 & 0XFFFFFFFF, &env->active_fpu.fp_status);
+    fst2 = float32_div(float32_one, fdt0 & 0XFFFFFFFF,
+                       &env->active_fpu.fp_status);
     fsth2 = float32_div(float32_one, fdt0 >> 32, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
     return ((uint64_t)fsth2 << 32) | fst2;
@@ -3737,8 +3841,8 @@ uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
 }
 
 #define FLOAT_RINT(name, bits)                                              \
-uint ## bits ## _t helper_float_ ## name (CPUMIPSState *env,                \
-                                          uint ## bits ## _t fs)            \
+uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,                 \
+                                         uint ## bits ## _t fs)             \
 {                                                                           \
     uint ## bits ## _t fdret;                                               \
                                                                             \
@@ -3763,8 +3867,8 @@ FLOAT_RINT(rint_d, 64)
 #define FLOAT_CLASS_POSITIVE_ZERO      0x200
 
 #define FLOAT_CLASS(name, bits)                                      \
-uint ## bits ## _t float_ ## name (uint ## bits ## _t arg,           \
-                                   float_status *status)             \
+uint ## bits ## _t float_ ## name(uint ## bits ## _t arg,            \
+                                  float_status *status)              \
 {                                                                    \
     if (float ## bits ## _is_signaling_nan(arg, status)) {           \
         return FLOAT_CLASS_SIGNALING_NAN;                            \
@@ -3793,8 +3897,8 @@ uint ## bits ## _t float_ ## name (uint ## bits ## _t arg,           \
     }                                                                \
 }                                                                    \
                                                                      \
-uint ## bits ## _t helper_float_ ## name (CPUMIPSState *env,         \
-                                          uint ## bits ## _t arg)    \
+uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,          \
+                                         uint ## bits ## _t arg)     \
 {                                                                    \
     return float_ ## name(arg, &env->active_fpu.fp_status);          \
 }
@@ -3810,7 +3914,7 @@ uint64_t helper_float_ ## name ## _d(CPUMIPSState *env,            \
 {                                                                  \
     uint64_t dt2;                                                  \
                                                                    \
-    dt2 = float64_ ## name (fdt0, fdt1, &env->active_fpu.fp_status);     \
+    dt2 = float64_ ## name(fdt0, fdt1, &env->active_fpu.fp_status);\
     update_fcr31(env, GETPC());                                    \
     return dt2;                                                    \
 }                                                                  \
@@ -3820,7 +3924,7 @@ uint32_t helper_float_ ## name ## _s(CPUMIPSState *env,            \
 {                                                                  \
     uint32_t wt2;                                                  \
                                                                    \
-    wt2 = float32_ ## name (fst0, fst1, &env->active_fpu.fp_status);     \
+    wt2 = float32_ ## name(fst0, fst1, &env->active_fpu.fp_status);\
     update_fcr31(env, GETPC());                                    \
     return wt2;                                                    \
 }                                                                  \
@@ -3836,8 +3940,8 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
     uint32_t wt2;                                                  \
     uint32_t wth2;                                                 \
                                                                    \
-    wt2 = float32_ ## name (fst0, fst1, &env->active_fpu.fp_status);     \
-    wth2 = float32_ ## name (fsth0, fsth1, &env->active_fpu.fp_status);  \
+    wt2 = float32_ ## name(fst0, fst1, &env->active_fpu.fp_status);     \
+    wth2 = float32_ ## name(fsth0, fsth1, &env->active_fpu.fp_status);  \
     update_fcr31(env, GETPC());                                    \
     return ((uint64_t)wth2 << 32) | wt2;                           \
 }
@@ -3852,7 +3956,8 @@ FLOAT_BINOP(div)
 uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
 {
     fdt2 = float64_mul(fdt0, fdt2, &env->active_fpu.fp_status);
-    fdt2 = float64_chs(float64_sub(fdt2, float64_one, &env->active_fpu.fp_status));
+    fdt2 = float64_chs(float64_sub(fdt2, float64_one,
+                                   &env->active_fpu.fp_status));
     update_fcr31(env, GETPC());
     return fdt2;
 }
@@ -3860,7 +3965,8 @@ uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
 uint32_t helper_float_recip2_s(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
 {
     fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
-    fst2 = float32_chs(float32_sub(fst2, float32_one, &env->active_fpu.fp_status));
+    fst2 = float32_chs(float32_sub(fst2, float32_one,
+                                       &env->active_fpu.fp_status));
     update_fcr31(env, GETPC());
     return fst2;
 }
@@ -3874,8 +3980,10 @@ uint64_t helper_float_recip2_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
 
     fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
     fsth2 = float32_mul(fsth0, fsth2, &env->active_fpu.fp_status);
-    fst2 = float32_chs(float32_sub(fst2, float32_one, &env->active_fpu.fp_status));
-    fsth2 = float32_chs(float32_sub(fsth2, float32_one, &env->active_fpu.fp_status));
+    fst2 = float32_chs(float32_sub(fst2, float32_one,
+                                       &env->active_fpu.fp_status));
+    fsth2 = float32_chs(float32_sub(fsth2, float32_one,
+                                       &env->active_fpu.fp_status));
     update_fcr31(env, GETPC());
     return ((uint64_t)fsth2 << 32) | fst2;
 }
@@ -3884,7 +3992,8 @@ uint64_t helper_float_rsqrt2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
 {
     fdt2 = float64_mul(fdt0, fdt2, &env->active_fpu.fp_status);
     fdt2 = float64_sub(fdt2, float64_one, &env->active_fpu.fp_status);
-    fdt2 = float64_chs(float64_div(fdt2, FLOAT_TWO64, &env->active_fpu.fp_status));
+    fdt2 = float64_chs(float64_div(fdt2, FLOAT_TWO64,
+                                       &env->active_fpu.fp_status));
     update_fcr31(env, GETPC());
     return fdt2;
 }
@@ -3893,7 +4002,8 @@ uint32_t helper_float_rsqrt2_s(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
 {
     fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
     fst2 = float32_sub(fst2, float32_one, &env->active_fpu.fp_status);
-    fst2 = float32_chs(float32_div(fst2, FLOAT_TWO32, &env->active_fpu.fp_status));
+    fst2 = float32_chs(float32_div(fst2, FLOAT_TWO32,
+                                       &env->active_fpu.fp_status));
     update_fcr31(env, GETPC());
     return fst2;
 }
@@ -3909,8 +4019,10 @@ uint64_t helper_float_rsqrt2_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
     fsth2 = float32_mul(fsth0, fsth2, &env->active_fpu.fp_status);
     fst2 = float32_sub(fst2, float32_one, &env->active_fpu.fp_status);
     fsth2 = float32_sub(fsth2, float32_one, &env->active_fpu.fp_status);
-    fst2 = float32_chs(float32_div(fst2, FLOAT_TWO32, &env->active_fpu.fp_status));
-    fsth2 = float32_chs(float32_div(fsth2, FLOAT_TWO32, &env->active_fpu.fp_status));
+    fst2 = float32_chs(float32_div(fst2, FLOAT_TWO32,
+                                       &env->active_fpu.fp_status));
+    fsth2 = float32_chs(float32_div(fsth2, FLOAT_TWO32,
+                                       &env->active_fpu.fp_status));
     update_fcr31(env, GETPC());
     return ((uint64_t)fsth2 << 32) | fst2;
 }
@@ -3924,8 +4036,8 @@ uint64_t helper_float_addr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
     uint32_t fst2;
     uint32_t fsth2;
 
-    fst2 = float32_add (fst0, fsth0, &env->active_fpu.fp_status);
-    fsth2 = float32_add (fst1, fsth1, &env->active_fpu.fp_status);
+    fst2 = float32_add(fst0, fsth0, &env->active_fpu.fp_status);
+    fsth2 = float32_add(fst1, fsth1, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
     return ((uint64_t)fsth2 << 32) | fst2;
 }
@@ -3939,16 +4051,16 @@ uint64_t helper_float_mulr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
     uint32_t fst2;
     uint32_t fsth2;
 
-    fst2 = float32_mul (fst0, fsth0, &env->active_fpu.fp_status);
-    fsth2 = float32_mul (fst1, fsth1, &env->active_fpu.fp_status);
+    fst2 = float32_mul(fst0, fsth0, &env->active_fpu.fp_status);
+    fsth2 = float32_mul(fst1, fsth1, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
     return ((uint64_t)fsth2 << 32) | fst2;
 }
 
 #define FLOAT_MINMAX(name, bits, minmaxfunc)                            \
-uint ## bits ## _t helper_float_ ## name (CPUMIPSState *env,            \
-                                          uint ## bits ## _t fs,        \
-                                          uint ## bits ## _t ft)        \
+uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
+                                         uint ## bits ## _t fs,         \
+                                         uint ## bits ## _t ft)         \
 {                                                                       \
     uint ## bits ## _t fdret;                                           \
                                                                         \
@@ -4026,10 +4138,10 @@ FLOAT_FMA(nmsub, float_muladd_negate_result | float_muladd_negate_c)
 #undef FLOAT_FMA
 
 #define FLOAT_FMADDSUB(name, bits, muladd_arg)                          \
-uint ## bits ## _t helper_float_ ## name (CPUMIPSState *env,            \
-                                          uint ## bits ## _t fs,        \
-                                          uint ## bits ## _t ft,        \
-                                          uint ## bits ## _t fd)        \
+uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
+                                         uint ## bits ## _t fs,         \
+                                         uint ## bits ## _t ft,         \
+                                         uint ## bits ## _t fd)         \
 {                                                                       \
     uint ## bits ## _t fdret;                                           \
                                                                         \
@@ -4072,26 +4184,58 @@ void helper_cmpabs_d_ ## op(CPUMIPSState *env, uint64_t fdt0,  \
         CLEAR_FP_COND(cc, env->active_fpu);                    \
 }
 
-/* NOTE: the comma operator will make "cond" to eval to false,
- * but float64_unordered_quiet() is still called. */
-FOP_COND_D(f,   (float64_unordered_quiet(fdt1, fdt0, &env->active_fpu.fp_status), 0))
-FOP_COND_D(un,  float64_unordered_quiet(fdt1, fdt0, &env->active_fpu.fp_status))
-FOP_COND_D(eq,  float64_eq_quiet(fdt0, fdt1, &env->active_fpu.fp_status))
-FOP_COND_D(ueq, float64_unordered_quiet(fdt1, fdt0, &env->active_fpu.fp_status)  || float64_eq_quiet(fdt0, fdt1, &env->active_fpu.fp_status))
-FOP_COND_D(olt, float64_lt_quiet(fdt0, fdt1, &env->active_fpu.fp_status))
-FOP_COND_D(ult, float64_unordered_quiet(fdt1, fdt0, &env->active_fpu.fp_status)  || float64_lt_quiet(fdt0, fdt1, &env->active_fpu.fp_status))
-FOP_COND_D(ole, float64_le_quiet(fdt0, fdt1, &env->active_fpu.fp_status))
-FOP_COND_D(ule, float64_unordered_quiet(fdt1, fdt0, &env->active_fpu.fp_status)  || float64_le_quiet(fdt0, fdt1, &env->active_fpu.fp_status))
-/* NOTE: the comma operator will make "cond" to eval to false,
- * but float64_unordered() is still called. */
-FOP_COND_D(sf,  (float64_unordered(fdt1, fdt0, &env->active_fpu.fp_status), 0))
-FOP_COND_D(ngle,float64_unordered(fdt1, fdt0, &env->active_fpu.fp_status))
-FOP_COND_D(seq, float64_eq(fdt0, fdt1, &env->active_fpu.fp_status))
-FOP_COND_D(ngl, float64_unordered(fdt1, fdt0, &env->active_fpu.fp_status)  || float64_eq(fdt0, fdt1, &env->active_fpu.fp_status))
-FOP_COND_D(lt,  float64_lt(fdt0, fdt1, &env->active_fpu.fp_status))
-FOP_COND_D(nge, float64_unordered(fdt1, fdt0, &env->active_fpu.fp_status)  || float64_lt(fdt0, fdt1, &env->active_fpu.fp_status))
-FOP_COND_D(le,  float64_le(fdt0, fdt1, &env->active_fpu.fp_status))
-FOP_COND_D(ngt, float64_unordered(fdt1, fdt0, &env->active_fpu.fp_status)  || float64_le(fdt0, fdt1, &env->active_fpu.fp_status))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float64_unordered_quiet() is still called.
+ */
+FOP_COND_D(f,    (float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_COND_D(un,   float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(eq,   float64_eq_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(ueq,  float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_eq_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(olt,  float64_lt_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(ult,  float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_lt_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(ole,  float64_le_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(ule,  float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_le_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float64_unordered() is still called.
+ */
+FOP_COND_D(sf,   (float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_COND_D(ngle, float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(seq,  float64_eq(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(ngl,  float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_eq(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(lt,   float64_lt(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(nge,  float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_lt(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(le,   float64_le(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_D(ngt,  float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_le(fdt0, fdt1,
+                                       &env->active_fpu.fp_status))
 
 #define FOP_COND_S(op, cond)                                   \
 void helper_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0,     \
@@ -4119,26 +4263,58 @@ void helper_cmpabs_s_ ## op(CPUMIPSState *env, uint32_t fst0,  \
         CLEAR_FP_COND(cc, env->active_fpu);                    \
 }
 
-/* NOTE: the comma operator will make "cond" to eval to false,
- * but float32_unordered_quiet() is still called. */
-FOP_COND_S(f,   (float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status), 0))
-FOP_COND_S(un,  float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status))
-FOP_COND_S(eq,  float32_eq_quiet(fst0, fst1, &env->active_fpu.fp_status))
-FOP_COND_S(ueq, float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status)  || float32_eq_quiet(fst0, fst1, &env->active_fpu.fp_status))
-FOP_COND_S(olt, float32_lt_quiet(fst0, fst1, &env->active_fpu.fp_status))
-FOP_COND_S(ult, float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status)  || float32_lt_quiet(fst0, fst1, &env->active_fpu.fp_status))
-FOP_COND_S(ole, float32_le_quiet(fst0, fst1, &env->active_fpu.fp_status))
-FOP_COND_S(ule, float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status)  || float32_le_quiet(fst0, fst1, &env->active_fpu.fp_status))
-/* NOTE: the comma operator will make "cond" to eval to false,
- * but float32_unordered() is still called. */
-FOP_COND_S(sf,  (float32_unordered(fst1, fst0, &env->active_fpu.fp_status), 0))
-FOP_COND_S(ngle,float32_unordered(fst1, fst0, &env->active_fpu.fp_status))
-FOP_COND_S(seq, float32_eq(fst0, fst1, &env->active_fpu.fp_status))
-FOP_COND_S(ngl, float32_unordered(fst1, fst0, &env->active_fpu.fp_status)  || float32_eq(fst0, fst1, &env->active_fpu.fp_status))
-FOP_COND_S(lt,  float32_lt(fst0, fst1, &env->active_fpu.fp_status))
-FOP_COND_S(nge, float32_unordered(fst1, fst0, &env->active_fpu.fp_status)  || float32_lt(fst0, fst1, &env->active_fpu.fp_status))
-FOP_COND_S(le,  float32_le(fst0, fst1, &env->active_fpu.fp_status))
-FOP_COND_S(ngt, float32_unordered(fst1, fst0, &env->active_fpu.fp_status)  || float32_le(fst0, fst1, &env->active_fpu.fp_status))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float32_unordered_quiet() is still called.
+ */
+FOP_COND_S(f,    (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_COND_S(un,   float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(eq,   float32_eq_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(ueq,  float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                 || float32_eq_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(olt,  float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(ult,  float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                 || float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(ole,  float32_le_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(ule,  float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                 || float32_le_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float32_unordered() is still called.
+ */
+FOP_COND_S(sf,   (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_COND_S(ngle, float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(seq,  float32_eq(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(ngl,  float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                 || float32_eq(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(lt,   float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(nge,  float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                 || float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(le,   float32_le(fst0, fst1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_S(ngt,  float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                 || float32_le(fst0, fst1,
+                                       &env->active_fpu.fp_status))
 
 #define FOP_COND_PS(op, condl, condh)                           \
 void helper_cmp_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,     \
@@ -4184,47 +4360,107 @@ void helper_cmpabs_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,  \
         CLEAR_FP_COND(cc + 1, env->active_fpu);                 \
 }
 
-/* NOTE: the comma operator will make "cond" to eval to false,
- * but float32_unordered_quiet() is still called. */
-FOP_COND_PS(f,   (float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status), 0),
-                 (float32_unordered_quiet(fsth1, fsth0, &env->active_fpu.fp_status), 0))
-FOP_COND_PS(un,  float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status),
-                 float32_unordered_quiet(fsth1, fsth0, &env->active_fpu.fp_status))
-FOP_COND_PS(eq,  float32_eq_quiet(fst0, fst1, &env->active_fpu.fp_status),
-                 float32_eq_quiet(fsth0, fsth1, &env->active_fpu.fp_status))
-FOP_COND_PS(ueq, float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status)    || float32_eq_quiet(fst0, fst1, &env->active_fpu.fp_status),
-                 float32_unordered_quiet(fsth1, fsth0, &env->active_fpu.fp_status)  || float32_eq_quiet(fsth0, fsth1, &env->active_fpu.fp_status))
-FOP_COND_PS(olt, float32_lt_quiet(fst0, fst1, &env->active_fpu.fp_status),
-                 float32_lt_quiet(fsth0, fsth1, &env->active_fpu.fp_status))
-FOP_COND_PS(ult, float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status)    || float32_lt_quiet(fst0, fst1, &env->active_fpu.fp_status),
-                 float32_unordered_quiet(fsth1, fsth0, &env->active_fpu.fp_status)  || float32_lt_quiet(fsth0, fsth1, &env->active_fpu.fp_status))
-FOP_COND_PS(ole, float32_le_quiet(fst0, fst1, &env->active_fpu.fp_status),
-                 float32_le_quiet(fsth0, fsth1, &env->active_fpu.fp_status))
-FOP_COND_PS(ule, float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status)    || float32_le_quiet(fst0, fst1, &env->active_fpu.fp_status),
-                 float32_unordered_quiet(fsth1, fsth0, &env->active_fpu.fp_status)  || float32_le_quiet(fsth0, fsth1, &env->active_fpu.fp_status))
-/* NOTE: the comma operator will make "cond" to eval to false,
- * but float32_unordered() is still called. */
-FOP_COND_PS(sf,  (float32_unordered(fst1, fst0, &env->active_fpu.fp_status), 0),
-                 (float32_unordered(fsth1, fsth0, &env->active_fpu.fp_status), 0))
-FOP_COND_PS(ngle,float32_unordered(fst1, fst0, &env->active_fpu.fp_status),
-                 float32_unordered(fsth1, fsth0, &env->active_fpu.fp_status))
-FOP_COND_PS(seq, float32_eq(fst0, fst1, &env->active_fpu.fp_status),
-                 float32_eq(fsth0, fsth1, &env->active_fpu.fp_status))
-FOP_COND_PS(ngl, float32_unordered(fst1, fst0, &env->active_fpu.fp_status)    || float32_eq(fst0, fst1, &env->active_fpu.fp_status),
-                 float32_unordered(fsth1, fsth0, &env->active_fpu.fp_status)  || float32_eq(fsth0, fsth1, &env->active_fpu.fp_status))
-FOP_COND_PS(lt,  float32_lt(fst0, fst1, &env->active_fpu.fp_status),
-                 float32_lt(fsth0, fsth1, &env->active_fpu.fp_status))
-FOP_COND_PS(nge, float32_unordered(fst1, fst0, &env->active_fpu.fp_status)    || float32_lt(fst0, fst1, &env->active_fpu.fp_status),
-                 float32_unordered(fsth1, fsth0, &env->active_fpu.fp_status)  || float32_lt(fsth0, fsth1, &env->active_fpu.fp_status))
-FOP_COND_PS(le,  float32_le(fst0, fst1, &env->active_fpu.fp_status),
-                 float32_le(fsth0, fsth1, &env->active_fpu.fp_status))
-FOP_COND_PS(ngt, float32_unordered(fst1, fst0, &env->active_fpu.fp_status)    || float32_le(fst0, fst1, &env->active_fpu.fp_status),
-                 float32_unordered(fsth1, fsth0, &env->active_fpu.fp_status)  || float32_le(fsth0, fsth1, &env->active_fpu.fp_status))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float32_unordered_quiet() is still called.
+ */
+FOP_COND_PS(f,    (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status), 0),
+                  (float32_unordered_quiet(fsth1, fsth0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_COND_PS(un,   float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered_quiet(fsth1, fsth0,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(eq,   float32_eq_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_eq_quiet(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(ueq,  float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                  || float32_eq_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered_quiet(fsth1, fsth0,
+                                       &env->active_fpu.fp_status)
+                  || float32_eq_quiet(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(olt,  float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_lt_quiet(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(ult,  float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                  || float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered_quiet(fsth1, fsth0,
+                                       &env->active_fpu.fp_status)
+                  || float32_lt_quiet(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(ole,  float32_le_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_le_quiet(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(ule,  float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                  || float32_le_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered_quiet(fsth1, fsth0,
+                                       &env->active_fpu.fp_status)
+                  || float32_le_quiet(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float32_unordered() is still called.
+ */
+FOP_COND_PS(sf,   (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status), 0),
+                  (float32_unordered(fsth1, fsth0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_COND_PS(ngle, float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered(fsth1, fsth0,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(seq,  float32_eq(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_eq(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(ngl,  float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                  || float32_eq(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered(fsth1, fsth0,
+                                       &env->active_fpu.fp_status)
+                  || float32_eq(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(lt,   float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_lt(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(nge,  float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                  || float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered(fsth1, fsth0,
+                                       &env->active_fpu.fp_status)
+                  || float32_lt(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(le,   float32_le(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_le(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
+FOP_COND_PS(ngt,  float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                  || float32_le(fst0, fst1,
+                                       &env->active_fpu.fp_status),
+                  float32_unordered(fsth1, fsth0,
+                                       &env->active_fpu.fp_status)
+                  || float32_le(fsth0, fsth1,
+                                       &env->active_fpu.fp_status))
 
 /* R6 compare operations */
 #define FOP_CONDN_D(op, cond)                                       \
-uint64_t helper_r6_cmp_d_ ## op(CPUMIPSState * env, uint64_t fdt0,  \
-                         uint64_t fdt1)                             \
+uint64_t helper_r6_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0,   \
+                                uint64_t fdt1)                      \
 {                                                                   \
     uint64_t c;                                                     \
     c = cond;                                                       \
@@ -4236,50 +4472,90 @@ uint64_t helper_r6_cmp_d_ ## op(CPUMIPSState * env, uint64_t fdt0,  \
     }                                                               \
 }
 
-/* NOTE: the comma operator will make "cond" to eval to false,
- * but float64_unordered_quiet() is still called. */
-FOP_CONDN_D(af,  (float64_unordered_quiet(fdt1, fdt0, &env->active_fpu.fp_status), 0))
-FOP_CONDN_D(un,  (float64_unordered_quiet(fdt1, fdt0, &env->active_fpu.fp_status)))
-FOP_CONDN_D(eq,  (float64_eq_quiet(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(ueq, (float64_unordered_quiet(fdt1, fdt0, &env->active_fpu.fp_status)
-                  || float64_eq_quiet(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(lt,  (float64_lt_quiet(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(ult, (float64_unordered_quiet(fdt1, fdt0, &env->active_fpu.fp_status)
-                  || float64_lt_quiet(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(le,  (float64_le_quiet(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(ule, (float64_unordered_quiet(fdt1, fdt0, &env->active_fpu.fp_status)
-                  || float64_le_quiet(fdt0, fdt1, &env->active_fpu.fp_status)))
-/* NOTE: the comma operator will make "cond" to eval to false,
- * but float64_unordered() is still called. */
-FOP_CONDN_D(saf,  (float64_unordered(fdt1, fdt0, &env->active_fpu.fp_status), 0))
-FOP_CONDN_D(sun,  (float64_unordered(fdt1, fdt0, &env->active_fpu.fp_status)))
-FOP_CONDN_D(seq,  (float64_eq(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(sueq, (float64_unordered(fdt1, fdt0, &env->active_fpu.fp_status)
-                   || float64_eq(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(slt,  (float64_lt(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(sult, (float64_unordered(fdt1, fdt0, &env->active_fpu.fp_status)
-                   || float64_lt(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(sle,  (float64_le(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(sule, (float64_unordered(fdt1, fdt0, &env->active_fpu.fp_status)
-                   || float64_le(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(or,   (float64_le_quiet(fdt1, fdt0, &env->active_fpu.fp_status)
-                   || float64_le_quiet(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(une,  (float64_unordered_quiet(fdt1, fdt0, &env->active_fpu.fp_status)
-                   || float64_lt_quiet(fdt1, fdt0, &env->active_fpu.fp_status)
-                   || float64_lt_quiet(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(ne,   (float64_lt_quiet(fdt1, fdt0, &env->active_fpu.fp_status)
-                   || float64_lt_quiet(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(sor,  (float64_le(fdt1, fdt0, &env->active_fpu.fp_status)
-                   || float64_le(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(sune, (float64_unordered(fdt1, fdt0, &env->active_fpu.fp_status)
-                   || float64_lt(fdt1, fdt0, &env->active_fpu.fp_status)
-                   || float64_lt(fdt0, fdt1, &env->active_fpu.fp_status)))
-FOP_CONDN_D(sne,  (float64_lt(fdt1, fdt0, &env->active_fpu.fp_status)
-                   || float64_lt(fdt0, fdt1, &env->active_fpu.fp_status)))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float64_unordered_quiet() is still called.
+ */
+FOP_CONDN_D(af,  (float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_CONDN_D(un,  (float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(eq,  (float64_eq_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(ueq, (float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_eq_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(lt,  (float64_lt_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(ult, (float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_lt_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(le,  (float64_le_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(ule, (float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                 || float64_le_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float64_unordered() is still called.\
+ */
+FOP_CONDN_D(saf,  (float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_CONDN_D(sun,  (float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(seq,  (float64_eq(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(sueq, (float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_eq(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(slt,  (float64_lt(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(sult, (float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_lt(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(sle,  (float64_le(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(sule, (float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_le(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(or,   (float64_le_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_le_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(une,  (float64_unordered_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_lt_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_lt_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(ne,   (float64_lt_quiet(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_lt_quiet(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(sor,  (float64_le(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_le(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(sune, (float64_unordered(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_lt(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_lt(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_D(sne,  (float64_lt(fdt1, fdt0,
+                                       &env->active_fpu.fp_status)
+                   || float64_lt(fdt0, fdt1,
+                                       &env->active_fpu.fp_status)))
 
 #define FOP_CONDN_S(op, cond)                                       \
-uint32_t helper_r6_cmp_s_ ## op(CPUMIPSState * env, uint32_t fst0,  \
-                         uint32_t fst1)                             \
+uint32_t helper_r6_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0,   \
+                                uint32_t fst1)                      \
 {                                                                   \
     uint64_t c;                                                     \
     c = cond;                                                       \
@@ -4291,46 +4567,86 @@ uint32_t helper_r6_cmp_s_ ## op(CPUMIPSState * env, uint32_t fst0,  \
     }                                                               \
 }
 
-/* NOTE: the comma operator will make "cond" to eval to false,
- * but float32_unordered_quiet() is still called. */
-FOP_CONDN_S(af,   (float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status), 0))
-FOP_CONDN_S(un,   (float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status)))
-FOP_CONDN_S(eq,   (float32_eq_quiet(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(ueq,  (float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status)
-                   || float32_eq_quiet(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(lt,   (float32_lt_quiet(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(ult,  (float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status)
-                   || float32_lt_quiet(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(le,   (float32_le_quiet(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(ule,  (float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status)
-                   || float32_le_quiet(fst0, fst1, &env->active_fpu.fp_status)))
-/* NOTE: the comma operator will make "cond" to eval to false,
- * but float32_unordered() is still called. */
-FOP_CONDN_S(saf,  (float32_unordered(fst1, fst0, &env->active_fpu.fp_status), 0))
-FOP_CONDN_S(sun,  (float32_unordered(fst1, fst0, &env->active_fpu.fp_status)))
-FOP_CONDN_S(seq,  (float32_eq(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(sueq, (float32_unordered(fst1, fst0, &env->active_fpu.fp_status)
-                   || float32_eq(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(slt,  (float32_lt(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(sult, (float32_unordered(fst1, fst0, &env->active_fpu.fp_status)
-                   || float32_lt(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(sle,  (float32_le(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(sule, (float32_unordered(fst1, fst0, &env->active_fpu.fp_status)
-                   || float32_le(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(or,   (float32_le_quiet(fst1, fst0, &env->active_fpu.fp_status)
-                   || float32_le_quiet(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(une,  (float32_unordered_quiet(fst1, fst0, &env->active_fpu.fp_status)
-                   || float32_lt_quiet(fst1, fst0, &env->active_fpu.fp_status)
-                   || float32_lt_quiet(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(ne,   (float32_lt_quiet(fst1, fst0, &env->active_fpu.fp_status)
-                   || float32_lt_quiet(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(sor,  (float32_le(fst1, fst0, &env->active_fpu.fp_status)
-                   || float32_le(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(sune, (float32_unordered(fst1, fst0, &env->active_fpu.fp_status)
-                   || float32_lt(fst1, fst0, &env->active_fpu.fp_status)
-                   || float32_lt(fst0, fst1, &env->active_fpu.fp_status)))
-FOP_CONDN_S(sne,  (float32_lt(fst1, fst0, &env->active_fpu.fp_status)
-                   || float32_lt(fst0, fst1, &env->active_fpu.fp_status)))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float32_unordered_quiet() is still called.
+ */
+FOP_CONDN_S(af,   (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_CONDN_S(un,   (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(eq,   (float32_eq_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(ueq,  (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_eq_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(lt,   (float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(ult,  (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(le,   (float32_le_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(ule,  (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_le_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+/*
+ * NOTE: the comma operator will make "cond" to eval to false,
+ * but float32_unordered() is still called.
+ */
+FOP_CONDN_S(saf,  (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status), 0))
+FOP_CONDN_S(sun,  (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(seq,  (float32_eq(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(sueq, (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_eq(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(slt,  (float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(sult, (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(sle,  (float32_le(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(sule, (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_le(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(or,   (float32_le_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_le_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(une,  (float32_unordered_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(ne,   (float32_lt_quiet(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt_quiet(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(sor,  (float32_le(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_le(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(sune, (float32_unordered(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
+FOP_CONDN_S(sne,  (float32_lt(fst1, fst0,
+                                       &env->active_fpu.fp_status)
+                   || float32_lt(fst0, fst1,
+                                       &env->active_fpu.fp_status)))
 
 /* MSA */
 /* Data format min and max values */
@@ -4522,7 +4838,7 @@ void helper_msa_ld_d(CPUMIPSState *env, uint32_t wd,
 }
 
 #define MSA_PAGESPAN(x) \
-        ((((x) & ~TARGET_PAGE_MASK) + MSA_WRLEN/8 - 1) >= TARGET_PAGE_SIZE)
+        ((((x) & ~TARGET_PAGE_MASK) + MSA_WRLEN / 8 - 1) >= TARGET_PAGE_SIZE)
 
 static inline void ensure_writable_pages(CPUMIPSState *env,
                                          target_ulong addr,
-- 
2.7.4


