Received: from eggs.gnu.org ([2001:4830:134:3::10]:57457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gFTrv-0000X7-AR
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gFTrq-0000ur-89
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:51:23 -0400
Received: from smtp36.i.mail.ru ([94.100.177.96]:43048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gFTrp-0000pg-Dx
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:51:17 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Thu, 25 Oct 2018 03:50:49 +0300
Message-Id: <20181025005052.27661-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v3 0/3] arm: Add nRF51 SoC UART support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Thomas Huth <thuth@redhat.com>, Julia Suvorova <jusual@mail.ru>

This series adds support for the nRF51 SoC UART, that used in
BBC Micro:bit board, and QTest for it.

v3:
    * serial_hd() moved to the board code
    * sysbus_init_child_obj() used for initialization
    * qemu_chr_fe_accept_input() called after byte popping

v2:
    * Suspend/Enable functionality added
    * Connection to SoC moved to a separate patch
    * Added QTest for checking reception functionality
    * Mini-kernel test changed to fit current implementation
    * Addressed review comments on R_*, uart_can_receive, VMState,
      uart_transmit

Julia Suvorova (3):
  hw/char: Implement nRF51 SoC UART
  hw/arm/nrf51_soc: Connect UART to nRF51 SoC
  tests/boot-serial-test: Add microbit board testcase

 hw/arm/microbit.c            |   2 +
 hw/arm/nrf51_soc.c           |  20 +++
 hw/char/Makefile.objs        |   1 +
 hw/char/nrf51_uart.c         | 330 +++++++++++++++++++++++++++++++++++
 hw/char/trace-events         |   4 +
 include/hw/arm/nrf51_soc.h   |   3 +
 include/hw/char/nrf51_uart.h |  78 +++++++++
 tests/boot-serial-test.c     |  19 ++
 8 files changed, 457 insertions(+)
 create mode 100644 hw/char/nrf51_uart.c
 create mode 100644 include/hw/char/nrf51_uart.h

-- 
2.17.1
