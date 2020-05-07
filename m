Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EB7C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8172082E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i5AQcm++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8172082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWiQA-0002Uh-Lj
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWiIB-0006sW-1a
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:18:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWiI9-0002ap-Vt
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:18:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id i15so6432874wrx.10
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rTf9IBDSAsF51iBWcS+fobjD1nzCOzkNrL8OJ1OV40M=;
 b=i5AQcm++hyCzhLAgoHyYhSW5VN3U/ORNfWsg2zSpo3vBirDxM03uvaBesTfw5L/NOM
 AHu/BhjjL98extszOh4q9euqMFG51934dyNOn+U4Iqg7KcKlrJoNee2ukpRGyfdmovqV
 2ibXtvztYqGMs0XgEBu8RGNAvWi7u2mMnITilnBXlTcSse69UbbSktCksXOs8bCigKht
 w1OX9s6MD/dCiFIWcKQKtkjAmMTZj1DQnUCb9DYP0fKJKtUpxrtSbyje1c849hAEChjT
 g2BuxEpGBOLXOk3jFz95RrF49Sih9A4yPxHRhJiLNXkIwOinRY9Pg8EYVDqWzLeC/KQ4
 3cSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rTf9IBDSAsF51iBWcS+fobjD1nzCOzkNrL8OJ1OV40M=;
 b=hc2mul+vzdrMr09l/DCaVehpIub1UJAgH0ax1naix+YgvTOwPGnt4tX6sK5urv3SAz
 VdE5P3HoWd32/qR8k+jibjmJ+3nL2dk+NpUyl7+O4HHvDUpKKp9BCLc8K0O8A3TDep6X
 u3YHR5CHAlpyqiGh1C6buvIvZjSZlhkWdHlVqtmBP33F3QfMgqn4d+/kyMtmdCVuHaf7
 SD7FP7KGQ3Jk6NtMbPgDWWoJOPBcfTYZCpLRmwRDyGsQDYzEgNruLYF7aqNG4ciJHWoS
 ST3N6daxdM5miKrGvy3YtUS+V51ckCzgziHSr8i1/hdJJ1LY2b7RjHekoPf+0ZtLPv8x
 cHyA==
X-Gm-Message-State: AGi0PuYrezzcFLKSDAeKtgirG7o86N7mYG5kGtHC3olzoV4Zt1d7f+zZ
 MlmRQZ3eiULHzW4/YOEo2QedUw==
X-Google-Smtp-Source: APiQypJ35Usq63LoiRjN0xCWHXpjkwG8aieOIze9ulmvT4dI4uhcuW7jbfyLqYEs2Dp8sxWgzZIYBA==
X-Received: by 2002:adf:e58d:: with SMTP id l13mr17143980wrm.187.1588864708620; 
 Thu, 07 May 2020 08:18:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q74sm961246wme.14.2020.05.07.08.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 08:18:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/5] docs/system: Document Musca boards
Date: Thu,  7 May 2020 16:18:19 +0100
Message-Id: <20200507151819.28444-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507151819.28444-1-peter.maydell@linaro.org>
References: <20200507151819.28444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Provide a minimal documentation of the Musca boards.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/musca.rst  | 31 +++++++++++++++++++++++++++++++
 docs/system/target-arm.rst |  1 +
 MAINTAINERS                |  1 +
 3 files changed, 33 insertions(+)
 create mode 100644 docs/system/arm/musca.rst

diff --git a/docs/system/arm/musca.rst b/docs/system/arm/musca.rst
new file mode 100644
index 00000000000..8375c5008d5
--- /dev/null
+++ b/docs/system/arm/musca.rst
@@ -0,0 +1,31 @@
+Arm Musca boards (``musca-a``, ``musca-b1``)
+============================================
+
+The Arm Musca development boards are a reference implementation
+of a system using the SSE-200 subsystem for embedded. They are
+dual Cortex-M33 systems.
+
+QEMU provides models of the A and B1 variants of this board.
+
+Unimplemented devices:
+
+- SPI
+- |I2C|
+- |I2S|
+- PWM
+- QSPI
+- Timer
+- SCC
+- GPIO
+- eFlash
+- MHU
+- PVT
+- SDIO
+- CryptoCell
+
+Note that (like the real hardware) the Musca-A machine is
+asymmetric: CPU 0 does not have the FPU or DSP extensions,
+but CPU 1 does. Also like the real hardware, the memory maps
+for the A and B1 variants differ significantly, so guest
+software must be built for the right variant.
+
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 15bcf9f81f0..1b86b93c346 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -72,6 +72,7 @@ undocumented; you can get a complete list by running
 
    arm/integratorcp
    arm/mps2
+   arm/musca
    arm/realview
    arm/versatile
    arm/vexpress
diff --git a/MAINTAINERS b/MAINTAINERS
index ea7bdd359e0..f8e0fdb4ef2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -706,6 +706,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/musca.c
+F: docs/system/arm/musca.rst
 
 Musicpal
 M: Jan Kiszka <jan.kiszka@web.de>
-- 
2.20.1


