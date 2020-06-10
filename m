Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB47C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD1E206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B2miHGni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD1E206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj97x-0007Dt-FS
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4234ccaf3=alistair.francis@wdc.com>)
 id 1jj95u-0004Ki-0G; Wed, 10 Jun 2020 18:21:14 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4234ccaf3=alistair.francis@wdc.com>)
 id 1jj95s-000237-5K; Wed, 10 Jun 2020 18:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591827671; x=1623363671;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9bD3QKWUr5LwbqJAQBdeqwpAm4nMqwx4Rcj7yirIh6Y=;
 b=B2miHGniKtUzHgoa6rHxtlac8GKxZWv6pIV21zx9Zhc9lBodeC1rrQtC
 dgOsAaChGLy0C1pEKpIKDYOSPf8YIrWUToTbf+EmKQluViWQ7nuUkScLZ
 zGad+vDdNBxfquvXRCx1+z/8fTkcbKxG/g3n5sxqTNO+qkNLd7QbkflXA
 NZ/B74sGAT9jg2QxaZ3qQHjZhMBep56m1FyRvFdY/dhjmzEUSdX4LdqpL
 +D+IE5r8qVOG5POii/y96Xe1TtGT8MH6GW/4m3oeiUqwxY3FvHaLi8pyX
 YTNqp96ltGE10ZaAxwI7iRtsy0s5pukv1+BRl+CAgV7o6WnrgW8Iot6uM w==;
IronPort-SDR: WW8xMXxV6yB//Hr05R8Y/FdqdsQug6qQWGUgTudBTpCgqIeILhc+C7WpdkCDNm7eRHu70qidiv
 luboDhnwWyljUAkGmczCf7pU9+Sy7Ehx5PbJFQS+/K8Q/JV1lcahwoM0nTrZjRbKRx1jew9Tyk
 LYDKCmrwuTP5WQJI0rZQDBSFaIcvH68eM1Rj7W76pKifYIDVWM8rN3PhHWbiOxdKMP7kCiGDe5
 5FJnhkZ5pcCdmYSho5fh/nuM7O1md3rZrjnnrc12AuV0idE+voipjVUk8saLEtvKmJ+CsLI/+/
 m5U=
X-IronPort-AV: E=Sophos;i="5.73,497,1583164800"; d="scan'208";a="248819305"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2020 06:21:05 +0800
IronPort-SDR: rojVYqLLuCpys4+s6mewY5hqayIiEwNJKLJikeQUlTpG+zglSDlnsEZgfDwh6K3o1vvbXSoCwu
 +pGx9d4t1nrEMSxQrxDTqgQTLIB5eWTBg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2020 15:10:31 -0700
IronPort-SDR: zp3Ed/5IYkYhE+L/rju4LJzXZm4JbNssRwmRIJxOk8/W/7vrxpl1ECNS3Ruoi1BoisXPYTH3IG
 kJljxZ3MrJjQ==
WDCIronportException: Internal
Received: from us4qd5p12.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.34])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Jun 2020 15:21:05 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v6 0/6]  RISC-V Add the OpenTitan Machine
Date: Wed, 10 Jun 2020 15:12:08 -0700
Message-Id: <cover.1591827110.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=4234ccaf3=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 18:21:06
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

OpenTitan is an open source silicon Root of Trust (RoT) project. This
series adds initial support for the OpenTitan machine to QEMU.

This series add the Ibex CPU to the QEMU RISC-V target. It then adds the
OpenTitan machine, the Ibex UART and the Ibex PLIC.

The UART has been tested sending and receiving data.

With this series QEMU can boot the OpenTitan ROM, Tock OS and a Tock
userspace app.

The Ibex PLIC is similar to the RISC-V PLIC (and is based on the QEMU
implementation) with some differences. The hope is that the Ibex PLIC
will converge to follow the RISC-V spec. As that happens I want to
update the QEMU Ibex PLIC and hopefully eventually replace the current
PLIC as the implementation is a little overlay complex.

For more details on OpenTitan, see here: https://docs.opentitan.org/

v6:
 - Rebase on master (some patches applied)
 - Fix the ROM address
v5:
 - Add some of the missing unimplemented devices
 - Don't set PMP feature in init() function
v4:
 - Don't set the reset vector in realise
 - Fix a bug where the MMU is always enabled
 - Fixup the PMP/MMU size logic
v3:
 - Small fixes pointed out in review
v2:
 - Rebase on master
 - Get uart receive working



Alistair Francis (6):
  riscv/opentitan: Fix the ROM size
  hw/char: Initial commit of Ibex UART
  hw/intc: Initial commit of lowRISC Ibex PLIC
  riscv/opentitan: Connect the PLIC device
  riscv/opentitan: Connect the UART device
  target/riscv: Use a smaller guess size for no-MMU PMP

 include/hw/char/ibex_uart.h  | 110 ++++++++
 include/hw/intc/ibex_plic.h  |  63 +++++
 include/hw/riscv/opentitan.h |  16 ++
 hw/char/ibex_uart.c          | 492 +++++++++++++++++++++++++++++++++++
 hw/intc/ibex_plic.c          | 261 +++++++++++++++++++
 hw/riscv/opentitan.c         |  45 +++-
 target/riscv/pmp.c           |  14 +-
 MAINTAINERS                  |   4 +
 hw/char/Makefile.objs        |   1 +
 hw/intc/Makefile.objs        |   1 +
 hw/riscv/Kconfig             |   4 +
 11 files changed, 1001 insertions(+), 10 deletions(-)
 create mode 100644 include/hw/char/ibex_uart.h
 create mode 100644 include/hw/intc/ibex_plic.h
 create mode 100644 hw/char/ibex_uart.c
 create mode 100644 hw/intc/ibex_plic.c

-- 
2.26.2


