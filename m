Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2FFC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2E3207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DqKwbaNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2E3207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57721 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGIi-0001il-3i
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:44:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8M-00012t-RH
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8J-000490-A1
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:14 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8J-00048c-1K
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:11 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so8383715otq.6
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=vE3e6PMhGjLXSh/X/O9LTv5nLv+W0lrSUYr/o4eJ7VI=;
	b=DqKwbaNAMmLGYhu15c41ulMF1x4lDWYw9AnI5vkpEeTsWkZhwjkVKP4FT4dFMrxqlW
	VFl02eLp3eJIHQqmTWfr/F0B/BqdhKqj4TkqaUIelL4Wspg6YhjmKlknkBca0E213Yli
	sokfo+CbxR+MLQW8KpCz5SxKkb7ATtUUTWLgMbAJQDKqTU//SQJ+i4hNiCkQ2tCd6YjX
	83jiuzBV6BQpSeg+XI2fx72OBs/bIkw4nTNYTqIWB/Vi6CpKZR+wvZ2FuKrokI541xPq
	KXXtEdnZZkPuxKZOzXXj7iIMzub6bo4AkGa2W41QB+oFdSSfT84l0L0AG2mJcnpO6YKJ
	ctLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=vE3e6PMhGjLXSh/X/O9LTv5nLv+W0lrSUYr/o4eJ7VI=;
	b=WTvh8uYWPMIVrinoZkk1wObRp7iHuQgvpiYabgb7Q+O73CsU7FLwfpGsc3iSJiYt3y
	BOgOR10i6EdT9CpVslnydqCw5LZgH0w/3B2sqbwhNju3y5lyT5v9De8dHwNhGVH1no4k
	zDT5GDpE0uuy0dUw73GhsdLwwl11ptvqinW6IP8Mr4H31kw1+yDn49SrKdX+SqXR3poA
	0x/igsVpCVeZUG/kJFsQH8miocFFLYc1rFxEulCNx6hLUceUPeeD+IpmDY8OrRdY6h3J
	7ACnTf9mWw9xWlakyWoy20Ox63CXCdOHDs7tL2oTcH7cUkCkjyB3XMasw4eQ8xlaut+S
	eAYg==
X-Gm-Message-State: APjAAAV4q4rAifna7U1ZqAyZPV4kcAHTOC8Yq1F19nkMEqRVfm2AwuYt
	rXN6IejfjUsZf4xyn3+P69fawQCeEwS3Fg==
X-Google-Smtp-Source: APXvYqyuqLFWenfUJy74gAtM2WOYnPMtmX/vFwWBQF3PXWWDAuqeA4cW0sUnya5f5JZSDW7pe1i7CQ==
X-Received: by 2002:a9d:69d9:: with SMTP id v25mr1734618oto.4.1559680449615;
	Tue, 04 Jun 2019 13:34:09 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.08
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:21 -0500
Message-Id: <20190604203351.27778-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [PATCH v4 09/39] target/arm: Use env_cpu, env_archcpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanup in the boilerplate that each target must define.
Replace arm_env_get_cpu with env_archcpu.  The combination
CPU(arm_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h              |   5 --
 linux-user/aarch64/cpu_loop.c |   6 +-
 linux-user/aarch64/signal.c   |   4 +-
 linux-user/arm/cpu_loop.c     |   2 +-
 linux-user/syscall.c          |   8 +--
 target/arm/arm-semi.c         |   4 +-
 target/arm/cpu64.c            |   2 +-
 target/arm/helper-a64.c       |   4 +-
 target/arm/helper.c           | 120 +++++++++++++++++-----------------
 target/arm/op_helper.c        |  21 +++---
 target/arm/translate-a64.c    |   2 +-
 target/arm/translate.c        |   2 +-
 target/arm/vfp_helper.c       |   2 +-
 13 files changed, 88 insertions(+), 94 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1afd1da491..c7df3816b5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -913,11 +913,6 @@ struct ARMCPU {
     uint32_t sve_max_vq;
 };
 
-static inline ARMCPU *arm_env_get_cpu(CPUARMState *env)
-{
-    return container_of(env, ARMCPU, env);
-}
-
 void arm_cpu_post_init(Object *obj);
 
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 2f2f63e3e8..18db6f80f0 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -73,7 +73,7 @@
 /* AArch64 main loop */
 void cpu_loop(CPUARMState *env)
 {
-    CPUState *cs = CPU(arm_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr;
     abi_long ret;
     target_siginfo_t info;
@@ -150,8 +150,8 @@ void cpu_loop(CPUARMState *env)
 
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
     TaskState *ts = cs->opaque;
     struct image_info *info = ts->info;
     int i;
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index f84a9cf28a..cd521ee42d 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -314,7 +314,7 @@ static int target_restore_sigframe(CPUARMState *env,
             break;
 
         case TARGET_SVE_MAGIC:
-            if (cpu_isar_feature(aa64_sve, arm_env_get_cpu(env))) {
+            if (cpu_isar_feature(aa64_sve, env_archcpu(env))) {
                 vq = (env->vfp.zcr_el[1] & 0xf) + 1;
                 sve_size = QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(vq), 16);
                 if (!sve && size == sve_size) {
@@ -433,7 +433,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                       &layout);
 
     /* SVE state needs saving only if it exists.  */
-    if (cpu_isar_feature(aa64_sve, arm_env_get_cpu(env))) {
+    if (cpu_isar_feature(aa64_sve, env_archcpu(env))) {
         vq = (env->vfp.zcr_el[1] & 0xf) + 1;
         sve_size = QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(vq), 16);
         sve_ofs = alloc_sigframe_space(sve_size, &layout);
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index b7e7a6323c..ece4cf335e 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -206,7 +206,7 @@ do_kernel_trap(CPUARMState *env)
 
 void cpu_loop(CPUARMState *env)
 {
-    CPUState *cs = CPU(arm_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr;
     unsigned int n, insn;
     target_siginfo_t info;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d1a2c7831f..ac3b5dc393 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9781,10 +9781,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
              * even though the current architectural maximum is VQ=16.
              */
             ret = -TARGET_EINVAL;
-            if (cpu_isar_feature(aa64_sve, arm_env_get_cpu(cpu_env))
+            if (cpu_isar_feature(aa64_sve, env_archcpu(cpu_env))
                 && arg2 >= 0 && arg2 <= 512 * 16 && !(arg2 & 15)) {
                 CPUARMState *env = cpu_env;
-                ARMCPU *cpu = arm_env_get_cpu(env);
+                ARMCPU *cpu = env_archcpu(env);
                 uint32_t vq, old_vq;
 
                 old_vq = (env->vfp.zcr_el[1] & 0xf) + 1;
@@ -9801,7 +9801,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         case TARGET_PR_SVE_GET_VL:
             ret = -TARGET_EINVAL;
             {
-                ARMCPU *cpu = arm_env_get_cpu(cpu_env);
+                ARMCPU *cpu = env_archcpu(cpu_env);
                 if (cpu_isar_feature(aa64_sve, cpu)) {
                     ret = ((cpu->env.vfp.zcr_el[1] & 0xf) + 1) * 16;
                 }
@@ -9810,7 +9810,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         case TARGET_PR_PAC_RESET_KEYS:
             {
                 CPUARMState *env = cpu_env;
-                ARMCPU *cpu = arm_env_get_cpu(env);
+                ARMCPU *cpu = env_archcpu(env);
 
                 if (arg3 || arg4 || arg5) {
                     return -TARGET_EINVAL;
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 53e807ab72..07af8d35da 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -257,8 +257,8 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
  */
 target_ulong do_arm_semihosting(CPUARMState *env)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
     target_ulong args;
     target_ulong arg0, arg1, arg2, arg3;
     char * s;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0ec8cd41f1..b8bd1e88a5 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -43,7 +43,7 @@ static inline void unset_feature(CPUARMState *env, int feature)
 #ifndef CONFIG_USER_ONLY
 static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     /* Number of cores is in [25:24]; otherwise we RAZ */
     return (cpu->core_count - 1) << 24;
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 796ef34b55..44e45a8037 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -1005,7 +1005,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
     }
 
     qemu_mutex_lock_iothread();
-    arm_call_pre_el_change_hook(arm_env_get_cpu(env));
+    arm_call_pre_el_change_hook(env_archcpu(env));
     qemu_mutex_unlock_iothread();
 
     if (!return_to_aa64) {
@@ -1047,7 +1047,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
     aarch64_sve_change_el(env, cur_el, new_el, return_to_aa64);
 
     qemu_mutex_lock_iothread();
-    arm_call_el_change_hook(arm_env_get_cpu(env));
+    arm_call_el_change_hook(env_archcpu(env));
     qemu_mutex_unlock_iothread();
 
     return;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f23989febf..188fb1950e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -227,7 +227,7 @@ static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static int arm_gdb_get_sysreg(CPUARMState *env, uint8_t *buf, int reg)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     const ARMCPRegInfo *ri;
     uint32_t key;
 
@@ -548,7 +548,7 @@ static CPAccessResult access_tpm(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     raw_write(env, ri, value);
     tlb_flush(CPU(cpu)); /* Flush TLB as domain not tracked in TLB */
@@ -556,7 +556,7 @@ static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 
 static void fcse_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     if (raw_read(env, ri) != value) {
         /* Unlike real hardware the qemu TLB uses virtual addresses,
@@ -570,7 +570,7 @@ static void fcse_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     if (raw_read(env, ri) != value && !arm_feature(env, ARM_FEATURE_PMSA)
         && !extended_addresses_enabled(env)) {
@@ -631,7 +631,7 @@ static void tlbiall_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           uint64_t value)
 {
     /* Invalidate all (TLBIALL) */
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     if (tlb_force_broadcast(env)) {
         tlbiall_is_write(env, NULL, value);
@@ -645,7 +645,7 @@ static void tlbimva_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           uint64_t value)
 {
     /* Invalidate single TLB entry by MVA and ASID (TLBIMVA) */
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     if (tlb_force_broadcast(env)) {
         tlbimva_is_write(env, NULL, value);
@@ -659,7 +659,7 @@ static void tlbiasid_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
     /* Invalidate by ASID (TLBIASID) */
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     if (tlb_force_broadcast(env)) {
         tlbiasid_is_write(env, NULL, value);
@@ -673,7 +673,7 @@ static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
     /* Invalidate single entry by MVA, all ASIDs (TLBIMVAA) */
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     if (tlb_force_broadcast(env)) {
         tlbimvaa_is_write(env, NULL, value);
@@ -1353,7 +1353,7 @@ static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
 
 static void pmu_update_irq(CPUARMState *env)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     qemu_set_irq(cpu->pmu_interrupt, (env->cp15.c9_pmcr & PMCRE) &&
             (env->cp15.c9_pminten & env->cp15.c9_pmovsr));
 }
@@ -1408,7 +1408,7 @@ static void pmccntr_op_finish(CPUARMState *env)
         if (overflow_in > 0) {
             int64_t overflow_at = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
                 overflow_in;
-            ARMCPU *cpu = arm_env_get_cpu(env);
+            ARMCPU *cpu = env_archcpu(env);
             timer_mod_anticipate_ns(cpu->pmu_timer, overflow_at);
         }
 #endif
@@ -1457,7 +1457,7 @@ static void pmevcntr_op_finish(CPUARMState *env, uint8_t counter)
         if (overflow_in > 0) {
             int64_t overflow_at = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
                 overflow_in;
-            ARMCPU *cpu = arm_env_get_cpu(env);
+            ARMCPU *cpu = env_archcpu(env);
             timer_mod_anticipate_ns(cpu->pmu_timer, overflow_at);
         }
 #endif
@@ -1865,7 +1865,7 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     /* Begin with base v8.0 state.  */
     uint32_t valid_mask = 0x3fff;
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     if (arm_el_is_aa64(env, 3)) {
         value |= SCR_FW | SCR_AW;   /* these two bits are RES1.  */
@@ -1902,7 +1902,7 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 
 static uint64_t ccsidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     /* Acquire the CSSELR index from the bank corresponding to the CCSIDR
      * bank
@@ -2452,7 +2452,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
 static void gt_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri,
                            int timeridx)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     timer_del(cpu->gt_timer[timeridx]);
 }
@@ -2473,7 +2473,7 @@ static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     trace_arm_gt_cval_write(timeridx, value);
     env->cp15.c14_timer[timeridx].cval = value;
-    gt_recalc_timer(arm_env_get_cpu(env), timeridx);
+    gt_recalc_timer(env_archcpu(env), timeridx);
 }
 
 static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2494,14 +2494,14 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
     trace_arm_gt_tval_write(timeridx, value);
     env->cp15.c14_timer[timeridx].cval = gt_get_countervalue(env) - offset +
                                          sextract64(value, 0, 32);
-    gt_recalc_timer(arm_env_get_cpu(env), timeridx);
+    gt_recalc_timer(env_archcpu(env), timeridx);
 }
 
 static void gt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
                          int timeridx,
                          uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     uint32_t oldval = env->cp15.c14_timer[timeridx].ctl;
 
     trace_arm_gt_ctl_write(timeridx, value);
@@ -2579,7 +2579,7 @@ static void gt_virt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
                               uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     trace_arm_gt_cntvoff_write(value);
     raw_write(env, ri, value);
@@ -3212,7 +3212,7 @@ static uint64_t pmsav7_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static void pmsav7_write(CPUARMState *env, const ARMCPRegInfo *ri,
                          uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     uint32_t *u32p = *(uint32_t **)raw_ptr(env, ri);
 
     if (!u32p) {
@@ -3227,7 +3227,7 @@ static void pmsav7_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void pmsav7_rgnr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                               uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     uint32_t nrgs = cpu->pmsav7_dregion;
 
     if (value >= nrgs) {
@@ -3355,7 +3355,7 @@ static void vmsa_ttbcr_raw_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void vmsa_ttbcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     TCR *tcr = raw_ptr(env, ri);
 
     if (arm_feature(env, ARM_FEATURE_LPAE)) {
@@ -3384,7 +3384,7 @@ static void vmsa_ttbcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     TCR *tcr = raw_ptr(env, ri);
 
     /* For AArch64 the A1 bit could result in a change of ASID, so TLB flush. */
@@ -3398,7 +3398,7 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
     if (cpreg_field_is_64bit(ri) &&
         extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
-        ARMCPU *cpu = arm_env_get_cpu(env);
+        ARMCPU *cpu = env_archcpu(env);
         tlb_flush(CPU(cpu));
     }
     raw_write(env, ri, value);
@@ -3407,7 +3407,7 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
 
     /* Accesses to VTTBR may change the VMID so we must flush the TLB.  */
@@ -3497,7 +3497,7 @@ static void omap_wfi_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
     /* Wait-for-interrupt (deprecated) */
-    cpu_interrupt(CPU(arm_env_get_cpu(env)), CPU_INTERRUPT_HALT);
+    cpu_interrupt(env_cpu(env), CPU_INTERRUPT_HALT);
 }
 
 static void omap_cachemaint_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3650,7 +3650,7 @@ static const ARMCPRegInfo strongarm_cp_reginfo[] = {
 
 static uint64_t midr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     unsigned int cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
 
@@ -3662,7 +3662,7 @@ static uint64_t midr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 
 static uint64_t mpidr_read_val(CPUARMState *env)
 {
-    ARMCPU *cpu = ARM_CPU(arm_env_get_cpu(env));
+    ARMCPU *cpu = env_archcpu(env);
     uint64_t mpidr = cpu->mp_affinity;
 
     if (arm_feature(env, ARM_FEATURE_V7MP)) {
@@ -3815,7 +3815,7 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * stage 2 translations, whereas most other scopes only invalidate
      * stage 1 translations.
      */
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
 
     if (arm_is_secure_below_el3(env)) {
@@ -3839,7 +3839,7 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
 
     tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E2);
@@ -3848,7 +3848,7 @@ static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
 
     tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E3);
@@ -3904,7 +3904,7 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * Currently handles both VAE2 and VALE2, since we don't support
      * flush-last-level-only.
      */
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
@@ -3918,7 +3918,7 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * Currently handles both VAE3 and VALE3, since we don't support
      * flush-last-level-only.
      */
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
@@ -3928,7 +3928,7 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
     bool sec = arm_is_secure_below_el3(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
@@ -3952,7 +3952,7 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * since we don't support flush-for-specific-ASID-only or
      * flush-last-level-only.
      */
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
@@ -4001,7 +4001,7 @@ static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * translation information.
      * This must NOP if EL2 isn't implemented or SCR_EL3.NS is zero.
      */
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
     uint64_t pageaddr;
 
@@ -4044,7 +4044,7 @@ static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static uint64_t aa64_dczid_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     int dzp_bit = 1 << 4;
 
     /* DZP indicates whether DC ZVA access is allowed */
@@ -4079,7 +4079,7 @@ static void spsel_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t val)
 static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     if (raw_read(env, ri) == value) {
         /* Skip the TLB flush if nothing actually changed; Linux likes
@@ -4571,7 +4571,7 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[] = {
 
 static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     uint64_t valid_mask = HCR_MASK;
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
@@ -5238,7 +5238,7 @@ int sve_exception_el(CPUARMState *env, int el)
  */
 uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     uint32_t zcr_len = cpu->sve_max_vq - 1;
 
     if (el <= 1) {
@@ -5406,7 +5406,7 @@ void hw_watchpoint_update_all(ARMCPU *cpu)
 static void dbgwvr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                          uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     int i = ri->crm;
 
     /* Bits [63:49] are hardwired to the value of bit [48]; that is, the
@@ -5422,7 +5422,7 @@ static void dbgwvr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void dbgwcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                          uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     int i = ri->crm;
 
     raw_write(env, ri, value);
@@ -5524,7 +5524,7 @@ void hw_breakpoint_update_all(ARMCPU *cpu)
 static void dbgbvr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                          uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     int i = ri->crm;
 
     raw_write(env, ri, value);
@@ -5534,7 +5534,7 @@ static void dbgbvr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void dbgbcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                          uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     int i = ri->crm;
 
     /* BAS[3] is a read-only copy of BAS[2], and BAS[1] a read-only
@@ -5630,7 +5630,7 @@ static void define_debug_regs(ARMCPU *cpu)
  */
 static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     uint64_t pfr1 = cpu->id_pfr1;
 
     if (env->gicv3state) {
@@ -5641,7 +5641,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 
 static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     uint64_t pfr0 = cpu->isar.id_aa64pfr0;
 
     if (env->gicv3state) {
@@ -7421,14 +7421,14 @@ uint32_t HELPER(rbit)(uint32_t x)
 /* These should probably raise undefined insn exceptions.  */
 void HELPER(v7m_msr)(CPUARMState *env, uint32_t reg, uint32_t val)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     cpu_abort(CPU(cpu), "v7m_msr %d\n", reg);
 }
 
 uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     cpu_abort(CPU(cpu), "v7m_mrs %d\n", reg);
     return 0;
@@ -7488,7 +7488,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
 
 static void switch_mode(CPUARMState *env, int mode)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     if (mode != ARM_CPU_MODE_USR) {
         cpu_abort(CPU(cpu), "Tried to switch out of user mode\n");
@@ -7831,7 +7831,7 @@ void HELPER(v7m_preserve_fp_state)(CPUARMState *env)
      * PreserveFPState() pseudocode.
      * We may throw an exception if the stacking fails.
      */
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     bool is_secure = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
     bool negpri = !(env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_HFRDY_MASK);
     bool is_priv = !(env->v7m.fpccr[is_secure] & R_V7M_FPCCR_USER_MASK);
@@ -10938,7 +10938,7 @@ static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
                              target_ulong *page_size,
                              ARMMMUFaultInfo *fi)
 {
-    CPUState *cs = CPU(arm_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int level = 1;
     uint32_t table;
     uint32_t desc;
@@ -11059,7 +11059,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
                              hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
                              target_ulong *page_size, ARMMMUFaultInfo *fi)
 {
-    CPUState *cs = CPU(arm_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int level = 1;
     uint32_t table;
     uint32_t desc;
@@ -11444,7 +11444,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
                                target_ulong *page_size_ptr,
                                ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
     /* Read an LPAE long-descriptor translation table. */
     ARMFaultType fault_type = ARMFault_Translation;
@@ -11802,7 +11802,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
                                  target_ulong *page_size,
                                  ARMMMUFaultInfo *fi)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     int n;
     bool is_user = regime_is_user(env, mmu_idx);
 
@@ -12006,7 +12006,7 @@ static void v8m_security_lookup(CPUARMState *env, uint32_t address,
      * pseudocode SecurityCheck() function.
      * We assume the caller has zero-initialized *sattrs.
      */
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     int r;
     bool idau_exempt = false, idau_ns = true, idau_nsc = true;
     int idau_region = IREGION_NOTVALID;
@@ -12119,7 +12119,7 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
      * We set is_subpage to true if the region hit doesn't cover the
      * entire TARGET_PAGE the address is within.
      */
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     bool is_user = regime_is_user(env, mmu_idx);
     uint32_t secure = regime_is_secure(env, mmu_idx);
     int n;
@@ -12899,7 +12899,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
             limit = is_psp ? env->v7m.psplim[false] : env->v7m.msplim[false];
 
             if (val < limit) {
-                CPUState *cs = CPU(arm_env_get_cpu(env));
+                CPUState *cs = env_cpu(env);
 
                 cpu_restore_state(cs, GETPC(), true);
                 raise_exception(env, EXCP_STKOF, 0, 1);
@@ -13180,7 +13180,7 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
      * alignment faults or any memory attribute handling).
      */
 
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     uint64_t blocklen = 4 << cpu->dcz_blocksize;
     uint64_t vaddr = vaddr_in & ~(blocklen - 1);
 
@@ -13680,7 +13680,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     uint32_t flags = 0;
 
     if (is_a64(env)) {
-        ARMCPU *cpu = arm_env_get_cpu(env);
+        ARMCPU *cpu = env_archcpu(env);
         uint64_t sctlr;
 
         *pc = env->pc;
@@ -13853,7 +13853,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
     uint64_t pmask;
 
     assert(vq >= 1 && vq <= ARM_MAX_VQ);
-    assert(vq <= arm_env_get_cpu(env)->sve_max_vq);
+    assert(vq <= env_archcpu(env)->sve_max_vq);
 
     /* Zap the high bits of the zregs.  */
     for (i = 0; i < 32; i++) {
@@ -13879,7 +13879,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
                            int new_el, bool el0_a64)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     int old_len, new_len;
     bool old_a64, new_a64;
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 8ee15a4bd4..4db254876d 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -31,7 +31,7 @@
 static CPUState *do_raise_exception(CPUARMState *env, uint32_t excp,
                                     uint32_t syndrome, uint32_t target_el)
 {
-    CPUState *cs = CPU(arm_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     if (target_el == 1 && (arm_hcr_el2_eff(env) & HCR_TGE)) {
         /*
@@ -224,7 +224,7 @@ void HELPER(v8m_stackcheck)(CPUARMState *env, uint32_t newvalue)
      * raising an exception if the limit is breached.
      */
     if (newvalue < v7m_sp_limit(env)) {
-        CPUState *cs = CPU(arm_env_get_cpu(env));
+        CPUState *cs = env_cpu(env);
 
         /*
          * Stack limit exceptions are a rare case, so rather than syncing
@@ -427,7 +427,7 @@ static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
 
 void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
 {
-    CPUState *cs = CPU(arm_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int target_el = check_wfx_trap(env, false);
 
     if (cpu_has_work(cs)) {
@@ -462,8 +462,7 @@ void HELPER(wfe)(CPUARMState *env)
 
 void HELPER(yield)(CPUARMState *env)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
     /* This is a non-trappable hint instruction that generally indicates
      * that the guest is currently busy-looping. Yield control back to the
@@ -481,7 +480,7 @@ void HELPER(yield)(CPUARMState *env)
  */
 void HELPER(exception_internal)(CPUARMState *env, uint32_t excp)
 {
-    CPUState *cs = CPU(arm_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     assert(excp_is_internal(excp));
     cs->exception_index = excp;
@@ -524,7 +523,7 @@ void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
 void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
 {
     qemu_mutex_lock_iothread();
-    arm_call_pre_el_change_hook(arm_env_get_cpu(env));
+    arm_call_pre_el_change_hook(env_archcpu(env));
     qemu_mutex_unlock_iothread();
 
     cpsr_write(env, val, CPSR_ERET_MASK, CPSRWriteExceptionReturn);
@@ -537,7 +536,7 @@ void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
     env->regs[15] &= (env->thumb ? ~1 : ~3);
 
     qemu_mutex_lock_iothread();
-    arm_call_el_change_hook(arm_env_get_cpu(env));
+    arm_call_el_change_hook(env_archcpu(env));
     qemu_mutex_unlock_iothread();
 }
 
@@ -842,7 +841,7 @@ uint64_t HELPER(get_cp_reg64)(CPUARMState *env, void *rip)
 
 void HELPER(pre_hvc)(CPUARMState *env)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     int cur_el = arm_current_el(env);
     /* FIXME: Use actual secure state.  */
     bool secure = false;
@@ -882,7 +881,7 @@ void HELPER(pre_hvc)(CPUARMState *env)
 
 void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     int cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
     bool smd_flag = env->cp15.scr_el3 & SCR_SMD;
@@ -1156,7 +1155,7 @@ static bool check_breakpoints(ARMCPU *cpu)
 
 void HELPER(check_breakpoints)(CPUARMState *env)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
 
     if (check_breakpoints(cpu)) {
         HELPER(exception_internal(env, EXCP_DEBUG));
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f5440e57dd..8a3bf204d3 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14289,7 +14289,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUARMState *env = cpu->env_ptr;
-    ARMCPU *arm_cpu = arm_env_get_cpu(env);
+    ARMCPU *arm_cpu = env_archcpu(env);
     uint32_t tb_flags = dc->base.tb->flags;
     int bound, core_mmu_idx;
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d240c1b714..d25e19ef11 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -13408,7 +13408,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUARMState *env = cs->env_ptr;
-    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     uint32_t tb_flags = dc->base.tb->flags;
     uint32_t condexec, core_mmu_idx;
 
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 7a46d99148..d3e83b627b 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -101,7 +101,7 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
     uint32_t changed = env->vfp.xregs[ARM_VFP_FPSCR];
 
     /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
-    if (!cpu_isar_feature(aa64_fp16, arm_env_get_cpu(env))) {
+    if (!cpu_isar_feature(aa64_fp16, env_archcpu(env))) {
         val &= ~FPCR_FZ16;
     }
 
-- 
2.17.1


