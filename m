Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400A7C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC79E216C4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yTm2fVFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC79E216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpCj-0001l1-Mp
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp84-0001zj-Nk
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:48 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp82-0007Vy-4b
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id s12so18873945wrw.11
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EnNTV7+OPS/Qkj7q6BpLWlhxHtmDDvBfdXjalrA7KYs=;
 b=yTm2fVFNuFlHAxrRPCKrWd1eeWtf8YU17aG3GjN27kSPd4UDx/6msvepuXEqbuErBF
 pqYQFIKpQbxpmKskHR9yzcQwb3Y+Y9VpNhTBTXYrFjMN14aeNHykVwiJi95ZhD/q04o4
 9oPHY/QCs0qZouIldt0bmVn4sdx4w0grAvxlxS9BMYkRaJdVvuNZnN+/NB3WLzyAtAU+
 bErHQE5nFtjb9XfeWq8v5uDwWeyDzsTJjECOtVdOIpbaNJ3/AybY+Nl2C+q/p7fMtTZh
 UHagPexKCWx/6TNQ0gZnj5Q4Gncyl/riRDudg/iyllKRJ+h3plympqzUCTcXQ+UElwqi
 LjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EnNTV7+OPS/Qkj7q6BpLWlhxHtmDDvBfdXjalrA7KYs=;
 b=sP0Sw9d6qzD1k92L5/Iw1LiZxEnzmIEcEgUC05mka3dUn+fm2QtWOlJGmeWW9gc+xn
 Ih+fGLhs8rhgYvxpvjjefk5F77m2MTL5oJnvKVOGa4dvT2qbd+K1cw0d24IyR5Vz1D7E
 RxuHpeSij78oxu+fKjD2kaLMKGCN4UQ6JV9PTPjsHA8fvH/hbbTLvoFDZO1JUkyG2uIz
 8RAo+AhkIN31Q73VOHxZviDLJgj/5drMzPBnLSWshM9M+fvXG0IEQWkdVzWCX1YhIqtp
 deGHbLSKlWoKg6Ld8kKp3lBPKp2zSq76mFBsqaQRhSwbNB/GX0LmA2OPMcrp7oo19S1L
 4rPA==
X-Gm-Message-State: AOAM5339lRc2EfEBYUgTug7G9MQ+ozVHTAyGzUmMUH/ZK/oXQZQsgtLE
 RfhL8lww4+R9uFU/0E227kaD3W0ukKmTcs+A
X-Google-Smtp-Source: ABdhPJzSSL3C9m7JGFDog2u2HgpgSALD6c/eAvieKu3NB2iCW7DOpCvhHuYJ7QzDJeSpMvm/jORk2A==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr15608148wrq.424.1600092403828; 
 Mon, 14 Sep 2020 07:06:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/36] target-arm queue
Date: Mon, 14 Sep 2020 15:06:05 +0100
Message-Id: <20200914140641.21369-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Nuvoton new board models, and some more minor stuff. I also put
in the deprecation patches for unicore32 and lm32.

thanks
-- PMM

The following changes since commit a68694cd1f3e5448cca814ff39b871f9ebd71ed5:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20200914' into staging (2020-09-14 12:18:58 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200914

for you to fetch changes up to dd44ae00fc5342ed99acb68ec3508f76a71d523a:

  MAINTAINERS: Add maintainer entry for Xilinx ZynqMP CAN controller (2020-09-14 14:27:08 +0100)

----------------------------------------------------------------
target-arm queue:
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
 * xlnx-zynqmp: implement ZynqMP CAN controllers

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

Vikram Garhwal (4):
      hw/net/can: Introduce Xilinx ZynqMP CAN controller
      xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
      tests/qtest: Introduce tests for Xilinx ZynqMP CAN controller
      MAINTAINERS: Add maintainer entry for Xilinx ZynqMP CAN controller

 docs/system/arm/mps2.rst               |   20 +-
 docs/system/arm/nuvoton.rst            |   92 +++
 docs/system/deprecated.rst             |   32 +-
 docs/system/target-arm.rst             |    1 +
 configure                              |    2 +-
 default-configs/arm-softmmu.mak        |    1 +
 include/hw/arm/npcm7xx.h               |  112 +++
 include/hw/arm/xlnx-zynqmp.h           |    8 +
 include/hw/mem/npcm7xx_mc.h            |   36 +
 include/hw/misc/npcm7xx_clk.h          |   48 ++
 include/hw/misc/npcm7xx_gcr.h          |   43 ++
 include/hw/net/xlnx-zynqmp-can.h       |   78 +++
 include/hw/nvram/npcm7xx_otp.h         |   79 +++
 include/hw/ssi/npcm7xx_fiu.h           |   73 ++
 include/hw/timer/npcm7xx_timer.h       |   78 +++
 target/arm/kvm-consts.h                |    7 -
 target/arm/kvm_arm.h                   |    6 -
 target/arm/neon-dp.decode              |   18 +-
 target/arm/neon-shared.decode          |   18 +-
 tests/decode/succ_ident1.decode        |    7 +
 hw/arm/mps2.c                          |   97 ++-
 hw/arm/npcm7xx.c                       |  532 +++++++++++++++
 hw/arm/npcm7xx_boards.c                |  197 ++++++
 hw/arm/xlnx-versal-virt.c              |    2 +-
 hw/arm/xlnx-zcu102.c                   |   20 +
 hw/arm/xlnx-zynqmp.c                   |   34 +
 hw/mem/npcm7xx_mc.c                    |   84 +++
 hw/misc/a9scu.c                        |   59 +-
 hw/misc/npcm7xx_clk.c                  |  266 ++++++++
 hw/misc/npcm7xx_gcr.c                  |  269 ++++++++
 hw/net/can/xlnx-zynqmp-can.c           | 1165 ++++++++++++++++++++++++++++++++
 hw/nvram/npcm7xx_otp.c                 |  440 ++++++++++++
 hw/ssi/npcm7xx_fiu.c                   |  572 ++++++++++++++++
 hw/timer/armv7m_systick.c              |    8 +
 hw/timer/npcm7xx_timer.c               |  543 +++++++++++++++
 target/arm/cpu.c                       |  101 ++-
 target/arm/helper.c                    |    2 +-
 target/arm/kvm.c                       |    7 -
 target/arm/kvm32.c                     |  595 ----------------
 tests/qtest/xlnx-can-test.c            |  359 ++++++++++
 .gitmodules                            |    3 +
 MAINTAINERS                            |   18 +
 hw/arm/Kconfig                         |    9 +
 hw/arm/meson.build                     |    1 +
 hw/mem/meson.build                     |    1 +
 hw/misc/meson.build                    |    4 +
 hw/misc/trace-events                   |    8 +
 hw/net/can/meson.build                 |    1 +
 hw/nvram/meson.build                   |    1 +
 hw/ssi/meson.build                     |    1 +
 hw/ssi/trace-events                    |   11 +
 hw/timer/meson.build                   |    1 +
 hw/timer/trace-events                  |    5 +
 pc-bios/README                         |    6 +
 pc-bios/meson.build                    |    1 +
 pc-bios/npcm7xx_bootrom.bin            |  Bin 0 -> 768 bytes
 roms/Makefile                          |    7 +
 roms/vbootrom                          |    1 +
 scripts/decodetree.py                  |   46 +-
 target/arm/meson.build                 |    5 +-
 target/arm/translate-neon.c.inc        |   42 +-
 tests/acceptance/boot_linux_console.py |   83 +++
 tests/qtest/meson.build                |    1 +
 63 files changed, 5584 insertions(+), 783 deletions(-)
 create mode 100644 docs/system/arm/nuvoton.rst
 create mode 100644 include/hw/arm/npcm7xx.h
 create mode 100644 include/hw/mem/npcm7xx_mc.h
 create mode 100644 include/hw/misc/npcm7xx_clk.h
 create mode 100644 include/hw/misc/npcm7xx_gcr.h
 create mode 100644 include/hw/net/xlnx-zynqmp-can.h
 create mode 100644 include/hw/nvram/npcm7xx_otp.h
 create mode 100644 include/hw/ssi/npcm7xx_fiu.h
 create mode 100644 include/hw/timer/npcm7xx_timer.h
 create mode 100644 tests/decode/succ_ident1.decode
 create mode 100644 hw/arm/npcm7xx.c
 create mode 100644 hw/arm/npcm7xx_boards.c
 create mode 100644 hw/mem/npcm7xx_mc.c
 create mode 100644 hw/misc/npcm7xx_clk.c
 create mode 100644 hw/misc/npcm7xx_gcr.c
 create mode 100644 hw/net/can/xlnx-zynqmp-can.c
 create mode 100644 hw/nvram/npcm7xx_otp.c
 create mode 100644 hw/ssi/npcm7xx_fiu.c
 create mode 100644 hw/timer/npcm7xx_timer.c
 delete mode 100644 target/arm/kvm32.c
 create mode 100644 tests/qtest/xlnx-can-test.c
 create mode 100644 pc-bios/npcm7xx_bootrom.bin
 create mode 160000 roms/vbootrom

