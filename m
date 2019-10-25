Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB82CA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C4221929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XE1pXmga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C4221929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNySi-00019K-SQ
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 08:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNyRt-0000Fk-6w
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNyRq-000451-E8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:12:08 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNyRq-00044m-75
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:12:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id q130so1784960wme.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 05:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+RE2T9wfMDW2dfXsrkxzuIgUHsYBZZVnGQntpHui/+g=;
 b=XE1pXmgaubxngY/05GOWF3d20eZ5PeNmr6QmHYF6UmDQ5kL3Tn/YFSAIUbUWMjjv0p
 YR09CZ5rG5ACnVP+M0q3kYI3XiIdyWU/fUxk6mG+amBkBeW34XtH3qm+hGHvEjQRitLi
 EWkUhpkMWpxIGQoaYZuUlSG2T9Hn7cqoEE+MeOAeXnX1ly9UgFbtkvd0Zw0SSxbLT6W0
 IiyFxtwibqw6fKOxCYznZCFXe7ejc9/RWhd8IT3mN7bDGssuAMe5+mi0nU7ZrQ7atQ4W
 6bxdFX5JBoT667wasOHcTV+oJze3iP29PDMje3WNWOEFNKnkpaJXBWJVfnIq+ef9/tck
 JzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+RE2T9wfMDW2dfXsrkxzuIgUHsYBZZVnGQntpHui/+g=;
 b=ShEMMx3Y95QHRPmGh2E93f+ycypELkd/qR3lNUjZ6Eb+tLa29v5/Ct2mGKcXVPEE7w
 8Ly+eQPXyyUNf18opAMfNHqhxGjZFNmVKfJX8YKUmVzy6y91BlcxPHRTnSVxh6R3gZ2G
 hzwFO2UP8oPC4kyC1JTGn93ACNo0FEj3106o+ITviAGnmFXqXFmj+lebglVHBiOdgbdz
 oz+GEpxgXXyUV9f9SmsR1y5cMUANwM3emI6steYal080POw9vMpfPQ30AJ2rfBXhTVDZ
 xYsewD5jAu8pHZXIYHiAsUZcsRDRya9pM9AI4aHnHvZ0XvqTt+jZp1KsEdBwUxKxDKyr
 nifw==
X-Gm-Message-State: APjAAAXo84EWN/IVCP7XUWnl2F5PgqoPbg5bUZ6NcJCWuj1XcbfIL1S4
 asDcaGb6xx3Fy9Z0dHaDIZpqLEl+gOQ=
X-Google-Smtp-Source: APXvYqx+GBKkMmyy+qyUJiIlFEGCYKj8TGvJTxTvTp7eQsglR1asCBpQ/Hr2UJQoov4ULGOUK2JZmA==
X-Received: by 2002:a1c:5641:: with SMTP id k62mr3258416wmb.97.1572005524187; 
 Fri, 25 Oct 2019 05:12:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 74sm2238969wrm.92.2019.10.25.05.12.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 05:12:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/42] target-arm queue
Date: Fri, 25 Oct 2019 13:12:01 +0100
Message-Id: <20191025121201.18485-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

Changes from v1: dropped SVE patchset.

The following changes since commit 58560ad254fbda71d4daa6622d71683190070ee2:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.2-20191024' into staging (2019-10-24 16:22:58 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191025

for you to fetch changes up to f9469c1a01c333c08980e083e0ad3417256c8b9c:

  hw/arm/highbank: Use AddressSpace when using write_secondary_boot() (2019-10-25 13:09:27 +0100)

----------------------------------------------------------------
target-arm queue:
 * raspi boards: some cleanup
 * raspi: implement the bcm2835 system timer device
 * raspi: implement a dummy thermal sensor
 * misc devices: switch to ptimer transaction API
 * cache TB flag state to improve performance of cpu_get_tb_cpu_state
 * aspeed: Add an AST2600 eval board

----------------------------------------------------------------
Cédric Le Goater (2):
      hw/gpio: Fix property accessors of the AST2600 GPIO 1.8V model
      aspeed: Add an AST2600 eval board

Peter Maydell (8):
      hw/net/fsl_etsec/etsec.c: Switch to transaction-based ptimer API
      hw/timer/xilinx_timer.c: Switch to transaction-based ptimer API
      hw/dma/xilinx_axidma.c: Switch to transaction-based ptimer API
      hw/timer/slavio_timer: Remove useless check for NULL t->timer
      hw/timer/slavio_timer.c: Switch to transaction-based ptimer API
      hw/timer/grlib_gptimer.c: Switch to transaction-based ptimer API
      hw/m68k/mcf5206.c: Switch to transaction-based ptimer API
      hw/watchdog/milkymist-sysctl.c: Switch to transaction-based ptimer API

Philippe Mathieu-Daudé (8):
      hw/misc/bcm2835_thermal: Add a dummy BCM2835 thermal sensor
      hw/arm/bcm2835_peripherals: Use the thermal sensor block
      hw/timer/bcm2835: Add the BCM2835 SYS_timer
      hw/arm/bcm2835_peripherals: Use the SYS_timer
      hw/arm/bcm2836: Make the SoC code modular
      hw/arm/bcm2836: Rename cpus[] as cpu[].core
      hw/arm/raspi: Use AddressSpace when using arm_boot::write_secondary_boot
      hw/arm/highbank: Use AddressSpace when using write_secondary_boot()

Richard Henderson (24):
      target/arm: Split out rebuild_hflags_common
      target/arm: Split out rebuild_hflags_a64
      target/arm: Split out rebuild_hflags_common_32
      target/arm: Split arm_cpu_data_is_big_endian
      target/arm: Split out rebuild_hflags_m32
      target/arm: Reduce tests vs M-profile in cpu_get_tb_cpu_state
      target/arm: Split out rebuild_hflags_a32
      target/arm: Split out rebuild_hflags_aprofile
      target/arm: Hoist XSCALE_CPAR, VECLEN, VECSTRIDE in cpu_get_tb_cpu_state
      target/arm: Simplify set of PSTATE_SS in cpu_get_tb_cpu_state
      target/arm: Hoist computation of TBFLAG_A32.VFPEN
      target/arm: Add arm_rebuild_hflags
      target/arm: Split out arm_mmu_idx_el
      target/arm: Hoist store to cs_base in cpu_get_tb_cpu_state
      target/arm: Add HELPER(rebuild_hflags_{a32, a64, m32})
      target/arm: Rebuild hflags at EL changes
      target/arm: Rebuild hflags at MSR writes
      target/arm: Rebuild hflags at CPSR writes
      target/arm: Rebuild hflags at Xscale SCTLR writes
      target/arm: Rebuild hflags for M-profile
      target/arm: Rebuild hflags for M-profile NVIC
      linux-user/aarch64: Rebuild hflags for TARGET_WORDS_BIGENDIAN
      linux-user/arm: Rebuild hflags for TARGET_WORDS_BIGENDIAN
      target/arm: Rely on hflags correct in cpu_get_tb_cpu_state

 hw/misc/Makefile.objs                |   1 +
 hw/timer/Makefile.objs               |   1 +
 hw/net/fsl_etsec/etsec.h             |   1 -
 include/hw/arm/aspeed.h              |   1 +
 include/hw/arm/bcm2835_peripherals.h |   5 +-
 include/hw/arm/bcm2836.h             |   4 +-
 include/hw/arm/raspi_platform.h      |   1 +
 include/hw/misc/bcm2835_thermal.h    |  27 +++
 include/hw/timer/bcm2835_systmr.h    |  33 +++
 target/arm/cpu.h                     |  84 +++++---
 target/arm/helper.h                  |   4 +
 target/arm/internals.h               |   9 +
 hw/arm/aspeed.c                      |  23 ++
 hw/arm/bcm2835_peripherals.c         |  30 ++-
 hw/arm/bcm2836.c                     |  44 ++--
 hw/arm/highbank.c                    |   3 +-
 hw/arm/raspi.c                       |  14 +-
 hw/dma/xilinx_axidma.c               |   9 +-
 hw/gpio/aspeed_gpio.c                |   8 +-
 hw/intc/armv7m_nvic.c                |  22 +-
 hw/m68k/mcf5206.c                    |  15 +-
 hw/misc/bcm2835_thermal.c            | 135 ++++++++++++
 hw/net/fsl_etsec/etsec.c             |   9 +-
 hw/timer/bcm2835_systmr.c            | 163 +++++++++++++++
 hw/timer/grlib_gptimer.c             |  28 ++-
 hw/timer/milkymist-sysctl.c          |  25 ++-
 hw/timer/slavio_timer.c              |  32 ++-
 hw/timer/xilinx_timer.c              |  13 +-
 linux-user/aarch64/cpu_loop.c        |   1 +
 linux-user/arm/cpu_loop.c            |   1 +
 linux-user/syscall.c                 |   1 +
 target/arm/cpu.c                     |   1 +
 target/arm/helper-a64.c              |   3 +
 target/arm/helper.c                  | 393 +++++++++++++++++++++++------------
 target/arm/m_helper.c                |   6 +
 target/arm/machine.c                 |   1 +
 target/arm/op_helper.c               |   4 +
 target/arm/translate-a64.c           |  13 +-
 target/arm/translate.c               |  33 ++-
 hw/timer/trace-events                |   5 +
 40 files changed, 945 insertions(+), 261 deletions(-)
 create mode 100644 include/hw/misc/bcm2835_thermal.h
 create mode 100644 include/hw/timer/bcm2835_systmr.h
 create mode 100644 hw/misc/bcm2835_thermal.c
 create mode 100644 hw/timer/bcm2835_systmr.c

