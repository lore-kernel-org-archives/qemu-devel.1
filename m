Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4F4C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A318C2089E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WzcUezC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A318C2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36057 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwf1-0006Ao-Sn
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:58:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTr-0004Ak-5U
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTn-0003dN-As
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:13 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTm-0002sh-8B
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id u8so826822wmm.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=yYV9ZBlnv8DXFwtLcWMXQbHBF1itZYJ0mukmVjZJUHI=;
	b=WzcUezC4bYu5r0aQiPFLiZvTcT+nZE53EfAljybrxcLwgYzQC9op+xPFR0yolOyzgN
	V6iRlxyDjLjD21beGQRSSOLm8PorBva/25uliLOgxHBjD4Kfyno60eNlev8Js40BOt5U
	IF/hSU2VeX2HZqa3x4lNOShwiI1VClXr3dXFdDPG8rhO0mB6XjFJsyb2rAQloK7sNpmr
	usbArA8obXe2ovsJtcn5fKASgOVRnH3DLlgDALlNur8NN0jdA9g1XkQQ9/b5cKkl6Qz0
	qTkxcQZ5AhH8K7fGy4tENDNKC715DGAG1khJGjtJEMKpk4PiS6w8yEK2EnON7UAB+qjq
	rjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=yYV9ZBlnv8DXFwtLcWMXQbHBF1itZYJ0mukmVjZJUHI=;
	b=tSuCVg9X1egLDAA+ZfZaZqZl+TtsrztTUFM6w7IQH1YpH2e1kbYhBPbswZLZAWE44V
	YsI+N6NP6TfacjdDLKhx39qUPy3SeD2+0ZTnZ98u9eXoIiLO3BffQ81s3ovoJyNnuy6N
	12EW8nWdXQH/B3P56A+XqC30YVANcwmZR7hn1aB2Mb264LKa7ottzMcewSY5HAK9KaI1
	J77hsHesXNvcUfMhZhcDtAlCfO8Eu5OazPMPoCSwV7v3Jyc4GqPIeiYxfXQDlpiPldIy
	RrqTzmQWYPkaUsE3Xu3bad3s3ToOcUUJVK3XpF23QovBLSkhI0r6PkD0jG5W9+xbkre0
	x5Ug==
X-Gm-Message-State: APjAAAWGmFqllwpQ0ZfsZPFdqqaUZqd6TVW+zllka8UtFvwTYcm9IPTv
	TJeqL3OWGRNAhTLdc0rG/Hjhzg==
X-Google-Smtp-Source: APXvYqxTwRV186PuoXdzPeHNuPxqwPH5ZJb7/nSBrq/YhYqEJiVq8lw7bMvKl9O6Jm3wwmppQzF2ZA==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr912246wmh.0.1559843181458;
	Thu, 06 Jun 2019 10:46:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:36 +0100
Message-Id: <20190606174609.20487-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 09/42] target/arm: Convert
 VCVTA/VCVTN/VCVTP/VCVTM to decodetree
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

Convert the VCVTA/VCVTN/VCVTP/VCVTM instructions to decodetree.
trans_VCVT() is temporarily left in translate.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c       | 72 +++++++++++++++++-------------------
 target/arm/vfp-uncond.decode |  6 +++
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 91e3e3680b2..2cf8fd99404 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3340,12 +3340,31 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
     return true;
 }
 
-static int handle_vcvt(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
-                       int rounding)
+static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
 {
-    bool is_signed = extract32(insn, 7, 1);
-    TCGv_ptr fpst = get_fpstatus_ptr(0);
+    uint32_t rd, rm;
+    bool dp = a->dp;
+    TCGv_ptr fpst;
     TCGv_i32 tcg_rmode, tcg_shift;
+    int rounding = fp_decode_rm[a->rm];
+    bool is_signed = a->op;
+
+    if (!dc_isar_feature(aa32_vcvt_dr, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+        return false;
+    }
+    rd = a->vd;
+    rm = a->vm;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(0);
 
     tcg_shift = tcg_const_i32(0);
 
@@ -3355,10 +3374,6 @@ static int handle_vcvt(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
     if (dp) {
         TCGv_i64 tcg_double, tcg_res;
         TCGv_i32 tcg_tmp;
-        /* Rd is encoded as a single precision register even when the source
-         * is double precision.
-         */
-        rd = ((rd << 1) & 0x1e) | ((rd >> 4) & 0x1);
         tcg_double = tcg_temp_new_i64();
         tcg_res = tcg_temp_new_i64();
         tcg_tmp = tcg_temp_new_i32();
@@ -3395,28 +3410,7 @@ static int handle_vcvt(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
 
     tcg_temp_free_ptr(fpst);
 
-    return 0;
-}
-
-static int disas_vfp_misc_insn(DisasContext *s, uint32_t insn)
-{
-    uint32_t rd, rm, dp = extract32(insn, 8, 1);
-
-    if (dp) {
-        VFP_DREG_D(rd, insn);
-        VFP_DREG_M(rm, insn);
-    } else {
-        rd = VFP_SREG_D(insn);
-        rm = VFP_SREG_M(insn);
-    }
-
-    if ((insn & 0x0fbc0e50) == 0x0ebc0a40 &&
-        dc_isar_feature(aa32_vcvt_dr, s)) {
-        /* VCVTA, VCVTN, VCVTP, VCVTM */
-        int rounding = fp_decode_rm[extract32(insn, 16, 2)];
-        return handle_vcvt(insn, rd, rm, dp, rounding);
-    }
-    return 1;
+    return true;
 }
 
 /*
@@ -3452,6 +3446,15 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
         }
     }
 
+    if (extract32(insn, 28, 4) == 0xf) {
+        /*
+         * Encodings with T=1 (Thumb) or unconditional (ARM): these
+         * were all handled by the decodetree decoder, so any insn
+         * patterns which get here must be UNDEF.
+         */
+        return 1;
+    }
+
     /*
      * FIXME: this access check should not take precedence over UNDEF
      * for invalid encodings; we will generate incorrect syndrome information
@@ -3468,15 +3471,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
         return 0;
     }
 
-    if (extract32(insn, 28, 4) == 0xf) {
-        /*
-         * Encodings with T=1 (Thumb) or unconditional (ARM):
-         * only used for the "miscellaneous VFP features" added in v8A
-         * and v7M (and gated on the MVFR2.FPMisc field).
-         */
-        return disas_vfp_misc_insn(s, insn);
-    }
-
     dp = ((insn & 0xf00) == 0xb00);
     switch ((insn >> 24) & 0xf) {
     case 0xe:
diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 0aa83285de2..5af1f2ee664 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -55,3 +55,9 @@ VRINT       1111 1110 1.11 10 rm:2 .... 1010 01.0 .... \
             vm=%vm_sp vd=%vd_sp dp=0
 VRINT       1111 1110 1.11 10 rm:2 .... 1011 01.0 .... \
             vm=%vm_dp vd=%vd_dp dp=1
+
+# VCVT float to int with specified rounding mode; Vd is always single-precision
+VCVT        1111 1110 1.11 11 rm:2 .... 1010 op:1 1.0 .... \
+            vm=%vm_sp vd=%vd_sp dp=0
+VCVT        1111 1110 1.11 11 rm:2 .... 1011 op:1 1.0 .... \
+            vm=%vm_dp vd=%vd_sp dp=1
-- 
2.20.1


