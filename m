Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BF2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BB221734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePEVKqrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BB221734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugdM-00062z-CJ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRT-00005P-Cl
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRR-0003Yd-Qh
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:47 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:33976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRR-0003XU-II
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:45 -0500
Received: by mail-wr1-x42f.google.com with SMTP id t2so3585033wrr.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BmL12HoYmCQ7eicWGWszUtewlEZQ98uMDHEdW47RVUQ=;
 b=ePEVKqrrADut6vYzXYAVKrxSfqcrl8oRHB+LhEtXFbsZFfeLdVBtKmGV1/MGU2wYvi
 s4E13nxA6FYSdc36qSi9kkvGbNUiboBX/u9Hz/vNXGxWLca8wVsoZScj8/ypwyFGb1oc
 Z3A7AR0IDVJuyiLszjHauCEBg+inAFYi7PTRThymLBQA1f6E5eosEMRU7PKi87yt5hdc
 pe/TGh/FsffLh02zDZ6dhJwCqcUuvKnddGp2i8+GqowBDzyodcFsst6G+x0CgDlVpKt5
 66wL1FGczIvw8UBT9tL2v71sja81DGD4btcqXsSC65aLlEUcqpFVIyd7Wc1LknTjsdnA
 z8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BmL12HoYmCQ7eicWGWszUtewlEZQ98uMDHEdW47RVUQ=;
 b=R3ICgtdq5inwnpJo6TavMi3lbjAP7ZcgBZRxq873BeoPgXgF4SvB2rI2XXbA1bZDR4
 KDvAxKGSxu4Xa56LZbb7a5mI91nue/WmAI1zZpm5GR/I64zXcrF34YuF1LiN8AFF1j8a
 MXdOl/bYOh8ZSAJeUiMXibolYL0LyaL45mqtXzbIclWQZkeRyiiyyyTlDy+eOV9ppuyS
 tFIMbI/Yjbfs5G83fyKTdPPYaaPvhFhFi9xiTM/dXIi1V+l1FpGp19lLbhwQCrhlcEb3
 6QIv446vNuuTqog1z45uFiwO4fY0yA3VSdyJQMfHWlbrzJjt2QtYVcMVJNN3Jr+KQkgA
 8t8Q==
X-Gm-Message-State: APjAAAWxR3V2xWsFul5+WljYOcga1s5WS9oGRp9inXP3XPJyKdGqDdUl
 58Rlj5rNzCK1ap554HG6vqR3RJ096Wbccw==
X-Google-Smtp-Source: APXvYqxFQ59T9ghBu9j4jyY2uh+mDwe511J2XFJSLUeWMSKK8j279UO5MrFONwrVudTLS4zO62cibA==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr19166116wrq.57.1579793443724; 
 Thu, 23 Jan 2020 07:30:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.30.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:30:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] target-arm queue
Date: Thu, 23 Jan 2020 15:30:21 +0000
Message-Id: <20200123153041.4248-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

The following changes since commit b7c359c748a2e3ccb97a184b9739feb2cd48de2f:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pull-request' into staging (2020-01-23 14:38:43 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200123

for you to fetch changes up to 53c75ad8e72dc3a5102de7ed21e4990969cb0a19:

  hw/arm/exynos4210: Connect serial port DMA busy signals with pl330 (2020-01-23 15:22:42 +0000)

----------------------------------------------------------------
target-arm queue:
 * fix bug in PAuth emulation
 * add PMU to Cortex-R5, Cortex-R5F
 * qemu-nbd: Convert documentation to rST
 * qemu-block-drivers: Convert documentation to rST
 * Fix Exynos4210 UART DMA support
 * Various minor code cleanups

----------------------------------------------------------------
Andrew Jones (1):
      target/arm/arch_dump: Add SVE notes

Clement Deschamps (1):
      target/arm: add PMU feature to cortex-r5 and cortex-r5f

Guenter Roeck (8):
      dma/pl330: Convert to support tracing
      hw/core/or-irq: Increase limit of or-lines to 48
      hw/arm/exynos4210: Fix DMA initialization
      hw/char/exynos4210_uart: Convert to support tracing
      hw/char/exynos4210_uart: Implement post_load function
      hw/char/exynos4210_uart: Implement Rx FIFO level triggers and timeouts
      hw/char/exynos4210_uart: Add receive DMA support
      hw/arm/exynos4210: Connect serial port DMA busy signals with pl330

Keqian Zhu (2):
      hw/acpi: Remove extra indent in ACPI GED hotplug cb
      hw/arm: Use helper function to trigger hotplug handler plug

Peter Maydell (3):
      qemu-nbd: Convert invocation documentation to rST
      docs: Create stub system manual
      qemu-block-drivers: Convert to rST

Philippe Mathieu-Daudé (1):
      hw/misc/stm32f4xx_syscfg: Fix copy/paste error

Richard Henderson (3):
      tests/tcg/aarch64: Fix compilation parameters for pauth-%
      tests/tcg/aarch64: Add pauth-3
      tests/tcg/aarch64: Add pauth-4

Vincent Dehors (1):
      target/arm: Fix PAuth sbox functions

 Makefile                                  |  37 +-
 tests/tcg/aarch64/Makefile.softmmu-target |   5 +-
 tests/tcg/aarch64/Makefile.target         |   3 +-
 include/elf.h                             |   1 +
 include/hw/arm/exynos4210.h               |   4 +
 include/hw/or-irq.h                       |   2 +-
 target/arm/cpu.h                          |  25 +
 hw/acpi/generic_event_device.c            |   2 +-
 hw/arm/exynos4210.c                       |  77 ++-
 hw/arm/virt.c                             |   6 +-
 hw/char/exynos4210_uart.c                 | 245 +++++---
 hw/dma/pl330.c                            |  88 +--
 hw/misc/stm32f4xx_syscfg.c                |   2 +-
 target/arm/arch_dump.c                    | 124 +++-
 target/arm/cpu.c                          |   1 +
 target/arm/kvm64.c                        |  24 -
 target/arm/pauth_helper.c                 |   4 +-
 tests/tcg/aarch64/pauth-1.c               |   2 -
 tests/tcg/aarch64/pauth-2.c               |   2 -
 tests/tcg/aarch64/pauth-4.c               |  25 +
 tests/tcg/aarch64/system/pauth-3.c        |  40 ++
 MAINTAINERS                               |   1 +
 docs/index.html.in                        |   1 +
 docs/interop/conf.py                      |   4 +-
 docs/interop/index.rst                    |   1 +
 docs/interop/qemu-nbd.rst                 | 263 ++++++++
 docs/interop/qemu-option-trace.rst.inc    |  30 +
 docs/qemu-block-drivers.texi              | 889 ---------------------------
 docs/system/conf.py                       |  22 +
 docs/system/index.rst                     |  17 +
 docs/system/qemu-block-drivers.rst        | 985 ++++++++++++++++++++++++++++++
 hw/char/trace-events                      |  20 +
 hw/dma/trace-events                       |  24 +
 qemu-doc.texi                             |  18 -
 qemu-nbd.texi                             | 214 -------
 qemu-option-trace.texi                    |   4 +
 qemu-options.hx                           |   2 +-
 37 files changed, 1897 insertions(+), 1317 deletions(-)
 create mode 100644 tests/tcg/aarch64/pauth-4.c
 create mode 100644 tests/tcg/aarch64/system/pauth-3.c
 create mode 100644 docs/interop/qemu-nbd.rst
 create mode 100644 docs/interop/qemu-option-trace.rst.inc
 delete mode 100644 docs/qemu-block-drivers.texi
 create mode 100644 docs/system/conf.py
 create mode 100644 docs/system/index.rst
 create mode 100644 docs/system/qemu-block-drivers.rst
 delete mode 100644 qemu-nbd.texi

