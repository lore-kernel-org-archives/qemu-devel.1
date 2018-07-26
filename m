Received: from eggs.gnu.org ([2001:4830:134:3::10]:53336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fiW9L-0005bn-2R
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 22:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fiW9I-0002xE-3Z
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 22:37:07 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 26 Jul 2018 12:06:42 +0930
Message-Id: <20180726023645.13927-1-joel@jms.id.au>
Subject: [Qemu-devel] [PATCH v3 0/3] arm: Add nRF51 SoC and micro:bit machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

v3: Rebase on Stefan's cortex-m0 series
Based-on: 20180725085944.11856-8-stefanha@redhat.com

This short series implements a minimal definition of the Nordic
Semiconductor nRF51, a Cortex-M0 ARM SoC, and the BBC micro:bit, a
machine that will use this SoC.

This work will serve as the base for our Google Summer of Code and
Outreachy interns who will work on implementing a number of features on
top of this base.

I've tested this with a microbit micropython firmware, and checked that
it starts running by looking at it with gdb.

I chose to keep the nrf51 and the microbit seperate, to not confuse the
peripherals that are on the microbit but are not part of the nrf51, and
vice versa.


Joel Stanley (3):
  MAINTAINERS: Add NRF51 entry
  arm: Add Nordic Semiconductor nRF51 SoC
  arm: Add BBC micro:bit machine

 MAINTAINERS                     |   8 +++
 default-configs/arm-softmmu.mak |   1 +
 hw/arm/Makefile.objs            |   1 +
 hw/arm/microbit.c               |  54 +++++++++++++++
 hw/arm/nrf51_soc.c              | 119 ++++++++++++++++++++++++++++++++
 include/hw/arm/nrf51_soc.h      |  42 +++++++++++
 6 files changed, 225 insertions(+)
 create mode 100644 hw/arm/microbit.c
 create mode 100644 hw/arm/nrf51_soc.c
 create mode 100644 include/hw/arm/nrf51_soc.h

-- 
2.17.1
