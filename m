Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99419C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6511D206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ft+XOIqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6511D206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoLR-0006DR-SL
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFW-0007R0-3Q
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFR-0007Xj-Kg
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:10 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:43837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFR-0007W3-Dn
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:09 -0500
Received: by mail-wr1-x431.google.com with SMTP id d16so6710832wre.10
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wZwKT5iuj8uVDc3w5WpvpvyISAx2GIKAn4nymeven8Y=;
 b=ft+XOIqr3XMI8QRmMNhSmx+c0j7O/kyvNfsxFNy4rhs0/PQAaevm8QP8xXeUKTuojo
 iIsZnsmztf+V44eXH8xnoCWRGoVHqTRxKvQCG0DxRCWR7xOFO4vuuZWbB64CUByvMFmF
 lfhgWjO58T1joqOwy2bd9t2jd8Gv4ZdeN7ThPi6Kf+saZqHy43jSc6SMTldYiOcTk4tR
 bF844rPQQ1mLE4b+8d7mlr8AwtimHz9Tq4FeNW6uoUTw1LfEv6RmF1js9Iv1NuZNekB6
 YNO3i98O2yGXNZ376Mw6RRykXePLLtsCQRMPpKI7fulPnb3hLp4paRhGZLX2IeEQ/Btt
 VgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wZwKT5iuj8uVDc3w5WpvpvyISAx2GIKAn4nymeven8Y=;
 b=fRqOMQRKrDwC9Nb/98zgkIuHv15DYI+y5hzqWIZ+y7M4q5bRJap6957bk6I80hFkwN
 GJjeL94O2jE97RQNMATs69xJbN+RvZZo4I4mHTVoh+fDXvusFT5kav0LgaxMG2JxnHd6
 wXnmpCUy+hqW2Vu8A1YPYsJyuwsGYt9je0ujB63oHbOLukKiJ0ajyUsa7OyWAUc1060r
 /K/+XCjqufvIdONwg9Jlm1X8h2Y14ThlK/pbXo/QY114L6aHk7+OSN4+DQKqwimnV3xO
 7oPLNU/Hu1FRqDH+ehYKpUbXKNLcEzfcMriWqI5sFepJUvZml5flbmTXjaj20JvPp30H
 J7WQ==
X-Gm-Message-State: APjAAAUyUnRK2aqQW1LAtmwNIwwcdE/Arrc0v2yZSfnHyVLARxUi5BXN
 YPIp4+AtWcqzhqqoIt/AqrFpziV62b6g6A==
X-Google-Smtp-Source: APXvYqz50s4k2GYOndSLOB9iRoA8Q1cwhXo6XB2uVOfPzww9AkjuTKjlvWjw8xWSS+Hx4QrJUc/G9A==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr29765616wrn.50.1576494547914; 
 Mon, 16 Dec 2019 03:09:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/34] target-arm queue
Date: Mon, 16 Dec 2019 11:08:30 +0000
Message-Id: <20191216110904.30815-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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


First arm pullreq of 5.0!

The following changes since commit 084a398bf8aa7634738e6c6c0103236ee1b3b72f:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-12-13 18:14:07 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191216-1

for you to fetch changes up to f80741d107673f162e3b097fc76a1590036cc9d1:

  target/arm: ensure we use current exception state after SCR update (2019-12-16 10:52:58 +0000)

----------------------------------------------------------------
target-arm queue:
 * Add support for Cortex-M7 CPU
 * exynos4210_gic: Suppress gcc9 format-truncation warnings
 * aspeed: Various minor bug fixes and improvements
 * aspeed: Add support for the tacoma-bmc board
 * Honour HCR_EL32.TID1 and .TID2 trapping requirements
 * Handle trapping to EL2 of AArch32 VMRS instructions
 * Handle AArch32 CP15 trapping via HSTR_EL2
 * Add support for missing Jazelle system registers
 * arm/arm-powerctl: set NSACR.{CP11, CP10} bits in arm_set_cpu_on
 * Add support for DC CVAP & DC CVADP instructions
 * Fix assertion when SCR.NS is changed in Secure-SVC &c
 * enable SHPC native hot plug in arm ACPI

----------------------------------------------------------------
Alex Bennée (1):
      target/arm: ensure we use current exception state after SCR update

Beata Michalska (4):
      tcg: cputlb: Add probe_read
      Memory: Enable writeback for given memory region
      migration: ram: Switch to ram block writeback
      target/arm: Add support for DC CVAP & DC CVADP ins

Christophe Lyon (1):
      target/arm: Add support for cortex-m7 CPU

Cédric Le Goater (12):
      aspeed/i2c: Add support for pool buffer transfers
      aspeed/i2c: Check SRAM enablement on AST2500
      aspeed: Add a DRAM memory region at the SoC level
      aspeed/i2c: Add support for DMA transfers
      aspeed/i2c: Add trace events
      aspeed/smc: Restore default AHB window mapping at reset
      aspeed/smc: Do not map disabled segment on the AST2600
      aspeed/smc: Add AST2600 timings registers
      aspeed: Remove AspeedBoardConfig array and use AspeedMachineClass
      aspeed: Add support for the tacoma-bmc board
      aspeed: Change the "scu" property definition
      aspeed: Change the "nic" property definition

David Gibson (1):
      exynos4210_gic: Suppress gcc9 format-truncation warnings

Heyi Guo (2):
      hw/arm/acpi: simplify AML bit and/or statement
      hw/arm/acpi: enable SHPC native hot plug

Joel Stanley (4):
      aspeed/sdmc: Make ast2600 default 1G
      aspeed/scu: Fix W1C behavior
      watchdog/aspeed: Improve watchdog timeout message
      watchdog/aspeed: Fix AST2600 frequency behaviour

Marc Zyngier (5):
      target/arm: Honor HCR_EL2.TID2 trapping requirements
      target/arm: Honor HCR_EL2.TID1 trapping requirements
      target/arm: Handle trapping to EL2 of AArch32 VMRS instructions
      target/arm: Handle AArch32 CP15 trapping via HSTR_EL2
      target/arm: Add support for missing Jazelle system registers

Niek Linnenbank (1):
      arm/arm-powerctl: set NSACR.{CP11, CP10} bits in arm_set_cpu_on()

PanNengyuan (1):
      gpio: fix memory leak in aspeed_gpio_init()

Philippe Mathieu-Daudé (2):
      hw/arm/sbsa-ref: Simplify by moving the gic in the machine state
      hw/arm/virt: Simplify by moving the gic in the machine state

 include/exec/exec-all.h           |   6 +
 include/exec/memory.h             |   6 +
 include/exec/ram_addr.h           |   8 +
 include/hw/arm/aspeed.h           |  24 +--
 include/hw/arm/aspeed_soc.h       |   1 +
 include/hw/arm/virt.h             |   1 +
 include/hw/i2c/aspeed_i2c.h       |  16 ++
 include/hw/ssi/aspeed_smc.h       |   1 +
 include/hw/watchdog/wdt_aspeed.h  |   1 +
 include/qemu/cutils.h             |   1 +
 target/arm/cpu.h                  |  20 +-
 target/arm/helper.h               |   3 +
 target/arm/translate.h            |   2 +
 exec.c                            |  36 ++++
 hw/arm/aspeed.c                   | 271 +++++++++++++----------
 hw/arm/aspeed_ast2600.c           |  25 ++-
 hw/arm/aspeed_soc.c               |  22 +-
 hw/arm/sbsa-ref.c                 |  86 ++++----
 hw/arm/virt-acpi-build.c          |  21 +-
 hw/arm/virt.c                     | 109 +++++-----
 hw/gpio/aspeed_gpio.c             |   1 +
 hw/i2c/aspeed_i2c.c               | 439 +++++++++++++++++++++++++++++++++++---
 hw/intc/exynos4210_gic.c          |   9 +-
 hw/misc/aspeed_scu.c              |  19 +-
 hw/misc/aspeed_sdmc.c             |   6 +-
 hw/net/ftgmac100.c                |  19 +-
 hw/ssi/aspeed_smc.c               |  63 ++++--
 hw/timer/aspeed_timer.c           |  17 +-
 hw/watchdog/wdt_aspeed.c          |  41 ++--
 linux-user/elfload.c              |   2 +
 memory.c                          |  12 ++
 migration/ram.c                   |   5 +-
 target/arm/arm-powerctl.c         |   3 +
 target/arm/cpu.c                  |  33 +++
 target/arm/cpu64.c                |   1 +
 target/arm/helper.c               | 170 ++++++++++++++-
 target/arm/op_helper.c            |  22 ++
 target/arm/translate-vfp.inc.c    |  20 +-
 target/arm/translate.c            |   9 +-
 target/arm/vfp_helper.c           |  29 +++
 util/cutils.c                     |  38 ++++
 hw/i2c/trace-events               |   9 +
 tests/data/acpi/virt/DSDT         | Bin 18470 -> 18462 bytes
 tests/data/acpi/virt/DSDT.memhp   | Bin 19807 -> 19799 bytes
 tests/data/acpi/virt/DSDT.numamem | Bin 18470 -> 18462 bytes
 45 files changed, 1273 insertions(+), 354 deletions(-)

