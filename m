Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AF8C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C260720820
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4+2M2+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C260720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56256 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haebm-0001H1-39
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38987)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haePp-0007A4-BU
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haePl-0007IK-2x
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:07 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36473)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haePi-0007EU-Ul
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:03 -0400
Received: by mail-wm1-x342.google.com with SMTP id u8so2398905wmm.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SZbakxW0g38DCAAdbQ5o6o6UWVsvUIKVBk4A8V5fIVY=;
 b=D4+2M2+FrohjPjlO6FclDGgkQtD129vVisIuNtgtJIMypwavc6CYeDXe6xmoYb87t0
 pdRsYQ524L7kGJBeiGcQ1Qx84IekbIcJlWANHrxWt9fH/piSyl9dWZBMmz/HtZsH63pd
 OHsVwG2u8Pd2c7FMa1j/+YrDPm/3T/XotFpNNC5ZDlkGWh8CYizNC2t+7d8DWFSla8a5
 6712Kx4bOAVYLJ2eRaoMobV3u88eo08phU2uHOLx6GNK74pUbSaxFT0K9JUKYbVp+Y2c
 vU/cyn7LBQ7f/XWIxxGHV6DEkSd30RBDqbTS6B3XExxcMW6ZWQxkS/9RmssgJv7e5SUV
 C58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SZbakxW0g38DCAAdbQ5o6o6UWVsvUIKVBk4A8V5fIVY=;
 b=Zej9Q3sv7votiKSlSO7pI4kbW5yyN6uhcl6LK+cn0L4Wyt++V8F5lOa2gCwNBqvPch
 Xwjdfjeyp1laNptblZFYduQUh2cZSlAQT99dUawynD8d1hUzW+sbwe+BZDf8+zuAvw7J
 zyv/ZbAwnEe8iTsgKj2pOQVlQimLHCqKmEKK8A6yd/vwsaeQoZ2mAH9NSDluWEqQ+ZuP
 72dVCGjDrhMoAWcnqdyUhOw+G/bGd068pZV67Iw6Zbl0k/11KcCLg9x16RI0Lhxymmmg
 qY1BpDRoo+oVWvuBLUA1yGKer8gyeW8vv0bBvHkYgtlOjWGinfsGhkTiDZ0mSREN0QyK
 jOTg==
X-Gm-Message-State: APjAAAX/bUXYZ15sMYyk7GVS62UYyDsUdSj2Zp8HaO2RNwKX2t3/2lSo
 tqUdwiQ91N7e1Chy7I1KRp/tY9my5jd7UQ==
X-Google-Smtp-Source: APXvYqwU6S2yHLaWRLmdzXPTpAa4OezYUKpQkHe6NozDe3UTeyu8nqD7H8B9BrnHwqfCE4U8Xez1Wg==
X-Received: by 2002:a1c:80c1:: with SMTP id b184mr15846499wmd.24.1560250440383; 
 Tue, 11 Jun 2019 03:54:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.53.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:53:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:16 +0100
Message-Id: <20190611105351.9871-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2 07/42] target/arm: Convert VMINNM,
 VMAXNM to decodetree
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

Convert the VMINNM and VMAXNM instructions to decodetree.
As with VSEL, we leave the trans_VMINMAXNM() function
in translate.c for the moment.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 41 ++++++++++++++++++++++++------------
 target/arm/vfp-uncond.decode |  5 +++++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6ee60303eeb..53badde1f52 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3202,11 +3202,31 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
     return true;
 }
 
-static int handle_vminmaxnm(uint32_t insn, uint32_t rd, uint32_t rn,
-                            uint32_t rm, uint32_t dp)
+static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
 {
-    uint32_t vmin = extract32(insn, 6, 1);
-    TCGv_ptr fpst = get_fpstatus_ptr(0);
+    uint32_t rd, rn, rm;
+    bool dp = a->dp;
+    bool vmin = a->op;
+    TCGv_ptr fpst;
+
+    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
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
+
+    fpst = get_fpstatus_ptr(0);
 
     if (dp) {
         TCGv_i64 frn, frm, dest;
@@ -3247,7 +3267,7 @@ static int handle_vminmaxnm(uint32_t insn, uint32_t rd, uint32_t rn,
     }
 
     tcg_temp_free_ptr(fpst);
-    return 0;
+    return true;
 }
 
 static int handle_vrint(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
@@ -3359,23 +3379,18 @@ static const uint8_t fp_decode_rm[] = {
 
 static int disas_vfp_misc_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t rd, rn, rm, dp = extract32(insn, 8, 1);
+    uint32_t rd, rm, dp = extract32(insn, 8, 1);
 
     if (dp) {
         VFP_DREG_D(rd, insn);
-        VFP_DREG_N(rn, insn);
         VFP_DREG_M(rm, insn);
     } else {
         rd = VFP_SREG_D(insn);
-        rn = VFP_SREG_N(insn);
         rm = VFP_SREG_M(insn);
     }
 
-    if ((insn & 0x0fb00e10) == 0x0e800a00 &&
-        dc_isar_feature(aa32_vminmaxnm, s)) {
-        return handle_vminmaxnm(insn, rd, rn, rm, dp);
-    } else if ((insn & 0x0fbc0ed0) == 0x0eb80a40 &&
-               dc_isar_feature(aa32_vrint, s)) {
+    if ((insn & 0x0fbc0ed0) == 0x0eb80a40 &&
+        dc_isar_feature(aa32_vrint, s)) {
         /* VRINTA, VRINTN, VRINTP, VRINTM */
         int rounding = fp_decode_rm[extract32(insn, 16, 2)];
         return handle_vrint(insn, rd, rm, dp, rounding);
diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index b7f7c27fe86..8ab201fa058 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -45,3 +45,8 @@ VSEL        1111 1110 0. cc:2 .... .... 1010 .0.0 .... \
             vm=%vm_sp vn=%vn_sp vd=%vd_sp dp=0
 VSEL        1111 1110 0. cc:2 .... .... 1011 .0.0 .... \
             vm=%vm_dp vn=%vn_dp vd=%vd_dp dp=1
+
+VMINMAXNM   1111 1110 1.00 .... .... 1010 . op:1 .0 .... \
+            vm=%vm_sp vn=%vn_sp vd=%vd_sp dp=0
+VMINMAXNM   1111 1110 1.00 .... .... 1011 . op:1 .0 .... \
+            vm=%vm_dp vn=%vn_dp vd=%vd_dp dp=1
-- 
2.20.1


