Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEA1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B1C20767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qEC1D4OR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B1C20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8R3-0007iy-Me
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LD-00075E-7u
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LB-00041E-D7
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id l17so2269905wmj.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+duFGZKIrzGEzxhaXpOnuzmyBgj9MUYvO1JAvfGbCTU=;
 b=qEC1D4ORsSfz83Ywg1INfn/IZrrdupDWnA3luspXjpDN38o1MPriet1d4UJX2Gbi95
 MWxx0l3wxJDQGwNVcUE7T8R3215LfAlNacIN/H5p+tbr4tkZoDF2/JpyM8qRd2VmLVPM
 /cCts3IBlYjCotcy8J0D1K/9vO6xXZrAtmGNPB857RL3eW0cwONvN8qywStB40/dZbcI
 954z/2kuSDhyo12ks98aROZXhkGnfC7brLS9NwBLgsTmNv5xjlkW0K5lMF3vhktRmpaK
 A/5X0Tg6kVIx/UbxLN8eA9MI6IHqUl7y6+/+lD8CitlB8CzWcHnwZ2QplKT4WtxZ5xQA
 3aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+duFGZKIrzGEzxhaXpOnuzmyBgj9MUYvO1JAvfGbCTU=;
 b=b6BETftJmYrMKU/kjB0v3FZCmHOorfdMCZFufCsXWoTndhB6h+IMdUzF0LCJv5B/uE
 lpwsWNmFl8EeWc6EKaalD25s0hKFVNtOhNhI2gjb2UwGNU1YWh9LYatX85tIkyW+j7Kw
 LYlWSbCBouIZl81jPp5PlCOOznbCwkctrYSwSdDC5QGMDKKsSW+YOVDBk3jIzjBQqMwJ
 qIxsTf4H/iDSHveH4KmY2RXej+oVbh4sdEXPkoCFkV0AqPyl1LS2l42ZTn1TF1QRqJOD
 mic602A6MaqHstC1u+gmKX2pQdZjbOzIB+WTl1+4AlK88nbD18shCtFuT2sx+PGyf+P3
 fvAg==
X-Gm-Message-State: AOAM532tzFtU+nd/1fhAz9pHFpjKvsLVz0bpr9soSR3hN1S900LLA0Ws
 UsC2JajVubqbX++DrXTwJGzCpVEaGGogVA==
X-Google-Smtp-Source: ABdhPJx3m8CkiZCKPxxHi1F7/xffXJ5RLFbRLXX6WbvuuQBy5TkGWnFtoUEaXess4662bI4pXozLpA==
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr2388499wma.32.1592301431713; 
 Tue, 16 Jun 2020 02:57:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/23] target/arm: Convert Neon 3-reg-diff long multiplies
Date: Tue, 16 Jun 2020 10:56:44 +0100
Message-Id: <20200616095702.25848-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon 3-reg-diff insns VMULL, VMLAL and VMLSL; these perform
a 32x32->64 multiply with possible accumulate.

Note that for VMLSL we do the accumulate directly with a subtraction
rather than doing a negate-then-add as the old code did.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       |  9 +++++
 target/arm/translate-neon.inc.c | 71 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 21 +++-------
 3 files changed, 86 insertions(+), 15 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 4f0aaaf6bb2..1da492df146 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -450,5 +450,14 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
 
     VABDL_S_3d   1111 001 0 1 . .. .... .... 0111 . 0 . 0 .... @3diff
     VABDL_U_3d   1111 001 1 1 . .. .... .... 0111 . 0 . 0 .... @3diff
+
+    VMLAL_S_3d   1111 001 0 1 . .. .... .... 1000 . 0 . 0 .... @3diff
+    VMLAL_U_3d   1111 001 1 1 . .. .... .... 1000 . 0 . 0 .... @3diff
+
+    VMLSL_S_3d   1111 001 0 1 . .. .... .... 1010 . 0 . 0 .... @3diff
+    VMLSL_U_3d   1111 001 1 1 . .. .... .... 1010 . 0 . 0 .... @3diff
+
+    VMULL_S_3d   1111 001 0 1 . .. .... .... 1100 . 0 . 0 .... @3diff
+    VMULL_U_3d   1111 001 1 1 . .. .... .... 1100 . 0 . 0 .... @3diff
   ]
 }
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index bea9360ce3f..c435f0685d4 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2151,3 +2151,74 @@ static bool trans_VABAL_U_3d(DisasContext *s, arg_3diff *a)
 
     return do_long_3d(s, a, opfn[a->size], addfn[a->size]);
 }
+
+static void gen_mull_s32(TCGv_i64 rd, TCGv_i32 rn, TCGv_i32 rm)
+{
+    TCGv_i32 lo = tcg_temp_new_i32();
+    TCGv_i32 hi = tcg_temp_new_i32();
+
+    tcg_gen_muls2_i32(lo, hi, rn, rm);
+    tcg_gen_concat_i32_i64(rd, lo, hi);
+
+    tcg_temp_free_i32(lo);
+    tcg_temp_free_i32(hi);
+}
+
+static void gen_mull_u32(TCGv_i64 rd, TCGv_i32 rn, TCGv_i32 rm)
+{
+    TCGv_i32 lo = tcg_temp_new_i32();
+    TCGv_i32 hi = tcg_temp_new_i32();
+
+    tcg_gen_mulu2_i32(lo, hi, rn, rm);
+    tcg_gen_concat_i32_i64(rd, lo, hi);
+
+    tcg_temp_free_i32(lo);
+    tcg_temp_free_i32(hi);
+}
+
+static bool trans_VMULL_S_3d(DisasContext *s, arg_3diff *a)
+{
+    static NeonGenTwoOpWidenFn * const opfn[] = {
+        gen_helper_neon_mull_s8,
+        gen_helper_neon_mull_s16,
+        gen_mull_s32,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], NULL);
+}
+
+static bool trans_VMULL_U_3d(DisasContext *s, arg_3diff *a)
+{
+    static NeonGenTwoOpWidenFn * const opfn[] = {
+        gen_helper_neon_mull_u8,
+        gen_helper_neon_mull_u16,
+        gen_mull_u32,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], NULL);
+}
+
+#define DO_VMLAL(INSN,MULL,ACC)                                         \
+    static bool trans_##INSN##_3d(DisasContext *s, arg_3diff *a)        \
+    {                                                                   \
+        static NeonGenTwoOpWidenFn * const opfn[] = {                   \
+            gen_helper_neon_##MULL##8,                                  \
+            gen_helper_neon_##MULL##16,                                 \
+            gen_##MULL##32,                                             \
+            NULL,                                                       \
+        };                                                              \
+        static NeonGenTwo64OpFn * const accfn[] = {                     \
+            gen_helper_neon_##ACC##l_u16,                               \
+            gen_helper_neon_##ACC##l_u32,                               \
+            tcg_gen_##ACC##_i64,                                        \
+            NULL,                                                       \
+        };                                                              \
+        return do_long_3d(s, a, opfn[a->size], accfn[a->size]);         \
+    }
+
+DO_VMLAL(VMLAL_S,mull_s,add)
+DO_VMLAL(VMLAL_U,mull_u,add)
+DO_VMLAL(VMLSL_S,mull_s,sub)
+DO_VMLAL(VMLSL_U,mull_u,sub)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 37fe9d46e0b..a2c47d19f21 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5246,11 +5246,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     {0, 0, 0, 7}, /* VABAL */
                     {0, 0, 0, 7}, /* VSUBHN: handled by decodetree */
                     {0, 0, 0, 7}, /* VABDL */
-                    {0, 0, 0, 0}, /* VMLAL */
+                    {0, 0, 0, 7}, /* VMLAL */
                     {0, 0, 0, 9}, /* VQDMLAL */
-                    {0, 0, 0, 0}, /* VMLSL */
+                    {0, 0, 0, 7}, /* VMLSL */
                     {0, 0, 0, 9}, /* VQDMLSL */
-                    {0, 0, 0, 0}, /* Integer VMULL */
+                    {0, 0, 0, 7}, /* Integer VMULL */
                     {0, 0, 0, 9}, /* VQDMULL */
                     {0, 0, 0, 0xa}, /* Polynomial VMULL */
                     {0, 0, 0, 7}, /* Reserved: always UNDEF */
@@ -5306,8 +5306,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         tmp2 = neon_load_reg(rm, pass);
                     }
                     switch (op) {
-                    case 8: case 9: case 10: case 11: case 12: case 13:
-                        /* VMLAL, VQDMLAL, VMLSL, VQDMLSL, VMULL, VQDMULL */
+                    case 9: case 11: case 13:
+                        /* VQDMLAL, VQDMLSL, VQDMULL */
                         gen_neon_mull(cpu_V0, tmp, tmp2, size, u);
                         break;
                     default: /* 15 is RESERVED: caught earlier  */
@@ -5317,16 +5317,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         /* VQDMULL */
                         gen_neon_addl_saturate(cpu_V0, cpu_V0, size);
                         neon_store_reg64(cpu_V0, rd + pass);
-                    } else if (op == 5 || (op >= 8 && op <= 11)) {
+                    } else {
                         /* Accumulate.  */
                         neon_load_reg64(cpu_V1, rd + pass);
                         switch (op) {
-                        case 10: /* VMLSL */
-                            gen_neon_negl(cpu_V0, size);
-                            /* Fall through */
-                        case 8: /* VABAL, VMLAL */
-                            gen_neon_addl(size);
-                            break;
                         case 9: case 11: /* VQDMLAL, VQDMLSL */
                             gen_neon_addl_saturate(cpu_V0, cpu_V0, size);
                             if (op == 11) {
@@ -5338,9 +5332,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             abort();
                         }
                         neon_store_reg64(cpu_V0, rd + pass);
-                    } else {
-                        /* Write back the result.  */
-                        neon_store_reg64(cpu_V0, rd + pass);
                     }
                 }
             } else {
-- 
2.20.1


