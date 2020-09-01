Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF550C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8635420BED
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HG4M0hDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8635420BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD87B-0007I7-N5
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83a-0007re-8X
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:46 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83Y-0006C0-Cu
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:45 -0400
Received: by mail-wm1-x342.google.com with SMTP id s13so1541569wmh.4
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ROW9Q5aXqXTZPIJJlI4YCR/TQMJwu0yJces49kV2nLI=;
 b=HG4M0hDe3ebCAwqyxHdCl858ln4o4vvx0GanPnHGGi38kSAUKyinG5ONFcrqhewyvJ
 5R97mBCHt7YAbBgiBk8xZUGldMelzwmRaVf9uiRo+ljrluoVxoQS3KbETljZFQpa4fy5
 YaWPIT3AgFHqjRthJCcL+Jms/t+YNFtFQ5rHMjaJDzy6HkJNZduwWWJTCB0bcOLQodOC
 BCBtUXZW4ijttcUknnM+hWOSHdam6tBD8hxH8RMhoTbEdnaOgennjyBaWLz1radyAzfl
 WY2I+E3VCFxscChnCMTWl5VPh8gg9KAj1A89vT1S/hRKpclSiiJslXw3Avot2I0DcPpf
 PPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ROW9Q5aXqXTZPIJJlI4YCR/TQMJwu0yJces49kV2nLI=;
 b=TrO7I+asj99IXSAStb6qUT1JEFCGqEdnpVC2MbuyLLZEhpdG2KmuZdVPMaP9/xiR/K
 AEwtudG2vpULKFAAlyUNp82juVkAweFds40t5DaCAw03S80ibQRmfZAeIhSQpttHrTId
 7i3X867sZOpXlGp5OO2MHyzc4bFC4Z9gTZwINaqjmQRwdMG4pCQUr67EmXuIZfH1ncZl
 SkAA98zaERL7imE7ekZ2RMabtSLiX7q+EtyM3LgMg1ylEsWvDTYYT0jr5IG1gsKf6QbT
 5mYgoLeUN5ujRZHsh3FJqcYlg4MqvImYGRY82L6e8DN5+ktnWBGx9C4JwudXXVHjY2Z+
 6i1A==
X-Gm-Message-State: AOAM532W/fdBrIIhpYOX6neR6BGguOs7b1pyuLlVE3Itk+hLD31DCxE0
 xeLwrttgImDKpysM+/iBB+a7LR8zv6K0a4qo
X-Google-Smtp-Source: ABdhPJzdqUzFDcILAipAfdEN27bOCFQ4uLJSsSpGjR4uXOuCNXQVCuVQtW2KPfVN4IzBM1cPC4lW+A==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr2290619wmh.20.1598973521352;
 Tue, 01 Sep 2020 08:18:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/47] target/arm: Implement VFP fp16 VLDR and VSTR
Date: Tue,  1 Sep 2020 16:17:47 +0100
Message-Id: <20200901151823.29785-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

Implement the fp16 versions of the VFP VLDR/VSTR (immediate).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-12-peter.maydell@linaro.org
---
 target/arm/vfp.decode          |  3 +--
 target/arm/translate-vfp.c.inc | 35 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index b213da4b55d..37f96e2d261 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -79,8 +79,7 @@ VMOV_single  ---- 1110 000 l:1 .... rt:4 1010 . 001 0000    vn=%vn_sp
 VMOV_64_sp   ---- 1100 010 op:1 rt2:4 rt:4 1010 00.1 ....   vm=%vm_sp
 VMOV_64_dp   ---- 1100 010 op:1 rt2:4 rt:4 1011 00.1 ....   vm=%vm_dp
 
-# Note that the half-precision variants of VLDR and VSTR are
-# not part of this decodetree at all because they have bits [9:8] == 0b01
+VLDR_VSTR_hp ---- 1101 u:1 .0 l:1 rn:4 .... 1001 imm:8      vd=%vd_sp
 VLDR_VSTR_sp ---- 1101 u:1 .0 l:1 rn:4 .... 1010 imm:8      vd=%vd_sp
 VLDR_VSTR_dp ---- 1101 u:1 .0 l:1 rn:4 .... 1011 imm:8      vd=%vd_dp
 
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 00a6363e1e1..59ef4d4fbc3 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -886,6 +886,41 @@ static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_dp *a)
     return true;
 }
 
+static bool trans_VLDR_VSTR_hp(DisasContext *s, arg_VLDR_VSTR_sp *a)
+{
+    uint32_t offset;
+    TCGv_i32 addr, tmp;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /* imm8 field is offset/2 for fp16, unlike fp32 and fp64 */
+    offset = a->imm << 1;
+    if (!a->u) {
+        offset = -offset;
+    }
+
+    /* For thumb, use of PC is UNPREDICTABLE.  */
+    addr = add_reg_for_lit(s, a->rn, offset);
+    tmp = tcg_temp_new_i32();
+    if (a->l) {
+        gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
+        neon_store_reg32(tmp, a->vd);
+    } else {
+        neon_load_reg32(tmp, a->vd);
+        gen_aa32_st16(s, tmp, addr, get_mem_index(s));
+    }
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
 static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
 {
     uint32_t offset;
-- 
2.20.1


