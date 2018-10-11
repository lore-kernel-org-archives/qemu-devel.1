Received: from eggs.gnu.org ([2001:4830:134:3::10]:51967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAaoD-0008Tg-Hv
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAao4-0004FW-PB
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:15:21 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 11 Oct 2018 15:14:13 +0200
Message-Id: <20181011131413.22208-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] chardev: Convert IOReadHandler to read an
 unsigned number of bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prasad J Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Fabien Chouteau <chouteau@adacore.com>, Peter Chubb <peter.chubb@nicta.com.au>, Alberto Garcia <berto@igalia.com>, Michael Walle <michael@walle.cc>, Thomas Huth <huth@tuxfamily.org>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Corey Minyard <minyard@acm.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Gerd Hoffmann <kraxel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Laurent Vivier <lvivier@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "open list:PXA2XX" <qemu-arm@nongnu.org>, "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>

The number of bytes can not be negative nor zero.

Fixed 2 format string:
- hw/char/spapr_vty.c
- hw/usb/ccid-card-passthru.c

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
See: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02212.html

 backends/rng-egd.c          | 4 ++--
 chardev/char-fd.c           | 2 +-
 chardev/char-mux.c          | 4 ++--
 chardev/char-pty.c          | 2 +-
 chardev/char-socket.c       | 4 ++--
 chardev/char-udp.c          | 2 +-
 gdbstub.c                   | 4 ++--
 hw/arm/pxa2xx.c             | 4 ++--
 hw/arm/strongarm.c          | 5 +++--
 hw/char/bcm2835_aux.c       | 4 ++--
 hw/char/cadence_uart.c      | 4 ++--
 hw/char/cmsdk-apb-uart.c    | 4 ++--
 hw/char/digic-uart.c        | 4 ++--
 hw/char/escc.c              | 6 +++---
 hw/char/etraxfs_ser.c       | 4 ++--
 hw/char/exynos4210_uart.c   | 5 +++--
 hw/char/grlib_apbuart.c     | 4 ++--
 hw/char/imx_serial.c        | 4 ++--
 hw/char/ipoctal232.c        | 4 ++--
 hw/char/lm32_juart.c        | 4 ++--
 hw/char/lm32_uart.c         | 4 ++--
 hw/char/mcf_uart.c          | 4 ++--
 hw/char/milkymist-uart.c    | 4 ++--
 hw/char/parallel.c          | 2 +-
 hw/char/pl011.c             | 4 ++--
 hw/char/sclpconsole-lm.c    | 4 ++--
 hw/char/sclpconsole.c       | 4 ++--
 hw/char/serial.c            | 6 +++---
 hw/char/sh_serial.c         | 6 +++---
 hw/char/spapr_vty.c         | 6 +++---
 hw/char/stm32f2xx_usart.c   | 5 +++--
 hw/char/terminal3270.c      | 4 ++--
 hw/char/virtio-console.c    | 4 ++--
 hw/char/xen_console.c       | 4 ++--
 hw/char/xilinx_uartlite.c   | 4 ++--
 hw/ipmi/ipmi_bmc_extern.c   | 8 ++++----
 hw/misc/ivshmem.c           | 6 +++---
 hw/riscv/riscv_htif.c       | 4 ++--
 hw/riscv/sifive_uart.c      | 4 ++--
 hw/usb/ccid-card-passthru.c | 6 +++---
 hw/usb/dev-serial.c         | 4 ++--
 hw/usb/redirect.c           | 4 ++--
 include/qemu/main-loop.h    | 4 ++--
 monitor.c                   | 6 +++---
 net/colo-compare.c          | 6 +++---
 net/filter-mirror.c         | 4 ++--
 net/slirp.c                 | 4 ++--
 qtest.c                     | 4 ++--
 target/xtensa/xtensa-semi.c | 4 ++--
 49 files changed, 107 insertions(+), 104 deletions(-)

diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index d2b9ce6cbf..d9d044ef98 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -48,7 +48,7 @@ static void rng_egd_request_entropy(RngBackend *b, RngR=
equest *req)
     }
 }
=20
-static int rng_egd_chr_can_read(void *opaque)
+static size_t rng_egd_chr_can_read(void *opaque)
 {
     RngEgd *s =3D RNG_EGD(opaque);
     RngRequest *req;
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
diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 2c9b2ce567..622adf92c5 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -69,7 +69,7 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCondit=
ion cond, void *opaque)
     return TRUE;
 }
=20
-static int fd_chr_read_poll(void *opaque)
+static size_t fd_chr_read_poll(void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
     FDChardev *s =3D FD_CHARDEV(opaque);
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 6055e76293..50bb398494 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -192,7 +192,7 @@ static void mux_chr_accept_input(Chardev *chr)
     }
 }
=20
-static int mux_chr_can_read(void *opaque)
+static size_t mux_chr_can_read(void *opaque)
 {
     MuxChardev *d =3D MUX_CHARDEV(opaque);
     int m =3D d->focus;
@@ -209,7 +209,7 @@ static int mux_chr_can_read(void *opaque)
     return 0;
 }
=20
-static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
+static void mux_chr_read(void *opaque, const uint8_t *buf, size_t size)
 {
     Chardev *chr =3D CHARDEV(opaque);
     MuxChardev *d =3D MUX_CHARDEV(opaque);
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index e8d9a53476..32e39bba3f 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -148,7 +148,7 @@ static GSource *pty_chr_add_watch(Chardev *chr, GIOCo=
ndition cond)
     return qio_channel_create_watch(s->ioc, cond);
 }
=20
-static int pty_chr_read_poll(void *opaque)
+static size_t pty_chr_read_poll(void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
     PtyChardev *s =3D PTY_CHARDEV(opaque);
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index a75b46d9fe..6e88135190 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -120,7 +120,7 @@ static void tcp_chr_accept(QIONetListener *listener,
                            QIOChannelSocket *cioc,
                            void *opaque);
=20
-static int tcp_chr_read_poll(void *opaque);
+static size_t tcp_chr_read_poll(void *opaque);
 static void tcp_chr_disconnect(Chardev *chr);
=20
 /* Called with chr_write_lock held.  */
@@ -157,7 +157,7 @@ static int tcp_chr_write(Chardev *chr, const uint8_t =
*buf, int len)
     }
 }
=20
-static int tcp_chr_read_poll(void *opaque)
+static size_t tcp_chr_read_poll(void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
     SocketChardev *s =3D SOCKET_CHARDEV(opaque);
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 097a2f0f42..d388bf21f0 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -65,7 +65,7 @@ static void udp_chr_flush_buffer(UdpChardev *s)
     }
 }
=20
-static int udp_chr_read_poll(void *opaque)
+static size_t udp_chr_read_poll(void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
     UdpChardev *s =3D UDP_CHARDEV(opaque);
diff --git a/gdbstub.c b/gdbstub.c
index c8478de8f5..0e134eef85 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1916,14 +1916,14 @@ void gdbserver_fork(CPUState *cpu)
     cpu_watchpoint_remove_all(cpu, BP_GDB);
 }
 #else
-static int gdb_chr_can_receive(void *opaque)
+static size_t gdb_chr_can_receive(void *opaque)
 {
   /* We can handle an arbitrarily large amount of data.
    Pick the maximum packet size, which is as good as anything.  */
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
index f598a1c053..a72d9bd4fe 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1923,13 +1923,13 @@ static const MemoryRegionOps pxa2xx_fir_ops =3D {
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
-static int pxa2xx_fir_is_empty(void *opaque)
+static size_t pxa2xx_fir_is_empty(void *opaque)
 {
     PXA2xxFIrState *s =3D (PXA2xxFIrState *) opaque;
     return (s->rx_len < 64);
 }
=20
-static void pxa2xx_fir_rx(void *opaque, const uint8_t *buf, int size)
+static void pxa2xx_fir_rx(void *opaque, const uint8_t *buf, size_t size)
 {
     PXA2xxFIrState *s =3D (PXA2xxFIrState *) opaque;
     if (!(s->control[0] & (1 << 4)))			/* RXE */
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index ec2627374d..6fdd4da3d0 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1058,7 +1058,7 @@ static void strongarm_uart_rx_push(StrongARMUARTSta=
te *s, uint16_t c)
         s->rx_fifo[(s->rx_start + 11) % 12] |=3D RX_FIFO_ROR;
 }
=20
-static int strongarm_uart_can_receive(void *opaque)
+static size_t strongarm_uart_can_receive(void *opaque)
 {
     StrongARMUARTState *s =3D opaque;
=20
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
index 0364596c55..5dd1b652c0 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -211,7 +211,7 @@ static void bcm2835_aux_write(void *opaque, hwaddr of=
fset, uint64_t value,
     bcm2835_aux_update(s);
 }
=20
-static int bcm2835_aux_can_receive(void *opaque)
+static size_t bcm2835_aux_can_receive(void *opaque)
 {
     BCM2835AuxState *s =3D opaque;
=20
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
index fbdbd463bb..5425abd807 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -216,7 +216,7 @@ static void uart_parameters_setup(CadenceUARTState *s=
)
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
 }
=20
-static int uart_can_receive(void *opaque)
+static size_t uart_can_receive(void *opaque)
 {
     CadenceUARTState *s =3D opaque;
     int ret =3D MAX(CADENCE_UART_RX_FIFO_SIZE, CADENCE_UART_TX_FIFO_SIZE=
);
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
index ddfbb25c24..c1437674a5 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -108,7 +108,7 @@ static void cmsdk_apb_uart_update(CMSDKAPBUART *s)
     qemu_set_irq(s->uartint, !!(s->intstatus));
 }
=20
-static int uart_can_receive(void *opaque)
+static size_t uart_can_receive(void *opaque)
 {
     CMSDKAPBUART *s =3D CMSDK_APB_UART(opaque);
=20
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
index ccc75eaa4d..f805ee5766 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -112,14 +112,14 @@ static const MemoryRegionOps uart_mmio_ops =3D {
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
-static int uart_can_rx(void *opaque)
+static size_t uart_can_rx(void *opaque)
 {
     DigicUartState *s =3D opaque;
=20
     return !(s->reg_st & ST_RX_RDY);
 }
=20
-static void uart_rx(void *opaque, const uint8_t *buf, int size)
+static void uart_rx(void *opaque, const uint8_t *buf, size_t size)
 {
     DigicUartState *s =3D opaque;
=20
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 628f5f81f7..503541ca5c 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -166,7 +166,7 @@
 #define R_EXTINT 15
=20
 static void handle_kbd_command(ESCCChannelState *s, int val);
-static int serial_can_receive(void *opaque);
+static size_t serial_can_receive(void *opaque);
 static void serial_receive_byte(ESCCChannelState *s, int ch);
=20
 static void clear_queue(void *opaque)
@@ -573,7 +573,7 @@ static const MemoryRegionOps escc_mem_ops =3D {
     },
 };
=20
-static int serial_can_receive(void *opaque)
+static size_t serial_can_receive(void *opaque)
 {
     ESCCChannelState *s =3D opaque;
     int ret;
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
index a184026410..970f6a6e90 100644
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
@@ -187,7 +187,7 @@ static void serial_receive(void *opaque, const uint8_=
t *buf, int size)
     ser_update_irq(s);
 }
=20
-static int serial_can_receive(void *opaque)
+static size_t serial_can_receive(void *opaque)
 {
     ETRAXSerial *s =3D opaque;
=20
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index a5a285655f..b93edec08a 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -487,7 +487,7 @@ static const MemoryRegionOps exynos4210_uart_ops =3D =
{
     },
 };
=20
-static int exynos4210_uart_can_receive(void *opaque)
+static size_t exynos4210_uart_can_receive(void *opaque)
 {
     Exynos4210UartState *s =3D (Exynos4210UartState *)opaque;
=20
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
index bac11bec58..7b57dce7fb 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -130,14 +130,14 @@ static void uart_add_to_fifo(UART          *uart,
     uart->len +=3D length;
 }
=20
-static int grlib_apbuart_can_receive(void *opaque)
+static size_t grlib_apbuart_can_receive(void *opaque)
 {
     UART *uart =3D opaque;
=20
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
index 1e363190e3..abbe68571d 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -293,7 +293,7 @@ static void imx_serial_write(void *opaque, hwaddr off=
set,
     }
 }
=20
-static int imx_can_receive(void *opaque)
+static size_t imx_can_receive(void *opaque)
 {
     IMXSerialState *s =3D (IMXSerialState *)opaque;
     return !(s->usr1 & USR1_RRDY);
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
index 5e09caf851..ba3f3408a2 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -461,14 +461,14 @@ static void mem_write8(IPackDevice *ip, uint32_t ad=
dr, uint8_t val)
     }
 }
=20
-static int hostdev_can_receive(void *opaque)
+static size_t hostdev_can_receive(void *opaque)
 {
     SCC2698Channel *ch =3D opaque;
     int available_bytes =3D RX_FIFO_SIZE - ch->rx_pending;
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
index d75c835ad2..51e598c570 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -88,14 +88,14 @@ void lm32_juart_set_jrx(DeviceState *d, uint32_t jtx)
     s->jrx &=3D ~JRX_FULL;
 }
=20
-static void juart_rx(void *opaque, const uint8_t *buf, int size)
+static void juart_rx(void *opaque, const uint8_t *buf, size_t size)
 {
     LM32JuartState *s =3D opaque;
=20
     s->jrx =3D *buf | JRX_FULL;
 }
=20
-static int juart_can_rx(void *opaque)
+static size_t juart_can_rx(void *opaque)
 {
     LM32JuartState *s =3D opaque;
=20
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index c4a3b9b275..2593434f8f 100644
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
@@ -225,7 +225,7 @@ static void uart_rx(void *opaque, const uint8_t *buf,=
 int size)
     uart_update_irq(s);
 }
=20
-static int uart_can_rx(void *opaque)
+static size_t uart_can_rx(void *opaque)
 {
     LM32UartState *s =3D opaque;
=20
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 787f985db6..cd9c499a51 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -267,14 +267,14 @@ static void mcf_uart_event(void *opaque, int event)
     }
 }
=20
-static int mcf_uart_can_receive(void *opaque)
+static size_t mcf_uart_can_receive(void *opaque)
 {
     mcf_uart_state *s =3D (mcf_uart_state *)opaque;
=20
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
index 548ee27bca..0efcd829ce 100644
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
@@ -170,7 +170,7 @@ static void uart_rx(void *opaque, const uint8_t *buf,=
 int size)
     uart_update_irq(s);
 }
=20
-static int uart_can_rx(void *opaque)
+static size_t uart_can_rx(void *opaque)
 {
     MilkymistUartState *s =3D opaque;
=20
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index a80da47ecf..fe0e5c8756 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -513,7 +513,7 @@ static const VMStateDescription vmstate_parallel_isa =
=3D {
     }
 };
=20
-static int parallel_can_receive(void *opaque)
+static size_t parallel_can_receive(void *opaque)
 {
      return 1;
 }
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 2aa277fc4f..8af7dd8269 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -224,7 +224,7 @@ static void pl011_write(void *opaque, hwaddr offset,
     }
 }
=20
-static int pl011_can_receive(void *opaque)
+static size_t pl011_can_receive(void *opaque)
 {
     PL011State *s =3D (PL011State *)opaque;
     int r;
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
index dbc91a1e5b..ad5f791227 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -61,7 +61,7 @@ typedef struct SCLPConsoleLM {
  * truncated to the guest in case it doesn't fit into the SCCB.
  */
=20
-static int chr_can_read(void *opaque)
+static size_t chr_can_read(void *opaque)
 {
     SCLPConsoleLM *scon =3D opaque;
=20
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
index 1fa16e9055..8ccdff50d1 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -47,7 +47,7 @@ typedef struct SCLPConsole {
 /* character layer call-back functions */
=20
 /* Return number of bytes that fit into iov buffer */
-static int chr_can_read(void *opaque)
+static size_t chr_can_read(void *opaque)
 {
     SCLPConsole *scon =3D opaque;
     int avail =3D SIZE_BUFFER_VT220 - scon->iov_data_len;
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
index 02463e3388..1763e63c3f 100644
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
@@ -600,13 +600,13 @@ static void fifo_timeout_int (void *opaque) {
     }
 }
=20
-static int serial_can_receive1(void *opaque)
+static size_t serial_can_receive1(void *opaque)
 {
     SerialState *s =3D opaque;
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
index 12831561a6..f5402d3b5c 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -300,7 +300,7 @@ static uint64_t sh_serial_read(void *opaque, hwaddr o=
ffs,
     return ret;
 }
=20
-static int sh_serial_can_receive(sh_serial_state *s)
+static size_t sh_serial_can_receive(sh_serial_state *s)
 {
     return s->scr & (1 << 4);
 }
@@ -311,7 +311,7 @@ static void sh_serial_receive_break(sh_serial_state *=
s)
         s->sr |=3D (1 << 4);
 }
=20
-static int sh_serial_can_receive1(void *opaque)
+static size_t sh_serial_can_receive1(void *opaque)
 {
     sh_serial_state *s =3D opaque;
     return sh_serial_can_receive(s);
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
index 6748334ded..0ac9dc8448 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -21,14 +21,14 @@ typedef struct VIOsPAPRVTYDevice {
 #define VIO_SPAPR_VTY_DEVICE(obj) \
      OBJECT_CHECK(VIOsPAPRVTYDevice, (obj), TYPE_VIO_SPAPR_VTY_DEVICE)
=20
-static int vty_can_receive(void *opaque)
+static size_t vty_can_receive(void *opaque)
 {
     VIOsPAPRVTYDevice *dev =3D VIO_SPAPR_VTY_DEVICE(opaque);
=20
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
index 032b5fda13..63256da77b 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -38,7 +38,7 @@
=20
 #define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
=20
-static int stm32f2xx_usart_can_receive(void *opaque)
+static size_t stm32f2xx_usart_can_receive(void *opaque)
 {
     STM32F2XXUsartState *s =3D opaque;
=20
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
index e9c45e55b1..a9db0a3401 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -38,7 +38,7 @@ typedef struct Terminal3270 {
 #define TERMINAL_3270(obj) \
         OBJECT_CHECK(Terminal3270, (obj), TYPE_TERMINAL_3270)
=20
-static int terminal_can_read(void *opaque)
+static size_t terminal_can_read(void *opaque)
 {
     Terminal3270 *t =3D opaque;
=20
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
index 2cbe1d4ed5..b942159d82 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -126,7 +126,7 @@ static void guest_writable(VirtIOSerialPort *port)
 }
=20
 /* Readiness of the guest to accept data on a port */
-static int chr_can_read(void *opaque)
+static size_t chr_can_read(void *opaque)
 {
     VirtConsole *vcon =3D opaque;
=20
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
index 44f7236382..0a1cbaeafa 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -116,13 +116,13 @@ static int ring_free_bytes(struct XenConsole *con)
     return (sizeof(intf->in) - space);
 }
=20
-static int xencons_can_receive(void *opaque)
+static size_t xencons_can_receive(void *opaque)
 {
     struct XenConsole *con =3D opaque;
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
index 2a8bc1e497..2473cb0ad7 100644
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
@@ -195,7 +195,7 @@ static void uart_rx(void *opaque, const uint8_t *buf,=
 int size)
     uart_update_irq(s);
 }
=20
-static int uart_can_rx(void *opaque)
+static size_t uart_can_rx(void *opaque)
 {
     XilinxUARTLite *s =3D opaque;
=20
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index bf0b7ee0f5..e45fdb3ce6 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -85,8 +85,8 @@ typedef struct IPMIBmcExtern {
     bool send_reset;
 } IPMIBmcExtern;
=20
-static int can_receive(void *opaque);
-static void receive(void *opaque, const uint8_t *buf, int size);
+static size_t can_receive(void *opaque);
+static void receive(void *opaque, const uint8_t *buf, size_t size);
 static void chr_event(void *opaque, int event);
=20
 static unsigned char
@@ -311,12 +311,12 @@ static void handle_msg(IPMIBmcExtern *ibe)
     k->handle_rsp(ibe->parent.intf, ibe->inbuf[0], ibe->inbuf + 1, ibe->=
inpos - 1);
 }
=20
-static int can_receive(void *opaque)
+static size_t can_receive(void *opaque)
 {
     return 1;
 }
=20
-static void receive(void *opaque, const uint8_t *buf, int size)
+static void receive(void *opaque, const uint8_t *buf, size_t size)
 {
     IPMIBmcExtern *ibe =3D opaque;
     int i;
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 6febbabcaa..aa7f5a1ef4 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -620,7 +620,7 @@ static void process_msg(IVShmemState *s, int64_t msg,=
 int fd, Error **errp)
     }
 }
=20
-static int ivshmem_can_receive(void *opaque)
+static size_t ivshmem_can_receive(void *opaque)
 {
     IVShmemState *s =3D opaque;
=20
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
index 4f7b11dc37..565120df7d 100644
--- a/hw/riscv/riscv_htif.c
+++ b/hw/riscv/riscv_htif.c
@@ -65,7 +65,7 @@ void htif_symbol_callback(const char *st_name, int st_i=
nfo, uint64_t st_value,
 /*
  * Called by the char dev to see if HTIF is ready to accept input.
  */
-static int htif_can_recv(void *opaque)
+static size_t htif_can_recv(void *opaque)
 {
     return 1;
 }
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
index b0c3798cf2..c6a8f5fbc4 100644
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
@@ -137,7 +137,7 @@ static void uart_rx(void *opaque, const uint8_t *buf,=
 int size)
     update_irq(s);
 }
=20
-static int uart_can_rx(void *opaque)
+static size_t uart_can_rx(void *opaque)
 {
     SiFiveUARTState *s =3D opaque;
=20
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 0a6c657228..5dc10ef850 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -112,7 +112,7 @@ static void ccid_card_vscard_send_init(PassthruState =
*s)
                          (uint8_t *)&msg, sizeof(msg));
 }
=20
-static int ccid_card_vscard_can_read(void *opaque)
+static size_t ccid_card_vscard_can_read(void *opaque)
 {
     PassthruState *card =3D opaque;
=20
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
index 98d1ca3c91..e9735d4b5d 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -421,7 +421,7 @@ static void usb_serial_handle_data(USBDevice *dev, US=
BPacket *p)
     }
 }
=20
-static int usb_serial_can_read(void *opaque)
+static size_t usb_serial_can_read(void *opaque)
 {
     USBSerialState *s =3D opaque;
=20
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
index 99094a721e..f025c91d28 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1284,7 +1284,7 @@ static void usbredir_do_attach(void *opaque)
  * chardev callbacks
  */
=20
-static int usbredir_chardev_can_read(void *opaque)
+static size_t usbredir_chardev_can_read(void *opaque)
 {
     USBRedirDevice *dev =3D opaque;
=20
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
index e59f9ae1e9..b51f9a5267 100644
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
@@ -182,7 +182,7 @@ typedef void IOReadHandler(void *opaque, const uint8_=
t *buf, int size);
  * is called again.  aio_notify() or qemu_notify_event() can be used to =
kick
  * the event loop.
  */
-typedef int IOCanReadHandler(void *opaque);
+typedef size_t IOCanReadHandler(void *opaque);
=20
 /**
  * qemu_set_fd_handler: Register a file descriptor with the main loop
diff --git a/monitor.c b/monitor.c
index b9258a7438..3417c5f044 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4038,7 +4038,7 @@ cleanup:
     free_cmdline_args(args, nb_args);
 }
=20
-static int monitor_can_read(void *opaque)
+static size_t monitor_can_read(void *opaque)
 {
     Monitor *mon =3D opaque;
=20
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
index dd745a491b..9321d81a98 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -683,7 +683,7 @@ err:
     return ret < 0 ? ret : -EIO;
 }
=20
-static int compare_chr_can_read(void *opaque)
+static size_t compare_chr_can_read(void *opaque)
 {
     return COMPARE_READ_LEN_MAX;
 }
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
index 3a61cf21e8..8e16535fad 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -114,12 +114,12 @@ static void redirector_to_filter(NetFilterState *nf=
,
      }
 }
=20
-static int redirector_chr_can_read(void *opaque)
+static size_t redirector_chr_can_read(void *opaque)
 {
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
index 99884de204..9dbcaffb07 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -712,13 +712,13 @@ struct GuestFwd {
     Slirp *slirp;
 };
=20
-static int guestfwd_can_read(void *opaque)
+static size_t guestfwd_can_read(void *opaque)
 {
     struct GuestFwd *fwd =3D opaque;
     return slirp_socket_can_recv(fwd->slirp, fwd->server, fwd->port);
 }
=20
-static void guestfwd_read(void *opaque, const uint8_t *buf, int size)
+static void guestfwd_read(void *opaque, const uint8_t *buf, size_t size)
 {
     struct GuestFwd *fwd =3D opaque;
     slirp_socket_recv(fwd->slirp, fwd->server, fwd->port, buf, size);
diff --git a/qtest.c b/qtest.c
index 69b9e9962b..bc685700cd 100644
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
@@ -665,7 +665,7 @@ static void qtest_read(void *opaque, const uint8_t *b=
uf, int size)
     qtest_process_inbuf(chr, inbuf);
 }
=20
-static int qtest_can_read(void *opaque)
+static size_t qtest_can_read(void *opaque)
 {
     return 1024;
 }
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 2f76216276..bd787cabc9 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -162,7 +162,7 @@ typedef struct XtensaSimConsole {
 static XtensaSimConsole *sim_console;
=20
 static IOCanReadHandler sim_console_can_read;
-static int sim_console_can_read(void *opaque)
+static size_t sim_console_can_read(void *opaque)
 {
     XtensaSimConsole *p =3D opaque;
=20
@@ -170,7 +170,7 @@ static int sim_console_can_read(void *opaque)
 }
=20
 static IOReadHandler sim_console_read;
-static void sim_console_read(void *opaque, const uint8_t *buf, int size)
+static void sim_console_read(void *opaque, const uint8_t *buf, size_t si=
ze)
 {
     XtensaSimConsole *p =3D opaque;
     size_t copy =3D sizeof(p->input.buffer) - p->input.offset;
--=20
2.17.1
