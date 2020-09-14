Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90483C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D54520756
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="an8deG/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D54520756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqXe-00016N-QF
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8C-0002Et-Pw
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:42299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8A-0007Yv-Uo
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:56 -0400
Received: by mail-wr1-x436.google.com with SMTP id c18so18876562wrm.9
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=iT35Vx2/tbH9gb/tDeYdi9/ngVuy5YBxKwmw7JtUnO4=;
 b=an8deG/LY5yfoX7xe+wy3hWH9sbZblvAuwkt3RHsYMdvNxwyCLeo4XZ0DneLgrJocm
 I8DTBumoaq1DXuljSd8DrUXQWPR8dFfk6bRKCHuFYOioa6CogU8TR/nn3R0S7G0htKyg
 qnP+RGXdS3RkFy1Ck4/sJAmkUJ48n1c/V6+98uZ3UC+ZoZ96TyNdKl0qzhCTEMI+d65L
 7ZUSDd5w5nsV7OrgHogl7VWvYT9C9D1m7vSpeTkfjx/mRMiYo0Wj56ECcnTvgJDaTFBg
 EL0hV5tCyouB42Qk3bjcpC+QURvdXHBEW12qwYw3gckhOtWCwa+EtsoGICnXn90FUz6+
 eDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iT35Vx2/tbH9gb/tDeYdi9/ngVuy5YBxKwmw7JtUnO4=;
 b=lzCF3kvo6Dw+oiO5qxKgpDWhz3rAV5Y1oMCD0qzRgpYpv9GeRd8BWUsI6gnKQQK4vv
 sbM45ht/x2P4TynNhNI4xe7jrPSOcKAqUNNHLaMtqE0s+tDQlp/fwNE5iDKnoEU79oIg
 Q+LjM5zxiu9FCg1vDrccgW2s3J8P5SSI5vWnig+y6QhGrCWFP99UyAZrgIu5MCtL7GhS
 CSEmSNVSenDNRFhN59QLmqSopNkmh+27TPma5qvUN+Wu1GRWt8AwOCLgINPH9GaKCnNY
 QY2Jzrk0z/go3a0YRL/vGq9ENX85sNtlbFNo4YOYTkwJZHVR7n4BtrHykS0dcWFpUVVW
 GTlg==
X-Gm-Message-State: AOAM532T3FMeqsoYmCikfRRcEEhS/9cf7M5UdXMWtJ73DwVd8oruzfD+
 BLVrp4P+Qz35yGUlHCzZEkpDQ46LRJX2EbUy
X-Google-Smtp-Source: ABdhPJwF6wvDdMcr5NrOm/NLEeJjZ03OSbF7bDbiyRaqcB71Yuj6hiiY16QKimVLoqYdIG0RW8+OOg==
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr16099715wrw.199.1600092413238; 
 Mon, 14 Sep 2020 07:06:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/36] target/arm: Convert VCMLA,
 VCADD size field to MO_* in decode
Date: Mon, 14 Sep 2020 15:06:14 +0100
Message-Id: <20200914140641.21369-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The VCMLA and VCADD insns have a size field which is 0 for fp16
and 1 for fp32 (note that this is the reverse of the Neon 3-same
encoding!). Convert it to MO_* values in decode for consistency.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200903133209.5141-4-peter.maydell@linaro.org
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


