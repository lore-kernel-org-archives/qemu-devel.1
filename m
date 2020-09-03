Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8EAC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30862072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xK3i/ztv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30862072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpMQ-0000BC-Vw
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDpLe-0007It-FQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:32:18 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDpLc-0007vM-MG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:32:18 -0400
Received: by mail-wm1-x341.google.com with SMTP id q9so2914141wmj.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IgYMHg6sQF3t/vMOC9QTn+hOO3zcDKiyhoHEzTVk0VU=;
 b=xK3i/ztvBbe+0TqwiOM/GgMyjONPmzXeVFxqxQtHUdIdxANuYuTQvnwPoDIYbPUVRz
 +Qb0gQd8RqtNS8sYJ65gePV7i9jBP8ISJJL0pFObifBqkD2o5J6DTE48qvRXFUOHu1Id
 nxdfLrftMtpkhS5WMukTRFeyl6zkvL21t3ezG8dgg39quMxjCxQynCrRQswaNLpG8TkA
 mhFV/jfF/3aPNdBehgEpzip0bFh/k43/9ZJctmbHPwJDeIo9T6WnpTs7Abt1BsfyKsUF
 Em63+STYTvSyHFulW13G2sNTKSoic0DHMdpzNni8U53dTA+8IzfdeV7Ye9nj+cMh7/nT
 SFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IgYMHg6sQF3t/vMOC9QTn+hOO3zcDKiyhoHEzTVk0VU=;
 b=kTX0/axph5o3kdyBhYNGBa841P59criE19yZmhRVNIGBJLs3zLMn43ZuBrsatEScO8
 x1IS91GYYpNjZSKIV4QVbU4+htbGmR2vzKq6bM3R6kF593YPw90Ndc1sinwmca/5zgp+
 EXcbbSYiX0qIN5sUjNJIgX9Qzgmhw1Cy+Wz0+wiBKp5ZoHSyDHLHHmRG4DNSeHJTVayf
 bSgr/l7p2BNoK/O/rpmEQICM3LEt62NRJaaZxUampuNzP0xYvk+CNroaxzug3qDvx6mv
 BMeQ7yX3oLn2mOszvzD3vgQOqRhxVMNb/tnOuBnEHBeuvsjVUcslqOpaEeAaxus2Ovuu
 kqVw==
X-Gm-Message-State: AOAM533IhuVNEdaFHD5WvVBznXbXDvKXRaM0SV9q6Pvoj2SSKwAOyhL3
 z3I619GJ9kBY9ffNudCRpVyLBg==
X-Google-Smtp-Source: ABdhPJzSWLL1cBY7yN1l1T/wm5CvXRgtigm5RIQ2+FXWXRaIp78PSK3Lc0TMjEHwFDxrS5XjIfKzSQ==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr2583824wmc.100.1599139935323; 
 Thu, 03 Sep 2020 06:32:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id k24sm4301988wmj.19.2020.09.03.06.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 06:32:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/arm: Convert VCMLA,
 VCADD size field to MO_* in decode
Date: Thu,  3 Sep 2020 14:32:09 +0100
Message-Id: <20200903133209.5141-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903133209.5141-1-peter.maydell@linaro.org>
References: <20200903133209.5141-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The VCMLA and VCADD insns have a size field which is 0 for fp16
and 1 for fp32 (note that this is the reverse of the Neon 3-same
encoding!). Convert it to MO_* values in decode for consistency.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-shared.decode   | 18 ++++++++++++------
 target/arm/translate-neon.c.inc | 22 ++++++++++++----------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index f297ba8cdfc..a9d010880d4 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -34,11 +34,17 @@
 %vd_dp  22:1 12:4
 %vd_sp  12:4 22:1
 
-VCMLA          1111 110 rot:2 . 1 size:1 .... .... 1000 . q:1 . 0 .... \
-               vm=%vm_dp vn=%vn_dp vd=%vd_dp
+# For VCMLA/VCADD insns, convert the single-bit size field
+# which is 0 for fp16 and 1 for fp32 into a MO_* constant.
+# (Note that this is the reverse of the sense of the 1-bit size
+# field in the 3same_fp Neon insns.)
+%vcadd_size    20:1 !function=plus1
 
-VCADD          1111 110 rot:1 1 . 0 size:1 .... .... 1000 . q:1 . 0 .... \
-               vm=%vm_dp vn=%vn_dp vd=%vd_dp
+VCMLA          1111 110 rot:2 . 1 . .... .... 1000 . q:1 . 0 .... \
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp size=%vcadd_size
+
+VCADD          1111 110 rot:1 1 . 0 . .... .... 1000 . q:1 . 0 .... \
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp size=%vcadd_size
 
 # VUDOT and VSDOT
 VDOT           1111 110 00 . 10 .... .... 1101 . q:1 . u:1 .... \
@@ -51,9 +57,9 @@ VFML           1111 110 0 s:1 . 10 .... .... 1000 . 1 . 1 .... \
                vm=%vm_dp vn=%vn_dp vd=%vd_dp q=1
 
 VCMLA_scalar   1111 1110 0 . rot:2 .... .... 1000 . q:1 index:1 0 vm:4 \
-               vn=%vn_dp vd=%vd_dp size=0
+               vn=%vn_dp vd=%vd_dp size=1
 VCMLA_scalar   1111 1110 1 . rot:2 .... .... 1000 . q:1 . 0 .... \
-               vm=%vm_dp vn=%vn_dp vd=%vd_dp size=1 index=0
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp size=2 index=0
 
 VDOT_scalar    1111 1110 0 . 10 .... .... 1101 . q:1 index:1 u:1 rm:4 \
                vm=%vm_dp vn=%vn_dp vd=%vd_dp
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 213c1c2174a..4d1a292981b 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -168,7 +168,7 @@ static bool trans_VCMLA(DisasContext *s, arg_VCMLA *a)
     gen_helper_gvec_3_ptr *fn_gvec_ptr;
 
     if (!dc_isar_feature(aa32_vcma, s)
-        || (!a->size && !dc_isar_feature(aa32_fp16_arith, s))) {
+        || (a->size == MO_16 && !dc_isar_feature(aa32_fp16_arith, s))) {
         return false;
     }
 
@@ -187,8 +187,9 @@ static bool trans_VCMLA(DisasContext *s, arg_VCMLA *a)
     }
 
     opr_sz = (1 + a->q) * 8;
-    fpst = fpstatus_ptr(a->size == 0 ? FPST_STD_F16 : FPST_STD);
-    fn_gvec_ptr = a->size ? gen_helper_gvec_fcmlas : gen_helper_gvec_fcmlah;
+    fpst = fpstatus_ptr(a->size == MO_16 ? FPST_STD_F16 : FPST_STD);
+    fn_gvec_ptr = (a->size == MO_16) ?
+        gen_helper_gvec_fcmlah : gen_helper_gvec_fcmlas;
     tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
                        vfp_reg_offset(1, a->vm),
@@ -205,7 +206,7 @@ static bool trans_VCADD(DisasContext *s, arg_VCADD *a)
     gen_helper_gvec_3_ptr *fn_gvec_ptr;
 
     if (!dc_isar_feature(aa32_vcma, s)
-        || (!a->size && !dc_isar_feature(aa32_fp16_arith, s))) {
+        || (a->size == MO_16 && !dc_isar_feature(aa32_fp16_arith, s))) {
         return false;
     }
 
@@ -224,8 +225,9 @@ static bool trans_VCADD(DisasContext *s, arg_VCADD *a)
     }
 
     opr_sz = (1 + a->q) * 8;
-    fpst = fpstatus_ptr(a->size == 0 ? FPST_STD_F16 : FPST_STD);
-    fn_gvec_ptr = a->size ? gen_helper_gvec_fcadds : gen_helper_gvec_fcaddh;
+    fpst = fpstatus_ptr(a->size == MO_16 ? FPST_STD_F16 : FPST_STD);
+    fn_gvec_ptr = (a->size == MO_16) ?
+        gen_helper_gvec_fcaddh : gen_helper_gvec_fcadds;
     tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
                        vfp_reg_offset(1, a->vm),
@@ -307,7 +309,7 @@ static bool trans_VCMLA_scalar(DisasContext *s, arg_VCMLA_scalar *a)
     if (!dc_isar_feature(aa32_vcma, s)) {
         return false;
     }
-    if (a->size == 0 && !dc_isar_feature(aa32_fp16_arith, s)) {
+    if (a->size == MO_16 && !dc_isar_feature(aa32_fp16_arith, s)) {
         return false;
     }
 
@@ -325,10 +327,10 @@ static bool trans_VCMLA_scalar(DisasContext *s, arg_VCMLA_scalar *a)
         return true;
     }
 
-    fn_gvec_ptr = (a->size ? gen_helper_gvec_fcmlas_idx
-                   : gen_helper_gvec_fcmlah_idx);
+    fn_gvec_ptr = (a->size == MO_16) ?
+        gen_helper_gvec_fcmlah_idx : gen_helper_gvec_fcmlas_idx;
     opr_sz = (1 + a->q) * 8;
-    fpst = fpstatus_ptr(a->size == 0 ? FPST_STD_F16 : FPST_STD);
+    fpst = fpstatus_ptr(a->size == MO_16 ? FPST_STD_F16 : FPST_STD);
     tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
                        vfp_reg_offset(1, a->vm),
-- 
2.20.1


