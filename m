Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB51C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CF0206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nFGYIp7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CF0206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTtTW-0002kw-AA
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 16:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtOi-0007rI-Ah
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtO3-0005vf-3e
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:33:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtJx-00065g-CN; Wed, 29 Apr 2020 16:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588192121; x=1619728121;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FJkl9Hbgys0eb3sfQF3l+EdkuBfAEQQRKAr1946F++g=;
 b=nFGYIp7bWEdBHWtKdZdRap2fTop/MnzGhlDSC7YgajmeeyJsSVY4VTsD
 bGGHyZqiHakvTqiZl+SY6m9AiQOMTP/JfkDweyt5zI2H5ae3JZ3Z2cVe8
 nZ2RFVmpf0HIrdFw9c15/NG/7H9IKO5ZjPtNRsXtqhPNHlgY8BIY2/Tsb
 oggOJvBRlEIJ1yFOFF/p1NEpkQXk5Hyz+3h2OwAHkp2TGmgDQNah6oOqQ
 dQvFFSPkVktLxTc3+mwJaX7O1T+HZLkVhd8YjAG2bCH2wAkU3vzOtzOsH
 6qqpczKe9/JQ2WQi0skzTBoOfDtNRFMwB7WFTLZXyGOvcWhNs2tWiMXIl g==;
IronPort-SDR: ulywGUWNMtt3LY1f47kLUIn5PFpzxw/gx05FLJXmhy6S5kTO38uOxC5RICpSThfK8Y41WoP2m1
 0n/0ChWyhLSBt8NDjJZyFCrWLDcOYElQPpn8lJDljvZduvMgzQpg8LzqNFPbf6YEl9UIPn9hR7
 WurZT4J71VfLGl144VkMVFQryjceVeOAOs4OT44ft/6qcksvD8dC+bZquJOOvSUSoqP8FeCXgq
 Ggpx+/jYrdiHre0iBX9n39v1QnaJSqMse/xgBVqViKRKs5uHSigPWb7zbexyuZXsS76IBUpxvY
 htY=
X-IronPort-AV: E=Sophos;i="5.73,333,1583164800"; d="scan'208";a="136507030"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 04:28:37 +0800
IronPort-SDR: ivRKSTrY6I7XGiDAq91CPMHX0OgXLIuf3U/4lmXDo+KAvUsaMM44g5c6k8IwFelOfqnGUtTzaH
 dsO97CyM+7bqrFQsZ4qK0y5ALaVldjmOY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 13:18:41 -0700
IronPort-SDR: WJ1PtoS4mKBWGJn3kA25ZUO4apDazX6Zkh23QLFXAZQ1fcUSRftFVLLwdHuFiQYe2KsSEDjUIE
 PoN4EypCzPrA==
WDCIronportException: Internal
Received: from usa004631.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.145])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 13:28:37 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL v2 00/14] RISC-V Patch Queue for 5.1
Date: Wed, 29 Apr 2020 13:19:52 -0700
Message-Id: <20200429202006.775322-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=381fbd49e=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 16:28:37
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: Alistair Francis <alistair.francis@wdc.com>, palmerdabbelt@google.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 648db19685b7030aa558a4ddbd3a8e53d8c9a062:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2020-04-29' into staging (2020-04-29 15:07:33 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200429-2

for you to fetch changes up to 31e6d70485b1a719ca27e9a2d21f2a61ac497cdf:

  hw/riscv/spike: Allow more than one CPUs (2020-04-29 13:16:38 -0700)

----------------------------------------------------------------
RISC-V pull request for 5.1

This is the first pull request for the 5.1 development period. It
contains all of the patches that were sent during the 5.0 timeframe.

This is an assortment of fixes for RISC-V, including fixes for the
Hypervisor extension, the Spike machine and an update to OpenSBI.

----------------------------------------------------------------
Alistair Francis (4):
      riscv/sifive_u: Fix up file ordering
      riscv/sifive_u: Add a serial property to the sifive_u SoC
      riscv: Don't use stage-2 PTE lookup protection flags
      riscv: AND stage-1 and stage-2 protection flags

Anup Patel (4):
      riscv: Fix Stage2 SV32 page table walk
      hw/riscv: Add optional symbol callback ptr to riscv_load_firmware()
      hw/riscv/spike: Allow loading firmware separately using -bios option
      hw/riscv/spike: Allow more than one CPUs

Bin Meng (3):
      riscv/sifive_u: Add a serial property to the sifive_u machine
      hw/riscv: Generate correct "mmu-type" for 32-bit machines
      roms: opensbi: Upgrade from v0.6 to v0.7

Corey Wharton (2):
      riscv: sifive_e: Support changing CPU type
      target/riscv: Add a sifive-e34 cpu type

LIU Zhiwei (1):
      linux-user/riscv: fix up struct target_ucontext definition

 hw/riscv/boot.c                              |  13 ++-
 hw/riscv/sifive_e.c                          |   5 +-
 hw/riscv/sifive_u.c                          | 142 ++++++++++++++++-----------
 hw/riscv/spike.c                             |  30 +++++-
 hw/riscv/virt.c                              |   6 +-
 include/hw/riscv/boot.h                      |   6 +-
 include/hw/riscv/sifive_u.h                  |   3 +
 linux-user/riscv/signal.c                    |   3 +-
 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin | Bin 49472 -> 49520 bytes
 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 41280 -> 49504 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 53760 -> 57936 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 49664 -> 57920 bytes
 roms/opensbi                                 |   2 +-
 target/riscv/cpu.c                           |  10 ++
 target/riscv/cpu.h                           |   1 +
 target/riscv/cpu_helper.c                    |  18 ++--
 16 files changed, 159 insertions(+), 80 deletions(-)

