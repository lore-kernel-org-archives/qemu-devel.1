Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAE1C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E5E2072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HGnFliWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E5E2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9MSD-0003K4-Mq
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 01:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MQy-0001gi-Jk
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:20 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:23553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MQw-0000Ci-5Z
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598075477; x=1629611477;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NkVWFkOYh9zhynd/wpH+EzFPU3yr/YmVFPu0rxDLOqI=;
 b=HGnFliWEnc972ylYuNgnCR0zdyYNjk/z2d2a2lExdxCI66Op4Ysonr3Z
 nZH3pRK22smlL7N36fdZHP18sYNqkbUVLM/UyH6LDNmMZKawVEfoQP8hy
 OAipY+dVfdZnuxNh5Dld1tCxIvufNcPArYGVfMT8AOcmBNSYbZMhF8WUJ
 9Q0ADk9I+n5nLepS5N02zPTRSXcTaXB26MOGlFWDz6IQLk/i+xQx8x7Tg
 aekNECbByJwubQQuawwbqP+dD+U7nGbzm2A3oPU2Qqdl9h4o4O6jkUQ7e
 0+H2z3k72uicRjEcpguYo8otf8puhjK0qTTQtOr6m49HhR90mbzQ/1JAO w==;
IronPort-SDR: uaWgwEhT1zPaIeF4of6kSA97Y+wFubRwpV7tZPRL5hb6xmVG27OQjNpj7n9mBdG3RV3jnXztnJ
 mw6xwS9GI+Y4fiFU3pbFyp+1RRXiNNI0twaeLCMGP1/lETBAbcnnEiyrd+A5lzIACphiVxxfy/
 hrBHmYCTRUE92CBhimuaBHNc5ykvkBc5eDgMuRnQiH/+mO7LqYlS3x37z+NFgSLe9stNeAq5Td
 ibBkqTfEXhJ3/2WjfYSdJAXWJwd8uJnWIb8b4iae1P5X6sq868mz+XHxlhRcRdyxWKSAQAoBhE
 5xQ=
X-IronPort-AV: E=Sophos;i="5.76,339,1592841600"; d="scan'208";a="255030527"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2020 13:51:15 +0800
IronPort-SDR: 1n9o9+LdtWjVFDkH0s89+V99nXFQzkEWEL6r85Ew3HsPE7Icg44JJHjgh0enwbA1mVo98RrDcV
 BDleL6DHKHkw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 22:38:55 -0700
IronPort-SDR: JAFii7fhyA6I3aI3WKT9qRDrCZbR+WhQn2k21VwG3Zv6oH9jJLzlUpnMfClytyOgYWIgktGPxj
 hqilBJypukIQ==
WDCIronportException: Internal
Received: from 5zn13g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.90])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2020 22:51:16 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/20] riscv-to-apply queue
Date: Fri, 21 Aug 2020 22:40:41 -0700
Message-Id: <20200822054101.1202175-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=49637c5a7=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 01:51:16
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f86d9a093dada588889bde5582c7ec320487c4b8:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-08-21 17:26:52 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200821-1

for you to fetch changes up to 01c41d15de13104774d08e951db24815c8cffc79:

  hw/intc: ibex_plic: Honour source priorities (2020-08-21 22:37:55 -0700)

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
 target/riscv/insn_trans/trans_rvd.c.inc        |   8 +-
 target/riscv/insn_trans/trans_rvf.c.inc        |  99 +++++++++++++++---------
 27 files changed, 338 insertions(+), 137 deletions(-)
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.elf
 delete mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.elf
 delete mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin

