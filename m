Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763F0C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4813220737
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtoUJuTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4813220737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjIa-0003HW-EH
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCb-0002As-09
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCS-0005w4-VG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id y3so65468wrl.4
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lqdF8B5zR97t5g0010GIU4n/HI2zsZ2s/f6t9ofxj/o=;
 b=jtoUJuTmdzW1O2siNF3Ks231BvUfS+1u7KvMQDyKHRJWscAKlOpEhzxoLLrue3xKnP
 ORiy96vAVJ1xYkxZYRCOA+uFmJZewUc7uIdSCRSF+mUZuunaidjGgD5o2jOWnQIl9p7r
 UVDsCGKPmLd+WQ9u96OMmZ5LxM71oegQtgKHQkgYOQqi45Gvo5K1kkdCvq4CfSojsO+R
 frYMccrFugLC/DPpolHLCraK1FsSad189B7SCG0GPgRb7sz+kdmc1JxvehraYhgBCMyx
 X3w2QoaDaDe59mLkkco9u0hC+Qr6mov0DvccfCaciR884B+5utJwz4wC9YMetGK2ZWvx
 RLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lqdF8B5zR97t5g0010GIU4n/HI2zsZ2s/f6t9ofxj/o=;
 b=e1et24dBNY9zDAjvrd1dD2o3TMqpDhL6FX8m8RC4JLUmN6hO0igtf16mW4ClxBWeLg
 zr7CmcIhZ8X75ePD0VNSuqUHm24iYe4ciSPy2KgJWh2lDVjErTo1vKWMhpWNyLg0l3WH
 s5EdIJOkK1SCiO+TCHy9okwqeYnWLw1mwT0VPtGkhktHkDN0SQT5LDXJJJA3o2YYYoNj
 1xTSkRfccnor52/ljPGspNH3dJod4pTOypNUPda5IJUrzWtBO1kelhSYsGDk6Cjx91wk
 YNhDLUfP0/Onu27dFESYc4ND4VN1p9gB6LBYdcwiM+io6yz5eb3Qf3DYDiPVGMWTYQ4R
 O9GA==
X-Gm-Message-State: AOAM533iOdAMah2bWH8mURapUvnl9BreJauv6SSOrtHMLv0NkLQC+9p5
 1mMMmD2GOuQQaP4wFop8/IOb4g==
X-Google-Smtp-Source: ABdhPJzoqcQZUSAab2EvD8snj3LiWeK43vIIT9Rpih4fID2Z09gsF20XTv7zgFIwYXk749+0KTDgzg==
X-Received: by 2002:adf:c453:: with SMTP id a19mr269163wrg.179.1598639642979; 
 Fri, 28 Aug 2020 11:34:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 05/45] target/arm: Macroify trans functions for VFMA, VFMS,
 VFNMA, VFNMS
Date: Fri, 28 Aug 2020 19:33:14 +0100
Message-Id: <20200828183354.27913-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Macroify creation of the trans functions for single and double
precision VFMA, VFMS, VFNMA, VFNMS. The repetition was OK for
two sizes, but we're about to add halfprec and it will get a bit
more than seems reasonable.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.c.inc | 50 +++++++++-------------------------
 1 file changed, 13 insertions(+), 37 deletions(-)

diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 15bb23688bd..9937fa569e4 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -1978,26 +1978,6 @@ static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
     return true;
 }
 
-static bool trans_VFMA_sp(DisasContext *s, arg_VFMA_sp *a)
-{
-    return do_vfm_sp(s, a, false, false);
-}
-
-static bool trans_VFMS_sp(DisasContext *s, arg_VFMS_sp *a)
-{
-    return do_vfm_sp(s, a, true, false);
-}
-
-static bool trans_VFNMA_sp(DisasContext *s, arg_VFNMA_sp *a)
-{
-    return do_vfm_sp(s, a, false, true);
-}
-
-static bool trans_VFNMS_sp(DisasContext *s, arg_VFNMS_sp *a)
-{
-    return do_vfm_sp(s, a, true, true);
-}
-
 static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
 {
     /*
@@ -2069,25 +2049,21 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
     return true;
 }
 
-static bool trans_VFMA_dp(DisasContext *s, arg_VFMA_dp *a)
-{
-    return do_vfm_dp(s, a, false, false);
-}
+#define MAKE_ONE_VFM_TRANS_FN(INSN, PREC, NEGN, NEGD)                   \
+    static bool trans_##INSN##_##PREC(DisasContext *s,                  \
+                                      arg_##INSN##_##PREC *a)           \
+    {                                                                   \
+        return do_vfm_##PREC(s, a, NEGN, NEGD);                         \
+    }
 
-static bool trans_VFMS_dp(DisasContext *s, arg_VFMS_dp *a)
-{
-    return do_vfm_dp(s, a, true, false);
-}
+#define MAKE_VFM_TRANS_FNS(PREC) \
+    MAKE_ONE_VFM_TRANS_FN(VFMA, PREC, false, false) \
+    MAKE_ONE_VFM_TRANS_FN(VFMS, PREC, true, false) \
+    MAKE_ONE_VFM_TRANS_FN(VFNMA, PREC, false, true) \
+    MAKE_ONE_VFM_TRANS_FN(VFNMS, PREC, true, true)
 
-static bool trans_VFNMA_dp(DisasContext *s, arg_VFNMA_dp *a)
-{
-    return do_vfm_dp(s, a, false, true);
-}
-
-static bool trans_VFNMS_dp(DisasContext *s, arg_VFNMS_dp *a)
-{
-    return do_vfm_dp(s, a, true, true);
-}
+MAKE_VFM_TRANS_FNS(sp)
+MAKE_VFM_TRANS_FNS(dp)
 
 static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 {
-- 
2.20.1


