Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81EAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F201206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOMZ4l05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F201206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgWE-0007dk-Pi
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3k-0008Bf-OS
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:48 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3i-0001s8-Qk
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:48 -0400
Received: by mail-pf1-x441.google.com with SMTP id k15so1822227pfc.12
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k4SMKMjkRRkG1Mjn2l2ewz/RkrM2zbTl1em1p59D3mo=;
 b=XOMZ4l05D5Rfa+RZYvVOAmYA4Ea7BrPh93a/iBcTGBXiFOijdkTlviHEy5BVinV0Bt
 uPVhZkwGUaeXcbde/ZogK+xLVh6tAJXqNSNMUgFZhZ0YA5xWn/hzJVin5dTzMyB/F/Qj
 O1O4UQnstTqY73sF9zq37W1rQeWL+bCQXWuvR/abF2vc0hkiWCCg25ZY+SV7pSudZYwa
 qKxEOaS8HrgrPC5aoQ0lJGc5eEZ63hSRl9hw2VzQ5OA/GsMpUyGyDdTQPuTh6u/zI6Gv
 muqyWDCOrLwaRzJ/O7ui4WbA6QCMY4AJV84PYzpjmik8cEm0OAX6wAu8tKHuJjRMjSSg
 /nzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k4SMKMjkRRkG1Mjn2l2ewz/RkrM2zbTl1em1p59D3mo=;
 b=K72uHXzifAdeJpStBHI7XXIhrft/GrkdOFOdfRkoEkPRnI+6UBO7XcH3tb5YN+uzue
 t+zrN6hGTnrZ7lSnwkofedM0A6HIXY8KuDzzJ1kYMVPcwgoXiLoA6/ryfq7S4BAzvRTf
 1U1wMZhnHTD9yJp4+Rmhg/tcBavlSu10TDZ8NeAagDRoLh35vEQpQGZz7M5S0pZytkL8
 +oUwmLQfbWTG3yuG4tEvnlVEiXRznWgIbZyKwJJFdE0tOD0ECxCWmUixNB0+c0rE/8lR
 eTkQa4AqmSVG1yLIJ/4S8W3ynL51keBHkA0W9XmJWhr/tFqi6lTLnAH5EfnHlZVTyWBC
 bdIA==
X-Gm-Message-State: AOAM531YO1XZKWp1+8eVEoUAofWVGlK/ehq/YkpYPElzZUfuMddPva+Y
 5KZmJb8vkiS+K9OQiyEMdIGqlupy9f8koA==
X-Google-Smtp-Source: ABdhPJwb2fi2TLa6HkBFE5JCLLRnBbPRsxq1cjUyFol06ztnQHVlPYwartnnqcslAOj+Ow5GyaXBXA==
X-Received: by 2002:a62:2d1:: with SMTP id 200mr9524092pfc.154.1598389245007; 
 Tue, 25 Aug 2020 14:00:45 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 42/77] target/microblaze: Convert dec_div to decodetree
Date: Tue, 25 Aug 2020 13:59:15 -0700
Message-Id: <20200825205950.730499-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
 target/microblaze/insns.decode |  3 +++
 target/microblaze/translate.c  | 35 +++++++++++++---------------------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 65a8a53b54..18619e923e 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -47,6 +47,9 @@ andni           101011 ..... ..... ................     @typeb
 cmp             000101 ..... ..... ..... 000 0000 0001  @typea
 cmpu            000101 ..... ..... ..... 000 0000 0011  @typea
 
+idiv            010010 ..... ..... ..... 000 0000 0000  @typea
+idivu           010010 ..... ..... ..... 000 0000 0010  @typea
+
 mul             010000 ..... ..... ..... 000 0000 0000  @typea
 mulh            010000 ..... ..... ..... 000 0000 0001  @typea
 mulhu           010000 ..... ..... ..... 000 0000 0011  @typea
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index dc6ea523b5..1d54ea02f0 100644
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
@@ -669,27 +682,6 @@ static void dec_msr(DisasContext *dc)
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
@@ -1551,7 +1543,6 @@ static struct decoder_info {
     {DEC_BCC, dec_bcc},
     {DEC_RTS, dec_rts},
     {DEC_FPU, dec_fpu},
-    {DEC_DIV, dec_div},
     {DEC_MSR, dec_msr},
     {DEC_STREAM, dec_stream},
     {{0, 0}, dec_null}
-- 
2.25.1


