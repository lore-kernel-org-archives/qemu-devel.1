Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5B1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489EF2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhPPWnv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489EF2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFgU-0003b7-Ew
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFYE-00021W-47
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:37699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFYC-0001hz-Pc
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id y20so2052247wmi.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TElvLw1zy+iE9k3jlMsYboQ92jOMtwZTIdWUQibLhGM=;
 b=dhPPWnv8e8pK2Phb+HH+ZvxVSyQsUCCbJBcpsD9dL3zxCxpPRLXZd6ZqPocTWKE7Za
 eAlm2itKYDcmT6dmVkEZsTwesT5MaEDBgy7NZUy0jw6XmQsLVc88N2kzYRAWaQOW3YsO
 RBP0gaAp0Tjz5h8xqgDJNeGwvGCZfyWOGmwlHXZAF3MoKbUn6J0eHQ06pZD3oW/SOC2k
 9Jrwgd3zlwFZ2H0Q/zq3GJqtgiKlVRXedFh/c7JKr76dEQAJuCnHGLzu3TD3s/gNc26p
 4Kmi/wy1ve5NnOftRNozWhFPuEt45E8vmUyN6vzKEpRoonuZifkyu95PAHDAXdL9mF90
 jHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TElvLw1zy+iE9k3jlMsYboQ92jOMtwZTIdWUQibLhGM=;
 b=FK9mctUWQcr4wOe90E8g5QhGXaKRA+IOFmB72Mcbj8P37b8ZgIKsaHS519xLXSnhtR
 ynt2445kbbRjgemkTxcDjTnKYAtLiE+MYB6vpEssTDeDFd1xWicSIVnWfCT6XrkmfqxC
 0sOT1qvZxl4gNoxqjB/WpyK9830VCJ4LD+N/EwkdTBPXYeSOk+1N5MDPSNcLWNTBLqT2
 S5Sy2ehdwVcURk5vCOtNRzLG6xhcGmGrJ8rvv5uw+hAiZbbWd9ZFqyY8Q9km790unrop
 uHNOq0mlpW2eDwNCpqbaaB78xt+WJTwDb6A7mcPa5+JbDbhwpwmdvyz+VQVa2UONmeCf
 bDtQ==
X-Gm-Message-State: AOAM530yjLYA2diMnddmBOQRQWF0zoCQlp1ysBOwvus4YYzqlFZA0EEw
 T/ItN1QHbxDopHck+b+Ew0PP0aNKXt4f+g==
X-Google-Smtp-Source: ABdhPJwCG27J0i6ftfo/y8ziyxhyMSObW9xGt0vDMxrX23hoikwBmzzKV83x6lWDogFBLJasipoOZg==
X-Received: by 2002:a05:600c:4152:: with SMTP id
 h18mr3763402wmm.189.1591375834929; 
 Fri, 05 Jun 2020 09:50:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/29] target/arm: Convert Neon VSRA, VSRI, VRSHR,
 VRSRA 2-reg-shift insns to decodetree
Date: Fri,  5 Jun 2020 17:50:01 +0100
Message-Id: <20200605165007.12095-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VSRA, VSRI, VRSHR, VRSRA 2-reg-shift insns to decodetree.
(These are the last instructions in the group that are vectorized;
the rest all require looping over each element.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200522145520.6778-4-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       | 35 ++++++++++++++++++++++
 target/arm/translate-neon.inc.c |  7 +++++
 target/arm/translate.c          | 52 +++------------------------------
 3 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 1b877cc68f6..659cf139303 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -242,6 +242,41 @@ VSHR_U_2sh       1111 001 1 1 . ...... .... 0000 . . . 1 .... @2reg_shr_s
 VSHR_U_2sh       1111 001 1 1 . ...... .... 0000 . . . 1 .... @2reg_shr_h
 VSHR_U_2sh       1111 001 1 1 . ...... .... 0000 . . . 1 .... @2reg_shr_b
 
+VSRA_S_2sh       1111 001 0 1 . ...... .... 0001 . . . 1 .... @2reg_shr_d
+VSRA_S_2sh       1111 001 0 1 . ...... .... 0001 . . . 1 .... @2reg_shr_s
+VSRA_S_2sh       1111 001 0 1 . ...... .... 0001 . . . 1 .... @2reg_shr_h
+VSRA_S_2sh       1111 001 0 1 . ...... .... 0001 . . . 1 .... @2reg_shr_b
+
+VSRA_U_2sh       1111 001 1 1 . ...... .... 0001 . . . 1 .... @2reg_shr_d
+VSRA_U_2sh       1111 001 1 1 . ...... .... 0001 . . . 1 .... @2reg_shr_s
+VSRA_U_2sh       1111 001 1 1 . ...... .... 0001 . . . 1 .... @2reg_shr_h
+VSRA_U_2sh       1111 001 1 1 . ...... .... 0001 . . . 1 .... @2reg_shr_b
+
+VRSHR_S_2sh      1111 001 0 1 . ...... .... 0010 . . . 1 .... @2reg_shr_d
+VRSHR_S_2sh      1111 001 0 1 . ...... .... 0010 . . . 1 .... @2reg_shr_s
+VRSHR_S_2sh      1111 001 0 1 . ...... .... 0010 . . . 1 .... @2reg_shr_h
+VRSHR_S_2sh      1111 001 0 1 . ...... .... 0010 . . . 1 .... @2reg_shr_b
+
+VRSHR_U_2sh      1111 001 1 1 . ...... .... 0010 . . . 1 .... @2reg_shr_d
+VRSHR_U_2sh      1111 001 1 1 . ...... .... 0010 . . . 1 .... @2reg_shr_s
+VRSHR_U_2sh      1111 001 1 1 . ...... .... 0010 . . . 1 .... @2reg_shr_h
+VRSHR_U_2sh      1111 001 1 1 . ...... .... 0010 . . . 1 .... @2reg_shr_b
+
+VRSRA_S_2sh      1111 001 0 1 . ...... .... 0011 . . . 1 .... @2reg_shr_d
+VRSRA_S_2sh      1111 001 0 1 . ...... .... 0011 . . . 1 .... @2reg_shr_s
+VRSRA_S_2sh      1111 001 0 1 . ...... .... 0011 . . . 1 .... @2reg_shr_h
+VRSRA_S_2sh      1111 001 0 1 . ...... .... 0011 . . . 1 .... @2reg_shr_b
+
+VRSRA_U_2sh      1111 001 1 1 . ...... .... 0011 . . . 1 .... @2reg_shr_d
+VRSRA_U_2sh      1111 001 1 1 . ...... .... 0011 . . . 1 .... @2reg_shr_s
+VRSRA_U_2sh      1111 001 1 1 . ...... .... 0011 . . . 1 .... @2reg_shr_h
+VRSRA_U_2sh      1111 001 1 1 . ...... .... 0011 . . . 1 .... @2reg_shr_b
+
+VSRI_2sh         1111 001 1 1 . ...... .... 0100 . . . 1 .... @2reg_shr_d
+VSRI_2sh         1111 001 1 1 . ...... .... 0100 . . . 1 .... @2reg_shr_s
+VSRI_2sh         1111 001 1 1 . ...... .... 0100 . . . 1 .... @2reg_shr_h
+VSRI_2sh         1111 001 1 1 . ...... .... 0100 . . . 1 .... @2reg_shr_b
+
 VSHL_2sh         1111 001 0 1 . ...... .... 0101 . . . 1 .... @2reg_shl_d
 VSHL_2sh         1111 001 0 1 . ...... .... 0101 . . . 1 .... @2reg_shl_s
 VSHL_2sh         1111 001 0 1 . ...... .... 0101 . . . 1 .... @2reg_shl_h
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 8693b9aa99d..28688000594 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1258,6 +1258,13 @@ static bool do_vector_2sh(DisasContext *s, arg_2reg_shift *a, GVecGen2iFn *fn)
 
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
index 4acc94e3cbc..2d08c644839 100644
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


