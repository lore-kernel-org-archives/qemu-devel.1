Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4DEC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 06:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66797208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 06:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCQOHQ1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66797208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40250 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQQvE-0005Qh-LH
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 02:28:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQQtq-0004eR-DH
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQQtp-0001ez-F3
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:26:54 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:42249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxL-0003Js-C9
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:07 -0400
Received: by mail-pl1-x635.google.com with SMTP id x15so7259945pln.9
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=+vy3D5n9NVcZ5Oj9MBgVyI+mUUxTaLSYcOmzMokmrqg=;
	b=mCQOHQ1HxRB1Chqk92LPRXqtYHOhcMtgWQUTpKtTDqD44VHJKY7uLHg9ZZEBAVGzp8
	hOVoqPNzXz58Ig5EuBe4JBAU80yYdVjeP6dn6LxdhVhpXHOLtQgkf0KE+YemVFAz/cqz
	KB8iVoT3XPh/WoTd61Gn123svcORt2MDgCKWXeFO5wtxb8enHf5HLPOwvDk+07IlUuzY
	jl0T2eT7K5BpvZ6lBuJCducXe0loB2cGEnwyI5Nw0MARhk6ImVBeEy42uUE6kXLzH1p8
	4ayXfF1wgU8ceVUouS7L7U4jIfIZ40b0AFOXOFASi5qfcCD5yNKSnT8oL0wQn4cIQJq2
	WdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=+vy3D5n9NVcZ5Oj9MBgVyI+mUUxTaLSYcOmzMokmrqg=;
	b=CKc05/1Ywo/bVAhHKusTxufyMlgE810P7SKoGmbJJwdshW8Af5NbdoJL+VfTnCAgC+
	g24OmqX/491JMM5SsVYuJEtuZhW07Ro/v/2WnY3KoMXTu+/5PTPWl+qh3sSdnCv8TEGn
	Uqch4NSGR7EfnIgsgNNdGOByM0KiDZJAWUThPjjUmOqnJgWsEOT+C1qbi478S/OGU3Mh
	EiU2slKhcFJ/tQoMkzS8eown31dTjnhVsifxVUng2DLGXYTsi4U+krFFlizRfOWwvBMK
	l9HM5HPeYzJH/dnoM6lh/cfRZyt77XYQwG8Q758H+bOrFRs9V45CsIOegiKg1813eMRv
	jnPQ==
X-Gm-Message-State: APjAAAVDbwSC4GoactzMUpG5i0PVdFZSfKzwIbRKlH/OU2V6qkRFxEEd
	ao81p8Zm0gOILacbRHun3QJd/SOTQXM=
X-Google-Smtp-Source: APXvYqz/U8jycTtHzNShUazkDAcqZLQBAN/HCPQUsziGlV/w4Eu1aQKDoHHvZ8NzhloXugcCZ1aeZA==
X-Received: by 2002:a17:902:20e2:: with SMTP id
	v31mr34815656plg.138.1557792364786; 
	Mon, 13 May 2019 17:06:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.06.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:06:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:25 -0700
Message-Id: <20190514000540.4313-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::635
Subject: [Qemu-devel] [PULL 16/31] tcg/i386: Support vector variable shift
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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


