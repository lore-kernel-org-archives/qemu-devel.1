Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C98C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BCE20707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4//LCdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BCE20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFHC-0002eF-R4
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF5A-0001bc-Qk
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF58-0007Vy-R9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:08 -0400
Received: by mail-wr1-x444.google.com with SMTP id j10so21555893wrw.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q+0uZHHdicr4FHXDVL/N22V2qnJh66s6U25qsKc1zpA=;
 b=P4//LCdpdE9XCKe56D5wKz06ioLvBJCQMZNlJg6Ac1VLLt7iLP7jGbEqovNw44Zi0L
 QCfZaemXs8gYIU4IBAuxtig5RTyIdJKoAoBzxsoqCb38pBlRjAGYgqbuUivDJ9b/5lWw
 ytmLfcVptE5Xk2PmIOvoFxJG7VRxJklD+zGGOme26i1CuP95gQJhaaRk1UX6GA2KYNKH
 C2Bzx2dsC3vJ1xSjqjMqNnk9hkBt1T0mC9W8PLgLIXMgNxouc8uLeSnR0u0+v9mlhwXy
 Eyi9i4BthXf50oiL/9y3YtyAPjQBfCkCQZtrcyRPLuWcdSfrLdyX8CfH5Bl6NyIDcSME
 RPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q+0uZHHdicr4FHXDVL/N22V2qnJh66s6U25qsKc1zpA=;
 b=tErdQdvRi65RsTqG39vBB5Ko9txfy1Ov656TVy7jVCJHIJTAT5m5r3MVh7CCtbqLWg
 BYhprAiD9ovjq9Wcj3RNIn13BOgurnv/1T0O7jYfrbZ2UIj4v4qGzPQUyR/SI0TG1ojE
 nHWl3aiDHzLSNSJ8Vt8dzTTjRa5WThHU5VlXx1cVs+/Q3dRBWFFKVG2z0FDtvI/fSu/c
 8MyfP2yQkVQ61nfVNpSWnynA2DZBz/JH9Fba6CJbEARTyAEHXW3OLesfZGS1+WjkTijv
 yYmSoD/75XLYQj7eKFFO308HJH/upOTx6/VL48MQyuBWMHWefF4kkCtyLC+HJSnzWHQG
 CFXw==
X-Gm-Message-State: AOAM530ZbjDXFXML54aCtJ2ZOKQZDqqVkNl2FEjhi330hGaaubUVYts6
 wEqo89lrdK+PxcqOOtLQZ6WXIQ==
X-Google-Smtp-Source: ABdhPJwkBb0rKqoP9zU5qygAGrKvCGNx49KPaIhw9ZXER17JrbXAuE+i/VCboA3o8vbheD9NpTtw/Q==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr4046191wru.102.1592327345499; 
 Tue, 16 Jun 2020 10:09:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:09:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 14/21] target/arm: Convert Neon VQABS, VQNEG to decodetree
Date: Tue, 16 Jun 2020 18:08:37 +0100
Message-Id: <20200616170844.13318-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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

Convert the Neon VQABS and VQNEG insns to decodetree.
Since these are the only ones which need cpu_env passing to
the helper, we wrap the helper rather than creating a whole
new do_2misc_env() function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  3 +++
 target/arm/translate-neon.inc.c | 35 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 30 ++--------------------------
 3 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index f947f7d09f0..f0bb34a49eb 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -465,6 +465,9 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VPADAL_S     1111 001 11 . 11 .. 00 .... 0 1100 . . 0 .... @2misc
     VPADAL_U     1111 001 11 . 11 .. 00 .... 0 1101 . . 0 .... @2misc
 
+    VQABS        1111 001 11 . 11 .. 00 .... 0 1110 . . 0 .... @2misc
+    VQNEG        1111 001 11 . 11 .. 00 .... 0 1111 . . 0 .... @2misc
+
     VCGT0        1111 001 11 . 11 .. 01 .... 0 0000 . . 0 .... @2misc
     VCGE0        1111 001 11 . 11 .. 01 .... 0 0001 . . 0 .... @2misc
     VCEQ0        1111 001 11 . 11 .. 01 .... 0 0010 . . 0 .... @2misc
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 336c2b312eb..2b5dc86f628 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3671,3 +3671,38 @@ static bool trans_VRSQRTE(DisasContext *s, arg_2misc *a)
     }
     return do_2misc(s, a, gen_helper_rsqrte_u32);
 }
+
+#define WRAP_1OP_ENV_FN(WRAPNAME, FUNC) \
+    static void WRAPNAME(TCGv_i32 d, TCGv_i32 m)        \
+    {                                                   \
+        FUNC(d, cpu_env, m);                            \
+    }
+
+WRAP_1OP_ENV_FN(gen_VQABS_s8, gen_helper_neon_qabs_s8)
+WRAP_1OP_ENV_FN(gen_VQABS_s16, gen_helper_neon_qabs_s16)
+WRAP_1OP_ENV_FN(gen_VQABS_s32, gen_helper_neon_qabs_s32)
+WRAP_1OP_ENV_FN(gen_VQNEG_s8, gen_helper_neon_qneg_s8)
+WRAP_1OP_ENV_FN(gen_VQNEG_s16, gen_helper_neon_qneg_s16)
+WRAP_1OP_ENV_FN(gen_VQNEG_s32, gen_helper_neon_qneg_s32)
+
+static bool trans_VQABS(DisasContext *s, arg_2misc *a)
+{
+    static NeonGenOneOpFn * const fn[] = {
+        gen_VQABS_s8,
+        gen_VQABS_s16,
+        gen_VQABS_s32,
+        NULL,
+    };
+    return do_2misc(s, a, fn[a->size]);
+}
+
+static bool trans_VQNEG(DisasContext *s, arg_2misc *a)
+{
+    static NeonGenOneOpFn * const fn[] = {
+        gen_VQNEG_s8,
+        gen_VQNEG_s16,
+        gen_VQNEG_s32,
+        NULL,
+    };
+    return do_2misc(s, a, fn[a->size]);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 17373743889..3cbd2ab0c96 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4945,6 +4945,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VNEG_F:
                 case NEON_2RM_VRECPE:
                 case NEON_2RM_VRSQRTE:
+                case NEON_2RM_VQABS:
+                case NEON_2RM_VQNEG:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -4966,34 +4968,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     for (pass = 0; pass < (q ? 4 : 2); pass++) {
                         tmp = neon_load_reg(rm, pass);
                         switch (op) {
-                        case NEON_2RM_VQABS:
-                            switch (size) {
-                            case 0:
-                                gen_helper_neon_qabs_s8(tmp, cpu_env, tmp);
-                                break;
-                            case 1:
-                                gen_helper_neon_qabs_s16(tmp, cpu_env, tmp);
-                                break;
-                            case 2:
-                                gen_helper_neon_qabs_s32(tmp, cpu_env, tmp);
-                                break;
-                            default: abort();
-                            }
-                            break;
-                        case NEON_2RM_VQNEG:
-                            switch (size) {
-                            case 0:
-                                gen_helper_neon_qneg_s8(tmp, cpu_env, tmp);
-                                break;
-                            case 1:
-                                gen_helper_neon_qneg_s16(tmp, cpu_env, tmp);
-                                break;
-                            case 2:
-                                gen_helper_neon_qneg_s32(tmp, cpu_env, tmp);
-                                break;
-                            default: abort();
-                            }
-                            break;
                         case NEON_2RM_VCGT0_F:
                         {
                             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-- 
2.20.1


