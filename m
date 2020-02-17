Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91297C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 23:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9CD207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 23:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZGkiWkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9CD207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3plU-0003MM-F1
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 18:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j3pkc-0001Wx-2C
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 18:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j3pka-0006af-8z
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 18:24:30 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j3pka-0006Yd-0N; Mon, 17 Feb 2020 18:24:28 -0500
Received: by mail-wr1-x42c.google.com with SMTP id u6so21774759wrt.0;
 Mon, 17 Feb 2020 15:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b3b7kBz00LpGCYA81YDLxYiAvamTgoNcDsjIy7fcIFk=;
 b=TZGkiWkkvv6mUJEciJzw5v3xmVLy68FEegTnf9PPuCa9F4b5N9Ux9Islqrqk3TKo2p
 2f5WBo7ErAIgTLNrqzWS8dZC31gCl/u5b5G9BfKT2ItF3I7LbPrzzxKqupICNkeTZxi+
 elPDV2J0EUAjYnamufpL4x9S84qEiHz2iYF+uc8b6oZRlbDoLjkU8o58KKfEfH3ZoiEL
 JS1uRHSVCiP4jozVLdTituP3QKi/ih3WzA5kyuTY9GBofwz9C8SwHEirSyizxeHaob7p
 pak1m+pUg2wFvx079bFOHW7MKVOi4BphvP8zNSWfufykqbPYXSBujK3yWjc6uT7ORrsZ
 QpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b3b7kBz00LpGCYA81YDLxYiAvamTgoNcDsjIy7fcIFk=;
 b=G6jTvjXQZDLxx1uvsvM5cNOYwOdbnv7JvepC5WISkM4WxT07gmB5YdG46J1ooQAdvn
 ajbJmP6AY2zEpJ//rw+i8FnkV1k3B9DjT0xuy6seGrKLyD5EsJYIq5d+BPUFFVlJU3ga
 WzE8kT/JxqTfFeISMeL0NC7At/q+sv9rvcvyJ0Jr+uu6o6F9V0UY/g5C1zPzTwh4O3BH
 8pT7Lv5TbbreUmFQ8MIT5M8cp382f9A7Q7qrj1v4J4iWD8tc/puImk6FmruWsyFXQq+B
 OIQbPubqV3aQuzAwbOWYg8nhUophHBZQJGiiiHTiROtrA9Ggfw3Elqm/mKiZmsIGECti
 dQiA==
X-Gm-Message-State: APjAAAULPod4haeUZRc1zW3rDiWu8S9mx49Wl5cCr3re6GussCkDMAPH
 avlHi241rweSyRRtM8FYPUm1A3IO/po=
X-Google-Smtp-Source: APXvYqzM6yaY5PSwwJVYgeXICAjUxHuDmWfArtxgn40ZNi0wLS8TnPVy370UH7NyyCtzCfwPObhPiQ==
X-Received: by 2002:adf:f986:: with SMTP id f6mr25443065wrr.182.1581981866440; 
 Mon, 17 Feb 2020 15:24:26 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id w1sm3244831wro.72.2020.02.17.15.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 15:24:25 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/18] Add Allwinner H3 SoC and Orange Pi PC Machine
Date: Tue, 18 Feb 2020 00:23:53 +0100
Message-Id: <20200217232411.30096-1-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
and NetBSD 9.0 are known to work.

For full details on how to use the Orange Pi PC machine, see the file
docs/orangepi.rst which is included as a patch in this series.

The contents of this patch series is available on Github at:

  https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v5

The followings are currently known issues in this series:

  - RTC date & time is not persistent
  - boot0 custom Allwinner bootloader not yet working
  - Watchdog not yet implemented, affects U-Boot 'reset' and shutdown/reboot
     -> This is part of the existing A10 timer that needs to be generalized first

Looking forward to your review comments. I will do my best
to update the patches where needed.

===== CHANGELOG =====
v5:
 * hw/arm/allwinner-h3.c: correct comment for dc->user_creatable = false
 * hw/arm/allwinner-h3.c: rename usb[0-3] to usb[0-3]-phy in unimplemented array
 * hw/arm/allwinner-h3.c: remove unneeded check for rom_size > blk_size in bootrom_setup()
 * hw/arm/allwinner-h3.c: remove errp parameter and directl use error_fatal in bootrom_setup()
 * hw/arm/Kconfig: add USB_OHCI, USB_EHCI_SYSBUS, SD to ALLWINNER_H3 item (for --without-default-devices)
 * hw/misc/allwinner-cpucfg.c: add entry_addr to VMState for migration
 * hw/misc/allwinner-sid.c: add identifier to VMState for migration
 * hw/misc/allwinner-sid.c: use ldl_be_p() to set rdkey value
 * hw/arm/orangepi.c: add comment about always using a default fixed SID identifier
 * hw/arm/orangepi.c: add check for SID identifier override, to allow -global override by the user
 * hw/arm/orangepi.c: print warning if SID identifier does not include H3 prefix
 * hw/arm/orangepi.c: move 1GiB RAM check between checks for BIOS and CPU type
 * include/hw/misc/allwinner-h3-ccu.h: rename AW_H3_CCU_REGS_MAXADDR to AW_H3_CCU_IOSIZE with value 0x400
 * hw/misc/allwinner-h3-ccu.c: use AW_H3_CCU_IOSIZE with range in switch(offset) in read/write
 * hw/rtc/allwinner-rtc.c: add 'base-year' property in AwRtcState (replaces previous year_offset)
 * hw/sd/allwinner-sdhost.c: set AUTOCMD interrupt flag in auto_stop() function only
 * hw/sd/allwinner-sdhost.c: set SDIO_INTR and INT_SUMMARY interrupt flags in dma() function
 * docs/orangepi.rst: add machine options section, which documents available machine/device specific properties
 * docs/orangepi.rst: updated NetBSD 9 instructions with new image URL, -global options and extend SD image command
 * hw/*/allwinner*.c: use device_class_set_props() to set DeviceClass properties
 * tests/acceptance/boot_linux_console.py: add check for 7z program using avocado's find_command()
 * tests/acceptance/boot_linux_console.py: adapt NetBSD test to use NetBSD 9.0 final release
 * tests/acceptance/boot_linux_console.py: adapt NetBSD test to use -global allwinner-rtc.base-year=2000

v4: https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg03960.html
    https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v4

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

Philippe Mathieu-Daudé (5):
  tests/boot_linux_console: Add a quick test for the OrangePi PC board
  tests/boot_linux_console: Add initrd test for the Orange Pi PC board
  tests/boot_linux_console: Add a SD card test for the OrangePi PC board
  tests/boot_linux_console: Add a SLOW test booting Ubuntu on OrangePi
    PC
  tests/boot_linux_console: Test booting NetBSD via U-Boot on OrangePi
    PC

 docs/orangepi.rst                      | 226 +++++++
 default-configs/arm-softmmu.mak        |   1 +
 hw/usb/hcd-ehci.h                      |   1 +
 include/hw/arm/allwinner-a10.h         |   4 +
 include/hw/arm/allwinner-h3.h          | 161 +++++
 include/hw/misc/allwinner-cpucfg.h     |  52 ++
 include/hw/misc/allwinner-h3-ccu.h     |  66 ++
 include/hw/misc/allwinner-h3-dramc.h   | 106 +++
 include/hw/misc/allwinner-h3-sysctrl.h |  67 ++
 include/hw/misc/allwinner-sid.h        |  60 ++
 include/hw/net/allwinner-sun8i-emac.h  |  99 +++
 include/hw/rtc/allwinner-rtc.h         | 134 ++++
 include/hw/sd/allwinner-sdhost.h       | 135 ++++
 hw/arm/allwinner-a10.c                 |  19 +
 hw/arm/allwinner-h3.c                  | 466 +++++++++++++
 hw/arm/cubieboard.c                    |  15 +
 hw/arm/orangepi.c                      | 134 ++++
 hw/misc/allwinner-cpucfg.c             | 270 ++++++++
 hw/misc/allwinner-h3-ccu.c             | 242 +++++++
 hw/misc/allwinner-h3-dramc.c           | 358 ++++++++++
 hw/misc/allwinner-h3-sysctrl.c         | 140 ++++
 hw/misc/allwinner-sid.c                | 168 +++++
 hw/net/allwinner-sun8i-emac.c          | 871 +++++++++++++++++++++++++
 hw/rtc/allwinner-rtc.c                 | 411 ++++++++++++
 hw/sd/allwinner-sdhost.c               | 854 ++++++++++++++++++++++++
 hw/usb/hcd-ehci-sysbus.c               |  17 +
 MAINTAINERS                            |   9 +
 hw/arm/Kconfig                         |  12 +
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
 tests/acceptance/boot_linux_console.py | 224 +++++++
 39 files changed, 5374 insertions(+)
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

