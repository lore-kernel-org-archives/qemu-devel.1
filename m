Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BA8C33CB6
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B516D2467C
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyUTqo+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B516D2467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isyq2-0000Gx-Pn
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 19:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyoB-0006uy-O4
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyo7-0008Hu-Ol
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:51:19 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36383)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1isyo7-0008Gf-Fz; Sat, 18 Jan 2020 19:51:15 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so11214599wma.1;
 Sat, 18 Jan 2020 16:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LX1m7MIq+SDVtXfwnSBLE6Hk9PkpWYM7XpDns9NSQoQ=;
 b=HyUTqo+EM+g8aNbZ3yzFsLFIZI8vWOYFmwi1L/XDJFKWV2g8CQDqoPewa9vnYvi/aT
 QEFO5G3juRIYPggGoZJXiYQ6HuA9osSqD5WG97JotHwaYeJN7NbgHj4ZfKv7RZr7QjEq
 iTESlt5T2jZjz3VzhqqgZUVfufPQVyEQ1u0+3h9Vxy34AxcaLCl9U3s8/1Q5k2hSFOy5
 8Xo5lTt/LTLR6+7CdaXuVfiSIR4zY0/y7x+nj5LTQiTttg4PskW43QOvRYdKwq68rVtx
 Nl3UcSAAaAsdbSbEcChhJ/gqaTenDOCCDxB7oLnE7k5oaELk+NiHVoVc3AFnIiQjsaVw
 HVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LX1m7MIq+SDVtXfwnSBLE6Hk9PkpWYM7XpDns9NSQoQ=;
 b=N8JfHq5KH8R62xeq+KS4uLO4IxFrAHiGTeRo5TWeIufK7/IiwjfZiT6PWHukvrIY1u
 3tAT5KfIdQ3ngoDqmHh8Ym6pNbcMPz/rNTj8AEJxRGgSj4mQlufySTCjqvdp0+1u2zHO
 fPtSTZEHh9U5L5xkmdvAIAs5OxuFdnCOjDEHJhNHtSNFCG28AIbhKcakiXJbtOibEW6p
 ssYLCqNoMZ94xTFwQWovO7YunAZ2szU5Wpr4C11PID10LV7w7ctltZ654wt4pwshFECG
 IuuaEHUl6LnlHjLlNbbPuFqVKbEkrY/OV297KUbRp5+jnAAOD8zQZHrE4huz+8kzSpWW
 yLmw==
X-Gm-Message-State: APjAAAU6XoyD5zOpgnjvXbQCoCQoxjIQAs/rzzWSddL72n+BQwg/rKEr
 gkUFXN9H9CKXI1DEHRcFgeNb2SWrYk0=
X-Google-Smtp-Source: APXvYqzSi5w+VfiEpfBXtazMIa7+YBRJAywNtiQYzTdhvNQFVtcClGswgpUXlMoqAFuYTfPAjobedw==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr11486380wme.109.1579395073971; 
 Sat, 18 Jan 2020 16:51:13 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id h2sm41763568wrv.66.2020.01.18.16.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2020 16:51:13 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/20] Add Allwinner H3 SoC and Orange Pi PC Machine
Date: Sun, 19 Jan 2020 01:50:42 +0100
Message-Id: <20200119005102.3847-1-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, jasowang@redhat.com,
 b.galvani@gmail.com, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dear QEMU developers,

Hereby I would like to contribute the following set of patches to QEMU
which add support for the Allwinner H3 System on Chip and the
Orange Pi PC machine. The following features and devices are supported:

 * SMP (Quad Core Cortex A7)
 * Generic Interrupt Controller configuration
 * SRAM mappings
 * SDRAM controller
 * Real Time Clock
 * Timer device (re-used from Allwinner A10)
 * UART
 * SD/MMC storage controller
 * EMAC ethernet connectivity
 * USB 2.0 interfaces
 * Clock Control Unit
 * System Control module
 * Security Identifier device

Functionality related to graphical output such as HDMI, GPU,
Display Engine and audio are not included. Recently released
mainline Linux kernels (4.19 up to latest master), mainline U-Boot
and NetBSD 9.0-RC1 are known to work.

For full details on how to use the Orange Pi PC machine, see the file
docs/orangepi.rst which is included as a patch in this series.

The contents of this patch series is available on Github at:

  https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v3

The followings are currently known issues in this series:

  - NetBSD 9.0-RC1 reads out year 2050 from RTC, while Linux works fine
     -> This is due to difference in base year defined by the corresponding drivers
  - RTC date & time is not persistent
  - boot0 custom Allwinner bootloader not yet working
  - Watchdog not yet implemented, affects U-Boot 'reset' and shutdown/reboot
     -> This is part of the existing A10 timer that needs to be generalized first

Looking forward to your review comments. I will do my best
to update the patches where needed.

===== CHANGELOG =====
v4:
 * docs/orangepi.rst: correct SDRAM size in board description: 512MB -> 1GiB
 * hw/arm/orangepi.c: correct SDRAM size in commit message: 512MB -> 1GiB
 * hw/arm/orangepi.c: set .nb_cpus in the orangepi_binfo struct static initialisation
 * hw/arm/orangepi.c: remove .board_id from orangepi_binfo struct
 * hw/arm/orangepi.c: move BIOS check to top of orangepi_init()
 * hw/arm/orangepi.c: change clk1-freq argument 24000000 to 24 * 1000 * 1000 for readability
 * hw/arm/orangepi.c: rephrase 1GiB check error message
 * include/hw/arm/allwinner-h3.h: improved comments
 * hw/arm/allwinner-h3.c: remove duplicate initialization and declaration of i variable
 * hw/arm/allwinner-h3.c: use DEVICE(&s->cpus[i]) instead of qemu_get_cpu()
 * hw/arm/allwinner-h3.c: use qdev API instead of object API in CPU initialization part
 * hw/arm/allwinner-h3.c: add note that UARTs are connected to APB2_CLK, for future clocktree API
 * hw/arm/allwinner-h3.c: extend commit message for Boot ROM with description for the 32KiB size
 * hw/rtc/allwinner-rtc.c: correct usage of AwRtcClass->regmap_size for checking r/w offset
 * hw/misc/allwinner-cpucfg.c: remove 64-bit counter, as it is unused by Linux/U-Boot/NetBSD
 * hw/misc/allwinner-cpucfg.c: add CPU_EXCEPTION_LEVEL_ON_RESET constant
 * hw/misc/allwinner-cpucfg.c: break instead of return after logging guest error, for tracing
 * hw/misc/allwinner-cpucfg.c: reduce duplication in switch/case for REG_CPUX_RST_CTRL in write function
 * include/hw/rtc/allwinner-rtc.h: increase AW_RTC_REGS_MAXADDR to 0x200
 * include/hw/rtc/allwinner-rtc.h: change type of AwRtcClass->year_offset to int, to match struct tm
 * tests/acceptance/boot_linux_console.py: remove calls to vm.set_machine()
 * tests/acceptance/boot_linux_console.py: added NetBSD test by Philippe
 * docs/orangepi.rst: removed some unneeded words/typos
 * docs/orangepi.rst: remove usage of -j5 for calling make (not all users have >= 4 SMP cores)
 * include/hw/*/allwinner*.h: moved #include "qemu/osdep.h" and unneeded #includes to .c file

v3: https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg01534.html
    https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v3

v2: https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03265.html
    https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v2

v1: https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg00320.html
    https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v1

With kind regards,

Niek Linnenbank

Niek Linnenbank (13):
  hw/arm: add Allwinner H3 System-on-Chip
  hw/arm: add Xunlong Orange Pi PC machine
  hw/arm/allwinner-h3: add Clock Control Unit
  hw/arm/allwinner-h3: add USB host controller
  hw/arm/allwinner-h3: add System Control module
  hw/arm/allwinner: add CPU Configuration module
  hw/arm/allwinner: add Security Identifier device
  hw/arm/allwinner: add SD/MMC host controller
  hw/arm/allwinner-h3: add EMAC ethernet device
  hw/arm/allwinner-h3: add Boot ROM support
  hw/arm/allwinner-h3: add SDRAM controller device
  hw/arm/allwinner: add RTC device support
  docs: add Orange Pi PC document

Philippe Mathieu-Daudé (7):
  tests/boot_linux_console: Add a quick test for the OrangePi PC board
  tests/boot_linux_console: Add initrd test for the Orange Pi PC board
  tests/boot_linux_console: Add a SD card test for the OrangePi PC board
  tests/boot_linux_console: Add a SLOW test booting Ubuntu on OrangePi
    PC
  Acceptance tests: Extract _console_interaction()
  Acceptance tests: Add interrupt_interactive_console_until_pattern()
  tests/boot_linux_console: Test booting NetBSD via U-Boot on OrangePi
    PC

 docs/orangepi.rst                         | 199 +++++
 default-configs/arm-softmmu.mak           |   1 +
 hw/usb/hcd-ehci.h                         |   1 +
 include/hw/arm/allwinner-a10.h            |   4 +
 include/hw/arm/allwinner-h3.h             | 163 ++++
 include/hw/misc/allwinner-cpucfg.h        |  52 ++
 include/hw/misc/allwinner-h3-ccu.h        |  66 ++
 include/hw/misc/allwinner-h3-dramc.h      | 106 +++
 include/hw/misc/allwinner-h3-sysctrl.h    |  67 ++
 include/hw/misc/allwinner-sid.h           |  60 ++
 include/hw/net/allwinner-sun8i-emac.h     |  99 +++
 include/hw/rtc/allwinner-rtc.h            | 128 ++++
 include/hw/sd/allwinner-sdhost.h          | 135 ++++
 hw/arm/allwinner-a10.c                    |  19 +
 hw/arm/allwinner-h3.c                     | 476 ++++++++++++
 hw/arm/cubieboard.c                       |  15 +
 hw/arm/orangepi.c                         | 127 ++++
 hw/misc/allwinner-cpucfg.c                | 269 +++++++
 hw/misc/allwinner-h3-ccu.c                | 243 ++++++
 hw/misc/allwinner-h3-dramc.c              | 358 +++++++++
 hw/misc/allwinner-h3-sysctrl.c            | 140 ++++
 hw/misc/allwinner-sid.c                   | 170 +++++
 hw/net/allwinner-sun8i-emac.c             | 871 ++++++++++++++++++++++
 hw/rtc/allwinner-rtc.c                    | 386 ++++++++++
 hw/sd/allwinner-sdhost.c                  | 848 +++++++++++++++++++++
 hw/usb/hcd-ehci-sysbus.c                  |  17 +
 MAINTAINERS                               |   9 +
 hw/arm/Kconfig                            |   9 +
 hw/arm/Makefile.objs                      |   1 +
 hw/misc/Makefile.objs                     |   5 +
 hw/misc/trace-events                      |  19 +
 hw/net/Kconfig                            |   3 +
 hw/net/Makefile.objs                      |   1 +
 hw/net/trace-events                       |  10 +
 hw/rtc/Makefile.objs                      |   1 +
 hw/rtc/trace-events                       |   4 +
 hw/sd/Makefile.objs                       |   1 +
 hw/sd/trace-events                        |   7 +
 tests/acceptance/avocado_qemu/__init__.py |  59 +-
 tests/acceptance/boot_linux_console.py    | 210 ++++++
 40 files changed, 5345 insertions(+), 14 deletions(-)
 create mode 100644 docs/orangepi.rst
 create mode 100644 include/hw/arm/allwinner-h3.h
 create mode 100644 include/hw/misc/allwinner-cpucfg.h
 create mode 100644 include/hw/misc/allwinner-h3-ccu.h
 create mode 100644 include/hw/misc/allwinner-h3-dramc.h
 create mode 100644 include/hw/misc/allwinner-h3-sysctrl.h
 create mode 100644 include/hw/misc/allwinner-sid.h
 create mode 100644 include/hw/net/allwinner-sun8i-emac.h
 create mode 100644 include/hw/rtc/allwinner-rtc.h
 create mode 100644 include/hw/sd/allwinner-sdhost.h
 create mode 100644 hw/arm/allwinner-h3.c
 create mode 100644 hw/arm/orangepi.c
 create mode 100644 hw/misc/allwinner-cpucfg.c
 create mode 100644 hw/misc/allwinner-h3-ccu.c
 create mode 100644 hw/misc/allwinner-h3-dramc.c
 create mode 100644 hw/misc/allwinner-h3-sysctrl.c
 create mode 100644 hw/misc/allwinner-sid.c
 create mode 100644 hw/net/allwinner-sun8i-emac.c
 create mode 100644 hw/rtc/allwinner-rtc.c
 create mode 100644 hw/sd/allwinner-sdhost.c

-- 
2.17.1

