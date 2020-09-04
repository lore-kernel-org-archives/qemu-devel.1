Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B665EC2BB84
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50EE220684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrfYrFIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EE220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEHCF-0004qZ-Fn
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH56-0001lw-3c
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:04 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:43657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH54-0000ow-52
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:03 -0400
Received: by mail-pf1-x42a.google.com with SMTP id f18so5106750pfa.10
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 12:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6ip8ETVXBtHaFZViNW/Xn/p/A5AwtAlXYIm9/stqaVE=;
 b=BrfYrFIUkZ2oGli0/6CvvFM7Jm3lLdEy9TDUXhWzy4m1W/UH5Jz8XH899tUOr1j/2i
 RER7iBzFgYZhLjk8gLdFs8nlE9S6ZtXj5iMF6ZCfyc2Ktn7NBpaV3afJZOUDFlpFQuCG
 lG+P2XhIcnAct5Ih+L/nHQIMXzybPkpvuOaWyg1JhUvGZHACTmH1OobGYRGasgXK46NM
 SPrQ5CdXL9hdO1dpSR56/Mj/LpS/qolXZepsHh3bofPfL6j1JpPf0R2TKS71+Tjit2Z8
 9f0LTsIGOT9hwjKBGKOmflH7yaQxZbuzC/iv1SlD80Ejq+39XsWLK8Exd3+COqxGF8ea
 ey0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6ip8ETVXBtHaFZViNW/Xn/p/A5AwtAlXYIm9/stqaVE=;
 b=ZVWZi9o/XkxBXVt6ULHChgPjUKtal/Kl5CBW72ABX0k2XS1l7iQeAY6BETZcEWv1Cg
 P0kgEZc8EDwHQiH9DE3W25oYDX4FGQOu0yqqAEcXWS1lE9jdsauOhzcGNcuv7KpxXzDj
 5Epetfn/KC2ALCr/TVcgZqIX/p5WXk/NopNulocQGD+Rf5vLtCjQG5eI961VdCdMARh4
 ygYEqZJveNuQ0NJh74PuKvAd+/8GOUkuoj/JTlcHc2LWPuqbnxwxce7+SRV40XQivyd4
 k3soPNbXNz+YKqyhtmb0zS3v1/8oWu5HVAXKCdHl15vH4X6wGbKlqJ8RgxZBbpkf1fe/
 SfyQ==
X-Gm-Message-State: AOAM530OtHsi2BtxfAbf7CaJchSQIz1wIXbKBYRYIJQJhEeZuxCMyCKS
 1Mtlsjwlv+KAKx9CIMLeHelwM2UCTzDyjA==
X-Google-Smtp-Source: ABdhPJw+5NiBtMEXFAE6i2KFn8y8MTfF70wnTtUSsytcnCW24IowV5qMAUTuRkAyT6UgrT27L9O7rg==
X-Received: by 2002:a65:6897:: with SMTP id e23mr8331694pgt.65.1599246540200; 
 Fri, 04 Sep 2020 12:09:00 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm1897941pge.22.2020.09.04.12.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 12:08:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/19] target/microblaze: Diagnose invalid insns in delay
 slots
Date: Fri,  4 Sep 2020 12:08:34 -0700
Message-Id: <20200904190842.2282109-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904190842.2282109-1-richard.henderson@linaro.org>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

These cases result in undefined and undocumented behaviour but the
behaviour is deterministic, i.e cores will not lock-up or expose
security issues.  However, RTL will not raise exceptions either.

Therefore, log a GUEST_ERROR and treat these cases as nops, to
avoid corner cases which could put qemu into an invalid state.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 48 ++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index d98572fab9..ff0cb7dbb6 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -179,6 +179,21 @@ static bool trap_userspace(DisasContext *dc, bool cond)
     return cond_user;
 }
 
+/*
+ * Return true, and log an error, if the current insn is
+ * within a delay slot.
+ */
+static bool invalid_delay_slot(DisasContext *dc, const char *insn_type)
+{
+    if (dc->tb_flags & D_FLAG) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Invalid insn in delay slot: %s at %08x\n",
+                      insn_type, (uint32_t)dc->base.pc_next);
+        return true;
+    }
+    return false;
+}
+
 static TCGv_i32 reg_for_read(DisasContext *dc, int reg)
 {
     if (likely(reg != 0)) {
@@ -500,6 +515,9 @@ DO_TYPEA_CFG(idivu, use_div, true, gen_idivu)
 
 static bool trans_imm(DisasContext *dc, arg_imm *arg)
 {
+    if (invalid_delay_slot(dc, "imm")) {
+        return true;
+    }
     dc->ext_imm = arg->imm << 16;
     tcg_gen_movi_i32(cpu_imm, dc->ext_imm);
     dc->tb_flags_to_set = IMM_FLAG;
@@ -1067,6 +1085,9 @@ static bool do_branch(DisasContext *dc, int dest_rb, int dest_imm,
 {
     uint32_t add_pc;
 
+    if (invalid_delay_slot(dc, "branch")) {
+        return true;
+    }
     if (delay) {
         setup_dslot(dc, dest_rb < 0);
     }
@@ -1106,6 +1127,9 @@ static bool do_bcc(DisasContext *dc, int dest_rb, int dest_imm,
 {
     TCGv_i32 zero, next;
 
+    if (invalid_delay_slot(dc, "bcc")) {
+        return true;
+    }
     if (delay) {
         setup_dslot(dc, dest_rb < 0);
     }
@@ -1158,6 +1182,10 @@ static bool trans_brk(DisasContext *dc, arg_typea_br *arg)
     if (trap_userspace(dc, true)) {
         return true;
     }
+    if (invalid_delay_slot(dc, "brk")) {
+        return true;
+    }
+
     tcg_gen_mov_i32(cpu_pc, reg_for_read(dc, arg->rb));
     if (arg->rd) {
         tcg_gen_movi_i32(cpu_R[arg->rd], dc->base.pc_next);
@@ -1176,6 +1204,10 @@ static bool trans_brki(DisasContext *dc, arg_typeb_br *arg)
     if (trap_userspace(dc, imm != 0x8 && imm != 0x18)) {
         return true;
     }
+    if (invalid_delay_slot(dc, "brki")) {
+        return true;
+    }
+
     tcg_gen_movi_i32(cpu_pc, imm);
     if (arg->rd) {
         tcg_gen_movi_i32(cpu_R[arg->rd], dc->base.pc_next);
@@ -1216,6 +1248,11 @@ static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
 {
     int mbar_imm = arg->imm;
 
+    /* Note that mbar is a specialized branch instruction. */
+    if (invalid_delay_slot(dc, "mbar")) {
+        return true;
+    }
+
     /* Data access memory barrier.  */
     if ((mbar_imm & 2) == 0) {
         tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
@@ -1263,6 +1300,10 @@ static bool do_rts(DisasContext *dc, arg_typeb_bc *arg, int to_set)
     if (trap_userspace(dc, to_set)) {
         return true;
     }
+    if (invalid_delay_slot(dc, "rts")) {
+        return true;
+    }
+
     dc->tb_flags_to_set |= to_set;
     setup_dslot(dc, true);
 
@@ -1695,7 +1736,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
     if (dc->jmp_cond != TCG_COND_NEVER && !(dc->tb_flags & D_FLAG)) {
         /*
          * Finish any return-from branch.
-         * TODO: Diagnose rtXd in delay slot of rtYd earlier.
          */
         uint32_t rt_ibe = dc->tb_flags & (DRTI_FLAG | DRTB_FLAG | DRTE_FLAG);
         if (unlikely(rt_ibe != 0)) {
@@ -1717,12 +1757,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
              * and will handle D_FLAG in mb_cpu_do_interrupt.
              */
             break;
-        case DISAS_EXIT:
-            /*
-             * TODO: diagnose brk/brki in delay slot earlier.
-             * This would then fold into the illegal insn case above.
-             */
-            break;
         case DISAS_NEXT:
             /*
              * Normal insn a delay slot.
-- 
2.25.1


