Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B7FC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2D42086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iBbq5da3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2D42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfP7-0004sb-Sb
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfES-000053-1k
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:56 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEQ-00055m-8z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:55 -0400
Received: by mail-pf1-x442.google.com with SMTP id u128so738918pfb.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rMh4Sqcir06bVXs74gHMdeUNg4a+HHCVID7KGWDrg3A=;
 b=iBbq5da3y3P3bezdVkUu9OPfJpyK63bO4IVhTAyq+WdGRc2YD3ImAKPXgra3AWNQhL
 ejfFhS2nKHir1X6glTZt3PHBAh9MzzsSTw45cIV6HNycY93jY1MpK2Kb2wlgUYux4emt
 FgavLe75eqcLpIfUjCQqf5fhwGZXOHbzD7yl6u3cbtV2fRHzohvyBvmN9FUfxNt9qz1p
 dobiF60oM9ohshu3pesTERoPw6ABBGWW6NKbOj7Ot7+J429AdWvEXcImSWZxxs0ddNvU
 TzX9QOw5/LY2pXOHDFo6d9r2/XCJrCJxILyACSSXNghiUKeEFLbjY/yscSdAbeq+n6hi
 wYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rMh4Sqcir06bVXs74gHMdeUNg4a+HHCVID7KGWDrg3A=;
 b=hEITDZl9B/jkjTahpTVR0yFpKooPyF1ALIPZR6mId2s7OITprfxYNfO8fydpK11G5e
 KUlnBuN1dj5etjwB6yCTbB3M4+inAF7JZ8dti2nblDoXVa+ZBQf3peQqRdGr81C3/3fe
 EeDBn5u+E1BcD3Gewl+WC61vucg1c+sB7CL6H+9DeITF7bIfD15aqRzcnBJmwjNhwYyY
 qLkiGwtRVwbNFcGhFeofDquTgu6Y3kXXwIP9eFgvaeGeRP5Djg/bqZP8xYK+xPW2ARkX
 bzF+R12LI2+hzpPfkdoAzOUexcNDDfb3CwRxhMhQHzJ/WQXpX1C8RqvaJcFFd/DBDq/A
 MoXg==
X-Gm-Message-State: AOAM530cWwA26BQpvGL+CfYck4JUaXgDJWSe/gmtU3kYes928YFTrfxj
 ltdsIf358ghD3xKtAo4VnvUOKHuCOY0MTw==
X-Google-Smtp-Source: ABdhPJzgb6JTN2KlMWXA807nUxrGg9eduy2x6nJubmX2RYAqYahntrFDSGoRTcbMhaz5aevIccZBpg==
X-Received: by 2002:a62:1cca:: with SMTP id c193mr1492421pfc.3.1598624392375; 
 Fri, 28 Aug 2020 07:19:52 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/76] target/microblaze: Fix width of FSR
Date: Fri, 28 Aug 2020 07:18:29 -0700
Message-Id: <20200828141929.77854-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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


