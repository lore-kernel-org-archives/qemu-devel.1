Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22A6C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047EE20EDD
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QwQlTUr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047EE20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8tc-00033f-RK
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8rs-0001QT-OP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8rp-0005fB-KG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603981529; x=1635517529;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vt1tKwO9yd0polgpQiUVN2DSNirL0ZolHuRVQHJI77M=;
 b=QwQlTUr0rbzCBTdHy9y0Ltxpghoc3YQOrSkBKeLrajZqlQCH9gGJjhFE
 JXe22R/9HnRug7mwI06UOAhDSC8U7tUTGZuaeeyTonZviUivu5bV+j6zP
 BKpNtiETcRsBtxFyI911IKO7KrLTwhooQBUBPYJAp+nlWJ1795fADA56J
 /vKaT5UsdNcxn2J2zTRcGKRWbyPzukLzX22LSWDh0PNeSqVyfBRJG9ORM
 ntGvuGX6O6k7jfLe7v/iKIdT4/on+DzSLeWz9imJcFaaEj81Oq+GBcQVL
 B5A5lesD23K2PmIZvtAGd28YWeNOryVY6sMGtaQ1ZoWVC8vaoZKiqKn7R Q==;
IronPort-SDR: 9TJOb6xHBxawwR1wU00OMjfxArgikq4+AKrCHxBmWpZTFrOzPgFeH1rBYYWJ8QwJBeXdwtTRB2
 +N/UIxkvPthDo7AtADRJZY4Kj5rMCjzuSBoAGjTW2yXQrQkNn1+6RzQSd9zmUbcELXtASjrgt8
 7x69x/e6uOI2TQKNiKEqo52YWwvITqqMaLw+LnQQT5X94VVxZdRVWAzkvw4W9P1D1jpaFah8hv
 wfOFfEDc4U6WGBpeB6jc20PRmDbpHm9ydx0XY1DvtQ5UnfCvr4mn2pAceXYvB96trn+Oy/8/sU
 z4A=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151317867"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:25:26 +0800
IronPort-SDR: TdbeMJ061RNodNFqs4GGgFKKZCqCMtUR+vPgX1+5Rv4Li+k7CP0vgJ77X4J6ChSbjctrOJxTuk
 qebLmURWvp6GR9OAm4MuHllbrRr1KVQ0N201p66qDa/thy2WGaMTZCxy3UW++j0JmLmqa3vedK
 v5MwRqZ+mSCuSozm1C/E0kpaGibVvSMuFnP4Rz9v6LKKwGjNS94xkeBV+Ta4IIb/wC2KWIwuir
 bf0EHlmOHIdsI/GVbhvzO8PVuOM/AdVVyLK1uW7XxVEJZRIX6cI9NVjxKSZsHQVA7PPGztXs/E
 hLkD1jUcrRc0GIduNw4jjDpR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 07:11:41 -0700
IronPort-SDR: sfigUJBVJFWDcFIXW0LFPASESai9gD2SKjz1erkJNpPDIPgmqpjMpJCYauZ7m/9vJUMS3eiNh1
 HFSfjg7/y3sJ8tk2FWbLbypkIdTZCtTI/tQsegOzGDxCHe2kYGimbim4euOCFLvjwqxtXbCHY1
 CHcL4L57hCdFOivDzXpHH3yO+2N7KSI4+wLNR1teose/uAWrpiHBmvtF8Ro4JVzlOUmaYF5sTq
 YY2MZ2L5VnCE9ZCgId2y1EQAKBVMV1dgwn/6CiEzYcWj5ej4xb6PWOp3iwdAzNZRGEPpUYMNiV
 dLc=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 07:25:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 00/18] riscv-to-apply queue
Date: Thu, 29 Oct 2020 07:13:40 -0700
Message-Id: <20201029141358.3102636-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=56447669b=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 10:25:26
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

The following changes since commit c0444009147aa935d52d5acfc6b70094bb42b0dd:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qmp-2020-10-27' into staging (2020-10-29 10:03:32 +0000)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20201029

for you to fetch changes up to e041badcd4ac644a67f02f8765095a5ff7a24d47:

  hw/riscv: microchip_pfsoc: Hook the I2C1 controller (2020-10-29 07:11:14 -0700)

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
 hw/riscv/microchip_pfsoc.c          | 123 +++++++++++++++---
 hw/riscv/sifive_u.c                 |  28 +++--
 hw/riscv/virt.c                     |  27 ++--
 target/riscv/cpu.c                  |  16 +--
 target/riscv/cpu_helper.c           |  35 ++----
 target/riscv/csr.c                  |  18 +--
 target/riscv/machine.c              | 196 +++++++++++++++++++++++++++++
 target/riscv/op_helper.c            |  11 +-
 target/riscv/pmp.c                  |  29 +++--
 MAINTAINERS                         |   6 +
 hw/misc/Kconfig                     |   9 ++
 hw/misc/meson.build                 |   3 +
 hw/riscv/Kconfig                    |   3 +
 target/riscv/meson.build            |   3 +-
 27 files changed, 1177 insertions(+), 126 deletions(-)
 create mode 100644 include/hw/misc/mchp_pfsoc_dmc.h
 create mode 100644 include/hw/misc/mchp_pfsoc_ioscb.h
 create mode 100644 include/hw/misc/mchp_pfsoc_sysreg.h
 create mode 100644 hw/misc/mchp_pfsoc_dmc.c
 create mode 100644 hw/misc/mchp_pfsoc_ioscb.c
 create mode 100644 hw/misc/mchp_pfsoc_sysreg.c
 create mode 100644 target/riscv/machine.c

