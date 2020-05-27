Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6F5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1C72088E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GkV9WwpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1C72088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdzPD-0002tl-58
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 12:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1jdzOH-0001Df-Dy; Wed, 27 May 2020 12:58:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1jdzOF-000244-G1; Wed, 27 May 2020 12:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590598731; x=1622134731;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0d53OiKp+2++SK471VZFVwFek97LO7t66ZdInaTMRjw=;
 b=GkV9WwpXrH32s5/3KSixzoXUd50RzWtwPA2FBAIMyvm0n/zB0kbnCahB
 NCcFBrgeaL8OfD9Vj7OIe4Dy9v2PutI/Up1W17A4W+OB4mDnTtRC81xLt
 gj4q1KMb2QDe15XWBqhRVmEg/rqFedA3PPtR24/0zm5eVy6ys6garHUlE
 hKSwdNujSte7/kXzMzAHdOWnsGJUT9OXiZ/s66hc3YpNEpZ14QkaropsI
 t5oclbRgIJYIkGGnA7dLbPNyo0EWAmTHE/OTBnqhbM4VDDiRmF36DFtc+
 aiI1IpNCOmBRjqVUCJvQ9RJPGaQIdtgIoJZ7PbsRMpln7TUim3LYkmzVj Q==;
IronPort-SDR: cwkUHCLk1Fc5Cvri6PYRIgnn/rxS39YSp42geR9vcY3DaLXorwCOJ6EDYPkSQcFTOEH948PT+c
 HYHv8QGFnbs4+F+KLmcJ/RP1hXhAVNtl1kz6KBrUbwxXHcZJ4m+EixVwyKba8esDeKjkSm+OuC
 +cfQifH6/tnA6Zc8Lu5GYQxYip6G8t2woEBoN9zdg9wVovE5V7AS7eHMPoIX0eHyvZqTPuVk0j
 m8hPWLWrepx/SGRB4zU5KfFim3uOs6sbGA+W1Ct0rCrjNhDTdOqjFhEXiMdKE0iazlKt6cwWIe
 518=
X-IronPort-AV: E=Sophos;i="5.73,442,1583164800"; d="scan'208";a="138633211"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 00:58:45 +0800
IronPort-SDR: GSsJAiiqubFpTOytLmuiQSBi6GfJejldiT/9ioHnIQWXQ5k0xpy0iJRuGFKqp1GxEo+mJmleuj
 bJkO9FdZX1/J7E1Ym9TuJth8HQcDXbP3E=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 09:48:02 -0700
IronPort-SDR: N4/snaMvqFFkwTS8kZYipzZ4iynP6nZpRi+YGncy8kgtMt+/20CqXkjoAziXKXzlLcY8VOB1gx
 GQ2REn7fhxCg==
WDCIronportException: Internal
Received: from 71vjjc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.96])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 May 2020 09:58:46 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 00/10]  RISC-V Add the OpenTitan Machine
Date: Wed, 27 May 2020 09:50:11 -0700
Message-Id: <cover.1590598125.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=40961fbaf=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 12:58:46
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
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

v4:
 - Don't set the reset vector in realise
 - Fix a bug where the MMU is always enabled
 - Fixup the PMP/MMU size logic
v3:
 - Small fixes pointed out in review
v2:
 - Rebase on master
 - Get uart receive working



Alistair Francis (10):
  riscv/boot: Add a missing header include
  target/riscv: Don't overwrite the reset vector
  target/riscv: Disable the MMU correctly
  target/riscv: Add the lowRISC Ibex CPU
  riscv: Initial commit of OpenTitan machine
  hw/char: Initial commit of Ibex UART
  hw/intc: Initial commit of lowRISC Ibex PLIC
  riscv/opentitan: Connect the PLIC device
  riscv/opentitan: Connect the UART device
  target/riscv: Use a smaller guess size for no-MMU PMP

 default-configs/riscv32-softmmu.mak |   1 +
 default-configs/riscv64-softmmu.mak |  11 +-
 include/hw/char/ibex_uart.h         | 110 +++++++
 include/hw/intc/ibex_plic.h         |  63 ++++
 include/hw/riscv/boot.h             |   1 +
 include/hw/riscv/opentitan.h        |  79 +++++
 target/riscv/cpu.h                  |   1 +
 hw/char/ibex_uart.c                 | 492 ++++++++++++++++++++++++++++
 hw/intc/ibex_plic.c                 | 261 +++++++++++++++
 hw/riscv/opentitan.c                | 204 ++++++++++++
 target/riscv/cpu.c                  |  21 +-
 target/riscv/pmp.c                  |  14 +-
 MAINTAINERS                         |  13 +
 hw/char/Makefile.objs               |   1 +
 hw/intc/Makefile.objs               |   1 +
 hw/riscv/Kconfig                    |   9 +
 hw/riscv/Makefile.objs              |   1 +
 17 files changed, 1272 insertions(+), 11 deletions(-)
 create mode 100644 include/hw/char/ibex_uart.h
 create mode 100644 include/hw/intc/ibex_plic.h
 create mode 100644 include/hw/riscv/opentitan.h
 create mode 100644 hw/char/ibex_uart.c
 create mode 100644 hw/intc/ibex_plic.c
 create mode 100644 hw/riscv/opentitan.c

-- 
2.26.2


