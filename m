Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BA9C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FD820866
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EqZ4nyhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FD820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9dA6-0007a3-Ly
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 18:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9d98-0006Qz-EG
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9d96-0004dp-TA
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:09:45 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9d96-0004Sp-6H; Wed, 04 Mar 2020 18:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583363383; x=1614899383;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tJtIPl5cwN1gfc3SsknFz5vNvnrF0CVeRFzPMds5Lwk=;
 b=EqZ4nyhPhg0gL+tEHNIvX3AJX9tnw/RX28iBvfUslym4QBHtQo1MhDS+
 uKGCzRWPPW0WB30ud6moKjXGoaVoyRO7V4QUcfnnr4F5Fg+AijrkLh1ro
 soDneI4T76CYSABrR8f83M4oXE/a01yAhNdQK0OItqZkHkBL1GM0o40Nw
 rM1Rw7MtZ6Zg5Jxu2McfGIUQNDGFU5Decile4mqgUDEE63J1OJnlJUHmm
 RJL2SoI/qqSNJ9SSLdQaXieNKwsTq0zBOkB7+sS2mHyATl2DHVDUfNzKK
 3GdRjS0aJV81SkFRV7u1anLbd7aFkuuP6qqcM6eweauMPsgh9rSvFIaG6 Q==;
IronPort-SDR: EwtedGqgnLAzM1kyB1MkYomaXrCbtJhb8DnybURqixGRV5KOM2ou/L/rq9hzlbbrpQ+C7JpMmm
 SzeyrYfIKSKPQZ1iWGklRxvj+KSsxEcLoHyiR1iDVNGjYN4ITBw3cLmelot9hB3Exlt54nY+FE
 zlSHq5KzrmxZfJN5Fc8eltV4DlxiqUDwnlZyW5kOicfOYAp3okqtRcIMM1M0B0QCAAmoUVRRfu
 2x13KPdEx/dzmb4choZ862Qcmbe6qcDRvslPzpV3AGDod5Cr4EDnkqrY94hrDGLNnPkRrEp8oo
 Ii4=
X-IronPort-AV: E=Sophos;i="5.70,515,1574092800"; d="scan'208";a="131477236"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2020 07:09:40 +0800
IronPort-SDR: dLNPKwKUaM/Cr/m/yqOBEryaK2F8aSeX76agnk1tpEWiOvTIMbVWzhOR6zgTUXMTN/Duz/deKf
 jO04w577dInmKiHIjq9qxgCYno70hY4J1gNpyJQcFGV3NnG7A7fRgTo5zCBBYiDSBPbF4m9piR
 +I5gSy2V69X4Ks5YeByGXyKnoTgEPaw+ahoA8BuW4D9UHzul0DinxW4+Sx/QHYq6I3YgU4M94G
 eioatdzxgK5IENHgigQajnhTZq3grHz+T9ll0jzkRXKzsc7jBc+RMDVZVEHCASLlLKF6aNlVp4
 ZX+qCghGElJ2QSxOvu+sna8w
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2020 15:01:53 -0800
IronPort-SDR: iNaPRfkO854zyZROI9ouP72IXubiJR1kRUpAeXX3JeAv4v4+svvndjtE3L8rGl2G5zcZLKd1n2
 BD8PVR5nSDMA+fO0+FZ8Dq2CtmFunoh4li4cwh2GP5phn+Z+x0YIg+XD5rtZ+6AuEOamv3+5wJ
 zEyyUtOo9U8d9B7cQJaTQyBpHYIM0SqXjKspl8qT1hLVdZQ/LXGfOc1LjfVuTeSNNC1AqrQIoO
 oGJE9IpzuAehGKidxsmg3nP9mHWs8Kg+T5OhdihCZIk9C7EVF3lV2lHSY6v0rYuwjC8XyN+HOB
 A5A=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Mar 2020 15:09:40 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 0/3] hw/riscv: Add a serial property to the sifive_u machine
Date: Wed,  4 Mar 2020 15:02:25 -0800
Message-Id: <cover.1583362888.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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

v2:
 - Fix the serial setting so it correctly sets

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


