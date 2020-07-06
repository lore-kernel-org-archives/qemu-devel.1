Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4F8C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC9E20672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srm4Oetv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC9E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsasd-0006LB-44
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaq8-0000xt-T3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:48:00 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaq7-0000st-Af
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:48:00 -0400
Received: by mail-pf1-x444.google.com with SMTP id i14so1136274pfu.13
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 16:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oeaiwHJekTGuu/i90XgUZWAnMUSgKNijCQLv8/PbPh8=;
 b=srm4Oetvx42IW6H6Qgm6+tl8TBD5VUNsjYTL5BI9R3kjOOklHC4DfJUj1heKT7Kt8E
 311veSX7UUnDBxfzI826LxKjiWXUJhiN1hXKbWY1yItwhxj/duuLCNryJKRiS+yQinGM
 3mTHCJOqCoBLbqh4z6rxIFwxiOMoIiduBC5LXmARN25UU+h4iRVMpZ7EaVHpGLMC6RjW
 7cyd6Ig8AYeVmGJTUv+7gGTA0n45+98wDTCaGl8eeEhaxZGfES9I+snfZnim3J2ODr/j
 XaqbOkhs7dlDmnKHwLDG7NF1vvD+ScOPmhonT4HcqObatHB0NrEWTu9xyou+0dIdo+0c
 SMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oeaiwHJekTGuu/i90XgUZWAnMUSgKNijCQLv8/PbPh8=;
 b=KPhc8VrMdTFHqoRvKZBfDX9qFDuIIw9BqIpnmjpQcxd8xuzb1osPOsSC5TtRoz7xJF
 DMkeanJ3TTOIfhcNFp8dl9llBbrDsJD5W/mVyCPiyeIWCOShxVYX/O2cgYJzow9JFtIU
 PBWNtzU8Qt8FZZYHTyLmg9g531lTZMQLUiJpkB3YrvuQ/6qcnpEjwpd7axnMAqXwLEyt
 KTinGZSOo++JrDx4yJBgmldoG3mKg3ijG8z/WhYM9Fpj9MFzzGrAsCoRkGH0KvFPtYDj
 GpP2FFWWtlgVTu6qYVwir5+F+BTkQR0TjJwKSaPKgHkwXPHeZrzD1/pMLipHwgB0S1/d
 UCfQ==
X-Gm-Message-State: AOAM531rfaK70As/fcjdc8N+CD973daPgMiu4vak1EWjiCkpbLS6lHzT
 9PcLznN2U7o3xzeZRTJRpSgmJ8lR
X-Google-Smtp-Source: ABdhPJx00D792c47tDVHl+2FGhvoZglmon8/jHK+afwsSxo3NVurQsxDFLZyF+g68Hh3hc1qZ4njBg==
X-Received: by 2002:a63:cb05:: with SMTP id p5mr17107893pgg.120.1594079277841; 
 Mon, 06 Jul 2020 16:47:57 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id e15sm19647649pgt.17.2020.07.06.16.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 16:47:57 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/21] target/xtensa: move FSR/FCR register accessors
Date: Mon,  6 Jul 2020 16:47:23 -0700
Message-Id: <20200706234737.32378-8-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706234737.32378-1-jcmvbkbc@gmail.com>
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move FSR/FCR register accessors from core opcodes to FPU2000 opcodes as
they are FPU2000-specific.

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


