Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C1CC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122BB206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tq6brdX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122BB206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOpF-0005kK-3G
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 14:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOo5-0004Mv-2h
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:09 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOo4-0002nl-2B
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:08 -0400
Received: by mail-pf1-x444.google.com with SMTP id z1so1435967pfn.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dOnBBGhmkNTpQUIqTasvNhE2MTWW7gI0dB3WMtwwkiQ=;
 b=tq6brdX7b8W2ZYb1Oi0evlSfSNa2jHfXitgWS+aO0xJI+sg/T92kF9riXQncp8UoF0
 urPzxJ9wGEIF+b20w9Zel7GIyeUrzEffA2q3fGVKwl9F02iHSUFlEq8+Dk0b6DgCFfuD
 axN1seqsAJ4kHP2C6UBnN+RLqW4I1RgplN4n9kU5QyQ9904focMHY6pq0x6TvgGgSPAr
 PWmfb1ltxBiNPdAILh+lTJTOx8J6N0duFhAUemTEfJim0RrhRb2aiYiym8EKtEAzmshr
 9tJKq0FKrfrHfCpyBkGZZaBj4Rj44rL5YKIguUNgwFQWX7NbfxIEi6NVx/hYbd8ZnoTU
 raQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dOnBBGhmkNTpQUIqTasvNhE2MTWW7gI0dB3WMtwwkiQ=;
 b=lT/pP5ff/wxGrDyTQpbB31KAe34tsdk2qOQ5OQjVJRL1CGkxgpvMcXn2mf9LfuVBoH
 DMo18dT9zh5CmfU0mWdftJ1njP9v3dJoKFwhMjmOIPrxr2X94wkR+zdO1o5IKeZLya0y
 +SLFwJHaBcDZJPMvvAR2veafmGhdD+Tbw5scFTarCGjDSwO2zajVq3dQ9MoC91IlQR2N
 1xPul5QRYQEwzo3akcP8Vso6TxT7ksADjZ++DPnjCiZ7vAAIGgGiE+cjJT32tY1YytEY
 gCMPrOO8AJLkbee2CtuZkGgeaiGv1Hrh4A+c7EECmkrVWivEmPm4Nrb7AggBMgJ2aJ3s
 ktKw==
X-Gm-Message-State: AGi0PuavX/RwbJr2+cXPm9/E+fIkWWL9zxL3HJaPfPezDuBqnSFGJ9jU
 waoa7UGdE3W6yhRXwqYQpfApcPPaj+A=
X-Google-Smtp-Source: APiQypIduohWntEEp+DoYZ9CQRu2aGefyrCIsO2H8nIAFAX+N2pZfZYwvE9r5COPz0F9PWr4qc5AfA==
X-Received: by 2002:a62:14a:: with SMTP id 71mr9065890pfb.33.1588789806243;
 Wed, 06 May 2020 11:30:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w11sm2572589pfq.100.2020.05.06.11.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 11:30:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/10] target/s390x: Use tcg_gen_gvec_dup_imm
Date: Wed,  6 May 2020 11:29:54 -0700
Message-Id: <20200506183002.3192-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506183002.3192-1-richard.henderson@linaro.org>
References: <20200506183002.3192-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The gen_gvec_dupi switch is unnecessary with the new function.
Replace it with a local gen_gvec_dup_imm that takes care of the
register to offset conversion and length arguments.

Drop zero_vec and use use gen_gvec_dup_imm with 0.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


