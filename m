Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBF1C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F90C2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PhYOaq9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F90C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfIE-0008D1-Kp
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEP-0008Qo-Fy
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:53 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:39123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEM-00055G-U4
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:53 -0400
Received: by mail-pg1-x532.google.com with SMTP id v15so525174pgh.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rsRB0RZxqoK3N2gzIw0qX54Gonb1t6EonRXZar2I/Yw=;
 b=PhYOaq9ic4t6FfOsgbpqYi4JtEXHu0j9JJLixfBVNWTgp3Paun0+8Gjwb18EdyK3sC
 rhnLUdaWtSLRMXAiVf2JWOCFnAWEni6HHrGSKlDp2E9XAvYiPzbCPC+8/YqBoS+n6XkE
 LCpUlh5dKDs6C3xkUwzJmGv0tsktQDxLYyG6kzC+cYZjvNjNnLAZoretcIU4Ni+re5rj
 nlfTGGj5Zi/UuNdahzZEtALDrr/eft11bBql41nGUVWi/XUXfmhfGnFBRREbnqCxOp5f
 3lBXCaicTOv8RvZ4HlTTH3xwYd2CLUq51dzdxK4oRT0ASmDlB7IAY4lKTs2BORzkgvRC
 DzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rsRB0RZxqoK3N2gzIw0qX54Gonb1t6EonRXZar2I/Yw=;
 b=tJTZm+pAjj0Wz1HHmCpUHUgQcHNoZgPn7L7aenRMby8QJyz1DYz3YcEIxHasHplghZ
 dKaxlEZJOR2CTLQNuJlMTEnU4JR5yVt4nFomEhIwhzVUFidGf5TZAKarTMBWnsdUGqIJ
 My0wdsrjc0vIW2Pd2gPGK3ImoZFwKfPPLpzLMZOR7rvUf8Bs6Kn7gIoiI6JrEZqLHQ3J
 d0Igk20re+Glhs/kfsVA5LRt/8Pahz2ijJEQmhaSDF1/hxg29qF+cu6QQpTLIc0ODV3W
 fJbnfje1tv5S8a4te6HOmuVYC/RvCahy+7s9uBojk6idJm5AHn4s8BKpWxkdyFfXkTbh
 XIew==
X-Gm-Message-State: AOAM5310YkdxzlirNNjavy/EUkqPfHcJ25Ih1L5eevODrM7vQIaY3R3A
 V4kqtvZSVwVTq7sLEZQOwnDP90ctuXKDfw==
X-Google-Smtp-Source: ABdhPJyD1bmH57SBByK8Lzlb5ynhx2PTka+WunzreiaWhI4HtVcKEsojzeU4+lris/teB8l0N950Vg==
X-Received: by 2002:a63:3841:: with SMTP id h1mr1367909pgn.38.1598624388838;
 Fri, 28 Aug 2020 07:19:48 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/76] target/microblaze: Fix width of PC and BTARGET
Date: Fri, 28 Aug 2020 07:18:26 -0700
Message-Id: <20200828141929.77854-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

The program counter is only 32-bits wide.  Do not use a 64-bit
type to represent it.  Since they are so closely related, fix
btarget at the same time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  4 +-
 target/microblaze/helper.c    | 16 +++----
 target/microblaze/mmu.c       |  4 +-
 target/microblaze/op_helper.c |  4 +-
 target/microblaze/translate.c | 78 ++++++++++++++---------------------
 5 files changed, 43 insertions(+), 63 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 610ddfb719..f4c3c09b09 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -231,12 +231,12 @@ typedef struct CPUMBState CPUMBState;
 struct CPUMBState {
     uint32_t debug;
     uint32_t btaken;
-    uint64_t btarget;
+    uint32_t btarget;
     uint32_t bimm;
 
     uint32_t imm;
     uint32_t regs[32];
-    uint64_t pc;
+    uint32_t pc;
     uint64_t msr;
     uint64_t ear;
     uint64_t esr;
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index b240dc76f6..b95617a81a 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -143,7 +143,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
             env->msr |= MSR_EIP;
 
             qemu_log_mask(CPU_LOG_INT,
-                          "hw exception at pc=%" PRIx64 " ear=%" PRIx64 " "
+                          "hw exception at pc=%x ear=%" PRIx64 " "
                           "esr=%" PRIx64 " iflags=%x\n",
                           env->pc, env->ear,
                           env->esr, env->iflags);
@@ -167,8 +167,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
                 /* was the branch immprefixed?.  */
                 if (env->bimm) {
                     qemu_log_mask(CPU_LOG_INT,
-                                  "bimm exception at pc=%" PRIx64 " "
-                                  "iflags=%x\n",
+                                  "bimm exception at pc=%x iflags=%x\n",
                                   env->pc, env->iflags);
                     env->regs[17] -= 4;
                     log_cpu_state_mask(CPU_LOG_INT, cs, 0);
@@ -186,8 +185,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
             env->msr |= MSR_EIP;
 
             qemu_log_mask(CPU_LOG_INT,
-                          "exception at pc=%" PRIx64 " ear=%" PRIx64 " "
-                          "iflags=%x\n",
+                          "exception at pc=%x ear=%" PRIx64 " iflags=%x\n",
                           env->pc, env->ear, env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
             env->iflags &= ~(IMM_FLAG | D_FLAG);
@@ -224,8 +222,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
             }
 #endif
             qemu_log_mask(CPU_LOG_INT,
-                         "interrupt at pc=%" PRIx64 " msr=%" PRIx64 " %x "
-                         "iflags=%x\n",
+                         "interrupt at pc=%x msr=%" PRIx64 " %x iflags=%x\n",
                          env->pc, env->msr, t, env->iflags);
 
             env->msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM | MSR_IE);
@@ -242,9 +239,8 @@ void mb_cpu_do_interrupt(CPUState *cs)
             assert(!(env->iflags & D_FLAG));
             t = (env->msr & (MSR_VM | MSR_UM)) << 1;
             qemu_log_mask(CPU_LOG_INT,
-                        "break at pc=%" PRIx64 " msr=%" PRIx64 " %x "
-                        "iflags=%x\n",
-                        env->pc, env->msr, t, env->iflags);
+                          "break at pc=%x msr=%" PRIx64 " %x iflags=%x\n",
+                          env->pc, env->msr, t, env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
             env->msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
             env->msr |= t;
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 3f403b567b..6e583d78d9 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -250,8 +250,8 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
             if (rn == MMU_R_TLBHI) {
                 if (i < 3 && !(v & TLB_VALID) && qemu_loglevel_mask(~0))
                     qemu_log_mask(LOG_GUEST_ERROR,
-                             "invalidating index %x at pc=%" PRIx64 "\n",
-                             i, env->pc);
+                                  "invalidating index %x at pc=%x\n",
+                                  i, env->pc);
                 env->mmu.tids[i] = env->mmu.regs[MMU_R_PID] & 0xff;
                 mmu_flush_idx(env, i);
             }
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index ae57d45536..fdf706a723 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -75,12 +75,12 @@ void helper_debug(CPUMBState *env)
 {
     int i;
 
-    qemu_log("PC=%" PRIx64 "\n", env->pc);
+    qemu_log("PC=%08x\n", env->pc);
     qemu_log("rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
              "debug[%x] imm=%x iflags=%x\n",
              env->msr, env->esr, env->ear,
              env->debug, env->imm, env->iflags);
-    qemu_log("btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) eip=%d ie=%d\n",
+    qemu_log("btaken=%d btarget=%x mode=%s(saved=%s) eip=%d ie=%d\n",
              env->btaken, env->btarget,
              (env->msr & MSR_UM) ? "user" : "kernel",
              (env->msr & MSR_UMS) ? "user" : "kernel",
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 19d7b8abfd..72783c1d8a 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -55,7 +55,7 @@
 
 static TCGv_i32 env_debug;
 static TCGv_i32 cpu_R[32];
-static TCGv_i64 cpu_pc;
+static TCGv_i32 cpu_pc;
 static TCGv_i64 cpu_msr;
 static TCGv_i64 cpu_ear;
 static TCGv_i64 cpu_esr;
@@ -64,7 +64,7 @@ static TCGv_i64 cpu_btr;
 static TCGv_i64 cpu_edr;
 static TCGv_i32 env_imm;
 static TCGv_i32 env_btaken;
-static TCGv_i64 env_btarget;
+static TCGv_i32 cpu_btarget;
 static TCGv_i32 env_iflags;
 static TCGv env_res_addr;
 static TCGv_i32 env_res_val;
@@ -123,7 +123,7 @@ static inline void t_gen_raise_exception(DisasContext *dc, uint32_t index)
     TCGv_i32 tmp = tcg_const_i32(index);
 
     t_sync_flags(dc);
-    tcg_gen_movi_i64(cpu_pc, dc->pc);
+    tcg_gen_movi_i32(cpu_pc, dc->pc);
     gen_helper_raise_exception(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
     dc->is_jmp = DISAS_UPDATE;
@@ -142,10 +142,10 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
 {
     if (use_goto_tb(dc, dest)) {
         tcg_gen_goto_tb(n);
-        tcg_gen_movi_i64(cpu_pc, dest);
+        tcg_gen_movi_i32(cpu_pc, dest);
         tcg_gen_exit_tb(dc->tb, n);
     } else {
-        tcg_gen_movi_i64(cpu_pc, dest);
+        tcg_gen_movi_i32(cpu_pc, dest);
         tcg_gen_exit_tb(NULL, 0);
     }
 }
@@ -509,7 +509,7 @@ static void dec_msr(DisasContext *dc)
         msr_write(dc, t0);
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
-        tcg_gen_movi_i64(cpu_pc, dc->pc + 4);
+        tcg_gen_movi_i32(cpu_pc, dc->pc + 4);
         dc->is_jmp = DISAS_UPDATE;
         return;
     }
@@ -850,7 +850,7 @@ static inline void sync_jmpstate(DisasContext *dc)
             tcg_gen_movi_i32(env_btaken, 1);
         }
         dc->jmp = JMP_INDIRECT;
-        tcg_gen_movi_i64(env_btarget, dc->jmp_pc);
+        tcg_gen_movi_i32(cpu_btarget, dc->jmp_pc);
     }
 }
 
@@ -1019,7 +1019,7 @@ static void dec_load(DisasContext *dc)
         TCGv_i32 treg = tcg_const_i32(dc->rd);
         TCGv_i32 tsize = tcg_const_i32(size - 1);
 
-        tcg_gen_movi_i64(cpu_pc, dc->pc);
+        tcg_gen_movi_i32(cpu_pc, dc->pc);
         gen_helper_memalign(cpu_env, addr, treg, t0, tsize);
 
         tcg_temp_free_i32(t0);
@@ -1139,7 +1139,7 @@ static void dec_store(DisasContext *dc)
         TCGv_i32 treg = tcg_const_i32(dc->rd);
         TCGv_i32 tsize = tcg_const_i32(size - 1);
 
-        tcg_gen_movi_i64(cpu_pc, dc->pc);
+        tcg_gen_movi_i32(cpu_pc, dc->pc);
         /* FIXME: if the alignment is wrong, we should restore the value
          *        in memory. One possible way to achieve this is to probe
          *        the MMU prior to the memaccess, thay way we could put
@@ -1187,18 +1187,15 @@ static inline void eval_cc(DisasContext *dc, unsigned int cc,
     }
 }
 
-static void eval_cond_jmp(DisasContext *dc, TCGv_i64 pc_true, TCGv_i64 pc_false)
+static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
 {
-    TCGv_i64 tmp_btaken = tcg_temp_new_i64();
-    TCGv_i64 tmp_zero = tcg_const_i64(0);
+    TCGv_i32 zero = tcg_const_i32(0);
 
-    tcg_gen_extu_i32_i64(tmp_btaken, env_btaken);
-    tcg_gen_movcond_i64(TCG_COND_NE, cpu_pc,
-                        tmp_btaken, tmp_zero,
+    tcg_gen_movcond_i32(TCG_COND_NE, cpu_pc,
+                        env_btaken, zero,
                         pc_true, pc_false);
 
-    tcg_temp_free_i64(tmp_btaken);
-    tcg_temp_free_i64(tmp_zero);
+    tcg_temp_free_i32(zero);
 }
 
 static void dec_setup_dslot(DisasContext *dc)
@@ -1229,14 +1226,12 @@ static void dec_bcc(DisasContext *dc)
     if (dec_alu_op_b_is_small_imm(dc)) {
         int32_t offset = (int32_t)((int16_t)dc->imm); /* sign-extend.  */
 
-        tcg_gen_movi_i64(env_btarget, dc->pc + offset);
+        tcg_gen_movi_i32(cpu_btarget, dc->pc + offset);
         dc->jmp = JMP_DIRECT_CC;
         dc->jmp_pc = dc->pc + offset;
     } else {
         dc->jmp = JMP_INDIRECT;
-        tcg_gen_extu_i32_i64(env_btarget, *(dec_alu_op_b(dc)));
-        tcg_gen_addi_i64(env_btarget, env_btarget, dc->pc);
-        tcg_gen_andi_i64(env_btarget, env_btarget, UINT32_MAX);
+        tcg_gen_addi_i32(cpu_btarget, *dec_alu_op_b(dc), dc->pc);
     }
     eval_cc(dc, cc, env_btaken, cpu_R[dc->ra]);
 }
@@ -1277,7 +1272,7 @@ static void dec_br(DisasContext *dc)
             tcg_gen_st_i32(tmp_1, cpu_env,
                            -offsetof(MicroBlazeCPU, env)
                            +offsetof(CPUState, halted));
-            tcg_gen_movi_i64(cpu_pc, dc->pc + 4);
+            tcg_gen_movi_i32(cpu_pc, dc->pc + 4);
             gen_helper_raise_exception(cpu_env, tmp_hlt);
             tcg_temp_free_i32(tmp_hlt);
             tcg_temp_free_i32(tmp_1);
@@ -1303,7 +1298,7 @@ static void dec_br(DisasContext *dc)
     dc->jmp = JMP_INDIRECT;
     if (abs) {
         tcg_gen_movi_i32(env_btaken, 1);
-        tcg_gen_extu_i32_i64(env_btarget, *(dec_alu_op_b(dc)));
+        tcg_gen_mov_i32(cpu_btarget, *(dec_alu_op_b(dc)));
         if (link && !dslot) {
             if (!(dc->tb_flags & IMM_FLAG) && (dc->imm == 8 || dc->imm == 0x18))
                 t_gen_raise_exception(dc, EXCP_BREAK);
@@ -1321,9 +1316,7 @@ static void dec_br(DisasContext *dc)
             dc->jmp_pc = dc->pc + (int32_t)((int16_t)dc->imm);
         } else {
             tcg_gen_movi_i32(env_btaken, 1);
-            tcg_gen_extu_i32_i64(env_btarget, *(dec_alu_op_b(dc)));
-            tcg_gen_addi_i64(env_btarget, env_btarget, dc->pc);
-            tcg_gen_andi_i64(env_btarget, env_btarget, UINT32_MAX);
+            tcg_gen_addi_i32(cpu_btarget, *dec_alu_op_b(dc), dc->pc);
         }
     }
 }
@@ -1387,7 +1380,6 @@ static inline void do_rte(DisasContext *dc)
 static void dec_rts(DisasContext *dc)
 {
     unsigned int b_bit, i_bit, e_bit;
-    TCGv_i64 tmp64;
 
     i_bit = dc->ir & (1 << 21);
     b_bit = dc->ir & (1 << 22);
@@ -1413,13 +1405,7 @@ static void dec_rts(DisasContext *dc)
 
     dc->jmp = JMP_INDIRECT;
     tcg_gen_movi_i32(env_btaken, 1);
-
-    tmp64 = tcg_temp_new_i64();
-    tcg_gen_extu_i32_i64(env_btarget, *(dec_alu_op_b(dc)));
-    tcg_gen_extu_i32_i64(tmp64, cpu_R[dc->ra]);
-    tcg_gen_add_i64(env_btarget, env_btarget, tmp64);
-    tcg_gen_andi_i64(env_btarget, env_btarget, UINT32_MAX);
-    tcg_temp_free_i64(tmp64);
+    tcg_gen_add_i32(cpu_btarget, cpu_R[dc->ra], *dec_alu_op_b(dc));
 }
 
 static int dec_check_fpuv2(DisasContext *dc)
@@ -1676,7 +1662,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 
 #if SIM_COMPAT
         if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)) {
-            tcg_gen_movi_i64(cpu_pc, dc->pc);
+            tcg_gen_movi_i32(cpu_pc, dc->pc);
             gen_helper_debug();
         }
 #endif
@@ -1718,10 +1704,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
                 dc->tb_flags &= ~D_FLAG;
                 /* If it is a direct jump, try direct chaining.  */
                 if (dc->jmp == JMP_INDIRECT) {
-                    TCGv_i64 tmp_pc = tcg_const_i64(dc->pc);
-                    eval_cond_jmp(dc, env_btarget, tmp_pc);
-                    tcg_temp_free_i64(tmp_pc);
-
+                    TCGv_i32 tmp_pc = tcg_const_i32(dc->pc);
+                    eval_cond_jmp(dc, cpu_btarget, tmp_pc);
+                    tcg_temp_free_i32(tmp_pc);
                     dc->is_jmp = DISAS_JUMP;
                 } else if (dc->jmp == JMP_DIRECT) {
                     t_sync_flags(dc);
@@ -1754,7 +1739,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     if (dc->jmp == JMP_DIRECT || dc->jmp == JMP_DIRECT_CC) {
         if (dc->tb_flags & D_FLAG) {
             dc->is_jmp = DISAS_UPDATE;
-            tcg_gen_movi_i64(cpu_pc, npc);
+            tcg_gen_movi_i32(cpu_pc, npc);
             sync_jmpstate(dc);
         } else
             npc = dc->jmp_pc;
@@ -1764,7 +1749,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     if (dc->is_jmp == DISAS_NEXT
         && (dc->cpustate_changed || org_flags != dc->tb_flags)) {
         dc->is_jmp = DISAS_UPDATE;
-        tcg_gen_movi_i64(cpu_pc, npc);
+        tcg_gen_movi_i32(cpu_pc, npc);
     }
     t_sync_flags(dc);
 
@@ -1772,7 +1757,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
         TCGv_i32 tmp = tcg_const_i32(EXCP_DEBUG);
 
         if (dc->is_jmp != DISAS_JUMP) {
-            tcg_gen_movi_i64(cpu_pc, npc);
+            tcg_gen_movi_i32(cpu_pc, npc);
         }
         gen_helper_raise_exception(cpu_env, tmp);
         tcg_temp_free_i32(tmp);
@@ -1822,7 +1807,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         return;
     }
 
-    qemu_fprintf(f, "IN: PC=%" PRIx64 " %s\n",
+    qemu_fprintf(f, "IN: PC=%x %s\n",
                  env->pc, lookup_symbol(env->pc));
     qemu_fprintf(f, "rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
                  "debug=%x imm=%x iflags=%x fsr=%" PRIx64 " "
@@ -1830,8 +1815,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                  env->msr, env->esr, env->ear,
                  env->debug, env->imm, env->iflags, env->fsr,
                  env->btr);
-    qemu_fprintf(f, "btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) "
-                 "eip=%d ie=%d\n",
+    qemu_fprintf(f, "btaken=%d btarget=%x mode=%s(saved=%s) eip=%d ie=%d\n",
                  env->btaken, env->btarget,
                  (env->msr & MSR_UM) ? "user" : "kernel",
                  (env->msr & MSR_UMS) ? "user" : "kernel",
@@ -1869,7 +1853,7 @@ void mb_tcg_init(void)
     env_imm = tcg_global_mem_new_i32(cpu_env,
                     offsetof(CPUMBState, imm),
                     "imm");
-    env_btarget = tcg_global_mem_new_i64(cpu_env,
+    cpu_btarget = tcg_global_mem_new_i32(cpu_env,
                      offsetof(CPUMBState, btarget),
                      "btarget");
     env_btaken = tcg_global_mem_new_i32(cpu_env,
@@ -1888,7 +1872,7 @@ void mb_tcg_init(void)
     }
 
     cpu_pc =
-        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, pc), "rpc");
+        tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, pc), "rpc");
     cpu_msr =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, msr), "rmsr");
     cpu_ear =
-- 
2.25.1


