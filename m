Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF85C54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6EED20724
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oW2ZX0qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EED20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4KN-0000XU-Ps
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41o-0002Mi-Oz
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41m-0002tl-8i
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:16 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41i-0002qj-OA
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:10 -0400
Received: by mail-pg1-x543.google.com with SMTP id j7so237694pgj.13
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CAaXlaeCbYzCudlBaA6sfoD14Yf3D0yL19dplfxIkw0=;
 b=oW2ZX0qaOHUft7B2x7GxjHuHRAwnpPJeIS8znuZuVkB5nzygOVmk9SJuham3j95+vH
 sW+cgydiUesKd9dbXGxJ9/NU8cp5KGTXjV/YspGYwh08eTzYUC1hx16Ot2JhaRtOIT3l
 Lnk8JZvl6JeHKCC4uBlWsnGuAW7nmX6EuHFC/wddaYY359OQtkoxC/KFDqWHHUi2iY+g
 Q+swQQedd1KpuJ1Tg/h3X7nPS4NXJunxbQklXw3KnuVQxxgbCXyEHEDz/HMREcaw7tK7
 PgMUUja0vn4wZCPx4BJ5VlP/BTLd97UjTmjRvRhLn1tIcyYTE4SYWz+45xpoEVfXjDm/
 WKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CAaXlaeCbYzCudlBaA6sfoD14Yf3D0yL19dplfxIkw0=;
 b=aoWIBhX1y98y0jn7Ypr9IdKeiFY46ioGIGameZ5Ak30j1vrXQgCU2Jtm1+sSd+e2ZJ
 lMrz8wccHTGshbtk4pM3QFvZZiu6lllALA94jiXZSgAX5n9mbs3qtT8yhjeNqRadbme8
 hKvYEn4OeplHgQMx6swi0ghnlN8BskSWIswydbBWrX1pswjBqXxT8zO/2HwaI9XB0zWc
 haSfrWmpaXBwrwtxRXR3bl6T0O96WMUsCmrC51mo2VnpSDR8bN+7DEszRVlFW/XXdYH0
 QTQZZaGeu7YwFvwlD0diyvBMlg+UIpIYd8EqP8sSsv9cAKZ8I/KBErcNOQsMVewQkR7I
 dseA==
X-Gm-Message-State: AGi0Pua5LIhoUw8D1sYu1jcFrX5DnS6KZE3z3xmbdcKfNEOh1BBcehGA
 6jRZQR4QLfak6Z14wpIrEbu84hbLqnY=
X-Google-Smtp-Source: APiQypJ9wlBHkJmBmR71eFxf/Ay2bSsgvQnbnCBISoORyDNphAccoD4FtkWfujs0U9zgMrr5gtht7g==
X-Received: by 2002:aa7:8ecd:: with SMTP id b13mr13567353pfr.191.1587518288974; 
 Tue, 21 Apr 2020 18:18:08 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:18:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 36/36] target/s390x: Use tcg_gen_gvec_rotl{i,s,v}
Date: Tue, 21 Apr 2020 18:17:22 -0700
Message-Id: <20200422011722.13287-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: alex.bennee@linaro.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Merge VERLL and VERLLV into op_vesv and op_ves, alongside
all of the other vector shift operations.

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/helper.h           |  4 --
 target/s390x/translate_vx.inc.c | 66 +++++----------------------------
 target/s390x/vec_int_helper.c   | 31 ----------------
 target/s390x/insn-data.def      |  4 +-
 4 files changed, 11 insertions(+), 94 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index b5813c2ac2..b7887b552b 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -198,10 +198,6 @@ DEF_HELPER_FLAGS_4(gvec_vmlo16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vmlo32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
 DEF_HELPER_FLAGS_3(gvec_vpopct8, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
 DEF_HELPER_FLAGS_3(gvec_vpopct16, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
-DEF_HELPER_FLAGS_4(gvec_verllv8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
-DEF_HELPER_FLAGS_4(gvec_verllv16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
-DEF_HELPER_FLAGS_4(gvec_verll8, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_verll16, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_verim8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
 DEF_HELPER_FLAGS_4(gvec_verim16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vsl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 12347f8a03..eb767f5288 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1825,63 +1825,6 @@ static DisasJumpType op_vpopct(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static void gen_rll_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t0 = tcg_temp_new_i32();
-
-    tcg_gen_andi_i32(t0, b, 31);
-    tcg_gen_rotl_i32(d, a, t0);
-    tcg_temp_free_i32(t0);
-}
-
-static void gen_rll_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t0 = tcg_temp_new_i64();
-
-    tcg_gen_andi_i64(t0, b, 63);
-    tcg_gen_rotl_i64(d, a, t0);
-    tcg_temp_free_i64(t0);
-}
-
-static DisasJumpType op_verllv(DisasContext *s, DisasOps *o)
-{
-    const uint8_t es = get_field(s, m4);
-    static const GVecGen3 g[4] = {
-        { .fno = gen_helper_gvec_verllv8, },
-        { .fno = gen_helper_gvec_verllv16, },
-        { .fni4 = gen_rll_i32, },
-        { .fni8 = gen_rll_i64, },
-    };
-
-    if (es > ES_64) {
-        gen_program_exception(s, PGM_SPECIFICATION);
-        return DISAS_NORETURN;
-    }
-
-    gen_gvec_3(get_field(s, v1), get_field(s, v2),
-               get_field(s, v3), &g[es]);
-    return DISAS_NEXT;
-}
-
-static DisasJumpType op_verll(DisasContext *s, DisasOps *o)
-{
-    const uint8_t es = get_field(s, m4);
-    static const GVecGen2s g[4] = {
-        { .fno = gen_helper_gvec_verll8, },
-        { .fno = gen_helper_gvec_verll16, },
-        { .fni4 = gen_rll_i32, },
-        { .fni8 = gen_rll_i64, },
-    };
-
-    if (es > ES_64) {
-        gen_program_exception(s, PGM_SPECIFICATION);
-        return DISAS_NORETURN;
-    }
-    gen_gvec_2s(get_field(s, v1), get_field(s, v3), o->addr1,
-                &g[es]);
-    return DISAS_NEXT;
-}
-
 static void gen_rim_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b, int32_t c)
 {
     TCGv_i32 t = tcg_temp_new_i32();
@@ -1946,6 +1889,9 @@ static DisasJumpType op_vesv(DisasContext *s, DisasOps *o)
     case 0x70:
         gen_gvec_fn_3(shlv, es, v1, v2, v3);
         break;
+    case 0x73:
+        gen_gvec_fn_3(rotlv, es, v1, v2, v3);
+        break;
     case 0x7a:
         gen_gvec_fn_3(sarv, es, v1, v2, v3);
         break;
@@ -1977,6 +1923,9 @@ static DisasJumpType op_ves(DisasContext *s, DisasOps *o)
         case 0x30:
             gen_gvec_fn_2i(shli, es, v1, v3, d2);
             break;
+        case 0x33:
+            gen_gvec_fn_2i(rotli, es, v1, v3, d2);
+            break;
         case 0x3a:
             gen_gvec_fn_2i(sari, es, v1, v3, d2);
             break;
@@ -1994,6 +1943,9 @@ static DisasJumpType op_ves(DisasContext *s, DisasOps *o)
         case 0x30:
             gen_gvec_fn_2s(shls, es, v1, v3, shift);
             break;
+        case 0x33:
+            gen_gvec_fn_2s(rotls, es, v1, v3, shift);
+            break;
         case 0x3a:
             gen_gvec_fn_2s(sars, es, v1, v3, shift);
             break;
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.c
index 0d6bc13dd6..5561b3ed90 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -515,37 +515,6 @@ void HELPER(gvec_vpopct##BITS)(void *v1, const void *v2, uint32_t desc)        \
 DEF_VPOPCT(8)
 DEF_VPOPCT(16)
 
-#define DEF_VERLLV(BITS)                                                       \
-void HELPER(gvec_verllv##BITS)(void *v1, const void *v2, const void *v3,       \
-                               uint32_t desc)                                  \
-{                                                                              \
-    int i;                                                                     \
-                                                                               \
-    for (i = 0; i < (128 / BITS); i++) {                                       \
-        const uint##BITS##_t a = s390_vec_read_element##BITS(v2, i);           \
-        const uint##BITS##_t b = s390_vec_read_element##BITS(v3, i);           \
-                                                                               \
-        s390_vec_write_element##BITS(v1, i, rol##BITS(a, b));                  \
-    }                                                                          \
-}
-DEF_VERLLV(8)
-DEF_VERLLV(16)
-
-#define DEF_VERLL(BITS)                                                        \
-void HELPER(gvec_verll##BITS)(void *v1, const void *v2, uint64_t count,        \
-                              uint32_t desc)                                   \
-{                                                                              \
-    int i;                                                                     \
-                                                                               \
-    for (i = 0; i < (128 / BITS); i++) {                                       \
-        const uint##BITS##_t a = s390_vec_read_element##BITS(v2, i);           \
-                                                                               \
-        s390_vec_write_element##BITS(v1, i, rol##BITS(a, count));              \
-    }                                                                          \
-}
-DEF_VERLL(8)
-DEF_VERLL(16)
-
 #define DEF_VERIM(BITS)                                                        \
 void HELPER(gvec_verim##BITS)(void *v1, const void *v2, const void *v3,        \
                               uint32_t desc)                                   \
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 2bc77f0871..91ddaedd84 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1147,8 +1147,8 @@
 /* VECTOR POPULATION COUNT */
     F(0xe750, VPOPCT,  VRR_a, V,   0, 0, 0, 0, vpopct, 0, IF_VEC)
 /* VECTOR ELEMENT ROTATE LEFT LOGICAL */
-    F(0xe773, VERLLV,  VRR_c, V,   0, 0, 0, 0, verllv, 0, IF_VEC)
-    F(0xe733, VERLL,   VRS_a, V,   la2, 0, 0, 0, verll, 0, IF_VEC)
+    F(0xe773, VERLLV,  VRR_c, V,   0, 0, 0, 0, vesv, 0, IF_VEC)
+    F(0xe733, VERLL,   VRS_a, V,   la2, 0, 0, 0, ves, 0, IF_VEC)
 /* VECTOR ELEMENT ROTATE AND INSERT UNDER MASK */
     F(0xe772, VERIM,   VRI_d, V,   0, 0, 0, 0, verim, 0, IF_VEC)
 /* VECTOR ELEMENT SHIFT LEFT */
-- 
2.20.1


