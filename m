Received: from eggs.gnu.org ([2001:4830:134:3::10]:49101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duGgA-0001yB-Iq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duGg7-0006BT-H2
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:27:02 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:37878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duGg7-0006Ac-Ai
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:26:59 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id E206D62291
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 13:26:57 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 19 Sep 2017 13:26:40 +0200
Message-Id: <20170919112645.8574-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] aspeed: add a witherspoon-bmc machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

This series adds a new Aspeed machine to emulate the BMC of a
Witherspoon system. It also extends the other Aspeed machines with I2C
devices and adds a simple model for the pca9552 LED blinker present on
the witherspoon board.

Thanks,

C.

C=C3=A9dric Le Goater (5):
  aspeed: add support for the witherspoon-bmc board
  aspeed: add an I2C RTC device to all machines
  aspeed: Add EEPROM I2C devices
  misc: add pca9552 LED blinker model
  aspeed: add the pc9552 chips to the witherspoon machine

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/aspeed.c                 |  92 +++++++++++++++++
 hw/misc/Makefile.objs           |   1 +
 hw/misc/pca9552.c               | 212 ++++++++++++++++++++++++++++++++++=
++++++
 include/hw/misc/pca9552.h       |  32 ++++++
 5 files changed, 338 insertions(+)
 create mode 100644 hw/misc/pca9552.c
 create mode 100644 include/hw/misc/pca9552.h

--=20
2.13.5
