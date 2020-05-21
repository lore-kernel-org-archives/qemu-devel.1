Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C956CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F67207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LRBl0Fov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F67207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqjp-0001Qk-N8
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg3-00025e-HV
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:23 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg2-0000PS-F0
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:23 -0400
Received: by mail-wr1-x433.google.com with SMTP id h17so7746202wrc.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RBS3/dvUvRdquBsGTxU/Sl3WvtmMy3/3XWW/lkBbmEE=;
 b=LRBl0Fovz0NCnQsX2tjh08NqP+bjhuTdi3UsTZoNZ03pYdCqWajOKhEtDiG2QHOvD2
 Emj/zaBcMz2f9/WloIrMeS/Go6dV+aEmGAHXBuvKCGbMq9GWDbp27c8Rth3QAyafevFc
 a27J3fXQHV8tjFvTH3IrZry7yoVu7TLLBwxfMGWmYgI34gqzi/KLeuBK7eCylYVBTOHK
 k4dXSUohPOe9GzNaTwbFC8IaVzPsyWAPJPme9MgqETLWCKBe68aDvHW1gZ9XEknpDVZt
 4gRobf1RMQQ6FaA69xNIqibZHI20CObq7S5sNBXO3MoL9nI3jMaw3QI6R+Oa4g5UYdv/
 bVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RBS3/dvUvRdquBsGTxU/Sl3WvtmMy3/3XWW/lkBbmEE=;
 b=LYXLP1xqIt54CR+qUBdz+OP2TwNyKQFA0Y5AuNv5+WTPKyIxABmxqLUhRrVIeKl/zv
 fnMl98536r9JGPU/10VZ1WJBXy8gFAfVt8bT81QVR5UCajhpyOhXeqlz9Z7QNn3xHShF
 8wic663kSQymoItbxkmXwNACWF8QFAsBlDP/LTn0L62GcwCowfHsRIzqCIRyy2piYDHf
 lBH7zcUPVZ1ZX98kR84UiewNXbfjHsraNaFXnATF4QGPoEV47rLYevOeDksa1erdbgzO
 PZt/6z0F57C7QLkP6wIpO/nQ1kP0mocgK/m2dXqVkVTc9e9hHfiwlm1j2SdYFuwEZfp2
 lJ9A==
X-Gm-Message-State: AOAM531DW7Bm9RW/eYLMTJ1aPmfJTLyh6wh+GroxtdQWeEY6mOXv0mYX
 a9CHQ7BfulZYDvg7xv5FyGPeEy4Bb0QVcw==
X-Google-Smtp-Source: ABdhPJyP17+fSuguiwy8AArUB4jk3M6awWAC3TRkeBguPqIXGr+Q5VXeQOZlTk0gerBLsx5xxkn0hg==
X-Received: by 2002:adf:fccd:: with SMTP id f13mr100949wrs.386.1590088580725; 
 Thu, 21 May 2020 12:16:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/29] docs/system: Document Musca boards
Date: Thu, 21 May 2020 20:15:47 +0100
Message-Id: <20200521191610.10941-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200507151819.28444-6-peter.maydell@linaro.org
---
 docs/system/arm/musca.rst  | 31 +++++++++++++++++++++++++++++++
 docs/system/target-arm.rst |  1 +
 MAINTAINERS                |  1 +
 3 files changed, 33 insertions(+)
 create mode 100644 docs/system/arm/musca.rst

diff --git a/docs/system/arm/musca.rst b/docs/system/arm/musca.rst
new file mode 100644
index 00000000000..81e3dc92194
--- /dev/null
+++ b/docs/system/arm/musca.rst
@@ -0,0 +1,31 @@
+Arm Musca boards (``musca-a``, ``musca-b1``)
+============================================
+
+The Arm Musca development boards are a reference implementation
+of a system using the SSE-200 Subsystem for Embedded. They are
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
index f2d9366e9b4..dce384cb0e3 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -77,6 +77,7 @@ undocumented; you can get a complete list by running
 
    arm/integratorcp
    arm/mps2
+   arm/musca
    arm/realview
    arm/versatile
    arm/vexpress
diff --git a/MAINTAINERS b/MAINTAINERS
index 520a7b74f28..023f48d3eaa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -708,6 +708,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/musca.c
+F: docs/system/arm/musca.rst
 
 Musicpal
 M: Jan Kiszka <jan.kiszka@web.de>
-- 
2.20.1


