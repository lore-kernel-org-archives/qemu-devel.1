Received: from eggs.gnu.org ([2001:4830:134:3::10]:52238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clement.deschamps@antfield.fr>) id 1cgV1V-0001zv-K5
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clement.deschamps@antfield.fr>) id 1cgV1U-0006Pq-Rs
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:23:53 -0500
From: Clement Deschamps <clement.deschamps@antfield.fr>
Date: Wed, 22 Feb 2017 12:23:35 +0100
Message-Id: <20170222112338.25492-1-clement.deschamps@antfield.fr>
Subject: [Qemu-devel] [PATCH v2 0/3] add sdhost and gpio controllers to the
 bcm2835 platform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org, peter.maydell@linaro.org, andrew.baumann@microsoft.com

This patches add the Arasan SDHost controller and the GPIO controller to the BCM2835/36 platforms.

This patches have been tested with raspbian 2015-09-24 (which uses the SDHCI controller),
and raspbian 2017-01-11 (which dynamically switches to the SDHost controller).

Note: In order to properly boot the kernel, you will first need to apply the
BCM2835 hardware RNG patch submitted recently.

v2:
- implements the GPIO controller for supporting SD controller selection via alternate functions of GPIOs 48-53

Clement Deschamps (3):
  bcm2835_sdhost: add bcm2835 sdhost controller
  bcm2835_gpio: add bcm2835 gpio controller
  bcm2835: add sdhost and gpio controllers

 hw/arm/bcm2835_peripherals.c         |  44 ++++
 hw/gpio/Makefile.objs                |   1 +
 hw/gpio/bcm2835_gpio.c               | 361 +++++++++++++++++++++++++++++
 hw/sd/Makefile.objs                  |   1 +
 hw/sd/bcm2835_sdhost.c               | 429 +++++++++++++++++++++++++++++++++++
 include/hw/arm/bcm2835_peripherals.h |   4 +
 include/hw/gpio/bcm2835_gpio.h       |  38 ++++
 include/hw/sd/bcm2835_sdhost.h       |  48 ++++
 8 files changed, 926 insertions(+)
 create mode 100644 hw/gpio/bcm2835_gpio.c
 create mode 100644 hw/sd/bcm2835_sdhost.c
 create mode 100644 include/hw/gpio/bcm2835_gpio.h
 create mode 100644 include/hw/sd/bcm2835_sdhost.h

-- 
2.11.1
