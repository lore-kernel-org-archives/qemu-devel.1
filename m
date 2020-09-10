Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D07C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BECF207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FpAQ21/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BECF207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGREi-0000Xr-3n
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBK-0003dC-2F
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBF-0002iJ-HL
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762021; x=1631298021;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aYu0GpPWoRsqP4tZ+MhbPKGqbvP+SZ3XPZ4lM9SMqcQ=;
 b=FpAQ21/Buue6PAC4ZuNt9yJ+B5r875akOaoA75e5fZfmuXVTROx/LsQz
 lxziuiumrjVTMv6wV4HpyOJsuH0RLHbSM+nrkIXTvaUKDfqtPdezupGE/
 +Zj0lWndb+AI/UR7pouxto4XsyNebttF4gsEd6uk1CdVVzZRmyvfTw+vI
 xaI6ooB5vNAxpgiV+rwXO2qmzb4JzHoF/OWOfW98SaEs8Wsi8LWfX6QC1
 3rN6ZWCIczn+e+Z/ZHkTWNCsd34ZU+bunN9xKJosycp0b/EFuoQw6Y2E2
 HNuAg+zWZrK97VZ4DsoB9P4kvvdH+c0viFJPE4wcwN2sTo6gRAbZp4tpc A==;
IronPort-SDR: aEJtrhnqdmSf1b8EbeznzleQQFtziHqHPL4BbrJU5AmLwXpjdicuPprAtRz8eczgWUTjZJn+QX
 v3KMyI0+blUlOIoxvW4jsSvE+AWpJrN3NxRnJJJ7kIutzbzkeTXzt1fe5ekpJLo4wEkl23WVjd
 e+G8rprk9syjP+s0Z0WdpGMfbeeHe+/vvrF5wSYzcLK6sYSr9sFgMNTrJsYdP8PsQmlCfHQtyz
 bJxsUAyCFPi6RjSscW2K5f6Q/P3eu0OJulhJtUI3D8MEZ2G5JgoUgPoKZlVbRDdkUB9O1t8af3
 QGI=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979201"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:14 +0800
IronPort-SDR: Mb3YrRHoLv9MUkVxNKeRRymNeV2YVwzR9FplOFw3eDzzEwjV8z1IO9t/HRLyZ8lTCJfczN4wVW
 odGV0db7jOFw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:30 -0700
IronPort-SDR: nf56aw1aimFuaQEH6HS/DI14SeWNa6xnGRo6SnLgRF7X9J4gAuSib4WnmGHwSYpEFsMS37MW0B
 /AT569oUHQYA==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:14 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 00/30] riscv-to-apply queue
Date: Thu, 10 Sep 2020 11:09:08 -0700
Message-Id: <20200910180938.584205-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9435a8b3dd35f1f926f1b9127e8a906217a5518a:

  Merge remote-tracking branch 'remotes/kraxel/tags/sirius/ipxe-20200908-pull-request' into staging (2020-09-08 21:21:13 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200910

for you to fetch changes up to 7595a65818ea9b49c36650a8c217a1ef9bd6e62a:

  hw/riscv: Sort the Kconfig options in alphabetical order (2020-09-09 15:54:19 -0700)

----------------------------------------------------------------
This PR includes multiple fixes and features for RISC-V:
 - Fixes a bug in printing trap causes
 - Allows 16-bit writes to the SiFive test device. This fixes the
   failure to reboot the RISC-V virt machine
 - Support for the Microchip PolarFire SoC and Icicle Kit
 - A reafactor of RISC-V code out of hw/riscv

----------------------------------------------------------------
Bin Meng (28):
      target/riscv: cpu: Add a new 'resetvec' property
      hw/riscv: hart: Add a new 'resetvec' property
      target/riscv: cpu: Set reset vector based on the configured property value
      hw/riscv: Initial support for Microchip PolarFire SoC Icicle Kit board
      hw/char: Add Microchip PolarFire SoC MMUART emulation
      hw/riscv: microchip_pfsoc: Connect 5 MMUARTs
      hw/sd: Add Cadence SDHCI emulation
      hw/riscv: microchip_pfsoc: Connect a Cadence SDHCI controller and an SD card
      hw/dma: Add SiFive platform DMA controller emulation
      hw/riscv: microchip_pfsoc: Connect a DMA controller
      hw/net: cadence_gem: Add a new 'phy-addr' property
      hw/arm: xlnx: Set all boards' GEM 'phy-addr' property value to 23
      hw/riscv: microchip_pfsoc: Connect 2 Cadence GEMs
      hw/riscv: microchip_pfsoc: Hook GPIO controllers
      hw/riscv: clint: Avoid using hard-coded timebase frequency
      hw/riscv: sifive_u: Connect a DMA controller
      hw/riscv: Move sifive_e_prci model to hw/misc
      hw/riscv: Move sifive_u_prci model to hw/misc
      hw/riscv: Move sifive_u_otp model to hw/misc
      hw/riscv: Move sifive_gpio model to hw/gpio
      hw/riscv: Move sifive_clint model to hw/intc
      hw/riscv: Move sifive_plic model to hw/intc
      hw/riscv: Move riscv_htif model to hw/char
      hw/riscv: Move sifive_uart model to hw/char
      hw/riscv: Move sifive_test model to hw/misc
      hw/riscv: Always build riscv_hart.c
      hw/riscv: Drop CONFIG_SIFIVE
      hw/riscv: Sort the Kconfig options in alphabetical order

Nathan Chancellor (1):
      riscv: sifive_test: Allow 16-bit writes to memory region

Yifei Jiang (1):
      target/riscv: Fix bug in getting trap cause name for trace_riscv_trap

 default-configs/riscv64-softmmu.mak         |   1 +
 {include/hw/riscv => hw/intc}/sifive_plic.h |   0
 hw/riscv/trace.h                            |   1 -
 include/hw/char/mchp_pfsoc_mmuart.h         |  61 ++++
 include/hw/{riscv => char}/riscv_htif.h     |   0
 include/hw/{riscv => char}/sifive_uart.h    |   0
 include/hw/dma/sifive_pdma.h                |  57 ++++
 include/hw/{riscv => gpio}/sifive_gpio.h    |   0
 include/hw/{riscv => intc}/sifive_clint.h   |   4 +-
 include/hw/{riscv => misc}/sifive_e_prci.h  |   0
 include/hw/{riscv => misc}/sifive_test.h    |   0
 include/hw/{riscv => misc}/sifive_u_otp.h   |   0
 include/hw/{riscv => misc}/sifive_u_prci.h  |   0
 include/hw/net/cadence_gem.h                |   2 +
 include/hw/riscv/microchip_pfsoc.h          | 133 +++++++++
 include/hw/riscv/riscv_hart.h               |   1 +
 include/hw/riscv/sifive_e.h                 |   2 +-
 include/hw/riscv/sifive_u.h                 |  17 +-
 include/hw/sd/cadence_sdhci.h               |  47 +++
 target/riscv/cpu.h                          |   8 +-
 hw/arm/xilinx_zynq.c                        |   1 +
 hw/arm/xlnx-versal.c                        |   1 +
 hw/arm/xlnx-zynqmp.c                        |   2 +
 hw/char/mchp_pfsoc_mmuart.c                 |  86 ++++++
 hw/{riscv => char}/riscv_htif.c             |   2 +-
 hw/{riscv => char}/sifive_uart.c            |   2 +-
 hw/dma/sifive_pdma.c                        | 313 ++++++++++++++++++++
 hw/{riscv => gpio}/sifive_gpio.c            |   2 +-
 hw/{riscv => intc}/sifive_clint.c           |  28 +-
 hw/{riscv => intc}/sifive_plic.c            |   2 +-
 hw/{riscv => misc}/sifive_e_prci.c          |   2 +-
 hw/{riscv => misc}/sifive_test.c            |   4 +-
 hw/{riscv => misc}/sifive_u_otp.c           |   2 +-
 hw/{riscv => misc}/sifive_u_prci.c          |   2 +-
 hw/net/cadence_gem.c                        |   7 +-
 hw/riscv/microchip_pfsoc.c                  | 437 ++++++++++++++++++++++++++++
 hw/riscv/opentitan.c                        |   1 +
 hw/riscv/riscv_hart.c                       |   3 +
 hw/riscv/sifive_e.c                         |  12 +-
 hw/riscv/sifive_u.c                         |  41 ++-
 hw/riscv/spike.c                            |   7 +-
 hw/riscv/virt.c                             |   9 +-
 hw/sd/cadence_sdhci.c                       | 193 ++++++++++++
 target/riscv/cpu.c                          |  19 +-
 target/riscv/cpu_helper.c                   |   8 +-
 target/riscv/csr.c                          |   4 +-
 MAINTAINERS                                 |   9 +
 hw/char/Kconfig                             |   9 +
 hw/char/meson.build                         |   3 +
 hw/dma/Kconfig                              |   3 +
 hw/dma/meson.build                          |   1 +
 hw/gpio/Kconfig                             |   3 +
 hw/gpio/meson.build                         |   1 +
 hw/gpio/trace-events                        |   6 +
 hw/intc/Kconfig                             |   6 +
 hw/intc/meson.build                         |   2 +
 hw/misc/Kconfig                             |  12 +
 hw/misc/meson.build                         |   6 +
 hw/riscv/Kconfig                            |  70 +++--
 hw/riscv/meson.build                        |  12 +-
 hw/riscv/trace-events                       |   7 -
 hw/sd/Kconfig                               |   4 +
 hw/sd/meson.build                           |   1 +
 meson.build                                 |   1 -
 64 files changed, 1575 insertions(+), 105 deletions(-)
 rename {include/hw/riscv => hw/intc}/sifive_plic.h (100%)
 delete mode 100644 hw/riscv/trace.h
 create mode 100644 include/hw/char/mchp_pfsoc_mmuart.h
 rename include/hw/{riscv => char}/riscv_htif.h (100%)
 rename include/hw/{riscv => char}/sifive_uart.h (100%)
 create mode 100644 include/hw/dma/sifive_pdma.h
 rename include/hw/{riscv => gpio}/sifive_gpio.h (100%)
 rename include/hw/{riscv => intc}/sifive_clint.h (92%)
 rename include/hw/{riscv => misc}/sifive_e_prci.h (100%)
 rename include/hw/{riscv => misc}/sifive_test.h (100%)
 rename include/hw/{riscv => misc}/sifive_u_otp.h (100%)
 rename include/hw/{riscv => misc}/sifive_u_prci.h (100%)
 create mode 100644 include/hw/riscv/microchip_pfsoc.h
 create mode 100644 include/hw/sd/cadence_sdhci.h
 create mode 100644 hw/char/mchp_pfsoc_mmuart.c
 rename hw/{riscv => char}/riscv_htif.c (99%)
 rename hw/{riscv => char}/sifive_uart.c (99%)
 create mode 100644 hw/dma/sifive_pdma.c
 rename hw/{riscv => gpio}/sifive_gpio.c (99%)
 rename hw/{riscv => intc}/sifive_clint.c (90%)
 rename hw/{riscv => intc}/sifive_plic.c (99%)
 rename hw/{riscv => misc}/sifive_e_prci.c (99%)
 rename hw/{riscv => misc}/sifive_test.c (97%)
 rename hw/{riscv => misc}/sifive_u_otp.c (99%)
 rename hw/{riscv => misc}/sifive_u_prci.c (99%)
 create mode 100644 hw/riscv/microchip_pfsoc.c
 create mode 100644 hw/sd/cadence_sdhci.c
 delete mode 100644 hw/riscv/trace-events

