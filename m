Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E72C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BA920774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Cq6OpsDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BA920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zRg-0003sk-Fr
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQS-0002G0-Vx
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQP-0005lp-UL
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272050; x=1628808050;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aw07KdbMYmTC5+DVpXPdFFWuLs99YJFabUaxAVYapdY=;
 b=Cq6OpsDGXSUKoFsccZQzYQmOe3iuCS8vRZDTszBreNGWKwbBU59CLHh3
 npLHrsUANuyli2clDz8ihMlgMcVAoc1Ej049S2DNiJTOskbbdnhXCHj17
 rNO11Up1dqT4agBaHSbOvgB62/zB+liqX0tTiP1V/gWqFmftKEuuqmZOD
 FazH+Oo7fa7h42wY+Fv9LF30Jufyvuex/nl686CgQqnkMnLyoMAzmFWNq
 eITIZTzXShLKeKvU+pmCZUpNTrQzHA5O13qUKjD1KWzwRGMu1iTY+6/AK
 w+CKbs6dm1JebCk9T7JqOf0cOOCO9Ayk02afEgxWzLNug/N58IYpi/98P Q==;
IronPort-SDR: v6tir55fqFLgCvkwEFIluz2SCE/QJYIIPBtzXCHN6/+rtEBjm54M5Y6CMZ2GPngIQ5XO/yKGNM
 4U9p4v1C3lnHGfwYzCQQdw3h3LHA5WELDLPQfUBOZkJly10Bq1Cb7w6eGGPc8Gl2xV+wpRx5/l
 Vj9ZBSvR6yoX7LO3Ke7EQ/dQqxQqr0t0EG/6ij4Mn/fXYaMXlks8y9sM7wHmQTrZrzsXJFDWDA
 IPmMclJwP6vx74pmO0nx6e1Evzkemqvlb3m5ElfSAKmV09aBUenl3K8R8wIxCleyG8io1GNH7Q
 dq0=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="144853389"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:47 +0800
IronPort-SDR: iundp8AN5YkdNcSI61gkpiPTJRgGr34iUqc7LzyTSqMUKAqUHJU81XAJXPLVXhMcqQekyerCAx
 AqaONCo+RPrw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:28:37 -0700
IronPort-SDR: 0mM1n362UySmaSYxxAgZNpdOERufk0DjYpdwSLUzeE+mbVkzEf1kCel475F93YBz8etvqigdWN
 OOPVbh05O7XQ==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:44 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] riscv-to-apply queue
Date: Wed, 12 Aug 2020 15:30:25 -0700
Message-Id: <20200812223045.96803-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:40:47
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

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200812

for you to fetch changes up to 339332b8aa240e4ea3a56ec1b98cc9b2e1346834:

  hw/intc: ibex_plic: Honour source priorities (2020-08-12 12:07:58 -0700)

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

