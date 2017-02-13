Received: from eggs.gnu.org ([2001:4830:134:3::10]:38577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdHst-0007Hn-Ob
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdHsp-00023T-NV
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:45:43 -0500
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:34254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cdHsp-000233-Gw
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:45:39 -0500
Received: from player772.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id BD68A4A71E
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 15:45:37 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 13 Feb 2017 15:44:20 +0100
Message-Id: <1486997062-23227-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] aspeed/smc: add support for DMAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is a short series adding support for DMAs to the SMC controller
of the Aspeed SoCs. It uses coroutines to spawn the DMA requests in
bottom halves. This method is inspired from the block layer, the code
looks nice but maybe, this is unnecessarily complex. Paolo, could you
provide some feedback ?

Thanks,

C.=20

C=C3=A9dric Le Goater (2):
  aspeed/smc: add a 'sdram_base' property
  aspeed/smc: add support for DMAs

 hw/arm/aspeed_soc.c         |   5 +-
 hw/ssi/aspeed_smc.c         | 233 ++++++++++++++++++++++++++++++++++++++=
++++--
 include/hw/ssi/aspeed_smc.h |   3 +
 3 files changed, 233 insertions(+), 8 deletions(-)

--=20
2.7.4
