Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D06C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223E32065F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBNatkNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223E32065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjEI-0004oG-7w
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCc-0002Dj-5x
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:18 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCT-0005wk-W3
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id h15so27145wrt.12
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ok9515A+UWatZQsVTa5LF82a4fmDdsSTs/unMMozW6w=;
 b=mBNatkNgZ+cfLMDqOkG56zeB0OfcZu79i2dAU8ODvkhAQGD98QeQkvPnsEfBF6d0Sf
 aJOXCV0TE77AvdjU8ZrPCOoqOBH5Xcks7oNOKXeIh43vi0bosHoeTEdUznjhD3sa7DMN
 AqTJNVLqx+Oq4GBLG1ROinxJ4HkxPSdx4ZGnNqMmbX0LMgZbBZNq+DDk+syUyXUlSzh3
 vU4AJjDRi/RQmPEG2apjyE+X2Vy/BerXYO5MI6E7aUh9KaRc3deX2u5aWpmEMOT/qD/o
 gxi8gPYUExNpnOHKe9AAy778LH7Lk8/FW93BsHSlAKO//BSA4ulrDYRMpB+n8Xa149QG
 BLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ok9515A+UWatZQsVTa5LF82a4fmDdsSTs/unMMozW6w=;
 b=rkfOvOp53NqLvz3/cHsa3BI8WvmWb48qK3Vhp+fM4eozDmzeCX9Or4fG0rmDmn1EcH
 WW4bA4mpPf5G4WCFCIrYwWDDYrHgBYbzkimqrmitHpMYWYtuWhWdas+ewIKC8S9rtmdY
 OfXxkq2vsMVNtjIwzZuZKtD4KPir3VKGzUmAuU+vUj/U1o5xdDU01xgeg0JueHNS2MH0
 B2tzR2OBcv5rX5bbZY46gCjRT9ltUhpiZERWAe7xwh9Vq2ljQgMV/bnmvC4ONNeFwi10
 xeAlzZbGTmi4ixCgi0neJZ7dzzbk16YxWz2xdr8I+cigvG1tjGaHnmVjlAdXrdiCRGLH
 YcEQ==
X-Gm-Message-State: AOAM5336tACw8x/n0HVPVY+NgNttpXlV5FZiotzUqGy05dvb7AyP+hpT
 /t8fvY3jq9Qk8f5Cyjdc79h+FjOT8XYxdCXl
X-Google-Smtp-Source: ABdhPJzu8v6aqFcrSzLetM2tkCL21Z1gYmK05KsKcc4zxxxEAYWUaozZC2mVoGqiKn6pDdcaUXULew==
X-Received: by 2002:adf:9387:: with SMTP id 7mr263656wrp.332.1598639647680;
 Fri, 28 Aug 2020 11:34:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 09/45] target/arm: Implement VFP fp16 for VMOV immediate
Date: Fri, 28 Aug 2020 19:33:18 +0100
Message-Id: <20200828183354.27913-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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

Implement VFP fp16 support for the VMOV immediate insn.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp.decode          |  2 ++
 target/arm/translate-vfp.c.inc | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 5c64701dde0..c898183771b 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -154,6 +154,8 @@ VFMS_dp      ---- 1110 1.10 .... .... 1011 .1.0 ....        @vfp_dnm_d
 VFNMA_dp     ---- 1110 1.01 .... .... 1011 .0.0 ....        @vfp_dnm_d
 VFNMS_dp     ---- 1110 1.01 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
+VMOV_imm_hp  ---- 1110 1.11 .... .... 1001 0000 .... \
+             vd=%vd_sp imm=%vmov_imm
 VMOV_imm_sp  ---- 1110 1.11 .... .... 1010 0000 .... \
              vd=%vd_sp imm=%vmov_imm
 VMOV_imm_dp  ---- 1110 1.11 .... .... 1011 0000 .... \
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 99b722b75bd..c864178ad4e 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -2161,6 +2161,28 @@ MAKE_VFM_TRANS_FNS(hp)
 MAKE_VFM_TRANS_FNS(sp)
 MAKE_VFM_TRANS_FNS(dp)
 
+static bool trans_VMOV_imm_hp(DisasContext *s, arg_VMOV_imm_sp *a)
+{
+    TCGv_i32 fd;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (s->vec_len != 0 || s->vec_stride != 0) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fd = tcg_const_i32(vfp_expand_imm(MO_16, a->imm));
+    neon_store_reg32(fd, a->vd);
+    tcg_temp_free_i32(fd);
+    return true;
+}
+
 static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 {
     uint32_t delta_d = 0;
-- 
2.20.1


