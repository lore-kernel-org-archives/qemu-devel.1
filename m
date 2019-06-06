Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A882C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3252083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yTg68Oce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3252083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36324 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwsK-0004rX-GT
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:12:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwUD-0004d2-7d
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU8-0004FQ-CM
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:37 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwU8-0002qx-2B
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id x17so3322221wrl.9
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=MfHjpfcV8rDRbagZf+maajLYmXP1fuWCMssnWt0JYC0=;
	b=yTg68OceOZ38PgiDkMW5TtwPXHzi65k/HC4f8vFpSstOQMU3uB75wWeANhx4ukGQ6e
	7M1U48n8ZH29oHS2U1aRF4yuAbqPjzN7veq65Cxhq94CRMcaitGMm8vVpkNfpbijb1X6
	ZxEPULqE1Kf36LgAhugozeyYEWYX/oXlHakwUUtdVGEhPrNpzo9P9YKFHDuwTM2pDD5+
	IoIDbVqtRT0rBmnUVa88Dk5SQk/cui4LRD79p8HgJuTFLKnc+ptV8B2EvS0JquU+yEtH
	ke1ljXj385TQjdKVr4sA8vGe8JUlLh5PyVR903T4cZdABZrYOw3efCm98JG/pZCPShdW
	w5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=MfHjpfcV8rDRbagZf+maajLYmXP1fuWCMssnWt0JYC0=;
	b=HrDj6BlOJGZ59rUdYJdYhEDQtoF0FvG6OrgOYms1Uw+QLUR3A4oVn/V7OZIQIG4FdS
	Yb46220xV6W330e9eocXYU4qy9NlJhdTjLUptB2cnoyN0Z/EaZQdzRrKzsLsLAxuxK8f
	2qNjLdCaNcV0rDdw7IaZKOTyjWZdBhRbidXWQnF95vKUzTb6dcR/7WeBPvyvE6tVxENU
	P4QIBXvK/c926D3H5NrJUJ58pnausEYT5MwyCbPtHjjG8mW/gia5HABI0JijD/HZkMPV
	D1f6cof//lpgmwKtc+bQYso6QZHDKronDMhWL8xJNx1xqi/6vv80Qeeei2w9ouo4TmnQ
	B9Sw==
X-Gm-Message-State: APjAAAXo1gnbrz7HidAkdAhCFXz2rVETXZVAlxDlHkdbgyQHGluCnVoh
	W/S9Z1z84NQpSauYEDS368pFKA==
X-Google-Smtp-Source: APXvYqzUmeifAIs1M30aJFuT1Z1qG8hKmTQQGjwFDCuTabautDZBCt698ME0MkGtcoCb/MDslw+ACA==
X-Received: by 2002:adf:db12:: with SMTP id s18mr6005707wri.335.1559843179086; 
	Thu, 06 Jun 2019 10:46:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:34 +0100
Message-Id: <20190606174609.20487-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 07/42] target/arm: Convert VMINNM,
 VMAXNM to decodetree
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

Convert the VMINNM and VMAXNM instructions to decodetree.
As with VSEL, we leave the trans_VMINMAXNM() function
in translate.c for the moment.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c       | 41 ++++++++++++++++++++++++------------
 target/arm/vfp-uncond.decode |  5 +++++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 50545062195..312ec455c28 100644
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


