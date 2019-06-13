Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE37CC31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A0B20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBOFN0Yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A0B20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39516 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPF4-0008TY-Pl
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59016)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdL-00080T-AB
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdI-0004Li-63
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdF-0004DU-FS
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id d18so20521857wrs.5
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZrHyvKvOWaE4Pp/kVtSvphKsec2oq7Qnq1JNeO01iSY=;
 b=DBOFN0Yq9c90uggDHRoPGNbmriMw0X6gV3Q3BI++NUUsLF0weDM3cUa/Cf2DzWxpOV
 jY7Gvga9BsdG78sQMOB72Tclccn/du57tS868vqm+yewl5hO7X0+nYtEgM0da4ceArMP
 RXVbPmH1w276FlJKXZof1CBBUC70V2ePTv5DwXX7Q+yRo/4P0skZYr+VgYGuHcfVMS2n
 AcRFwGog5Wvo9Bx9XLYojRTxIw2q589SCZdXCYYE0f3/IqJViBc0qMAYZukaC1LvuNay
 z5h6hYLBu/73PAV15AlV3X4EfsU5txGk/kE0qt2ejVYOXDrM5PB0feJRG2nXmLmERSC7
 o9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZrHyvKvOWaE4Pp/kVtSvphKsec2oq7Qnq1JNeO01iSY=;
 b=W+9OrOhI/JfRmRDJ+6KxQU74/XHhx4qvqGJeseXWKWZDnaEtz4VLKXRTMM4JpS3Q7g
 mE1aaFIa1MYjl6gylcdayFECC8kgsNLAvAo60/uQ2TX6MUFLzwItEg94/DQlax8wo0pt
 SU98STpkWU/xEywuTUIAefVsBcN1o33zwom/RqhmWwrNZ2x21GP9nGy4mEVa92b68VzP
 DRloGEO18gO5hkqBtMfZM3bKSf/2WsVNF7Igrq8++CcwesnPZb2bChAocwoSKyzNE+AO
 tmac0EM+/tTpfwbKLE65lXk1XwvloV49BLBIlHeSgNnsO1ccJ4jYMsXrd7EekMmRdnb4
 zTIA==
X-Gm-Message-State: APjAAAVn/hEbuBEd/2QFECIGanWuGu+Bz/QBK8v6a4BYkdBqlc/y2adZ
 AdGlwy5o6eumpUe1EvkpkwdtxqHwKaB8gA==
X-Google-Smtp-Source: APXvYqw26ErsPLlw+wexDBM+/w3wwbhk+yXHyo4B0Ra3HATs+R3i8j6bowRV3C3jRWGwuoNMpNl3xw==
X-Received: by 2002:adf:f181:: with SMTP id h1mr1582290wro.86.1560428100925;
 Thu, 13 Jun 2019 05:15:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:08 +0100
Message-Id: <20190613121433.5246-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 23/48] target/arm: Remove VLDR/VSTR/VLDM/VSTM
 use of cpu_F0s and cpu_F0d
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

Expand out the sequences in the new decoder VLDR/VSTR/VLDM/VSTM trans
functions which perform the memory accesses by going via the TCG
globals cpu_F0s and cpu_F0d, to use local TCG temps instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 46 +++++++++++++++++++++-------------
 target/arm/translate.c         | 18 -------------
 2 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 32a1805e582..9729946d734 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -857,7 +857,7 @@ static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_sp *a)
 static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
 {
     uint32_t offset;
-    TCGv_i32 addr;
+    TCGv_i32 addr, tmp;
 
     if (!vfp_access_check(s)) {
         return true;
@@ -876,13 +876,15 @@ static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
         addr = load_reg(s, a->rn);
     }
     tcg_gen_addi_i32(addr, addr, offset);
+    tmp = tcg_temp_new_i32();
     if (a->l) {
-        gen_vfp_ld(s, false, addr);
-        gen_mov_vreg_F0(false, a->vd);
+        gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
+        neon_store_reg32(tmp, a->vd);
     } else {
-        gen_mov_F0_vreg(false, a->vd);
-        gen_vfp_st(s, false, addr);
+        neon_load_reg32(tmp, a->vd);
+        gen_aa32_st32(s, tmp, addr, get_mem_index(s));
     }
+    tcg_temp_free_i32(tmp);
     tcg_temp_free_i32(addr);
 
     return true;
@@ -892,6 +894,7 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_sp *a)
 {
     uint32_t offset;
     TCGv_i32 addr;
+    TCGv_i64 tmp;
 
     /* UNDEF accesses to D16-D31 if they don't exist */
     if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
@@ -915,13 +918,15 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_sp *a)
         addr = load_reg(s, a->rn);
     }
     tcg_gen_addi_i32(addr, addr, offset);
+    tmp = tcg_temp_new_i64();
     if (a->l) {
-        gen_vfp_ld(s, true, addr);
-        gen_mov_vreg_F0(true, a->vd);
+        gen_aa32_ld64(s, tmp, addr, get_mem_index(s));
+        neon_store_reg64(tmp, a->vd);
     } else {
-        gen_mov_F0_vreg(true, a->vd);
-        gen_vfp_st(s, true, addr);
+        neon_load_reg64(tmp, a->vd);
+        gen_aa32_st64(s, tmp, addr, get_mem_index(s));
     }
+    tcg_temp_free_i64(tmp);
     tcg_temp_free_i32(addr);
 
     return true;
@@ -930,7 +935,7 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_sp *a)
 static bool trans_VLDM_VSTM_sp(DisasContext *s, arg_VLDM_VSTM_sp *a)
 {
     uint32_t offset;
-    TCGv_i32 addr;
+    TCGv_i32 addr, tmp;
     int i, n;
 
     n = a->imm;
@@ -976,18 +981,20 @@ static bool trans_VLDM_VSTM_sp(DisasContext *s, arg_VLDM_VSTM_sp *a)
     }
 
     offset = 4;
+    tmp = tcg_temp_new_i32();
     for (i = 0; i < n; i++) {
         if (a->l) {
             /* load */
-            gen_vfp_ld(s, false, addr);
-            gen_mov_vreg_F0(false, a->vd + i);
+            gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
+            neon_store_reg32(tmp, a->vd + i);
         } else {
             /* store */
-            gen_mov_F0_vreg(false, a->vd + i);
-            gen_vfp_st(s, false, addr);
+            neon_load_reg32(tmp, a->vd + i);
+            gen_aa32_st32(s, tmp, addr, get_mem_index(s));
         }
         tcg_gen_addi_i32(addr, addr, offset);
     }
+    tcg_temp_free_i32(tmp);
     if (a->w) {
         /* writeback */
         if (a->p) {
@@ -1006,6 +1013,7 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
 {
     uint32_t offset;
     TCGv_i32 addr;
+    TCGv_i64 tmp;
     int i, n;
 
     n = a->imm >> 1;
@@ -1056,18 +1064,20 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
     }
 
     offset = 8;
+    tmp = tcg_temp_new_i64();
     for (i = 0; i < n; i++) {
         if (a->l) {
             /* load */
-            gen_vfp_ld(s, true, addr);
-            gen_mov_vreg_F0(true, a->vd + i);
+            gen_aa32_ld64(s, tmp, addr, get_mem_index(s));
+            neon_store_reg64(tmp, a->vd + i);
         } else {
             /* store */
-            gen_mov_F0_vreg(true, a->vd + i);
-            gen_vfp_st(s, true, addr);
+            neon_load_reg64(tmp, a->vd + i);
+            gen_aa32_st64(s, tmp, addr, get_mem_index(s));
         }
         tcg_gen_addi_i32(addr, addr, offset);
     }
+    tcg_temp_free_i64(tmp);
     if (a->w) {
         /* writeback */
         if (a->p) {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f9b07247b4c..1c5c87d7d01 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1522,24 +1522,6 @@ VFP_GEN_FIX(uhto, )
 VFP_GEN_FIX(ulto, )
 #undef VFP_GEN_FIX
 
-static inline void gen_vfp_ld(DisasContext *s, int dp, TCGv_i32 addr)
-{
-    if (dp) {
-        gen_aa32_ld64(s, cpu_F0d, addr, get_mem_index(s));
-    } else {
-        gen_aa32_ld32u(s, cpu_F0s, addr, get_mem_index(s));
-    }
-}
-
-static inline void gen_vfp_st(DisasContext *s, int dp, TCGv_i32 addr)
-{
-    if (dp) {
-        gen_aa32_st64(s, cpu_F0d, addr, get_mem_index(s));
-    } else {
-        gen_aa32_st32(s, cpu_F0s, addr, get_mem_index(s));
-    }
-}
-
 static inline long vfp_reg_offset(bool dp, unsigned reg)
 {
     if (dp) {
-- 
2.20.1


