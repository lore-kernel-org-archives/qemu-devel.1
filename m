Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F749C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3B02080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="enSUahLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3B02080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haed6-0003IW-7P
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38999)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haePp-0007AT-I0
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haePl-0007JL-Cf
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:09 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haePl-0007HG-1h
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id 22so2394161wmg.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6srWzGhLdDZvahbNwt98sqmf01N2eShCM8nmAyJtJt8=;
 b=enSUahLzS7sdbjgFcAUG949lrnHrwXq02sbbbsMWLWem/dTWkSvOteuEYdhUgfttck
 EHU4Q58lbqK2GDwqdz8abvwqM10vDNyGZ/xeEgoX2zkyli0IZMJ+1dRymGyH587MPYQj
 iHs3XfGkkI4J86xyaXJHGIgdGv8UnL6yuXPr5JBsrs3z51N4uRfWI/0L+wo5nk5R1qYM
 E27kBOP0SZLfTwkT9EP3Sv8vmeWL0PQPZbdcvDSBTGp7WXwYjETKYxk5lR5Pkim5K9ck
 eR45ljRMh7B7tqNhXLQCwv9+IOtlUHV0Q1w5fTWmdFcwdDHjVrYzDMz/RRYure4o0HpM
 rK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6srWzGhLdDZvahbNwt98sqmf01N2eShCM8nmAyJtJt8=;
 b=D7IiCHkn9t0C05qJSrlFpSYjZIuWURH/ui0Gt2fkDZv+P1Te2HO3T8DK9dfpi1R7YZ
 v4C3tvOCxh+GtCRJRvUWdF0T2bK5HQsrlxrctJqvIgJOFyiLT6B9VtAUKU4Gj1bCjTRJ
 4cEARNZJQAOJiWIT+V7nxmjTkJM6rLwzcaFNpUgtNqMC1vBNI4Iuw0GsiOa4ZlxU9I0H
 siO8cZG8pjQQUhdOTHybOQiea9fZ3wb1JXYs/Rf941L3fCsPqLauM96j6y+/eik+qECf
 z9PEsnBC5t2X9cxwlfDL4VMrDrHitUQr1tYGNx6gpKYLrBK5HURBse10GSDhDcE9jGRL
 m//w==
X-Gm-Message-State: APjAAAXvriosMRDwyjkIPMynFjuigNJvpYXZ03S1HnTvpT20iCCmWV5U
 Z087QLW3WucacSYLOzwhJjdtoA==
X-Google-Smtp-Source: APXvYqzfqriKTrQXiOaTHsIZZRrgxahiDpMQe7HdBtLYOzXeU3ypMAu75gD21/zIfFu4Isp7x6dhew==
X-Received: by 2002:a1c:5f09:: with SMTP id t9mr18294175wmb.112.1560250443007; 
 Tue, 11 Jun 2019 03:54:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:18 +0100
Message-Id: <20190611105351.9871-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2 09/42] target/arm: Convert
 VCVTA/VCVTN/VCVTP/VCVTM to decodetree
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

Convert the VCVTA/VCVTN/VCVTP/VCVTM instructions to decodetree.
trans_VCVT() is temporarily left in translate.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 72 +++++++++++++++++-------------------
 target/arm/vfp-uncond.decode |  6 +++
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1f106645bca..6da472dbca8 100644
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


