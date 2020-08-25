Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F14BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C192071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KiQEVfCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C192071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAglR-0008Nh-6P
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4I-0000Z7-Qr
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:22 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4F-00022L-OH
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:22 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mt12so120996pjb.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zHtJR2PgLnYmwJnfF35UuanJnJx2PjTcBTvuZ0jGjNE=;
 b=KiQEVfCouKax1rSSdjEQx9KrexQT9SyEycflGMaClusSis7dIMsS4J7q7LTuNgArae
 GaJWFpnjJ9U/jIx6WLrIM9NXzsciTOxCUztFhtTSL7MUSYAvyRqPMNoQGB0l6o9Un7cT
 JrpHUmq9+ZwdD+I4uOOhMR1Kl2p8BZbgmx9zvRQ9+cPQsF9+Y3usSDjXsWMyxNat67OM
 4tlLaa61GzQXPP1pL5kS5c2oWemlyEoyjYIs/+Imp0rIx1RkyXHqPoNEydsUazkknNYl
 Ut0GEjcHSbwdcfvMnTEFic4NI/NjSDJ4WBZCuaiGUZGAU2xSQboLfjglXn+yGvqtao3m
 P4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zHtJR2PgLnYmwJnfF35UuanJnJx2PjTcBTvuZ0jGjNE=;
 b=UnenWT+aKPB/9Dk/z7kWTUO/9cCdg919Ees7LaKtFzpo3+I1sGobYnkN4quFtpLaX7
 J8G3NPa3KyJ0mXKApK6GHufCHTIK82531oshaipvG4p7cXrVr7SOwyxAdmudlXyHpg+H
 Vwijrt5vGRtMd/+uYEFzMcOVNN2W617Y7VqSC19tJoKdlX6+Eln1IO5ynSl8kl5TUqzI
 W7BWqc6vl6urg5FY3kz0SnAN6pnNmNyiH8GPbO4gDRQQmgAqoWP8N49kRimqc6p3NVbh
 touwCck0iKoDNM9BLe6d0hk7ZeMtiJeIOSA3oML6G1Cn2pxZcALGflUdC0s6frqtCWfy
 7BJQ==
X-Gm-Message-State: AOAM532lUFXy3v/3J5AY8OwTcVn4/Pm+r5xIYbCJtXsBNU6+7+hyuKLG
 W+TEXSGTztqeEnnjP7exbV2pJf0TG/qu/g==
X-Google-Smtp-Source: ABdhPJzbM8+/IcwY4LjAadraqi9KtPrrVfpWj6/RtqiTlsRpKe16U+3RhbxJCN6lzbZKCZ0KDhFwig==
X-Received: by 2002:a17:90a:644b:: with SMTP id
 y11mr3206329pjm.13.1598389277873; 
 Tue, 25 Aug 2020 14:01:17 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 65/77] target/microblaze: Reorganize branching
Date: Tue, 25 Aug 2020 13:59:38 -0700
Message-Id: <20200825205950.730499-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the btaken variable, and simplify things by always computing
the full branch destination into btarget.  This avoids all need for
sync_jmpstate().

Retain the direct branch behaviour by remembering the jump destination
in jmp_dest, discarding btarget.  In the normal case, where the branch
delay slot cannot trap (e.g. arithmetic not memory operation), tcg will
remove the computation into btarget, leaving us with just the tcg
direct branching at the end.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |   4 +-
 target/microblaze/translate.c | 192 ++++++++++++++--------------------
 2 files changed, 79 insertions(+), 117 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 1528749a0b..4298f242a6 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -234,8 +234,8 @@ typedef struct CPUMBState CPUMBState;
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
 struct CPUMBState {
-    uint32_t btaken;
-    uint32_t btarget;
+    uint32_t bvalue;   /* TCG temporary, only valid during a TB */
+    uint32_t btarget;  /* Full resolved branch destination */
 
     uint32_t imm;
     uint32_t regs[32];
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a391e80fb9..6f9b20d391 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -45,7 +45,7 @@ static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
 static TCGv_i32 cpu_msr_c;
 static TCGv_i32 cpu_imm;
-static TCGv_i32 cpu_btaken;
+static TCGv_i32 cpu_bvalue;
 static TCGv_i32 cpu_btarget;
 static TCGv_i32 cpu_iflags;
 static TCGv cpu_res_addr;
@@ -77,12 +77,11 @@ typedef struct DisasContext {
     unsigned int tb_flags_to_set;
     int mem_index;
 
-#define JMP_NOJMP     0
-#define JMP_DIRECT    1
-#define JMP_DIRECT_CC 2
-#define JMP_INDIRECT  3
-    unsigned int jmp;
-    uint32_t jmp_pc;
+    /* Condition under which to jump, including NEVER and ALWAYS. */
+    TCGCond jmp_cond;
+
+    /* Immediate branch-taken destination, or -1 for indirect. */
+    uint32_t jmp_dest;
 
     int abort_at_next_insn;
 } DisasContext;
@@ -106,17 +105,6 @@ static void t_sync_flags(DisasContext *dc)
     }
 }
 
-static inline void sync_jmpstate(DisasContext *dc)
-{
-    if (dc->jmp == JMP_DIRECT || dc->jmp == JMP_DIRECT_CC) {
-        if (dc->jmp == JMP_DIRECT) {
-            tcg_gen_movi_i32(cpu_btaken, 1);
-        }
-        dc->jmp = JMP_INDIRECT;
-        tcg_gen_movi_i32(cpu_btarget, dc->jmp_pc);
-    }
-}
-
 static void gen_raise_exception(DisasContext *dc, uint32_t index)
 {
     TCGv_i32 tmp = tcg_const_i32(index);
@@ -821,8 +809,6 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
         }
     }
 
-    sync_jmpstate(dc);
-
     if (size > MO_8 &&
         (dc->tb_flags & MSR_EE) &&
         dc->cpu->cfg.unaligned_exceptions) {
@@ -924,8 +910,6 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
     /* lwx does not throw unaligned access errors, so force alignment */
     tcg_gen_andi_tl(addr, addr, ~3);
 
-    sync_jmpstate(dc);
-
     tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index, MO_TEUL);
     tcg_gen_mov_tl(cpu_res_addr, addr);
     tcg_temp_free(addr);
@@ -959,8 +943,6 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
         }
     }
 
-    sync_jmpstate(dc);
-
     if (size > MO_8 &&
         (dc->tb_flags & MSR_EE) &&
         dc->cpu->cfg.unaligned_exceptions) {
@@ -1062,8 +1044,6 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
     TCGLabel *swx_fail = gen_new_label();
     TCGv_i32 tval;
 
-    sync_jmpstate(dc);
-
     /* swx does not throw unaligned access errors, so force alignment */
     tcg_gen_andi_tl(addr, addr, ~3);
 
@@ -1413,44 +1393,6 @@ static void dec_msr(DisasContext *dc)
     }
 }
 
-static inline void eval_cc(DisasContext *dc, unsigned int cc,
-                           TCGv_i32 d, TCGv_i32 a)
-{
-    static const int mb_to_tcg_cc[] = {
-        [CC_EQ] = TCG_COND_EQ,
-        [CC_NE] = TCG_COND_NE,
-        [CC_LT] = TCG_COND_LT,
-        [CC_LE] = TCG_COND_LE,
-        [CC_GE] = TCG_COND_GE,
-        [CC_GT] = TCG_COND_GT,
-    };
-
-    switch (cc) {
-    case CC_EQ:
-    case CC_NE:
-    case CC_LT:
-    case CC_LE:
-    case CC_GE:
-    case CC_GT:
-        tcg_gen_setcondi_i32(mb_to_tcg_cc[cc], d, a, 0);
-        break;
-    default:
-        cpu_abort(CPU(dc->cpu), "Unknown condition code %x.\n", cc);
-        break;
-    }
-}
-
-static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
-{
-    TCGv_i32 zero = tcg_const_i32(0);
-
-    tcg_gen_movcond_i32(TCG_COND_NE, cpu_pc,
-                        cpu_btaken, zero,
-                        pc_true, pc_false);
-
-    tcg_temp_free_i32(zero);
-}
-
 static bool dec_setup_dslot(DisasContext *dc)
 {
     if (wait_for_next_tb(dc)) {
@@ -1466,8 +1408,17 @@ static bool dec_setup_dslot(DisasContext *dc)
 
 static void dec_bcc(DisasContext *dc)
 {
+    static const TCGCond mb_to_tcg_cc[] = {
+        [CC_EQ] = TCG_COND_EQ,
+        [CC_NE] = TCG_COND_NE,
+        [CC_LT] = TCG_COND_LT,
+        [CC_LE] = TCG_COND_LE,
+        [CC_GE] = TCG_COND_GE,
+        [CC_GT] = TCG_COND_GT,
+    };
     unsigned int cc;
     unsigned int dslot;
+    TCGv_i32 zero, next;
 
     cc = EXTRACT_FIELD(dc->ir, 21, 23);
     dslot = dc->ir & (1 << 25);
@@ -1476,15 +1427,29 @@ static void dec_bcc(DisasContext *dc)
         return;
     }
 
+    dc->jmp_cond = mb_to_tcg_cc[cc];
+
+    /* Cache the condition register in cpu_bvalue across any delay slot.  */
+    tcg_gen_mov_i32(cpu_bvalue, cpu_R[dc->ra]);
+
+    /* Store the branch taken destination into btarget.  */
     if (dc->type_b) {
-        dc->jmp = JMP_DIRECT_CC;
-        dc->jmp_pc = dc->base.pc_next + dec_alu_typeb_imm(dc);
-        tcg_gen_movi_i32(cpu_btarget, dc->jmp_pc);
+        dc->jmp_dest = dc->base.pc_next + dec_alu_typeb_imm(dc);
+        tcg_gen_movi_i32(cpu_btarget, dc->jmp_dest);
     } else {
-        dc->jmp = JMP_INDIRECT;
-        tcg_gen_addi_i32(cpu_btarget, cpu_R[dc->rb], dc->base.pc_next);
+        dc->jmp_dest = -1;
+        tcg_gen_addi_i32(cpu_btarget, reg_for_read(dc, dc->rb),
+                         dc->base.pc_next);
     }
-    eval_cc(dc, cc, cpu_btaken, cpu_R[dc->ra]);
+
+    /* Compute the final destination into btarget.  */
+    zero = tcg_const_i32(0);
+    next = tcg_const_i32(dc->base.pc_next + (dslot + 1) * 4);
+    tcg_gen_movcond_i32(dc->jmp_cond, cpu_btarget,
+                        reg_for_read(dc, dc->ra), zero,
+                        cpu_btarget, next);
+    tcg_temp_free_i32(zero);
+    tcg_temp_free_i32(next);
 }
 
 static void dec_br(DisasContext *dc)
@@ -1506,14 +1471,13 @@ static void dec_br(DisasContext *dc)
 
     add_pc = abs ? 0 : dc->base.pc_next;
     if (dc->type_b) {
-        dc->jmp = JMP_DIRECT;
-        dc->jmp_pc = add_pc + dec_alu_typeb_imm(dc);
-        tcg_gen_movi_i32(cpu_btarget, dc->jmp_pc);
+        dc->jmp_dest = add_pc + dec_alu_typeb_imm(dc);
+        tcg_gen_movi_i32(cpu_btarget, dc->jmp_dest);
     } else {
-        dc->jmp = JMP_INDIRECT;
+        dc->jmp_dest = -1;
         tcg_gen_addi_i32(cpu_btarget, cpu_R[dc->rb], add_pc);
     }
-    tcg_gen_movi_i32(cpu_btaken, 1);
+    dc->jmp_cond = TCG_COND_ALWAYS;
 }
 
 static inline void do_rti(DisasContext *dc)
@@ -1596,8 +1560,8 @@ static void dec_rts(DisasContext *dc)
         dc->tb_flags |= DRTE_FLAG;
     }
 
-    dc->jmp = JMP_INDIRECT;
-    tcg_gen_movi_i32(cpu_btaken, 1);
+    dc->jmp_cond = TCG_COND_ALWAYS;
+    dc->jmp_dest = -1;
     tcg_gen_add_i32(cpu_btarget, cpu_R[dc->ra], *dec_alu_op_b(dc));
 }
 
@@ -1694,13 +1658,14 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 
     dc->cpu = cpu;
     dc->tb_flags = dc->base.tb->flags;
-    dc->jmp = dc->tb_flags & D_FLAG ? JMP_INDIRECT : JMP_NOJMP;
     dc->cpustate_changed = 0;
     dc->abort_at_next_insn = 0;
     dc->ext_imm = dc->base.tb->cs_base;
     dc->r0 = NULL;
     dc->r0_set = false;
     dc->mem_index = cpu_mmu_index(&cpu->env, false);
+    dc->jmp_cond = dc->tb_flags & D_FLAG ? TCG_COND_ALWAYS : TCG_COND_NEVER;
+    dc->jmp_dest = -1;
 
     bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
     dc->base.max_insns = MIN(dc->base.max_insns, bound);
@@ -1769,14 +1734,12 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
     dc->tb_flags |= dc->tb_flags_to_set;
     dc->base.pc_next += 4;
 
-    if (dc->jmp != JMP_NOJMP && !(dc->tb_flags & D_FLAG)) {
+    if (dc->jmp_cond != TCG_COND_NEVER && !(dc->tb_flags & D_FLAG)) {
         if (dc->tb_flags & DRTI_FLAG) {
             do_rti(dc);
-        }
-        if (dc->tb_flags & DRTB_FLAG) {
+        } else if (dc->tb_flags & DRTB_FLAG) {
             do_rtb(dc);
-        }
-        if (dc->tb_flags & DRTE_FLAG) {
+        } else if (dc->tb_flags & DRTE_FLAG) {
             do_rte(dc);
         }
         dc->base.is_jmp = DISAS_JUMP;
@@ -1801,19 +1764,13 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
     }
 
     t_sync_flags(dc);
-    if (dc->tb_flags & D_FLAG) {
-        sync_jmpstate(dc);
-        dc->jmp = JMP_NOJMP;
-    }
 
     switch (dc->base.is_jmp) {
     case DISAS_TOO_MANY:
-        assert(dc->jmp == JMP_NOJMP);
         gen_goto_tb(dc, 0, dc->base.pc_next);
         return;
 
     case DISAS_UPDATE:
-        assert(dc->jmp == JMP_NOJMP);
         if (unlikely(cs->singlestep_enabled)) {
             gen_raise_exception(dc, EXCP_DEBUG);
         } else {
@@ -1822,35 +1779,41 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
         return;
 
     case DISAS_JUMP:
-        switch (dc->jmp) {
-        case JMP_INDIRECT:
-            {
-                TCGv_i32 tmp_pc = tcg_const_i32(dc->base.pc_next);
-                eval_cond_jmp(dc, cpu_btarget, tmp_pc);
-                tcg_temp_free_i32(tmp_pc);
+        if (dc->jmp_dest != -1 && !cs->singlestep_enabled) {
+            /* Direct jump. */
+            tcg_gen_discard_i32(cpu_btarget);
 
-                if (unlikely(cs->singlestep_enabled)) {
-                    gen_raise_exception(dc, EXCP_DEBUG);
-                } else {
-                    tcg_gen_exit_tb(NULL, 0);
-                }
-            }
-            return;
+            if (dc->jmp_cond != TCG_COND_ALWAYS) {
+                /* Conditional direct jump. */
+                TCGLabel *taken = gen_new_label();
+                TCGv_i32 tmp = tcg_temp_new_i32();
 
-        case JMP_DIRECT_CC:
-            {
-                TCGLabel *l1 = gen_new_label();
-                tcg_gen_brcondi_i32(TCG_COND_NE, cpu_btaken, 0, l1);
+                /*
+                 * Copy bvalue to a temp now, so we can discard bvalue.
+                 * This can avoid writing bvalue to memory when the
+                 * delay slot cannot raise an exception.
+                 */
+                tcg_gen_mov_i32(tmp, cpu_bvalue);
+                tcg_gen_discard_i32(cpu_bvalue);
+
+                tcg_gen_brcondi_i32(dc->jmp_cond, tmp, 0, taken);
                 gen_goto_tb(dc, 1, dc->base.pc_next);
-                gen_set_label(l1);
+                gen_set_label(taken);
             }
-            /* fall through */
-
-        case JMP_DIRECT:
-            gen_goto_tb(dc, 0, dc->jmp_pc);
+            gen_goto_tb(dc, 0, dc->jmp_dest);
             return;
         }
-        /* fall through */
+
+        /* Indirect jump (or direct jump w/ singlestep) */
+        tcg_gen_mov_i32(cpu_pc, cpu_btarget);
+        tcg_gen_discard_i32(cpu_btarget);
+
+        if (unlikely(cs->singlestep_enabled)) {
+            gen_raise_exception(dc, EXCP_DEBUG);
+        } else {
+            tcg_gen_exit_tb(NULL, 0);
+        }
+        return;
 
     default:
         g_assert_not_reached();
@@ -1902,8 +1865,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, " BIMM");
     }
     if (iflags & D_FLAG) {
-        qemu_fprintf(f, " D(btaken=%d btarget=0x%08x)",
-                     env->btaken, env->btarget);
+        qemu_fprintf(f, " D(btarget=0x%08x)", env->btarget);
     }
     if (iflags & DRTI_FLAG) {
         qemu_fprintf(f, " DRTI");
@@ -1953,7 +1915,7 @@ void mb_tcg_init(void)
         SP(msr_c),
         SP(imm),
         SP(iflags),
-        SP(btaken),
+        SP(bvalue),
         SP(btarget),
         SP(res_val),
     };
-- 
2.25.1


