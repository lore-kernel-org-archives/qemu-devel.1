Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E47C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F1A2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bv8+RR9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F1A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycUf-0007L4-2X
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc7A-0003go-Ge
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc79-0005t9-50
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39641)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc78-0005sF-RU
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id t16so1520224wra.6
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=H6CEmZhNUcWnGG10A1rCHrC8jo1DEeiMiR6gM4RwrlU=;
 b=bv8+RR9kIiuGqtvjQWXo420PxJfRa+cics1FOkZOSB2ACD10BxxAOwrOxDnbyiKckM
 TwwdPLpP8JDSpSdRDmyNtnTbhJKbVA0OUHORwFUIZP8CTxbly1Cga6MIBfGwsLe0XNvP
 45L7q1hq3Jjy8WRlUEp8Ie2J5F/zQ4McgGHSZncTFarJZ0iRwKEoAiJLKvVuuyP5I0VU
 JenwhQ+MM2/a3hyoNBSbvHoyqhy6IWHwMGGaSHRflxxVdwzTCcROlKakfYaQJFkC+9dE
 SJ1IE3I+4dz2BQZXMiQ8hoBd1qF3rdlWOZSMb9xQmaxmtX6Z1v8XgUq/rrlHVlPvvL9y
 q6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H6CEmZhNUcWnGG10A1rCHrC8jo1DEeiMiR6gM4RwrlU=;
 b=RRvu8GnVdDbwQNRtnE4pUNHkS8BdOMehv2tZxx95hlCyo3NNY5jLMEXymM3SquBvMb
 po6MOG1mk8rEB4lM20Q7tnYudlw2l84ay3v1Ev9bbyR/CvC8GxvBeMI66z500dcWV/Gk
 Kp4C83NhEEqkg/+Cg3z13yIzjY/YXSyt3ppgeAvUWo6uDGOJuOFnjbWksY30vZNHxdwD
 EwL7FIC93iWtBtZY5tePk1Vz84TPV5Q9ADfbTC7b7PkawW8oO9CPOoF3yNysL6eGlU+m
 yQQME6O+b+EI+yzQsIlkszfASidzs4WM/E+f82pNkgWkrrFbHX3m20akqS8U3ndst6fI
 dtvw==
X-Gm-Message-State: APjAAAU8kE/IIYi8RrYt+mv+cjO1mw/qbOLJ58Z3t6HR+oEWJxSSD+rq
 aFTdAwaVwcuRLId4l4ndiunwADUFMbSOsQ==
X-Google-Smtp-Source: APXvYqw2XgSSWP2DvLxAGGvx92o7m4qxBlq/bd/jBHZa6pr3hd7ki8QFZf2nAGi0FGLzkPVk5gdv/g==
X-Received: by 2002:a5d:4101:: with SMTP id l1mr11621845wrp.202.1565961473753; 
 Fri, 16 Aug 2019 06:17:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:19 +0100
Message-Id: <20190816131719.28244-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 29/29] target/arm: Use tcg_gen_extrh_i64_i32 to
 extract the high word
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

From: Richard Henderson <richard.henderson@linaro.org>

Separate shift + extract low will result in one extra insn
for hosts like RISC-V, MIPS, and Sparc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190808202616.13782-8-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9e2853fe76c..d9487571310 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1746,8 +1746,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
             if (insn & ARM_CP_RW_BIT) {                         /* TMRRC */
                 iwmmxt_load_reg(cpu_V0, wrd);
                 tcg_gen_extrl_i64_i32(cpu_R[rdlo], cpu_V0);
-                tcg_gen_shri_i64(cpu_V0, cpu_V0, 32);
-                tcg_gen_extrl_i64_i32(cpu_R[rdhi], cpu_V0);
+                tcg_gen_extrh_i64_i32(cpu_R[rdhi], cpu_V0);
             } else {                                    /* TMCRR */
                 tcg_gen_concat_i32_i64(cpu_V0, cpu_R[rdlo], cpu_R[rdhi]);
                 iwmmxt_store_reg(cpu_V0, wrd);
@@ -2792,8 +2791,7 @@ static int disas_dsp_insn(DisasContext *s, uint32_t insn)
         if (insn & ARM_CP_RW_BIT) {                     /* MRA */
             iwmmxt_load_reg(cpu_V0, acc);
             tcg_gen_extrl_i64_i32(cpu_R[rdlo], cpu_V0);
-            tcg_gen_shri_i64(cpu_V0, cpu_V0, 32);
-            tcg_gen_extrl_i64_i32(cpu_R[rdhi], cpu_V0);
+            tcg_gen_extrh_i64_i32(cpu_R[rdhi], cpu_V0);
             tcg_gen_andi_i32(cpu_R[rdhi], cpu_R[rdhi], (1 << (40 - 32)) - 1);
         } else {                                        /* MAR */
             tcg_gen_concat_i32_i64(cpu_V0, cpu_R[rdlo], cpu_R[rdhi]);
@@ -5990,8 +5988,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                 gen_helper_neon_narrow_high_u16(tmp, cpu_V0);
                                 break;
                             case 2:
-                                tcg_gen_shri_i64(cpu_V0, cpu_V0, 32);
-                                tcg_gen_extrl_i64_i32(tmp, cpu_V0);
+                                tcg_gen_extrh_i64_i32(tmp, cpu_V0);
                                 break;
                             default: abort();
                             }
@@ -6005,8 +6002,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                 break;
                             case 2:
                                 tcg_gen_addi_i64(cpu_V0, cpu_V0, 1u << 31);
-                                tcg_gen_shri_i64(cpu_V0, cpu_V0, 32);
-                                tcg_gen_extrl_i64_i32(tmp, cpu_V0);
+                                tcg_gen_extrh_i64_i32(tmp, cpu_V0);
                                 break;
                             default: abort();
                             }
@@ -7239,9 +7235,8 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
                 tmp = tcg_temp_new_i32();
                 tcg_gen_extrl_i64_i32(tmp, tmp64);
                 store_reg(s, rt, tmp);
-                tcg_gen_shri_i64(tmp64, tmp64, 32);
                 tmp = tcg_temp_new_i32();
-                tcg_gen_extrl_i64_i32(tmp, tmp64);
+                tcg_gen_extrh_i64_i32(tmp, tmp64);
                 tcg_temp_free_i64(tmp64);
                 store_reg(s, rt2, tmp);
             } else {
@@ -7350,8 +7345,7 @@ static void gen_storeq_reg(DisasContext *s, int rlow, int rhigh, TCGv_i64 val)
     tcg_gen_extrl_i64_i32(tmp, val);
     store_reg(s, rlow, tmp);
     tmp = tcg_temp_new_i32();
-    tcg_gen_shri_i64(val, val, 32);
-    tcg_gen_extrl_i64_i32(tmp, val);
+    tcg_gen_extrh_i64_i32(tmp, val);
     store_reg(s, rhigh, tmp);
 }
 
-- 
2.20.1


