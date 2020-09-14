Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BDEC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739B92074B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOizjK9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739B92074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpL6-0003av-Ap
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8c-0003Pj-Hh
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:34838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8Z-0007ew-MK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id y15so213181wmi.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+mtOlMEuw3HvpJKrB1GOD8D12U8B4KYT+5FYplXqpYI=;
 b=UOizjK9jo4r/EQlVET3j2zQtbhOcsa2GOwEUM5n8SQh6uj5dQzOtAsgZn8WD8A0Iyp
 5gHxFn9CYF77BuvT5CTUeJIYGKWkQpJAyg9PW1sqxZNWeKUNfHhDtAB0fZzpT8/Zujwn
 e2BEhlanVExNjfbxmXnNjaK/JJVu9eTYgNkUdAp//Wi25JzZcb4omjzBJt4r52XJBEEA
 WczueyUON33+Oji9HrTwlwk2J+OCoxtNTNhC+/x654PoI6uqtBhD3cqnKHeDlxvINuuk
 Pyjc1bXx5mJxKv9tb8aELfsQlzHgHNBpYQB1I8mBctfz5jQlI6u0dokGaVVvN1OEh39I
 eBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+mtOlMEuw3HvpJKrB1GOD8D12U8B4KYT+5FYplXqpYI=;
 b=g78OWR8gtsXGY9y1Xwr7ACmXqt1/mN+yepR5d3t+AiDtEJ5xyU0k5dNCaf1gAhX3G3
 DXZ/kU9/rQORTJJH/ORQmW72u86qmX2ZgpBTumnWofbODp/dWZL/il5oCH1GhGtEFUA3
 l0+y45hkzc1Eoy+6ypIpNLasb13Hn8iOoV/yIX/WZDc6WCqqL2PK1B4YazBF5yq3IB1z
 ofQXTD77NuzSGT0AIfHzbbxqTfOlrCTi2mDeecc/rs5vPeBfqqa5QHjTx6SNKMr41GII
 W8W+8OkoxuheTD31Goa42EjDsURErlQS06nBgPOYkiujmqB8RehYBQu6FA6kbo+bdhC5
 AdpA==
X-Gm-Message-State: AOAM530Qi/M11NFh6TvsQ10CUmggZaD2YLB6LfdYWCXgT9/EpXc3Hj40
 VgVKgb5jgCinPrPdtODIixfhTfGT3zqUwxtE
X-Google-Smtp-Source: ABdhPJxZphnf1BVfXyp743VVu93vrZfeW8b8hwuKu6Ts9WqklRxhag6f6SDCUX3ZSAJMIwPl9iSAYQ==
X-Received: by 2002:a1c:b388:: with SMTP id c130mr7017953wmf.175.1600092438037; 
 Mon, 14 Sep 2020 07:07:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.07.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:07:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/36] docs/system: Add Nuvoton machine documentation
Date: Mon, 14 Sep 2020 15:06:36 +0100
Message-Id: <20200914140641.21369-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
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

From: Havard Skinnemoen <hskinnemoen@google.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
Message-id: 20200911052101.2602693-14-hskinnemoen@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/nuvoton.rst | 92 +++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst  |  1 +
 2 files changed, 93 insertions(+)
 create mode 100644 docs/system/arm/nuvoton.rst

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
new file mode 100644
index 00000000000..e3e1a3a3a73
--- /dev/null
+++ b/docs/system/arm/nuvoton.rst
@@ -0,0 +1,92 @@
+Nuvoton iBMC boards (``npcm750-evb``, ``quanta-gsj``)
+=====================================================
+
+The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of ARM-based SoCs that are
+designed to be used as Baseboard Management Controllers (BMCs) in various
+servers. They all feature one or two ARM Cortex A9 CPU cores, as well as an
+assortment of peripherals targeted for either Enterprise or Data Center /
+Hyperscale applications. The former is a superset of the latter, so NPCM750 has
+all the peripherals of NPCM730 and more.
+
+.. _Nuvoton iBMC: https://www.nuvoton.com/products/cloud-computing/ibmc/
+
+The NPCM750 SoC has two Cortex A9 cores and is targeted for the Enterprise
+segment. The following machines are based on this chip :
+
+- ``npcm750-evb``       Nuvoton NPCM750 Evaluation board
+
+The NPCM730 SoC has two Cortex A9 cores and is targeted for Data Center and
+Hyperscale applications. The following machines are based on this chip :
+
+- ``quanta-gsj``        Quanta GSJ server BMC
+
+There are also two more SoCs, NPCM710 and NPCM705, which are single-core
+variants of NPCM750 and NPCM730, respectively. These are currently not
+supported by QEMU.
+
+Supported devices
+-----------------
+
+ * SMP (Dual Core Cortex-A9)
+ * Cortex-A9MPCore built-in peripherals: SCU, GIC, Global Timer, Private Timer
+   and Watchdog.
+ * SRAM, ROM and DRAM mappings
+ * System Global Control Registers (GCR)
+ * Clock and reset controller (CLK)
+ * Timer controller (TIM)
+ * Serial ports (16550-based)
+ * DDR4 memory controller (dummy interface indicating memory training is done)
+ * OTP controllers (no protection features)
+ * Flash Interface Unit (FIU; no protection features)
+
+Missing devices
+---------------
+
+ * GPIO controller
+ * LPC/eSPI host-to-BMC interface, including
+
+   * Keyboard and mouse controller interface (KBCI)
+   * Keyboard Controller Style (KCS) channels
+   * BIOS POST code FIFO
+   * System Wake-up Control (SWC)
+   * Shared memory (SHM)
+   * eSPI slave interface
+
+ * Ethernet controllers (GMAC and EMC)
+ * USB host (USBH)
+ * USB device (USBD)
+ * SMBus controller (SMBF)
+ * Peripheral SPI controller (PSPI)
+ * Analog to Digital Converter (ADC)
+ * SD/MMC host
+ * Random Number Generator (RNG)
+ * PECI interface
+ * Pulse Width Modulation (PWM)
+ * Tachometer
+ * PCI and PCIe root complex and bridges
+ * VDM and MCTP support
+ * Serial I/O expansion
+ * LPC/eSPI host
+ * Coprocessor
+ * Graphics
+ * Video capture
+ * Encoding compression engine
+ * Security features
+
+Boot options
+------------
+
+The Nuvoton machines can boot from an OpenBMC firmware image, or directly into
+a kernel using the ``-kernel`` option. OpenBMC images for `quanta-gsj` and
+possibly others can be downloaded from the OpenPOWER jenkins :
+
+   https://openpower.xyz/
+
+The firmware image should be attached as an MTD drive. Example :
+
+.. code-block:: bash
+
+  $ qemu-system-arm -machine quanta-gsj -nographic \
+      -drive file=image-bmc,if=mtd,bus=0,unit=0,format=raw
+
+The default root password for test images is usually ``0penBmc``.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index afdb37e7384..fdcf25c2375 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -86,6 +86,7 @@ undocumented; you can get a complete list by running
    arm/musicpal
    arm/gumstix
    arm/nseries
+   arm/nuvoton
    arm/orangepi
    arm/palm
    arm/xscale
-- 
2.20.1


