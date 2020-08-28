Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA78FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76AF32075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xpwmA76D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AF32075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjPN-0006V1-JL
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCg-0002QO-QO
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:42502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCa-0005y6-BY
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id c18so42219wrm.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DVP2Mp73QOLPJah3nvK3hrNS6x+FIiMTtRkRR6OwSkc=;
 b=xpwmA76DG9nNRd8h2DW9PXEIJzQnocVVd0JXPJLuAgA7elvPCogwZysrmA1Is3mfYZ
 eVHDrjohVUPR+BmrD6sfyPa1ctY6ZeUMEJYxCH652RGPIKsxOg7oDNdkv/XxDlBRz5a9
 3M4rJkkgVsl4WTnW/zmFmdW+pReNCas8M1n7cke2EnqaocPmbjAPE8vx+vlMAwG7fRmj
 HGvYDAo/17/vCEbIGkGkTyfkWju9DAEp/5IVISyRjfxtaT12td9q+AWQuJEKeKigZg+P
 XyqwB1L/8bCbLf7oFv+KtDRscEkGQoPLZN/GFuyqj2FWXiUyqPFAwEjBWtzFQg1yHHUt
 FZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DVP2Mp73QOLPJah3nvK3hrNS6x+FIiMTtRkRR6OwSkc=;
 b=Gr955FTmGPz73OXSRi6wAxzHz0KzXVmXTe+Z1Myj8KqwiTE0R8sNn+MMo9woV51EHt
 qHJTGU/52wgG5buZ2kQwIXzj5nvntVFRiWBBLCyUpRbfm4XASXWavzcI3wBOZg2c8r5U
 RfcM3YZsE5CfZuSmCNix9mumNZGUEtTav7QOIdf0yo4N6VQxrU5amEYAr2t3LTPUttC+
 Re7mr+3psKOX6GDFBTHuB15+9J4z8IiWd2uV1/FJK1YQS0N+zpF9tX5V5ShKu6yguDwo
 VfACKd8FDXU8OkiEc1hFqc7sJhlG5LfI4LdciuI40lJEuEGEyPGV9jtpo2t7uoz6sgeq
 p/jQ==
X-Gm-Message-State: AOAM530gJTh0y0LLVqGE8FJrFlCopDw4kkBjufKheVHJqPCYnN0zK2Vf
 qFe+HpOIakqgvMI4DLV7800c9VsIVTxmi9LT
X-Google-Smtp-Source: ABdhPJyQfo84ZQRbnc4znsz7NIHl3J1RjoPqnZZHHk2SSX0MB6e6KL9lw4zisEq7WeXbe400uhTFGA==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr283414wrw.149.1598639655125; 
 Fri, 28 Aug 2020 11:34:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 15/45] target/arm: Implement VFP fp16 VCVT between float
 and fixed-point
Date: Fri, 28 Aug 2020 19:33:24 +0100
Message-Id: <20200828183354.27913-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implement the fp16 versions of the VFP VCVT instruction forms which
convert between floating point and fixed-point.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp.decode          |  2 ++
 target/arm/translate-vfp.c.inc | 59 ++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 642ec039e3c..a8f1137be1e 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -225,6 +225,8 @@ VJCVT        ---- 1110 1.11 1001 .... 1011 11.0 ....        @vfp_dm_sd
 # We assemble bits 18 (op), 16 (u) and 7 (sx) into a single opc field
 # for the convenience of the trans_VCVT_fix functions.
 %vcvt_fix_op 18:1 16:1 7:1
+VCVT_fix_hp  ---- 1110 1.11 1.1. .... 1001 .1.0 .... \
+             vd=%vd_sp imm=%vm_sp opc=%vcvt_fix_op
 VCVT_fix_sp  ---- 1110 1.11 1.1. .... 1010 .1.0 .... \
              vd=%vd_sp imm=%vm_sp opc=%vcvt_fix_op
 VCVT_fix_dp  ---- 1110 1.11 1.1. .... 1011 .1.0 .... \
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 0140822d183..fdf486b7c15 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -2972,6 +2972,65 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
     return true;
 }
 
+static bool trans_VCVT_fix_hp(DisasContext *s, arg_VCVT_fix_sp *a)
+{
+    TCGv_i32 vd, shift;
+    TCGv_ptr fpst;
+    int frac_bits;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    frac_bits = (a->opc & 1) ? (32 - a->imm) : (16 - a->imm);
+
+    vd = tcg_temp_new_i32();
+    neon_load_reg32(vd, a->vd);
+
+    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    shift = tcg_const_i32(frac_bits);
+
+    /* Switch on op:U:sx bits */
+    switch (a->opc) {
+    case 0:
+        gen_helper_vfp_shtoh(vd, vd, shift, fpst);
+        break;
+    case 1:
+        gen_helper_vfp_sltoh(vd, vd, shift, fpst);
+        break;
+    case 2:
+        gen_helper_vfp_uhtoh(vd, vd, shift, fpst);
+        break;
+    case 3:
+        gen_helper_vfp_ultoh(vd, vd, shift, fpst);
+        break;
+    case 4:
+        gen_helper_vfp_toshh_round_to_zero(vd, vd, shift, fpst);
+        break;
+    case 5:
+        gen_helper_vfp_toslh_round_to_zero(vd, vd, shift, fpst);
+        break;
+    case 6:
+        gen_helper_vfp_touhh_round_to_zero(vd, vd, shift, fpst);
+        break;
+    case 7:
+        gen_helper_vfp_toulh_round_to_zero(vd, vd, shift, fpst);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    neon_store_reg32(vd, a->vd);
+    tcg_temp_free_i32(vd);
+    tcg_temp_free_i32(shift);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
+
 static bool trans_VCVT_fix_sp(DisasContext *s, arg_VCVT_fix_sp *a)
 {
     TCGv_i32 vd, shift;
-- 
2.20.1


