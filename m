Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0EACA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A67206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGmcPMrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A67206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXxZ-0008Ta-Ef
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXw3-0006I5-94
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:15 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXw2-00065I-8X
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id l17so2743785wrr.4
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WtBRFIcGQ2KxMUWXVFcqCaZ+mGBUmkZ1KykSMd1Jqr0=;
 b=CGmcPMrmum9dYuvevGAaPmNjyPDB3XyeQIuBKnOAj7JCRre1cSXtc54r/k/gpJhES8
 l3Rn1K3GHUlkLKwzlq7m9s9ZMx6cxs/Mf5uTWSWC+TgO/RAZe7/c8VCeC+pM8aglhsx9
 ra6Rl+HgP9ZYgETZcs9mrHDOlRwXomWmDME2Ymf0zpcp2bWqZE21kBWxO/TdHJCSaiIS
 qqHN3kb82tUv5tYBEb4WPBLQOs4P+jIuXnbaw88HcC+QgoCCp4j3ebwlnFhDIBx2gpaa
 DIWa8WN3tBlk5NflG+GH/qrWC4z5yn3AZGEa0D8MJkKlYHAaB800fcJaAFZUDFb4Foux
 2FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WtBRFIcGQ2KxMUWXVFcqCaZ+mGBUmkZ1KykSMd1Jqr0=;
 b=P7CLkWvOUzhq7Yq7mymr5/jFbWh30QJ4j/wmohhAwCPGsbQQQL4mdpgfkHDaeB1Rty
 gWGyy9ZQVR6AjLEd1vvFI/V1SnbzXUr+9ISjXzMOXdaKT1kIgPw1ujteRcqb+HbZToGu
 Bwixh8KOcX7x9J8Z1RuhXxnPf1Nql74KQC1+V3ZJgyqgukS0BJwdQgauRBVFGeG4vXNA
 Lko0AxcBBgLjgrodt3Jbe/084lU35U1FojrDo3aPSFHv72shkPmcPuRyzGd20IRz4LT8
 bptVBHhvnNb4p72TVOX2ZYBX6qgzk7XfeFYWiMHoqtduOcmsfESg1tNH7aHKjRCUmSWi
 fciA==
X-Gm-Message-State: AGi0Pub2mxEZ2FgkWCjiElzCdSF0WZY28DOfw/IKS4jbnm++prJFD24X
 51qhqBXOcPuQgFU0bIPCUU46Yw==
X-Google-Smtp-Source: APiQypLhjw4yDnQ2w2m+Au0zpx/8rslNYwU4d4u25Fsy+LPNYtVYa38GJzN1QWLyP4lfE1f/7a16RQ==
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr18466923wrh.116.1589301552922; 
 Tue, 12 May 2020 09:39:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o205sm18525981wmo.32.2020.05.12.09.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:39:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 04/17] target/arm: Convert Neon VHADD 3-reg-same insns
Date: Tue, 12 May 2020 17:38:51 +0100
Message-Id: <20200512163904.10918-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512163904.10918-1-peter.maydell@linaro.org>
References: <20200512163904.10918-1-peter.maydell@linaro.org>
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

Convert the Neon VHADD insns in the 3-reg-same group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  2 ++
 target/arm/translate-neon.inc.c | 24 ++++++++++++++++++++++++
 target/arm/translate.c          |  4 +---
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index fe649038547..3432aacfe90 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -42,6 +42,8 @@
 @3same           .... ... . . . size:2 .... .... .... . q:1 . . .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
 
+VHADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 0 .... @3same
+VHADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 0 .... @3same
 VQADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 1 .... @3same
 VQADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 1 .... @3same
 
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 05c6dcdc9b9..0418a84a7de 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -849,3 +849,27 @@ DO_3SAME_64_ENV(VQSHL_S64, gen_helper_neon_qshl_s64)
 DO_3SAME_64_ENV(VQSHL_U64, gen_helper_neon_qshl_u64)
 DO_3SAME_64_ENV(VQRSHL_S64, gen_helper_neon_qrshl_s64)
 DO_3SAME_64_ENV(VQRSHL_U64, gen_helper_neon_qrshl_u64)
+
+#define DO_3SAME_32(INSN, FUNC)                                         \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        static const GVecGen3 ops[4] = {                                \
+            { .fni4 = gen_helper_neon_##FUNC##8 },                      \
+            { .fni4 = gen_helper_neon_##FUNC##16 },                     \
+            { .fni4 = gen_helper_neon_##FUNC##32 },                     \
+            { 0 },                                                      \
+        };                                                              \
+        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &ops[vece]); \
+    }                                                                   \
+    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        if (a->size > 2) {                                              \
+            return false;                                               \
+        }                                                               \
+        return do_3same(s, a, gen_##INSN##_3s);                         \
+    }
+
+DO_3SAME_32(VHADD_S, hadd_s)
+DO_3SAME_32(VHADD_U, hadd_u)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1ce3e182867..8d856ccfe96 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5454,6 +5454,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VML:
         case NEON_3R_VSHL:
         case NEON_3R_SHA:
+        case NEON_3R_VHADD:
             /* Already handled by decodetree */
             return 1;
         }
@@ -5534,9 +5535,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tmp2 = neon_load_reg(rm, pass);
         }
         switch (op) {
-        case NEON_3R_VHADD:
-            GEN_NEON_INTEGER_OP(hadd);
-            break;
         case NEON_3R_VRHADD:
             GEN_NEON_INTEGER_OP(rhadd);
             break;
-- 
2.20.1


