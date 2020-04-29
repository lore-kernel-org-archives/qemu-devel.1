Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C5DC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A3C2072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gHaxnY0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A3C2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrcV-0004EE-D9
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTra7-0008C5-O7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTra5-0003SK-GA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTra1-0003PL-3o; Wed, 29 Apr 2020 14:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588185430; x=1619721430;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1XgLDz26nHEpu0y9cchduMq7HttvXlRu1DO0Cxc980c=;
 b=gHaxnY0ahJrOgO2//M8kwml7XFL2JjaxtpJDBOMeCDUVH+hV9cy5ksih
 BAffZL9iuILzN3oeEeucGY0U2GZHYY7a3D7xBT/O7vjQ+UQG8rPC/1yNF
 sdg/IUN1zr6eXrn5d2/7BPGWiZ+D8lmhuf/zoxBnMeFY3ew5B3S2UIkB1
 nSl2+71nkw5PMy9W6EodzcTtp3wSAJUYe6c52MqG76N03Lf0DxH2cvd6j
 0hADduEunGZp1R6P1OKrT3kJQLP17OaCVRVn/WwafxuArZc8K/X92dv2X
 XVfKXAm0VQ4G7VTnKb/AECrxuv2iQaLFAoMOqRZC8bnCRzlalyi88upa+ A==;
IronPort-SDR: ttwrcDOhqC7HG77Q3N01ltTOz6dawUJBo7SLwzsguXB33u8rrF2LYEB0MuVDV+ssA5IY3BMfe0
 u9Rx9+mUsfePhHXWs72agolRwe+19YB0ToPP6SVQoijWCmnuHcaqaVURfMN24mTeXzP2jqhQuW
 ExpPX9Qf+8ENFyobsgJ7fD8rJRiK/JiQN8w4PSJ5EEErCB3dZ/npcQEZR6f6iWvZxlljYfPbU9
 /2RhvVInz5e/jvmP2UVmdvY5q2uEtP7vpHllck88FVfu7+/bOqh5NN+tiUxOKWTqZPaETwr2mk
 4FM=
X-IronPort-AV: E=Sophos;i="5.73,332,1583164800"; d="scan'208";a="137935126"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 02:37:04 +0800
IronPort-SDR: 62ykwJIudIHRRjtow64sxiI8BA0AYD2N91pP12yWlaeIzbeUlFTXe4noKO0Qw9SshMrpNcK0U3
 4pdSBbrpBFjnFu21KbDsjpgGYWGmHXlXo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 11:27:08 -0700
IronPort-SDR: t3qSngCryoWVlFS84BFNntMO/IxERhDyrcbbdq/91Z0rqEFe5vKzzDqZqZIFvGKnjqusWGXeoc
 vRnfN8Fvvx1A==
WDCIronportException: Internal
Received: from cnf007834.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.55.253])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 11:37:02 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL 00/14] RISC-V Patch Queue for 5.1
Date: Wed, 29 Apr 2020 11:28:42 -0700
Message-Id: <20200429182856.2588202-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=381fbd49e=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 14:37:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.45
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

The following changes since commit a7922a3c81f34f45b1ebc9670a7769edc4c42a43:

  Open 5.1 development tree (2020-04-29 15:07:10 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200429-1

for you to fetch changes up to 23766b6a35d5b1664ab782c02624bf2435c4ed5d:

  hw/riscv/spike: Allow more than one CPUs (2020-04-29 11:23:44 -0700)

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
 hw/riscv/sifive_u.c                          | 143 ++++++++++++++++-----------
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
 16 files changed, 160 insertions(+), 80 deletions(-)

