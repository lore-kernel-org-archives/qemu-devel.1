Received: from eggs.gnu.org ([2001:4830:134:3::10]:34639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNunT-0002BK-95
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNunP-00014M-Be
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:41:23 -0400
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:44308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNunP-00011h-52
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:41:19 -0400
Received: from player159.ha.ovh.net (unknown [10.109.122.81])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 76091C1CE7
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 08:41:08 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 30 May 2018 08:40:42 +0200
Message-Id: <20180530064049.27976-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 0/7] aspeed: add a witherspoon-bmc machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello

This series adds a new Aspeed machine to emulate the BMC of a
Witherspoon system. It also extends the other Aspeed machines with I2C
devices and adds a simple model for the pca9552 LED blinker present on
the Witherspoon board.

Thanks,

C.

Changes since v6:

 - removed code duplication in the pca9552 test
 - removed the ROM memory region catching invalid writes

C=C3=A9dric Le Goater (7):
  aspeed: remove ignore_memory_transaction_failures on all boards
  aspeed: add support for the witherspoon-bmc board
  aspeed: add an I2C RTC device to all machines
  smbus: add a smbus_eeprom_init_one() routine
  aspeed: Add EEPROM I2C devices
  misc: add pca9552 LED blinker model
  aspeed: add the pc9552 chips to the witherspoon machine

 default-configs/arm-softmmu.mak |   1 +
 include/hw/i2c/smbus.h          |   1 +
 include/hw/misc/pca9552.h       |  32 ++++++
 include/hw/misc/pca9552_regs.h  |  32 ++++++
 tests/libqos/i2c.h              |   2 +
 hw/arm/aspeed.c                 |  88 ++++++++++++++-
 hw/i2c/smbus_eeprom.c           |  16 ++-
 hw/misc/pca9552.c               | 240 ++++++++++++++++++++++++++++++++++=
++++++
 tests/pca9552-test.c            | 116 +++++++++++++++++++
 tests/tmp105-test.c             |   2 -
 hw/misc/Makefile.objs           |   1 +
 tests/Makefile.include          |   2 +
 12 files changed, 523 insertions(+), 10 deletions(-)
 create mode 100644 include/hw/misc/pca9552.h
 create mode 100644 include/hw/misc/pca9552_regs.h
 create mode 100644 hw/misc/pca9552.c
 create mode 100644 tests/pca9552-test.c

--=20
2.13.6
