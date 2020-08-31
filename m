Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429DBC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8E82071B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DF6skYWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8E82071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCok8-0003Pp-57
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCojE-0001hh-Vv
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:40:29 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCojC-0007Cr-9a
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:40:28 -0400
Received: by mail-pl1-x641.google.com with SMTP id c15so3518995plq.4
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lL/ii72cJ6FGOWErATISMRgVjr2vWowOXNCcA+ww9dI=;
 b=DF6skYWejnfluzQLHjR0lgfuoCbg2GOsZeIXJ2sXh64XDtAKYIA4JH5c7uMnTZMkXP
 aaNt09nVWIRmwkte9KpIVQQX5QuRR4wcJn1vxp91kgKOlUVqIzIzoeEHiVt22ppppAxr
 +Mh8tRe/AZbnIi9m28LJ50titG7nYyta6HJLXIDKHxYFC1Tbvy10da2u0vLkIFIm5KSr
 NVZzq2lhHxMf1ITbKGyAWeAjLaQVkFjJtEY+FaZxzsSEaVShoGte348F2U/L30TGnbP9
 iCqTGBUmTMAFbrsGh03o7a4LPBf1GV1P7fzsM1IhX6ph6kPxRFuBMCY8FjLnDm9r+e1e
 Ub0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lL/ii72cJ6FGOWErATISMRgVjr2vWowOXNCcA+ww9dI=;
 b=MeV3kgjefIJGFMwM5UCvRoJlW9EwK7MapFiILni9nXxiz+8jVOt1WZIGIbFBJiqhTZ
 iT3pkLA8SH1hiyKrm67+ObDpN2xBjPMF9zNEgLskua6SJsv1UzpQWvsOAPS9wK2T11cD
 fNIkkSj8Yu8byqYsqkXJeTBHYxrOnfiT5wmHA2VSjWxD6K9rqpBIGjLRIA9Vmktv1jd0
 EiQb8JT7QSKJWfzhEgrbQ+9GdW6Rjfh0fmVKy6g0+GucnBLwiaYVmeIUQgfEKNidSX75
 dQ0S8Q9p1/I5kXad2yXzQUgJhnmmA+uv0Kc23KvHaRLOUJTg9/sShkVCoz5XOhMl6aOB
 12ag==
X-Gm-Message-State: AOAM533RXr9gvu5gu9lM/p6KW0i9Qga2bMVH+geu/OeZ+lzhYsxSNrZc
 vR/S2OuUI0kRpnwXAt6Ftg+UJxL4bpMHpA==
X-Google-Smtp-Source: ABdhPJy3N00L5JyTacZC6IZtkm6FzCnJmqTMiFqwO86tR8rj+hDi8drH2ivVxFHXN8hG6AkxTpK01w==
X-Received: by 2002:a17:90b:14d5:: with SMTP id
 jz21mr595453pjb.229.1598899224339; 
 Mon, 31 Aug 2020 11:40:24 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y195sm5757580pfc.137.2020.08.31.11.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 11:40:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] target/microblaze: Replace cpustate_changed with
 DISAS_EXIT_NEXT
Date: Mon, 31 Aug 2020 11:40:15 -0700
Message-Id: <20200831184018.839906-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831184018.839906-1-richard.henderson@linaro.org>
References: <20200831184018.839906-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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


