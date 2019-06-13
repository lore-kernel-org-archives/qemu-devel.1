Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D704C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A402173C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NbE333tJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A402173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39624 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPa3-0000F9-4G
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59370)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdZ-0008HA-Ub
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdU-0004aP-Kf
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdU-0004ND-5v
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so20484152wrw.13
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Xek76Z21N6AcxCeV/KMXFd6TB5Qk1G4QFM9zTsJV+oA=;
 b=NbE333tJ3eT3wD79M9E226KMwElA1OMqzy4AoZWfEjyu93jMjmVtx0h20r+fRISPe/
 7a97oZIwh4FlwqUUUXMCwT33H13i4eM8/noegKXTH851JIP/VKpHNfntfLIkQpezlUhC
 jWp+SOy3LBSIL/SB9b0/mnrJ8U1mj2qbUnq6uLaCEHpEzuBlDx6EB+/LTg7Bdyz9qqEZ
 491nxlT/Gi5vvoyn4M8xFau2P+wrWQl7wE6P1itRbCU3UWHNxtOaQscPkND5RSYf0mlq
 haHch9/NWVwuE5Moxp9aWt/IyiEdSwVoCQlo4kSZwbxoamvfY/MHJk/p7csDTmq4/LjW
 2amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xek76Z21N6AcxCeV/KMXFd6TB5Qk1G4QFM9zTsJV+oA=;
 b=UwrA/8oZevii0WUGacWfskalhNYHGRFySGvfXlGqR9569chfpmrR428fTrQ4py4lfZ
 Hlbe/WSC7OiPKoNRakt2xaATwqEbW3sQdRTAqQt238v7zdrkAhMbzh7y3HYrE1dVqX2l
 i1/oyzcQAaxUcWBN56acxonUDILLW5RsTdsyBWODOvTSoRWCYTT4vnV2fZ4K7MbCtfgt
 QcsWVz4NX9IoAOxtnqXv6g5UHBp7XPGxp+oG1wGAfmPSIfVy5uBBvlGz/sakCFpPXper
 qVc/5m8NdTkArB4Ici5/1v8jzsXwEc3jy76AAQMKdoypMVNJ5nZMYf5L5jWZu2QC6cH1
 HvZg==
X-Gm-Message-State: APjAAAU83aX7nTVklFXDVcZrwpytovH3vnzeZT2jLvoDeYMokHObTPmi
 RkJ0ovw1S/hhMf4/PtBMxkURJlypJGEpPw==
X-Google-Smtp-Source: APXvYqwDH0/0t5N/YteAwPqW1fUU/e8HwP2bK66kAcgvnVlmZvlLnKK3VU50ODXVGljxOrWz9h6D5w==
X-Received: by 2002:adf:9cd0:: with SMTP id h16mr42665889wre.211.1560428109883; 
 Thu, 13 Jun 2019 05:15:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:17 +0100
Message-Id: <20190613121433.5246-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 32/48] target/arm: Convert VDIV to decodetree
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

Convert the VDIV instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 10 ++++++++++
 target/arm/translate.c         | 21 +--------------------
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 12da3b8acb8..6af99605d5c 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1471,3 +1471,13 @@ static bool trans_VSUB_dp(DisasContext *s, arg_VSUB_sp *a)
 {
     return do_vfp_3op_dp(s, gen_helper_vfp_subd, a->vd, a->vn, a->vm, false);
 }
+
+static bool trans_VDIV_sp(DisasContext *s, arg_VDIV_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_helper_vfp_divs, a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VDIV_dp(DisasContext *s, arg_VDIV_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_helper_vfp_divd, a->vd, a->vn, a->vm, false);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a7f79395e31..d802f046769 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1374,22 +1374,6 @@ static TCGv_ptr get_fpstatus_ptr(int neon)
     return statusptr;
 }
 
-#define VFP_OP2(name)                                                 \
-static inline void gen_vfp_##name(int dp)                             \
-{                                                                     \
-    TCGv_ptr fpst = get_fpstatus_ptr(0);                              \
-    if (dp) {                                                         \
-        gen_helper_vfp_##name##d(cpu_F0d, cpu_F0d, cpu_F1d, fpst);    \
-    } else {                                                          \
-        gen_helper_vfp_##name##s(cpu_F0s, cpu_F0s, cpu_F1s, fpst);    \
-    }                                                                 \
-    tcg_temp_free_ptr(fpst);                                          \
-}
-
-VFP_OP2(div)
-
-#undef VFP_OP2
-
 static inline void gen_vfp_abs(int dp)
 {
     if (dp)
@@ -3109,7 +3093,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 7:
+            case 0 ... 8:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3295,9 +3279,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 8: /* div: fn / fm */
-                    gen_vfp_div(dp);
-                    break;
                 case 10: /* VFNMA : fd = muladd(-fd,  fn, fm) */
                 case 11: /* VFNMS : fd = muladd(-fd, -fn, fm) */
                 case 12: /* VFMA  : fd = muladd( fd,  fn, fm) */
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index de56f44efc9..de305f60e18 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -137,3 +137,8 @@ VSUB_sp      ---- 1110 0.11 .... .... 1010 .1.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VSUB_dp      ---- 1110 0.11 .... .... 1011 .1.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VDIV_sp      ---- 1110 1.00 .... .... 1010 .0.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VDIV_dp      ---- 1110 1.00 .... .... 1011 .0.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


