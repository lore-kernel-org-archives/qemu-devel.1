Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FE3C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F5220700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LFu64r3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F5220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSkBQ-0002ve-P5
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 12:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk7t-0004MG-Gz
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk7s-0004GU-5K
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:28 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk7r-00044P-5H; Sun, 26 Apr 2020 12:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587918447; x=1619454447;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CzMEq7wJwKeWlJSDtGSqQMMtu2h3E4OJwzh8OjO7gWU=;
 b=LFu64r3KOxf6FmS5jHVt1WhKwTeVsKqLHZvFP+vVxbMVtKLVmAS2Bj7s
 bLVsjWNPSJC4zFzFvCQZyEZagc/NEvqENt5cUokoOGSaRkthfMzDdE4D8
 sqa4kA8CbooRk64iTcKJ8BqqXp/gz4eUX7l8SVRLwj7qOuhVlZZNTESLo
 e3Rb/KJqyMiBu38GG/61ppGm4xfgTnGL4EezpSo7woAGn6TR8POTrmOPV
 UFMyzH/Tfwl+Ulz8N+Oxm/2bziUsYWjZat3jcI2WX9IqJezaHo+/nla35
 sEjySMFF1dCFa+efXviqovC7FCuy262/yvZjQpVDOhK8PLHAq3ZAy3OFo Q==;
IronPort-SDR: IXurWE4fPpqiBuH2cpDjKKN/bJn8/tHz6/XE2UuU3EKxJzRVlWWdN0hyNnlNROdcBd/v428mv9
 DxC9dDPldDNW83HLrXG390W9N8CXrOxX82r9RZJQS3yVyF8+kP9BEIjOENxzSpRK8Lm5amKUtO
 vFquwafmSGamWoO+Ny+djOQMs8Whoel/egbe8WOSZjNuSNTsqweeLAFp4X/mzOUMJEzFcWgJtf
 SjhyarRYU1HVSp+arLg43IOMQ9bULLzd7UFjaGTdfKgyVYBMbD4xCiq9dT2BEzdoiFOfmAONLu
 yfc=
X-IronPort-AV: E=Sophos;i="5.73,320,1583164800"; d="scan'208";a="136193234"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 00:27:21 +0800
IronPort-SDR: TXVfx+/fCAsIygIgYsyvOOm8JNPR9/aO/3Ea126Gz1riU8MGH3yWUOfO2TO6y7IFtc4nVGI3XT
 cEVY0bWJ14R9RXVszAnNb7wGzBY1UEgAg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 09:17:31 -0700
IronPort-SDR: nPxOJ6r3/EbNZYpQcSkjxovvS2+BcaNU3/4NhW+caaXqDp4rRlZYnaCMPb7hMyetMZnZHEuG8B
 Fa5xqEe65Clw==
WDCIronportException: Internal
Received: from wdthnc17-0189.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.50])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Apr 2020 09:27:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 00/15]  RISC-V: Update the Hypervisor spec to v0.6
Date: Sun, 26 Apr 2020 09:19:11 -0700
Message-Id: <cover.1587917657.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=378a396a1=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 12:27:21
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series updates the experimental QEMU RISC-V Hypervisor spec to the
v0.6 draft implementation.

THis includes support for the new 2-stage lookup instructions and the new
CSRs.

This was tested by running 32-bit and 64-bit Xvisor on QEMU and starting
Linux guests.



Alistair Francis (15):
  target/riscv: Set access as data_load when validating stage-2 PTEs
  target/riscv: Report errors validating 2nd-stage PTEs
  target/riscv: Move the hfence instructions to the rvh decode
  target/riscv: Implement checks for hfence
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

 target/riscv/cpu.h                            |   2 +
 target/riscv/cpu_bits.h                       |  19 +-
 target/riscv/cpu_helper.c                     | 114 +++---
 target/riscv/csr.c                            |  61 ++-
 target/riscv/helper.h                         |   8 +
 target/riscv/insn32-64.decode                 |   5 +
 target/riscv/insn32.decode                    |  17 +-
 .../riscv/insn_trans/trans_privileged.inc.c   |  40 --
 target/riscv/insn_trans/trans_rvh.inc.c       | 377 ++++++++++++++++++
 target/riscv/op_helper.c                      | 135 ++++++-
 target/riscv/translate.c                      |  11 +-
 11 files changed, 674 insertions(+), 115 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvh.inc.c

-- 
2.26.2


