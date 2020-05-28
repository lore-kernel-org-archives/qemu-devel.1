Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98211C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFAF208B8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FUd7xZmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFAF208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeQz2-0007Sa-GQ
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQvM-00026z-1S; Thu, 28 May 2020 18:22:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQvJ-0005c9-90; Thu, 28 May 2020 18:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590704570; x=1622240570;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dwFF3Z9fw75SKPqpg4WJ6RijqvXlAFJWRkvVUQeWXLw=;
 b=FUd7xZmZq8uypeJykbf4K0gh2qjN5Rc+pZaHzeRRF2lF/zX7ccB1ZFi3
 aNFQ6Yk7CkUHOeAtWzJGVA+ErH//98laCcxYf8CYwXV2rRihmlaeNS0mn
 fYfFtbO1bW+8zxk3SIyjSpNxsx63H1+P2vByFtJyfGNesM6mYCCcMq6pH
 MzgvuwowZs/LM+12srvD6ribjQSmL4U+EPN5SixzeFq25IX6EN5o8KpCD
 RIojWG/WF1qs+Jz3JEAh8ErYlglDXY1BOyMnBRNTzDZXaUC2DvHnFjnDp
 7YB59KgBwSGS3SAKaRRgrlzwXj9SCXesf6g/az7J+BLHvcNqh97i8EblE A==;
IronPort-SDR: 38QKzF5Nzmmu2RfLuJZiD6jT3itQLtV7VLXVDoYJI3wV9IIuZWJgwjfPFPYLa2lvEiiaSJeFdn
 pOMRFYzJ8VMgBD7ooHqLIaoOloWftvoM1U6cfJLLzeCVRRfbSIrdncRJVNsmR2jZwArUL3T6CG
 QKAXbsdTYXrMB49LJZ7E5atU/qy25agb6/q9SjTw+JJBEziwSVwaO8L7KSk/w5uYZAzJr+RruG
 MzyCKUYbRolwQlcpmkC7KX4UuuQXs7WR/bqZhQsFvhUgXbkg++36IoHhTQVmN9QrArmGRyQrQK
 kwk=
X-IronPort-AV: E=Sophos;i="5.73,446,1583164800"; d="scan'208";a="139073324"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 06:22:44 +0800
IronPort-SDR: hV6I6KI81wGkkF6IaUsvYPGxgpkG3AWWzsWZHO05rSKNb9WKToLuGa+uyZ331TTAv32/OHULLJ
 wIdrQSoYLpuk9JnWKJBRM0ThrknKLWJ80=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 15:11:58 -0700
IronPort-SDR: EefalmEMV67jml+B2WWe/avhBMuYKzMcIoXHibqk8nu+Egv0NTEN4s28atWce6VE1OraazZviZ
 tsyvyRI90Wmw==
WDCIronportException: Internal
Received: from 6xf7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.123])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 May 2020 15:22:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v5 00/11]  RISC-V Add the OpenTitan Machine
Date: Thu, 28 May 2020 15:14:06 -0700
Message-Id: <cover.1590704015.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=4104b2603=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 18:22:43
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



Alistair Francis (11):
  riscv/boot: Add a missing header include
  target/riscv: Don't overwrite the reset vector
  target/riscv: Disable the MMU correctly
  target/riscv: Don't set PMP feature in the cpu init
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
 include/hw/riscv/opentitan.h        |  84 +++++
 target/riscv/cpu.h                  |   1 +
 hw/char/ibex_uart.c                 | 492 ++++++++++++++++++++++++++++
 hw/intc/ibex_plic.c                 | 261 +++++++++++++++
 hw/riscv/opentitan.c                | 219 +++++++++++++
 target/riscv/cpu.c                  |  27 +-
 target/riscv/pmp.c                  |  14 +-
 MAINTAINERS                         |  13 +
 hw/char/Makefile.objs               |   1 +
 hw/intc/Makefile.objs               |   1 +
 hw/riscv/Kconfig                    |   9 +
 hw/riscv/Makefile.objs              |   1 +
 17 files changed, 1291 insertions(+), 18 deletions(-)
 create mode 100644 include/hw/char/ibex_uart.h
 create mode 100644 include/hw/intc/ibex_plic.h
 create mode 100644 include/hw/riscv/opentitan.h
 create mode 100644 hw/char/ibex_uart.c
 create mode 100644 hw/intc/ibex_plic.c
 create mode 100644 hw/riscv/opentitan.c

-- 
2.26.2


