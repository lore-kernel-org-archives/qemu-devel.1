Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9790FC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68FDD218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGfwYEjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FDD218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Pq-0007Aq-A1
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mx-00038w-98
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mu-00088X-2A
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:02 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39971)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Mt-00086Z-Qu
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:00 -0400
Received: by mail-pg1-x544.google.com with SMTP id w10so25118261pgj.7
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ukXEAQeVlVRr0NDtltS3ky/umJGI1MT5scY2efu29x8=;
 b=rGfwYEjjH1zbSGoLAJkn1Y0CKXSSsSU6We6F5QakfoswaOEfaMrNaZ/MOXtJlSCY83
 NXT7YNqwfoZ+o3ayyQJL/+X55FLA8xpHycQCUezKhoIe1BKw5qAiy6H6Y7ct6LRRSUQo
 vaT5TzUetA99hu5m0vG67feKLagNoji2lCMdpYjHmr2FfGJ7o6Yp4jmotB24+WyTvPMI
 kg6YjfWWY/pt0A4hnE8Xf+Tz/FdoCXkZ1kc2J7Nipq5FwbU6rnQAuBhzr6/rzKXMqQX7
 6mhYm3YdVIl2HyoBT1mhBNgSOuGStzODjPvdMP5r9ZHD+9a8V7bxYm5o0swrkltZHVe7
 RfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ukXEAQeVlVRr0NDtltS3ky/umJGI1MT5scY2efu29x8=;
 b=LKTjomBDEWW26YGO8KbVC9FGqKZqGvAzg88QCr/sDji9kBukMBhxqmAjMLpbxF1Qh9
 gdyAEaByJCfQHFHVt/kvn+J8RxNP/cN796q4WnTCjub2sdzt319Yj56gl32D1aJqUnzR
 AcGls2PSgQygdmEARptA1ifmwQMATT/OcYhs0PAJcCX5n6I143+fs6Np+MoypEGMXw7d
 cMmSNg3SJVmCThT7d5UdHfJCdMBwNiomewmDOk2DwqytF8LL7lXutdVFXFue91ZOE3JP
 2sFQLpsETaakP9aAJ+1v2t98sde59uq9Y4MPPArs17BPi8DXaKJ/jvouis6K2SWueUnr
 PkLg==
X-Gm-Message-State: APjAAAXGC07t+0P2b4Yx7cOol6vr19gX7mbcKrPO2nvkXMxNAU95ZQzq
 YUOjSW0pBCuBfOqXNMD/DQmrEQoUM2M=
X-Google-Smtp-Source: APXvYqzZa3m4zaryyY4hB6bznSS8dIpJKQmWqYNMePVD+wTXBqpr0bFAE6nn24eVeT3UAY41z3I7Jg==
X-Received: by 2002:a63:36cc:: with SMTP id
 d195mr51512589pga.157.1564163458590; 
 Fri, 26 Jul 2019 10:50:58 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:46 -0700
Message-Id: <20190726175032.6769-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 21/67] target/arm: Convert T32 ADDW/SUBW
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 24 +++++++++++++-----------
 target/arm/a32.decode  |  1 +
 target/arm/t32.decode  | 19 +++++++++++++++++++
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 09310b1c3a..d19131d594 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7683,6 +7683,11 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
  * Constant expanders for the decoders.
  */
 
+static int negate(DisasContext *s, int x)
+{
+    return -x;
+}
+
 static int times_2(DisasContext *s, int x)
 {
     return x * 2;
@@ -8053,6 +8058,12 @@ static bool trans_ORN_rri(DisasContext *s, arg_s_rri_rot *a)
 #undef DO_ANY
 #undef DO_LOGIC
 
+static bool trans_ADR(DisasContext *s, arg_ri *a)
+{
+    store_reg_bx(s, a->rd, add_reg_for_lit(s, 15, a->imm));
+    return true;
+}
+
 /*
  * Multiply and multiply accumulate
  */
@@ -10758,17 +10769,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         }
                         store_reg(s, rd, tmp);
                     } else {
-                        /* Add/sub 12-bit immediate.  */
-                        if (insn & (1 << 23)) {
-                            imm = -imm;
-                        }
-                        tmp = add_reg_for_lit(s, rn, imm);
-                        if (rn == 13 && rd == 13) {
-                            /* ADD SP, SP, imm or SUB SP, SP, imm */
-                            store_sp_checked(s, tmp);
-                        } else {
-                            store_reg(s, rd, tmp);
-                        }
+                        /* Add/sub 12-bit immediate, in decodetree */
+                        goto illegal_op;
                     }
                 }
             } else {
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 32d1833037..baae62dea9 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -30,6 +30,7 @@
 &rrrr            rd rn rm ra
 &rrr             rd rn rm
 &rr              rd rm
+&ri              rd imm
 &r               rm
 &i               imm
 &msr_reg         rn r mask
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index abd233180d..69e81ef71a 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -27,6 +27,7 @@
 &rrrr            !extern rd rn rm ra
 &rrr             !extern rd rn rm
 &rr              !extern rd rm
+&ri              !extern rd imm
 &r               !extern rm
 &i               !extern imm
 &msr_reg         !extern rn r mask
@@ -121,6 +122,24 @@ SBC_rri          1111 0.0 1011 . .... 0 ... .... ........     @s_rri_rot
 }
 RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
 
+# Data processing (plain binary immediate)
+
+%imm12_26_12_0   26:1 12:3 0:8
+%neg12_26_12_0   26:1 12:3 0:8 !function=negate
+@s0_rri_12       .... ... .... . rn:4 . ... rd:4 ........ \
+                 &s_rri_rot imm=%imm12_26_12_0 rot=0 s=0
+
+{
+  ADR            1111 0.1 0000 0 1111 0 ... rd:4 ........ \
+                 &ri imm=%imm12_26_12_0
+  ADD_rri        1111 0.1 0000 0 .... 0 ... .... ........     @s0_rri_12
+}
+{
+  ADR            1111 0.1 0101 0 1111 0 ... rd:4 ........ \
+                 &ri imm=%neg12_26_12_0
+  SUB_rri        1111 0.1 0101 0 .... 0 ... .... ........     @s0_rri_12
+}
+
 # Multiply and multiply accumulate
 
 @s0_rnadm        .... .... .... rn:4 ra:4 rd:4 .... rm:4      &s_rrrr s=0
-- 
2.17.1


