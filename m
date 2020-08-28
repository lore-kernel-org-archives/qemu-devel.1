Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CDBC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B42320639
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTtHd001"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B42320639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfPj-0006In-8E
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEr-00010l-1W
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:21 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:44612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEn-0005Bh-5l
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id q3so519699pls.11
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wse7zD0pJo6WjEez5LvLZIudG6q/fbgb3bbbGW9ilgU=;
 b=JTtHd001fmseF2x8ueeXUqRoww9p2zSHOGlRcOTohLKFRLMLAGUPSs3Ji3e7PgtyEc
 GEIhJ8HeJpCT0G596HhCoxvee7+xpnOltXzwW1v9xbEKQzWQG9PwISSYCeSHg97FvmqH
 XGouX4YMs2Kv1FvnxTx0OF9c7GlpOqg67U69IuIAmc0GStImTKmUldlT8hdCIhe+iIyK
 9exMY2FWun8Dtfx9wHVFVH4Q7pzz9D6rNjGlttBirrxO1Wtz4vx5jWcwV+6MmS770Dbs
 8oiFByfTG5HFxgR4ic+uA7plpMnLSuiRXhoUGrKUSrAuJZqXIa6vdeZ0ncVZehhFxTL4
 OvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wse7zD0pJo6WjEez5LvLZIudG6q/fbgb3bbbGW9ilgU=;
 b=V1KgVeVL9t5Zz1uWHMD6H1rpzWR0K24akbo4Lp/nYjfsBsV3xulL2StQIMHPQztPG0
 q8zCmWrVt56QAm0vtLH4oNgAR29ezd69LX98TrV/OF8MxNMUMDYkeXe/MLXvgrjq1VBN
 0UyRsENx2aZH0XQyHRBGINqSpYpE6P5tpqnN0TEm56io1X+VY1ZnKAj4vec+Fewgke/r
 6XCcWpLxIxhIBVqylFkjDPo/pJ6+VYGBT7cZdG+weARdWaVeIWeAJef8E83bNOr4M32W
 BnSIbmQ1/0dQGMPvXFFy9S00WB7YF83gOvWCGD29mZyS8+3HsNLeEYr7WMaw4fDtenLw
 Qe/g==
X-Gm-Message-State: AOAM531bXElZ92KCmLLtwqcI/iEeleuH6V40AY+Uk1YU9fEYKW8I2vKC
 xFtCMHvNW3WsFvrTls/0TW2Wj51tcrm9KA==
X-Google-Smtp-Source: ABdhPJyUN7340HolLAR3nfS/akljQu8O3gAVw2PkM5xzTCPuIHQszNQvxOLF0BcmsITdZ6ZR/eg6Vg==
X-Received: by 2002:a17:90a:ad48:: with SMTP id
 w8mr1393761pjv.179.1598624415335; 
 Fri, 28 Aug 2020 07:20:15 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 34/76] target/microblaze: Ensure imm constant is always
 available
Date: Fri, 28 Aug 2020 07:18:47 -0700
Message-Id: <20200828141929.77854-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Include the env->imm value in the TB values when IMM_FLAG is set.
This means that we can always reconstruct the complete 32-bit imm.
Discard env_imm when its contents can no longer be accessed.

Fix user-mode checks for BRK/BRKI, which depend on IMM.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |   2 +-
 target/microblaze/translate.c | 111 ++++++++++++++++++++--------------
 2 files changed, 67 insertions(+), 46 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 7066878ac7..013858b8e0 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -374,9 +374,9 @@ static inline void cpu_get_tb_cpu_state(CPUMBState *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
     *pc = env->pc;
-    *cs_base = 0;
     *flags = (env->iflags & IFLAGS_TB_MASK) |
              (env->msr & (MSR_UM | MSR_VM | MSR_EE));
+    *cs_base = (*flags & IMM_FLAG ? env->imm : 0);
 }
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 133ec24870..65ce8f3cd6 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -61,6 +61,7 @@ typedef struct DisasContext {
     /* Decoder.  */
     int type_b;
     uint32_t ir;
+    uint32_t ext_imm;
     uint8_t opcode;
     uint8_t rd, ra, rb;
     uint16_t imm;
@@ -169,24 +170,23 @@ static bool trap_userspace(DisasContext *dc, bool cond)
     return cond_user;
 }
 
-/* True if ALU operand b is a small immediate that may deserve
-   faster treatment.  */
-static inline int dec_alu_op_b_is_small_imm(DisasContext *dc)
+static int32_t dec_alu_typeb_imm(DisasContext *dc)
 {
-    /* Immediate insn without the imm prefix ?  */
-    return dc->type_b && !(dc->tb_flags & IMM_FLAG);
+    tcg_debug_assert(dc->type_b);
+    if (dc->tb_flags & IMM_FLAG) {
+        return dc->ext_imm | dc->imm;
+    } else {
+        return (int16_t)dc->imm;
+    }
 }
 
 static inline TCGv_i32 *dec_alu_op_b(DisasContext *dc)
 {
     if (dc->type_b) {
-        if (dc->tb_flags & IMM_FLAG)
-            tcg_gen_ori_i32(cpu_imm, cpu_imm, dc->imm);
-        else
-            tcg_gen_movi_i32(cpu_imm, (int32_t)((int16_t)dc->imm));
+        tcg_gen_movi_i32(cpu_imm, dec_alu_typeb_imm(dc));
         return &cpu_imm;
-    } else
-        return &cpu_R[dc->rb];
+    }
+    return &cpu_R[dc->rb];
 }
 
 static void dec_add(DisasContext *dc)
@@ -776,14 +776,14 @@ static inline void sync_jmpstate(DisasContext *dc)
 
 static void dec_imm(DisasContext *dc)
 {
-    tcg_gen_movi_i32(cpu_imm, (dc->imm << 16));
+    dc->ext_imm = dc->imm << 16;
+    tcg_gen_movi_i32(cpu_imm, dc->ext_imm);
     dc->tb_flags |= IMM_FLAG;
     dc->clear_imm = 0;
 }
 
 static inline void compute_ldst_addr(DisasContext *dc, bool ea, TCGv t)
 {
-    bool extimm = dc->tb_flags & IMM_FLAG;
     /* Should be set to true if r1 is used by loadstores.  */
     bool stackprot = false;
     TCGv_i32 t32;
@@ -836,11 +836,7 @@ static inline void compute_ldst_addr(DisasContext *dc, bool ea, TCGv t)
     }
     /* Immediate.  */
     t32 = tcg_temp_new_i32();
-    if (!extimm) {
-        tcg_gen_addi_i32(t32, cpu_R[dc->ra], (int16_t)dc->imm);
-    } else {
-        tcg_gen_add_i32(t32, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-    }
+    tcg_gen_addi_i32(t32, cpu_R[dc->ra], dec_alu_typeb_imm(dc));
     tcg_gen_extu_i32_tl(t, t32);
     tcg_temp_free_i32(t32);
 
@@ -1134,15 +1130,13 @@ static void dec_bcc(DisasContext *dc)
         dec_setup_dslot(dc);
     }
 
-    if (dec_alu_op_b_is_small_imm(dc)) {
-        int32_t offset = (int32_t)((int16_t)dc->imm); /* sign-extend.  */
-
-        tcg_gen_movi_i32(cpu_btarget, dc->base.pc_next + offset);
+    if (dc->type_b) {
         dc->jmp = JMP_DIRECT_CC;
-        dc->jmp_pc = dc->base.pc_next + offset;
+        dc->jmp_pc = dc->base.pc_next + dec_alu_typeb_imm(dc);
+        tcg_gen_movi_i32(cpu_btarget, dc->jmp_pc);
     } else {
         dc->jmp = JMP_INDIRECT;
-        tcg_gen_addi_i32(cpu_btarget, *dec_alu_op_b(dc), dc->base.pc_next);
+        tcg_gen_addi_i32(cpu_btarget, cpu_R[dc->rb], dc->base.pc_next);
     }
     eval_cc(dc, cc, cpu_btaken, cpu_R[dc->ra]);
 }
@@ -1192,38 +1186,63 @@ static void dec_br(DisasContext *dc)
         return;
     }
 
+    if (abs && link && !dslot) {
+        if (dc->type_b) {
+            /* BRKI */
+            uint32_t imm = dec_alu_typeb_imm(dc);
+            if (trap_userspace(dc, imm != 8 && imm != 0x18)) {
+                return;
+            }
+        } else {
+            /* BRK */
+            if (trap_userspace(dc, true)) {
+                return;
+            }
+        }
+    }
+
     dc->delayed_branch = 1;
     if (dslot) {
         dec_setup_dslot(dc);
     }
-    if (link && dc->rd)
+    if (link && dc->rd) {
         tcg_gen_movi_i32(cpu_R[dc->rd], dc->base.pc_next);
+    }
 
-    dc->jmp = JMP_INDIRECT;
     if (abs) {
-        tcg_gen_movi_i32(cpu_btaken, 1);
-        tcg_gen_mov_i32(cpu_btarget, *(dec_alu_op_b(dc)));
-        if (link && !dslot) {
-            if (!(dc->tb_flags & IMM_FLAG) &&
-                (dc->imm == 8 || dc->imm == 0x18)) {
+        if (dc->type_b) {
+            uint32_t dest = dec_alu_typeb_imm(dc);
+
+            dc->jmp = JMP_DIRECT;
+            dc->jmp_pc = dest;
+            tcg_gen_movi_i32(cpu_btarget, dest);
+            if (link && !dslot) {
+                switch (dest) {
+                case 8:
+                case 0x18:
+                    gen_raise_exception_sync(dc, EXCP_BREAK);
+                    break;
+                case 0:
+                    gen_raise_exception_sync(dc, EXCP_DEBUG);
+                    break;
+                }
+            }
+        } else {
+            dc->jmp = JMP_INDIRECT;
+            tcg_gen_mov_i32(cpu_btarget, cpu_R[dc->rb]);
+            if (link && !dslot) {
                 gen_raise_exception_sync(dc, EXCP_BREAK);
             }
-            if (dc->imm == 0) {
-                if (trap_userspace(dc, true)) {
-                    return;
-                }
-                gen_raise_exception_sync(dc, EXCP_DEBUG);
-            }
         }
+    } else if (dc->type_b) {
+        dc->jmp = JMP_DIRECT;
+        dc->jmp_pc = dc->base.pc_next + dec_alu_typeb_imm(dc);
+        tcg_gen_movi_i32(cpu_btarget, dc->jmp_pc);
     } else {
-        if (dec_alu_op_b_is_small_imm(dc)) {
-            dc->jmp = JMP_DIRECT;
-            dc->jmp_pc = dc->base.pc_next + (int32_t)((int16_t)dc->imm);
-        } else {
-            tcg_gen_movi_i32(cpu_btaken, 1);
-            tcg_gen_addi_i32(cpu_btarget, *dec_alu_op_b(dc), dc->base.pc_next);
-        }
+        dc->jmp = JMP_INDIRECT;
+        tcg_gen_addi_i32(cpu_btarget, cpu_R[dc->rb], dc->base.pc_next);
     }
+    tcg_gen_movi_i32(cpu_btaken, 1);
 }
 
 static inline void do_rti(DisasContext *dc)
@@ -1529,6 +1548,7 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     dc->jmp = dc->delayed_branch ? JMP_INDIRECT : JMP_NOJMP;
     dc->cpustate_changed = 0;
     dc->abort_at_next_insn = 0;
+    dc->ext_imm = dc->base.tb->cs_base;
 
     bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
     dc->base.max_insns = MIN(dc->base.max_insns, bound);
@@ -1573,8 +1593,9 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     dc->clear_imm = 1;
     decode(dc, cpu_ldl_code(env, dc->base.pc_next));
-    if (dc->clear_imm) {
+    if (dc->clear_imm && (dc->tb_flags & IMM_FLAG)) {
         dc->tb_flags &= ~IMM_FLAG;
+        tcg_gen_discard_i32(cpu_imm);
     }
     dc->base.pc_next += 4;
 
-- 
2.25.1


