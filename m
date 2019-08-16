Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1591DC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3FFE2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="auqJtNoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FFE2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycRP-00031G-Hr
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6s-0003OH-Or
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6o-0005St-VK
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:54847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6o-0005Ry-Kb
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:34 -0400
Received: by mail-wm1-x32c.google.com with SMTP id p74so4023098wme.4
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=h4Kov0gouAMEel5NC/aLENgpRMLwwNbVgx6hHvUU4Vk=;
 b=auqJtNoLqfOUWEXUUhNn4KIv2AdIfzfwmkgHCJo2OiVHbogo0xgLaxycU9wJ8UmDZI
 4h48iyC1f3PZ/ZmrRRsHg15YqC1zrbUZdKH22PkMqA0J0zk43nKZsV4AxpHZykOwjc9X
 pjuC6alsfwlakYPmZNm4QbdBpZBeNb1q0WneTNO4FlCUfqsBJshL9c64ab7e7rRjglrT
 WpWQDzJmhlVWuIgNaU8PsYXdS9kHquh7f/RXPPyvjvHO5iI1/8n0QFQiOuWvKAaRt1WP
 o67Jv1208/VfIN9VHk4EDanKxM1Qzy/Entt79hsXw7k/4UWHmnzajFikga3aFwAW/plY
 goMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h4Kov0gouAMEel5NC/aLENgpRMLwwNbVgx6hHvUU4Vk=;
 b=tomkKiEnCnRV0kz7PL/3xPHXGc8F2X2qgBuhKcyx4Z+cJJDjfMhlgZuNqoWhGkPvKr
 /GY0XVQOfW0iFi3gndXVpMSmJ2/e+KSgFZvuA9EEeXeakI2krxii9EiRsXmYtBQxPhRw
 v6mGqIPFU2JwnDFcBxIbFPmlxx7iGp8s76P7dmY0cWhQGjJOVMCfeHqtjS81il8V//+6
 GXcJQVh7yECgkSE2XUPGi9gx5IjDghOLcYB+TUM4Tac7CbuXPrFZyvXwRfiEEw5fdXtj
 cj68yGTUJqtD5yM943YMCPimLl8sJXZF9tkM2q3oQq7slhuZSx3Sg6qAPkdjxvNb2lvS
 XI1Q==
X-Gm-Message-State: APjAAAWCU6LAVclyr/iz7f8FpQvT49EG2HP0s80VPTJLkQ0ql6LyySfO
 bXTsyezCA2DyGQTjJmyl3lnJi4rt5R0buQ==
X-Google-Smtp-Source: APXvYqwSEEHetJ6J1e947DcoJUYfEx+OKi3wMwn4Q0H1wAWvqwF1eiwm0GlLjDxPR70XY2dvEeRrWA==
X-Received: by 2002:a1c:b342:: with SMTP id c63mr7422362wmf.84.1565961452726; 
 Fri, 16 Aug 2019 06:17:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:01 +0100
Message-Id: <20190816131719.28244-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PULL 11/29] target/arm: Replace s->pc with
 s->base.pc_next
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We must update s->base.pc_next when we return from the translate_insn
hook to the main translator loop.  By incrementing s->base.pc_next
immediately after reading the insn word, "pc_next" contains the address
of the next instruction throughout translation.

All remaining uses of s->pc are referencing the address of the next insn,
so this is now a simple global replacement.  Remove the "s->pc" field.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190807045335.1361-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.h     |   1 -
 target/arm/translate-a64.c |  51 +++++++++---------
 target/arm/translate.c     | 103 ++++++++++++++++++-------------------
 3 files changed, 72 insertions(+), 83 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 53ac50bc028..64304c957ee 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -10,7 +10,6 @@ typedef struct DisasContext {
     DisasContextBase base;
     const ARMISARegisters *isar;
 
-    target_ulong pc;
     /* The address of the current instruction being translated. */
     target_ulong pc_curr;
     target_ulong page_start;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a0b557ddcec..bc89f2c8317 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -255,7 +255,7 @@ static void gen_exception_internal(int excp)
 
 static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
 {
-    gen_a64_set_pc_im(s->pc - offset);
+    gen_a64_set_pc_im(s->base.pc_next - offset);
     gen_exception_internal(excp);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -263,7 +263,7 @@ static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
 static void gen_exception_insn(DisasContext *s, int offset, int excp,
                                uint32_t syndrome, uint32_t target_el)
 {
-    gen_a64_set_pc_im(s->pc - offset);
+    gen_a64_set_pc_im(s->base.pc_next - offset);
     gen_exception(excp, syndrome, target_el);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -273,7 +273,7 @@ static void gen_exception_bkpt_insn(DisasContext *s, int offset,
 {
     TCGv_i32 tcg_syn;
 
-    gen_a64_set_pc_im(s->pc - offset);
+    gen_a64_set_pc_im(s->base.pc_next - offset);
     tcg_syn = tcg_const_i32(syndrome);
     gen_helper_exception_bkpt_insn(cpu_env, tcg_syn);
     tcg_temp_free_i32(tcg_syn);
@@ -1238,7 +1238,7 @@ static void disas_uncond_b_imm(DisasContext *s, uint32_t insn)
 
     if (insn & (1U << 31)) {
         /* BL Branch with link */
-        tcg_gen_movi_i64(cpu_reg(s, 30), s->pc);
+        tcg_gen_movi_i64(cpu_reg(s, 30), s->base.pc_next);
     }
 
     /* B Branch / BL Branch with link */
@@ -1271,7 +1271,7 @@ static void disas_comp_b_imm(DisasContext *s, uint32_t insn)
     tcg_gen_brcondi_i64(op ? TCG_COND_NE : TCG_COND_EQ,
                         tcg_cmp, 0, label_match);
 
-    gen_goto_tb(s, 0, s->pc);
+    gen_goto_tb(s, 0, s->base.pc_next);
     gen_set_label(label_match);
     gen_goto_tb(s, 1, addr);
 }
@@ -1302,7 +1302,7 @@ static void disas_test_b_imm(DisasContext *s, uint32_t insn)
     tcg_gen_brcondi_i64(op ? TCG_COND_NE : TCG_COND_EQ,
                         tcg_cmp, 0, label_match);
     tcg_temp_free_i64(tcg_cmp);
-    gen_goto_tb(s, 0, s->pc);
+    gen_goto_tb(s, 0, s->base.pc_next);
     gen_set_label(label_match);
     gen_goto_tb(s, 1, addr);
 }
@@ -1330,7 +1330,7 @@ static void disas_cond_b_imm(DisasContext *s, uint32_t insn)
         /* genuinely conditional branches */
         TCGLabel *label_match = gen_new_label();
         arm_gen_test_cc(cond, label_match);
-        gen_goto_tb(s, 0, s->pc);
+        gen_goto_tb(s, 0, s->base.pc_next);
         gen_set_label(label_match);
         gen_goto_tb(s, 1, addr);
     } else {
@@ -1491,7 +1491,7 @@ static void handle_sync(DisasContext *s, uint32_t insn,
          * any pending interrupts immediately.
          */
         reset_btype(s);
-        gen_goto_tb(s, 0, s->pc);
+        gen_goto_tb(s, 0, s->base.pc_next);
         return;
 
     case 7: /* SB */
@@ -1503,7 +1503,7 @@ static void handle_sync(DisasContext *s, uint32_t insn,
          * MB and end the TB instead.
          */
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-        gen_goto_tb(s, 0, s->pc);
+        gen_goto_tb(s, 0, s->base.pc_next);
         return;
 
     default:
@@ -2015,7 +2015,7 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         gen_a64_set_pc(s, dst);
         /* BLR also needs to load return address */
         if (opc == 1) {
-            tcg_gen_movi_i64(cpu_reg(s, 30), s->pc);
+            tcg_gen_movi_i64(cpu_reg(s, 30), s->base.pc_next);
         }
         break;
 
@@ -2042,7 +2042,7 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         gen_a64_set_pc(s, dst);
         /* BLRAA also needs to load return address */
         if (opc == 9) {
-            tcg_gen_movi_i64(cpu_reg(s, 30), s->pc);
+            tcg_gen_movi_i64(cpu_reg(s, 30), s->base.pc_next);
         }
         break;
 
@@ -14030,10 +14030,10 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
 {
     uint32_t insn;
 
-    s->pc_curr = s->pc;
-    insn = arm_ldl_code(env, s->pc, s->sctlr_b);
+    s->pc_curr = s->base.pc_next;
+    insn = arm_ldl_code(env, s->base.pc_next, s->sctlr_b);
     s->insn = insn;
-    s->pc += 4;
+    s->base.pc_next += 4;
 
     s->fp_access_checked = false;
 
@@ -14130,7 +14130,6 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     int bound, core_mmu_idx;
 
     dc->isar = &arm_cpu->isar;
-    dc->pc = dc->base.pc_first;
     dc->condjmp = 0;
 
     dc->aarch64 = 1;
@@ -14203,7 +14202,7 @@ static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(dc->pc, 0, 0);
+    tcg_gen_insn_start(dc->base.pc_next, 0, 0);
     dc->insn_start = tcg_last_op();
 }
 
@@ -14213,7 +14212,7 @@ static bool aarch64_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     if (bp->flags & BP_CPU) {
-        gen_a64_set_pc_im(dc->pc);
+        gen_a64_set_pc_im(dc->base.pc_next);
         gen_helper_check_breakpoints(cpu_env);
         /* End the TB early; it likely won't be executed */
         dc->base.is_jmp = DISAS_TOO_MANY;
@@ -14224,7 +14223,7 @@ static bool aarch64_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
            to for it to be properly cleared -- thus we
            increment the PC here so that the logic setting
            tb->size below does the right thing.  */
-        dc->pc += 4;
+        dc->base.pc_next += 4;
         dc->base.is_jmp = DISAS_NORETURN;
     }
 
@@ -14254,7 +14253,6 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         disas_a64_insn(env, dc);
     }
 
-    dc->base.pc_next = dc->pc;
     translator_loop_temp_check(&dc->base);
 }
 
@@ -14270,7 +14268,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
          */
         switch (dc->base.is_jmp) {
         default:
-            gen_a64_set_pc_im(dc->pc);
+            gen_a64_set_pc_im(dc->base.pc_next);
             /* fall through */
         case DISAS_EXIT:
         case DISAS_JUMP:
@@ -14287,11 +14285,11 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         switch (dc->base.is_jmp) {
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
-            gen_goto_tb(dc, 1, dc->pc);
+            gen_goto_tb(dc, 1, dc->base.pc_next);
             break;
         default:
         case DISAS_UPDATE:
-            gen_a64_set_pc_im(dc->pc);
+            gen_a64_set_pc_im(dc->base.pc_next);
             /* fall through */
         case DISAS_EXIT:
             tcg_gen_exit_tb(NULL, 0);
@@ -14303,11 +14301,11 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_SWI:
             break;
         case DISAS_WFE:
-            gen_a64_set_pc_im(dc->pc);
+            gen_a64_set_pc_im(dc->base.pc_next);
             gen_helper_wfe(cpu_env);
             break;
         case DISAS_YIELD:
-            gen_a64_set_pc_im(dc->pc);
+            gen_a64_set_pc_im(dc->base.pc_next);
             gen_helper_yield(cpu_env);
             break;
         case DISAS_WFI:
@@ -14317,7 +14315,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
              */
             TCGv_i32 tmp = tcg_const_i32(4);
 
-            gen_a64_set_pc_im(dc->pc);
+            gen_a64_set_pc_im(dc->base.pc_next);
             gen_helper_wfi(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
             /* The helper doesn't necessarily throw an exception, but we
@@ -14328,9 +14326,6 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         }
         }
     }
-
-    /* Functions above can change dc->pc, so re-align db->pc_next */
-    dc->base.pc_next = dc->pc;
 }
 
 static void aarch64_tr_disas_log(const DisasContextBase *dcbase,
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8779d36a868..14572b8501b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1036,7 +1036,7 @@ static inline void gen_blxns(DisasContext *s, int rm)
      * We do however need to set the PC, because the blxns helper reads it.
      * The blxns helper may throw an exception.
      */
-    gen_set_pc_im(s, s->pc);
+    gen_set_pc_im(s, s->base.pc_next);
     gen_helper_v7m_blxns(cpu_env, var);
     tcg_temp_free_i32(var);
     s->base.is_jmp = DISAS_EXIT;
@@ -1222,7 +1222,7 @@ static inline void gen_hvc(DisasContext *s, int imm16)
      * for single stepping.)
      */
     s->svc_imm = imm16;
-    gen_set_pc_im(s, s->pc);
+    gen_set_pc_im(s, s->base.pc_next);
     s->base.is_jmp = DISAS_HVC;
 }
 
@@ -1237,14 +1237,14 @@ static inline void gen_smc(DisasContext *s)
     tmp = tcg_const_i32(syn_aa32_smc());
     gen_helper_pre_smc(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
-    gen_set_pc_im(s, s->pc);
+    gen_set_pc_im(s, s->base.pc_next);
     s->base.is_jmp = DISAS_SMC;
 }
 
 static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
 {
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - offset);
+    gen_set_pc_im(s, s->base.pc_next - offset);
     gen_exception_internal(excp);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1253,7 +1253,7 @@ static void gen_exception_insn(DisasContext *s, int offset, int excp,
                                int syn, uint32_t target_el)
 {
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - offset);
+    gen_set_pc_im(s, s->base.pc_next - offset);
     gen_exception(excp, syn, target_el);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1263,7 +1263,7 @@ static void gen_exception_bkpt_insn(DisasContext *s, int offset, uint32_t syn)
     TCGv_i32 tcg_syn;
 
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - offset);
+    gen_set_pc_im(s, s->base.pc_next - offset);
     tcg_syn = tcg_const_i32(syn);
     gen_helper_exception_bkpt_insn(cpu_env, tcg_syn);
     tcg_temp_free_i32(tcg_syn);
@@ -1273,7 +1273,7 @@ static void gen_exception_bkpt_insn(DisasContext *s, int offset, uint32_t syn)
 /* Force a TB lookup after an instruction that changes the CPU state.  */
 static inline void gen_lookup_tb(DisasContext *s)
 {
-    tcg_gen_movi_i32(cpu_R[15], s->pc);
+    tcg_gen_movi_i32(cpu_R[15], s->base.pc_next);
     s->base.is_jmp = DISAS_EXIT;
 }
 
@@ -2909,7 +2909,7 @@ static inline bool use_goto_tb(DisasContext *s, target_ulong dest)
 {
 #ifndef CONFIG_USER_ONLY
     return (s->base.tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK) ||
-           ((s->pc - 1) & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
+           ((s->base.pc_next - 1) & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
 #else
     return true;
 #endif
@@ -3279,17 +3279,17 @@ static void gen_nop_hint(DisasContext *s, int val)
          */
     case 1: /* yield */
         if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-            gen_set_pc_im(s, s->pc);
+            gen_set_pc_im(s, s->base.pc_next);
             s->base.is_jmp = DISAS_YIELD;
         }
         break;
     case 3: /* wfi */
-        gen_set_pc_im(s, s->pc);
+        gen_set_pc_im(s, s->base.pc_next);
         s->base.is_jmp = DISAS_WFI;
         break;
     case 2: /* wfe */
         if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-            gen_set_pc_im(s, s->pc);
+            gen_set_pc_im(s, s->base.pc_next);
             s->base.is_jmp = DISAS_WFE;
         }
         break;
@@ -7240,7 +7240,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             if (isread) {
                 return 1;
             }
-            gen_set_pc_im(s, s->pc);
+            gen_set_pc_im(s, s->base.pc_next);
             s->base.is_jmp = DISAS_WFI;
             return 0;
         default:
@@ -7804,7 +7804,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                  * self-modifying code correctly and also to take
                  * any pending interrupts immediately.
                  */
-                gen_goto_tb(s, 0, s->pc);
+                gen_goto_tb(s, 0, s->base.pc_next);
                 return;
             case 7: /* sb */
                 if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
@@ -7815,7 +7815,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                  * for TCG; MB and end the TB instead.
                  */
                 tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                gen_goto_tb(s, 0, s->pc);
+                gen_goto_tb(s, 0, s->base.pc_next);
                 return;
             default:
                 goto illegal_op;
@@ -7871,7 +7871,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             int32_t offset;
 
             tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, s->pc);
+            tcg_gen_movi_i32(tmp, s->base.pc_next);
             store_reg(s, 14, tmp);
             /* Sign-extend the 24-bit offset */
             offset = (((int32_t)insn) << 8) >> 8;
@@ -8056,7 +8056,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             /* branch link/exchange thumb (blx) */
             tmp = load_reg(s, rm);
             tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->pc);
+            tcg_gen_movi_i32(tmp2, s->base.pc_next);
             store_reg(s, 14, tmp2);
             gen_bx(s, tmp);
             break;
@@ -9222,7 +9222,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 /* branch (and link) */
                 if (insn & (1 << 24)) {
                     tmp = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(tmp, s->pc);
+                    tcg_gen_movi_i32(tmp, s->base.pc_next);
                     store_reg(s, 14, tmp);
                 }
                 offset = sextract32(insn << 2, 0, 26);
@@ -9244,7 +9244,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         case 0xf:
             /* swi */
-            gen_set_pc_im(s, s->pc);
+            gen_set_pc_im(s, s->base.pc_next);
             s->svc_imm = extract32(insn, 0, 24);
             s->base.is_jmp = DISAS_SWI;
             break;
@@ -10326,7 +10326,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
                 if (insn & (1 << 14)) {
                     /* Branch and link.  */
-                    tcg_gen_movi_i32(cpu_R[14], s->pc | 1);
+                    tcg_gen_movi_i32(cpu_R[14], s->base.pc_next | 1);
                 }
 
                 offset += read_pc(s);
@@ -10449,7 +10449,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                              * and also to take any pending interrupts
                              * immediately.
                              */
-                            gen_goto_tb(s, 0, s->pc);
+                            gen_goto_tb(s, 0, s->base.pc_next);
                             break;
                         case 7: /* sb */
                             if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
@@ -10460,7 +10460,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                              * for TCG; MB and end the TB instead.
                              */
                             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                            gen_goto_tb(s, 0, s->pc);
+                            gen_goto_tb(s, 0, s->base.pc_next);
                             break;
                         default:
                             goto illegal_op;
@@ -11121,7 +11121,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
                 /* BLX/BX */
                 tmp = load_reg(s, rm);
                 if (link) {
-                    val = (uint32_t)s->pc | 1;
+                    val = (uint32_t)s->base.pc_next | 1;
                     tmp2 = tcg_temp_new_i32();
                     tcg_gen_movi_i32(tmp2, val);
                     store_reg(s, 14, tmp2);
@@ -11695,7 +11695,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 
         if (cond == 0xf) {
             /* swi */
-            gen_set_pc_im(s, s->pc);
+            gen_set_pc_im(s, s->base.pc_next);
             s->svc_imm = extract32(insn, 0, 8);
             s->base.is_jmp = DISAS_SWI;
             break;
@@ -11724,7 +11724,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             tcg_gen_andi_i32(tmp, tmp, 0xfffffffc);
 
             tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->pc | 1);
+            tcg_gen_movi_i32(tmp2, s->base.pc_next | 1);
             store_reg(s, 14, tmp2);
             gen_bx(s, tmp);
             break;
@@ -11749,7 +11749,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             tcg_gen_addi_i32(tmp, tmp, offset);
 
             tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->pc | 1);
+            tcg_gen_movi_i32(tmp2, s->base.pc_next | 1);
             store_reg(s, 14, tmp2);
             gen_bx(s, tmp);
         } else {
@@ -11769,16 +11769,16 @@ undef:
 
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
 {
-    /* Return true if the insn at dc->pc might cross a page boundary.
+    /* Return true if the insn at dc->base.pc_next might cross a page boundary.
      * (False positives are OK, false negatives are not.)
      * We know this is a Thumb insn, and our caller ensures we are
-     * only called if dc->pc is less than 4 bytes from the page
+     * only called if dc->base.pc_next is less than 4 bytes from the page
      * boundary, so we cross the page if the first 16 bits indicate
      * that this is a 32 bit insn.
      */
-    uint16_t insn = arm_lduw_code(env, s->pc, s->sctlr_b);
+    uint16_t insn = arm_lduw_code(env, s->base.pc_next, s->sctlr_b);
 
-    return !thumb_insn_is_16bit(s, s->pc, insn);
+    return !thumb_insn_is_16bit(s, s->base.pc_next, insn);
 }
 
 static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
@@ -11790,7 +11790,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     uint32_t condexec, core_mmu_idx;
 
     dc->isar = &cpu->isar;
-    dc->pc = dc->base.pc_first;
     dc->condjmp = 0;
 
     dc->aarch64 = 0;
@@ -11922,7 +11921,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(dc->pc,
+    tcg_gen_insn_start(dc->base.pc_next,
                        (dc->condexec_cond << 4) | (dc->condexec_mask >> 1),
                        0);
     dc->insn_start = tcg_last_op();
@@ -11935,7 +11934,7 @@ static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
 
     if (bp->flags & BP_CPU) {
         gen_set_condexec(dc);
-        gen_set_pc_im(dc, dc->pc);
+        gen_set_pc_im(dc, dc->base.pc_next);
         gen_helper_check_breakpoints(cpu_env);
         /* End the TB early; it's likely not going to be executed */
         dc->base.is_jmp = DISAS_TOO_MANY;
@@ -11948,7 +11947,7 @@ static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
            tb->size below does the right thing.  */
         /* TODO: Advance PC by correct instruction length to
          * avoid disassembler error messages */
-        dc->pc += 2;
+        dc->base.pc_next += 2;
         dc->base.is_jmp = DISAS_NORETURN;
     }
 
@@ -11959,7 +11958,7 @@ static bool arm_pre_translate_insn(DisasContext *dc)
 {
 #ifdef CONFIG_USER_ONLY
     /* Intercept jump to the magic kernel page.  */
-    if (dc->pc >= 0xffff0000) {
+    if (dc->base.pc_next >= 0xffff0000) {
         /* We always get here via a jump, so know we are not in a
            conditional execution block.  */
         gen_exception_internal(EXCP_KERNEL_TRAP);
@@ -11994,7 +11993,6 @@ static void arm_post_translate_insn(DisasContext *dc)
         gen_set_label(dc->condlabel);
         dc->condjmp = 0;
     }
-    dc->base.pc_next = dc->pc;
     translator_loop_temp_check(&dc->base);
 }
 
@@ -12008,10 +12006,10 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         return;
     }
 
-    dc->pc_curr = dc->pc;
-    insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
+    dc->pc_curr = dc->base.pc_next;
+    insn = arm_ldl_code(env, dc->base.pc_next, dc->sctlr_b);
     dc->insn = insn;
-    dc->pc += 4;
+    dc->base.pc_next += 4;
     disas_arm_insn(dc, insn);
 
     arm_post_translate_insn(dc);
@@ -12077,15 +12075,15 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         return;
     }
 
-    dc->pc_curr = dc->pc;
-    insn = arm_lduw_code(env, dc->pc, dc->sctlr_b);
-    is_16bit = thumb_insn_is_16bit(dc, dc->pc, insn);
-    dc->pc += 2;
+    dc->pc_curr = dc->base.pc_next;
+    insn = arm_lduw_code(env, dc->base.pc_next, dc->sctlr_b);
+    is_16bit = thumb_insn_is_16bit(dc, dc->base.pc_next, insn);
+    dc->base.pc_next += 2;
     if (!is_16bit) {
-        uint32_t insn2 = arm_lduw_code(env, dc->pc, dc->sctlr_b);
+        uint32_t insn2 = arm_lduw_code(env, dc->base.pc_next, dc->sctlr_b);
 
         insn = insn << 16 | insn2;
-        dc->pc += 2;
+        dc->base.pc_next += 2;
     }
     dc->insn = insn;
 
@@ -12133,8 +12131,8 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
      * but isn't very efficient).
      */
     if (dc->base.is_jmp == DISAS_NEXT
-        && (dc->pc - dc->page_start >= TARGET_PAGE_SIZE
-            || (dc->pc - dc->page_start >= TARGET_PAGE_SIZE - 3
+        && (dc->base.pc_next - dc->page_start >= TARGET_PAGE_SIZE
+            || (dc->base.pc_next - dc->page_start >= TARGET_PAGE_SIZE - 3
                 && insn_crosses_page(env, dc)))) {
         dc->base.is_jmp = DISAS_TOO_MANY;
     }
@@ -12179,7 +12177,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
         case DISAS_UPDATE:
-            gen_set_pc_im(dc, dc->pc);
+            gen_set_pc_im(dc, dc->base.pc_next);
             /* fall through */
         default:
             /* FIXME: Single stepping a WFI insn will not halt the CPU. */
@@ -12200,13 +12198,13 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         switch(dc->base.is_jmp) {
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
-            gen_goto_tb(dc, 1, dc->pc);
+            gen_goto_tb(dc, 1, dc->base.pc_next);
             break;
         case DISAS_JUMP:
             gen_goto_ptr();
             break;
         case DISAS_UPDATE:
-            gen_set_pc_im(dc, dc->pc);
+            gen_set_pc_im(dc, dc->base.pc_next);
             /* fall through */
         default:
             /* indicate that the hash table must be used to find the next TB */
@@ -12252,15 +12250,12 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_set_label(dc->condlabel);
         gen_set_condexec(dc);
         if (unlikely(is_singlestepping(dc))) {
-            gen_set_pc_im(dc, dc->pc);
+            gen_set_pc_im(dc, dc->base.pc_next);
             gen_singlestep_exception(dc);
         } else {
-            gen_goto_tb(dc, 1, dc->pc);
+            gen_goto_tb(dc, 1, dc->base.pc_next);
         }
     }
-
-    /* Functions above can change dc->pc, so re-align db->pc_next */
-    dc->base.pc_next = dc->pc;
 }
 
 static void arm_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
-- 
2.20.1


