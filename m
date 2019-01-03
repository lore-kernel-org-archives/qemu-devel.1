Received: from eggs.gnu.org ([208.118.235.92]:51751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gez3V-0003HG-Hy
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:12:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gez3U-0006Ts-O1
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:12:45 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  3 Jan 2019 09:11:08 +0000
Message-Id: <20190103091119.9367-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/11] arm: Core nRF51 Devices and Microbit
 Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Steffen has been busy so I picked up "[PATCH v5 00/14] arm: nRF51 Devices=
 and
Microbit Support".  This series includes the core devices needed to boot =
basic
guest software on the "microbit" board.

This series includes Steffen's random number generator, GPIO, timer, and =
a
stubbed clock.  Also, this series adds the tests/microbit-test.c qtest.

Changes from Steffen's series:
 * Made timer tickless [Peter]
 * Dropped non-volatile memory controller.  More work is needed there and=
 I
   don't want to hold back other devices in this series that are ready fo=
r
   merge.
 * Rebased and re-tested with make check and real micro:bit programs
   (requires out-of-tree -kernel and stub TWI device patches)

Steffen G=C3=B6rtz (11):
  qtest: Add set_irq_in command to set IRQ/GPIO level
  arm: Add header to host common definition for nRF51 SOC peripherals
  hw/misc/nrf51_rng: Add NRF51 random number generator peripheral
  arm: Instantiate NRF51 random number generator
  hw/gpio/nrf51_gpio: Add nRF51 GPIO peripheral
  arm: Instantiate NRF51 general purpose I/O
  tests/microbit-test: Add Tests for nRF51 GPIO
  hw/timer/nrf51_timer: Add nRF51 Timer peripheral
  arm: Instantiate NRF51 Timers
  tests/microbit-test: Add Tests for nRF51 Timer
  arm: Add Clock peripheral stub to NRF51 SOC

 Makefile.objs                  |   1 +
 hw/gpio/Makefile.objs          |   1 +
 hw/misc/Makefile.objs          |   1 +
 hw/timer/Makefile.objs         |   1 +
 tests/Makefile.include         |   2 +
 include/hw/arm/nrf51.h         |  45 ++++
 include/hw/arm/nrf51_soc.h     |   9 +
 include/hw/char/nrf51_uart.h   |   1 -
 include/hw/gpio/nrf51_gpio.h   |  69 ++++++
 include/hw/misc/nrf51_rng.h    |  83 +++++++
 include/hw/timer/nrf51_timer.h |  80 +++++++
 tests/libqtest.h               |  13 ++
 hw/arm/nrf51_soc.c             | 117 ++++++++--
 hw/gpio/nrf51_gpio.c           | 300 +++++++++++++++++++++++++
 hw/misc/nrf51_rng.c            | 262 ++++++++++++++++++++++
 hw/timer/nrf51_timer.c         | 393 +++++++++++++++++++++++++++++++++
 qtest.c                        |  43 ++++
 tests/libqtest.c               |  10 +
 tests/microbit-test.c          | 255 +++++++++++++++++++++
 hw/gpio/trace-events           |   7 +
 hw/timer/trace-events          |   5 +
 21 files changed, 1676 insertions(+), 22 deletions(-)
 create mode 100644 include/hw/arm/nrf51.h
 create mode 100644 include/hw/gpio/nrf51_gpio.h
 create mode 100644 include/hw/misc/nrf51_rng.h
 create mode 100644 include/hw/timer/nrf51_timer.h
 create mode 100644 hw/gpio/nrf51_gpio.c
 create mode 100644 hw/misc/nrf51_rng.c
 create mode 100644 hw/timer/nrf51_timer.c
 create mode 100644 tests/microbit-test.c
 create mode 100644 hw/gpio/trace-events

--=20
2.19.2
