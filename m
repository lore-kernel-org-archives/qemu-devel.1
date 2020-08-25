Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042BDC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA80120665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K6wHwI9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA80120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgEK-0007Rn-1W
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3D-0007L2-GY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:15 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3B-0001gd-3t
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:15 -0400
Received: by mail-pg1-x544.google.com with SMTP id p37so7680752pgl.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+nsIkr2WvIp6my21gJ25pABEfOsk+UM0/dRmzACDNzE=;
 b=K6wHwI9OOKLE2O4HOnH6UdJUAi8ehWCjGroGwu7CDdLLiM80Dg4mtSAedJSVB0zezC
 VgRH2So8yKIA21R7VzN7VNzk2yCmpYW+21HXK/RPY9JTfojWnGvrQn78n+aKA+kolhiU
 48DOa1Gpj75m6mDJ9+gPIjmwhpfmxuOlGgsScq2WuexrtlCRRxyXNC71AvEjriSH0/ZA
 zwxZ8/ecrgowB1INkNGrhsLotmulDYhIFUsMKubCh8eDOYLeDfQdiNLzMMUIR3RQkg0b
 VvPRR//MJsWeLxA2N2YBfo1yTCGTyUKISIBehA1l7dzGrsINpCuCFcBtg+86TeGdIXLL
 He5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+nsIkr2WvIp6my21gJ25pABEfOsk+UM0/dRmzACDNzE=;
 b=uUMBvdGl7DW1fQ7vbezoewnGPq23VDJIYuPiquk+X86ExJmxx1AYPrTbPsDn1S2cyg
 TOpleWgjj8bLJwBwzRMpHddShjSArGeLjzWpJXhFWbniYajCKvZtyV6h4pwOeH5m7IWW
 epGiO/UoGoJpUV7KrhjXfP1eIGd30q4kBFbK325f+SAV2hFrOJ1mNxQpYB07dpe8Plsx
 B/VbfBTa1OFiE+uVnjIClHFGiRfJAu4wGCw8iQs2wNdpwnVRztSzLMMt8ohnxKf7gQvN
 Dr74vfHBqeWe5d30PnFHlBnKwXsHmYcVAAigNajAJtOCaM/1OmWW7cMSiMLUKxmHWDlz
 wB3w==
X-Gm-Message-State: AOAM533KFc3Hbhz8C30T2c3Kke1NUdA3ChYlU6IKkoAkJ6Yf7SHk/x+d
 KLQcNhT0GZZDkqS3CgB0d+tMkFcUYyOJKw==
X-Google-Smtp-Source: ABdhPJw9r3wzV6gkJU3+haj+A8gqGg8cApnEOwF7JXWuo9uCrPyhg29T9OeiFeSPc0T5piGhjqE84A==
X-Received: by 2002:a05:6a00:14d0:: with SMTP id
 w16mr9327023pfu.39.1598389211180; 
 Tue, 25 Aug 2020 14:00:11 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/77] target/microblaze: Fix width of ESR
Date: Tue, 25 Aug 2020 13:58:48 -0700
Message-Id: <20200825205950.730499-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The exception status register is only 32-bits wide.
Do not use a 64-bit type to represent it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h          |  2 +-
 linux-user/microblaze/cpu_loop.c |  2 +-
 target/microblaze/helper.c       |  2 +-
 target/microblaze/op_helper.c    |  2 +-
 target/microblaze/translate.c    | 16 ++++++++--------
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 019e5dfa26..aaac0c9a6c 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -239,7 +239,7 @@ struct CPUMBState {
     uint32_t pc;
     uint32_t msr;
     uint64_t ear;
-    uint64_t esr;
+    uint32_t esr;
     uint64_t fsr;
     uint64_t btr;
     uint64_t edr;
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index da5e98b784..3de99ea311 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -106,7 +106,7 @@ void cpu_loop(CPUMBState *env)
                     queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
                     break;
                 default:
-                    fprintf(stderr, "Unhandled hw-exception: 0x%" PRIx64 "\n",
+                    fprintf(stderr, "Unhandled hw-exception: 0x%x\n",
                             env->esr & ESR_EC_MASK);
                     cpu_dump_state(cs, stderr, 0);
                     exit(EXIT_FAILURE);
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index af79091fd2..b2373f6a23 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -144,7 +144,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
 
             qemu_log_mask(CPU_LOG_INT,
                           "hw exception at pc=%x ear=%" PRIx64 " "
-                          "esr=%" PRIx64 " iflags=%x\n",
+                          "esr=%x iflags=%x\n",
                           env->pc, env->ear,
                           env->esr, env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index a7f6cb71f1..dc2bec0c99 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -76,7 +76,7 @@ void helper_debug(CPUMBState *env)
     int i;
 
     qemu_log("PC=%08x\n", env->pc);
-    qemu_log("rmsr=%x resr=%" PRIx64 " rear=%" PRIx64 " "
+    qemu_log("rmsr=%x resr=%x rear=%" PRIx64 " "
              "debug[%x] imm=%x iflags=%x\n",
              env->msr, env->esr, env->ear,
              env->debug, env->imm, env->iflags);
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0e71e7ed01..f63aae6de9 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -58,7 +58,7 @@ static TCGv_i32 cpu_R[32];
 static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
 static TCGv_i64 cpu_ear;
-static TCGv_i64 cpu_esr;
+static TCGv_i32 cpu_esr;
 static TCGv_i64 cpu_fsr;
 static TCGv_i64 cpu_btr;
 static TCGv_i64 cpu_edr;
@@ -182,7 +182,7 @@ static bool trap_illegal(DisasContext *dc, bool cond)
 {
     if (cond && (dc->tb_flags & MSR_EE_FLAG)
         && dc->cpu->cfg.illegal_opcode_exception) {
-        tcg_gen_movi_i64(cpu_esr, ESR_EC_ILLEGAL_OP);
+        tcg_gen_movi_i32(cpu_esr, ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
     return cond;
@@ -198,7 +198,7 @@ static bool trap_userspace(DisasContext *dc, bool cond)
     bool cond_user = cond && mem_index == MMU_USER_IDX;
 
     if (cond_user && (dc->tb_flags & MSR_EE_FLAG)) {
-        tcg_gen_movi_i64(cpu_esr, ESR_EC_PRIVINSN);
+        tcg_gen_movi_i32(cpu_esr, ESR_EC_PRIVINSN);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
     return cond_user;
@@ -539,7 +539,7 @@ static void dec_msr(DisasContext *dc)
                 tcg_gen_extu_i32_i64(cpu_ear, cpu_R[dc->ra]);
                 break;
             case SR_ESR:
-                tcg_gen_extu_i32_i64(cpu_esr, cpu_R[dc->ra]);
+                tcg_gen_mov_i32(cpu_esr, cpu_R[dc->ra]);
                 break;
             case SR_FSR:
                 tcg_gen_extu_i32_i64(cpu_fsr, cpu_R[dc->ra]);
@@ -580,7 +580,7 @@ static void dec_msr(DisasContext *dc)
                 }
                 break;
             case SR_ESR:
-                tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_esr);
+                tcg_gen_mov_i32(cpu_R[dc->rd], cpu_esr);
                 break;
             case SR_FSR:
                 tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_fsr);
@@ -1399,7 +1399,7 @@ static void dec_rts(DisasContext *dc)
 static int dec_check_fpuv2(DisasContext *dc)
 {
     if ((dc->cpu->cfg.use_fpu != 2) && (dc->tb_flags & MSR_EE_FLAG)) {
-        tcg_gen_movi_i64(cpu_esr, ESR_EC_FPU);
+        tcg_gen_movi_i32(cpu_esr, ESR_EC_FPU);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
     return (dc->cpu->cfg.use_fpu == 2) ? PVR2_USE_FPU2_MASK : 0;
@@ -1797,7 +1797,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
     qemu_fprintf(f, "IN: PC=%x %s\n",
                  env->pc, lookup_symbol(env->pc));
-    qemu_fprintf(f, "rmsr=%x resr=%" PRIx64 " rear=%" PRIx64 " "
+    qemu_fprintf(f, "rmsr=%x resr=%x rear=%" PRIx64 " "
                  "debug=%x imm=%x iflags=%x fsr=%" PRIx64 " "
                  "rbtr=%" PRIx64 "\n",
                  env->msr, env->esr, env->ear,
@@ -1866,7 +1866,7 @@ void mb_tcg_init(void)
     cpu_ear =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear), "rear");
     cpu_esr =
-        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, esr), "resr");
+        tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, esr), "resr");
     cpu_fsr =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, fsr), "rfsr");
     cpu_btr =
-- 
2.25.1


