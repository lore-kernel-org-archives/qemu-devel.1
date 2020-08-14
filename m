Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DECC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0EE3207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F4H4eGUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EE3207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bTD-0007z6-5M
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQO-0003PT-2z
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:20 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQK-0007bQ-Vq
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597418117; x=1628954117;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=C0XaOZXVZ1mP0mMppQ0w8h2usGXgNAwdJMoBgibbfz0=;
 b=F4H4eGUEaqv5DFgKAaE/i9KubA7H6U9bk6ZAeaQd+iS4b+xmKnhwXBqG
 dJxbepAVuLrblUh336qYu0cfyWIOZKpqYDPFg3L8vDNLvNhh2RFm/QUn4
 OAHiF37/tYtnB2Di3gHE0tVO2NMe1guvDJt6W/FjbeURffyRpYq9qILmp
 Qulgk8rApZIMf5FR0dOpfnJvF74HQS/j423lftdW+R4OvljXu6/77U49W
 4IcXygprCT29uzt7chHNcOPO8PdDBVXloMjwzCOk4Fi12vg6Sebyoc6cl
 jfj/KQ+LfDgEK5PQ5lbCVqX1Rdwzuz87dkhfLGPBlYIuE0Ax93zPMH5nu g==;
IronPort-SDR: JJHLXo8QM028KkrmEeonZ4fUf4hIBdxA8MWtKux4zD6yZIgmZY/ubkw13BcF4LD6UdG+zdMwAC
 fnbdpvyOBdwVcxvzy1oGycwaMWYLAdp2L1FMp0G+Rx5oDBd1iD5UOnPG/DkYawF8lHjB6KCVZI
 661G9h4zD85CPjyPkx/IjHurZd1ukqQTip++JgzmpVFkKnulPnBdFByTqgUDXH8/oMayyIwr/R
 PkQ2FshoAP2fyBTUHHM0e4fLGIdETm1SUI/NziIc3GlKnMa3ckV3AvxyOK/sJsALc5jXc/eZQY
 IHQ=
X-IronPort-AV: E=Sophos;i="5.76,312,1592841600"; d="scan'208";a="144994802"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2020 23:15:12 +0800
IronPort-SDR: xoWChVXGgrVJ1fqpNiIhWScjeCvS14F6tA4S3zp0pt7WT5NAUco2jCRudb1ZvxxQqlG3PC8nAC
 RDVRBJ4PCB6A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 08:02:16 -0700
IronPort-SDR: hKoZRoC1mSIZ858HjvVpNdYwFW+y74GhWCSR54M2dyHpdzEmG5GwlVFJtEBOi1vDbwJMflZ5dv
 d+HqgRZYTHUA==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Aug 2020 08:15:11 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/20] riscv-to-apply queue
Date: Fri, 14 Aug 2020 08:04:46 -0700
Message-Id: <20200814150506.2070566-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=4887bfbec=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 11:15:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:

  Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200814

for you to fetch changes up to f57d45853ead8f3ff2c295a6b93b386b56396020:

  hw/intc: ibex_plic: Honour source priorities (2020-08-13 14:20:03 -0700)

----------------------------------------------------------------
The first RISC-V PR for the 5.2 window.

This includes:
 - NaNBox fixes
 - Vector extension improvements
 - a L2 cache controller
 - PMP fixes
 - Upgrade to OpenSBI v0.8 and the generic platform
 - Fixes for the Ibex PLIC

----------------------------------------------------------------
Alistair Francis (3):
      hw/intc: ibex_plic: Update the pending irqs
      hw/intc: ibex_plic: Don't allow repeat interrupts on claimed lines
      hw/intc: ibex_plic: Honour source priorities

Bin Meng (7):
      hw/riscv: sifive_u: Add a dummy L2 cache controller device
      configure: Create symbolic links for pc-bios/*.elf files
      roms/opensbi: Upgrade from v0.7 to v0.8
      roms/Makefile: Build the generic platform for RISC-V OpenSBI firmware
      hw/riscv: Use pre-built bios image of generic platform for virt & sifive_u
      hw/riscv: spike: Change the default bios to use generic platform image
      gitlab-ci/opensbi: Update GitLab CI to build generic platform

Hou Weiying (1):
      riscv: Fix bug in setting pmpcfg CSR for RISCV64

LIU Zhiwei (2):
      target/riscv: Clean up fmv.w.x
      target/riscv: check before allocating TCG temps

Richard Henderson (5):
      target/riscv: Generate nanboxed results from fp helpers
      target/riscv: Generalize gen_nanbox_fpr to gen_nanbox_s
      target/riscv: Generate nanboxed results from trans_rvf.inc.c
      target/riscv: Check nanboxed inputs to fp helpers
      target/riscv: Check nanboxed inputs in trans_rvf.inc.c

Zong Li (2):
      target/riscv: Fix the translation of physical address
      target/riscv: Change the TLB page size depends on PMP entries.

 configure                                      |   1 +
 Makefile                                       |   4 +-
 include/hw/intc/ibex_plic.h                    |   1 +
 include/hw/riscv/sifive_u.h                    |   4 +
 target/riscv/internals.h                       |  16 ++++
 target/riscv/pmp.h                             |   2 +
 hw/intc/ibex_plic.c                            |  36 +++++++--
 hw/riscv/sifive_u.c                            |  26 ++++++-
 hw/riscv/spike.c                               |   9 ++-
 hw/riscv/virt.c                                |   4 +-
 target/riscv/cpu_helper.c                      |  15 +++-
 target/riscv/fpu_helper.c                      | 102 ++++++++++++++++---------
 target/riscv/insn_trans/trans_rvd.inc.c        |   8 +-
 target/riscv/insn_trans/trans_rvf.inc.c        |  99 +++++++++++++++---------
 target/riscv/pmp.c                             |  57 +++++++++++++-
 target/riscv/translate.c                       |  29 +++++++
 .gitlab-ci.d/opensbi.yml                       |  28 +++----
 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 0 -> 62144 bytes
 pc-bios/opensbi-riscv32-generic-fw_dynamic.elf | Bin 0 -> 558668 bytes
 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin   | Bin 49520 -> 0 bytes
 pc-bios/opensbi-riscv32-virt-fw_jump.bin       | Bin 49504 -> 0 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 0 -> 70792 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.elf | Bin 0 -> 620424 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin   | Bin 57936 -> 0 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin       | Bin 57920 -> 0 bytes
 roms/Makefile                                  |  32 +++-----
 roms/opensbi                                   |   2 +-
 27 files changed, 338 insertions(+), 137 deletions(-)
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.elf
 delete mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.elf
 delete mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin

