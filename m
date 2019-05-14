Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ED0C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F3B2084F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgJgSPI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F3B2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQL3H-0005Yf-Qt
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:12:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKy5-0001d3-0u
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxS-0003da-11
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:49 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:39485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxP-0003SI-M7
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:11 -0400
Received: by mail-pg1-x535.google.com with SMTP id w22so7599205pgi.6
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=C9S5vov6bUnXU5tt0bNOV17wX7MiGxVomIsm/epCn2g=;
	b=lgJgSPI4cj87m514yI+1D1kg5grNK2HEEDQjlCKdQQVIiKdsxTY1g1BzBTVNSVQ2kb
	3tHEdM67Mjcv8wA6xwQmglVaIXZHrlwUuLDIzx+vc2bufv6zdxQhrP9LVw9IybHlSaxI
	WWXeo+qRXmXjiPVMzxjNhPPLu2Hc9hxZfGnHBTsd3hzKwiPxpHnVN2eRJ3DHWJhK6sMq
	V9XzAkUP2miaBegcqHYe/IGSxyta8TqRrRs1eEqN1kyZvOby8SWCajXZku8SezbBI+XC
	b5iQCZ4j1H1MKx4ywjBr2BU0+H+jzKiJoJ0F/ORinJirBiXoAmSUYNy0wTvAhmao7Xrq
	ILIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=C9S5vov6bUnXU5tt0bNOV17wX7MiGxVomIsm/epCn2g=;
	b=fCCuG2O/whjVxjwC8fqiysOkugyAAeFHPz5yY32HviO/fYzDHjulullJpwQeI5ZLuf
	1/TP4rOq4TbQ5PaFVPAfmiKlBS+6Xxq0lKwIaU3DtLX934zoW74g1m6BSr489D62m3PY
	T8yPnqaZSwKpDfZTXoro4L82wWJTKeJSmi2dpb407J116AsalpRx8T1hARYB082C1syw
	bacaO+6mcXh/+rcJbFXpcfeC/r1/9xShyQUXAA7UUpe87N2IkhGJo2oXknb3DZXMalaF
	I7r+KC6zP1kvQciFTs9IadUa/KJIPFVjNbE5yvoKvqNNsRpyEyu7rgkMT+i3NTc3pvOD
	HnaA==
X-Gm-Message-State: APjAAAVvl3asWUkNRrLyBxVueIYf9fZ2O/3nCW+eTSiu8FRkXxDq8R+v
	TjptABFhnlvVxBX62MGC90LYg+hrbhQ=
X-Google-Smtp-Source: APXvYqy1AlZ/x57Heq1sTOXwlaKovLtayzte18upZnQP8NKUsd8UxNxtt+CspJ9BICn8BoCD71gbPw==
X-Received: by 2002:a62:200f:: with SMTP id g15mr37037659pfg.7.1557792368589; 
	Mon, 13 May 2019 17:06:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.06.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:06:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:28 -0700
Message-Id: <20190514000540.4313-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::535
Subject: [Qemu-devel] [PULL 19/31] tcg/i386: Support vector scalar shift
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


