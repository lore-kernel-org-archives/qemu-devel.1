Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BF8C3A5AA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FFAF208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1dknQ78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFAF208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5b72-000393-24
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azt-0004Ho-SO
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azq-0002Bv-92
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:17 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5azp-0002Af-SD
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:14 -0400
Received: by mail-pl1-x644.google.com with SMTP id y1so10010965plp.9
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iwMY4Va0yfoxKscjE8xig8J8a9Pr7U82PT5LI3ovLKI=;
 b=a1dknQ78ieEUaLnDIrsUXtplVyPj3hwbaDzsvra5gjcjiH8Bxm9Tm158vo48znhNKU
 6Hn3UwlVCYL7UR+DgazQbTMUQenXvHFXG4MtY+a1nrNaDv0w9cwGnLovbP6GgubqyRe6
 qLkUf/BraZj1h1AIY15QycgghMZ3ivR3ZjPvcI4vANvfZJwG2yAeeMpjTIZQK4ar3fCQ
 UYHI8nAyImvmqZkki8mRe1aoYq97N9LSBsmAtoUzKhorL2M0Z6hPCKRzcGPMDaVIAIrz
 129N/VZgm5bo075chChD06D5JEIVmCKBVytWMhF/bCXH6Ojz6y4sNuV+78kNaFm0SqRK
 z21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=iwMY4Va0yfoxKscjE8xig8J8a9Pr7U82PT5LI3ovLKI=;
 b=YIU+7uAmt2ftB0UNOpLqNZcXyphvpjU5/rGANmJSF/s7DrWajEc1jDZM45UjgeIElq
 zxEy3qsklIhNst7fM051NAi6v7OtX7pLq89I9cP57hCbESZsE4vr63wS/b8UwR/jwW6i
 F25fRniNK+dwsnCLB2X96qOORQQmWbf+ska1YqdiCARS217owDHwHfuX1yMeZhv8lLOA
 +G7eqAfc+N43r2tUgUZLpBqG5x0REBEwvkKirKS4NlCUIL0G3GxMambEyHibYBodjFvJ
 LkS6WOp+Nd5fbvcNhEricICCBm0oDiZ4B3qr9YJcmIDxugTyknN9a8bed6hgT5XlkR1/
 gF2g==
X-Gm-Message-State: APjAAAX+FCHaMcjqQp5cxBIdtEYL7AppOA4bo0TGy/eYjRo6iKVK7+aG
 6sF8ikLft5ZuQ0HIo6yYMsDGBvdaJ5c=
X-Google-Smtp-Source: APXvYqwR340+hWcD2Th9ymSi5oIknjuVFIWdwbQyFSMv1f4NcHRlZkWy0yyqFBsKHxNAPzhwomBAAQ==
X-Received: by 2002:a17:902:ff15:: with SMTP id
 f21mr21978203plj.185.1567625472415; 
 Wed, 04 Sep 2019 12:31:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:29:59 -0700
Message-Id: <20190904193059.26202-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v4 09/69] target/arm: Convert Halfword multiply
 and multiply accumulate
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 218 +++++++++++++++++++++++------------------
 target/arm/a32.decode  |  20 ++++
 target/arm/t32.decode  |  29 ++++++
 3 files changed, 170 insertions(+), 97 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ddb2c764a1..5306e93470 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8170,6 +8170,117 @@ DO_QADDSUB(QDSUB, false, true)
 
 #undef DO_QADDSUB
 
+/*
+ * Halfword multiply and multiply accumulate
+ */
+
+static bool op_smlaxxx(DisasContext *s, arg_rrrr *a,
+                       int add_long, bool nt, bool mt)
+{
+    TCGv_i32 t0, t1;
+    TCGv_i64 t64;
+
+    if (s->thumb
+        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
+        : !ENABLE_ARCH_5TE) {
+        return false;
+    }
+
+    t0 = load_reg(s, a->rn);
+    t1 = load_reg(s, a->rm);
+    gen_mulxy(t0, t1, nt, mt);
+    tcg_temp_free_i32(t1);
+
+    switch (add_long) {
+    case 0:
+        store_reg(s, a->rd, t0);
+        break;
+    case 1:
+        t1 = load_reg(s, a->ra);
+        gen_helper_add_setq(t0, cpu_env, t0, t1);
+        tcg_temp_free_i32(t1);
+        store_reg(s, a->rd, t0);
+        break;
+    case 2:
+        t64 = tcg_temp_new_i64();
+        tcg_gen_ext_i32_i64(t64, t0);
+        tcg_temp_free_i32(t0);
+        gen_addq(s, t64, a->ra, a->rd);
+        gen_storeq_reg(s, a->ra, a->rd, t64);
+        tcg_temp_free_i64(t64);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return true;
+}
+
+#define DO_SMLAX(NAME, add, nt, mt) \
+static bool trans_##NAME(DisasContext *s, arg_rrrr *a)     \
+{                                                          \
+    return op_smlaxxx(s, a, add, nt, mt);                  \
+}
+
+DO_SMLAX(SMULBB, 0, 0, 0)
+DO_SMLAX(SMULBT, 0, 0, 1)
+DO_SMLAX(SMULTB, 0, 1, 0)
+DO_SMLAX(SMULTT, 0, 1, 1)
+
+DO_SMLAX(SMLABB, 1, 0, 0)
+DO_SMLAX(SMLABT, 1, 0, 1)
+DO_SMLAX(SMLATB, 1, 1, 0)
+DO_SMLAX(SMLATT, 1, 1, 1)
+
+DO_SMLAX(SMLALBB, 2, 0, 0)
+DO_SMLAX(SMLALBT, 2, 0, 1)
+DO_SMLAX(SMLALTB, 2, 1, 0)
+DO_SMLAX(SMLALTT, 2, 1, 1)
+
+#undef DO_SMLAX
+
+static bool op_smlawx(DisasContext *s, arg_rrrr *a, bool add, bool mt)
+{
+    TCGv_i32 t0, t1;
+    TCGv_i64 t64;
+
+    if (!ENABLE_ARCH_5TE) {
+        return false;
+    }
+
+    t0 = load_reg(s, a->rn);
+    t1 = load_reg(s, a->rm);
+    if (mt) {
+        tcg_gen_sari_i32(t1, t1, 16);
+    } else {
+        gen_sxth(t1);
+    }
+    t64 = gen_muls_i64_i32(t0, t1);
+    tcg_gen_shri_i64(t64, t64, 16);
+    t1 = tcg_temp_new_i32();
+    tcg_gen_extrl_i64_i32(t1, t64);
+    tcg_temp_free_i64(t64);
+    if (add) {
+        t0 = load_reg(s, a->ra);
+        gen_helper_add_setq(t1, cpu_env, t1, t0);
+        tcg_temp_free_i32(t0);
+    }
+    store_reg(s, a->rd, t1);
+    return true;
+}
+
+#define DO_SMLAWX(NAME, add, mt) \
+static bool trans_##NAME(DisasContext *s, arg_rrrr *a)     \
+{                                                          \
+    return op_smlawx(s, a, add, mt);                       \
+}
+
+DO_SMLAWX(SMULWB, 0, 0)
+DO_SMLAWX(SMULWT, 0, 1)
+DO_SMLAWX(SMLAWB, 1, 0)
+DO_SMLAWX(SMLAWT, 1, 1)
+
+#undef DO_SMLAWX
+
 /*
  * Legacy decoder.
  */
@@ -8636,56 +8747,13 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             }
             break;
         }
-        case 0x8: /* signed multiply */
+        case 0x8:
         case 0xa:
         case 0xc:
         case 0xe:
-            ARCH(5TE);
-            rs = (insn >> 8) & 0xf;
-            rn = (insn >> 12) & 0xf;
-            rd = (insn >> 16) & 0xf;
-            if (op1 == 1) {
-                /* (32 * 16) >> 16 */
-                tmp = load_reg(s, rm);
-                tmp2 = load_reg(s, rs);
-                if (sh & 4)
-                    tcg_gen_sari_i32(tmp2, tmp2, 16);
-                else
-                    gen_sxth(tmp2);
-                tmp64 = gen_muls_i64_i32(tmp, tmp2);
-                tcg_gen_shri_i64(tmp64, tmp64, 16);
-                tmp = tcg_temp_new_i32();
-                tcg_gen_extrl_i64_i32(tmp, tmp64);
-                tcg_temp_free_i64(tmp64);
-                if ((sh & 2) == 0) {
-                    tmp2 = load_reg(s, rn);
-                    gen_helper_add_setq(tmp, cpu_env, tmp, tmp2);
-                    tcg_temp_free_i32(tmp2);
-                }
-                store_reg(s, rd, tmp);
-            } else {
-                /* 16 * 16 */
-                tmp = load_reg(s, rm);
-                tmp2 = load_reg(s, rs);
-                gen_mulxy(tmp, tmp2, sh & 2, sh & 4);
-                tcg_temp_free_i32(tmp2);
-                if (op1 == 2) {
-                    tmp64 = tcg_temp_new_i64();
-                    tcg_gen_ext_i32_i64(tmp64, tmp);
-                    tcg_temp_free_i32(tmp);
-                    gen_addq(s, tmp64, rn, rd);
-                    gen_storeq_reg(s, rn, rd, tmp64);
-                    tcg_temp_free_i64(tmp64);
-                } else {
-                    if (op1 == 0) {
-                        tmp2 = load_reg(s, rn);
-                        gen_helper_add_setq(tmp, cpu_env, tmp, tmp2);
-                        tcg_temp_free_i32(tmp2);
-                    }
-                    store_reg(s, rd, tmp);
-                }
-            }
-            break;
+            /* Halfword multiply and multiply accumulate.  */
+            /* All done in decodetree.  Reach here for illegal ops.  */
+            goto illegal_op;
         default:
             goto illegal_op;
         }
@@ -10143,13 +10211,14 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             break;
         case 4: case 5: /* 32-bit multiply.  Sum of absolute differences.  */
             switch ((insn >> 20) & 7) {
-            case 0: /* 32 x 32 -> 32, in decodetree */
+            case 0: /* 32 x 32 -> 32 */
+            case 1: /* 16 x 16 -> 32 */
+            case 3: /* 32 * 16 -> 32msb */
+                /* in decodetree */
                 goto illegal_op;
             case 7: /* Unsigned sum of absolute differences.  */
                 break;
-            case 1: /* 16 x 16 -> 32 */
             case 2: /* Dual multiply add.  */
-            case 3: /* 32 * 16 -> 32msb */
             case 4: /* Dual multiply subtract.  */
             case 5: case 6: /* 32 * 32 -> 32msb (SMMUL, SMMLA, SMMLS) */
                 if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
@@ -10161,15 +10230,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             tmp = load_reg(s, rn);
             tmp2 = load_reg(s, rm);
             switch ((insn >> 20) & 7) {
-            case 1: /* 16 x 16 -> 32 */
-                gen_mulxy(tmp, tmp2, op & 2, op & 1);
-                tcg_temp_free_i32(tmp2);
-                if (rs != 15) {
-                    tmp2 = load_reg(s, rs);
-                    gen_helper_add_setq(tmp, cpu_env, tmp, tmp2);
-                    tcg_temp_free_i32(tmp2);
-                }
-                break;
             case 2: /* Dual multiply add.  */
             case 4: /* Dual multiply subtract.  */
                 if (op)
@@ -10193,23 +10253,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     tcg_temp_free_i32(tmp2);
                   }
                 break;
-            case 3: /* 32 * 16 -> 32msb */
-                if (op)
-                    tcg_gen_sari_i32(tmp2, tmp2, 16);
-                else
-                    gen_sxth(tmp2);
-                tmp64 = gen_muls_i64_i32(tmp, tmp2);
-                tcg_gen_shri_i64(tmp64, tmp64, 16);
-                tmp = tcg_temp_new_i32();
-                tcg_gen_extrl_i64_i32(tmp, tmp64);
-                tcg_temp_free_i64(tmp64);
-                if (rs != 15)
-                  {
-                    tmp2 = load_reg(s, rs);
-                    gen_helper_add_setq(tmp, cpu_env, tmp, tmp2);
-                    tcg_temp_free_i32(tmp2);
-                  }
-                break;
             case 5: case 6: /* 32 * 32 -> 32msb (SMMUL, SMMLA, SMMLS) */
                 tcg_gen_muls2_i32(tmp2, tmp, tmp, tmp2);
                 if (rs != 15) {
@@ -10290,29 +10333,10 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 gen_storeq_reg(s, rs, rd, tmp64);
                 tcg_temp_free_i64(tmp64);
             } else {
-                if ((op & 0x20) || !(op & 8)) {
-                    /* Signed/unsigned 64-bit multiply, in decodetree */
-                    tcg_temp_free_i32(tmp2);
-                    tcg_temp_free_i32(tmp);
-                    goto illegal_op;
-                }
-                /* smlalxy */
-                if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                    tcg_temp_free_i32(tmp2);
-                    tcg_temp_free_i32(tmp);
-                    goto illegal_op;
-                }
-                gen_mulxy(tmp, tmp2, op & 2, op & 1);
+                /* Signed/unsigned 64-bit multiply, in decodetree */
                 tcg_temp_free_i32(tmp2);
-                tmp64 = tcg_temp_new_i64();
-                tcg_gen_ext_i32_i64(tmp64, tmp);
                 tcg_temp_free_i32(tmp);
-                if (op & 0x40) {
-                    /* 64-bit accumulate.  */
-                    gen_addq(s, tmp64, rs, rd);
-                }
-                gen_storeq_reg(s, rs, rd, tmp64);
-                tcg_temp_free_i64(tmp64);
+                goto illegal_op;
             }
             break;
         }
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 7791be5590..19d12e726b 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -114,6 +114,7 @@ MVN_rxi          .... 001 1111 . 0000 .... ............       @s_rxi_rot
 @s_rdamn         ---- .... ... s:1 rd:4 ra:4 rm:4 .... rn:4   &s_rrrr
 @s_rd0mn         ---- .... ... s:1 rd:4 .... rm:4 .... rn:4   &s_rrrr ra=0
 @rdamn           ---- .... ... .   rd:4 ra:4 rm:4 .... rn:4   &rrrr
+@rd0mn           ---- .... ... .   rd:4 .... rm:4 .... rn:4   &rrrr ra=0
 
 MUL              .... 0000 000 . .... 0000 .... 1001 ....     @s_rd0mn
 MLA              .... 0000 001 . .... .... .... 1001 ....     @s_rdamn
@@ -132,3 +133,22 @@ QADD             .... 0001 0000 .... .... 0000 0101 ....      @rndm
 QSUB             .... 0001 0010 .... .... 0000 0101 ....      @rndm
 QDADD            .... 0001 0100 .... .... 0000 0101 ....      @rndm
 QDSUB            .... 0001 0110 .... .... 0000 0101 ....      @rndm
+
+# Halfword multiply and multiply accumulate
+
+SMLABB           .... 0001 0000 .... .... .... 1000 ....      @rdamn
+SMLABT           .... 0001 0000 .... .... .... 1100 ....      @rdamn
+SMLATB           .... 0001 0000 .... .... .... 1010 ....      @rdamn
+SMLATT           .... 0001 0000 .... .... .... 1110 ....      @rdamn
+SMLAWB           .... 0001 0010 .... .... .... 1000 ....      @rdamn
+SMULWB           .... 0001 0010 .... 0000 .... 1010 ....      @rd0mn
+SMLAWT           .... 0001 0010 .... .... .... 1100 ....      @rdamn
+SMULWT           .... 0001 0010 .... 0000 .... 1110 ....      @rd0mn
+SMLALBB          .... 0001 0100 .... .... .... 1000 ....      @rdamn
+SMLALBT          .... 0001 0100 .... .... .... 1100 ....      @rdamn
+SMLALTB          .... 0001 0100 .... .... .... 1010 ....      @rdamn
+SMLALTT          .... 0001 0100 .... .... .... 1110 ....      @rdamn
+SMULBB           .... 0001 0110 .... 0000 .... 1000 ....      @rd0mn
+SMULBT           .... 0001 0110 .... 0000 .... 1100 ....      @rd0mn
+SMULTB           .... 0001 0110 .... 0000 .... 1010 ....      @rd0mn
+SMULTT           .... 0001 0110 .... 0000 .... 1110 ....      @rd0mn
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 7c6226e0af..122a0537ed 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -118,6 +118,7 @@ RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
 @s0_rnadm        .... .... .... rn:4 ra:4 rd:4 .... rm:4      &s_rrrr s=0
 @s0_rn0dm        .... .... .... rn:4 .... rd:4 .... rm:4      &s_rrrr ra=0 s=0
 @rnadm           .... .... .... rn:4 ra:4 rd:4 .... rm:4      &rrrr
+@rn0dm           .... .... .... rn:4 .... rd:4 .... rm:4      &rrrr ra=0
 @rndm            .... .... .... rn:4 .... rd:4 .... rm:4      &rrr
 
 {
@@ -130,6 +131,34 @@ UMULL            1111 1011 1010 .... .... .... 0000 ....      @s0_rnadm
 SMLAL            1111 1011 1100 .... .... .... 0000 ....      @s0_rnadm
 UMLAL            1111 1011 1110 .... .... .... 0000 ....      @s0_rnadm
 UMAAL            1111 1011 1110 .... .... .... 0110 ....      @rnadm
+{
+  SMULWB         1111 1011 0011 .... 1111 .... 0000 ....      @rn0dm
+  SMLAWB         1111 1011 0011 .... .... .... 0000 ....      @rnadm
+}
+{
+  SMULWT         1111 1011 0011 .... 1111 .... 0001 ....      @rn0dm
+  SMLAWT         1111 1011 0011 .... .... .... 0001 ....      @rnadm
+}
+{
+  SMULBB         1111 1011 0001 .... 1111 .... 0000 ....      @rn0dm
+  SMLABB         1111 1011 0001 .... .... .... 0000 ....      @rnadm
+}
+{
+  SMULBT         1111 1011 0001 .... 1111 .... 0001 ....      @rn0dm
+  SMLABT         1111 1011 0001 .... .... .... 0001 ....      @rnadm
+}
+{
+  SMULTB         1111 1011 0001 .... 1111 .... 0010 ....      @rn0dm
+  SMLATB         1111 1011 0001 .... .... .... 0010 ....      @rnadm
+}
+{
+  SMULTT         1111 1011 0001 .... 1111 .... 0011 ....      @rn0dm
+  SMLATT         1111 1011 0001 .... .... .... 0011 ....      @rnadm
+}
+SMLALBB          1111 1011 1100 .... .... .... 1000 ....      @rnadm
+SMLALBT          1111 1011 1100 .... .... .... 1001 ....      @rnadm
+SMLALTB          1111 1011 1100 .... .... .... 1010 ....      @rnadm
+SMLALTT          1111 1011 1100 .... .... .... 1011 ....      @rnadm
 
 # Data-processing (two source registers)
 
-- 
2.17.1


