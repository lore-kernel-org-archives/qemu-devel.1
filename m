Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ADDC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610062173C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zTL5AmxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610062173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvp2J-0005i5-NP
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 16:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59929)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozW-0007Jb-HK
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozV-0001M1-Cs
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:30 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvozV-0001LH-7i
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:29 -0400
Received: by mail-pg1-x541.google.com with SMTP id w10so44637956pgj.7
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 13:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AcVFjfcusS5dLWT70g3h9t3XMQa4NwJ2WZoNCoEA3tk=;
 b=zTL5AmxUG1HAJtBxREkWCohQIuU5e/eWoOKXPgWm7cdi0Cbss+jzaqR6Cg1inkf3SO
 sq2EDEt4l/rv1s2oe38z8PvIGuDlQzmmbCBBA6QzAG9SefWWPADeq1INm7dLYBdJX4HC
 vBG4ppvGAaHNRbitrkMJ4PvW+990yBCMyS8loSTnCkZ1z+9ebmINaItqXl1bBP2Qi+mN
 DMKzOIJ8TvW7ga4DCdH8KgiLAcNKqv/vZ/vUtdOF5Uz3uyAdgLZw+Qgi0ri5JfkejdpF
 Bif9+rNE+1wwVHlzmHM0IihBf+GGLDXnhAl5a+NZvLtkTPXkKuNpdhyoeprGe7H9E+eZ
 GSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AcVFjfcusS5dLWT70g3h9t3XMQa4NwJ2WZoNCoEA3tk=;
 b=hSjucfHX2XqerOs9pAViNjSAcDM3CDZ9zW6Nx5OgDx3tU2BsAek1y15N9c+AiaXOnn
 LZtMGA+bH9nKZX+k9nxAond842CYyODOu0XXiowtm/WGyILMjIveD2FpOT0sKBCFuXbY
 J/0s4vMF0JGwg8qAvMpXgs4wB5DmZZ4VUoYXvjNar8OftGqGHDQITEMokVtf4+BgmDHA
 zHitYvyng/34g+X47etWsTPjPZSj+ImIXTsO8bMuKTUr7KRp4xpg1W+fT14WCu58T/Um
 6ZWy7nOnWgHY20XUE2rDcki/zJDGRJ0tgTZNUuK0xtphjku/9lnsvM400oO3wHO0Ww8k
 KWhw==
X-Gm-Message-State: APjAAAXpOn4pI/iOEvhPVi/HAH8/ZEQpu6x0NNnECSRy48K+EZUas9Tx
 e3ksxI0kmhyhCoYqqZ/Sswz55o1SJQg=
X-Google-Smtp-Source: APXvYqx088HeJxF82vXyFaLKETFEBxPPvjb49mIQDVxDs3bQLjcHrTZXfQq0DIXxqhxFIV0qWBIbrg==
X-Received: by 2002:aa7:8b51:: with SMTP id i17mr17664848pfd.33.1565295987980; 
 Thu, 08 Aug 2019 13:26:27 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v12sm2850146pjk.13.2019.08.08.13.26.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 13:26:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 13:26:16 -0700
Message-Id: <20190808202616.13782-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190808202616.13782-1-richard.henderson@linaro.org>
References: <20190808202616.13782-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 7/7] target/arm: Use tcg_gen_extrh_i64_i32 to
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Separate shift + extract low will result in one extra insn
for hosts like RISC-V, MIPS, and Sparc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 77154be743..9e103e4fad 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1761,8 +1761,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
             if (insn & ARM_CP_RW_BIT) {                         /* TMRRC */
                 iwmmxt_load_reg(cpu_V0, wrd);
                 tcg_gen_extrl_i64_i32(cpu_R[rdlo], cpu_V0);
-                tcg_gen_shri_i64(cpu_V0, cpu_V0, 32);
-                tcg_gen_extrl_i64_i32(cpu_R[rdhi], cpu_V0);
+                tcg_gen_extrh_i64_i32(cpu_R[rdhi], cpu_V0);
             } else {                                    /* TMCRR */
                 tcg_gen_concat_i32_i64(cpu_V0, cpu_R[rdlo], cpu_R[rdhi]);
                 iwmmxt_store_reg(cpu_V0, wrd);
@@ -2807,8 +2806,7 @@ static int disas_dsp_insn(DisasContext *s, uint32_t insn)
         if (insn & ARM_CP_RW_BIT) {                     /* MRA */
             iwmmxt_load_reg(cpu_V0, acc);
             tcg_gen_extrl_i64_i32(cpu_R[rdlo], cpu_V0);
-            tcg_gen_shri_i64(cpu_V0, cpu_V0, 32);
-            tcg_gen_extrl_i64_i32(cpu_R[rdhi], cpu_V0);
+            tcg_gen_extrh_i64_i32(cpu_R[rdhi], cpu_V0);
             tcg_gen_andi_i32(cpu_R[rdhi], cpu_R[rdhi], (1 << (40 - 32)) - 1);
         } else {                                        /* MAR */
             tcg_gen_concat_i32_i64(cpu_V0, cpu_R[rdlo], cpu_R[rdhi]);
@@ -6005,8 +6003,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                 gen_helper_neon_narrow_high_u16(tmp, cpu_V0);
                                 break;
                             case 2:
-                                tcg_gen_shri_i64(cpu_V0, cpu_V0, 32);
-                                tcg_gen_extrl_i64_i32(tmp, cpu_V0);
+                                tcg_gen_extrh_i64_i32(tmp, cpu_V0);
                                 break;
                             default: abort();
                             }
@@ -6020,8 +6017,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                 break;
                             case 2:
                                 tcg_gen_addi_i64(cpu_V0, cpu_V0, 1u << 31);
-                                tcg_gen_shri_i64(cpu_V0, cpu_V0, 32);
-                                tcg_gen_extrl_i64_i32(tmp, cpu_V0);
+                                tcg_gen_extrh_i64_i32(tmp, cpu_V0);
                                 break;
                             default: abort();
                             }
@@ -7254,9 +7250,8 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
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
@@ -7365,8 +7360,7 @@ static void gen_storeq_reg(DisasContext *s, int rlow, int rhigh, TCGv_i64 val)
     tcg_gen_extrl_i64_i32(tmp, val);
     store_reg(s, rlow, tmp);
     tmp = tcg_temp_new_i32();
-    tcg_gen_shri_i64(val, val, 32);
-    tcg_gen_extrl_i64_i32(tmp, val);
+    tcg_gen_extrh_i64_i32(tmp, val);
     store_reg(s, rhigh, tmp);
 }
 
-- 
2.17.1


