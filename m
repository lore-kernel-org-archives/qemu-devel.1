Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8120FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E5320782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HfMqd7FN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E5320782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeAx-000551-9t
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9s-0003UK-2x
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9o-0002vn-Qj
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381938; x=1629917938;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=r+jRYzZGDNTuf5/RlCQsWlvwdX04Fg7L+XC2SA4r7XA=;
 b=HfMqd7FNfO6H8J8OPFPqAGpH3LBkP74lMMITkuGnh0WnQZb3oJJd148W
 jBiB1EB7j2lk1fAFcGrlgxhOU083nE6c8XnDIVJ7obnB87IBkXEEhhT+6
 ndZr/FOEAE7ifWebS1E7w0WeUwo3SrcBcH7h8+0HUnsQjFZy4T9PkwGkU
 L3K0cpJknsyAAUTyYR/6W0uQXcdzlEwjm4QjpsCltjtQ3sbZUUGOb6BN7
 Jzc/k51F3X9GROoZDYXjY730jEGus+W5TgCPwhT0ZtXZFg/41TQMKPeQt
 bOtj0D1s/ehrlid149ZUcdEYT52Wxbgez7GPEHdT4c/glAlqMz0WJ1LgU A==;
IronPort-SDR: vA7+gArARYJ3GJc1i4ZuWkOP+QKfDMC9A0gTNKzh+VB0uYqU/PzY8dbGuUKS7OAdPH/qRhgEj0
 MCEReHzlDr4WvP0+GvWT4JyVggUXt7NtrIB4pWfcSzZ7V/K7N36xXcZWoF06L/j3UgAGmwC0z2
 JG3O6zG2dmFmJwwRbgb9ykNwWZvJJ2xktlIrTtklc58fHwjVdFuNzk7YULQ1+9Vs6MjOTnWrEG
 eqWensDmk/BvkLUbUkJoZymCEav/sQSLrtN4gNNRbMybmUp8+5DCKFzOlshDEwSIprEa3yxFgC
 QBg=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145282"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:54 +0800
IronPort-SDR: dNryOqRd4hG0QXOPHPn94JYUmeCODQPGneNyIGaThifuXC8f9o2nHKhXHIgiCC2lkiC/XShJ/Q
 wrYyzlMwUWBg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:29 -0700
IronPort-SDR: uzSTaiFxznM/sHeKQfI1h/+hFZ1SZOEfLt6cg8EegMv/purVujvaBuKN+JVlll9PSOhjSrIUN2
 RK4eHOTDK+sg==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:53 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] riscv-to-apply queue
Date: Tue, 25 Aug 2020 11:48:18 -0700
Message-Id: <20200825184836.1282371-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 14:58:53
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7774e403f2ac58b3e87bfe8d2f77676501ba893e:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200825-pull-request' into staging (2020-08-25 10:54:51 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200825

for you to fetch changes up to e39a8320b088dd5efc9ebaafe387e52b3d962665:

  target/riscv: Support the Virtual Instruction fault (2020-08-25 09:11:36 -0700)

----------------------------------------------------------------
This pull request first adds support for multi-socket NUMA RISC-V
machines. The Spike and Virt machines both support NUMA sockets.

This PR also updates the current experimental Hypervisor support to the
v0.6.1 spec.

----------------------------------------------------------------
Alistair Francis (13):
      target/riscv: Allow setting a two-stage lookup in the virt status
      target/riscv: Allow generating hlv/hlvx/hsv instructions
      target/riscv: Do two-stage lookups on hlv/hlvx/hsv instructions
      target/riscv: Don't allow guest to write to htinst
      target/riscv: Convert MSTATUS MTL to GVA
      target/riscv: Fix the interrupt cause code
      target/riscv: Update the Hypervisor trap return/entry
      target/riscv: Update the CSRs to the v0.6 Hyp extension
      target/riscv: Only support a single VSXL length
      target/riscv: Only support little endian guests
      target/riscv: Support the v0.6 Hypervisor extension CRSs
      target/riscv: Return the exception from invalid CSR accesses
      target/riscv: Support the Virtual Instruction fault

Anup Patel (5):
      hw/riscv: Allow creating multiple instances of CLINT
      hw/riscv: Allow creating multiple instances of PLIC
      hw/riscv: Add helpers for RISC-V multi-socket NUMA machines
      hw/riscv: spike: Allow creating multiple NUMA sockets
      hw/riscv: virt: Allow creating multiple NUMA sockets

 include/hw/riscv/numa.h                 | 113 +++++++
 include/hw/riscv/sifive_clint.h         |   7 +-
 include/hw/riscv/sifive_plic.h          |  12 +-
 include/hw/riscv/spike.h                |  11 +-
 include/hw/riscv/virt.h                 |   9 +-
 target/riscv/cpu.h                      |   2 +
 target/riscv/cpu_bits.h                 |  25 +-
 target/riscv/helper.h                   |   4 +
 target/riscv/insn32-64.decode           |   5 +
 target/riscv/insn32.decode              |  11 +
 hw/riscv/numa.c                         | 242 +++++++++++++++
 hw/riscv/sifive_clint.c                 |  20 +-
 hw/riscv/sifive_e.c                     |   4 +-
 hw/riscv/sifive_plic.c                  |  24 +-
 hw/riscv/sifive_u.c                     |   4 +-
 hw/riscv/spike.c                        | 232 +++++++++-----
 hw/riscv/virt.c                         | 526 ++++++++++++++++++--------------
 target/riscv/cpu_helper.c               | 123 ++++----
 target/riscv/csr.c                      | 171 +++++++++--
 target/riscv/op_helper.c                | 176 ++++++++++-
 target/riscv/translate.c                |  10 -
 hw/riscv/meson.build                    |   1 +
 target/riscv/insn_trans/trans_rvh.c.inc | 342 ++++++++++++++++++++-
 23 files changed, 1630 insertions(+), 444 deletions(-)
 create mode 100644 include/hw/riscv/numa.h
 create mode 100644 hw/riscv/numa.c

