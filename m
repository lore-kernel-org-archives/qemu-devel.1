Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A37C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363252078A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7bxIiv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363252078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfM4-0007ck-8i
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEf-0000eA-Bf
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:09 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEc-00057J-Na
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:09 -0400
Received: by mail-pf1-x441.google.com with SMTP id 17so729988pfw.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tvav2yDgl091Kla7AxGkIifdrAi1yowT9YLtoH5uMlM=;
 b=c7bxIiv55uJTvV7CM3S2ERtZ6aPNhVq4Z0OLfFhAKSlx5dnzd/6p7Tkk2GaUJWYVV7
 hSPAO0gdAa6oTbnW+QhUw/TDWrsMmiPRdWjtMApxvejOZ0jlE0h9Itt52acYpIacaMR7
 7NUSwxxnsOx1+ScErVMJ+jTWw7/oQCoW6Gx3lzqf5ek8apX8aEdM3waqJDMVpnFLg+Mt
 ofbo7Advl6BYzQLf3sb94G61JX6QM5Xcuq8bB9xNaLg88JhYA4267fcERck/AmP58gVS
 qapZ+M76ge9nLTIHSlO3YaM6DQkIbpXNZIhVbXUXA9p013dAGFythezqt9LYTZTtB/ly
 xC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tvav2yDgl091Kla7AxGkIifdrAi1yowT9YLtoH5uMlM=;
 b=YUjd+TK37pyhFkaMpN4e8CTIrSeTCj/CqfVvuAa1vXWhFaOgu+qmESuGxpUHZAf0WU
 4vJgI0xeOQ0AJoDImx3CdzvQN+OIg8IzdnEIhJ0tuvb3+a5WMZs18igTNLwNS0NBfpou
 SX2kZ12ihUMEK56j9O+TgvyLkCt2mo+qEThgKEFqIomjZ2GOGScRI9itxOA4MOuG4iS4
 LCFtdUZ/GPUUn7aylMHLFqcdkTbhgdy2dC2u5bDr1lqCbgyXg8WskWYNthwXjcjiIEob
 17BNmKGycGPumLvL48Mw/QszwdCGJw05amQr2kEJmeWFQGEiiuf0PzaKhcHgTYXZ3PBB
 vhAw==
X-Gm-Message-State: AOAM5330zQQo5nIpHxCzjTc3CYM5p8EWiSNpkLbi2j0GgC4rJHR6G04F
 4UHjzh5diKldBgOGek4fMvNysNTeSa/LmQ==
X-Google-Smtp-Source: ABdhPJz45Q5AGu1osyZMyAxml+YBRSIeLRe3jMa/Ph0Jm+hIg8p+cetQ2RrXFdGD/03VhayVff2nzA==
X-Received: by 2002:a05:6a00:1688:: with SMTP id
 k8mr1414318pfc.33.1598624404483; 
 Fri, 28 Aug 2020 07:20:04 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 25/76] target/microblaze: Split out MSR[C] to its own
 variable
Date: Fri, 28 Aug 2020 07:18:38 -0700
Message-Id: <20200828141929.77854-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Having the MSR[C] bit separate will improve arithmetic that operates
on the carry bit.  Having mb_cpu_read_msr() populate MSR[CC] will
prevent the carry copy not matching the carry bit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       | 19 +++++++-
 linux-user/elfload.c          |  2 +-
 target/microblaze/cpu.c       |  4 +-
 target/microblaze/gdbstub.c   |  4 +-
 target/microblaze/helper.c    | 58 +++++++++++-----------
 target/microblaze/translate.c | 91 +++++++++++------------------------
 6 files changed, 82 insertions(+), 96 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 7708c9a3d3..7066878ac7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -236,7 +236,8 @@ struct CPUMBState {
     uint32_t imm;
     uint32_t regs[32];
     uint32_t pc;
-    uint32_t msr;
+    uint32_t msr;    /* All bits of MSR except MSR[C] and MSR[CC] */
+    uint32_t msr_c;  /* MSR[C], in low bit; other bits must be 0 */
     uint64_t ear;
     uint32_t esr;
     uint32_t fsr;
@@ -327,6 +328,22 @@ hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
+static inline uint32_t mb_cpu_read_msr(const CPUMBState *env)
+{
+    /* Replicate MSR[C] to MSR[CC]. */
+    return env->msr | (env->msr_c * (MSR_C | MSR_CC));
+}
+
+static inline void mb_cpu_write_msr(CPUMBState *env, uint32_t val)
+{
+    env->msr_c = (val >> 2) & 1;
+    /*
+     * Clear both MSR[C] and MSR[CC] from the saved copy.
+     * MSR_PVR is not writable and is always clear.
+     */
+    env->msr = val & ~(MSR_C | MSR_CC | MSR_PVR);
+}
+
 void mb_tcg_init(void);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index bbfb665321..98af4fe7e0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1033,7 +1033,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
     }
 
     (*regs)[pos++] = tswapreg(env->pc);
-    (*regs)[pos++] = tswapreg(env->msr);
+    (*regs)[pos++] = tswapreg(mb_cpu_read_msr(env));
     (*regs)[pos++] = 0;
     (*regs)[pos++] = tswapreg(env->ear);
     (*regs)[pos++] = 0;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 0eac068570..1eabf5cc3f 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -121,9 +121,9 @@ static void mb_cpu_reset(DeviceState *dev)
 
 #if defined(CONFIG_USER_ONLY)
     /* start in user mode with interrupts enabled.  */
-    env->msr = MSR_EE | MSR_IE | MSR_VM | MSR_UM;
+    mb_cpu_write_msr(env, MSR_EE | MSR_IE | MSR_VM | MSR_UM);
 #else
-    env->msr = 0;
+    mb_cpu_write_msr(env, 0);
     mmu_init(&env->mmu);
     env->mmu.c_mmu = 3;
     env->mmu.c_mmu_tlb_access = 3;
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 9cba9d2215..08d6a0e807 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -62,7 +62,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         val = env->pc;
         break;
     case GDB_MSR:
-        val = env->msr;
+        val = mb_cpu_read_msr(env);
         break;
     case GDB_EAR:
         val = env->ear;
@@ -118,7 +118,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->pc = tmp;
         break;
     case GDB_MSR:
-        env->msr = tmp;
+        mb_cpu_write_msr(env, tmp);
         break;
     case GDB_EAR:
         env->ear = tmp;
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index b2373f6a23..9a95456401 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -112,12 +112,11 @@ void mb_cpu_do_interrupt(CPUState *cs)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
-    uint32_t t;
+    uint32_t t, msr = mb_cpu_read_msr(env);
 
     /* IMM flag cannot propagate across a branch and into the dslot.  */
     assert(!((env->iflags & D_FLAG) && (env->iflags & IMM_FLAG)));
     assert(!(env->iflags & (DRTI_FLAG | DRTE_FLAG | DRTB_FLAG)));
-/*    assert(env->msr & (MSR_EE)); Only for HW exceptions.  */
     env->res_addr = RES_ADDR_NONE;
     switch (cs->exception_index) {
         case EXCP_HW_EXCP:
@@ -136,11 +135,12 @@ void mb_cpu_do_interrupt(CPUState *cs)
             }
 
             /* Disable the MMU.  */
-            t = (env->msr & (MSR_VM | MSR_UM)) << 1;
-            env->msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
-            env->msr |= t;
+            t = (msr & (MSR_VM | MSR_UM)) << 1;
+            msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
+            msr |= t;
             /* Exception in progress.  */
-            env->msr |= MSR_EIP;
+            msr |= MSR_EIP;
+            mb_cpu_write_msr(env, msr);
 
             qemu_log_mask(CPU_LOG_INT,
                           "hw exception at pc=%x ear=%" PRIx64 " "
@@ -178,11 +178,12 @@ void mb_cpu_do_interrupt(CPUState *cs)
             }
 
             /* Disable the MMU.  */
-            t = (env->msr & (MSR_VM | MSR_UM)) << 1;
-            env->msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
-            env->msr |= t;
+            t = (msr & (MSR_VM | MSR_UM)) << 1;
+            msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
+            msr |= t;
             /* Exception in progress.  */
-            env->msr |= MSR_EIP;
+            msr |= MSR_EIP;
+            mb_cpu_write_msr(env, msr);
 
             qemu_log_mask(CPU_LOG_INT,
                           "exception at pc=%x ear=%" PRIx64 " iflags=%x\n",
@@ -193,11 +194,11 @@ void mb_cpu_do_interrupt(CPUState *cs)
             break;
 
         case EXCP_IRQ:
-            assert(!(env->msr & (MSR_EIP | MSR_BIP)));
-            assert(env->msr & MSR_IE);
+            assert(!(msr & (MSR_EIP | MSR_BIP)));
+            assert(msr & MSR_IE);
             assert(!(env->iflags & D_FLAG));
 
-            t = (env->msr & (MSR_VM | MSR_UM)) << 1;
+            t = (msr & (MSR_VM | MSR_UM)) << 1;
 
 #if 0
 #include "disas/disas.h"
@@ -212,21 +213,20 @@ void mb_cpu_do_interrupt(CPUState *cs)
                     && (!strcmp("netif_rx", sym)
                         || !strcmp("process_backlog", sym))) {
 
-                    qemu_log(
-                         "interrupt at pc=%x msr=%x %x iflags=%x sym=%s\n",
-                         env->pc, env->msr, t, env->iflags,
-                         sym);
+                    qemu_log("interrupt at pc=%x msr=%x %x iflags=%x sym=%s\n",
+                             env->pc, msr, t, env->iflags, sym);
 
                     log_cpu_state(cs, 0);
                 }
             }
 #endif
             qemu_log_mask(CPU_LOG_INT,
-                         "interrupt at pc=%x msr=%x %x iflags=%x\n",
-                         env->pc, env->msr, t, env->iflags);
+                          "interrupt at pc=%x msr=%x %x iflags=%x\n",
+                          env->pc, msr, t, env->iflags);
 
-            env->msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM | MSR_IE);
-            env->msr |= t;
+            msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM | MSR_IE);
+            msr |= t;
+            mb_cpu_write_msr(env, msr);
 
             env->regs[14] = env->pc;
             env->pc = cpu->cfg.base_vectors + 0x10;
@@ -237,20 +237,22 @@ void mb_cpu_do_interrupt(CPUState *cs)
         case EXCP_HW_BREAK:
             assert(!(env->iflags & IMM_FLAG));
             assert(!(env->iflags & D_FLAG));
-            t = (env->msr & (MSR_VM | MSR_UM)) << 1;
+            t = (msr & (MSR_VM | MSR_UM)) << 1;
             qemu_log_mask(CPU_LOG_INT,
                           "break at pc=%x msr=%x %x iflags=%x\n",
-                          env->pc, env->msr, t, env->iflags);
+                          env->pc, msr, t, env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
-            env->msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
-            env->msr |= t;
-            env->msr |= MSR_BIP;
+            msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
+            msr |= t;
+            msr |= MSR_BIP;
             if (cs->exception_index == EXCP_HW_BREAK) {
                 env->regs[16] = env->pc;
-                env->msr |= MSR_BIP;
+                msr |= MSR_BIP;
                 env->pc = cpu->cfg.base_vectors + 0x18;
-            } else
+            } else {
                 env->pc = env->btarget;
+            }
+            mb_cpu_write_msr(env, msr);
             break;
         default:
             cpu_abort(cs, "unhandled exception type=%d\n",
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index e709884f2d..0c9b4ffa5a 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -56,6 +56,7 @@
 static TCGv_i32 cpu_R[32];
 static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
+static TCGv_i32 cpu_msr_c;
 static TCGv_i32 cpu_imm;
 static TCGv_i32 cpu_btaken;
 static TCGv_i32 cpu_btarget;
@@ -150,30 +151,6 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
     }
 }
 
-static void read_carry(DisasContext *dc, TCGv_i32 d)
-{
-    tcg_gen_shri_i32(d, cpu_msr, 31);
-}
-
-/*
- * write_carry sets the carry bits in MSR based on bit 0 of v.
- * v[31:1] are ignored.
- */
-static void write_carry(DisasContext *dc, TCGv_i32 v)
-{
-    /* Deposit bit 0 into MSR_C and the alias MSR_CC.  */
-    tcg_gen_deposit_i32(cpu_msr, cpu_msr, v, 2, 1);
-    tcg_gen_deposit_i32(cpu_msr, cpu_msr, v, 31, 1);
-}
-
-static void write_carryi(DisasContext *dc, bool carry)
-{
-    TCGv_i32 t0 = tcg_temp_new_i32();
-    tcg_gen_movi_i32(t0, carry);
-    write_carry(dc, t0);
-    tcg_temp_free_i32(t0);
-}
-
 /*
  * Returns true if the insn an illegal operation.
  * If exceptions are enabled, an exception is raised.
@@ -243,11 +220,7 @@ static void dec_add(DisasContext *dc)
 
             if (c) {
                 /* c - Add carry into the result.  */
-                cf = tcg_temp_new_i32();
-
-                read_carry(dc, cf);
-                tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->rd], cf);
-                tcg_temp_free_i32(cf);
+                tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->rd], cpu_msr_c);
             }
         }
         return;
@@ -257,21 +230,15 @@ static void dec_add(DisasContext *dc)
     /* Extract carry.  */
     cf = tcg_temp_new_i32();
     if (c) {
-        read_carry(dc, cf);
+        tcg_gen_mov_i32(cf, cpu_msr_c);
     } else {
         tcg_gen_movi_i32(cf, 0);
     }
 
+    gen_helper_carry(cpu_msr_c, cpu_R[dc->ra], *(dec_alu_op_b(dc)), cf);
     if (dc->rd) {
-        TCGv_i32 ncf = tcg_temp_new_i32();
-        gen_helper_carry(ncf, cpu_R[dc->ra], *(dec_alu_op_b(dc)), cf);
         tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
         tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->rd], cf);
-        write_carry(dc, ncf);
-        tcg_temp_free_i32(ncf);
-    } else {
-        gen_helper_carry(cf, cpu_R[dc->ra], *(dec_alu_op_b(dc)), cf);
-        write_carry(dc, cf);
     }
     tcg_temp_free_i32(cf);
 }
@@ -309,11 +276,7 @@ static void dec_sub(DisasContext *dc)
 
             if (c) {
                 /* c - Add carry into the result.  */
-                cf = tcg_temp_new_i32();
-
-                read_carry(dc, cf);
-                tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->rd], cf);
-                tcg_temp_free_i32(cf);
+                tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->rd], cpu_msr_c);
             }
         }
         return;
@@ -324,7 +287,7 @@ static void dec_sub(DisasContext *dc)
     cf = tcg_temp_new_i32();
     na = tcg_temp_new_i32();
     if (c) {
-        read_carry(dc, cf);
+        tcg_gen_mov_i32(cf, cpu_msr_c);
     } else {
         tcg_gen_movi_i32(cf, 1);
     }
@@ -332,16 +295,10 @@ static void dec_sub(DisasContext *dc)
     /* d = b + ~a + c. carry defaults to 1.  */
     tcg_gen_not_i32(na, cpu_R[dc->ra]);
 
+    gen_helper_carry(cpu_msr_c, na, *(dec_alu_op_b(dc)), cf);
     if (dc->rd) {
-        TCGv_i32 ncf = tcg_temp_new_i32();
-        gen_helper_carry(ncf, na, *(dec_alu_op_b(dc)), cf);
         tcg_gen_add_i32(cpu_R[dc->rd], na, *(dec_alu_op_b(dc)));
         tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->rd], cf);
-        write_carry(dc, ncf);
-        tcg_temp_free_i32(ncf);
-    } else {
-        gen_helper_carry(cf, na, *(dec_alu_op_b(dc)), cf);
-        write_carry(dc, cf);
     }
     tcg_temp_free_i32(cf);
     tcg_temp_free_i32(na);
@@ -429,16 +386,26 @@ static void dec_xor(DisasContext *dc)
         tcg_gen_xor_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
 }
 
-static inline void msr_read(DisasContext *dc, TCGv_i32 d)
+static void msr_read(DisasContext *dc, TCGv_i32 d)
 {
-    tcg_gen_mov_i32(d, cpu_msr);
+    TCGv_i32 t;
+
+    /* Replicate the cpu_msr_c boolean into the proper bit and the copy. */
+    t = tcg_temp_new_i32();
+    tcg_gen_muli_i32(t, cpu_msr_c, MSR_C | MSR_CC);
+    tcg_gen_or_i32(d, cpu_msr, t);
+    tcg_temp_free_i32(t);
 }
 
-static inline void msr_write(DisasContext *dc, TCGv_i32 v)
+static void msr_write(DisasContext *dc, TCGv_i32 v)
 {
     dc->cpustate_changed = 1;
-    /* PVR bit is not writable, and is never set. */
-    tcg_gen_andi_i32(cpu_msr, v, ~MSR_PVR);
+
+    /* Install MSR_C.  */
+    tcg_gen_extract_i32(cpu_msr_c, v, 2, 1);
+
+    /* Clear MSR_C and MSR_CC; MSR_PVR is not writable, and is always clear. */
+    tcg_gen_andi_i32(cpu_msr, v, ~(MSR_C | MSR_CC | MSR_PVR));
 }
 
 static void dec_msr(DisasContext *dc)
@@ -778,8 +745,8 @@ static void dec_bit(DisasContext *dc)
             t0 = tcg_temp_new_i32();
 
             LOG_DIS("src r%d r%d\n", dc->rd, dc->ra);
-            tcg_gen_andi_i32(t0, cpu_msr, MSR_CC);
-            write_carry(dc, cpu_R[dc->ra]);
+            tcg_gen_shli_i32(t0, cpu_msr_c, 31);
+            tcg_gen_andi_i32(cpu_msr_c, cpu_R[dc->ra], 1);
             if (dc->rd) {
                 tcg_gen_shri_i32(cpu_R[dc->rd], cpu_R[dc->ra], 1);
                 tcg_gen_or_i32(cpu_R[dc->rd], cpu_R[dc->rd], t0);
@@ -792,8 +759,7 @@ static void dec_bit(DisasContext *dc)
             /* srl.  */
             LOG_DIS("srl r%d r%d\n", dc->rd, dc->ra);
 
-            /* Update carry. Note that write carry only looks at the LSB.  */
-            write_carry(dc, cpu_R[dc->ra]);
+            tcg_gen_andi_i32(cpu_msr_c, cpu_R[dc->ra], 1);
             if (dc->rd) {
                 if (op == 0x41)
                     tcg_gen_shri_i32(cpu_R[dc->rd], cpu_R[dc->ra], 1);
@@ -1042,7 +1008,7 @@ static void dec_load(DisasContext *dc)
 
     if (ex) { /* lwx */
         /* no support for AXI exclusive so always clear C */
-        write_carryi(dc, 0);
+        tcg_gen_movi_i32(cpu_msr_c, 0);
     }
 
     tcg_temp_free(addr);
@@ -1093,7 +1059,7 @@ static void dec_store(DisasContext *dc)
         /* swx does not throw unaligned access errors, so force alignment */
         tcg_gen_andi_tl(addr, addr, ~3);
 
-        write_carryi(dc, 1);
+        tcg_gen_movi_i32(cpu_msr_c, 1);
         swx_skip = gen_new_label();
         tcg_gen_brcond_tl(TCG_COND_NE, cpu_res_addr, addr, swx_skip);
 
@@ -1108,7 +1074,7 @@ static void dec_store(DisasContext *dc)
                                    mop);
 
         tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_val, tval, swx_skip);
-        write_carryi(dc, 0);
+        tcg_gen_movi_i32(cpu_msr_c, 0);
         tcg_temp_free_i32(tval);
     }
 
@@ -1851,6 +1817,7 @@ void mb_tcg_init(void)
 
         SP(pc),
         SP(msr),
+        SP(msr_c),
         SP(imm),
         SP(iflags),
         SP(btaken),
-- 
2.25.1


