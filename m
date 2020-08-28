Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2111AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6DA2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obNgwWI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6DA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjZ5-0005ro-12
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCt-0002z1-Px
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCp-00062h-2E
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id o21so127426wmc.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=d1v3KyQ1t1fIhlpZMIXH6cnFh1IA/Ig80NyUtW4n5r8=;
 b=obNgwWI5dHGJSTicvHpLkHO13EPcjlc8dE8Jqc/nXTND9ixkJmOX/Vjo+USXjz8YFb
 wQLH0TUER2s85o6nTbTca0NnGkJIiDPjyDBzkAWzh8wast+KgnJ0N1KW8utix0SuwKRh
 UHcfnf9EzG7w1K8mTuMQ1SKkuEXITj9xecDxcpflWBRb6zAqgxv3T8ljtkrbWdP6gQSV
 +iy4cStds9N905RzX3dz1VRX/+vQl1Sc+aquYG2G71iFFUIfIIBm9J3CkyfRJHufaFbu
 JCeOoqUViy7RjbYgTBCfJb06tg1sC9XuGf38RNuSVbyRTuIYf3qJcSuHM6vQtNtOkHBs
 NbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d1v3KyQ1t1fIhlpZMIXH6cnFh1IA/Ig80NyUtW4n5r8=;
 b=g04cRMrL0oe20kEPXglhCs/FdrHiM11vXOXfVr8Ux9MXeOU3QGj6q/5w/Sp2aweK6s
 niu2rhddT9dNHD5nPIotD7ZTl8b6qFoPVuhPKit3d3e/lr8MBexFvXv3p6AA7pZTStSo
 YiTsLv7kJ9uuaf3X4biS/lTPo3urClGGSyaWLTegRhrqvcNq7f9OAGY4MgHxHW+NZLaC
 0kxX5RJcyvn3lvS4fXdbfRBdmoYLDUbQIgtHLaJ0px38TdF87TpVhRqNw7Yo7Y/BhWoh
 +Qcm58zBE7nkI1dTI22OwIovfXhObzvgcGWrkPueEhdwicNIdQhvI1HqzeGBJAoNTFlG
 cUKg==
X-Gm-Message-State: AOAM5318cPYJsWG7+8e+NXyBdhFQMVj2tiIbi7tK1i8ALMucYM/7I4oi
 IYVaT6R3MQM79Ogei1V+KPrwk2ppO5uGGD0H
X-Google-Smtp-Source: ABdhPJysrLdTogAzf76v7FsZHZ64I56n99lctlvth2D/B5GzGguWQrL3X3s7wCxGINvg7+su8b4CJA==
X-Received: by 2002:a1c:ab06:: with SMTP id u6mr31228wme.172.1598639669482;
 Fri, 28 Aug 2020 11:34:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 27/45] target/arm: Implement fp16 for VACGE, VACGT
Date: Fri, 28 Aug 2020 19:33:36 +0100
Message-Id: <20200828183354.27913-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
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

Convert the neon floating-point vector absolute comparison ops
VACGE and VACGT over to using a gvec hepler and use this to
implement the fp16 case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  6 ++++++
 target/arm/vec_helper.c         | 26 ++++++++++++++++++++++++++
 target/arm/translate-neon.c.inc |  4 ++--
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index a05a0d1a427..b2d24050e27 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -641,6 +641,12 @@ DEF_HELPER_FLAGS_5(gvec_fcge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fcgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fcgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_facge_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_facge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_facgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_facgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index f60968f4997..4ac16ed102c 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -691,6 +691,26 @@ static uint32_t float32_cgt(float32 op1, float32 op2, float_status *stat)
     return -float32_lt(op2, op1, stat);
 }
 
+static uint16_t float16_acge(float16 op1, float16 op2, float_status *stat)
+{
+    return -float16_le(float16_abs(op2), float16_abs(op1), stat);
+}
+
+static uint32_t float32_acge(float32 op1, float32 op2, float_status *stat)
+{
+    return -float32_le(float32_abs(op2), float32_abs(op1), stat);
+}
+
+static uint16_t float16_acgt(float16 op1, float16 op2, float_status *stat)
+{
+    return -float16_lt(float16_abs(op2), float16_abs(op1), stat);
+}
+
+static uint32_t float32_acgt(float32 op1, float32 op2, float_status *stat)
+{
+    return -float32_lt(float32_abs(op2), float32_abs(op1), stat);
+}
+
 #define DO_2OP(NAME, FUNC, TYPE) \
 void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)  \
 {                                                                 \
@@ -791,6 +811,12 @@ DO_3OP(gvec_fcge_s, float32_cge, float32)
 DO_3OP(gvec_fcgt_h, float16_cgt, float16)
 DO_3OP(gvec_fcgt_s, float32_cgt, float32)
 
+DO_3OP(gvec_facge_h, float16_acge, float16)
+DO_3OP(gvec_facge_s, float32_acge, float32)
+
+DO_3OP(gvec_facgt_h, float16_acgt, float16)
+DO_3OP(gvec_facgt_s, float32_acgt, float32)
+
 #ifdef TARGET_AARCH64
 
 DO_3OP(gvec_recps_h, helper_recpsf_f16, float16)
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 94871f8597d..645a099518d 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1115,6 +1115,8 @@ DO_3S_FP_GVEC(VMUL, gen_helper_gvec_fmul_s, gen_helper_gvec_fmul_h)
 DO_3S_FP_GVEC(VCEQ, gen_helper_gvec_fceq_s, gen_helper_gvec_fceq_h)
 DO_3S_FP_GVEC(VCGE, gen_helper_gvec_fcge_s, gen_helper_gvec_fcge_h)
 DO_3S_FP_GVEC(VCGT, gen_helper_gvec_fcgt_s, gen_helper_gvec_fcgt_h)
+DO_3S_FP_GVEC(VACGE, gen_helper_gvec_facge_s, gen_helper_gvec_facge_h)
+DO_3S_FP_GVEC(VACGT, gen_helper_gvec_facgt_s, gen_helper_gvec_facgt_h)
 
 /*
  * For all the functions using this macro, size == 1 means fp16,
@@ -1130,8 +1132,6 @@ DO_3S_FP_GVEC(VCGT, gen_helper_gvec_fcgt_s, gen_helper_gvec_fcgt_h)
         return do_3same_fp(s, a, FUNC, READS_VD);                   \
     }
 
-DO_3S_FP(VACGE, gen_helper_neon_acge_f32, false)
-DO_3S_FP(VACGT, gen_helper_neon_acgt_f32, false)
 DO_3S_FP(VMAX, gen_helper_vfp_maxs, false)
 DO_3S_FP(VMIN, gen_helper_vfp_mins, false)
 
-- 
2.20.1


