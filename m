Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C96EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DD120727
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUIIFssK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DD120727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZF7j-0004tT-TI
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEku-00045Z-Kt
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:40636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkt-00061N-KI
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id u16so32902396wmc.5
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dJBpegJ1A1utSWaGPViC4+9XvSSO9OobUlFSAeGWXVk=;
 b=kUIIFssKktD6S8lzqdH9N/P7opFnf14S/vndDAWNdH45MQ0aC1AKOXaM0t+vaFIFyS
 fmL7G8n/1UDcLrAFeKJvAJSEiEJ/H2ElSCXArPhzQc2BIJnqaJLmZ0IdsMPoOjzNPvus
 bHS5Hio0HMSJ6nVtDum0+X5f4AC5UAVfuEj2mtH1G6JFZ1X2S1xPJMiu0z7SA2ndBAh3
 C1DMEtr/F9jwtiUZcZsEMGUMta1/aAeIVxQRUHqq7Qvrr+EMcX97sjGuV2SrS4wtgmu9
 XCh6QMTCLJBLeRCdQBr5/xxFOPU0AsTTXt64TFFJ1cfPLPRW4WGB8Kuz1n+ljCPujL7l
 BDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dJBpegJ1A1utSWaGPViC4+9XvSSO9OobUlFSAeGWXVk=;
 b=KRQnn/fXiXTHu+HC7hFGnbL+yxVJqVDBtpE2q4TA7opkIk7jXsOqibWs13jh4j8gqM
 vTPUvTysEuwx+bPoU4/i4GIr/Q85JX4IviYy0HuS7bEC8Wwz0pqWXrpPWzi7ljAJPmcY
 njUerMqr1RbiYkz4PAZSVU2cDVODbDLYbjdvUGfZCaloiwrLNv+QTWkaW7O5l4VHUVCg
 JjmY6ihbxiHpOvGtqoo3rCWmmMIoa2kz8IuUXgvKdC/ekk3nOdcsahd4P2qiuMzIYSQ5
 xC3y2F++A3nPA/ZFkN6r3tVHjuEUuD1ne3vEmlmvRRpqXdTxVqlNTN8kPW1Pgj2BNTrR
 Tniw==
X-Gm-Message-State: AGi0PubwDFM0EFCicT5PBOwsBQ3lPqMBI6jsvhqR7MXzXYlMwzZU4Dfd
 lpHjR5oC8BAg5cSc7YcWdClU2iMbgA3DUg==
X-Google-Smtp-Source: APiQypKlrMj+5SxZGcpWiSbnbHcTg6SNPNJ1iBLoIpxgwIv2RJuyWP/CKUtwPHTx73TS95j/FTRUVQ==
X-Received: by 2002:a05:600c:40d:: with SMTP id
 q13mr39378260wmb.69.1589466153888; 
 Thu, 14 May 2020 07:22:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/45] target/arm: Convert Neon 3-reg-same compare insns to
 decodetree
Date: Thu, 14 May 2020 15:21:35 +0100
Message-Id: <20200514142138.20875-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon integer 3-reg-same compare insns VCGE, VCGT,
VCEQ, VACGE and VACGT to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-15-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  5 +++++
 target/arm/translate-neon.inc.c |  6 +++++
 target/arm/translate.c          | 39 ++-------------------------------
 3 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 4c2f8c770d1..29cf54c217c 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -183,5 +183,10 @@ VABD_fp_3s       1111 001 1 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
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


