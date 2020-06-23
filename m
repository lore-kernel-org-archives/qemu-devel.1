Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA44C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC4B20724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUgbnJxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC4B20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhK3-00087Q-Vr
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGz-0002r8-1c
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:29 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGw-0003EK-Ip
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:28 -0400
Received: by mail-wr1-x42f.google.com with SMTP id z13so8403219wrw.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OVN9bOxyVp8gAMLTUZtV/zPnQlWaqxMdhBXvzBIHaD4=;
 b=fUgbnJxFedP06RCO2/Muk6GRw0ED9NMRsdfNgTWzwvhArvLoyM2F4/lpQIfML/uQrE
 C+yEZyyXFkymgYzCUpQZVdcbUCqVSe3eaxQ5o8T210qJXY+g6zD0AwIPCj3ob3cjMtWi
 AimJXyaTw7whm9atgiFppdqNfc5lbVfSFFBN4NgSm8vDkDvZbv5Y7pLoWmbXL6yjIBUP
 qzwooczMP6BujRQp/MBVuyD9B1cn/ohC3qlaf9nM59m5aIpcpYzGKKYJcQ/A9oXVoKsj
 OyisacTj4noWTxamYDMP8E7/WYwAJUj08/Ok4vlsWwhCS9cJME4c84qlxiZkhFU2Pkjm
 JGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OVN9bOxyVp8gAMLTUZtV/zPnQlWaqxMdhBXvzBIHaD4=;
 b=tEmSL6jzkNvnaZXHq+oigVEn/I6FjdujWr0v09t5sdycQZLxTLJLwBf0wjRw/mZq8Z
 Xi+4vHZrPGUmWDMUokc4nEnsvCDkkcZt2zipW8IvqyoX2n1kEAcY0TohJing0MUH5ZOa
 JhdNxgfNPsng6L9wg9cM6MRNvOq0Bh7bgj9ujrdlw9qJqEGSA5N5A1nK2Qiw+UkV1GSb
 nCEwBotB7gBd/zxdNvheAFY2p+qlD/mjGa7Me/SlgGbzUIDrm6BGX0dMihN0Bguz6iMA
 y/Ho1FeRwDEOijVRQvkPDZl+0cAjnDbKwE70s93hdPL33vAzhaMpe4x3gtYztOdaq2D+
 cleQ==
X-Gm-Message-State: AOAM531+YujWp0tSJulP/FWpOADL5Bywuj6t1X1FnDC/ESZGfmc2QGen
 SNFUqXQfP6S3iwdie2hvKfVaNPL7ni8S+A==
X-Google-Smtp-Source: ABdhPJxNi5rByYWGCoSGzJWMCIOtuXeUXiB0BTsozuNi65xNYLacbVW7FdexYB93CvixQIe3cxslMA==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr7417495wrv.177.1592912364784; 
 Tue, 23 Jun 2020 04:39:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/42] target/arm: Convert Neon VQABS, VQNEG to decodetree
Date: Tue, 23 Jun 2020 12:38:38 +0100
Message-Id: <20200623113904.28805-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Convert the Neon VQABS and VQNEG insns to decodetree.
Since these are the only ones which need cpu_env passing to
the helper, we wrap the helper rather than creating a whole
new do_2misc_env() function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-15-peter.maydell@linaro.org
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


