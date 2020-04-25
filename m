Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152EAC54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 18:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93F0206B6
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 18:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="WG5GLO/K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vWKzfFFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93F0206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSlfD-0001td-4V
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 14:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1jSlc1-0007Uz-HS
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 14:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1jSlbz-0007Wu-Tc
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 14:02:40 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1jSlbz-0007W6-AU; Sun, 26 Apr 2020 14:02:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 28E0C5C00E3;
 Sun, 26 Apr 2020 14:02:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Sun, 26 Apr 2020 14:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=S65C8AGToF/dNNOvMyyM+fwvZj
 8b5XGM2SrQ2cG8EFY=; b=WG5GLO/KTcD6IsMcLglaEpIyyvM77g8NCwFfiQKCPT
 rPdhMSWNFMUT635TZXy/JHOKKaAhefShuDVQ+s72echpr2ZCHC8SxqrksH1Vn2aU
 kuCoYqNznwDVz/ATR0hAJ+hI/9sWSzBvjaqlujmNlxptNT3MweXMIBeEk0gnefWa
 Lmm7fKf1lyZ5Frx+yaIK4e75n6XU8L4weocuzXc8iLJ1y1bvOktPDl38dlrvgRzW
 QWW8HHCKxpe4g8Ja9NhpbMbn/QlxexWTZ7oNbDYlah7/wGyynjloT5lT+cfc59zb
 e88CGSvreBjPQ0Y8ZkZD66SsRSOZ+vsKxH8W5lPRE1XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=S65C8AGToF/dNNOvM
 yyM+fwvZj8b5XGM2SrQ2cG8EFY=; b=vWKzfFFnLdW33gbzP6eH2vlykWk7chwTN
 vNC7RS4QkS9MbxLFow/InWUYJlKzBIbOZG0LTncPrJbHjihyIcXS5U6/x33iHnc0
 akb93G+LocwxV84xckgKys4J1FWw1OWhfKKJ4N2qwveErWKtjkvbErm1ZqOBQ30R
 UpUim6daHtnEAV+tkubg5T7zhO8Qc0BywWAjGsQsDTn+Xs0P/cf0YkFPKbIz+oug
 aWflEeKf3xsNhOKyAxv5zKvdBjKtZHy3Uuqr8JgUvkNprtuWSOFYEoQRfakIFDI0
 cz+TszLIiy//FM/LY5qZNEv3t7I+h/ewtlRtYK5hFDE5Ud6tLmgpA==
X-ME-Sender: <xms:vcylXm8gHj6siDym8e2XE_l8fznGB0RIFgwx8cI4wLg1-HEjI_r6ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrheejgdduvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
 segrlhhishhtrghirhdvfedrmhgvqeenucffohhmrghinhepohhpvghnthhithgrnhdroh
 hrghenucfkphepjeefrdelfedrkeegrddvtdeknecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfe
 drmhgv
X-ME-Proxy: <xmx:vcylXqZD6kKw7tJ2IWtQTk673w8vx_yTs6TRHM2ZopRkiyCSeXhXjA>
 <xmx:vcylXnH_3z2gp4eTpTr1GVExjvI3By5zmF5NYRbtacppyvWvFP3xLg>
 <xmx:vcylXr4ohM3JE6nV4sBuUW6tFfYm5J4Jxds2sDtF_aAHOnn5REvIiw>
 <xmx:vsylXpg5d9F-K4BDeEwesph_p7oDf0LjSg1uI20JhF4f5Vi1ndt8SQ>
Received: from ThinkpadX1Yoga3.localdomain (c-73-93-84-208.hsd1.ca.comcast.net
 [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2D5BD3065E36;
 Sun, 26 Apr 2020 14:02:37 -0400 (EDT)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 0/9]  RISC-V Add the OpenTitan Machine
Date: Sat, 25 Apr 2020 04:28:57 -0700
Message-Id: <cover.1587920572.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=66.111.4.29; envelope-from=alistair@alistair23.me;
 helo=out5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 14:02:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 66.111.4.29
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

From: Alistair Francis <alistair.francis@wdc.com>

OpenTitan is an open source silicon Root of Trust (RoT) project. This
series adds initial support for the OpenTitan machine to QEMU.

This series add the Ibex CPU to the QEMU RISC-V target. It then adds the
OpenTitan machine, the Ibex UART and the Ibex PLIC.

The UART has been tested sending data, but not receiving as there is
currently no UART receiving support in Tock.

With this series QEMU can boot the OpenTitan ROM, Tock OS and a Tock
userspace app.

The Ibex PLIC is similar to the RISC-V PLIC (and is based on the QEMU
implementation) with some differences. The hope is that the Ibex PLIC
will converge to follow the RISC-V spec. As that happens I want to
update the QEMU Ibex PLIC and hopefully eventually replace the current
PLIC as the implementation is a little overlay complex.

For more details on OpenTitan, see here: https://docs.opentitan.org/



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
 hw/char/ibex_uart.c                 | 487 ++++++++++++++++++++++++++++
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
 17 files changed, 1278 insertions(+), 15 deletions(-)
 create mode 100644 hw/char/ibex_uart.c
 create mode 100644 hw/intc/ibex_plic.c
 create mode 100644 hw/riscv/opentitan.c
 create mode 100644 include/hw/char/ibex_uart.h
 create mode 100644 include/hw/intc/ibex_plic.h
 create mode 100644 include/hw/riscv/opentitan.h

-- 
2.26.2


