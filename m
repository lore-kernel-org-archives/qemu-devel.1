Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A14C606C9
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 18:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EB721707
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 18:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nf0cqUeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EB721707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkYle-0002fM-La
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 14:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56026)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=085e8ccea=alistair.francis@wdc.com>)
 id 1hkYkQ-0001t4-M2
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=085e8ccea=alistair.francis@wdc.com>)
 id 1hkYkP-0007ah-Hv
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:52:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34026)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=085e8ccea=alistair.francis@wdc.com>)
 id 1hkYkO-0007Tx-TH; Mon, 08 Jul 2019 14:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562611941; x=1594147941;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=uH/qkDo1j7ujLLdk0clrf+B7ILiNXAyEMMTKL2p6PX8=;
 b=Nf0cqUeZNrSXfrB+RA4MKQhJmF8DlwEeZ1vGHCUUoNBIkRlu6S2S4KQ3
 uX9lHUsSlbKDK53T9QmvSp7aTYMPYvBn1oFeZEqw/FGNE35bV3sWGIMW2
 ZCaNT6Caj41m0t1MFo+lQ4Hf+a2sQmobVLh8WVfy8m94i3ebVhJgjTg02
 YrhT6f/wzg/uGVU9RZzoNWDnghtrAnPv3o0IzX0xh+6LK6KTiQizXF2H5
 yEeUcTZk8ZXPguE3N1aq2TYdKAsgzeXSb4NRH8LtjCey4aIPV6G7nLpdN
 /opXhCo9JWXMgKdJeHCovM5a1aF6baw8YrVFGrDPKiFpkHdNCLBwyhVMb g==;
IronPort-SDR: kyDHa5/+E1dyV9LuAzJTkH8CTm1bcOMXwNrk0h6rLTtyGTkcSg1YYbKZws27JsK8FYNKtVPwzN
 YhAvNkSN+uV8iH3QxIebfh5na6uxAOUKj46PsyTmTOqMqJSRCwdQBxYEGFXdlWlLn9ewJgKljq
 Euqhhf6z71MMRLy7SB9RL/BdK66XfbFOKe9r0y0AO+dbFghXVtCn1mBsftE5nsE742ayedbnWs
 nNS4+0HppC6AAUOOj+Aoh4qinpCOgjHxwjzkQYClZhDPHUfaNbzhfjB1ZLJZSSefL6qusd0E8s
 /9Y=
X-IronPort-AV: E=Sophos;i="5.63,466,1557158400"; d="scan'208";a="114094437"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2019 02:52:17 +0800
IronPort-SDR: sMTAdbsjPN8JRjOv0H5as+1T7/fW2UEerkVZPwM4oHJyiS//gdJ6HRMsMDin8ngpfUzWbs/mXB
 kDnSeuuPgBOXjhfTVX4tV/mhcGGwCMoGKiK8SbCA7BhfglNwmCjZEP6KkAej7R5LVhi/Ub6je6
 fg5oPelyGzsQDX1QCTc6+7H3g8mrUQ9S2QIlVO8HHtNl2Z8ssjd9PX1/0Z2i2HrBuGBGG2/P5r
 s2VW/FaZmwTm8GtI9B/9GK4aqKDr50afg8/q51JkknZgbrmWKkG4EcLpjci5ZfpTT6Ig8joJ9f
 a12g3eOmt/ORZphWbslvSARQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 08 Jul 2019 11:51:05 -0700
IronPort-SDR: 2CDX3KCgjO4UtPgO4JCzKn2W0LO8r5MBzp8ocAF72h1yX2uC3Efcu+2oKRD+LNH8da8rU8giR0
 O/hSTJ7uuNV+Jj/ap0gDmq81N9AjLsJz2ceYtPYhYLV+yIdZlQk2FtT4qfdu9yvSF762ZTL1me
 kUzpPHuOdvnHeNw+NJVr9L3SAwwIyFkuXEg6UB2SkslCxcdhW/uE9fjVkMKJPETJIgAcVlvHNM
 sSbAuKJ4YzqXYDw/hbO59wmCO9of2rgsXCoq0pB/EjVFlm9z31Xdss5iYapQZT9SKNN5NGo6Ny
 OH8=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 08 Jul 2019 11:52:18 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon,  8 Jul 2019 11:49:35 -0700
Message-Id: <cover.1562611535.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 0/2]  RISC-V: Add default OpenSBI ROM
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
Cc: peter.maydell@linaro.org, codyprime@gmail.com, anup@brainfault.org,
 palmer@sifive.com, alistair.francis@wdc.com, stefanha@redhat.com,
 pbonzini@redhat.com, alistair23@gmail.com, bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series includes the OpenSBI firmware for QEMU RISC-V users.

To avoid breakages we have not changed the default behaviour of QEMU.
The plan is to change the default though, which is why an entry to the
qemu-deprecated.texi file has been added as well as a new warning.

After this series QEMU 4.1 has three options:
 1. ``-bios none`` - This is the current default behavior if no -bios option
      is included. QEMU will not automatically load any firmware. It is up
      to the user to load all the images they need.
 2. ``-bios default`` - In a future QEMU release this will become the default
      behaviour if no -bios option is specified. This option will load the
      default OpenSBI firmware automatically. The firmware is included with
      the QEMU release and no user interaction is required. All a user needs
      to do is specify the kernel they want to boot with the -kernel option
 3. ``-bios <file>`` - Tells QEMU to load the specified file as the firmwrae.

All users should transition to using a -bios option. We can start
updating all documentation after the release of 4.1.

At the end of this series and the transition period we are in the good
place of no longer requiring users to build firmware to boot a kernel.
Instead users can just run QEMU with the -kernel option and everything
will work. They can also override the firmware with their own using
the -bios option. Using "-bios none" will result in no firmware being
loaded (as it is today).

This is based on my original series adding OpenSBI support but now has
improved documentation changes around the license.

Alistair Francis (2):
  roms: Add OpenSBI version 0.4
  hw/riscv: Load OpenSBI as the default firmware

 .gitmodules                                  |   3 ++
 LICENSE                                      |  21 +++++---
 Makefile                                     |   5 +-
 hw/riscv/boot.c                              |  49 +++++++++++++++++++
 hw/riscv/sifive_u.c                          |   7 +--
 hw/riscv/virt.c                              |  11 +++--
 include/hw/riscv/boot.h                      |   3 ++
 pc-bios/README                               |  11 +++++
 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 0 -> 36888 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 0 -> 40968 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 0 -> 40968 bytes
 qemu-deprecated.texi                         |  20 ++++++++
 roms/Makefile                                |  48 +++++++++++++-----
 roms/opensbi                                 |   1 +
 14 files changed, 152 insertions(+), 27 deletions(-)
 create mode 100755 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 create mode 100755 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 create mode 100755 pc-bios/opensbi-riscv64-virt-fw_jump.bin
 create mode 160000 roms/opensbi

-- 
2.22.0


