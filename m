Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E97C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0E920738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJpkDfwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0E920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADgT-0006m9-UP
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADU5-0000MY-O5
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:30:06 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTy-0002kz-6j
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:30:04 -0400
Received: by mail-wm1-x343.google.com with SMTP id u18so8544369wmc.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0AGhW0MxhHcUCSNBSGpBK11L52+F5zOr0t2Vfz/+snY=;
 b=UJpkDfwkX7erAH9325bqppJ7xu97l0Y8+a5z4ihjHS9mD8xMApc+aci1tb1zqKbibQ
 3DLdFuniFHMqDmPeFmnc2juAe46YZ1E4/RWuQWIzCSAgBWuaku+tX9ibHD8k9sPeSKCF
 /jVU3Z1vr/IHcgPdpMIpdooOEaTRWI767SQ9VIkICFHfYie0J+qdgPgLWZbeX9BaVKrG
 Tg4Ci2tNB+o86hDntYLbcbXRKWePct8IDAqhMShhAY2GC5byxHsDfc+m7aiwl4lFyd1H
 cQmNa5zohwNyw62uL9zRDfdYmpxNicnkEJqxN5dh9PHzyKwj4Qj3JAN3ht1H3QAVDY1x
 Xepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0AGhW0MxhHcUCSNBSGpBK11L52+F5zOr0t2Vfz/+snY=;
 b=qONKaFqng/spcUWlpe5JZwH0TcxMx7atGCMxjnjWyReijdcZSBCyaOhsyDxjKJ5IMR
 T18yd0+oPYd6CKq46w350Q51A/Tv+XcobmFROQLna6Zv+2Kz1tQKXuQcO/zBwwNA6J4m
 W1gcL0GXNX2IqL1+hMmMIMPVhgwunZa9C7CvZKhacfOnn18xossnu/tMT2P0osatgntt
 Znv9FPsYD3B9ybtLWeHzOHxTmNtVTuovk+jVBEF5COdaykluFtC8ry6CeB2rxdzsgIWi
 zDFcdX/EaoacKTHHTh98Q/qhFIer41/QVJ0Y//5mwBxmfsXnBpTOOGOaOti/Fb9lD6Ap
 cKMQ==
X-Gm-Message-State: AOAM532lBLeWCr+1q0Ujfik/qJxNfBEaEJhekkCJ0hEkHA7SgGGQnuoP
 gRS8F6lC/uHwyexKckwm6K+SK/qs5vQGWkeB
X-Google-Smtp-Source: ABdhPJyTn+kydJnEzdtIF8s6AHIjtgJaKsDmxb9odAGBwDX8Z1Th+vT8qvmt5I7D3py9j5GdY44Zyg==
X-Received: by 2002:a1c:283:: with SMTP id 125mr6262891wmc.12.1598279396899;
 Mon, 24 Aug 2020 07:29:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b14sm24499091wrj.93.2020.08.24.07.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:29:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 19/22] target/arm: Implement new VFP fp16 insn VINS
Date: Mon, 24 Aug 2020 15:29:31 +0100
Message-Id: <20200824142934.20850-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824142934.20850-1-peter.maydell@linaro.org>
References: <20200824142934.20850-1-peter.maydell@linaro.org>
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

The fp16 extension includes a new instruction VINS, which copies the
lower 16 bits of a 32-bit source VFP register into the upper 16 bits
of the destination.  Implement it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp-uncond.decode   |  3 +++
 target/arm/translate-vfp.c.inc | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 9615544623a..39dc8f6373a 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -74,3 +74,6 @@ VCVT        1111 1110 1.11 11 rm:2 .... 1010 op:1 1.0 .... \
             vm=%vm_sp vd=%vd_sp sz=2
 VCVT        1111 1110 1.11 11 rm:2 .... 1011 op:1 1.0 .... \
             vm=%vm_dp vd=%vd_sp sz=3
+
+VINS        1111 1110 1.11 0000 .... 1010 11 . 0 .... \
+            vd=%vd_sp vm=%vm_sp
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 7ce044fa896..bda3dd25136 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -3454,3 +3454,31 @@ static bool trans_NOCP(DisasContext *s, arg_NOCP *a)
 
     return false;
 }
+
+static bool trans_VINS(DisasContext *s, arg_VINS *a)
+{
+    TCGv_i32 rd, rm;
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
+    /* Insert low half of Vm into high half of Vd */
+    rm = tcg_temp_new_i32();
+    rd = tcg_temp_new_i32();
+    neon_load_reg32(rm, a->vm);
+    neon_load_reg32(rd, a->vd);
+    tcg_gen_deposit_i32(rd, rd, rm, 16, 16);
+    neon_store_reg32(rd, a->vd);
+    tcg_temp_free_i32(rm);
+    tcg_temp_free_i32(rd);
+    return true;
+}
-- 
2.20.1


