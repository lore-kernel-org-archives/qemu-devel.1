Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F72C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FAB206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HbU03IhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FAB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEH85-0006WG-Re
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH50-0001W1-DO
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:08:58 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH4y-0000ny-GV
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:08:58 -0400
Received: by mail-pl1-x642.google.com with SMTP id z15so1591429plo.7
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Lzoy3rQTW8RpzNKU3s0YRAjNrkjr7LKa4OsZvtm8Vk0=;
 b=HbU03IhRAu98U9e5TaKfKNlCunwAL7INMsYlRU4Mi+T3q7Sv4Q/WOwP7KtzsBrBFLY
 xb5LHZJWsDofm1tyQXsajflcgWYEN3gDxxfCvLIquQ+gDWEQZJ1B58onRfb44KJt/vyq
 Y7TU7u+bn+me7an2wWIPn7eSGRMnt3Lls2s8iG1uKP7hhHr0yzV8xjOW9/plmRg0OgXc
 B3TDJ7BnffKANYB1xW01d3QmDVdvfGnFxSSFGiKV/rxDR28t2de4mJ5joF2ewwXtmXyT
 zmM03O67aMjIYeE9wC5fZCAPSX7T7XiiKO+d4c4255HRvJMBGw0HZLYijozZ5FgqT/Y9
 4knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Lzoy3rQTW8RpzNKU3s0YRAjNrkjr7LKa4OsZvtm8Vk0=;
 b=WLavaMA3IYepjZOV+7WDUKIyyPdS6e2bPpz+4p6xF7onWLhJV9t/2Te0NEM2RVuXTH
 CqIvQI7AUur1+OGeruKoXAD1BX+S7z3PesqXDXHe4erWVWNVSAw7B9wlXklgTIsElC62
 p015XEUyJucs10CZinzSS9ZpAQCDV+1sjmztiupnRWhaA8sfBM/sqvVvRsUM9mzv8KgY
 Y9zWX7aai02rM2kQqLkuQ5gfgxABQoaiY0sNbm/0Nfb9xfpzgJMe74PyLVFd1WBQQSZm
 knal5nSZHBb58MJ2QvTQjc++35Qqhtjw/A3L91kz/OF3Pt/TN5tbM3XkvG+sQBGnhgX5
 bRmw==
X-Gm-Message-State: AOAM5305FDvYmcOiQsUYzqhCLBMrR088pp0pwou1sOwuIVJ1oGBfhW/g
 aUUhEtAuvfgpu4nGAODIt38pGkNKEXKG9Q==
X-Google-Smtp-Source: ABdhPJzLWTATVudAHtf4uhShZ+pFHIM/1idAyJ3KEjFlMewPMYpWzaMUTp88Ar/Q5tN2gBoesGaSdQ==
X-Received: by 2002:a17:90b:693:: with SMTP id
 m19mr9211007pjz.111.1599246534409; 
 Fri, 04 Sep 2020 12:08:54 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm1897941pge.22.2020.09.04.12.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 12:08:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/19] target/microblaze: Replace cpustate_changed with
 DISAS_EXIT_NEXT
Date: Fri,  4 Sep 2020 12:08:30 -0700
Message-Id: <20200904190842.2282109-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904190842.2282109-1-richard.henderson@linaro.org>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: edgar.iglesias@xilinx.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than look for the combination of DISAS_NEXT with a separate
variable, go ahead and set is_jmp to the desired state.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 2abef328a3..6bf299a826 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -70,7 +70,6 @@ typedef struct DisasContext {
 
     /* Decoder.  */
     uint32_t ext_imm;
-    unsigned int cpustate_changed;
     unsigned int tb_flags;
     unsigned int tb_flags_to_set;
     int mem_index;
@@ -1255,7 +1254,7 @@ static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
      *
      * Therefore, choose to end the TB always.
      */
-    dc->cpustate_changed = 1;
+    dc->base.is_jmp = DISAS_EXIT_NEXT;
     return true;
 }
 
@@ -1307,19 +1306,6 @@ static void msr_read(DisasContext *dc, TCGv_i32 d)
     tcg_temp_free_i32(t);
 }
 
-#ifndef CONFIG_USER_ONLY
-static void msr_write(DisasContext *dc, TCGv_i32 v)
-{
-    dc->cpustate_changed = 1;
-
-    /* Install MSR_C.  */
-    tcg_gen_extract_i32(cpu_msr_c, v, 2, 1);
-
-    /* Clear MSR_C and MSR_CC; MSR_PVR is not writable, and is always clear. */
-    tcg_gen_andi_i32(cpu_msr, v, ~(MSR_C | MSR_CC | MSR_PVR));
-}
-#endif
-
 static bool do_msrclrset(DisasContext *dc, arg_type_msr *arg, bool set)
 {
     uint32_t imm = arg->imm;
@@ -1352,7 +1338,7 @@ static bool do_msrclrset(DisasContext *dc, arg_type_msr *arg, bool set)
         } else {
             tcg_gen_andi_i32(cpu_msr, cpu_msr, ~imm);
         }
-        dc->cpustate_changed = 1;
+        dc->base.is_jmp = DISAS_EXIT_NEXT;
     }
     return true;
 }
@@ -1385,7 +1371,13 @@ static bool trans_mts(DisasContext *dc, arg_mts *arg)
     TCGv_i32 src = reg_for_read(dc, arg->ra);
     switch (arg->rs) {
     case SR_MSR:
-        msr_write(dc, src);
+        /* Install MSR_C.  */
+        tcg_gen_extract_i32(cpu_msr_c, src, 2, 1);
+        /*
+         * Clear MSR_C and MSR_CC;
+         * MSR_PVR is not writable, and is always clear.
+         */
+        tcg_gen_andi_i32(cpu_msr, src, ~(MSR_C | MSR_CC | MSR_PVR));
         break;
     case SR_FSR:
         tcg_gen_st_i32(src, cpu_env, offsetof(CPUMBState, fsr));
@@ -1417,7 +1409,7 @@ static bool trans_mts(DisasContext *dc, arg_mts *arg)
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid mts reg 0x%x\n", arg->rs);
         return true;
     }
-    dc->cpustate_changed = 1;
+    dc->base.is_jmp = DISAS_EXIT_NEXT;
     return true;
 #endif
 }
@@ -1629,7 +1621,6 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 
     dc->cpu = cpu;
     dc->tb_flags = dc->base.tb->flags;
-    dc->cpustate_changed = 0;
     dc->ext_imm = dc->base.tb->cs_base;
     dc->r0 = NULL;
     dc->r0_set = false;
@@ -1714,11 +1705,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         }
         dc->base.is_jmp = DISAS_JUMP;
     }
-
-    /* Force an exit if the per-tb cpu state has changed.  */
-    if (dc->base.is_jmp == DISAS_NEXT && dc->cpustate_changed) {
-        dc->base.is_jmp = DISAS_EXIT_NEXT;
-    }
 }
 
 static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
-- 
2.25.1


