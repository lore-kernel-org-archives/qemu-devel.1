Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68373C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3381A20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y0UVN9w/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3381A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWBR-0000q7-FT
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWAE-0007g4-Ld
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWA8-00060J-Oh
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591201365; x=1622737365;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tZ9wGSapWYWJy8E5B+mTHvinWTbr7aWDWaZ3GOgkX4E=;
 b=Y0UVN9w/WxUwJdetTlBbPd/fv6+9WxCxaHr/X5Zdjp+8C8OjcD/LVkHJ
 dz7Fy1Q6+dueyI+LAZd914gEjledvZH7x3ZYVp8Sy6/P3BFkt/NGJkz+7
 KEwoyMLuOjyfqEl3p+ibTpWjXawlsqzxc5ggvkqu44iVKeKjoNW9qmCoT
 kPGjYD9igF4NIwo3CG/mP4ubaFyMnC9DzO92TBqRqU1rcV+qbEk4Mgike
 ngmIo+wyawOYqbnj44DkX91NE761G5SzuHc10igy9iMw7SgJ7FkHf17Jp
 /fH2FETuar+gEad1x4wavFpUsQfbXTaGyylH74NiM+GaH4j019B0AqcQw A==;
IronPort-SDR: ThNe8d3oHPo1bsQQpQOTQTB22yYJZGAGPckU1h/ixnhDXu07+ioB13T25cAHJJd1cOJKBjezfX
 UgAMhdSyLHzKF2bq/k+fLaboBhMjrBeCQ/A8BCtdAULnXhsn0e9D1zIIX/2u1zGZYMy1mgn28D
 FDI9uZbq4rodGKJ7streOCZugdwULdgnRbGl2Of+2dava/8Ir4ZOiuDGuV5KUmDSKrqoZAQ8Xr
 Ucj8tf+nG7aRPQ1+S2qfnRYw6QSRVYNSOIb0KgHHWvz7+qIGROcar0Cxpf8LAStwXIaETnTt6i
 9vk=
X-IronPort-AV: E=Sophos;i="5.73,468,1583164800"; d="scan'208";a="143451350"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 00:22:40 +0800
IronPort-SDR: FYz67G5l41Lr1+8TFXx2BAm2PVHN24lDzM0pLo1PuLxMezcV5SOR6z0QHcXD3HqspB7v8hgduV
 wBzSqeeF40lh2bbdPeViSyKuclBYlmq18=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 09:11:45 -0700
IronPort-SDR: 1UBSxz9gQnM0rfphzZG42u7q84lnJIlY2MhtcNpD05c3jsWYrgz+WQynw+ywEN75Ppb35L5Sdy
 p1+is+Na1poA==
WDCIronportException: Internal
Received: from cne220230.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.144])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jun 2020 09:22:40 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 00/15] riscv-to-apply queue
Date: Wed,  3 Jun 2020 09:13:43 -0700
Message-Id: <20200603161352.744204-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=416cc4bc0=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 12:22:40
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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

The following changes since commit 5cc7a54c2e91d82cb6a52e4921325c511fd90712:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200602' into staging (2020-06-02 18:16:38 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200603

for you to fetch changes up to fe0fe4735e798578097758781166cc221319b93d:

  riscv: Initial commit of OpenTitan machine (2020-06-03 09:11:51 -0700)

----------------------------------------------------------------
This is a collection of RISC-V patches for 5.1.

This incldues removing deprecated features and part of the OpenTitan
support series.

----------------------------------------------------------------
Alistair Francis (11):
      hw/riscv: spike: Remove deprecated ISA specific machines
      target/riscv: Remove the deprecated CPUs
      target/riscv: Drop support for ISA spec version 1.09.1
      docs: deprecated: Update the -bios documentation
      riscv: sifive_e: Manually define the machine
      riscv/boot: Add a missing header include
      target/riscv: Don't overwrite the reset vector
      target/riscv: Disable the MMU correctly
      target/riscv: Don't set PMP feature in the cpu init
      target/riscv: Add the lowRISC Ibex CPU
      riscv: Initial commit of OpenTitan machine

Bin Meng (4):
      riscv: Suppress the error report for QEMU testing with riscv_find_firmware()
      riscv: Change the default behavior if no -bios option is specified
      hw/riscv: sifive_u: Remove the riscv_ prefix of the soc* functions
      hw/riscv: virt: Remove the riscv_ prefix of the machine* functions

 docs/system/deprecated.rst                     |  98 +++++------
 default-configs/riscv32-softmmu.mak            |   1 +
 default-configs/riscv64-softmmu.mak            |  11 +-
 include/hw/riscv/boot.h                        |   1 +
 include/hw/riscv/opentitan.h                   |  68 ++++++++
 include/hw/riscv/sifive_e.h                    |   4 +
 include/hw/riscv/spike.h                       |   6 +-
 target/riscv/cpu.h                             |   9 +-
 hw/riscv/boot.c                                |  45 ++---
 hw/riscv/opentitan.c                           | 184 +++++++++++++++++++++
 hw/riscv/sifive_e.c                            |  41 +++--
 hw/riscv/sifive_u.c                            |  24 +--
 hw/riscv/spike.c                               | 217 -------------------------
 hw/riscv/virt.c                                |  20 +--
 target/riscv/cpu.c                             |  45 ++---
 target/riscv/cpu_helper.c                      |  82 ++++------
 target/riscv/csr.c                             | 138 +++-------------
 target/riscv/insn_trans/trans_privileged.inc.c |  18 +-
 target/riscv/monitor.c                         |   5 -
 target/riscv/op_helper.c                       |  17 +-
 tests/qtest/machine-none-test.c                |   4 +-
 MAINTAINERS                                    |   9 +
 hw/riscv/Kconfig                               |   5 +
 hw/riscv/Makefile.objs                         |   1 +
 24 files changed, 480 insertions(+), 573 deletions(-)
 create mode 100644 include/hw/riscv/opentitan.h
 create mode 100644 hw/riscv/opentitan.c

