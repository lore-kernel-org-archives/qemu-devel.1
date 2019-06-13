Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9405EC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CC320B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkNyyD/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CC320B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPEB-0007gW-DK
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59132)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdR-00085d-JL
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdN-0004Q4-7u
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:15 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:45252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdK-00040o-B2
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:11 -0400
Received: by mail-wr1-x42c.google.com with SMTP id f9so20487065wre.12
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DxkVuYTzDW0ZPX4NRM71Po/auhPBMIBC698b0Rvas5w=;
 b=IkNyyD/ioq3HBl8rjXSUxwSJ/beY503oJR4gZZmhJt6hIXQT/NUlxzWiLnU4HDwvvL
 Ss/Dh+tfyvNpWdi3qg8B5R0qbe3UDkwxnEi8PojYLbYKy/istdudSMat9782Jf/qd/0O
 zQvZrkg3m+04OxCpYRykGkGNtKXZ6zfhmIDi+ZytVy7lF50Ynll2H69kurZ08rUnRHEE
 tT627+eza/1kRJIpG5K1294T6MMqGM1Wqu2GYuoLMsUslJ8snOvUQFGdjIdnvJFhRbjK
 lo7x0KNFhM3G2RdBlJXxOTPEiwAGnUy8O7162NELhcpDGtoh/1lehTYUCq+lC4URfipc
 SHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DxkVuYTzDW0ZPX4NRM71Po/auhPBMIBC698b0Rvas5w=;
 b=kV//gziXyQOIiAOMN5JIZ0LY/+sV5IsS7JEXuRcibpI+cOsjNKdIQ+0rySH9emBAsW
 lU/+KHd+fIIEMpairwpt1ENlpv73aY4hK/MaBFUiRytzUlml7RNmZKAsnTGVWQoGxnVm
 w9ON9roo8KpQ1b62WBuDJlU93hrraBFH72c4++St/CoNk7n2AWxoSkxiWdfs7+mDsJfK
 luPXncY+EBJ0JHbdSOuKZzmZT0Yv/8J2GmqKL1QXtocAT7c5Rz/917jRr7Zcd+zpPLZs
 +rdjTHCdDgE9EKOGNsUzd0Uqe9jrXiu+ACz/3IOfhbBV2LC8v11wnCZS3O6NCiELDhuN
 waBA==
X-Gm-Message-State: APjAAAWB5o5sPhM7jHpBGCNorfsFH9nnPRr60tE6PYjI1xv6MXS4217a
 EuU/8f3MU4DgOL5tj8WFH4c/s9RBkxjOBA==
X-Google-Smtp-Source: APXvYqyTBgT9vJG4oeScfUlacIpMArt3Mo1ZMQBwGk+TKE4Qm7xgd15nPwoJKqeC6vKvzGkeZDfssw==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr19241815wrm.55.1560428089145; 
 Thu, 13 Jun 2019 05:14:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:13:58 +0100
Message-Id: <20190613121433.5246-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 13/48] target/arm: Convert VMINNM,
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
index 997cafdbe5c..6cbdf4307a4 100644
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


