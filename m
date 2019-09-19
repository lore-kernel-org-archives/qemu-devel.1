Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DEAC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC83217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C5CcASz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC83217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4xU-0003SR-KB
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vB-0001Ep-Hh
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vA-0004xc-Bw
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:29:05 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4v9-0004wS-OE; Thu, 19 Sep 2019 18:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568932156; x=1600468156;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lZdttSW9jIlCDnuRmTYoBJWo0WbxlfQThewDn8tBbEo=;
 b=C5CcASz/rRxT1U8RrDipnUiubiyFizdE9YVYN28iTSMlrVq8pQsyw4A7
 jfOwNtUd0tXlzgB680CeGPUGaJm+jg9IX01lH7lmHHt/meN44InRtkhEL
 WK3GRhoEg8SnXXouJb9agLcypBocA3Frc9tq63KiI0xBiXMZS9tJZNtsp
 H++nGailL1ENUX70V2U27+Ru+gU1xYab7eBjInsC6kmk5l/ej1qKznsia
 Au+NZEtDBlkDRqeaPu9VTqt1GSf8bDvavNylrgnlOW0ao3a0tpl+UGwoj
 mfGV6jS6iUJTZxHtdY3OUoMaFM8yIDaNvus37PoSn/NYsNB+/OLq/b/lf A==;
IronPort-SDR: WLw9CnEeOkqFdqJte5x+JcdGZux5tyg4N1wK6O91Ngydyyd5/hqIfzomF9olsTvcXX8d+Saz3W
 0sn9ElyglrGENhi83ipMp0CZaqje8PAklbdEaWCdwQXoetJloaa/tUSilhTr+9LdKvZeSwcjmf
 QkEpPO0s9bQrEOsVCyaLMtZ8mSvr+6sADdeUFPPPet/Pv5QADmcSILqldyDPZeBupUoH7ohy8e
 uF9W6lZM/aezBMG5Xzp1YTdWeULq7MfQw7UUAUpwiAUMdJvWa5YcUI5R4DsSt2vtAX3KYNwcQh
 ikI=
X-IronPort-AV: E=Sophos;i="5.64,526,1559491200"; d="scan'208";a="219490584"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2019 06:29:09 +0800
IronPort-SDR: jN/LMRY2L0O5S+HcgyUhwAocqmH7b7lYxYidMoJBPP2Q3LNsuAC3s+KEs0Oh9bg8Is0gy+1cUl
 2Fg1WtvNJ3TlKPF5X6wq3gdzXdaUpsRJaGhAM7HGju5N+RRH3XGpEtU+jzuMVfYS4jYuWCsWEI
 8+clvQ4/joWVMF8dD7OcZ+XI/vfpqzUE+ksZZotv2SgppRzd2c8BxzY8MQSpAB0xrYqVj9Ih0V
 3lP6q4iKS2MDYv7nNi4JdEG3qiBuq2OEHOrrpGNEiW8QesDTf0VKRujgjSosdRSqt49ODe8VoG
 NzYmKr5hJlQeqnmRi6ZthpcM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2019 15:25:31 -0700
IronPort-SDR: VxM57Dg/2n2XEogiGD473VCkx3JcRWjMTZsb1W0apYGCJaNpCRLvJpz85QNgn5WznEBRHRRtiT
 Su1rabKvmtH08nGnmhDUzJlCaE27/vo+miy1PZ5vMtBin5fTUIayo1qU4kgc00QGII0nyByGUZ
 0Fs2pnM3vn9Gxmq2xvfZp3VLlXZvsSneoq/OA1/2Sp6PL390srfzbG4QGuPZkIhGRsQpIAhPCO
 Wws+q1Xa60QF0aEMnOLepxuayzW+tMrNcTYDr8KVC2ES79+5fy9ry+96sWd1DLPS7pFhUwRSQa
 A3k=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Sep 2019 15:28:59 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 0/6]  RISC-V: Add more machine memory
Date: Thu, 19 Sep 2019 15:24:51 -0700
Message-Id: <cover.1568931866.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
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

Alistair Francis (6):
  riscv/sifive_u: Add L2-LIM cache memory
  riscv/sifive_u: Add QSPI memory region
  riscv/sifive_u: Manually define the machine
  riscv/sifive_u: Add the start-in-flash property
  riscv/virt: Add the PFlash CFI01 device
  riscv/virt: Jump to pflash if specified

 hw/riscv/Kconfig            |  1 +
 hw/riscv/sifive_u.c         | 77 +++++++++++++++++++++++++++++--
 hw/riscv/virt.c             | 91 ++++++++++++++++++++++++++++++++++++-
 include/hw/riscv/sifive_u.h | 11 ++++-
 include/hw/riscv/virt.h     |  3 ++
 5 files changed, 177 insertions(+), 6 deletions(-)

-- 
2.23.0


