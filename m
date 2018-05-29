Received: from eggs.gnu.org ([2001:4830:134:3::10]:41845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fNmjB-0007G4-N9
	for qemu-devel@nongnu.org; Tue, 29 May 2018 18:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fNmj8-0007nI-KU
	for qemu-devel@nongnu.org; Tue, 29 May 2018 18:04:25 -0400
Received: from smtp18.mail.ru ([94.100.176.155]:38608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fNmj8-0007mM-8o
	for qemu-devel@nongnu.org; Tue, 29 May 2018 18:04:22 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Wed, 30 May 2018 01:03:35 +0300
Message-Id: <20180529220338.10879-1-jusual@mail.ru>
Subject: [Qemu-devel] [RFC 0/3] nRF51 SoC: Add UART support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

This series adds basic support for the nRF51 SoC UART, that used in
BBC Micro:bit board, and QTest for it.

Based-on: <20180503090532.3113-1-joel@jms.id.au>

Julia Suvorova (3):
  hw/arm/nrf51_soc: Fix compilation and memory regions
  hw/char/nrf51_uart: Implement nRF51 SoC UART
  tests/boot-serial-test: Add support for the microbit board

 hw/arm/nrf51_soc.c           |  19 ++-
 hw/char/Makefile.objs        |   1 +
 hw/char/nrf51_uart.c         | 232 +++++++++++++++++++++++++++++++++++
 include/hw/arm/nrf51_soc.h   |   2 +
 include/hw/char/nrf51_uart.h |  54 ++++++++
 tests/boot-serial-test.c     |  11 ++
 6 files changed, 314 insertions(+), 5 deletions(-)
 create mode 100644 hw/char/nrf51_uart.c
 create mode 100644 include/hw/char/nrf51_uart.h

-- 
2.17.0
