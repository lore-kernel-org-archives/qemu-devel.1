Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80269C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B64A2147A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDUQcnIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B64A2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36739 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQL8t-0003Jy-HW
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:18:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQL0C-0002ws-KY
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxX-0003j0-VJ
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:08:58 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:42240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxS-0003cm-1u
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id x15so7260079pln.9
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=4RamRVLS6CpSQqwq41FPx2oK0CgrkzF+uLuaNa5g2S4=;
	b=TDUQcnIHIKt/l4ogEWDL9VlpRVwdtYntQdRFLqK3oOIjLFAUhn9KDZFpERGBuqwqk3
	FczEeVPem/MXsuwJ17mDJdM4askz29AVZ4ogQ+xH9hXpLU4GI4o3s6BYI4P5sxJm7xlK
	9ITXot/+j27JOFLVtUS+spjbFxzTmGL43wKt727Jw/gRReMssYXp3UUuvN5LZfHHULCl
	I8fLUyo5Nw7kzjxxo9EQ5uIma9jmNsVAlDufVazkgBWLIi3exPBC7pISz6U0LtZg0926
	sicHq3muxOCsJctHi6v2u0hAXiuDZOcECpgcOO5l7qF15O0HMIGgxVs1LtpMYTasqQU1
	LNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=4RamRVLS6CpSQqwq41FPx2oK0CgrkzF+uLuaNa5g2S4=;
	b=bzJqDeqecpKFeJCko5licSrWipd0WNQzMd59+qu7ttUmwLrhkqIkXP6ajClwwqF97e
	3zGKxlHSd1e0CeSSW5FyPWR/+xMuBTa+T9JyKptFOIlAc2YBoEQe6dOPjRUc/TocTIV5
	ZpPDir9gzSjqVc6ECpsZjGLFfMpMVa346NpexHEmmXFXpJFzD1jm3Z0/0O6Lp4/n6Ihd
	DgUekv7UF/Z+1oPSaW3vd5hJQ5ZbiKmaWeiEQ56Lc6eUwy80V0ECPTajUY0YoRedSDhI
	LxiD/FSLlpcYLXOsKqDxY9ierGMAf+5CkX3o1QhFJcrawvoHyFUP4xo+YOncXXdP0/Uk
	2glQ==
X-Gm-Message-State: APjAAAVU3BXUGeakKU5TqTuvAglvP5HBq+jCLZ9kO1xNV8IiFzSzJ4nm
	k7LtFLP0+hZdMClwajh5Ep698HjFwqQ=
X-Google-Smtp-Source: APXvYqz1BF6JUm7IMUNMOANAArgKbwJ2ERpGE3aRn0yuPq8+ahLMNyaGir/yu3hPxhIu6AE+JRuUqg==
X-Received: by 2002:a17:902:5ac8:: with SMTP id
	g8mr5804622plm.154.1557792371878; 
	Mon, 13 May 2019 17:06:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.06.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:06:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:31 -0700
Message-Id: <20190514000540.4313-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62b
Subject: [Qemu-devel] [PULL 22/31] tcg/i386: Support vector absolute value
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
 tcg/i386/tcg-target.inc.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 7445f05885..66f16fbe3c 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -182,7 +182,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_orc_vec          0
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_neg_vec          0
-#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          1
 #define TCG_TARGET_HAS_shv_vec          have_avx2
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 0ba1587da4..aafd01cb49 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -369,6 +369,9 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVSLQ	(0x63 | P_REXW)
 #define OPC_MOVZBL	(0xb6 | P_EXT)
 #define OPC_MOVZWL	(0xb7 | P_EXT)
+#define OPC_PABSB       (0x1c | P_EXT38 | P_DATA16)
+#define OPC_PABSW       (0x1d | P_EXT38 | P_DATA16)
+#define OPC_PABSD       (0x1e | P_EXT38 | P_DATA16)
 #define OPC_PACKSSDW    (0x6b | P_EXT | P_DATA16)
 #define OPC_PACKSSWB    (0x63 | P_EXT | P_DATA16)
 #define OPC_PACKUSDW    (0x2b | P_EXT38 | P_DATA16)
@@ -2741,6 +2744,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const sars_insn[4] = {
         OPC_UD2, OPC_PSRAW, OPC_PSRAD, OPC_UD2
     };
+    static int const abs_insn[4] = {
+        /* TODO: AVX512 adds support for MO_64.  */
+        OPC_PABSB, OPC_PABSW, OPC_PABSD, OPC_UD2
+    };
 
     TCGType type = vecl + TCG_TYPE_V64;
     int insn, sub;
@@ -2829,6 +2836,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         insn = OPC_PUNPCKLDQ;
         goto gen_simd;
 #endif
+    case INDEX_op_abs_vec:
+        insn = abs_insn[vece];
+        a2 = a1;
+        a1 = 0;
+        goto gen_simd;
     gen_simd:
         tcg_debug_assert(insn != OPC_UD2);
         if (type == TCG_TYPE_V256) {
@@ -3206,6 +3218,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dup2_vec:
 #endif
         return &x_x_x;
+    case INDEX_op_abs_vec:
     case INDEX_op_dup_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
@@ -3283,6 +3296,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_umin_vec:
     case INDEX_op_umax_vec:
         return vece <= MO_32 ? 1 : -1;
+    case INDEX_op_abs_vec:
+        return vece <= MO_32;
 
     default:
         return 0;
-- 
2.17.1


