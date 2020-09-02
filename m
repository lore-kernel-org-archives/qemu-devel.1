Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A564C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9AF2206E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4QDFMg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AF2206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVnn-0006dw-TY
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVk2-0000Br-Nf
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:36:10 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVjy-00056a-JI
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:36:10 -0400
Received: by mail-pg1-x544.google.com with SMTP id 67so2796432pgd.12
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eLcSoqsf7NIliRe9V1n6YrDvFXnEu6vUNh8IjxNercQ=;
 b=G4QDFMg4bwPi1sOi+6Zx5Rbq4sbOIntw9R3imeJAxdKfH9jeCUnesYCzf878O1u//M
 CNK2zwA5wQCCxU7cCNglvWxi3L4j73ujfuZIt1WtWqYc1dcBKCvIKcQ7Y/oxBh9ktdTZ
 1U7cEQUTwD2MYbDnqK9Xv8v/kFQ1/qxN9jtZh0F4Y3ah+F36OY76hQeXUgYWHxDqJexT
 IpplV1CWYvxqWENYHzp/moIxjcWiNtzzBUa8l9Y9WKBeQkfbIW/ODAmU18Hc2PLC/IBB
 +oJU7Ntr0NNTYY2s+k9tkHVyCBJyuCqhyc25uPYObuLlkxM+jSrC6HNLQ5BObZ7X0SfF
 WfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eLcSoqsf7NIliRe9V1n6YrDvFXnEu6vUNh8IjxNercQ=;
 b=MMkcuDdCVby/8mww7RNByrTBTy8yyj2fvPlxyn/aa2cR0EQVy4mWLgfyz0Rn4cVhg8
 Rk4z5AdNfkG7CIfnwBVocnTnQLWWy448YVz0vXuCfP7VL77DmP1HkvjQjw9qyK8xQgmH
 +8mhQN9LWmbIL/i0NC3W2oUfYxV3KRVIu39DB9SjQWQBL7y2KSeRYpQtJz0jV24zdQBi
 DXk/Ifl6Q6lDwSbbWLTXOa8/ddcFy30Jylo93HVSc7GB+wNZ7TJ2wrYosGAYVNFdQpdA
 12ZADfC2EJwAg/fue0mnXFkQue5a+9rqu1jNYzmCvMDu0ljjzLvsE4N5GVgGqyOTiDN/
 wxVQ==
X-Gm-Message-State: AOAM530MUaDG7kRGbuJ5Ej+kh/IP3wk/jTCt3fQxEGubNYY1gROeISBL
 JKS60iVJvNoIMIrYFWSDWzc4zHEY3yBLww==
X-Google-Smtp-Source: ABdhPJz2wjAKnLT5NEtAmAVozVkNU1H75JT0AGTtJNQyTMNZMUBQ3yjn1ZFJYAEDvvbyp1UV0bgpzg==
X-Received: by 2002:a63:1a51:: with SMTP id a17mr2460068pgm.309.1599064564795; 
 Wed, 02 Sep 2020 09:36:04 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm4955441pjz.33.2020.09.02.09.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 09:36:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] target/microblaze: Replace cpustate_changed with
 DISAS_EXIT_NEXT
Date: Wed,  2 Sep 2020 09:35:55 -0700
Message-Id: <20200902163559.1077728-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902163559.1077728-1-richard.henderson@linaro.org>
References: <20200902163559.1077728-1-richard.henderson@linaro.org>
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
Cc: edgar.iglesias@xilinx.com
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
index 0733728794..9c52448c06 100644
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


