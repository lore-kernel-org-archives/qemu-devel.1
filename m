Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EADC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D08F206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BT3FWAhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D08F206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIm3-0003aJ-KI
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS2-0002em-Py
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:02 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS1-00017W-40
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:02 -0400
Received: by mail-pf1-x444.google.com with SMTP id m9so107548pfh.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 15:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C8YfKGyEdI8vzXLOKLYupIYgZtt3IjmnEZ/eJOq5z60=;
 b=BT3FWAhDnjTOrLH0OGf/3fssRSaj5fHdTxJOMym5Wma+opHFpcLLRdzfih6hFZMri0
 bgr4uZj2zJ8olb3wNO3nWfo7fAcH5P/bayFNW0Tum0+6Ct8yN+ZbPo2gByrx2eVrqF9Z
 nru+yNcsJ6rVT+eUAaiJLdUa5wQxe9LKKRs0Gw/Szn4BsrIHYUVUQUXO3mYudTrn7kAC
 lNSuQKUhrazOdF/B6Cs77/P1v3l1xc/vohvQR63EEKqz9C7XEZZL6RzOEbnjeDVISv8g
 oG+D36jeIG5aZEJkWrgG5iWZkaF5AIuwbGMX04/u90II8Gbl1RR304ouZtecCpIYi/DC
 66aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C8YfKGyEdI8vzXLOKLYupIYgZtt3IjmnEZ/eJOq5z60=;
 b=Xs2FWyvptpTozB1FS4QRMFGdMzKUGu7Ewq+1+m+o8nms0142z8rkQXNWCeiNx1EWZ+
 n0DmCXQfZ4ymtGI2rP2Z2P8AxejAgS/PkIEypBnh15IPfuOKTeCK/1UNCZT7wzSqoFBQ
 doBqaNXFPnFVGPep+atLlxXjDAAMv2p32EX3ZilylhUPlpQcDL+9rpBahQjRHXEBL38B
 c5Ara1BUn7ZPh/tpjv8dx/7ibfjIjqR8r/23ApuAfgQRN+k1q59kALQPwuns9zml9yR7
 nyVfRx40evstHdf4DlkEljFWi3X5dWLE0K8bMf8yUliGEzaAOWhZgtzCgIORgr9/dAzS
 PTKw==
X-Gm-Message-State: AOAM531U2TD3lvpRHt17KvHjAnNLi8He7aQ9bHgknNke6m+pnZwdTXx+
 ZUYQCAqP+njixA9U/9+d69ZpB3fq
X-Google-Smtp-Source: ABdhPJydahh50HLo7IMhSy/MFeHLnuBkxfkV9y5bL4E/ae3Q9ZPbPsBrdOGqLloNQvbSn7UIKExLNA==
X-Received: by 2002:a62:3741:: with SMTP id e62mr19161218pfa.127.1594246919440; 
 Wed, 08 Jul 2020 15:21:59 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id t73sm693517pfc.78.2020.07.08.15.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 15:21:58 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/21] target/xtensa: move FSR/FCR register accessors
Date: Wed,  8 Jul 2020 15:20:47 -0700
Message-Id: <20200708222101.24568-8-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708222101.24568-1-jcmvbkbc@gmail.com>
References: <20200708222101.24568-1-jcmvbkbc@gmail.com>
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

Move FSR/FCR register accessors from core opcodes to FPU2000 opcodes as
they are FPU2000-specific.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 64 +++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 0deaeef6b5fa..f859cd3f0818 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2813,18 +2813,6 @@ static void translate_wur(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_mov_i32(cpu_UR[par[0]], arg[0].in);
 }
 
-static void translate_wur_fpu2k_fcr(DisasContext *dc, const OpcodeArg arg[],
-                                    const uint32_t par[])
-{
-    gen_helper_wur_fpu2k_fcr(cpu_env, arg[0].in);
-}
-
-static void translate_wur_fsr(DisasContext *dc, const OpcodeArg arg[],
-                              const uint32_t par[])
-{
-    tcg_gen_andi_i32(cpu_UR[par[0]], arg[0].in, 0xffffff80);
-}
-
 static void translate_xor(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
@@ -4665,16 +4653,6 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "rur.expstate",
         .translate = translate_rur,
         .par = (const uint32_t[]){EXPSTATE},
-    }, {
-        .name = "rur.fcr",
-        .translate = translate_rur,
-        .par = (const uint32_t[]){FCR},
-        .coprocessor = 0x1,
-    }, {
-        .name = "rur.fsr",
-        .translate = translate_rur,
-        .par = (const uint32_t[]){FSR},
-        .coprocessor = 0x1,
     }, {
         .name = "rur.threadptr",
         .translate = translate_rur,
@@ -5581,16 +5559,6 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "wur.expstate",
         .translate = translate_wur,
         .par = (const uint32_t[]){EXPSTATE},
-    }, {
-        .name = "wur.fcr",
-        .translate = translate_wur_fpu2k_fcr,
-        .par = (const uint32_t[]){FCR},
-        .coprocessor = 0x1,
-    }, {
-        .name = "wur.fsr",
-        .translate = translate_wur_fsr,
-        .par = (const uint32_t[]){FSR},
-        .coprocessor = 0x1,
     }, {
         .name = "wur.threadptr",
         .translate = translate_wur,
@@ -6510,6 +6478,18 @@ static void translate_wfr_s(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_mov_i32(arg[0].out, arg[1].in);
 }
 
+static void translate_wur_fpu2k_fcr(DisasContext *dc, const OpcodeArg arg[],
+                                    const uint32_t par[])
+{
+    gen_helper_wur_fpu2k_fcr(cpu_env, arg[0].in);
+}
+
+static void translate_wur_fpu2k_fsr(DisasContext *dc, const OpcodeArg arg[],
+                                    const uint32_t par[])
+{
+    tcg_gen_andi_i32(cpu_UR[par[0]], arg[0].in, 0xffffff80);
+}
+
 static const XtensaOpcodeOps fpu2000_ops[] = {
     {
         .name = "abs.s",
@@ -6632,6 +6612,16 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_nearest_even, false},
         .coprocessor = 0x1,
+    }, {
+        .name = "rur.fcr",
+        .translate = translate_rur,
+        .par = (const uint32_t[]){FCR},
+        .coprocessor = 0x1,
+    }, {
+        .name = "rur.fsr",
+        .translate = translate_rur,
+        .par = (const uint32_t[]){FSR},
+        .coprocessor = 0x1,
     }, {
         .name = "ssi",
         .translate = translate_ldsti,
@@ -6699,6 +6689,16 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "wfr",
         .translate = translate_wfr_s,
         .coprocessor = 0x1,
+    }, {
+        .name = "wur.fcr",
+        .translate = translate_wur_fpu2k_fcr,
+        .par = (const uint32_t[]){FCR},
+        .coprocessor = 0x1,
+    }, {
+        .name = "wur.fsr",
+        .translate = translate_wur_fpu2k_fsr,
+        .par = (const uint32_t[]){FSR},
+        .coprocessor = 0x1,
     },
 };
 
-- 
2.20.1


