Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5C7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A374207DD
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HD/oE3tJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A374207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmAdK-0007Ef-PV
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbg-0005Tc-Ls
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbe-00028E-5S
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548470; x=1624084470;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3fOEVJH73Cid+Crj9dZeNILk6d9N/hX0nmGut4NNaWY=;
 b=HD/oE3tJIIc22UDilJJQJ9sfvU5N18FJZcNTejJ29JeYs4Dc2RKPVmEq
 kWPN5mdsfG+4HcML+in5ee7pIGMTSDxhhACj5Nme0VyBf9bx21EIzPSYe
 zV+Q+IBh/74pbp+rm5ILSu5Gn7odvesZXbwbNH34zyQfDwOXkjrf1YwHD
 Ix0yMODLilC5Qv2Gg3i+Mi3GyTA83HPpZgk4Z+15M9AWE4/a+JbzmUd0D
 tdMdSej3W+FreRFurp34cyWBiraFGosJYWs0wbbIrhCmEAVjjOyt1gn9R
 mLXQpUYlu9lfycBBL4l3jRg0+1xJH0OVz7DTEALoWz3BmT+YbuNVp09yO Q==;
IronPort-SDR: Rw06fPXi844+9kBPO1DgLxRKs4+gtiCxC0DeRzIDaGsOGgdahyOsmh8sTuUMPtxaWr2xclZ2As
 eIPno3Mh+hCB6XDlyoXsCudGbNgD9QxZVRczLZE8RLq4SN0IzAywGY0EQL0Xdb4X2/rHHc1FCg
 8mKOCG49QNMPNIH33edFj32koiREGZnF67ZezAw5cxV07VsB9pIZtrKX74qFjg1SQxDPo7+7yw
 GfxGScxTvFjpPDtpmnWmxwjUGUUmb7OaxB/nrdfHGObMjUugsO5AgT0XF+fxOUjmShcwiwLY/e
 KJw=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="144724270"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:26 +0800
IronPort-SDR: pn0jn0AKKAndJ24paZuJOp/5/FHrmY5/s2O/gRIPNo74ZDw3eAwFU92UlXE5gbsWhJW2dJHXDf
 VYo+olpNiIwldIb/+1byK0GFM8mjww99M=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:37 -0700
IronPort-SDR: EERR59rTR4L7LflObp2cUzc2DsN90HJMVmUdz4hPPhbV1+6kqCKGmc+Tqp+OMLF2j6hA76IaA+
 wXQWuUlHgsFg==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:25 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 00/32] riscv-to-apply queue
Date: Thu, 18 Jun 2020 23:24:46 -0700
Message-Id: <20200619062518.1718523-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:34:26
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

The following changes since commit eefe34ea4b82c2b47abe28af4cc7247d51553626:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20200617a' into staging (2020-06-18 15:30:13 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200618-1

for you to fetch changes up to fad6a8463510ff5e0fb31bb451a6c3218a45d179:

  hw/riscv: sifive_u: Add a dummy DDR memory controller device (2020-06-18 23:09:16 -0700)

----------------------------------------------------------------
This is a range of patches for RISC-V.

Some key points are:
 - Generalise the CPU init functions
 - Support the SiFive revB machine
 - Improvements to the Hypervisor implementation and error checking
 - Connect some OpenTitan devices
 - Changes to the sifive_u machine to support U-boot

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

