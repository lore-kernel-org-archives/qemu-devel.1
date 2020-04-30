Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A32C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8BA20774
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOw32oAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8BA20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUAS6-0007IG-IQ
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUAQy-0006Io-8p
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUAQx-0002zJ-0o
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:45:03 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:44876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUAQw-0002tM-GZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:45:02 -0400
Received: by mail-wr1-x435.google.com with SMTP id d17so7222947wrg.11
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o03GEJHAEin06hy2s0mzQS70eb/2rkMMYtrKlM7rZzI=;
 b=vOw32oAE0aFanKF8xqvm6sieGWrGi/MBmktqeOZMk/7VuQucDM5IzA5SMpPFn6k0SK
 sAn/EAjmgyU/1CB/5ypjHxoXgPxMo+2BN8HVYzgu72qjMNfRFXQxxle2fq7k+WSYw1RB
 aWZtbrDQRB0Pc+dcuAOxibKhSycEEJSfh3DAQNZBcmODiRKNQQ5jGsr3mFPUcQVXB2ZA
 Fkx9p9i917oVYbDFEd9PwlVmlFr8OMWeYI02eSPAMWJW8WfXo1tTeGnYb35bumOu3l3d
 kRHWXmEZHG3sTrnQ3C5NBRbenSOXATaOTqCDL85zw4J5PccvGvcP/8lzt/IsFo8IMNy4
 oyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o03GEJHAEin06hy2s0mzQS70eb/2rkMMYtrKlM7rZzI=;
 b=S76s/3LmjNBnL1UVJ6/jVR32CZm1ZOfsk8gm5p8BJRZFWERm02DK/mslY/Mzde/ib8
 7NoIbJeISmRZMpNyJZTUtgFZftl+Vpi7/C2h7Qa78OyUOGLL1bKhkHSubu6t/TgFff6j
 rANdy35ch50k8uF30GXdh4pIaWjKK4ZeEhPY8vnpdvyND5rNBxViRV9THxyoW/8rwPdX
 Lt98RvScgb0/67ZPYhHjybL/y65nExlvaOnlkDR3rcym/AFaojIkqlQMXLXSIEbMYWaZ
 n5JWJwsrl5frOEXd9TsF01F1zKpaZGpCT/KqmwEaGag/q/gxr66bevCpiR97N0GwTBhw
 sA1g==
X-Gm-Message-State: AGi0PuaIcmTfkvWW/44tJ22DXdbS1fzgjfic/aVfwdZDMb8JH23iByHd
 om293DBIblvko0UVnMDklhrXVWR2DVzwBQ==
X-Google-Smtp-Source: APiQypIEtazXesUL9lDVSSwdTMCz033/TcXIs1/GdFm8DzCC5kpylxxKEcZy95CpAJ75UZMZknglnA==
X-Received: by 2002:adf:df8d:: with SMTP id z13mr4325479wrl.304.1588257900352; 
 Thu, 30 Apr 2020 07:45:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u3sm4186435wrt.93.2020.04.30.07.44.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 07:44:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/30] target-arm queue
Date: Thu, 30 Apr 2020 15:44:58 +0100
Message-Id: <20200430144458.17324-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::435
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

v2:
 * dropped target/arm/cpu: Use ARRAY_SIZE() to iterate over ARMCPUInfo[]
 * renamed CLOCK_SECOND to CLOCK_PERIOD_1SEC


The following changes since commit 648db19685b7030aa558a4ddbd3a8e53d8c9a062:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2020-04-29' into staging (2020-04-29 15:07:33 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200430-1

for you to fetch changes up to 6f7b6947a6639fff15c6a0956adf0f5ec004b789:

  hw/arm: xlnx-zcu102: Disable unsupported FDT firmware nodes (2020-04-30 15:35:41 +0100)

----------------------------------------------------------------
target-arm queue:
 * xlnx-zdma: Fix endianness handling of descriptor loading
 * nrf51: Fix last GPIO CNF address
 * gicv3: Use gicr_typer in arm_gicv3_icc_reset
 * msf2: Add EMAC block to SmartFusion2 SoC
 * New clock modelling framework
 * hw/arm: versal: Setup the ADMA with 128bit bus-width
 * Cadence: gem: fix wraparound in 64bit descriptors
 * cadence_gem: clear RX control descriptor
 * target/arm: Vectorize integer comparison vs zero
 * hw/arm/virt: dt: add kaslr-seed property
 * hw/arm: xlnx-zcu102: Disable unsupported FDT firmware nodes

----------------------------------------------------------------
Cameron Esfahani (1):
      nrf51: Fix last GPIO CNF address

Damien Hedde (7):
      hw/core/clock-vmstate: define a vmstate entry for clock state
      qdev: add clock input&output support to devices.
      qdev-clock: introduce an init array to ease the device construction
      hw/misc/zynq_slcr: add clock generation for uarts
      hw/char/cadence_uart: add clock support
      hw/arm/xilinx_zynq: connect uart clocks to slcr
      qdev-monitor: print the device's clock with info qtree

Edgar E. Iglesias (7):
      dma/xlnx-zdma: Fix descriptor loading (MEM) wrt endianness
      dma/xlnx-zdma: Fix descriptor loading (REG) wrt endianness
      hw/arm: versal: Setup the ADMA with 128bit bus-width
      device_tree: Allow name wildcards in qemu_fdt_node_path()
      device_tree: Constify compat in qemu_fdt_node_path()
      hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102
      hw/arm: xlnx-zcu102: Disable unsupported FDT firmware nodes

Jerome Forissier (2):
      hw/arm/virt: dt: move creation of /secure-chosen to create_fdt()
      hw/arm/virt: dt: add kaslr-seed property

Keqian Zhu (2):
      bugfix: Use gicr_typer in arm_gicv3_icc_reset
      Typo: Correct the name of CPU hotplug memory region

Peter Maydell (2):
      hw/core/clock: introduce clock object
      docs/clocks: add device's clock documentation

Philippe Mathieu-Daudé (2):
      target/arm: Restrict the Address Translate write operation to TCG accel
      target/arm/cpu: Update coding style to make checkpatch.pl happy

Ramon Fried (2):
      Cadence: gem: fix wraparound in 64bit descriptors
      net: cadence_gem: clear RX control descriptor

Richard Henderson (1):
      target/arm: Vectorize integer comparison vs zero

Subbaraya Sundeep (3):
      hw/net: Add Smartfusion2 emac block
      msf2: Add EMAC block to SmartFusion2 SoC
      tests/boot_linux_console: Add ethernet test to SmartFusion2

Thomas Huth (1):
      target/arm: Make cpu_register() available for other files

 hw/core/Makefile.objs                  |   2 +
 hw/net/Makefile.objs                   |   1 +
 tests/Makefile.include                 |   1 +
 include/hw/arm/msf2-soc.h              |   2 +
 include/hw/char/cadence_uart.h         |   1 +
 include/hw/clock.h                     | 225 +++++++++++++
 include/hw/gpio/nrf51_gpio.h           |   2 +-
 include/hw/net/msf2-emac.h             |  53 +++
 include/hw/qdev-clock.h                | 159 +++++++++
 include/hw/qdev-core.h                 |  12 +
 include/sysemu/device_tree.h           |   5 +-
 target/arm/cpu-qom.h                   |   9 +-
 target/arm/helper.h                    |  27 +-
 target/arm/translate.h                 |   5 +
 device_tree.c                          |   4 +-
 hw/acpi/cpu.c                          |   2 +-
 hw/arm/msf2-soc.c                      |  26 +-
 hw/arm/virt.c                          |  20 +-
 hw/arm/xilinx_zynq.c                   |  57 +++-
 hw/arm/xlnx-versal.c                   |   2 +
 hw/arm/xlnx-zcu102.c                   |  39 ++-
 hw/char/cadence_uart.c                 |  73 +++-
 hw/core/clock-vmstate.c                |  25 ++
 hw/core/clock.c                        | 130 ++++++++
 hw/core/qdev-clock.c                   | 185 +++++++++++
 hw/core/qdev.c                         |  12 +
 hw/dma/xlnx-zdma.c                     |  25 +-
 hw/intc/arm_gicv3_kvm.c                |   4 +-
 hw/misc/zynq_slcr.c                    | 172 +++++++++-
 hw/net/cadence_gem.c                   |  16 +-
 hw/net/msf2-emac.c                     | 589 +++++++++++++++++++++++++++++++++
 qdev-monitor.c                         |   9 +
 target/arm/cpu.c                       |  19 +-
 target/arm/cpu64.c                     |   8 +-
 target/arm/helper.c                    |  17 +
 target/arm/neon_helper.c               |  24 --
 target/arm/translate-a64.c             |  64 +---
 target/arm/translate.c                 | 256 ++++++++++++--
 target/arm/vec_helper.c                |  25 ++
 MAINTAINERS                            |   2 +
 docs/devel/clocks.rst                  | 391 ++++++++++++++++++++++
 docs/devel/index.rst                   |   1 +
 hw/char/trace-events                   |   3 +
 hw/core/trace-events                   |   7 +
 tests/acceptance/boot_linux_console.py |  15 +-
 45 files changed, 2533 insertions(+), 193 deletions(-)
 create mode 100644 include/hw/clock.h
 create mode 100644 include/hw/net/msf2-emac.h
 create mode 100644 include/hw/qdev-clock.h
 create mode 100644 hw/core/clock-vmstate.c
 create mode 100644 hw/core/clock.c
 create mode 100644 hw/core/qdev-clock.c
 create mode 100644 hw/net/msf2-emac.c
 create mode 100644 docs/devel/clocks.rst

