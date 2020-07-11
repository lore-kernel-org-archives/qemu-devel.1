Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A601C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254952078B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moUanxtz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254952078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juDQz-0004R5-4e
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 07:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMO-0004ex-Sc
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:08:00 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMN-0006OD-5P
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:08:00 -0400
Received: by mail-pf1-x444.google.com with SMTP id 207so3702825pfu.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 04:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I1f4zQiKTvpbbOCt4JUJePn9EdmWfzb1AtrlfbGVBHI=;
 b=moUanxtzBMQ5iSX+fAK81/rjN1Tf1o/tkEEgEHnJ2GAFEkff9qed0GVcT541dCsovU
 4gPUs+GreKwpYiZ1qn28Foue+YxBGr4yD0Ms+M8bwmROAWOepJYAoQfhse0UZpj0Yq7R
 WPgVPuZs8rV7Sn9TOM8ZuklTe8cDeep74RrSfy4L2g7LLAHH8lkyMevJ4EWkb+cabQRy
 9FnHnkcChpEhKEn1pObqQu0CvBTkFU9Ly//UC3GmOTmo0F/sprQe3pYxZLI+EKRGuoMg
 +HTRQKP1pTwlsWQNHrX1+SGHJBEymx/rbBbjTZ7TsBvzzZi3Zg7C+Hp6JYNIEAnwNUDR
 IhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I1f4zQiKTvpbbOCt4JUJePn9EdmWfzb1AtrlfbGVBHI=;
 b=ErB8IO87EYC7JrcUn5k28ephcaJis9foCIcgoyVwdG7KCOnEGwPKAlwLwvu92pqI40
 zOt/61N5Q4+1xHkeHQGF5hR+kk3aY1UwDFCMJWRmRgClkTqLyx04ctKDRAhhGNF3pPhl
 exeUfJ/MqdRU3fvTrZbUgvq5Mj1sdnWYZLA0/1cWvA3WLHzsL5o6YB0kOgMlyP2q/cHv
 zKWko5Ebr0JIhB2Om7XYChfQF/0J8/msz19N8NbOJKtXejLlEFnNYP54oLMw4q2S4rFp
 vg+m+v4M8uB24d6+XY9o+kmW4Bm19KcQ1IhEYz+vt9ho3AiJISXqzOUxRDirVRjSF7AO
 gyfg==
X-Gm-Message-State: AOAM530wcWL3XtFvWSKD4bX7MQ4CuWJiusMQov9jL8/Vu8p9dJmnbOkM
 5pHYtyZWGbj56fJc695VkROnZ5y/
X-Google-Smtp-Source: ABdhPJzwM8geZOr8sqOVwIAEAqLGW+dcNglb84edR+3LZCY6ISf9dXSZ6p1FhTc4sZj918XX2vnJKg==
X-Received: by 2002:a62:ceca:: with SMTP id y193mr33795430pfg.11.1594465677543; 
 Sat, 11 Jul 2020 04:07:57 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id m31sm8925826pjb.52.2020.07.11.04.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 04:07:56 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/22] target/xtensa: implement FPU division and square root
Date: Sat, 11 Jul 2020 04:06:46 -0700
Message-Id: <20200711110655.20287-12-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711110655.20287-1-jcmvbkbc@gmail.com>
References: <20200711110655.20287-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This does not implement all opcodes related to div/sqrt as specified in
the xtensa ISA, partly because the official specification is not
complete and partly because precise implementation is unnecessarily
complex. Instead instructions specific to the div/sqrt sequences are
implemented differently, most of them as nops, but the results of
div/sqrt sequences is preserved.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/fpu_helper.c |  24 +++++++++
 target/xtensa/helper.h     |   4 ++
 target/xtensa/translate.c  | 104 +++++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)

diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index b5faf34ad080..ba3c29d19d91 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -231,6 +231,30 @@ float32 HELPER(msub_s)(CPUXtensaState *env, float32 a, float32 b, float32 c)
                           &env->fp_status);
 }
 
+float64 HELPER(mkdadj_d)(CPUXtensaState *env, float64 a, float64 b)
+{
+    set_use_first_nan(true, &env->fp_status);
+    return float64_div(b, a, &env->fp_status);
+}
+
+float32 HELPER(mkdadj_s)(CPUXtensaState *env, float32 a, float32 b)
+{
+    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
+    return float32_div(b, a, &env->fp_status);
+}
+
+float64 HELPER(mksadj_d)(CPUXtensaState *env, float64 v)
+{
+    set_use_first_nan(true, &env->fp_status);
+    return float64_sqrt(v, &env->fp_status);
+}
+
+float32 HELPER(mksadj_s)(CPUXtensaState *env, float32 v)
+{
+    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
+    return float32_sqrt(v, &env->fp_status);
+}
+
 uint32_t HELPER(ftoi_d)(CPUXtensaState *env, float64 v,
                         uint32_t rounding_mode, uint32_t scale)
 {
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index 095f754671ce..ae938ceedb80 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -83,6 +83,10 @@ DEF_HELPER_4(madd_d, f64, env, f64, f64, f64)
 DEF_HELPER_4(madd_s, f32, env, f32, f32, f32)
 DEF_HELPER_4(msub_d, f64, env, f64, f64, f64)
 DEF_HELPER_4(msub_s, f32, env, f32, f32, f32)
+DEF_HELPER_3(mkdadj_d, f64, env, f64, f64)
+DEF_HELPER_3(mkdadj_s, f32, env, f32, f32)
+DEF_HELPER_2(mksadj_d, f64, env, f64)
+DEF_HELPER_2(mksadj_s, f32, env, f32)
 DEF_HELPER_4(ftoi_d, i32, env, f64, i32, i32)
 DEF_HELPER_4(ftoui_d, i32, env, f64, i32, i32)
 DEF_HELPER_3(itof_d, f64, env, i32, i32)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index fff29cc25dd1..944a157747cd 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -7314,6 +7314,38 @@ static void translate_sub_s(DisasContext *dc, const OpcodeArg arg[],
     }
 }
 
+static void translate_mkdadj_d(DisasContext *dc, const OpcodeArg arg[],
+                               const uint32_t par[])
+{
+    gen_helper_mkdadj_d(arg[0].out, cpu_env, arg[0].in, arg[1].in);
+}
+
+static void translate_mkdadj_s(DisasContext *dc, const OpcodeArg arg[],
+                               const uint32_t par[])
+{
+    OpcodeArg arg32[2];
+
+    get_f32_o1_i2(arg, arg32, 0, 0, 1);
+    gen_helper_mkdadj_s(arg32[0].out, cpu_env, arg32[0].in, arg32[1].in);
+    put_f32_o1_i2(arg, arg32, 0, 0, 1);
+}
+
+static void translate_mksadj_d(DisasContext *dc, const OpcodeArg arg[],
+                               const uint32_t par[])
+{
+    gen_helper_mksadj_d(arg[0].out, cpu_env, arg[1].in);
+}
+
+static void translate_mksadj_s(DisasContext *dc, const OpcodeArg arg[],
+                               const uint32_t par[])
+{
+    OpcodeArg arg32[2];
+
+    get_f32_o1_i1(arg, arg32, 0, 1);
+    gen_helper_mksadj_s(arg32[0].out, cpu_env, arg32[1].in);
+    put_f32_o1_i1(arg, arg32, 0, 1);
+}
+
 static void translate_wur_fpu_fcr(DisasContext *dc, const OpcodeArg arg[],
                                   const uint32_t par[])
 {
@@ -7349,6 +7381,22 @@ static const XtensaOpcodeOps fpu_ops[] = {
         .name = "add.s",
         .translate = translate_add_s,
         .coprocessor = 0x1,
+    }, {
+        .name = "addexp.d",
+        .translate = translate_nop,
+        .coprocessor = 0x1,
+    }, {
+        .name = "addexp.s",
+        .translate = translate_nop,
+        .coprocessor = 0x1,
+    }, {
+        .name = "addexpm.d",
+        .translate = translate_mov_s,
+        .coprocessor = 0x1,
+    }, {
+        .name = "addexpm.s",
+        .translate = translate_mov_s,
+        .coprocessor = 0x1,
     }, {
         .name = "ceil.d",
         .translate = translate_ftoi_d,
@@ -7375,6 +7423,22 @@ static const XtensaOpcodeOps fpu_ops[] = {
         .name = "cvts.d",
         .translate = translate_cvts_d,
         .coprocessor = 0x1,
+    }, {
+        .name = "div0.d",
+        .translate = translate_nop,
+        .coprocessor = 0x1,
+    }, {
+        .name = "div0.s",
+        .translate = translate_nop,
+        .coprocessor = 0x1,
+    }, {
+        .name = "divn.d",
+        .translate = translate_nop,
+        .coprocessor = 0x1,
+    }, {
+        .name = "divn.s",
+        .translate = translate_nop,
+        .coprocessor = 0x1,
     }, {
         .name = "float.d",
         .translate = translate_float_d,
@@ -7475,6 +7539,30 @@ static const XtensaOpcodeOps fpu_ops[] = {
         .name = "madd.s",
         .translate = translate_madd_s,
         .coprocessor = 0x1,
+    }, {
+        .name = "maddn.d",
+        .translate = translate_nop,
+        .coprocessor = 0x1,
+    }, {
+        .name = "maddn.s",
+        .translate = translate_nop,
+        .coprocessor = 0x1,
+    }, {
+        .name = "mkdadj.d",
+        .translate = translate_mkdadj_d,
+        .coprocessor = 0x1,
+    }, {
+        .name = "mkdadj.s",
+        .translate = translate_mkdadj_s,
+        .coprocessor = 0x1,
+    }, {
+        .name = "mksadj.d",
+        .translate = translate_mksadj_d,
+        .coprocessor = 0x1,
+    }, {
+        .name = "mksadj.s",
+        .translate = translate_mksadj_s,
+        .coprocessor = 0x1,
     }, {
         .name = "mov.d",
         .translate = translate_mov_d,
@@ -7567,6 +7655,14 @@ static const XtensaOpcodeOps fpu_ops[] = {
         .name = "neg.s",
         .translate = translate_neg_s,
         .coprocessor = 0x1,
+    }, {
+        .name = "nexp01.d",
+        .translate = translate_nop,
+        .coprocessor = 0x1,
+    }, {
+        .name = "nexp01.s",
+        .translate = translate_nop,
+        .coprocessor = 0x1,
     }, {
         .name = "oeq.d",
         .translate = translate_compare_d,
@@ -7660,6 +7756,14 @@ static const XtensaOpcodeOps fpu_ops[] = {
         .par = (const uint32_t[]){true, true, true},
         .op_flags = XTENSA_OP_STORE,
         .coprocessor = 0x1,
+    }, {
+        .name = "sqrt0.d",
+        .translate = translate_nop,
+        .coprocessor = 0x1,
+    }, {
+        .name = "sqrt0.s",
+        .translate = translate_nop,
+        .coprocessor = 0x1,
     }, {
         .name = "ssi",
         .translate = translate_ldsti_s,
-- 
2.20.1


