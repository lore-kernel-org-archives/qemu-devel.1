Received: from eggs.gnu.org ([2001:4830:134:3::10]:33456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlEr-0006DW-Ih
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlEo-0005l4-IL
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:23:33 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Oct 2018 02:22:13 +0200
Message-Id: <20181012002217.2864-8-philmd@redhat.com>
In-Reply-To: <20181012002217.2864-1-philmd@redhat.com>
References: <20181012002217.2864-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/11] chardev: Let IOReadHandler use
 unsigned type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <ppandit@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Fabien Chouteau <chouteau@adacore.com>, Peter Chubb <peter.chubb@nicta.com.au>, Alberto Garcia <berto@igalia.com>, Michael Walle <michael@walle.cc>, Thomas Huth <huth@tuxfamily.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Corey Minyard <minyard@acm.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Gerd Hoffmann <kraxel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Laurent Vivier <lvivier@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "open list:PXA2XX" <qemu-arm@nongnu.org>, "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>

The number of bytes can not be negative nor zero.

Fixed 2 format string:
- hw/char/spapr_vty.c
- hw/usb/ccid-card-passthru.c

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Alberto Garcia <berto@igalia.com>
---
 backends/rng-egd.c          | 2 +-
 chardev/char-mux.c          | 2 +-
 gdbstub.c                   | 2 +-
 hw/arm/pxa2xx.c             | 2 +-
 hw/arm/strongarm.c          | 3 ++-
 hw/char/bcm2835_aux.c       | 2 +-
 hw/char/cadence_uart.c      | 2 +-
 hw/char/cmsdk-apb-uart.c    | 2 +-
 hw/char/digic-uart.c        | 2 +-
 hw/char/escc.c              | 2 +-
 hw/char/etraxfs_ser.c       | 2 +-
 hw/char/exynos4210_uart.c   | 3 ++-
 hw/char/grlib_apbuart.c     | 2 +-
 hw/char/imx_serial.c        | 2 +-
 hw/char/ipoctal232.c        | 2 +-
 hw/char/lm32_juart.c        | 2 +-
 hw/char/lm32_uart.c         | 2 +-
 hw/char/mcf_uart.c          | 2 +-
 hw/char/milkymist-uart.c    | 2 +-
 hw/char/pl011.c             | 2 +-
 hw/char/sclpconsole-lm.c    | 2 +-
 hw/char/sclpconsole.c       | 2 +-
 hw/char/serial.c            | 4 ++--
 hw/char/sh_serial.c         | 2 +-
 hw/char/spapr_vty.c         | 4 ++--
 hw/char/stm32f2xx_usart.c   | 3 ++-
 hw/char/terminal3270.c      | 2 +-
 hw/char/virtio-console.c    | 2 +-
 hw/char/xen_console.c       | 2 +-
 hw/char/xilinx_uartlite.c   | 2 +-
 hw/ipmi/ipmi_bmc_extern.c   | 2 +-
 hw/misc/ivshmem.c           | 4 ++--
 hw/riscv/riscv_htif.c       | 2 +-
 hw/riscv/sifive_uart.c      | 2 +-
 hw/usb/ccid-card-passthru.c | 4 ++--
 hw/usb/dev-serial.c         | 2 +-
 hw/usb/redirect.c           | 2 +-
 include/qemu/main-loop.h    | 2 +-
 monitor.c                   | 4 ++--
 net/colo-compare.c          | 4 ++--
 net/filter-mirror.c         | 2 +-
 net/slirp.c                 | 2 +-
 qtest.c                     | 2 +-
 target/xtensa/xtensa-semi.c | 2 +-
 44 files changed, 53 insertions(+), 50 deletions(-)

diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index d2b9ce6cbf..b51c01f664 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -61,7 +61,7 @@ static int rng_egd_chr_can_read(void *opaque)
     return size;
 }
=20
-static void rng_egd_chr_read(void *opaque, const uint8_t *buf, int size)
+static void rng_egd_chr_read(void *opaque, const uint8_t *buf, size_t si=
ze)
 {
     RngEgd *s =3D RNG_EGD(opaque);
     size_t buf_offset =3D 0;
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 3ca732d3a8..d8d6eaa646 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -209,7 +209,7 @@ static int mux_chr_can_read(void *opaque)
     return 0;
 }
=20
-static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
+static void mux_chr_read(void *opaque, const uint8_t *buf, size_t size)
 {
     Chardev *chr =3D CHARDEV(opaque);
     MuxChardev *d =3D MUX_CHARDEV(opaque);
diff --git a/gdbstub.c b/gdbstub.c
index bbbb1cfcc1..a2fc3682ce 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1923,7 +1923,7 @@ static int gdb_chr_can_receive(void *opaque)
   return MAX_PACKET_LENGTH;
 }
=20
-static void gdb_chr_receive(void *opaque, const uint8_t *buf, int size)
+static void gdb_chr_receive(void *opaque, const uint8_t *buf, size_t siz=
e)
 {
     int i;
=20
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index f598a1c053..75b6aa2772 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1929,7 +1929,7 @@ static int pxa2xx_fir_is_empty(void *opaque)
     return (s->rx_len < 64);
 }
=20
-static void pxa2xx_fir_rx(void *opaque, const uint8_t *buf, int size)
+static void pxa2xx_fir_rx(void *opaque, const uint8_t *buf, size_t size)
 {
     PXA2xxFIrState *s =3D (PXA2xxFIrState *) opaque;
     if (!(s->control[0] & (1 << 4)))			/* RXE */
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index ec2627374d..40db4e5e0a 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1072,7 +1072,8 @@ static int strongarm_uart_can_receive(void *opaque)
     return 1;
 }
=20
-static void strongarm_uart_receive(void *opaque, const uint8_t *buf, int=
 size)
+static void strongarm_uart_receive(void *opaque, const uint8_t *buf,
+                                   size_t size)
 {
     StrongARMUARTState *s =3D opaque;
     int i;
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 0364596c55..cb26df40f8 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -235,7 +235,7 @@ static void bcm2835_aux_put_fifo(void *opaque, uint8_=
t value)
     bcm2835_aux_update(s);
 }
=20
-static void bcm2835_aux_receive(void *opaque, const uint8_t *buf, int si=
ze)
+static void bcm2835_aux_receive(void *opaque, const uint8_t *buf, size_t=
 size)
 {
     bcm2835_aux_put_fifo(opaque, *buf);
 }
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index fbdbd463bb..eb5cc974a1 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -332,7 +332,7 @@ static void uart_write_tx_fifo(CadenceUARTState *s, c=
onst uint8_t *buf,
     cadence_uart_xmit(NULL, G_IO_OUT, s);
 }
=20
-static void uart_receive(void *opaque, const uint8_t *buf, int size)
+static void uart_receive(void *opaque, const uint8_t *buf, size_t size)
 {
     CadenceUARTState *s =3D opaque;
     uint32_t ch_mode =3D s->r[R_MR] & UART_MR_CHMODE;
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index ddfbb25c24..774986d88d 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -119,7 +119,7 @@ static int uart_can_receive(void *opaque)
     return 0;
 }
=20
-static void uart_receive(void *opaque, const uint8_t *buf, int size)
+static void uart_receive(void *opaque, const uint8_t *buf, size_t size)
 {
     CMSDKAPBUART *s =3D CMSDK_APB_UART(opaque);
=20
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index ccc75eaa4d..0f41a23b54 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -119,7 +119,7 @@ static int uart_can_rx(void *opaque)
     return !(s->reg_st & ST_RX_RDY);
 }
=20
-static void uart_rx(void *opaque, const uint8_t *buf, int size)
+static void uart_rx(void *opaque, const uint8_t *buf, size_t size)
 {
     DigicUartState *s =3D opaque;
=20
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 628f5f81f7..e655b86273 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -601,7 +601,7 @@ static void serial_receive_break(ESCCChannelState *s)
     escc_update_irq(s);
 }
=20
-static void serial_receive1(void *opaque, const uint8_t *buf, int size)
+static void serial_receive1(void *opaque, const uint8_t *buf, size_t siz=
e)
 {
     ESCCChannelState *s =3D opaque;
     serial_receive_byte(s, buf[0]);
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index a184026410..79cd8d2dc1 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -166,7 +166,7 @@ static Property etraxfs_ser_properties[] =3D {
     DEFINE_PROP_END_OF_LIST(),
 };
=20
-static void serial_receive(void *opaque, const uint8_t *buf, int size)
+static void serial_receive(void *opaque, const uint8_t *buf, size_t size=
)
 {
     ETRAXSerial *s =3D opaque;
     int i;
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index a5a285655f..5fdf5b1f37 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -495,7 +495,8 @@ static int exynos4210_uart_can_receive(void *opaque)
 }
=20
=20
-static void exynos4210_uart_receive(void *opaque, const uint8_t *buf, in=
t size)
+static void exynos4210_uart_receive(void *opaque, const uint8_t *buf,
+                                    size_t size)
 {
     Exynos4210UartState *s =3D (Exynos4210UartState *)opaque;
     int i;
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index bac11bec58..d370609a52 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -137,7 +137,7 @@ static int grlib_apbuart_can_receive(void *opaque)
     return FIFO_LENGTH - uart->len;
 }
=20
-static void grlib_apbuart_receive(void *opaque, const uint8_t *buf, int =
size)
+static void grlib_apbuart_receive(void *opaque, const uint8_t *buf, size=
_t size)
 {
     UART *uart =3D opaque;
=20
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 1e363190e3..b9fdfaeb38 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -315,7 +315,7 @@ static void imx_put_data(void *opaque, uint32_t value=
)
     imx_update(s);
 }
=20
-static void imx_receive(void *opaque, const uint8_t *buf, int size)
+static void imx_receive(void *opaque, const uint8_t *buf, size_t size)
 {
     imx_put_data(opaque, *buf);
 }
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 5e09caf851..08e3f9e45f 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -468,7 +468,7 @@ static int hostdev_can_receive(void *opaque)
     return ch->rx_enabled ? available_bytes : 0;
 }
=20
-static void hostdev_receive(void *opaque, const uint8_t *buf, int size)
+static void hostdev_receive(void *opaque, const uint8_t *buf, size_t siz=
e)
 {
     SCC2698Channel *ch =3D opaque;
     IPOctalState *dev =3D ch->ipoctal;
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index d75c835ad2..ecb61ee086 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -88,7 +88,7 @@ void lm32_juart_set_jrx(DeviceState *d, uint32_t jtx)
     s->jrx &=3D ~JRX_FULL;
 }
=20
-static void juart_rx(void *opaque, const uint8_t *buf, int size)
+static void juart_rx(void *opaque, const uint8_t *buf, size_t size)
 {
     LM32JuartState *s =3D opaque;
=20
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index c4a3b9b275..ee0bf8e117 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -211,7 +211,7 @@ static const MemoryRegionOps uart_ops =3D {
     },
 };
=20
-static void uart_rx(void *opaque, const uint8_t *buf, int size)
+static void uart_rx(void *opaque, const uint8_t *buf, size_t size)
 {
     LM32UartState *s =3D opaque;
=20
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 787f985db6..e126860b46 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -274,7 +274,7 @@ static int mcf_uart_can_receive(void *opaque)
     return s->rx_enabled && (s->sr & MCF_UART_FFULL) =3D=3D 0;
 }
=20
-static void mcf_uart_receive(void *opaque, const uint8_t *buf, int size)
+static void mcf_uart_receive(void *opaque, const uint8_t *buf, size_t si=
ze)
 {
     mcf_uart_state *s =3D (mcf_uart_state *)opaque;
=20
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index 548ee27bca..a10c0957ff 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -158,7 +158,7 @@ static const MemoryRegionOps uart_mmio_ops =3D {
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
-static void uart_rx(void *opaque, const uint8_t *buf, int size)
+static void uart_rx(void *opaque, const uint8_t *buf, size_t size)
 {
     MilkymistUartState *s =3D opaque;
=20
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 2aa277fc4f..37973c32ce 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -260,7 +260,7 @@ static void pl011_put_fifo(void *opaque, uint32_t val=
ue)
     }
 }
=20
-static void pl011_receive(void *opaque, const uint8_t *buf, int size)
+static void pl011_receive(void *opaque, const uint8_t *buf, size_t size)
 {
     pl011_put_fifo(opaque, *buf);
 }
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index dbc91a1e5b..a04a2a9d80 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -71,7 +71,7 @@ static int chr_can_read(void *opaque)
     return 1;
 }
=20
-static void chr_read(void *opaque, const uint8_t *buf, int size)
+static void chr_read(void *opaque, const uint8_t *buf, size_t size)
 {
     SCLPConsoleLM *scon =3D opaque;
=20
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 1fa16e9055..62395c19f4 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -59,7 +59,7 @@ static int chr_can_read(void *opaque)
 }
=20
 /* Send data from a char device over to the guest */
-static void chr_read(void *opaque, const uint8_t *buf, int size)
+static void chr_read(void *opaque, const uint8_t *buf, size_t size)
 {
     SCLPConsole *scon =3D opaque;
=20
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 02463e3388..69baed105b 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -105,7 +105,7 @@ do { fprintf(stderr, "serial: " fmt , ## __VA_ARGS__)=
; } while (0)
 do {} while (0)
 #endif
=20
-static void serial_receive1(void *opaque, const uint8_t *buf, int size);
+static void serial_receive1(void *opaque, const uint8_t *buf, size_t siz=
e);
 static void serial_xmit(SerialState *s);
=20
 static inline void recv_fifo_put(SerialState *s, uint8_t chr)
@@ -606,7 +606,7 @@ static int serial_can_receive1(void *opaque)
     return serial_can_receive(s);
 }
=20
-static void serial_receive1(void *opaque, const uint8_t *buf, int size)
+static void serial_receive1(void *opaque, const uint8_t *buf, size_t siz=
e)
 {
     SerialState *s =3D opaque;
=20
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 12831561a6..04fdcee328 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -327,7 +327,7 @@ static void sh_serial_timeout_int(void *opaque)
     }
 }
=20
-static void sh_serial_receive1(void *opaque, const uint8_t *buf, int siz=
e)
+static void sh_serial_receive1(void *opaque, const uint8_t *buf, size_t =
size)
 {
     sh_serial_state *s =3D opaque;
=20
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 6748334ded..42b4b61cce 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -28,7 +28,7 @@ static int vty_can_receive(void *opaque)
     return VTERM_BUFSIZE - (dev->in - dev->out);
 }
=20
-static void vty_receive(void *opaque, const uint8_t *buf, int size)
+static void vty_receive(void *opaque, const uint8_t *buf, size_t size)
 {
     VIOsPAPRVTYDevice *dev =3D VIO_SPAPR_VTY_DEVICE(opaque);
     int i;
@@ -42,7 +42,7 @@ static void vty_receive(void *opaque, const uint8_t *bu=
f, int size)
             static bool reported;
             if (!reported) {
                 error_report("VTY input buffer exhausted - characters dr=
opped."
-                             " (input size =3D %i)", size);
+                             " (input size =3D %zu)", size);
                 reported =3D true;
             }
             break;
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 032b5fda13..78bf142678 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -49,7 +49,8 @@ static int stm32f2xx_usart_can_receive(void *opaque)
     return 0;
 }
=20
-static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf, in=
t size)
+static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf,
+                                    size_t size)
 {
     STM32F2XXUsartState *s =3D opaque;
=20
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index e9c45e55b1..076516991e 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -90,7 +90,7 @@ static gboolean send_timing_mark_cb(gpointer opaque)
  * As of now, for such case, we simply terminate the connection,
  * and we should come back here later with a better solution.
  */
-static void terminal_read(void *opaque, const uint8_t *buf, int size)
+static void terminal_read(void *opaque, const uint8_t *buf, size_t size)
 {
     Terminal3270 *t =3D opaque;
     CcwDevice *ccw_dev =3D CCW_DEVICE(t);
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 2cbe1d4ed5..e3d368b976 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -134,7 +134,7 @@ static int chr_can_read(void *opaque)
 }
=20
 /* Send data from a char device over to the guest */
-static void chr_read(void *opaque, const uint8_t *buf, int size)
+static void chr_read(void *opaque, const uint8_t *buf, size_t size)
 {
     VirtConsole *vcon =3D opaque;
     VirtIOSerialPort *port =3D VIRTIO_SERIAL_PORT(vcon);
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 44f7236382..ca90c5c17e 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -122,7 +122,7 @@ static int xencons_can_receive(void *opaque)
     return ring_free_bytes(con);
 }
=20
-static void xencons_receive(void *opaque, const uint8_t *buf, int len)
+static void xencons_receive(void *opaque, const uint8_t *buf, size_t len=
)
 {
     struct XenConsole *con =3D opaque;
     struct xencons_interface *intf =3D con->sring;
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 2a8bc1e497..b1abf8b604 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -177,7 +177,7 @@ static Property xilinx_uartlite_properties[] =3D {
     DEFINE_PROP_END_OF_LIST(),
 };
=20
-static void uart_rx(void *opaque, const uint8_t *buf, int size)
+static void uart_rx(void *opaque, const uint8_t *buf, size_t size)
 {
     XilinxUARTLite *s =3D opaque;
=20
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 8c78b9804b..c52f80f771 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -312,7 +312,7 @@ static int can_receive(void *opaque)
     return 1;
 }
=20
-static void receive(void *opaque, const uint8_t *buf, int size)
+static void receive(void *opaque, const uint8_t *buf, size_t size)
 {
     IPMIBmcExtern *ibe =3D opaque;
     int i;
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 8cb17b9dd4..f506479845 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -628,14 +628,14 @@ static int ivshmem_can_receive(void *opaque)
     return sizeof(s->msg_buf) - s->msg_buffered_bytes;
 }
=20
-static void ivshmem_read(void *opaque, const uint8_t *buf, int size)
+static void ivshmem_read(void *opaque, const uint8_t *buf, size_t size)
 {
     IVShmemState *s =3D opaque;
     Error *err =3D NULL;
     int fd;
     int64_t msg;
=20
-    assert(size >=3D 0 && s->msg_buffered_bytes + size <=3D sizeof(s->ms=
g_buf));
+    assert(s->msg_buffered_bytes + size <=3D sizeof(s->msg_buf));
     memcpy((unsigned char *)&s->msg_buf + s->msg_buffered_bytes, buf, si=
ze);
     s->msg_buffered_bytes +=3D size;
     if (s->msg_buffered_bytes < sizeof(s->msg_buf)) {
diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
index 4f7b11dc37..2625f5e9e8 100644
--- a/hw/riscv/riscv_htif.c
+++ b/hw/riscv/riscv_htif.c
@@ -74,7 +74,7 @@ static int htif_can_recv(void *opaque)
  * Called by the char dev to supply input to HTIF console.
  * We assume that we will receive one character at a time.
  */
-static void htif_recv(void *opaque, const uint8_t *buf, int size)
+static void htif_recv(void *opaque, const uint8_t *buf, size_t size)
 {
     HTIFState *htifstate =3D opaque;
=20
diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index b0c3798cf2..d4cbf91b9f 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -123,7 +123,7 @@ static const MemoryRegionOps uart_ops =3D {
     }
 };
=20
-static void uart_rx(void *opaque, const uint8_t *buf, int size)
+static void uart_rx(void *opaque, const uint8_t *buf, size_t size)
 {
     SiFiveUARTState *s =3D opaque;
=20
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 0a6c657228..b6fa35a4b4 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -270,13 +270,13 @@ static void ccid_card_vscard_drop_connection(Passth=
ruState *card)
     card->vscard_in_pos =3D card->vscard_in_hdr =3D 0;
 }
=20
-static void ccid_card_vscard_read(void *opaque, const uint8_t *buf, int =
size)
+static void ccid_card_vscard_read(void *opaque, const uint8_t *buf, size=
_t size)
 {
     PassthruState *card =3D opaque;
     VSCMsgHeader *hdr;
=20
     if (card->vscard_in_pos + size > VSCARD_IN_SIZE) {
-        error_report("no room for data: pos %u +  size %d > %" PRId64 ".=
"
+        error_report("no room for data: pos %u +  size %zu > %" PRId64 "=
."
                      " dropping connection.",
                      card->vscard_in_pos, size, VSCARD_IN_SIZE);
         ccid_card_vscard_drop_connection(card);
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 98d1ca3c91..efaeab484d 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -431,7 +431,7 @@ static int usb_serial_can_read(void *opaque)
     return RECV_BUF - s->recv_used;
 }
=20
-static void usb_serial_read(void *opaque, const uint8_t *buf, int size)
+static void usb_serial_read(void *opaque, const uint8_t *buf, size_t siz=
e)
 {
     USBSerialState *s =3D opaque;
     int first_size, start;
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 99094a721e..a73076ba78 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1302,7 +1302,7 @@ static int usbredir_chardev_can_read(void *opaque)
     return 1 * MiB;
 }
=20
-static void usbredir_chardev_read(void *opaque, const uint8_t *buf, int =
size)
+static void usbredir_chardev_read(void *opaque, const uint8_t *buf, size=
_t size)
 {
     USBRedirDevice *dev =3D opaque;
=20
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index e59f9ae1e9..c5a7299266 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -167,7 +167,7 @@ void qemu_del_wait_object(HANDLE handle, WaitObjectFu=
nc *func, void *opaque);
=20
 /* async I/O support */
=20
-typedef void IOReadHandler(void *opaque, const uint8_t *buf, int size);
+typedef void IOReadHandler(void *opaque, const uint8_t *buf, size_t size=
);
=20
 /**
  * IOCanReadHandler: Return the number of bytes that #IOReadHandler can =
accept
diff --git a/monitor.c b/monitor.c
index b9258a7438..12401ec60b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4240,14 +4240,14 @@ static void handle_qmp_command(void *opaque, QObj=
ect *req, Error *err)
     qemu_bh_schedule(qmp_dispatcher_bh);
 }
=20
-static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
+static void monitor_qmp_read(void *opaque, const uint8_t *buf, size_t si=
ze)
 {
     Monitor *mon =3D opaque;
=20
     json_message_parser_feed(&mon->qmp.parser, (const char *) buf, size)=
;
 }
=20
-static void monitor_read(void *opaque, const uint8_t *buf, int size)
+static void monitor_read(void *opaque, const uint8_t *buf, size_t size)
 {
     Monitor *old_mon =3D cur_mon;
     int i;
diff --git a/net/colo-compare.c b/net/colo-compare.c
index dd745a491b..433e9ba287 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -692,7 +692,7 @@ static int compare_chr_can_read(void *opaque)
  * Called from the main thread on the primary for packets
  * arriving over the socket from the primary.
  */
-static void compare_pri_chr_in(void *opaque, const uint8_t *buf, int siz=
e)
+static void compare_pri_chr_in(void *opaque, const uint8_t *buf, size_t =
size)
 {
     CompareState *s =3D COLO_COMPARE(opaque);
     int ret;
@@ -709,7 +709,7 @@ static void compare_pri_chr_in(void *opaque, const ui=
nt8_t *buf, int size)
  * Called from the main thread on the primary for packets
  * arriving over the socket from the secondary.
  */
-static void compare_sec_chr_in(void *opaque, const uint8_t *buf, int siz=
e)
+static void compare_sec_chr_in(void *opaque, const uint8_t *buf, size_t =
size)
 {
     CompareState *s =3D COLO_COMPARE(opaque);
     int ret;
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 3a61cf21e8..27b6e52a1d 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -119,7 +119,7 @@ static int redirector_chr_can_read(void *opaque)
     return REDIRECTOR_MAX_LEN;
 }
=20
-static void redirector_chr_read(void *opaque, const uint8_t *buf, int si=
ze)
+static void redirector_chr_read(void *opaque, const uint8_t *buf, size_t=
 size)
 {
     NetFilterState *nf =3D opaque;
     MirrorState *s =3D FILTER_REDIRECTOR(nf);
diff --git a/net/slirp.c b/net/slirp.c
index 99884de204..5e864f4a4f 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -718,7 +718,7 @@ static int guestfwd_can_read(void *opaque)
     return slirp_socket_can_recv(fwd->slirp, fwd->server, fwd->port);
 }
=20
-static void guestfwd_read(void *opaque, const uint8_t *buf, int size)
+static void guestfwd_read(void *opaque, const uint8_t *buf, size_t size)
 {
     struct GuestFwd *fwd =3D opaque;
     slirp_socket_recv(fwd->slirp, fwd->server, fwd->port, buf, size);
diff --git a/qtest.c b/qtest.c
index 69b9e9962b..0494afdfb3 100644
--- a/qtest.c
+++ b/qtest.c
@@ -657,7 +657,7 @@ static void qtest_process_inbuf(CharBackend *chr, GSt=
ring *inbuf)
     }
 }
=20
-static void qtest_read(void *opaque, const uint8_t *buf, int size)
+static void qtest_read(void *opaque, const uint8_t *buf, size_t size)
 {
     CharBackend *chr =3D opaque;
=20
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index e389069f0b..241874ea4e 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -168,7 +168,7 @@ static int sim_console_can_read(void *opaque)
     return sizeof(p->input.buffer) - p->input.offset;
 }
=20
-static void sim_console_read(void *opaque, const uint8_t *buf, int size)
+static void sim_console_read(void *opaque, const uint8_t *buf, size_t si=
ze)
 {
     XtensaSimConsole *p =3D opaque;
     size_t copy =3D sizeof(p->input.buffer) - p->input.offset;
--=20
2.17.1
