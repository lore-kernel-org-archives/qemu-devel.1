Received: from eggs.gnu.org ([2001:4830:134:3::10]:41576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1erL2y-00028x-Ng
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1erL2t-000263-TJ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:02:44 -0500
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Thu,  1 Mar 2018 11:02:16 +0100
Message-Id: <1519898536-19027-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH] grlib_apbuart: always enable tx and rx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcd@tribudubois.net, chouteau@adacore.com, mark.cave-ayland@ilande.co.uk, qemu-trivial@nongnu.org, frederic.konrad@adacore.com

We often use a bootloader for this board. So lets set the uart in a state
which it can emit characters as if we were using a bootloader.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 hw/char/grlib_apbuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index bac11be..a8020ea 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -265,8 +265,8 @@ static void grlib_apbuart_reset(DeviceState *d)
 
     /* Transmitter FIFO and shift registers are always empty in QEMU */
     uart->status =  UART_TRANSMIT_FIFO_EMPTY | UART_TRANSMIT_SHIFT_EMPTY;
-    /* Everything is off */
-    uart->control = 0;
+    /* Enable Tx and Rx as the bootloader would do */
+    uart->control = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE;
     /* Flush receive FIFO */
     uart->len = 0;
     uart->current = 0;
-- 
1.8.3.1
