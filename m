Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F7BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CD02054F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cLry2Aar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CD02054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfIt-000181-Qf
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEW-0000Gz-B8
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:00 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEU-00056T-HU
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:59 -0400
Received: by mail-pf1-x442.google.com with SMTP id k15so722893pfc.12
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HaAnpocjYbBqDikM80fgZOEo5h0cDqsU8in/f2nqeSk=;
 b=cLry2AaricD3MDar6w+kt9ppYYkjP0svhXDsLUgXEoQM4L0Nqv32c8JbH4afPLRNFs
 mVdBMOa+bYLJ+XjRSgtm2YZZ0o4axSUuuDSRuv6gYaR2Cs5qG2RU7HYILej09F3oQ3jE
 hHOwImhD1tQwXHuLK6p8XKtn0I0nL5XJhzfANzMowagxnCXgA+rQ2UYItQ8FAWx9yS5S
 m8kdY2ejjGS97jZ1UDpdtM+9jO93TaONqF78EqtQB7G1lx11c2WPkwgbPKLeKyIyT85Q
 crgPSXRQAuWqZKMNx0bgN7koljgKDV+ojY4malcyYY0oH2Td1Oa06tnvNTEsDz/cvOaZ
 MPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HaAnpocjYbBqDikM80fgZOEo5h0cDqsU8in/f2nqeSk=;
 b=qmehNKcFNXJ4NmnCFGeGqdUD21NVk0xo6bN+SzysUoAcPa/sLi5q5hcF6gkm5GeCIN
 D3dl4Q6oiCmurTJq8wARne99s7CmP7RLttQZMJJQzAmzUR/r9haKK83XfQtRcWIjICtv
 l5506s0cqm7h26n3F6tFqgu4tN70FJqfOyK2flTGVGpaWtkbvhYGdvp6w2lo8r859/Oe
 ijeM0G7aJ08JjRCNNaR0ospHQe+3Z5ugofeHpNe7IVTz+KkuYHMh4Lh/bbUUuDQxoqS0
 vqmSz7qJShT5hQjt3RG2fsSlHvTA+eUzIKxYYjFe9ess9DOEzQaERw+NZH1knYWRf0Au
 1ZiQ==
X-Gm-Message-State: AOAM531e+CaYQHj/ZmbARhQzQ3Gtc97OXw12muMD3F0Y5YlmD6LEJ2CH
 5/uabixdoeurzjClD1IYY/Y7SHFkewFdhQ==
X-Google-Smtp-Source: ABdhPJwE2tQAjn+odpnrJ9x6x2MwylhCYBb0HLHurxtaHCjQAtn0ine3W5UqXnACSkispUVDdd+BIg==
X-Received: by 2002:a62:868b:: with SMTP id x133mr1447643pfd.165.1598624396840; 
 Fri, 28 Aug 2020 07:19:56 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/76] target/microblaze: Remove cpu_ear
Date: Fri, 28 Aug 2020 07:18:32 -0700
Message-Id: <20200828141929.77854-20-richard.henderson@linaro.org>
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

Since cpu_ear is only used during MSR and MTR instructions,
we can just as easily use an explicit load and store, so
eliminate the variable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a862ac4055..f5ca25cead 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -57,7 +57,6 @@ static TCGv_i32 env_debug;
 static TCGv_i32 cpu_R[32];
 static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
-static TCGv_i64 cpu_ear;
 static TCGv_i32 cpu_esr;
 static TCGv_i32 env_imm;
 static TCGv_i32 env_btaken;
@@ -533,7 +532,12 @@ static void dec_msr(DisasContext *dc)
                 msr_write(dc, cpu_R[dc->ra]);
                 break;
             case SR_EAR:
-                tcg_gen_extu_i32_i64(cpu_ear, cpu_R[dc->ra]);
+                {
+                    TCGv_i64 t64 = tcg_temp_new_i64();
+                    tcg_gen_extu_i32_i64(t64, cpu_R[dc->ra]);
+                    tcg_gen_st_i64(t64, cpu_env, offsetof(CPUMBState, ear));
+                    tcg_temp_free_i64(t64);
+                }
                 break;
             case SR_ESR:
                 tcg_gen_mov_i32(cpu_esr, cpu_R[dc->ra]);
@@ -573,10 +577,15 @@ static void dec_msr(DisasContext *dc)
                 msr_read(dc, cpu_R[dc->rd]);
                 break;
             case SR_EAR:
-                if (extended) {
-                    tcg_gen_extrh_i64_i32(cpu_R[dc->rd], cpu_ear);
-                } else {
-                    tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_ear);
+                {
+                    TCGv_i64 t64 = tcg_temp_new_i64();
+                    tcg_gen_ld_i64(t64, cpu_env, offsetof(CPUMBState, ear));
+                    if (extended) {
+                        tcg_gen_extrh_i64_i32(cpu_R[dc->rd], t64);
+                    } else {
+                        tcg_gen_extrl_i64_i32(cpu_R[dc->rd], t64);
+                    }
+                    tcg_temp_free_i64(t64);
                 }
                 break;
             case SR_ESR:
@@ -1865,8 +1874,6 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, pc), "rpc");
     cpu_msr =
         tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, msr), "rmsr");
-    cpu_ear =
-        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear), "rear");
     cpu_esr =
         tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, esr), "resr");
 }
-- 
2.25.1


