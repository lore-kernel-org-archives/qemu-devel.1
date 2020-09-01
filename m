Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA0BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251FA20684
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mcnCwdaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251FA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8AQ-0004zn-AP
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83w-0000PH-5l
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83u-0006Gl-8o
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id w5so1980696wrp.8
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bc7vrMm+TmfTi3N/2CYRNzasmk1wUwx4PlIXubLUvTw=;
 b=mcnCwdaLlW4e8OiGSLGp3YkSBb33jJtgM+Wo7VArrNGo9lrHA+NA0L2wAvHSIym+sV
 TMmEzdYIyWyYmW3h6wNeQzHB1A38SrjxldN3ANrUk9BI29fOBXUeoYnMFluNFMRZwhCV
 YCiG1bZvsg5olhICVmwn9rlhoE3MfKT5Dr0jOxV3vn/q1U/SXl94JOOW4t88T22cviIY
 HtSUnxN54qyaVUwpUvD54Rrk5i6f7R3zY99qjwo3AOpcaFG9Lzi0ZkXKAS5GTGGmJKUY
 l1a2PoM95Hi4xgJQDXwxzqThLdMoVAaioiRbNZr0RX2zriPjfHxrvi5VxzoGmi+FkKLQ
 RJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bc7vrMm+TmfTi3N/2CYRNzasmk1wUwx4PlIXubLUvTw=;
 b=L8KMt/M1LvRFSremGpxiJ4KcnfWG5TBCGQhp0yyZXopXL0cJqXj0MJSkikpBvNvq3H
 npob1jw6F2w7kmLONMTwxYHJGgUaFLi3aofqZzMOmDidjS1PtNYobiymzaVL+RRyEjQY
 N8Exn6oaSaPQNQjzSTF7icOzXT4bKV3R7caahwO/A8uwuATE8t2GHU3IZivV9ohTsLvm
 rQM96mFZJ14bkNjy0AIilyf8YNy/vCgHiG3SHULF0J27oQVHWmZIE0OhW3vfh5l6NBU0
 /Ec7wDFvcZ9CeohrfmjrA+O3IBZaR2mF8S2+xKcP8Gd1q1v/cfWsIs1X818SIFdrd42q
 H3jQ==
X-Gm-Message-State: AOAM531r6QZrHYchzbNVRZdRxI367FQcw6tX8lCQivocXMVti5hsSruB
 BjxyDXjfdKt/rMYsYB2xrC9Yv4QDvgO5ZA33
X-Google-Smtp-Source: ABdhPJx8uJMKEWlG7ws/L7X7dSjfRlj8uAKnr0TvwKldkPuIE+hUqET5QY7nSn3liU2arAuMVt3Ezw==
X-Received: by 2002:a5d:510d:: with SMTP id s13mr2473404wrt.177.1598973539587; 
 Tue, 01 Sep 2020 08:18:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/47] target/arm: Implement fp16 for VACGE, VACGT
Date: Tue,  1 Sep 2020 16:18:02 +0100
Message-Id: <20200901151823.29785-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
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

Convert the neon floating-point vector absolute comparison ops
VACGE and VACGT over to using a gvec hepler and use this to
implement the fp16 case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-28-peter.maydell@linaro.org
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
index b2924ac1cdd..f21b944e0d3 100644
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


