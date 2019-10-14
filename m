Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA70EC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824752133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="plXLI36N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824752133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK334-0004GL-6l
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pQ-0003Eg-N6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pO-0006ij-9j
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:38255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2pO-0006gN-0l
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:10 -0400
Received: by mail-wm1-x329.google.com with SMTP id 3so17309459wmi.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2iBSUbF+D74lhF2JQuHBB11TedsOiA6uD15DmsrniE8=;
 b=plXLI36NUkxzRlEclcDqSjEIkDWbExotm4ibhXKRSWP6MbQBsb439aYMSo43DOwiO0
 JdDFugMRAMx1G2kkmUl9id1DLoYdL/BXP9FiaHKdUOZL+SxH3oclyxLBU6L0FMBV5uj0
 IGhhbLM2owLkQiQ4jkYTiRMAnTcuDINp0US7QK1BTerF496OIHftMPKkyuRQ3gmBARJs
 ouT4DeeFq3cC+cHf75I4cZXXo0W8m97S4CGPb3m7pctEYQZYUfivqYOSSTLkwmOgUrs5
 jR82R83FuMO0sDRJiY37k8P3/t7FFZqJJqsRa9PCesIr45l/9QklQs6mVJMOst/w+HAH
 utgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2iBSUbF+D74lhF2JQuHBB11TedsOiA6uD15DmsrniE8=;
 b=Gpck3oXZLzWoDo2zQZ+O8t6cBS7dN2Rg1t0qCwBkhB9YSodHET5M1cOTgotzSqgLsd
 g8yEVlOpSn6CcywkxiaC3rQ6dPYXgO8n5dOgILqopEXX3h03oyQ3SfzUkGEKQnGzTAds
 SVxYFCIrnxUIWY6BPGmsBMo8wYOsQ46WDkT9/wUjpTQKLTyDxJqwFBZjRwQHdsFahRYy
 5wFjKp3AZ8ZUtbNsZN0pF1TeN7Xg61fPqe4/+3Yfqk+7SDr06H/TOuGlN/os5Pg0Ob5u
 RSOPTHRMfEwpnK6xF99/IM0lM5KP0DWSomYxgQ9QBJX9ZtaSFCxLlxRs+CJF9HXM+1SQ
 9Mew==
X-Gm-Message-State: APjAAAX3mGOMCJprBm7GEsmYvMP3SVzIZ8wWjRL3CLRH3uxVmNcpE/Ca
 aBYMYZy5+j5b6VlR62aiD0Tx5DlCpLF/ww==
X-Google-Smtp-Source: APXvYqx+PpmJr2Tx6XNhHtKwQNK5CnPGRv8rKOvDhmwJLlGkOBiAWQR4CUImFd284wwnhe/U8TeWyA==
X-Received: by 2002:a1c:8043:: with SMTP id b64mr15102283wmd.145.1571069047230; 
 Mon, 14 Oct 2019 09:04:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/68] target-arm queue
Date: Mon, 14 Oct 2019 17:02:56 +0100
Message-Id: <20191014160404.19553-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

A large arm pullreq, mostly because of 3 series:
 * aspeed 2600 support
 * semihosting v2.0 support
 * transaction-based ptimers

thanks
-- PMM

The following changes since commit 22dbfdecc3c52228d3489da3fe81da92b21197bf:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-update-20191010.0' into staging (2019-10-14 15:09:08 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191014

for you to fetch changes up to bca1936f8f66c5f8a111569ffd14969de208bf3b:

  hw/misc/bcm2835_mbox: Add trace events (2019-10-14 16:48:56 +0100)

----------------------------------------------------------------
target-arm queue:
 * Add Aspeed AST2600 SoC and board support
 * aspeed/wdt: Check correct register for clock source
 * bcm2835: code cleanups, better logging, trace events
 * implement v2.0 of the Arm semihosting specification
 * provide new 'transaction-based' ptimer API and use it
   for the Arm devices that use ptimers
 * ARM: KVM: support more than 256 CPUs

----------------------------------------------------------------
Amithash Prasad (1):
      aspeed/wdt: Check correct register for clock source

Cédric Le Goater (15):
      aspeed/timer: Introduce an object class per SoC
      aspeed/timer: Add support for control register 3
      aspeed/timer: Add AST2600 support
      aspeed/timer: Add support for IRQ status register on the AST2600
      aspeed/sdmc: Introduce an object class per SoC
      watchdog/aspeed: Introduce an object class per SoC
      aspeed/smc: Introduce segment operations
      aspeed/smc: Add AST2600 support
      aspeed/i2c: Introduce an object class per SoC
      aspeed/i2c: Add AST2600 support
      aspeed: Introduce an object class per SoC
      aspeed/soc: Add AST2600 support
      m25p80: Add support for w25q512jv
      aspeed: Add an AST2600 eval board
      aspeed: add support for the Aspeed MII controller of the AST2600

Eddie James (1):
      hw/sd/aspeed_sdhci: New device

Eric Auger (3):
      linux headers: update against v5.4-rc1
      intc/arm_gic: Support IRQ injection for more than 256 vpus
      ARM: KVM: Check KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 for smp_cpus > 256

Joel Stanley (5):
      hw: aspeed_scu: Add AST2600 support
      aspeed/sdmc: Add AST2600 support
      hw: wdt_aspeed: Add AST2600 support
      aspeed: Parameterise number of MACs
      aspeed/soc: Add ASPEED Video stub

Peter Maydell (36):
      ptimer: Rename ptimer_init() to ptimer_init_with_bh()
      ptimer: Provide new transaction-based API
      tests/ptimer-test: Switch to transaction-based ptimer API
      hw/timer/arm_timer.c: Switch to transaction-based ptimer API
      hw/arm/musicpal.c: Switch to transaction-based ptimer API
      hw/timer/allwinner-a10-pit.c: Switch to transaction-based ptimer API
      hw/timer/arm_mptimer.c: Switch to transaction-based ptimer API
      hw/timer/cmsdk-apb-dualtimer.c: Switch to transaction-based ptimer API
      hw/timer/cmsdk-apb-timer.c: Switch to transaction-based ptimer API
      hw/timer/digic-timer.c: Switch to transaction-based ptimer API
      hw/timer/exynos4210_mct.c: Switch GFRC to transaction-based ptimer API
      hw/timer/exynos4210_mct.c: Switch LFRC to transaction-based ptimer API
      hw/timer/exynos4210_mct.c: Switch ltick to transaction-based ptimer API
      hw/timer/exynos4210_pwm.c: Switch to transaction-based ptimer API
      hw/timer/exynos4210_rtc.c: Switch 1Hz ptimer to transaction-based API
      hw/timer/exynos4210_rtc.c: Switch main ptimer to transaction-based API
      hw/timer/imx_epit.c: Switch to transaction-based ptimer API
      hw/timer/imx_gpt.c: Switch to transaction-based ptimer API
      hw/timer/mss-timerc: Switch to transaction-based ptimer API
      hw/watchdog/cmsdk-apb-watchdog.c: Switch to transaction-based ptimer API
      hw/net/lan9118.c: Switch to transaction-based ptimer API
      target/arm/arm-semi: Capture errno in softmmu version of set_swi_errno()
      target/arm/arm-semi: Always set some kind of errno for failed calls
      target/arm/arm-semi: Correct comment about gdb syscall races
      target/arm/arm-semi: Make semihosting code hand out its own file descriptors
      target/arm/arm-semi: Restrict use of TaskState*
      target/arm/arm-semi: Use set_swi_errno() in gdbstub callback functions
      target/arm/arm-semi: Factor out implementation of SYS_CLOSE
      target/arm/arm-semi: Factor out implementation of SYS_WRITE
      target/arm/arm-semi: Factor out implementation of SYS_READ
      target/arm/arm-semi: Factor out implementation of SYS_ISTTY
      target/arm/arm-semi: Factor out implementation of SYS_SEEK
      target/arm/arm-semi: Factor out implementation of SYS_FLEN
      target/arm/arm-semi: Implement support for semihosting feature detection
      target/arm/arm-semi: Implement SH_EXT_EXIT_EXTENDED extension
      target/arm/arm-semi: Implement SH_EXT_STDOUT_STDERR extension

Philippe Mathieu-Daudé (6):
      hw/arm/raspi: Use the IEC binary prefix definitions
      hw/arm/bcm2835_peripherals: Improve logging
      hw/arm/bcm2835_peripherals: Name various address spaces
      hw/arm/bcm2835: Rename some definitions
      hw/arm/bcm2835: Add various unimplemented peripherals
      hw/misc/bcm2835_mbox: Add trace events

Rashmica Gupta (1):
      hw/gpio: Add in AST2600 specific implementation

 hw/arm/Makefile.objs                          |   2 +-
 hw/sd/Makefile.objs                           |   1 +
 include/hw/arm/aspeed.h                       |   1 +
 include/hw/arm/aspeed_soc.h                   |  29 +-
 include/hw/arm/bcm2835_peripherals.h          |  15 +
 include/hw/arm/raspi_platform.h               |  24 +-
 include/hw/i2c/aspeed_i2c.h                   |  20 +-
 include/hw/misc/aspeed_scu.h                  |   7 +-
 include/hw/misc/aspeed_sdmc.h                 |  20 +-
 include/hw/net/ftgmac100.h                    |  17 +
 include/hw/ptimer.h                           |  83 ++-
 include/hw/sd/aspeed_sdhci.h                  |  34 ++
 include/hw/ssi/aspeed_smc.h                   |   4 +
 include/hw/timer/aspeed_timer.h               |  18 +
 include/hw/timer/mss-timer.h                  |   1 -
 include/hw/watchdog/wdt_aspeed.h              |  19 +-
 include/standard-headers/asm-x86/bootparam.h  |   2 +
 include/standard-headers/asm-x86/kvm_para.h   |   1 +
 include/standard-headers/linux/ethtool.h      |  24 +
 include/standard-headers/linux/pci_regs.h     |  19 +-
 include/standard-headers/linux/virtio_fs.h    |  19 +
 include/standard-headers/linux/virtio_ids.h   |   2 +
 include/standard-headers/linux/virtio_iommu.h | 165 ++++++
 include/standard-headers/linux/virtio_pmem.h  |   6 +-
 linux-headers/asm-arm/kvm.h                   |  16 +-
 linux-headers/asm-arm/unistd-common.h         |   2 +
 linux-headers/asm-arm64/kvm.h                 |  21 +-
 linux-headers/asm-generic/mman-common.h       |  18 +-
 linux-headers/asm-generic/mman.h              |  10 +-
 linux-headers/asm-generic/unistd.h            |  10 +-
 linux-headers/asm-mips/mman.h                 |   3 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/mman.h              |   6 +-
 linux-headers/asm-powerpc/unistd_32.h         |   2 +
 linux-headers/asm-powerpc/unistd_64.h         |   2 +
 linux-headers/asm-s390/kvm.h                  |   6 +
 linux-headers/asm-s390/unistd_32.h            |   2 +
 linux-headers/asm-s390/unistd_64.h            |   2 +
 linux-headers/asm-x86/kvm.h                   |  28 +-
 linux-headers/asm-x86/unistd.h                |   2 +-
 linux-headers/asm-x86/unistd_32.h             |   2 +
 linux-headers/asm-x86/unistd_64.h             |   2 +
 linux-headers/asm-x86/unistd_x32.h            |   2 +
 linux-headers/linux/kvm.h                     |  12 +-
 linux-headers/linux/psp-sev.h                 |   5 +-
 linux-headers/linux/vfio.h                    |  71 ++-
 target/arm/kvm_arm.h                          |   1 +
 hw/arm/aspeed.c                               |  42 +-
 hw/arm/aspeed_ast2600.c                       | 523 +++++++++++++++++++
 hw/arm/aspeed_soc.c                           | 199 +++++---
 hw/arm/bcm2835_peripherals.c                  |  38 +-
 hw/arm/bcm2836.c                              |   2 +-
 hw/arm/musicpal.c                             |  16 +-
 hw/arm/raspi.c                                |   4 +-
 hw/block/m25p80.c                             |   1 +
 hw/char/bcm2835_aux.c                         |   5 +-
 hw/core/ptimer.c                              | 154 +++++-
 hw/display/bcm2835_fb.c                       |   2 +-
 hw/dma/bcm2835_dma.c                          |  10 +-
 hw/dma/xilinx_axidma.c                        |   2 +-
 hw/gpio/aspeed_gpio.c                         | 142 +++++-
 hw/i2c/aspeed_i2c.c                           | 106 +++-
 hw/intc/arm_gic_kvm.c                         |   7 +-
 hw/intc/bcm2836_control.c                     |   7 +-
 hw/m68k/mcf5206.c                             |   2 +-
 hw/m68k/mcf5208.c                             |   2 +-
 hw/misc/aspeed_scu.c                          | 194 ++++++-
 hw/misc/aspeed_sdmc.c                         | 250 ++++++---
 hw/misc/bcm2835_mbox.c                        |  14 +-
 hw/misc/bcm2835_property.c                    |  20 +-
 hw/net/fsl_etsec/etsec.c                      |   2 +-
 hw/net/ftgmac100.c                            | 162 ++++++
 hw/net/lan9118.c                              |  11 +-
 hw/sd/aspeed_sdhci.c                          | 198 ++++++++
 hw/ssi/aspeed_smc.c                           | 177 ++++++-
 hw/timer/allwinner-a10-pit.c                  |  12 +-
 hw/timer/altera_timer.c                       |   2 +-
 hw/timer/arm_mptimer.c                        |  18 +-
 hw/timer/arm_timer.c                          |  16 +-
 hw/timer/aspeed_timer.c                       | 213 +++++++-
 hw/timer/cmsdk-apb-dualtimer.c                |  14 +-
 hw/timer/cmsdk-apb-timer.c                    |  15 +-
 hw/timer/digic-timer.c                        |  16 +-
 hw/timer/etraxfs_timer.c                      |   6 +-
 hw/timer/exynos4210_mct.c                     | 107 +++-
 hw/timer/exynos4210_pwm.c                     |  17 +-
 hw/timer/exynos4210_rtc.c                     |  22 +-
 hw/timer/grlib_gptimer.c                      |   2 +-
 hw/timer/imx_epit.c                           |  32 +-
 hw/timer/imx_gpt.c                            |  21 +-
 hw/timer/lm32_timer.c                         |   2 +-
 hw/timer/milkymist-sysctl.c                   |   4 +-
 hw/timer/mss-timer.c                          |  11 +-
 hw/timer/puv3_ost.c                           |   2 +-
 hw/timer/sh_timer.c                           |   2 +-
 hw/timer/slavio_timer.c                       |   2 +-
 hw/timer/xilinx_timer.c                       |   2 +-
 hw/watchdog/cmsdk-apb-watchdog.c              |  13 +-
 hw/watchdog/wdt_aspeed.c                      | 153 +++---
 target/arm/arm-semi.c                         | 707 +++++++++++++++++++++-----
 target/arm/cpu.c                              |  10 +-
 target/arm/kvm.c                              |  22 +-
 tests/ptimer-test.c                           | 106 +++-
 hw/misc/trace-events                          |   6 +
 106 files changed, 3958 insertions(+), 650 deletions(-)
 create mode 100644 include/hw/sd/aspeed_sdhci.h
 create mode 100644 include/standard-headers/linux/virtio_fs.h
 create mode 100644 include/standard-headers/linux/virtio_iommu.h
 create mode 100644 hw/arm/aspeed_ast2600.c
 create mode 100644 hw/sd/aspeed_sdhci.c

