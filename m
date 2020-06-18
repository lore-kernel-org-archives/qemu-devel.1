Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAFEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8752100A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yf0rlRMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8752100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmAC-0004JN-Jr
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8d-0001kB-JQ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:26:55 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8c-0002GO-1m
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:26:55 -0400
Received: by mail-pf1-x444.google.com with SMTP id x22so2202815pfn.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s4wGmXAIkyJLsPXTOxLRpkXsjobp8ryXeXVLTjvMEOw=;
 b=Yf0rlRMKLpPaa9dg+YIf886Pe/rQjbGakYMGacDc603PSHbnpw+ciOY4/njNbM57OG
 djrqXLZo2B0RK8F1e/uf5Z1pfbIF9Z4MOsW4C6VMTs7+rXWdBERDzutL/k3k7fPA+i5M
 oU8wIt3qbO/8ZLXUtV3biJzDCzvC+X9F8MPL9qIZz3NsCaE9t55imLiBof/+w7cq7DWR
 tGoQzSCImcIU4lNLEJwzistEZ9dl/u1Y4xgSe2fQemt72PuqG2Jv/fU2DCQ/AYB4O5QS
 BKq+qSqW0qP7KY7R+tGHXIa+DbVpIvc98aHbnRWpo7JK7qJCZQTReMP6hl+IXv9bEeg2
 lQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s4wGmXAIkyJLsPXTOxLRpkXsjobp8ryXeXVLTjvMEOw=;
 b=fS5hwGUEGTGZELm3CZU9lou89LsYo/3tBivcd2NzKFHziFo4vnJoGi7bz95v7pjDIX
 Oemh9nmwwUAxSPL6Q+iKpIa2Ebca8aDXGEuQLY+6AXqROcLcssH3noVILkE5U32Okjo3
 aA+hb/R2tfZzKjNLHKyEHHVVYVy/rdgxOShsByywcpIBbEYvY3L2tx/MWv4oeWh5P3cO
 hugcNSCO0YnJ3ZGByDum5+KmA8fDTZBMYELym9r/aKAJcJMdAaY/oX96kAL1qcR0Smkf
 9MLdKSOiPZKj4Rui+W2HK4toEvu71Lo/xOAcjvAx4YSRrdCocUvsud18oyTsv8zbDWEs
 B5qg==
X-Gm-Message-State: AOAM533cbBXIcn+CCYCFMSVZrEHflhd1646rdM7tuGYeyL33VuwtxzDo
 EUirnEgYALIJVhLqC8A/Y0ofUcSqXE8=
X-Google-Smtp-Source: ABdhPJxMej/HixwVCY/mu1L5BAcqNH1uqxqZL17VgdUmlnfsGNFv7K7wkG6Ow0QH6VnV63OVY+vOsQ==
X-Received: by 2002:a62:3806:: with SMTP id f6mr1946040pfa.102.1592454412278; 
 Wed, 17 Jun 2020 21:26:52 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o16sm1162035pgg.57.2020.06.17.21.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:26:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 004/100] target/arm: Split out gen_gvec_fn_zzz, do_zzz_fn
Date: Wed, 17 Jun 2020 21:25:08 -0700
Message-Id: <20200618042644.1685561-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Model gen_gvec_fn_zzz on gen_gvec_fn3 in translate-a64.c, but
indicating which kind of register and in which order.

Model do_zzz_fn on the other do_foo functions that take an
argument set and verify sve enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 43 +++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index bc286331cb..a8d5c7421d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -153,16 +153,13 @@ static void gen_gvec_fn_zz(DisasContext *s, GVecGen2Fn *gvec_fn,
 }
 
 /* Invoke a vector expander on three Zregs.  */
-static bool do_vector3_z(DisasContext *s, GVecGen3Fn *gvec_fn,
-                         int esz, int rd, int rn, int rm)
+static void gen_gvec_fn_zzz(DisasContext *s, GVecGen3Fn *gvec_fn,
+                            int esz, int rd, int rn, int rm)
 {
-    if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        gvec_fn(esz, vec_full_reg_offset(s, rd),
-                vec_full_reg_offset(s, rn),
-                vec_full_reg_offset(s, rm), vsz, vsz);
-    }
-    return true;
+    unsigned vsz = vec_full_reg_size(s);
+    gvec_fn(esz, vec_full_reg_offset(s, rd),
+            vec_full_reg_offset(s, rn),
+            vec_full_reg_offset(s, rm), vsz, vsz);
 }
 
 /* Invoke a vector move on two Zregs.  */
@@ -274,24 +271,32 @@ const uint64_t pred_esz_masks[4] = {
  *** SVE Logical - Unpredicated Group
  */
 
+static bool do_zzz_fn(DisasContext *s, arg_rrr_esz *a, GVecGen3Fn *gvec_fn)
+{
+    if (sve_access_check(s)) {
+        gen_gvec_fn_zzz(s, gvec_fn, a->esz, a->rd, a->rn, a->rm);
+    }
+    return true;
+}
+
 static bool trans_AND_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_and, 0, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_and);
 }
 
 static bool trans_ORR_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_or, 0, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_or);
 }
 
 static bool trans_EOR_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_xor, 0, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_xor);
 }
 
 static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_andc);
 }
 
 /*
@@ -300,32 +305,32 @@ static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a)
 
 static bool trans_ADD_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_add, a->esz, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_add);
 }
 
 static bool trans_SUB_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_sub, a->esz, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_sub);
 }
 
 static bool trans_SQADD_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_ssadd, a->esz, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_ssadd);
 }
 
 static bool trans_SQSUB_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_sssub, a->esz, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_sssub);
 }
 
 static bool trans_UQADD_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_usadd, a->esz, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_usadd);
 }
 
 static bool trans_UQSUB_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_ussub, a->esz, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_ussub);
 }
 
 /*
-- 
2.25.1


