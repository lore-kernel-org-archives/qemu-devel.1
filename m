Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F79C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1862B2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LD+/DsM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1862B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmbe-0008Eo-6K
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKn-0005JQ-Ci
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:05 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:40973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKk-00063n-Mm
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:05 -0400
Received: by mail-pf1-x42a.google.com with SMTP id t9so805511pfq.8
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rWOc9BwUZsVi//eDSn3YgBVyZRgNAuFh68+VKq4fp/Q=;
 b=LD+/DsM68XC5buvs7Xbjn9dT4H3XqujGlPzBqjCCljAsvMWOlBzBtxKiJblJV9bxeb
 DHu9OneExkDDpo7P6UzWJ1a6b3gN5Z5S4GmicVGazw9yPeRqkWxG9qeF+VcO5vBMSwSH
 smoQ2+vknkB6VcVaW3twQTzocKwZk34FeHXGs/5pd9OijKBT08ge+J7wyqwW9L91la9i
 YklEKvbhbCku64qbemYdcSmAJMF8AVDCSXNtUHRnmHF2Bqzw7MUAdC9QP8bD9xy4Dl2U
 ufA+UYNv+q2j6FSdPCU7doAmD6n1NbCQhColaZI4Z+1ARmrcFv51kYJwyJZ+FE4NuC1m
 2Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rWOc9BwUZsVi//eDSn3YgBVyZRgNAuFh68+VKq4fp/Q=;
 b=fiBi9AmD5s7dtm4rGthFvHhYFhD8umDZ7EyyNWgrhBAay2/JCWtIRru55osHMIX4IW
 wEPX8ybsnVXkN8m3BOZxNfKH9swR9oajPxE44UKPUuhUAh/QsEEqcaeiSjoUxa/KOcaA
 TEXgJkK/ZYwiH1eoQcNqrtmXpLEfQJzvE09+Yp8it1dCSuIMxiuTWwUFh2iGHnhMI5nw
 nZLIKVH5sXkaoVOhmUwueCARZpkrtp9QdA3z1vIc7W1ff3PGy4afG4y0mx7OgIXi3/Aa
 ETBkZgzQeqTUDTDwc+Ue0/4cEIS2FfFW5Uep0arkb+SUHD0l4waLuHNDnI6MpRQ4U4Js
 xFlA==
X-Gm-Message-State: AOAM530gSuqxKJnyFD2Szs5v1WAC81C5XRnTXvDjxSElH9BkLMi9i60c
 JuBQ7UXt+S1d+nSIC2MfnrYQEJPA5Ntpig==
X-Google-Smtp-Source: ABdhPJxn3G7rL/Mvq5vfAM+WLA+6aQ3OSmJd6YS3qazc7FSu3UvMH59KeTZIiJZMs4YKKOEDWIlEFw==
X-Received: by 2002:a63:4b61:: with SMTP id k33mr1708075pgl.195.1598890020925; 
 Mon, 31 Aug 2020 09:07:00 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/76] target/microblaze: Convert dec_div to decodetree
Date: Mon, 31 Aug 2020 09:05:27 -0700
Message-Id: <20200831160601.833692-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  3 +++
 target/microblaze/translate.c  | 35 +++++++++++++---------------------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 1a2e22e44a..b2dcbdf784 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -50,6 +50,9 @@ andni           101011 ..... ..... ................     @typeb
 cmp             000101 ..... ..... ..... 000 0000 0001  @typea
 cmpu            000101 ..... ..... ..... 000 0000 0011  @typea
 
+idiv            010010 ..... ..... ..... 000 0000 0000  @typea
+idivu           010010 ..... ..... ..... 000 0000 0010  @typea
+
 mul             010000 ..... ..... ..... 000 0000 0000  @typea
 mulh            010000 ..... ..... ..... 000 0000 0001  @typea
 mulhu           010000 ..... ..... ..... 000 0000 0011  @typea
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 617e208583..9763b9d77c 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -368,6 +368,19 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA(cmp, false, gen_cmp)
 DO_TYPEA(cmpu, false, gen_cmpu)
 
+static void gen_idiv(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    gen_helper_divs(out, cpu_env, inb, ina);
+}
+
+static void gen_idivu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    gen_helper_divu(out, cpu_env, inb, ina);
+}
+
+DO_TYPEA_CFG(idiv, use_div, true, gen_idiv)
+DO_TYPEA_CFG(idivu, use_div, true, gen_idivu)
+
 static void gen_mulh(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
@@ -683,27 +696,6 @@ static void dec_msr(DisasContext *dc)
     }
 }
 
-/* Div unit.  */
-static void dec_div(DisasContext *dc)
-{
-    unsigned int u;
-
-    u = dc->imm & 2; 
-
-    if (trap_illegal(dc, !dc->cpu->cfg.use_div)) {
-        return;
-    }
-
-    if (u)
-        gen_helper_divu(cpu_R[dc->rd], cpu_env, *(dec_alu_op_b(dc)),
-                        cpu_R[dc->ra]);
-    else
-        gen_helper_divs(cpu_R[dc->rd], cpu_env, *(dec_alu_op_b(dc)),
-                        cpu_R[dc->ra]);
-    if (!dc->rd)
-        tcg_gen_movi_i32(cpu_R[dc->rd], 0);
-}
-
 static void dec_barrel(DisasContext *dc)
 {
     TCGv_i32 t0;
@@ -1565,7 +1557,6 @@ static struct decoder_info {
     {DEC_BCC, dec_bcc},
     {DEC_RTS, dec_rts},
     {DEC_FPU, dec_fpu},
-    {DEC_DIV, dec_div},
     {DEC_MSR, dec_msr},
     {DEC_STREAM, dec_stream},
     {{0, 0}, dec_null}
-- 
2.25.1


