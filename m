Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B36C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB5121479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7v/fGWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB5121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38243 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkk7-0003UE-3m
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:48:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWs-0000E5-7s
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWr-0008NC-1W
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:18 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:43188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWq-0008LU-S7
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:16 -0400
Received: by mail-pg1-x52f.google.com with SMTP id z9so3580511pgu.10
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LtKlGjbuWemXwNkHto3iydMd/+NtQ4CVvCNq9/MhWAw=;
	b=d7v/fGWU6nMrGcBWXUOtp2qL57i2eB8B+FIviw3QiM3ObFsWKo1zJmiFEqer3L2T9g
	hHrpTSfbmbOR/UHguT228X9FsO5YQ5tx32ZsFgH1I1PHcSRtOCbkFcH6wrb8Saya7B+Z
	m+bS/nxvlXtKDW+1tHMrLzru5+gkcD1Fx3WW2eWxtbGfgM4TvXYNWo7RibuBhSttQUKs
	bRaQwjB/NSf7RJ0QfZdotE5/Q7MURZJS5mxC7Aiwg183VPmKChRsxgkjbI+qnnlEk//6
	JKcVTr9vEGQSkQtidgn47QJIVNlPqdn0k7UNclqGUSthfLolzpSw/k/B6E/uEOjLCdmq
	XNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=LtKlGjbuWemXwNkHto3iydMd/+NtQ4CVvCNq9/MhWAw=;
	b=FhQ9bSk913DlnIADqhEamawTEjVw5AjZVcV60QYCazH59D9mr+OlHy0+DiEQN2Dzb+
	qpRW5cHyFiFgKow63/BbPP6Ftj/sYWFddgQHZLHzFIzSiRg04F1w5E2NohfMSNYEgj+O
	BKoPU+Rf0nn8e2Nq4ezqq3oCJcdKSWVd/bMqfU6JPWcm+IzHFeLUPwjg4cslkEXrGiS4
	KC6Z3r9QOJ/6ulOcPvud3mOOYNB04XXri9u8wPYhOiEmKib/BNkYdh45KFD4zc5PUoNG
	ouWkxVP7IpWPl2vRxGXAMwVfWJlgco7clps9L1/S2toShh3zryk0W69dFzx3yMMBMIQl
	PX5w==
X-Gm-Message-State: APjAAAVFvccXcK0GcQu6ABA5Xe3WP/K6GmTUY5BVAGEvBlF0SR4lGKm4
	HBmTwdfdp7RSZxkBGMumTibVAWgm7Cg=
X-Google-Smtp-Source: APXvYqzM6kerCE9yYCBU520nEWJlT07oVEoy/Hm/1PalftDDsi4DB9YwoJB6wUDSABzYOgV35oBqwQ==
X-Received: by 2002:a63:7885:: with SMTP id t127mr7885953pgc.338.1555745715547;
	Sat, 20 Apr 2019 00:35:15 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:22 -1000
Message-Id: <20190420073442.7488-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52f
Subject: [Qemu-devel] [PATCH 18/38] tcg/i386: Support vector scalar shift
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
Message-ID: <20190420073422.blMinXZJ2_2RScDbH-JhkShC1UgjkgnF6Z7Nm81jzw0@z>

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
index 04e609c7b2..85b68e4326 100644
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
@@ -2722,6 +2730,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -2783,6 +2800,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -3163,6 +3189,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_shls_vec:
+    case INDEX_op_shrs_vec:
+    case INDEX_op_sars_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_x86_shufps_vec:
     case INDEX_op_x86_blend_vec:
@@ -3220,6 +3249,12 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
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


