Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08850C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BCC20771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S9sbgHXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BCC20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKVA-000277-19
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUA-0000cV-W2
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKU8-0004PR-1W
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586444; x=1624122444;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wCzH4ldf0iBAHVrs//zx0ycxxx0p01PIIaQfMaxgfe8=;
 b=S9sbgHXJs0N9XJbe/YsrlK3uPpjinyH6LhvVTZpKJxG1ZPcp2vruhIPj
 B0vgTk6boBcV3rSjyi9pkuYFcs4mFH9dgB9uJyOLMrctO9hK9dcKfFAoG
 aCIxTFoF/3vOyXg+vhWL+3FW02xdH7aTE4xeaaegZvqV0vSO/148hZeKk
 CrU/+Nnh1uuSW7RoBDp1pc4BTAV2LZ2tRpgPIz4BTJ2oPHujJPlQNZ/8j
 4epM1wBPbWkE8VTyAXGrSsFnhB2fScKv7UaUnP9Ql6LqnZsuKjDxrJIPV
 CP6rn2ylf/tapF5I7VXJaF83Hs2WaKgKcWBkmSRz5av8Ek7XMAmD8xDRw Q==;
IronPort-SDR: A44IoC1dVEsOBXVGFzcg7ZV9Bpfd4NGKflT+MLiXEhdJWb5K0p9P0gTajtId4EzEkZGn16phmM
 CODFecRGkPgDzhZPzKTxm4396wiCTU+UCEnejHl1XLpdlR+/lDvIhes8JAxpS6B68sR4MyP1e/
 eituQ8IyWVgkagMIgEU6OBMcAUq7AXdWNHbZMlIln7uoRfvpUgwv0elW+x9xsIs25dMpdcp8db
 /vPOW/3rz+DzlYUjkU8LbIRAgdvmVbPeWD1vQy5nYhoZdGhNhlo6QCCefNBI+PqjI/Rgkj23nA
 kMk=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="144763293"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:21 +0800
IronPort-SDR: CngtkR53n6kQ+9tZbzVmNtydz0IEVIBcwCQy2u3GcgH6hyF0eVk91nKqoE40RgAnrlZe9Z7PiL
 8oIYECzKzfRQijjH2791SWmqcF6bo47Vg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:55:58 -0700
IronPort-SDR: BSNfBf9ybprIWhWPxtubCU+DqDzswv2OnZnHrERCdI2CeC6ZYk6/WlTD1yjGuLIZn3i9HtkJ59
 oiDI31xmF5rA==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 00/32] riscv-to-apply queue
Date: Fri, 19 Jun 2020 09:57:45 -0700
Message-Id: <20200619165817.4144200-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

The following changes since commit 4d285821c5055ed68a6f6b7693fd11a06a1aa426:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200618' into staging (2020-06-19 11:44:03 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200619-3

for you to fetch changes up to 3eaea6eb4e534f7b87c6eca808149bb671976800:

  hw/riscv: sifive_u: Add a dummy DDR memory controller device (2020-06-19 08:25:27 -0700)

----------------------------------------------------------------
This is a range of patches for RISC-V.

Some key points are:
 - Generalise the CPU init functions
 - Support the SiFive revB machine
 - Improvements to the Hypervisor implementation and error checking
 - Connect some OpenTitan devices
 - Changes to the sifive_u machine to support U-boot

v2:
 - Fix missing realise assert

----------------------------------------------------------------
Alistair Francis (11):
      sifive_e: Support the revB machine
      target/riscv: Set access as data_load when validating stage-2 PTEs
      target/riscv: Report errors validating 2nd-stage PTEs
      target/riscv: Move the hfence instructions to the rvh decode
      target/riscv: Implement checks for hfence
      riscv/opentitan: Fix the ROM size
      hw/char: Initial commit of Ibex UART
      hw/intc: Initial commit of lowRISC Ibex PLIC
      riscv/opentitan: Connect the PLIC device
      riscv/opentitan: Connect the UART device
      target/riscv: Use a smaller guess size for no-MMU PMP

Bin Meng (20):
      riscv: Generalize CPU init routine for the base CPU
      riscv: Generalize CPU init routine for the gcsu CPU
      riscv: Generalize CPU init routine for the imacu CPU
      riscv: Keep the CPU init routine names consistent
      hw/riscv: sifive_e: Remove the riscv_ prefix of the machine* and soc* functions
      hw/riscv: opentitan: Remove the riscv_ prefix of the machine* and soc* functions
      hw/riscv: sifive_u: Simplify the GEM IRQ connect code a little bit
      hw/riscv: sifive_u: Generate device tree node for OTP
      hw/riscv: sifive_gpio: Clean up the codes
      hw/riscv: sifive_gpio: Add a new 'ngpio' property
      hw/riscv: sifive_u: Hook a GPIO controller
      hw/riscv: sifive_gpio: Do not blindly trigger output IRQs
      hw/riscv: sifive_u: Add reset functionality
      hw/riscv: sifive_u: Rename serial property get/set functions to a generic name
      hw/riscv: sifive_u: Add a new property msel for MSEL pin state
      target/riscv: Rename IBEX CPU init routine
      hw/riscv: sifive: Change SiFive E/U CPU reset vector to 0x1004
      hw/riscv: sifive_u: Support different boot source per MSEL pin state
      hw/riscv: sifive_u: Sort the SoC memmap table entries
      hw/riscv: sifive_u: Add a dummy DDR memory controller device

Ian Jiang (1):
      riscv: Add helper to make NaN-boxing for FP register

 include/hw/char/ibex_uart.h                    | 110 ++++++
 include/hw/intc/ibex_plic.h                    |  63 ++++
 include/hw/riscv/opentitan.h                   |  16 +
 include/hw/riscv/sifive_e.h                    |   1 +
 include/hw/riscv/sifive_gpio.h                 |   8 +-
 include/hw/riscv/sifive_u.h                    |  27 ++
 target/riscv/helper.h                          |   5 +
 target/riscv/insn32.decode                     |   8 +-
 hw/char/ibex_uart.c                            | 492 +++++++++++++++++++++++++
 hw/intc/ibex_plic.c                            | 261 +++++++++++++
 hw/riscv/opentitan.c                           |  71 +++-
 hw/riscv/sifive_e.c                            |  60 ++-
 hw/riscv/sifive_gpio.c                         |  45 ++-
 hw/riscv/sifive_u.c                            | 157 ++++++--
 target/riscv/cpu.c                             |  69 ++--
 target/riscv/cpu_helper.c                      |   9 +-
 target/riscv/insn_trans/trans_privileged.inc.c |  38 --
 target/riscv/insn_trans/trans_rvf.inc.c        |  17 +-
 target/riscv/insn_trans/trans_rvh.inc.c        |  37 ++
 target/riscv/op_helper.c                       |  13 +
 target/riscv/pmp.c                             |  14 +-
 target/riscv/translate.c                       |   1 +
 MAINTAINERS                                    |   4 +
 hw/char/Makefile.objs                          |   1 +
 hw/intc/Makefile.objs                          |   1 +
 hw/riscv/Kconfig                               |   4 +
 26 files changed, 1350 insertions(+), 182 deletions(-)
 create mode 100644 include/hw/char/ibex_uart.h
 create mode 100644 include/hw/intc/ibex_plic.h
 create mode 100644 hw/char/ibex_uart.c
 create mode 100644 hw/intc/ibex_plic.c
 create mode 100644 target/riscv/insn_trans/trans_rvh.inc.c

