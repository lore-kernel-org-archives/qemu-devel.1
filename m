Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EC6C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4554721479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ASW0F1Fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4554721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38295 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkm1-00058w-Bi
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:50:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWj-00005s-39
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWi-00084i-1l
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:09 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWh-00083F-Rt
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:07 -0400
Received: by mail-pf1-x444.google.com with SMTP id b3so3480564pfd.1
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=F1de5So3vFDWwHAWVYAQ29uD+09yUtcwgv6kBjYxLtM=;
	b=ASW0F1FbKt3Bq1COddmbp3oVZcJN2FNaQNqVewjp9+KYNX4Vg4voLCqr1DJG8H2qzK
	rn//YW51aZyO6RUEzkgWx6p+I65oUrOIZIyaBtvztJV8Id3JzZdM6+S3SIOh1pIJtVai
	taXs6nS8RZ5JZRO/JRSPVbT97Lgc/yD9LGPWMHuUbblNXR8QrGDvU0KaOvWJZzbVcW5T
	yvUAgCcboGKxg2Khqh5Wz0GX1Pw353l1046eidxslnpyopaOiAqPCJdv3IjMzt3tS6Y2
	OfGbDgUhDg/p0w2dGtfYKj8EZgXOC3xgrL/4fqerdmvQel9PIR+n5LTJx5kjeo4hz35h
	nQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=F1de5So3vFDWwHAWVYAQ29uD+09yUtcwgv6kBjYxLtM=;
	b=c/cVH3JP+jCRAEhmK13E4G0uGcudZCFO3YA7jiKsXaHpHEybvcgp4HyLMFSFAo+Ubk
	1XXLPivEeqwiKCTqupnaHLuOnJ0FxudCQd12fsyJsSrA0XZQEBDsV7LHCG9FlnIhYBoP
	bXLTFvcqdVOVWRn3wuRaoZZLlUY1/5nKMt7c5D7I4qsKGZyp9HzDShZhuSMD3KhtaINJ
	G9Cg1ONKxKoxZJecePDnNvbV9EcYtv127G1ehvosXaQ2aZs4a/mb+eSI83P/aTpGcIn2
	C5TbnCaTN37O4a8XB/02tjla6lwkDERTKio+iXhPMIrXl4vCEJlGc2K6f61xAt8Npu2w
	xiPA==
X-Gm-Message-State: APjAAAWcXUpVIpxfGdSyVIk/db/TdlN6Dgwj77cIheXDw5yAml2FqHtZ
	UAYmlCMMzoa2dRcziIdC0GicnSqSoqs=
X-Google-Smtp-Source: APXvYqxEraO7aRcg5SPlK1jetffmZ2O0DPFwZiu9+M1EhDnWgvQnnaJ3e1VM0KBW9AwNHZCrHFbODg==
X-Received: by 2002:a05:6a00:dc:: with SMTP id
	e28mr8433637pfj.186.1555745706468; 
	Sat, 20 Apr 2019 00:35:06 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:17 -1000
Message-Id: <20190420073442.7488-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 13/38] tcg/i386: Support vector variable shift
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073417.CJblDRDiDDtDY0_qJccVN5DMgQYvTs0iQtS-obLzc-w@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.inc.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 241bf19413..b240633455 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -184,7 +184,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_shv_vec          have_avx2
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 4c42a2430d..04e609c7b2 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -467,6 +467,11 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_VPBROADCASTQ (0x59 | P_EXT38 | P_DATA16)
 #define OPC_VPERMQ      (0x00 | P_EXT3A | P_DATA16 | P_REXW)
 #define OPC_VPERM2I128  (0x46 | P_EXT3A | P_DATA16 | P_VEXL)
+#define OPC_VPSLLVD     (0x47 | P_EXT38 | P_DATA16)
+#define OPC_VPSLLVQ     (0x47 | P_EXT38 | P_DATA16 | P_REXW)
+#define OPC_VPSRAVD     (0x46 | P_EXT38 | P_DATA16)
+#define OPC_VPSRLVD     (0x45 | P_EXT38 | P_DATA16)
+#define OPC_VPSRLVQ     (0x45 | P_EXT38 | P_DATA16 | P_REXW)
 #define OPC_VZEROUPPER  (0x77 | P_EXT)
 #define OPC_XCHG_ax_r32	(0x90)
 
@@ -2705,6 +2710,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const umax_insn[4] = {
         OPC_PMAXUB, OPC_PMAXUW, OPC_PMAXUD, OPC_UD2
     };
+    static int const shlv_insn[4] = {
+        /* TODO: AVX512 adds support for MO_16.  */
+        OPC_UD2, OPC_UD2, OPC_VPSLLVD, OPC_VPSLLVQ
+    };
+    static int const shrv_insn[4] = {
+        /* TODO: AVX512 adds support for MO_16.  */
+        OPC_UD2, OPC_UD2, OPC_VPSRLVD, OPC_VPSRLVQ
+    };
+    static int const sarv_insn[4] = {
+        /* TODO: AVX512 adds support for MO_16, MO_64.  */
+        OPC_UD2, OPC_UD2, OPC_VPSRAVD, OPC_UD2
+    };
 
     TCGType type = vecl + TCG_TYPE_V64;
     int insn, sub;
@@ -2757,6 +2774,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_umax_vec:
         insn = umax_insn[vece];
         goto gen_simd;
+    case INDEX_op_shlv_vec:
+        insn = shlv_insn[vece];
+        goto gen_simd;
+    case INDEX_op_shrv_vec:
+        insn = shrv_insn[vece];
+        goto gen_simd;
+    case INDEX_op_sarv_vec:
+        insn = sarv_insn[vece];
+        goto gen_simd;
     case INDEX_op_x86_punpckl_vec:
         insn = punpckl_insn[vece];
         goto gen_simd;
@@ -3134,6 +3160,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_umin_vec:
     case INDEX_op_smax_vec:
     case INDEX_op_umax_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_x86_shufps_vec:
     case INDEX_op_x86_blend_vec:
@@ -3191,6 +3220,12 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
         }
         return 1;
 
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+        return have_avx2 && vece >= MO_32;
+    case INDEX_op_sarv_vec:
+        return have_avx2 && vece == MO_32;
+
     case INDEX_op_mul_vec:
         if (vece == MO_8) {
             /* We can expand the operation for MO_8.  */
-- 
2.17.1


