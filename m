Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E22C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E18A23B18
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKrf+TQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E18A23B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yis-00073v-KD
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6yc6-0007Az-5r
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:00:58 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6yc4-0001RE-7r
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:00:57 -0400
Received: by mail-oi1-x243.google.com with SMTP id n128so7085509oif.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 09:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SDfyZ1vPdbyiEKDNiF+oq98+HOXuA4JwMfm0jf3z2+s=;
 b=JKrf+TQX3ghbMiQT0U6DNXZaI1HLVIPq4T8Ik6AKld+BYK/XN+cM4sNVqmOJLWALCt
 UYp3Nsx5BqQTlyGeactN2CqC3y5SI2pBCnqOpsB8lkTVBweEAfOKyAoJn6T1hZc6Scbo
 2/Js8ZDJd+VLOLow+YWVZ5EZ760wCHJMnT4JAj/+v+F7sDoIJrXD9DTaRLZxdnFzbqHX
 Zuf7mhBP4nxy+eHd2MIYc5OFowDuAHwnEKDLs+m9bodisyIgjwfRw1oBHTySDbVJLCXw
 nBDljL4Zcll3Mj0o9HO1xWqMvHlDN8KGpkZrWvt5bJXdlaV6o+mI2A3E2aP0Gg/aq1/V
 uSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SDfyZ1vPdbyiEKDNiF+oq98+HOXuA4JwMfm0jf3z2+s=;
 b=i3YYWtsEZiMZZ81CAmSXIEZozayix/EqlJ3p5GOquOMeiJsbNjCgQ7/+DqcBqXZWTO
 Tuhz58DSXvGbTfNkbmRfa82zH5y3sFdSKLOHybfEQvlqjAzJX2nsvCg15hQki6J6eXAC
 M+N9EErZhEK+l2TevoL6kn3wcId5zhZ3aCCaSNZ1K+WX0IQ72Ssr8t//NiQoK9YwtquB
 UK+q5WrsrJ815z8U34zYg8rbR5CBh3X2HWD8ApZHDfaI5Vz0tx9t5RJDExmkyYdk/3kG
 jtnQ1bQofqnZJVkfGyA1jih/gvxFZhH7l5OvoPoQd4Qga4/eMTSiQyya4pd5VOESYuXT
 HsKA==
X-Gm-Message-State: AOAM532OMKzRdzJGOb9V7LSEATZqqHGQ62n/MsShCgzV2DrkOUn7V//0
 DQnqoWb5BzBx0nIbqNK/W3hX+ACSW+L8cA==
X-Google-Smtp-Source: ABdhPJwpqQWw3l+zIA4iwwM024K3vWNw9vsmfDL7ZlvKY8rGmy2DTLm7q/kivpJOMsA/0/wLPxc80Q==
X-Received: by 2002:a17:90a:cf15:: with SMTP id
 h21mr4401515pju.108.1597455118711; 
 Fri, 14 Aug 2020 18:31:58 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:31:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/20] target/arm: Split out gen_gvec_ool_zzzp
Date: Fri, 14 Aug 2020 18:31:33 -0700
Message-Id: <20200815013145.539409-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x243.google.com
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

Model after gen_gvec_fn_zzz et al.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index aa7ed070e3..535d086838 100644
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


