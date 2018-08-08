Received: from eggs.gnu.org ([2001:4830:134:3::10]:49773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fnVhS-0003A5-3h
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 17:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fnVhN-0006bh-1w
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 17:08:58 -0400
Received: from smtp20.mail.ru ([94.100.179.251]:32832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fnVhM-0006am-Mq
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 17:08:52 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Thu,  9 Aug 2018 00:07:46 +0300
Message-Id: <20180808210750.3915-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v2 0/4] arm: Add nRF51 SoC UART support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

This series adds support for the nRF51 SoC UART, that used in
BBC Micro:bit board, and QTest for it.

v2:
    * Suspend/Enable functionality added
    * Connection to SoC moved to a separate patch
    * Added QTest for checking reception functionality
    * Mini-kernel test changed to fit current implementation
    * Addressed review comments on R_*, uart_can_receive, VMState,
      uart_transmit

Julia Suvorova (4):
  hw/char: Implement nRF51 SoC UART
  hw/arm/nrf51_soc: Connect UART to nRF51 SoC
  tests/boot-serial-test: Add microbit board testcase
  tests/microbit-test: Check nRF51 UART functionality

 hw/arm/nrf51_soc.c           |  20 +++
 hw/char/Makefile.objs        |   1 +
 hw/char/nrf51_uart.c         | 329 +++++++++++++++++++++++++++++++++++
 hw/char/trace-events         |   4 +
 include/hw/arm/nrf51_soc.h   |   3 +
 include/hw/char/nrf51_uart.h |  78 +++++++++
 tests/boot-serial-test.c     |  19 ++
 tests/microbit-test.c        | 106 ++++++++++-
 8 files changed, 557 insertions(+), 3 deletions(-)
 create mode 100644 hw/char/nrf51_uart.c
 create mode 100644 include/hw/char/nrf51_uart.h

-- 
2.17.1
