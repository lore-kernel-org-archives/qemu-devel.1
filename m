Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE74C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC5A207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kys7XJET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC5A207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRCt-0005P6-Nd
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRB6-0003T9-Tj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRB2-0002cf-FD
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762008; x=1631298008;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aYu0GpPWoRsqP4tZ+MhbPKGqbvP+SZ3XPZ4lM9SMqcQ=;
 b=Kys7XJETULWIVdABVHsC3ixaru+SxTx0FVb7f29L5VqEIHOmAkSe/gP0
 pFowr5jvjzMB6S6UqoAQ14CypXtcO+1nrJ8i5KaR4UWar8VYqRk8XBtIl
 BqDukpVSMRQRAU1q1maQ9dJWfUGmROEPu9v2AodqgoGhOhqWAo3Nh9xgE
 Y7/BbcpmhjTdHL/OCh9/9jXEGz9d7ywRpGOuQm+W5aqch9htMKThOvBvi
 lMoSrsdg2outggEIsm6ILrlctM263KXdzqpnpnyJv075E0HON7aF2B6wv
 AVqz/dDW5m96N+pwLN2BrlHd2j+5z3txEi/kcRwEcHyu4CliaNmmAi00L w==;
IronPort-SDR: fTR6v9XJ+7KWT7yJzgiBl8LsvO8xqWHjVeElPLbQVZl+AcO2iqx7qGFB2L/OxBW9QaIwQzqXsx
 mr3DCHDS2xdetHMrsuxZ7y3KeJgf5bVBjYGaDnMpbyJTd1iaFvWvORa6IlHLUDdHyZ1e/CRd1e
 evEmvBLHMcSXTND1/EGAyBWk9Edg9RK9OZ1v/3JG/Y6O87BD7MpcDLwlgSEuv57aaxaYUsAnVG
 ofynGaTE1wcbLaKjLFs3bqUOjPObJawvueB8ZvqD4T/2GP7t5G5M5Qd6OhkO14d4ApTvhZBcla
 p+k=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979149"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:03 +0800
IronPort-SDR: Nq0b30KibmTUIjj4TKgIoPjRAjgnlsTJW1qg4k3f5BM6PxbvrUkS+6BgAuX2xZ1x4rfTh4NLwh
 NGjroTGa8p4g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:20 -0700
IronPort-SDR: pSFaIqKUgV94Ek6dJqCa3LRT0MKIWrz+7KX3ZMydK1ikYrpkLcPN439ijC/s4j/CA83z7e7JwP
 6MQebCmHMECA==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Sep 2020 11:20:03 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 00/30] riscv-to-apply queue
Date: Thu, 10 Sep 2020 11:08:54 -0700
Message-Id: <20200910180924.584156-1-alistair.francis@wdc.com>
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

