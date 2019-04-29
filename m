Received: from eggs.gnu.org ([209.51.188.92]:52426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyu9-0006H3-8I
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyu8-00055P-Ck
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:32:41 -0400
Received: from mail-oln040092253104.outbound.protection.outlook.com
	([40.92.253.104]:39646
	helo=APC01-SG2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hKyu8-000541-33
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:32:40 -0400
From: Alistair Francis <alistair@alistair23.me>
Date: Mon, 29 Apr 2019 05:32:31 +0000
Message-ID: <PSXP216MB02773138677F519BAFADB522DD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 0/5] Add the STM32F405 and Netduino Plus 2
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>


Now that the Arm-M4 CPU has been added to QEMU we can add the Netduino
Plus 2 machine. This is very similar to the STM32F205 and Netduino 2 SoC
and machine.


Alistair Francis (5):
  armv7m: Allow entry information to be returned
  hw/misc: Add the STM32F4xx Sysconfig device
  hw/misc: Add the STM32F4xx EXTI device
  hw/arm: Add the STM32F4xx SoC
  hw/arm: Add the Netduino Plus 2

 MAINTAINERS                        |  14 ++
 default-configs/arm-softmmu.mak    |   4 +
 hw/arm/Kconfig                     |   6 +
 hw/arm/Makefile.objs               |   2 +
 hw/arm/armv7m.c                    |   6 +-
 hw/arm/microbit.c                  |   2 +-
 hw/arm/mps2-tz.c                   |   3 +-
 hw/arm/mps2.c                      |   2 +-
 hw/arm/msf2-som.c                  |   2 +-
 hw/arm/musca.c                     |   3 +-
 hw/arm/netduino2.c                 |   2 +-
 hw/arm/netduinoplus2.c             |  77 ++++++++
 hw/arm/stellaris.c                 |   3 +-
 hw/arm/stm32f405_soc.c             | 292 +++++++++++++++++++++++++++++
 hw/misc/Kconfig                    |   6 +
 hw/misc/Makefile.objs              |   2 +
 hw/misc/stm32f4xx_exti.c           | 175 +++++++++++++++++
 hw/misc/stm32f4xx_syscfg.c         | 275 +++++++++++++++++++++++++++
 include/hw/arm/arm.h               |   4 +-
 include/hw/arm/stm32f405_soc.h     |  70 +++++++
 include/hw/misc/stm32f4xx_exti.h   |  57 ++++++
 include/hw/misc/stm32f4xx_syscfg.h |  62 ++++++
 22 files changed, 1058 insertions(+), 11 deletions(-)
 create mode 100644 hw/arm/netduinoplus2.c
 create mode 100644 hw/arm/stm32f405_soc.c
 create mode 100644 hw/misc/stm32f4xx_exti.c
 create mode 100644 hw/misc/stm32f4xx_syscfg.c
 create mode 100644 include/hw/arm/stm32f405_soc.h
 create mode 100644 include/hw/misc/stm32f4xx_exti.h
 create mode 100644 include/hw/misc/stm32f4xx_syscfg.h

--=20
2.21.0
