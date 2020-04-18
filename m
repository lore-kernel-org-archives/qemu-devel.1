Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DD9C38A2F
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153CF2076A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6bMv3zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153CF2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPp2K-00009w-4u
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 11:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPp12-000752-62
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPp10-00034Z-SU
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:20 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPp10-0002zt-Mq
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:18 -0400
Received: by mail-pl1-x642.google.com with SMTP id k18so2150947pll.6
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=weSa2Q8xnocg4w6MPGqPbS35FDoC38Z4xsrq7F4gNiQ=;
 b=i6bMv3znncAiRQ13CGtxAopsQubXS9ztyWPGXYdrTaZoUiyvX9g+JFbMuxlUE5Hsd0
 WAV/2hfxdOZ8+mnvSAWwc3YrEtZ8xIXt4zQL0HUA9Nioc5drs4vLd9oQwg0XJWWyPjnP
 fFtpvArEwAnEHUPuGXOUiZGjWYQK+c5cs14LSr65hbt01M0WC2BNMX1DRYZKSWcB8Jhw
 i2f5O/M0ShP5dOynYUt+bVKzTW6CvnmkiD8gO80oq1pqRLUqZecXjCMlJPtbsD/cN57T
 yxpO3qsOOPQOhyGCaGvafj8fMsiFp3FaodzryzRx6Dmp0CJLX7LekSuoHy+hgCWYv9yC
 uGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=weSa2Q8xnocg4w6MPGqPbS35FDoC38Z4xsrq7F4gNiQ=;
 b=bg1to5TuNXx3XWp9ssoqKB4EYq5iEtZABddFv2Y2upO8cgxTK7HbQKPACTbWOzZe5a
 di0jsw8FCYpQo7uBiwOEEgq8q5RvrBz6Bz6AHPguCsnyei/MrbOL5Xwu5/VPLqbtevtL
 Rbpbw3oT8JKBtCXzuG5BEJ6BA+829JKDt0aOFa+b6v7fxgzDDv0S2Ersa3Op3RtSnCjd
 VryetacsoLsJ8p+7wGIgxs3sdcska2SyJcoHwW+UiAFbo/BlH+Z71LceSXKsxAE5IfBJ
 Pas0TMVOEp1Ep1v3oF2Q7XbMjsiuxFHWjIiCuGpP9dIo/YWCkoVd1JNfmbhyxudQ3Dpx
 yEGA==
X-Gm-Message-State: AGi0PuZdZy56fhHMnNCNl6175aDS8xWyGp05VuVc5wrVhIbFY7UC+pbG
 mDxa8zvcoMFMvKJ3kZgYTopuExKrsiE=
X-Google-Smtp-Source: APiQypIYbmC8My8LepMhC5OWuuHU3GmevvJEP2T5KKngyBiLyEwbkcQPW1ebCiIbCdhotzH+dyCs3A==
X-Received: by 2002:a17:90a:37a3:: with SMTP id
 v32mr11230904pjb.2.1587222257316; 
 Sat, 18 Apr 2020 08:04:17 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id t103sm8668601pjb.46.2020.04.18.08.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 08:04:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] target/s390x: Use tcg_gen_gvec_dup_imm
Date: Sat, 18 Apr 2020 08:04:06 -0700
Message-Id: <20200418150411.1831-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418150411.1831-1-richard.henderson@linaro.org>
References: <20200418150411.1831-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org, david@redhat.com, zhiwei_liu@c-sky.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The gen_gvec_dupi switch is unnecessarily with the new function.
Replace it with a local gen_gvec_dup_imm that takes care of the
register to offset conversion and length arguments.

Drop zero_vec and use use gen_gvec_dup_imm with 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/translate_vx.inc.c | 41 +++++++--------------------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 24558cce80..12347f8a03 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -231,8 +231,8 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
 #define gen_gvec_mov(v1, v2) \
     tcg_gen_gvec_mov(0, vec_full_reg_offset(v1), vec_full_reg_offset(v2), 16, \
                      16)
-#define gen_gvec_dup64i(v1, c) \
-    tcg_gen_gvec_dup64i(vec_full_reg_offset(v1), 16, 16, c)
+#define gen_gvec_dup_imm(es, v1, c) \
+    tcg_gen_gvec_dup_imm(es, vec_full_reg_offset(v1), 16, 16, c);
 #define gen_gvec_fn_2(fn, es, v1, v2) \
     tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                       16, 16)
@@ -316,31 +316,6 @@ static void gen_gvec128_4_i64(gen_gvec128_4_i64_fn fn, uint8_t d, uint8_t a,
         tcg_temp_free_i64(cl);
 }
 
-static void gen_gvec_dupi(uint8_t es, uint8_t reg, uint64_t c)
-{
-    switch (es) {
-    case ES_8:
-        tcg_gen_gvec_dup8i(vec_full_reg_offset(reg), 16, 16, c);
-        break;
-    case ES_16:
-        tcg_gen_gvec_dup16i(vec_full_reg_offset(reg), 16, 16, c);
-        break;
-    case ES_32:
-        tcg_gen_gvec_dup32i(vec_full_reg_offset(reg), 16, 16, c);
-        break;
-    case ES_64:
-        gen_gvec_dup64i(reg, c);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-static void zero_vec(uint8_t reg)
-{
-    tcg_gen_gvec_dup8i(vec_full_reg_offset(reg), 16, 16, 0);
-}
-
 static void gen_addi2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al, TCGv_i64 ah,
                           uint64_t b)
 {
@@ -396,8 +371,8 @@ static DisasJumpType op_vgbm(DisasContext *s, DisasOps *o)
          * Masks for both 64 bit elements of the vector are the same.
          * Trust tcg to produce a good constant loading.
          */
-        gen_gvec_dup64i(get_field(s, v1),
-                        generate_byte_mask(i2 & 0xff));
+        gen_gvec_dup_imm(ES_64, get_field(s, v1),
+                         generate_byte_mask(i2 & 0xff));
     } else {
         TCGv_i64 t = tcg_temp_new_i64();
 
@@ -432,7 +407,7 @@ static DisasJumpType op_vgm(DisasContext *s, DisasOps *o)
         }
     }
 
-    gen_gvec_dupi(es, get_field(s, v1), mask);
+    gen_gvec_dup_imm(es, get_field(s, v1), mask);
     return DISAS_NEXT;
 }
 
@@ -585,7 +560,7 @@ static DisasJumpType op_vllez(DisasContext *s, DisasOps *o)
 
     t = tcg_temp_new_i64();
     tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_TE | es);
-    zero_vec(get_field(s, v1));
+    gen_gvec_dup_imm(es, get_field(s, v1), 0);
     write_vec_element_i64(t, get_field(s, v1), enr, es);
     tcg_temp_free_i64(t);
     return DISAS_NEXT;
@@ -892,7 +867,7 @@ static DisasJumpType op_vrepi(DisasContext *s, DisasOps *o)
         return DISAS_NORETURN;
     }
 
-    gen_gvec_dupi(es, get_field(s, v1), data);
+    gen_gvec_dup_imm(es, get_field(s, v1), data);
     return DISAS_NEXT;
 }
 
@@ -1372,7 +1347,7 @@ static DisasJumpType op_vcksm(DisasContext *s, DisasOps *o)
         read_vec_element_i32(tmp, get_field(s, v2), i, ES_32);
         tcg_gen_add2_i32(tmp, sum, sum, sum, tmp, tmp);
     }
-    zero_vec(get_field(s, v1));
+    gen_gvec_dup_imm(ES_32, get_field(s, v1), 0);
     write_vec_element_i32(sum, get_field(s, v1), 1, ES_32);
 
     tcg_temp_free_i32(tmp);
-- 
2.20.1


