Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C94C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3192820836
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVfemUV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3192820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDk1-0002qq-A1
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDe4-0001Vc-Nz
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdc-0000ms-Df
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdb-0000gk-I4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id u16so3072200wmc.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lz8mXOgIyBmnqYSstj+GgsJWNWgYl7m155/mR9kGoOM=;
 b=RVfemUV9uPSOuHxEh/yplE80sKPs+uz7E53/06NXDev0hHjU5paT7jKGBTv9ALpMhi
 zykuRvQqNdY+mSq8xAzkQ3EiDJJtuCUbzVaQosU6dKlUSQqgGj8d7f4/ws7pxe6cve8C
 NbRttkeBERpkRLwH7chalem4Vf+2DqyA0yS2v8p9uEox140fQXIvO8/NYcCUbnayN06j
 W7fsb2Op270c9e88tsmDZVgRn/MvM9fcIx4k0OcbdrWGvSdeGUjjp/jDoxEUHx4HHK6A
 5Iwub1DChe8CxC8Qja5/AyiRfrAnRBFdIrGqpOKRNAM1AbEojegiRm4Sx3EOwbZu71Td
 +XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lz8mXOgIyBmnqYSstj+GgsJWNWgYl7m155/mR9kGoOM=;
 b=EqEGpnQOzWexL29ebRe7cOx7brRuRoE9qE1TyHIOkEZlC/4NwogO5LwrZkWVVgf3nr
 ySIqRwGGy35ZmBO+VP7jvdmsbaVTQcWIDmbbPVOXCu/Sfwhf02yOSqa3//NNXAgWPdC1
 QIcth+ZCjuzwiaHVKcl9lZK/pct32MEUb3yLN+uq7/ltx2r4efbqvmHGhJ+6jOmBShTu
 6tOdVJjp1eIn9twIh3x+5AGlhgyjW3Bmti1A/hm/e0E5NpuyVZdrzODGCv2w50JI9fEG
 qoFlLxGBcAG9yFECd7H0J9S7xBzhLzHziOxcJtbIefaWk08dLRoXnqHx5FDz71PcQRPB
 Ey7A==
X-Gm-Message-State: AGi0PubTckQAB5xRommRB71xWx4iUpo2VtBCGeh2Q71pzn/iK3vtI0+i
 DcFitrGK+IbfkamkKtLrPqfAxgMA+afhpg==
X-Google-Smtp-Source: APiQypLd/2b8lclyNbKwAxbKuQMYHxPKE4lf9iGeXDdg9+ZuCZDenNteVAuviV/WkwfXbIiN5kRmpg==
X-Received: by 2002:a1c:a549:: with SMTP id o70mr4302228wme.179.1588270216968; 
 Thu, 30 Apr 2020 11:10:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/36] target/arm: Convert VCMLA (scalar) to decodetree
Date: Thu, 30 Apr 2020 19:09:35 +0100
Message-Id: <20200430181003.21682-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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

Convert VCMLA (scalar) in the 2reg-scalar-ext group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 40 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 26 +--------------------
 target/arm/neon-shared.decode   |  5 +++++
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 6c58abc54b5..92eccbf8236 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -167,3 +167,43 @@ static bool trans_VFML(DisasContext *s, arg_VFML *a)
                        gen_helper_gvec_fmlal_a32);
     return true;
 }
+
+static bool trans_VCMLA_scalar(DisasContext *s, arg_VCMLA_scalar *a)
+{
+    gen_helper_gvec_3_ptr *fn_gvec_ptr;
+    int opr_sz;
+    TCGv_ptr fpst;
+
+    if (!dc_isar_feature(aa32_vcma, s)) {
+        return false;
+    }
+    if (a->size == 0 && !dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vd | a->vn) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fn_gvec_ptr = (a->size ? gen_helper_gvec_fcmlas_idx
+                   : gen_helper_gvec_fcmlah_idx);
+    opr_sz = (1 + a->q) * 8;
+    fpst = get_fpstatus_ptr(1);
+    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
+                       vfp_reg_offset(1, a->vn),
+                       vfp_reg_offset(1, a->vm),
+                       fpst, opr_sz, opr_sz,
+                       (a->index << 2) | a->rot, fn_gvec_ptr);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index caa18c8c56c..b82e54b7b23 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7049,31 +7049,7 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
     bool is_long = false, q = extract32(insn, 6, 1);
     bool ptr_is_env = false;
 
-    if ((insn & 0xff000f10) == 0xfe000800) {
-        /* VCMLA (indexed) -- 1111 1110 S.RR .... .... 1000 ...0 .... */
-        int rot = extract32(insn, 20, 2);
-        int size = extract32(insn, 23, 1);
-        int index;
-
-        if (!dc_isar_feature(aa32_vcma, s)) {
-            return 1;
-        }
-        if (size == 0) {
-            if (!dc_isar_feature(aa32_fp16_arith, s)) {
-                return 1;
-            }
-            /* For fp16, rm is just Vm, and index is M.  */
-            rm = extract32(insn, 0, 4);
-            index = extract32(insn, 5, 1);
-        } else {
-            /* For fp32, rm is the usual M:Vm, and index is 0.  */
-            VFP_DREG_M(rm, insn);
-            index = 0;
-        }
-        data = (index << 2) | rot;
-        fn_gvec_ptr = (size ? gen_helper_gvec_fcmlas_idx
-                       : gen_helper_gvec_fcmlah_idx);
-    } else if ((insn & 0xffb00f00) == 0xfe200d00) {
+    if ((insn & 0xffb00f00) == 0xfe200d00) {
         /* V[US]DOT -- 1111 1110 0.10 .... .... 1101 .Q.U .... */
         int u = extract32(insn, 4, 1);
 
diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index 90cd5c871e2..c11d755ed14 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -49,3 +49,8 @@ VFML           1111 110 0 s:1 . 10 .... .... 1000 . 0 . 1 .... \
                vm=%vm_sp vn=%vn_sp vd=%vd_dp q=0
 VFML           1111 110 0 s:1 . 10 .... .... 1000 . 1 . 1 .... \
                vm=%vm_dp vn=%vn_dp vd=%vd_dp q=1
+
+VCMLA_scalar   1111 1110 0 . rot:2 .... .... 1000 . q:1 index:1 0 vm:4 \
+               vn=%vn_dp vd=%vd_dp size=0
+VCMLA_scalar   1111 1110 1 . rot:2 .... .... 1000 . q:1 . 0 .... \
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp size=1 index=0
-- 
2.20.1


