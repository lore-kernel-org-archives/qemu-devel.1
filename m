Received: from eggs.gnu.org ([2001:4830:134:3::10]:43522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPV-0006Tl-E1
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPQ-0007sm-9z
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f9XPP-0007mN-JU
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:08 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:52:43 +0100
Message-Id: <20180420145249.32435-8-peter.maydell@linaro.org>
In-Reply-To: <20180420145249.32435-1-peter.maydell@linaro.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 07/13] Change references to serial_hds[] to
 serial_hd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Change all the uses of serial_hds[] to go via the new
serial_hd() function. Code change produced with:
 find hw -name '*.[ch]' | xargs sed -i -e 's/serial_hds\[\([^]]*\)\]/serial_hd(\1)/g'

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/allwinner-a10.c                   |  4 ++--
 hw/arm/aspeed_soc.c                      |  4 ++--
 hw/arm/bcm2835_peripherals.c             |  4 ++--
 hw/arm/digic.c                           |  2 +-
 hw/arm/fsl-imx25.c                       |  2 +-
 hw/arm/fsl-imx31.c                       |  2 +-
 hw/arm/fsl-imx6.c                        |  4 ++--
 hw/arm/fsl-imx7.c                        |  2 +-
 hw/arm/highbank.c                        |  2 +-
 hw/arm/integratorcp.c                    |  4 ++--
 hw/arm/kzm.c                             |  4 ++--
 hw/arm/mps2-tz.c                         |  2 +-
 hw/arm/mps2.c                            |  4 ++--
 hw/arm/msf2-soc.c                        |  4 ++--
 hw/arm/musicpal.c                        |  8 ++++----
 hw/arm/omap1.c                           |  6 +++---
 hw/arm/omap2.c                           | 10 +++++-----
 hw/arm/pxa2xx.c                          | 16 ++++++++--------
 hw/arm/realview.c                        |  8 ++++----
 hw/arm/stellaris.c                       |  2 +-
 hw/arm/stm32f205_soc.c                   |  2 +-
 hw/arm/strongarm.c                       |  2 +-
 hw/arm/versatilepb.c                     |  8 ++++----
 hw/arm/vexpress.c                        |  8 ++++----
 hw/arm/virt.c                            |  4 ++--
 hw/arm/xilinx_zynq.c                     |  4 ++--
 hw/arm/xlnx-zynqmp.c                     |  2 +-
 hw/char/exynos4210_uart.c                |  2 +-
 hw/char/serial-isa.c                     |  4 ++--
 hw/char/xen_console.c                    |  2 +-
 hw/cris/axis_dev88.c                     |  2 +-
 hw/hppa/machine.c                        |  4 ++--
 hw/isa/isa-superio.c                     |  4 ++--
 hw/lm32/lm32_boards.c                    |  8 ++++----
 hw/lm32/milkymist.c                      |  4 ++--
 hw/m68k/mcf5206.c                        |  4 ++--
 hw/m68k/mcf5208.c                        |  6 +++---
 hw/microblaze/petalogix_ml605_mmu.c      |  2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
 hw/mips/boston.c                         |  2 +-
 hw/mips/mips_jazz.c                      |  8 ++++----
 hw/mips/mips_malta.c                     |  2 +-
 hw/mips/mips_mipssim.c                   |  4 ++--
 hw/misc/macio/macio.c                    |  4 ++--
 hw/moxie/moxiesim.c                      |  4 ++--
 hw/nios2/10m50_devboard.c                |  2 +-
 hw/openrisc/openrisc_sim.c               |  2 +-
 hw/ppc/e500.c                            | 12 ++++++------
 hw/ppc/ppc405_uc.c                       | 16 ++++++++--------
 hw/ppc/ppc440_bamboo.c                   |  8 ++++----
 hw/ppc/sam460ex.c                        |  8 ++++----
 hw/ppc/spapr.c                           |  4 ++--
 hw/ppc/virtex_ml507.c                    |  2 +-
 hw/riscv/sifive_e.c                      |  4 ++--
 hw/riscv/sifive_u.c                      |  4 ++--
 hw/riscv/spike.c                         |  4 ++--
 hw/riscv/virt.c                          |  2 +-
 hw/sh4/r2d.c                             |  2 +-
 hw/sh4/sh7750.c                          |  4 ++--
 hw/sparc/leon3.c                         |  4 ++--
 hw/sparc/sun4m.c                         |  4 ++--
 hw/sparc64/niagara.c                     |  4 ++--
 hw/sparc64/sun4u.c                       |  2 +-
 hw/xtensa/sim.c                          |  4 ++--
 hw/xtensa/xtfpga.c                       |  2 +-
 65 files changed, 143 insertions(+), 143 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 5dbbacb7e8..c5fbc654f2 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -108,9 +108,9 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sata), 0, AW_A10_SATA_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, s->irq[56]);
 
-    /* FIXME use a qdev chardev prop instead of serial_hds[] */
+    /* FIXME use a qdev chardev prop instead of serial_hd() */
     serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2, s->irq[1],
-                   115200, serial_hds[0], DEVICE_NATIVE_ENDIAN);
+                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
 }
 
 static void aw_a10_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 30d25f8b06..1219167a5e 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -229,11 +229,11 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, ASPEED_SOC_SCU_BASE);
 
     /* UART - attach an 8250 to the IO space as our UART5 */
-    if (serial_hds[0]) {
+    if (serial_hd(0)) {
         qemu_irq uart5 = qdev_get_gpio_in(DEVICE(&s->vic), uart_irqs[4]);
         serial_mm_init(get_system_memory(),
                        ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE, 2,
-                       uart5, 38400, serial_hds[0], DEVICE_LITTLE_ENDIAN);
+                       uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
     }
 
     /* I2C */
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 13b63970d7..6be7660e8c 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -166,7 +166,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     sysbus_pass_irq(SYS_BUS_DEVICE(s), SYS_BUS_DEVICE(&s->ic));
 
     /* UART0 */
-    qdev_prop_set_chr(DEVICE(s->uart0), "chardev", serial_hds[0]);
+    qdev_prop_set_chr(DEVICE(s->uart0), "chardev", serial_hd(0));
     object_property_set_bool(OBJECT(s->uart0), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -179,7 +179,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
                                INTERRUPT_UART));
     /* AUX / UART1 */
-    qdev_prop_set_chr(DEVICE(&s->aux), "chardev", serial_hds[1]);
+    qdev_prop_set_chr(DEVICE(&s->aux), "chardev", serial_hd(1));
 
     object_property_set_bool(OBJECT(&s->aux), true, "realized", &err);
     if (err) {
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 6184020985..726abb9b48 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -85,7 +85,7 @@ static void digic_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(sbd, 0, DIGIC4_TIMER_BASE(i));
     }
 
-    qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hds[0]);
+    qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));
     object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index d7d064e5ce..9731833fa5 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -118,7 +118,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
         };
 
         if (i < MAX_SERIAL_PORTS) {
-            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hds[i]);
+            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
         }
 
         object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index e6c788049d..8509915200 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -107,7 +107,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
         };
 
         if (i < MAX_SERIAL_PORTS) {
-            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hds[i]);
+            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
         }
 
         object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index ea14de33c6..535ad5888b 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -189,7 +189,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         if (i < MAX_SERIAL_PORTS) {
-            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hds[i]);
+            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
         }
 
         object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
@@ -438,7 +438,7 @@ static void fsl_imx6_class_init(ObjectClass *oc, void *data)
 
     dc->realize = fsl_imx6_realize;
     dc->desc = "i.MX6 SOC";
-    /* Reason: Uses serial_hds[] in the realize() function */
+    /* Reason: Uses serial_hd() in the realize() function */
     dc->user_creatable = false;
 }
 
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 390b4310e6..2848d76d3c 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -391,7 +391,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
 
 
         if (i < MAX_SERIAL_PORTS) {
-            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hds[i]);
+            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
         }
 
         object_property_set_bool(OBJECT(&s->uart[i]), true, "realized",
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 1742cf6f6c..0851d3b28a 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -342,7 +342,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, 0xfff34000);
     sysbus_connect_irq(busdev, 0, pic[18]);
-    pl011_create(0xfff36000, pic[20], serial_hds[0]);
+    pl011_create(0xfff36000, pic[20], serial_hd(0));
 
     dev = qdev_create(NULL, TYPE_HIGHBANK_REGISTERS);
     qdev_init_nofail(dev);
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 58b40efc19..4eceebb9ea 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -631,8 +631,8 @@ static void integratorcp_init(MachineState *machine)
     sysbus_create_varargs("integrator_pit", 0x13000000,
                           pic[5], pic[6], pic[7], NULL);
     sysbus_create_simple("pl031", 0x15000000, pic[8]);
-    pl011_create(0x16000000, pic[1], serial_hds[0]);
-    pl011_create(0x17000000, pic[2], serial_hds[1]);
+    pl011_create(0x16000000, pic[1], serial_hd(0));
+    pl011_create(0x17000000, pic[2], serial_hd(1));
     icp = sysbus_create_simple(TYPE_ICP_CONTROL_REGS, 0xcb000000,
                                qdev_get_gpio_in(sic, 3));
     sysbus_create_simple("pl050_keyboard", 0x18000000, pic[3]);
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index f9c2228e31..864c7bd411 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -121,10 +121,10 @@ static void kzm_init(MachineState *machine)
                      qdev_get_gpio_in(DEVICE(&s->soc.avic), 52));
     }
 
-    if (serial_hds[2]) { /* touchscreen */
+    if (serial_hd(2)) { /* touchscreen */
         serial_mm_init(get_system_memory(), KZM_FPGA_ADDR+0x10, 0,
                        qdev_get_gpio_in(DEVICE(&s->soc.avic), 52),
-                       14745600, serial_hds[2], DEVICE_NATIVE_ENDIAN);
+                       14745600, serial_hd(2), DEVICE_NATIVE_ENDIAN);
     }
 
     kzm_binfo.ram_size = machine->ram_size;
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 8c86cffa9e..4ae4a5cb2a 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -172,7 +172,7 @@ static MemoryRegion *make_uart(MPS2TZMachineState *mms, void *opaque,
 {
     CMSDKAPBUART *uart = opaque;
     int i = uart - &mms->uart[0];
-    Chardev *uartchr = i < MAX_SERIAL_PORTS ? serial_hds[i] : NULL;
+    Chardev *uartchr = i < MAX_SERIAL_PORTS ? serial_hd(i) : NULL;
     int rxirqno = i * 2;
     int txirqno = i * 2 + 1;
     int combirqno = i + 10;
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 694fb36866..eb550fad34 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -230,7 +230,7 @@ static void mps2_common_init(MachineState *machine)
             static const hwaddr uartbase[] = {0x40004000, 0x40005000,
                                               0x40006000, 0x40007000,
                                               0x40009000};
-            Chardev *uartchr = i < MAX_SERIAL_PORTS ? serial_hds[i] : NULL;
+            Chardev *uartchr = i < MAX_SERIAL_PORTS ? serial_hd(i) : NULL;
             /* RX irq number; TX irq is always one greater */
             static const int uartirq[] = {0, 2, 4, 18, 20};
             qemu_irq txovrint = NULL, rxovrint = NULL;
@@ -270,7 +270,7 @@ static void mps2_common_init(MachineState *machine)
             static const hwaddr uartbase[] = {0x40004000, 0x40005000,
                                               0x4002c000, 0x4002d000,
                                               0x4002e000};
-            Chardev *uartchr = i < MAX_SERIAL_PORTS ? serial_hds[i] : NULL;
+            Chardev *uartchr = i < MAX_SERIAL_PORTS ? serial_hd(i) : NULL;
             Object *txrx_orgate;
             DeviceState *txrx_orgate_dev;
 
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index f68df56b97..75c44adf7d 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -138,10 +138,10 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     system_clock_scale = NANOSECONDS_PER_SECOND / s->m3clk;
 
     for (i = 0; i < MSF2_NUM_UARTS; i++) {
-        if (serial_hds[i]) {
+        if (serial_hd(i)) {
             serial_mm_init(get_system_memory(), uart_addr[i], 2,
                            qdev_get_gpio_in(armv7m, uart_irq[i]),
-                           115200, serial_hds[i], DEVICE_NATIVE_ENDIAN);
+                           115200, serial_hd(i), DEVICE_NATIVE_ENDIAN);
         }
     }
 
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 38d7322a19..c807010e83 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1610,13 +1610,13 @@ static void musicpal_init(MachineState *machine)
                           pic[MP_TIMER2_IRQ], pic[MP_TIMER3_IRQ],
                           pic[MP_TIMER4_IRQ], NULL);
 
-    if (serial_hds[0]) {
+    if (serial_hd(0)) {
         serial_mm_init(address_space_mem, MP_UART1_BASE, 2, pic[MP_UART1_IRQ],
-                       1825000, serial_hds[0], DEVICE_NATIVE_ENDIAN);
+                       1825000, serial_hd(0), DEVICE_NATIVE_ENDIAN);
     }
-    if (serial_hds[1]) {
+    if (serial_hd(1)) {
         serial_mm_init(address_space_mem, MP_UART2_BASE, 2, pic[MP_UART2_IRQ],
-                       1825000, serial_hds[1], DEVICE_NATIVE_ENDIAN);
+                       1825000, serial_hd(1), DEVICE_NATIVE_ENDIAN);
     }
 
     /* Register flash */
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index b3a23a83d1..24673abfca 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3963,21 +3963,21 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
                     omap_findclk(s, "uart1_ck"),
                     s->drq[OMAP_DMA_UART1_TX], s->drq[OMAP_DMA_UART1_RX],
                     "uart1",
-                    serial_hds[0]);
+                    serial_hd(0));
     s->uart[1] = omap_uart_init(0xfffb0800,
                                 qdev_get_gpio_in(s->ih[1], OMAP_INT_UART2),
                     omap_findclk(s, "uart2_ck"),
                     omap_findclk(s, "uart2_ck"),
                     s->drq[OMAP_DMA_UART2_TX], s->drq[OMAP_DMA_UART2_RX],
                     "uart2",
-                    serial_hds[0] ? serial_hds[1] : NULL);
+                    serial_hd(0) ? serial_hd(1) : NULL);
     s->uart[2] = omap_uart_init(0xfffb9800,
                                 qdev_get_gpio_in(s->ih[0], OMAP_INT_UART3),
                     omap_findclk(s, "uart3_ck"),
                     omap_findclk(s, "uart3_ck"),
                     s->drq[OMAP_DMA_UART3_TX], s->drq[OMAP_DMA_UART3_RX],
                     "uart3",
-                    serial_hds[0] && serial_hds[1] ? serial_hds[2] : NULL);
+                    serial_hd(0) && serial_hd(1) ? serial_hd(2) : NULL);
 
     s->dpll[0] = omap_dpll_init(system_memory, 0xfffecf00,
                                 omap_findclk(s, "dpll1"));
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 647b119ba9..80663533e1 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2349,7 +2349,7 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
                     s->drq[OMAP24XX_DMA_UART1_TX],
                     s->drq[OMAP24XX_DMA_UART1_RX],
                     "uart1",
-                    serial_hds[0]);
+                    serial_hd(0));
     s->uart[1] = omap2_uart_init(sysmem, omap_l4ta(s->l4, 20),
                                  qdev_get_gpio_in(s->ih[0],
                                                   OMAP_INT_24XX_UART2_IRQ),
@@ -2358,7 +2358,7 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
                     s->drq[OMAP24XX_DMA_UART2_TX],
                     s->drq[OMAP24XX_DMA_UART2_RX],
                     "uart2",
-                    serial_hds[0] ? serial_hds[1] : NULL);
+                    serial_hd(0) ? serial_hd(1) : NULL);
     s->uart[2] = omap2_uart_init(sysmem, omap_l4ta(s->l4, 21),
                                  qdev_get_gpio_in(s->ih[0],
                                                   OMAP_INT_24XX_UART3_IRQ),
@@ -2367,7 +2367,7 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
                     s->drq[OMAP24XX_DMA_UART3_TX],
                     s->drq[OMAP24XX_DMA_UART3_RX],
                     "uart3",
-                    serial_hds[0] && serial_hds[1] ? serial_hds[2] : NULL);
+                    serial_hd(0) && serial_hd(1) ? serial_hd(2) : NULL);
 
     s->gptimer[0] = omap_gp_timer_init(omap_l4ta(s->l4, 7),
                     qdev_get_gpio_in(s->ih[0], OMAP_INT_24XX_GPTIMER1),
@@ -2519,8 +2519,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
     omap_sti_init(omap_l4ta(s->l4, 18), sysmem, 0x54000000,
                   qdev_get_gpio_in(s->ih[0], OMAP_INT_24XX_STI),
                   omap_findclk(s, "emul_ck"),
-                    serial_hds[0] && serial_hds[1] && serial_hds[2] ?
-                    serial_hds[3] : NULL);
+                    serial_hd(0) && serial_hd(1) && serial_hd(2) ?
+                    serial_hd(3) : NULL);
 
     s->eac = omap_eac_init(omap_l4ta(s->l4, 32),
                            qdev_get_gpio_in(s->ih[0], OMAP_INT_24XX_EAC_IRQ),
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 5805a2c858..928a0431d6 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -2106,21 +2106,21 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
                     qdev_get_gpio_in(s->dma, PXA2XX_TX_RQ_MMCI));
 
     for (i = 0; pxa270_serial[i].io_base; i++) {
-        if (serial_hds[i]) {
+        if (serial_hd(i)) {
             serial_mm_init(address_space, pxa270_serial[i].io_base, 2,
                            qdev_get_gpio_in(s->pic, pxa270_serial[i].irqn),
-                           14857000 / 16, serial_hds[i],
+                           14857000 / 16, serial_hd(i),
                            DEVICE_NATIVE_ENDIAN);
         } else {
             break;
         }
     }
-    if (serial_hds[i])
+    if (serial_hd(i))
         s->fir = pxa2xx_fir_init(address_space, 0x40800000,
                         qdev_get_gpio_in(s->pic, PXA2XX_PIC_ICP),
                         qdev_get_gpio_in(s->dma, PXA2XX_RX_RQ_ICP),
                         qdev_get_gpio_in(s->dma, PXA2XX_TX_RQ_ICP),
-                        serial_hds[i]);
+                        serial_hd(i));
 
     s->lcd = pxa2xx_lcdc_init(address_space, 0x44000000,
                     qdev_get_gpio_in(s->pic, PXA2XX_PIC_LCD));
@@ -2231,21 +2231,21 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
                     qdev_get_gpio_in(s->dma, PXA2XX_TX_RQ_MMCI));
 
     for (i = 0; pxa255_serial[i].io_base; i++) {
-        if (serial_hds[i]) {
+        if (serial_hd(i)) {
             serial_mm_init(address_space, pxa255_serial[i].io_base, 2,
                            qdev_get_gpio_in(s->pic, pxa255_serial[i].irqn),
-                           14745600 / 16, serial_hds[i],
+                           14745600 / 16, serial_hd(i),
                            DEVICE_NATIVE_ENDIAN);
         } else {
             break;
         }
     }
-    if (serial_hds[i])
+    if (serial_hd(i))
         s->fir = pxa2xx_fir_init(address_space, 0x40800000,
                         qdev_get_gpio_in(s->pic, PXA2XX_PIC_ICP),
                         qdev_get_gpio_in(s->dma, PXA2XX_RX_RQ_ICP),
                         qdev_get_gpio_in(s->dma, PXA2XX_TX_RQ_ICP),
-                        serial_hds[i]);
+                        serial_hd(i));
 
     s->lcd = pxa2xx_lcdc_init(address_space, 0x44000000,
                     qdev_get_gpio_in(s->pic, PXA2XX_PIC_LCD));
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 2139a62e25..cd585d9469 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -195,10 +195,10 @@ static void realview_init(MachineState *machine,
     sysbus_create_simple("pl050_keyboard", 0x10006000, pic[20]);
     sysbus_create_simple("pl050_mouse", 0x10007000, pic[21]);
 
-    pl011_create(0x10009000, pic[12], serial_hds[0]);
-    pl011_create(0x1000a000, pic[13], serial_hds[1]);
-    pl011_create(0x1000b000, pic[14], serial_hds[2]);
-    pl011_create(0x1000c000, pic[15], serial_hds[3]);
+    pl011_create(0x10009000, pic[12], serial_hd(0));
+    pl011_create(0x1000a000, pic[13], serial_hd(1));
+    pl011_create(0x1000b000, pic[14], serial_hd(2));
+    pl011_create(0x1000c000, pic[15], serial_hd(3));
 
     /* DMA controller is optional, apparently.  */
     sysbus_create_simple("pl081", 0x10030000, pic[24]);
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index de7c0fc4a6..e886f54976 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1353,7 +1353,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         if (board->dc2 & (1 << i)) {
             pl011_luminary_create(0x4000c000 + i * 0x1000,
                                   qdev_get_gpio_in(nvic, uart_irq[i]),
-                                  serial_hds[i]);
+                                  serial_hd(i));
         }
     }
     if (board->dc2 & (1 << 4)) {
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 1cd6374e07..f59418e7d0 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -136,7 +136,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_USARTS; i++) {
         dev = DEVICE(&(s->usart[i]));
         qdev_prop_set_chr(dev, "chardev",
-                          i < MAX_SERIAL_PORTS ? serial_hds[i] : NULL);
+                          i < MAX_SERIAL_PORTS ? serial_hd(i) : NULL);
         object_property_set_bool(OBJECT(&s->usart[i]), true, "realized", &err);
         if (err != NULL) {
             error_propagate(errp, err);
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 4cdb3a670b..ec2627374d 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1622,7 +1622,7 @@ StrongARMState *sa1110_init(MemoryRegion *sysmem,
 
     for (i = 0; sa_serial[i].io_base; i++) {
         DeviceState *dev = qdev_create(NULL, TYPE_STRONGARM_UART);
-        qdev_prop_set_chr(dev, "chardev", serial_hds[i]);
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
         qdev_init_nofail(dev);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
                 sa_serial[i].io_base);
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 418792cd02..e01e3192ff 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -283,10 +283,10 @@ static void versatile_init(MachineState *machine, int board_id)
         n--;
     }
 
-    pl011_create(0x101f1000, pic[12], serial_hds[0]);
-    pl011_create(0x101f2000, pic[13], serial_hds[1]);
-    pl011_create(0x101f3000, pic[14], serial_hds[2]);
-    pl011_create(0x10009000, sic[6], serial_hds[3]);
+    pl011_create(0x101f1000, pic[12], serial_hd(0));
+    pl011_create(0x101f2000, pic[13], serial_hd(1));
+    pl011_create(0x101f3000, pic[14], serial_hd(2));
+    pl011_create(0x10009000, sic[6], serial_hd(3));
 
     sysbus_create_simple("pl080", 0x10130000, pic[17]);
     sysbus_create_simple("sp804", 0x101e2000, pic[4]);
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 9fad79177a..f1e33c8a36 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -622,10 +622,10 @@ static void vexpress_common_init(MachineState *machine)
     sysbus_create_simple("pl050_keyboard", map[VE_KMI0], pic[12]);
     sysbus_create_simple("pl050_mouse", map[VE_KMI1], pic[13]);
 
-    pl011_create(map[VE_UART0], pic[5], serial_hds[0]);
-    pl011_create(map[VE_UART1], pic[6], serial_hds[1]);
-    pl011_create(map[VE_UART2], pic[7], serial_hds[2]);
-    pl011_create(map[VE_UART3], pic[8], serial_hds[3]);
+    pl011_create(map[VE_UART0], pic[5], serial_hd(0));
+    pl011_create(map[VE_UART1], pic[6], serial_hd(1));
+    pl011_create(map[VE_UART2], pic[7], serial_hd(2));
+    pl011_create(map[VE_UART3], pic[8], serial_hd(3));
 
     sysbus_create_simple("sp804", map[VE_TIMER01], pic[2]);
     sysbus_create_simple("sp804", map[VE_TIMER23], pic[3]);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 94dcb125d3..a18291c5d5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1371,11 +1371,11 @@ static void machvirt_init(MachineState *machine)
 
     fdt_add_pmu_nodes(vms);
 
-    create_uart(vms, pic, VIRT_UART, sysmem, serial_hds[0]);
+    create_uart(vms, pic, VIRT_UART, sysmem, serial_hd(0));
 
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem);
-        create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem, serial_hds[1]);
+        create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
     }
 
     create_rtc(vms, pic);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 0f76333770..899a26326f 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -236,8 +236,8 @@ static void zynq_init(MachineState *machine)
     sysbus_create_simple("xlnx,ps7-usb", 0xE0002000, pic[53-IRQ_OFFSET]);
     sysbus_create_simple("xlnx,ps7-usb", 0xE0003000, pic[76-IRQ_OFFSET]);
 
-    cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hds[0]);
-    cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hds[1]);
+    cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0));
+    cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1));
 
     sysbus_create_varargs("cadence_ttc", 0xF8001000,
             pic[42-IRQ_OFFSET], pic[43-IRQ_OFFSET], pic[44-IRQ_OFFSET], NULL);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 465796e97c..505253e0d2 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -374,7 +374,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
-        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hds[i]);
+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
         object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 3957e78abf..c2bba03362 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -600,7 +600,7 @@ DeviceState *exynos4210_uart_create(hwaddr addr,
                          MAX_SERIAL_PORTS);
             exit(1);
         }
-        chr = serial_hds[channel];
+        chr = serial_hd(channel);
         if (!chr) {
             snprintf(label, ARRAY_SIZE(label), "%s%d", chr_name, channel);
             chr = qemu_chr_new(label, "null");
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index d7c5cc11fe..eb5996159d 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -141,8 +141,8 @@ void serial_hds_isa_init(ISABus *bus, int from, int to)
     assert(to <= MAX_SERIAL_PORTS);
 
     for (i = from; i < to; ++i) {
-        if (serial_hds[i]) {
-            serial_isa_init(bus, i, serial_hds[i]);
+        if (serial_hd(i)) {
+            serial_isa_init(bus, i, serial_hd(i));
         }
     }
 }
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 5e68326c19..bdfaa40ed3 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -201,7 +201,7 @@ static int con_init(struct XenDevice *xendev)
     /* no Xen override, use qemu output device */
     if (output == NULL) {
         if (con->xendev.dev) {
-            qemu_chr_fe_init(&con->chr, serial_hds[con->xendev.dev],
+            qemu_chr_fe_init(&con->chr, serial_hd(con->xendev.dev),
                              &error_abort);
         }
     } else {
diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 9ccc4350a5..409f3d581a 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -337,7 +337,7 @@ void axisdev88_init(MachineState *machine)
     sysbus_create_varargs("etraxfs,timer", 0x3005e000, irq[0x1b], nmi[1], NULL);
 
     for (i = 0; i < 4; i++) {
-        etraxfs_ser_create(0x30026000 + i * 0x2000, irq[0x14 + i], serial_hds[i]);
+        etraxfs_ser_create(0x30026000 + i * 0x2000, irq[0x14 + i], serial_hd(i));
     }
 
     if (kernel_filename) {
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 19033e268d..a1d6b0ebfb 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -108,10 +108,10 @@ static void machine_hppa_init(MachineState *machine)
     mc146818_rtc_init(isa_bus, 2000, rtc_irq);
 
     /* Serial code setup.  */
-    if (serial_hds[0]) {
+    if (serial_hd(0)) {
         uint32_t addr = DINO_UART_HPA + 0x800;
         serial_mm_init(addr_space, addr, 0, serial_irq,
-                       115200, serial_hds[0], DEVICE_BIG_ENDIAN);
+                       115200, serial_hd(0), DEVICE_BIG_ENDIAN);
     }
 
     /* SCSI disk setup. */
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index b95608a003..76286c81a1 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -81,8 +81,8 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             break;
         }
         if (!k->serial.is_enabled || k->serial.is_enabled(sio, i)) {
-            /* FIXME use a qdev chardev prop instead of serial_hds[] */
-            chr = serial_hds[i];
+            /* FIXME use a qdev chardev prop instead of serial_hd() */
+            chr = serial_hd(i);
             if (chr == NULL || chr->be) {
                 name = g_strdup_printf("discarding-serial%d", i);
                 chr = qemu_chr_new(name, "null");
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index 527bcc229c..907e875d02 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -125,12 +125,12 @@ static void lm32_evr_init(MachineState *machine)
         irq[i] = qdev_get_gpio_in(env->pic_state, i);
     }
 
-    lm32_uart_create(uart0_base, irq[uart0_irq], serial_hds[0]);
+    lm32_uart_create(uart0_base, irq[uart0_irq], serial_hd(0));
     sysbus_create_simple("lm32-timer", timer0_base, irq[timer0_irq]);
     sysbus_create_simple("lm32-timer", timer1_base, irq[timer1_irq]);
 
     /* make sure juart isn't the first chardev */
-    env->juart_state = lm32_juart_init(serial_hds[1]);
+    env->juart_state = lm32_juart_init(serial_hd(1));
 
     reset_info->bootstrap_pc = flash_base;
 
@@ -217,13 +217,13 @@ static void lm32_uclinux_init(MachineState *machine)
         irq[i] = qdev_get_gpio_in(env->pic_state, i);
     }
 
-    lm32_uart_create(uart0_base, irq[uart0_irq], serial_hds[0]);
+    lm32_uart_create(uart0_base, irq[uart0_irq], serial_hd(0));
     sysbus_create_simple("lm32-timer", timer0_base, irq[timer0_irq]);
     sysbus_create_simple("lm32-timer", timer1_base, irq[timer1_irq]);
     sysbus_create_simple("lm32-timer", timer2_base, irq[timer2_irq]);
 
     /* make sure juart isn't the first chardev */
-    env->juart_state = lm32_juart_init(serial_hds[1]);
+    env->juart_state = lm32_juart_init(serial_hd(1));
 
     reset_info->bootstrap_pc = flash_base;
 
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 85d64fe58d..f9688e059e 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -151,7 +151,7 @@ milkymist_init(MachineState *machine)
     }
     g_free(bios_filename);
 
-    milkymist_uart_create(0x60000000, irq[0], serial_hds[0]);
+    milkymist_uart_create(0x60000000, irq[0], serial_hd(0));
     milkymist_sysctl_create(0x60001000, irq[1], irq[2], irq[3],
             80000000, 0x10014d31, 0x0000041f, 0x00000001);
     milkymist_hpdmc_create(0x60002000);
@@ -167,7 +167,7 @@ milkymist_init(MachineState *machine)
             0x20000000, 0x1000, 0x20020000, 0x2000);
 
     /* make sure juart isn't the first chardev */
-    env->juart_state = lm32_juart_init(serial_hds[1]);
+    env->juart_state = lm32_juart_init(serial_hd(1));
 
     if (kernel_filename) {
         uint64_t entry;
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index bd8e993c58..6ad1e4bd2d 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -543,8 +543,8 @@ qemu_irq *mcf5206_init(MemoryRegion *sysmem, uint32_t base, M68kCPU *cpu)
     pic = qemu_allocate_irqs(m5206_mbar_set_irq, s, 14);
     s->timer[0] = m5206_timer_init(pic[9]);
     s->timer[1] = m5206_timer_init(pic[10]);
-    s->uart[0] = mcf_uart_init(pic[12], serial_hds[0]);
-    s->uart[1] = mcf_uart_init(pic[13], serial_hds[1]);
+    s->uart[0] = mcf_uart_init(pic[12], serial_hd(0));
+    s->uart[1] = mcf_uart_init(pic[13], serial_hd(1));
     s->cpu = cpu;
 
     m5206_mbar_reset(s);
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index fac0d09cbc..7aca58542e 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -247,9 +247,9 @@ static void mcf5208evb_init(MachineState *machine)
     /* Internal peripherals.  */
     pic = mcf_intc_init(address_space_mem, 0xfc048000, cpu);
 
-    mcf_uart_mm_init(0xfc060000, pic[26], serial_hds[0]);
-    mcf_uart_mm_init(0xfc064000, pic[27], serial_hds[1]);
-    mcf_uart_mm_init(0xfc068000, pic[28], serial_hds[2]);
+    mcf_uart_mm_init(0xfc060000, pic[26], serial_hd(0));
+    mcf_uart_mm_init(0xfc064000, pic[27], serial_hd(1));
+    mcf_uart_mm_init(0xfc068000, pic[28], serial_hd(2));
 
     mcf5208_sys_init(address_space_mem, pic);
 
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index b664dc0f9c..cf6bf3f32a 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -125,7 +125,7 @@ petalogix_ml605_init(MachineState *machine)
     }
 
     serial_mm_init(address_space_mem, UART16550_BASEADDR + 0x1000, 2,
-                   irq[UART16550_IRQ], 115200, serial_hds[0],
+                   irq[UART16550_IRQ], 115200, serial_hd(0),
                    DEVICE_LITTLE_ENDIAN);
 
     /* 2 timers at irq 2 @ 100 Mhz.  */
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 5cb4deb69e..1186002a76 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -103,7 +103,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     }
 
     xilinx_uartlite_create(UARTLITE_BASEADDR, irq[UARTLITE_IRQ],
-                           serial_hds[0]);
+                           serial_hd(0));
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
     dev = qdev_create(NULL, "xlnx.xps-timer");
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 14f0f6673b..5302e5c885 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -507,7 +507,7 @@ static void boston_mach_init(MachineState *machine)
 
     s->uart = serial_mm_init(sys_mem, 0x17ffe000, 2,
                              get_cps_irq(s->cps, 3), 10000000,
-                             serial_hds[0], DEVICE_NATIVE_ENDIAN);
+                             serial_hd(0), DEVICE_NATIVE_ENDIAN);
 
     lcd = g_new(MemoryRegion, 1);
     memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0x8);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 7223085547..90cb306f53 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -303,15 +303,15 @@ static void mips_jazz_init(MachineState *machine,
     memory_region_add_subregion(address_space, 0x80005000, i8042);
 
     /* Serial ports */
-    if (serial_hds[0]) {
+    if (serial_hd(0)) {
         serial_mm_init(address_space, 0x80006000, 0,
                        qdev_get_gpio_in(rc4030, 8), 8000000/16,
-                       serial_hds[0], DEVICE_NATIVE_ENDIAN);
+                       serial_hd(0), DEVICE_NATIVE_ENDIAN);
     }
-    if (serial_hds[1]) {
+    if (serial_hd(1)) {
         serial_mm_init(address_space, 0x80007000, 0,
                        qdev_get_gpio_in(rc4030, 9), 8000000/16,
-                       serial_hds[1], DEVICE_NATIVE_ENDIAN);
+                       serial_hd(1), DEVICE_NATIVE_ENDIAN);
     }
 
     /* Parallel port */
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 49fe7a0a72..af70ecffc0 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1057,7 +1057,7 @@ void mips_malta_init(MachineState *machine)
     /* FPGA */
 
     /* The CBUS UART is attached to the MIPS CPU INT2 pin, ie interrupt 4 */
-    malta_fpga_init(system_memory, FPGA_ADDRESS, cbus_irq, serial_hds[2]);
+    malta_fpga_init(system_memory, FPGA_ADDRESS, cbus_irq, serial_hd(2));
 
     /* Load firmware in flash / BIOS. */
     dinfo = drive_get(IF_PFLASH, 0, fl_idx);
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index e0ba5efc84..241faa1d0f 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -213,8 +213,8 @@ mips_mipssim_init(MachineState *machine)
 
     /* A single 16450 sits at offset 0x3f8. It is attached to
        MIPS CPU INT2, which is interrupt 4. */
-    if (serial_hds[0])
-        serial_init(0x3f8, env->irq[4], 115200, serial_hds[0],
+    if (serial_hd(0))
+        serial_init(0x3f8, env->irq[4], 115200, serial_hd(0),
                     get_system_io());
 
     if (nd_table[0].used)
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index b74a6572b0..a0cefe5719 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -118,8 +118,8 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
     qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
     qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
-    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hds[0]);
-    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hds[1]);
+    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hd(0));
+    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hd(1));
     qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
     qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
     object_property_set_bool(OBJECT(&s->escc), true, "realized", &err);
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 0bbf770795..d41247dbdc 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -141,9 +141,9 @@ static void moxiesim_init(MachineState *machine)
     }
 
     /* A single 16450 sits at offset 0x3f8.  */
-    if (serial_hds[0]) {
+    if (serial_hd(0)) {
         serial_mm_init(address_space_mem, 0x3f8, 0, env->irq[4],
-                       8000000/16, serial_hds[0], DEVICE_LITTLE_ENDIAN);
+                       8000000/16, serial_hd(0), DEVICE_LITTLE_ENDIAN);
     }
 }
 
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 42053b2ca9..36b49a420c 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -92,7 +92,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
 
     /* Register: Altera 16550 UART */
     serial_mm_init(address_space_mem, 0xf8001600, 2, irq[1], 115200,
-                   serial_hds[0], DEVICE_NATIVE_ENDIAN);
+                   serial_hd(0), DEVICE_NATIVE_ENDIAN);
 
     /* Register: Timer sys_clk_timer  */
     dev = qdev_create(NULL, "ALTR.timer");
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index c755f11efd..a495a84a41 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -164,7 +164,7 @@ static void openrisc_sim_init(MachineState *machine)
     }
 
     serial_mm_init(get_system_memory(), 0x90000000, 0, serial_irq,
-                   115200, serial_hds[0], DEVICE_NATIVE_ENDIAN);
+                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
 
     openrisc_load_kernel(ram_size, kernel_filename);
 }
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 9a85a41362..2ddab7ed24 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -456,12 +456,12 @@ static int ppce500_load_device_tree(MachineState *machine,
      * device it finds in the dt as serial output device. And we generate
      * devices in reverse order to the dt.
      */
-    if (serial_hds[1]) {
+    if (serial_hd(1)) {
         dt_serial_create(fdt, MPC8544_SERIAL1_REGS_OFFSET,
                          soc, mpic, "serial1", 1, false);
     }
 
-    if (serial_hds[0]) {
+    if (serial_hd(0)) {
         dt_serial_create(fdt, MPC8544_SERIAL0_REGS_OFFSET,
                          soc, mpic, "serial0", 0, true);
     }
@@ -875,16 +875,16 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     mpicdev = ppce500_init_mpic(machine, params, ccsr_addr_space, irqs);
 
     /* Serial */
-    if (serial_hds[0]) {
+    if (serial_hd(0)) {
         serial_mm_init(ccsr_addr_space, MPC8544_SERIAL0_REGS_OFFSET,
                        0, qdev_get_gpio_in(mpicdev, 42), 399193,
-                       serial_hds[0], DEVICE_BIG_ENDIAN);
+                       serial_hd(0), DEVICE_BIG_ENDIAN);
     }
 
-    if (serial_hds[1]) {
+    if (serial_hd(1)) {
         serial_mm_init(ccsr_addr_space, MPC8544_SERIAL1_REGS_OFFSET,
                        0, qdev_get_gpio_in(mpicdev, 42), 399193,
-                       serial_hds[1], DEVICE_BIG_ENDIAN);
+                       serial_hd(1), DEVICE_BIG_ENDIAN);
     }
 
     /* General Utility device */
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 205ebcea93..34f8d57b07 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -1660,14 +1660,14 @@ CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
     dma_irqs[3] = pic[23];
     ppc405_dma_init(env, dma_irqs);
     /* Serial ports */
-    if (serial_hds[0] != NULL) {
+    if (serial_hd(0) != NULL) {
         serial_mm_init(address_space_mem, 0xef600300, 0, pic[0],
-                       PPC_SERIAL_MM_BAUDBASE, serial_hds[0],
+                       PPC_SERIAL_MM_BAUDBASE, serial_hd(0),
                        DEVICE_BIG_ENDIAN);
     }
-    if (serial_hds[1] != NULL) {
+    if (serial_hd(1) != NULL) {
         serial_mm_init(address_space_mem, 0xef600400, 0, pic[1],
-                       PPC_SERIAL_MM_BAUDBASE, serial_hds[1],
+                       PPC_SERIAL_MM_BAUDBASE, serial_hd(1),
                        DEVICE_BIG_ENDIAN);
     }
     /* IIC controller */
@@ -2023,14 +2023,14 @@ CPUPPCState *ppc405ep_init(MemoryRegion *address_space_mem,
     /* GPIO */
     ppc405_gpio_init(0xef600700);
     /* Serial ports */
-    if (serial_hds[0] != NULL) {
+    if (serial_hd(0) != NULL) {
         serial_mm_init(address_space_mem, 0xef600300, 0, pic[0],
-                       PPC_SERIAL_MM_BAUDBASE, serial_hds[0],
+                       PPC_SERIAL_MM_BAUDBASE, serial_hd(0),
                        DEVICE_BIG_ENDIAN);
     }
-    if (serial_hds[1] != NULL) {
+    if (serial_hd(1) != NULL) {
         serial_mm_init(address_space_mem, 0xef600400, 0, pic[1],
-                       PPC_SERIAL_MM_BAUDBASE, serial_hds[1],
+                       PPC_SERIAL_MM_BAUDBASE, serial_hd(1),
                        DEVICE_BIG_ENDIAN);
     }
     /* OCM */
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 8641986a71..44e6a0c21b 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -238,14 +238,14 @@ static void bamboo_init(MachineState *machine)
                              get_system_io(), 0, PPC440EP_PCI_IOLEN);
     memory_region_add_subregion(get_system_memory(), PPC440EP_PCI_IO, isa);
 
-    if (serial_hds[0] != NULL) {
+    if (serial_hd(0) != NULL) {
         serial_mm_init(address_space_mem, 0xef600300, 0, pic[0],
-                       PPC_SERIAL_MM_BAUDBASE, serial_hds[0],
+                       PPC_SERIAL_MM_BAUDBASE, serial_hd(0),
                        DEVICE_BIG_ENDIAN);
     }
-    if (serial_hds[1] != NULL) {
+    if (serial_hd(1) != NULL) {
         serial_mm_init(address_space_mem, 0xef600400, 0, pic[1],
-                       PPC_SERIAL_MM_BAUDBASE, serial_hds[1],
+                       PPC_SERIAL_MM_BAUDBASE, serial_hd(1),
                        DEVICE_BIG_ENDIAN);
     }
 
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index dfff262f96..a48e6e6fce 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -522,14 +522,14 @@ static void sam460ex_init(MachineState *machine)
 
     /* SoC has 4 UARTs
      * but board has only one wired and two are present in fdt */
-    if (serial_hds[0] != NULL) {
+    if (serial_hd(0) != NULL) {
         serial_mm_init(address_space_mem, 0x4ef600300, 0, uic[1][1],
-                       PPC_SERIAL_MM_BAUDBASE, serial_hds[0],
+                       PPC_SERIAL_MM_BAUDBASE, serial_hd(0),
                        DEVICE_BIG_ENDIAN);
     }
-    if (serial_hds[1] != NULL) {
+    if (serial_hd(1) != NULL) {
         serial_mm_init(address_space_mem, 0x4ef600400, 0, uic[0][1],
-                       PPC_SERIAL_MM_BAUDBASE, serial_hds[1],
+                       PPC_SERIAL_MM_BAUDBASE, serial_hd(1),
                        DEVICE_BIG_ENDIAN);
     }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a81570e7c8..b0ecfaca9e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2590,8 +2590,8 @@ static void spapr_machine_init(MachineState *machine)
     spapr->vio_bus = spapr_vio_bus_init();
 
     for (i = 0; i < MAX_SERIAL_PORTS; i++) {
-        if (serial_hds[i]) {
-            spapr_vty_create(spapr->vio_bus, serial_hds[i]);
+        if (serial_hd(i)) {
+            spapr_vty_create(spapr->vio_bus, serial_hd(i));
         }
     }
 
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 77a1778e07..a80cbdd7ee 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -251,7 +251,7 @@ static void virtex_init(MachineState *machine)
     }
 
     serial_mm_init(address_space_mem, UART16550_BASEADDR, 2, irq[UART16550_IRQ],
-                   115200, serial_hds[0], DEVICE_LITTLE_ENDIAN);
+                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
     dev = qdev_create(NULL, "xlnx.xps-timer");
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 19eca36ff4..487244890e 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -162,13 +162,13 @@ static void riscv_sifive_e_init(MachineState *machine)
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.gpio0",
         memmap[SIFIVE_E_GPIO0].base, memmap[SIFIVE_E_GPIO0].size);
     sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART0].base,
-        serial_hds[0], SIFIVE_PLIC(s->plic)->irqs[SIFIVE_E_UART0_IRQ]);
+        serial_hd(0), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_E_UART0_IRQ]);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.qspi0",
         memmap[SIFIVE_E_QSPI0].base, memmap[SIFIVE_E_QSPI0].size);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.pwm0",
         memmap[SIFIVE_E_PWM0].base, memmap[SIFIVE_E_PWM0].size);
     /* sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART1].base,
-        serial_hds[1], SIFIVE_PLIC(s->plic)->irqs[SIFIVE_E_UART1_IRQ]); */
+        serial_hd(1), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_E_UART1_IRQ]); */
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.qspi1",
         memmap[SIFIVE_E_QSPI1].base, memmap[SIFIVE_E_QSPI1].size);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.pwm1",
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 1c2deefa6c..66616bacd7 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -296,9 +296,9 @@ static void riscv_sifive_u_init(MachineState *machine)
         SIFIVE_U_PLIC_CONTEXT_STRIDE,
         memmap[SIFIVE_U_PLIC].size);
     sifive_uart_create(sys_memory, memmap[SIFIVE_U_UART0].base,
-        serial_hds[0], SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART0_IRQ]);
+        serial_hd(0), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART0_IRQ]);
     /* sifive_uart_create(sys_memory, memmap[SIFIVE_U_UART1].base,
-        serial_hds[1], SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART1_IRQ]); */
+        serial_hd(1), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART1_IRQ]); */
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
         memmap[SIFIVE_U_CLINT].size, smp_cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 2d1f114d40..62857e4fa0 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -233,7 +233,7 @@ static void spike_v1_10_0_board_init(MachineState *machine)
         s->fdt, s->fdt_size);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, boot_rom, &s->soc.harts[0].env, serial_hds[0]);
+    htif_mm_init(system_memory, boot_rom, &s->soc.harts[0].env, serial_hd(0));
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
@@ -330,7 +330,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
         config_string, config_string_len);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, boot_rom, &s->soc.harts[0].env, serial_hds[0]);
+    htif_mm_init(system_memory, boot_rom, &s->soc.harts[0].env, serial_hd(0));
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e2c214e86a..4f69eb2cff 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -382,7 +382,7 @@ static void riscv_virt_board_init(MachineState *machine)
 
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
         0, SIFIVE_PLIC(s->plic)->irqs[UART0_IRQ], 399193,
-        serial_hds[0], DEVICE_LITTLE_ENDIAN);
+        serial_hd(0), DEVICE_LITTLE_ENDIAN);
 }
 
 static int riscv_virt_board_sysbus_device_init(SysBusDevice *sysbusdev)
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 458ed83297..6b01d6eed8 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -271,7 +271,7 @@ static void r2d_init(MachineState *machine)
     busdev = SYS_BUS_DEVICE(dev);
     qdev_prop_set_uint32(dev, "vram-size", SM501_VRAM_SIZE);
     qdev_prop_set_uint32(dev, "base", 0x10000000);
-    qdev_prop_set_ptr(dev, "chr-state", serial_hds[2]);
+    qdev_prop_set_ptr(dev, "chr-state", serial_hd(2));
     qdev_init_nofail(dev);
     sysbus_mmio_map(busdev, 0, 0x10000000);
     sysbus_mmio_map(busdev, 1, 0x13e00000);
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 166e4bd947..5a7d47d31e 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -773,7 +773,7 @@ SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem)
     cpu->env.intc_handle = &s->intc;
 
     sh_serial_init(sysmem, 0x1fe00000,
-                   0, s->periph_freq, serial_hds[0],
+                   0, s->periph_freq, serial_hd(0),
                    s->intc.irqs[SCI1_ERI],
                    s->intc.irqs[SCI1_RXI],
                    s->intc.irqs[SCI1_TXI],
@@ -781,7 +781,7 @@ SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem)
                    NULL);
     sh_serial_init(sysmem, 0x1fe80000,
                    SH_SERIAL_FEAT_SCIF,
-                   s->periph_freq, serial_hds[1],
+                   s->periph_freq, serial_hd(1),
                    s->intc.irqs[SCIF_ERI],
                    s->intc.irqs[SCIF_RXI],
                    s->intc.irqs[SCIF_TXI],
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index bba3aa3dee..98fa6adae0 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -206,8 +206,8 @@ static void leon3_generic_hw_init(MachineState *machine)
     grlib_gptimer_create(0x80000300, 2, CPU_CLK, cpu_irqs, 6);
 
     /* Allocate uart */
-    if (serial_hds[0]) {
-        grlib_apbuart_create(0x80000100, serial_hds[0], cpu_irqs[3]);
+    if (serial_hd(0)) {
+        grlib_apbuart_create(0x80000100, serial_hd(0), cpu_irqs[3]);
     }
 }
 
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 6471aca25d..0ee779fafe 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -943,8 +943,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     qdev_prop_set_uint32(dev, "disabled", 0);
     qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
     qdev_prop_set_uint32(dev, "it_shift", 1);
-    qdev_prop_set_chr(dev, "chrB", serial_hds[1]);
-    qdev_prop_set_chr(dev, "chrA", serial_hds[0]);
+    qdev_prop_set_chr(dev, "chrB", serial_hd(1));
+    qdev_prop_set_chr(dev, "chrA", serial_hd(0));
     qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
     qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
     qdev_init_nofail(dev);
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 1874477ef6..22c4655fde 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -156,9 +156,9 @@ static void niagara_init(MachineState *machine)
             exit(1);
         }
     }
-    if (serial_hds[0]) {
+    if (serial_hd(0)) {
         serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL, 115200,
-                       serial_hds[0], DEVICE_BIG_ENDIAN);
+                       serial_hd(0), DEVICE_BIG_ENDIAN);
     }
     empty_slot_init(NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
     sun4v_rtc_init(NIAGARA_RTC_BASE);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 2044a52ded..9b441f704b 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -295,7 +295,7 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     i = 0;
     if (s->console_serial_base) {
         serial_mm_init(pci_address_space(pci_dev), s->console_serial_base,
-                       0, NULL, 115200, serial_hds[i], DEVICE_BIG_ENDIAN);
+                       0, NULL, 115200, serial_hd(i), DEVICE_BIG_ENDIAN);
         i++;
     }
     serial_hds_isa_init(s->isa_bus, i, MAX_SERIAL_PORTS);
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 5c0ba231d1..b6ccb3cd4a 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -90,8 +90,8 @@ static void xtensa_sim_init(MachineState *machine)
                                      get_system_memory());
     }
 
-    if (serial_hds[0]) {
-        xtensa_sim_open_console(serial_hds[0]);
+    if (serial_hd(0)) {
+        xtensa_sim_open_console(serial_hd(0));
     }
     if (kernel_filename) {
         uint64_t elf_entry;
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 9db99e1f7e..63734c70ec 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -279,7 +279,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     }
 
     serial_mm_init(system_io, 0x0d050020, 2, xtensa_get_extint(env, 0),
-            115200, serial_hds[0], DEVICE_NATIVE_ENDIAN);
+            115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     if (dinfo) {
-- 
2.17.0
