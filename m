Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BBAC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB39720757
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rRcLMnk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB39720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfUp-00088P-3I
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEv-00017i-JK
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:25 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:46555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEt-0005Eo-Gd
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:25 -0400
Received: by mail-pf1-x42a.google.com with SMTP id t185so723067pfd.13
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wXHheAujwG3J7OkJDdVOIKAESxqo8RAwt5jkuy5HApE=;
 b=rRcLMnk0BuRSGAIPpb/sgknemybd7UCwpH3jjRfjTom1E3gQ3EGGr/u1pIxjMtpE/A
 nZEBRF9JD2J/FINUIpDIMFHlkeKWtOkcq6nWrPT7UJH4LOoCeyI02QpRorz8WQ3c+1mb
 VmSMTffUBE0CH3nvO/Y09TYllPKMjSmVcm4uC7d9NmHlRbOiu52vjf+2RzOvLN/yC9tE
 Rtkdz6JZnFCJ/IybgcKUxoxPyrz17R06Vh/xzMCAct46uiOJwKH9hhDTb9c9ANA3Fg9t
 6sba8DsrGgARoFw6lqhj3MxM//ohiiUf5BCIjcxikJ0Rgl8ejFDpzpJvMKNgsUYusyx3
 /l9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wXHheAujwG3J7OkJDdVOIKAESxqo8RAwt5jkuy5HApE=;
 b=S+lk9i8hQ3kGHM2GJOGY5+s/7ejeaTaC8OxzEZBqMaD5eRiPFF9JAFzW1RCACul3fg
 +tt5V48xsiKVw9/NsNfmc8kM0tymPU/SkEMYFaIZcl/pMlm1Hhq0PfMZLOIfXBIjyva/
 uTUBbLAAHI6W/z7eQLCEI8RHhsFRF0wUZpVBp+R2ZJZtM5CadyzDUovnCD93sEO2ZFPd
 KKHobK5Z1ZloooklO4WhY9xcx+6P/CDBxp+gfB2Cx7wCfK2yneA+4wMyfILSjXXS7UY2
 /9fv+kgM0A7HdYTyBa7dbaoog/yUMBSttwCjseBOm8As/RRa77IQeVLZ8fLDyaAUSwNo
 qSYA==
X-Gm-Message-State: AOAM5331gm7VIfHoZ4Th0kfDyOatloW9xC8DTLkvyNoRzZUdtAORVQSb
 tinJv/BsYAAH23RsX+YvSrkQm3YolEzuug==
X-Google-Smtp-Source: ABdhPJzm1rHCH9MSsU1d3J6bRZ8ILG2jhS2i4ae3DV4JoCHW4jUSq7zhNyllC7AXEYtj7RlYlDBiaQ==
X-Received: by 2002:a65:60ce:: with SMTP id r14mr1449898pgv.85.1598624421014; 
 Fri, 28 Aug 2020 07:20:21 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 39/76] target/microblaze: Convert dec_pattern to decodetree
Date: Fri, 28 Aug 2020 07:18:52 -0700
Message-Id: <20200828141929.77854-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  4 ++
 target/microblaze/translate.c  | 67 +++++++++-------------------------
 2 files changed, 22 insertions(+), 49 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index a611cc83a7..16519f05dc 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -44,6 +44,10 @@ addikc          001110 ..... ..... ................     @typeb
 cmp             000101 ..... ..... ..... 000 0000 0001  @typea
 cmpu            000101 ..... ..... ..... 000 0000 0011  @typea
 
+pcmpbf          100000 ..... ..... ..... 100 0000 0000  @typea
+pcmpeq          100010 ..... ..... ..... 100 0000 0000  @typea
+pcmpne          100011 ..... ..... ..... 100 0000 0000  @typea
+
 rsub            000001 ..... ..... ..... 000 0000 0000  @typea
 rsubc           000011 ..... ..... ..... 000 0000 0000  @typea
 rsubk           000101 ..... ..... ..... 000 0000 0000  @typea
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8da477457d..7ebf0e1e7d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -279,6 +279,10 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
     static bool trans_##NAME(DisasContext *dc, arg_typea *a) \
     { return do_typea(dc, a, SE, FN); }
 
+#define DO_TYPEA_CFG(NAME, CFG, SE, FN) \
+    static bool trans_##NAME(DisasContext *dc, arg_typea *a) \
+    { return dc->cpu->cfg.CFG && do_typea(dc, a, SE, FN); }
+
 #define DO_TYPEBI(NAME, SE, FNI) \
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
     { return do_typeb_imm(dc, a, SE, FNI); }
@@ -350,6 +354,20 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA(cmp, false, gen_cmp)
 DO_TYPEA(cmpu, false, gen_cmpu)
 
+static void gen_pcmpeq(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    tcg_gen_setcond_i32(TCG_COND_EQ, out, ina, inb);
+}
+
+static void gen_pcmpne(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    tcg_gen_setcond_i32(TCG_COND_NE, out, ina, inb);
+}
+
+DO_TYPEA_CFG(pcmpbf, use_pcmp_instr, false, gen_helper_pcmpbf)
+DO_TYPEA_CFG(pcmpeq, use_pcmp_instr, false, gen_pcmpeq)
+DO_TYPEA_CFG(pcmpne, use_pcmp_instr, false, gen_pcmpne)
+
 /* No input carry, but output carry. */
 static void gen_rsub(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
@@ -413,49 +431,10 @@ static bool trans_zero(DisasContext *dc, arg_zero *arg)
     return false;
 }
 
-static void dec_pattern(DisasContext *dc)
-{
-    unsigned int mode;
-
-    if (trap_illegal(dc, !dc->cpu->cfg.use_pcmp_instr)) {
-        return;
-    }
-
-    mode = dc->opcode & 3;
-    switch (mode) {
-        case 0:
-            /* pcmpbf.  */
-            if (dc->rd)
-                gen_helper_pcmpbf(cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        case 2:
-            if (dc->rd) {
-                tcg_gen_setcond_i32(TCG_COND_EQ, cpu_R[dc->rd],
-                                   cpu_R[dc->ra], cpu_R[dc->rb]);
-            }
-            break;
-        case 3:
-            if (dc->rd) {
-                tcg_gen_setcond_i32(TCG_COND_NE, cpu_R[dc->rd],
-                                   cpu_R[dc->ra], cpu_R[dc->rb]);
-            }
-            break;
-        default:
-            cpu_abort(CPU(dc->cpu),
-                      "unsupported pattern insn opcode=%x\n", dc->opcode);
-            break;
-    }
-}
-
 static void dec_and(DisasContext *dc)
 {
     unsigned int not;
 
-    if (!dc->type_b && (dc->imm & (1 << 10))) {
-        dec_pattern(dc);
-        return;
-    }
-
     not = dc->opcode & (1 << 1);
 
     if (!dc->rd)
@@ -469,22 +448,12 @@ static void dec_and(DisasContext *dc)
 
 static void dec_or(DisasContext *dc)
 {
-    if (!dc->type_b && (dc->imm & (1 << 10))) {
-        dec_pattern(dc);
-        return;
-    }
-
     if (dc->rd)
         tcg_gen_or_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
 }
 
 static void dec_xor(DisasContext *dc)
 {
-    if (!dc->type_b && (dc->imm & (1 << 10))) {
-        dec_pattern(dc);
-        return;
-    }
-
     if (dc->rd)
         tcg_gen_xor_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
 }
-- 
2.25.1


