Received: from eggs.gnu.org ([2001:4830:134:3::10]:60774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRiAa-0007N7-MW
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRiAR-0006GQ-HS
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:28:40 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 20 Dec 2017 09:22:55 -0800
Message-ID: <dbfd863f4995e46458792572ad5ab280c52a2d97.1513790495.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1513790494.git.alistair.francis@xilinx.com>
References: <cover.1513790494.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 02/29] Replace all occurances of
 __FUNCTION__ with __func__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org

Replace all occurs of __FUNCTION__ except for the check in checkpatch
with the non GCC specific __func__.

One line in hcd-musb.c was manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Andrzej Zaborowski <balrogg@gmail.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: John Snow <jsnow@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fam Zheng <famz@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-arm@nongnu.org
Cc: qemu-block@nongnu.org
Cc: xen-devel@lists.xenproject.org
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---

 hw/arm/nseries.c           |  2 +-
 hw/arm/omap1.c             | 42 +++++++++++++++++++++---------------------
 hw/arm/omap2.c             | 12 ++++++------
 hw/arm/palm.c              | 14 +++++++-------
 hw/arm/pxa2xx.c            | 46 +++++++++++++++++++++++-----------------------
 hw/arm/pxa2xx_gpio.c       |  6 +++---
 hw/arm/pxa2xx_pic.c        |  4 ++--
 hw/arm/tosa.c              | 10 +++++-----
 hw/audio/hda-codec.c       | 10 +++++-----
 hw/audio/intel-hda.c       | 28 ++++++++++++++--------------
 hw/audio/wm8750.c          |  4 ++--
 hw/block/nand.c            |  4 ++--
 hw/block/onenand.c         |  8 ++++----
 hw/bt/core.c               | 10 +++++-----
 hw/bt/hci-csr.c            | 14 +++++++-------
 hw/bt/hci.c                | 26 +++++++++++++-------------
 hw/bt/hid.c                |  2 +-
 hw/bt/l2cap.c              | 22 +++++++++++-----------
 hw/bt/sdp.c                |  6 +++---
 hw/display/blizzard.c      | 18 +++++++++---------
 hw/display/omap_dss.c      |  6 +++---
 hw/display/pxa2xx_lcd.c    | 14 +++++++-------
 hw/display/qxl-render.c    |  6 +++---
 hw/display/qxl.h           |  2 +-
 hw/display/tc6393xb.c      |  2 +-
 hw/display/xenfb.c         |  2 +-
 hw/dma/omap_dma.c          | 26 +++++++++++++-------------
 hw/dma/pxa2xx_dma.c        | 14 +++++++-------
 hw/gpio/max7310.c          |  8 ++++----
 hw/gpio/omap_gpio.c        |  2 +-
 hw/i2c/omap_i2c.c          |  6 +++---
 hw/ide/ahci.c              |  2 +-
 hw/ide/microdrive.c        |  4 ++--
 hw/input/lm832x.c          |  6 +++---
 hw/input/pxa2xx_keypad.c   |  6 +++---
 hw/input/tsc2005.c         |  8 ++++----
 hw/input/tsc210x.c         |  4 ++--
 hw/intc/omap_intc.c        |  2 +-
 hw/isa/vt82c686.c          |  2 +-
 hw/mips/gt64xxx_pci.c      |  2 +-
 hw/misc/cbus.c             | 12 ++++++------
 hw/misc/omap_clk.c         |  4 ++--
 hw/misc/omap_gpmc.c        |  6 +++---
 hw/misc/omap_l4.c          |  4 ++--
 hw/misc/omap_sdrc.c        |  2 +-
 hw/misc/omap_tap.c         |  6 +++---
 hw/misc/tmp105.c           |  2 +-
 hw/pci-host/bonito.c       |  2 +-
 hw/sd/pxa2xx_mmci.c        |  6 +++---
 hw/ssi/omap_spi.c          |  6 +++---
 hw/timer/omap_gptimer.c    |  6 +++---
 hw/timer/twl92230.c        |  6 +++---
 hw/usb/desc.c              |  2 +-
 hw/usb/dev-bluetooth.c     |  4 ++--
 hw/usb/hcd-musb.c          |  4 ++--
 hw/usb/tusb6010.c          | 14 +++++++-------
 hw/xenpv/xen_domainbuild.c | 16 ++++++++--------
 hw/xenpv/xen_machine_pv.c  |  2 +-
 include/hw/arm/omap.h      | 10 +++++-----
 include/hw/arm/sharpsl.h   |  2 +-
 memory_mapping.c           |  2 +-
 migration/block.c          |  4 ++--
 ui/cursor.c                |  6 +++---
 ui/spice-display.c         |  4 ++--
 64 files changed, 272 insertions(+), 272 deletions(-)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 58005b6619..32687afced 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -463,7 +463,7 @@ static uint32_t mipid_txrx(void *opaque, uint32_t cmd, int len)
     uint8_t ret;
 
     if (len > 9) {
-        hw_error("%s: FIXME: bad SPI word width %i\n", __FUNCTION__, len);
+        hw_error("%s: FIXME: bad SPI word width %i\n", __func__, len);
     }
 
     if (s->p >= ARRAY_SIZE(s->resp)) {
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index b3e7625130..1388200191 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -999,7 +999,7 @@ static uint64_t omap_id_read(void *opaque, hwaddr addr,
         case omap1510:
             return 0x03310115;
         default:
-            hw_error("%s: bad mpu model\n", __FUNCTION__);
+            hw_error("%s: bad mpu model\n", __func__);
         }
         break;
 
@@ -1010,7 +1010,7 @@ static uint64_t omap_id_read(void *opaque, hwaddr addr,
         case omap1510:
             return 0xfb47002f;
         default:
-            hw_error("%s: bad mpu model\n", __FUNCTION__);
+            hw_error("%s: bad mpu model\n", __func__);
         }
         break;
     }
@@ -1716,7 +1716,7 @@ static void omap_clkm_write(void *opaque, hwaddr addr,
     case 0x18:	/* ARM_SYSST */
         if ((s->clkm.clocking_scheme ^ (value >> 11)) & 7) {
             s->clkm.clocking_scheme = (value >> 11) & 7;
-            printf("%s: clocking scheme set to %s\n", __FUNCTION__,
+            printf("%s: clocking scheme set to %s\n", __func__,
                             clkschemename[s->clkm.clocking_scheme]);
         }
         s->clkm.cold_start &= value & 0x3f;
@@ -2129,14 +2129,14 @@ qemu_irq *omap_mpuio_in_get(struct omap_mpuio_s *s)
 void omap_mpuio_out_set(struct omap_mpuio_s *s, int line, qemu_irq handler)
 {
     if (line >= 16 || line < 0)
-        hw_error("%s: No GPIO line %i\n", __FUNCTION__, line);
+        hw_error("%s: No GPIO line %i\n", __func__, line);
     s->handler[line] = handler;
 }
 
 void omap_mpuio_key(struct omap_mpuio_s *s, int row, int col, int down)
 {
     if (row >= 5 || row < 0)
-        hw_error("%s: No key %i-%i\n", __FUNCTION__, col, row);
+        hw_error("%s: No key %i-%i\n", __func__, col, row);
 
     if (down)
         s->buttons[row] |= 1 << col;
@@ -2313,7 +2313,7 @@ void omap_uwire_attach(struct omap_uwire_s *s,
                 uWireSlave *slave, int chipselect)
 {
     if (chipselect < 0 || chipselect > 3) {
-        fprintf(stderr, "%s: Bad chipselect %i\n", __FUNCTION__, chipselect);
+        fprintf(stderr, "%s: Bad chipselect %i\n", __func__, chipselect);
         exit(-1);
     }
 
@@ -2335,7 +2335,7 @@ static void omap_pwl_update(struct omap_pwl_s *s)
 
     if (output != s->output) {
         s->output = output;
-        printf("%s: Backlight now at %i/256\n", __FUNCTION__, output);
+        printf("%s: Backlight now at %i/256\n", __func__, output);
     }
 }
 
@@ -2473,7 +2473,7 @@ static void omap_pwt_write(void *opaque, hwaddr addr,
     case 0x04:	/* VRC */
         if ((value ^ s->vrc) & 1) {
             if (value & 1)
-                printf("%s: %iHz buzz on\n", __FUNCTION__, (int)
+                printf("%s: %iHz buzz on\n", __func__, (int)
                                 /* 1.5 MHz from a 12-MHz or 13-MHz PWT_CLK */
                                 ((omap_clk_getrate(s->clk) >> 3) /
                                  /* Pre-multiplexer divider */
@@ -2490,7 +2490,7 @@ static void omap_pwt_write(void *opaque, hwaddr addr,
                                  ((value & (1 << 5)) ?  80 : 127) /
                                  (107 * 55 * 63 * 127)));
             else
-                printf("%s: silence!\n", __FUNCTION__);
+                printf("%s: silence!\n", __func__);
         }
         s->vrc = value & 0x7f;
         break;
@@ -2562,7 +2562,7 @@ static void omap_rtc_alarm_update(struct omap_rtc_s *s)
 {
     s->alarm_ti = mktimegm(&s->alarm_tm);
     if (s->alarm_ti == -1)
-        printf("%s: conversion failed\n", __FUNCTION__);
+        printf("%s: conversion failed\n", __func__);
 }
 
 static uint64_t omap_rtc_read(void *opaque, hwaddr addr,
@@ -3028,7 +3028,7 @@ static void omap_mcbsp_source_tick(void *opaque)
     if (!s->rx_rate)
         return;
     if (s->rx_req)
-        printf("%s: Rx FIFO overrun\n", __FUNCTION__);
+        printf("%s: Rx FIFO overrun\n", __func__);
 
     s->rx_req = s->rx_rate << bps[(s->rcr[0] >> 5) & 7];
 
@@ -3074,7 +3074,7 @@ static void omap_mcbsp_sink_tick(void *opaque)
     if (!s->tx_rate)
         return;
     if (s->tx_req)
-        printf("%s: Tx FIFO underrun\n", __FUNCTION__);
+        printf("%s: Tx FIFO underrun\n", __func__);
 
     s->tx_req = s->tx_rate << bps[(s->xcr[0] >> 5) & 7];
 
@@ -3176,7 +3176,7 @@ static uint64_t omap_mcbsp_read(void *opaque, hwaddr addr,
         /* Fall through.  */
     case 0x02:	/* DRR1 */
         if (s->rx_req < 2) {
-            printf("%s: Rx FIFO underrun\n", __FUNCTION__);
+            printf("%s: Rx FIFO underrun\n", __func__);
             omap_mcbsp_rx_done(s);
         } else {
             s->tx_req -= 2;
@@ -3282,7 +3282,7 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
             if (s->tx_req < 2)
                 omap_mcbsp_tx_done(s);
         } else
-            printf("%s: Tx FIFO overrun\n", __FUNCTION__);
+            printf("%s: Tx FIFO overrun\n", __func__);
         return;
 
     case 0x08:	/* SPCR2 */
@@ -3297,7 +3297,7 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
         s->spcr[0] &= 0x0006;
         s->spcr[0] |= 0xf8f9 & value;
         if (value & (1 << 15))				/* DLB */
-            printf("%s: Digital Loopback mode enable attempt\n", __FUNCTION__);
+            printf("%s: Digital Loopback mode enable attempt\n", __func__);
         if (~value & 1) {				/* RRST */
             s->spcr[0] &= ~6;
             s->rx_req = 0;
@@ -3330,13 +3330,13 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
         s->mcr[1] = value & 0x03e3;
         if (value & 3)					/* XMCM */
             printf("%s: Tx channel selection mode enable attempt\n",
-                            __FUNCTION__);
+                            __func__);
         return;
     case 0x1a:	/* MCR1 */
         s->mcr[0] = value & 0x03e1;
         if (value & 1)					/* RMCM */
             printf("%s: Rx channel selection mode enable attempt\n",
-                            __FUNCTION__);
+                            __func__);
         return;
     case 0x1c:	/* RCERA */
         s->rcer[0] = value & 0xffff;
@@ -3418,7 +3418,7 @@ static void omap_mcbsp_writew(void *opaque, hwaddr addr,
             if (s->tx_req < 4)
                 omap_mcbsp_tx_done(s);
         } else
-            printf("%s: Tx FIFO overrun\n", __FUNCTION__);
+            printf("%s: Tx FIFO overrun\n", __func__);
         return;
     }
 
@@ -3536,7 +3536,7 @@ static void omap_lpg_tick(void *opaque)
         timer_mod(s->tm, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + s->on);
 
     s->cycle = !s->cycle;
-    printf("%s: LED is %s\n", __FUNCTION__, s->cycle ? "on" : "off");
+    printf("%s: LED is %s\n", __func__, s->cycle ? "on" : "off");
 }
 
 static void omap_lpg_update(struct omap_lpg_s *s)
@@ -3557,9 +3557,9 @@ static void omap_lpg_update(struct omap_lpg_s *s)
 
     timer_del(s->tm);
     if (on == period && s->on < s->period)
-        printf("%s: LED is on\n", __FUNCTION__);
+        printf("%s: LED is on\n", __func__);
     else if (on == 0 && s->on)
-        printf("%s: LED is off\n", __FUNCTION__);
+        printf("%s: LED is off\n", __func__);
     else if (on && (on != s->on || period != s->period)) {
         s->cycle = 0;
         s->on = on;
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index f5b148881c..b53878b8b9 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -1312,7 +1312,7 @@ static void omap_prcm_apll_update(struct omap_prcm_s *s)
 
     if (mode[0] == 1 || mode[0] == 2 || mode[1] == 1 || mode[1] == 2)
         fprintf(stderr, "%s: bad EN_54M_PLL or bad EN_96M_PLL\n",
-                        __FUNCTION__);
+                        __func__);
 }
 
 static void omap_prcm_dpll_update(struct omap_prcm_s *s)
@@ -1331,7 +1331,7 @@ static void omap_prcm_dpll_update(struct omap_prcm_s *s)
     s->dpll_lock = 0;
     switch (mode) {
     case 0:
-        fprintf(stderr, "%s: bad EN_DPLL\n", __FUNCTION__);
+        fprintf(stderr, "%s: bad EN_DPLL\n", __func__);
         break;
     case 1:	/* Low-power bypass mode (Default) */
     case 2:	/* Fast-relock bypass mode */
@@ -1358,7 +1358,7 @@ static void omap_prcm_dpll_update(struct omap_prcm_s *s)
         omap_clk_reparent(core, dpll_x2);
         break;
     case 3:
-        fprintf(stderr, "%s: bad CORE_CLK_SRC\n", __FUNCTION__);
+        fprintf(stderr, "%s: bad CORE_CLK_SRC\n", __func__);
         break;
     }
 }
@@ -1628,7 +1628,7 @@ static void omap_prcm_write(void *opaque, hwaddr addr,
     case 0x500:	/* CM_CLKEN_PLL */
         if (value & 0xffffff30)
             fprintf(stderr, "%s: write 0s in CM_CLKEN_PLL for "
-                            "future compatibility\n", __FUNCTION__);
+                            "future compatibility\n", __func__);
         if ((s->clken[9] ^ value) & 0xcc) {
             s->clken[9] &= ~0xcc;
             s->clken[9] |= value & 0xcc;
@@ -1647,7 +1647,7 @@ static void omap_prcm_write(void *opaque, hwaddr addr,
     case 0x540:	/* CM_CLKSEL1_PLL */
         if (value & 0xfc4000d7)
             fprintf(stderr, "%s: write 0s in CM_CLKSEL1_PLL for "
-                            "future compatibility\n", __FUNCTION__);
+                            "future compatibility\n", __func__);
         if ((s->clksel[5] ^ value) & 0x003fff00) {
             s->clksel[5] = value & 0x03bfff28;
             omap_prcm_dpll_update(s);
@@ -1659,7 +1659,7 @@ static void omap_prcm_write(void *opaque, hwaddr addr,
     case 0x544:	/* CM_CLKSEL2_PLL */
         if (value & ~3)
             fprintf(stderr, "%s: write 0s in CM_CLKSEL2_PLL[31:2] for "
-                            "future compatibility\n", __FUNCTION__);
+                            "future compatibility\n", __func__);
         if (s->clksel[6] != (value & 3)) {
             s->clksel[6] = value & 3;
             omap_prcm_dpll_update(s);
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index a1f55d79b4..285f43709d 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -44,7 +44,7 @@ static void static_write(void *opaque, hwaddr offset, uint64_t value,
 {
 #ifdef SPY
     printf("%s: value %08lx written at " PA_FMT "\n",
-                    __FUNCTION__, value, offset);
+                    __func__, value, offset);
 #endif
 }
 
@@ -127,11 +127,11 @@ static void palmte_onoff_gpios(void *opaque, int line, int level)
     switch (line) {
     case 0:
         printf("%s: current to MMC/SD card %sabled.\n",
-                        __FUNCTION__, level ? "dis" : "en");
+                        __func__, level ? "dis" : "en");
         break;
     case 1:
         printf("%s: internal speaker amplifier %s.\n",
-                        __FUNCTION__, level ? "down" : "on");
+                        __func__, level ? "down" : "on");
         break;
 
     /* These LCD & Audio output signals have not been identified yet.  */
@@ -139,12 +139,12 @@ static void palmte_onoff_gpios(void *opaque, int line, int level)
     case 3:
     case 4:
         printf("%s: LCD GPIO%i %s.\n",
-                        __FUNCTION__, line - 1, level ? "high" : "low");
+                        __func__, line - 1, level ? "high" : "low");
         break;
     case 5:
     case 6:
         printf("%s: Audio GPIO%i %s.\n",
-                        __FUNCTION__, line - 4, level ? "high" : "low");
+                        __func__, line - 4, level ? "high" : "low");
         break;
     }
 }
@@ -234,7 +234,7 @@ static void palmte_init(MachineState *machine)
         rom_size = get_image_size(option_rom[0].name);
         if (rom_size > flash_size) {
             fprintf(stderr, "%s: ROM image too big (%x > %x)\n",
-                            __FUNCTION__, rom_size, flash_size);
+                            __func__, rom_size, flash_size);
             rom_size = 0;
         }
         if (rom_size > 0) {
@@ -244,7 +244,7 @@ static void palmte_init(MachineState *machine)
         }
         if (rom_size < 0) {
             fprintf(stderr, "%s: error loading '%s'\n",
-                            __FUNCTION__, option_rom[0].name);
+                            __func__, option_rom[0].name);
         }
     }
 
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index ab691a7985..db860c238e 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -107,7 +107,7 @@ static uint64_t pxa2xx_pm_read(void *opaque, hwaddr addr,
         return s->pm_regs[addr >> 2];
     default:
     fail:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
         break;
     }
     return 0;
@@ -139,7 +139,7 @@ static void pxa2xx_pm_write(void *opaque, hwaddr addr,
             break;
         }
 
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
         break;
     }
 }
@@ -180,7 +180,7 @@ static uint64_t pxa2xx_cm_read(void *opaque, hwaddr addr,
         return s->cm_regs[CCCR >> 2] | (3 << 28);
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
         break;
     }
     return 0;
@@ -205,7 +205,7 @@ static void pxa2xx_cm_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
         break;
     }
 }
@@ -410,7 +410,7 @@ static uint64_t pxa2xx_mm_read(void *opaque, hwaddr addr,
             return s->mm_regs[addr >> 2];
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
         break;
     }
     return 0;
@@ -429,7 +429,7 @@ static void pxa2xx_mm_write(void *opaque, hwaddr addr,
         }
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
         break;
     }
 }
@@ -619,7 +619,7 @@ static uint64_t pxa2xx_ssp_read(void *opaque, hwaddr addr,
         if (!s->enable)
             return 0xffffffff;
         if (s->rx_level < 1) {
-            printf("%s: SSP Rx Underrun\n", __FUNCTION__);
+            printf("%s: SSP Rx Underrun\n", __func__);
             return 0xffffffff;
         }
         s->rx_level --;
@@ -636,7 +636,7 @@ static uint64_t pxa2xx_ssp_read(void *opaque, hwaddr addr,
     case SSACD:
         return s->ssacd;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
         break;
     }
     return 0;
@@ -653,9 +653,9 @@ static void pxa2xx_ssp_write(void *opaque, hwaddr addr,
         s->sscr[0] = value & 0xc7ffffff;
         s->enable = value & SSCR0_SSE;
         if (value & SSCR0_MOD)
-            printf("%s: Attempt to use network mode\n", __FUNCTION__);
+            printf("%s: Attempt to use network mode\n", __func__);
         if (s->enable && SSCR0_DSS(value) < 4)
-            printf("%s: Wrong data size: %i bits\n", __FUNCTION__,
+            printf("%s: Wrong data size: %i bits\n", __func__,
                             SSCR0_DSS(value));
         if (!(value & SSCR0_SSE)) {
             s->sssr = 0;
@@ -668,7 +668,7 @@ static void pxa2xx_ssp_write(void *opaque, hwaddr addr,
     case SSCR1:
         s->sscr[1] = value;
         if (value & (SSCR1_LBM | SSCR1_EFWR))
-            printf("%s: Attempt to use SSP test mode\n", __FUNCTION__);
+            printf("%s: Attempt to use SSP test mode\n", __func__);
         pxa2xx_ssp_fifo_update(s);
         break;
 
@@ -728,7 +728,7 @@ static void pxa2xx_ssp_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
         break;
     }
 }
@@ -990,7 +990,7 @@ static uint64_t pxa2xx_rtc_read(void *opaque, hwaddr addr,
         else
             return s->last_swcr;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
         break;
     }
     return 0;
@@ -1096,7 +1096,7 @@ static void pxa2xx_rtc_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
     }
 }
 
@@ -1344,7 +1344,7 @@ static uint64_t pxa2xx_i2c_read(void *opaque, hwaddr addr,
             s->ibmr = 0;
         return s->ibmr;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
         break;
     }
     return 0;
@@ -1417,7 +1417,7 @@ static void pxa2xx_i2c_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
     }
 }
 
@@ -1618,7 +1618,7 @@ static uint64_t pxa2xx_i2s_read(void *opaque, hwaddr addr,
         }
         return 0;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
         break;
     }
     return 0;
@@ -1641,14 +1641,14 @@ static void pxa2xx_i2s_write(void *opaque, hwaddr addr,
             s->status &= ~(1 << 7);			/* I2SOFF */
         }
         if (value & (1 << 4))				/* EFWR */
-            printf("%s: Attempt to use special function\n", __FUNCTION__);
+            printf("%s: Attempt to use special function\n", __func__);
         s->enable = (value & 9) == 1;			/* ENB && !RST*/
         pxa2xx_i2s_update(s);
         break;
     case SACR1:
         s->control[1] = value & 0x0039;
         if (value & (1 << 5))				/* ENLBF */
-            printf("%s: Attempt to use loopback function\n", __FUNCTION__);
+            printf("%s: Attempt to use loopback function\n", __func__);
         if (value & (1 << 4))				/* DPRL */
             s->fifo_len = 0;
         pxa2xx_i2s_update(s);
@@ -1675,7 +1675,7 @@ static void pxa2xx_i2s_write(void *opaque, hwaddr addr,
         }
         break;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
     }
 }
 
@@ -1851,7 +1851,7 @@ static uint64_t pxa2xx_fir_read(void *opaque, hwaddr addr,
             pxa2xx_fir_update(s);
             return ret;
         }
-        printf("%s: Rx FIFO underrun.\n", __FUNCTION__);
+        printf("%s: Rx FIFO underrun.\n", __func__);
         break;
     case ICSR0:
         return s->status[0];
@@ -1860,7 +1860,7 @@ static uint64_t pxa2xx_fir_read(void *opaque, hwaddr addr,
     case ICFOR:
         return s->rx_len;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
         break;
     }
     return 0;
@@ -1912,7 +1912,7 @@ static void pxa2xx_fir_write(void *opaque, hwaddr addr,
     case ICFOR:
         break;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __FUNCTION__, addr);
+        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
     }
 }
 
diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index 521dbad039..e15070188e 100644
--- a/hw/arm/pxa2xx_gpio.c
+++ b/hw/arm/pxa2xx_gpio.c
@@ -107,7 +107,7 @@ static void pxa2xx_gpio_set(void *opaque, int line, int level)
     uint32_t mask;
 
     if (line >= s->lines) {
-        printf("%s: No GPIO pin %i\n", __FUNCTION__, line);
+        printf("%s: No GPIO pin %i\n", __func__, line);
         return;
     }
 
@@ -195,7 +195,7 @@ static uint64_t pxa2xx_gpio_read(void *opaque, hwaddr offset,
         return s->status[bank];
 
     default:
-        hw_error("%s: Bad offset " REG_FMT "\n", __FUNCTION__, offset);
+        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
     }
 
     return 0;
@@ -248,7 +248,7 @@ static void pxa2xx_gpio_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        hw_error("%s: Bad offset " REG_FMT "\n", __FUNCTION__, offset);
+        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
     }
 }
 
diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index b516ced8c0..61275fa040 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -165,7 +165,7 @@ static uint64_t pxa2xx_pic_mem_read(void *opaque, hwaddr offset,
     case ICHP:	/* Highest Priority register */
         return pxa2xx_pic_highest(s);
     default:
-        printf("%s: Bad register offset " REG_FMT "\n", __FUNCTION__, offset);
+        printf("%s: Bad register offset " REG_FMT "\n", __func__, offset);
         return 0;
     }
 }
@@ -198,7 +198,7 @@ static void pxa2xx_pic_mem_write(void *opaque, hwaddr offset,
         s->priority[32 + ((offset - IPR32) >> 2)] = value & 0x8000003f;
         break;
     default:
-        printf("%s: Bad register offset " REG_FMT "\n", __FUNCTION__, offset);
+        printf("%s: Bad register offset " REG_FMT "\n", __func__, offset);
         return;
     }
     pxa2xx_pic_update(opaque);
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 044796350a..a55b1a369c 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -159,7 +159,7 @@ static int tosa_dac_send(I2CSlave *i2c, uint8_t data)
     s->buf[s->len] = data;
     if (s->len ++ > 2) {
 #ifdef VERBOSE
-        fprintf(stderr, "%s: message too long (%i bytes)\n", __FUNCTION__, s->len);
+        fprintf(stderr, "%s: message too long (%i bytes)\n", __func__, s->len);
 #endif
         return 1;
     }
@@ -181,14 +181,14 @@ static int tosa_dac_event(I2CSlave *i2c, enum i2c_event event)
     case I2C_START_SEND:
         break;
     case I2C_START_RECV:
-        printf("%s: recv not supported!!!\n", __FUNCTION__);
+        printf("%s: recv not supported!!!\n", __func__);
         break;
     case I2C_FINISH:
 #ifdef VERBOSE
         if (s->len < 2)
-            printf("%s: message too short (%i bytes)\n", __FUNCTION__, s->len);
+            printf("%s: message too short (%i bytes)\n", __func__, s->len);
         if (s->len > 2)
-            printf("%s: message too long\n", __FUNCTION__);
+            printf("%s: message too long\n", __func__);
 #endif
         break;
     default:
@@ -200,7 +200,7 @@ static int tosa_dac_event(I2CSlave *i2c, enum i2c_event event)
 
 static int tosa_dac_recv(I2CSlave *s)
 {
-    printf("%s: recv not supported!!!\n", __FUNCTION__);
+    printf("%s: recv not supported!!!\n", __func__);
     return -1;
 }
 
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 5402cd196c..e8aa7842e6 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -316,7 +316,7 @@ static void hda_audio_command(HDACodecDevice *hda, uint32_t nid, uint32_t data)
         goto fail;
     }
     dprint(a, 2, "%s: nid %d (%s), verb 0x%x, payload 0x%x\n",
-           __FUNCTION__, nid, node->name, verb, payload);
+           __func__, nid, node->name, verb, payload);
 
     switch (verb) {
     /* all nodes */
@@ -449,7 +449,7 @@ static void hda_audio_command(HDACodecDevice *hda, uint32_t nid, uint32_t data)
 
 fail:
     dprint(a, 1, "%s: not handled: nid %d (%s), verb 0x%x, payload 0x%x\n",
-           __FUNCTION__, nid, node ? node->name : "?", verb, payload);
+           __func__, nid, node ? node->name : "?", verb, payload);
     hda_codec_response(hda, true, 0);
 }
 
@@ -484,7 +484,7 @@ static int hda_audio_init(HDACodecDevice *hda, const struct desc_codec *desc)
 
     a->desc = desc;
     a->name = object_get_typename(OBJECT(a));
-    dprint(a, 1, "%s: cad %d\n", __FUNCTION__, a->hda.cad);
+    dprint(a, 1, "%s: cad %d\n", __func__, a->hda.cad);
 
     AUD_register_card("hda", &a->card);
     for (i = 0; i < a->desc->nnodes; i++) {
@@ -526,7 +526,7 @@ static void hda_audio_exit(HDACodecDevice *hda)
     HDAAudioStream *st;
     int i;
 
-    dprint(a, 1, "%s\n", __FUNCTION__);
+    dprint(a, 1, "%s\n", __func__);
     for (i = 0; i < ARRAY_SIZE(a->st); i++) {
         st = a->st + i;
         if (st->node == NULL) {
@@ -547,7 +547,7 @@ static int hda_audio_post_load(void *opaque, int version)
     HDAAudioStream *st;
     int i;
 
-    dprint(a, 1, "%s\n", __FUNCTION__);
+    dprint(a, 1, "%s\n", __func__);
     if (version == 1) {
         /* assume running_compat[] is for output streams */
         for (i = 0; i < ARRAY_SIZE(a->running_compat); i++)
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index a3e670c188..948268afd8 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -265,7 +265,7 @@ static void intel_hda_update_irq(IntelHDAState *d)
     } else {
         level = 0;
     }
-    dprint(d, 2, "%s: level %d [%s]\n", __FUNCTION__,
+    dprint(d, 2, "%s: level %d [%s]\n", __func__,
            level, msi ? "msi" : "intx");
     if (msi) {
         if (level) {
@@ -285,7 +285,7 @@ static int intel_hda_send_command(IntelHDAState *d, uint32_t verb)
     cad = (verb >> 28) & 0x0f;
     if (verb & (1 << 27)) {
         /* indirect node addressing, not specified in HDA 1.0 */
-        dprint(d, 1, "%s: indirect node addressing (guest bug?)\n", __FUNCTION__);
+        dprint(d, 1, "%s: indirect node addressing (guest bug?)\n", __func__);
         return -1;
     }
     nid = (verb >> 20) & 0x7f;
@@ -293,7 +293,7 @@ static int intel_hda_send_command(IntelHDAState *d, uint32_t verb)
 
     codec = hda_codec_find(&d->codecs, cad);
     if (codec == NULL) {
-        dprint(d, 1, "%s: addressed non-existing codec\n", __FUNCTION__);
+        dprint(d, 1, "%s: addressed non-existing codec\n", __func__);
         return -1;
     }
     cdc = HDA_CODEC_DEVICE_GET_CLASS(codec);
@@ -307,22 +307,22 @@ static void intel_hda_corb_run(IntelHDAState *d)
     uint32_t rp, verb;
 
     if (d->ics & ICH6_IRS_BUSY) {
-        dprint(d, 2, "%s: [icw] verb 0x%08x\n", __FUNCTION__, d->icw);
+        dprint(d, 2, "%s: [icw] verb 0x%08x\n", __func__, d->icw);
         intel_hda_send_command(d, d->icw);
         return;
     }
 
     for (;;) {
         if (!(d->corb_ctl & ICH6_CORBCTL_RUN)) {
-            dprint(d, 2, "%s: !run\n", __FUNCTION__);
+            dprint(d, 2, "%s: !run\n", __func__);
             return;
         }
         if ((d->corb_rp & 0xff) == d->corb_wp) {
-            dprint(d, 2, "%s: corb ring empty\n", __FUNCTION__);
+            dprint(d, 2, "%s: corb ring empty\n", __func__);
             return;
         }
         if (d->rirb_count == d->rirb_cnt) {
-            dprint(d, 2, "%s: rirb count reached\n", __FUNCTION__);
+            dprint(d, 2, "%s: rirb count reached\n", __func__);
             return;
         }
 
@@ -331,7 +331,7 @@ static void intel_hda_corb_run(IntelHDAState *d)
         verb = ldl_le_pci_dma(&d->pci, addr + 4*rp);
         d->corb_rp = rp;
 
-        dprint(d, 2, "%s: [rp 0x%x] verb 0x%08x\n", __FUNCTION__, rp, verb);
+        dprint(d, 2, "%s: [rp 0x%x] verb 0x%08x\n", __func__, rp, verb);
         intel_hda_send_command(d, verb);
     }
 }
@@ -345,7 +345,7 @@ static void intel_hda_response(HDACodecDevice *dev, bool solicited, uint32_t res
 
     if (d->ics & ICH6_IRS_BUSY) {
         dprint(d, 2, "%s: [irr] response 0x%x, cad 0x%x\n",
-               __FUNCTION__, response, dev->cad);
+               __func__, response, dev->cad);
         d->irr = response;
         d->ics &= ~(ICH6_IRS_BUSY | 0xf0);
         d->ics |= (ICH6_IRS_VALID | (dev->cad << 4));
@@ -353,7 +353,7 @@ static void intel_hda_response(HDACodecDevice *dev, bool solicited, uint32_t res
     }
 
     if (!(d->rirb_ctl & ICH6_RBCTL_DMA_EN)) {
-        dprint(d, 1, "%s: rirb dma disabled, drop codec response\n", __FUNCTION__);
+        dprint(d, 1, "%s: rirb dma disabled, drop codec response\n", __func__);
         return;
     }
 
@@ -365,17 +365,17 @@ static void intel_hda_response(HDACodecDevice *dev, bool solicited, uint32_t res
     d->rirb_wp = wp;
 
     dprint(d, 2, "%s: [wp 0x%x] response 0x%x, extra 0x%x\n",
-           __FUNCTION__, wp, response, ex);
+           __func__, wp, response, ex);
 
     d->rirb_count++;
     if (d->rirb_count == d->rirb_cnt) {
-        dprint(d, 2, "%s: rirb count reached (%d)\n", __FUNCTION__, d->rirb_count);
+        dprint(d, 2, "%s: rirb count reached (%d)\n", __func__, d->rirb_count);
         if (d->rirb_ctl & ICH6_RBCTL_IRQ_EN) {
             d->rirb_sts |= ICH6_RBSTS_IRQ;
             intel_hda_update_irq(d);
         }
     } else if ((d->corb_rp & 0xff) == d->corb_wp) {
-        dprint(d, 2, "%s: corb ring empty (%d/%d)\n", __FUNCTION__,
+        dprint(d, 2, "%s: corb ring empty (%d/%d)\n", __func__,
                d->rirb_count, d->rirb_cnt);
         if (d->rirb_ctl & ICH6_RBCTL_IRQ_EN) {
             d->rirb_sts |= ICH6_RBSTS_IRQ;
@@ -1144,7 +1144,7 @@ static int intel_hda_post_load(void *opaque, int version)
     IntelHDAState* d = opaque;
     int i;
 
-    dprint(d, 1, "%s\n", __FUNCTION__);
+    dprint(d, 1, "%s\n", __func__);
     for (i = 0; i < ARRAY_SIZE(d->st); i++) {
         if (d->st[i].ctl & 0x02) {
             intel_hda_parse_bdl(d, &d->st[i]);
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 8bb44a7cc1..6d8b728923 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -315,7 +315,7 @@ static int wm8750_event(I2CSlave *i2c, enum i2c_event event)
 #ifdef VERBOSE
         if (s->i2c_len < 2)
             printf("%s: message too short (%i bytes)\n",
-                            __FUNCTION__, s->i2c_len);
+                            __func__, s->i2c_len);
 #endif
         break;
     default:
@@ -555,7 +555,7 @@ static int wm8750_tx(I2CSlave *i2c, uint8_t data)
 
 #ifdef VERBOSE
     default:
-        printf("%s: unknown register %02x\n", __FUNCTION__, cmd);
+        printf("%s: unknown register %02x\n", __func__, cmd);
 #endif
     }
 
diff --git a/hw/block/nand.c b/hw/block/nand.c
index 76dcd3f76e..919cb9b803 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -321,7 +321,7 @@ static void nand_command(NANDFlashState *s)
         break;
 
     default:
-        printf("%s: Unknown NAND command 0x%02x\n", __FUNCTION__, s->cmd);
+        printf("%s: Unknown NAND command 0x%02x\n", __func__, s->cmd);
     }
 }
 
@@ -640,7 +640,7 @@ DeviceState *nand_init(BlockBackend *blk, int manf_id, int chip_id)
     DeviceState *dev;
 
     if (nand_flash_ids[chip_id].size == 0) {
-        hw_error("%s: Unsupported NAND chip ID.\n", __FUNCTION__);
+        hw_error("%s: Unsupported NAND chip ID.\n", __func__);
     }
     dev = DEVICE(object_new(TYPE_NAND));
     qdev_prop_set_uint8(dev, "manufacturer_id", manf_id);
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index de65c9ebb9..e243182394 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -659,12 +659,12 @@ static uint64_t onenand_read(void *opaque, hwaddr addr,
     case 0xff02:	/* ECC Result of spare area data */
     case 0xff03:	/* ECC Result of main area data */
     case 0xff04:	/* ECC Result of spare area data */
-        hw_error("%s: imeplement ECC\n", __FUNCTION__);
+        hw_error("%s: imeplement ECC\n", __func__);
         return 0x0000;
     }
 
     fprintf(stderr, "%s: unknown OneNAND register %x\n",
-                    __FUNCTION__, offset);
+                    __func__, offset);
     return 0;
 }
 
@@ -709,7 +709,7 @@ static void onenand_write(void *opaque, hwaddr addr,
 
         default:
             fprintf(stderr, "%s: unknown OneNAND boot command %"PRIx64"\n",
-                            __FUNCTION__, value);
+                            __func__, value);
         }
         break;
 
@@ -760,7 +760,7 @@ static void onenand_write(void *opaque, hwaddr addr,
 
     default:
         fprintf(stderr, "%s: unknown OneNAND register %x\n",
-                        __FUNCTION__, offset);
+                        __func__, offset);
     }
 }
 
diff --git a/hw/bt/core.c b/hw/bt/core.c
index 615f0af073..c1806b71a3 100644
--- a/hw/bt/core.c
+++ b/hw/bt/core.c
@@ -32,23 +32,23 @@ static void bt_dummy_lmp_connection_complete(struct bt_link_s *link)
 {
     if (link->slave->reject_reason)
         fprintf(stderr, "%s: stray LMP_not_accepted received, fixme\n",
-                        __FUNCTION__);
+                        __func__);
     else
         fprintf(stderr, "%s: stray LMP_accepted received, fixme\n",
-                        __FUNCTION__);
+                        __func__);
     exit(-1);
 }
 
 static void bt_dummy_lmp_disconnect_master(struct bt_link_s *link)
 {
-    fprintf(stderr, "%s: stray LMP_detach received, fixme\n", __FUNCTION__);
+    fprintf(stderr, "%s: stray LMP_detach received, fixme\n", __func__);
     exit(-1);
 }
 
 static void bt_dummy_lmp_acl_resp(struct bt_link_s *link,
                 const uint8_t *data, int start, int len)
 {
-    fprintf(stderr, "%s: stray ACL response PDU, fixme\n", __FUNCTION__);
+    fprintf(stderr, "%s: stray ACL response PDU, fixme\n", __func__);
     exit(-1);
 }
 
@@ -113,7 +113,7 @@ void bt_device_done(struct bt_device_s *dev)
     while (*p && *p != dev)
         p = &(*p)->next;
     if (*p != dev) {
-        fprintf(stderr, "%s: bad bt device \"%s\"\n", __FUNCTION__,
+        fprintf(stderr, "%s: bad bt device \"%s\"\n", __func__,
                         dev->lmp_name ?: "(null)");
         exit(-1);
     }
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index d13192b9b5..ac067b81f6 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -111,14 +111,14 @@ static uint8_t *csrhci_out_packet(struct csrhci_s *s, int len)
 
     if (off < FIFO_LEN) {
         if (off + len > FIFO_LEN && (s->out_size = off + len) > FIFO_LEN * 2) {
-            fprintf(stderr, "%s: can't alloc %i bytes\n", __FUNCTION__, len);
+            fprintf(stderr, "%s: can't alloc %i bytes\n", __func__, len);
             exit(-1);
         }
         return s->outfifo + off;
     }
 
     if (s->out_len > s->out_size) {
-        fprintf(stderr, "%s: can't alloc %i bytes\n", __FUNCTION__, len);
+        fprintf(stderr, "%s: can't alloc %i bytes\n", __func__, len);
         exit(-1);
     }
 
@@ -169,7 +169,7 @@ static void csrhci_in_packet_vendor(struct csrhci_s *s, int ocf,
 
             s->hci->bdaddr_set(s->hci, s->bd_addr.b);
             fprintf(stderr, "%s: bd_address loaded from firmware: "
-                            "%02x:%02x:%02x:%02x:%02x:%02x\n", __FUNCTION__,
+                            "%02x:%02x:%02x:%02x:%02x:%02x\n", __func__,
                             s->bd_addr.b[0], s->bd_addr.b[1], s->bd_addr.b[2],
                             s->bd_addr.b[3], s->bd_addr.b[4], s->bd_addr.b[5]);
         }
@@ -181,7 +181,7 @@ static void csrhci_in_packet_vendor(struct csrhci_s *s, int ocf,
         break;
 
     default:
-        fprintf(stderr, "%s: got a bad CMD packet\n", __FUNCTION__);
+        fprintf(stderr, "%s: got a bad CMD packet\n", __func__);
         return;
     }
 
@@ -226,7 +226,7 @@ static void csrhci_in_packet(struct csrhci_s *s, uint8_t *pkt)
     case H4_NEG_PKT:
         if (s->in_hdr != sizeof(csrhci_neg_packet) ||
                         memcmp(pkt - 1, csrhci_neg_packet, s->in_hdr)) {
-            fprintf(stderr, "%s: got a bad NEG packet\n", __FUNCTION__);
+            fprintf(stderr, "%s: got a bad NEG packet\n", __func__);
             return;
         }
         pkt += 2;
@@ -241,7 +241,7 @@ static void csrhci_in_packet(struct csrhci_s *s, uint8_t *pkt)
 
     case H4_ALIVE_PKT:
         if (s->in_hdr != 4 || pkt[1] != 0x55 || pkt[2] != 0x00) {
-            fprintf(stderr, "%s: got a bad ALIVE packet\n", __FUNCTION__);
+            fprintf(stderr, "%s: got a bad ALIVE packet\n", __func__);
             return;
         }
 
@@ -254,7 +254,7 @@ static void csrhci_in_packet(struct csrhci_s *s, uint8_t *pkt)
     default:
     bad_pkt:
         /* TODO: error out */
-        fprintf(stderr, "%s: got a bad packet\n", __FUNCTION__);
+        fprintf(stderr, "%s: got a bad packet\n", __func__);
         break;
     }
 
diff --git a/hw/bt/hci.c b/hw/bt/hci.c
index 476ebec0ab..df05f07887 100644
--- a/hw/bt/hci.c
+++ b/hw/bt/hci.c
@@ -458,7 +458,7 @@ static inline uint8_t *bt_hci_event_start(struct bt_hci_s *hci,
 
     if (len > 255) {
         fprintf(stderr, "%s: HCI event params too long (%ib)\n",
-                        __FUNCTION__, len);
+                        __func__, len);
         exit(-1);
     }
 
@@ -589,7 +589,7 @@ static void bt_hci_inquiry_result(struct bt_hci_s *hci,
         bt_hci_inquiry_result_with_rssi(hci, slave);
         return;
     default:
-        fprintf(stderr, "%s: bad inquiry mode %02x\n", __FUNCTION__,
+        fprintf(stderr, "%s: bad inquiry mode %02x\n", __func__,
                         hci->lm.inquiry_mode);
         exit(-1);
     }
@@ -1528,7 +1528,7 @@ static void bt_submit_hci(struct HCIInfo *info,
                             "the Inquiry command has been issued, a Command "
                             "Status event has been received for the Inquiry "
                             "command, and before the Inquiry Complete event "
-                            "occurs", __FUNCTION__);
+                            "occurs", __func__);
             bt_hci_event_complete_status(hci, HCI_COMMAND_DISALLOWED);
             break;
         }
@@ -1567,7 +1567,7 @@ static void bt_submit_hci(struct HCIInfo *info,
                             "the Inquiry command has been issued, a Command "
                             "Status event has been received for the Inquiry "
                             "command, and before the Inquiry Complete event "
-                            "occurs", __FUNCTION__);
+                            "occurs", __func__);
             bt_hci_event_complete_status(hci, HCI_COMMAND_DISALLOWED);
             break;
         }
@@ -1972,7 +1972,7 @@ static void bt_submit_hci(struct HCIInfo *info,
 
     short_hci:
         fprintf(stderr, "%s: HCI packet too short (%iB)\n",
-                        __FUNCTION__, length);
+                        __func__, length);
         bt_hci_event_status(hci, HCI_INVALID_PARAMETERS);
         break;
     }
@@ -1992,7 +1992,7 @@ static inline void bt_hci_lmp_acl_data(struct bt_hci_s *hci, uint16_t handle,
 
     if (len + HCI_ACL_HDR_SIZE > sizeof(hci->acl_buf)) {
         fprintf(stderr, "%s: can't take ACL packets %i bytes long\n",
-                        __FUNCTION__, len);
+                        __func__, len);
         return;
     }
     memcpy(hci->acl_buf + HCI_ACL_HDR_SIZE, data, len);
@@ -2030,7 +2030,7 @@ static void bt_submit_acl(struct HCIInfo *info,
 
     if (length < HCI_ACL_HDR_SIZE) {
         fprintf(stderr, "%s: ACL packet too short (%iB)\n",
-                        __FUNCTION__, length);
+                        __func__, length);
         return;
     }
 
@@ -2042,7 +2042,7 @@ static void bt_submit_acl(struct HCIInfo *info,
 
     if (bt_hci_handle_bad(hci, handle)) {
         fprintf(stderr, "%s: invalid ACL handle %03x\n",
-                        __FUNCTION__, handle);
+                        __func__, handle);
         /* TODO: signal an error */
         return;
     }
@@ -2050,7 +2050,7 @@ static void bt_submit_acl(struct HCIInfo *info,
 
     if (datalen > length) {
         fprintf(stderr, "%s: ACL packet too short (%iB < %iB)\n",
-                        __FUNCTION__, length, datalen);
+                        __func__, length, datalen);
         return;
     }
 
@@ -2061,7 +2061,7 @@ static void bt_submit_acl(struct HCIInfo *info,
             hci->asb_handle = handle;
         else if (handle != hci->asb_handle) {
             fprintf(stderr, "%s: Bad handle %03x in Active Slave Broadcast\n",
-                            __FUNCTION__, handle);
+                            __func__, handle);
             /* TODO: signal an error */
             return;
         }
@@ -2074,7 +2074,7 @@ static void bt_submit_acl(struct HCIInfo *info,
             hci->psb_handle = handle;
         else if (handle != hci->psb_handle) {
             fprintf(stderr, "%s: Bad handle %03x in Parked Slave Broadcast\n",
-                            __FUNCTION__, handle);
+                            __func__, handle);
             /* TODO: signal an error */
             return;
         }
@@ -2106,13 +2106,13 @@ static void bt_submit_sco(struct HCIInfo *info,
 
     if (bt_hci_handle_bad(hci, handle)) {
         fprintf(stderr, "%s: invalid SCO handle %03x\n",
-                        __FUNCTION__, handle);
+                        __func__, handle);
         return;
     }
 
     if (datalen > length) {
         fprintf(stderr, "%s: SCO packet too short (%iB < %iB)\n",
-                        __FUNCTION__, length, datalen);
+                        __func__, length, datalen);
         return;
     }
 
diff --git a/hw/bt/hid.c b/hw/bt/hid.c
index f6affbbb44..09d17322e4 100644
--- a/hw/bt/hid.c
+++ b/hw/bt/hid.c
@@ -420,7 +420,7 @@ static void bt_hid_interrupt_sdu(void *opaque, const uint8_t *data, int len)
     return;
 bad:
     fprintf(stderr, "%s: bad transaction on Interrupt channel.\n",
-                    __FUNCTION__);
+                    __func__);
 }
 
 /* "Virtual cable" plug/unplug event.  */
diff --git a/hw/bt/l2cap.c b/hw/bt/l2cap.c
index e342045140..3e53dd082d 100644
--- a/hw/bt/l2cap.c
+++ b/hw/bt/l2cap.c
@@ -468,7 +468,7 @@ static void l2cap_channel_close(struct l2cap_instance_s *l2cap,
     if (likely(ch)) {
         if (ch->remote_cid != source_cid) {
             fprintf(stderr, "%s: Ignoring a Disconnection Request with the "
-                            "invalid SCID %04x.\n", __FUNCTION__, source_cid);
+                            "invalid SCID %04x.\n", __func__, source_cid);
             return;
         }
 
@@ -791,7 +791,7 @@ static void l2cap_command(struct l2cap_instance_s *l2cap, int code, int id,
     /* TODO: do the IDs really have to be in sequence?  */
     if (!id || (id != l2cap->last_id && id != l2cap->next_id)) {
         fprintf(stderr, "%s: out of sequence command packet ignored.\n",
-                        __FUNCTION__);
+                        __func__);
         return;
     }
 #else
@@ -814,7 +814,7 @@ static void l2cap_command(struct l2cap_instance_s *l2cap, int code, int id,
 
         /* We never issue commands other than Command Reject currently.  */
         fprintf(stderr, "%s: stray Command Reject (%02x, %04x) "
-                        "packet, ignoring.\n", __FUNCTION__, id,
+                        "packet, ignoring.\n", __func__, id,
                         le16_to_cpu(((l2cap_cmd_rej *) params)->reason));
         break;
 
@@ -837,7 +837,7 @@ static void l2cap_command(struct l2cap_instance_s *l2cap, int code, int id,
 
         /* We never issue Connection Requests currently. TODO  */
         fprintf(stderr, "%s: unexpected Connection Response (%02x) "
-                        "packet, ignoring.\n", __FUNCTION__, id);
+                        "packet, ignoring.\n", __func__, id);
         break;
 
     case L2CAP_CONF_REQ:
@@ -866,7 +866,7 @@ static void l2cap_command(struct l2cap_instance_s *l2cap, int code, int id,
                         ((l2cap_conf_rsp *) params)->data,
                         len - L2CAP_CONF_RSP_SIZE(0)))
             fprintf(stderr, "%s: unexpected Configure Response (%02x) "
-                            "packet, ignoring.\n", __FUNCTION__, id);
+                            "packet, ignoring.\n", __func__, id);
         break;
 
     case L2CAP_DISCONN_REQ:
@@ -888,7 +888,7 @@ static void l2cap_command(struct l2cap_instance_s *l2cap, int code, int id,
 
         /* We never issue Disconnection Requests currently. TODO  */
         fprintf(stderr, "%s: unexpected Disconnection Response (%02x) "
-                        "packet, ignoring.\n", __FUNCTION__, id);
+                        "packet, ignoring.\n", __func__, id);
         break;
 
     case L2CAP_ECHO_REQ:
@@ -898,7 +898,7 @@ static void l2cap_command(struct l2cap_instance_s *l2cap, int code, int id,
     case L2CAP_ECHO_RSP:
         /* We never issue Echo Requests currently. TODO  */
         fprintf(stderr, "%s: unexpected Echo Response (%02x) "
-                        "packet, ignoring.\n", __FUNCTION__, id);
+                        "packet, ignoring.\n", __func__, id);
         break;
 
     case L2CAP_INFO_REQ:
@@ -918,7 +918,7 @@ static void l2cap_command(struct l2cap_instance_s *l2cap, int code, int id,
 
         /* We never issue Information Requests currently. TODO  */
         fprintf(stderr, "%s: unexpected Information Response (%02x) "
-                        "packet, ignoring.\n", __FUNCTION__, id);
+                        "packet, ignoring.\n", __func__, id);
         break;
 
     default:
@@ -1067,7 +1067,7 @@ static void l2cap_frame_in(struct l2cap_instance_s *l2cap,
 
     if (unlikely(cid >= L2CAP_CID_MAX || !l2cap->cid[cid])) {
         fprintf(stderr, "%s: frame addressed to a non-existent L2CAP "
-                        "channel %04x received.\n", __FUNCTION__, cid);
+                        "channel %04x received.\n", __func__, cid);
         return;
     }
 
@@ -1129,7 +1129,7 @@ static uint8_t *l2cap_bframe_out(struct bt_l2cap_conn_params_s *parm, int len)
 
     if (len > chan->params.remote_mtu) {
         fprintf(stderr, "%s: B-Frame for CID %04x longer than %i octets.\n",
-                        __FUNCTION__,
+                        __func__,
                         chan->remote_cid, chan->params.remote_mtu);
         exit(-1);
     }
@@ -1354,7 +1354,7 @@ void bt_l2cap_psm_register(struct bt_l2cap_device_s *dev, int psm, int min_mtu,
 
     if (new_psm) {
         fprintf(stderr, "%s: PSM %04x already registered for device `%s'.\n",
-                        __FUNCTION__, psm, dev->device.lmp_name);
+                        __func__, psm, dev->device.lmp_name);
         exit(-1);
     }
 
diff --git a/hw/bt/sdp.c b/hw/bt/sdp.c
index 3cb60b9495..7c0d38b504 100644
--- a/hw/bt/sdp.c
+++ b/hw/bt/sdp.c
@@ -506,7 +506,7 @@ static void bt_l2cap_sdp_sdu_in(void *opaque, const uint8_t *data, int len)
     int rsp_len = 0;
 
     if (len < 5) {
-        fprintf(stderr, "%s: short SDP PDU (%iB).\n", __FUNCTION__, len);
+        fprintf(stderr, "%s: short SDP PDU (%iB).\n", __func__, len);
         return;
     }
 
@@ -518,7 +518,7 @@ static void bt_l2cap_sdp_sdu_in(void *opaque, const uint8_t *data, int len)
 
     if (len != plen) {
         fprintf(stderr, "%s: wrong SDP PDU length (%iB != %iB).\n",
-                        __FUNCTION__, plen, len);
+                        __func__, plen, len);
         err = SDP_INVALID_PDU_SIZE;
         goto respond;
     }
@@ -545,7 +545,7 @@ static void bt_l2cap_sdp_sdu_in(void *opaque, const uint8_t *data, int len)
     case SDP_SVC_SEARCH_ATTR_RSP:
     default:
         fprintf(stderr, "%s: unexpected SDP PDU ID %02x.\n",
-                        __FUNCTION__, pdu_id);
+                        __func__, pdu_id);
         err = SDP_INVALID_SYNTAX;
         break;
     }
diff --git a/hw/display/blizzard.c b/hw/display/blizzard.c
index cbf07d14d9..291abe6fca 100644
--- a/hw/display/blizzard.c
+++ b/hw/display/blizzard.c
@@ -474,7 +474,7 @@ static uint16_t blizzard_reg_read(void *opaque, uint8_t reg)
         return s->gpio_pdown;
 
     default:
-        fprintf(stderr, "%s: unknown register %02x\n", __FUNCTION__, reg);
+        fprintf(stderr, "%s: unknown register %02x\n", __func__, reg);
         return 0;
     }
 }
@@ -502,7 +502,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
         s->pll_mode = value & 0x77;
         if ((value & 3) == 0 || (value & 3) == 3)
             fprintf(stderr, "%s: wrong PLL Control bits (%i)\n",
-                    __FUNCTION__, value & 3);
+                    __func__, value & 3);
         break;
 
     case 0x0e:	/* Clock-Source Select */
@@ -541,7 +541,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
     case 0x28:	/* LCD Panel Configuration */
         s->lcd_config = value & 0xff;
         if (value & (1 << 7))
-            fprintf(stderr, "%s: data swap not supported!\n", __FUNCTION__);
+            fprintf(stderr, "%s: data swap not supported!\n", __func__);
         break;
 
     case 0x2a:	/* LCD Horizontal Display Width */
@@ -586,7 +586,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
         s->hssi_config[1] = value;
         if (((value >> 4) & 3) == 3)
             fprintf(stderr, "%s: Illegal active-data-links value\n",
-                            __FUNCTION__);
+                            __func__);
         break;
     case 0x42:	/* High-speed Serial Interface Tx Mode */
         s->hssi_config[2] = value & 0xbd;
@@ -641,7 +641,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
         s->enable = value & 1;
         s->blank = (value >> 1) & 1;
         if (value & (1 << 4))
-            fprintf(stderr, "%s: Macrovision enable attempt!\n", __FUNCTION__);
+            fprintf(stderr, "%s: Macrovision enable attempt!\n", __func__);
         break;
 
     case 0x6a:	/* Special Effects */
@@ -718,7 +718,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
         s->bpp = blizzard_iformat_bpp[s->iformat];
         if (!s->bpp)
             fprintf(stderr, "%s: Illegal or unsupported input format %x\n",
-                            __FUNCTION__, s->iformat);
+                            __func__, s->iformat);
         break;
     case 0x8e:	/* Data Source Select */
         s->source = value & 7;
@@ -730,7 +730,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
                         !((s->ix[1] - s->ix[0]) & (s->iy[1] - s->iy[0]) &
                           (s->ox[1] - s->ox[0]) & (s->oy[1] - s->oy[0]) & 1))
             fprintf(stderr, "%s: Illegal input/output window positions\n",
-                            __FUNCTION__);
+                            __func__);
 
         blizzard_transfer_setup(s);
         break;
@@ -784,7 +784,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
         s->pm = value & 0x83;
         if (value & s->mode & 1)
             fprintf(stderr, "%s: The display must be disabled before entering "
-                            "Standby Mode\n", __FUNCTION__);
+                            "Standby Mode\n", __func__);
         break;
     case 0xe8:	/* Non-display Period Control / Status */
         s->status = value & 0x1b;
@@ -815,7 +815,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
         break;
 
     default:
-        fprintf(stderr, "%s: unknown register %02x\n", __FUNCTION__, reg);
+        fprintf(stderr, "%s: unknown register %02x\n", __func__, reg);
         break;
     }
 }
diff --git a/hw/display/omap_dss.c b/hw/display/omap_dss.c
index 783e9e1318..601f178fdd 100644
--- a/hw/display/omap_dss.c
+++ b/hw/display/omap_dss.c
@@ -526,7 +526,7 @@ static void omap_disc_write(void *opaque, hwaddr addr,
         s->dispc.l[0].attr = value & 0x7ff;
         if (value & (3 << 9))
             fprintf(stderr, "%s: Big-endian pixel format not supported\n",
-                            __FUNCTION__);
+                            __func__);
         s->dispc.l[0].enable = value & 1;
         s->dispc.l[0].bpp = (value >> 1) & 0xf;
         s->dispc.invalidate = 1;
@@ -617,7 +617,7 @@ static void omap_rfbi_transfer_start(struct omap_dss_s *s)
     if (s->rfbi.control & (1 << 1)) {				/* BYPASS */
         /* TODO: in non-Bypass mode we probably need to just assert the
          * DRQ and wait for DMA to write the pixels.  */
-        fprintf(stderr, "%s: Bypass mode unimplemented\n", __FUNCTION__);
+        fprintf(stderr, "%s: Bypass mode unimplemented\n", __func__);
         return;
     }
 
@@ -1086,6 +1086,6 @@ struct omap_dss_s *omap_dss_init(struct omap_target_agent_s *ta,
 void omap_rfbi_attach(struct omap_dss_s *s, int cs, struct rfbi_chip_s *chip)
 {
     if (cs < 0 || cs > 1)
-        hw_error("%s: wrong CS %i\n", __FUNCTION__, cs);
+        hw_error("%s: wrong CS %i\n", __func__, cs);
     s->rfbi.chip[cs] = chip;
 }
diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index 845521c5b2..b83f80753a 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -405,7 +405,7 @@ static uint64_t pxa2xx_lcdc_read(void *opaque, hwaddr offset,
 
     default:
     fail:
-        hw_error("%s: Bad offset " REG_FMT "\n", __FUNCTION__, offset);
+        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
     }
 
     return 0;
@@ -424,7 +424,7 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
             s->status[0] |= LCSR0_QD;
 
         if (!(s->control[0] & LCCR0_LCDT) && (value & LCCR0_LCDT))
-            printf("%s: internal frame buffer unsupported\n", __FUNCTION__);
+            printf("%s: internal frame buffer unsupported\n", __func__);
 
         if ((s->control[3] & LCCR3_API) &&
                 (value & LCCR0_ENB) && !(value & LCCR0_LCDT))
@@ -460,7 +460,7 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
 
     case OVL1C1:
         if (!(s->ovl1c[0] & OVLC1_EN) && (value & OVLC1_EN))
-            printf("%s: Overlay 1 not supported\n", __FUNCTION__);
+            printf("%s: Overlay 1 not supported\n", __func__);
 
         s->ovl1c[0] = value & 0x80ffffff;
         s->dma_ch[1].up = (value & OVLC1_EN) || (s->control[0] & LCCR0_SDS);
@@ -472,7 +472,7 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
 
     case OVL2C1:
         if (!(s->ovl2c[0] & OVLC1_EN) && (value & OVLC1_EN))
-            printf("%s: Overlay 2 not supported\n", __FUNCTION__);
+            printf("%s: Overlay 2 not supported\n", __func__);
 
         s->ovl2c[0] = value & 0x80ffffff;
         s->dma_ch[2].up = !!(value & OVLC1_EN);
@@ -486,7 +486,7 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
 
     case CCR:
         if (!(s->ccr & CCR_CEN) && (value & CCR_CEN))
-            printf("%s: Hardware cursor unimplemented\n", __FUNCTION__);
+            printf("%s: Hardware cursor unimplemented\n", __func__);
 
         s->ccr = value & 0x81ffffe7;
         s->dma_ch[5].up = !!(value & CCR_CEN);
@@ -560,7 +560,7 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
 
     default:
     fail:
-        hw_error("%s: Bad offset " REG_FMT "\n", __FUNCTION__, offset);
+        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
     }
 }
 
@@ -1050,7 +1050,7 @@ PXA2xxLCDState *pxa2xx_lcdc_init(MemoryRegion *sysmem,
         s->dest_width = 4;
         break;
     default:
-        fprintf(stderr, "%s: Bad color depth\n", __FUNCTION__);
+        fprintf(stderr, "%s: Bad color depth\n", __func__);
         exit(1);
     }
 
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 90e0865618..e7ac4f8789 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -78,7 +78,7 @@ void qxl_render_resize(PCIQXLDevice *qxl)
         qxl->guest_primary.bits_pp = 32;
         break;
     default:
-        fprintf(stderr, "%s: unhandled format: %x\n", __FUNCTION__,
+        fprintf(stderr, "%s: unhandled format: %x\n", __func__,
                 qxl->guest_primary.surface.format);
         qxl->guest_primary.bytes_pp = 4;
         qxl->guest_primary.bits_pp = 32;
@@ -248,7 +248,7 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor,
         break;
     default:
         fprintf(stderr, "%s: not implemented: type %d\n",
-                __FUNCTION__, cursor->header.type);
+                __func__, cursor->header.type);
         goto fail;
     }
     return c;
@@ -275,7 +275,7 @@ int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt *ext)
     }
 
     if (qxl->debug > 1 && cmd->type != QXL_CURSOR_MOVE) {
-        fprintf(stderr, "%s", __FUNCTION__);
+        fprintf(stderr, "%s", __func__);
         qxl_log_cmd_cursor(qxl, cmd, ext->group_id);
         fprintf(stderr, "\n");
     }
diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index 8668a8e05a..089696ef62 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -132,7 +132,7 @@ typedef struct PCIQXLDevice {
 #define PCI_QXL(obj) OBJECT_CHECK(PCIQXLDevice, (obj), TYPE_PCI_QXL)
 
 #define PANIC_ON(x) if ((x)) {                         \
-    printf("%s: PANIC %s failed\n", __FUNCTION__, #x); \
+    printf("%s: PANIC %s failed\n", __func__, #x); \
     abort();                                           \
 }
 
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 0ae63605f0..464465b7c2 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -148,7 +148,7 @@ static void tc6393xb_gpio_set(void *opaque, int line, int level)
 //    TC6393xbState *s = opaque;
 
     if (line > TC6393XB_GPIOS) {
-        printf("%s: No GPIO pin %i\n", __FUNCTION__, line);
+        printf("%s: No GPIO pin %i\n", __func__, line);
         return;
     }
 
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index d4fc0fa5f2..f5afcc0358 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -662,7 +662,7 @@ static void xenfb_guest_copy(struct XenFB *xenfb, int x, int y, int w, int h)
     }
     if (oops) /* should not happen */
         xen_pv_printf(&xenfb->c.xendev, 0, "%s: oops: convert %d -> %d bpp?\n",
-                      __FUNCTION__, xenfb->depth, bpp);
+                      __func__, xenfb->depth, bpp);
 
     dpy_gfx_update(xenfb->con, x, y, w, h);
 }
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 45dfe7aadd..abd18c67ea 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -161,7 +161,7 @@ static void omap_dma_channel_load(struct omap_dma_channel_s *ch)
     a->pck_element = 0;
 
     if (unlikely(!ch->elements || !ch->frames)) {
-        printf("%s: bad DMA request\n", __FUNCTION__);
+        printf("%s: bad DMA request\n", __func__);
         return;
     }
 
@@ -519,7 +519,7 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
         continue;
 #endif
         printf("%s: Bus time-out in DMA%i operation\n",
-                        __FUNCTION__, dma->num);
+                        __func__, dma->num);
     }
 
     min_elems = INT_MAX;
@@ -879,14 +879,14 @@ static int omap_dma_ch_reg_write(struct omap_dma_s *s,
         ch->pack[0] = (value & 0x0040) >> 6;
         ch->port[0] = (enum omap_dma_port) ((value & 0x003c) >> 2);
         if (ch->port[0] >= __omap_dma_port_last)
-            printf("%s: invalid DMA port %i\n", __FUNCTION__,
+            printf("%s: invalid DMA port %i\n", __func__,
                             ch->port[0]);
         if (ch->port[1] >= __omap_dma_port_last)
-            printf("%s: invalid DMA port %i\n", __FUNCTION__,
+            printf("%s: invalid DMA port %i\n", __func__,
                             ch->port[1]);
         ch->data_type = 1 << (value & 3);
         if ((value & 3) == 3) {
-            printf("%s: bad data_type for DMA channel\n", __FUNCTION__);
+            printf("%s: bad data_type for DMA channel\n", __func__);
             ch->data_type >>= 1;
         }
         break;
@@ -1440,7 +1440,7 @@ static int omap_dma_sys_read(struct omap_dma_s *s, int offset,
     case 0x482:	/* DMA_PCh1_SR */
     case 0x4c0:	/* DMA_PChD_SR_0 */
         printf("%s: Physical Channel Status Registers not implemented.\n",
-               __FUNCTION__);
+               __func__);
         *ret = 0xff;
         break;
 
@@ -1898,13 +1898,13 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
             omap_dma_reset(s->dma);
         s->ocp = value & 0x3321;
         if (((s->ocp >> 12) & 3) == 3)				/* MIDLEMODE */
-            fprintf(stderr, "%s: invalid DMA power mode\n", __FUNCTION__);
+            fprintf(stderr, "%s: invalid DMA power mode\n", __func__);
         return;
 
     case 0x78:	/* DMA4_GCR */
         s->gcr = value & 0x00ff00ff;
 	if ((value & 0xff) == 0x00)		/* MAX_CHANNEL_FIFO_DEPTH */
-            fprintf(stderr, "%s: wrong FIFO depth in GCR\n", __FUNCTION__);
+            fprintf(stderr, "%s: wrong FIFO depth in GCR\n", __func__);
         return;
 
     case 0x80 ... 0xfff:
@@ -1935,7 +1935,7 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
         ch->src_sync = (value >> 24) & 1;	/* XXX For CamDMA must be 1 */
         if (ch->buf_disable && !ch->src_sync)
             fprintf(stderr, "%s: Buffering disable is not allowed in "
-                            "destination synchronised mode\n", __FUNCTION__);
+                            "destination synchronised mode\n", __func__);
         ch->prefetch = (value >> 23) & 1;
         ch->bs = (value >> 18) & 1;
         ch->transparent_copy = (value >> 17) & 1;
@@ -1947,7 +1947,7 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
         ch->fs = (value & 0x0020) >> 5;
         if (ch->fs && ch->bs && ch->mode[0] && ch->mode[1])
             fprintf(stderr, "%s: For a packet transfer at least one port "
-                            "must be constant-addressed\n", __FUNCTION__);
+                            "must be constant-addressed\n", __func__);
         ch->sync = (value & 0x001f) | ((value >> 14) & 0x0060);
         /* XXX must be 0x01 for CamDMA */
 
@@ -1978,7 +1978,7 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
         ch->endian_lock[1] =(value >> 18) & 1;
         if (ch->endian[0] != ch->endian[1])
             fprintf(stderr, "%s: DMA endianness conversion enable attempt\n",
-                            __FUNCTION__);
+                            __func__);
         ch->write_mode = (value >> 16) & 3;
         ch->burst[1] = (value & 0xc000) >> 14;
         ch->pack[1] = (value & 0x2000) >> 13;
@@ -1988,10 +1988,10 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
         ch->translate[0] = (value & 0x003c) >> 2;
         if (ch->translate[0] | ch->translate[1])
             fprintf(stderr, "%s: bad MReqAddressTranslate sideband signal\n",
-                            __FUNCTION__);
+                            __func__);
         ch->data_type = 1 << (value & 3);
         if ((value & 3) == 3) {
-            printf("%s: bad data_type for DMA channel\n", __FUNCTION__);
+            printf("%s: bad data_type for DMA channel\n", __func__);
             ch->data_type >>= 1;
         }
         break;
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
index 634a4328f0..f4eb26cf17 100644
--- a/hw/dma/pxa2xx_dma.c
+++ b/hw/dma/pxa2xx_dma.c
@@ -169,7 +169,7 @@ static inline void pxa2xx_dma_descriptor_fetch(
         s->chan[ch].dest &= ~3;
 
     if (s->chan[ch].cmd & (DCMD_CMPEN | DCMD_FLYBYS | DCMD_FLYBYT))
-        printf("%s: unsupported mode in channel %i\n", __FUNCTION__, ch);
+        printf("%s: unsupported mode in channel %i\n", __func__, ch);
 
     if (s->chan[ch].cmd & DCMD_STARTIRQEN)
         s->chan[ch].state |= DCSR_STARTINTR;
@@ -264,7 +264,7 @@ static uint64_t pxa2xx_dma_read(void *opaque, hwaddr offset,
     unsigned int channel;
 
     if (size != 4) {
-        hw_error("%s: Bad access width\n", __FUNCTION__);
+        hw_error("%s: Bad access width\n", __func__);
         return 5;
     }
 
@@ -312,7 +312,7 @@ static uint64_t pxa2xx_dma_read(void *opaque, hwaddr offset,
         }
     }
 
-    hw_error("%s: Bad offset 0x" TARGET_FMT_plx "\n", __FUNCTION__, offset);
+    hw_error("%s: Bad offset 0x" TARGET_FMT_plx "\n", __func__, offset);
     return 7;
 }
 
@@ -323,7 +323,7 @@ static void pxa2xx_dma_write(void *opaque, hwaddr offset,
     unsigned int channel;
 
     if (size != 4) {
-        hw_error("%s: Bad access width\n", __FUNCTION__);
+        hw_error("%s: Bad access width\n", __func__);
         return;
     }
 
@@ -337,7 +337,7 @@ static void pxa2xx_dma_write(void *opaque, hwaddr offset,
         if (value & DRCMR_MAPVLD)
             if ((value & DRCMR_CHLNUM) > s->channels)
                 hw_error("%s: Bad DMA channel %i\n",
-                         __FUNCTION__, (unsigned)value & DRCMR_CHLNUM);
+                         __func__, (unsigned)value & DRCMR_CHLNUM);
 
         s->req[channel] = value;
         break;
@@ -416,7 +416,7 @@ static void pxa2xx_dma_write(void *opaque, hwaddr offset,
             break;
         }
     fail:
-        hw_error("%s: Bad offset " TARGET_FMT_plx "\n", __FUNCTION__, offset);
+        hw_error("%s: Bad offset " TARGET_FMT_plx "\n", __func__, offset);
     }
 }
 
@@ -431,7 +431,7 @@ static void pxa2xx_dma_request(void *opaque, int req_num, int on)
     PXA2xxDMAState *s = opaque;
     int ch;
     if (req_num < 0 || req_num >= PXA2XX_DMA_NUM_REQUESTS)
-        hw_error("%s: Bad DMA request %i\n", __FUNCTION__, req_num);
+        hw_error("%s: Bad DMA request %i\n", __func__, req_num);
 
     if (!(s->req[req_num] & DRCMR_MAPVLD))
         return;
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index f82e3e6555..4c203ef5c6 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -67,7 +67,7 @@ static int max7310_rx(I2CSlave *i2c)
 
     default:
 #ifdef VERBOSE
-        printf("%s: unknown register %02x\n", __FUNCTION__, s->command);
+        printf("%s: unknown register %02x\n", __func__, s->command);
 #endif
         break;
     }
@@ -82,7 +82,7 @@ static int max7310_tx(I2CSlave *i2c, uint8_t data)
 
     if (s->len ++ > 1) {
 #ifdef VERBOSE
-        printf("%s: message too long (%i bytes)\n", __FUNCTION__, s->len);
+        printf("%s: message too long (%i bytes)\n", __func__, s->len);
 #endif
         return 1;
     }
@@ -121,7 +121,7 @@ static int max7310_tx(I2CSlave *i2c, uint8_t data)
 	break;
     default:
 #ifdef VERBOSE
-        printf("%s: unknown register %02x\n", __FUNCTION__, s->command);
+        printf("%s: unknown register %02x\n", __func__, s->command);
 #endif
         return 1;
     }
@@ -141,7 +141,7 @@ static int max7310_event(I2CSlave *i2c, enum i2c_event event)
     case I2C_FINISH:
 #ifdef VERBOSE
         if (s->len == 1)
-            printf("%s: message too short (%i bytes)\n", __FUNCTION__, s->len);
+            printf("%s: message too short (%i bytes)\n", __func__, s->len);
 #endif
         break;
     default:
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 17891e2d0f..08472193b5 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -399,7 +399,7 @@ static void omap2_gpio_module_write(void *opaque, hwaddr addr,
 
     case 0x10:	/* GPIO_SYSCONFIG */
         if (((value >> 3) & 3) == 3)
-            fprintf(stderr, "%s: bad IDLEMODE value\n", __FUNCTION__);
+            fprintf(stderr, "%s: bad IDLEMODE value\n", __func__);
         if (value & 2)
             omap2_gpio_module_reset(s);
         s->config[0] = value & 0x1d;
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index 12264ee0f5..26e3e5ebf6 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -341,12 +341,12 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
         }
         if ((value & (1 << 15)) && !(value & (1 << 10))) {	/* MST */
             fprintf(stderr, "%s: I^2C slave mode not supported\n",
-                            __FUNCTION__);
+                            __func__);
             break;
         }
         if ((value & (1 << 15)) && value & (1 << 8)) {		/* XA */
             fprintf(stderr, "%s: 10-bit addressing mode not supported\n",
-                            __FUNCTION__);
+                            __func__);
             break;
         }
         if ((value & (1 << 15)) && value & (1 << 0)) {		/* STT */
@@ -393,7 +393,7 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
                 omap_i2c_interrupts_update(s);
             }
         if (value & (1 << 15))					/* ST_EN */
-            fprintf(stderr, "%s: System Test not supported\n", __FUNCTION__);
+            fprintf(stderr, "%s: System Test not supported\n", __func__);
         break;
 
     default:
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 451b18b419..e22d7be05f 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1052,7 +1052,7 @@ static void process_ncq_command(AHCIState *s, int port, uint8_t *cmd_fis,
     g_assert(is_ncq(ncq_fis->command));
     if (ncq_tfs->used) {
         /* error - already in use */
-        fprintf(stderr, "%s: tag %d already used\n", __FUNCTION__, tag);
+        fprintf(stderr, "%s: tag %d already used\n", __func__, tag);
         return;
     }
 
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index fde4d4645e..58e4f52f7d 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -155,7 +155,7 @@ static uint8_t md_attr_read(PCMCIACardState *card, uint32_t at)
         return 0x00;
 #ifdef VERBOSE
     default:
-        printf("%s: Bad attribute space register %02x\n", __FUNCTION__, at);
+        printf("%s: Bad attribute space register %02x\n", __func__, at);
 #endif
     }
 
@@ -192,7 +192,7 @@ static void md_attr_write(PCMCIACardState *card, uint32_t at, uint8_t value)
     case 0x06:	/* Socket and Copy Register */
         break;
     default:
-        printf("%s: Bad attribute space register %02x\n", __FUNCTION__, at);
+        printf("%s: Bad attribute space register %02x\n", __func__, at);
     }
 }
 
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index 2340523da0..d39953126b 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -239,7 +239,7 @@ static uint8_t lm_kbd_read(LM823KbdState *s, int reg, int byte)
 
     default:
         lm_kbd_error(s, ERR_CMDUNK);
-        fprintf(stderr, "%s: unknown command %02x\n", __FUNCTION__, reg);
+        fprintf(stderr, "%s: unknown command %02x\n", __func__, reg);
         return 0x00;
     }
 
@@ -331,7 +331,7 @@ static void lm_kbd_write(LM823KbdState *s, int reg, int byte, uint8_t value)
         if ((value & 3) && (value & 3) != 3) {
             lm_kbd_error(s, ERR_BADPAR);
             fprintf(stderr, "%s: invalid clock setting in RCPWM\n",
-                            __FUNCTION__);
+                            __func__);
         }
         /* TODO: Validate that the command is only issued once */
         break;
@@ -378,7 +378,7 @@ static void lm_kbd_write(LM823KbdState *s, int reg, int byte, uint8_t value)
         break;
     default:
         lm_kbd_error(s, ERR_CMDUNK);
-        fprintf(stderr, "%s: unknown command %02x\n", __FUNCTION__, reg);
+        fprintf(stderr, "%s: unknown command %02x\n", __func__, reg);
         break;
     }
 }
diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
index 2b70bbb95c..93db9ed25b 100644
--- a/hw/input/pxa2xx_keypad.c
+++ b/hw/input/pxa2xx_keypad.c
@@ -231,7 +231,7 @@ static uint64_t pxa2xx_keypad_read(void *opaque, hwaddr offset,
         return s->kpkdi;
         break;
     default:
-        hw_error("%s: Bad offset " REG_FMT "\n", __FUNCTION__, offset);
+        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
     }
 
     return 0;
@@ -278,7 +278,7 @@ static void pxa2xx_keypad_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        hw_error("%s: Bad offset " REG_FMT "\n", __FUNCTION__, offset);
+        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
     }
 }
 
@@ -326,7 +326,7 @@ void pxa27x_register_keypad(PXA2xxKeyPadState *kp,
                             const struct keymap *map, int size)
 {
     if(!map || size < 0x80) {
-        fprintf(stderr, "%s - No PXA keypad map defined\n", __FUNCTION__);
+        fprintf(stderr, "%s - No PXA keypad map defined\n", __func__);
         exit(-1);
     }
 
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index eb5320af40..7990954b6c 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -201,7 +201,7 @@ static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
         if (s->enabled != !(data & 0x4000)) {
             s->enabled = !(data & 0x4000);
             fprintf(stderr, "%s: touchscreen sense %sabled\n",
-                            __FUNCTION__, s->enabled ? "en" : "dis");
+                            __func__, s->enabled ? "en" : "dis");
             if (s->busy && !s->enabled)
                 timer_del(s->timer);
             s->busy = s->busy && s->enabled;
@@ -210,7 +210,7 @@ static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
         s->timing[0] = data & 0x1fff;
         if ((s->timing[0] >> 11) == 3)
             fprintf(stderr, "%s: illegal conversion clock setting\n",
-                            __FUNCTION__);
+                            __func__);
         break;
     case 0xd:	/* CFR1 */
         s->timing[1] = data & 0xf07;
@@ -222,7 +222,7 @@ static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
 
     default:
         fprintf(stderr, "%s: write into read-only register %x\n",
-                        __FUNCTION__, reg);
+                        __func__, reg);
     }
 }
 
@@ -338,7 +338,7 @@ static uint8_t tsc2005_txrx_word(void *opaque, uint8_t value)
                 if (s->enabled != !(value & 1)) {
                     s->enabled = !(value & 1);
                     fprintf(stderr, "%s: touchscreen sense %sabled\n",
-                                    __FUNCTION__, s->enabled ? "en" : "dis");
+                                    __func__, s->enabled ? "en" : "dis");
                     if (s->busy && !s->enabled)
                         timer_del(s->timer);
                     s->busy = s->busy && s->enabled;
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index 75ac8c2ab5..1cad57f644 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -287,7 +287,7 @@ static void tsc2102_audio_rate_update(TSC210xState *s)
                         rate->fsref == ((s->audio_ctrl3 >> 13) & 1))/* REFFS */
             break;
     if (!rate->rate) {
-        printf("%s: unknown sampling rate configured\n", __FUNCTION__);
+        printf("%s: unknown sampling rate configured\n", __func__);
         return;
     }
 
@@ -913,7 +913,7 @@ uint32_t tsc210x_txrx(void *opaque, uint32_t value, int len)
     uint32_t ret = 0;
 
     if (len != 16)
-        hw_error("%s: FIXME: bad SPI word width %i\n", __FUNCTION__, len);
+        hw_error("%s: FIXME: bad SPI word width %i\n", __func__, len);
 
     /* TODO: sequential reads etc - how do we make sure the host doesn't
      * unintentionally read out a conversion result from a register while
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index ccdda89dab..6844c1aa83 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -540,7 +540,7 @@ static void omap2_inth_write(void *opaque, hwaddr addr,
          * for every register, see Chapter 3 and 4 for privileged mode.  */
         if (value & 1)
             fprintf(stderr, "%s: protection mode enable attempt\n",
-                            __FUNCTION__);
+                            __func__);
         return;
 
     case 0x50:	/* INTC_IDLE */
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 4084b32be9..070cc1889f 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -29,7 +29,7 @@
 //#define DEBUG_VT82C686B
 
 #ifdef DEBUG_VT82C686B
-#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __FUNCTION__, ##__VA_ARGS__)
+#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __func__, ##__VA_ARGS__)
 #else
 #define DPRINTF(fmt, ...)
 #endif
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 5a9dad9aae..e12336d14a 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -33,7 +33,7 @@
 //#define DEBUG
 
 #ifdef DEBUG
-#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __FUNCTION__, ##__VA_ARGS__)
+#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __func__, ##__VA_ARGS__)
 #else
 #define DPRINTF(fmt, ...)
 #endif
diff --git a/hw/misc/cbus.c b/hw/misc/cbus.c
index 677274ce3e..25e337ea77 100644
--- a/hw/misc/cbus.c
+++ b/hw/misc/cbus.c
@@ -62,7 +62,7 @@ static void cbus_io(CBusPriv *s)
         s->slave[s->addr]->io(s->slave[s->addr]->opaque,
                         s->rw, s->reg, &s->val);
     else
-        hw_error("%s: bad slave address %i\n", __FUNCTION__, s->addr);
+        hw_error("%s: bad slave address %i\n", __func__, s->addr);
 }
 
 static void cbus_cycle(CBusPriv *s)
@@ -299,7 +299,7 @@ static inline uint16_t retu_read(CBusRetu *s, int reg)
         return 0x0000;
 
     default:
-        hw_error("%s: bad register %02x\n", __FUNCTION__, reg);
+        hw_error("%s: bad register %02x\n", __func__, reg);
     }
 }
 
@@ -372,7 +372,7 @@ static inline void retu_write(CBusRetu *s, int reg, uint16_t val)
         break;
 
     default:
-        hw_error("%s: bad register %02x\n", __FUNCTION__, reg);
+        hw_error("%s: bad register %02x\n", __func__, reg);
     }
 }
 
@@ -538,7 +538,7 @@ static inline uint16_t tahvo_read(CBusTahvo *s, int reg)
         return 0x0000;
 
     default:
-        hw_error("%s: bad register %02x\n", __FUNCTION__, reg);
+        hw_error("%s: bad register %02x\n", __func__, reg);
     }
 }
 
@@ -567,7 +567,7 @@ static inline void tahvo_write(CBusTahvo *s, int reg, uint16_t val)
         if (s->backlight != (val & 0x7f)) {
             s->backlight = val & 0x7f;
             printf("%s: LCD backlight now at %i / 127\n",
-                            __FUNCTION__, s->backlight);
+                            __func__, s->backlight);
         }
         break;
 
@@ -588,7 +588,7 @@ static inline void tahvo_write(CBusTahvo *s, int reg, uint16_t val)
         break;
 
     default:
-        hw_error("%s: bad register %02x\n", __FUNCTION__, reg);
+        hw_error("%s: bad register %02x\n", __func__, reg);
     }
 }
 
diff --git a/hw/misc/omap_clk.c b/hw/misc/omap_clk.c
index 19151d07d6..9ea14186d4 100644
--- a/hw/misc/omap_clk.c
+++ b/hw/misc/omap_clk.c
@@ -1109,7 +1109,7 @@ struct clk *omap_findclk(struct omap_mpu_state_s *mpu, const char *name)
     for (i = mpu->clks; i->name; i ++)
         if (!strcmp(i->name, name) || (i->alias && !strcmp(i->alias, name)))
             return i;
-    hw_error("%s: %s not found\n", __FUNCTION__, name);
+    hw_error("%s: %s not found\n", __func__, name);
 }
 
 void omap_clk_get(struct clk *clk)
@@ -1120,7 +1120,7 @@ void omap_clk_get(struct clk *clk)
 void omap_clk_put(struct clk *clk)
 {
     if (!(clk->usecount --))
-        hw_error("%s: %s is not in use\n", __FUNCTION__, clk->name);
+        hw_error("%s: %s is not in use\n", __func__, clk->name);
 }
 
 static void omap_clk_update(struct clk *clk)
diff --git a/hw/misc/omap_gpmc.c b/hw/misc/omap_gpmc.c
index 67d8e2f023..84f9e4c612 100644
--- a/hw/misc/omap_gpmc.c
+++ b/hw/misc/omap_gpmc.c
@@ -643,7 +643,7 @@ static void omap_gpmc_write(void *opaque, hwaddr addr,
     case 0x010:	/* GPMC_SYSCONFIG */
         if ((value >> 3) == 0x3)
             fprintf(stderr, "%s: bad SDRAM idle mode %"PRIi64"\n",
-                            __FUNCTION__, value >> 3);
+                            __func__, value >> 3);
         if (value & 2)
             omap_gpmc_reset(s);
         s->sysconfig = value & 0x19;
@@ -806,7 +806,7 @@ static void omap_gpmc_write(void *opaque, hwaddr addr,
         break;
     case 0x230:	/* GPMC_TESTMODE_CTRL */
         if (value & 7)
-            fprintf(stderr, "%s: test mode enable attempt\n", __FUNCTION__);
+            fprintf(stderr, "%s: test mode enable attempt\n", __func__);
         break;
 
     default:
@@ -864,7 +864,7 @@ void omap_gpmc_attach(struct omap_gpmc_s *s, int cs, MemoryRegion *iomem)
     assert(iomem);
 
     if (cs < 0 || cs >= 8) {
-        fprintf(stderr, "%s: bad chip-select %i\n", __FUNCTION__, cs);
+        fprintf(stderr, "%s: bad chip-select %i\n", __func__, cs);
         exit(-1);
     }
     f = &s->cs_file[cs];
diff --git a/hw/misc/omap_l4.c b/hw/misc/omap_l4.c
index 88c533a0fe..96fc057b4e 100644
--- a/hw/misc/omap_l4.c
+++ b/hw/misc/omap_l4.c
@@ -126,7 +126,7 @@ struct omap_target_agent_s *omap_l4ta_get(struct omap_l4_s *bus,
             break;
         }
     if (!ta) {
-        fprintf(stderr, "%s: bad target agent (%i)\n", __FUNCTION__, cs);
+        fprintf(stderr, "%s: bad target agent (%i)\n", __func__, cs);
         exit(-1);
     }
 
@@ -151,7 +151,7 @@ hwaddr omap_l4_attach(struct omap_target_agent_s *ta,
     hwaddr base;
 
     if (region < 0 || region >= ta->regions) {
-        fprintf(stderr, "%s: bad io region (%i)\n", __FUNCTION__, region);
+        fprintf(stderr, "%s: bad io region (%i)\n", __func__, region);
         exit(-1);
     }
 
diff --git a/hw/misc/omap_sdrc.c b/hw/misc/omap_sdrc.c
index dff37ecaf9..7b38c5568c 100644
--- a/hw/misc/omap_sdrc.c
+++ b/hw/misc/omap_sdrc.c
@@ -109,7 +109,7 @@ static void omap_sdrc_write(void *opaque, hwaddr addr,
     case 0x10:	/* SDRC_SYSCONFIG */
         if ((value >> 3) != 0x2)
             fprintf(stderr, "%s: bad SDRAM idle mode %i\n",
-                    __FUNCTION__, (unsigned)value >> 3);
+                    __func__, (unsigned)value >> 3);
         if (value & 2)
             omap_sdrc_reset(s);
         s->config = value & 0x18;
diff --git a/hw/misc/omap_tap.c b/hw/misc/omap_tap.c
index e6ea8ee235..3f595e8df7 100644
--- a/hw/misc/omap_tap.c
+++ b/hw/misc/omap_tap.c
@@ -44,7 +44,7 @@ static uint64_t omap_tap_read(void *opaque, hwaddr addr,
         case omap3430:
             return 0x1b7ae02f;	/* ES 2 */
         default:
-            hw_error("%s: Bad mpu model\n", __FUNCTION__);
+            hw_error("%s: Bad mpu model\n", __func__);
         }
 
     case 0x208:	/* PRODUCTION_ID_reg for OMAP2 */
@@ -61,7 +61,7 @@ static uint64_t omap_tap_read(void *opaque, hwaddr addr,
         case omap3430:
             return 0x000000f0;
         default:
-            hw_error("%s: Bad mpu model\n", __FUNCTION__);
+            hw_error("%s: Bad mpu model\n", __func__);
         }
 
     case 0x20c:
@@ -75,7 +75,7 @@ static uint64_t omap_tap_read(void *opaque, hwaddr addr,
         case omap3430:
             return 0xcafeb7ae;	/* ES 2 */
         default:
-            hw_error("%s: Bad mpu model\n", __FUNCTION__);
+            hw_error("%s: Bad mpu model\n", __func__);
         }
 
     case 0x218:	/* DIE_ID_reg */
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 04e83787d4..9e22d64e36 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -131,7 +131,7 @@ static void tmp105_write(TMP105State *s)
 
     case TMP105_REG_CONFIG:
         if (s->buf[0] & ~s->config & (1 << 0))			/* SD */
-            printf("%s: TMP105 shutdown\n", __FUNCTION__);
+            printf("%s: TMP105 shutdown\n", __func__);
         s->config = s->buf[0];
         s->faults = tmp105_faultq[(s->config >> 3) & 3];	/* F */
         tmp105_alarm_update(s);
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 9f61e27edc..2ebeab5d90 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -50,7 +50,7 @@
 //#define DEBUG_BONITO
 
 #ifdef DEBUG_BONITO
-#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __FUNCTION__, ##__VA_ARGS__)
+#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __func__, ##__VA_ARGS__)
 #else
 #define DPRINTF(fmt, ...)
 #endif
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 3deccf02c9..0d4b88c609 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -330,7 +330,7 @@ static uint64_t pxa2xx_mmci_read(void *opaque, hwaddr offset, unsigned size)
     case MMC_BLKS_REM:
         return s->numblk;
     default:
-        hw_error("%s: Bad offset " REG_FMT "\n", __FUNCTION__, offset);
+        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
     }
 
     return 0;
@@ -369,7 +369,7 @@ static void pxa2xx_mmci_write(void *opaque,
     case MMC_SPI:
         s->spi = value & 0xf;
         if (value & SPI_SPI_MODE)
-            printf("%s: attempted to use card in SPI mode\n", __FUNCTION__);
+            printf("%s: attempted to use card in SPI mode\n", __func__);
         break;
 
     case MMC_CMDAT:
@@ -442,7 +442,7 @@ static void pxa2xx_mmci_write(void *opaque,
         break;
 
     default:
-        hw_error("%s: Bad offset " REG_FMT "\n", __FUNCTION__, offset);
+        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
     }
 }
 
diff --git a/hw/ssi/omap_spi.c b/hw/ssi/omap_spi.c
index 22034656b8..34163e5646 100644
--- a/hw/ssi/omap_spi.c
+++ b/hw/ssi/omap_spi.c
@@ -295,10 +295,10 @@ static void omap_mcspi_write(void *opaque, hwaddr addr,
         if ((value ^ s->ch[ch].config) & (3 << 14))	/* DMAR | DMAW */
             omap_mcspi_dmarequest_update(s->ch + ch);
         if (((value >> 12) & 3) == 3)			/* TRM */
-            fprintf(stderr, "%s: invalid TRM value (3)\n", __FUNCTION__);
+            fprintf(stderr, "%s: invalid TRM value (3)\n", __func__);
         if (((value >> 7) & 0x1f) < 3)			/* WL */
             fprintf(stderr, "%s: invalid WL value (%" PRIx64 ")\n",
-                            __FUNCTION__, (value >> 7) & 0x1f);
+                            __func__, (value >> 7) & 0x1f);
         s->ch[ch].config = value & 0x7fffff;
         break;
 
@@ -367,7 +367,7 @@ void omap_mcspi_attach(struct omap_mcspi_s *s,
                 int chipselect)
 {
     if (chipselect < 0 || chipselect >= s->chnum)
-        hw_error("%s: Bad chipselect %i\n", __FUNCTION__, chipselect);
+        hw_error("%s: Bad chipselect %i\n", __func__, chipselect);
 
     s->ch[chipselect].txrx = txrx;
     s->ch[chipselect].opaque = opaque;
diff --git a/hw/timer/omap_gptimer.c b/hw/timer/omap_gptimer.c
index 6d7c8a396f..ae2dc99832 100644
--- a/hw/timer/omap_gptimer.c
+++ b/hw/timer/omap_gptimer.c
@@ -357,7 +357,7 @@ static void omap_gp_timer_write(void *opaque, hwaddr addr,
         s->config = value & 0x33d;
         if (((value >> 3) & 3) == 3)				/* IDLEMODE */
             fprintf(stderr, "%s: illegal IDLEMODE value in TIOCP_CFG\n",
-                            __FUNCTION__);
+                            __func__);
         if (value & 2)						/* SOFTRESET */
             omap_gp_timer_reset(s);
         break;
@@ -395,10 +395,10 @@ static void omap_gp_timer_write(void *opaque, hwaddr addr,
         s->st = (value >> 0) & 1;
         if (s->inout && s->trigger != gpt_trigger_none)
             fprintf(stderr, "%s: GP timer pin must be an output "
-                            "for this trigger mode\n", __FUNCTION__);
+                            "for this trigger mode\n", __func__);
         if (!s->inout && s->capture != gpt_capture_none)
             fprintf(stderr, "%s: GP timer pin must be an input "
-                            "for this capture mode\n", __FUNCTION__);
+                            "for this capture mode\n", __func__);
         if (s->trigger == gpt_trigger_none)
             omap_gp_timer_out(s, s->scpwm);
         /* TODO: make sure this doesn't overflow 32-bits */
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index eb58c378e0..ef116c636c 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -403,7 +403,7 @@ static uint8_t menelaus_read(void *opaque, uint8_t addr)
 
     default:
 #ifdef VERBOSE
-        printf("%s: unknown register %02x\n", __FUNCTION__, addr);
+        printf("%s: unknown register %02x\n", __func__, addr);
 #endif
         break;
     }
@@ -615,7 +615,7 @@ static void menelaus_write(void *opaque, uint8_t addr, uint8_t value)
         rtc_badness:
         default:
             fprintf(stderr, "%s: bad RTC_UPDATE value %02x\n",
-                            __FUNCTION__, value);
+                            __func__, value);
             s->status |= 1 << 10;				/* RTCERR */
             menelaus_update(s);
         }
@@ -708,7 +708,7 @@ static void menelaus_write(void *opaque, uint8_t addr, uint8_t value)
 
     default:
 #ifdef VERBOSE
-        printf("%s: unknown register %02x\n", __FUNCTION__, addr);
+        printf("%s: unknown register %02x\n", __func__, addr);
 #endif
     }
 }
diff --git a/hw/usb/desc.c b/hw/usb/desc.c
index c36bf30e4f..85c15addc5 100644
--- a/hw/usb/desc.c
+++ b/hw/usb/desc.c
@@ -688,7 +688,7 @@ int usb_desc_get_descriptor(USBDevice *dev, USBPacket *p,
         break;
 
     default:
-        fprintf(stderr, "%s: %d unknown type %d (len %zd)\n", __FUNCTION__,
+        fprintf(stderr, "%s: %d unknown type %d (len %zd)\n", __func__,
                 dev->addr, type, len);
         break;
     }
diff --git a/hw/usb/dev-bluetooth.c b/hw/usb/dev-bluetooth.c
index 443e3c301d..0bbceaea0b 100644
--- a/hw/usb/dev-bluetooth.c
+++ b/hw/usb/dev-bluetooth.c
@@ -274,13 +274,13 @@ static void usb_bt_fifo_enqueue(struct usb_hci_in_fifo_s *fifo,
     if (off <= DFIFO_LEN_MASK) {
         if (off + len > DFIFO_LEN_MASK + 1 &&
                         (fifo->dsize = off + len) > (DFIFO_LEN_MASK + 1) * 2) {
-            fprintf(stderr, "%s: can't alloc %i bytes\n", __FUNCTION__, len);
+            fprintf(stderr, "%s: can't alloc %i bytes\n", __func__, len);
             exit(-1);
         }
         buf = fifo->data + off;
     } else {
         if (fifo->dlen > fifo->dsize) {
-            fprintf(stderr, "%s: can't alloc %i bytes\n", __FUNCTION__, len);
+            fprintf(stderr, "%s: can't alloc %i bytes\n", __func__, len);
             exit(-1);
         }
         buf = fifo->data + off - fifo->dsize;
diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
index 27d9d0bd82..d70a91a58c 100644
--- a/hw/usb/hcd-musb.c
+++ b/hw/usb/hcd-musb.c
@@ -253,8 +253,8 @@
 /* #define MUSB_DEBUG */
 
 #ifdef MUSB_DEBUG
-#define TRACE(fmt,...) fprintf(stderr, "%s@%d: " fmt "\n", __FUNCTION__, \
-                               __LINE__, ##__VA_ARGS__)
+#define TRACE(fmt, ...) fprintf(stderr, "%s@%d: " fmt "\n", __func__, \
+                                __LINE__, ##__VA_ARGS__)
 #else
 #define TRACE(...)
 #endif
diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index 8f593a6fdb..2662c060ed 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -296,7 +296,7 @@ static uint32_t tusb_async_readb(void *opaque, hwaddr addr)
     }
 
     printf("%s: unknown register at %03x\n",
-                    __FUNCTION__, (int) (addr & 0xfff));
+                    __func__, (int) (addr & 0xfff));
     return 0;
 }
 
@@ -313,7 +313,7 @@ static uint32_t tusb_async_readh(void *opaque, hwaddr addr)
     }
 
     printf("%s: unknown register at %03x\n",
-                    __FUNCTION__, (int) (addr & 0xfff));
+                    __func__, (int) (addr & 0xfff));
     return 0;
 }
 
@@ -436,7 +436,7 @@ static uint32_t tusb_async_readw(void *opaque, hwaddr addr)
         return 0x54059adf;
     }
 
-    printf("%s: unknown register at %03x\n", __FUNCTION__, offset);
+    printf("%s: unknown register at %03x\n", __func__, offset);
     return 0;
 }
 
@@ -456,7 +456,7 @@ static void tusb_async_writeb(void *opaque, hwaddr addr,
 
     default:
         printf("%s: unknown register at %03x\n",
-                        __FUNCTION__, (int) (addr & 0xfff));
+                        __func__, (int) (addr & 0xfff));
         return;
     }
 }
@@ -477,7 +477,7 @@ static void tusb_async_writeh(void *opaque, hwaddr addr,
 
     default:
         printf("%s: unknown register at %03x\n",
-                        __FUNCTION__, (int) (addr & 0xfff));
+                        __func__, (int) (addr & 0xfff));
         return;
     }
 }
@@ -505,7 +505,7 @@ static void tusb_async_writew(void *opaque, hwaddr addr,
         s->dev_config = value;
         s->host_mode = (value & TUSB_DEV_CONF_USB_HOST_MODE);
         if (value & TUSB_DEV_CONF_PROD_TEST_MODE)
-            hw_error("%s: Product Test mode not allowed\n", __FUNCTION__);
+            hw_error("%s: Product Test mode not allowed\n", __func__);
         break;
 
     case TUSB_PHY_OTG_CTRL_ENABLE:
@@ -636,7 +636,7 @@ static void tusb_async_writew(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: unknown register at %03x\n", __FUNCTION__, offset);
+        printf("%s: unknown register at %03x\n", __func__, offset);
         return;
     }
 }
diff --git a/hw/xenpv/xen_domainbuild.c b/hw/xenpv/xen_domainbuild.c
index c89ced2e88..027f76fad1 100644
--- a/hw/xenpv/xen_domainbuild.c
+++ b/hw/xenpv/xen_domainbuild.c
@@ -25,22 +25,22 @@ static int xenstore_domain_mkdir(char *path)
     int i;
 
     if (!xs_mkdir(xenstore, 0, path)) {
-        fprintf(stderr, "%s: xs_mkdir %s: failed\n", __FUNCTION__, path);
+        fprintf(stderr, "%s: xs_mkdir %s: failed\n", __func__, path);
 	return -1;
     }
     if (!xs_set_permissions(xenstore, 0, path, perms_ro, 2)) {
-        fprintf(stderr, "%s: xs_set_permissions failed\n", __FUNCTION__);
+        fprintf(stderr, "%s: xs_set_permissions failed\n", __func__);
 	return -1;
     }
 
     for (i = 0; writable[i]; i++) {
         snprintf(subpath, sizeof(subpath), "%s/%s", path, writable[i]);
         if (!xs_mkdir(xenstore, 0, subpath)) {
-            fprintf(stderr, "%s: xs_mkdir %s: failed\n", __FUNCTION__, subpath);
+            fprintf(stderr, "%s: xs_mkdir %s: failed\n", __func__, subpath);
             return -1;
         }
         if (!xs_set_permissions(xenstore, 0, subpath, perms_rw, 2)) {
-            fprintf(stderr, "%s: xs_set_permissions failed\n", __FUNCTION__);
+            fprintf(stderr, "%s: xs_set_permissions failed\n", __func__);
             return -1;
         }
     }
@@ -158,7 +158,7 @@ static int xen_domain_watcher(void)
     char byte;
 
     if (pipe(fd) != 0) {
-        qemu_log("%s: Huh? pipe error: %s\n", __FUNCTION__, strerror(errno));
+        qemu_log("%s: Huh? pipe error: %s\n", __func__, strerror(errno));
         return -1;
     }
     if (fork() != 0)
@@ -190,7 +190,7 @@ static int xen_domain_watcher(void)
         case -1:
             if (errno == EINTR)
                 continue;
-            qemu_log("%s: Huh? read error: %s\n", __FUNCTION__, strerror(errno));
+            qemu_log("%s: Huh? read error: %s\n", __func__, strerror(errno));
             qemu_running = 0;
             break;
         case 0:
@@ -198,13 +198,13 @@ static int xen_domain_watcher(void)
             qemu_running = 0;
             break;
         default:
-            qemu_log("%s: Huh? data on the watch pipe?\n", __FUNCTION__);
+            qemu_log("%s: Huh? data on the watch pipe?\n", __func__);
             break;
         }
     }
 
     /* cleanup */
-    qemu_log("%s: destroy domain %d\n", __FUNCTION__, xen_domid);
+    qemu_log("%s: destroy domain %d\n", __func__, xen_domid);
     xc_domain_destroy(xen_xc, xen_domid);
     _exit(0);
 }
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 31d2f25627..69a52a9f93 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -36,7 +36,7 @@ static void xen_init_pv(MachineState *machine)
 
     /* Initialize backend core & drivers */
     if (xen_be_init() != 0) {
-        fprintf(stderr, "%s: xen backend core setup failed\n", __FUNCTION__);
+        fprintf(stderr, "%s: xen backend core setup failed\n", __func__);
         exit(1);
     }
 
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index cac1b2ba43..b398607b06 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -960,10 +960,10 @@ void omap_mpu_wakeup(void *opaque, int irq, int req);
 
 # define OMAP_BAD_REG(paddr)		\
         fprintf(stderr, "%s: Bad register " OMAP_FMT_plx "\n",	\
-                        __FUNCTION__, paddr)
+                        __func__, paddr)
 # define OMAP_RO_REG(paddr)		\
         fprintf(stderr, "%s: Read-only register " OMAP_FMT_plx "\n",	\
-                        __FUNCTION__, paddr)
+                        __func__, paddr)
 
 /* OMAP-specific Linux bootloader tags for the ATAG_BOARD area
    (Board-specifc tags are not here)  */
@@ -998,13 +998,13 @@ enum {
 # ifdef TCMI_VERBOSE
 #  define OMAP_8B_REG(paddr)		\
         fprintf(stderr, "%s: 8-bit register " OMAP_FMT_plx "\n",	\
-                        __FUNCTION__, paddr)
+                        __func__, paddr)
 #  define OMAP_16B_REG(paddr)		\
         fprintf(stderr, "%s: 16-bit register " OMAP_FMT_plx "\n",	\
-                        __FUNCTION__, paddr)
+                        __func__, paddr)
 #  define OMAP_32B_REG(paddr)		\
         fprintf(stderr, "%s: 32-bit register " OMAP_FMT_plx "\n",	\
-                        __FUNCTION__, paddr)
+                        __func__, paddr)
 # else
 #  define OMAP_8B_REG(paddr)
 #  define OMAP_16B_REG(paddr)
diff --git a/include/hw/arm/sharpsl.h b/include/hw/arm/sharpsl.h
index 13981a6d03..5bf6db1fa2 100644
--- a/include/hw/arm/sharpsl.h
+++ b/include/hw/arm/sharpsl.h
@@ -7,7 +7,7 @@
 #define QEMU_SHARPSL_H
 
 #define zaurus_printf(format, ...)	\
-    fprintf(stderr, "%s: " format, __FUNCTION__, ##__VA_ARGS__)
+    fprintf(stderr, "%s: " format, __func__, ##__VA_ARGS__)
 
 /* zaurus.c */
 
diff --git a/memory_mapping.c b/memory_mapping.c
index a5d38552a6..775466f3a8 100644
--- a/memory_mapping.c
+++ b/memory_mapping.c
@@ -256,7 +256,7 @@ static void guest_phys_blocks_region_add(MemoryListener *listener,
 
 #ifdef DEBUG_GUEST_PHYS_REGION_ADD
     fprintf(stderr, "%s: target_start=" TARGET_FMT_plx " target_end="
-            TARGET_FMT_plx ": %s (count: %u)\n", __FUNCTION__, target_start,
+            TARGET_FMT_plx ": %s (count: %u)\n", __func__, target_start,
             target_end, predecessor ? "joined" : "added", g->list->num);
 #endif
 }
diff --git a/migration/block.c b/migration/block.c
index e68e090c6f..1f03946797 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -631,7 +631,7 @@ static int flush_blks(QEMUFile *f)
     int ret = 0;
 
     DPRINTF("%s Enter submitted %d read_done %d transferred %d\n",
-            __FUNCTION__, block_mig_state.submitted, block_mig_state.read_done,
+            __func__, block_mig_state.submitted, block_mig_state.read_done,
             block_mig_state.transferred);
 
     blk_mig_lock();
@@ -658,7 +658,7 @@ static int flush_blks(QEMUFile *f)
     }
     blk_mig_unlock();
 
-    DPRINTF("%s Exit submitted %d read_done %d transferred %d\n", __FUNCTION__,
+    DPRINTF("%s Exit submitted %d read_done %d transferred %d\n", __func__,
             block_mig_state.submitted, block_mig_state.read_done,
             block_mig_state.transferred);
     return ret;
diff --git a/ui/cursor.c b/ui/cursor.c
index 2e2fe13fa6..f3da0cee79 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -19,11 +19,11 @@ static QEMUCursor *cursor_parse_xpm(const char *xpm[])
     if (sscanf(xpm[line], "%u %u %u %u",
                &width, &height, &colors, &chars) != 4) {
         fprintf(stderr, "%s: header parse error: \"%s\"\n",
-                __FUNCTION__, xpm[line]);
+                __func__, xpm[line]);
         return NULL;
     }
     if (chars != 1) {
-        fprintf(stderr, "%s: chars != 1 not supported\n", __FUNCTION__);
+        fprintf(stderr, "%s: chars != 1 not supported\n", __func__);
         return NULL;
     }
     line++;
@@ -41,7 +41,7 @@ static QEMUCursor *cursor_parse_xpm(const char *xpm[])
             }
         }
         fprintf(stderr, "%s: color parse error: \"%s\"\n",
-                __FUNCTION__, xpm[line]);
+                __func__, xpm[line]);
         return NULL;
     }
 
diff --git a/ui/spice-display.c b/ui/spice-display.c
index ad1ceafb3f..586f058f1b 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -630,13 +630,13 @@ static int interface_req_cursor_notification(QXLInstance *sin)
 
 static void interface_notify_update(QXLInstance *sin, uint32_t update_id)
 {
-    fprintf(stderr, "%s: abort()\n", __FUNCTION__);
+    fprintf(stderr, "%s: abort()\n", __func__);
     abort();
 }
 
 static int interface_flush_resources(QXLInstance *sin)
 {
-    fprintf(stderr, "%s: abort()\n", __FUNCTION__);
+    fprintf(stderr, "%s: abort()\n", __func__);
     abort();
     return 0;
 }
-- 
2.14.1
