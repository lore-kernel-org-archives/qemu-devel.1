Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C693C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C02206CD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiahcZs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C02206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmOU-0004FP-2x
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKJ-0004HC-BG
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:35 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:33295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKF-0005yl-PB
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:34 -0400
Received: by mail-pl1-x62c.google.com with SMTP id h2so3256632plr.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hvfzFSYLvytasBwqaxM3erubgzY88RSzpHLi7SaenA4=;
 b=GiahcZs/EA5dhKX6PkCcQ5TpPE+2Eu7ybM4w5ghbhLDfSCMmiZeexCwg2FDxZHqDTV
 elkA1czuTID4/JoYMi3u6tx4DDyJbAbuh3RM0NSDE/nD5/a1Mv4bqWG1jm23LCrHahm6
 j3jyWZs2DkMraXX9L/zVH+DTAfrrRCZcPKMKWwYPGlRxtRrBR6GXWBxNXYOIt+25x5QS
 0BJGKwjR4n5vgSv9p0Fj046mqhHRawi4vqxEpPIy/QcPaAoVuJr1Lqo5RkN+ezD1sSYg
 lTYhmXEySptsp2PtyWLtMxURYvlPJ7KRACbfOv8CDy3+TeCbdWcnOuUhUI9RFCCu9u4Y
 gWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hvfzFSYLvytasBwqaxM3erubgzY88RSzpHLi7SaenA4=;
 b=btdCqJyp5Q5GzKPcG14zbSPDxVI+dJqsKR+esWMTnQi2gk0hKO0zjtGcJR/jaLFG4v
 MP3lrnS25b2BBACJ/QADFRsCE/WgjesUEUtaJBWemLTSIAy0tO6dIjOrJ1fDBWknsBXq
 s0x9eXVVMIK2drdiSIACYLTmgEFjOBJE4F2SLhZNnWT3o/m9+zS1g8jspmWqLt9bQOD2
 04dWoT99BjrnhmSXwvh5a+88Y8g2NVlCsyUTBjJvFBc/4V8C58l4eLnnWomGnLnEs1QH
 c7W6NEdCy0hNob4ZbgiSp7I+8OrVYPjv9n4M63a/WlYsGSJIedgrmSQ/HQBeR/XYApws
 WuWg==
X-Gm-Message-State: AOAM533vqd9dpxc/CkbrFuPje53tbdJYWDbuhMs3sSamz6wsWUdJElQ4
 YPhBZ1XegKBbbR+69S8aO0kXrob9y/2w5Q==
X-Google-Smtp-Source: ABdhPJyBZgwx7KCqmXjbKoBHRDLey6Cjm3WKI+xxH/mz4QvjJm5qne817Vw2p2s0I0W9nLvfFWdtsQ==
X-Received: by 2002:a17:90b:4d06:: with SMTP id
 mw6mr83686pjb.226.1598889989887; 
 Mon, 31 Aug 2020 09:06:29 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/76] target/microblaze: Remove cpu_ear
Date: Mon, 31 Aug 2020 09:05:04 -0700
Message-Id: <20200831160601.833692-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Since cpu_ear is only used during MSR and MTR instructions,
we can just as easily use an explicit load and store, so
eliminate the variable.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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


