Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3E0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E82B82067B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M6y1tygO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82B82067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1C1-0002Zc-6A
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1Av-0000sD-3e; Thu, 04 Jun 2020 21:29:37 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1At-0008Vi-3H; Thu, 04 Jun 2020 21:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320576; x=1622856576;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IgtHnvrWU4YfhDphmhZfm1yvpcoHDs5Gh7DArAKK17g=;
 b=M6y1tygOVQRpJ6MqW86lVlv29bgi10ihNlELze5W9TmtFpUJg+VbBoSD
 NLSPegy8NrA2yZiJyLskALj9SeXIuY0RVNgZfniuu+vg1QtCjVzuNGua/
 V2lEcUlG4RaEFFT700L3dKjyX0UglgR3Zm36qhWV47wyJ3mbj34CK2s/n
 CGfttJVqp6VtM5JN0jn0od7DvbcDVEDMfBZnwvDATQ7fbxc+YVWioROBw
 +cjm2hQ5Y8a2mDSTvG3bECuOJxeR6Ean66+ImvdbdiQtLUrI5F1ytu0zM
 9NrMGrsW+oNFE8jblzd6F07Ffm7JDRlbjkY19DVZE5tzsDioST5NzPko5 w==;
IronPort-SDR: 7vas3P+FuPuDL6espBYyI+1e1tBfQsrHIOy8ri+KEuqHo9HXiIRMigEwLBMEL/xCVACk21R87z
 xsk8dZAqeSWYvV7Qc+LdCyXvbHlQWqmCfBL1FkADWRaRon8Es7G1ElhR3Rf92L7b8dy46Mi1ao
 6a42uaEQEAf1pw2A6E5canKAwF7ONN1+2FZeTMmB5bsH4Q1w2QZNfwDM6pIn+BLXlpAAg74UZG
 AnH4Z+waXK3xNhWO8L7RhF88t9wjRKibkbSw9Z2ZNj5cCG1HDog+dND7qhNqAfsApGBxgF2lJJ
 rEM=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="139561706"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:29:31 +0800
IronPort-SDR: HWI1x0nrR963ruZWia//Sslqsc8jOI8xIZiKl+8LPERnQu5sRwahWPVN+xUERnTq7WhKvLv9iP
 pg2EpvT/aRzOMChCOQ9d1IhW7aKe1NnjA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:19:06 -0700
IronPort-SDR: tWb75yk9iw0OSWwvGHklT3AsPGuwXhPkry1SXi3u/0AlIaFg3Y2p/CUOipQ/9roOQT2wM59nNK
 vHWKn4rn7ssQ==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Jun 2020 18:29:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 00/17]  RISC-V: Update the Hypervisor spec to v0.6.1
Date: Thu,  4 Jun 2020 18:20:42 -0700
Message-Id: <cover.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:29:30
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
Cc: alistair.francis@wdc.com, anup.pate@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair@alistair23.me>

This series updates the experimental QEMU RISC-V Hypervisor spec to the
v0.6.1 draft implementation.

THis includes support for the new 2-stage lookup instructions and the new
CSRs.

It also includes the new 0.6.1 support for the virtual instruction
fault.

This was tested by running 32-bit and 64-bit Xvisor on QEMU and starting
Linux guests.

v2:
 - Update to v0.6.1



Alistair Francis (17):
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
  target/riscv: Return the exception from invalid CSR accesses
  target/riscv: Support the Virtual Instruction fault

 target/riscv/cpu.h                            |   2 +
 target/riscv/cpu_bits.h                       |  25 +-
 target/riscv/helper.h                         |   9 +
 target/riscv/insn32-64.decode                 |   5 +
 target/riscv/insn32.decode                    |  19 +-
 target/riscv/cpu_helper.c                     | 114 +++---
 target/riscv/csr.c                            | 171 ++++++--
 .../riscv/insn_trans/trans_privileged.inc.c   |  38 --
 target/riscv/insn_trans/trans_rvh.inc.c       | 377 ++++++++++++++++++
 target/riscv/op_helper.c                      | 189 ++++++++-
 target/riscv/translate.c                      |  11 +-
 11 files changed, 815 insertions(+), 145 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvh.inc.c

-- 
2.26.2


