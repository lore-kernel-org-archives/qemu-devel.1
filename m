Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8BCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 686C120707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y14Bco3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686C120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8Sv-0002dV-Jn
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LE-00077U-GP
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:16 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LC-00041P-K7
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:16 -0400
Received: by mail-wr1-x436.google.com with SMTP id l10so20048964wrr.10
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OTEJtvwoi/Tq6+Gsk0HWDmoxlvZQU0bMln6FXAFyNNI=;
 b=y14Bco3h556g+PBgUJg+/3zcq5AWIn8fi7mUi68i/+GwTvmO3NC4exIQMSVTpdXf6E
 posjEgBYvgMMx34OUYCxzsHCuhYoQ+n4GELyBS+INCx4gAZGG6xrf4IUo53uQeHUOG/Y
 JIPzMA+XFNIco+gp5aR5/dgfg8BT0skrohL+uk87blLTZIoPBTFlGxJNecAGD0Xx8+IP
 zXga1B+E5yeL9wHHpHBFJesF5CE5GU418ccKOaCBrBHAboIQolyiahnH10rVyOLVMQFA
 pH4uEnfan0gs6PFL3qAIEy0HEN6cehguvdHqW2ykvxmw9Db32sRidrBRDtyJ7IVr3AcC
 sQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OTEJtvwoi/Tq6+Gsk0HWDmoxlvZQU0bMln6FXAFyNNI=;
 b=X1UoYR6kxNjCD6wbOw0pHK41zrZltTMTgcOB7+TwotfYZRHJYvQgWCXk+vOC3VFCNr
 G+BOlVunOmB7sTRpF2FGVHal6ZQwiH0IhskK8kBJPPdRTQhW7Hz4UXW/6tuRV26CA3/H
 HnaLdsR+VvynGYpn0EpLEe9aiakd0NfhUJVQbaDvdTChOmaBrURj1NBz0ApsE9oia2Qz
 CG9DN3VUM0zRql3Hx/1prba1lqQ+KP0vUcZBuDIgFFAcGvmzCr6SUuxDByATiFYV5sQ7
 h+RSDeriicKQ2Ub0SJIBBklS4i7Tri6RFyU6AnTrMe0Z41mrvF6xj7b0pLlBivKoReHR
 5tzw==
X-Gm-Message-State: AOAM531i/+WcgipO10+zoLq0C5fYgqfeKYKyibolOnWyGULhcyrb9idh
 Uvm93wk2iXo+scsM38CQA1MT/l6ZeWIxVA==
X-Google-Smtp-Source: ABdhPJzVpzgHk/qWorS0+K0fZlRmQMEjJZ5bb9dKxNcV1iVwE207NIPzLx9jnJRZBKDsEGumeL8+/g==
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr2141693wrq.362.1592301432922; 
 Tue, 16 Jun 2020 02:57:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/23] target/arm: Convert Neon 3-reg-diff saturating doubling
 multiplies
Date: Tue, 16 Jun 2020 10:56:45 +0100
Message-Id: <20200616095702.25848-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Convert the Neon 3-reg-diff insns VQDMULL, VQDMLAL and VQDMLSL:
these are all saturating doubling long multiplies with a possible
accumulate step.

These are the last insns in the group which use the pass-over-each
elements loop, so we can delete that code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       |  6 +++
 target/arm/translate-neon.inc.c | 82 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 59 ++----------------------
 3 files changed, 92 insertions(+), 55 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 1da492df146..65ea30d3edf 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -454,10 +454,16 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VMLAL_S_3d   1111 001 0 1 . .. .... .... 1000 . 0 . 0 .... @3diff
     VMLAL_U_3d   1111 001 1 1 . .. .... .... 1000 . 0 . 0 .... @3diff
 
+    VQDMLAL_3d   1111 001 0 1 . .. .... .... 1001 . 0 . 0 .... @3diff
+
     VMLSL_S_3d   1111 001 0 1 . .. .... .... 1010 . 0 . 0 .... @3diff
     VMLSL_U_3d   1111 001 1 1 . .. .... .... 1010 . 0 . 0 .... @3diff
 
+    VQDMLSL_3d   1111 001 0 1 . .. .... .... 1011 . 0 . 0 .... @3diff
+
     VMULL_S_3d   1111 001 0 1 . .. .... .... 1100 . 0 . 0 .... @3diff
     VMULL_U_3d   1111 001 1 1 . .. .... .... 1100 . 0 . 0 .... @3diff
+
+    VQDMULL_3d   1111 001 0 1 . .. .... .... 1101 . 0 . 0 .... @3diff
   ]
 }
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index c435f0685d4..083e3af8c56 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2222,3 +2222,85 @@ DO_VMLAL(VMLAL_S,mull_s,add)
 DO_VMLAL(VMLAL_U,mull_u,add)
 DO_VMLAL(VMLSL_S,mull_s,sub)
 DO_VMLAL(VMLSL_U,mull_u,sub)
+
+static void gen_VQDMULL_16(TCGv_i64 rd, TCGv_i32 rn, TCGv_i32 rm)
+{
+    gen_helper_neon_mull_s16(rd, rn, rm);
+    gen_helper_neon_addl_saturate_s32(rd, cpu_env, rd, rd);
+}
+
+static void gen_VQDMULL_32(TCGv_i64 rd, TCGv_i32 rn, TCGv_i32 rm)
+{
+    gen_mull_s32(rd, rn, rm);
+    gen_helper_neon_addl_saturate_s64(rd, cpu_env, rd, rd);
+}
+
+static bool trans_VQDMULL_3d(DisasContext *s, arg_3diff *a)
+{
+    static NeonGenTwoOpWidenFn * const opfn[] = {
+        NULL,
+        gen_VQDMULL_16,
+        gen_VQDMULL_32,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], NULL);
+}
+
+static void gen_VQDMLAL_acc_16(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    gen_helper_neon_addl_saturate_s32(rd, cpu_env, rn, rm);
+}
+
+static void gen_VQDMLAL_acc_32(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    gen_helper_neon_addl_saturate_s64(rd, cpu_env, rn, rm);
+}
+
+static bool trans_VQDMLAL_3d(DisasContext *s, arg_3diff *a)
+{
+    static NeonGenTwoOpWidenFn * const opfn[] = {
+        NULL,
+        gen_VQDMULL_16,
+        gen_VQDMULL_32,
+        NULL,
+    };
+    static NeonGenTwo64OpFn * const accfn[] = {
+        NULL,
+        gen_VQDMLAL_acc_16,
+        gen_VQDMLAL_acc_32,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], accfn[a->size]);
+}
+
+static void gen_VQDMLSL_acc_16(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    gen_helper_neon_negl_u32(rm, rm);
+    gen_helper_neon_addl_saturate_s32(rd, cpu_env, rn, rm);
+}
+
+static void gen_VQDMLSL_acc_32(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    tcg_gen_neg_i64(rm, rm);
+    gen_helper_neon_addl_saturate_s64(rd, cpu_env, rn, rm);
+}
+
+static bool trans_VQDMLSL_3d(DisasContext *s, arg_3diff *a)
+{
+    static NeonGenTwoOpWidenFn * const opfn[] = {
+        NULL,
+        gen_VQDMULL_16,
+        gen_VQDMULL_32,
+        NULL,
+    };
+    static NeonGenTwo64OpFn * const accfn[] = {
+        NULL,
+        gen_VQDMLSL_acc_16,
+        gen_VQDMLSL_acc_32,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], accfn[a->size]);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a2c47d19f21..88e91845c02 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5247,11 +5247,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     {0, 0, 0, 7}, /* VSUBHN: handled by decodetree */
                     {0, 0, 0, 7}, /* VABDL */
                     {0, 0, 0, 7}, /* VMLAL */
-                    {0, 0, 0, 9}, /* VQDMLAL */
+                    {0, 0, 0, 7}, /* VQDMLAL */
                     {0, 0, 0, 7}, /* VMLSL */
-                    {0, 0, 0, 9}, /* VQDMLSL */
+                    {0, 0, 0, 7}, /* VQDMLSL */
                     {0, 0, 0, 7}, /* Integer VMULL */
-                    {0, 0, 0, 9}, /* VQDMULL */
+                    {0, 0, 0, 7}, /* VQDMULL */
                     {0, 0, 0, 0xa}, /* Polynomial VMULL */
                     {0, 0, 0, 7}, /* Reserved: always UNDEF */
                 };
@@ -5282,58 +5282,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     }
                     return 0;
                 }
-
-                /* Avoid overlapping operands.  Wide source operands are
-                   always aligned so will never overlap with wide
-                   destinations in problematic ways.  */
-                if (rd == rm) {
-                    tmp = neon_load_reg(rm, 1);
-                    neon_store_scratch(2, tmp);
-                } else if (rd == rn) {
-                    tmp = neon_load_reg(rn, 1);
-                    neon_store_scratch(2, tmp);
-                }
-                tmp3 = NULL;
-                for (pass = 0; pass < 2; pass++) {
-                    if (pass == 1 && rd == rn) {
-                        tmp = neon_load_scratch(2);
-                    } else {
-                        tmp = neon_load_reg(rn, pass);
-                    }
-                    if (pass == 1 && rd == rm) {
-                        tmp2 = neon_load_scratch(2);
-                    } else {
-                        tmp2 = neon_load_reg(rm, pass);
-                    }
-                    switch (op) {
-                    case 9: case 11: case 13:
-                        /* VQDMLAL, VQDMLSL, VQDMULL */
-                        gen_neon_mull(cpu_V0, tmp, tmp2, size, u);
-                        break;
-                    default: /* 15 is RESERVED: caught earlier  */
-                        abort();
-                    }
-                    if (op == 13) {
-                        /* VQDMULL */
-                        gen_neon_addl_saturate(cpu_V0, cpu_V0, size);
-                        neon_store_reg64(cpu_V0, rd + pass);
-                    } else {
-                        /* Accumulate.  */
-                        neon_load_reg64(cpu_V1, rd + pass);
-                        switch (op) {
-                        case 9: case 11: /* VQDMLAL, VQDMLSL */
-                            gen_neon_addl_saturate(cpu_V0, cpu_V0, size);
-                            if (op == 11) {
-                                gen_neon_negl(cpu_V0, size);
-                            }
-                            gen_neon_addl_saturate(cpu_V0, cpu_V1, size);
-                            break;
-                        default:
-                            abort();
-                        }
-                        neon_store_reg64(cpu_V0, rd + pass);
-                    }
-                }
+                abort(); /* all others handled by decodetree */
             } else {
                 /* Two registers and a scalar. NB that for ops of this form
                  * the ARM ARM labels bit 24 as Q, but it is in our variable
-- 
2.20.1


