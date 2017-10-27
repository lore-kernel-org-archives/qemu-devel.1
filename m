Received: from eggs.gnu.org ([2001:4830:134:3::10]:48885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e87Uz-0006p4-4C
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e87Uv-000330-TP
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:28:45 -0400
From: Gabriel Costa <gabriel291075@gmail.com>
Date: Fri, 27 Oct 2017 08:24:10 -0400
Message-Id: <1509107055-21978-1-git-send-email-costa@advantech.ca>
Subject: [Qemu-devel]  [PATCH v7 0/5] arm: kinetis_mk64fn1m0 machine
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

PATCH V5: Change the 0x%02X to HWADDR_PRIx on qemu_log_mask and added
	.valid.min_access_size and .valid.max_access_size
PATCH v6: misunderstood the process to add a new model, next patch will
	include the changes in the Makefile in the same patch version.
	
regards,

Gabriel Costa (5):
  arm: kinetis_k64_uart
  arm: kinetis_k64_mcg
  arm: kinetis_k64_pmux
  arm: kinetis_k64_system
  arm: kinetis_mk64fn1m0 machine

 default-configs/arm-softmmu.mak      |   1 +
 hw/arm/Makefile.objs                 |   1 +
 hw/arm/mk64fn1m0.c                   | 136 ++++++++++++++
 hw/char/Makefile.objs                |   1 +
 hw/char/kinetis_k64_uart.c           | 343 +++++++++++++++++++++++++++++++++++
 hw/misc/Makefile.objs                |   3 +
 hw/misc/kinetis_k64_mcg.c            | 208 +++++++++++++++++++++
 hw/misc/kinetis_k64_pmux.c           | 158 ++++++++++++++++
 hw/misc/kinetis_k64_system.c         | 274 ++++++++++++++++++++++++++++
 include/hw/char/kinetis_k64_uart.h   |  79 ++++++++
 include/hw/misc/kinetis_k64_mcg.h    |  43 +++++
 include/hw/misc/kinetis_k64_pmux.h   |  38 ++++
 include/hw/misc/kinetis_k64_system.h |  52 ++++++
 13 files changed, 1337 insertions(+)
 create mode 100644 hw/arm/mk64fn1m0.c
 create mode 100644 hw/char/kinetis_k64_uart.c
 create mode 100644 hw/misc/kinetis_k64_mcg.c
 create mode 100644 hw/misc/kinetis_k64_pmux.c
 create mode 100644 hw/misc/kinetis_k64_system.c
 create mode 100644 include/hw/char/kinetis_k64_uart.h
 create mode 100644 include/hw/misc/kinetis_k64_mcg.h
 create mode 100644 include/hw/misc/kinetis_k64_pmux.h
 create mode 100644 include/hw/misc/kinetis_k64_system.h

-- 
2.1.4
