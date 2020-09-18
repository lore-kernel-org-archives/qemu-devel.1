Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17D4C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46156208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ql8amN+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46156208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJM23-0001ZK-Ce
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLI7-0000uI-9o
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:27 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:33132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHo-0007DQ-7J
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:23 -0400
Received: by mail-pj1-x1044.google.com with SMTP id md22so4604441pjb.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tpgwU+O2Pyt/u4rQ1PaoM0R+miZyXm0Qzr3tAtW7L6c=;
 b=Ql8amN+xWtuJhkPjoOXWPeOMnsejcjZJtsBpVEVjwfAGbata+yob1JQv16IaGld45x
 Qb3de2irou0ZZL+WR7e/y6mrs/9/VwKoeW4rePjalii5bEgApG7sIiLK3d6rD1fpMGRU
 dWiC1kT5KcbdyVihov9fo2l2HKMMWZW7OzcK76mAhV0zV1yrqMYHRSp0wxCxOTs+5G+w
 EKtui3HcZX3aT6mo4CzFkleFL7DesUWAtfTnnx1BPgbXZIlHfSoIw//v6bAc5TQqdxK1
 uBWudgFEHTpSKxKvKfeViiXqa3yygeFxIS1erD95qjcN2Hxt7eBxLKNq4Oq/tL6Y/bT1
 u0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tpgwU+O2Pyt/u4rQ1PaoM0R+miZyXm0Qzr3tAtW7L6c=;
 b=bKpP+Kxr+PFYTQmiIOXjLx7caQNyYDPbisqyycaIe3T5xmZHV6wdsSwD4AopZBIgBp
 86q3t4ZUzGiGuaw5N3Oqw+Ia6qUB9BQJfZaDaWjB7fEzuESO6ERb43Bfipu0sdqtvp7K
 O0ivORgVu7E3Oz+hDwq1WJiNfCE63bzfMe9vVDZxMFQSmATggk90VGcmbcJ/rWYfAC4u
 9Xw+rejLDM5VT4Wit1VvHeeY8+/MRDJWBtHUk4QnL5kZWG/riaP5FmBk2m9AlRSJ9kRQ
 mGJHvTC9rpFF//d8axfVqipnha8QezPYR7MmpP/qanLZZoMA1BRDAyXzYVg8bT5xrHnO
 KkKA==
X-Gm-Message-State: AOAM530l9Mjem5qLkv2smb32fb0HCvvfeenOUyyeHzdovUtsQ7tl9db9
 sphlMcOmkg8ODHNBvxQr3ge8qkgrduNeDw==
X-Google-Smtp-Source: ABdhPJwaagueNwgQmf5LdgaXYAVZBEN80kU4itwiVW8562wFKNB+4GAo+E7B57evy8cSBrUSlxBV6g==
X-Received: by 2002:a17:90a:ea09:: with SMTP id
 w9mr13600298pjy.203.1600454344420; 
 Fri, 18 Sep 2020 11:39:04 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 54/81] target/arm: Split out formats for 3 vectors + 1 index
Date: Fri, 18 Sep 2020 11:37:24 -0700
Message-Id: <20200918183751.2787647-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Used by FMLA and DOT, but will shortly be used more.
Split FMLA from FMLS to avoid an extra sub field;
similarly for SDOT from UDOT.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      | 29 +++++++++++++++++++----------
 target/arm/translate-sve.c | 38 ++++++++++++++++++++++++++++----------
 2 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index a121e55f07..ea6ec5f198 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -73,6 +73,7 @@
 &rprr_s         rd pg rn rm s
 &rprr_esz       rd pg rn rm esz
 &rrrr_esz       rd ra rn rm esz
+&rrxr_esz       rd rn rm ra index esz
 &rprrr_esz      rd pg rn rm ra esz
 &rpri_esz       rd pg rn imm esz
 &ptrue          rd esz pat s
@@ -254,6 +255,14 @@
 @rrx_d          ........ 11 . index:1 rm:4 ...... rn:5 rd:5 \
                 &rrx_esz esz=3
 
+# Three registers and a scalar by index
+@rrxr_h         ........ 0. . ..      rm:3 ...... rn:5 rd:5 \
+                &rrxr_esz ra=%reg_movprfx index=%index3_22_19 esz=1
+@rrxr_s         ........ 10 . index:2 rm:3 ...... rn:5 rd:5 \
+                &rrxr_esz ra=%reg_movprfx esz=2
+@rrxr_d         ........ 11 . index:1 rm:4 ...... rn:5 rd:5 \
+                &rrxr_esz ra=%reg_movprfx esz=3
+
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
 
@@ -769,10 +778,10 @@ DOT_zzzz        01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5 \
                 ra=%reg_movprfx
 
 # SVE integer dot product (indexed)
-DOT_zzxw        01000100 101 index:2 rm:3 00000 u:1 rn:5 rd:5 \
-                sz=0 ra=%reg_movprfx
-DOT_zzxw        01000100 111 index:1 rm:4 00000 u:1 rn:5 rd:5 \
-                sz=1 ra=%reg_movprfx
+SDOT_zzxw_s     01000100 .. 1 ..... 000000 ..... .....          @rrxr_s
+SDOT_zzxw_d     01000100 .. 1 ..... 000000 ..... .....          @rrxr_d
+UDOT_zzxw_s     01000100 .. 1 ..... 000001 ..... .....          @rrxr_s
+UDOT_zzxw_d     01000100 .. 1 ..... 000001 ..... .....          @rrxr_d
 
 # SVE floating-point complex add (predicated)
 FCADD           01100100 esz:2 00000 rot:1 100 pg:3 rm:5 rd:5 \
@@ -791,12 +800,12 @@ FCMLA_zzxz      01100100 11 1 index:1 rm:4 0001 rot:2 rn:5 rd:5 \
 ### SVE FP Multiply-Add Indexed Group
 
 # SVE floating-point multiply-add (indexed)
-FMLA_zzxz       01100100 0.1 .. rm:3 00000 sub:1 rn:5 rd:5 \
-                ra=%reg_movprfx index=%index3_22_19 esz=1
-FMLA_zzxz       01100100 101 index:2 rm:3 00000 sub:1 rn:5 rd:5 \
-                ra=%reg_movprfx esz=2
-FMLA_zzxz       01100100 111 index:1 rm:4 00000 sub:1 rn:5 rd:5 \
-                ra=%reg_movprfx esz=3
+FMLA_zzxz       01100100 .. 1 ..... 000000 ..... .....  @rrxr_h
+FMLA_zzxz       01100100 .. 1 ..... 000000 ..... .....  @rrxr_s
+FMLA_zzxz       01100100 .. 1 ..... 000000 ..... .....  @rrxr_d
+FMLS_zzxz       01100100 .. 1 ..... 000001 ..... .....  @rrxr_h
+FMLS_zzxz       01100100 .. 1 ..... 000001 ..... .....  @rrxr_s
+FMLS_zzxz       01100100 .. 1 ..... 000001 ..... .....  @rrxr_d
 
 ### SVE FP Multiply Indexed Group
 
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 10200f0207..7c50298302 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3817,26 +3817,34 @@ static bool trans_DOT_zzzz(DisasContext *s, arg_DOT_zzzz *a)
     return true;
 }
 
-static bool trans_DOT_zzxw(DisasContext *s, arg_DOT_zzxw *a)
+static bool do_zzxz_ool(DisasContext *s, arg_rrxr_esz *a,
+                        gen_helper_gvec_4 *fn)
 {
-    static gen_helper_gvec_4 * const fns[2][2] = {
-        { gen_helper_gvec_sdot_idx_b, gen_helper_gvec_sdot_idx_h },
-        { gen_helper_gvec_udot_idx_b, gen_helper_gvec_udot_idx_h }
-    };
-
+    if (fn == NULL) {
+        return false;
+    }
     if (sve_access_check(s)) {
-        gen_gvec_ool_zzzz(s, fns[a->u][a->sz], a->rd, a->rn, a->rm,
-                          a->ra, a->index);
+        gen_gvec_ool_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, a->index);
     }
     return true;
 }
 
+#define DO_RRXR(NAME, FUNC) \
+    static bool NAME(DisasContext *s, arg_rrxr_esz *a)  \
+    { return do_zzxz_ool(s, a, FUNC); }
+
+DO_RRXR(trans_SDOT_zzxw_s, gen_helper_gvec_sdot_idx_b)
+DO_RRXR(trans_SDOT_zzxw_d, gen_helper_gvec_sdot_idx_h)
+DO_RRXR(trans_UDOT_zzxw_s, gen_helper_gvec_udot_idx_b)
+DO_RRXR(trans_UDOT_zzxw_d, gen_helper_gvec_udot_idx_h)
+
+#undef DO_RRXR
 
 /*
  *** SVE Floating Point Multiply-Add Indexed Group
  */
 
-static bool trans_FMLA_zzxz(DisasContext *s, arg_FMLA_zzxz *a)
+static bool do_FMLA_zzxz(DisasContext *s, arg_rrxr_esz *a, bool sub)
 {
     static gen_helper_gvec_4_ptr * const fns[3] = {
         gen_helper_gvec_fmla_idx_h,
@@ -3851,13 +3859,23 @@ static bool trans_FMLA_zzxz(DisasContext *s, arg_FMLA_zzxz *a)
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
                            vec_full_reg_offset(s, a->ra),
-                           status, vsz, vsz, (a->index << 1) | a->sub,
+                           status, vsz, vsz, (a->index << 1) | sub,
                            fns[a->esz - 1]);
         tcg_temp_free_ptr(status);
     }
     return true;
 }
 
+static bool trans_FMLA_zzxz(DisasContext *s, arg_FMLA_zzxz *a)
+{
+    return do_FMLA_zzxz(s, a, false);
+}
+
+static bool trans_FMLS_zzxz(DisasContext *s, arg_FMLA_zzxz *a)
+{
+    return do_FMLA_zzxz(s, a, true);
+}
+
 /*
  *** SVE Floating Point Multiply Indexed Group
  */
-- 
2.25.1


