Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8396DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100A52071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bqme4U3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100A52071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADdd-0000yG-UB
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADUF-0000Vz-Fg
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:30:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADUD-0002lc-Ma
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:30:15 -0400
Received: by mail-wr1-x444.google.com with SMTP id x7so2846745wro.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=m9CVuJMQutWMXochut4xWnb86c2y5GFee0Vhh2Rycx4=;
 b=Bqme4U3e5Kedmkef6fegYSh99eLn+goTZLouJB3QEp5LEOSLLmElAGLHBWEp41q17U
 YJ5fObPv6+avoe1IrMV26HyptLlrq/wWK+WPjPlJeykj6CBLXXsgX+Gp6267inc3I8hs
 CDg+5r/xJ8wefhsaMnuRn3VE2pbxVul7R9iQYl8wpOC0KEsTUofmeS4X2Ckk0uheb0lO
 tJaalP2eVVRDmtmvWNhsURY781bWLNdR+Wnk26X+bq4wx27h0YExPXcjDEmXj9dx0Xi5
 KI+squk+4udCCLxa5T8Whc7Qfv08G4aH/IWywwL80aTN6jIiskMvPj2L+fQBgHA1rdnJ
 cGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m9CVuJMQutWMXochut4xWnb86c2y5GFee0Vhh2Rycx4=;
 b=ZNgPEpA8Y+ghOVUJeLdR6cmLBom4StDETWhrA4cQwRGoh71pvIDq/0hIoQu2VTQCoA
 IqyPz4uIKy/HDBcufPeX8U7l+hX1AIBWQ44jEdwf4ARDmjto2V2gX93Wysz3a9aCNUtF
 p8qDp4y80c1AVXt4zLByaEQ6yMUv7lTrsFB5O9qSqEGirC+IIVBtllNDFaOy4knZoErT
 6po5NLOoGnmKFrUpv3VFY054Ud4YABtzbyXCwzr4Y4/w9XAg+tDtcrztptT7o1TJpIoW
 bQbNCplesZaBEi4rhQAdpajPZYpCj8AWtd0OD/erkQMCC3sA47OuiPbXz67XVuAYTPx5
 cR3g==
X-Gm-Message-State: AOAM5330OvBudxcjc24Gb09tYFfrCdRWjyXBUH8yKtwOFkQLBvKGa58I
 doemwUFj5z6Fj2xRe+9uQI2kfPvcIjIa5Qcd
X-Google-Smtp-Source: ABdhPJyeYxj0MJuHhqsGEraemlm4gHAksOpDGd5PP0tyughmyF21TDm5z+u4TqDSPGke8+X4uAx3yA==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr6108269wrl.250.1598279397884; 
 Mon, 24 Aug 2020 07:29:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b14sm24499091wrj.93.2020.08.24.07.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:29:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 20/22] target/arm: Implement new VFP fp16 insn VMOVX
Date: Mon, 24 Aug 2020 15:29:32 +0100
Message-Id: <20200824142934.20850-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824142934.20850-1-peter.maydell@linaro.org>
References: <20200824142934.20850-1-peter.maydell@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The fp16 extension includes a new instruction VMOVX, which copies the
upper 16 bits of a 32-bit source VFP register into the lower 16
bits of the destination and zeroes the high half of the destination.
Implement it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp-uncond.decode   |  3 +++
 target/arm/translate-vfp.c.inc | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 39dc8f6373a..8891ab3d549 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -75,5 +75,8 @@ VCVT        1111 1110 1.11 11 rm:2 .... 1010 op:1 1.0 .... \
 VCVT        1111 1110 1.11 11 rm:2 .... 1011 op:1 1.0 .... \
             vm=%vm_dp vd=%vd_sp sz=3
 
+VMOVX       1111 1110 1.11 0000 .... 1010 01 . 0 .... \
+            vd=%vd_sp vm=%vm_sp
+
 VINS        1111 1110 1.11 0000 .... 1010 11 . 0 .... \
             vd=%vd_sp vm=%vm_sp
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index bda3dd25136..4b26156eccc 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -3482,3 +3482,28 @@ static bool trans_VINS(DisasContext *s, arg_VINS *a)
     tcg_temp_free_i32(rd);
     return true;
 }
+
+static bool trans_VMOVX(DisasContext *s, arg_VINS *a)
+{
+    TCGv_i32 rm;
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
+    /* Set Vd to high half of Vm */
+    rm = tcg_temp_new_i32();
+    neon_load_reg32(rm, a->vm);
+    tcg_gen_shri_i32(rm, rm, 16);
+    neon_store_reg32(rm, a->vd);
+    tcg_temp_free_i32(rm);
+    return true;
+}
-- 
2.20.1


