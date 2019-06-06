Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B63C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38ABE20868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xf1bqLvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38ABE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35927 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwXJ-00077S-9F
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:50:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTj-00043R-F4
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTg-0003VT-CC
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTf-0002s5-Ff
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:03 -0400
Received: by mail-wm1-x344.google.com with SMTP id v19so806618wmj.5
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=IKYt9IdR9p04yclzZJ7NN0tuSnfOmYMB2x4KhMTCD0Y=;
	b=Xf1bqLviV2uyjpMBVugSD+hc5B7uuH338ROF0FBMDIuwPJ+MTKTyg8Lw/S/Sw5oyMu
	DE4eYYUaiQdhn00F7LIVnTUgyXIMD3Zza/Iob/bUrOyaehNrpdf4atTHVxRmcsm1+5qb
	nrkww3eBtg9fXLlbmZUVnSB78QoDAhgPseQMCtW5AcDXqmFS/zPurEaXZuaUiMkFazBB
	Awu5v6Irmdo3I7KwZpXFlIJ4Z1TVEVAmcKQ6KEwJRYBzUwOakyt9U9jIVw2bh5G3GgyB
	5fa9eUaYxvOKg4bhVr/ID/zf+59BcUVUHd9FArT8lJsQ65/sPQpA24XN2XUVFnl6uD6c
	jPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=IKYt9IdR9p04yclzZJ7NN0tuSnfOmYMB2x4KhMTCD0Y=;
	b=cGoKAGTknV3Mel+abEJvSCvjlP+R5PAoKTL+XC5iV3Xj5pdyJN4/cLop2OU0vcSUhR
	TUgye7eZ9uL+HcecEOqZxSuzQE0K67U9USwesNrIZpKkhuyVOhD7u/uyYfKBeTouPLyr
	3LYOQmeFCfvwIWOY01X6xeiiSRSAmI/S4+kzv4Dp9lMLXSKoovqPEiyhLBOb8ewQ0m2/
	O4Fj3MBWh0QpLPS12jYtNn/sr0WnvitRf65P0Gn2PUGjLLzpRLF7ojQdSPQ8N86237Gn
	qf8utip5h1i22owvvrRWzlyIbInBRlI8rDjjWYnruddX9klqFsdzjH+OnNrZ6LYWCOXI
	iZsg==
X-Gm-Message-State: APjAAAWNyQmYuyb5UKMBJEFKfxkfBZok/y0MDo16SUzPLWbpj/XnxQGQ
	AwTEjGSD8bGknqh8W0WlANpfoQ==
X-Google-Smtp-Source: APXvYqwjaS1jA8UHMKkOo99Gq9IfwTwZhEJVkk2xDB3iaKFw8NSMJvcRJrrv5hsZSZ+f2R4GFQazkA==
X-Received: by 2002:a7b:c189:: with SMTP id y9mr870188wmi.116.1559843180246;
	Thu, 06 Jun 2019 10:46:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:35 +0100
Message-Id: <20190606174609.20487-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 08/42] target/arm: Convert
 VRINTA/VRINTN/VRINTP/VRINTM to decodetree
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

Convert the VRINTA/VRINTN/VRINTP/VRINTM instructions to decodetree.
Again, trans_VRINT() is temporarily left in translate.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c       | 60 +++++++++++++++++++++++-------------
 target/arm/vfp-uncond.decode |  5 +++
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 312ec455c28..91e3e3680b2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3270,11 +3270,43 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
     return true;
 }
 
-static int handle_vrint(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
-                        int rounding)
+/*
+ * Table for converting the most common AArch32 encoding of
+ * rounding mode to arm_fprounding order (which matches the
+ * common AArch64 order); see ARM ARM pseudocode FPDecodeRM().
+ */
+static const uint8_t fp_decode_rm[] = {
+    FPROUNDING_TIEAWAY,
+    FPROUNDING_TIEEVEN,
+    FPROUNDING_POSINF,
+    FPROUNDING_NEGINF,
+};
+
+static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
 {
-    TCGv_ptr fpst = get_fpstatus_ptr(0);
+    uint32_t rd, rm;
+    bool dp = a->dp;
+    TCGv_ptr fpst;
     TCGv_i32 tcg_rmode;
+    int rounding = fp_decode_rm[a->rm];
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (dp && !dc_isar_feature(aa32_fp_d32, s) &&
+        ((a->vm | a->vd) & 0x10)) {
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
 
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
@@ -3305,7 +3337,7 @@ static int handle_vrint(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
     tcg_temp_free_i32(tcg_rmode);
 
     tcg_temp_free_ptr(fpst);
-    return 0;
+    return true;
 }
 
 static int handle_vcvt(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
@@ -3366,17 +3398,6 @@ static int handle_vcvt(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
     return 0;
 }
 
-/* Table for converting the most common AArch32 encoding of
- * rounding mode to arm_fprounding order (which matches the
- * common AArch64 order); see ARM ARM pseudocode FPDecodeRM().
- */
-static const uint8_t fp_decode_rm[] = {
-    FPROUNDING_TIEAWAY,
-    FPROUNDING_TIEEVEN,
-    FPROUNDING_POSINF,
-    FPROUNDING_NEGINF,
-};
-
 static int disas_vfp_misc_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t rd, rm, dp = extract32(insn, 8, 1);
@@ -3389,13 +3410,8 @@ static int disas_vfp_misc_insn(DisasContext *s, uint32_t insn)
         rm = VFP_SREG_M(insn);
     }
 
-    if ((insn & 0x0fbc0ed0) == 0x0eb80a40 &&
-        dc_isar_feature(aa32_vrint, s)) {
-        /* VRINTA, VRINTN, VRINTP, VRINTM */
-        int rounding = fp_decode_rm[extract32(insn, 16, 2)];
-        return handle_vrint(insn, rd, rm, dp, rounding);
-    } else if ((insn & 0x0fbc0e50) == 0x0ebc0a40 &&
-               dc_isar_feature(aa32_vcvt_dr, s)) {
+    if ((insn & 0x0fbc0e50) == 0x0ebc0a40 &&
+        dc_isar_feature(aa32_vcvt_dr, s)) {
         /* VCVTA, VCVTN, VCVTP, VCVTM */
         int rounding = fp_decode_rm[extract32(insn, 16, 2)];
         return handle_vcvt(insn, rd, rm, dp, rounding);
diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 8ab201fa058..0aa83285de2 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -50,3 +50,8 @@ VMINMAXNM   1111 1110 1.00 .... .... 1010 . op:1 .0 .... \
             vm=%vm_sp vn=%vn_sp vd=%vd_sp dp=0
 VMINMAXNM   1111 1110 1.00 .... .... 1011 . op:1 .0 .... \
             vm=%vm_dp vn=%vn_dp vd=%vd_dp dp=1
+
+VRINT       1111 1110 1.11 10 rm:2 .... 1010 01.0 .... \
+            vm=%vm_sp vd=%vd_sp dp=0
+VRINT       1111 1110 1.11 10 rm:2 .... 1011 01.0 .... \
+            vm=%vm_dp vd=%vd_dp dp=1
-- 
2.20.1


