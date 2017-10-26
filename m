Received: from eggs.gnu.org ([2001:4830:134:3::10]:55995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e7jIw-0007Gv-EO
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e7jIs-0007dG-AE
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:38:42 -0400
From: Gabriel Costa <gabriel291075@gmail.com>
Date: Thu, 26 Oct 2017 06:34:07 -0400
Message-Id: <1509014053-28134-1-git-send-email-costa@advantech.ca>
Subject: [Qemu-devel] [PATCH v5 0/5]arm: kinetis_k64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, f4bug@amsat.org, Gabriel Augusto Costa <gabriel291075@gmail.com>

From: Gabriel Augusto Costa <gabriel291075@gmail.com>

Hi everyone,

I made a new arm machine with some peripherals.
The machine is mk64fn1m0, a cortex-m4 microcontroller from NXP Kinetis family.
I have prepared a series of patchs to include this machine:

PATCH v5 n/5: It adds the machine and peripherals devices;
PATCH v6: It changes the Makes files to compile this machine.

This machine has been created based on K64P144M120SF5RM.pdf, stellaris and
stm32f205 machines, and reading the code of the other devices. Also, the
comments from community and special thanks to Peter Maydell, Philippe
Mathieu-Daude and Eric Blake.

The initial propose of this machine is execute a simple example, only
with UART0 in polling mode, and gradually adding other devices/peripherals to
this machine to allow execute an operating system like FreeRTOS or MQX.
Next step:
	-Execute an example of UART0 working with interruption.
	-Add a timer with interruption.

The code to test can be generated using MCUXpresso IDE v10.0.2_411, with the
option "Import SDK Examples", selecting "frdmk64f" family, driver_examples,
uart, polling.
The binary file generated is frdmk64f_driver_examples_uart_polling.axf and
can be executed in QEmu with this patch using the following command:
$qemu-system-arm -M mk64fn1m0 -kernel frdmk64f_driver_examples_uart_polling.axf
obs: I can send the file if someone want to test!

History:

PATCH V1: First try. Many errors, the patch is long with code style
	issues, change the files to executable. 
PATCH V2: the same mistakes.

PATCH V3: The patch was splitted in series of patch, without code style
 errors. I receive some tips about QEmu functions and others tips.
PATCH V4: Not send.
	
regards,

Gabriel Augusto Costa (6):
  arm: kinetis_k64_mcg
  arm: kinetis_k64_pmux
  arm: kinetis_k64_system.c
  arm: kinetis_k64_uart
  arm: mk64fn1m0
  arm: Added kinetis k64 platform

 default-configs/arm-softmmu.mak      |   1 +
 hw/arm/Makefile.objs                 |   1 +
 hw/arm/mk64fn1m0.c                   | 136 ++++++++++++++
 hw/char/Makefile.objs                |   1 +
 hw/char/kinetis_k64_uart.c           | 342 +++++++++++++++++++++++++++++++++++
 hw/misc/Makefile.objs                |   3 +
 hw/misc/kinetis_k64_mcg.c            | 208 +++++++++++++++++++++
 hw/misc/kinetis_k64_pmux.c           | 159 ++++++++++++++++
 hw/misc/kinetis_k64_system.c         | 274 ++++++++++++++++++++++++++++
 include/hw/char/kinetis_k64_uart.h   |  79 ++++++++
 include/hw/misc/kinetis_k64_mcg.h    |  43 +++++
 include/hw/misc/kinetis_k64_pmux.h   |  38 ++++
 include/hw/misc/kinetis_k64_system.h |  52 ++++++
 13 files changed, 1337 insertions(+)
 mode change 100644 => 100755 default-configs/arm-softmmu.mak
 mode change 100644 => 100755 hw/arm/Makefile.objs
 create mode 100755 hw/arm/mk64fn1m0.c
 mode change 100644 => 100755 hw/char/Makefile.objs
 create mode 100755 hw/char/kinetis_k64_uart.c
 mode change 100644 => 100755 hw/misc/Makefile.objs
 create mode 100755 hw/misc/kinetis_k64_mcg.c
 create mode 100755 hw/misc/kinetis_k64_pmux.c
 create mode 100755 hw/misc/kinetis_k64_system.c
 create mode 100755 include/hw/char/kinetis_k64_uart.h
 create mode 100755 include/hw/misc/kinetis_k64_mcg.h
 create mode 100755 include/hw/misc/kinetis_k64_pmux.h
 create mode 100755 include/hw/misc/kinetis_k64_system.h

-- 
2.1.4
