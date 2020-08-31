Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C06DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA87A20767
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cd4Tt9Ej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA87A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmMm-0000pT-Uj
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKH-0004B5-14
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:33 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:52758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKE-0005yU-HE
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:32 -0400
Received: by mail-pj1-x1029.google.com with SMTP id o16so28034pjr.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a0lsjfSJGV5n3EJZlHS5Bf00XbvDVFjsqHd/6iA5EWQ=;
 b=cd4Tt9EjTc04eHfBPpNFdFwM2EJFVGUleFLVKLO/1Xn7FKNJXOJQ45ms7tdsgp8drQ
 mTKbN1+3yAnbzMYmC4YWufv8uTwjl2AVYRqn6F4D/zFDWn2dhxdrGJo+jmYz25C9KLU8
 fsUf1hE40hAAn8C5Rg75cjhO08XGmJTr5E+T83LXDD5ZOrrQKeVRshE1BwsIvw2DNiGO
 2SHMeXoaO8E7YBTSGZgeZuaGS//iIs5mO41ATcB+kfvsg2hpK8JsuQPlIhmt8JMNsDw2
 2XanwJMvtvBU0ebC+Q74Acj1PjY++ZRbcnN2ZiD/Rvoi5fVKd/6PKJgnteEqQ/k6Rdws
 dPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a0lsjfSJGV5n3EJZlHS5Bf00XbvDVFjsqHd/6iA5EWQ=;
 b=do9AjA8NABMrixZjA414emnwyFbBUuDzmhqlbGiKpZzbsKI6gVCS8f7pAna0WDfDwO
 X34kLdDvbjuDyjeX5vyOTArERRosoFOhSkYNu+bqxldDHTtamwVmI4nlk3UqW5IpDX6p
 eY5258Od2Wo2MnDvpdSlCPwSewJWS8T7DEV6f94lPIiRmykfoQMh/Zqm68MPYd/F2mvL
 9sOSd/P5ZIOJlyF3IWOPWbzftDEap+jnicfi7WGjgpxN9D+umk4+qpybENu/KI5EObYX
 j9Vel1zjBuhL6curOPvVSYjUASmam54q+RhsHzqjV0zVmwORDq3KrF985eA7T1SUm8Cz
 07JA==
X-Gm-Message-State: AOAM532S6BwPxH3x/YGFXQr1ICRuxsCrChbs5q4gJ68XusQO9sgTTaBy
 SGOMMgzThAe5yAdEP6rxT7YfN5eeW+LJMg==
X-Google-Smtp-Source: ABdhPJyNSUFPtm6IqJUHlj9ECtbC3oA/zZHRoIxvo1r615LItH1WI7zErZmrVS5awPZrIrY0CJPAGg==
X-Received: by 2002:a17:90a:5a48:: with SMTP id m8mr61640pji.181.1598889988664; 
 Mon, 31 Aug 2020 09:06:28 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/76] target/microblaze: Fix width of EDR
Date: Mon, 31 Aug 2020 09:05:03 -0700
Message-Id: <20200831160601.833692-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

The exception data register is only 32-bits wide.  Do not use a
64-bit type to represent it.  Since cpu_edr is only used during
MSR and MTR instructions, we can just as easily use an explicit
load and store, so eliminate the variable.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  2 +-
 target/microblaze/translate.c | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 72f068a5fd..b88acba12b 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -242,7 +242,7 @@ struct CPUMBState {
     uint32_t esr;
     uint32_t fsr;
     uint32_t btr;
-    uint64_t edr;
+    uint32_t edr;
     float_status fp_status;
     /* Stack protectors. Yes, it's a hw feature.  */
     uint32_t slr, shr;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a2bba0fe61..a862ac4055 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -59,7 +59,6 @@ static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
 static TCGv_i64 cpu_ear;
 static TCGv_i32 cpu_esr;
-static TCGv_i64 cpu_edr;
 static TCGv_i32 env_imm;
 static TCGv_i32 env_btaken;
 static TCGv_i32 cpu_btarget;
@@ -548,7 +547,8 @@ static void dec_msr(DisasContext *dc)
                                cpu_env, offsetof(CPUMBState, btr));
                 break;
             case SR_EDR:
-                tcg_gen_extu_i32_i64(cpu_edr, cpu_R[dc->ra]);
+                tcg_gen_st_i32(cpu_R[dc->ra],
+                               cpu_env, offsetof(CPUMBState, edr));
                 break;
             case 0x800:
                 tcg_gen_st_i32(cpu_R[dc->ra],
@@ -591,7 +591,8 @@ static void dec_msr(DisasContext *dc)
                                cpu_env, offsetof(CPUMBState, btr));
                 break;
             case SR_EDR:
-                tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_edr);
+                tcg_gen_ld_i32(cpu_R[dc->rd],
+                               cpu_env, offsetof(CPUMBState, edr));
                 break;
             case 0x800:
                 tcg_gen_ld_i32(cpu_R[dc->rd],
@@ -1818,7 +1819,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 
     /* Registers that aren't modeled are reported as 0 */
-    qemu_fprintf(f, "redr=%" PRIx64 " rpid=0 rzpr=0 rtlbx=0 rtlbsx=0 "
+    qemu_fprintf(f, "redr=%x rpid=0 rzpr=0 rtlbx=0 rtlbsx=0 "
                     "rtlblo=0 rtlbhi=0\n", env->edr);
     qemu_fprintf(f, "slr=%x shr=%x\n", env->slr, env->shr);
     for (i = 0; i < 32; i++) {
@@ -1868,8 +1869,6 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear), "rear");
     cpu_esr =
         tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, esr), "resr");
-    cpu_edr =
-        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, edr), "redr");
 }
 
 void restore_state_to_opc(CPUMBState *env, TranslationBlock *tb,
-- 
2.25.1


