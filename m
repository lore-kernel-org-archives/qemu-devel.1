Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A8EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08CC206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNU0nljl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08CC206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsWFW-0002Qm-UW
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 14:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsWEZ-0000sW-0i
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:52:55 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsWEX-0000fG-Dv
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:52:54 -0400
Received: by mail-pl1-x644.google.com with SMTP id q17so1258107pls.9
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rQZd24S5VU+V/cof+qwhVwm+IKJe+Jz5EkBoSd9tflA=;
 b=pNU0nljlJvQBpMLL55zd66qH8go5yYWCvaF62nl2w1i2j+hYsbJEgXj0R5HB4rysHT
 cIpy1OZ2+sLPbkGU0p9cx+V+WzIcusl9NRWthv2XyJ5ELXI6c8jRwh8TWtNsYOJlMP7C
 hp0/PWMtyYdiAz6ju3mAGiFHPBT640KjS4lyX+VvLo/9cSzCgR+zMeQsI1j/ZQYHFAq3
 iJm7tdcZeFe6Ydi9sg4VAhgyrXy7TjqX0m86aJSp+69+dQKjPelK1HytAf6ChdDOQPC9
 iD6cpqIsobvZ/FlbdFyp9+7FmogOlfGyzK/B29wshdNepH/x53Q5vEML1vXpyuwOgy4Q
 bYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rQZd24S5VU+V/cof+qwhVwm+IKJe+Jz5EkBoSd9tflA=;
 b=dfqtwm3ReEXv3D9diyVuYfDcOVpxg+hAE3UwPoIKZYRWOeg1B/s2uFw4S2Nz794VSO
 64+h0/V8lsp5lHaL8yKplDcpBMNDVJyDxmOpMFKcDOAV9dF/e48Bx7ySkhhMBMxLMEPP
 6abmEMuL6RB4sJ6l+uaICEfDZiAYF5rg0/1ZxyHNAuEKBnKocVbjU7I5KYFoYnCmpVgs
 PuuBF9gjmWtUxvF1Ov/Qdni7qJ6OXccIZs8Bxn4JgeUc6XFvxGDTceXdvAk/YeiOM9D7
 e/1UAK5FwVLl7Sqf/8SAHxo28fxeDDsEAYynF/ET6eknwv3GNIg9KS0QXgtEF/s4cVu/
 9WBg==
X-Gm-Message-State: AOAM532lEO8wezcxj82tJhZ7BUqX70JU0R7y+CSOf6kKjp2S3HIerguj
 //5YSBPgwxL+qFtZLox6hzSmmSwWETo=
X-Google-Smtp-Source: ABdhPJyoU4LpPJ3R8T5acE/cXAvcfwlrYqppqStLvawwIfnKmMbz0vFd5UnMUxbDK71nzeUaYVusnQ==
X-Received: by 2002:a17:90a:c592:: with SMTP id
 l18mr568352pjt.119.1594061571479; 
 Mon, 06 Jul 2020 11:52:51 -0700 (PDT)
Received: from localhost.localdomain (097-090-106-114.biz.spectrum.com.
 [97.90.106.114])
 by smtp.gmail.com with ESMTPSA id q6sm19988179pfg.76.2020.07.06.11.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 11:52:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Fix temp double-free in sve ldr/str
Date: Mon,  6 Jul 2020 11:52:46 -0700
Message-Id: <20200706185248.118447-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706185248.118447-1-richard.henderson@linaro.org>
References: <20200706185248.118447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The temp that gets assigned to clean_addr has been allocated with
new_tmp_a64, which means that it will be freed at the end of the
instruction.  Freeing it earlier leads to assertion failure.

The loop creates a complication, in which we allocate a new local
temp, which does need freeing, and the final code path is shared
between the loop and non-loop.

Fix this complication by adding new_tmp_a64_local so that the new
local temp is freed at the end, and can be treated exactly like
the non-loop path.

Fixes: bba87d0a0f4
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.h | 1 +
 target/arm/translate-a64.c | 6 ++++++
 target/arm/translate-sve.c | 8 ++------
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 49e4865918..647f0c74f6 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -30,6 +30,7 @@ void unallocated_encoding(DisasContext *s);
     } while (0)
 
 TCGv_i64 new_tmp_a64(DisasContext *s);
+TCGv_i64 new_tmp_a64_local(DisasContext *s);
 TCGv_i64 new_tmp_a64_zero(DisasContext *s);
 TCGv_i64 cpu_reg(DisasContext *s, int reg);
 TCGv_i64 cpu_reg_sp(DisasContext *s, int reg);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 73d753f11f..8c0764957c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -461,6 +461,12 @@ TCGv_i64 new_tmp_a64(DisasContext *s)
     return s->tmp_a64[s->tmp_a64_count++] = tcg_temp_new_i64();
 }
 
+TCGv_i64 new_tmp_a64_local(DisasContext *s)
+{
+    assert(s->tmp_a64_count < TMP_A64_MAX);
+    return s->tmp_a64[s->tmp_a64_count++] = tcg_temp_local_new_i64();
+}
+
 TCGv_i64 new_tmp_a64_zero(DisasContext *s)
 {
     TCGv_i64 t = new_tmp_a64(s);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f318ca265f..08f0fd15b2 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4372,9 +4372,8 @@ static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
 
         /* Copy the clean address into a local temp, live across the loop. */
         t0 = clean_addr;
-        clean_addr = tcg_temp_local_new_i64();
+        clean_addr = new_tmp_a64_local(s);
         tcg_gen_mov_i64(clean_addr, t0);
-        tcg_temp_free_i64(t0);
 
         gen_set_label(loop);
 
@@ -4422,7 +4421,6 @@ static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
         tcg_gen_st_i64(t0, cpu_env, vofs + len_align);
         tcg_temp_free_i64(t0);
     }
-    tcg_temp_free_i64(clean_addr);
 }
 
 /* Similarly for stores.  */
@@ -4463,9 +4461,8 @@ static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
 
         /* Copy the clean address into a local temp, live across the loop. */
         t0 = clean_addr;
-        clean_addr = tcg_temp_local_new_i64();
+        clean_addr = new_tmp_a64_local(s);
         tcg_gen_mov_i64(clean_addr, t0);
-        tcg_temp_free_i64(t0);
 
         gen_set_label(loop);
 
@@ -4509,7 +4506,6 @@ static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
         }
         tcg_temp_free_i64(t0);
     }
-    tcg_temp_free_i64(clean_addr);
 }
 
 static bool trans_LDR_zri(DisasContext *s, arg_rri *a)
-- 
2.25.1


