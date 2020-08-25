Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3503C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7122020665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLeGcz39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7122020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgFP-0000yA-KQ
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3F-0007OW-6c
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:17 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3C-0001gw-OZ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:16 -0400
Received: by mail-pg1-x543.google.com with SMTP id o13so7688800pgf.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rMh4Sqcir06bVXs74gHMdeUNg4a+HHCVID7KGWDrg3A=;
 b=pLeGcz39VQ2b4YB7GhbRNmfrp8ZshjAHxpsJAi3TKvDx5mX+YuHdarLDS9gIsv/sxi
 3fJYgbkzWbQYgfaRtPCcm1+taontYWQY3lp3Ciw2/N9GPWu51+JaVLVOqso9GqAMvpaT
 IsgNHN61Oh9WOBGhN3Oqfkod9DDsLACn7u4p//HC6B59Cw+UvFEGue8B5rxLZFVjbtDc
 UhUBWHlFc8Aose560U9udDL94QTStqVVWUoMp92xUxykDHZvWAnt1MK3Tu1KuW6l7IfG
 ErcVlTqE2QwZpwnCMuzLxLjxGxOOvNc3QdK7l2QwZ1rsLKehkV9ak1WKQRwJlpMQ5mH5
 x4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rMh4Sqcir06bVXs74gHMdeUNg4a+HHCVID7KGWDrg3A=;
 b=LWHKvs0W96QUu3a9qK2VGAUt+/tnPNH4pN8TzR3msaCpTXe7h29yREuPcIcbYJ9fzN
 zNVB/h4S7P/mSKgm1R2hp5krQcf9d2iWgidU0uF7RPDJlbkUaKiSHwp36t60Z+XymIK8
 66L2+x2xOjtPUupd+8q2l6ncFeG7P3PQSTJO4miYMo4Q90XSNVzt4zOIboqsVbCYAC3y
 ZwFXs7ep99kf8k83PBuTkyjoQwm/XAqQdKu9M9TUpmbjawX2vDaP5MYRgQISloD1QaF6
 lwiqNrnv4mLpyhHEreh5ylnXFu+8BHILDngiVEpQkbRDcpSb8NO6CLyEjJ6fXghhZfG/
 vqFg==
X-Gm-Message-State: AOAM531mbRgCMrf8Ld1NlgvsdtxVp0uZfy3D31ytFHGKFcVuGs9aIac9
 05CBou7N0tZL7+hZF4Z0RtrzqWv7yXbscg==
X-Google-Smtp-Source: ABdhPJwQfSmOTc87ZFy2jjnDiDsKnD6jMgFr5+ddYoRPEWZNN3gXdlXodjX5PITbaiq1zqGkfYHyrw==
X-Received: by 2002:aa7:96c8:: with SMTP id h8mr6386665pfq.108.1598389212946; 
 Tue, 25 Aug 2020 14:00:12 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/77] target/microblaze: Fix width of FSR
Date: Tue, 25 Aug 2020 13:58:49 -0700
Message-Id: <20200825205950.730499-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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

The exception status register is only 32-bits wide.  Do not use a
64-bit type to represent it.  Since cpu_fsr is only used during
MSR and MTR instructions, we can just as easily use an explicit
load and store, so eliminate the variable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  2 +-
 target/microblaze/translate.c | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index aaac0c9a6c..34177f9b28 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -240,7 +240,7 @@ struct CPUMBState {
     uint32_t msr;
     uint64_t ear;
     uint32_t esr;
-    uint64_t fsr;
+    uint32_t fsr;
     uint64_t btr;
     uint64_t edr;
     float_status fp_status;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index f63aae6de9..3fc2feda3d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -59,7 +59,6 @@ static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
 static TCGv_i64 cpu_ear;
 static TCGv_i32 cpu_esr;
-static TCGv_i64 cpu_fsr;
 static TCGv_i64 cpu_btr;
 static TCGv_i64 cpu_edr;
 static TCGv_i32 env_imm;
@@ -542,7 +541,8 @@ static void dec_msr(DisasContext *dc)
                 tcg_gen_mov_i32(cpu_esr, cpu_R[dc->ra]);
                 break;
             case SR_FSR:
-                tcg_gen_extu_i32_i64(cpu_fsr, cpu_R[dc->ra]);
+                tcg_gen_st_i32(cpu_R[dc->ra],
+                               cpu_env, offsetof(CPUMBState, fsr));
                 break;
             case SR_BTR:
                 tcg_gen_extu_i32_i64(cpu_btr, cpu_R[dc->ra]);
@@ -583,7 +583,8 @@ static void dec_msr(DisasContext *dc)
                 tcg_gen_mov_i32(cpu_R[dc->rd], cpu_esr);
                 break;
             case SR_FSR:
-                tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_fsr);
+                tcg_gen_ld_i32(cpu_R[dc->rd],
+                               cpu_env, offsetof(CPUMBState, fsr));
                 break;
             case SR_BTR:
                 tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_btr);
@@ -1798,7 +1799,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "IN: PC=%x %s\n",
                  env->pc, lookup_symbol(env->pc));
     qemu_fprintf(f, "rmsr=%x resr=%x rear=%" PRIx64 " "
-                 "debug=%x imm=%x iflags=%x fsr=%" PRIx64 " "
+                 "debug=%x imm=%x iflags=%x fsr=%x "
                  "rbtr=%" PRIx64 "\n",
                  env->msr, env->esr, env->ear,
                  env->debug, env->imm, env->iflags, env->fsr,
@@ -1867,8 +1868,6 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear), "rear");
     cpu_esr =
         tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, esr), "resr");
-    cpu_fsr =
-        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, fsr), "rfsr");
     cpu_btr =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, btr), "rbtr");
     cpu_edr =
-- 
2.25.1


