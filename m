Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFD8C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C7A208C9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtGSnpTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C7A208C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfFP-0001a9-AW
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEH-000872-Ve
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:46 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEF-00053o-TJ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:45 -0400
Received: by mail-pg1-x544.google.com with SMTP id d19so516033pgl.10
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7Ks3symFLErGr7Owkm+SISLoajDlzvmQWhx78MqL0K4=;
 b=WtGSnpTvGsoXGp8gH9G7d+JaqMGE9+ziWaxVo4aT59gqip+xfd6Szb6hSrgAxLj0Ex
 VDtHWdLza8hKR5vjzFzWaUXsAOaHRB/2Rul8bRgh/n8KOwE6rfE20Oyl6GSZFr4LMjgk
 MWwRRM2SoZG0vo5gQrIStuSooAdxEcc4tTrQtAxmJX0W6GVTkBMD+G5vXm1NCJ/J7Ngt
 FiDlltfT/zzvGDn5G3kcRh4qZZq0HGLODn34qpxm+d4CXexo380qjdZVfBPgo4rLk10L
 CJWJj42c0WV1avRVeIk3kchD/3pTKgDhewAegZ6IygNncgECx0EQe41aF7V/QbkOC2FC
 PuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7Ks3symFLErGr7Owkm+SISLoajDlzvmQWhx78MqL0K4=;
 b=XGaLvoYVKKyITDtHKsuL23kr9v6prMh4B7E4Sh5W64a8wCNP11Rf30ndFCZ0J5r8t1
 0IW+QI66uJAU36WDUagjireejXO4ki+Q9M2ohc1OiX8061XcNB7HjhaevCGae7z5SBvR
 CJUMeDbmIhx4jrIlHIHPciR4lzsc2fr54CDYYslOmno9pUcAvCrr+OLoAi7llZFCCv+J
 h1sSU+AZ4I3EXoaefg/bXMT5cxucY97ChlmOu24BJ+3OmxbobK00m3Be6wXJC8xpZDoS
 f5J5J0ZLbJORd2XcX9RppYgbigMw5cwX9e7dQwlYNEMTmq1gHkYXLt1nktHkPUVBnxdO
 AyJA==
X-Gm-Message-State: AOAM5328izUksLp4zKqF3o/tKjP8/55+rtrTNmSsR4AnBDBGOggeH9Td
 7d1uy3OwhHPLD0nbkOyMH4Un7l9x8KoyYg==
X-Google-Smtp-Source: ABdhPJyYoiBKfgMtu/QaPlOQnQoeg1vfT0jZRfuMUD11v08ByvlrJzlLKVj7SI362MRIUBivoM3SqA==
X-Received: by 2002:a63:b10a:: with SMTP id r10mr1439412pgf.431.1598624381962; 
 Fri, 28 Aug 2020 07:19:41 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/76] target/microblaze: Split out ESR from env->sregs
Date: Fri, 28 Aug 2020 07:18:21 -0700
Message-Id: <20200828141929.77854-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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

Continue eliminating the sregs array in favor of individual members.
Does not correct the width of ESR, yet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h          |  1 +
 linux-user/microblaze/cpu_loop.c |  6 +++---
 target/microblaze/gdbstub.c      |  4 ++--
 target/microblaze/helper.c       | 18 +++++++++---------
 target/microblaze/op_helper.c    | 17 ++++++++---------
 target/microblaze/translate.c    |  6 ++++--
 6 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index c9035b410e..7d94af43ed 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -239,6 +239,7 @@ struct CPUMBState {
     uint64_t pc;
     uint64_t msr;
     uint64_t ear;
+    uint64_t esr;
     uint64_t sregs[14];
     float_status fp_status;
     /* Stack protectors. Yes, it's a hw feature.  */
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 3c693086f4..c10e3e0261 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -78,14 +78,14 @@ void cpu_loop(CPUMBState *env)
         case EXCP_HW_EXCP:
             env->regs[17] = env->pc + 4;
             if (env->iflags & D_FLAG) {
-                env->sregs[SR_ESR] |= 1 << 12;
+                env->esr |= 1 << 12;
                 env->pc -= 4;
                 /* FIXME: if branch was immed, replay the imm as well.  */
             }
 
             env->iflags &= ~(IMM_FLAG | D_FLAG);
 
-            switch (env->sregs[SR_ESR] & 31) {
+            switch (env->esr & 31) {
                 case ESR_EC_DIVZERO:
                     info.si_signo = TARGET_SIGFPE;
                     info.si_errno = 0;
@@ -107,7 +107,7 @@ void cpu_loop(CPUMBState *env)
                     break;
                 default:
                     fprintf(stderr, "Unhandled hw-exception: 0x%" PRIx64 "\n",
-                            env->sregs[SR_ESR] & ESR_EC_MASK);
+                            env->esr & ESR_EC_MASK);
                     cpu_dump_state(cs, stderr, 0);
                     exit(EXIT_FAILURE);
                     break;
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index e33a613efe..05e22f233d 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -68,7 +68,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         val = env->ear;
         break;
     case GDB_ESR:
-        val = env->sregs[SR_ESR];
+        val = env->esr;
         break;
     case GDB_FSR:
         val = env->sregs[SR_FSR];
@@ -124,7 +124,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->ear = tmp;
         break;
     case GDB_ESR:
-        env->sregs[SR_ESR] = tmp;
+        env->esr = tmp;
         break;
     case GDB_FSR:
         env->sregs[SR_FSR] = tmp;
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index afe9634781..ea290be780 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -88,12 +88,12 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     env->ear = address;
     switch (lu.err) {
     case ERR_PROT:
-        env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ? 17 : 16;
-        env->sregs[SR_ESR] |= (access_type == MMU_DATA_STORE) << 10;
+        env->esr = access_type == MMU_INST_FETCH ? 17 : 16;
+        env->esr |= (access_type == MMU_DATA_STORE) << 10;
         break;
     case ERR_MISS:
-        env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ? 19 : 18;
-        env->sregs[SR_ESR] |= (access_type == MMU_DATA_STORE) << 10;
+        env->esr = access_type == MMU_INST_FETCH ? 19 : 18;
+        env->esr |= (access_type == MMU_DATA_STORE) << 10;
         break;
     default:
         abort();
@@ -127,11 +127,11 @@ void mb_cpu_do_interrupt(CPUState *cs)
             }
 
             env->regs[17] = env->pc + 4;
-            env->sregs[SR_ESR] &= ~(1 << 12);
+            env->esr &= ~(1 << 12);
 
             /* Exception breaks branch + dslot sequence?  */
             if (env->iflags & D_FLAG) {
-                env->sregs[SR_ESR] |= 1 << 12 ;
+                env->esr |= 1 << 12 ;
                 env->sregs[SR_BTR] = env->btarget;
             }
 
@@ -146,7 +146,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
                           "hw exception at pc=%" PRIx64 " ear=%" PRIx64 " "
                           "esr=%" PRIx64 " iflags=%x\n",
                           env->pc, env->ear,
-                          env->sregs[SR_ESR], env->iflags);
+                          env->esr, env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
             env->iflags &= ~(IMM_FLAG | D_FLAG);
             env->pc = cpu->cfg.base_vectors + 0x20;
@@ -155,11 +155,11 @@ void mb_cpu_do_interrupt(CPUState *cs)
         case EXCP_MMU:
             env->regs[17] = env->pc;
 
-            env->sregs[SR_ESR] &= ~(1 << 12);
+            env->esr &= ~(1 << 12);
             /* Exception breaks branch + dslot sequence?  */
             if (env->iflags & D_FLAG) {
                 D(qemu_log("D_FLAG set at exception bimm=%d\n", env->bimm));
-                env->sregs[SR_ESR] |= 1 << 12 ;
+                env->esr |= 1 << 12 ;
                 env->sregs[SR_BTR] = env->btarget;
 
                 /* Reexecute the branch.  */
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 5bacd29663..f01cf9be64 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -78,7 +78,7 @@ void helper_debug(CPUMBState *env)
     qemu_log("PC=%" PRIx64 "\n", env->pc);
     qemu_log("rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
              "debug[%x] imm=%x iflags=%x\n",
-             env->msr, env->sregs[SR_ESR], env->ear,
+             env->msr, env->esr, env->ear,
              env->debug, env->imm, env->iflags);
     qemu_log("btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) eip=%d ie=%d\n",
              env->btaken, env->btarget,
@@ -138,7 +138,7 @@ static inline int div_prepare(CPUMBState *env, uint32_t a, uint32_t b)
         env->msr |= MSR_DZ;
 
         if ((env->msr & MSR_EE) && cpu->cfg.div_zero_exception) {
-            env->sregs[SR_ESR] = ESR_EC_DIVZERO;
+            env->esr = ESR_EC_DIVZERO;
             helper_raise_exception(env, EXCP_HW_EXCP);
         }
         return 0;
@@ -166,7 +166,7 @@ uint32_t helper_divu(CPUMBState *env, uint32_t a, uint32_t b)
 /* raise FPU exception.  */
 static void raise_fpu_exception(CPUMBState *env)
 {
-    env->sregs[SR_ESR] = ESR_EC_FPU;
+    env->esr = ESR_EC_FPU;
     helper_raise_exception(env, EXCP_HW_EXCP);
 }
 
@@ -432,10 +432,9 @@ void helper_memalign(CPUMBState *env, target_ulong addr,
                           " mask=%x, wr=%d dr=r%d\n",
                           addr, mask, wr, dr);
             env->ear = addr;
-            env->sregs[SR_ESR] = ESR_EC_UNALIGNED_DATA | (wr << 10) \
-                                 | (dr & 31) << 5;
+            env->esr = ESR_EC_UNALIGNED_DATA | (wr << 10) | (dr & 31) << 5;
             if (mask == 3) {
-                env->sregs[SR_ESR] |= 1 << 11;
+                env->esr |= 1 << 11;
             }
             if (!(env->msr & MSR_EE)) {
                 return;
@@ -451,7 +450,7 @@ void helper_stackprot(CPUMBState *env, target_ulong addr)
                       TARGET_FMT_lx " %x %x\n",
                       addr, env->slr, env->shr);
         env->ear = addr;
-        env->sregs[SR_ESR] = ESR_EC_STACKPROT;
+        env->esr = ESR_EC_STACKPROT;
         helper_raise_exception(env, EXCP_HW_EXCP);
     }
 }
@@ -491,12 +490,12 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
     env->ear = addr;
     if (access_type == MMU_INST_FETCH) {
         if ((env->pvr.regs[2] & PVR2_IOPB_BUS_EXC_MASK)) {
-            env->sregs[SR_ESR] = ESR_EC_INSN_BUS;
+            env->esr = ESR_EC_INSN_BUS;
             helper_raise_exception(env, EXCP_HW_EXCP);
         }
     } else {
         if ((env->pvr.regs[2] & PVR2_DOPB_BUS_EXC_MASK)) {
-            env->sregs[SR_ESR] = ESR_EC_DATA_BUS;
+            env->esr = ESR_EC_DATA_BUS;
             helper_raise_exception(env, EXCP_HW_EXCP);
         }
     }
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 62747b02f3..411c7b6e49 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1809,7 +1809,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
                  "debug=%x imm=%x iflags=%x fsr=%" PRIx64 " "
                  "rbtr=%" PRIx64 "\n",
-                 env->msr, env->sregs[SR_ESR], env->ear,
+                 env->msr, env->esr, env->ear,
                  env->debug, env->imm, env->iflags, env->sregs[SR_FSR],
                  env->sregs[SR_BTR]);
     qemu_fprintf(f, "btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) "
@@ -1875,8 +1875,10 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, msr), "rmsr");
     cpu_SR[SR_EAR] =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear), "rear");
+    cpu_SR[SR_ESR] =
+        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, esr), "resr");
 
-    for (i = SR_EAR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
+    for (i = SR_ESR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
         cpu_SR[i] = tcg_global_mem_new_i64(cpu_env,
                           offsetof(CPUMBState, sregs[i]),
                           special_regnames[i]);
-- 
2.25.1


