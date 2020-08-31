Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74C5C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD31B2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6H9RCuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD31B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmT9-0006fn-Q7
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKF-00047A-JS
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:31 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:54430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKD-0005yF-8J
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:31 -0400
Received: by mail-pj1-x1036.google.com with SMTP id mm21so22366pjb.4
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5ShF+BY48IwWmImvy13quKmLT6LR29ss78JGb2qClWk=;
 b=e6H9RCuEKvAL+dLt6N7M3C0TcE2anGkJN9Z91jPzXhZEYoyYmMu+DD394dp6CGlApu
 04cwemSEhZ2q1QcrIrjbuCpF6UIYoMB0TiSyRGLGpA18eKJDefax0/LMj3p2E1STxzJl
 Ea5aPjD8n+Wgf4rrgXORlgUeHQxlwuAdLlqXDk+MPTwPLUzO3mXJJmt5aTijoZGS6UHw
 oSjpkmCMsA5kUNJKBty02udS1fhu9CVDsgiJnA62EUF/XB5A3Rucgu8MkG2IQhHIb7F3
 Qa2KDzaelkVfWP2a7nE/MfMSN5PxO8cq9IeMLHdiqo0bDK4vU/di/xkk5u6XJVj4j2Zp
 8cSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5ShF+BY48IwWmImvy13quKmLT6LR29ss78JGb2qClWk=;
 b=Fd7tInKS2d4TOR5LZQFEOY+e8WZzXah8nQTz7AWQ0W+bvKmbYgV0DIOSs2pP+dV8fn
 FdDQTGUPNxNYkseXfp0vT2gJ21EV+sB0O21kI83t9wepb4+vXZzvynLMxa0AFKR7mfIi
 tLSMvfAkYZEvKjVnmcpeDSaMai3xMDoPmF67A2QSj7eNCF2MU4SXyD9BNTJElTQhzP4y
 sMjaHEIO4/w1rL5Wn/XZudWi+cNL/kbGwmg7CBTib/5FK6QdzstLJao6zbzgi0YzL2OO
 gYPAiGgX3IoQBqx5FhF2pppzm00MhwmoGr3JKLPOGoxQSsqE/ZuKgYuMl4CMJbzeLd+S
 rVHA==
X-Gm-Message-State: AOAM531xR2KIO2fDfW25A3XbZ6QXaVSOxPAyT2b+uynIGRmXVwwyknBH
 OQrlN907chO/nufb2yQh23QNSi1YOpbogg==
X-Google-Smtp-Source: ABdhPJxCaqwX9QsYEty3dBpZh2Z/R7ki45b2FnDnfSB5RFyz2eyXmeRUoV1C9sE4pXwTbqBU/Ixn+Q==
X-Received: by 2002:a17:902:6ac3:: with SMTP id
 i3mr1591333plt.21.1598889987492; 
 Mon, 31 Aug 2020 09:06:27 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/76] target/microblaze: Fix width of BTR
Date: Mon, 31 Aug 2020 09:05:02 -0700
Message-Id: <20200831160601.833692-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

The branch target register is only 32-bits wide.  Do not use a
64-bit type to represent it.  Since cpu_btr is only used during
MSR and MTR instructions, we can just as easily use an explicit
load and store, so eliminate the variable.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  2 +-
 target/microblaze/translate.c | 12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 34177f9b28..72f068a5fd 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -241,7 +241,7 @@ struct CPUMBState {
     uint64_t ear;
     uint32_t esr;
     uint32_t fsr;
-    uint64_t btr;
+    uint32_t btr;
     uint64_t edr;
     float_status fp_status;
     /* Stack protectors. Yes, it's a hw feature.  */
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 3fc2feda3d..a2bba0fe61 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -59,7 +59,6 @@ static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
 static TCGv_i64 cpu_ear;
 static TCGv_i32 cpu_esr;
-static TCGv_i64 cpu_btr;
 static TCGv_i64 cpu_edr;
 static TCGv_i32 env_imm;
 static TCGv_i32 env_btaken;
@@ -545,7 +544,8 @@ static void dec_msr(DisasContext *dc)
                                cpu_env, offsetof(CPUMBState, fsr));
                 break;
             case SR_BTR:
-                tcg_gen_extu_i32_i64(cpu_btr, cpu_R[dc->ra]);
+                tcg_gen_st_i32(cpu_R[dc->ra],
+                               cpu_env, offsetof(CPUMBState, btr));
                 break;
             case SR_EDR:
                 tcg_gen_extu_i32_i64(cpu_edr, cpu_R[dc->ra]);
@@ -587,7 +587,8 @@ static void dec_msr(DisasContext *dc)
                                cpu_env, offsetof(CPUMBState, fsr));
                 break;
             case SR_BTR:
-                tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_btr);
+                tcg_gen_ld_i32(cpu_R[dc->rd],
+                               cpu_env, offsetof(CPUMBState, btr));
                 break;
             case SR_EDR:
                 tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_edr);
@@ -1799,8 +1800,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "IN: PC=%x %s\n",
                  env->pc, lookup_symbol(env->pc));
     qemu_fprintf(f, "rmsr=%x resr=%x rear=%" PRIx64 " "
-                 "debug=%x imm=%x iflags=%x fsr=%x "
-                 "rbtr=%" PRIx64 "\n",
+                 "debug=%x imm=%x iflags=%x fsr=%x rbtr=%x\n",
                  env->msr, env->esr, env->ear,
                  env->debug, env->imm, env->iflags, env->fsr,
                  env->btr);
@@ -1868,8 +1868,6 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear), "rear");
     cpu_esr =
         tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, esr), "resr");
-    cpu_btr =
-        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, btr), "rbtr");
     cpu_edr =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, edr), "redr");
 }
-- 
2.25.1


