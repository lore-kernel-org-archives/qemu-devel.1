Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB860C47254
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98123206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Js4jBdWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98123206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaeE-0007Sp-Mw
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaIE-0001Dz-EF
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:54626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaID-0001Ie-EA
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:54 -0400
Received: by mail-wm1-x336.google.com with SMTP id h4so8231230wmb.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xEeT1kQKm2VJdMcCBAQyxewPYik69v57HfRFb5sdhOo=;
 b=Js4jBdWCKPBT63lhW6eSNPkht84nJyO5gmjxx1EeHG0Y3R2VVZfgYtXdOYwZ8Qor2G
 F3wxoV0/ZSze/8dN6j5Jl6OQfZSNpilz8CPSnh3coHNS5l9FOLUGpckIuEmhj9Jmd6p3
 ImSzd+k2AwrsmK3lptnpa3iVyf45xneAPsfltPn3GPTYwDCEolpNlIeQyp6vpQR7d9YG
 BnOeZjpNXTb0J2blyQazSZY5jZI/RioYfmkY2muCg4nwQ1c19GvVA2h8GwidHSYlmy6H
 941Bon8pTK68MQygng/TFGhYaJsQ36FmjUsXMVy43WbIO9pURd5cfr8Mtas5PvZu8RvA
 42QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xEeT1kQKm2VJdMcCBAQyxewPYik69v57HfRFb5sdhOo=;
 b=jxDv6rCoyvl3P9HFqOlePJSumcoXF0PtdQwlcLAUDVc4gxgkrP4CDUMT1wzYpCeUwp
 VGQoVedI1qYVXnFgo4KCvNHBaXfE3ZQoTSFdHGtW1VAEgBfS/PDXdJqUO890AEptCFJ9
 pNx4HTVV7bnSsKccb1Ulo1ltbTzG7/2dRJIegn6ccMbziEHnuaTUwmYemYuzYbJFcn0G
 S+DH2u66oxUP86hUzOTWzYrBl7OfNEkCAj/StkEq0t2e3wEbYqcH7JFisMcdHFMgoQaX
 huW6olohV62mWZ3/UrJwQLpeSYwA3PUuxMXHkImGItc3YGc8vEQP8h2DOlEzM/ELCKLV
 0OPQ==
X-Gm-Message-State: AGi0PuZsiOVbKjQmcdLXQH8WrriOiYW4rsM6zQ7M0mkhksXhexVlIi/t
 7h6uGQm/j4HB+xK7vfxdm9YAbTSKmofUjg==
X-Google-Smtp-Source: APiQypIuuVWbp7c0BEXkurHd7QxjruwHzXhokSRlyRPlecZOP7qEHQ0h/kR06KGXkKSt138B3S7qfQ==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr14122377wme.75.1588595631684; 
 Mon, 04 May 2020 05:33:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/39] target/arm: Convert Neon 3-reg-same comparisons to
 decodetree
Date: Mon,  4 May 2020 13:33:06 +0100
Message-Id: <20200504123309.3808-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
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

Convert the Neon comparison ops in the 3-reg-same grouping
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-18-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  8 ++++++++
 target/arm/translate-neon.inc.c | 22 ++++++++++++++++++++++
 target/arm/translate.c          | 23 +++--------------------
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index b721d39c7ba..b89ea6819a9 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -54,6 +54,11 @@ VBSL_3s          1111 001 1 0 . 01 .... .... 0001 ... 1 .... @3same_logic
 VBIT_3s          1111 001 1 0 . 10 .... .... 0001 ... 1 .... @3same_logic
 VBIF_3s          1111 001 1 0 . 11 .... .... 0001 ... 1 .... @3same_logic
 
+VCGT_S_3s        1111 001 0 0 . .. .... .... 0011 . . . 0 .... @3same
+VCGT_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 0 .... @3same
+VCGE_S_3s        1111 001 0 0 . .. .... .... 0011 . . . 1 .... @3same
+VCGE_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 1 .... @3same
+
 VMAX_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 0 .... @3same
 VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
 VMIN_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 1 .... @3same
@@ -61,3 +66,6 @@ VMIN_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 1 .... @3same
 
 VADD_3s          1111 001 0 0 . .. .... .... 1000 . . . 0 .... @3same
 VSUB_3s          1111 001 1 0 . .. .... .... 1000 . . . 0 .... @3same
+
+VTST_3s          1111 001 0 0 . .. .... .... 1000 . . . 1 .... @3same
+VCEQ_3s          1111 001 1 0 . .. .... .... 1000 . . . 1 .... @3same
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index ab1740201c4..952e4456f5e 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -631,3 +631,25 @@ DO_3SAME_NO_SZ_3(VMAX_S, tcg_gen_gvec_smax)
 DO_3SAME_NO_SZ_3(VMAX_U, tcg_gen_gvec_umax)
 DO_3SAME_NO_SZ_3(VMIN_S, tcg_gen_gvec_smin)
 DO_3SAME_NO_SZ_3(VMIN_U, tcg_gen_gvec_umin)
+
+#define DO_3SAME_CMP(INSN, COND)                                        \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        tcg_gen_gvec_cmp(COND, vece, rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz); \
+    }                                                                   \
+    DO_3SAME_NO_SZ_3(INSN, gen_##INSN##_3s)
+
+DO_3SAME_CMP(VCGT_S, TCG_COND_GT)
+DO_3SAME_CMP(VCGT_U, TCG_COND_GTU)
+DO_3SAME_CMP(VCGE_S, TCG_COND_GE)
+DO_3SAME_CMP(VCGE_U, TCG_COND_GEU)
+DO_3SAME_CMP(VCEQ, TCG_COND_EQ)
+
+static void gen_VTST_3s(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                         uint32_t rm_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &cmtst_op[vece]);
+}
+DO_3SAME_NO_SZ_3(VTST, gen_VTST_3s)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2f054cfa783..0e6ecc0969a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4879,26 +4879,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                            u ? &mls_op[size] : &mla_op[size]);
             return 0;
 
-        case NEON_3R_VTST_VCEQ:
-            if (u) { /* VCEQ */
-                tcg_gen_gvec_cmp(TCG_COND_EQ, size, rd_ofs, rn_ofs, rm_ofs,
-                                 vec_size, vec_size);
-            } else { /* VTST */
-                tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
-                               vec_size, vec_size, &cmtst_op[size]);
-            }
-            return 0;
-
-        case NEON_3R_VCGT:
-            tcg_gen_gvec_cmp(u ? TCG_COND_GTU : TCG_COND_GT, size,
-                             rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
-            return 0;
-
-        case NEON_3R_VCGE:
-            tcg_gen_gvec_cmp(u ? TCG_COND_GEU : TCG_COND_GE, size,
-                             rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
-            return 0;
-
         case NEON_3R_VSHL:
             /* Note the operation is vshl vd,vm,vn */
             tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs, vec_size, vec_size,
@@ -4909,6 +4889,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_LOGIC:
         case NEON_3R_VMAX:
         case NEON_3R_VMIN:
+        case NEON_3R_VTST_VCEQ:
+        case NEON_3R_VCGT:
+        case NEON_3R_VCGE:
             /* Already handled by decodetree */
             return 1;
         }
-- 
2.20.1


