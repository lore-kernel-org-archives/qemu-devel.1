Received: from eggs.gnu.org ([2001:4830:134:3::10]:47540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duZ1I-0004n5-SK
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duZ1D-0008Pi-4v
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:02:04 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:36200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duZ1C-0008O1-Vh
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:01:59 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id AB417AC92C
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:01:57 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 20 Sep 2017 09:01:29 +0200
Message-Id: <20170920070135.31379-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/6] aspeed: add a witherspoon-bmc machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

This series adds a new Aspeed machine to emulate the BMC of a
Witherspoon system. It also extends the other Aspeed machines with I2C
devices and adds a simple model for the pca9552 LED blinker present on
the witherspoon board.

Thanks,

C.

Changes since v1:

 - introduced smbus_eeprom_init_one()

C=C3=A9dric Le Goater (6):
  aspeed: add support for the witherspoon-bmc board
  aspeed: add an I2C RTC device to all machines
  smbus: add a smbus_eeprom_init_one() routine
  aspeed: Add EEPROM I2C devices
  misc: add pca9552 LED blinker model
  aspeed: add the pc9552 chips to the witherspoon machine

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/aspeed.c                 |  85 ++++++++++++++++
 hw/i2c/smbus_eeprom.c           |  16 ++-
 hw/misc/Makefile.objs           |   1 +
 hw/misc/pca9552.c               | 212 ++++++++++++++++++++++++++++++++++=
++++++
 include/hw/i2c/smbus.h          |   1 +
 include/hw/misc/pca9552.h       |  32 ++++++
 7 files changed, 343 insertions(+), 5 deletions(-)
 create mode 100644 hw/misc/pca9552.c
 create mode 100644 include/hw/misc/pca9552.h

--=20
2.13.5
