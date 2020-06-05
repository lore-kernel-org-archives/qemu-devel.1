Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3B1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BBEF2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwWV2upf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBEF2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFcN-0002Un-PO
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFY2-0001aa-PH
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:27 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:52137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFY1-0001g4-Jg
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id u13so9071917wml.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=p06xAuPBqkUPgldQtU+c9R5ekbMeiVqYhWcLz5TebRE=;
 b=KwWV2upfxjEypAAX1eUz1ZlPpRYgXJbwIdGphNRwPDPNzjKohrYELUuroPwEVY4yTn
 PKN+bNQoDHnkZSo1jKWIF4JYMF5rdm9taPeRokjsm43O+jrwZ4ciMF9wVSzyHXVBhqrT
 N7JykBslj+WngW3Fo2vkdLRNxLEZtNKwmJIJXoh2pCiHLvonfPdaFS6ViAeDIMhRWA5B
 uykxtidFTKnuwK5SrjzZC4V/z4l9c/3WQRf4119HAYM9xWlG4W0o+oU/cx+SdUGwvDbE
 KDPWoM2xWqP4lA/YX5Powqo73GiMKYzrfkF9sNjr+xdZArSoK6KrAu0Y7ox0HbZPwZl8
 6tRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p06xAuPBqkUPgldQtU+c9R5ekbMeiVqYhWcLz5TebRE=;
 b=Yqd19AdZtMUMVA7TXXy3eVKviWcjCAXEGmel8DTba2z+u0velxpLuI0AqMU17CJiJd
 u2sG+2MLFy7XngykcPvK2qZz8kTqG8FI10/mV56d4r6FZXaMxksfQm1gCeZ6Ix3P4plo
 dOnDEc9oMuQ8CwZKue+TS+87MyXbwY3OF9Z+CokIXrZEkY2VSZvMsyxXBzmW3q4N8ZKI
 UToFay1E3hLCgcD6ibdlSMGxEUoNIukLU7fztZanghibnFtN28+57hjaLT2NgP08yvuv
 RveAap9Ps9wkxCnq8fOFohjsw9Bd5dyApA3GUmEr0mGP5Eh8f9kcUl96YbYcD6g5adkX
 Pz5Q==
X-Gm-Message-State: AOAM531m0Y3+W0lzRPuW2UVM4sr7M6+4+Nhx8jmjeYtHdvUctIvExCX/
 4Qgs212G+VDUZkZwTjuD8tvcA7bzzyZAiA==
X-Google-Smtp-Source: ABdhPJy4QQBghKDGUAUkbKZuyK8iCB9TjqBI26EVXEkJIW/Pfxv1jxOpMtGUR1hsHShJksazl7KKGw==
X-Received: by 2002:a1c:6243:: with SMTP id w64mr3518060wmb.162.1591375823816; 
 Fri, 05 Jun 2020 09:50:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/29] docs/system: Document Aspeed boards
Date: Fri,  5 Jun 2020 17:49:51 +0100
Message-Id: <20200605165007.12095-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Cédric Le Goater <clg@kaod.org>

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200602135050.593692-1-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/aspeed.rst | 85 ++++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst |  1 +
 2 files changed, 86 insertions(+)
 create mode 100644 docs/system/arm/aspeed.rst

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
new file mode 100644
index 00000000000..45f891eb3ca
--- /dev/null
+++ b/docs/system/arm/aspeed.rst
@@ -0,0 +1,85 @@
+Aspeed family boards (``*-bmc``, ``ast2500-evb``, ``ast2600-evb``)
+==================================================================
+
+The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
+Aspeed evaluation boards. They are based on different releases of the
+Aspeed SoC : the AST2400 integrating an ARM926EJ-S CPU (400MHz), the
+AST2500 with an ARM1176JZS CPU (800MHz) and more recently the AST2600
+with dual cores ARM Cortex A7 CPUs (1.2GHz).
+
+The SoC comes with RAM, Gigabit ethernet, USB, SD/MMC, USB, SPI, I2C,
+etc.
+
+AST2400 SoC based machines :
+
+- ``palmetto-bmc``         OpenPOWER Palmetto POWER8 BMC
+
+AST2500 SoC based machines :
+
+- ``ast2500-evb``          Aspeed AST2500 Evaluation board
+- ``romulus-bmc``          OpenPOWER Romulus POWER9 BMC
+- ``witherspoon-bmc``      OpenPOWER Witherspoon POWER9 BMC
+- ``sonorapass-bmc``       OCP SonoraPass BMC
+- ``swift-bmc``            OpenPOWER Swift BMC POWER9
+
+AST2600 SoC based machines :
+
+- ``ast2600-evb``          Aspeed AST2600 Evaluation board (Cortex A7)
+- ``tacoma-bmc``           OpenPOWER Witherspoon POWER9 AST2600 BMC
+
+Supported devices
+-----------------
+
+ * SMP (for the AST2600 Cortex-A7)
+ * Interrupt Controller (VIC)
+ * Timer Controller
+ * RTC Controller
+ * I2C Controller
+ * System Control Unit (SCU)
+ * SRAM mapping
+ * X-DMA Controller (basic interface)
+ * Static Memory Controller (SMC or FMC) - Only SPI Flash support
+ * SPI Memory Controller
+ * USB 2.0 Controller
+ * SD/MMC storage controllers
+ * SDRAM controller (dummy interface for basic settings and training)
+ * Watchdog Controller
+ * GPIO Controller (Master only)
+ * UART
+ * Ethernet controllers
+
+
+Missing devices
+---------------
+
+ * Coprocessor support
+ * ADC (out of tree implementation)
+ * PWM and Fan Controller
+ * LPC Bus Controller
+ * Slave GPIO Controller
+ * Super I/O Controller
+ * Hash/Crypto Engine
+ * PCI-Express 1 Controller
+ * Graphic Display Controller
+ * PECI Controller
+ * MCTP Controller
+ * Mailbox Controller
+ * Virtual UART
+ * eSPI Controller
+ * I3C Controller
+
+Boot options
+------------
+
+The Aspeed machines can be started using the -kernel option to load a
+Linux kernel or from a firmare image which can be downloaded from the
+OpenPOWER jenkins :
+
+   https://openpower.xyz/
+
+The image should be attached as an MTD drive. Run :
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M romulus-bmc -nic user \
+	-drive file=flash-romulus,format=raw,if=mtd -nographic
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index dce384cb0e3..1bd477a2936 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -81,6 +81,7 @@ undocumented; you can get a complete list by running
    arm/realview
    arm/versatile
    arm/vexpress
+   arm/aspeed
    arm/musicpal
    arm/nseries
    arm/orangepi
-- 
2.20.1


