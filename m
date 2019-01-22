Received: from eggs.gnu.org ([209.51.188.92]:34167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gm1Pw-0005lS-RG
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:09:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gm1Pv-0000xj-KV
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:09:00 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:38835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1gm1Pv-0000ZY-CS
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:08:59 -0500
Received: by mail-pl1-x62a.google.com with SMTP id e5so11927289plb.5
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:08:28 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 22 Jan 2019 04:20:47 -0800
Message-Id: <20190122122048.10845-3-edgar.iglesias@gmail.com>
In-Reply-To: <20190122122048.10845-1-edgar.iglesias@gmail.com>
References: <20190122122048.10845-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v1 2/3] hw/microblaze: s3adsp1800: Create an
 unimplemented GPIO area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Create an unimplemented GPIO area instead of leaving it unassigned.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 5cf7b84c79..b9f0b0d06e 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -35,6 +35,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/devices.h"
 #include "hw/boards.h"
+#include "hw/misc/unimp.h"
 #include "exec/address-spaces.h"
 #include "hw/char/xilinx_uartlite.h"
 
@@ -47,6 +48,7 @@
 
 #define MEMORY_BASEADDR 0x90000000
 #define FLASH_BASEADDR 0xa0000000
+#define GPIO_BASEADDR 0x81400000
 #define INTC_BASEADDR 0x81800000
 #define TIMER_BASEADDR 0x83c00000
 #define UARTLITE_BASEADDR 0x84000000
@@ -122,6 +124,8 @@ petalogix_s3adsp1800_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
 
+    create_unimplemented_device("gpio", GPIO_BASEADDR, 0x10000);
+
     microblaze_load_kernel(cpu, ddr_base, ram_size,
                            machine->initrd_filename,
                            BINARY_DEVICE_TREE_FILE,
-- 
2.19.1
