Received: from eggs.gnu.org ([2001:4830:134:3::10]:32813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e5Dne-00011L-VV
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e5DnZ-0003JO-Us
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:36:02 -0400
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:49707)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e5DnZ-0003In-Ok
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:35:57 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 2E08B1461D8
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 18:35:56 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Oct 2017 18:35:38 +0200
Message-Id: <20171019163546.2039-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 0/8] aspeed: add a witherspoon-bmc machine
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

Changes since v5:

 - created the ROM memory region even if there is no file backend
   specified by the user

Changes since v4:

 - use a ROM memory region

Changes since v3:

 - introduce a dummy ROM device to catch invalid writes
 - removed 'ignore_memory_transaction_failures' on all Aspeed machines
 - reworked PCA9552 device :
   . simpler I2C handles
   . auto-increment support
   . unit test

Changes since v2:

 - removed comments on the I2C buffer size pf the PCA9552 device.
 - removed 'ignore_memory_transaction_failures' flag on the
   witherspoon machine.
  =20
Changes since v1:

 - introduced smbus_eeprom_init_one()


C=C3=A9dric Le Goater (8):
  aspeed: use a ROM memory region to catch invalid writes
  aspeed: remove ignore_memory_transaction_failures on all boards
  aspeed: add support for the witherspoon-bmc board
  aspeed: add an I2C RTC device to all machines
  smbus: add a smbus_eeprom_init_one() routine
  aspeed: Add EEPROM I2C devices
  misc: add pca9552 LED blinker model
  aspeed: add the pc9552 chips to the witherspoon machine

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/aspeed.c                 | 139 ++++++++++++++++++---
 hw/i2c/smbus_eeprom.c           |  16 ++-
 hw/misc/Makefile.objs           |   1 +
 hw/misc/pca9552.c               | 259 ++++++++++++++++++++++++++++++++++=
++++++
 include/hw/i2c/smbus.h          |   1 +
 include/hw/misc/pca9552.h       |  33 +++++
 tests/Makefile.include          |   2 +
 tests/pca9552-test.c            | 131 ++++++++++++++++++++
 9 files changed, 560 insertions(+), 23 deletions(-)
 create mode 100644 hw/misc/pca9552.c
 create mode 100644 include/hw/misc/pca9552.h
 create mode 100644 tests/pca9552-test.c

--=20
2.13.6
