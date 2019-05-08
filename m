Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B752CC004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2E220675
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StJEqMV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2E220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56586 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAKk-0002Ij-Ij
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:21:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA73-0007TZ-PS
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA70-0006hp-R6
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:09 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA70-0006Vt-G6
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:06 -0400
Received: by mail-pl1-x642.google.com with SMTP id p15so1773519pll.4
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=FiCZqSS6wKeRmYap2qgvPaqBc3zhhAWRiK2tapmwRp0=;
	b=StJEqMV/ONt31ki94vL/nc3jD5/uHic6KdHehlbERjIriJH3sCWbw4F+A2N015lrbv
	8orKTZ1Hs+C7TLXzcThbrgAZflUne0k/IWbWdPLMc0oaglk/VyHxizHVECeq2u7JPDEN
	rWHU/HJC9PsPzPWArQZG5f56q6cVwfhx86a4XFgdzmmBiqMUvHkV7GBWiu7bZ+oT6LV/
	HQ+o82R8fvxaTyrnUnFX6C7fRjGdX/UzL/sBtwOyRKLctQpYK28h99UFalZCz+D5hTxE
	9pJcs35bIo0LOdtRalwqHRNw5I6qjCnvlURn130uBYZcAlOn7LVqGrxIw4OXBHcoiXll
	NWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=FiCZqSS6wKeRmYap2qgvPaqBc3zhhAWRiK2tapmwRp0=;
	b=LUkGIZLE3XNLdvz2Tajq4YXVTsk38yo8PyeK2G2My1xbtdx7ItHc04KKAR6GkR4cTd
	KLIE8xzHjjvTfMLzyyS1HzRboEaRetCp0sfqePPKeyPMFiNw+lzr6LSC620W/oLojUKl
	G+OJkIw0YeIlX/mdhEQojdvXxKPbtrLnH6o+PubnSwuRmHvm3x22/kjpIKM7n41acWZS
	U8rmCdwXxvFxI4rtoOLG4p1wFM/u8q2zPNPo80XJHWZaRunhnDl81RiYFT/cr55ueD8t
	aLtNmKjxu2o+wCgnv8LMlzNrXQBUDxa1XBK++b8JSimAZBHfJFOF0WxeJnLGCjtlh34X
	7knA==
X-Gm-Message-State: APjAAAXzIAsu6abkssMYn+RZc8j+F+MBtjzieXPEFm5VEGlNh+Xb1dMH
	DaNSvviR797irNdwGJyyrdfwXoM0LPE=
X-Google-Smtp-Source: APXvYqxrnpxzsBFUmcjl3IkjiXytq1bIO2CexHKzWE4R78geA98B34QKlS4kl15exoVupKceai1UFw==
X-Received: by 2002:a17:902:4283:: with SMTP id
	h3mr42536564pld.176.1557274021832; 
	Tue, 07 May 2019 17:07:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.00 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:16 -0700
Message-Id: <20190508000641.19090-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v3 14/39] target/i386: Use env_cpu, env_archcpu
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

Combined uses of CPU(x86_env_get_cpu()) were failures to use
the more proper, ENV_GET_CPU macro, now replaced by env_cpu.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h          |  5 -----
 bsd-user/main.c            |  3 +--
 hw/i386/kvmvapic.c         |  4 ++--
 hw/i386/pc.c               |  2 +-
 linux-user/i386/cpu_loop.c |  2 +-
 linux-user/i386/signal.c   |  2 +-
 linux-user/vm86.c          | 18 +++++++++---------
 target/i386/bpt_helper.c   |  4 ++--
 target/i386/cpu.c          |  4 ++--
 target/i386/excp_helper.c  |  2 +-
 target/i386/fpu_helper.c   |  2 +-
 target/i386/helper.c       | 16 ++++++----------
 target/i386/misc_helper.c  | 24 +++++++++++-------------
 target/i386/seg_helper.c   | 14 +++++++-------
 target/i386/smm_helper.c   |  4 ++--
 target/i386/svm_helper.c   | 22 +++++++++++-----------
 16 files changed, 58 insertions(+), 70 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2546ffa4d4..e7f94437b1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1479,11 +1479,6 @@ struct X86CPU {
     int32_t hv_max_vps;
 };
 
-static inline X86CPU *x86_env_get_cpu(CPUX86State *env)
-{
-    return container_of(env, X86CPU, env);
-}
-
 #define ENV_OFFSET offsetof(X86CPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 6192e9d91e..bfdcae4269 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -140,8 +140,7 @@ static void set_idt(int n, unsigned int dpl)
 
 void cpu_loop(CPUX86State *env)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(cpu);
     int trapnr;
     abi_ulong pc;
     //target_siginfo_t info;
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 70f6f26a94..fe5b12ef6e 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -152,7 +152,7 @@ static void update_guest_rom_state(VAPICROMState *s)
 
 static int find_real_tpr_addr(VAPICROMState *s, CPUX86State *env)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     hwaddr paddr;
     target_ulong addr;
 
@@ -279,7 +279,7 @@ instruction_ok:
 
 static int update_rom_mapping(VAPICROMState *s, CPUX86State *env, target_ulong ip)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     hwaddr paddr;
     uint32_t rom_state_vaddr;
     uint32_t pos, patch, offset;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d98b737b8f..6a3a0678fc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -408,7 +408,7 @@ uint64_t cpu_get_tsc(CPUX86State *env)
 /* IRQ handling */
 int cpu_get_pic_interrupt(CPUX86State *env)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
+    X86CPU *cpu = env_archcpu(env);
     int intno;
 
     if (!kvm_irqchip_in_kernel()) {
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 51cfa006c9..71da24384f 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -82,7 +82,7 @@ static void set_idt(int n, unsigned int dpl)
 
 void cpu_loop(CPUX86State *env)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr;
     abi_ulong pc;
     abi_ulong ret;
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index fecb4c99c3..97a39204cc 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -198,7 +198,7 @@ static void setup_sigcontext(struct target_sigcontext *sc,
         struct target_fpstate *fpstate, CPUX86State *env, abi_ulong mask,
         abi_ulong fpstate_addr)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 #ifndef TARGET_X86_64
     uint16_t magic;
 
diff --git a/linux-user/vm86.c b/linux-user/vm86.c
index 9c393df424..2fa7a89edc 100644
--- a/linux-user/vm86.c
+++ b/linux-user/vm86.c
@@ -72,7 +72,7 @@ static inline unsigned int vm_getl(CPUX86State *env,
 
 void save_v86_state(CPUX86State *env)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     TaskState *ts = cs->opaque;
     struct target_vm86plus_struct * target_v86;
 
@@ -132,7 +132,7 @@ static inline void return_to_32bit(CPUX86State *env, int retval)
 
 static inline int set_IF(CPUX86State *env)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     TaskState *ts = cs->opaque;
 
     ts->v86flags |= VIF_MASK;
@@ -145,7 +145,7 @@ static inline int set_IF(CPUX86State *env)
 
 static inline void clear_IF(CPUX86State *env)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     TaskState *ts = cs->opaque;
 
     ts->v86flags &= ~VIF_MASK;
@@ -163,7 +163,7 @@ static inline void clear_AC(CPUX86State *env)
 
 static inline int set_vflags_long(unsigned long eflags, CPUX86State *env)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     TaskState *ts = cs->opaque;
 
     set_flags(ts->v86flags, eflags, ts->v86mask);
@@ -177,7 +177,7 @@ static inline int set_vflags_long(unsigned long eflags, CPUX86State *env)
 
 static inline int set_vflags_short(unsigned short flags, CPUX86State *env)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     TaskState *ts = cs->opaque;
 
     set_flags(ts->v86flags, flags, ts->v86mask & 0xffff);
@@ -191,7 +191,7 @@ static inline int set_vflags_short(unsigned short flags, CPUX86State *env)
 
 static inline unsigned int get_vflags(CPUX86State *env)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     TaskState *ts = cs->opaque;
     unsigned int flags;
 
@@ -208,7 +208,7 @@ static inline unsigned int get_vflags(CPUX86State *env)
    support TSS interrupt revectoring, so this code is always executed) */
 static void do_int(CPUX86State *env, int intno)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     TaskState *ts = cs->opaque;
     uint32_t int_addr, segoffs, ssp;
     unsigned int sp;
@@ -267,7 +267,7 @@ void handle_vm86_trap(CPUX86State *env, int trapno)
 
 void handle_vm86_fault(CPUX86State *env)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     TaskState *ts = cs->opaque;
     uint32_t csp, ssp;
     unsigned int ip, sp, newflags, newip, newcs, opcode, intno;
@@ -392,7 +392,7 @@ void handle_vm86_fault(CPUX86State *env)
 
 int do_vm86(CPUX86State *env, long subfunction, abi_ulong vm86_addr)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     TaskState *ts = cs->opaque;
     struct target_vm86plus_struct * target_v86;
     int ret;
diff --git a/target/i386/bpt_helper.c b/target/i386/bpt_helper.c
index b3efdc77ec..c3a8ea73c9 100644
--- a/target/i386/bpt_helper.c
+++ b/target/i386/bpt_helper.c
@@ -53,7 +53,7 @@ static inline int hw_breakpoint_len(unsigned long dr7, int index)
 
 static int hw_breakpoint_insert(CPUX86State *env, int index)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     target_ulong dr7 = env->dr[7];
     target_ulong drN = env->dr[index];
     int err = 0;
@@ -97,7 +97,7 @@ static int hw_breakpoint_insert(CPUX86State *env, int index)
 
 static void hw_breakpoint_remove(CPUX86State *env, int index)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     switch (hw_breakpoint_type(env->dr[7], index)) {
     case DR7_TYPE_BP_INST:
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 722c5514d4..5b84629f91 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4221,8 +4221,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                    uint32_t *eax, uint32_t *ebx,
                    uint32_t *ecx, uint32_t *edx)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    X86CPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
     uint32_t pkg_offset;
     uint32_t limit;
     uint32_t signature[3];
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index 49231f6b69..371792ce8b 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -90,7 +90,7 @@ static void QEMU_NORETURN raise_interrupt2(CPUX86State *env, int intno,
                                            int next_eip_addend,
                                            uintptr_t retaddr)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     if (!is_int) {
         cpu_svm_check_intercept_param(env, SVM_EXIT_EXCP_BASE + intno,
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index ea5a0c4861..005f1f68f8 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -1477,7 +1477,7 @@ void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
             env->pkru = 0;
         }
         if (env->pkru != old_pkru) {
-            CPUState *cs = CPU(x86_env_get_cpu(env));
+            CPUState *cs = env_cpu(env);
             tlb_flush(cs);
         }
     }
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 96336055f3..ff3a60c7cf 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -622,7 +622,7 @@ void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
 
 void cpu_x86_update_cr0(CPUX86State *env, uint32_t new_cr0)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
+    X86CPU *cpu = env_archcpu(env);
     int pe_state;
 
     qemu_log_mask(CPU_LOG_MMU, "CR0 update: CR0=0x%08x\n", new_cr0);
@@ -664,19 +664,16 @@ void cpu_x86_update_cr0(CPUX86State *env, uint32_t new_cr0)
    the PDPT */
 void cpu_x86_update_cr3(CPUX86State *env, target_ulong new_cr3)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
-
     env->cr[3] = new_cr3;
     if (env->cr[0] & CR0_PG_MASK) {
         qemu_log_mask(CPU_LOG_MMU,
                         "CR3 update: CR3=" TARGET_FMT_lx "\n", new_cr3);
-        tlb_flush(CPU(cpu));
+        tlb_flush(env_cpu(env));
     }
 }
 
 void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
     uint32_t hflags;
 
 #if defined(DEBUG_MMU)
@@ -685,7 +682,7 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
     if ((new_cr4 ^ env->cr[4]) &
         (CR4_PGE_MASK | CR4_PAE_MASK | CR4_PSE_MASK |
          CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_LA57_MASK)) {
-        tlb_flush(CPU(cpu));
+        tlb_flush(env_cpu(env));
     }
 
     /* Clear bits we're going to recompute.  */
@@ -977,8 +974,8 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
 
 void cpu_report_tpr_access(CPUX86State *env, TPRAccess access)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    X86CPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
 
     if (kvm_enabled() || whpx_enabled()) {
         env->tpr_access_type = access;
@@ -996,8 +993,7 @@ int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
                             target_ulong *base, unsigned int *limit,
                             unsigned int *flags)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
     SegmentCache *dt;
     target_ulong ptr;
     uint32_t e1, e2;
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index 78f2020ef2..3eff6885f8 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -133,7 +133,7 @@ target_ulong helper_read_crN(CPUX86State *env, int reg)
         break;
     case 8:
         if (!(env->hflags2 & HF2_VINTR_MASK)) {
-            val = cpu_get_apic_tpr(x86_env_get_cpu(env)->apic_state);
+            val = cpu_get_apic_tpr(env_archcpu(env)->apic_state);
         } else {
             val = env->v_tpr;
         }
@@ -158,7 +158,7 @@ void helper_write_crN(CPUX86State *env, int reg, target_ulong t0)
     case 8:
         if (!(env->hflags2 & HF2_VINTR_MASK)) {
             qemu_mutex_lock_iothread();
-            cpu_set_apic_tpr(x86_env_get_cpu(env)->apic_state, t0);
+            cpu_set_apic_tpr(env_archcpu(env)->apic_state, t0);
             qemu_mutex_unlock_iothread();
         }
         env->v_tpr = t0 & 0x0f;
@@ -180,7 +180,7 @@ void helper_lmsw(CPUX86State *env, target_ulong t0)
 
 void helper_invlpg(CPUX86State *env, target_ulong addr)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
+    X86CPU *cpu = env_archcpu(env);
 
     cpu_svm_check_intercept_param(env, SVM_EXIT_INVLPG, 0, GETPC());
     tlb_flush_page(CPU(cpu), addr);
@@ -247,7 +247,7 @@ void helper_wrmsr(CPUX86State *env)
         env->sysenter_eip = val;
         break;
     case MSR_IA32_APICBASE:
-        cpu_set_apic_base(x86_env_get_cpu(env)->apic_state, val);
+        cpu_set_apic_base(env_archcpu(env)->apic_state, val);
         break;
     case MSR_EFER:
         {
@@ -404,7 +404,7 @@ void helper_rdmsr(CPUX86State *env)
         val = env->sysenter_eip;
         break;
     case MSR_IA32_APICBASE:
-        val = cpu_get_apic_base(x86_env_get_cpu(env)->apic_state);
+        val = cpu_get_apic_base(env_archcpu(env)->apic_state);
         break;
     case MSR_EFER:
         val = env->efer;
@@ -561,7 +561,7 @@ static void do_hlt(X86CPU *cpu)
 
 void helper_hlt(CPUX86State *env, int next_eip_addend)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
+    X86CPU *cpu = env_archcpu(env);
 
     cpu_svm_check_intercept_param(env, SVM_EXIT_HLT, 0, GETPC());
     env->eip += next_eip_addend;
@@ -580,8 +580,8 @@ void helper_monitor(CPUX86State *env, target_ulong ptr)
 
 void helper_mwait(CPUX86State *env, int next_eip_addend)
 {
-    CPUState *cs;
-    X86CPU *cpu;
+    CPUState *cs = env_cpu(env);
+    X86CPU *cpu = env_archcpu(env);
 
     if ((uint32_t)env->regs[R_ECX] != 0) {
         raise_exception_ra(env, EXCP0D_GPF, GETPC());
@@ -589,8 +589,6 @@ void helper_mwait(CPUX86State *env, int next_eip_addend)
     cpu_svm_check_intercept_param(env, SVM_EXIT_MWAIT, 0, GETPC());
     env->eip += next_eip_addend;
 
-    cpu = x86_env_get_cpu(env);
-    cs = CPU(cpu);
     /* XXX: not complete but not completely erroneous */
     if (cs->cpu_index != 0 || CPU_NEXT(cs) != NULL) {
         do_pause(cpu);
@@ -601,7 +599,7 @@ void helper_mwait(CPUX86State *env, int next_eip_addend)
 
 void helper_pause(CPUX86State *env, int next_eip_addend)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
+    X86CPU *cpu = env_archcpu(env);
 
     cpu_svm_check_intercept_param(env, SVM_EXIT_PAUSE, 0, GETPC());
     env->eip += next_eip_addend;
@@ -611,7 +609,7 @@ void helper_pause(CPUX86State *env, int next_eip_addend)
 
 void helper_debug(CPUX86State *env)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = EXCP_DEBUG;
     cpu_loop_exit(cs);
@@ -631,7 +629,7 @@ uint64_t helper_rdpkru(CPUX86State *env, uint32_t ecx)
 
 void helper_wrpkru(CPUX86State *env, uint32_t ecx, uint64_t val)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     if ((env->cr[4] & CR4_PKE_MASK) == 0) {
         raise_exception_err_ra(env, EXCP06_ILLOP, 0, GETPC());
diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 63e265cb38..87a627f9dc 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -137,7 +137,7 @@ static inline void get_ss_esp_from_tss(CPUX86State *env, uint32_t *ss_ptr,
                                        uint32_t *esp_ptr, int dpl,
                                        uintptr_t retaddr)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
+    X86CPU *cpu = env_archcpu(env);
     int type, index, shift;
 
 #if 0
@@ -830,7 +830,7 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
 
 static inline target_ulong get_rsp_from_tss(CPUX86State *env, int level)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
+    X86CPU *cpu = env_archcpu(env);
     int index;
 
 #if 0
@@ -972,7 +972,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
 #if defined(CONFIG_USER_ONLY)
 void helper_syscall(CPUX86State *env, int next_eip_addend)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = EXCP_SYSCALL;
     env->exception_next_eip = env->eip + next_eip_addend;
@@ -1172,7 +1172,7 @@ static void do_interrupt_user(CPUX86State *env, int intno, int is_int,
 static void handle_even_inj(CPUX86State *env, int intno, int is_int,
                             int error_code, int is_hw, int rm)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint32_t event_inj = x86_ldl_phys(cs, env->vm_vmcb + offsetof(struct vmcb,
                                                           control.event_inj));
 
@@ -1312,7 +1312,7 @@ void x86_cpu_do_interrupt(CPUState *cs)
 
 void do_interrupt_x86_hardirq(CPUX86State *env, int intno, int is_hw)
 {
-    do_interrupt_all(x86_env_get_cpu(env), intno, 0, 0, 0, is_hw);
+    do_interrupt_all(env_archcpu(env), intno, 0, 0, 0, is_hw);
 }
 
 bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
@@ -1763,7 +1763,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
     target_ulong ssp, old_ssp, offset, sp;
 
     LOG_PCALL("lcall %04x:" TARGET_FMT_lx " s=%d\n", new_cs, new_eip, shift);
-    LOG_PCALL_STATE(CPU(x86_env_get_cpu(env)));
+    LOG_PCALL_STATE(env_cpu(env));
     if ((new_cs & 0xfffc) == 0) {
         raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
     }
@@ -2167,7 +2167,7 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
     }
     LOG_PCALL("lret new %04x:" TARGET_FMT_lx " s=%d addend=0x%x\n",
               new_cs, new_eip, shift, addend);
-    LOG_PCALL_STATE(CPU(x86_env_get_cpu(env)));
+    LOG_PCALL_STATE(env_cpu(env));
     if ((new_cs & 0xfffc) == 0) {
         raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, retaddr);
     }
diff --git a/target/i386/smm_helper.c b/target/i386/smm_helper.c
index c1c34a75db..eb5aa6eb3d 100644
--- a/target/i386/smm_helper.c
+++ b/target/i386/smm_helper.c
@@ -204,8 +204,8 @@ void do_smm_enter(X86CPU *cpu)
 
 void helper_rsm(CPUX86State *env)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    X86CPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
     target_ulong sm_state;
     int i, offset;
     uint32_t val;
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 9fd22a883b..7b8105a1c3 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -84,7 +84,7 @@ void helper_svm_check_io(CPUX86State *env, uint32_t port, uint32_t param,
 static inline void svm_save_seg(CPUX86State *env, hwaddr addr,
                                 const SegmentCache *sc)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     x86_stw_phys(cs, addr + offsetof(struct vmcb_seg, selector),
              sc->selector);
@@ -99,7 +99,7 @@ static inline void svm_save_seg(CPUX86State *env, hwaddr addr,
 static inline void svm_load_seg(CPUX86State *env, hwaddr addr,
                                 SegmentCache *sc)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     unsigned int flags;
 
     sc->selector = x86_lduw_phys(cs,
@@ -122,7 +122,7 @@ static inline void svm_load_seg_cache(CPUX86State *env, hwaddr addr,
 
 void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     target_ulong addr;
     uint64_t nested_ctl;
     uint32_t event_inj;
@@ -314,7 +314,7 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
     env->hflags2 |= HF2_GIF_MASK;
 
     if (int_ctl & V_IRQ_MASK) {
-        CPUState *cs = CPU(x86_env_get_cpu(env));
+        CPUState *cs = env_cpu(env);
 
         cs->interrupt_request |= CPU_INTERRUPT_VIRQ;
     }
@@ -379,7 +379,7 @@ void helper_vmmcall(CPUX86State *env)
 
 void helper_vmload(CPUX86State *env, int aflag)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     target_ulong addr;
 
     cpu_svm_check_intercept_param(env, SVM_EXIT_VMLOAD, 0, GETPC());
@@ -419,7 +419,7 @@ void helper_vmload(CPUX86State *env, int aflag)
 
 void helper_vmsave(CPUX86State *env, int aflag)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     target_ulong addr;
 
     cpu_svm_check_intercept_param(env, SVM_EXIT_VMSAVE, 0, GETPC());
@@ -482,7 +482,7 @@ void helper_skinit(CPUX86State *env)
 
 void helper_invlpga(CPUX86State *env, int aflag)
 {
-    X86CPU *cpu = x86_env_get_cpu(env);
+    X86CPU *cpu = env_archcpu(env);
     target_ulong addr;
 
     cpu_svm_check_intercept_param(env, SVM_EXIT_INVLPGA, 0, GETPC());
@@ -501,7 +501,7 @@ void helper_invlpga(CPUX86State *env, int aflag)
 void cpu_svm_check_intercept_param(CPUX86State *env, uint32_t type,
                                    uint64_t param, uintptr_t retaddr)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     if (likely(!(env->hflags & HF_GUEST_MASK))) {
         return;
@@ -583,7 +583,7 @@ void helper_svm_check_intercept_param(CPUX86State *env, uint32_t type,
 void helper_svm_check_io(CPUX86State *env, uint32_t port, uint32_t param,
                          uint32_t next_eip_addend)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     if (env->intercept & (1ULL << (SVM_EXIT_IOIO - SVM_EXIT_INTR))) {
         /* FIXME: this should be read in at vmrun (faster this way?) */
@@ -604,7 +604,7 @@ void helper_svm_check_io(CPUX86State *env, uint32_t port, uint32_t param,
 void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
                 uintptr_t retaddr)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cpu_restore_state(cs, retaddr, true);
 
@@ -625,7 +625,7 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
 
 void do_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1)
 {
-    CPUState *cs = CPU(x86_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint32_t int_ctl;
 
     if (env->hflags & HF_INHIBIT_IRQ_MASK) {
-- 
2.17.1


