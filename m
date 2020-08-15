Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA4BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A27723AA0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rP4gPilP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A27723AA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ytN-0005TD-9W
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6yrX-0002kz-0m
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:16:55 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6yrV-0003Xd-5q
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:16:54 -0400
Received: by mail-pl1-x643.google.com with SMTP id u10so5480164plr.7
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 09:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cA0vYLAZE6i6Tzs841BUfloSXj9bRzCj5fg2IHyhivw=;
 b=rP4gPilPMT/vIfoGrXcjvkyRln4/9P+j8elpCDXBKje9s8TcAciV84bd59WGf1r2Ku
 lPPeCnLlIQtMVQDZIY9VQdxz7qAxkrYz6vH5Wae4b/YasxymB+PKNjRT0V3KQrgRp4vu
 LP8fQm9+dUe5RKn3CyCc0Y4StYOy3aPGqfVjiXPJQCBtUdiluAYPSEe79ObpfyM8dDud
 MgNf3pofyaKMyCapft8nnKdKIxwxSQs/skJRbGuO5+Ww8cTGDqHlTTlxHt5O5Sf+n6V2
 y7RJc35pWJYbrRF8OfPhLM4lvQDcjkNrMyvyuVAFK7acROoJEASDbwOv7DPm7zIdY7UW
 vi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cA0vYLAZE6i6Tzs841BUfloSXj9bRzCj5fg2IHyhivw=;
 b=pFn5zo+gMtlFZFLIrT8Lk4Hk0w890KfMs6NN9Ft+7CLV6/bYfoshq7XEs8dyutLg1U
 tExkR9vGZjpC5knSUGgUU3DhJMno3bxX8yu7kl1anWxpdQ7qd4HzgVMdCIx9qsHB4hF/
 TvYAxs0CFRhvTkNM+LuDj76MlKHT0o7eyflFSRVBOohsVJA+5FfBxaykmg23DWEGBh7T
 +3IP7z629a/RfQ9Sj0xwUK6Z50odLYxvvXczHNOdoabfyyrNpsQdUd6iI0oWkgEbANUP
 IQp5iwuu7WGXwXsJewiVwMOhGilv1Lbk9f951PP971O2CsfeAGgbmjRF03COfZ3Pf2G+
 DZIA==
X-Gm-Message-State: AOAM532gaSnsgttB9u2yK4lPpKrXRuGq9rMsBcUvZ/O+lkDbKx5dbsZC
 LeuSqpbQ847VdTy5qqNKHyiSnsV7g9nTWw==
X-Google-Smtp-Source: ABdhPJx8N6eZgthigZEvAaYRXmC6X8r2WzyxnuGXuS63su5YbLvD3s9GgrVRtCcq+5WdFvMrcQr1Zg==
X-Received: by 2002:a62:7f06:: with SMTP id a6mr3752428pfd.300.1597455122610; 
 Fri, 14 Aug 2020 18:32:02 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:32:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/20] target/arm: Split out gen_gvec_ool_zzz
Date: Fri, 14 Aug 2020 18:31:36 -0700
Message-Id: <20200815013145.539409-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 53 +++++++++++++-------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 3361e1c01f..3a90a645fd 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -142,6 +142,17 @@ static int pred_gvec_reg_size(DisasContext *s)
     return size_for_gvec(pred_full_reg_size(s));
 }
 
+/* Invoke an out-of-line helper on 3 Zregs. */
+static void gen_gvec_ool_zzz(DisasContext *s, gen_helper_gvec_3 *fn,
+                             int rd, int rn, int rm, int data)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm),
+                       vsz, vsz, data, fn);
+}
+
 /* Invoke an out-of-line helper on 2 Zregs and a predicate. */
 static void gen_gvec_ool_zzp(DisasContext *s, gen_helper_gvec_3 *fn,
                              int rd, int rn, int pg, int data)
@@ -769,11 +780,7 @@ static bool do_zzw_ool(DisasContext *s, arg_rrr_esz *a, gen_helper_gvec_3 *fn)
         return false;
     }
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, 0, fn);
+        gen_gvec_ool_zzz(s, fn, a->rd, a->rn, a->rm, 0);
     }
     return true;
 }
@@ -947,11 +954,7 @@ static bool trans_RDVL(DisasContext *s, arg_RDVL *a)
 static bool do_adr(DisasContext *s, arg_rrri *a, gen_helper_gvec_3 *fn)
 {
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, a->imm, fn);
+        gen_gvec_ool_zzz(s, fn, a->rd, a->rn, a->rm, a->imm);
     }
     return true;
 }
@@ -1012,11 +1015,7 @@ static bool trans_FTSSEL(DisasContext *s, arg_rrr_esz *a)
         return false;
     }
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, 0, fns[a->esz]);
+        gen_gvec_ool_zzz(s, fns[a->esz], a->rd, a->rn, a->rm, 0);
     }
     return true;
 }
@@ -2067,11 +2066,7 @@ static bool trans_TBL(DisasContext *s, arg_rrr_esz *a)
     };
 
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, 0, fns[a->esz]);
+        gen_gvec_ool_zzz(s, fns[a->esz], a->rd, a->rn, a->rm, 0);
     }
     return true;
 }
@@ -2244,11 +2239,7 @@ static bool do_zzz_data_ool(DisasContext *s, arg_rrr_esz *a, int data,
                             gen_helper_gvec_3 *fn)
 {
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, data, fn);
+        gen_gvec_ool_zzz(s, fn, a->rd, a->rn, a->rm, data);
     }
     return true;
 }
@@ -3373,11 +3364,7 @@ static bool trans_DOT_zzz(DisasContext *s, arg_DOT_zzz *a)
     };
 
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, 0, fns[a->u][a->sz]);
+        gen_gvec_ool_zzz(s, fns[a->u][a->sz], a->rd, a->rn, a->rm, 0);
     }
     return true;
 }
@@ -3390,11 +3377,7 @@ static bool trans_DOT_zzx(DisasContext *s, arg_DOT_zzx *a)
     };
 
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, a->index, fns[a->u][a->sz]);
+        gen_gvec_ool_zzz(s, fns[a->u][a->sz], a->rd, a->rn, a->rm, a->index);
     }
     return true;
 }
-- 
2.25.1


