Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA778C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7519020724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPGI7Tf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7519020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhR0-0003sY-MD
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGs-0002ai-5M
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGp-0003BM-Kx
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id f139so1438335wmf.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wHY2dRt/edaBgZCUqWFdVDocojehIOV1l3z6opvWx9Y=;
 b=CPGI7Tf3ps6NmzBtjrc+2TRiQm2zi6JArmkuP9s3WFD64lFbfYhveTiWBmpR60X2mX
 MSdcDSgyrWcytFMw5jKbFzZ+C4YaUcHOaypAVwqDF5ZMiVMib7+E7f0L8R4QB89BuhUe
 OcmLaF/x+I/Vh5x0Ivh3n8LnlNeERlz7kG+A1UyXrs8RX0lbwNIVNPbUIFC7lonHltbv
 R6tNzPmyPv2CmY1TO75V61kMgwo6qGFNBtBRnS90x817FP2hp8ft6D39JHMBeJjvXwbS
 8rBRxadDJMDoim6qZv7bx0/X41ljCapbDgzfXM38/Jit/HcZl0K9R5H+CSGD4V8/MXk4
 DVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wHY2dRt/edaBgZCUqWFdVDocojehIOV1l3z6opvWx9Y=;
 b=XxYynsC3rwOJlYLYOlCefGT02t2dzt8njd3H3CScKPks+IAeky4HWkBTheio2aksQt
 FNxC8i5Ew+EH8amIXRrVkxrabHU/7xoj5yGwvx/mfON0hNLsrusRnewYzyc1nbBzwHXr
 8zqpKnyNxi8Tw2l2a0Kw9uh1NNSisEQ1kWZaWo5DkEaeUIIiiINXvuW4m5zLvBv+WwKb
 TriZpIKD01twSIatmJhIdBXKDDnrARA6BVPJ6WtPHsKe/89qAh6o4KAaz+C6aMeTELuw
 rcJ3ExKDuB3bUzk9aXMI8YcVk9aX/tkPc/NfGoi4ZKFcrtEf1oA3ASJWK3Hyr3XnvuFl
 DKkg==
X-Gm-Message-State: AOAM533KKlBIJb8dgCPySVngKXJ1qXfA8qt5lZeRp3ne5eBQ9J6sFD09
 zdpUbhsKIsTA3n6e1nE4DcFonvRTb3Ijcg==
X-Google-Smtp-Source: ABdhPJzSge0kAsfxkVJNlM3Wn0s94CBc/0NrpEM8AtF9VQ80RYxpCS/Unnrg9zdzs5tQ2CJRXHXZdg==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr16342387wmj.20.1592912357795; 
 Tue, 23 Jun 2020 04:39:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/42] target/arm: Convert Neon 2-reg-misc crypto operations to
 decodetree
Date: Tue, 23 Jun 2020 12:38:32 +0100
Message-Id: <20200623113904.28805-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon-2-reg misc crypto ops (AESE, AESMC, SHA1H, SHA1SU1)
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-9-peter.maydell@linaro.org
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


