Received: from eggs.gnu.org ([2001:4830:134:3::10]:47449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cbp5m-0004Wp-3B
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:48:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cbp5i-0001Wh-V3
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:48:58 -0500
Received: from 10.mo53.mail-out.ovh.net ([87.98.189.210]:43123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cbp5i-0001Si-P9
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:48:54 -0500
Received: from player158.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo53.mail-out.ovh.net (Postfix) with ESMTP id D937438476
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 14:48:45 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  9 Feb 2017 14:47:34 +0100
Message-Id: <1486648058-520-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] aspeed: miscellaneous small fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is a short series fixing small issues in the SMC controller model
of the Aspeed SoC.

Thanks,

C.=20

C=C3=A9dric Le Goater (4):
  aspeed: check for negative values returned by blk_getlength()
  aspeed: remove useless comment on controller segment size
  aspeed/smc: handle dummies only in fast read mode
  aspeed/smc: use a modulo to check segment limits

 hw/arm/aspeed.c     | 22 +++++++++++++++-------
 hw/ssi/aspeed_smc.c | 13 ++++++++-----
 2 files changed, 23 insertions(+), 12 deletions(-)

--=20
2.7.4
