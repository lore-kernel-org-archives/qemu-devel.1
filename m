Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9403FC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698F620753
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698F620753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErSm-0006w2-Fa
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jErRq-0005DH-Mn
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jErRp-000488-8V
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:42 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:59829)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jErRo-00044i-VO
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:41 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mpkwn-1jdy0F05yX-00q9MK; Thu, 19 Mar 2020 10:26:34 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v3 03/16] linux-user/i386: Emulate x86_64 vsyscalls
Date: Thu, 19 Mar 2020 10:26:14 +0100
Message-Id: <20200319092627.51487-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319092627.51487-1-laurent@vivier.eu>
References: <20200319092627.51487-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nZQ3FBqNzQhrqOP5mWCt76B83fNEBxa51x7BfenTNo8DnmjVtP3
 b0VqPquMvR2xeck7/JTVcMELFL25GO/+HFvkb95+cjNjHKMBuOD+760U/AodcAlqAMZnS56
 VEBueio5q2kGiHeuWuXobzaMMWu+3HRyBIc/bddEZ8xL90/jmXKGSXYZE5+tFjvaO1zOY14
 1JnwCbhRsWNc/WBrbMXCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GlgdFC3RNPE=:H4zz2fdGY1sZOV9p3v9HiU
 c3zyAwE5Ths8NQ/01/StHVdJmi7FZYFls8HjHGLKHNILx/NkzlxlwiNGjzRjCtWY9DEpGmsUE
 JV91X9S3J6QhEKnHbDqFsj6RoyY4eeIOufeUfW7cHBwUi6lNOPo7ysdN9M7R/69LZZ1HNi1Ps
 tx54Oh5sze/ASaIPElVLs3qsAvkrpRNsFSZwJW5suY6p7L0bitwCO6uKqYM/X/s3YoM0HyrRK
 fpOnYVhTpY0f3WwFPp7/P3gHM5dwTok8QUECQUTcNGy3ukxAqtIx3lw4YEsjfvnTkjbZOmuF7
 eREaxHMLLRGbR9MTDu2BR8aZTsituxAB9+EraxRntFF7U5Eij+s2Ir/bhWm++usQWk6gkUfLR
 HgN35wS/iMk8IQkMh7qk8ylH668uOXMrvUU/zzGXxZrnHrtjaz7aqBv1EmO9jQwEO9t/Rsmz8
 e2ylCs/501bdNs25Hnoq7ZG6Y/27qvdrzF68nhBquKNAUdqXQNJcFBkH3f+OybiUkgqDR8Gjr
 u37fJOCgOuL+YBtAeL3bS3cj7nz83t6dBUXylGYiAdw50CF+lwXIK0w8jFQ76l7AGaEzxpkSB
 M/Aq0nkcpnB9VZ8gS7YNdN3HHxh1x5DXhtLPxDsERubpscFOpPdcfGmqfi+7k2pB5QZbNv/Jj
 QtQ4Ptc1AdXeGfkybEvY6wxPhTWA58pfqy+/ru9OCceQuRznhdCCyhafuvJp4avdbcEsWpFNz
 0+aP2JkFN53y84Wv37lDQq2QWUCshoW5nFriyZY6RLBna1IDaDD0u6nIop1IF9InP1gGBiiE2
 hW3TTdkLdEatrhnna3c8Oa8AF3G9/jqFw5w7egBITKik+mBC1ASZRFtYF3ltyKiRkNJ8gTS
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Notice the magic page during translate, much like we already
do for the arm32 commpage.  At runtime, raise an exception to
return cpu_loop for emulation.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200213032223.14643-4-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/i386/cpu_loop.c | 108 +++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h          |   7 +++
 target/i386/translate.c    |  14 ++++-
 3 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index e217cca5ee1e..70cde417e605 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -92,6 +92,109 @@ static void gen_signal(CPUX86State *env, int sig, int code, abi_ptr addr)
     queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
 }
 
+#ifdef TARGET_X86_64
+static bool write_ok_or_segv(CPUX86State *env, abi_ptr addr, size_t len)
+{
+    /*
+     * For all the vsyscalls, NULL means "don't write anything" not
+     * "write it at address 0".
+     */
+    if (addr == 0 || access_ok(VERIFY_WRITE, addr, len)) {
+        return true;
+    }
+
+    env->error_code = PG_ERROR_W_MASK | PG_ERROR_U_MASK;
+    gen_signal(env, TARGET_SIGSEGV, TARGET_SEGV_MAPERR, addr);
+    return false;
+}
+
+/*
+ * Since v3.1, the kernel traps and emulates the vsyscall page.
+ * Entry points other than the official generate SIGSEGV.
+ */
+static void emulate_vsyscall(CPUX86State *env)
+{
+    int syscall;
+    abi_ulong ret;
+    uint64_t caller;
+
+    /*
+     * Validate the entry point.  We have already validated the page
+     * during translation to get here; now verify the offset.
+     */
+    switch (env->eip & ~TARGET_PAGE_MASK) {
+    case 0x000:
+        syscall = TARGET_NR_gettimeofday;
+        break;
+    case 0x400:
+        syscall = TARGET_NR_time;
+        break;
+    case 0x800:
+        syscall = TARGET_NR_getcpu;
+        break;
+    default:
+        goto sigsegv;
+    }
+
+    /*
+     * Validate the return address.
+     * Note that the kernel treats this the same as an invalid entry point.
+     */
+    if (get_user_u64(caller, env->regs[R_ESP])) {
+        goto sigsegv;
+    }
+
+    /*
+     * Validate the the pointer arguments.
+     */
+    switch (syscall) {
+    case TARGET_NR_gettimeofday:
+        if (!write_ok_or_segv(env, env->regs[R_EDI],
+                              sizeof(struct target_timeval)) ||
+            !write_ok_or_segv(env, env->regs[R_ESI],
+                              sizeof(struct target_timezone))) {
+            return;
+        }
+        break;
+    case TARGET_NR_time:
+        if (!write_ok_or_segv(env, env->regs[R_EDI], sizeof(abi_long))) {
+            return;
+        }
+        break;
+    case TARGET_NR_getcpu:
+        if (!write_ok_or_segv(env, env->regs[R_EDI], sizeof(uint32_t)) ||
+            !write_ok_or_segv(env, env->regs[R_ESI], sizeof(uint32_t))) {
+            return;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /*
+     * Perform the syscall.  None of the vsyscalls should need restarting.
+     */
+    ret = do_syscall(env, syscall, env->regs[R_EDI], env->regs[R_ESI],
+                     env->regs[R_EDX], env->regs[10], env->regs[8],
+                     env->regs[9], 0, 0);
+    g_assert(ret != -TARGET_ERESTARTSYS);
+    g_assert(ret != -TARGET_QEMU_ESIGRETURN);
+    if (ret == -TARGET_EFAULT) {
+        goto sigsegv;
+    }
+    env->regs[R_EAX] = ret;
+
+    /* Emulate a ret instruction to leave the vsyscall page.  */
+    env->eip = caller;
+    env->regs[R_ESP] += 8;
+    return;
+
+ sigsegv:
+    /* Like force_sig(SIGSEGV).  */
+    gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
+}
+#endif
+
 void cpu_loop(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
@@ -141,6 +244,11 @@ void cpu_loop(CPUX86State *env)
                 env->regs[R_EAX] = ret;
             }
             break;
+#endif
+#ifdef TARGET_X86_64
+        case EXCP_VSYSCALL:
+            emulate_vsyscall(env);
+            break;
 #endif
         case EXCP0B_NOSEG:
         case EXCP0C_STACK:
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 08b4422f36bd..39be555db3da 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1001,6 +1001,7 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 
 #define EXCP_VMEXIT     0x100 /* only for system emulation */
 #define EXCP_SYSCALL    0x101 /* only for user emulation */
+#define EXCP_VSYSCALL   0x102 /* only for user emulation */
 
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
@@ -2215,4 +2216,10 @@ static inline bool hyperv_feat_enabled(X86CPU *cpu, int feat)
     return !!(cpu->hyperv_features & BIT(feat));
 }
 
+#if defined(TARGET_X86_64) && \
+    defined(CONFIG_USER_ONLY) && \
+    defined(CONFIG_LINUX)
+# define TARGET_VSYSCALL_PAGE  (UINT64_C(-10) << 20)
+#endif
+
 #endif /* I386_CPU_H */
diff --git a/target/i386/translate.c b/target/i386/translate.c
index d9af8f4078b3..5e5dbb41b0ce 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8555,7 +8555,19 @@ static bool i386_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
 static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    target_ulong pc_next = disas_insn(dc, cpu);
+    target_ulong pc_next;
+
+#ifdef TARGET_VSYSCALL_PAGE
+    /*
+     * Detect entry into the vsyscall page and invoke the syscall.
+     */
+    if ((dc->base.pc_next & TARGET_PAGE_MASK) == TARGET_VSYSCALL_PAGE) {
+        gen_exception(dc, EXCP_VSYSCALL, dc->base.pc_next);
+        return;
+    }
+#endif
+
+    pc_next = disas_insn(dc, cpu);
 
     if (dc->tf || (dc->base.tb->flags & HF_INHIBIT_IRQ_MASK)) {
         /* if single step mode, we generate only one instruction and
-- 
2.25.1


