Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C3AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B76523B82
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zLmIOPoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B76523B82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k70Iy-0003Q8-PK
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 13:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k70IE-00030V-5c
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 13:48:34 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k70IC-0005kX-CW
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 13:48:33 -0400
Received: by mail-oi1-x244.google.com with SMTP id l84so11103054oig.10
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 10:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AwlieOmSDn/Rt8TnNZpP6jW//R9aevOAUmcoQvuaIu0=;
 b=zLmIOPoCrjmObGTyfj3dii+4lVz+oI81GQNI6AnXJGyoc/Ky43uQFq1D4IFK6R+JFQ
 xShIrmEy/qly+8q39OZBFHIK6lriSs8y5My3qnC3xNHYSzBwkMeAHriIVxGjdCi+cEFD
 2GUQyDWjJy+PeBn4mQkBjaHnJ/BlnKJ/NGGreH9x2D+gpAJB2itiTNjRzb0t1wZVjwNS
 pd7VkpN24S4eqQxxpbmrFIIFc7cQcg395noD0c+HBgYmtmZWyhofMmd9DedhIJxkc+q8
 1skWUYDLdhojlz8iOFlT7cb7IHFysu2K1s12o0zOSuhhB0LTQQf32mcaj3ZN/q7Ol6NC
 9caQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AwlieOmSDn/Rt8TnNZpP6jW//R9aevOAUmcoQvuaIu0=;
 b=cdhgKDzfWe7VT9I4mMP8LOwRRChZCenHDyNEyr1q8aZQGIyb8KOYTK+FTZ2E+YHa4Y
 cgtew8MMI2JF4dJ/o9P7TMjXD3wCnhDKRRoNRaQWx2aq2HP9EYD9n0sMSoJUWimhFloC
 ncqZfO+wzMmPurvi6yA5Z8eRIR8nDA7GpFeFJNK6rEReBxJmthsxfrNZpIb1nxP8yGtD
 aiW9SrhbNx7JqNtz2XjbG122tpybBfzcrofPStLCVtg6Q2qlbxls/dRe7R7ksC5Y8kar
 COGTlKeFEg0i0FWdZRxn82hKMXBqShwWzqKViPaPu6OuFgNQE45RbXvzwVplI86NGsLU
 bvdQ==
X-Gm-Message-State: AOAM530JubLVji4nRG2XXNRxCnIWeYmSvzIUyD9iM3cNyMT5y0AZdiYo
 gPhi8AekxTulCfbGB43+KUGCE44CAHm/vw==
X-Google-Smtp-Source: ABdhPJwSufAFPq1rt6hopWCIpgdlMaT2T2FNmFIqfvnoyNNQYvEEn1Mzk2Sf25gijORRk6yS0kbWxg==
X-Received: by 2002:a17:90a:c207:: with SMTP id
 e7mr4568675pjt.172.1597455111984; 
 Fri, 14 Aug 2020 18:31:51 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:31:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/20] target/arm: Split out gen_gvec_fn_zzz, do_zzz_fn
Date: Fri, 14 Aug 2020 18:31:28 -0700
Message-Id: <20200815013145.539409-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x244.google.com
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

Model gen_gvec_fn_zzz on gen_gvec_fn3 in translate-a64.c, but
indicating which kind of register and in which order.

Model do_zzz_fn on the other do_foo functions that take an
argument set and verify sve enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 43 +++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 28e27c55b5..b0fa38db1c 100644
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


