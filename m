Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEA1C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94130206CD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="npAPzeI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94130206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmQ2-0007bW-Ny
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKJ-0004I9-L3
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:35 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:56170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKG-0005z3-TS
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:35 -0400
Received: by mail-pj1-x102f.google.com with SMTP id 2so19805pjx.5
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A5jlK0T95NH3JH2keCbWDldYP2nsIY3hCH9MCVLy8Ng=;
 b=npAPzeI394RnB/EKsO+bAly/wiJB/8fRBbn0h5PD7bb0A14uv1yFTTjbaeNiF95w+a
 KrJTwtYPNlxJwmTUq9B5weX+6Ocd8sX2oN0/2fVxeUe7UF38MAIE29R7aFt8n512kyXR
 UAVeXnpq9o1XY7zsmDdrQ8QfsWy+t0nYIjAAg+MEXMpdKI8s9y3vslItFEUiw+wC70ru
 ScjCK2rcsyu+uLAr2AOgm/XrBjVnXWLus4J57Mr8b4qZRUqu9pnP2Sk8MT1lFl91cjtg
 cdsD3xAjEVrH63vgpEQ0D6mlst8lSDGWtC5rQMrOd9WB0godKN1t0I/YjklAeqsU7k/3
 GT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A5jlK0T95NH3JH2keCbWDldYP2nsIY3hCH9MCVLy8Ng=;
 b=np3ymulgTJEQ82lNbGDdQLdpaOLkuthATpRPVjK31SS2duIhJJrd/Gy6hCx/6Qpge/
 UwnXRThsfzalRElgnhDsMOoPeEtWphMMTVuDIqKrXaQCKtuDLqnCoKWSMUXaJfX0revP
 60YJz5u5I2PHQKWCgMXJPyCuqpkPwaoemuRajYY/aRYUWH59XCUggBT/ePc1HD7E9QTm
 WdfOcdW6z6CSlIMnexCmWhJpxQPwj6oELChP3hyjTAvN6uSbhum9xxC0DRwmgFaqgjmD
 uAjdtIqjLg5DhDWk18F3G+OLOrjwHee6k9in559lXbYUVAgH+QUT8SpJnhDQd9KaBM/n
 2SMw==
X-Gm-Message-State: AOAM530luIQWdbK2+aNqttl3aX55G6CxsRf4AsZovXheKV3H/HNtIxKL
 Baic74mezSPNPRWW5Q+6h4mZiskf9Mq6yA==
X-Google-Smtp-Source: ABdhPJw7tRYqwTLKJ6nEpcH1bHtRvILrTLdCe8SiCh/GF8uILdGUHiy9lN0dZCBbpOl8bJlbGikOEQ==
X-Received: by 2002:a17:90b:4a4d:: with SMTP id
 lb13mr93066pjb.130.1598889991089; 
 Mon, 31 Aug 2020 09:06:31 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/76] target/microblaze: Tidy raising of exceptions
Date: Mon, 31 Aug 2020 09:05:05 -0700
Message-Id: <20200831160601.833692-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Split out gen_raise_exception which does no cpu state sync.
Rename t_gen_raise_exception to gen_raise_exception_sync to
emphasize that it does a sync.  Create gen_raise_hw_excp to
simplify code raising EXCP_HW_EXCP.

Since there is now only one use of cpu_esr, perform a store
instead and remove the TCG variable.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 62 +++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index f5ca25cead..9a00a78b8a 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -57,7 +57,6 @@ static TCGv_i32 env_debug;
 static TCGv_i32 cpu_R[32];
 static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
-static TCGv_i32 cpu_esr;
 static TCGv_i32 env_imm;
 static TCGv_i32 env_btaken;
 static TCGv_i32 cpu_btarget;
@@ -114,17 +113,31 @@ static inline void t_sync_flags(DisasContext *dc)
     }
 }
 
-static inline void t_gen_raise_exception(DisasContext *dc, uint32_t index)
+static void gen_raise_exception(DisasContext *dc, uint32_t index)
 {
     TCGv_i32 tmp = tcg_const_i32(index);
 
-    t_sync_flags(dc);
-    tcg_gen_movi_i32(cpu_pc, dc->pc);
     gen_helper_raise_exception(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
     dc->is_jmp = DISAS_UPDATE;
 }
 
+static void gen_raise_exception_sync(DisasContext *dc, uint32_t index)
+{
+    t_sync_flags(dc);
+    tcg_gen_movi_i32(cpu_pc, dc->pc);
+    gen_raise_exception(dc, index);
+}
+
+static void gen_raise_hw_excp(DisasContext *dc, uint32_t esr_ec)
+{
+    TCGv_i32 tmp = tcg_const_i32(esr_ec);
+    tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUMBState, esr));
+    tcg_temp_free_i32(tmp);
+
+    gen_raise_exception_sync(dc, EXCP_HW_EXCP);
+}
+
 static inline bool use_goto_tb(DisasContext *dc, target_ulong dest)
 {
 #ifndef CONFIG_USER_ONLY
@@ -178,8 +191,7 @@ static bool trap_illegal(DisasContext *dc, bool cond)
 {
     if (cond && (dc->tb_flags & MSR_EE_FLAG)
         && dc->cpu->cfg.illegal_opcode_exception) {
-        tcg_gen_movi_i32(cpu_esr, ESR_EC_ILLEGAL_OP);
-        t_gen_raise_exception(dc, EXCP_HW_EXCP);
+        gen_raise_hw_excp(dc, ESR_EC_ILLEGAL_OP);
     }
     return cond;
 }
@@ -194,8 +206,7 @@ static bool trap_userspace(DisasContext *dc, bool cond)
     bool cond_user = cond && mem_index == MMU_USER_IDX;
 
     if (cond_user && (dc->tb_flags & MSR_EE_FLAG)) {
-        tcg_gen_movi_i32(cpu_esr, ESR_EC_PRIVINSN);
-        t_gen_raise_exception(dc, EXCP_HW_EXCP);
+        gen_raise_hw_excp(dc, ESR_EC_PRIVINSN);
     }
     return cond_user;
 }
@@ -540,7 +551,8 @@ static void dec_msr(DisasContext *dc)
                 }
                 break;
             case SR_ESR:
-                tcg_gen_mov_i32(cpu_esr, cpu_R[dc->ra]);
+                tcg_gen_st_i32(cpu_R[dc->ra],
+                               cpu_env, offsetof(CPUMBState, esr));
                 break;
             case SR_FSR:
                 tcg_gen_st_i32(cpu_R[dc->ra],
@@ -589,7 +601,8 @@ static void dec_msr(DisasContext *dc)
                 }
                 break;
             case SR_ESR:
-                tcg_gen_mov_i32(cpu_R[dc->rd], cpu_esr);
+                tcg_gen_ld_i32(cpu_R[dc->rd],
+                               cpu_env, offsetof(CPUMBState, esr));
                 break;
             case SR_FSR:
                 tcg_gen_ld_i32(cpu_R[dc->rd],
@@ -1258,8 +1271,7 @@ static void dec_br(DisasContext *dc)
 
         /* mbar IMM & 16 decodes to sleep.  */
         if (mbar_imm & 16) {
-            TCGv_i32 tmp_hlt = tcg_const_i32(EXCP_HLT);
-            TCGv_i32 tmp_1 = tcg_const_i32(1);
+            TCGv_i32 tmp_1;
 
             LOG_DIS("sleep\n");
 
@@ -1269,13 +1281,16 @@ static void dec_br(DisasContext *dc)
             }
 
             t_sync_flags(dc);
+
+            tmp_1 = tcg_const_i32(1);
             tcg_gen_st_i32(tmp_1, cpu_env,
                            -offsetof(MicroBlazeCPU, env)
                            +offsetof(CPUState, halted));
-            tcg_gen_movi_i32(cpu_pc, dc->pc + 4);
-            gen_helper_raise_exception(cpu_env, tmp_hlt);
-            tcg_temp_free_i32(tmp_hlt);
             tcg_temp_free_i32(tmp_1);
+
+            tcg_gen_movi_i32(cpu_pc, dc->pc + 4);
+
+            gen_raise_exception(dc, EXCP_HLT);
             return;
         }
         /* Break the TB.  */
@@ -1300,14 +1315,15 @@ static void dec_br(DisasContext *dc)
         tcg_gen_movi_i32(env_btaken, 1);
         tcg_gen_mov_i32(cpu_btarget, *(dec_alu_op_b(dc)));
         if (link && !dslot) {
-            if (!(dc->tb_flags & IMM_FLAG) && (dc->imm == 8 || dc->imm == 0x18))
-                t_gen_raise_exception(dc, EXCP_BREAK);
+            if (!(dc->tb_flags & IMM_FLAG) &&
+                (dc->imm == 8 || dc->imm == 0x18)) {
+                gen_raise_exception_sync(dc, EXCP_BREAK);
+            }
             if (dc->imm == 0) {
                 if (trap_userspace(dc, true)) {
                     return;
                 }
-
-                t_gen_raise_exception(dc, EXCP_DEBUG);
+                gen_raise_exception_sync(dc, EXCP_DEBUG);
             }
         }
     } else {
@@ -1411,8 +1427,7 @@ static void dec_rts(DisasContext *dc)
 static int dec_check_fpuv2(DisasContext *dc)
 {
     if ((dc->cpu->cfg.use_fpu != 2) && (dc->tb_flags & MSR_EE_FLAG)) {
-        tcg_gen_movi_i32(cpu_esr, ESR_EC_FPU);
-        t_gen_raise_exception(dc, EXCP_HW_EXCP);
+        gen_raise_hw_excp(dc, ESR_EC_FPU);
     }
     return (dc->cpu->cfg.use_fpu == 2) ? PVR2_USE_FPU2_MASK : 0;
 }
@@ -1668,8 +1683,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 #endif
 
         if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
-            t_gen_raise_exception(dc, EXCP_DEBUG);
-            dc->is_jmp = DISAS_UPDATE;
+            gen_raise_exception_sync(dc, EXCP_DEBUG);
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
@@ -1874,8 +1888,6 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, pc), "rpc");
     cpu_msr =
         tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, msr), "rmsr");
-    cpu_esr =
-        tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, esr), "resr");
 }
 
 void restore_state_to_opc(CPUMBState *env, TranslationBlock *tb,
-- 
2.25.1


