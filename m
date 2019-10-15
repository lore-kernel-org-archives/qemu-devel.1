Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35406ECE596
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B5D217D6
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixjgDo4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B5D217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQRK-0007jV-48
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iKQQC-00071y-VN
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iKQQA-0007wJ-Nd
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:15:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iKQQA-0007vE-EL
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:15:42 -0400
Received: by mail-wr1-x443.google.com with SMTP id j18so24807626wrq.10
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P9FI3xy5T6ZPTjV1mRqBpOBPngWCbdi+cvfrJ3CQlbw=;
 b=ixjgDo4PH5mqyWWf3PunUoVhy619saLe6VdfcqPy/U2gY2YGXkN/BGmyc5TMBMI1cy
 zbRVH8NeF9TVA5pf7z+CkGcEIWdz49ai5gVyPW/c0JQLgiPvF0qpbtUFOo4rVh0Wel3Y
 EfrtxjMFK1/CwuzjY9eO3pN0YYWZgCByQSMljYmdNAx6FyhUxpKz032O4vGiQpQXTrFy
 wXD2MdO/RY+maLe28KMsMtN7USyMl4EAUTmXfbIMXNmx0IGn88q6I+mRDecybAB2T0vh
 xn2pEir6JW8uzNTH42MUw8cjlrrvJSc4Wws7Px0pnxFvbIrgFbuaKLoJE5WIaVW+INuj
 XZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P9FI3xy5T6ZPTjV1mRqBpOBPngWCbdi+cvfrJ3CQlbw=;
 b=XRboeVf7UVyQd3rXHtXoRkm2vsA+V+o55euBI+QV8qOULD48wMzVNXFyr/nOrgGSRt
 5pfmj8Gx8iWbj8K8j0PCnnH21YdtSKWt4trjrrmuy1wd8OvSS33lBalnsM722LJjPdnX
 CM/qnp+ursymX/lzlrlrZxL/D1JrLklKBi1jNT9lkzO3NJBYewdj0cgNhrltosXfo9FX
 lP0cxgSyMdi+CeUSV1o5vMPjaMl8lZ0ec1gU6QToM10f96HMUKd2AvGmUpxRP3yHgBgA
 b2cipPWZ6TEyuZWvW4whnAHnDrgtjVKHFUad1Hr1gUgwT/ZqEYsOi+XH2gTLbzxhpjsy
 XBUw==
X-Gm-Message-State: APjAAAVqaGL61+EbkGL6rZMZvsGSANlo0tW/QSjOUDgtwHjsyMQXmfjr
 2UIipWZg/e54igS1osZ6IVMZU3yWTAaCaA==
X-Google-Smtp-Source: APXvYqyZeyu/B+fp3Ch7eFudjYoAecLee78p7K6SDwXkD0OjEwpUowj5QJwysTh3hFxSLYIWhVUf0g==
X-Received: by 2002:adf:f983:: with SMTP id f3mr31124955wrr.169.1571159740453; 
 Tue, 15 Oct 2019 10:15:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f20sm17764586wmb.6.2019.10.15.10.15.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 10:15:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/67] target-arm queue
Date: Tue, 15 Oct 2019 18:15:37 +0100
Message-Id: <20191015171537.12499-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

v1->v2 changes: dropped the patch adding the new ast2600
board, as it doesn't pass "make check" on 32-bit hosts or
low-memory hosts.

thanks
-- PMM

The following changes since commit 3af78db68176a049e2570822f64604e0692c1447:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-10-15 13:25:05 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191015

for you to fetch changes up to 19845504da1bdee4be7d0fba33da5be9efa4c11b:

  hw/misc/bcm2835_mbox: Add trace events (2019-10-15 18:09:05 +0100)

----------------------------------------------------------------
target-arm queue:
 * Add Aspeed AST2600 SoC support (but no new board model yet)
 * aspeed/wdt: Check correct register for clock source
 * bcm2835: code cleanups, better logging, trace events
 * implement v2.0 of the Arm semihosting specification
 * provide new 'transaction-based' ptimer API and use it
   for the Arm devices that use ptimers
 * ARM: KVM: support more than 256 CPUs

----------------------------------------------------------------
Amithash Prasad (1):
      aspeed/wdt: Check correct register for clock source

Cédric Le Goater (14):
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
 hw/arm/aspeed.c                               |  19 +-
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
 105 files changed, 3934 insertions(+), 650 deletions(-)
 create mode 100644 include/hw/sd/aspeed_sdhci.h
 create mode 100644 include/standard-headers/linux/virtio_fs.h
 create mode 100644 include/standard-headers/linux/virtio_iommu.h
 create mode 100644 hw/arm/aspeed_ast2600.c
 create mode 100644 hw/sd/aspeed_sdhci.c

