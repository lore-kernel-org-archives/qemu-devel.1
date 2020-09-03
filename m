Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47A1C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C1E20737
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwaQf6lM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C1E20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjfB-0004A2-CK
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDjeE-00023d-KT
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:27:06 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDjeC-0001mL-QM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:27:06 -0400
Received: by mail-pj1-x1041.google.com with SMTP id 2so1075588pjx.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Lzoy3rQTW8RpzNKU3s0YRAjNrkjr7LKa4OsZvtm8Vk0=;
 b=WwaQf6lMQ7SxmmV3QVyMP4oKA7DAdsIOQfDxRyv3au9XTMaJQVterawNKG7hNNwwWt
 URMOjYvJQCwUb6E4kO8AOQCQEHXH1n2OFWd1GP6FPKQ45+91WktjvUqUeJLMVedqZPKS
 1u06lcXDODoIDh4gllTvhRfguZMIpiXRhD6TflxsK8LFAaS2m+NVp7KfEJ8zBglaSJvx
 z400FJb4cmmvvj7rBjtLVJlxsnu9M4qX+I4oMECYVX0NzlctUBLsBIbAYNgadP+/Zi8I
 Bqr2mOx5e9V35SQVCEUcMRs1puZfj9UNx860He6Ylo4yr2limrVLsD7anWfLf1Fd070c
 F2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Lzoy3rQTW8RpzNKU3s0YRAjNrkjr7LKa4OsZvtm8Vk0=;
 b=cheiPMNuKSYq89/v9Ce8uP2EgH+DsWixqMQLqoSbJ7DBB8GRHUng5S7/oPvYxzuQkI
 7XIZuNKnRUYNflqgyFreCUk2F5QCK4QEW/SwufyYoD38x+uYTajI9rpxGIElSKx+/XNb
 rI7TdXGyjeOqnSYhJ0SWoAWgNgo43dSAgQLv0CoSACuG/vqWtXLpzDuTrB70APB2izUB
 AQD907pFUpLfz/CxNzpx97vE6kDx4PORxlTS5xcoCIaGDn0qu2nGyoYZnx6q+VrtCXjM
 BL+FH/dnxLHc9ezvzXLyNakWzWERD6MRObgL20pllimDsxzMBvGEcphlB4jDa+N3G9Z2
 +F5A==
X-Gm-Message-State: AOAM530bvWtcPTJKlY+BkMhUwJ26YjtHDi+G9uY6JDq28OOeE9kleefp
 pO86IFkaREcPaM9IysXKUMYjcTydoLGmew==
X-Google-Smtp-Source: ABdhPJwthZKLJEtHNbda0i+4/KbVvsGoOFG04oJxVRDipdBDPydi7Pc328M8IKVMDXcUrW4tBbYu6Q==
X-Received: by 2002:a17:90a:3ccb:: with SMTP id
 k11mr2012662pjd.50.1599118023111; 
 Thu, 03 Sep 2020 00:27:03 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x185sm1930229pfc.188.2020.09.03.00.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:27:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/12] target/microblaze: Replace cpustate_changed with
 DISAS_EXIT_NEXT
Date: Thu,  3 Sep 2020 00:26:46 -0700
Message-Id: <20200903072650.1360454-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903072650.1360454-1-richard.henderson@linaro.org>
References: <20200903072650.1360454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: edgar.iglesias@xilinx.com, thuth@redhat.com, f4bug@amsat.org
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


