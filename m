Received: from eggs.gnu.org ([2001:4830:134:3::10]:39878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5E6j-0001Z5-5i
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5E6f-00011n-8T
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:55:45 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:44585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gabriel291075@gmail.com>)
	id 1e5E6f-00011W-3f
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:55:41 -0400
Received: by mail-qk0-x241.google.com with SMTP id r64so11176170qkc.1
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 09:55:40 -0700 (PDT)
From: gabriel291075@gmail.com
Date: Thu, 19 Oct 2017 08:51:25 -0400
Message-Id: <1508417485-31911-1-git-send-email-gabriel291075@gmail.com>
Subject: [Qemu-devel] [PATCH v2] arm: Adding makefile for Kinetis K64
 MK64FN1M0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gabriel Augusto Costa <gabriel291075@gmail.com>

From: Gabriel Augusto Costa <gabriel291075@gmail.com>

I add a new arm machine with some peripherals. The machine is mk64fn1m0, a 
cortex-m4 microcontroller from NXP Kinetis family. The machine can run a 
simple arm binary file using UART0 in polling mode.
I prepared two patchs to include this machine:
PATCH v1: Include the machine and peripherals devices;
PATCH v2: Change the make file to compile this machine.
Also, I made a folder tree to accomodate this machine more or less like u-boot.
In my opinion put all files in the same folder "/hw/arm" is not a good idea, 
or put all code in an unique file, because machines from the same family 
sharing the same peripherals.
The folder tree struct is machine/family/peripheral, as an example:
kinetis/k64/peripheral.
So, in this way the code will be more maintainable.  

Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
---
 hw/arm/Makefile.objs | 4 ++++
 1 file changed, 4 insertions(+)
 mode change 100644 => 100755 hw/arm/Makefile.objs

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
old mode 100644
new mode 100755
index 2794e08..650a0af
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -20,3 +20,7 @@ obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
 obj-$(CONFIG_MPS2) += mps2.o
 obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
+obj-y += kinetis/k64/mk64fn1m0.o kinetis/k64/peripheral/mcg.o \
+	kinetis/k64/peripheral/sim.o kinetis/k64/peripheral/pmux.o \
+	kinetis/k64/peripheral/uart.o kinetis/k64/peripheral/flextimer.o
+	
-- 
2.1.4
