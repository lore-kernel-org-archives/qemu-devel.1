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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE58C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D4020665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTRGB80q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D4020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgFT-00018q-59
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3j-00089b-QV
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:47 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:32859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3h-0001rk-Kv
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:47 -0400
Received: by mail-pf1-x443.google.com with SMTP id u20so8302427pfn.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y0GhQmIlcg+ScCvY3Co9GQAvD5jBxaWm8gs041r/HXU=;
 b=JTRGB80qZ7pHKoUrhtdI4wnlB54v+X4kdzI66ft1KLDH8CAsN6G+LcEoc1Fuu2xaCh
 xYXeLNcz6D4EpaJK60Itg++p5xUt2B/s58vP3eNUSW8ZFFOUHpf50cpnb72+gdpNq4Fi
 nOosvOa27HclkMuU9d4yF3BQd1WGAfTm+x/49fZF5M4GMMYC7RljdxL3B2UetlpPBoc3
 c7xXoc8eifb20aIUeEN3fX/h3VGIby5IJcN4vnFpYuEe03HNNYaTRn570QftFdddTTSy
 slRKEufoVXnmsFys/4qpfYJ3aSBV6a8WLDFmhMRlhZSrO0WaLuaG0MK4CZGyk8w/ZzT1
 bbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y0GhQmIlcg+ScCvY3Co9GQAvD5jBxaWm8gs041r/HXU=;
 b=ostWOsrYjjeq4xkOGSzRqIZdxKQmPCtv+d8lH4QIFRUaTd8kksYWQ3chmmEamb2CSk
 F9yNC7Kq89xr5il5L++cfGSSlA4rrz5FMg2Kzv5wGsyu0ntjpRW1RtwetP2DRmpJ6psA
 R8zDD1pql+KMYiJlc5EwVqxLFbJEXDGqPRPofT/+1/K0vHpwotoVNqe/3jz21+GbGZI6
 +wdDz9smBPf4lZ8y2/mKJ/QSdV9jOY7ptK9xo/+fgnHO4nR4Y8L+ba2cXkkf1PuSTDA/
 R9uPVJOS2rh6IWsE089wSefOmZHPrMonb3ZzeOMtF2AorCa8RQF2/0WPf5TzekoDQRPz
 q2Kw==
X-Gm-Message-State: AOAM5335iVYxGTHn8eLytLMtzpV+cW3gIMFfeeHTgRA9vOsRa9saylEA
 sY8yCbgvxwdMVWg/IfFp0k107HKBAR++yw==
X-Google-Smtp-Source: ABdhPJyryqiC4ubkBeFxiAwFn/ROxqQ4r+6fSQ6op9MOlTFpCTqtJY5ZgH1aHFxdc048GcwaaWuE0g==
X-Received: by 2002:aa7:8699:: with SMTP id d25mr1013097pfo.191.1598389243875; 
 Tue, 25 Aug 2020 14:00:43 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 41/77] target/microblaze: Convert dec_mul to decodetree
Date: Tue, 25 Aug 2020 13:59:14 -0700
Message-Id: <20200825205950.730499-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  6 +++
 target/microblaze/translate.c  | 77 ++++++++++++++--------------------
 2 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 6b3cc9a182..65a8a53b54 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -47,6 +47,12 @@ andni           101011 ..... ..... ................     @typeb
 cmp             000101 ..... ..... ..... 000 0000 0001  @typea
 cmpu            000101 ..... ..... ..... 000 0000 0011  @typea
 
+mul             010000 ..... ..... ..... 000 0000 0000  @typea
+mulh            010000 ..... ..... ..... 000 0000 0001  @typea
+mulhu           010000 ..... ..... ..... 000 0000 0011  @typea
+mulhsu          010000 ..... ..... ..... 000 0000 0010  @typea
+muli            011000 ..... ..... ................     @typeb
+
 or              100000 ..... ..... ..... 000 0000 0000  @typea
 ori             101000 ..... ..... ................     @typeb
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 5252790b09..dc6ea523b5 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -287,6 +287,10 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
     { return do_typeb_imm(dc, a, SE, FNI); }
 
+#define DO_TYPEBI_CFG(NAME, CFG, SE, FNI) \
+    static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
+    { return dc->cpu->cfg.CFG && do_typeb_imm(dc, a, SE, FNI); }
+
 #define DO_TYPEBV(NAME, SE, FN) \
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
     { return do_typeb_val(dc, a, SE, FN); }
@@ -364,6 +368,33 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA(cmp, false, gen_cmp)
 DO_TYPEA(cmpu, false, gen_cmpu)
 
+static void gen_mulh(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_muls2_i32(tmp, out, ina, inb);
+    tcg_temp_free_i32(tmp);
+}
+
+static void gen_mulhu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_mulu2_i32(tmp, out, ina, inb);
+    tcg_temp_free_i32(tmp);
+}
+
+static void gen_mulhsu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_mulsu2_i32(tmp, out, ina, inb);
+    tcg_temp_free_i32(tmp);
+}
+
+DO_TYPEA_CFG(mul, use_hw_mul, false, tcg_gen_mul_i32)
+DO_TYPEA_CFG(mulh, use_hw_mul >= 2, false, gen_mulh)
+DO_TYPEA_CFG(mulhu, use_hw_mul >= 2, false, gen_mulhu)
+DO_TYPEA_CFG(mulhsu, use_hw_mul >= 2, false, gen_mulhsu)
+DO_TYPEBI_CFG(muli, use_hw_mul, false, tcg_gen_muli_i32)
+
 DO_TYPEA(or, false, tcg_gen_or_i32)
 DO_TYPEBI(ori, false, tcg_gen_ori_i32)
 
@@ -638,51 +669,6 @@ static void dec_msr(DisasContext *dc)
     }
 }
 
-/* Multiplier unit.  */
-static void dec_mul(DisasContext *dc)
-{
-    TCGv_i32 tmp;
-    unsigned int subcode;
-
-    if (trap_illegal(dc, !dc->cpu->cfg.use_hw_mul)) {
-        return;
-    }
-
-    subcode = dc->imm & 3;
-
-    if (dc->type_b) {
-        tcg_gen_mul_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-        return;
-    }
-
-    /* mulh, mulhsu and mulhu are not available if C_USE_HW_MUL is < 2.  */
-    if (subcode >= 1 && subcode <= 3 && dc->cpu->cfg.use_hw_mul < 2) {
-        /* nop??? */
-    }
-
-    tmp = tcg_temp_new_i32();
-    switch (subcode) {
-        case 0:
-            tcg_gen_mul_i32(cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        case 1:
-            tcg_gen_muls2_i32(tmp, cpu_R[dc->rd],
-                              cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        case 2:
-            tcg_gen_mulsu2_i32(tmp, cpu_R[dc->rd],
-                               cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        case 3:
-            tcg_gen_mulu2_i32(tmp, cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        default:
-            cpu_abort(CPU(dc->cpu), "unknown MUL insn %x\n", subcode);
-            break;
-    }
-    tcg_temp_free_i32(tmp);
-}
-
 /* Div unit.  */
 static void dec_div(DisasContext *dc)
 {
@@ -1565,7 +1551,6 @@ static struct decoder_info {
     {DEC_BCC, dec_bcc},
     {DEC_RTS, dec_rts},
     {DEC_FPU, dec_fpu},
-    {DEC_MUL, dec_mul},
     {DEC_DIV, dec_div},
     {DEC_MSR, dec_msr},
     {DEC_STREAM, dec_stream},
-- 
2.25.1


