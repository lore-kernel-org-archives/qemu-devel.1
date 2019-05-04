Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014F3C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10B620675
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UN8b35af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10B620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51747 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnmI-0007hv-SP
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:04:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbz-0007wJ-Hf
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnby-0004NF-DO
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:27 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:33671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnby-0004N0-79
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:26 -0400
Received: by mail-pl1-x633.google.com with SMTP id y3so3740368plp.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=C9S5vov6bUnXU5tt0bNOV17wX7MiGxVomIsm/epCn2g=;
	b=UN8b35afLcCW4+U6WFWYWS6mnrnER2Q22JrnKlEtNVtCwMbVIm46AVxMB8WuIijfxC
	x952hvpGs4LGsHnMys6JnFqOUpYgXNA1+lSwxsnBli1b4ue1bR4w7r2fPQHTo7W9vvKL
	s2sDIFkmIuNJd11pjayIFaNez91Q4Sl5Hhf7BWMHoxjka0aeZxres+xH9bBrXjhGj+IT
	A4k26ordQRG8H5w+guzILuFbBGgzvneSQc1DjefJfDjdkNub7jhVDiyDdkQAp6mhgN+2
	QgEwLe5WQm2PHgZTdaP1lnpXAvZ2RMQWr5GgtvyB7JlAj6kxyVX8nadMcM4CzQ+5dKWu
	rZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=C9S5vov6bUnXU5tt0bNOV17wX7MiGxVomIsm/epCn2g=;
	b=VI/x9EQjl+fBZlSlD4GOWQBHhFESGp5AvdJkJIZ2eSfTFo8INl9Mu8SS118Paf+Xmu
	BXK5dLMX6eIOnlrIARPU+wbWu0jYVX3NDEYOT1nluqfVR0rqZFgh8un8fkHzsaiGXYPD
	tPxwg86i0XlkirgNjUQC9iEJcaynUV5woc8QD8P4W6g/PLZrmDJ5ms1nvEAbC/iFfnPl
	Pngj2KurS9qZmB9voh7PFjkQEucxJRQ80W54qHk4ijiiiusYYP4L2gh++YkfZA+ZqaPs
	HjziuDTXKrWTpvtXm3lzgZk8MRUr7iIyQSXcqg9JQBhFzUV6h3AcoX00hFaUOcPvdP1w
	d7Wg==
X-Gm-Message-State: APjAAAXYLR2f4rN5IA9+RCRgy2XnHu2nT6Ygl15vvxEYzLgyb1BeiWH5
	hoX5lMOSWAT9128j+aPs2tEJTo4JLTU=
X-Google-Smtp-Source: APXvYqzLOZ1zv2n3KhLiqyOG2Bi6IyJQBGPhVijBDbSseGz2RFZtmRIuDQWe/cmsAYPqKvi2lud4NQ==
X-Received: by 2002:a17:902:8bca:: with SMTP id
	r10mr16274860plo.67.1556949204966; 
	Fri, 03 May 2019 22:53:24 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:48 -0700
Message-Id: <20190504055300.18426-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::633
Subject: [Qemu-devel] [PATCH v3 19/31] tcg/i386: Support vector scalar shift
 opcodes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504055248.0jv92QiZaSopvdomoGFVHgy13C4t-nj3wc8AbIOWMVo@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.inc.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index b240633455..618aa520d2 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -183,7 +183,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_shi_vec          1
-#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shs_vec          1
 #define TCG_TARGET_HAS_shv_vec          have_avx2
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index c9448b6d84..0ba1587da4 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -420,6 +420,14 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_PSHIFTW_Ib  (0x71 | P_EXT | P_DATA16) /* /2 /6 /4 */
 #define OPC_PSHIFTD_Ib  (0x72 | P_EXT | P_DATA16) /* /2 /6 /4 */
 #define OPC_PSHIFTQ_Ib  (0x73 | P_EXT | P_DATA16) /* /2 /6 /4 */
+#define OPC_PSLLW       (0xf1 | P_EXT | P_DATA16)
+#define OPC_PSLLD       (0xf2 | P_EXT | P_DATA16)
+#define OPC_PSLLQ       (0xf3 | P_EXT | P_DATA16)
+#define OPC_PSRAW       (0xe1 | P_EXT | P_DATA16)
+#define OPC_PSRAD       (0xe2 | P_EXT | P_DATA16)
+#define OPC_PSRLW       (0xd1 | P_EXT | P_DATA16)
+#define OPC_PSRLD       (0xd2 | P_EXT | P_DATA16)
+#define OPC_PSRLQ       (0xd3 | P_EXT | P_DATA16)
 #define OPC_PSUBB       (0xf8 | P_EXT | P_DATA16)
 #define OPC_PSUBW       (0xf9 | P_EXT | P_DATA16)
 #define OPC_PSUBD       (0xfa | P_EXT | P_DATA16)
@@ -2724,6 +2732,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         /* TODO: AVX512 adds support for MO_16, MO_64.  */
         OPC_UD2, OPC_UD2, OPC_VPSRAVD, OPC_UD2
     };
+    static int const shls_insn[4] = {
+        OPC_UD2, OPC_PSLLW, OPC_PSLLD, OPC_PSLLQ
+    };
+    static int const shrs_insn[4] = {
+        OPC_UD2, OPC_PSRLW, OPC_PSRLD, OPC_PSRLQ
+    };
+    static int const sars_insn[4] = {
+        OPC_UD2, OPC_PSRAW, OPC_PSRAD, OPC_UD2
+    };
 
     TCGType type = vecl + TCG_TYPE_V64;
     int insn, sub;
@@ -2785,6 +2802,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sarv_vec:
         insn = sarv_insn[vece];
         goto gen_simd;
+    case INDEX_op_shls_vec:
+        insn = shls_insn[vece];
+        goto gen_simd;
+    case INDEX_op_shrs_vec:
+        insn = shrs_insn[vece];
+        goto gen_simd;
+    case INDEX_op_sars_vec:
+        insn = sars_insn[vece];
+        goto gen_simd;
     case INDEX_op_x86_punpckl_vec:
         insn = punpckl_insn[vece];
         goto gen_simd;
@@ -3165,6 +3191,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_shls_vec:
+    case INDEX_op_shrs_vec:
+    case INDEX_op_sars_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_x86_shufps_vec:
     case INDEX_op_x86_blend_vec:
@@ -3222,6 +3251,12 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
         }
         return 1;
 
+    case INDEX_op_shls_vec:
+    case INDEX_op_shrs_vec:
+        return vece >= MO_16;
+    case INDEX_op_sars_vec:
+        return vece >= MO_16 && vece <= MO_32;
+
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
         return have_avx2 && vece >= MO_32;
-- 
2.17.1


