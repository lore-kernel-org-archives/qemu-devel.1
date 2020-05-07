Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6D7C47257
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FBC1208D6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X4dEXe+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBC1208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWm6M-0001b0-Iy
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 15:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm5C-00083p-77; Thu, 07 May 2020 15:21:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm5B-0005FG-2i; Thu, 07 May 2020 15:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588879280; x=1620415280;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=D75QxEi0d3XWdQeTdloAyfN+Ms3lwSlbQzyDFV+7mpU=;
 b=X4dEXe+nVOmbAGwpY6Diq61hzqyOaqVkseO38Btr7DHfyE37Lg+i9nJn
 qpn3zgwgy7zMDMKGCU9DMk6aqGnAuKCAJ8iXFFrjamY/Kz8g712RcuIgW
 H7jYh6IOmCZOyTV7IRdaR+ijzhloqlPz7e7nt1DPqWaMhqcMVY2sr8KzV
 f+7qesYymQvXVKcKfuiG/5VVYDBIanLTbyT0UCWvZODj98X52cCO9+AnD
 0RJ50yJa5uVg7RvdeV1BeCpJowZKY56bElN6gUWg/Igvs9SKAplHUU3BU
 T3AFwk5WagXJQFw8H8Rd7Cp5+GTJYvvWa69RJfobMZxd7X1S2RUss7b/S w==;
IronPort-SDR: UbjpH4Ea7fZ+d04yNiH9IlUUbZsYyV10B0TTypbnprp7RbWAhNf/Cn7YDqRGvREgTqbcTrR+tj
 8H9N7eKLowIW/rbvIRbcuNO8tFv3saMBOkVITTKsHrIztBKzXf/6eqWHfiIfI5SNvcj3NRJ/7g
 EFgo5A4dDzDrOG/xZeMxpA++EsJSynKj69GgDmvL3PFLcqDWLTPRjqb6+UiWLionFY3IHjCcmU
 nBDQomMJ27P/0CPdXa6vvTKOGwaK27zSSjqXwzG8+smf7UrTSynswrlxZV4t/cxzX6j7YTWviQ
 Bf4=
X-IronPort-AV: E=Sophos;i="5.73,364,1583164800"; d="scan'208";a="246038021"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 03:21:18 +0800
IronPort-SDR: /8DZivhKk7EoGeab/ioKdT6t/PcyeZiq6E+iDvT/pkD1Kb/ugPnF5lNmdZkqmETtKojHc5lj7g
 jUy9N4DFpJoY9otjtU9Wvj8F0mOy3q6lo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 12:11:42 -0700
IronPort-SDR: rylsPYgf9OJhePJvqeBEsBgRSw+25JZBde5ADsIynAnxEMk5vjKsoqFfHs+Q+eQ4uoKCs4VLnl
 a6FUEuzIWQdQ==
WDCIronportException: Internal
Received: from uscxm6l72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.6])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 May 2020 12:21:18 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 0/9]  RISC-V Add the OpenTitan Machine
Date: Thu,  7 May 2020 12:12:59 -0700
Message-Id: <cover.1588878756.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=38990af3b=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 15:21:18
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

v2:
 - Rebase on master
 - Get uart receive working

Alistair Francis (9):
  riscv/boot: Add a missing header include
  target/riscv: Don't overwrite the reset vector
  target/riscv: Add the lowRISC Ibex CPU
  riscv: Initial commit of OpenTitan machine
  hw/char: Initial commit of Ibex UART
  hw/intc: Initial commit of lowRISC Ibex PLIC
  riscv/opentitan: Connect the PLIC device
  riscv/opentitan: Connect the UART device
  target/riscv: Use a smaller guess size for no-MMU PMP

 MAINTAINERS                         |  14 +
 default-configs/riscv32-softmmu.mak |   1 +
 default-configs/riscv64-softmmu.mak |  11 +-
 hw/char/Makefile.objs               |   1 +
 hw/char/ibex_uart.c                 | 490 ++++++++++++++++++++++++++++
 hw/intc/Makefile.objs               |   1 +
 hw/intc/ibex_plic.c                 | 261 +++++++++++++++
 hw/riscv/Kconfig                    |   9 +
 hw/riscv/Makefile.objs              |   1 +
 hw/riscv/opentitan.c                | 204 ++++++++++++
 include/hw/char/ibex_uart.h         | 110 +++++++
 include/hw/intc/ibex_plic.h         |  63 ++++
 include/hw/riscv/boot.h             |   1 +
 include/hw/riscv/opentitan.h        |  79 +++++
 target/riscv/cpu.c                  |  30 +-
 target/riscv/cpu.h                  |   1 +
 target/riscv/pmp.c                  |  19 +-
 17 files changed, 1281 insertions(+), 15 deletions(-)
 create mode 100644 hw/char/ibex_uart.c
 create mode 100644 hw/intc/ibex_plic.c
 create mode 100644 hw/riscv/opentitan.c
 create mode 100644 include/hw/char/ibex_uart.h
 create mode 100644 include/hw/intc/ibex_plic.h
 create mode 100644 include/hw/riscv/opentitan.h

-- 
2.26.2


