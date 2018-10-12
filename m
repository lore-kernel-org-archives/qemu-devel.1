Received: from eggs.gnu.org ([2001:4830:134:3::10]:33618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlFF-0006WN-PO
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlFD-0006hD-JG
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:23:57 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Oct 2018 02:22:14 +0200
Message-Id: <20181012002217.2864-9-philmd@redhat.com>
In-Reply-To: <20181012002217.2864-1-philmd@redhat.com>
References: <20181012002217.2864-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/11] chardev: Let IOCanReadHandler use
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Fabien Chouteau <chouteau@adacore.com>, Peter Chubb <peter.chubb@nicta.com.au>, Alberto Garcia <berto@igalia.com>, Michael Walle <michael@walle.cc>, Thomas Huth <huth@tuxfamily.org>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Corey Minyard <minyard@acm.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Gerd Hoffmann <kraxel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Laurent Vivier <lvivier@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "open list:PXA2XX" <qemu-arm@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 backends/rng-egd.c          | 4 ++--
 chardev/char-mux.c          | 2 +-
 gdbstub.c                   | 2 +-
 hw/arm/pxa2xx.c             | 2 +-
 hw/arm/strongarm.c          | 2 +-
 hw/char/bcm2835_aux.c       | 2 +-
 hw/char/cadence_uart.c      | 4 ++--
 hw/char/cmsdk-apb-uart.c    | 2 +-
 hw/char/digic-uart.c        | 2 +-
 hw/char/escc.c              | 6 +++---
 hw/char/etraxfs_ser.c       | 2 +-
 hw/char/exynos4210_uart.c   | 2 +-
 hw/char/grlib_apbuart.c     | 2 +-
 hw/char/imx_serial.c        | 2 +-
 hw/char/ipoctal232.c        | 4 ++--
 hw/char/lm32_juart.c        | 2 +-
 hw/char/lm32_uart.c         | 2 +-
 hw/char/mcf_uart.c          | 2 +-
 hw/char/milkymist-uart.c    | 2 +-
 hw/char/parallel.c          | 2 +-
 hw/char/pl011.c             | 4 ++--
 hw/char/sclpconsole-lm.c    | 2 +-
 hw/char/sclpconsole.c       | 4 ++--
 hw/char/serial.c            | 4 ++--
 hw/char/sh_serial.c         | 4 ++--
 hw/char/spapr_vty.c         | 2 +-
 hw/char/stm32f2xx_usart.c   | 2 +-
 hw/char/terminal3270.c      | 2 +-
 hw/char/virtio-console.c    | 2 +-
 hw/char/xen_console.c       | 2 +-
 hw/char/xilinx_uartlite.c   | 2 +-
 hw/ipmi/ipmi_bmc_extern.c   | 2 +-
 hw/misc/ivshmem.c           | 2 +-
 hw/riscv/riscv_htif.c       | 2 +-
 hw/riscv/sifive_uart.c      | 2 +-
 hw/usb/ccid-card-passthru.c | 2 +-
 hw/usb/dev-serial.c         | 2 +-
 hw/usb/redirect.c           | 2 +-
 include/qemu/main-loop.h    | 2 +-
 monitor.c                   | 2 +-
 net/colo-compare.c          | 2 +-
 net/filter-mirror.c         | 2 +-
 net/slirp.c                 | 2 +-
 qtest.c                     | 2 +-
 target/xtensa/xtensa-semi.c | 2 +-
 45 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index b51c01f664..4a9a92a8e7 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -48,11 +48,11 @@ static void rng_egd_request_entropy(RngBackend *b, Rn=
gRequest *req)
     }
 }
=20
-static int rng_egd_chr_can_read(void *opaque)
+static size_t rng_egd_chr_can_read(void *opaque)
 {
     RngEgd *s =3D RNG_EGD(opaque);
     RngRequest *req;
-    int size =3D 0;
+    size_t size =3D 0;
=20
     QSIMPLEQ_FOREACH(req, &s->parent.requests, next) {
         size +=3D req->size - req->offset;
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index d8d6eaa646..98db12cf77 100644
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
diff --git a/gdbstub.c b/gdbstub.c
index a2fc3682ce..86d1fa62f8 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1916,7 +1916,7 @@ void gdbserver_fork(CPUState *cpu)
     cpu_watchpoint_remove_all(cpu, BP_GDB);
 }
 #else
-static int gdb_chr_can_receive(void *opaque)
+static size_t gdb_chr_can_receive(void *opaque)
 {
   /* We can handle an arbitrarily large amount of data.
    Pick the maximum packet size, which is as good as anything.  */
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 75b6aa2772..a72d9bd4fe 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1923,7 +1923,7 @@ static const MemoryRegionOps pxa2xx_fir_ops =3D {
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
-static int pxa2xx_fir_is_empty(void *opaque)
+static size_t pxa2xx_fir_is_empty(void *opaque)
 {
     PXA2xxFIrState *s =3D (PXA2xxFIrState *) opaque;
     return (s->rx_len < 64);
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 40db4e5e0a..6fdd4da3d0 100644
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
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index cb26df40f8..5dd1b652c0 100644
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
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index eb5cc974a1..5835362038 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -216,10 +216,10 @@ static void uart_parameters_setup(CadenceUARTState =
*s)
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
 }
=20
-static int uart_can_receive(void *opaque)
+static size_t uart_can_receive(void *opaque)
 {
     CadenceUARTState *s =3D opaque;
-    int ret =3D MAX(CADENCE_UART_RX_FIFO_SIZE, CADENCE_UART_TX_FIFO_SIZE=
);
+    size_t ret =3D MAX(CADENCE_UART_RX_FIFO_SIZE, CADENCE_UART_TX_FIFO_S=
IZE);
     uint32_t ch_mode =3D s->r[R_MR] & UART_MR_CHMODE;
=20
     if (ch_mode =3D=3D NORMAL_MODE || ch_mode =3D=3D ECHO_MODE) {
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index 774986d88d..c1437674a5 100644
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
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 0f41a23b54..f805ee5766 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -112,7 +112,7 @@ static const MemoryRegionOps uart_mmio_ops =3D {
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
-static int uart_can_rx(void *opaque)
+static size_t uart_can_rx(void *opaque)
 {
     DigicUartState *s =3D opaque;
=20
diff --git a/hw/char/escc.c b/hw/char/escc.c
index e655b86273..decc35b990 100644
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
@@ -573,10 +573,10 @@ static const MemoryRegionOps escc_mem_ops =3D {
     },
 };
=20
-static int serial_can_receive(void *opaque)
+static size_t serial_can_receive(void *opaque)
 {
     ESCCChannelState *s =3D opaque;
-    int ret;
+    size_t ret;
=20
     if (((s->wregs[W_RXCTRL] & RXCTRL_RXEN) =3D=3D 0) // Rx not enabled
         || ((s->rregs[R_STATUS] & STATUS_RXAV) =3D=3D STATUS_RXAV))
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index 79cd8d2dc1..970f6a6e90 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -187,7 +187,7 @@ static void serial_receive(void *opaque, const uint8_=
t *buf, size_t size)
     ser_update_irq(s);
 }
=20
-static int serial_can_receive(void *opaque)
+static size_t serial_can_receive(void *opaque)
 {
     ETRAXSerial *s =3D opaque;
=20
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 5fdf5b1f37..b93edec08a 100644
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
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index d370609a52..7b57dce7fb 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -130,7 +130,7 @@ static void uart_add_to_fifo(UART          *uart,
     uart->len +=3D length;
 }
=20
-static int grlib_apbuart_can_receive(void *opaque)
+static size_t grlib_apbuart_can_receive(void *opaque)
 {
     UART *uart =3D opaque;
=20
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index b9fdfaeb38..abbe68571d 100644
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
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 08e3f9e45f..be21303dcd 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -461,10 +461,10 @@ static void mem_write8(IPackDevice *ip, uint32_t ad=
dr, uint8_t val)
     }
 }
=20
-static int hostdev_can_receive(void *opaque)
+static size_t hostdev_can_receive(void *opaque)
 {
     SCC2698Channel *ch =3D opaque;
-    int available_bytes =3D RX_FIFO_SIZE - ch->rx_pending;
+    size_t available_bytes =3D RX_FIFO_SIZE - ch->rx_pending;
     return ch->rx_enabled ? available_bytes : 0;
 }
=20
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index ecb61ee086..51e598c570 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -95,7 +95,7 @@ static void juart_rx(void *opaque, const uint8_t *buf, =
size_t size)
     s->jrx =3D *buf | JRX_FULL;
 }
=20
-static int juart_can_rx(void *opaque)
+static size_t juart_can_rx(void *opaque)
 {
     LM32JuartState *s =3D opaque;
=20
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index ee0bf8e117..2593434f8f 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -225,7 +225,7 @@ static void uart_rx(void *opaque, const uint8_t *buf,=
 size_t size)
     uart_update_irq(s);
 }
=20
-static int uart_can_rx(void *opaque)
+static size_t uart_can_rx(void *opaque)
 {
     LM32UartState *s =3D opaque;
=20
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index e126860b46..cd9c499a51 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -267,7 +267,7 @@ static void mcf_uart_event(void *opaque, int event)
     }
 }
=20
-static int mcf_uart_can_receive(void *opaque)
+static size_t mcf_uart_can_receive(void *opaque)
 {
     mcf_uart_state *s =3D (mcf_uart_state *)opaque;
=20
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index a10c0957ff..0efcd829ce 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -170,7 +170,7 @@ static void uart_rx(void *opaque, const uint8_t *buf,=
 size_t size)
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
index 37973c32ce..10195679b4 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -224,10 +224,10 @@ static void pl011_write(void *opaque, hwaddr offset=
,
     }
 }
=20
-static int pl011_can_receive(void *opaque)
+static size_t pl011_can_receive(void *opaque)
 {
     PL011State *s =3D (PL011State *)opaque;
-    int r;
+    size_t r;
=20
     if (s->lcr & 0x10) {
         r =3D s->read_count < 16;
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index a04a2a9d80..ad5f791227 100644
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
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 62395c19f4..5ec1c4b607 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -47,10 +47,10 @@ typedef struct SCLPConsole {
 /* character layer call-back functions */
=20
 /* Return number of bytes that fit into iov buffer */
-static int chr_can_read(void *opaque)
+static size_t chr_can_read(void *opaque)
 {
     SCLPConsole *scon =3D opaque;
-    int avail =3D SIZE_BUFFER_VT220 - scon->iov_data_len;
+    size_t avail =3D SIZE_BUFFER_VT220 - scon->iov_data_len;
=20
     if (avail =3D=3D 0) {
         scon->notify =3D true;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 69baed105b..f83bb8ee4e 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -561,7 +561,7 @@ static uint64_t serial_ioport_read(void *opaque, hwad=
dr addr, unsigned size)
     return ret;
 }
=20
-static int serial_can_receive(SerialState *s)
+static size_t serial_can_receive(SerialState *s)
 {
     if(s->fcr & UART_FCR_FE) {
         if (s->recv_fifo.num < UART_FIFO_LENGTH) {
@@ -600,7 +600,7 @@ static void fifo_timeout_int (void *opaque) {
     }
 }
=20
-static int serial_can_receive1(void *opaque)
+static size_t serial_can_receive1(void *opaque)
 {
     SerialState *s =3D opaque;
     return serial_can_receive(s);
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 04fdcee328..f5402d3b5c 100644
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
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 42b4b61cce..0ac9dc8448 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -21,7 +21,7 @@ typedef struct VIOsPAPRVTYDevice {
 #define VIO_SPAPR_VTY_DEVICE(obj) \
      OBJECT_CHECK(VIOsPAPRVTYDevice, (obj), TYPE_VIO_SPAPR_VTY_DEVICE)
=20
-static int vty_can_receive(void *opaque)
+static size_t vty_can_receive(void *opaque)
 {
     VIOsPAPRVTYDevice *dev =3D VIO_SPAPR_VTY_DEVICE(opaque);
=20
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 78bf142678..63256da77b 100644
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
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 076516991e..a9db0a3401 100644
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
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index e3d368b976..b942159d82 100644
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
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index ca90c5c17e..0a1cbaeafa 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -116,7 +116,7 @@ static int ring_free_bytes(struct XenConsole *con)
     return (sizeof(intf->in) - space);
 }
=20
-static int xencons_can_receive(void *opaque)
+static size_t xencons_can_receive(void *opaque)
 {
     struct XenConsole *con =3D opaque;
     return ring_free_bytes(con);
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index b1abf8b604..2473cb0ad7 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -195,7 +195,7 @@ static void uart_rx(void *opaque, const uint8_t *buf,=
 size_t size)
     uart_update_irq(s);
 }
=20
-static int uart_can_rx(void *opaque)
+static size_t uart_can_rx(void *opaque)
 {
     XilinxUARTLite *s =3D opaque;
=20
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index c52f80f771..7107d2fe9f 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -307,7 +307,7 @@ static void handle_msg(IPMIBmcExtern *ibe)
     k->handle_rsp(ibe->parent.intf, ibe->inbuf[0], ibe->inbuf + 1, ibe->=
inpos - 1);
 }
=20
-static int can_receive(void *opaque)
+static size_t can_receive(void *opaque)
 {
     return 1;
 }
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index f506479845..01b331aaab 100644
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
diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
index 2625f5e9e8..565120df7d 100644
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
diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index d4cbf91b9f..c6a8f5fbc4 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -137,7 +137,7 @@ static void uart_rx(void *opaque, const uint8_t *buf,=
 size_t size)
     update_irq(s);
 }
=20
-static int uart_can_rx(void *opaque)
+static size_t uart_can_rx(void *opaque)
 {
     SiFiveUARTState *s =3D opaque;
=20
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index b6fa35a4b4..5dc10ef850 100644
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
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index efaeab484d..e9735d4b5d 100644
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
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index a73076ba78..f025c91d28 100644
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
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index c5a7299266..b51f9a5267 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -182,7 +182,7 @@ typedef void IOReadHandler(void *opaque, const uint8_=
t *buf, size_t size);
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
index 12401ec60b..3417c5f044 100644
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
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 433e9ba287..9321d81a98 100644
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
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 27b6e52a1d..8e16535fad 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -114,7 +114,7 @@ static void redirector_to_filter(NetFilterState *nf,
      }
 }
=20
-static int redirector_chr_can_read(void *opaque)
+static size_t redirector_chr_can_read(void *opaque)
 {
     return REDIRECTOR_MAX_LEN;
 }
diff --git a/net/slirp.c b/net/slirp.c
index 5e864f4a4f..9dbcaffb07 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -712,7 +712,7 @@ struct GuestFwd {
     Slirp *slirp;
 };
=20
-static int guestfwd_can_read(void *opaque)
+static size_t guestfwd_can_read(void *opaque)
 {
     struct GuestFwd *fwd =3D opaque;
     return slirp_socket_can_recv(fwd->slirp, fwd->server, fwd->port);
diff --git a/qtest.c b/qtest.c
index 0494afdfb3..bc685700cd 100644
--- a/qtest.c
+++ b/qtest.c
@@ -665,7 +665,7 @@ static void qtest_read(void *opaque, const uint8_t *b=
uf, size_t size)
     qtest_process_inbuf(chr, inbuf);
 }
=20
-static int qtest_can_read(void *opaque)
+static size_t qtest_can_read(void *opaque)
 {
     return 1024;
 }
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 241874ea4e..a57e61ef4a 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -161,7 +161,7 @@ typedef struct XtensaSimConsole {
=20
 static XtensaSimConsole *sim_console;
=20
-static int sim_console_can_read(void *opaque)
+static size_t sim_console_can_read(void *opaque)
 {
     XtensaSimConsole *p =3D opaque;
=20
--=20
2.17.1
