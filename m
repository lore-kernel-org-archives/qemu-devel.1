Received: from eggs.gnu.org ([2001:4830:134:3::10]:47136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNvsA-00060b-VA
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNvs6-00018f-Mg
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:50:18 -0400
Received: from 8.mo3.mail-out.ovh.net ([87.98.172.249]:51826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNvs6-00018I-Ff
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:50:14 -0400
Received: from player770.ha.ovh.net (unknown [10.109.105.92])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 94EFD1BA5AC
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 09:50:12 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 30 May 2018 09:49:58 +0200
Message-Id: <20180530075002.4618-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] aspeed: add MMIO exec support to the FMC
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

When MMIO execution support is active, these changes let the Aspeed
SoC machine boot directly from CE0. As there is still some
issues, the feature is disabled by default and should be activated
with :

	-global driver=3Daspeed.smc,property=3Dmmio-exec,value=3Dtrue

Thanks,

C.

C=C3=A9dric Le Goater (4):
  aspeed/smc: fix HW strapping
  aspeed/smc: rename aspeed_smc_flash_send_addr() to
    aspeed_smc_flash_setup()
  aspeed/smc: add a new memory region dedicated to MMIO execution
  hw/arm/aspeed: boot from the FMC CE0 flash module

 include/hw/ssi/aspeed_smc.h |   7 ++
 hw/arm/aspeed.c             |  41 +++++++----
 hw/ssi/aspeed_smc.c         | 161 +++++++++++++++++++++++++++++++++++++-=
------
 3 files changed, 172 insertions(+), 37 deletions(-)

--=20
2.13.6
