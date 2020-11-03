Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7361CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E2020756
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ltYxb5E6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E2020756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyOO-00015j-VD
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJN-0001JB-C3
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:29 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJK-0001EJ-U4
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417607; x=1635953607;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WvesQhO5wv+7mElyU2TyDpctqU+vtAbEhVaxXit1ZlI=;
 b=ltYxb5E6ycvy8H8DqUtH0sNvVewV+vKnSjsewkQBjOUsrnmM/XMFxUbF
 MqtJyLXaEPcM6KqxBnBDH0J75LD/tVpzjOQXmmJZBXH9KfcyQJfE0Q8Oq
 76wPNJNz98U4TCxCetoepWj1snlRDG/68GmAOoXLs7FcncN2w+yLeL3zx
 Eu/u1lsyKl3FLOOqaWvycxbUre48KktT80bkrI7VkV4oA+s5M3EZfbc3d
 A3SaOY71Qz1cQDMZauyGmwek++7I0bSvV+46+cPf+OBUB6otSaQQyEdtc
 EbAKPWsMlqtNnYaE9TFA2SHcKb2msmbM/uGaO61iZ6pmTIa2hgfbwZTIU Q==;
IronPort-SDR: Dp/pyhz+KIhKI89OqM/wwafSqwxGnJZzowmwk+z0y/piW3PQclStLLJcBeaQSk0OkzTLOu35xg
 waxWLsRDHrxeWTiBbmRKivKABaKj7e1phUGmV8lY67UD2Sgrp8h3/11U29TWVZgO6dJxfEpTvI
 iP6ekD+3gw+V8XidDXPLrP+/thP0/+5z6HMQgOHz2tYCo6rlj0tPS93wONxa1P7ZexCdbfs0eq
 Ie02ffFEMsCA0qchX9z/gE84Spf9pPj4tIvZWWvWE9rpJkhQNff2HEq3byAwRR2l3e5yLtKGDS
 Aq0=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867446"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:23 +0800
IronPort-SDR: oNwDi+1MW9IRHHH75lEr4sSHz53Qto9meNvCGMDAb5HAq5hRrSiS4CV6+YQy6LAcSwZP3MTioc
 joTVTrMRAzavzNkW/SJilfMcpO6IwYMl3sYkHCZI6eujpk6sfpC1kmbUd3b2TadlowiMDBg82S
 mWfY9y/7mOAU10hC5zKwTHtCTftcdrWrt0YllT9xwbatxQGsBoJApt/U/RLPszbKJpZSgU7u/g
 7c5fsypEQ711lDKyV/IBG6TnntgfvKSFYUgNm2mEiOIH+zRUGNOVf4grrRtT+Mi76+kz4YOW7L
 T06H2jFLRG8SZh+nC7G1Hx2k
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:32 -0800
IronPort-SDR: 6P2GDwOaJzozGLPCffmG47ucJ64M427jLUljmP+nEhP2FLPH7xSihCbz0mRY7i9Re0L0XnFQW/
 AiiEvUTsOpHhhwsJXCFKc7Eb19KwF91eh2hql4mxv4bPdy4aoog40E9IDbzFWy7LwU6hRkQSq1
 QfTsOHX454NY3J3+DEzlPHcxwsXUYRMJArUYxSTFkaGV7d2LEdKJjahXoPXTv8PvS9SkDVCffu
 D+suphar6b4wXYywkh3UaX2ccIHXQenoKgpiZjy+fr8iz1mjLL9/dmJt+YwOh3weGfDuDLQywE
 V5g=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:24 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 00/19] riscv-to-apply queue
Date: Tue,  3 Nov 2020 07:21:31 -0800
Message-Id: <20201103152150.2677566-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:33:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 83851c7c60c90e9fb6a23ff48076387a77bc33cd:

  Merge remote-tracking branch 'remotes/mdroth/tags/qga-pull-2020-10-27-v3-tag' into staging (2020-11-03 12:47:58 +0000)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20201103

for you to fetch changes up to 422819776101520cb56658ee5facf926526cf870:

  target/riscv/csr.c : add space before the open parenthesis '(' (2020-11-03 07:17:23 -0800)

----------------------------------------------------------------
This series adds support for migration to RISC-V QEMU and expands the
Microchip PFSoC to allow unmodified HSS and Linux boots.

----------------------------------------------------------------
Anup Patel (2):
      hw/riscv: sifive_u: Allow passing custom DTB
      hw/riscv: virt: Allow passing custom DTB

Bin Meng (10):
      hw/riscv: microchip_pfsoc: Document where to look at the SoC memory maps
      hw/misc: Add Microchip PolarFire SoC DDR Memory Controller support
      hw/riscv: microchip_pfsoc: Connect DDR memory controller modules
      hw/misc: Add Microchip PolarFire SoC IOSCB module support
      hw/riscv: microchip_pfsoc: Connect the IOSCB module
      hw/misc: Add Microchip PolarFire SoC SYSREG module support
      hw/riscv: microchip_pfsoc: Connect the SYSREG module
      hw/riscv: microchip_pfsoc: Map the reserved memory at address 0
      hw/riscv: microchip_pfsoc: Correct DDR memory map
      hw/riscv: microchip_pfsoc: Hook the I2C1 controller

Xinhao Zhang (1):
      target/riscv/csr.c : add space before the open parenthesis '('

Yifei Jiang (6):
      target/riscv: Merge m/vsstatus and m/vsstatush into one uint64_t unit
      target/riscv: Add basic vmstate description of CPU
      target/riscv: Add PMP state description
      target/riscv: Add H extension state description
      target/riscv: Add V extension state description
      target/riscv: Add sifive_plic vmstate

 include/hw/intc/sifive_plic.h       |   1 +
 include/hw/misc/mchp_pfsoc_dmc.h    |  56 +++++++++
 include/hw/misc/mchp_pfsoc_ioscb.h  |  50 ++++++++
 include/hw/misc/mchp_pfsoc_sysreg.h |  39 ++++++
 include/hw/riscv/microchip_pfsoc.h  |  18 ++-
 target/riscv/cpu.h                  |  24 ++--
 target/riscv/cpu_bits.h             |  19 +--
 target/riscv/internals.h            |   4 +
 target/riscv/pmp.h                  |   2 +
 hw/intc/sifive_plic.c               |  26 +++-
 hw/misc/mchp_pfsoc_dmc.c            | 216 ++++++++++++++++++++++++++++++++
 hw/misc/mchp_pfsoc_ioscb.c          | 242 ++++++++++++++++++++++++++++++++++++
 hw/misc/mchp_pfsoc_sysreg.c         |  99 +++++++++++++++
 hw/riscv/microchip_pfsoc.c          | 125 ++++++++++++++++---
 hw/riscv/sifive_u.c                 |  28 +++--
 hw/riscv/virt.c                     |  27 ++--
 target/riscv/cpu.c                  |  16 +--
 target/riscv/cpu_helper.c           |  35 ++----
 target/riscv/csr.c                  |  20 +--
 target/riscv/machine.c              | 196 +++++++++++++++++++++++++++++
 target/riscv/op_helper.c            |  11 +-
 target/riscv/pmp.c                  |  29 +++--
 MAINTAINERS                         |   6 +
 hw/misc/Kconfig                     |   9 ++
 hw/misc/meson.build                 |   3 +
 hw/riscv/Kconfig                    |   3 +
 target/riscv/meson.build            |   3 +-
 27 files changed, 1180 insertions(+), 127 deletions(-)
 create mode 100644 include/hw/misc/mchp_pfsoc_dmc.h
 create mode 100644 include/hw/misc/mchp_pfsoc_ioscb.h
 create mode 100644 include/hw/misc/mchp_pfsoc_sysreg.h
 create mode 100644 hw/misc/mchp_pfsoc_dmc.c
 create mode 100644 hw/misc/mchp_pfsoc_ioscb.c
 create mode 100644 hw/misc/mchp_pfsoc_sysreg.c
 create mode 100644 target/riscv/machine.c

