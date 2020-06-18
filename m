Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1078BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF5920739
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="si6QS1bE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF5920739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmBu-0000by-W7
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8k-00022x-57
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:27:02 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:33240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8i-0002II-IS
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:27:01 -0400
Received: by mail-pj1-x1043.google.com with SMTP id b7so2990516pju.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CDc9TG70gufzBOuiRWeZCFf3ZumKEjj9+6ML7NwYukE=;
 b=si6QS1bE9lgfVUi/MCeZJP2wmLMg4PfgZHj7FOzs5X3yRuQiA2s/ocEyIeZxsckRYJ
 BwhDCeWISlM0boTEjjeN/IPl7ncU51lRXth1reCYEAEN/KwWDelykPGsu0dRUxwFVZUV
 Px3b6NoEJz1NLmUlpvZ07NVeAROfhQxfZQ1HqiO6VkDEl+ju/QTUWg3qBQOKdhFgZpTB
 6SnrLNa7IKEwVb6eBn9nWTKu8yrWQVimM5xZJmQ4AT2pLyHZ/aEeA7QaIh6OwshalpGw
 vj+WUeFlDbl6gJT1GwyWmSuokNS9F1z82pcwT5DilOIdEJj2No3awAk3C60MeRboMNST
 A7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CDc9TG70gufzBOuiRWeZCFf3ZumKEjj9+6ML7NwYukE=;
 b=Np1akOfMyoSQ6oRJUvoEfu+R+Sh94cSQia5lvzpCvsJuaOzwJ3geHpF3TzzkMJSf6b
 Lkx+WDBuJEQJpHuBH9EQ/hrKqczlZCgmyDgf2fCMZrWwJgocCnxamKKqHn8c9dSyEyKe
 o0OZG0xvUldhLEYRU4wDqJaeHGLSl4qLrbPUHbbICtcH2yKIBmurnXZfzXmDQvj5WHZz
 OP1ycfwFhD1Nux27Y6WC4pkJVaAxrimNGSw8fNRnKBwMoxzfssGTLW+8cegSgNQNw9Cm
 eZOaVVWR6Zk/Qt0Ye4VtZi5FkNpNzTLaCpWjhRqhWtrBm13JLCK0J6mRULkHROwvyUYO
 d6vQ==
X-Gm-Message-State: AOAM530BzlJPAkizgtJ+BpVzqLcZuSURM4uvNobm5rj+3oJCFxW+kfSJ
 /oY2YL+wl4AtD1vRDYQb6bT77WkxcTA=
X-Google-Smtp-Source: ABdhPJwS9PMb/hp1Llp/iTPMsYBUsM6SUFAlYPHVjPPXU5wPFMPw/ZQiuz2gLFjJtSAEjTzHadNNbA==
X-Received: by 2002:a17:902:7043:: with SMTP id
 h3mr2213726plt.200.1592454418786; 
 Wed, 17 Jun 2020 21:26:58 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o16sm1162035pgg.57.2020.06.17.21.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:26:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 009/100] target/arm: Split out gen_gvec_ool_zzzp
Date: Wed, 17 Jun 2020 21:25:13 -0700
Message-Id: <20200618042644.1685561-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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

Model after gen_gvec_fn_zzz et al.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 741f4d8b32..5d4f572b67 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -142,8 +142,19 @@ static int pred_gvec_reg_size(DisasContext *s)
     return size_for_gvec(pred_full_reg_size(s));
 }
 
-/* Invoke a vector expander on two Zregs.  */
+/* Invoke an out-of-line helper on 3 Zregs and a predicate. */
+static void gen_gvec_ool_zzzp(DisasContext *s, gen_helper_gvec_4 *fn,
+                              int rd, int rn, int rm, int pg, int data)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm),
+                       pred_full_reg_offset(s, pg),
+                       vsz, vsz, data, fn);
+}
 
+/* Invoke a vector expander on two Zregs.  */
 static void gen_gvec_fn_zz(DisasContext *s, GVecGen2Fn *gvec_fn,
                            int esz, int rd, int rn)
 {
@@ -314,16 +325,11 @@ static bool trans_UQSUB_zzz(DisasContext *s, arg_rrr_esz *a)
 
 static bool do_zpzz_ool(DisasContext *s, arg_rprr_esz *a, gen_helper_gvec_4 *fn)
 {
-    unsigned vsz = vec_full_reg_size(s);
     if (fn == NULL) {
         return false;
     }
     if (sve_access_check(s)) {
-        tcg_gen_gvec_4_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           pred_full_reg_offset(s, a->pg),
-                           vsz, vsz, 0, fn);
+        gen_gvec_ool_zzzp(s, fn, a->rd, a->rn, a->rm, a->pg, 0);
     }
     return true;
 }
@@ -337,12 +343,7 @@ static void do_sel_z(DisasContext *s, int rd, int rn, int rm, int pg, int esz)
         gen_helper_sve_sel_zpzz_b, gen_helper_sve_sel_zpzz_h,
         gen_helper_sve_sel_zpzz_s, gen_helper_sve_sel_zpzz_d
     };
-    unsigned vsz = vec_full_reg_size(s);
-    tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
-                       vec_full_reg_offset(s, rn),
-                       vec_full_reg_offset(s, rm),
-                       pred_full_reg_offset(s, pg),
-                       vsz, vsz, 0, fns[esz]);
+    gen_gvec_ool_zzzp(s, fns[esz], rd, rn, rm, pg, 0);
 }
 
 #define DO_ZPZZ(NAME, name) \
@@ -2704,12 +2705,8 @@ static bool trans_RBIT(DisasContext *s, arg_rpr_esz *a)
 static bool trans_SPLICE(DisasContext *s, arg_rprr_esz *a)
 {
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_4_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           pred_full_reg_offset(s, a->pg),
-                           vsz, vsz, a->esz, gen_helper_sve_splice);
+        gen_gvec_ool_zzzp(s, gen_helper_sve_splice,
+                          a->rd, a->rn, a->rm, a->pg, 0);
     }
     return true;
 }
-- 
2.25.1


