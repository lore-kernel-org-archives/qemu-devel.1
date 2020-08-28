Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B247FC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6632078A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WAv9b7bU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6632078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfKn-0004Wp-Ms
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEY-0000Lg-3n
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:02 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEV-00056b-Vu
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:01 -0400
Received: by mail-pj1-x1044.google.com with SMTP id g6so572283pjl.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z4AmITk5w2LQx1h3BHbpZiArbCayMAaSAdvlTGNWCzo=;
 b=WAv9b7bUW5/qLq4riFvb2UCvmxlH4qtzUxA+pQ5edWjXSpavzfURH6fGceg8Z3f3uI
 xH/MK/ro9KulZ1V0aSvJUqOHzZ3Y27iEAh49j4V7vl/PZds768DqwUSERFtsGQoHP6UM
 rK6umV/OrCYS4cWWhOpN+nBYJeH/p+YIO3T5Khw/84WNXTJ8x2ajetTan/OzsjkEv/Bn
 JrvPa0IfioalZPNcasyzO+KftGPTQ9HOV8Oa48lclaURMCVtvLjYuGY4J7jUjmj7AjQp
 bzcI74BP/MQ+mPITjPURpB8Pq5RkaxX2GELILFSsVPBpuZfr9IWABhXAmi49kg3wO5ta
 jeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z4AmITk5w2LQx1h3BHbpZiArbCayMAaSAdvlTGNWCzo=;
 b=gtjIASV1WrIWwl8iPfLzsuNtCggnmHsXC0XVvz7Z4G0RISeq+sk+jeLczMpKAs085M
 /aO+vz4lnKakBH/jHQnEpHS8APGNfDHcCKVm1PoJchDW1MMEXnrvYzR1mKTzjAV3C+Ld
 QENbTa1/aTc6qv7yJpjf3u//knq6efeb952e05G2nnRqCyKZebV6HhavnngNkOX/YY15
 UW8KSzu6H+BBY4XvRLS9GmKJCC8pIiEo0YSCyXjONXPOrr1KbgkGybzlQ/w+gYhbvGHT
 Z/ZbwjAfo3MSNoTCrnAX7G/z6pHsMHEXvO+4VkI7T8ZvXZQxzNoES1kpEmXWVm0Tq9En
 e1wg==
X-Gm-Message-State: AOAM530VwO5BSP+CMyeVyz+Oq4g13yjgiFp1NVXTs6l18463d6jCJRJ8
 3kMzx4nS6vP+rA4Dj1sVYhMBs6UWvI7YmQ==
X-Google-Smtp-Source: ABdhPJyDpYYi2BYtiMGb8wTPa/nqXp3C7W7Fv5s9aN13AyH4M2lXRrVX29aIXK/8SH04gqe6D71kRg==
X-Received: by 2002:a17:90a:ec03:: with SMTP id
 l3mr1379319pjy.193.1598624398119; 
 Fri, 28 Aug 2020 07:19:58 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 20/76] target/microblaze: Tidy raising of exceptions
Date: Fri, 28 Aug 2020 07:18:33 -0700
Message-Id: <20200828141929.77854-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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

Split out gen_raise_exception which does no cpu state sync.
Rename t_gen_raise_exception to gen_raise_exception_sync to
emphasize that it does a sync.  Create gen_raise_hw_excp to
simplify code raising EXCP_HW_EXCP.

Since there is now only one use of cpu_esr, perform a store
instead and remove the TCG variable.

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


