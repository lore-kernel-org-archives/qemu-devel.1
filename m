Received: from eggs.gnu.org ([2001:4830:134:3::10]:38316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gHWD9-0003OO-QS
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gHWD5-0005NR-Aq
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:45:43 -0400
Received: from steffen-goertz.de ([88.198.119.201]:60102)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gHWD3-0004eh-DW
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:45:37 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Tue, 30 Oct 2018 11:45:01 -0400
Message-Id: <20181030154510.29868-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/8] arm: nRF51 Devices and Microbit Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

This series contains additional peripheral devices for the nRF51822
microcontroller.=20

Included devices:
- Random Number Generator
- Non-volatile Memories
- General purpose I/O
- Timer=20

Instantiate of the devices is done in an upcoming patch series.

v2:
    * Factored out common definitions to won header (Stefan)
    * Add set_irq_in command to support tests for GPIO
    * Add tests for GPIO
    * Removed LED matrix from this patch set
    * Small tidy ups on RNG, NVM, GPIO and Timer

Steffen G=C3=B6rtz (8):
  qtest: Add set_irq_in command to set IRQ/GPIO level
  arm: Add header to hosts common definition for nRF51 SOC peripherals
  hw/misc/nrf51_rng: Add NRF51 random number generator peripheral
  hw/nvram/nrf51_nvm: Add nRF51 non-volatile memories
  tests: Add bbc:microbit / nRF51 test suite
  hw/gpio/nrf51_gpio: Add nRF51 GPIO peripheral
  tests/microbit-test: Add Tests for nRF51 GPIO
  hw/timer/nrf51_timer: Add nRF51 Timer peripheral

 Makefile.objs                  |   1 +
 hw/gpio/Makefile.objs          |   1 +
 hw/gpio/nrf51_gpio.c           | 292 +++++++++++++++++++++++++++
 hw/gpio/trace-events           |   7 +
 hw/misc/Makefile.objs          |   1 +
 hw/misc/nrf51_rng.c            | 262 ++++++++++++++++++++++++
 hw/nvram/Makefile.objs         |   1 +
 hw/nvram/nrf51_nvm.c           | 339 +++++++++++++++++++++++++++++++
 hw/timer/Makefile.objs         |   1 +
 hw/timer/nrf51_timer.c         | 358 +++++++++++++++++++++++++++++++++
 hw/timer/trace-events          |   5 +
 include/hw/arm/nrf51.h         |  40 ++++
 include/hw/gpio/nrf51_gpio.h   |  69 +++++++
 include/hw/misc/nrf51_rng.h    |  83 ++++++++
 include/hw/nvram/nrf51_nvm.h   |  73 +++++++
 include/hw/timer/nrf51_timer.h |  77 +++++++
 qtest.c                        |  40 ++++
 tests/Makefile.include         |   2 +
 tests/libqtest.c               |  10 +
 tests/libqtest.h               |  28 +++
 tests/microbit-test.c          | 239 ++++++++++++++++++++++
 21 files changed, 1929 insertions(+)
 create mode 100644 hw/gpio/nrf51_gpio.c
 create mode 100644 hw/gpio/trace-events
 create mode 100644 hw/misc/nrf51_rng.c
 create mode 100644 hw/nvram/nrf51_nvm.c
 create mode 100644 hw/timer/nrf51_timer.c
 create mode 100644 include/hw/arm/nrf51.h
 create mode 100644 include/hw/gpio/nrf51_gpio.h
 create mode 100644 include/hw/misc/nrf51_rng.h
 create mode 100644 include/hw/nvram/nrf51_nvm.h
 create mode 100644 include/hw/timer/nrf51_timer.h
 create mode 100644 tests/microbit-test.c

--=20
2.19.1
