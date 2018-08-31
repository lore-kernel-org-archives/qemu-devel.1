Received: from eggs.gnu.org ([2001:4830:134:3::10]:45828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvgp0-0002Un-TL
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvgox-0001W4-MZ
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:38:34 -0400
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:42560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fvgox-0001VQ-CU
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:38:31 -0400
Received: from player168.ha.ovh.net (unknown [10.109.160.39])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id E0F0F17990D
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 12:38:29 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 31 Aug 2018 12:38:07 +0200
Message-Id: <20180831103816.13479-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/11] aspeed: misc fixes and enhancements (SMC)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

This series adds a couple of cleanups and two main features to the
Aspeed machines :

 - a 'mmio-exec' property to boot directly from a memory region alias
   of the FMC flash module using MMIO execution. This is not activated
   by default because boot time needs to be improved on recent
   firmwares.

 - support for DMA to access the flash modules. Our primary need is
   the checksum calculation which is used to evaluate the best clock
   settings for reads.

Thanks,

C.

C=C3=A9dric Le Goater (11):
  aspeed/timer: fix compile breakage with clang 3.4.2
  hw/arm/aspeed: change the FMC flash model of the AST2500 evb
  hw/arm/aspeed: Add an Aspeed machine class
  hw/arm/aspeed: add a 'mmio-exec' property to boot from the FMC flash
    module
  aspeed/smc: fix some alignment issues
  aspeed/smc: fix default read value
  aspeed/smc: add a 'sdram_base' and 'max-ram-size' properties
  aspeed/smc: add support for DMAs
  aspeed/smc: add DMA calibration settings
  aspeed/smc: inject errors in DMA checksum
  aspeed/smc: Add dummy data register

 include/hw/arm/aspeed.h         |  48 ++++++
 include/hw/ssi/aspeed_smc.h     |   4 +
 include/hw/timer/aspeed_timer.h |   3 +-
 hw/arm/aspeed.c                 | 255 +++++++++++++------------------
 hw/arm/aspeed_soc.c             |  28 ++--
 hw/ssi/aspeed_smc.c             | 263 ++++++++++++++++++++++++++++++--
 hw/timer/aspeed_timer.c         |   1 -
 7 files changed, 428 insertions(+), 174 deletions(-)
 create mode 100644 include/hw/arm/aspeed.h

--=20
2.17.1
