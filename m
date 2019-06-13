Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1330C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7113121721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqK+Namr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7113121721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39432 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbOyD-0003yW-LN
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58881)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOd9-0007uv-Vb
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOd6-000495-25
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:32984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOcz-00040R-TC
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:51 -0400
Received: by mail-wr1-x42b.google.com with SMTP id n9so20572667wru.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ntwaaBg1kutCMaFMzBy7jmCm0WsN7rKH75PfJlZe0jU=;
 b=XqK+NamrtJtp2h19ewArAQVA0WuJYb8JYKED55BG9WXwjcxCVJa5GNYs8TfUhKDFHp
 WGUa+RJJnfIdfz+Cl8TwMEjcvzoib6MYBuKJiOtq5z7gnXEOXKaLp6/Whn5lASReW4Ou
 c4hv+M0Yi3/EvhVrUDOXzEaiOwOPr44mfjNa63erZWAbMvYrHDSZLiJs3CzWDHNxm/oW
 7t8nexjUo8yR4/bdvEqmTM4RgaswFaKOVdapL4rOREltYwNVt/fDj0Yvjc4ylzDmzWSt
 eBOYaqSznt+a1O3OeXZySZUFBy0FMvdhx9X/UrAIJT1BlFyuNlgsr9+gbZMwaVoUfOxC
 dj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ntwaaBg1kutCMaFMzBy7jmCm0WsN7rKH75PfJlZe0jU=;
 b=hvU9cfxeQAGxgIEkj7Q6Df5fhst0kgsCTDvxDWPpOtqkqyAQxhWpz7M51LuZidSh7V
 DnbstCQyuGKKPJKYvfw1s3LyurkTCWUpxXsHkl5L3+SCr6Jc1CmJ/55OIvTDjHvVFUGl
 OgDTxVYcTzRU3XsCnTRcI9sH6AUjq26X2ISlMd1gqKdYRtID/ouSCVdZRWQnNEie2V8Q
 7rc3OdLnaNQGyFEL32jEJkBugOVYC1plGw5c2+jyD++GGM2tmGqPyjCLWzAnopciLAND
 KsmmKw61kPQ9Im5CtXPKIc3p7aHOnPtULpN4RF9WCX9GbpIsc3cXg6oMmmDFjCnfQLI3
 i6jQ==
X-Gm-Message-State: APjAAAX4LqX1LTVdy7oTGqu0UjPRiGxTBrWRytdhsuCztZ7xjSnv2aQT
 p9IokU/a/X3LD0K37YOhO8fDfrFih3mGng==
X-Google-Smtp-Source: APXvYqzHeuDu4ZVIpY++GhiRs+uFavJwDviE+Stdm2rnxrOUzxgjSI9oiHSI0+dTHaNcjI2P1XMB6g==
X-Received: by 2002:adf:fb81:: with SMTP id a1mr19212708wrr.329.1560428088237; 
 Thu, 13 Jun 2019 05:14:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:13:57 +0100
Message-Id: <20190613121433.5246-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 12/48] target/arm: Convert the VSEL instructions
 to decodetree
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

Convert the VSEL instructions to decodetree.
We leave trans_VSEL() in translate.c for now as this allows
the patch to show just the changes from the old handle_vsel().

In the old code the check for "do D16-D31 exist" was hidden in
the VFP_DREG macro, and assumed that VFPv3 always implied that
D16-D31 exist. In the new code we do the correct ID register test.
This gives identical behaviour for most of our CPUs, and fixes
previously incorrect handling for  Cortex-R5F, Cortex-M4 and
Cortex-M33, which all implement VFPv3 or better with only 16
double-precision registers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  6 ++++++
 target/arm/translate-vfp.inc.c |  9 +++++++++
 target/arm/translate.c         | 35 ++++++++++++++++++++++++----------
 target/arm/vfp-uncond.decode   | 19 ++++++++++++++++++
 4 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 06ddc49eb6c..dc50c86e318 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3371,6 +3371,12 @@ static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
 }
 
+static inline bool isar_feature_aa32_fp_d32(const ARMISARegisters *id)
+{
+    /* Return true if D16-D31 are implemented */
+    return FIELD_EX64(id->mvfr0, MVFR0, SIMDREG) >= 2;
+}
+
 /*
  * We always set the FP and SIMD FP16 fields to indicate identical
  * levels of support (assuming SIMD is implemented at all), so
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index cf3d7febaa7..f7535138d0f 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -129,3 +129,12 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 
     return true;
 }
+
+/*
+ * The most usual kind of VFP access check, for everything except
+ * FMXR/FMRX to the always-available special registers.
+ */
+static bool vfp_access_check(DisasContext *s)
+{
+    return full_vfp_access_check(s, false);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f7720922c75..997cafdbe5c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3076,10 +3076,27 @@ static void gen_neon_dup_high16(TCGv_i32 var)
     tcg_temp_free_i32(tmp);
 }
 
-static int handle_vsel(uint32_t insn, uint32_t rd, uint32_t rn, uint32_t rm,
-                       uint32_t dp)
+static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
 {
-    uint32_t cc = extract32(insn, 20, 2);
+    uint32_t rd, rn, rm;
+    bool dp = a->dp;
+
+    if (!dc_isar_feature(aa32_vsel, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+        ((a->vm | a->vn | a->vd) & 0x10)) {
+        return false;
+    }
+    rd = a->vd;
+    rn = a->vn;
+    rm = a->vm;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
 
     if (dp) {
         TCGv_i64 frn, frm, dest;
@@ -3101,7 +3118,7 @@ static int handle_vsel(uint32_t insn, uint32_t rd, uint32_t rn, uint32_t rm,
 
         tcg_gen_ld_f64(frn, cpu_env, vfp_reg_offset(dp, rn));
         tcg_gen_ld_f64(frm, cpu_env, vfp_reg_offset(dp, rm));
-        switch (cc) {
+        switch (a->cc) {
         case 0: /* eq: Z */
             tcg_gen_movcond_i64(TCG_COND_EQ, dest, zf, zero,
                                 frn, frm);
@@ -3148,7 +3165,7 @@ static int handle_vsel(uint32_t insn, uint32_t rd, uint32_t rn, uint32_t rm,
         dest = tcg_temp_new_i32();
         tcg_gen_ld_f32(frn, cpu_env, vfp_reg_offset(dp, rn));
         tcg_gen_ld_f32(frm, cpu_env, vfp_reg_offset(dp, rm));
-        switch (cc) {
+        switch (a->cc) {
         case 0: /* eq: Z */
             tcg_gen_movcond_i32(TCG_COND_EQ, dest, cpu_ZF, zero,
                                 frn, frm);
@@ -3182,7 +3199,7 @@ static int handle_vsel(uint32_t insn, uint32_t rd, uint32_t rn, uint32_t rm,
         tcg_temp_free_i32(zero);
     }
 
-    return 0;
+    return true;
 }
 
 static int handle_vminmaxnm(uint32_t insn, uint32_t rd, uint32_t rn,
@@ -3354,10 +3371,8 @@ static int disas_vfp_misc_insn(DisasContext *s, uint32_t insn)
         rm = VFP_SREG_M(insn);
     }
 
-    if ((insn & 0x0f800e50) == 0x0e000a00 && dc_isar_feature(aa32_vsel, s)) {
-        return handle_vsel(insn, rd, rn, rm, dp);
-    } else if ((insn & 0x0fb00e10) == 0x0e800a00 &&
-               dc_isar_feature(aa32_vminmaxnm, s)) {
+    if ((insn & 0x0fb00e10) == 0x0e800a00 &&
+        dc_isar_feature(aa32_vminmaxnm, s)) {
         return handle_vminmaxnm(insn, rd, rn, rm, dp);
     } else if ((insn & 0x0fbc0ed0) == 0x0eb80a40 &&
                dc_isar_feature(aa32_vrint, s)) {
diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index b1d9dc507c2..b7f7c27fe86 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -26,3 +26,22 @@
 #  1111 1110 .... .... .... 101. .... ....
 # (but those patterns might also cover some Neon instructions,
 # which do not live in this file.)
+
+# VFP registers have an odd encoding with a four-bit field
+# and a one-bit field which are assembled in different orders
+# depending on whether the register is double or single precision.
+# Each individual instruction function must do the checks for
+# "double register selected but CPU does not have double support"
+# and "double register number has bit 4 set but CPU does not
+# support D16-D31" (which should UNDEF).
+%vm_dp  5:1 0:4
+%vm_sp  0:4 5:1
+%vn_dp  7:1 16:4
+%vn_sp  16:4 7:1
+%vd_dp  22:1 12:4
+%vd_sp  12:4 22:1
+
+VSEL        1111 1110 0. cc:2 .... .... 1010 .0.0 .... \
+            vm=%vm_sp vn=%vn_sp vd=%vd_sp dp=0
+VSEL        1111 1110 0. cc:2 .... .... 1011 .0.0 .... \
+            vm=%vm_dp vn=%vn_dp vd=%vd_dp dp=1
-- 
2.20.1


