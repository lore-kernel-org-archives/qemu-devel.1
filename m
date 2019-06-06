Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782A0C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB602083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVkdeOsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB602083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwpd-0001Vf-C2
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:09:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwUB-0004bC-Ve
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU7-0004By-Aa
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:35 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwU6-0003Hr-QE
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id x17so3323621wrl.9
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Nhyme5lhykh5XVXz5eoRB8o/u66NAipPBCokmUZB+qw=;
	b=FVkdeOsgjI6pu6E83Ue8VNDuvwldZ7TXUaWm/20n1q7nQE2Db478VLZM3u8AdyTYTa
	sdmlb6AM0NV/Kon6yiTLu2rQuweW5a65d0vT3wkEurPm7UCsza7HEJsGhFb7f/ZR0d5u
	P6XkBvKMhdUWV87mFY5RxzvhfrvrMV2mQiBXzqxcK9DiaWK2u5UBDNbvCRy0GLaNH8LP
	Q3ggseLdoggALLa84NcZfHvIgupb/4kJhsLa9jNKN9mNbXNwFyzLmwBSeTufNN5w5iEG
	/M2uX7ZzCr+fRriT82h/HoN4rjwVCgTbnfDQNww8JIQwIRklu9hXGI0nZ5WaJN1mA+7i
	uX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Nhyme5lhykh5XVXz5eoRB8o/u66NAipPBCokmUZB+qw=;
	b=SUA9QzPrKC3kXXgXbuOLKDOGNo12q0OUtxaWNB14NhSgnj3ukU6CI6GFERybnFHQAS
	+2IPbewqN472Sm9mW7dkskIsOufFGGmhY58QttlDEcesT/u13gCmHxBuj4kzc9D55BpS
	3qTACmeYUk7KfkA4F16Iuu93xkGhmamLgUBpKkPieDR51E+zn1w0IO3rP+n/aXaaqfDi
	WviFb+hHRIrwkL+CuABor3jkM9RMLp5ilGJx1v16QvE+lW3JfrFtfIOLRWGzq1snPf9o
	0jwJf6ctyQyvbhfs3CDJkW8z1z9GiWf6keL3SXR5EIS3gfxkuEnr1AivzH/UANRgBpEq
	F7Fg==
X-Gm-Message-State: APjAAAXEAgVjh/gERQlArGu/uhE6DvGjdj0QplRbBvybUO+mpdvHbP5R
	D2Dm8wJLhxE0pO94xdAOWx8p7w==
X-Google-Smtp-Source: APXvYqwMau5Croc+2cvwcZ1iXUfJYAkgRnhHjOm1Beo5Eh9xwJSTWNuxTgSGzGfrVHU03TP4tl92yg==
X-Received: by 2002:adf:a11d:: with SMTP id o29mr2087317wro.262.1559843209136; 
	Thu, 06 Jun 2019 10:46:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:46:01 +0100
Message-Id: <20190606174609.20487-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 34/42] target/arm: Convert the VCVT-from-f16
 insns to decodetree
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
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
---
 target/arm/translate-vfp.inc.c | 82 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 56 +----------------------
 target/arm/vfp.decode          |  6 +++
 3 files changed, 89 insertions(+), 55 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 872b01621cc..3ad93cc48f4 100644
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
@@ -2005,3 +2025,65 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
     }
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
index 26994e0d427..65e69873654 100644
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


