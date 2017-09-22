Received: from eggs.gnu.org ([2001:4830:134:3::10]:51562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQOh-00067s-GZ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQOf-0008Ox-Pv
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:01:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 13:01:02 -0300
Message-Id: <20170922160111.31885-3-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 25/34] hw/timer/m48t59: use TYPE_M48T59_ISA,
 add entries to MAINTAINERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/m48t59.h | 2 ++
 hw/ppc/prep.c             | 2 +-
 hw/timer/m48t59-isa.c     | 2 +-
 MAINTAINERS               | 2 ++
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/timer/m48t59.h b/include/hw/timer/m48t59.h
index db5e43a8da..069bb045d7 100644
--- a/include/hw/timer/m48t59.h
+++ b/include/hw/timer/m48t59.h
@@ -25,6 +25,8 @@ typedef struct NvramClass {
     void (*toggle_lock)(Nvram *obj, int lock);
 } NvramClass;
 
+#define TYPE_M48T59_ISA "isa-m48t59"
+
 Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
                        int base_year, int type);
 Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 16f4537093..1f8ef4819b 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -777,7 +777,7 @@ static void ibm_40p_init(MachineState *machine)
     /* add some more devices */
     if (defaults_enabled()) {
         isa_create_simple(isa_bus, TYPE_I8042);
-        m48t59 = NVRAM(isa_create_simple(isa_bus, "isa-m48t59"));
+        m48t59 = NVRAM(isa_create_simple(isa_bus, TYPE_M48T59_ISA));
 
         dev = DEVICE(isa_create(isa_bus, "cs4231a"));
         qdev_prop_set_uint32(dev, "iobase", 0x830);
diff --git a/hw/timer/m48t59-isa.c b/hw/timer/m48t59-isa.c
index ea1ba703d7..077346f7ca 100644
--- a/hw/timer/m48t59-isa.c
+++ b/hw/timer/m48t59-isa.c
@@ -49,7 +49,7 @@ typedef struct M48txxISADeviceClass {
 
 static M48txxInfo m48txx_isa_info[] = {
     {
-        .bus_name = "isa-m48t59",
+        .bus_name = TYPE_M48T59_ISA,
         .model = 59,
         .size = 0x2000,
     }
diff --git a/MAINTAINERS b/MAINTAINERS
index a79723601c..3cb6bc190c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -708,6 +708,8 @@ F: hw/pci-host/prep.[hc]
 F: hw/isa/i82378.c
 F: hw/isa/pc87312.[hc]
 F: hw/dma/i82374.c
+F: hw/timer/m48t59-isa.c
+F: include/hw/timer/m48t59.h
 F: pc-bios/ppc_rom.bin
 
 sPAPR
-- 
2.14.1
