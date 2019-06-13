Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D575C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE0F2147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ks1KLPCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE0F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPj4-0008CZ-GC
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59439)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdd-0008PO-7U
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdV-0004do-MI
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:52171)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdV-0004Vg-5W
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id 207so2082552wma.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ntm/Cb4AncOPeCVYJ1Vrv7fiT2IGGzLZpdC//b8Kuds=;
 b=Ks1KLPCXk7vsjkTIQMuWoqHydm9jSDKxd1t3W3GQi1D2sHuGpgNnbjYv1dbJPMn0kc
 TanY1+2sDQVNOpE340765asdmZ4wi7d1PkqsYumShgbHAJOaWBzbiKFBtmnjAzobjN0c
 VyXPSo8dsFr8W6pL7qrsRD0SqZII5/EyGyzVA8XjCI1/nU8se1nG167eFDEemJvMR/ES
 BezGL+gj0jhOmMCIn8Lx6GUWyCJW6XuqT/Kc6nB+PGEPzEOrfD9m8K7SI4SUceRtDqo8
 9Il1Ui0YNcpZoV+nvpl0QwzirOxz/SumKNeR0h0gNK8y/e4PfdETQIywWKqsv96A7W+4
 Dl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ntm/Cb4AncOPeCVYJ1Vrv7fiT2IGGzLZpdC//b8Kuds=;
 b=bKzpQQCcYZOyNukkWlnBV1QPTUDEuAYGgq5rLOoO8Eogx87bM1byFZ6RhCs3pi895n
 yMp9l31vKUk9sNOAou5weEFMT0iWBPzLvv6etJzZmO2LhLfXaqKwtkuXnWXHtt1Kkutl
 YEiNhZnO5Mi2S/7lSb/ENzbl5Vv4UYwy9afBppl69oa41ef5J3ZvyeAPQ9zvc/F7xffl
 cD58K5+PLaSOjFFIXVTGTtNBoGo7WsCi3rExZoLwi68WcXsfIsa3ks7YRAnJGFosML0B
 SI0rzg0z8MglYyaBif7OPmOP0gMOYkR9W8V57IeyAyJCUniMo/Pr4z8lhc4yxI4dkfQu
 T/Yg==
X-Gm-Message-State: APjAAAWn27fWeWpFLmpgcuD/wUaD6DuX4hS4VAEybVuhOUveEm7zQVs8
 fopW7RTyrsqNHtnN2ZO0shyYKGVCTyuOqg==
X-Google-Smtp-Source: APXvYqxa0i5e5cK5zLRioP3BVJe8TJWxcoRr4ABhgcZLtUQMu+WHyXMxamuF+RFbgExRk3IzKW2VBg==
X-Received: by 2002:a1c:b707:: with SMTP id h7mr3520312wmf.45.1560428118311;
 Thu, 13 Jun 2019 05:15:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:25 +0100
Message-Id: <20190613121433.5246-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PULL 40/48] target/arm: Convert the VCVT-from-f16
 insns to decodetree
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

Convert the VCVTT, VCVTB instructions that deal with conversion
from half-precision floats to f32 or 64 to decodetree.

Since we're no longer constrained to the old decoder's style
using cpu_F0s and cpu_F0d we can perform a direct 16 bit
load of the right half of the input single-precision register
rather than loading the full 32 bits and then doing a
separate shift or sign-extension.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 82 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 56 +----------------------
 target/arm/vfp.decode          |  6 +++
 3 files changed, 89 insertions(+), 55 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index ebde86210a6..732bf6020a9 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -30,6 +30,26 @@
 #include "decode-vfp.inc.c"
 #include "decode-vfp-uncond.inc.c"
 
+/*
+ * Return the offset of a 16-bit half of the specified VFP single-precision
+ * register. If top is true, returns the top 16 bits; otherwise the bottom
+ * 16 bits.
+ */
+static inline long vfp_f16_offset(unsigned reg, bool top)
+{
+    long offs = vfp_reg_offset(false, reg);
+#ifdef HOST_WORDS_BIGENDIAN
+    if (!top) {
+        offs += 2;
+    }
+#else
+    if (top) {
+        offs += 2;
+    }
+#endif
+    return offs;
+}
+
 /*
  * Check that VFP access is enabled. If it is, do the necessary
  * M-profile lazy-FP handling and then return true.
@@ -2013,3 +2033,65 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
 
     return true;
 }
+
+static bool trans_VCVT_f32_f16(DisasContext *s, arg_VCVT_f32_f16 *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 ahp_mode;
+    TCGv_i32 tmp;
+
+    if (!dc_isar_feature(aa32_fp16_spconv, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(false);
+    ahp_mode = get_ahp_flag();
+    tmp = tcg_temp_new_i32();
+    /* The T bit tells us if we want the low or high 16 bits of Vm */
+    tcg_gen_ld16u_i32(tmp, cpu_env, vfp_f16_offset(a->vm, a->t));
+    gen_helper_vfp_fcvt_f16_to_f32(tmp, tmp, fpst, ahp_mode);
+    neon_store_reg32(tmp, a->vd);
+    tcg_temp_free_i32(ahp_mode);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tmp);
+    return true;
+}
+
+static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 ahp_mode;
+    TCGv_i32 tmp;
+    TCGv_i64 vd;
+
+    if (!dc_isar_feature(aa32_fp16_dpconv, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd  & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(false);
+    ahp_mode = get_ahp_flag();
+    tmp = tcg_temp_new_i32();
+    /* The T bit tells us if we want the low or high 16 bits of Vm */
+    tcg_gen_ld16u_i32(tmp, cpu_env, vfp_f16_offset(a->vm, a->t));
+    vd = tcg_temp_new_i64();
+    gen_helper_vfp_fcvt_f16_to_f64(vd, tmp, fpst, ahp_mode);
+    neon_store_reg64(vd, a->vd);
+    tcg_temp_free_i32(ahp_mode);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i64(vd);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index af1d01c49b7..a2cb2cdba58 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3066,7 +3066,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 0 ... 3:
+                case 0 ... 5:
                 case 8 ... 11:
                     /* Already handled by decodetree */
                     return 1;
@@ -3080,24 +3080,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             if (op == 15) {
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
-                case 0x04: /* vcvtb.f64.f16, vcvtb.f32.f16 */
-                case 0x05: /* vcvtt.f64.f16, vcvtt.f32.f16 */
-                    /*
-                     * VCVTB, VCVTT: only present with the halfprec extension
-                     * UNPREDICTABLE if bit 8 is set prior to ARMv8
-                     * (we choose to UNDEF)
-                     */
-                    if (dp) {
-                        if (!dc_isar_feature(aa32_fp16_dpconv, s)) {
-                            return 1;
-                        }
-                    } else {
-                        if (!dc_isar_feature(aa32_fp16_spconv, s)) {
-                            return 1;
-                        }
-                    }
-                    rm_is_dp = false;
-                    break;
                 case 0x06: /* vcvtb.f16.f32, vcvtb.f16.f64 */
                 case 0x07: /* vcvtt.f16.f32, vcvtt.f16.f64 */
                     if (dp) {
@@ -3239,42 +3221,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 4: /* vcvtb.f32.f16, vcvtb.f64.f16 */
-                    {
-                        TCGv_ptr fpst = get_fpstatus_ptr(false);
-                        TCGv_i32 ahp_mode = get_ahp_flag();
-                        tmp = gen_vfp_mrs();
-                        tcg_gen_ext16u_i32(tmp, tmp);
-                        if (dp) {
-                            gen_helper_vfp_fcvt_f16_to_f64(cpu_F0d, tmp,
-                                                           fpst, ahp_mode);
-                        } else {
-                            gen_helper_vfp_fcvt_f16_to_f32(cpu_F0s, tmp,
-                                                           fpst, ahp_mode);
-                        }
-                        tcg_temp_free_i32(ahp_mode);
-                        tcg_temp_free_ptr(fpst);
-                        tcg_temp_free_i32(tmp);
-                        break;
-                    }
-                    case 5: /* vcvtt.f32.f16, vcvtt.f64.f16 */
-                    {
-                        TCGv_ptr fpst = get_fpstatus_ptr(false);
-                        TCGv_i32 ahp = get_ahp_flag();
-                        tmp = gen_vfp_mrs();
-                        tcg_gen_shri_i32(tmp, tmp, 16);
-                        if (dp) {
-                            gen_helper_vfp_fcvt_f16_to_f64(cpu_F0d, tmp,
-                                                           fpst, ahp);
-                        } else {
-                            gen_helper_vfp_fcvt_f16_to_f32(cpu_F0s, tmp,
-                                                           fpst, ahp);
-                        }
-                        tcg_temp_free_i32(tmp);
-                        tcg_temp_free_i32(ahp);
-                        tcg_temp_free_ptr(fpst);
-                        break;
-                    }
                     case 6: /* vcvtb.f16.f32, vcvtb.f16.f64 */
                     {
                         TCGv_ptr fpst = get_fpstatus_ptr(false);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 9db7aa7021a..53d9544f7cd 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -181,3 +181,9 @@ VCMP_sp      ---- 1110 1.11 010 z:1 .... 1010 e:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCMP_dp      ---- 1110 1.11 010 z:1 .... 1011 e:1 1.0 .... \
              vd=%vd_dp vm=%vm_dp
+
+# VCVTT and VCVTB from f16: Vd format depends on size bit; Vm is always vm_sp
+VCVT_f32_f16 ---- 1110 1.11 0010 .... 1010 t:1 1.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VCVT_f64_f16 ---- 1110 1.11 0010 .... 1011 t:1 1.0 .... \
+             vd=%vd_dp vm=%vm_sp
-- 
2.20.1


