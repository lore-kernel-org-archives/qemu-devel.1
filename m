Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DA0C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB93A2083D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HvHTZ+T1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB93A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha9tt-00047p-88
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53080)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9dz-00068L-Im
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9dx-0001jT-O5
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:43 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9dx-0001j3-FO
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:41 -0400
Received: by mail-pg1-x544.google.com with SMTP id l19so1548854pgh.9
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YQ3prlLRhvmp7SwtjAI7734y9y6DKFE67qKRqtf/C98=;
 b=HvHTZ+T1fJvgUy+KrQbIAiGDQfOQGccbQ3xEGk7qfW9J0kja9XTWmUbp9oIpqCg5sB
 aP1ylcJ8SkvRsk42cBnvU1itvSbTlft18aJRkLJg26m8suIxn8T4RaupMW++LC7GDBZV
 qum7UNSR8SXiYAGFeK9pYU5WJgqQAxS+WtHJoOrBvEiTWTwIPuC6EXigBcQVGc1B0949
 HIK40iNKkke9tT/PUF8551ttlITA02FcCzRHoCtktQ3/7UHt9W0EwQLhTkg97bFUnLjl
 TEAJqYLOTZLpIT1J7qz06xJFyKaPZzn1Er/2snNy+b8YJ8MDgpjVKwJwUhNHlu42ySZ6
 f75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YQ3prlLRhvmp7SwtjAI7734y9y6DKFE67qKRqtf/C98=;
 b=QcFD9E/5r6T0YtPJ3F6BYhCiiCFgOBkgHOjIs0XfPay7tAPSdB3pROS7/jxSoHzhgI
 1vmOjxrQnuPOExOfznNhIY8YJY9jA1JrKOL+HKMyE7k9q5+zvq+3lVFtHqvV/JPjrQzQ
 0GiA0JJniK12nA0/eVxshfqX1+TEUjmlu8CO8MpOyeMMnqzYzM9VY/3cyXWJkVKd7dnG
 88mvyB8OkUHJYIh+yXvalsNX/P8u3dX/zsfzoSbfgrdg0FwT8eUvkBZgzW5UUm1AD8lb
 wQywpt+ww++qLRdHrsvRLRzE46GIy1DZzmQ97I+gnHXNhCo/U9ybOXJfIl8JULCTUHdV
 9rQw==
X-Gm-Message-State: APjAAAWhd5qtoJlyevr3M8TONVPkV9o2zL82OMawo2rLc5Uy8ahmCX1Z
 R2+IN4jOiQvY2XUZ2Fp42QWm1LICD4Q=
X-Google-Smtp-Source: APXvYqzhU6OiNMABkZfCDaeU+Rle2y0ODXD/wDcSEP5O1Kee3wP8oaUuksuYET97kC22az/pFu2H5A==
X-Received: by 2002:a65:56c5:: with SMTP id w5mr13465003pgs.434.1560132159904; 
 Sun, 09 Jun 2019 19:02:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:01:55 -0700
Message-Id: <20190610020218.9228-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PULL 16/39] target/m68k: Use env_cpu
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanup in the boilerplate that each target must define.
The combination CPU(m68k_env_get_cpu) should have used
ENV_GET_CPU to begin; use env_cpu now.

Acked-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/m68k/target_cpu.h |  2 +-
 target/m68k/cpu.h            |  5 -----
 linux-user/m68k-sim.c        |  3 +--
 linux-user/m68k/cpu_loop.c   |  2 +-
 target/m68k/helper.c         | 33 ++++++++++++---------------------
 target/m68k/m68k-semi.c      |  4 ++--
 target/m68k/op_helper.c      | 12 ++++++------
 target/m68k/translate.c      |  4 +---
 8 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
index 7a26f3c3fc..bc7446fbaf 100644
--- a/linux-user/m68k/target_cpu.h
+++ b/linux-user/m68k/target_cpu.h
@@ -31,7 +31,7 @@ static inline void cpu_clone_regs(CPUM68KState *env, target_ulong newsp)
 
 static inline void cpu_set_tls(CPUM68KState *env, target_ulong newtls)
 {
-    CPUState *cs = CPU(m68k_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     TaskState *ts = cs->opaque;
 
     ts->tp_value = newtls;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 2e53cde076..7f3fa8d141 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -163,11 +163,6 @@ struct M68kCPU {
     CPUM68KState env;
 };
 
-static inline M68kCPU *m68k_env_get_cpu(CPUM68KState *env)
-{
-    return container_of(env, M68kCPU, env);
-}
-
 #define ENV_OFFSET offsetof(M68kCPU, env)
 
 void m68k_cpu_do_interrupt(CPUState *cpu);
diff --git a/linux-user/m68k-sim.c b/linux-user/m68k-sim.c
index 34d332d8b1..9bc6ff3d3a 100644
--- a/linux-user/m68k-sim.c
+++ b/linux-user/m68k-sim.c
@@ -91,7 +91,6 @@ static int translate_openflags(int flags)
 #define ARG(x) tswap32(args[x])
 void do_m68k_simcall(CPUM68KState *env, int nr)
 {
-    M68kCPU *cpu = m68k_env_get_cpu(env);
     uint32_t *args;
 
     args = (uint32_t *)(unsigned long)(env->aregs[7] + 4);
@@ -159,6 +158,6 @@ void do_m68k_simcall(CPUM68KState *env, int nr)
         check_err(env, lseek(ARG(0), (int32_t)ARG(1), ARG(2)));
         break;
     default:
-        cpu_abort(CPU(cpu), "Unsupported m68k sim syscall %d\n", nr);
+        cpu_abort(env_cpu(env), "Unsupported m68k sim syscall %d\n", nr);
     }
 }
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 42d8d841ea..f2c33057b3 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -23,7 +23,7 @@
 
 void cpu_loop(CPUM68KState *env)
 {
-    CPUState *cs = CPU(m68k_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr;
     unsigned int n;
     target_siginfo_t info;
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 6db93bdd81..31aacb51c6 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -168,8 +168,6 @@ void m68k_cpu_init_gdb(M68kCPU *cpu)
 
 void HELPER(cf_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
 {
-    M68kCPU *cpu = m68k_env_get_cpu(env);
-
     switch (reg) {
     case M68K_CR_CACR:
         env->cacr = val;
@@ -186,7 +184,7 @@ void HELPER(cf_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
         break;
     /* TODO: Implement control registers.  */
     default:
-        cpu_abort(CPU(cpu),
+        cpu_abort(env_cpu(env),
                   "Unimplemented control register write 0x%x = 0x%x\n",
                   reg, val);
     }
@@ -194,8 +192,6 @@ void HELPER(cf_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
 
 void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
 {
-    M68kCPU *cpu = m68k_env_get_cpu(env);
-
     switch (reg) {
     /* MC680[1234]0 */
     case M68K_CR_SFC:
@@ -248,14 +244,13 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
         env->mmu.ttr[M68K_DTTR1] = val;
         return;
     }
-    cpu_abort(CPU(cpu), "Unimplemented control register write 0x%x = 0x%x\n",
+    cpu_abort(env_cpu(env),
+              "Unimplemented control register write 0x%x = 0x%x\n",
               reg, val);
 }
 
 uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
 {
-    M68kCPU *cpu = m68k_env_get_cpu(env);
-
     switch (reg) {
     /* MC680[1234]0 */
     case M68K_CR_SFC:
@@ -292,7 +287,7 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
     case M68K_CR_DTT1:
         return env->mmu.ttr[M68K_DTTR1];
     }
-    cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
+    cpu_abort(env_cpu(env), "Unimplemented control register read 0x%x\n",
               reg);
 }
 
@@ -388,8 +383,7 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
     uint32_t last_logical, last_physical;
     int32_t size;
     int last_attr = -1, attr = -1;
-    M68kCPU *cpu = m68k_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
     MemTxResult txres;
 
     if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
@@ -630,8 +624,7 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
                                 int *prot, target_ulong address,
                                 int access_type, target_ulong *page_size)
 {
-    M68kCPU *cpu = m68k_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
     uint32_t entry;
     uint32_t next;
     target_ulong page_mask;
@@ -1175,7 +1168,7 @@ void HELPER(mac_set_flags)(CPUM68KState *env, uint32_t acc)
         z = n;                                                             \
         break;                                                             \
     default:                                                               \
-        cpu_abort(CPU(m68k_env_get_cpu(env)), "Bad CC_OP %d", op);         \
+        cpu_abort(env_cpu(env), "Bad CC_OP %d", op);                       \
     }                                                                      \
 } while (0)
 
@@ -1358,8 +1351,6 @@ void HELPER(set_mac_extu)(CPUM68KState *env, uint32_t val, uint32_t acc)
 #if defined(CONFIG_SOFTMMU)
 void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
 {
-    M68kCPU *cpu = m68k_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
     hwaddr physical;
     int access_type;
     int prot;
@@ -1384,7 +1375,7 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
     if (ret == 0) {
         addr &= TARGET_PAGE_MASK;
         physical += addr & (page_size - 1);
-        tlb_set_page(cs, addr, physical,
+        tlb_set_page(env_cpu(env), addr, physical,
                      prot, access_type & ACCESS_SUPER ?
                      MMU_KERNEL_IDX : MMU_USER_IDX, page_size);
     }
@@ -1392,18 +1383,18 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
 
 void HELPER(pflush)(CPUM68KState *env, uint32_t addr, uint32_t opmode)
 {
-    M68kCPU *cpu = m68k_env_get_cpu(env);
+    CPUState *cs = env_cpu(env);
 
     switch (opmode) {
     case 0: /* Flush page entry if not global */
     case 1: /* Flush page entry */
-        tlb_flush_page(CPU(cpu), addr);
+        tlb_flush_page(cs, addr);
         break;
     case 2: /* Flush all except global entries */
-        tlb_flush(CPU(cpu));
+        tlb_flush(cs);
         break;
     case 3: /* Flush all entries */
-        tlb_flush(CPU(cpu));
+        tlb_flush(cs);
         break;
     }
 }
diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 1402145c8f..6716b93b5a 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -421,7 +421,7 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
     case HOSTED_INIT_SIM:
 #if defined(CONFIG_USER_ONLY)
         {
-        CPUState *cs = CPU(m68k_env_get_cpu(env));
+        CPUState *cs = env_cpu(env);
         TaskState *ts = cs->opaque;
         /* Allocate the heap using sbrk.  */
         if (!ts->heap_limit) {
@@ -454,7 +454,7 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
 #endif
         return;
     default:
-        cpu_abort(CPU(m68k_env_get_cpu(env)), "Unsupported semihosting syscall %d\n", nr);
+        cpu_abort(env_cpu(env), "Unsupported semihosting syscall %d\n", nr);
         result = 0;
     }
 failed:
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 3d1aa23a02..ebcfe3dfdd 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -196,7 +196,7 @@ static const char *m68k_exception_name(int index)
 
 static void cf_interrupt_all(CPUM68KState *env, int is_hw)
 {
-    CPUState *cs = CPU(m68k_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint32_t sp;
     uint32_t sr;
     uint32_t fmt;
@@ -274,7 +274,7 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
 {
     if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
         /*  all except 68000 */
-        CPUState *cs = CPU(m68k_env_get_cpu(env));
+        CPUState *cs = env_cpu(env);
         switch (format) {
         case 4:
             *sp -= 4;
@@ -299,7 +299,7 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
 
 static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
 {
-    CPUState *cs = CPU(m68k_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint32_t sp;
     uint32_t retaddr;
     uint32_t vector;
@@ -507,7 +507,7 @@ bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 static void raise_exception_ra(CPUM68KState *env, int tt, uintptr_t raddr)
 {
-    CPUState *cs = CPU(m68k_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = tt;
     cpu_loop_exit_restore(cs, raddr);
@@ -1037,7 +1037,7 @@ void HELPER(chk)(CPUM68KState *env, int32_t val, int32_t ub)
     env->cc_c = 0 <= ub ? val < 0 || val > ub : val > ub && val < 0;
 
     if (val < 0 || val > ub) {
-        CPUState *cs = CPU(m68k_env_get_cpu(env));
+        CPUState *cs = env_cpu(env);
 
         /* Recover PC and CC_OP for the beginning of the insn.  */
         cpu_restore_state(cs, GETPC(), true);
@@ -1068,7 +1068,7 @@ void HELPER(chk2)(CPUM68KState *env, int32_t val, int32_t lb, int32_t ub)
     env->cc_c = lb <= ub ? val < lb || val > ub : val > ub && val < lb;
 
     if (env->cc_c) {
-        CPUState *cs = CPU(m68k_env_get_cpu(env));
+        CPUState *cs = env_cpu(env);
 
         /* Recover PC and CC_OP for the beginning of the insn.  */
         cpu_restore_state(cs, GETPC(), true);
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f0534a4ba0..2ae537461f 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4777,14 +4777,12 @@ DISAS_INSN(wddata)
 
 DISAS_INSN(wdebug)
 {
-    M68kCPU *cpu = m68k_env_get_cpu(env);
-
     if (IS_USER(s)) {
         gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
     /* TODO: Implement wdebug.  */
-    cpu_abort(CPU(cpu), "WDEBUG not implemented");
+    cpu_abort(env_cpu(env), "WDEBUG not implemented");
 }
 #endif
 
-- 
2.17.1


