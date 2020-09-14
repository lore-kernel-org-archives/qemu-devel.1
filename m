Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18EEC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2C9217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgJsAnPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2C9217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrcv-0000Zh-Br
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHq0Z-0004av-1g
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:03:10 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:44780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHq0S-0007Rs-Un
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:03:06 -0400
Received: by mail-wr1-x431.google.com with SMTP id s12so19097189wrw.11
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZtpT+xt6cTZNa7AtMysMjQ4Nuvw3w7evk1Aqw/sDTfg=;
 b=cgJsAnPdJc0904I3/SSV5vXDfExlj2W1d+siN4UkUoFFYhZXyi0bzbbTI25XxgFPgu
 e/jAQg2xQUfiC6IwYLMpvaoAsEob1EfWDgLf7X/y4pVGUYWfOB/bEWGOgV2Zik6jZfAy
 HEgnmnC3233pnRP0IiinTMIMXBpUBWTiO+seR6ZbSHykVcW0qRCqNDPR3WHO6k37+odH
 qqgMmvmJKpbdWY/nEv9aOd/iEq/enOJpHKMcZ8LTzV8xT73Atx0+9KosUzjrfCXhgLdk
 8+QxiHwo9uiNs7aYsPAaSRBsrr1eJ2/aHCO0pe7zdx/gh3Jz3VFiSEbX6Nh+FyWpUHPy
 klrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZtpT+xt6cTZNa7AtMysMjQ4Nuvw3w7evk1Aqw/sDTfg=;
 b=MtroOdfPEiLNKIdYW+64lp9Pjeqy1zZxRR4CVzfvCg2BaY7Qa+4Oin8pAlYQh2DKM1
 u/8491L8xC0xgNNL+1xPVZJEy/us9YyEC+TFOzmVXwMHLEQChdh8u4/cte8kgMQXCVlA
 YvswS+D+3dLNFlf9QmhzDh+eC3UYCVd7NkPlp717aeEdms/hvOTC7W3O/46srU4xYZbS
 q9yv7zT4q5rY5PtdXThQ5u5cJIGeLSFYVhq5lV9HrEzsRyrYEnG3wr3j5pQU03lcmB8z
 U/n9xN3ZWAsn2jypUSz4pn47s5d8NJslRbGjiUw9xUt64sYVJIA6DPo6yPPKFuqp1m6h
 3wIw==
X-Gm-Message-State: AOAM533roTb6GDLKqWNcNmfw5pTDBYVq1SdhTAOL5PK8bBBV/TY3CogC
 LpWU5YdZ5jGrBfbxm7TiftOrqIRPPCaPCelv
X-Google-Smtp-Source: ABdhPJwUJXuF3zUZpy5Ux6nVB4il6UGyNH7d5d+Z5GXz/kAEx4Qa31DnKsTlGm7KXvSn5791jr8U/Q==
X-Received: by 2002:adf:fa52:: with SMTP id y18mr16631208wrr.264.1600095777358; 
 Mon, 14 Sep 2020 08:02:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v17sm22315615wrc.23.2020.09.14.08.02.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 08:02:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/32] target-arm queue
Date: Mon, 14 Sep 2020 16:02:54 +0100
Message-Id: <20200914150254.6489-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For some reason the xilinx can bus patches built in my local config
but not in the merge-test ones; dropped those.

-- PMM

The following changes since commit a68694cd1f3e5448cca814ff39b871f9ebd71ed5:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20200914' into staging (2020-09-14 12:18:58 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200914-1

for you to fetch changes up to 4fe986dd4480308ecf07200cfbd3c3d494a0f639:

  tests/acceptance: console boot tests for quanta-gsj (2020-09-14 14:24:59 +0100)

----------------------------------------------------------------
 * hw/misc/a9scu: Do not allow invalid CPU count
 * hw/misc/a9scu: Minor cleanups
 * hw/timer/armv7m_systick: assert that board code set system_clock_scale
 * decodetree: Improve identifier matching
 * target/arm: Clean up neon fp insn size field decode
 * target/arm: Remove KVM support for 32-bit Arm hosts
 * hw/arm/mps2: New board models mps2-an386, mps2-an500
 * Deprecate Unicore32 port
 * Deprecate lm32 port
 * target/arm: Count PMU events when MDCR.SPME is set
 * hw/arm: versal-virt: Correct the tx/rx GEM clocks
 * New Nuvoton iBMC board models npcm750-evb, quanta-gsj

----------------------------------------------------------------
Aaron Lindsay (1):
      target/arm: Count PMU events when MDCR.SPME is set

Edgar E. Iglesias (1):
      hw/arm: versal-virt: Correct the tx/rx GEM clocks

Havard Skinnemoen (14):
      hw/misc: Add NPCM7xx System Global Control Registers device model
      hw/misc: Add NPCM7xx Clock Controller device model
      hw/timer: Add NPCM7xx Timer device model
      hw/arm: Add NPCM730 and NPCM750 SoC models
      hw/arm: Add two NPCM7xx-based machines
      roms: Add virtual Boot ROM for NPCM7xx SoCs
      hw/arm: Load -bios image as a boot ROM for npcm7xx
      hw/nvram: NPCM7xx OTP device model
      hw/mem: Stubbed out NPCM7xx Memory Controller model
      hw/ssi: NPCM7xx Flash Interface Unit device model
      hw/arm: Wire up BMC boot flash for npcm750-evb and quanta-gsj
      hw/arm/npcm7xx: add board setup stub for CPU and UART clocks
      docs/system: Add Nuvoton machine documentation
      tests/acceptance: console boot tests for quanta-gsj

Peter Maydell (11):
      hw/timer/armv7m_systick: assert that board code set system_clock_scale
      target/arm: Convert Neon 3-same-fp size field to MO_* in decode
      target/arm: Convert Neon VCVT fp size field to MO_* in decode
      target/arm: Convert VCMLA, VCADD size field to MO_* in decode
      target/arm: Remove KVM support for 32-bit Arm hosts
      target/arm: Remove no-longer-reachable 32-bit KVM code
      hw/arm/mps2: New board model mps2-an386
      hw/arm/mps2: New board model mps2-an500
      docs/system/arm/mps2.rst: Make board list consistent
      Deprecate Unicore32 port
      Deprecate lm32 port

Philippe Mathieu-Daudé (4):
      hw/misc/a9scu: Do not allow invalid CPU count
      hw/misc/a9scu: Simplify setting MemoryRegionOps::valid fields
      hw/misc/a9scu: Simplify setting MemoryRegionOps::impl fields
      hw/misc/a9scu: Report unimplemented accesses with qemu_log_mask(UNIMP)

Richard Henderson (1):
      decodetree: Improve identifier matching

 docs/system/arm/mps2.rst               |  20 +-
 docs/system/arm/nuvoton.rst            |  92 +++++
 docs/system/deprecated.rst             |  32 +-
 docs/system/target-arm.rst             |   1 +
 configure                              |   2 +-
 default-configs/arm-softmmu.mak        |   1 +
 include/hw/arm/npcm7xx.h               | 112 +++++++
 include/hw/mem/npcm7xx_mc.h            |  36 ++
 include/hw/misc/npcm7xx_clk.h          |  48 +++
 include/hw/misc/npcm7xx_gcr.h          |  43 +++
 include/hw/nvram/npcm7xx_otp.h         |  79 +++++
 include/hw/ssi/npcm7xx_fiu.h           |  73 ++++
 include/hw/timer/npcm7xx_timer.h       |  78 +++++
 target/arm/kvm-consts.h                |   7 -
 target/arm/kvm_arm.h                   |   6 -
 target/arm/neon-dp.decode              |  18 +-
 target/arm/neon-shared.decode          |  18 +-
 tests/decode/succ_ident1.decode        |   7 +
 hw/arm/mps2.c                          |  97 +++++-
 hw/arm/npcm7xx.c                       | 532 +++++++++++++++++++++++++++++
 hw/arm/npcm7xx_boards.c                | 197 +++++++++++
 hw/arm/xlnx-versal-virt.c              |   2 +-
 hw/mem/npcm7xx_mc.c                    |  84 +++++
 hw/misc/a9scu.c                        |  59 ++--
 hw/misc/npcm7xx_clk.c                  | 266 +++++++++++++++
 hw/misc/npcm7xx_gcr.c                  | 269 +++++++++++++++
 hw/nvram/npcm7xx_otp.c                 | 440 ++++++++++++++++++++++++
 hw/ssi/npcm7xx_fiu.c                   | 572 +++++++++++++++++++++++++++++++
 hw/timer/armv7m_systick.c              |   8 +
 hw/timer/npcm7xx_timer.c               | 543 ++++++++++++++++++++++++++++++
 target/arm/cpu.c                       | 101 +++---
 target/arm/helper.c                    |   2 +-
 target/arm/kvm.c                       |   7 -
 target/arm/kvm32.c                     | 595 ---------------------------------
 .gitmodules                            |   3 +
 MAINTAINERS                            |  10 +
 hw/arm/Kconfig                         |   9 +
 hw/arm/meson.build                     |   1 +
 hw/mem/meson.build                     |   1 +
 hw/misc/meson.build                    |   4 +
 hw/misc/trace-events                   |   8 +
 hw/nvram/meson.build                   |   1 +
 hw/ssi/meson.build                     |   1 +
 hw/ssi/trace-events                    |  11 +
 hw/timer/meson.build                   |   1 +
 hw/timer/trace-events                  |   5 +
 pc-bios/README                         |   6 +
 pc-bios/meson.build                    |   1 +
 pc-bios/npcm7xx_bootrom.bin            | Bin 0 -> 768 bytes
 roms/Makefile                          |   7 +
 roms/vbootrom                          |   1 +
 scripts/decodetree.py                  |  46 ++-
 target/arm/meson.build                 |   5 +-
 target/arm/translate-neon.c.inc        |  42 ++-
 tests/acceptance/boot_linux_console.py |  83 +++++
 55 files changed, 3910 insertions(+), 783 deletions(-)
 create mode 100644 docs/system/arm/nuvoton.rst
 create mode 100644 include/hw/arm/npcm7xx.h
 create mode 100644 include/hw/mem/npcm7xx_mc.h
 create mode 100644 include/hw/misc/npcm7xx_clk.h
 create mode 100644 include/hw/misc/npcm7xx_gcr.h
 create mode 100644 include/hw/nvram/npcm7xx_otp.h
 create mode 100644 include/hw/ssi/npcm7xx_fiu.h
 create mode 100644 include/hw/timer/npcm7xx_timer.h
 create mode 100644 tests/decode/succ_ident1.decode
 create mode 100644 hw/arm/npcm7xx.c
 create mode 100644 hw/arm/npcm7xx_boards.c
 create mode 100644 hw/mem/npcm7xx_mc.c
 create mode 100644 hw/misc/npcm7xx_clk.c
 create mode 100644 hw/misc/npcm7xx_gcr.c
 create mode 100644 hw/nvram/npcm7xx_otp.c
 create mode 100644 hw/ssi/npcm7xx_fiu.c
 create mode 100644 hw/timer/npcm7xx_timer.c
 delete mode 100644 target/arm/kvm32.c
 create mode 100644 pc-bios/npcm7xx_bootrom.bin
 create mode 160000 roms/vbootrom

