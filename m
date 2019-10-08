Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302BEECE58C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F365221721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V/kmIR9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F365221721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHz40-00027p-0z
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 19:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz21-0000NW-Gp
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz1z-0006NC-Ui
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:36:40 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13227)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz1z-0006MO-9J; Tue, 08 Oct 2019 19:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570577799; x=1602113799;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dTIxuW/6qjYDWLD7g2ntU0dhNT0bIPVcxN3B/vRs8A0=;
 b=V/kmIR9/8wjc6NxzFZBK0yXAyoSlRwH1PW0vGLPYQXXgJKKZS1mOgXNw
 1gNnE+02LpYfoK664P2ZZO3IdUXs0QWi0xNQhVXnNj96cGy/wuUhUa1Hk
 8dHv2QturCPyZPzVRp0L+jJK8/HBfNzEZp/kjq1W9xAnAPFYgDPd6GWAi
 dbPMGl0kJB5vSPKcNNbgaNV3yTTOgVYZqsjRO1LxsH5bk36U8jxELZx6N
 UQYYwUxTPYpGAe6g4swYwggT8mHC0uMQ8KQqbTY01W/vUh0Pb0DRQkk3y
 +Pf8PXWrys6RbjETDprGKjvwRB/Y9CguUQws2bJ0W5G8ahfZGhV/KqltL Q==;
IronPort-SDR: HGOru1L1ntfq9GvLTngs3/qCNT8F3U3Ein9AED5x2WNZO3a9/eWrl+7NXPozgLCQfKko30yDmp
 p0eBQbzlMskQb/Qd3C7NOAmy3//g5JKlJW976II5DuOoPDX0+7Oup2Sd5EMZ5GPWeIsd2HIqri
 HkaOWOn+JwWKGStwv0gO1EBFH3iJ3Z9mHlLDLrHEfnVOWhKqSjqSnlbLs85yxwvayP0+4mto6e
 mZo1bmYZIXPwGxXtJAKRBEluZd0fOD1s/NIvNPpsUyQuwNJ38Xy2h5nQCQgTRZ6uCVQgnRwh32
 +rE=
X-IronPort-AV: E=Sophos;i="5.67,273,1566835200"; d="scan'208";a="121675994"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2019 07:36:34 +0800
IronPort-SDR: WlIYkv+/NBVadAZcG8krY2pILcXHIrcLCptoTawRVRr4EEqEq/iMxhuHfsufw/i68J66ioaMdw
 BgoV1NKv61tqP2MurZyeXgzGq7F8vLXQdUWqj17GWx0Z4MugoMttOe/BSg0Cv+inS53nNKX3lY
 s5pIRTuQdFYAlQhhdEVkLcpGQ650dhY/ulLAWMYFBzD90C2ZSF9GtRDpHqe5/mWsT8dvvXkfsG
 Thzv9huU5kBeWIaGU0B+cUkjeBwuG13EGKaJsmMdFLn0BIKjETSK2xW63z3MII0YQeas2gSpHW
 zaHREyQBWbV0nvPIJWbtlR0h
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 16:32:35 -0700
IronPort-SDR: BOKoC1orIRNuBdblB7v9IkVsJDCuwj1rNiC8wqQPIMJTrFoKtxZ/q7QrnM8T7dW4UhtxjHQ3AY
 rUcFv5S/gTBCvD17bfL1lQ0sTcE8tMh/ydIGrbc5o3RPpiGYqMTRBjInqH/844NBFA+TSyg5Cf
 ALmELtB4OAs6KuEKNlOhAbf3symkfg7sLPG0PSvs0veR3U4Tcb3Z9ynWuW8WGUATJBjNu8oFty
 QjE6Hh5ov+u215AuXqMNHid3aufVcrC9xpMqiKi9VNLIK82hibAtRYp+ROVaGlBT5sLIP1LqlS
 yEg=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 08 Oct 2019 16:36:35 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 0/7]  RISC-V: Add more machine memory
Date: Tue,  8 Oct 2019 16:32:03 -0700
Message-Id: <cover.1570577500.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


This series aims to improve the use of QEMU for developing boot code. It
does a few things:

 - sifive_u machine:
   - Adds a chunk of memory in the Flash area. This allows boot loaders
   to use this memory. I can't find details on the QSPI flash used on
   the real board, so this is the best bet at the moment.
   - Adds a chunk of memory in the L2-LIM area. This is actualy the L2
   cache and should shrink as the L2 cache is enalbed. Unfortunatley I
   don't see a nice way to shrink this memory.
   - Adds a property that allows users to specify if QEMU should jump to
   flash or DRAM after the ROM code.

 - virt machine:
   - Add the pflash_cfi01 flash device. This is based on the ARM virt
   board implementation
   - Adjusts QEMU to jump to the flash if a user has speciefied any
   pflash.

Both machines have been tested with oreboot, but this should also help
the coreboot developers.

v3:
 - Use the start_addr variable instead of editing reset vector
 - Fix function names
v2:
 - Address comments
 - Fixup addresses
 - Don't use macro for machine definition of RISC-V virt machine



Alistair Francis (7):
  riscv/sifive_u: Add L2-LIM cache memory
  riscv/sifive_u: Add QSPI memory region
  riscv/sifive_u: Manually define the machine
  riscv/sifive_u: Add the start-in-flash property
  riscv/virt: Manually define the machine
  riscv/virt: Add the PFlash CFI01 device
  riscv/virt: Jump to pflash if specified

 hw/riscv/Kconfig            |   1 +
 hw/riscv/sifive_u.c         |  98 ++++++++++++++++++++++++----
 hw/riscv/virt.c             | 127 ++++++++++++++++++++++++++++++++++--
 include/hw/riscv/sifive_u.h |  11 +++-
 include/hw/riscv/virt.h     |  10 ++-
 5 files changed, 224 insertions(+), 23 deletions(-)

-- 
2.23.0


