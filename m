Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85BCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA2821475
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vABnWw3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA2821475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFBC-0000Kb-W8
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF54-0001K3-Dp
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF52-0007TL-8I
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:02 -0400
Received: by mail-wr1-x442.google.com with SMTP id t18so21579170wru.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kP44X+T+Jfw2C1rlZJnvqC8xIudFDMP5KRrffXuNTsw=;
 b=vABnWw3XXAcPeedfu56Tql4zhVSy20+pLdNodWoRds2Co0JIQCVkGe1B8FMWpqhKNr
 LqRHIGTEGGrzRu3FJDU4KYzeUyWKIOVqNczNYpHQa8vSu65Hdoye+/3nhmuuetWmzrh2
 6HWD/mNDKZnNvd7R+lhvYETqXgXemjSxTuzMo+0z1CgfE4gJHyh6A/4GJUPxLhdZjlj8
 KfTqvnXaJ7CFy7DgX4/C5TameZVUlJ/m8rfrnZvGlnEWbEyNSWGQn/lXiL0Jz0VrHN/y
 5BtalCrioxzY8x3arVNO6ZmqiHy+tJCf2o4VumtAylyuhAYJMPtEXIs19q1TJcZwTy7u
 q9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kP44X+T+Jfw2C1rlZJnvqC8xIudFDMP5KRrffXuNTsw=;
 b=ljV2/0Ek4Cj9CA6mQaFIXZ5a3AdkpY+IVgoAYCmvvMG2sE+d8dB3wlO2DVWKHQDThl
 q9Ox+kO6QUFPh7fAXbjodYy+VAV3GX/BMpryPkBgeMOOzHlkEewlK0qCDwq9iX2DuY+E
 MXk78d4E4gdLu+3dunWDBGOjoIlGOo9PRKwNlk7byW0w4sRN2HozbVp/jIpns8+ARKI2
 U+ogtPHUZaEjWvdvD5TfNCGxyCSnMI5pGfn1tYs0ycRJlmLVdusId9VZyWdpqeW9OPRV
 nqnFcOeGR1PMtvUu3cJxpB3IaF678bplHnYPEiokludX5guLDON/udPKwKCcRr4Lm24M
 eiJQ==
X-Gm-Message-State: AOAM532aSRlN8wGOeOxMRt75BTqgj5HCuVz8Qfh0fMJzDWSqtumGRdIh
 p5ajzRzonllxluUlZN1sEu/QIQ==
X-Google-Smtp-Source: ABdhPJxbjZyw/ijSVtiV93tiTLwtXUbH6tptNgj7slZ7/b/npttcmArFfsgAl5/em56AgW0WmmriiA==
X-Received: by 2002:adf:910e:: with SMTP id j14mr3905230wrj.278.1592327338706; 
 Tue, 16 Jun 2020 10:08:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:08:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/21] target/arm: Convert Neon 2-reg-misc crypto operations
 to decodetree
Date: Tue, 16 Jun 2020 18:08:31 +0100
Message-Id: <20200616170844.13318-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Convert the Neon-2-reg misc crypto ops (AESE, AESMC, SHA1H, SHA1SU1)
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       | 12 ++++++++
 target/arm/translate-neon.inc.c | 42 ++++++++++++++++++++++++++
 target/arm/translate.c          | 52 +++------------------------------
 3 files changed, 58 insertions(+), 48 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index b5692070d62..86b1b9e34bf 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -441,12 +441,19 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
                  &2misc vm=%vm_dp vd=%vd_dp
     @2misc_q0    .... ... .. . .. size:2 .. .... . .... . . . .... \
                  &2misc vm=%vm_dp vd=%vd_dp q=0
+    @2misc_q1    .... ... .. . .. size:2 .. .... . .... . . . .... \
+                 &2misc vm=%vm_dp vd=%vd_dp q=1
 
     VREV64       1111 001 11 . 11 .. 00 .... 0 0000 . . 0 .... @2misc
 
     VPADDL_S     1111 001 11 . 11 .. 00 .... 0 0100 . . 0 .... @2misc
     VPADDL_U     1111 001 11 . 11 .. 00 .... 0 0101 . . 0 .... @2misc
 
+    AESE         1111 001 11 . 11 .. 00 .... 0 0110 0 . 0 .... @2misc_q1
+    AESD         1111 001 11 . 11 .. 00 .... 0 0110 1 . 0 .... @2misc_q1
+    AESMC        1111 001 11 . 11 .. 00 .... 0 0111 0 . 0 .... @2misc_q1
+    AESIMC       1111 001 11 . 11 .. 00 .... 0 0111 1 . 0 .... @2misc_q1
+
     VMVN         1111 001 11 . 11 .. 00 .... 0 1011 . . 0 .... @2misc
 
     VPADAL_S     1111 001 11 . 11 .. 00 .... 0 1100 . . 0 .... @2misc
@@ -458,6 +465,8 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VCLE0        1111 001 11 . 11 .. 01 .... 0 0011 . . 0 .... @2misc
     VCLT0        1111 001 11 . 11 .. 01 .... 0 0100 . . 0 .... @2misc
 
+    SHA1H        1111 001 11 . 11 .. 01 .... 0 0101 1 . 0 .... @2misc_q1
+
     VABS         1111 001 11 . 11 .. 01 .... 0 0110 . . 0 .... @2misc
     VNEG         1111 001 11 . 11 .. 01 .... 0 0111 . . 0 .... @2misc
 
@@ -473,6 +482,9 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
 
     VSHLL        1111 001 11 . 11 .. 10 .... 0 0110 0 . 0 .... @2misc_q0
 
+    SHA1SU1      1111 001 11 . 11 .. 10 .... 0 0111 0 . 0 .... @2misc_q1
+    SHA256SU0    1111 001 11 . 11 .. 10 .... 0 0111 1 . 0 .... @2misc_q1
+
     VCVT_F16_F32 1111 001 11 . 11 .. 10 .... 0 1100 0 . 0 .... @2misc_q0
     VCVT_F32_F16 1111 001 11 . 11 .. 10 .... 0 1110 0 . 0 .... @2misc_q0
   ]
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index d80123514c2..5e2cd18bf71 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3505,3 +3505,45 @@ static bool trans_VMVN(DisasContext *s, arg_2misc *a)
     }
     return do_2misc_vec(s, a, tcg_gen_gvec_not);
 }
+
+#define WRAP_2M_3_OOL_FN(WRAPNAME, FUNC, DATA)                          \
+    static void WRAPNAME(unsigned vece, uint32_t rd_ofs,                \
+                         uint32_t rm_ofs, uint32_t oprsz,               \
+                         uint32_t maxsz)                                \
+    {                                                                   \
+        tcg_gen_gvec_3_ool(rd_ofs, rd_ofs, rm_ofs, oprsz, maxsz,        \
+                           DATA, FUNC);                                 \
+    }
+
+#define WRAP_2M_2_OOL_FN(WRAPNAME, FUNC, DATA)                          \
+    static void WRAPNAME(unsigned vece, uint32_t rd_ofs,                \
+                         uint32_t rm_ofs, uint32_t oprsz,               \
+                         uint32_t maxsz)                                \
+    {                                                                   \
+        tcg_gen_gvec_2_ool(rd_ofs, rm_ofs, oprsz, maxsz, DATA, FUNC);   \
+    }
+
+WRAP_2M_3_OOL_FN(gen_AESE, gen_helper_crypto_aese, 0)
+WRAP_2M_3_OOL_FN(gen_AESD, gen_helper_crypto_aese, 1)
+WRAP_2M_2_OOL_FN(gen_AESMC, gen_helper_crypto_aesmc, 0)
+WRAP_2M_2_OOL_FN(gen_AESIMC, gen_helper_crypto_aesmc, 1)
+WRAP_2M_2_OOL_FN(gen_SHA1H, gen_helper_crypto_sha1h, 0)
+WRAP_2M_2_OOL_FN(gen_SHA1SU1, gen_helper_crypto_sha1su1, 0)
+WRAP_2M_2_OOL_FN(gen_SHA256SU0, gen_helper_crypto_sha256su0, 0)
+
+#define DO_2M_CRYPTO(INSN, FEATURE, SIZE)                       \
+    static bool trans_##INSN(DisasContext *s, arg_2misc *a)     \
+    {                                                           \
+        if (!dc_isar_feature(FEATURE, s) || a->size != SIZE) {  \
+            return false;                                       \
+        }                                                       \
+        return do_2misc_vec(s, a, gen_##INSN);                  \
+    }
+
+DO_2M_CRYPTO(AESE, aa32_aes, 0)
+DO_2M_CRYPTO(AESD, aa32_aes, 0)
+DO_2M_CRYPTO(AESMC, aa32_aes, 0)
+DO_2M_CRYPTO(AESIMC, aa32_aes, 0)
+DO_2M_CRYPTO(SHA1H, aa32_sha1, 2)
+DO_2M_CRYPTO(SHA1SU1, aa32_sha1, 2)
+DO_2M_CRYPTO(SHA256SU0, aa32_sha2, 2)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0f0741a37bc..38644995ab2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4855,7 +4855,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
 {
     int op;
     int q;
-    int rd, rm, rd_ofs, rm_ofs;
+    int rd, rm;
     int size;
     int pass;
     int u;
@@ -4882,8 +4882,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     VFP_DREG_D(rd, insn);
     VFP_DREG_M(rm, insn);
     size = (insn >> 20) & 3;
-    rd_ofs = neon_reg_offset(rd, 0);
-    rm_ofs = neon_reg_offset(rm, 0);
 
     if ((insn & (1 << 23)) == 0) {
         /* Three register same length: handled by decodetree */
@@ -4935,6 +4933,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VCLE0:
                 case NEON_2RM_VCGE0:
                 case NEON_2RM_VCLT0:
+                case NEON_2RM_AESE: case NEON_2RM_AESMC:
+                case NEON_2RM_SHA1H:
+                case NEON_2RM_SHA1SU1:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -4950,51 +4951,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         goto elementwise;
                     }
                     break;
-                case NEON_2RM_AESE: case NEON_2RM_AESMC:
-                    if (!dc_isar_feature(aa32_aes, s) || ((rm | rd) & 1)) {
-                        return 1;
-                    }
-                    /*
-                     * Bit 6 is the lowest opcode bit; it distinguishes
-                     * between encryption (AESE/AESMC) and decryption
-                     * (AESD/AESIMC).
-                     */
-                    if (op == NEON_2RM_AESE) {
-                        tcg_gen_gvec_3_ool(vfp_reg_offset(true, rd),
-                                           vfp_reg_offset(true, rd),
-                                           vfp_reg_offset(true, rm),
-                                           16, 16, extract32(insn, 6, 1),
-                                           gen_helper_crypto_aese);
-                    } else {
-                        tcg_gen_gvec_2_ool(vfp_reg_offset(true, rd),
-                                           vfp_reg_offset(true, rm),
-                                           16, 16, extract32(insn, 6, 1),
-                                           gen_helper_crypto_aesmc);
-                    }
-                    break;
-                case NEON_2RM_SHA1H:
-                    if (!dc_isar_feature(aa32_sha1, s) || ((rm | rd) & 1)) {
-                        return 1;
-                    }
-                    tcg_gen_gvec_2_ool(rd_ofs, rm_ofs, 16, 16, 0,
-                                       gen_helper_crypto_sha1h);
-                    break;
-                case NEON_2RM_SHA1SU1:
-                    if ((rm | rd) & 1) {
-                            return 1;
-                    }
-                    /* bit 6 (q): set -> SHA256SU0, cleared -> SHA1SU1 */
-                    if (q) {
-                        if (!dc_isar_feature(aa32_sha2, s)) {
-                            return 1;
-                        }
-                    } else if (!dc_isar_feature(aa32_sha1, s)) {
-                        return 1;
-                    }
-                    tcg_gen_gvec_2_ool(rd_ofs, rm_ofs, 16, 16, 0,
-                                       q ? gen_helper_crypto_sha256su0
-                                       : gen_helper_crypto_sha1su1);
-                    break;
 
                 default:
                 elementwise:
-- 
2.20.1


