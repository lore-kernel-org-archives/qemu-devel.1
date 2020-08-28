Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A972C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121F221531
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ja3VBGZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121F221531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfXF-00056e-MP
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEi-0000mO-Pu
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:12 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:37150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEg-00057n-5B
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:12 -0400
Received: by mail-pf1-x42f.google.com with SMTP id x143so741728pfc.4
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kv9Q2CNP0xNdIj9IWSGlA1oMnFfXI9CS46hFWNSGG9w=;
 b=ja3VBGZiZN6wLe3q3D2MgdvHPXkhLGcQC3GQsMQ7lPzls3KSuzNYUtNV8/mTa7ei6N
 yRQGnx66bzzWJEDt/weKilCSAaQ3WdgcxFTst62WxctkrH0mohfBHzgUZhMGsqd94Zxp
 KewEzWoJ3zm2JByuFy3SuAQR3NONKuuAsLY0ElW3nuZgWNj/XD6HSyol2iJfnEArnLBX
 4W9eYBmPfHgz5leeXHXR+KaEWF7ODp2U69/AydoW62vVfi7RfhMnTWVg+m8prn7xxyOv
 jUZ+nvzx05UpTzwo6cM+Sbfblr/ePrUPxauOo2cesae6CBzj+M+H0QiLq8Db3s6CrY3C
 Q+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kv9Q2CNP0xNdIj9IWSGlA1oMnFfXI9CS46hFWNSGG9w=;
 b=iUAVfahEZL1jh2dK4wcLVIphknUCcwzWA/9rJH7bUC7W1IxhgATfUOQUplCwY4KdlB
 FWMD0xa2Wc2g0diHxL+aZYIRg6CNj3r/EB69eyHZo+NFQT+53Fwo/6WRj9AFA0O5gHc/
 F0f7W9pFHiKhPS3txxJFJPKunEF97gOPsoL5VUgv60861xdPfYsD6i8gq7ObiWeN5UDV
 crrBM3RIECEd1ixVP0eLcPlnXj1ovZ0LTt+VIGns71AeVwcv/N0leqEheuNTzpVuLCjv
 mZmJnkGDmI8r5l0V6uEZ8t81lUraPYrMISJb0p8U+mwiVd+Q/3vVz6lWEjSnRZ/Jau0Z
 YAxw==
X-Gm-Message-State: AOAM532uTji42T0Ng2GAjkNIIgJaXI1TSCRb/rpCkDxnGQcuRqZEYVna
 xQQ1WK7na9aP5Zagj7g7VI07wA4Ry49oQQ==
X-Google-Smtp-Source: ABdhPJyC0ozkybcM/1EKh2gB6DkuOB0xwSyXCMscUDhbYscEp1rQ9mCkjmkkijzHC3lP1vwTzHdkRA==
X-Received: by 2002:aa7:8c42:: with SMTP id e2mr1452633pfd.181.1598624408177; 
 Fri, 28 Aug 2020 07:20:08 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 28/76] target/microblaze: Convert to DisasContextBase
Date: Fri, 28 Aug 2020 07:18:41 -0700
Message-Id: <20200828141929.77854-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Part one of conversion to the generic translator_loop is to
use the DisasContextBase and the members therein.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 104 +++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 7d5b96c38b..45b1555f85 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -67,8 +67,8 @@ static TCGv_i32 cpu_res_val;
 
 /* This is the state at translation time.  */
 typedef struct DisasContext {
+    DisasContextBase base;
     MicroBlazeCPU *cpu;
-    uint32_t pc;
 
     /* Decoder.  */
     int type_b;
@@ -81,7 +81,6 @@ typedef struct DisasContext {
     unsigned int delayed_branch;
     unsigned int tb_flags, synced_flags; /* tb dependent flags.  */
     unsigned int clear_imm;
-    int is_jmp;
 
 #define JMP_NOJMP     0
 #define JMP_DIRECT    1
@@ -91,8 +90,6 @@ typedef struct DisasContext {
     uint32_t jmp_pc;
 
     int abort_at_next_insn;
-    struct TranslationBlock *tb;
-    int singlestep_enabled;
 } DisasContext;
 
 static inline void t_sync_flags(DisasContext *dc)
@@ -110,13 +107,13 @@ static void gen_raise_exception(DisasContext *dc, uint32_t index)
 
     gen_helper_raise_exception(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
-    dc->is_jmp = DISAS_NORETURN;
+    dc->base.is_jmp = DISAS_NORETURN;
 }
 
 static void gen_raise_exception_sync(DisasContext *dc, uint32_t index)
 {
     t_sync_flags(dc);
-    tcg_gen_movi_i32(cpu_pc, dc->pc);
+    tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
     gen_raise_exception(dc, index);
 }
 
@@ -132,7 +129,7 @@ static void gen_raise_hw_excp(DisasContext *dc, uint32_t esr_ec)
 static inline bool use_goto_tb(DisasContext *dc, target_ulong dest)
 {
 #ifndef CONFIG_USER_ONLY
-    return (dc->tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
+    return (dc->base.pc_first & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
 #else
     return true;
 #endif
@@ -140,20 +137,20 @@ static inline bool use_goto_tb(DisasContext *dc, target_ulong dest)
 
 static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
 {
-    if (dc->singlestep_enabled) {
+    if (dc->base.singlestep_enabled) {
         TCGv_i32 tmp = tcg_const_i32(EXCP_DEBUG);
-        tcg_gen_movi_i64(cpu_SR[SR_PC], dest);
+        tcg_gen_movi_i32(cpu_pc, dest);
         gen_helper_raise_exception(cpu_env, tmp);
         tcg_temp_free_i32(tmp);
     } else if (use_goto_tb(dc, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_exit_tb(dc->tb, n);
+        tcg_gen_exit_tb(dc->base.tb, n);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
         tcg_gen_exit_tb(NULL, 0);
     }
-    dc->is_jmp = DISAS_NORETURN;
+    dc->base.is_jmp = DISAS_NORETURN;
 }
 
 /*
@@ -468,8 +465,8 @@ static void dec_msr(DisasContext *dc)
         msr_write(dc, t0);
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
-        tcg_gen_movi_i32(cpu_pc, dc->pc + 4);
-        dc->is_jmp = DISAS_UPDATE;
+        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next + 4);
+        dc->base.is_jmp = DISAS_UPDATE;
         return;
     }
 
@@ -546,7 +543,7 @@ static void dec_msr(DisasContext *dc)
 
         switch (sr) {
             case SR_PC:
-                tcg_gen_movi_i32(cpu_R[dc->rd], dc->pc);
+                tcg_gen_movi_i32(cpu_R[dc->rd], dc->base.pc_next);
                 break;
             case SR_MSR:
                 msr_read(dc, cpu_R[dc->rd]);
@@ -813,7 +810,7 @@ static void dec_bit(DisasContext *dc)
             break;
         default:
             cpu_abort(cs, "unknown bit oc=%x op=%x rd=%d ra=%d rb=%d\n",
-                      dc->pc, op, dc->rd, dc->ra, dc->rb);
+                      (uint32_t)dc->base.pc_next, op, dc->rd, dc->ra, dc->rb);
             break;
     }
 }
@@ -994,7 +991,7 @@ static void dec_load(DisasContext *dc)
         TCGv_i32 treg = tcg_const_i32(dc->rd);
         TCGv_i32 tsize = tcg_const_i32(size - 1);
 
-        tcg_gen_movi_i32(cpu_pc, dc->pc);
+        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
         gen_helper_memalign(cpu_env, addr, treg, t0, tsize);
 
         tcg_temp_free_i32(t0);
@@ -1114,7 +1111,7 @@ static void dec_store(DisasContext *dc)
         TCGv_i32 treg = tcg_const_i32(dc->rd);
         TCGv_i32 tsize = tcg_const_i32(size - 1);
 
-        tcg_gen_movi_i32(cpu_pc, dc->pc);
+        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
         /* FIXME: if the alignment is wrong, we should restore the value
          *        in memory. One possible way to achieve this is to probe
          *        the MMU prior to the memaccess, thay way we could put
@@ -1201,12 +1198,12 @@ static void dec_bcc(DisasContext *dc)
     if (dec_alu_op_b_is_small_imm(dc)) {
         int32_t offset = (int32_t)((int16_t)dc->imm); /* sign-extend.  */
 
-        tcg_gen_movi_i32(cpu_btarget, dc->pc + offset);
+        tcg_gen_movi_i32(cpu_btarget, dc->base.pc_next + offset);
         dc->jmp = JMP_DIRECT_CC;
-        dc->jmp_pc = dc->pc + offset;
+        dc->jmp_pc = dc->base.pc_next + offset;
     } else {
         dc->jmp = JMP_INDIRECT;
-        tcg_gen_addi_i32(cpu_btarget, *dec_alu_op_b(dc), dc->pc);
+        tcg_gen_addi_i32(cpu_btarget, *dec_alu_op_b(dc), dc->base.pc_next);
     }
     eval_cc(dc, cc, cpu_btaken, cpu_R[dc->ra]);
 }
@@ -1250,7 +1247,7 @@ static void dec_br(DisasContext *dc)
                            +offsetof(CPUState, halted));
             tcg_temp_free_i32(tmp_1);
 
-            tcg_gen_movi_i32(cpu_pc, dc->pc + 4);
+            tcg_gen_movi_i32(cpu_pc, dc->base.pc_next + 4);
 
             gen_raise_exception(dc, EXCP_HLT);
             return;
@@ -1270,7 +1267,7 @@ static void dec_br(DisasContext *dc)
         dec_setup_dslot(dc);
     }
     if (link && dc->rd)
-        tcg_gen_movi_i32(cpu_R[dc->rd], dc->pc);
+        tcg_gen_movi_i32(cpu_R[dc->rd], dc->base.pc_next);
 
     dc->jmp = JMP_INDIRECT;
     if (abs) {
@@ -1291,10 +1288,10 @@ static void dec_br(DisasContext *dc)
     } else {
         if (dec_alu_op_b_is_small_imm(dc)) {
             dc->jmp = JMP_DIRECT;
-            dc->jmp_pc = dc->pc + (int32_t)((int16_t)dc->imm);
+            dc->jmp_pc = dc->base.pc_next + (int32_t)((int16_t)dc->imm);
         } else {
             tcg_gen_movi_i32(cpu_btaken, 1);
-            tcg_gen_addi_i32(cpu_btarget, *dec_alu_op_b(dc), dc->pc);
+            tcg_gen_addi_i32(cpu_btarget, *dec_alu_op_b(dc), dc->base.pc_next);
         }
     }
 }
@@ -1459,7 +1456,8 @@ static void dec_fpu(DisasContext *dc)
                     qemu_log_mask(LOG_UNIMP,
                                   "unimplemented fcmp fpu_insn=%x pc=%x"
                                   " opc=%x\n",
-                                  fpu_insn, dc->pc, dc->opcode);
+                                  fpu_insn, (uint32_t)dc->base.pc_next,
+                                  dc->opcode);
                     dc->abort_at_next_insn = 1;
                     break;
             }
@@ -1489,7 +1487,7 @@ static void dec_fpu(DisasContext *dc)
         default:
             qemu_log_mask(LOG_UNIMP, "unimplemented FPU insn fpu_insn=%x pc=%x"
                           " opc=%x\n",
-                          fpu_insn, dc->pc, dc->opcode);
+                          fpu_insn, (uint32_t)dc->base.pc_next, dc->opcode);
             dc->abort_at_next_insn = 1;
             break;
     }
@@ -1500,7 +1498,8 @@ static void dec_null(DisasContext *dc)
     if (trap_illegal(dc, true)) {
         return;
     }
-    qemu_log_mask(LOG_GUEST_ERROR, "unknown insn pc=%x opc=%x\n", dc->pc, dc->opcode);
+    qemu_log_mask(LOG_GUEST_ERROR, "unknown insn pc=%x opc=%x\n",
+                  (uint32_t)dc->base.pc_next, dc->opcode);
     dc->abort_at_next_insn = 1;
 }
 
@@ -1610,19 +1609,20 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 
     pc_start = tb->pc;
     dc->cpu = cpu;
-    dc->tb = tb;
     org_flags = dc->synced_flags = dc->tb_flags = tb->flags;
 
-    dc->is_jmp = DISAS_NEXT;
     dc->jmp = 0;
     dc->delayed_branch = !!(dc->tb_flags & D_FLAG);
     if (dc->delayed_branch) {
         dc->jmp = JMP_INDIRECT;
     }
-    dc->pc = pc_start;
-    dc->singlestep_enabled = cs->singlestep_enabled;
+    dc->base.pc_first = pc_start;
+    dc->base.pc_next = pc_start;
+    dc->base.singlestep_enabled = cs->singlestep_enabled;
     dc->cpustate_changed = 0;
     dc->abort_at_next_insn = 0;
+    dc->base.is_jmp = DISAS_NEXT;
+    dc->base.tb = tb;
 
     if (pc_start & 3) {
         cpu_abort(cs, "Microblaze: unaligned PC=%x\n", pc_start);
@@ -1634,31 +1634,31 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     gen_tb_start(tb);
     do
     {
-        tcg_gen_insn_start(dc->pc);
+        tcg_gen_insn_start(dc->base.pc_next);
         num_insns++;
 
-        if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cs, dc->base.pc_next, BP_ANY))) {
             gen_raise_exception_sync(dc, EXCP_DEBUG);
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
                the logic setting tb->size below does the right thing.  */
-            dc->pc += 4;
+            dc->base.pc_next += 4;
             break;
         }
 
         /* Pretty disas.  */
-        LOG_DIS("%8.8x:\t", dc->pc);
+        LOG_DIS("%8.8x:\t", (uint32_t)dc->base.pc_next);
 
         if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
         dc->clear_imm = 1;
-        decode(dc, cpu_ldl_code(env, dc->pc));
+        decode(dc, cpu_ldl_code(env, dc->base.pc_next));
         if (dc->clear_imm)
             dc->tb_flags &= ~IMM_FLAG;
-        dc->pc += 4;
+        dc->base.pc_next += 4;
 
         if (dc->delayed_branch) {
             dc->delayed_branch--;
@@ -1673,10 +1673,10 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
                 dc->tb_flags &= ~D_FLAG;
                 /* If it is a direct jump, try direct chaining.  */
                 if (dc->jmp == JMP_INDIRECT) {
-                    TCGv_i32 tmp_pc = tcg_const_i32(dc->pc);
+                    TCGv_i32 tmp_pc = tcg_const_i32(dc->base.pc_next);
                     eval_cond_jmp(dc, cpu_btarget, tmp_pc);
                     tcg_temp_free_i32(tmp_pc);
-                    dc->is_jmp = DISAS_JUMP;
+                    dc->base.is_jmp = DISAS_JUMP;
                 } else if (dc->jmp == JMP_DIRECT) {
                     t_sync_flags(dc);
                     gen_goto_tb(dc, 0, dc->jmp_pc);
@@ -1685,26 +1685,26 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
                     t_sync_flags(dc);
                     /* Conditional jmp.  */
                     tcg_gen_brcondi_i32(TCG_COND_NE, cpu_btaken, 0, l1);
-                    gen_goto_tb(dc, 1, dc->pc);
+                    gen_goto_tb(dc, 1, dc->base.pc_next);
                     gen_set_label(l1);
                     gen_goto_tb(dc, 0, dc->jmp_pc);
                 }
                 break;
             }
         }
-        if (cs->singlestep_enabled) {
+        if (dc->base.singlestep_enabled) {
             break;
         }
-    } while (!dc->is_jmp && !dc->cpustate_changed
+    } while (!dc->base.is_jmp && !dc->cpustate_changed
              && !tcg_op_buf_full()
              && !singlestep
-             && (dc->pc - page_start < TARGET_PAGE_SIZE)
+             && (dc->base.pc_next - page_start < TARGET_PAGE_SIZE)
              && num_insns < max_insns);
 
-    npc = dc->pc;
+    npc = dc->base.pc_next;
     if (dc->jmp == JMP_DIRECT || dc->jmp == JMP_DIRECT_CC) {
         if (dc->tb_flags & D_FLAG) {
-            dc->is_jmp = DISAS_UPDATE;
+            dc->base.is_jmp = DISAS_UPDATE;
             tcg_gen_movi_i32(cpu_pc, npc);
             sync_jmpstate(dc);
         } else
@@ -1712,25 +1712,25 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     }
 
     /* Force an update if the per-tb cpu state has changed.  */
-    if (dc->is_jmp == DISAS_NEXT
+    if (dc->base.is_jmp == DISAS_NEXT
         && (dc->cpustate_changed || org_flags != dc->tb_flags)) {
-        dc->is_jmp = DISAS_UPDATE;
+        dc->base.is_jmp = DISAS_UPDATE;
         tcg_gen_movi_i32(cpu_pc, npc);
     }
     t_sync_flags(dc);
 
-    if (dc->is_jmp == DISAS_NORETURN) {
+    if (dc->base.is_jmp == DISAS_NORETURN) {
         /* nothing more to generate */
     } else if (unlikely(cs->singlestep_enabled)) {
         TCGv_i32 tmp = tcg_const_i32(EXCP_DEBUG);
 
-        if (dc->is_jmp != DISAS_JUMP) {
+        if (dc->base.is_jmp != DISAS_JUMP) {
             tcg_gen_movi_i32(cpu_pc, npc);
         }
         gen_helper_raise_exception(cpu_env, tmp);
         tcg_temp_free_i32(tmp);
     } else {
-        switch(dc->is_jmp) {
+        switch (dc->base.is_jmp) {
             case DISAS_NEXT:
                 gen_goto_tb(dc, 1, npc);
                 break;
@@ -1746,7 +1746,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     }
     gen_tb_end(tb, num_insns);
 
-    tb->size = dc->pc - pc_start;
+    tb->size = dc->base.pc_next - pc_start;
     tb->icount = num_insns;
 
 #ifdef DEBUG_DISAS
@@ -1755,7 +1755,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
         && qemu_log_in_addr_range(pc_start)) {
         FILE *logfile = qemu_log_lock();
         qemu_log("--------------\n");
-        log_target_disas(cs, pc_start, dc->pc - pc_start);
+        log_target_disas(cs, pc_start, dc->base.pc_next - pc_start);
         qemu_log_unlock(logfile);
     }
 #endif
-- 
2.25.1


