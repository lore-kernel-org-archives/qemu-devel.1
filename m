Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A348EC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F5B21655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="THgtsBrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F5B21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXO6J-0001TE-7n
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPM-0001Bl-AM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:44:56 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPA-0004OC-F5
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:44:55 -0400
Received: by mail-wm1-x329.google.com with SMTP id w23so1060755wmi.4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bzOemMMziQnSbiKMC0kHPZJ+XLEmi9SVdIHzXguz6BI=;
 b=THgtsBrf88yZ5qP1PXOAvSmi957WnZHtlcIWrlmNyiyILgGTNwjqNyYbrn8uLYHqZR
 XB+2FjXeIfvqWYmpi4oiwBc4mkNMXwUEzGQcCCpP2BcLX2m/ylgAHVfQ1PsMJJn+Y7HE
 lZXSDQaWOjazLP4Z5zOnLC07Mpl9n4byq7gxhIgIFgGMmhTNh9j+klCrBQwVoUQiGqzc
 an3q0itPjUdKModC2VCrzBClkHaTpy8TJ+m9qbC8eIARDSA6+oEp5M0DgKH54FWtzbE5
 nK0a0ZaFAUGZoG5rU3M9LBYs0HP5E1/pRYrqSsV0yR4X+ntrnslWrTCFQd1sRpUEiJEi
 RmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bzOemMMziQnSbiKMC0kHPZJ+XLEmi9SVdIHzXguz6BI=;
 b=pGiXFtV/EnWWIW6EorINs/TEedN05VCsrVC4kEhkbM6xJr4OwyBqckZTiTCmmXIrSQ
 EmewWlPb2F15UGxrSat7CmqhQd0d6nE2r6fGVOHrt8wrVBpxQ0hYBCBT5ny028X+Nka7
 7+xazrTGa3FR2r7PRGQtruBC+cmH9ZD1KsTd67pC/qCSLogY5IuGPBBxUt/rEk9GBAvv
 NmF9hHCmu8TtCIJ4ARrlP4w5MTswwDklCegutT1A91fns0DSoYusRI2SUVc5mNiq1FiX
 hl9n4tmWVFJbYMPr0lU9GwUKZQo0M3n6votU5O4fxP+VMZpx+HZVvA+YaEntvF8Gu6vq
 CuXQ==
X-Gm-Message-State: AOAM5329rJE2xjoYaXNMouhdhARbI1R0Duur96alPuLyxKNV6RZhXaXI
 EodKFDkCin4/g3O8MBAmPgiyYcqc1pnllg==
X-Google-Smtp-Source: ABdhPJwnT7ajOMPpQvs5tORJ/7gdrvB5XdC+AvIQ96XHfz6IWT27wYRTX2xS2xbnAOM28huHB7LLgA==
X-Received: by 2002:a1c:2042:: with SMTP id g63mr2246994wmg.174.1603799081090; 
 Tue, 27 Oct 2020 04:44:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.44.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:44:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/48] target-arm queue
Date: Tue, 27 Oct 2020 11:43:50 +0000
Message-Id: <20201027114438.17662-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Last minute pullreq for arm related patches; quite large because
there were several series that only just made it through code review
in time.

thanks
-- PMM

The following changes since commit 091e3e3dbc499d84c004e1c50bc9870af37f6e99:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-bitmaps-2020-10-26' into staging (2020-10-26 22:36:35 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20201027-1

for you to fetch changes up to 32bd322a0134ed89db00f2b9b3894982db3dedcb:

  hw/timer/armv7m_systick: Rewrite to use ptimers (2020-10-27 11:15:31 +0000)

----------------------------------------------------------------
target-arm queue:
 * raspi: add model of cprman clock manager
 * sbsa-ref: add an SBSA generic watchdog device
 * arm/trace: Fix hex printing
 * raspi: Add models of Pi 3 model A+, Pi Zero and Pi A+
 * hw/arm/smmuv3: Set the restoration priority of the vSMMUv3 explicitly
 * Nuvoton NPCM7xx: Add USB, RNG, GPIO and watchdog support
 * hw/arm: fix min_cpus for xlnx-versal-virt platform
 * hw/arm/highbank: Silence warnings about missing fallthrough statements
 * linux-user: Support Aarch64 BTI
 * Armv7M systick: fix corner case bugs by rewriting to use ptimer

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      arm/trace: Fix hex printing

Hao Wu (1):
      hw/timer: Adding watchdog for NPCM7XX Timer.

Havard Skinnemoen (4):
      Move npcm7xx_timer_reached_zero call out of npcm7xx_timer_pause
      hw/misc: Add npcm7xx random number generator
      hw/arm/npcm7xx: Add EHCI and OHCI controllers
      hw/gpio: Add GPIO model for Nuvoton NPCM7xx

Luc Michel (14):
      hw/core/clock: provide the VMSTATE_ARRAY_CLOCK macro
      hw/core/clock: trace clock values in Hz instead of ns
      hw/arm/raspi: fix CPRMAN base address
      hw/arm/raspi: add a skeleton implementation of the CPRMAN
      hw/misc/bcm2835_cprman: add a PLL skeleton implementation
      hw/misc/bcm2835_cprman: implement PLLs behaviour
      hw/misc/bcm2835_cprman: add a PLL channel skeleton implementation
      hw/misc/bcm2835_cprman: implement PLL channels behaviour
      hw/misc/bcm2835_cprman: add a clock mux skeleton implementation
      hw/misc/bcm2835_cprman: implement clock mux behaviour
      hw/misc/bcm2835_cprman: add the DSI0HSCK multiplexer
      hw/misc/bcm2835_cprman: add sane reset values to the registers
      hw/char/pl011: add a clock input
      hw/arm/bcm2835_peripherals: connect the UART clock

Pavel Dovgalyuk (1):
      hw/arm: fix min_cpus for xlnx-versal-virt platform

Peter Maydell (2):
      hw/core/ptimer: Support ptimer being disabled by timer callback
      hw/timer/armv7m_systick: Rewrite to use ptimers

Philippe Mathieu-Daudé (10):
      linux-user/elfload: Avoid leaking interp_name using GLib memory API
      hw/arm/bcm2836: Restrict BCM283XInfo declaration to C source
      hw/arm/bcm2836: QOM'ify more by adding class_init() to each SoC type
      hw/arm/bcm2836: Introduce BCM283XClass::core_count
      hw/arm/bcm2836: Only provide "enabled-cpus" property to multicore SoCs
      hw/arm/bcm2836: Split out common realize() code
      hw/arm/bcm2836: Introduce the BCM2835 SoC
      hw/arm/raspi: Add the Raspberry Pi A+ machine
      hw/arm/raspi: Add the Raspberry Pi Zero machine
      hw/arm/raspi: Add the Raspberry Pi 3 model A+

Richard Henderson (11):
      linux-user/aarch64: Reset btype for signals
      linux-user: Set PAGE_TARGET_1 for TARGET_PROT_BTI
      include/elf: Add defines related to GNU property notes for AArch64
      linux-user/elfload: Fix coding style in load_elf_image
      linux-user/elfload: Adjust iteration over phdr
      linux-user/elfload: Move PT_INTERP detection to first loop
      linux-user/elfload: Use Error for load_elf_image
      linux-user/elfload: Use Error for load_elf_interp
      linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0 notes
      linux-user/elfload: Parse GNU_PROPERTY_AARCH64_FEATURE_1_AND
      tests/tcg/aarch64: Add bti smoke tests

Shashi Mallela (2):
      hw/watchdog: Implement SBSA watchdog device
      hw/arm/sbsa-ref: add SBSA watchdog device

Thomas Huth (1):
      hw/arm/highbank: Silence warnings about missing fallthrough statements

Zenghui Yu (1):
      hw/arm/smmuv3: Set the restoration priority of the vSMMUv3 explicitly

 docs/system/arm/nuvoton.rst                |    6 +-
 hw/usb/hcd-ehci.h                          |    1 +
 include/elf.h                              |   22 +
 include/exec/cpu-all.h                     |    2 +
 include/hw/arm/bcm2835_peripherals.h       |    5 +-
 include/hw/arm/bcm2836.h                   |    9 +-
 include/hw/arm/npcm7xx.h                   |    8 +
 include/hw/arm/raspi_platform.h            |    5 +-
 include/hw/char/pl011.h                    |    1 +
 include/hw/clock.h                         |    5 +
 include/hw/gpio/npcm7xx_gpio.h             |   55 ++
 include/hw/misc/bcm2835_cprman.h           |  210 ++++++
 include/hw/misc/bcm2835_cprman_internals.h | 1019 ++++++++++++++++++++++++++++
 include/hw/misc/npcm7xx_clk.h              |    2 +
 include/hw/misc/npcm7xx_rng.h              |   34 +
 include/hw/timer/armv7m_systick.h          |    3 +-
 include/hw/timer/npcm7xx_timer.h           |   48 +-
 include/hw/watchdog/sbsa_gwdt.h            |   79 +++
 linux-user/qemu.h                          |    4 +
 linux-user/syscall_defs.h                  |    4 +
 target/arm/cpu.h                           |    5 +
 hw/arm/bcm2835_peripherals.c               |   15 +-
 hw/arm/bcm2836.c                           |  182 +++--
 hw/arm/highbank.c                          |    2 +
 hw/arm/npcm7xx.c                           |  126 +++-
 hw/arm/raspi.c                             |   41 ++
 hw/arm/sbsa-ref.c                          |   23 +
 hw/arm/smmuv3.c                            |    1 +
 hw/arm/xlnx-versal-virt.c                  |    1 +
 hw/char/pl011.c                            |   45 ++
 hw/core/clock.c                            |    6 +-
 hw/core/ptimer.c                           |    4 +
 hw/gpio/npcm7xx_gpio.c                     |  424 ++++++++++++
 hw/misc/bcm2835_cprman.c                   |  808 ++++++++++++++++++++++
 hw/misc/npcm7xx_clk.c                      |   28 +
 hw/misc/npcm7xx_rng.c                      |  180 +++++
 hw/timer/armv7m_systick.c                  |  124 ++--
 hw/timer/npcm7xx_timer.c                   |  270 ++++++--
 hw/usb/hcd-ehci-sysbus.c                   |   19 +
 hw/watchdog/sbsa_gwdt.c                    |  293 ++++++++
 linux-user/aarch64/signal.c                |   10 +-
 linux-user/elfload.c                       |  326 +++++++--
 linux-user/mmap.c                          |   16 +
 target/arm/translate-a64.c                 |    6 +-
 tests/qtest/npcm7xx_gpio-test.c            |  385 +++++++++++
 tests/qtest/npcm7xx_rng-test.c             |  278 ++++++++
 tests/qtest/npcm7xx_watchdog_timer-test.c  |  319 +++++++++
 tests/tcg/aarch64/bti-1.c                  |   62 ++
 tests/tcg/aarch64/bti-2.c                  |  116 ++++
 tests/tcg/aarch64/bti-crt.inc.c            |   51 ++
 MAINTAINERS                                |    1 +
 hw/arm/Kconfig                             |    1 +
 hw/arm/trace-events                        |    2 +-
 hw/char/trace-events                       |    1 +
 hw/core/trace-events                       |    4 +-
 hw/gpio/meson.build                        |    1 +
 hw/gpio/trace-events                       |    7 +
 hw/misc/meson.build                        |    2 +
 hw/misc/trace-events                       |    9 +
 hw/watchdog/Kconfig                        |    3 +
 hw/watchdog/meson.build                    |    1 +
 tests/qtest/meson.build                    |    6 +-
 tests/tcg/aarch64/Makefile.target          |   10 +
 tests/tcg/configure.sh                     |    4 +
 64 files changed, 5461 insertions(+), 279 deletions(-)
 create mode 100644 include/hw/gpio/npcm7xx_gpio.h
 create mode 100644 include/hw/misc/bcm2835_cprman.h
 create mode 100644 include/hw/misc/bcm2835_cprman_internals.h
 create mode 100644 include/hw/misc/npcm7xx_rng.h
 create mode 100644 include/hw/watchdog/sbsa_gwdt.h
 create mode 100644 hw/gpio/npcm7xx_gpio.c
 create mode 100644 hw/misc/bcm2835_cprman.c
 create mode 100644 hw/misc/npcm7xx_rng.c
 create mode 100644 hw/watchdog/sbsa_gwdt.c
 create mode 100644 tests/qtest/npcm7xx_gpio-test.c
 create mode 100644 tests/qtest/npcm7xx_rng-test.c
 create mode 100644 tests/qtest/npcm7xx_watchdog_timer-test.c
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-2.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c

