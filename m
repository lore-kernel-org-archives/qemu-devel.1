Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A468C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D140A20786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D140A20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgT6-0002P3-TM
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGgPC-00069n-IA
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGgPA-0000ep-NE
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:30 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60365)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jGgPA-0000eK-Do
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:28 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M2fDl-1jFqvM2Xdf-004FkX; Tue, 24 Mar 2020 11:03:15 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] linux-user/i386: Emulate x86_64 vsyscalls
Date: Tue, 24 Mar 2020 11:03:09 +0100
Message-Id: <20200324100311.588288-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324100311.588288-1-laurent@vivier.eu>
References: <20200324100311.588288-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OXu2EBDMcXnv46HrJDbKY9A+52Hd7vrYXjTaMleT9EevKzQ9qQz
 S+hP+E4rNj/+ixO+fkI0HJYwx/fN/NCEaijyE+J1zIPF84DRLw438FvX0ynC4uD7QMIzA9d
 XfQq8PA1pyAfqJv+tlcy2U2YIkmHrB5EF4ZJl/Ou8fuX19cBwtPR1VcTQhskzTBSG87sIDQ
 FiqkDE47YA4xHeo2zwSlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hufkybbf2n0=:P6v+ihT7h5V+5U0sD3zBG8
 8ndo1lru968ESMimuGlAE/xUd3MfXyuGNUMJedDb+i3/BCjXaH00YDyomi4KQqn/owSuXgGmJ
 1CkUwfjW8uy9zCEN6qQcy7D2TwgLsoix9+9jUEst8pHh1Sc4p92n8hDAMk7wev2EaecqIRcD1
 tVxaEUPw4MvIb/jAHPsahT/QW+WVvuorl7qZ2vSTPC00g10lk5/QkMwaMnh3+jctRmlg09U0K
 8fVG/1kWj6mJATi/s9ewJg3TkHT7sIsZ8mFMIG0+jCkNiSIwnrKFC95ubK+fhBcaGYvW1yuF0
 2grKY9jM3INpUjI8X1NIqs7UP/HBppCl/zjCDsYpm/sYpcc1UtolDXc0RzK5ZuR6lfTIufX2E
 Dj0ilrSfwEmn6tUXbaPHrZjmgCgMLKMwR9iFJT4Ox0tqhUzVbDN517cgVUDW0x02XOL/+nG7w
 fBb2xzk5ulSYmkrW//Y7goDaL4GA7ITy2mAO9Y/9+k4D5Q4HBFiZFQ1c1Q0bwiatJnqFecSis
 oGwhuuggZRgIdrkpQTmSbkNPt4SomBgyNoj6bU/S2k30n1sa4LfXDmdvzStNC5EZKUdz2dvZo
 0SnEdaiIsasFRix4RTMv+dQn08wzHE+aYBMHEq8bzDarwtRln6RDW7ccYMvyEf9d6Va4tgyQB
 CJvHZQTsJ1XtMwevGawQj8iRH7Ge9LKYQnX1bXSwvyj+HQyrjT42Y6ch+IPKoIOY62QA3c6VD
 6xPUIoVzifItTeO7RDzRg00dSlCUrgiSRRv3FHyQSIx3EXTAjT1KcUEqKRQmVLKQL7T9VxQ0X
 FYXYtBo7Z8jvI2mz5QyzPhAvNQGrNLlOE/pWc6CIlAsR40RdptAxgPyCZThpcFhWrTs9e9C
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
index 49ecc23104c9..9af1b0c12e8e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1003,6 +1003,7 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 
 #define EXCP_VMEXIT     0x100 /* only for system emulation */
 #define EXCP_SYSCALL    0x101 /* only for user emulation */
+#define EXCP_VSYSCALL   0x102 /* only for user emulation */
 
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
@@ -2218,4 +2219,10 @@ static inline bool hyperv_feat_enabled(X86CPU *cpu, int feat)
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


