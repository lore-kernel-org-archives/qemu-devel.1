Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B6CC3B18B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362E92073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lM25owbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362E92073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fic-0005z8-Ci
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgi-0004As-4s
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgg-0001Oh-55
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:56 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:33770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgc-0001BY-I9
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:54 -0500
Received: by mail-wr1-x432.google.com with SMTP id u6so7017958wrt.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PGSDCccbGiXjX/zXoKO/zem9AXmsZofLXoSgTSuBx04=;
 b=lM25owbb3dVdXDyDVqpfgaI7HpTXLclOrHv2kn+fPB0drwXsAupBpLJXxg51k0CR3S
 D6TXrn53TuM1X8CeIq/WVtARoubribljt0Y9sBG6PRrTGo3ZXYbuag7VY4hqZecXWo1/
 TUR4mz72KsXmarnM2JBeTjZoCSf6pIqmKN5ac3Kt6VKqdjideopy1OB7IrirTkB0t4Jd
 +5roxzkTyOgIq0Q0L205NJV7HlFU97mHuKRkM218/ncONwjIxzOOz88sQko+IGgH25fV
 CmP6g5cEjuXI3DojIDfG0d5NEml75qMG37b+KlBcP94fe+FaqgX9q5/Es1exYa/B/mKd
 sRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PGSDCccbGiXjX/zXoKO/zem9AXmsZofLXoSgTSuBx04=;
 b=VHl2kuR8o8uQ5Zc0o9uVXuULK//HTu0GycYG1sRHabN4EUyQSilSb6ArXSbvbP6qNg
 sBz0xWHHmnOQnT1CqbFrDWu0lqVLVeaOM8kW8skwZFyAnWf2rebWWKVxdnndBWlcJIs/
 q0/snzEEPiblP4oYlgOGN535aEEMrVe7QhdJpY5p825nRAmMOQK8M+3DhLBKZbTGaUSk
 7diC+hcKETjuLB9RIOMJkOBFRdv/V9iXsW4yhnCa1Aa0qVWAAXWI92G41KYyK+qgKDwW
 XxekxQWRLQXj4N5VuHrinM6i0j8tmINO4f6l6hiR/2m7UqzDMQZe6SuZMVspCSCF/xK2
 LI8Q==
X-Gm-Message-State: APjAAAXVgrfNiZ1bCqmOqpm3HJ2AQXQEV6EwswB0F6xoo2XPV56p5AOR
 9kwkwiMRUBUcH6yis2umw0AGmngVuIY=
X-Google-Smtp-Source: APXvYqzuu4X3gvA9qgcmdtPY4eP4uVaPcbciV5uXwOPljhfAMWk8KRTSJ3NTiK4mm5mOcrHUusUeBA==
X-Received: by 2002:adf:f28c:: with SMTP id k12mr23004748wro.360.1581604907954; 
 Thu, 13 Feb 2020 06:41:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.41.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:41:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/46] target-arm queue
Date: Thu, 13 Feb 2020 14:40:59 +0000
Message-Id: <20200213144145.818-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

Big pullreq this week, since it's got RTH's PAN/UAO/ATS1E1
implementation in it, and also Philippe's raspi board model
cleanup patchset, as well as a scattering of smaller stuff.

-- PMM


The following changes since commit 7ce9ce89930ce260af839fb3e3e5f9101f5c69a0:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20200212-pull-request' into staging (2020-02-13 11:06:32 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200213

for you to fetch changes up to dc7a88d0810ad272bdcd2e0869359af78fdd9114:

  target/arm: Implement ARMv8.1-VMID16 extension (2020-02-13 14:30:51 +0000)

----------------------------------------------------------------
target-arm queue:
 * i.MX: Fix inverted sense of register bits in watchdog timer
 * i.MX: Add support for WDT on i.MX6
 * arm/virt: cleanups to ACPI tables
 * Implement ARMv8.1-VMID16 extension
 * Implement ARMv8.1-PAN
 * Implement ARMv8.2-UAO
 * Implement ARMv8.2-ATS1E1
 * ast2400/2500/2600: Wire up EHCI controllers
 * hw/char/exynos4210_uart: Fix memleaks in exynos4210_uart_init
 * hw/arm/raspi: Clean up the board code

----------------------------------------------------------------
Chen Qun (1):
      hw/char/exynos4210_uart: Fix memleaks in exynos4210_uart_init

Guenter Roeck (2):
      hw/arm: ast2400/ast2500: Wire up EHCI controllers
      hw/arm: ast2600: Wire up EHCI controllers

Heyi Guo (7):
      bios-tables-test: prepare to change ARM virt ACPI DSDT
      arm/virt/acpi: remove meaningless sub device "RP0" from PCI0
      arm/virt/acpi: remove _ADR from devices identified by _HID
      arm/acpi: fix PCI _PRT definition
      arm/acpi: fix duplicated _UID of PCI interrupt link devices
      arm/acpi: simplify the description of PCI _CRS
      virt/acpi: update golden masters for DSDT update

Peter Maydell (1):
      target/arm: Implement ARMv8.1-VMID16 extension

Philippe Mathieu-Daudé (13):
      hw/arm/raspi: Use BCM2708 machine type with pre Device Tree kernels
      hw/arm/raspi: Correct the board descriptions
      hw/arm/raspi: Extract the version from the board revision
      hw/arm/raspi: Extract the RAM size from the board revision
      hw/arm/raspi: Extract the processor type from the board revision
      hw/arm/raspi: Trivial code movement
      hw/arm/raspi: Make machines children of abstract RaspiMachineClass
      hw/arm/raspi: Make board_rev a field of RaspiMachineClass
      hw/arm/raspi: Let class_init() directly call raspi_machine_init()
      hw/arm/raspi: Set default RAM size to size encoded in board revision
      hw/arm/raspi: Extract the board model from the board revision
      hw/arm/raspi: Use a unique raspi_machine_class_init() method
      hw/arm/raspi: Extract the cores count from the board revision

Richard Henderson (20):
      target/arm: Add arm_mmu_idx_is_stage1_of_2
      target/arm: Add mmu_idx for EL1 and EL2 w/ PAN enabled
      target/arm: Add isar_feature tests for PAN + ATS1E1
      target/arm: Move LOR regdefs to file scope
      target/arm: Split out aarch32_cpsr_valid_mask
      target/arm: Mask CPSR_J when Jazelle is not enabled
      target/arm: Replace CPSR_ERET_MASK with aarch32_cpsr_valid_mask
      target/arm: Use aarch32_cpsr_valid_mask in helper_exception_return
      target/arm: Remove CPSR_RESERVED
      target/arm: Introduce aarch64_pstate_valid_mask
      target/arm: Update MSR access for PAN
      target/arm: Update arm_mmu_idx_el for PAN
      target/arm: Enforce PAN semantics in get_S1prot
      target/arm: Set PAN bit as required on exception entry
      target/arm: Implement ATS1E1 system registers
      target/arm: Enable ARMv8.2-ATS1E1 in -cpu max
      target/arm: Add ID_AA64MMFR2_EL1
      target/arm: Update MSR access to UAO
      target/arm: Implement UAO semantics
      target/arm: Enable ARMv8.2-UAO in -cpu max

Roman Kapl (2):
      i.MX: Fix inverted register bits in wdt code.
      i.MX: Add support for WDT on i.MX6

 include/hw/arm/aspeed_soc.h       |   6 +
 include/hw/arm/fsl-imx6.h         |   3 +
 target/arm/cpu-param.h            |   2 +-
 target/arm/cpu.h                  |  95 ++++++++---
 target/arm/internals.h            |  85 ++++++++++
 hw/arm/aspeed_ast2600.c           |  23 +++
 hw/arm/aspeed_soc.c               |  25 +++
 hw/arm/fsl-imx6.c                 |  21 +++
 hw/arm/raspi.c                    | 190 ++++++++++++++++------
 hw/arm/virt-acpi-build.c          |  25 +--
 hw/char/exynos4210_uart.c         |   5 +-
 hw/misc/imx2_wdt.c                |   2 +-
 target/arm/cpu.c                  |   4 +
 target/arm/cpu64.c                |  10 ++
 target/arm/helper-a64.c           |   6 +-
 target/arm/helper.c               | 327 +++++++++++++++++++++++++++++---------
 target/arm/kvm64.c                |   2 +
 target/arm/op_helper.c            |  14 +-
 target/arm/translate-a64.c        |  31 ++++
 target/arm/translate.c            |  42 +++--
 tests/data/acpi/virt/DSDT         | Bin 18462 -> 5307 bytes
 tests/data/acpi/virt/DSDT.memhp   | Bin 19799 -> 6644 bytes
 tests/data/acpi/virt/DSDT.numamem | Bin 18462 -> 5307 bytes
 23 files changed, 731 insertions(+), 187 deletions(-)

