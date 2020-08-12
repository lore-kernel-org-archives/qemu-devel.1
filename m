Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7248C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A443E20838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="epqxyFx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A443E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5wNh-0001Cz-U8
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLL-0004c2-4m; Wed, 12 Aug 2020 15:23:23 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLH-0000QZ-4C; Wed, 12 Aug 2020 15:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597260198; x=1628796198;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sYzibE/kdXlmqf0yyengbm7+wamxTSqDhk7lUTV/Bww=;
 b=epqxyFx/41yfX2skZQtXcuSLTXb2d7Jx3K46qmaKcJo6VUpIn9Bzado+
 7Lb01PvFTV+LhZuAwsWq/hk0uvG2+L39M7mOF4GHMTzGdMwj/llnKVY1R
 QkiEy98QlTy+s0dbisC1p6pbl1ptlI5xQ7FWrX5jUI9JtCPJ6xJEXPM1D
 7Qujk6qsxXLQK4BZEJfN0Ij6efB77xYdZc4f/I9Hal81m5KxcejVlnn4F
 nIgaCnv9f3PBrZtVWQ9urrEZ+CHlGDwpsTEkSqydP9QjhKYxAXXAPtLZX
 vijr+/pC0c/37wtVuMOud62GcUH7RNbkuD/iQJSAnNJImKEUk2+Kk0igL g==;
IronPort-SDR: jCTDTqFJFQ8TYwsCRZzf/Pnjylzdnjx8bpHWJjAOZaXjLrcrJIulL/AhQfa1f6rE/JKwk0JVQc
 ORU7nqRMtUxm1Jf8NRGAPoYSKRfZpOBTvWWQvJckBqiEAJoU0m5gmjlsqc7qOLivpbhpyBtV+g
 8V7FWLkg6c+DZh0nLj5X42uR6dUYnY+JcdZQVQcVU6BT1OX2s+6f6LzCzOMmU+xt8b14i1/wsd
 KL4YicbVJvq8yJe2A+twhf2JLiuuckI7Lgo6ifdmxxsKn9QPn1zBJ42VsNH+0Bro/tZLI2L6qK
 /ks=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="144786676"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 03:23:14 +0800
IronPort-SDR: Kk1j1/poCnJquLAYbxEmPdMHKHitkv/2A3IMdMRry50RoOHQKczZ1ofaReEAGAzBDIk1IFxlWq
 /IeMROIJzbbA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 12:11:05 -0700
IronPort-SDR: ouxOJtNHygGGPjl2PE4G4jTdAg2v3nKGkTIwjDZE8E1F2H8trmeetbpXlwbpWFVW/PnlcuGY+H
 HJEUmcBBbhqg==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 12:23:14 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 00/13]  RISC-V: Update the Hypervisor spec to v0.6.1
Date: Wed, 12 Aug 2020 12:13:14 -0700
Message-Id: <cover.1597259519.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 15:23:14
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
Cc: alistair.francis@wdc.com, anup.patel@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series updates the experimental QEMU RISC-V Hypervisor spec to the
v0.6.1 draft implementation.

THis includes support for the new 2-stage lookup instructions and the new
CSRs.

It also includes the new 0.6.1 support for the virtual instruction
fault.

This was tested by running 32-bit and 64-bit Xvisor on QEMU and starting
Linux guests.

v3:
 - Rebase on master
v2:
 - Update to v0.6.1



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

 target/riscv/cpu.h                      |   2 +
 target/riscv/cpu_bits.h                 |  25 +-
 target/riscv/helper.h                   |   4 +
 target/riscv/insn32-64.decode           |   5 +
 target/riscv/insn32.decode              |  11 +
 target/riscv/cpu_helper.c               | 123 +++++----
 target/riscv/csr.c                      | 171 ++++++++++--
 target/riscv/insn_trans/trans_rvh.inc.c | 342 +++++++++++++++++++++++-
 target/riscv/op_helper.c                | 176 +++++++++++-
 target/riscv/translate.c                |  10 -
 10 files changed, 761 insertions(+), 108 deletions(-)

-- 
2.27.0


