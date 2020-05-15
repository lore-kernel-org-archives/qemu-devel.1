Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EF6C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6EB2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vi1slfoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6EB2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbHU-0000Xx-D7
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZbCz-0000ix-TR
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:21:05 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZbCy-0003sG-OU
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:21:05 -0400
Received: by mail-wr1-x442.google.com with SMTP id e1so3772914wrt.5
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2YJwvw0U8SAAD/UpPFNsjDivgh2d1pwAU2NE+6DTu5Y=;
 b=vi1slfoeztNGNZ6vyb9td7BdpXMFohwqluyQB7JBMtlYW+unZ4McAgMzqXlwY1HpHI
 1KoQKlx01C2TPdV8yr1SoitAe1+3tEUFu0lY9IG9zt0kgyiPupmyvfmpc3H7c7fg96qp
 nn7Qgg7NaERw9N+7USkjbDlDnAHQXsGHNj30Nbgf6dBGstcJ3Qxt4CxGzwopGB/JE7P7
 OitXplZgSxh7s8ua3r2BeMzO2xMER2qpKi+i/QZkGn+M1IsTq+z/ajD/mBciE05RuYlo
 zpDEP04FlfmjbKAsAJYMVP18vinhKb2uGEzV45TGFQ170YThyvukQva3cSPmmGA0GJ0D
 Re5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2YJwvw0U8SAAD/UpPFNsjDivgh2d1pwAU2NE+6DTu5Y=;
 b=Hnw+XBCJ5QVh92e4eW0s9fCtZmkmBAgniFpmdWfht+LAxpDGhkAjBAXNW95op+25hh
 LOci0CgZeCNH9Wv5Gt8QHvgkMtxlIFVwDJW0W+0LwPD2i52esRxK6v6e5NriaiePWG91
 F1eseqsZJU+5VGgLiT6wj6yGhmv5EznrTtEpG8IVKvb2zx07dWsNE9EgUlCDFQJgdDEi
 korFUqj1SFzhSZqNFw+xOk1BqWZoO9HUUkImKKD5VWmilBy5/j3k3AofG8IN5Cevch1C
 5od5JsO9FciZBFmlreYgwMY8lGLL+Abt0RbSG3NUH72cpAdXDSohEd1/Pa1wbHcSnVtk
 qkHw==
X-Gm-Message-State: AOAM532tNUx3SjzjO1jU9olIjZTGwMSMHuSlzI1mVPBZZ4ZPiJMbsyb5
 eLGUhrgG+a4ctgbNG8kkZuGGdQ==
X-Google-Smtp-Source: ABdhPJydgcfhnHbIwx1fcPmedqQjVWuRYTReR6iOVZdMgugbfb28bTK/dz6IShKslx61TvqIYVAshQ==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr4460229wrm.224.1589552463301; 
 Fri, 15 May 2020 07:21:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s14sm3738327wmh.18.2020.05.15.07.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:21:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/10] target/arm: Convert Neon VSRA, VSRI, VRSHR,
 VRSRA 2-reg-shift insns to decodetree
Date: Fri, 15 May 2020 15:20:50 +0100
Message-Id: <20200515142056.21346-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515142056.21346-1-peter.maydell@linaro.org>
References: <20200515142056.21346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VSRA, VSRI, VRSHR, VRSRA 2-reg-shift insns to decodetree.
(These are the last instructions in the group that are vectorized;
the rest all require looping over each element.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       | 63 +++++++++++++++++++++++++++++++++
 target/arm/translate-neon.inc.c |  7 ++++
 target/arm/translate.c          | 52 +++------------------------
 3 files changed, 74 insertions(+), 48 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 648812395f1..3ed10d1524e 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -233,6 +233,69 @@ VSHR_U_2sh       1111 001 1 1 . 01 ....     .... 0000 0 . . 1 .... \
 VSHR_U_2sh       1111 001 1 1 . 001 ...     .... 0000 0 . . 1 .... \
                  @2reg_shift size=0 shift=%neon_rshift_i3
 
+VSRA_S_2sh       1111 001 0 1 .  ......     .... 0001 1 . . 1 .... \
+                 @2reg_shift size=3 shift=%neon_rshift_i6
+VSRA_S_2sh       1111 001 0 1 . 1 .....     .... 0001 0 . . 1 .... \
+                 @2reg_shift size=2 shift=%neon_rshift_i5
+VSRA_S_2sh       1111 001 0 1 . 01 ....     .... 0001 0 . . 1 .... \
+                 @2reg_shift size=1 shift=%neon_rshift_i4
+VSRA_S_2sh       1111 001 0 1 . 001 ...     .... 0001 0 . . 1 .... \
+                 @2reg_shift size=0 shift=%neon_rshift_i3
+
+VSRA_U_2sh       1111 001 1 1 .  ......     .... 0001 1 . . 1 .... \
+                 @2reg_shift size=3 shift=%neon_rshift_i6
+VSRA_U_2sh       1111 001 1 1 . 1 .....     .... 0001 0 . . 1 .... \
+                 @2reg_shift size=2 shift=%neon_rshift_i5
+VSRA_U_2sh       1111 001 1 1 . 01 ....     .... 0001 0 . . 1 .... \
+                 @2reg_shift size=1 shift=%neon_rshift_i4
+VSRA_U_2sh       1111 001 1 1 . 001 ...     .... 0001 0 . . 1 .... \
+                 @2reg_shift size=0 shift=%neon_rshift_i3
+
+VRSHR_S_2sh      1111 001 0 1 .  ......     .... 0010 1 . . 1 .... \
+                 @2reg_shift size=3 shift=%neon_rshift_i6
+VRSHR_S_2sh      1111 001 0 1 . 1 .....     .... 0010 0 . . 1 .... \
+                 @2reg_shift size=2 shift=%neon_rshift_i5
+VRSHR_S_2sh      1111 001 0 1 . 01 ....     .... 0010 0 . . 1 .... \
+                 @2reg_shift size=1 shift=%neon_rshift_i4
+VRSHR_S_2sh      1111 001 0 1 . 001 ...     .... 0010 0 . . 1 .... \
+                 @2reg_shift size=0 shift=%neon_rshift_i3
+
+VRSHR_U_2sh      1111 001 1 1 .  ......     .... 0010 1 . . 1 .... \
+                 @2reg_shift size=3 shift=%neon_rshift_i6
+VRSHR_U_2sh      1111 001 1 1 . 1 .....     .... 0010 0 . . 1 .... \
+                 @2reg_shift size=2 shift=%neon_rshift_i5
+VRSHR_U_2sh      1111 001 1 1 . 01 ....     .... 0010 0 . . 1 .... \
+                 @2reg_shift size=1 shift=%neon_rshift_i4
+VRSHR_U_2sh      1111 001 1 1 . 001 ...     .... 0010 0 . . 1 .... \
+                 @2reg_shift size=0 shift=%neon_rshift_i3
+
+VRSRA_S_2sh      1111 001 0 1 .  ......     .... 0011 1 . . 1 .... \
+                 @2reg_shift size=3 shift=%neon_rshift_i6
+VRSRA_S_2sh      1111 001 0 1 . 1 .....     .... 0011 0 . . 1 .... \
+                 @2reg_shift size=2 shift=%neon_rshift_i5
+VRSRA_S_2sh      1111 001 0 1 . 01 ....     .... 0011 0 . . 1 .... \
+                 @2reg_shift size=1 shift=%neon_rshift_i4
+VRSRA_S_2sh      1111 001 0 1 . 001 ...     .... 0011 0 . . 1 .... \
+                 @2reg_shift size=0 shift=%neon_rshift_i3
+
+VRSRA_U_2sh      1111 001 1 1 .  ......     .... 0011 1 . . 1 .... \
+                 @2reg_shift size=3 shift=%neon_rshift_i6
+VRSRA_U_2sh      1111 001 1 1 . 1 .....     .... 0011 0 . . 1 .... \
+                 @2reg_shift size=2 shift=%neon_rshift_i5
+VRSRA_U_2sh      1111 001 1 1 . 01 ....     .... 0011 0 . . 1 .... \
+                 @2reg_shift size=1 shift=%neon_rshift_i4
+VRSRA_U_2sh      1111 001 1 1 . 001 ...     .... 0011 0 . . 1 .... \
+                 @2reg_shift size=0 shift=%neon_rshift_i3
+
+VSRI_2sh         1111 001 1 1 .  ......     .... 0100 1 . . 1 .... \
+                 @2reg_shift size=3 shift=%neon_rshift_i6
+VSRI_2sh         1111 001 1 1 . 1 .....     .... 0100 0 . . 1 .... \
+                 @2reg_shift size=2 shift=%neon_rshift_i5
+VSRI_2sh         1111 001 1 1 . 01 ....     .... 0100 0 . . 1 .... \
+                 @2reg_shift size=1 shift=%neon_rshift_i4
+VSRI_2sh         1111 001 1 1 . 001 ...     .... 0100 0 . . 1 .... \
+                 @2reg_shift size=0 shift=%neon_rshift_i3
+
 VSHL_2sh         1111 001 0 1 . shift:6     .... 0101 1 . . 1 .... \
                  @2reg_shift size=3
 VSHL_2sh         1111 001 0 1 . 1 shift:5   .... 0101 0 . . 1 .... \
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 0475696835f..f4d42683aea 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1366,6 +1366,13 @@ static bool do_vector_2sh(DisasContext *s, arg_2reg_shift *a, GVecGen2iFn *fn)
 
 DO_2SH(VSHL, tcg_gen_gvec_shli)
 DO_2SH(VSLI, gen_gvec_sli)
+DO_2SH(VSRI, gen_gvec_sri)
+DO_2SH(VSRA_S, gen_gvec_ssra)
+DO_2SH(VSRA_U, gen_gvec_usra)
+DO_2SH(VRSHR_S, gen_gvec_srshr)
+DO_2SH(VRSHR_U, gen_gvec_urshr)
+DO_2SH(VRSRA_S, gen_gvec_srsra)
+DO_2SH(VRSRA_U, gen_gvec_ursra)
 
 static bool trans_VSHR_S_2sh(DisasContext *s, arg_2reg_shift *a)
 {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f2ccab1b21c..4a55986aad9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5297,6 +5297,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
 
             switch (op) {
             case 0: /* VSHR */
+            case 1: /* VSRA */
+            case 2: /* VRSHR */
+            case 3: /* VRSRA */
+            case 4: /* VSRI */
             case 5: /* VSHL, VSLI */
                 return 1; /* handled by decodetree */
             default:
@@ -5330,54 +5334,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     shift = shift - (1 << (size + 3));
                 }
 
-                switch (op) {
-                case 1:  /* VSRA */
-                    /* Right shift comes here negative.  */
-                    shift = -shift;
-                    if (u) {
-                        gen_gvec_usra(size, rd_ofs, rm_ofs, shift,
-                                      vec_size, vec_size);
-                    } else {
-                        gen_gvec_ssra(size, rd_ofs, rm_ofs, shift,
-                                      vec_size, vec_size);
-                    }
-                    return 0;
-
-                case 2: /* VRSHR */
-                    /* Right shift comes here negative.  */
-                    shift = -shift;
-                    if (u) {
-                        gen_gvec_urshr(size, rd_ofs, rm_ofs, shift,
-                                       vec_size, vec_size);
-                    } else {
-                        gen_gvec_srshr(size, rd_ofs, rm_ofs, shift,
-                                       vec_size, vec_size);
-                    }
-                    return 0;
-
-                case 3: /* VRSRA */
-                    /* Right shift comes here negative.  */
-                    shift = -shift;
-                    if (u) {
-                        gen_gvec_ursra(size, rd_ofs, rm_ofs, shift,
-                                       vec_size, vec_size);
-                    } else {
-                        gen_gvec_srsra(size, rd_ofs, rm_ofs, shift,
-                                       vec_size, vec_size);
-                    }
-                    return 0;
-
-                case 4: /* VSRI */
-                    if (!u) {
-                        return 1;
-                    }
-                    /* Right shift comes here negative.  */
-                    shift = -shift;
-                    gen_gvec_sri(size, rd_ofs, rm_ofs, shift,
-                                 vec_size, vec_size);
-                    return 0;
-                }
-
                 if (size == 3) {
                     count = q + 1;
                 } else {
-- 
2.20.1


