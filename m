Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC787C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 01:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970502073D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 01:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nHHfRxiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970502073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9IyR-000445-QX
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 20:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IxV-0003Bv-St
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 20:36:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IxU-0004M0-KD
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 20:36:25 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IxT-0004Fm-Pi; Tue, 03 Mar 2020 20:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583285784; x=1614821784;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5ar0juGldpaqyHq+thEzU2krib+m92Q6k25lA1Zb1JM=;
 b=nHHfRxiW2u0WCUY5anb8GSl8ui6vLIFEI5IXvKZc1hDDEIz6+xCdRhYv
 7S9seFhtacOLNaC4BInUeFPABbwueCrwjaIegHrWZiFnRg7u2oZQtQJ1V
 evKJB0vyfj7wFpWUmk7hGE3/BiwRDF9wzULYez/70Zs5hFR7Mdz3EBBCg
 HLf92WyjcTLRE8NZsgNzb7oMJIoreGLRU6ZX0U7zh8gsPMBLPw5/RBZ8c
 dQHv5CrqH4CT2bFzCpEpuJBwVSa1ByKYnMDyuW9pwdVjg6WYDLRrr4o+y
 mnRTsSnNppc8v7iE3FsXHrll6taXbUqljJYE3UsZE10B8TKpdan7JxCdq Q==;
IronPort-SDR: mYhWnSOtf5indY2BwmNcz58nUdX2pHBaFjfYVtuKZKSNtgOjZEVHw/16aPobMQkZBFEeMvhGVR
 FBuZAbTCSLr4p3HDLo9d9IrcrSuX8OMKMrtFA9PDWrGxVUkarF/RvtWFMqmhxiFDoD5njuRCKw
 6R1CmAN0VbiC+F0qmLip0aPONocHxGjzA0lmn2PCKWilPp/o6/mORsJosgdou+th3casgWRI5d
 IKomY9HYvStB1/DWPbVg0dOvCcKSYzSmPTgznj2URHvjW0SZ05ywTDI+zyJeufYLHFDxvWu1t7
 aVM=
X-IronPort-AV: E=Sophos;i="5.70,511,1574092800"; d="scan'208";a="131866028"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2020 09:36:20 +0800
IronPort-SDR: QjNKalt78CosMrfiRJ/jmLZIxK0/kJJgAuIfDLEXtpxt3hFsV6axphfnZzau4KrwFXcfr6lZPm
 nCqIiSrNQiSH2JwfiOBentDUWFC6dSft2p3nelHH4hDrZlf5vxj23Pp9iiRxMaPkJ6W2/4I9gp
 zlBmN/1Cg5/M9fhGXYkc49/TacsvltsbH7BjqQZGf9SZs+MdPjj7UUgpGqfo971K+C8dPFpuCN
 zW7pU6s1mOM6m+qXl0z39jRb4rX1SGLnu/AQLt0J9g0swV5E/rOHvM6uLR9Cn6S4LJWxOv1uC/
 7bn2HfRSw3MUTt5xPrsPitkM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2020 17:28:10 -0800
IronPort-SDR: IF4fxrGbpTrod6ujhsjj9z+rTmviTMO80s7/YX1B5jJ9ZijzVCZwLHAbJS7y6kL0elzdcrqJJg
 9ykka5WZZ4t8gcIFn2mFlvLDA1wCWzuNkUYoyCQmp51uS7lwkgchJ7/OJP+SDWhq30VbxffMKA
 ZO/zSKpoyUBd7i+QkGufijeiJo1RMucxsrRx9oWOlpxDbLB4sJsA+wxX3CD+NsJSnm5L6T+yaV
 6u/12JKd9v3X/ZeWakQYezuI49/YvTeD1nlBJ9uzQcKuDlJAY6AH6Y0T2tN3n+g3Scm3wz42qL
 dDs=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2020 17:36:18 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 0/3] hw/riscv: Add a serial property to the sifive_u machine
Date: Tue,  3 Mar 2020 17:29:06 -0800
Message-Id: <cover.1583285287.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At present the board serial number is hard-coded to 1, and passed
to OTP model during initialization. Firmware (FSBL, U-Boot) uses
the serial number to generate a unique MAC address for the on-chip
ethernet controller. When multiple QEMU 'sifive_u' instances are
created and connected to the same subnet, they all have the same
MAC address hence it creates a unusable network.

A new "serial" property is introduced to specify the board serial
number. When not given, the default serial number 1 is used.

Alistair Francis (2):
  riscv/sifive_u: Fix up file ordering
  riscv/sifive_u: Add a serial property to the sifive_u SoC

Bin Meng (1):
  riscv/sifive_u: Add a serial property to the sifive_u machine

 hw/riscv/sifive_u.c         | 135 +++++++++++++++++++++---------------
 include/hw/riscv/sifive_u.h |   3 +
 2 files changed, 84 insertions(+), 54 deletions(-)

-- 
2.25.1


