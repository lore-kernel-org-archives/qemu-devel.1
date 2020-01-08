Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB8AC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BAA20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+1rqHDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BAA20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipHYN-0003yy-GS
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 15:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVP-0001HC-8Y
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVN-0002SU-BL
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:39 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ipHVM-0002R1-Ck; Wed, 08 Jan 2020 15:00:36 -0500
Received: by mail-wr1-x441.google.com with SMTP id t2so4808715wrr.1;
 Wed, 08 Jan 2020 12:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tJ0nI7Fpsu0bji0D+Ii0nNgAGdbc+5tgc+UAyNq0LSg=;
 b=Y+1rqHDT2oAyzhoPOu+ynFRzWKzz9f4WB9Roo0vGIY5jIqSTiNwQpYpEYhkZOF73To
 xorUXQZ053iey1Yj5rg3kXQLXJggwpGr2DMDHVaKCxgjbjq6es6sLbbHewAjFuXWK8g+
 kHI+jU5bHxPWeuPdhYEEPOyCUNmIQpXAeWG/UuqWFwX08rXvyZqK85+6K4oizUZ2Z7N8
 /EVnwqCQVakmvGa4YrCI/v/hEF87uJ74RyUFx5vHDBopRCTh0pF53hj/pLqInQk2FqOB
 MenY95d9cKTyD5D2UldvMxoT/adOuRZ+7oK4lowFZcdkYFh9+4EpHwgFkvqbEHevI9QK
 JxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tJ0nI7Fpsu0bji0D+Ii0nNgAGdbc+5tgc+UAyNq0LSg=;
 b=jaNRggGhNRBjD3P6U/kCaR6jVtivhmP2mJFv7IFl56lBJ0iwP/HXpBlHisGCZqtRll
 tDxM5E1gRt1Z2urEw3akf8vHMM3OjNrCZFxQTr3VgAQPgZE7gBRtrYJpY3Mq1MaIXwBu
 bzrFTkgRKesaHp4gcc2p9I5PccBKIZ0VQC85Sj0ek2LKhROFQQsHK3OH3wJD5P0LGgqT
 GJzwM9P5KRwZpZIFGbdPbArqGkzX8G9I+/cm9bg7VuT17y0cXpLvsV05JVOvOy9JZEiO
 a4PvGWNtnl+fYbPizfNwpWGfe1GbqdhCDw1hmhn/Y+NmeljoD0ecn2j57WQwseQOaWi1
 moPg==
X-Gm-Message-State: APjAAAVyunk8im7kfnL7VpgdUnYTCInLgzJpdpSaPkhWiXCEqjx8cqf7
 JVx7PAzYtu/8Xx/d0IzSHCrhPj48
X-Google-Smtp-Source: APXvYqxLpuHA9tYM0moIF2XCB65bAkjVYB1r5TqNlKwGC08s/Kgpd7YK+gTZZoH4cusQZcWSXaFFsA==
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr6540776wru.40.1578513634432; 
 Wed, 08 Jan 2020 12:00:34 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id u18sm4970099wrt.26.2020.01.08.12.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 12:00:33 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/17] Add Allwinner H3 SoC and Orange Pi PC Machine
Date: Wed,  8 Jan 2020 21:00:03 +0100
Message-Id: <20200108200020.4745-1-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, philmd@redhat.com
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
  - boot0 custom Allwinner bootloader not yet working
  - Watchdog not yet implemented, affects U-Boot 'reset' and shutdown/reboot
     -> This is part of the existing A10 timer that needs to be generalized first

Looking forward to your review comments. I will do my best
to update the patches where needed.

===== CHANGELOG =====
v3:
 * hw/rtc/allwinner-rtc.c: add Allwinner RTC device
 * hw/misc/allwinner-h3-dramc.c: add SDRAM Controller device
 * hw/sd/allwinner-h3-sdhost.c: rename to allwinner-sdhost.c and re-use in A10/cubieboard
 * hw/arm/allwinner-h3.c: add Boot ROM support (for starting without -kernel)
 * hw/arm/allwinner-h3.c: add property alias clk0-freq/clk1-freq to the timer
 * hw/arm/allwinner-h3.c: remove unneccessary checks for error_abort != NULL
 * docs/orangepi.rst: add Orange Pi PC documentation
 * hw/arm/orangepi.c: restrict allowed machine->ram_size to 1GiB only
 * hw/arm/orangepi.c: set mc->default_ram_size to 1GiB
 * hw/arm/orangepi.c: renamed memory region identifier to "sdram"
 * hw/arm/orangepi.c: remove unneccessary checks for error_abort != NULL
 * hw/arm/orangepi.c: move adding mc->units_per_default_bus = 1 to patch 0009 (add SD/MMC host controller)
 * hw/arm/orangepi.c: report error when providing unsupported '-bios' argument
 * hw/net/allwinner-h3-emac.c: add missing MII registers: advertised abilities, linked partner abilities
 * hw/net/allwinner-h3-emac.c: add REG_RGMII_STA to read handler
 * hw/net/allwinner-h3-emac.c: use REG_BASIC_CTL_0_RST in reset function
 * hw/net/allwinner-h3-emac.c: add mii_cr, mii_st to VMState
 * hw/misc/allwinner-h3-sid.c: renamed to allwinner-sid.c/.h (generic module)
 * hw/misc/allwinner-h3-sid.c: removed unnecessary call to zero UUID field in init function
 * hw/misc/allwinner-h3-clk.c: add REG_DRAM_CFG register
 * hw/misc/allwinner-h3-clk.c: renamed to allwinner-h3-ccu.c/.h
 * hw/misc/allwinner-h3-cpucfg.c: renamed to allwinner-cpucfg.c/.h (generic module)
 * hw/misc/allwinner-h3-syscon.c: renamed to allwinner-h3-sysctrl.c (and all others)
 * hw/misc/trace-events: remove "*H3" prefixes from trace output
 * hw/*/allwinner-h3-*.c: remove .unaligned = true from MemoryRegionOps
 * hw/*/allwinner-h3-*.c: remove unused realize function
 * hw/*/allwinner-h3-*.c: use AW_H3_*() macro for all opaque variables
 * hw/*/allwinner-h3-*.c: each patch adds new device to enum in allwinner-h3.h and removes from unimpl list
 * hw/*/allwinner-h3-*.c: each patch adds new entry to AW_H3_GIC_SPI_* enum (if applicable)
 * hw/*/allwinner-h3-*.c: rename functions from short aw_h3_*() form to full form (e.g. allwinner-h3-*())
 * include/hw/*/allwinner-h3*.h: provide Doxygen style code comments

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

Philippe Mathieu-Daudé (4):
  tests/boot_linux_console: Add a quick test for the OrangePi PC board
  tests/boot_linux_console: Add initrd test for the Orange Pi PC board
  tests/boot_linux_console: Add a SD card test for the OrangePi PC board
  tests/boot_linux_console: Add a SLOW test booting Ubuntu on OrangePi
    PC

 docs/orangepi.rst                      | 200 ++++++
 default-configs/arm-softmmu.mak        |   1 +
 hw/usb/hcd-ehci.h                      |   1 +
 include/hw/arm/allwinner-a10.h         |   8 +-
 include/hw/arm/allwinner-h3.h          | 164 +++++
 include/hw/misc/allwinner-cpucfg.h     |  54 ++
 include/hw/misc/allwinner-h3-ccu.h     |  67 ++
 include/hw/misc/allwinner-h3-dramc.h   | 107 +++
 include/hw/misc/allwinner-h3-sysctrl.h |  68 ++
 include/hw/misc/allwinner-sid.h        |  61 ++
 include/hw/net/allwinner-sun8i-emac.h  | 103 +++
 include/hw/rtc/allwinner-rtc.h         | 129 ++++
 include/hw/sd/allwinner-sdhost.h       | 136 ++++
 hw/arm/allwinner-a10.c                 |  17 +
 hw/arm/allwinner-h3.c                  | 477 ++++++++++++++
 hw/arm/cubieboard.c                    |  15 +
 hw/arm/orangepi.c                      | 125 ++++
 hw/misc/allwinner-cpucfg.c             | 282 ++++++++
 hw/misc/allwinner-h3-ccu.c             | 243 +++++++
 hw/misc/allwinner-h3-dramc.c           | 358 ++++++++++
 hw/misc/allwinner-h3-sysctrl.c         | 140 ++++
 hw/misc/allwinner-sid.c                | 170 +++++
 hw/net/allwinner-sun8i-emac.c          | 871 +++++++++++++++++++++++++
 hw/rtc/allwinner-rtc.c                 | 386 +++++++++++
 hw/sd/allwinner-sdhost.c               | 848 ++++++++++++++++++++++++
 hw/usb/hcd-ehci-sysbus.c               |  17 +
 MAINTAINERS                            |   9 +
 hw/arm/Kconfig                         |   9 +
 hw/arm/Makefile.objs                   |   1 +
 hw/misc/Makefile.objs                  |   5 +
 hw/misc/trace-events                   |  19 +
 hw/net/Kconfig                         |   3 +
 hw/net/Makefile.objs                   |   1 +
 hw/net/trace-events                    |  10 +
 hw/rtc/Makefile.objs                   |   1 +
 hw/rtc/trace-events                    |   4 +
 hw/sd/Makefile.objs                    |   1 +
 hw/sd/trace-events                     |   7 +
 tests/acceptance/boot_linux_console.py | 151 +++++
 39 files changed, 5267 insertions(+), 2 deletions(-)
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


