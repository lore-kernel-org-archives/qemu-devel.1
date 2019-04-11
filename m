Received: from eggs.gnu.org ([209.51.188.92]:60923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEcHZ-0003XE-Uh
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEcHZ-0004q7-1D
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:10:33 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:36103)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEcHY-0004mQ-Qh
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:10:32 -0400
Received: from player759.ha.ovh.net (unknown [10.109.146.175])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 89F475C047
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 18:10:24 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 11 Apr 2019 18:10:10 +0200
Message-Id: <20190411161013.4514-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] aspeed: cleanups and extenstions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is a series adding a couple of cleanups to the Aspeed SoCs to
prepare ground for extensions and new SoCs.

Thanks,

C.

C=C3=A9dric Le Goater (3):
  aspeed: add a per SoC mapping for the interrupt space
  aspeed: add a per SoC mapping for the memory space
  aspeed: use sysbus_init_child_obj() to initialize children

 include/hw/arm/aspeed_soc.h |   3 +-
 hw/arm/aspeed_soc.c         | 266 ++++++++++++++++++++++++------------
 2 files changed, 184 insertions(+), 85 deletions(-)

--=20
2.20.1
