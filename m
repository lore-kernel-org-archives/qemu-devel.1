Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDE1C74A36
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 00:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B906A21019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 00:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NSBUdhai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B906A21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlMme-0008KT-PQ
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 20:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47651)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=088e9cfd1=alistair.francis@wdc.com>)
 id 1hlMlf-0007OE-Sl
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 20:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=088e9cfd1=alistair.francis@wdc.com>)
 id 1hlMle-0004BY-Mq
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 20:16:59 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33483)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=088e9cfd1=alistair.francis@wdc.com>)
 id 1hlMle-00043Y-28; Wed, 10 Jul 2019 20:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562804218; x=1594340218;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iJakTHifpUX7sP4t7RCs+ZOYW8GQuYlCP1wr5W3XNQQ=;
 b=NSBUdhai4RWDhPnVqWTS2lVx/HB9R5dL1jQX7qAbuJFVM5aEJQg+gRGB
 Pi+9A9jhrwta9gbzKxJNROxJQW4pcwj6Zuv+gCqywvzvICEh/LdM0UC7I
 q8R+dIJymk9nLU2D3FvVNP5EI01MZMLUVx7Hw+RLht3EJENwvIkiyMVU7
 9Vmtf/5zRgcl/0r7Ylq6JFM5ee/GOG/MtQMLNyURO3h/P4xQVNaY3+5c3
 3UqTIMHir5ZKvNfOLquqME/DSPqbBYaTWOuTbfF7wdgFOfA869c4jPQVj
 ctEO4x6XKGxT5DWtgGgTVuTefsvuGNL3JDe5dXg/NiW98jFtl9dKnR6Z1 A==;
IronPort-SDR: 2MxN2X9UUu6Q+tu95Zl3+wh1j8pswLu4CuanEi6+AZk/oOho5YLvZxKIEUJYjmVO9R4CZt5rgP
 jG+1rfJrFUnT9h7MApMESdze2K42QIirgCDhibyJ84bt3fONKljO7KqzIcXEa1jiX+wRgLrYc2
 hzZgqOBpd1xekP6+T4CmI1yTVixE+k3vvXPy9uV31jUCXjikZ/okWpV13vYjbG75UdpOrZwVdi
 h2q2QWuUI9Vl+svO3tHrqQKmo+ar4QBIPCky5RIe2N5RGFn6M8P44UmulmoC7/S/1mb+IgEvTz
 jDg=
X-IronPort-AV: E=Sophos;i="5.63,476,1557158400"; d="scan'208";a="112725454"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2019 08:16:48 +0800
IronPort-SDR: hgmjOd7divxrZY7vOoph8/dcNyB6+JBeujBfGEF+b/LBZwwAq1Pily54grtMKHOSeozL65qTKJ
 TlqVbBQCEw2D322DGxvqQgOemaFbVVwuMzYIRUV9+0zrKKYijdHD0jkGWNXzVxiMQoysLGigG5
 m4KRH9F/TdSwnKFTx96plofJFYuHPDZpYURmqIVGdSZJEmcTsLvhodVo+vlcRTXleKEy1r2vsX
 qYrbydCp8KJnZg8KDG5BLNGsmgGwN0eF3cqBttKSoNnevFcsquF7rSy1kVtjgqWHfQoJ/TvSIs
 vLWfQdcauixSsqIuve3QO0H5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 10 Jul 2019 17:15:32 -0700
IronPort-SDR: 55+1A/Ns0YKLXv7Hss4fMudEgG1HhvtiZFxwnq8qYCJabkqNOnCG5N7RxI7KutOSZIb+Z5vDjh
 BlPAhUe5aSIJkdf7zEy1HJJxVylKso8r/SpI0iUWtn+TmlXy1dLIXRarjnJrQBv464QKmuKpnk
 GYzvmmVCrtUJAk0Onm9Q3u35ol4wGavlBGmwCfrPrzabxTUMn20m4H2JtXWHIEhkHA9d1vT53K
 oLhv5W86ynw+4x5q6gOrP+Nb2LMj1R6tAR1X38fucSudxpAgbOnqBc+66K/zif0miQO9mLkDOJ
 VR0=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Jul 2019 17:16:47 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Wed, 10 Jul 2019 17:14:02 -0700
Message-Id: <cover.1562803960.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v2 0/2]  RISC-V: Add default OpenSBI ROM
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
 pbonzini@redhat.com, alistair23@gmail.com, bmeng.cn@gmail.com,
 linux@roeck-us.net
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

The commits can be found here: https://github.com/alistair23/qemu/tree/mainline/alistair/opensbi.next

v2:
 - Error and exit if we can't load the default firmware


Alistair Francis (2):
  roms: Add OpenSBI version 0.4
  hw/riscv: Load OpenSBI as the default firmware

 .gitmodules                                  |   3 ++
 LICENSE                                      |  21 +++++---
 Makefile                                     |   5 +-
 hw/riscv/boot.c                              |  54 +++++++++++++++++++
 hw/riscv/sifive_u.c                          |   7 +--
 hw/riscv/virt.c                              |  11 ++--
 include/hw/riscv/boot.h                      |   3 ++
 pc-bios/README                               |  11 ++++
 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 0 -> 36888 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 0 -> 40968 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 0 -> 40968 bytes
 qemu-deprecated.texi                         |  20 +++++++
 roms/Makefile                                |  48 ++++++++++++-----
 roms/opensbi                                 |   1 +
 14 files changed, 157 insertions(+), 27 deletions(-)
 create mode 100755 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 create mode 100755 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 create mode 100755 pc-bios/opensbi-riscv64-virt-fw_jump.bin
 create mode 160000 roms/opensbi

-- 
2.22.0


