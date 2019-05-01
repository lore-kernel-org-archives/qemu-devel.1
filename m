Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C75BC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CCA2081C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPNiRrYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CCA2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36458 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhii-0004I8-3H
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:23:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRZ-0006YI-BL
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRV-0002wU-KD
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:09 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:44318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRT-0002vP-Sx
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:04 -0400
Received: by mail-pf1-x42e.google.com with SMTP id y13so8131579pfm.11
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=+vy3D5n9NVcZ5Oj9MBgVyI+mUUxTaLSYcOmzMokmrqg=;
	b=oPNiRrYepa1vkZOy7NCmvfNcxpTTnVUmlpKjD2CacgHuC9+F+niucdvnZ3N2/0ZjHk
	CghQkki3jy2DoEtb3fWj3YVUAUp1jA7ribj/+Em07+WtvuPSVFT5lGI4hABQa75YZ6G3
	40D3E3+P9X3KBbzAilzXRIYB9FlBVuotbWITASbDv8avwp+RgdWcG0XJvQ9r/2n+NFM5
	JgpV9HY52FVtbO3km4/PqgRHQahDv+qOIC4aWepTZWCcsEWmezFCF8l01VPcR7Fg7ZQN
	aNnr9DHnVnF7sp5ZvjtKyCXgtR/kBK46whbk6r3vGQeIOfdBvH7Xh1OCr2REP+8yXsSR
	LrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=+vy3D5n9NVcZ5Oj9MBgVyI+mUUxTaLSYcOmzMokmrqg=;
	b=IH0yGM0X8OFePJf//QZRaaF98WXRxA664Lfnrg5U4D/FycjmfIedZEmU44EJcLtpwY
	pmoC83FUZfBHnzwqdJYiJdgzYChBL37omLsHjb82aJ3rs+FxSQaVR5GkclzFKTWhZt1a
	sg1Q4f9MUHmPQYh7r8uAvW2z6wOu9pYU4TYniFP9aQZUDrNjoRMVkAiR4CjcfiNx1oG0
	//l++Elrq0IqHILdcvkugiM1UPeE6uAx3TUpSiTpne6lgi/ZT9eUAW5sO+msoRPR0zvF
	U1DqM3ZsTgloYOTtjOAyJnHtPakWnZbmUiEqQB6bQSjFv6ldJcCjVn2ucU0YIX93EubF
	BcrA==
X-Gm-Message-State: APjAAAUdXc5un+X9kaZf7frIXN+zSIReHRujJZSWItmaep+zjcDxnOMT
	Brjj2KvaCXIYrDQiFgBiocFXisAbriY=
X-Google-Smtp-Source: APXvYqwrV32s9o7Sze/WD8bWwgu6tWGNbJSor2DVWsg8O5bEBc7OsyY5oGpInPW3EOoHet2mByq88A==
X-Received: by 2002:a63:ff05:: with SMTP id k5mr59148047pgi.342.1556687162256; 
	Tue, 30 Apr 2019 22:06:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.06.01 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:06:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:22 -0700
Message-Id: <20190501050536.15580-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42e
Subject: [Qemu-devel] [PATCH v2 15/29] tcg/i386: Support vector variable
 shift opcodes
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501050522.9yLNn8hdXAxWJf_rsHdau2egolyNsPBOsuKrPh1pdy0@z>

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
index 5b33bbd99b..c9448b6d84 100644
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
 
@@ -2707,6 +2712,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -2759,6 +2776,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -3136,6 +3162,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_umin_vec:
     case INDEX_op_smax_vec:
     case INDEX_op_umax_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_x86_shufps_vec:
     case INDEX_op_x86_blend_vec:
@@ -3193,6 +3222,12 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
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


