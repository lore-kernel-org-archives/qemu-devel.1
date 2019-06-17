Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C444AC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BCF2086A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDTfAyrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BCF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48178 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcszw-0003TZ-Rr
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46724)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiM-0003eZ-QO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiL-000875-En
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:30 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiL-00086L-4z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so10258586wru.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/O59M+oyu5/R7Sber67X9/QD01sBNxWM7GHNOMmzU2g=;
 b=EDTfAyrDu+ehs7fu2+Rvy+vmjye5s47o4SY9YMs+s5vlamkYuwrt4TUuPTI22jsuIi
 LsNzD4u05EPLfCXzsb9kfIV6S0xXfGJW5s/gxKNQTeMJjVyZJK87bwkp8RdBBQAnV1V7
 nocV++BbC53UxlCsTmHuE/11cSNG10j2s0oTK0Uc5PPVQBBXPIHtM9uhb6S4Fj+1dnIF
 7sGLUAu8KrJH2d3sgfXlpN9puUtbPtvpm5OuL6tAPuB60M58t0ouk8HChVTCYpWbhmb4
 cWfaR3oL4B4ZMsM5CoZR7x8vUFPEdn+Lzwz0bvlxYR8u35E2ZtHDy7XBjuiAoyyVGrVJ
 08cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/O59M+oyu5/R7Sber67X9/QD01sBNxWM7GHNOMmzU2g=;
 b=VvuPo4qtFSUBoMzfYWsHIOlmfcTNHJ36BGvSYmK+WTdqLyPzJgbtXAH4AhJ0Z9zsn9
 m5MnMVDbUde2RTMOMvzYqEec0KWX5GlMXp6NSoc5aJR8kNU/alNAkK5ig5nWd2yBgHae
 OuI4W+XPxJB9lhqLEYfW9r865C3Zb+SfOcgP3vPsd0EmIP5/zxK0+7CematDqVF4jdqT
 E0U4Phi7trRg6B4RfcVxp4a/Z84Zq9kiQhn9Kch6kcXlqnszrKegRVBfs5t95FBFO5Ep
 GyRA+nne6/MLyl1fmYOpKB8wxiWuQ0saD1cC+T/R8c/o+i4PEidBMqlYnlCLCgMm7AZt
 4cyg==
X-Gm-Message-State: APjAAAXWVzj4K4Z0ZTjhqPA6BMTCA59VPgmXm/FabtiZIv8ba/WZCDpy
 dwX/fMTMbQJrQ2ybmx01BDd5pdBO3WBcKA==
X-Google-Smtp-Source: APXvYqyHIN8JBDxHeMHa2VILdrHomKVccPdAPLjbkHhs+rG4kXyOS5pbaXfusr9DX4VE2cOdhpUBsg==
X-Received: by 2002:a05:6000:1c9:: with SMTP id
 t9mr53462883wrx.187.1560782067908; 
 Mon, 17 Jun 2019 07:34:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:34:00 +0100
Message-Id: <20190617143412.5734-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 12/24] target/arm: Use vfp_expand_imm() for
 AArch32 VFP VMOV_imm
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

The AArch32 VMOV (immediate) instruction uses the same VFP encoded
immediate format we already handle in vfp_expand_imm().  Use that
function rather than hand-decoding it.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190613163917.28589-3-peter.maydell@linaro.org
---
 target/arm/translate-vfp.inc.c | 28 ++++------------------------
 target/arm/vfp.decode          | 10 ++++++----
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index a66084f6e36..8b732761f26 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1842,7 +1842,7 @@ static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
     uint32_t delta_d = 0;
     int veclen = s->vec_len;
     TCGv_i32 fd;
-    uint32_t n, i, vd;
+    uint32_t vd;
 
     vd = a->vd;
 
@@ -1869,17 +1869,7 @@ static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
         }
     }
 
-    n = (a->imm4h << 28) & 0x80000000;
-    i = ((a->imm4h << 4) & 0x70) | a->imm4l;
-    if (i & 0x40) {
-        i |= 0x780;
-    } else {
-        i |= 0x800;
-    }
-    n |= i << 19;
-
-    fd = tcg_temp_new_i32();
-    tcg_gen_movi_i32(fd, n);
+    fd = tcg_const_i32(vfp_expand_imm(MO_32, a->imm));
 
     for (;;) {
         neon_store_reg32(fd, vd);
@@ -1902,7 +1892,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
     uint32_t delta_d = 0;
     int veclen = s->vec_len;
     TCGv_i64 fd;
-    uint32_t n, i, vd;
+    uint32_t vd;
 
     vd = a->vd;
 
@@ -1934,17 +1924,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
         }
     }
 
-    n = (a->imm4h << 28) & 0x80000000;
-    i = ((a->imm4h << 4) & 0x70) | a->imm4l;
-    if (i & 0x40) {
-        i |= 0x3f80;
-    } else {
-        i |= 0x4000;
-    }
-    n |= i << 16;
-
-    fd = tcg_temp_new_i64();
-    tcg_gen_movi_i64(fd, ((uint64_t)n) << 32);
+    fd = tcg_const_i64(vfp_expand_imm(MO_64, a->imm));
 
     for (;;) {
         neon_store_reg64(fd, vd);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index ea24365bb4c..a67b3f29ee5 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -44,6 +44,8 @@
 %vmov_idx_b     21:1 5:2
 %vmov_idx_h     21:1 6:1
 
+%vmov_imm 16:4 0:4
+
 # VMOV scalar to general-purpose register; note that this does
 # include some Neon cases.
 VMOV_to_gp   ---- 1110 u:1 1.        1 .... rt:4 1011 ... 1 0000 \
@@ -152,10 +154,10 @@ VFM_sp       ---- 1110 1.10 .... .... 1010 . o2:1 . 0 .... \
 VFM_dp       ---- 1110 1.10 .... .... 1011 . o2:1 . 0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp o1=2
 
-VMOV_imm_sp  ---- 1110 1.11 imm4h:4 .... 1010 0000 imm4l:4 \
-             vd=%vd_sp
-VMOV_imm_dp  ---- 1110 1.11 imm4h:4 .... 1011 0000 imm4l:4 \
-             vd=%vd_dp
+VMOV_imm_sp  ---- 1110 1.11 .... .... 1010 0000 .... \
+             vd=%vd_sp imm=%vmov_imm
+VMOV_imm_dp  ---- 1110 1.11 .... .... 1011 0000 .... \
+             vd=%vd_dp imm=%vmov_imm
 
 VMOV_reg_sp  ---- 1110 1.11 0000 .... 1010 01.0 .... \
              vd=%vd_sp vm=%vm_sp
-- 
2.20.1


