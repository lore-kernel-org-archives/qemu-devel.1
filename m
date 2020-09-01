Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AE8C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B04620707
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJLu19Td"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B04620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCvIW-00051N-Ij
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 21:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvHh-0003qx-Kt; Mon, 31 Aug 2020 21:40:29 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvHf-0005UN-Go; Mon, 31 Aug 2020 21:40:29 -0400
Received: by mail-pj1-x1043.google.com with SMTP id 2so869496pjx.5;
 Mon, 31 Aug 2020 18:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wQPHkilrQMomooaP59G9Mj9MFPTLkFKqNxNAUzMzLLQ=;
 b=FJLu19TdNxkNdrY2bQ2PnClhkGo/DTGn9wtJwrXRp88oletXjX250ORXLGNdv/z1k4
 pBRMl0FfCS5AAS+mZChW70iOJvTaXEIhEbGnatTL/Ay/vmP6KDrYvHbi6zClpUcgNDos
 Cteh1t74jmUVf5Nct+4BsOI1fBrAe+zfxy58FTrsoNcXjGCtUj5JzE+BZFPrTt77dahO
 cKrawI6OTBwRoheuEv31/oT3/gGsxayf1aGiTJu43GJdrLrxszsH280a1YMSbO2PIWMo
 iDH1+jtXuFERUf8fg0jykrcMJ+MS/8EdF4t0eex5x35dDAOexxSIKswq/lTsg0Cfjcjh
 vENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wQPHkilrQMomooaP59G9Mj9MFPTLkFKqNxNAUzMzLLQ=;
 b=sObikaPm6PYHvzioaQvSWV/zp+RhRV94Q9fQA6S3LRa/MlMV7fkEtQBaIRgLIfdE1p
 tPeniN910g2CkJ8cQOxBsx8ncw+WbtUv+28s63WWoQpr67RERQ7MdNJQi1sVbGpM6RVB
 +SkXu9nFD+NbKnvWnRevFN7T1kyU1CX9MqTk8yJU01eP9VGR6T+ffQ4PgLxqyUf0ZxK+
 bndyTFHUF1IxvklYwjQ9Xv/5QaCK02hjhMcWOFGHbrky1TuR4gPPVkiUbKqOZ0GOVFV1
 FFSW+XmU/S+sAw2eP69D66WXNrcipTOW3I4OvFaX+p56bwa3yqJKC3UFUsDiBq4MRjps
 pWRQ==
X-Gm-Message-State: AOAM531+j2gQ3e+lvoUgBqAv/p1e18P4+Okc8Rr2vpVgccqJVaLC6zhm
 AyFbh3Nz2gryspASb1kFSXs=
X-Google-Smtp-Source: ABdhPJxWCkDKVN5uLWEFtn5UytjeR8AGK3wDy6lRRNlihvVal9b8mvFC24GOUEbBGYFNC8rr2yaWqw==
X-Received: by 2002:a17:902:bc87:: with SMTP id
 bb7mr3331774plb.146.1598924424998; 
 Mon, 31 Aug 2020 18:40:24 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id l13sm8887520pgq.33.2020.08.31.18.40.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Aug 2020 18:40:24 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 00/16] hw/riscv: Add Microchip PolarFire SoC Icicle Kit
 board support
Date: Tue,  1 Sep 2020 09:38:55 +0800
Message-Id: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

This adds support for Microchip PolarFire SoC Icicle Kit board.
The Icicle Kit board integrates a PolarFire SoC, with one SiFive's
E51 plus four U54 cores and many on-chip peripherals and an FPGA.

For more details about Microchip PolarFire SoC, please see:
https://www.microsemi.com/product-directory/soc-fpgas/5498-polarfire-soc-fpga

The Icicle Kit board information can be found here:
https://www.microsemi.com/existing-parts/parts/152514

Unlike SiFive FU540, the RISC-V core resect vector is at 0x20220000.
The RISC-V CPU and HART codes has been updated to set the core's
reset vector based on a configurable property from machine codes.

The following perepherals are created as an unimplemented device:

- Bus Error Uint 0/1/2/3/4
- L2 cache controller
- SYSREG
- MPUCFG
- IOSCBCFG
- GPIO

The following perepherals are emulated:
- SiFive CLINT
- SiFive PLIC
- PolarFire SoC Multi-Mode UART
- SiFive PDMA
- Cadence eMMC/SDHCI controller
- Cadence Gigabit Ethernet MAC

The BIOS image used by this machine is hss.bin, aka Hart Software
Services, which can be built from:
https://github.com/polarfire-soc/hart-software-services

To launch this machine:
$ qemu-system-riscv64 -M microchip-icicle-kit -smp 5 \
    -bios path/to/hss.bin -sd path/to/sdcard.img \
    -nic tap,ifname=tap,script=no,model=cadence_gem \
    -display none -serial stdio \
    -chardev socket,id=serial1,path=serial1.sock,server,wait \
    -serial chardev:serial1

The memory is set to 1 GiB by default to match the hardware.
A sanity check on ram size is performed in the machine init routine
to prompt user to increase the RAM size to > 1 GiB when less than
1 GiB ram is detected.

HSS output is on the first serial port (stdio) and U-Boot/Linux
outputs on the 2nd serial port. OpenSBI outputs on a random serial
port due to the lottery mechanism used during the multi-core boot.

Please check the QEMU WiKi page for the target specific information:
https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_SoC_Icicle_Kit

Changes in v3:
- rebase on qemu/master
- change MCHP_PFSOC_DMA to SIFIVE_PDMA
- use the correct (Object *) to set the 'phy-addr' in xlnx-zynqmp.c

Changes in v2:
- change to update hw/char/meson.build
- add impl.min_access_size and impl.max_access_size as part of
  MemoryRegionOps and remove the allignment check
- change to update hw/sd/meson.build
- change the name to "generic-sdhci" when calling object_initialize_child()
- add a container MR to simplify out-of-bounds access checks
- do not initialize TYPE_SYSBUS_SDHCI in the SoC instance_init(),
  instead move that to the cadence_sdhci model
- do not access generic-sdhci's state directly,
  instead move that to the cadence_sdhci model
- change to update hw/dma/meson.build
- rename the file names to sifive_pdma.[c|h]
- update irq number to 8 per the SiFive FU540 manual
- fix the register offset for channel 1/2/3 in the read/write ops
- connect 8 IRQs to the PLIC
- change "phy-addr" default value to BOARD_PHY_ADDRESS

Bin Meng (16):
  target/riscv: cpu: Add a new 'resetvec' property
  hw/riscv: hart: Add a new 'resetvec' property
  target/riscv: cpu: Set reset vector based on the configured property
    value
  hw/riscv: Initial support for Microchip PolarFire SoC Icicle Kit board
  hw/char: Add Microchip PolarFire SoC MMUART emulation
  hw/riscv: microchip_pfsoc: Connect 5 MMUARTs
  hw/sd: Add Cadence SDHCI emulation
  hw/riscv: microchip_pfsoc: Connect a Cadence SDHCI controller and an
    SD card
  hw/dma: Add SiFive platform DMA controller emulation
  hw/riscv: microchip_pfsoc: Connect a DMA controller
  hw/net: cadence_gem: Add a new 'phy-addr' property
  hw/arm: xlnx: Set all boards' GEM 'phy-addr' property value to 23
  hw/riscv: microchip_pfsoc: Connect 2 Cadence GEMs
  hw/riscv: microchip_pfsoc: Hook GPIO controllers
  hw/riscv: clint: Avoid using hard-coded timebase frequency
  hw/riscv: sifive_u: Connect a DMA controller

 default-configs/riscv64-softmmu.mak |   1 +
 include/hw/char/mchp_pfsoc_mmuart.h |  61 +++++
 include/hw/dma/sifive_pdma.h        |  57 +++++
 include/hw/net/cadence_gem.h        |   2 +
 include/hw/riscv/microchip_pfsoc.h  | 133 +++++++++++
 include/hw/riscv/riscv_hart.h       |   1 +
 include/hw/riscv/sifive_clint.h     |   4 +-
 include/hw/riscv/sifive_u.h         |  11 +
 include/hw/sd/cadence_sdhci.h       |  47 ++++
 target/riscv/cpu.h                  |   7 +-
 hw/arm/xilinx_zynq.c                |   1 +
 hw/arm/xlnx-versal.c                |   1 +
 hw/arm/xlnx-zynqmp.c                |   2 +
 hw/char/mchp_pfsoc_mmuart.c         |  86 +++++++
 hw/dma/sifive_pdma.c                | 313 ++++++++++++++++++++++++++
 hw/net/cadence_gem.c                |   7 +-
 hw/riscv/microchip_pfsoc.c          | 437 ++++++++++++++++++++++++++++++++++++
 hw/riscv/opentitan.c                |   1 +
 hw/riscv/riscv_hart.c               |   3 +
 hw/riscv/sifive_clint.c             |  26 ++-
 hw/riscv/sifive_e.c                 |   4 +-
 hw/riscv/sifive_u.c                 |  35 ++-
 hw/riscv/spike.c                    |   3 +-
 hw/riscv/virt.c                     |   3 +-
 hw/sd/cadence_sdhci.c               | 193 ++++++++++++++++
 target/riscv/cpu.c                  |   8 +-
 target/riscv/cpu_helper.c           |   4 +-
 target/riscv/csr.c                  |   4 +-
 MAINTAINERS                         |   9 +
 hw/char/Kconfig                     |   3 +
 hw/char/meson.build                 |   1 +
 hw/dma/Kconfig                      |   3 +
 hw/dma/meson.build                  |   1 +
 hw/riscv/Kconfig                    |  10 +
 hw/riscv/meson.build                |   1 +
 hw/sd/Kconfig                       |   4 +
 hw/sd/meson.build                   |   1 +
 37 files changed, 1459 insertions(+), 29 deletions(-)
 create mode 100644 include/hw/char/mchp_pfsoc_mmuart.h
 create mode 100644 include/hw/dma/sifive_pdma.h
 create mode 100644 include/hw/riscv/microchip_pfsoc.h
 create mode 100644 include/hw/sd/cadence_sdhci.h
 create mode 100644 hw/char/mchp_pfsoc_mmuart.c
 create mode 100644 hw/dma/sifive_pdma.c
 create mode 100644 hw/riscv/microchip_pfsoc.c
 create mode 100644 hw/sd/cadence_sdhci.c

-- 
2.7.4


