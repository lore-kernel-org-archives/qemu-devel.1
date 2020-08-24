Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ED2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D5CC20738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z1+X2uI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5CC20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADeg-0002zX-O5
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTv-00008y-T6
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTu-0002jb-0o
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id y3so8899147wrl.4
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=6iJpACWsMvXCAbJNWQuL6aEft/GfwNO72E4X7/oHZeQ=;
 b=Z1+X2uI9h1zE3ieQUqCVDB67nKXM1jcJE5H9K95uolRzuSTeU+jS6XJv6K+x0pzLbh
 mt70DhIYnnGO7GmUfGLraKwAHF26bJeAfJU1OLICKVNf1Og/cov7P8MaQ8mk0k/yljzi
 d+N135iXynwVJqKC8EJxRLm1Uc0xkzH00M2fzk95ylwfuxHS12P1zwTWsNmfvlaJdiGv
 MzA4/1YTqm4fGLFpRQsNIirv8OpzqAGaoVA2+Bvj1gEaF1UlmFSVid+fPnIVW1agNST4
 5ruLeqUzyvqDW4RARZOx2CuDqo2UJ/VEf5KoB+a4Yisrkf0Oe4g3WbofbnerCNaiT8b9
 U5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6iJpACWsMvXCAbJNWQuL6aEft/GfwNO72E4X7/oHZeQ=;
 b=VHmBsgTYmntgyyxB0ze6H8GVz97+RbolXIy8dCyEaaVWAGX5xurqBbV+Lsvb03RB9C
 4nrLx6eSevzUl/5EK1J7o19AXxbb4hkYf44NxEOz4795DIUM+JXwqzoPYZ/szS6wFzuv
 +84o/nF2uanEkppcPAKaTgAPW6UZ1Oma+kckZr3qBAyuS8CFWEAfYhEWrcGUGuRu4fAX
 o2Z8glXm+cNtOHctiD6Igv+hjXOx0UD28VbNjHtobTxz3Zr+mv6yuLpBdjh3MMV61Llw
 NIs/FoV5uLuaQ3SJAH+vq41hePTsIlOXqiVgvQ84UMhf5z+dpmHjiDjJETjkMppOZjQU
 Vdvg==
X-Gm-Message-State: AOAM531AKpXrszmeeUuds9UygetrhtZOmrvzaThAN+aNjB3tgige7i0C
 x5+/3o0zWgF0ChKz51Bfvl804Q==
X-Google-Smtp-Source: ABdhPJzwMYK4uic+uas99iy1aGNg2dkbC/guzW3Wr/tveEG9VeF5P2MDIOmWZvutg/geOMkUqTvadg==
X-Received: by 2002:a5d:54ca:: with SMTP id x10mr6026049wrv.36.1598279392692; 
 Mon, 24 Aug 2020 07:29:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b14sm24499091wrj.93.2020.08.24.07.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:29:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 15/22] target/arm: Implement VFP fp16 VCVT between float and
 fixed-point
Date: Mon, 24 Aug 2020 15:29:27 +0100
Message-Id: <20200824142934.20850-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824142934.20850-1-peter.maydell@linaro.org>
References: <20200824142934.20850-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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


