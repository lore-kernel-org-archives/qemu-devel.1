Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B497C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F88208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5ub63YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F88208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBamv-0000TX-7u
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacr-00054u-MS
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacp-0004MD-Uy
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id s13so289268wmh.4
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rb21YRqN8FSr5jkzL6XdWdemnlaFMSgFTexiVZhwl7w=;
 b=M5ub63YKp9MmX9yWNvU16Djihr4BbVUfhPVD1MLDSu/nBcGi2bM8j5mJxPLfxCLcVk
 aNWGitmzG3TwK6WKtvh0/Ow9n+sx2L0jojP6QpYeVltd+Y1mJXBXBKM/zPbb8lZoxrU5
 3rMYAMBJYIaQY8mPVcrPUV9savtvmRFgCHddy1oAe7K/AK0rrzIIjjy/Td7o+tu/M3Vo
 gEm1b2/ATqiOc8V0xDGbCUNi96AnxPRpyrp2Ii06ovwEwGWzF4oFCAfj50fxZ8OE/C+b
 AhbOLFgG9EG7XL1SjMpSzhI+7a04Kqddtvz+zgYeEpEq9+vzlzsPckEexe27lzwlMF4M
 mH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rb21YRqN8FSr5jkzL6XdWdemnlaFMSgFTexiVZhwl7w=;
 b=oBUvyH1EMhvZF8RZQKOxGqVSs4B/7YbJbrMkRTvrUknE4kTT4wvdFNKB5jMCCKNck0
 UJO3Z6PQhfcxtSh3AVzQcGODsJj3RIPUJzrcpBPg1yNtwCGB3tih2veBs4ioAtLXQ/+2
 gTP+lnIv47uU3kd1jq32dM+Os42DVgYrc3eSwDgh45uQpzVuVZN78W5qgL3/aRxlzYeu
 M8egq9icTQf08972NTAUMuc4oDZTiA+htxODAs/n2UaRaQl+Jah5vAkkqFObuMEj8k96
 uvCCjuPiik/15pRXwc+tCcbDWISptbf+bJOIkGxY+2Yc0N5Xmg+GVEXeG7axWharIjSj
 5e8g==
X-Gm-Message-State: AOAM531f7CKzq5YREa7bZ3ybDxSSzp27r1pDUeaWytRI0mDj6VJ3iFlt
 /427btUpQhNtbr5koGPQ+PYlXsJZXLX09yCu
X-Google-Smtp-Source: ABdhPJyFEv+syIZvxVplQF4xq28YGvNLt81pjY8rcKweW06yXqmhrcy4g793g9BuQhuxkVKlDfmMGQ==
X-Received: by 2002:a7b:c342:: with SMTP id l2mr657062wmj.153.1598606686399;
 Fri, 28 Aug 2020 02:24:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/35] target/arm: Split out gen_gvec_ool_zzzp
Date: Fri, 28 Aug 2020 10:24:04 +0100
Message-Id: <20200828092413.22206-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Model after gen_gvec_fn_zzz et al.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index a747fff01f8..96bfd32bbec 100644
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
2.20.1


