Received: from eggs.gnu.org ([2001:4830:134:3::10]:33423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSdFH-0004VK-JF
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSdFE-0001Xl-Hv
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:57:35 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:54190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fSdFE-0001Wz-BO
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:57:32 -0400
Received: from player797.ha.ovh.net (unknown [10.109.105.51])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 758B41BFEFE
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 08:57:30 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 12 Jun 2018 08:57:13 +0200
Message-Id: <20180612065716.10587-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] aspeed/smc: small fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is a short series of cleanups and fixes for issues in the Aspeed
SMC controller model discovered when experimenting with the MMIO exec
feature and also from tests under a QEMU PowerNV machine.

Indeed, the OPAL/skiboot firmware accesses the Aspeed SoC address
space using the iLPC->AHB bridge of the SuperIO controller and drives
the SPI controller to access the PNOR.

Thanks,

C.

C=C3=A9dric Le Goater (3):
  aspeed/smc: fix dummy cycles count when in dual IO mode
  aspeed/smc: fix HW strapping
  aspeed/smc: rename aspeed_smc_flash_send_addr() to aspeed_smc_flash_set=
up()

 hw/ssi/aspeed_smc.c | 48 +++++++++++++++++++++++++----------------------=
-
 1 file changed, 25 insertions(+), 23 deletions(-)

--=20
2.13.6
