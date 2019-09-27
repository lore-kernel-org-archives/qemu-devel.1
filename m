Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D589C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9EE20872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gf0rqPjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9EE20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDeTP-0000Id-60
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 20:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRB-0006wZ-Jz
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRA-0008I6-6J
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeR9-0008AO-52; Thu, 26 Sep 2019 20:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569545323; x=1601081323;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=to2LSvU6SRtGzE2StLUvISodwbfvMN16nW0KP1wbnVw=;
 b=gf0rqPjUW5VGZmYq5XJCTrwFS0lhUvZBpPEI+T1+wsETJK5RCHpaxpc/
 FKOtx2gTyiYmvrASEqJReukhXgPWhTuYdYfzC+hfnZf9y05PZkZiMz64s
 vgDdM16J9r59sI5dDFF0pFS+F3y3EQpHq+nx21snQTTb4muGld7OJa37b
 v34u75mO8FstVbcYJQkJtnHgE2LyTuvJ62RGZ8WXPAjIAPKmYrQ/wqVvV
 mU8po6vEIEqnR9dmLbImnGBamuIffNRwMwlcFe5XAo0Ip+rC9PxilQ3O5
 Ys1kIUMV0gQPGo7TJDDT11cq0WD39Nt91KlnUnbOJo7TOgREUDO3m4pi9 g==;
IronPort-SDR: gZ6i0KSYUQHijrEOndPwg3aYGICuw6RGGVstH+aZNW0OudeLeW8KL0mIE8M19PXm8AVp0NvtYB
 LJVXXGcPpfF8O0qO4ppjOl2F2ImpVvxiwRS13ClKnO+iupwi1N0sEe5jjy8lE+yPhQMRCyEwmS
 nv2qX4PjAbNIdH+DRes9WCQ+toWc4URiGfMUNP6aAB76WXXiKxwj4W81aIgimqlHGZ+Ujd3nqY
 L5tTrIb0nH0hEHhmpm5rENbjyiVUBhEQDKdUaEhzGWTnEsCvqqAfNildBd3JWMWy4rBBlAIOIk
 EfU=
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; d="scan'208";a="120012181"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2019 08:48:36 +0800
IronPort-SDR: Ndww3ipI075j3B0QvLBvGooHVorpPd5BhTo5tBzKH2isIFA95Urs9UFcwpuWRnnhWCiWqC7+WD
 t1HqwnqhRJZx2OPQZFq8+X+R7BOo/BYBdlZcVrvJBdFuO4SuNZXCR9HAtBJOdQLAvKuN9Zccf6
 zm9DMXRLhm2jka4a2no2HMFUZJDV0dGiBlkSVnVMEqE4elR99jLjfj5wiLBjZE0NBUDx4WbXi4
 N/s5ofOaK6BAUr5Qjx1agkDIkDwltnr66NdEg54L/xokywD4Irfug7KMkSfLhsLtc3c53qk5Uh
 UNmC8cWNC1X14X/ULnrmAa/H
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 17:44:56 -0700
IronPort-SDR: w9TNfa7USp9TYeeBNJX5TGG4Fiqqkj6QTTJzms1rlmvycuih3VIdO95sr3FOJ8Hx2jGhD+ayuZ
 h9tDLpAR+mISnDxJG17fkyV/gmlQfTGXw+m9HkCdmInnCAlHiD0G8rhBhYCIZ6dLYkP807D1+A
 lxDnRee7akksB5X4sOXcQ50vM1RcYWgousQ+AXOFHv6cer7Blvvwc1qqqpgFjid6GBCWu+ISUj
 rOGnLFcGx7xqLil1o+mt7I6HLeOLy/5pjKvMnm98uJL79KaJmQddb0mCR2+quT27BeYjsS4H8h
 PbI=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2019 17:48:36 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 0/7]  RISC-V: Add more machine memory
Date: Thu, 26 Sep 2019 17:44:17 -0700
Message-Id: <cover.1569545046.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.144
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
 hw/riscv/sifive_u.c         |  95 +++++++++++++++++++++++----
 hw/riscv/virt.c             | 127 ++++++++++++++++++++++++++++++++++--
 include/hw/riscv/sifive_u.h |  11 +++-
 include/hw/riscv/virt.h     |  10 ++-
 5 files changed, 222 insertions(+), 22 deletions(-)

-- 
2.23.0


