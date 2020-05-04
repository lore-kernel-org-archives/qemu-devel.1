Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B863EC47259
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876C52071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUZJIg81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876C52071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVacm-00065u-MH
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaIC-00018K-Cy
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:52 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:36110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaIB-0001IQ-Cq
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:52 -0400
Received: by mail-wr1-x42a.google.com with SMTP id d15so20720456wrx.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=g++wUoq6vldDFh+xfURkEagD8VQSYf3z+WvonduPSWo=;
 b=mUZJIg81EWm50IGDHJXiUzjNoN6dgMwJ++lXibgzsqbSUpFvSVNuK8/zRccKErjpjg
 MTmUCvQCx0tZYDWFeABEYiWLq1D/DbEArE0ls+LKBgZsKl4q0tujWghKqePxleCSge4E
 0/eXXmJzAt++nUzR9jRvcek5dbqF5N5/pJZqy2budQuWPlvW01SxDRbDceT8RUmfbyll
 HvATaEhWhfCIe/KtYDIxtpve2od14qmW0dan2uGGorrzg2Sz6rGe0kseFlCfRppShrBq
 V51uzobZfVrPxYY/9MDs5nudHeRNhQFdLMk8HUN8dcWwQiqLJFP7wBaspX+2Z69MkSIt
 Dk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g++wUoq6vldDFh+xfURkEagD8VQSYf3z+WvonduPSWo=;
 b=g3c6+XqWPigHRaG3a9mSRkeco76MXB4UrVaBbeIPUo0i7NkhcdrfXy/kS7uDzmnZWh
 JjWpvzvDImX6+ZvipPkB88N7cYI5/WIkQ/MnjYCxqJm/027ffb+Y7PgzTNUR2NaMCEhW
 cjI7DZ9kXQXtzacT69zk5gjT2tEtn8cnAd03exXokbLK46yBH43Y8lB+IUWV259B0DFO
 3FGQPuWrWAE5WxLY2b1TCNZ/BrVKrAiLQuXEcIuclE09UHDzZlXESsOirWUg/iQyA39u
 b24GIXNi0NRHwUR/8SuBpO+5r8ayELM0f0MnvfK60/yV12nv8Vyqr2VyGATVyTTUC00E
 WPLQ==
X-Gm-Message-State: AGi0PubEym07O7CPBXUNzUNgL7ofcakRvQYeaLjOWE+9mmu5j0dCjED5
 gk5XrJ78gUe4Qo16V31Kg88zC1iAq2p0vg==
X-Google-Smtp-Source: APiQypKZ0MvZJmpfCcZQfNWoDWKtJ7OACVxtWMNfuT80A87eLZXWhc0XXwnym0yiFxWlrOWxK9HFAQ==
X-Received: by 2002:adf:e449:: with SMTP id t9mr7905653wrm.108.1588595629644; 
 Mon, 04 May 2020 05:33:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/39] target/arm: Convert Neon 3-reg-same logic ops to
 decodetree
Date: Mon,  4 May 2020 13:33:04 +0100
Message-Id: <20200504123309.3808-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Convert the Neon logic ops in the 3-reg-same grouping to decodetree.
Note that for the logic ops the 'size' field forms part of their
decode and the actual operations are always bitwise.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-16-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       | 12 +++++++++++
 target/arm/translate-neon.inc.c | 19 +++++++++++++++++
 target/arm/translate.c          | 38 +--------------------------------
 3 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index a61b1e88476..f62dbaa72d5 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -42,5 +42,17 @@
 @3same           .... ... . . . size:2 .... .... .... . q:1 . . .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
 
+@3same_logic     .... ... . . . .. .... .... .... . q:1 .. .... \
+                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp size=0
+
+VAND_3s          1111 001 0 0 . 00 .... .... 0001 ... 1 .... @3same_logic
+VBIC_3s          1111 001 0 0 . 01 .... .... 0001 ... 1 .... @3same_logic
+VORR_3s          1111 001 0 0 . 10 .... .... 0001 ... 1 .... @3same_logic
+VORN_3s          1111 001 0 0 . 11 .... .... 0001 ... 1 .... @3same_logic
+VEOR_3s          1111 001 1 0 . 00 .... .... 0001 ... 1 .... @3same_logic
+VBSL_3s          1111 001 1 0 . 01 .... .... 0001 ... 1 .... @3same_logic
+VBIT_3s          1111 001 1 0 . 10 .... .... 0001 ... 1 .... @3same_logic
+VBIF_3s          1111 001 1 0 . 11 .... .... 0001 ... 1 .... @3same_logic
+
 VADD_3s          1111 001 0 0 . .. .... .... 1000 . . . 0 .... @3same
 VSUB_3s          1111 001 1 0 . .. .... .... 1000 . . . 0 .... @3same
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index bd9e697b3e2..507f0abe801 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -598,3 +598,22 @@ static bool do_3same(DisasContext *s, arg_3same *a, GVecGen3Fn fn)
 
 DO_3SAME(VADD, tcg_gen_gvec_add)
 DO_3SAME(VSUB, tcg_gen_gvec_sub)
+DO_3SAME(VAND, tcg_gen_gvec_and)
+DO_3SAME(VBIC, tcg_gen_gvec_andc)
+DO_3SAME(VORR, tcg_gen_gvec_or)
+DO_3SAME(VORN, tcg_gen_gvec_orc)
+DO_3SAME(VEOR, tcg_gen_gvec_xor)
+
+/* These insns are all gvec_bitsel but with the inputs in various orders. */
+#define DO_3SAME_BITSEL(INSN, O1, O2, O3)                               \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        tcg_gen_gvec_bitsel(vece, rd_ofs, O1, O2, O3, oprsz, maxsz);    \
+    }                                                                   \
+    DO_3SAME(INSN, gen_##INSN##_3s)
+
+DO_3SAME_BITSEL(VBSL, rd_ofs, rn_ofs, rm_ofs)
+DO_3SAME_BITSEL(VBIT, rm_ofs, rn_ofs, rd_ofs)
+DO_3SAME_BITSEL(VBIF, rm_ofs, rd_ofs, rn_ofs)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 061bc7c31c9..9affa92cbe7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4848,43 +4848,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             }
             return 1;
 
-        case NEON_3R_LOGIC: /* Logic ops.  */
-            switch ((u << 2) | size) {
-            case 0: /* VAND */
-                tcg_gen_gvec_and(0, rd_ofs, rn_ofs, rm_ofs,
-                                 vec_size, vec_size);
-                break;
-            case 1: /* VBIC */
-                tcg_gen_gvec_andc(0, rd_ofs, rn_ofs, rm_ofs,
-                                  vec_size, vec_size);
-                break;
-            case 2: /* VORR */
-                tcg_gen_gvec_or(0, rd_ofs, rn_ofs, rm_ofs,
-                                vec_size, vec_size);
-                break;
-            case 3: /* VORN */
-                tcg_gen_gvec_orc(0, rd_ofs, rn_ofs, rm_ofs,
-                                 vec_size, vec_size);
-                break;
-            case 4: /* VEOR */
-                tcg_gen_gvec_xor(0, rd_ofs, rn_ofs, rm_ofs,
-                                 vec_size, vec_size);
-                break;
-            case 5: /* VBSL */
-                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rd_ofs, rn_ofs, rm_ofs,
-                                    vec_size, vec_size);
-                break;
-            case 6: /* VBIT */
-                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rm_ofs, rn_ofs, rd_ofs,
-                                    vec_size, vec_size);
-                break;
-            case 7: /* VBIF */
-                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rm_ofs, rd_ofs, rn_ofs,
-                                    vec_size, vec_size);
-                break;
-            }
-            return 0;
-
         case NEON_3R_VQADD:
             tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                            rn_ofs, rm_ofs, vec_size, vec_size,
@@ -4962,6 +4925,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             return 0;
 
         case NEON_3R_VADD_VSUB:
+        case NEON_3R_LOGIC:
             /* Already handled by decodetree */
             return 1;
         }
-- 
2.20.1


