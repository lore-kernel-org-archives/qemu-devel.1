Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1089FCA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F6F206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBdbHZ9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F6F206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYYBg-0001qc-UC
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXwG-0006or-SP
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXwF-0006Ik-Mm
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id y24so24224086wma.4
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pvqJd3qWY/MPKRY/jCCulOuFIxuFeVoByyFCNf9EIS0=;
 b=JBdbHZ9Q3w5xev6NvMd+xn8UT0jnee4oQGeS5PKrl/rD+uuyB29gVF+UXpZmy+zRdc
 uFiGbi9t4C1rcjnT/kFY9Gi5LJS+EBOJC5s3z9dNVsR3GqPed44dVznnrs8iGgUCJs3J
 eAyinRREmRpHMm0RF43kbIQveREuehUNn6KPNdjw79pXONzC1zfR6enumrwuUYWrk8VU
 ind8oQrVL3vkRozf0bT95eWP+Yq/gsn66Uv/51YLsMqv9HnBar6omGIAyjmt8ZyMFUFf
 CikAauboWeFrC/xDgnWucVOd0Vk/ZkxPgoJJn1dUdGp2RTEFnCx6YG0Td1dJ43ro1szk
 WeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pvqJd3qWY/MPKRY/jCCulOuFIxuFeVoByyFCNf9EIS0=;
 b=jznw7sh0JSCF9N5pZYxZG5xgbD25DI+DqLPlpfbVjbYRX+5W1TqufB3MbFUGTxwD9p
 MClPr9GnAFybiq2kh/fmbAUc1AxJ+bml4KnoiG/v/YNjjVBEaE4HIaaFIgPX/jQuiVsy
 2DxMEjk4Zi2ywMdQZ4FTcBsWTQ5TxWgS81xbWSyGjJF2Kz0cdrd27w9kC4vKz1S5QiBY
 /RQPaQnq5FEANNkENXpfciFnPWR7+7HRV9h/nkxLbgjRRzf0Nk838dWelR7WVDdo/xK3
 WB1AcjwdunAe65xHi5h6yppzv+xFZLttpYfpCkfQXcxBXJyfUmwhZk54sJIk16IMweEt
 TZYA==
X-Gm-Message-State: AGi0PuY2hdOL9wW97Q/t6MMzIVygku6oaHlWs7gedb7dMkde5Pc388Kf
 nRPzb8lCkEPGa6nfNwgfr2okNTDeiSU6IA==
X-Google-Smtp-Source: APiQypJUjwvf/59l1uPokuHRk5AWg03fOCEutMyPJEuvIwCyY4d7sv3xrZIpjGpA/4RNBhTIRkhYsA==
X-Received: by 2002:a1c:7f91:: with SMTP id
 a139mr36404611wmd.164.1589301566336; 
 Tue, 12 May 2020 09:39:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o205sm18525981wmo.32.2020.05.12.09.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:39:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 14/17] target/arm: Convert Neon 3-reg-same compare insns to
 decodetree
Date: Tue, 12 May 2020 17:39:01 +0100
Message-Id: <20200512163904.10918-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512163904.10918-1-peter.maydell@linaro.org>
References: <20200512163904.10918-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon integer 3-reg-same compare insns VCGE, VCGT,
VCEQ, VACGE and VACGT to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       |  5 +++++
 target/arm/translate-neon.inc.c |  6 +++++
 target/arm/translate.c          | 39 ++-------------------------------
 3 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 0f74b31dcd1..bc5a3e0295c 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -184,5 +184,10 @@ VABD_fp_3s       1111 001 1 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
 VMLA_fp_3s       1111 001 0 0 . 0 . .... .... 1101 ... 1 .... @3same_fp
 VMLS_fp_3s       1111 001 0 0 . 1 . .... .... 1101 ... 1 .... @3same_fp
 VMUL_fp_3s       1111 001 1 0 . 0 . .... .... 1101 ... 1 .... @3same_fp
+VCEQ_fp_3s       1111 001 0 0 . 0 . .... .... 1110 ... 0 .... @3same_fp
+VCGE_fp_3s       1111 001 1 0 . 0 . .... .... 1110 ... 0 .... @3same_fp
+VACGE_fp_3s      1111 001 1 0 . 0 . .... .... 1110 ... 1 .... @3same_fp
+VCGT_fp_3s       1111 001 1 0 . 1 . .... .... 1110 ... 0 .... @3same_fp
+VACGT_fp_3s      1111 001 1 0 . 1 . .... .... 1110 ... 1 .... @3same_fp
 VPMAX_fp_3s      1111 001 1 0 . 0 . .... .... 1111 ... 0 .... @3same_fp_q0
 VPMIN_fp_3s      1111 001 1 0 . 1 . .... .... 1111 ... 0 .... @3same_fp_q0
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 18896598bb4..eeea71e3bec 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1114,6 +1114,12 @@ DO_3S_FP_GVEC(VMUL, gen_helper_gvec_fmul_s)
         return do_3same_fp(s, a, FUNC, READS_VD);                   \
     }
 
+DO_3S_FP(VCEQ, gen_helper_neon_ceq_f32, false)
+DO_3S_FP(VCGE, gen_helper_neon_cge_f32, false)
+DO_3S_FP(VCGT, gen_helper_neon_cgt_f32, false)
+DO_3S_FP(VACGE, gen_helper_neon_acge_f32, false)
+DO_3S_FP(VACGT, gen_helper_neon_acgt_f32, false)
+
 static void gen_VMLA_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
                             TCGv_ptr fpstatus)
 {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 06b6925d31e..b9fcbbcbcb5 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5434,6 +5434,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VQDMULH_VQRDMULH:
         case NEON_3R_FLOAT_ARITH:
         case NEON_3R_FLOAT_MULTIPLY:
+        case NEON_3R_FLOAT_CMP:
+        case NEON_3R_FLOAT_ACMP:
             /* Already handled by decodetree */
             return 1;
         }
@@ -5448,17 +5450,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 return 1; /* VPMIN/VPMAX handled by decodetree */
             }
             break;
-        case NEON_3R_FLOAT_CMP:
-            if (!u && size) {
-                /* no encoding for U=0 C=1x */
-                return 1;
-            }
-            break;
-        case NEON_3R_FLOAT_ACMP:
-            if (!u) {
-                return 1;
-            }
-            break;
         case NEON_3R_FLOAT_MISC:
             /* VMAXNM/VMINNM in ARMv8 */
             if (u && !arm_dc_feature(s, ARM_FEATURE_V8)) {
@@ -5480,32 +5471,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         tmp = neon_load_reg(rn, pass);
         tmp2 = neon_load_reg(rm, pass);
         switch (op) {
-        case NEON_3R_FLOAT_CMP:
-        {
-            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-            if (!u) {
-                gen_helper_neon_ceq_f32(tmp, tmp, tmp2, fpstatus);
-            } else {
-                if (size == 0) {
-                    gen_helper_neon_cge_f32(tmp, tmp, tmp2, fpstatus);
-                } else {
-                    gen_helper_neon_cgt_f32(tmp, tmp, tmp2, fpstatus);
-                }
-            }
-            tcg_temp_free_ptr(fpstatus);
-            break;
-        }
-        case NEON_3R_FLOAT_ACMP:
-        {
-            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-            if (size == 0) {
-                gen_helper_neon_acge_f32(tmp, tmp, tmp2, fpstatus);
-            } else {
-                gen_helper_neon_acgt_f32(tmp, tmp, tmp2, fpstatus);
-            }
-            tcg_temp_free_ptr(fpstatus);
-            break;
-        }
         case NEON_3R_FLOAT_MINMAX:
         {
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-- 
2.20.1


