Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696AEC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30AFE2072A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abAIrGDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AFE2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ83q-0004Rb-Au
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 23:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zd-0004oi-04
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zb-0008H9-Nr
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:12 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:43560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJ7zb-0008Gm-I5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:11 -0400
Received: by mail-pl1-x635.google.com with SMTP id v23so7599934ply.10
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 20:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sVWQh9CNUJ7u635QOP+H3s5ThKzTlbDf/81J3QrEWMc=;
 b=abAIrGDBGlAjvpm2YYOvX3gKhR8abmRXTe5lzZVK1+hVb36wpznzeeQc+D/nenODF8
 ukNo/c5+Cd8SALKDryLq2RwVE+MIhgQKViSnx1okcLhLE4eWGM1xCjZ434oz/RCc0qWy
 UZeEIdDYabKA8jfaLhltxG3lUKskCFqHnI7BXM7LMrsy/kSvv7Ipuhs60+r4pEltl0bV
 BK7cpzlN4YeB5+a/Ulhneb15ccTLITNV5EI1Ju4DWnp8UQSEFrNI0VFPN/kF031udfCa
 EXC7Pd3nQklulbetaZcqO3sApCddrGv+Bz81ZiAQ8k77Ai2XZ9UZ0Z8AShX+cIpkuAtQ
 jbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sVWQh9CNUJ7u635QOP+H3s5ThKzTlbDf/81J3QrEWMc=;
 b=r+F4PtObjMXNOcaryYh3yyxaSlXiYxHjE270HQCtAzI8oZqtu1HCclZ3U2v5B/41Rj
 p4muet5fsszQNf1mDdJT/mZ3fjjxgkHcQc3fS+nfGAvDfBr7W4qHAEUO7vHlI5CIBwTe
 jLH4ZvwQRfCdzU8xDM8AepotllDDWLDWWzdGGiZ5qTvoVowAvaxfgwo1Zl5zXGNRlqZG
 8MPnvoTFk2myD7EEUI2c8zgigYe9jM4sT+Wv/QStzp+D5kE97fIICPI9iOLe+D1IrtPY
 uHBWuYDw/Ln5a7JRchT05TUDmPHa47zJ+pmv65OlBf6kyafODKXnfyHf18Jd2+SdEFr6
 NgEQ==
X-Gm-Message-State: AGi0PuZkGnc1Ad3g9AlzA5DCfzUald9kSCNoLSXrpJSk/n6Ga/rvf+A7
 nCyO4fK3WSCh2ysiLt5winpTUGBKRws=
X-Google-Smtp-Source: APiQypI1/Fb8KG7jUfmSKwf4wsqkSAxL4ltHg/Y1X3/mgpk69xi7FN3ImeKVu5gsYHrLcb+VMNdFXQ==
X-Received: by 2002:a17:90a:2801:: with SMTP id
 e1mr1592143pjd.78.1585626910274; 
 Mon, 30 Mar 2020 20:55:10 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h11sm11386174pfq.56.2020.03.30.20.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 20:55:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 08/10] target/mips: Fix loongson multimedia condition
 instructions
Date: Mon, 30 Mar 2020 20:54:54 -0700
Message-Id: <20200331035456.6494-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331035456.6494-1-richard.henderson@linaro.org>
References: <20200331035456.6494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::635
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
Cc: peter.maydell@linaro.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Loongson multimedia condition instructions were previously implemented as
write 0 to rd due to lack of documentation. So I just confirmed with Loongson
about their encoding and implemented them correctly.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Acked-by: Huacai Chen <chenhc@lemote.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/translate.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d745bd2803..25b595a17d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5529,6 +5529,7 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
 {
     uint32_t opc, shift_max;
     TCGv_i64 t0, t1;
+    TCGCond cond;
 
     opc = MASK_LMI(ctx->opcode);
     switch (opc) {
@@ -5862,14 +5863,39 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
 
     case OPC_SEQU_CP2:
     case OPC_SEQ_CP2:
+        cond = TCG_COND_EQ;
+        goto do_cc_cond;
+        break;
     case OPC_SLTU_CP2:
+        cond = TCG_COND_LTU;
+        goto do_cc_cond;
+        break;
     case OPC_SLT_CP2:
+        cond = TCG_COND_LT;
+        goto do_cc_cond;
+        break;
     case OPC_SLEU_CP2:
+        cond = TCG_COND_LEU;
+        goto do_cc_cond;
+        break;
     case OPC_SLE_CP2:
-        /*
-         * ??? Document is unclear: Set FCC[CC].  Does that mean the
-         * FD field is the CC field?
-         */
+        cond = TCG_COND_LE;
+    do_cc_cond:
+        {
+            int cc = (ctx->opcode >> 8) & 0x7;
+            TCGv_i64 t64 = tcg_temp_new_i64();
+            TCGv_i32 t32 = tcg_temp_new_i32();
+
+            tcg_gen_setcond_i64(cond, t64, t0, t1);
+            tcg_gen_extrl_i64_i32(t32, t64);
+            tcg_gen_deposit_i32(fpu_fcr31, fpu_fcr31, t32,
+                                get_fp_bit(cc), 1);
+
+            tcg_temp_free_i32(t32);
+            tcg_temp_free_i64(t64);
+        }
+        goto no_rd;
+        break;
     default:
         MIPS_INVAL("loongson_cp2");
         generate_exception_end(ctx, EXCP_RI);
@@ -5878,6 +5904,7 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
 
     gen_store_fpr64(ctx, t0, rd);
 
+no_rd:
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
 }
-- 
2.20.1


