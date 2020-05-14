Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C258C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3EC205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9OZUpKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3EC205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZF2g-0004gv-Bt
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEki-0003gK-S4
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:24 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:33568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkh-0005zp-Sb
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:24 -0400
Received: by mail-wr1-x42b.google.com with SMTP id l11so4405851wru.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OqBsQrFfPdlz6CK7gP+vWBXO/E1AFqNNicfObysyTjY=;
 b=o9OZUpKuob8DVxxop53b0vWPMvG0V8faawq3l1PElWfylZ2Q7OZ5jgxlUDW2kwh+3R
 zTOf4+ZSp0Wz1FHx03KD5eZCy6lM4Y/PqUBnfWV4Znw0n13VEpuXMiegVBSYM6Sgm9mg
 ga+TFZfHyEaTrh4vG0r9+O91rxHwRmuffRXzawDBNci2ICWXtIetbW/KS5xFTlENvob0
 zvI3Qdpme8iuBgaoUi2YgzOSRoCRfoMbMTA1yFev5tordUXRqhYCwjieyAXWelxlX9m5
 6PoIHg7p3NlgwUpBKwS3jiEgRZBVqt6zTHkLbHLEaMrtvnVkcyahDwQPde+Z/gTLIa6+
 NdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OqBsQrFfPdlz6CK7gP+vWBXO/E1AFqNNicfObysyTjY=;
 b=pgz/BZ+uo3Im4EJiP1VqaYnyXTbY7LVAzbjqPprRa5Bkywl0xjPe0RY/+l92PO5YKs
 SmeB31TupRI2xMWwqjoD/4mtIPSccH7C+Q5pk9m+IeOCazc1XgXI9qriY/VhNzmBT4ll
 yFuEdyowUjp5YWnqUCGEIEBXgnOGFK9geWGfjmMKHQ/yfrlAUQ4zlIf/XYwdvG0LmjKx
 TJzbeR4OP4RjEqqb8tOyCG0aHotk3rE/p2cIlbaEcyh3EEaOV94U1ZyD9xvTCG6ry+ER
 925VOXpNKPL3PD9NhbnA7GNILNAU4Cft0Unf1Vmd0EUluQejmt3476WueqK9DJD1C+I6
 jIig==
X-Gm-Message-State: AOAM533aLgESEs0xhPmflEKrt8TPcieArlvhX+1nXDJOQnwQi0sTG09w
 BlZuwdtkXt+W7qsk3ISLvbng7bMzezoKCg==
X-Google-Smtp-Source: ABdhPJy15alaZPDDuticnEeaB8Af5EBs+e8NASL8X2DPTRG1Q3ihU6lTpRhtDuLJ/swvH6kKYnv4HA==
X-Received: by 2002:adf:fdc5:: with SMTP id i5mr2413237wrs.176.1589466142076; 
 Thu, 14 May 2020 07:22:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/45] target/arm: Convert Neon VHADD 3-reg-same insns
Date: Thu, 14 May 2020 15:21:25 +0100
Message-Id: <20200514142138.20875-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Convert the Neon VHADD insns in the 3-reg-same group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-5-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  2 ++
 target/arm/translate-neon.inc.c | 24 ++++++++++++++++++++++++
 target/arm/translate.c          |  4 +---
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index fa52b998e87..8120d8d5f2d 100644
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


