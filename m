Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A20C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4472F2075B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OWMgLQTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4472F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFiv-00087O-Iq
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFYE-000228-AM
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:38 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFYB-0001hk-KP
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:37 -0400
Received: by mail-wr1-x42f.google.com with SMTP id q11so10461286wrp.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9Q0xXEZJ6TGepC4ygMhD3wn6XfDyAGo8CkCU3NowxvM=;
 b=OWMgLQTRTypnbdzzqMsAi4dnnp72PgsKuNarx4fnX4Ig7xRxgOSOcvxs6wSBMfIhNs
 xe4Z8Y1Xg4GVZ0wj6RKKFIK3WTHbT8Ym7YS0SD5ETCuzjgCdiG7jpqgjI30vSvNfCd0Z
 iAtxtSOYGIeQ9WDbNKYPwWFoPkJRV/jteTxhUCiniKka+TXRZVZEjxcoE7CU1ldyHpSw
 zzz9njAinZyqn0OgcEfgvSCfB28Gurn5j8LjTHCPv3pxHhyJVS/rPEQti5vg4clRZPZq
 lbfLfio5ogJVMbnZbuoAaIe2BUcDY50JuQr2TthK6rPk/UUTgVblKkrzofSRApiq1y5g
 RY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9Q0xXEZJ6TGepC4ygMhD3wn6XfDyAGo8CkCU3NowxvM=;
 b=YEXOdNdfzWGgvTvDxYKY6PximoKvcqZztV1rgZk76GMjoj/fDcoeiXQE0rCRCf9/7i
 Tay+H2Efsb+UpJ9z8bvlZHTAoGDFUcnFeyOfZQFLCcBmHLOMYkqsHeWaE8JS7K0u14tT
 3ZovmliKw9tX7MfwI5VF8TS3E4TK251v8bccbT6RNtFRzxZ3CPCCl4yLIwpKcQu2dU1K
 p6ZqQB9+vf7FKFmA7GfqOITbQD4/dOD0eUPbx+tRD9koHD4pkKELLqCyhPLbCra6wCJw
 +l9XFeIGqiPCitH5WPPdTBCZHno234RHhS2g0UFtnSfnEqiwabuwWnXmm3BSi5CxyrlE
 to9Q==
X-Gm-Message-State: AOAM531k6eI+I9wrvCWtb1lOYctDZYdr0QshsBNw87Ax/d78hfPHjqpO
 Vjs8gctQgOOmwmdVFkltwawFNzzXK6Ndog==
X-Google-Smtp-Source: ABdhPJx9KB8kwVBJHEGtOHxFqydR7wte+iH4H1eT59sTybBhY5whP53LGS1obY1e42psz1SxAGHSbw==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr10498077wrl.265.1591375833826; 
 Fri, 05 Jun 2020 09:50:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/29] target/arm: Convert Neon VSHR 2-reg-shift insns to
 decodetree
Date: Fri,  5 Jun 2020 17:50:00 +0100
Message-Id: <20200605165007.12095-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Convert the VSHR 2-reg-shift insns to decodetree.

Note that unlike the legacy decoder, we present the right shift
amount to the trans_ function as a positive integer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200522145520.6778-3-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       | 25 ++++++++++++++++++++
 target/arm/translate-neon.inc.c | 41 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 21 +----------------
 3 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index fcce2edacd4..1b877cc68f6 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -208,6 +208,21 @@ VMINNM_fp_3s     1111 001 1 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
 ######################################################################
 &2reg_shift vm vd q shift size
 
+# Right shifts are encoded as N - shift, where N is the element size in bits.
+%neon_rshift_i6  16:6 !function=rsub_64
+%neon_rshift_i5  16:5 !function=rsub_32
+%neon_rshift_i4  16:4 !function=rsub_16
+%neon_rshift_i3  16:3 !function=rsub_8
+
+@2reg_shr_d      .... ... . . . ......  .... .... 1 q:1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=3 shift=%neon_rshift_i6
+@2reg_shr_s      .... ... . . . 1 ..... .... .... 0 q:1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=2 shift=%neon_rshift_i5
+@2reg_shr_h      .... ... . . . 01 .... .... .... 0 q:1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=1 shift=%neon_rshift_i4
+@2reg_shr_b      .... ... . . . 001 ... .... .... 0 q:1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=0 shift=%neon_rshift_i3
+
 @2reg_shl_d      .... ... . . . shift:6      .... .... 1 q:1 . . .... \
                  &2reg_shift vm=%vm_dp vd=%vd_dp size=3
 @2reg_shl_s      .... ... . . . 1 shift:5    .... .... 0 q:1 . . .... \
@@ -217,6 +232,16 @@ VMINNM_fp_3s     1111 001 1 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
 @2reg_shl_b      .... ... . . . 001 shift:3  .... .... 0 q:1 . . .... \
                  &2reg_shift vm=%vm_dp vd=%vd_dp size=0
 
+VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_d
+VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_s
+VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_h
+VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_b
+
+VSHR_U_2sh       1111 001 1 1 . ...... .... 0000 . . . 1 .... @2reg_shr_d
+VSHR_U_2sh       1111 001 1 1 . ...... .... 0000 . . . 1 .... @2reg_shr_s
+VSHR_U_2sh       1111 001 1 1 . ...... .... 0000 . . . 1 .... @2reg_shr_h
+VSHR_U_2sh       1111 001 1 1 . ...... .... 0000 . . . 1 .... @2reg_shr_b
+
 VSHL_2sh         1111 001 0 1 . ...... .... 0101 . . . 1 .... @2reg_shl_d
 VSHL_2sh         1111 001 0 1 . ...... .... 0101 . . . 1 .... @2reg_shl_s
 VSHL_2sh         1111 001 0 1 . ...... .... 0101 . . . 1 .... @2reg_shl_h
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 7f05323fdff..8693b9aa99d 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -31,6 +31,24 @@ static inline int plus1(DisasContext *s, int x)
     return x + 1;
 }
 
+static inline int rsub_64(DisasContext *s, int x)
+{
+    return 64 - x;
+}
+
+static inline int rsub_32(DisasContext *s, int x)
+{
+    return 32 - x;
+}
+static inline int rsub_16(DisasContext *s, int x)
+{
+    return 16 - x;
+}
+static inline int rsub_8(DisasContext *s, int x)
+{
+    return 8 - x;
+}
+
 /* Include the generated Neon decoder */
 #include "decode-neon-dp.inc.c"
 #include "decode-neon-ls.inc.c"
@@ -1240,3 +1258,26 @@ static bool do_vector_2sh(DisasContext *s, arg_2reg_shift *a, GVecGen2iFn *fn)
 
 DO_2SH(VSHL, tcg_gen_gvec_shli)
 DO_2SH(VSLI, gen_gvec_sli)
+
+static bool trans_VSHR_S_2sh(DisasContext *s, arg_2reg_shift *a)
+{
+    /* Signed shift out of range results in all-sign-bits */
+    a->shift = MIN(a->shift, (8 << a->size) - 1);
+    return do_vector_2sh(s, a, tcg_gen_gvec_sari);
+}
+
+static void gen_zero_rd_2sh(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                            int64_t shift, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_dup_imm(vece, rd_ofs, oprsz, maxsz, 0);
+}
+
+static bool trans_VSHR_U_2sh(DisasContext *s, arg_2reg_shift *a)
+{
+    /* Shift out of range is architecturally valid and results in zero. */
+    if (a->shift >= (8 << a->size)) {
+        return do_vector_2sh(s, a, gen_zero_rd_2sh);
+    } else {
+        return do_vector_2sh(s, a, tcg_gen_gvec_shri);
+    }
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 41fef49dbe7..4acc94e3cbc 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5296,6 +5296,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             op = (insn >> 8) & 0xf;
 
             switch (op) {
+            case 0: /* VSHR */
             case 5: /* VSHL, VSLI */
                 return 1; /* handled by decodetree */
             default:
@@ -5330,26 +5331,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
 
                 switch (op) {
-                case 0:  /* VSHR */
-                    /* Right shift comes here negative.  */
-                    shift = -shift;
-                    /* Shifts larger than the element size are architecturally
-                     * valid.  Unsigned results in all zeros; signed results
-                     * in all sign bits.
-                     */
-                    if (!u) {
-                        tcg_gen_gvec_sari(size, rd_ofs, rm_ofs,
-                                          MIN(shift, (8 << size) - 1),
-                                          vec_size, vec_size);
-                    } else if (shift >= 8 << size) {
-                        tcg_gen_gvec_dup_imm(MO_8, rd_ofs, vec_size,
-                                             vec_size, 0);
-                    } else {
-                        tcg_gen_gvec_shri(size, rd_ofs, rm_ofs, shift,
-                                          vec_size, vec_size);
-                    }
-                    return 0;
-
                 case 1:  /* VSRA */
                     /* Right shift comes here negative.  */
                     shift = -shift;
-- 
2.20.1


