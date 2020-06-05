Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19706C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDFFD206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZQsAGRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFFD206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFYo-00030T-4B
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXp-00018E-KX
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:13 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXo-0001dQ-95
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:13 -0400
Received: by mail-wr1-x430.google.com with SMTP id c3so10424579wru.12
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d0wr87mnUdy9e95d4CG/7IUoBY3RN7PHOhlJdr0e89w=;
 b=UZQsAGRThuBk75wi0HN6F33KEVOXbkmvdWQesqjsO1ocOjvRW8ezm0crDRYBQqszlO
 s9pzuQ+H49PeuuvDKWm+8OuC06v/vHYxA73oj7SbM9+23UdNEP4bNNEIjbNlCbOFFKR5
 lPJXtalTv8nHvop2RUl/u6T3BCVRtKmMQBjaTCX6Sv/7bYTrf0bQGi2odG39SFIIo6V2
 QpgXx7EbdjhsjdjkQWpIU+UuHpgmE0PZmZM2tQk1Yrd50MslYpB0ILO09Rj4+q044oJ7
 EEL6/4+rm9bnftaK5EkkKZOuGKvmLd9/KHkks3NpccpfLk/rbapzlEwdx3jS0fpASXkY
 izUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d0wr87mnUdy9e95d4CG/7IUoBY3RN7PHOhlJdr0e89w=;
 b=Ch/3dIOA7cNhrp1xjdlT7wpJ3z7MgrvySk2TVjekrLkGQA4DQuMQOxIh+tUdg5tlKI
 Bzy2d/Fo8PZjU1l2fYNw7Gr6IKgU1zRas/zS33z46WE9H8SYfNWo/0ORH4XV2eeYgRtM
 nUJHzOuyCk7k0hKAKQgndKj39esSlZ9VxivFIbyMdroDGlCwCmbO8IsK0OViNmpC8K8Y
 HO4B58N1bz2MZ7Ii/mJ2WkQORBmPmpfvHBQX2K4I8G90RO3zuuixgDZ+cwDRn/PVwru0
 AETRrVDwrML4SejvkCPKpWnGWX/2j/IPrgbhPuXqmx7WTQrr9C6xyHFAUgAbnXHmS4fP
 anxA==
X-Gm-Message-State: AOAM531HtcHuEgNCNarO8+0PbL6tjqUTLh50QZL9n0f6VsUCtyt84DQd
 v0OYdjVhIveb976WQ6X4hdcMLobnzqeyAg==
X-Google-Smtp-Source: ABdhPJyth4A6acrz9gVLYzS5nz9wrXXzwlrgmz8AyBSXP7JJjWqdvSFG48XB93fbzxzZms5yBYbdSA==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr10137747wro.176.1591375809920; 
 Fri, 05 Jun 2020 09:50:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/29] target-arm queue
Date: Fri,  5 Jun 2020 17:49:38 +0100
Message-Id: <20200605165007.12095-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Arm queue; some of the simpler stuff, things other have reviewed (thanks!), etc.

-- PMM

The following changes since commit 5d2f557b47dfbf8f23277a5bdd8473d4607c681a:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200605-pull-request' into staging (2020-06-05 13:53:05 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200605

for you to fetch changes up to 2c35a39eda0b16c2ed85c94cec204bf5efb97812:

  target/arm: Convert Neon one-register-and-immediate insns to decodetree (2020-06-05 17:23:10 +0100)

----------------------------------------------------------------
target-arm queue:
 hw/ssi/imx_spi: Handle tx burst lengths other than 8 correctly
 hw/input/pxa2xx_keypad: Replace hw_error() by qemu_log_mask()
 hw/arm/pxa2xx: Replace printf() call by qemu_log_mask()
 target/arm: Convert crypto insns to gvec
 hw/adc/stm32f2xx_adc: Correct memory region size and access size
 tests/acceptance: Add a boot test for the xlnx-versal-virt machine
 docs/system: Document Aspeed boards
 raspi: Add model of the USB controller
 target/arm: Convert 2-reg-and-shift and 1-reg-imm Neon insns to decodetree

----------------------------------------------------------------
Cédric Le Goater (1):
      docs/system: Document Aspeed boards

Eden Mikitas (2):
      hw/ssi/imx_spi: changed while statement to prevent underflow
      hw/ssi/imx_spi: Removed unnecessary cast of rx data received from slave

Paul Zimmerman (7):
      raspi: add BCM2835 SOC MPHI emulation
      dwc-hsotg (dwc2) USB host controller register definitions
      dwc-hsotg (dwc2) USB host controller state definitions
      dwc-hsotg (dwc2) USB host controller emulation
      usb: add short-packet handling to usb-storage driver
      wire in the dwc-hsotg (dwc2) USB host controller emulation
      raspi2 acceptance test: add test for dwc-hsotg (dwc2) USB host

Peter Maydell (9):
      target/arm: Convert Neon VSHL and VSLI 2-reg-shift insn to decodetree
      target/arm: Convert Neon VSHR 2-reg-shift insns to decodetree
      target/arm: Convert Neon VSRA, VSRI, VRSHR, VRSRA 2-reg-shift insns to decodetree
      target/arm: Convert VQSHLU, VQSHL 2-reg-shift insns to decodetree
      target/arm: Convert Neon narrowing shifts with op==8 to decodetree
      target/arm: Convert Neon narrowing shifts with op==9 to decodetree
      target/arm: Convert Neon VSHLL, VMOVL to decodetree
      target/arm: Convert VCVT fixed-point ops to decodetree
      target/arm: Convert Neon one-register-and-immediate insns to decodetree

Philippe Mathieu-Daudé (3):
      hw/input/pxa2xx_keypad: Replace hw_error() by qemu_log_mask()
      hw/arm/pxa2xx: Replace printf() call by qemu_log_mask()
      hw/adc/stm32f2xx_adc: Correct memory region size and access size

Richard Henderson (6):
      target/arm: Convert aes and sm4 to gvec helpers
      target/arm: Convert rax1 to gvec helpers
      target/arm: Convert sha512 and sm3 to gvec helpers
      target/arm: Convert sha1 and sha256 to gvec helpers
      target/arm: Split helper_crypto_sha1_3reg
      target/arm: Split helper_crypto_sm3tt

Thomas Huth (1):
      tests/acceptance: Add a boot test for the xlnx-versal-virt machine

 docs/system/arm/aspeed.rst             |   85 ++
 docs/system/target-arm.rst             |    1 +
 hw/usb/hcd-dwc2.h                      |  190 +++++
 include/hw/arm/bcm2835_peripherals.h   |    5 +-
 include/hw/misc/bcm2835_mphi.h         |   44 +
 include/hw/usb/dwc2-regs.h             |  899 ++++++++++++++++++++
 target/arm/helper.h                    |   45 +-
 target/arm/translate-a64.h             |    3 +
 target/arm/vec_internal.h              |   33 +
 target/arm/neon-dp.decode              |  214 ++++-
 hw/adc/stm32f2xx_adc.c                 |    4 +-
 hw/arm/bcm2835_peripherals.c           |   38 +-
 hw/arm/pxa2xx.c                        |   66 +-
 hw/input/pxa2xx_keypad.c               |   10 +-
 hw/misc/bcm2835_mphi.c                 |  191 +++++
 hw/ssi/imx_spi.c                       |    4 +-
 hw/usb/dev-storage.c                   |   15 +-
 hw/usb/hcd-dwc2.c                      | 1417 ++++++++++++++++++++++++++++++++
 target/arm/crypto_helper.c             |  267 ++++--
 target/arm/translate-a64.c             |  198 ++---
 target/arm/translate-neon.inc.c        |  796 ++++++++++++++----
 target/arm/translate.c                 |  539 +-----------
 target/arm/vec_helper.c                |   12 +-
 hw/misc/Makefile.objs                  |    1 +
 hw/usb/Kconfig                         |    5 +
 hw/usb/Makefile.objs                   |    1 +
 hw/usb/trace-events                    |   50 ++
 tests/acceptance/boot_linux_console.py |   35 +-
 28 files changed, 4258 insertions(+), 910 deletions(-)
 create mode 100644 docs/system/arm/aspeed.rst
 create mode 100644 hw/usb/hcd-dwc2.h
 create mode 100644 include/hw/misc/bcm2835_mphi.h
 create mode 100644 include/hw/usb/dwc2-regs.h
 create mode 100644 target/arm/vec_internal.h
 create mode 100644 hw/misc/bcm2835_mphi.c
 create mode 100644 hw/usb/hcd-dwc2.c

