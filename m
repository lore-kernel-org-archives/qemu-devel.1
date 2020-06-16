Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E975C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A7B20C09
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zsnf2wvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A7B20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlF9g-0004AR-8V
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF59-0001Yt-PY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF57-0007VZ-Gr
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id f185so3870951wmf.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8XDNy5i8wbkQg//M5D1t/pjF6TQt81ktgOCgLPl1lf0=;
 b=Zsnf2wvsUL0ndcXwl4QKpWumgeoZ+jdzcdfrYKh9jNN+r86q32I/KRoLD+lyS6F3hq
 vRugjdK3Cf8Jk9Hjphr2KXKqQJWOwfu9LHXgGkg5CVd0IFhVvUwQ+k6jlkStlJdpTGGA
 iYkTPif00YYwfRaQMvUXDze5DxGCYjTw/zIhh9qFHia3PdSLoubyus2fFEoES102skZ2
 FpO7LD2RPX8ytXTsBX7e6eqS1OPsktai3Iyb+/CV9pI6YKe57YMRKthn7turMDn0yFMB
 ax3q0mPRABqCm1TbIwAZI7HW3Rm2A5l7L0JkEe8LcMeAtAm+2MdlrKG8gYNm06IPhOi6
 vStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8XDNy5i8wbkQg//M5D1t/pjF6TQt81ktgOCgLPl1lf0=;
 b=HF3bD6yEN/jD7RmYIcxLanJuIDMHTc9SIUresOrfLVB94+AY/W114LCVyqXAewD69w
 SIjUCHC+L+YIGoLHEsNSAtIj8qualEV7fzr8r+ucUMGEjZSUy8uLGMwJ2hyOEEsAFCFo
 KnfZLF0Jn3oWNZnV0Ql2sLFS6zZ5eqJUKVDVNTPFteloD7VxJ8ni6V11CEk/eOadqJyC
 mc6YrAEjOEYpPfD7udqupi0I1+0Pam6EZt7rdY2/7zFidsT5JehEuOKqUDZ6Xr9IqqlT
 6CdRSWaEpH5W+A7cJwjh+rgicahXrHAdL1MXfbd62/7MoA+jXMaz/mvPwxGXNS7+Z7sw
 IHxg==
X-Gm-Message-State: AOAM532CW6KLl3qb2QPK9xwVa+y6Q1HEY0lxNfFy88nJ2FaVTxOKdJyw
 wH25YCGbzFLN6cpdPP85IbWa1Mxcv+j9Hw==
X-Google-Smtp-Source: ABdhPJy9akmWc6qGJuzf59wYQZv3l4ghUM8uB62e8VPEHV1TBLjMXYSp4C0thwV737qMCKm0c+eBMQ==
X-Received: by 2002:a05:600c:4146:: with SMTP id
 h6mr4400459wmm.170.1592327344098; 
 Tue, 16 Jun 2020 10:09:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:09:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 13/21] target/arm: Convert remaining simple 2-reg-misc Neon ops
Date: Tue, 16 Jun 2020 18:08:36 +0100
Message-Id: <20200616170844.13318-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the remaining ops in the Neon 2-reg-misc group which
can be implemented simply with our do_2misc() helper.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       | 10 +++++
 target/arm/translate-neon.inc.c | 69 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 38 ++++--------------
 3 files changed, 86 insertions(+), 31 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 0a791af46c8..f947f7d09f0 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -456,6 +456,10 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     AESMC        1111 001 11 . 11 .. 00 .... 0 0111 0 . 0 .... @2misc_q1
     AESIMC       1111 001 11 . 11 .. 00 .... 0 0111 1 . 0 .... @2misc_q1
 
+    VCLS         1111 001 11 . 11 .. 00 .... 0 1000 . . 0 .... @2misc
+    VCLZ         1111 001 11 . 11 .. 00 .... 0 1001 . . 0 .... @2misc
+    VCNT         1111 001 11 . 11 .. 00 .... 0 1010 . . 0 .... @2misc
+
     VMVN         1111 001 11 . 11 .. 00 .... 0 1011 . . 0 .... @2misc
 
     VPADAL_S     1111 001 11 . 11 .. 00 .... 0 1100 . . 0 .... @2misc
@@ -472,6 +476,9 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VABS         1111 001 11 . 11 .. 01 .... 0 0110 . . 0 .... @2misc
     VNEG         1111 001 11 . 11 .. 01 .... 0 0111 . . 0 .... @2misc
 
+    VABS_F       1111 001 11 . 11 .. 01 .... 0 1110 . . 0 .... @2misc
+    VNEG_F       1111 001 11 . 11 .. 01 .... 0 1111 . . 0 .... @2misc
+
     VUZP         1111 001 11 . 11 .. 10 .... 0 0010 . . 0 .... @2misc
     VZIP         1111 001 11 . 11 .. 10 .... 0 0011 . . 0 .... @2misc
 
@@ -489,6 +496,9 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
 
     VCVT_F16_F32 1111 001 11 . 11 .. 10 .... 0 1100 0 . 0 .... @2misc_q0
     VCVT_F32_F16 1111 001 11 . 11 .. 10 .... 0 1110 0 . 0 .... @2misc_q0
+
+    VRECPE       1111 001 11 . 11 .. 11 .... 0 1000 . . 0 .... @2misc
+    VRSQRTE      1111 001 11 . 11 .. 11 .... 0 1001 . . 0 .... @2misc
   ]
 
   # Subgroup for size != 0b11
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 0a779980d01..336c2b312eb 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3602,3 +3602,72 @@ static bool trans_VREV16(DisasContext *s, arg_2misc *a)
     }
     return do_2misc(s, a, gen_rev16);
 }
+
+static bool trans_VCLS(DisasContext *s, arg_2misc *a)
+{
+    static NeonGenOneOpFn * const fn[] = {
+        gen_helper_neon_cls_s8,
+        gen_helper_neon_cls_s16,
+        gen_helper_neon_cls_s32,
+        NULL,
+    };
+    return do_2misc(s, a, fn[a->size]);
+}
+
+static void do_VCLZ_32(TCGv_i32 rd, TCGv_i32 rm)
+{
+    tcg_gen_clzi_i32(rd, rm, 32);
+}
+
+static bool trans_VCLZ(DisasContext *s, arg_2misc *a)
+{
+    static NeonGenOneOpFn * const fn[] = {
+        gen_helper_neon_clz_u8,
+        gen_helper_neon_clz_u16,
+        do_VCLZ_32,
+        NULL,
+    };
+    return do_2misc(s, a, fn[a->size]);
+}
+
+static bool trans_VCNT(DisasContext *s, arg_2misc *a)
+{
+    if (a->size != 0) {
+        return false;
+    }
+    return do_2misc(s, a, gen_helper_neon_cnt_u8);
+}
+
+static bool trans_VABS_F(DisasContext *s, arg_2misc *a)
+{
+    if (a->size != 2) {
+        return false;
+    }
+    /* TODO: FP16 : size == 1 */
+    return do_2misc(s, a, gen_helper_vfp_abss);
+}
+
+static bool trans_VNEG_F(DisasContext *s, arg_2misc *a)
+{
+    if (a->size != 2) {
+        return false;
+    }
+    /* TODO: FP16 : size == 1 */
+    return do_2misc(s, a, gen_helper_vfp_negs);
+}
+
+static bool trans_VRECPE(DisasContext *s, arg_2misc *a)
+{
+    if (a->size != 2) {
+        return false;
+    }
+    return do_2misc(s, a, gen_helper_recpe_u32);
+}
+
+static bool trans_VRSQRTE(DisasContext *s, arg_2misc *a)
+{
+    if (a->size != 2) {
+        return false;
+    }
+    return do_2misc(s, a, gen_helper_rsqrte_u32);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5b50eddd111..17373743889 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4938,6 +4938,13 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_SHA1SU1:
                 case NEON_2RM_VREV32:
                 case NEON_2RM_VREV16:
+                case NEON_2RM_VCLS:
+                case NEON_2RM_VCLZ:
+                case NEON_2RM_VCNT:
+                case NEON_2RM_VABS_F:
+                case NEON_2RM_VNEG_F:
+                case NEON_2RM_VRECPE:
+                case NEON_2RM_VRSQRTE:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -4959,25 +4966,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     for (pass = 0; pass < (q ? 4 : 2); pass++) {
                         tmp = neon_load_reg(rm, pass);
                         switch (op) {
-                        case NEON_2RM_VCLS:
-                            switch (size) {
-                            case 0: gen_helper_neon_cls_s8(tmp, tmp); break;
-                            case 1: gen_helper_neon_cls_s16(tmp, tmp); break;
-                            case 2: gen_helper_neon_cls_s32(tmp, tmp); break;
-                            default: abort();
-                            }
-                            break;
-                        case NEON_2RM_VCLZ:
-                            switch (size) {
-                            case 0: gen_helper_neon_clz_u8(tmp, tmp); break;
-                            case 1: gen_helper_neon_clz_u16(tmp, tmp); break;
-                            case 2: tcg_gen_clzi_i32(tmp, tmp, 32); break;
-                            default: abort();
-                            }
-                            break;
-                        case NEON_2RM_VCNT:
-                            gen_helper_neon_cnt_u8(tmp, tmp);
-                            break;
                         case NEON_2RM_VQABS:
                             switch (size) {
                             case 0:
@@ -5051,12 +5039,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             tcg_temp_free_ptr(fpstatus);
                             break;
                         }
-                        case NEON_2RM_VABS_F:
-                            gen_helper_vfp_abss(tmp, tmp);
-                            break;
-                        case NEON_2RM_VNEG_F:
-                            gen_helper_vfp_negs(tmp, tmp);
-                            break;
                         case NEON_2RM_VSWP:
                             tmp2 = neon_load_reg(rd, pass);
                             neon_store_reg(rm, pass, tmp2);
@@ -5137,12 +5119,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             tcg_temp_free_ptr(fpst);
                             break;
                         }
-                        case NEON_2RM_VRECPE:
-                            gen_helper_recpe_u32(tmp, tmp);
-                            break;
-                        case NEON_2RM_VRSQRTE:
-                            gen_helper_rsqrte_u32(tmp, tmp);
-                            break;
                         case NEON_2RM_VRECPE_F:
                         {
                             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-- 
2.20.1


