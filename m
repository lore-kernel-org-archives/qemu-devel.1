Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D788C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1555F2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZTCtZxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1555F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmcl-0001k9-70
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLH-0006PB-SZ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:35 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:40979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLF-00069K-ER
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id t9so806446pfq.8
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UG3Qh+wDtSGX7ZrIIX3RyslAUMOb2/3zqXzoeybPnTM=;
 b=jZTCtZxN8S4h+OpigoO0FZE9Q4aR3SNl9ADcP+j31hAdW6k8BtE9ZbwCi/HL5PfHGo
 mrJ33YP3bMLIir9WBkfEDJcn5yeeOz9lQr4XT5uHwrheMQUU8mZr0/cZLhzNASwXAPzP
 AYe9BN+16dXlNkqx1xv16McHGAhb32fpPTSts0I7Iv8JMV/VlCuMRgZHyF2LVN2z51m6
 gPmCnZns4BZHn6RoJs+2a+3kCB+qSiYun+OzNwGSyXDIvj0/ND6Zdk6hA5fTuNXDswa0
 YGexjh3M9oZmWt7kOlRn1DbiTf7u/SxwhrvBYoaYpBdKIL9eJu63f8xfruxiz0N/EsBu
 t3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UG3Qh+wDtSGX7ZrIIX3RyslAUMOb2/3zqXzoeybPnTM=;
 b=dOK8FOZrv9BTsqfGHMWuf+fwqDa4CHdNmQx0HYbEu6eou9GeCwVp1z5T3M4b96s8z5
 QDh5ueR5RKWnd9UCmcSxlaTu2Fu+ZH6Hrf4geT6y0MNTTSzTqAKIjxyS1GYNrcroN/+j
 2rnIu6IFa6IPsJX+cnaeGvSC3D64bMoz6Xb1e6s0BhcXmuVFs4PNOoZgtwjcsLTqfuJl
 OA8AzpeWDu3JjHHSHIoy/CPokiyuKTznNnswcEIlyGPDfukZpOZW60SELaXdJeJlqLfn
 wRIA58ZlGffo9kfSY5paNBty+f/kvkPM3CP1SI9d95e0kxwPsS5h91PMC7a750yiZP/J
 PS1Q==
X-Gm-Message-State: AOAM531N4/jGUtdKDTBIVZt/AhKlVisgaJWI/SDDEBmQFkn8KEo1jXhh
 SHCQjq5Pc/1zoQzDoYtKwi1MbH5SuDd+bg==
X-Google-Smtp-Source: ABdhPJxAlvHmbExye28Ma6hBIYSDabZhx0Ny2RyC8QHGa+7IUo/u84Jf54l7/fM7m+KKlGy0TKcN5w==
X-Received: by 2002:a62:8c91:: with SMTP id m139mr1827902pfd.267.1598890051546; 
 Mon, 31 Aug 2020 09:07:31 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 65/76] target/microblaze: Reorganize branching
Date: Mon, 31 Aug 2020 09:05:50 -0700
Message-Id: <20200831160601.833692-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the btaken variable, and simplify things by always computing
the full branch destination into btarget.  This avoids all need for
sync_jmpstate().

Retain the direct branch behaviour by remembering the jump destination
in jmp_dest, discarding btarget.  In the normal case, where the branch
delay slot cannot trap (e.g. arithmetic), tcg will remove the computation
into btarget, leaving us with just the tcg direct branching at the end.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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
index 832cf85c64..1545974669 100644
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
@@ -782,8 +770,6 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
         }
     }
 
-    sync_jmpstate(dc);
-
     if (size > MO_8 &&
         (dc->tb_flags & MSR_EE) &&
         dc->cpu->cfg.unaligned_exceptions) {
@@ -885,8 +871,6 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
     /* lwx does not throw unaligned access errors, so force alignment */
     tcg_gen_andi_tl(addr, addr, ~3);
 
-    sync_jmpstate(dc);
-
     tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index, MO_TEUL);
     tcg_gen_mov_tl(cpu_res_addr, addr);
     tcg_temp_free(addr);
@@ -920,8 +904,6 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
         }
     }
 
-    sync_jmpstate(dc);
-
     if (size > MO_8 &&
         (dc->tb_flags & MSR_EE) &&
         dc->cpu->cfg.unaligned_exceptions) {
@@ -1023,8 +1005,6 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
     TCGLabel *swx_fail = gen_new_label();
     TCGv_i32 tval;
 
-    sync_jmpstate(dc);
-
     /* swx does not throw unaligned access errors, so force alignment */
     tcg_gen_andi_tl(addr, addr, ~3);
 
@@ -1392,44 +1372,6 @@ static void dec_msr(DisasContext *dc)
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
 static void dec_setup_dslot(DisasContext *dc)
 {
     dc->tb_flags_to_set |= D_FLAG;
@@ -1440,8 +1382,17 @@ static void dec_setup_dslot(DisasContext *dc)
 
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
@@ -1450,15 +1401,29 @@ static void dec_bcc(DisasContext *dc)
         dec_setup_dslot(dc);
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
@@ -1479,14 +1444,13 @@ static void dec_br(DisasContext *dc)
 
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
@@ -1567,8 +1531,8 @@ static void dec_rts(DisasContext *dc)
         dc->tb_flags |= DRTE_FLAG;
     }
 
-    dc->jmp = JMP_INDIRECT;
-    tcg_gen_movi_i32(cpu_btaken, 1);
+    dc->jmp_cond = TCG_COND_ALWAYS;
+    dc->jmp_dest = -1;
     tcg_gen_add_i32(cpu_btarget, cpu_R[dc->ra], *dec_alu_op_b(dc));
 }
 
@@ -1659,13 +1623,14 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 
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
@@ -1734,14 +1699,12 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
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
@@ -1766,19 +1729,13 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
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
@@ -1787,35 +1744,41 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
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
@@ -1867,8 +1830,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, " BIMM");
     }
     if (iflags & D_FLAG) {
-        qemu_fprintf(f, " D(btaken=%d btarget=0x%08x)",
-                     env->btaken, env->btarget);
+        qemu_fprintf(f, " D(btarget=0x%08x)", env->btarget);
     }
     if (iflags & DRTI_FLAG) {
         qemu_fprintf(f, " DRTI");
@@ -1918,7 +1880,7 @@ void mb_tcg_init(void)
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


