Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFEBC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9647E20E65
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OypsOhWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9647E20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8J8-00062q-DM
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83W-0007hb-6l
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:42 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83U-0006BG-Bn
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:41 -0400
Received: by mail-wr1-x434.google.com with SMTP id z4so1986522wrr.4
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8CkNZDIClDhttev8nkQXhOCk51Y9GF0fQ7LhFUI0X04=;
 b=OypsOhWGG/87umfxgyo1cKgZFh30OMCTIOnKFoRt2Pv8k+BxpocdQk5utedJcdCalr
 zZTX566jWPV3FwDvlPGZkw1+1CyxN4qM+qXPX36vnUvcX58n7hqrMGjQ7ATETIAVX0jv
 puMUfBgil2LqiT8KDuLo/MURZA5x5V0TRzP4GLmQAf0hw2rfmwlbHM9NZ4h04XA/VnG/
 oGm7ZZMWT8uYercw4IeGZxGHQZ+bUcPLiQfiPDpDMKwUUdbnb0VmGw3x9lHP6j9QI6W5
 /d1wk3Nfx7yFvoB5RgkzjVemhbACMgujJrlt9QapKfI+olh3dCw6f29CDp+n+ML3HWYq
 GK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8CkNZDIClDhttev8nkQXhOCk51Y9GF0fQ7LhFUI0X04=;
 b=FyP4fpeWCzH6tO+mR6AzHTANeEzx2kxqqOee/tRMllbkp3WYqIp/x6bDI1csF45fXt
 k4TfFt/caxKJqPmtTcFo9JzhmOVS1angHpQoB9gYJ0MwolWt4T9zlJ51CmfQWoJ0yxYS
 REgusghNBvOoXNCrY1GvRzDF7Z45oF7MxWoxNZiCeEuYk9nKGNMJx1UZORA3cU8f8apt
 cujMD73Ptz6HAySblcqHtN27aG1BSMbsM+FJimAMBaxEKDgpvpyQUwxQJwzt1Bu85Rp3
 CUPReFxum73dMiB2x1GWv6h8DMq90O7EurRypKVEqtVfd9jyMHOawFQ05pxUDvNqdla/
 QH5A==
X-Gm-Message-State: AOAM533kLi5K4rHq4652RNS9nf7duMd00UEtWZ2X6u6+UeA6nAdiqG3q
 W1luFPvJtJtAgiN3UPG/YYoFIQOHrzzYUZYR
X-Google-Smtp-Source: ABdhPJxiPpkwKFa29G6fr9UaS/LvGk0LyCGw5bNycZMXghB477a49sgmgHQFREMiKtPEqcWOQpA7/w==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr2495615wrq.203.1598973518492; 
 Tue, 01 Sep 2020 08:18:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/47] target/arm: Implement VFP fp16 for VMOV immediate
Date: Tue,  1 Sep 2020 16:17:45 +0100
Message-Id: <20200901151823.29785-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
Message-id: 20200828183354.27913-10-peter.maydell@linaro.org
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


