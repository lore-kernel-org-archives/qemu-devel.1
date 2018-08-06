Received: from eggs.gnu.org ([2001:4830:134:3::10]:38594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKJ-00022y-J8
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKG-0003Cs-HX
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:23 -0400
Received: from steffen-goertz.de ([88.198.119.201]:33106)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKG-0003C9-Am
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:20 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Mon,  6 Aug 2018 12:01:07 +0200
Message-Id: <20180806100114.21410-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/7] arm: nRF51 Devices and Microbit Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

This series contains additional peripheral devices for the nRF51822
microcontroller. Furthermore it includes a device to demultiplex
the row and column strobes used in embedded devices to drive
2D LED dot-matrices.

Included devices:
- Random Number Generator
- Non-volatile Memories
- General purpose I/O
- Timer=20

Microbit board-level Devices:
- LED Matrix

Instantiate of the devices is done in an upcoming patch series.

Based-on: 20180726023645.13927-1-joel@jms.id.au

Steffen G=C3=B6rtz (7):
  hw/misc/nrf51_rng: Add NRF51 random number generator peripheral
  hw/nvram/nrf51_nvm: Add nRF51 non-volatile memories
  tests: Add bbc:microbit / nRF51 test suite
  hw/gpio/nrf51_gpio: Add nRF51 GPIO peripheral
  tests/microbit-test: Add Tests for nRF51 GPIO
  hw/timer/nrf51_timer: Add nRF51 Timer peripheral
  hw/display/led_matrix: Add LED matrix display device

 Makefile.objs                   |   1 +
 hw/display/Makefile.objs        |   2 +
 hw/display/led_matrix.c         | 262 +++++++++++++++++++++
 hw/gpio/Makefile.objs           |   1 +
 hw/gpio/nrf51_gpio.c            | 305 +++++++++++++++++++++++++
 hw/gpio/trace-events            |   7 +
 hw/misc/Makefile.objs           |   1 +
 hw/misc/nrf51_rng.c             | 273 ++++++++++++++++++++++
 hw/nvram/Makefile.objs          |   1 +
 hw/nvram/nrf51_nvm.c            | 390 ++++++++++++++++++++++++++++++++
 hw/timer/Makefile.objs          |   1 +
 hw/timer/nrf51_timer.c          | 382 +++++++++++++++++++++++++++++++
 hw/timer/trace-events           |   5 +
 include/hw/display/led_matrix.h |  38 ++++
 include/hw/gpio/nrf51_gpio.h    |  57 +++++
 include/hw/misc/nrf51_rng.h     |  71 ++++++
 include/hw/nvram/nrf51_nvm.h    |  56 +++++
 include/hw/timer/nrf51_timer.h  |  63 ++++++
 tests/Makefile.include          |   2 +
 tests/microbit-test.c           | 222 ++++++++++++++++++
 20 files changed, 2140 insertions(+)
 create mode 100644 hw/display/led_matrix.c
 create mode 100644 hw/gpio/nrf51_gpio.c
 create mode 100644 hw/gpio/trace-events
 create mode 100644 hw/misc/nrf51_rng.c
 create mode 100644 hw/nvram/nrf51_nvm.c
 create mode 100644 hw/timer/nrf51_timer.c
 create mode 100644 include/hw/display/led_matrix.h
 create mode 100644 include/hw/gpio/nrf51_gpio.h
 create mode 100644 include/hw/misc/nrf51_rng.h
 create mode 100644 include/hw/nvram/nrf51_nvm.h
 create mode 100644 include/hw/timer/nrf51_timer.h
 create mode 100644 tests/microbit-test.c

--=20
2.18.0
