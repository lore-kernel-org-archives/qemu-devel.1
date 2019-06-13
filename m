Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3B6C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD5CA21473
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JyIH9wNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5CA21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43764 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUjf-0000E5-Sd
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlH-000404-C3
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlF-0003Jz-DE
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbSlF-0002nU-3L
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:37 -0400
Received: by mail-wm1-x343.google.com with SMTP id w9so7014363wmd.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XGJE4iIoyDN2tN+sycnvDF5WRUBy3je+PRFryiYL8bY=;
 b=JyIH9wNgMCaCsjeNgXKXY6qO5YVaQsxfCRq0Ywi0BSCT4kPClEVph/yDc0l4vbePjD
 KBLFUSxRcJW3oFamFyvvs9LXbLghG4W2IvuEL4fesDZl/AW2mzUSZiooBcZH4O+eObdu
 94HBQMEV3zPqzP2q3Az4MgXfnPi8VdX0L7oQ9kpQgMD59HbSgqFKCNkpLnguCy0xdFwo
 LqUGE+YMDNyy+2QCH89IhecqB+EyHiCUWzJ+ABMOVyXO3ORupTzqUYUdPZBRGMg0IPPr
 wYtqh0K2iDNob6wTQ7vU15nf5IlXpgFaTMLYZsahJHRqOozsAqRVrcBxXm2FYJ+ZftHU
 ftBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XGJE4iIoyDN2tN+sycnvDF5WRUBy3je+PRFryiYL8bY=;
 b=WK2yeol/cWgIfwyRMdGhdNDMkQsDxftSrfvXozyWRNAKIXOzB6h8ktvPLuHOACtynk
 Tpd7DJ/QMsQOOmuTErU7pEeOsouJn1jZFOAO1K3ET8xcQix0Z5YOzwBg7DYu0IEZ8BVB
 I75IKPXHeUN3+SbgW1j/rpL7QYqUQks66MxDMfgtTSTz5Yv9XcJosxVVrBeRcQnpNZkG
 A2r+It3NhI2INeLjrIpmUIiOA84GQHKu5ZqrNa8Y6XczZT34W48QpjGpPt7fLUR6dKy1
 zrHRBtCJemUQdhNPKyi4L/Nn4wgGxWmVrAcYs849ufo0+vnmxSPFUoqwX3M+I2CN+r/H
 pLiw==
X-Gm-Message-State: APjAAAU3z3RwVKN+/wksRcIunNdvgN8woweqbPl6UP3Zd13U8o1fHqOB
 VliF6/qaVxhWc4YCM8U1WKyo2A==
X-Google-Smtp-Source: APXvYqzFqv5g4TK37epAS+rO3iVECjyRj5ICcyTxN7hSkrzDixkhiJTFTIEU0q0WZY9850KymmY1Ew==
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr4518552wmc.169.1560443968944; 
 Thu, 13 Jun 2019 09:39:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f197sm358747wme.39.2019.06.13.09.39.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 09:39:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:39:14 +0100
Message-Id: <20190613163917.28589-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613163917.28589-1-peter.maydell@linaro.org>
References: <20190613163917.28589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 09/12] target/arm: Stop using cpu_F0s in Neon
 VCVT fixed-point ops
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

Stop using cpu_F0s in the Neon VCVT fixed-point operations.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 62 +++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0fb94b777bf..d8b46130d42 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -80,6 +80,8 @@ static const char * const regnames[] =
 /* Function prototypes for gen_ functions calling Neon helpers.  */
 typedef void NeonGenThreeOpEnvFn(TCGv_i32, TCGv_env, TCGv_i32,
                                  TCGv_i32, TCGv_i32);
+/* Function prototypes for gen_ functions for fix point conversions */
+typedef void VFPGenFixPointFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
 
 /* initialize TCG globals.  */
 void arm_translate_init(void)
@@ -1374,27 +1376,6 @@ static TCGv_ptr get_fpstatus_ptr(int neon)
     return statusptr;
 }
 
-#define VFP_GEN_FIX(name, round) \
-static inline void gen_vfp_##name(int dp, int shift, int neon) \
-{ \
-    TCGv_i32 tmp_shift = tcg_const_i32(shift); \
-    TCGv_ptr statusptr = get_fpstatus_ptr(neon); \
-    if (dp) { \
-        gen_helper_vfp_##name##d##round(cpu_F0d, cpu_F0d, tmp_shift, \
-                                        statusptr); \
-    } else { \
-        gen_helper_vfp_##name##s##round(cpu_F0s, cpu_F0s, tmp_shift, \
-                                        statusptr); \
-    } \
-    tcg_temp_free_i32(tmp_shift); \
-    tcg_temp_free_ptr(statusptr); \
-}
-VFP_GEN_FIX(tosl, _round_to_zero)
-VFP_GEN_FIX(toul, _round_to_zero)
-VFP_GEN_FIX(slto, )
-VFP_GEN_FIX(ulto, )
-#undef VFP_GEN_FIX
-
 static inline long vfp_reg_offset(bool dp, unsigned reg)
 {
     if (dp) {
@@ -5721,28 +5702,41 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
             } else if (op >= 14) {
                 /* VCVT fixed-point.  */
+                TCGv_ptr fpst;
+                TCGv_i32 shiftv;
+                VFPGenFixPointFn *fn;
+
                 if (!(insn & (1 << 21)) || (q && ((rd | rm) & 1))) {
                     return 1;
                 }
+
+                if (!(op & 1)) {
+                    if (u) {
+                        fn = gen_helper_vfp_ultos;
+                    } else {
+                        fn = gen_helper_vfp_sltos;
+                    }
+                } else {
+                    if (u) {
+                        fn = gen_helper_vfp_touls_round_to_zero;
+                    } else {
+                        fn = gen_helper_vfp_tosls_round_to_zero;
+                    }
+                }
+
                 /* We have already masked out the must-be-1 top bit of imm6,
                  * hence this 32-shift where the ARM ARM has 64-imm6.
                  */
                 shift = 32 - shift;
+                fpst = get_fpstatus_ptr(1);
+                shiftv = tcg_const_i32(shift);
                 for (pass = 0; pass < (q ? 4 : 2); pass++) {
-                    tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, pass));
-                    if (!(op & 1)) {
-                        if (u)
-                            gen_vfp_ulto(0, shift, 1);
-                        else
-                            gen_vfp_slto(0, shift, 1);
-                    } else {
-                        if (u)
-                            gen_vfp_toul(0, shift, 1);
-                        else
-                            gen_vfp_tosl(0, shift, 1);
-                    }
-                    tcg_gen_st_f32(cpu_F0s, cpu_env, neon_reg_offset(rd, pass));
+                    TCGv_i32 tmpf = neon_load_reg(rm, pass);
+                    fn(tmpf, tmpf, shiftv, fpst);
+                    neon_store_reg(rd, pass, tmpf);
                 }
+                tcg_temp_free_ptr(fpst);
+                tcg_temp_free_i32(shiftv);
             } else {
                 return 1;
             }
-- 
2.20.1


