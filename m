Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D7FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40867205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="umecrGdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40867205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgLv-0002L0-L0
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxU-0006oh-EM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxR-0000e6-CY
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:30 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxQ-0000dU-UP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:29 -0400
Received: by mail-wr1-x443.google.com with SMTP id t16so21669938wrr.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N9Wa6GXsq2Rj5Y1S6r/KHxw3huNUqxJSZE661YxRMe0=;
 b=umecrGdf4eF5+wFOHZC/ZDRwyStPzJqnIhhxVqt3h+ds4+/Dz4HAJTexFTDK91PLdS
 9NVS7mbVvluDEh1bnlJlCXtEa9o4YS67Bp7N1uJXK8gss4XOVl5VuvOuiK1EfGIHxCLd
 wzSFyAkV8MeeRkGyhoo12oKmJNiW5XlPiCOfLZDP9auN/Q2tf9s3sQz1+wi5GHj2DYYB
 y1kNcJR0+vDUeIvOyDgZ0tgZrowQBheFXHH15lXw0NG4qg78GDVsEl152nJeZuhnUrBh
 06nJhtiyUdE5vjqK/IbhzNhpz+Ge8wR50pVzGJ9zogB6EUW1qoZxoRrSvjyFDYKtKiMM
 zdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N9Wa6GXsq2Rj5Y1S6r/KHxw3huNUqxJSZE661YxRMe0=;
 b=CWiPc9UTqU40lciRw1miZMiSfNIyRz+11tCLbczxEoTtvXmTTduVnfrAmrR3IuSZOx
 pFzPYZf7N0IztJ/ye3nIgHgnjTqXdiAH5jxn8sYHYMrMdgYeN39YPQoT/U156gaMZmlN
 +8DITYdwPi3GqpT3EuZdM4RO9s6e8qV03q4arGX7nSTigQKpyhMq4J/smjKew89FFMj0
 l/5V4Kel1D0x8kaLhBU6uC3UdAsopwZRjXhAkZXN24g/jLOzS9OJOpjL9nK6hRoF9Bs8
 QruIRzoNCx2qhPniMP0kFXkpsq+i0otJ1Z+ur/6hIZexIts76wjqkfytIPfq/CPvatGF
 wsGg==
X-Gm-Message-State: APjAAAWJje3Jv2AcUUvNJxceUYt6YzHOMA5RYsB0z92WNiCfMTq0T/HJ
 W7oO2m075emWdUzhH1VULO4xRsn2w1I=
X-Google-Smtp-Source: APXvYqx3n++/31oNHR3mywk6LQDp1LiUFjXYEBA7A9Mc1eTRLa794eVb4ovlJIqpg7uPgmRrl+qhzA==
X-Received: by 2002:adf:fd88:: with SMTP id d8mr4517705wrr.200.1571934447170; 
 Thu, 24 Oct 2019 09:27:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/51] target-arm queue
Date: Thu, 24 Oct 2019 17:26:33 +0100
Message-Id: <20191024162724.31675-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Probably the last arm pullreq before softfreeze...

The following changes since commit 58560ad254fbda71d4daa6622d71683190070ee2:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.2-20191024' into staging (2019-10-24 16:22:58 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191024

for you to fetch changes up to a01a4a3e85ae8f6fe21adbedc80f7013faabdcf4:

  hw/arm/highbank: Use AddressSpace when using write_secondary_boot() (2019-10-24 17:16:30 +0100)

----------------------------------------------------------------
target-arm queue:
 * raspi boards: some cleanup
 * raspi: implement the bcm2835 system timer device
 * raspi: implement a dummy thermal sensor
 * KVM: support providing SVE to the guest
 * misc devices: switch to ptimer transaction API
 * cache TB flag state to improve performance of cpu_get_tb_cpu_state
 * aspeed: Add an AST2600 eval board

----------------------------------------------------------------
Andrew Jones (9):
      target/arm/monitor: Introduce qmp_query_cpu_model_expansion
      tests: arm: Introduce cpu feature tests
      target/arm: Allow SVE to be disabled via a CPU property
      target/arm/cpu64: max cpu: Introduce sve<N> properties
      target/arm/kvm64: Add kvm_arch_get/put_sve
      target/arm/kvm64: max cpu: Enable SVE when available
      target/arm/kvm: scratch vcpu: Preserve input kvm_vcpu_init features
      target/arm/cpu64: max cpu: Support sve properties with KVM
      target/arm/kvm: host cpu: Add support for sve<N> properties

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
 tests/Makefile.include               |   5 +-
 qapi/machine-target.json             |   6 +-
 hw/net/fsl_etsec/etsec.h             |   1 -
 include/hw/arm/aspeed.h              |   1 +
 include/hw/arm/bcm2835_peripherals.h |   5 +-
 include/hw/arm/bcm2836.h             |   4 +-
 include/hw/arm/raspi_platform.h      |   1 +
 include/hw/misc/bcm2835_thermal.h    |  27 ++
 include/hw/timer/bcm2835_systmr.h    |  33 +++
 include/qemu/bitops.h                |   1 +
 target/arm/cpu.h                     | 105 +++++--
 target/arm/helper.h                  |   4 +
 target/arm/internals.h               |   9 +
 target/arm/kvm_arm.h                 |  39 +++
 hw/arm/aspeed.c                      |  23 ++
 hw/arm/bcm2835_peripherals.c         |  30 +-
 hw/arm/bcm2836.c                     |  44 +--
 hw/arm/highbank.c                    |   3 +-
 hw/arm/raspi.c                       |  14 +-
 hw/dma/xilinx_axidma.c               |   9 +-
 hw/gpio/aspeed_gpio.c                |   8 +-
 hw/intc/armv7m_nvic.c                |  22 +-
 hw/m68k/mcf5206.c                    |  15 +-
 hw/misc/bcm2835_thermal.c            | 135 +++++++++
 hw/net/fsl_etsec/etsec.c             |   9 +-
 hw/timer/bcm2835_systmr.c            | 163 +++++++++++
 hw/timer/grlib_gptimer.c             |  28 +-
 hw/timer/milkymist-sysctl.c          |  25 +-
 hw/timer/slavio_timer.c              |  32 ++-
 hw/timer/xilinx_timer.c              |  13 +-
 linux-user/aarch64/cpu_loop.c        |   1 +
 linux-user/arm/cpu_loop.c            |   1 +
 linux-user/syscall.c                 |   1 +
 target/arm/cpu.c                     |  26 +-
 target/arm/cpu64.c                   | 364 +++++++++++++++++++++--
 target/arm/helper-a64.c              |   3 +
 target/arm/helper.c                  | 403 +++++++++++++++++---------
 target/arm/kvm.c                     |  25 +-
 target/arm/kvm32.c                   |   6 +-
 target/arm/kvm64.c                   | 325 ++++++++++++++++++---
 target/arm/m_helper.c                |   6 +
 target/arm/machine.c                 |   1 +
 target/arm/monitor.c                 | 158 ++++++++++
 target/arm/op_helper.c               |   4 +
 target/arm/translate-a64.c           |  13 +-
 target/arm/translate.c               |  33 ++-
 tests/arm-cpu-features.c             | 540 +++++++++++++++++++++++++++++++++++
 docs/arm-cpu-features.rst            | 317 ++++++++++++++++++++
 hw/timer/trace-events                |   5 +
 51 files changed, 2725 insertions(+), 323 deletions(-)
 create mode 100644 include/hw/misc/bcm2835_thermal.h
 create mode 100644 include/hw/timer/bcm2835_systmr.h
 create mode 100644 hw/misc/bcm2835_thermal.c
 create mode 100644 hw/timer/bcm2835_systmr.c
 create mode 100644 tests/arm-cpu-features.c
 create mode 100644 docs/arm-cpu-features.rst

