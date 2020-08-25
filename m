Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F65C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4326520738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouP3GNpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4326520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgRm-00080X-BC
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4E-0000Q1-C1
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:18 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:55654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4C-00021h-3g
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:17 -0400
Received: by mail-pj1-x1044.google.com with SMTP id 2so118661pjx.5
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ulBZsejW2MG0+XvkBxJ405c+w3o2ybsU7Ko1+l3VylQ=;
 b=ouP3GNpws10kfQdVvOrwNLcPphAdXPOKqL+5zPovlIaEbwdO2MNHWHG7o+NkDz9k55
 gmKxf2I23v/uU2kYDf/Y9+IgkRsTkX6tTqZ2dktEKRP8al2bej0CeNjdkXLDkSS8G4CL
 goRbB00kxg7VHSbQiYJeIxOyeaeC9+Co57nZ/CgKda4kgYxJ48yrouJxbWpLV9YubiYL
 fKvcaLpDh8yNF9pAk5lMVMwQc98DDsdQJveb7N8l5rj6V1ef4ypFnGZApk0grxdB2e+B
 uK+BHu9VJyopinTtt19X+rMqk49Bubjc4ZFq3VZ0h6AmKHRxPyIE3jBG5DxPejh7/2vg
 cSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ulBZsejW2MG0+XvkBxJ405c+w3o2ybsU7Ko1+l3VylQ=;
 b=sT93v3fCMieAtp5WhEmPZFgEAXzHUtRCfZDlCmFpnPOHL/Cv1P4Hd4Kl9OCT9VZsK8
 9SwqpeadzVy3ZMZem136z3Fizkt3WyW+D6v4tk4oUlK14eRqX12FxdqwIx54x1Z2JqD8
 snV86/6ikvsL2y1x6qwbaaDMzO6xxKMdy6uShNAOcz8BX5UENMTv2Lpg+ap64k90FBvv
 TgHnCLQ/DQw5HVg3EKD6Vl3YO/IDHwUtWQj+k44mGEsH41hPhgDJorslz5r4tX4eVIKD
 Z5VV/Mi8/U5AvNXGtUreUnNzBs3CCB4/AVU1NpbzRYP1gL7yzfQ0uyRu6bdOlz0gF2JP
 kiXA==
X-Gm-Message-State: AOAM531erSUPrcWn2eSlyjTdgKVHKQuHFB3j5ZO4+qLwQU5L/LMP99Od
 ELZreCoMNl5nunZo/T4qVaTxPdjboSfX4A==
X-Google-Smtp-Source: ABdhPJwzmYVJHTh+ZG7U+5WPLuwqasVsUl81thLd/BHqyWYQQpaxz6sy3srKwZeETHx2VNL+yehpbg==
X-Received: by 2002:a17:90a:fd82:: with SMTP id
 cx2mr3102172pjb.20.1598389274338; 
 Tue, 25 Aug 2020 14:01:14 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 62/77] target/microblaze: Try to keep imm and delay slot
 together
Date: Tue, 25 Aug 2020 13:59:35 -0700
Message-Id: <20200825205950.730499-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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

If the last insn on a page is imm, or a branch with delay slot,
then end a tb early if this has not begun the tb.  If it has
begun the tb, then we can allow the tb to span two pages as if
the imm plus its consumer, or branch plus delay, or imm plus
branch plus delay, are a single insn.

If the insn in the delay slot faults, then the exception handler
will have reset the PC to the beginning of this sequence anyway,
via the stored D_FLAG and BIMM_FLAG bits.

Disable all of this when single-stepping.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 65 ++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4675326083..fcfc1ac184 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -530,11 +530,50 @@ static void gen_idivu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA_CFG(idiv, use_div, true, gen_idiv)
 DO_TYPEA_CFG(idivu, use_div, true, gen_idivu)
 
+/*
+ * Try to keep the current instruction with the one following.
+ * So if this insn is the last in the TB, and is not the first
+ * in the TB, and we are not singlestepping, then back up and
+ * exit the current TB.
+ */
+static bool wait_for_next_tb(DisasContext *dc)
+{
+    if (dc->base.num_insns >= dc->base.max_insns
+        && !dc->base.singlestep_enabled) {
+        /* Also consider if this insn (e.g. brid) itself uses an imm. */
+        int ninsns = (dc->tb_flags & IMM_FLAG ? 2 : 1);
+
+        /*
+         * If this is not the first insn in the TB, back up and
+         * start again with a new TB.
+         */
+        if (dc->base.num_insns > ninsns) {
+            dc->base.pc_next -= ninsns * 4;
+            dc->base.num_insns -= ninsns;
+            dc->base.is_jmp = DISAS_TOO_MANY;
+            return true;
+        }
+
+        /*
+         * Correspondingly, if this is the first insn of the TB,
+         * then extend the TB as necessary to keep it with the
+         * next insn.  Do this by *reducing* the number of insns
+         * processed by this TB so that icount does fail an assertion.
+         */
+        if (dc->base.num_insns == ninsns) {
+            dc->base.num_insns = 0;
+        }
+    }
+    return false;
+}
+
 static bool trans_imm(DisasContext *dc, arg_imm *arg)
 {
-    dc->ext_imm = arg->imm << 16;
-    tcg_gen_movi_i32(cpu_imm, dc->ext_imm);
-    dc->tb_flags_to_set = IMM_FLAG;
+    if (!wait_for_next_tb(dc)) {
+        dc->ext_imm = arg->imm << 16;
+        tcg_gen_movi_i32(cpu_imm, dc->ext_imm);
+        dc->tb_flags_to_set = IMM_FLAG;
+    }
     return true;
 }
 
@@ -1311,12 +1350,17 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
     tcg_temp_free_i32(zero);
 }
 
-static void dec_setup_dslot(DisasContext *dc)
+static bool dec_setup_dslot(DisasContext *dc)
 {
+    if (wait_for_next_tb(dc)) {
+        return true;
+    }
+
     dc->tb_flags_to_set |= D_FLAG;
     if (dc->type_b && (dc->tb_flags & IMM_FLAG)) {
         dc->tb_flags_to_set |= BIMM_FLAG;
     }
+    return false;
 }
 
 static void dec_bcc(DisasContext *dc)
@@ -1327,8 +1371,8 @@ static void dec_bcc(DisasContext *dc)
     cc = EXTRACT_FIELD(dc->ir, 21, 23);
     dslot = dc->ir & (1 << 25);
 
-    if (dslot) {
-        dec_setup_dslot(dc);
+    if (dslot && dec_setup_dslot(dc)) {
+        return;
     }
 
     if (dc->type_b) {
@@ -1402,9 +1446,10 @@ static void dec_br(DisasContext *dc)
         }
     }
 
-    if (dslot) {
-        dec_setup_dslot(dc);
+    if (dslot && dec_setup_dslot(dc)) {
+        return;
     }
+
     if (link && dc->rd) {
         tcg_gen_movi_i32(cpu_R[dc->rd], dc->base.pc_next);
     }
@@ -1513,7 +1558,9 @@ static void dec_rts(DisasContext *dc)
         return;
     }
 
-    dec_setup_dslot(dc);
+    if (dec_setup_dslot(dc)) {
+        return;
+    }
 
     if (i_bit) {
         dc->tb_flags |= DRTI_FLAG;
-- 
2.25.1


