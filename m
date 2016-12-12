Received: from eggs.gnu.org ([2001:4830:134:3::10]:42930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZKd-0003lV-MV
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZKR-0003Sb-ET
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZKQ-0003Rq-LU
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:15 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C93C1C04B924
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:44:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:41 +0300
Message-Id: <20161212224325.20790-11-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/54] char: rename CharDriverState Chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Uniformify chardev type name.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 backends/baum.c                   |  56 +--
 backends/msmouse.c                |  42 +-
 backends/rng-egd.c                |   4 +-
 backends/testdev.c                |  28 +-
 gdbstub.c                         |  12 +-
 hw/arm/fsl-imx25.c                |   2 +-
 hw/arm/fsl-imx31.c                |   2 +-
 hw/arm/fsl-imx6.c                 |   2 +-
 hw/arm/nseries.c                  |   2 +-
 hw/arm/omap2.c                    |   2 +-
 hw/arm/pxa2xx.c                   |   2 +-
 hw/arm/virt.c                     |   2 +-
 hw/bt/hci-csr.c                   |  14 +-
 hw/char/escc.c                    |   2 +-
 hw/char/exynos4210_uart.c         |   2 +-
 hw/char/imx_serial.c              |   2 +-
 hw/char/mcf_uart.c                |   4 +-
 hw/char/omap_uart.c               |   6 +-
 hw/char/parallel.c                |   2 +-
 hw/char/serial-isa.c              |   2 +-
 hw/char/serial.c                  |   4 +-
 hw/char/sh_serial.c               |   2 +-
 hw/char/spapr_vty.c               |   2 +-
 hw/char/virtio-console.c          |   2 +-
 hw/core/qdev-properties-system.c  |   4 +-
 hw/display/milkymist-tmu2.c       |   2 +-
 hw/display/sm501.c                |   2 +-
 hw/isa/isa-bus.c                  |   2 +-
 hw/isa/pc87312.c                  |   2 +-
 hw/mips/mips_malta.c              |   4 +-
 hw/misc/ivshmem.c                 |   2 +-
 hw/misc/milkymist-pfpu.c          |   2 +-
 hw/usb/ccid-card-passthru.c       |   2 +-
 hw/usb/dev-serial.c               |   6 +-
 hw/usb/redirect.c                 |   4 +-
 monitor.c                         |   4 +-
 net/colo-compare.c                |   4 +-
 net/filter-mirror.c               |   4 +-
 net/slirp.c                       |   2 +-
 net/vhost-user.c                  |  10 +-
 qemu-char.c                       | 839 +++++++++++++++++++-------------=
------
 qmp.c                             |   2 +-
 qtest.c                           |   2 +-
 replay/replay-char.c              |   8 +-
 spice-qemu-char.c                 |  80 ++--
 stubs/get-next-serial.c           |   2 +-
 stubs/monitor-init.c              |   2 +-
 stubs/replay.c                    |   4 +-
 tests/test-char.c                 |  10 +-
 tests/vhost-user-test.c           |   4 +-
 ui/console.c                      |  40 +-
 ui/gtk.c                          |  26 +-
 vl.c                              |  10 +-
 xen-common-stub.c                 |   2 +-
 xen-common.c                      |   4 +-
 hw/lm32/lm32.h                    |   4 +-
 hw/lm32/milkymist-hw.h            |   2 +-
 include/hw/arm/exynos4210.h       |   2 +-
 include/hw/arm/omap.h             |   6 +-
 include/hw/bt.h                   |   4 +-
 include/hw/char/cadence_uart.h    |   2 +-
 include/hw/char/escc.h            |   2 +-
 include/hw/char/pl011.h           |   4 +-
 include/hw/char/serial.h          |   4 +-
 include/hw/char/xilinx_uartlite.h |   2 +-
 include/hw/cris/etraxfs.h         |   2 +-
 include/hw/devices.h              |   2 +-
 include/hw/i386/pc.h              |   2 +-
 include/hw/m68k/mcf.h             |   4 +-
 include/hw/ppc/spapr_vio.h        |   2 +-
 include/hw/qdev-properties.h      |   2 +-
 include/hw/sh4/sh.h               |   2 +-
 include/hw/sparc/grlib.h          |   2 +-
 include/hw/xen/xen.h              |   2 +-
 include/monitor/monitor.h         |   2 +-
 include/qemu/typedefs.h           |   2 +-
 include/sysemu/char.h             |  94 ++---
 include/sysemu/replay.h           |   4 +-
 include/sysemu/sysemu.h           |   4 +-
 include/ui/gtk.h                  |   2 +-
 include/ui/qemu-spice.h           |   2 +-
 81 files changed, 728 insertions(+), 725 deletions(-)

diff --git a/backends/baum.c b/backends/baum.c
index 6244929ac6..7fd1ebc557 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -87,7 +87,7 @@
 #define BUF_SIZE 256
=20
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
=20
     brlapi_handle_t *brlapi;
     int brlapi_fd;
@@ -100,7 +100,7 @@ typedef struct {
     uint8_t out_buf_used, out_buf_ptr;
=20
     QEMUTimer *cellCount_timer;
-} BaumDriverState;
+} BaumChardev;
=20
 /* Let's assume NABCC by default */
 enum way {
@@ -225,7 +225,7 @@ static const uint8_t nabcc_translation[2][256] =3D {
 };
=20
 /* The guest OS has started discussing with us, finish initializing BrlA=
PI */
-static int baum_deferred_init(BaumDriverState *baum)
+static int baum_deferred_init(BaumChardev *baum)
 {
 #if defined(CONFIG_SDL)
 #if SDL_COMPILEDVERSION < SDL_VERSIONNUM(2, 0, 0)
@@ -268,9 +268,9 @@ static int baum_deferred_init(BaumDriverState *baum)
 }
=20
 /* The serial port can receive more of our data */
-static void baum_accept_input(struct CharDriverState *chr)
+static void baum_accept_input(struct Chardev *chr)
 {
-    BaumDriverState *baum =3D (BaumDriverState *)chr;
+    BaumChardev *baum =3D (BaumChardev *)chr;
     int room, first;
=20
     if (!baum->out_buf_used)
@@ -294,9 +294,9 @@ static void baum_accept_input(struct CharDriverState =
*chr)
 }
=20
 /* We want to send a packet */
-static void baum_write_packet(BaumDriverState *baum, const uint8_t *buf,=
 int len)
+static void baum_write_packet(BaumChardev *baum, const uint8_t *buf, int=
 len)
 {
-    CharDriverState *chr =3D (CharDriverState *)baum;
+    Chardev *chr =3D (Chardev *)baum;
     uint8_t io_buf[1 + 2 * len], *cur =3D io_buf;
     int room;
     *cur++ =3D ESC;
@@ -337,14 +337,14 @@ static void baum_write_packet(BaumDriverState *baum=
, const uint8_t *buf, int len
 /* Called when the other end seems to have a wrong idea of our display s=
ize */
 static void baum_cellCount_timer_cb(void *opaque)
 {
-    BaumDriverState *baum =3D opaque;
+    BaumChardev *baum =3D opaque;
     uint8_t cell_count[] =3D { BAUM_RSP_CellCount, baum->x * baum->y };
     DPRINTF("Timeout waiting for DisplayData, sending cell count\n");
     baum_write_packet(baum, cell_count, sizeof(cell_count));
 }
=20
 /* Try to interpret a whole incoming packet */
-static int baum_eat_packet(BaumDriverState *baum, const uint8_t *buf, in=
t len)
+static int baum_eat_packet(BaumChardev *baum, const uint8_t *buf, int le=
n)
 {
     const uint8_t *cur =3D buf;
     uint8_t req =3D 0;
@@ -485,9 +485,9 @@ static int baum_eat_packet(BaumDriverState *baum, con=
st uint8_t *buf, int len)
 }
=20
 /* The other end is writing some data.  Store it and try to interpret */
-static int baum_write(CharDriverState *chr, const uint8_t *buf, int len)
+static int baum_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    BaumDriverState *baum =3D (BaumDriverState *)chr;
+    BaumChardev *baum =3D (BaumChardev *)chr;
     int tocopy, cur, eaten, orig_len =3D len;
=20
     if (!len)
@@ -526,14 +526,16 @@ static int baum_write(CharDriverState *chr, const u=
int8_t *buf, int len)
 }
=20
 /* Send the key code to the other end */
-static void baum_send_key(BaumDriverState *baum, uint8_t type, uint8_t v=
alue) {
+static void baum_send_key(BaumChardev *baum, uint8_t type, uint8_t value=
)
+{
     uint8_t packet[] =3D { type, value };
     DPRINTF("writing key %x %x\n", type, value);
     baum_write_packet(baum, packet, sizeof(packet));
 }
=20
-static void baum_send_key2(BaumDriverState *baum, uint8_t type, uint8_t =
value,
-                           uint8_t value2) {
+static void baum_send_key2(BaumChardev *baum, uint8_t type, uint8_t valu=
e,
+                           uint8_t value2)
+{
     uint8_t packet[] =3D { type, value, value2 };
     DPRINTF("writing key %x %x\n", type, value);
     baum_write_packet(baum, packet, sizeof(packet));
@@ -542,7 +544,7 @@ static void baum_send_key2(BaumDriverState *baum, uin=
t8_t type, uint8_t value,
 /* We got some data on the BrlAPI socket */
 static void baum_chr_read(void *opaque)
 {
-    BaumDriverState *baum =3D opaque;
+    BaumChardev *baum =3D opaque;
     brlapi_keyCode_t code;
     int ret;
     if (!baum->brlapi)
@@ -626,9 +628,9 @@ static void baum_chr_read(void *opaque)
     }
 }
=20
-static void baum_free(struct CharDriverState *chr)
+static void baum_free(struct Chardev *chr)
 {
-    BaumDriverState *baum =3D (BaumDriverState *)chr;
+    BaumChardev *baum =3D (BaumChardev *)chr;
=20
     timer_free(baum->cellCount_timer);
     if (baum->brlapi) {
@@ -637,23 +639,23 @@ static void baum_free(struct CharDriverState *chr)
     }
 }
=20
-static CharDriverState *chr_baum_init(const CharDriver *driver,
-                                      const char *id,
-                                      ChardevBackend *backend,
-                                      ChardevReturn *ret,
-                                      bool *be_opened,
-                                      Error **errp)
+static Chardev *chr_baum_init(const CharDriver *driver,
+                              const char *id,
+                              ChardevBackend *backend,
+                              ChardevReturn *ret,
+                              bool *be_opened,
+                              Error **errp)
 {
     ChardevCommon *common =3D backend->u.braille.data;
-    BaumDriverState *baum;
-    CharDriverState *chr;
+    BaumChardev *baum;
+    Chardev *chr;
     brlapi_handle_t *handle;
=20
     chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
-    baum =3D (BaumDriverState *)chr;
+    baum =3D (BaumChardev *)chr;
=20
     handle =3D g_malloc0(brlapi_getHandleSize());
     baum->brlapi =3D handle;
@@ -681,7 +683,7 @@ fail_handle:
 static void register_types(void)
 {
     static const CharDriver driver =3D {
-        .instance_size =3D sizeof(BaumDriverState),
+        .instance_size =3D sizeof(BaumChardev),
         .kind =3D CHARDEV_BACKEND_KIND_BRAILLE,
         .parse =3D NULL, .create =3D chr_baum_init,
         .chr_write =3D baum_write,
diff --git a/backends/msmouse.c b/backends/msmouse.c
index e954720e28..fabc2926d6 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -31,7 +31,7 @@
 #define MSMOUSE_HI2(n) (((n) & 0xc0) >> 6)
=20
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
=20
     QemuInputHandlerState *hs;
     int axis[INPUT_AXIS__MAX];
@@ -39,11 +39,11 @@ typedef struct {
     bool btnc[INPUT_BUTTON__MAX];
     uint8_t outbuf[32];
     int outlen;
-} MouseState;
+} MouseChardev;
=20
-static void msmouse_chr_accept_input(CharDriverState *chr)
+static void msmouse_chr_accept_input(Chardev *chr)
 {
-    MouseState *mouse =3D (MouseState *)chr;
+    MouseChardev *mouse =3D (MouseChardev *)chr;
     int len;
=20
     len =3D qemu_chr_be_can_write(chr);
@@ -61,7 +61,7 @@ static void msmouse_chr_accept_input(CharDriverState *c=
hr)
     }
 }
=20
-static void msmouse_queue_event(MouseState *mouse)
+static void msmouse_queue_event(MouseChardev *mouse)
 {
     unsigned char bytes[4] =3D { 0x40, 0x00, 0x00, 0x00 };
     int dx, dy, count =3D 3;
@@ -98,7 +98,7 @@ static void msmouse_queue_event(MouseState *mouse)
 static void msmouse_input_event(DeviceState *dev, QemuConsole *src,
                                 InputEvent *evt)
 {
-    MouseState *mouse =3D (MouseState *)dev;
+    MouseChardev *mouse =3D (MouseChardev *)dev;
     InputMoveEvent *move;
     InputBtnEvent *btn;
=20
@@ -122,22 +122,22 @@ static void msmouse_input_event(DeviceState *dev, Q=
emuConsole *src,
=20
 static void msmouse_input_sync(DeviceState *dev)
 {
-    MouseState *mouse =3D (MouseState *)dev;
-    CharDriverState *chr =3D (CharDriverState *)dev;
+    MouseChardev *mouse =3D (MouseChardev *)dev;
+    Chardev *chr =3D (Chardev *)dev;
=20
     msmouse_queue_event(mouse);
     msmouse_chr_accept_input(chr);
 }
=20
-static int msmouse_chr_write (struct CharDriverState *s, const uint8_t *=
buf, int len)
+static int msmouse_chr_write(struct Chardev *s, const uint8_t *buf, int =
len)
 {
     /* Ignore writes to mouse port */
     return len;
 }
=20
-static void msmouse_chr_free(struct CharDriverState *chr)
+static void msmouse_chr_free(struct Chardev *chr)
 {
-    MouseState *mouse =3D (MouseState *)chr;
+    MouseChardev *mouse =3D (MouseChardev *)chr;
=20
     qemu_input_handler_unregister(mouse->hs);
 }
@@ -149,16 +149,16 @@ static QemuInputHandler msmouse_handler =3D {
     .sync  =3D msmouse_input_sync,
 };
=20
-static CharDriverState *qemu_chr_open_msmouse(const CharDriver *driver,
-                                              const char *id,
-                                              ChardevBackend *backend,
-                                              ChardevReturn *ret,
-                                              bool *be_opened,
-                                              Error **errp)
+static Chardev *qemu_chr_open_msmouse(const CharDriver *driver,
+                                      const char *id,
+                                      ChardevBackend *backend,
+                                      ChardevReturn *ret,
+                                      bool *be_opened,
+                                      Error **errp)
 {
     ChardevCommon *common =3D backend->u.msmouse.data;
-    MouseState *mouse;
-    CharDriverState *chr;
+    MouseChardev *mouse;
+    Chardev *chr;
=20
     chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
@@ -166,7 +166,7 @@ static CharDriverState *qemu_chr_open_msmouse(const C=
harDriver *driver,
     }
     *be_opened =3D false;
=20
-    mouse =3D (MouseState *)chr;
+    mouse =3D (MouseChardev *)chr;
     mouse->hs =3D qemu_input_handler_register((DeviceState *)mouse,
                                             &msmouse_handler);
=20
@@ -177,7 +177,7 @@ static CharDriverState *qemu_chr_open_msmouse(const C=
harDriver *driver,
 static void register_types(void)
 {
     static const CharDriver driver =3D {
-        .instance_size =3D sizeof(MouseState),
+        .instance_size =3D sizeof(MouseChardev),
         .kind =3D CHARDEV_BACKEND_KIND_MSMOUSE,
         .parse =3D NULL, .create =3D qemu_chr_open_msmouse,
         .chr_write =3D msmouse_chr_write,
diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index 69c04b1b26..380b19a0a1 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -86,7 +86,7 @@ static void rng_egd_chr_read(void *opaque, const uint8_=
t *buf, int size)
 static void rng_egd_opened(RngBackend *b, Error **errp)
 {
     RngEgd *s =3D RNG_EGD(b);
-    CharDriverState *chr;
+    Chardev *chr;
=20
     if (s->chr_name =3D=3D NULL) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
@@ -125,7 +125,7 @@ static void rng_egd_set_chardev(Object *obj, const ch=
ar *value, Error **errp)
 static char *rng_egd_get_chardev(Object *obj, Error **errp)
 {
     RngEgd *s =3D RNG_EGD(obj);
-    CharDriverState *chr =3D qemu_chr_fe_get_driver(&s->chr);
+    Chardev *chr =3D qemu_chr_fe_get_driver(&s->chr);
=20
     if (chr && chr->label) {
         return g_strdup(chr->label);
diff --git a/backends/testdev.c b/backends/testdev.c
index 69cf188b95..1d06c8633e 100644
--- a/backends/testdev.c
+++ b/backends/testdev.c
@@ -30,14 +30,14 @@
 #define BUF_SIZE 32
=20
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
=20
     uint8_t in_buf[32];
     int in_buf_used;
-} TestdevCharState;
+} TestdevChardev;
=20
 /* Try to interpret a whole incoming packet */
-static int testdev_eat_packet(TestdevCharState *testdev)
+static int testdev_eat_packet(TestdevChardev *testdev)
 {
     const uint8_t *cur =3D testdev->in_buf;
     int len =3D testdev->in_buf_used;
@@ -78,9 +78,9 @@ static int testdev_eat_packet(TestdevCharState *testdev=
)
 }
=20
 /* The other end is writing some data.  Store it and try to interpret */
-static int testdev_write(CharDriverState *chr, const uint8_t *buf, int l=
en)
+static int testdev_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    TestdevCharState *testdev =3D (TestdevCharState *)chr;
+    TestdevChardev *testdev =3D (TestdevChardev *)chr;
     int tocopy, eaten, orig_len =3D len;
=20
     while (len) {
@@ -103,15 +103,15 @@ static int testdev_write(CharDriverState *chr, cons=
t uint8_t *buf, int len)
     return orig_len;
 }
=20
-static CharDriverState *chr_testdev_init(const CharDriver *driver,
-                                         const char *id,
-                                         ChardevBackend *backend,
-                                         ChardevReturn *ret,
-                                         bool *be_opened,
-                                         Error **errp)
+static Chardev *chr_testdev_init(const CharDriver *driver,
+                                 const char *id,
+                                 ChardevBackend *backend,
+                                 ChardevReturn *ret,
+                                 bool *be_opened,
+                                 Error **errp)
 {
-    TestdevCharState *testdev =3D g_new0(TestdevCharState, 1);;
-    CharDriverState *chr =3D (CharDriverState *)testdev;
+    TestdevChardev *testdev =3D g_new0(TestdevChardev, 1);;
+    Chardev *chr =3D (Chardev *)testdev;
=20
     chr->driver =3D driver;
=20
@@ -121,7 +121,7 @@ static CharDriverState *chr_testdev_init(const CharDr=
iver *driver,
 static void register_types(void)
 {
     static const CharDriver driver =3D {
-        .instance_size =3D sizeof(TestdevCharState),
+        .instance_size =3D sizeof(TestdevChardev),
         .kind =3D CHARDEV_BACKEND_KIND_TESTDEV,
         .parse =3D NULL, .create =3D chr_testdev_init,
         .chr_write =3D testdev_write,
diff --git a/gdbstub.c b/gdbstub.c
index a8def2fd6f..22fa291bc9 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -303,7 +303,7 @@ typedef struct GDBState {
     int running_state;
 #else
     CharBackend chr;
-    CharDriverState *mon_chr;
+    Chardev *mon_chr;
 #endif
     char syscall_buf[256];
     gdb_syscall_complete_cb current_syscall_cb;
@@ -1471,7 +1471,7 @@ void gdb_exit(CPUArchState *env, int code)
   GDBState *s;
   char buf[4];
 #ifndef CONFIG_USER_ONLY
-  CharDriverState *chr;
+  Chardev *chr;
 #endif
=20
   s =3D gdbserver_state;
@@ -1696,7 +1696,7 @@ static void gdb_monitor_output(GDBState *s, const c=
har *msg, int len)
     put_packet(s, buf);
 }
=20
-static int gdb_monitor_write(CharDriverState *chr, const uint8_t *buf, i=
nt len)
+static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
 {
     const char *p =3D (const char *)buf;
     int max_sz;
@@ -1727,11 +1727,11 @@ int gdbserver_start(const char *device)
 {
     GDBState *s;
     char gdbstub_device_name[128];
-    CharDriverState *chr =3D NULL;
-    CharDriverState *mon_chr;
+    Chardev *chr =3D NULL;
+    Chardev *mon_chr;
     ChardevCommon common =3D { 0 };
     static const CharDriver driver =3D {
-        .instance_size =3D sizeof(CharDriverState),
+        .instance_size =3D sizeof(Chardev),
         .kind =3D -1,
         .chr_write =3D gdb_monitor_write
     };
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 7bb7be76b6..2126f73ca0 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -118,7 +118,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error=
 **errp)
         };
=20
         if (i < MAX_SERIAL_PORTS) {
-            CharDriverState *chr;
+            Chardev *chr;
=20
             chr =3D serial_hds[i];
=20
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index f23672b222..dd1c713ae3 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -107,7 +107,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error=
 **errp)
         };
=20
         if (i < MAX_SERIAL_PORTS) {
-            CharDriverState *chr;
+            Chardev *chr;
=20
             chr =3D serial_hds[i];
=20
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index e93532fb57..76dd8a48ca 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -187,7 +187,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error =
**errp)
         };
=20
         if (i < MAX_SERIAL_PORTS) {
-            CharDriverState *chr;
+            Chardev *chr;
=20
             chr =3D serial_hds[i];
=20
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index c86cf80514..503a3b6d24 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -786,7 +786,7 @@ static void n8x0_cbus_setup(struct n800_s *s)
=20
 static void n8x0_uart_setup(struct n800_s *s)
 {
-    CharDriverState *radio =3D uart_hci_init();
+    Chardev *radio =3D uart_hci_init();
=20
     qdev_connect_gpio_out(s->mpu->gpio, N8X0_BT_RESET_GPIO,
                     csrhci_pins_get(radio)[csrhci_pin_reset]);
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 6f05c98d3e..cf1b4ba58f 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -792,7 +792,7 @@ static const MemoryRegionOps omap_sti_fifo_ops =3D {
 static struct omap_sti_s *omap_sti_init(struct omap_target_agent_s *ta,
                 MemoryRegion *sysmem,
                 hwaddr channel_base, qemu_irq irq, omap_clk clk,
-                CharDriverState *chr)
+                Chardev *chr)
 {
     struct omap_sti_s *s =3D g_new0(struct omap_sti_s, 1);
=20
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 21ea1d6210..6467bb362e 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -2029,7 +2029,7 @@ static PXA2xxFIrState *pxa2xx_fir_init(MemoryRegion=
 *sysmem,
                                        hwaddr base,
                                        qemu_irq irq, qemu_irq rx_dma,
                                        qemu_irq tx_dma,
-                                       CharDriverState *chr)
+                                       Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *sbd;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d04e4acbd9..c10ddaac9c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -626,7 +626,7 @@ static void create_gic(VirtBoardInfo *vbi, qemu_irq *=
pic, int type,
 }
=20
 static void create_uart(const VirtBoardInfo *vbi, qemu_irq *pic, int uar=
t,
-                        MemoryRegion *mem, CharDriverState *chr)
+                        MemoryRegion *mem, Chardev *chr)
 {
     char *nodename;
     hwaddr base =3D vbi->memmap[uart].base;
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index e2c78b8720..153ed2f1ba 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -29,7 +29,7 @@
 #include "qapi/error.h"
=20
 struct csrhci_s {
-    CharDriverState parent;
+    Chardev parent;
     int enable;
     qemu_irq *pins;
     int pin_state;
@@ -79,7 +79,7 @@ enum {
=20
 static inline void csrhci_fifo_wake(struct csrhci_s *s)
 {
-    CharDriverState *chr =3D (CharDriverState *)s;
+    Chardev *chr =3D (Chardev *)s;
     CharBackend *be =3D chr->be;
=20
     if (!s->enable || !s->out_len)
@@ -313,7 +313,7 @@ static void csrhci_ready_for_next_inpkt(struct csrhci=
_s *s)
     s->in_hdr =3D INT_MAX;
 }
=20
-static int csrhci_write(struct CharDriverState *chr,
+static int csrhci_write(struct Chardev *chr,
                 const uint8_t *buf, int len)
 {
     struct csrhci_s *s =3D (struct csrhci_s *)chr;
@@ -386,7 +386,7 @@ static void csrhci_out_hci_packet_acl(void *opaque,
     csrhci_fifo_wake(s);
 }
=20
-static int csrhci_ioctl(struct CharDriverState *chr, int cmd, void *arg)
+static int csrhci_ioctl(struct Chardev *chr, int cmd, void *arg)
 {
     QEMUSerialSetParams *ssp;
     struct csrhci_s *s =3D (struct csrhci_s *) chr;
@@ -455,14 +455,14 @@ static void csrhci_pins(void *opaque, int line, int=
 level)
     }
 }
=20
-qemu_irq *csrhci_pins_get(CharDriverState *chr)
+qemu_irq *csrhci_pins_get(Chardev *chr)
 {
     struct csrhci_s *s =3D (struct csrhci_s *) chr;
=20
     return s->pins;
 }
=20
-CharDriverState *uart_hci_init(void)
+Chardev *uart_hci_init(void)
 {
     static const CharDriver hci_driver =3D {
         .instance_size =3D sizeof(struct csrhci_s),
@@ -472,7 +472,7 @@ CharDriverState *uart_hci_init(void)
     };
     Error *err =3D NULL;
     ChardevCommon common =3D { 0, };
-    CharDriverState *chr =3D qemu_chr_alloc(&hci_driver, &common, &err);
+    Chardev *chr =3D qemu_chr_alloc(&hci_driver, &common, &err);
     struct csrhci_s *s =3D (struct csrhci_s *)chr;
=20
     if (err) {
diff --git a/hw/char/escc.c b/hw/char/escc.c
index d6662dc77d..9228091cec 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -689,7 +689,7 @@ static const VMStateDescription vmstate_escc =3D {
 };
=20
 MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq irqB,
-              CharDriverState *chrA, CharDriverState *chrB,
+              Chardev *chrA, Chardev *chrB,
               int clock, int it_shift)
 {
     DeviceState *dev;
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 571c324004..ad7ab4eb7d 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -586,7 +586,7 @@ static const VMStateDescription vmstate_exynos4210_ua=
rt =3D {
 DeviceState *exynos4210_uart_create(hwaddr addr,
                                     int fifo_size,
                                     int channel,
-                                    CharDriverState *chr,
+                                    Chardev *chr,
                                     qemu_irq irq)
 {
     DeviceState  *dev;
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 99545fc359..52e67f8dc9 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -170,7 +170,7 @@ static void imx_serial_write(void *opaque, hwaddr off=
set,
                              uint64_t value, unsigned size)
 {
     IMXSerialState *s =3D (IMXSerialState *)opaque;
-    CharDriverState *chr =3D qemu_chr_fe_get_driver(&s->chr);
+    Chardev *chr =3D qemu_chr_fe_get_driver(&s->chr);
     unsigned char ch;
=20
     DPRINTF("write(offset=3D0x%" HWADDR_PRIx ", value =3D 0x%x) to %s\n"=
,
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index ecaa091190..80c380e077 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -275,7 +275,7 @@ static void mcf_uart_receive(void *opaque, const uint=
8_t *buf, int size)
     mcf_uart_push_byte(s, buf[0]);
 }
=20
-void *mcf_uart_init(qemu_irq irq, CharDriverState *chr)
+void *mcf_uart_init(qemu_irq irq, Chardev *chr)
 {
     mcf_uart_state *s;
=20
@@ -300,7 +300,7 @@ static const MemoryRegionOps mcf_uart_ops =3D {
 void mcf_uart_mm_init(MemoryRegion *sysmem,
                       hwaddr base,
                       qemu_irq irq,
-                      CharDriverState *chr)
+                      Chardev *chr)
 {
     mcf_uart_state *s;
=20
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index 893ab108bc..31ebb1592c 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -54,7 +54,7 @@ void omap_uart_reset(struct omap_uart_s *s)
 struct omap_uart_s *omap_uart_init(hwaddr base,
                 qemu_irq irq, omap_clk fclk, omap_clk iclk,
                 qemu_irq txdma, qemu_irq rxdma,
-                const char *label, CharDriverState *chr)
+                const char *label, Chardev *chr)
 {
     struct omap_uart_s *s =3D g_new0(struct omap_uart_s, 1);
=20
@@ -163,7 +163,7 @@ struct omap_uart_s *omap2_uart_init(MemoryRegion *sys=
mem,
                 struct omap_target_agent_s *ta,
                 qemu_irq irq, omap_clk fclk, omap_clk iclk,
                 qemu_irq txdma, qemu_irq rxdma,
-                const char *label, CharDriverState *chr)
+                const char *label, Chardev *chr)
 {
     hwaddr base =3D omap_l4_attach(ta, 0, NULL);
     struct omap_uart_s *s =3D omap_uart_init(base, irq,
@@ -178,7 +178,7 @@ struct omap_uart_s *omap2_uart_init(MemoryRegion *sys=
mem,
     return s;
 }
=20
-void omap_uart_attach(struct omap_uart_s *s, CharDriverState *chr)
+void omap_uart_attach(struct omap_uart_s *s, Chardev *chr)
 {
     /* TODO: Should reuse or destroy current s->serial */
     s->serial =3D serial_mm_init(get_system_memory(), s->base, 2, s->irq=
,
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index f2d56666b7..c71a4a0f4f 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -603,7 +603,7 @@ static const MemoryRegionOps parallel_mm_ops =3D {
 /* If fd is zero, it means that the parallel device uses the console */
 bool parallel_mm_init(MemoryRegion *address_space,
                       hwaddr base, int it_shift, qemu_irq irq,
-                      CharDriverState *chr)
+                      Chardev *chr)
 {
     ParallelState *s;
=20
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 54d3a12f51..d7c5cc11fe 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -121,7 +121,7 @@ static void serial_register_types(void)
=20
 type_init(serial_register_types)
=20
-static void serial_isa_init(ISABus *bus, int index, CharDriverState *chr=
)
+static void serial_isa_init(ISABus *bus, int index, Chardev *chr)
 {
     DeviceState *dev;
     ISADevice *isadev;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index ffbacd8227..11628149a1 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -927,7 +927,7 @@ const MemoryRegionOps serial_io_ops =3D {
 };
=20
 SerialState *serial_init(int base, qemu_irq irq, int baudbase,
-                         CharDriverState *chr, MemoryRegion *system_io)
+                         Chardev *chr, MemoryRegion *system_io)
 {
     SerialState *s;
=20
@@ -983,7 +983,7 @@ static const MemoryRegionOps serial_mm_ops[3] =3D {
 SerialState *serial_mm_init(MemoryRegion *address_space,
                             hwaddr base, int it_shift,
                             qemu_irq irq, int baudbase,
-                            CharDriverState *chr, enum device_endian end=
)
+                            Chardev *chr, enum device_endian end)
 {
     SerialState *s;
=20
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 9d35564bcf..303eb0a678 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -356,7 +356,7 @@ static const MemoryRegionOps sh_serial_ops =3D {
=20
 void sh_serial_init(MemoryRegion *sysmem,
                     hwaddr base, int feat,
-                    uint32_t freq, CharDriverState *chr,
+                    uint32_t freq, Chardev *chr,
                     qemu_irq eri_source,
                     qemu_irq rxi_source,
                     qemu_irq txi_source,
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 7c22b8bd0e..e30c8da57c 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -141,7 +141,7 @@ static target_ulong h_get_term_char(PowerPCCPU *cpu, =
sPAPRMachineState *spapr,
     return H_SUCCESS;
 }
=20
-void spapr_vty_create(VIOsPAPRBus *bus, CharDriverState *chardev)
+void spapr_vty_create(VIOsPAPRBus *bus, Chardev *chardev)
 {
     DeviceState *dev;
=20
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 776205b4a9..798d9b69fd 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -168,7 +168,7 @@ static void virtconsole_realize(DeviceState *dev, Err=
or **errp)
     VirtIOSerialPort *port =3D VIRTIO_SERIAL_PORT(dev);
     VirtConsole *vcon =3D VIRTIO_CONSOLE(dev);
     VirtIOSerialPortClass *k =3D VIRTIO_SERIAL_PORT_GET_CLASS(dev);
-    CharDriverState *chr =3D qemu_chr_fe_get_driver(&vcon->chr);
+    Chardev *chr =3D qemu_chr_fe_get_driver(&vcon->chr);
=20
     if (port->id =3D=3D 0 && !k->is_console) {
         error_setg(errp, "Port number 0 on virtio-serial devices reserve=
d "
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
index 1b7ea50e9f..94f4d8bde4 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -179,7 +179,7 @@ static void set_chr(Object *obj, Visitor *v, const ch=
ar *name, void *opaque,
     Error *local_err =3D NULL;
     Property *prop =3D opaque;
     CharBackend *be =3D qdev_get_prop_ptr(dev, prop);
-    CharDriverState *s;
+    Chardev *s;
     char *str;
=20
     if (dev->realized) {
@@ -411,7 +411,7 @@ void qdev_prop_set_drive(DeviceState *dev, const char=
 *name,
 }
=20
 void qdev_prop_set_chr(DeviceState *dev, const char *name,
-                       CharDriverState *value)
+                       Chardev *value)
 {
     assert(!value || value->label);
     object_property_set_str(OBJECT(dev),
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 5c666f9b24..18f27fcd4f 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -85,7 +85,7 @@ struct MilkymistTMU2State {
     SysBusDevice parent_obj;
=20
     MemoryRegion regs_region;
-    CharDriverState *chr;
+    Chardev *chr;
     qemu_irq irq;
=20
     uint32_t regs[R_MAX];
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 5f71012108..040a0b93f2 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1392,7 +1392,7 @@ static const GraphicHwOps sm501_ops =3D {
 };
=20
 void sm501_init(MemoryRegion *address_space_mem, uint32_t base,
-                uint32_t local_mem_bytes, qemu_irq irq, CharDriverState =
*chr)
+                uint32_t local_mem_bytes, qemu_irq irq, Chardev *chr)
 {
     SM501State * s;
     DeviceState *dev;
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 9d07b118c0..166ac936d7 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -287,7 +287,7 @@ MemoryRegion *isa_address_space_io(ISADevice *dev)
=20
 type_init(isabus_register_types)
=20
-static void parallel_init(ISABus *bus, int index, CharDriverState *chr)
+static void parallel_init(ISABus *bus, int index, Chardev *chr)
 {
     DeviceState *dev;
     ISADevice *isadev;
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index b1c1a0acb1..c707d24db4 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -268,7 +268,7 @@ static void pc87312_realize(DeviceState *dev, Error *=
*errp)
     DeviceState *d;
     ISADevice *isa;
     ISABus *bus;
-    CharDriverState *chr;
+    Chardev *chr;
     DriveInfo *drive;
     char name[5];
     int i;
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index cf48f420cc..75877de11c 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -551,10 +551,10 @@ static void malta_fgpa_display_event(void *opaque, =
int event)
 }
=20
 static MaltaFPGAState *malta_fpga_init(MemoryRegion *address_space,
-         hwaddr base, qemu_irq uart_irq, CharDriverState *uart_chr)
+         hwaddr base, qemu_irq uart_irq, Chardev *uart_chr)
 {
     MaltaFPGAState *s;
-    CharDriverState *chr;
+    Chardev *chr;
=20
     s =3D (MaltaFPGAState *)g_malloc0(sizeof(MaltaFPGAState));
=20
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index abeaf3da08..c836222b12 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -868,7 +868,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Er=
ror **errp)
         s->ivshmem_bar2 =3D host_memory_backend_get_memory(s->hostmem,
                                                          &error_abort);
     } else {
-        CharDriverState *chr =3D qemu_chr_fe_get_driver(&s->server_chr);
+        Chardev *chr =3D qemu_chr_fe_get_driver(&s->server_chr);
         assert(chr);
=20
         IVSHMEM_DPRINTF("using shared memory server (socket =3D %s)\n",
diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 3ca25894f1..86f5e383b0 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -125,7 +125,7 @@ struct MilkymistPFPUState {
     SysBusDevice parent_obj;
=20
     MemoryRegion regs_region;
-    CharDriverState *chr;
+    Chardev *chr;
     qemu_irq irq;
=20
     uint32_t regs[R_MAX];
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 88cb6d8978..daab0d56cf 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -264,7 +264,7 @@ static void ccid_card_vscard_handle_message(PassthruS=
tate *card,
=20
 static void ccid_card_vscard_drop_connection(PassthruState *card)
 {
-    CharDriverState *chr =3D qemu_chr_fe_get_driver(&card->cs);
+    Chardev *chr =3D qemu_chr_fe_get_driver(&card->cs);
=20
     qemu_chr_fe_deinit(&card->cs);
     qemu_chr_delete(chr);
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 6066d9b0f7..6d5137383b 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -483,7 +483,7 @@ static void usb_serial_realize(USBDevice *dev, Error =
**errp)
 {
     USBSerialState *s =3D USB_SERIAL_DEV(dev);
     Error *local_err =3D NULL;
-    CharDriverState *chr =3D qemu_chr_fe_get_driver(&s->cs);
+    Chardev *chr =3D qemu_chr_fe_get_driver(&s->cs);
=20
     usb_desc_create_serial(dev);
     usb_desc_init(dev);
@@ -512,7 +512,7 @@ static void usb_serial_realize(USBDevice *dev, Error =
**errp)
 static USBDevice *usb_serial_init(USBBus *bus, const char *filename)
 {
     USBDevice *dev;
-    CharDriverState *cdrv;
+    Chardev *cdrv;
     uint32_t vendorid =3D 0, productid =3D 0;
     char label[32];
     static int index;
@@ -564,7 +564,7 @@ static USBDevice *usb_serial_init(USBBus *bus, const =
char *filename)
 static USBDevice *usb_braille_init(USBBus *bus, const char *unused)
 {
     USBDevice *dev;
-    CharDriverState *cdrv;
+    Chardev *cdrv;
=20
     cdrv =3D qemu_chr_new("braille", "braille");
     if (!cdrv)
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index a65723781e..3359e6a747 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -284,7 +284,7 @@ static gboolean usbredir_write_unblocked(GIOChannel *=
chan, GIOCondition cond,
 static int usbredir_write(void *priv, uint8_t *data, int count)
 {
     USBRedirDevice *dev =3D priv;
-    CharDriverState *chr =3D qemu_chr_fe_get_driver(&dev->cs);
+    Chardev *chr =3D qemu_chr_fe_get_driver(&dev->cs);
     int r;
=20
     if (!chr->be_open) {
@@ -1430,7 +1430,7 @@ static void usbredir_cleanup_device_queues(USBRedir=
Device *dev)
 static void usbredir_handle_destroy(USBDevice *udev)
 {
     USBRedirDevice *dev =3D USB_REDIRECT(udev);
-    CharDriverState *chr =3D qemu_chr_fe_get_driver(&dev->cs);
+    Chardev *chr =3D qemu_chr_fe_get_driver(&dev->cs);
=20
     qemu_chr_fe_deinit(&dev->cs);
     qemu_chr_delete(chr);
diff --git a/monitor.c b/monitor.c
index 17948f5289..a82f547488 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3193,7 +3193,7 @@ static void ringbuf_completion(ReadLineState *rs, c=
onst char *str)
         ChardevInfo *chr_info =3D list->value;
=20
         if (!strncmp(chr_info->label, str, len)) {
-            CharDriverState *chr =3D qemu_chr_find(chr_info->label);
+            Chardev *chr =3D qemu_chr_find(chr_info->label);
             if (chr && qemu_chr_is_ringbuf(chr)) {
                 readline_add_completion(rs, chr_info->label);
             }
@@ -3981,7 +3981,7 @@ static void __attribute__((constructor)) monitor_lo=
ck_init(void)
     qemu_mutex_init(&monitor_lock);
 }
=20
-void monitor_init(CharDriverState *chr, int flags)
+void monitor_init(Chardev *chr, int flags)
 {
     static int is_first_init =3D 1;
     Monitor *mon;
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 9bfc736f55..4962976c22 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -564,7 +564,7 @@ static void compare_sec_rs_finalize(SocketReadState *=
sec_rs)
  * Return 0 is success.
  * Return 1 is failed.
  */
-static int find_and_check_chardev(CharDriverState **chr,
+static int find_and_check_chardev(Chardev **chr,
                                   char *chr_name,
                                   Error **errp)
 {
@@ -611,7 +611,7 @@ static void check_old_packet_regular(void *opaque)
 static void colo_compare_complete(UserCreatable *uc, Error **errp)
 {
     CompareState *s =3D COLO_COMPARE(uc);
-    CharDriverState *chr;
+    Chardev *chr;
     char thread_name[64];
     static int compare_id;
=20
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index b7d645617c..aa0aa98fa5 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -191,7 +191,7 @@ static void filter_redirector_cleanup(NetFilterState =
*nf)
 static void filter_mirror_setup(NetFilterState *nf, Error **errp)
 {
     MirrorState *s =3D FILTER_MIRROR(nf);
-    CharDriverState *chr;
+    Chardev *chr;
=20
     if (!s->outdev) {
         error_setg(errp, "filter mirror needs 'outdev' "
@@ -220,7 +220,7 @@ static void redirector_rs_finalize(SocketReadState *r=
s)
 static void filter_redirector_setup(NetFilterState *nf, Error **errp)
 {
     MirrorState *s =3D FILTER_REDIRECTOR(nf);
-    CharDriverState *chr;
+    Chardev *chr;
=20
     if (!s->indev && !s->outdev) {
         error_setg(errp, "filter redirector needs 'indev' or "
diff --git a/net/slirp.c b/net/slirp.c
index bcd1c5f57d..f97ec23345 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -748,7 +748,7 @@ static int slirp_guestfwd(SlirpState *s, const char *=
config_str,
         }
     } else {
         Error *err =3D NULL;
-        CharDriverState *chr =3D qemu_chr_new(buf, p);
+        Chardev *chr =3D qemu_chr_new(buf, p);
=20
         if (!chr) {
             error_report("could not open guest forwarding device '%s'", =
buf);
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 7aff77ee4a..b0f0ab6cc8 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -195,7 +195,7 @@ static void net_vhost_user_event(void *opaque, int ev=
ent)
     const char *name =3D opaque;
     NetClientState *ncs[MAX_QUEUE_NUM];
     VhostUserState *s;
-    CharDriverState *chr;
+    Chardev *chr;
     Error *err =3D NULL;
     int queues;
=20
@@ -232,7 +232,7 @@ static void net_vhost_user_event(void *opaque, int ev=
ent)
 }
=20
 static int net_vhost_user_init(NetClientState *peer, const char *device,
-                               const char *name, CharDriverState *chr,
+                               const char *name, Chardev *chr,
                                int queues)
 {
     Error *err =3D NULL;
@@ -274,10 +274,10 @@ static int net_vhost_user_init(NetClientState *peer=
, const char *device,
     return 0;
 }
=20
-static CharDriverState *net_vhost_claim_chardev(
+static Chardev *net_vhost_claim_chardev(
     const NetdevVhostUserOptions *opts, Error **errp)
 {
-    CharDriverState *chr =3D qemu_chr_find(opts->chardev);
+    Chardev *chr =3D qemu_chr_find(opts->chardev);
=20
     if (chr =3D=3D NULL) {
         error_setg(errp, "chardev \"%s\" not found", opts->chardev);
@@ -324,7 +324,7 @@ int net_init_vhost_user(const Netdev *netdev, const c=
har *name,
 {
     int queues;
     const NetdevVhostUserOptions *vhost_user_opts;
-    CharDriverState *chr;
+    Chardev *chr;
=20
     assert(netdev->type =3D=3D NET_CLIENT_DRIVER_VHOST_USER);
     vhost_user_opts =3D &netdev->u.vhost_user;
diff --git a/qemu-char.c b/qemu-char.c
index cc1cf3b676..24169a95b5 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -89,7 +89,7 @@
 #define READ_RETRIES 10
 #define TCP_MAX_FDS 16
=20
-typedef struct MuxDriver MuxDriver;
+typedef struct MuxChardev MuxChardev;
=20
 /***********************************************************/
 /* Socket address helpers */
@@ -157,19 +157,19 @@ static char *sockaddr_to_str(struct sockaddr_storag=
e *ss, socklen_t ss_len,
 /***********************************************************/
 /* character device */
=20
-static QTAILQ_HEAD(CharDriverStateHead, CharDriverState) chardevs =3D
+static QTAILQ_HEAD(ChardevHead, Chardev) chardevs =3D
     QTAILQ_HEAD_INITIALIZER(chardevs);
=20
-static void qemu_chr_free_common(CharDriverState *chr);
+static void qemu_chr_free_common(Chardev *chr);
=20
-CharDriverState *qemu_chr_alloc(const CharDriver *driver,
+Chardev *qemu_chr_alloc(const CharDriver *driver,
                                 ChardevCommon *backend, Error **errp)
 {
-    CharDriverState *chr;
+    Chardev *chr;
=20
     assert(driver);
     assert(driver->chr_write);
-    assert(driver->instance_size >=3D sizeof(CharDriverState));
+    assert(driver->instance_size >=3D sizeof(Chardev));
=20
     chr =3D g_malloc0(driver->instance_size);
     qemu_mutex_init(&chr->chr_write_lock);
@@ -197,7 +197,7 @@ CharDriverState *qemu_chr_alloc(const CharDriver *dri=
ver,
     return chr;
 }
=20
-void qemu_chr_be_event(CharDriverState *s, int event)
+void qemu_chr_be_event(Chardev *s, int event)
 {
     CharBackend *be =3D s->be;
=20
@@ -218,7 +218,7 @@ void qemu_chr_be_event(CharDriverState *s, int event)
     be->chr_event(be->opaque, event);
 }
=20
-void qemu_chr_be_generic_open(CharDriverState *s)
+void qemu_chr_be_generic_open(Chardev *s)
 {
     qemu_chr_be_event(s, CHR_EVENT_OPENED);
 }
@@ -226,7 +226,7 @@ void qemu_chr_be_generic_open(CharDriverState *s)
=20
 /* Not reporting errors from writing to logfile, as logs are
  * defined to be "best effort" only */
-static void qemu_chr_fe_write_log(CharDriverState *s,
+static void qemu_chr_fe_write_log(Chardev *s,
                                   const uint8_t *buf, size_t len)
 {
     size_t done =3D 0;
@@ -251,7 +251,8 @@ static void qemu_chr_fe_write_log(CharDriverState *s,
     }
 }
=20
-static int qemu_chr_fe_write_buffer(CharDriverState *s, const uint8_t *b=
uf, int len, int *offset)
+static int qemu_chr_fe_write_buffer(Chardev *s,
+                                    const uint8_t *buf, int len, int *of=
fset)
 {
     int res =3D 0;
     *offset =3D 0;
@@ -279,14 +280,14 @@ static int qemu_chr_fe_write_buffer(CharDriverState=
 *s, const uint8_t *buf, int
     return res;
 }
=20
-static bool qemu_chr_replay(CharDriverState *chr)
+static bool qemu_chr_replay(Chardev *chr)
 {
     return qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
 }
=20
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
 {
-    CharDriverState *s =3D be->chr;
+    Chardev *s =3D be->chr;
     int ret;
=20
     if (!s) {
@@ -317,7 +318,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t =
*buf, int len)
     return ret;
 }
=20
-static int qemu_chr_write_all(CharDriverState *s, const uint8_t *buf, in=
t len)
+static int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len)
 {
     int offset;
     int res;
@@ -343,7 +344,7 @@ static int qemu_chr_write_all(CharDriverState *s, con=
st uint8_t *buf, int len)
=20
 int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
 {
-    CharDriverState *s =3D be->chr;
+    Chardev *s =3D be->chr;
=20
     if (!s) {
         return 0;
@@ -354,7 +355,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint=
8_t *buf, int len)
=20
 int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
 {
-    CharDriverState *s =3D be->chr;
+    Chardev *s =3D be->chr;
     int offset =3D 0, counter =3D 10;
     int res;
=20
@@ -400,7 +401,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *bu=
f, int len)
=20
 int qemu_chr_fe_ioctl(CharBackend *be, int cmd, void *arg)
 {
-    CharDriverState *s =3D be->chr;
+    Chardev *s =3D be->chr;
     int res;
=20
     if (!s || !s->driver->chr_ioctl || qemu_chr_replay(s)) {
@@ -412,7 +413,7 @@ int qemu_chr_fe_ioctl(CharBackend *be, int cmd, void =
*arg)
     return res;
 }
=20
-int qemu_chr_be_can_write(CharDriverState *s)
+int qemu_chr_be_can_write(Chardev *s)
 {
     CharBackend *be =3D s->be;
=20
@@ -423,7 +424,7 @@ int qemu_chr_be_can_write(CharDriverState *s)
     return be->chr_can_read(be->opaque);
 }
=20
-void qemu_chr_be_write_impl(CharDriverState *s, uint8_t *buf, int len)
+void qemu_chr_be_write_impl(Chardev *s, uint8_t *buf, int len)
 {
     CharBackend *be =3D s->be;
=20
@@ -432,7 +433,7 @@ void qemu_chr_be_write_impl(CharDriverState *s, uint8=
_t *buf, int len)
     }
 }
=20
-void qemu_chr_be_write(CharDriverState *s, uint8_t *buf, int len)
+void qemu_chr_be_write(Chardev *s, uint8_t *buf, int len)
 {
     if (qemu_chr_replay(s)) {
         if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
@@ -446,7 +447,7 @@ void qemu_chr_be_write(CharDriverState *s, uint8_t *b=
uf, int len)
=20
 int qemu_chr_fe_get_msgfd(CharBackend *be)
 {
-    CharDriverState *s =3D be->chr;
+    Chardev *s =3D be->chr;
     int fd;
     int res =3D (qemu_chr_fe_get_msgfds(be, &fd, 1) =3D=3D 1) ? fd : -1;
     if (s && qemu_chr_replay(s)) {
@@ -459,7 +460,7 @@ int qemu_chr_fe_get_msgfd(CharBackend *be)
=20
 int qemu_chr_fe_get_msgfds(CharBackend *be, int *fds, int len)
 {
-    CharDriverState *s =3D be->chr;
+    Chardev *s =3D be->chr;
=20
     if (!s) {
         return -1;
@@ -470,7 +471,7 @@ int qemu_chr_fe_get_msgfds(CharBackend *be, int *fds,=
 int len)
=20
 int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num)
 {
-    CharDriverState *s =3D be->chr;
+    Chardev *s =3D be->chr;
=20
     if (!s) {
         return -1;
@@ -479,14 +480,14 @@ int qemu_chr_fe_set_msgfds(CharBackend *be, int *fd=
s, int num)
     return s->driver->set_msgfds ? s->driver->set_msgfds(s, fds, num) : =
-1;
 }
=20
-int qemu_chr_add_client(CharDriverState *s, int fd)
+int qemu_chr_add_client(Chardev *s, int fd)
 {
     return s->driver->chr_add_client ? s->driver->chr_add_client(s, fd) =
: -1;
 }
=20
 void qemu_chr_fe_accept_input(CharBackend *be)
 {
-    CharDriverState *s =3D be->chr;
+    Chardev *s =3D be->chr;
=20
     if (!s) {
         return;
@@ -510,23 +511,23 @@ void qemu_chr_fe_printf(CharBackend *be, const char=
 *fmt, ...)
     va_end(ap);
 }
=20
-static void remove_fd_in_watch(CharDriverState *chr);
-static void mux_chr_set_handlers(CharDriverState *chr, GMainContext *con=
text);
-static void mux_set_focus(MuxDriver *d, int focus);
+static void remove_fd_in_watch(Chardev *chr);
+static void mux_chr_set_handlers(Chardev *chr, GMainContext *context);
+static void mux_set_focus(MuxChardev *d, int focus);
=20
-static int null_chr_write(CharDriverState *chr, const uint8_t *buf, int =
len)
+static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     return len;
 }
=20
-static CharDriverState *qemu_chr_open_null(const CharDriver *driver,
-                                           const char *id,
-                                           ChardevBackend *backend,
-                                           ChardevReturn *ret,
-                                           bool *be_opened,
-                                           Error **errp)
+static Chardev *qemu_chr_open_null(const CharDriver *driver,
+                                   const char *id,
+                                   ChardevBackend *backend,
+                                   ChardevReturn *ret,
+                                   bool *be_opened,
+                                   Error **errp)
 {
-    CharDriverState *chr;
+    Chardev *chr;
     ChardevCommon *common =3D backend->u.null.data;
=20
     chr =3D qemu_chr_alloc(driver, common, errp);
@@ -538,7 +539,7 @@ static CharDriverState *qemu_chr_open_null(const Char=
Driver *driver,
 }
=20
 static const CharDriver null_driver =3D {
-    .instance_size =3D sizeof(CharDriverState),
+    .instance_size =3D sizeof(Chardev),
     .kind =3D CHARDEV_BACKEND_KIND_NULL, .create =3D qemu_chr_open_null,
     .chr_write =3D null_chr_write
 };
@@ -547,8 +548,8 @@ static const CharDriver null_driver =3D {
 #define MAX_MUX 4
 #define MUX_BUFFER_SIZE 32	/* Must be a power of 2.  */
 #define MUX_BUFFER_MASK (MUX_BUFFER_SIZE - 1)
-struct MuxDriver {
-    CharDriverState parent;
+struct MuxChardev {
+    Chardev parent;
     CharBackend *backends[MAX_MUX];
     CharBackend chr;
     int focus;
@@ -563,15 +564,15 @@ struct MuxDriver {
     int cons[MAX_MUX];
     int timestamps;
=20
-    /* Protected by the CharDriverState chr_write_lock.  */
+    /* Protected by the Chardev chr_write_lock.  */
     int linestart;
     int64_t timestamps_start;
 };
=20
 /* Called with chr_write_lock held.  */
-static int mux_chr_write(CharDriverState *chr, const uint8_t *buf, int l=
en)
+static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    MuxDriver *d =3D (MuxDriver *)chr;
+    MuxChardev *d =3D (MuxChardev *)chr;
     int ret;
     if (!d->timestamps) {
         ret =3D qemu_chr_fe_write(&d->chr, buf, len);
@@ -623,7 +624,7 @@ static const char * const mux_help[] =3D {
 };
=20
 int term_escape_char =3D 0x01; /* ctrl-a is used for escape */
-static void mux_print_help(CharDriverState *chr)
+static void mux_print_help(Chardev *chr)
 {
     int i, j;
     char ebuf[15] =3D "Escape-Char";
@@ -650,7 +651,7 @@ static void mux_print_help(CharDriverState *chr)
     }
 }
=20
-static void mux_chr_send_event(MuxDriver *d, int mux_nr, int event)
+static void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
 {
     CharBackend *be =3D d->backends[mux_nr];
=20
@@ -659,7 +660,7 @@ static void mux_chr_send_event(MuxDriver *d, int mux_=
nr, int event)
     }
 }
=20
-static int mux_proc_byte(CharDriverState *chr, MuxDriver *d, int ch)
+static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
 {
     if (d->term_got_escape) {
         d->term_got_escape =3D 0;
@@ -703,9 +704,9 @@ static int mux_proc_byte(CharDriverState *chr, MuxDri=
ver *d, int ch)
     return 0;
 }
=20
-static void mux_chr_accept_input(CharDriverState *chr)
+static void mux_chr_accept_input(Chardev *chr)
 {
-    MuxDriver *d =3D (MuxDriver *)chr;
+    MuxChardev *d =3D (MuxChardev *)chr;
     int m =3D d->focus;
     CharBackend *be =3D d->backends[m];
=20
@@ -718,7 +719,7 @@ static void mux_chr_accept_input(CharDriverState *chr=
)
=20
 static int mux_chr_can_read(void *opaque)
 {
-    MuxDriver *d =3D opaque;
+    MuxChardev *d =3D opaque;
     int m =3D d->focus;
     CharBackend *be =3D d->backends[m];
=20
@@ -735,8 +736,8 @@ static int mux_chr_can_read(void *opaque)
=20
 static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
 {
-    CharDriverState *chr =3D opaque;
-    MuxDriver *d =3D opaque;
+    Chardev *chr =3D opaque;
+    MuxChardev *d =3D opaque;
     int m =3D d->focus;
     CharBackend *be =3D d->backends[m];
     int i;
@@ -758,7 +759,7 @@ static bool muxes_realized;
=20
 static void mux_chr_event(void *opaque, int event)
 {
-    MuxDriver *d =3D opaque;
+    MuxChardev *d =3D opaque;
     int i;
=20
     if (!muxes_realized) {
@@ -784,11 +785,11 @@ static void mux_chr_event(void *opaque, int event)
  */
 static void muxes_realize_done(Notifier *notifier, void *unused)
 {
-    CharDriverState *chr;
+    Chardev *chr;
=20
     QTAILQ_FOREACH(chr, &chardevs, next) {
         if (qemu_chr_get_kind(chr) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
-            MuxDriver *d =3D (MuxDriver *)chr;
+            MuxChardev *d =3D (MuxChardev *)chr;
             int i;
=20
             /* send OPENED to all already-attached FEs */
@@ -808,10 +809,10 @@ static Notifier muxes_realize_notify =3D {
     .notify =3D muxes_realize_done,
 };
=20
-static GSource *mux_chr_add_watch(CharDriverState *s, GIOCondition cond)
+static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 {
-    MuxDriver *d =3D (MuxDriver *)s;
-    CharDriverState *chr =3D qemu_chr_fe_get_driver(&d->chr);
+    MuxChardev *d =3D (MuxChardev *)s;
+    Chardev *chr =3D qemu_chr_fe_get_driver(&d->chr);
=20
     if (!chr->driver->chr_add_watch) {
         return NULL;
@@ -820,9 +821,9 @@ static GSource *mux_chr_add_watch(CharDriverState *s,=
 GIOCondition cond)
     return chr->driver->chr_add_watch(chr, cond);
 }
=20
-static void mux_chr_free(struct CharDriverState *chr)
+static void mux_chr_free(struct Chardev *chr)
 {
-    MuxDriver *d =3D (MuxDriver *)chr;
+    MuxChardev *d =3D (MuxChardev *)chr;
     int i;
=20
     for (i =3D 0; i < d->mux_cnt; i++) {
@@ -834,9 +835,9 @@ static void mux_chr_free(struct CharDriverState *chr)
     qemu_chr_fe_deinit(&d->chr);
 }
=20
-static void mux_chr_set_handlers(CharDriverState *chr, GMainContext *con=
text)
+static void mux_chr_set_handlers(Chardev *chr, GMainContext *context)
 {
-    MuxDriver *d =3D (MuxDriver *)chr;
+    MuxChardev *d =3D (MuxChardev *)chr;
=20
     /* Fix up the real driver with mux routines */
     qemu_chr_fe_set_handlers(&d->chr,
@@ -847,7 +848,7 @@ static void mux_chr_set_handlers(CharDriverState *chr=
, GMainContext *context)
                              context, true);
 }
=20
-static void mux_set_focus(MuxDriver *d, int focus)
+static void mux_set_focus(MuxChardev *d, int focus)
 {
     assert(focus >=3D 0);
     assert(focus < d->mux_cnt);
@@ -860,16 +861,16 @@ static void mux_set_focus(MuxDriver *d, int focus)
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
=20
-static CharDriverState *qemu_chr_open_mux(const CharDriver *driver,
-                                          const char *id,
-                                          ChardevBackend *backend,
-                                          ChardevReturn *ret,
-                                          bool *be_opened,
-                                          Error **errp)
+static Chardev *qemu_chr_open_mux(const CharDriver *driver,
+                                  const char *id,
+                                  ChardevBackend *backend,
+                                  ChardevReturn *ret,
+                                  bool *be_opened,
+                                  Error **errp)
 {
     ChardevMux *mux =3D backend->u.mux.data;
-    CharDriverState *chr, *drv;
-    MuxDriver *d;
+    Chardev *chr, *drv;
+    MuxChardev *d;
     ChardevCommon *common =3D qapi_ChardevMux_base(mux);
=20
     drv =3D qemu_chr_find(mux->chardev);
@@ -882,7 +883,7 @@ static CharDriverState *qemu_chr_open_mux(const CharD=
river *driver,
     if (!chr) {
         return NULL;
     }
-    d =3D (MuxDriver *)chr;
+    d =3D (MuxChardev *)chr;
     d->focus =3D -1;
     /* only default to opened state if we've realized the initial
      * set of muxes
@@ -896,17 +897,17 @@ static CharDriverState *qemu_chr_open_mux(const Cha=
rDriver *driver,
     return chr;
 }
=20
-CharDriverState *qemu_chr_fe_get_driver(CharBackend *be)
+Chardev *qemu_chr_fe_get_driver(CharBackend *be)
 {
     return be->chr;
 }
=20
-bool qemu_chr_fe_init(CharBackend *b, CharDriverState *s, Error **errp)
+bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
 {
     int tag =3D 0;
=20
     if (qemu_chr_get_kind(s) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
-        MuxDriver *d =3D (MuxDriver *)s;
+        MuxChardev *d =3D (MuxChardev *)s;
=20
         if (d->mux_cnt >=3D MAX_MUX) {
             goto unavailable;
@@ -930,10 +931,10 @@ unavailable:
     return false;
 }
=20
-static bool qemu_chr_is_busy(CharDriverState *s)
+static bool qemu_chr_is_busy(Chardev *s)
 {
     if (qemu_chr_get_kind(s) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
-        MuxDriver *d =3D (MuxDriver *)s;
+        MuxChardev *d =3D (MuxChardev *)s;
         return d->mux_cnt >=3D 0;
     } else {
         return s->be !=3D NULL;
@@ -948,7 +949,7 @@ void qemu_chr_fe_deinit(CharBackend *b)
         qemu_chr_fe_set_handlers(b, NULL, NULL, NULL, NULL, NULL, true);
         b->chr->be =3D NULL;
         if (qemu_chr_get_kind(b->chr) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
-            MuxDriver *d =3D (MuxDriver *)b->chr;
+            MuxChardev *d =3D (MuxChardev *)b->chr;
             d->backends[b->tag] =3D NULL;
         }
         b->chr =3D NULL;
@@ -963,7 +964,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
                               GMainContext *context,
                               bool set_open)
 {
-    CharDriverState *s;
+    Chardev *s;
     int fe_open;
=20
     s =3D b->chr;
@@ -1010,7 +1011,7 @@ void qemu_chr_fe_take_focus(CharBackend *b)
     }
=20
     if (qemu_chr_get_kind(b->chr) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
-        mux_set_focus((MuxDriver *)b->chr, b->tag);
+        mux_set_focus((MuxChardev *)b->chr, b->tag);
     }
 }
=20
@@ -1090,7 +1091,7 @@ static GSourceFuncs io_watch_poll_funcs =3D {
 };
=20
 /* Can only be used for read */
-static guint io_add_watch_poll(CharDriverState *chr,
+static guint io_add_watch_poll(Chardev *chr,
                                QIOChannel *ioc,
                                IOCanReadHandler *fd_can_read,
                                QIOChannelFunc fd_read,
@@ -1138,7 +1139,7 @@ static void io_remove_watch_poll(guint tag)
     g_source_destroy(&iwp->parent);
 }
=20
-static void remove_fd_in_watch(CharDriverState *chr)
+static void remove_fd_in_watch(Chardev *chr)
 {
     if (chr->fd_in_tag) {
         io_remove_watch_poll(chr->fd_in_tag);
@@ -1187,25 +1188,25 @@ static int io_channel_send(QIOChannel *ioc, const=
 void *buf, size_t len)
 }
=20
=20
-typedef struct FDCharDriver {
-    CharDriverState parent;
-    CharDriverState *chr;
+typedef struct FDChardev {
+    Chardev parent;
+    Chardev *chr;
     QIOChannel *ioc_in, *ioc_out;
     int max_size;
-} FDCharDriver;
+} FDChardev;
=20
 /* Called with chr_write_lock held.  */
-static int fd_chr_write(CharDriverState *chr, const uint8_t *buf, int le=
n)
+static int fd_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    FDCharDriver *s =3D (FDCharDriver *)chr;
+    FDChardev *s =3D (FDChardev *)chr;
=20
     return io_channel_send(s->ioc_out, buf, len);
 }
=20
 static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *o=
paque)
 {
-    CharDriverState *chr =3D opaque;
-    FDCharDriver *s =3D opaque;
+    Chardev *chr =3D opaque;
+    FDChardev *s =3D opaque;
     int len;
     uint8_t buf[READ_BUF_LEN];
     ssize_t ret;
@@ -1234,23 +1235,23 @@ static gboolean fd_chr_read(QIOChannel *chan, GIO=
Condition cond, void *opaque)
=20
 static int fd_chr_read_poll(void *opaque)
 {
-    CharDriverState *chr =3D opaque;
-    FDCharDriver *s =3D opaque;
+    Chardev *chr =3D opaque;
+    FDChardev *s =3D opaque;
=20
     s->max_size =3D qemu_chr_be_can_write(chr);
     return s->max_size;
 }
=20
-static GSource *fd_chr_add_watch(CharDriverState *chr, GIOCondition cond=
)
+static GSource *fd_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    FDCharDriver *s =3D (FDCharDriver *)chr;
+    FDChardev *s =3D (FDChardev *)chr;
     return qio_channel_create_watch(s->ioc_out, cond);
 }
=20
-static void fd_chr_update_read_handler(CharDriverState *chr,
+static void fd_chr_update_read_handler(Chardev *chr,
                                        GMainContext *context)
 {
-    FDCharDriver *s =3D (FDCharDriver *)chr;
+    FDChardev *s =3D (FDChardev *)chr;
=20
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -1261,9 +1262,9 @@ static void fd_chr_update_read_handler(CharDriverSt=
ate *chr,
     }
 }
=20
-static void fd_chr_free(struct CharDriverState *chr)
+static void fd_chr_free(struct Chardev *chr)
 {
-    FDCharDriver *s =3D (FDCharDriver *)chr;
+    FDChardev *s =3D (FDChardev *)chr;
=20
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -1277,19 +1278,19 @@ static void fd_chr_free(struct CharDriverState *c=
hr)
 }
=20
 /* open a character device to a unix fd */
-static CharDriverState *qemu_chr_open_fd(const CharDriver *driver,
-                                         int fd_in, int fd_out,
-                                         ChardevCommon *backend, Error *=
*errp)
+static Chardev *qemu_chr_open_fd(const CharDriver *driver,
+                                 int fd_in, int fd_out,
+                                 ChardevCommon *backend, Error **errp)
 {
-    CharDriverState *chr;
-    FDCharDriver *s;
+    Chardev *chr;
+    FDChardev *s;
     char *name;
=20
     chr =3D qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
-    s =3D (FDCharDriver *)chr;
+    s =3D (FDChardev *)chr;
     s->ioc_in =3D QIO_CHANNEL(qio_channel_file_new_fd(fd_in));
     name =3D g_strdup_printf("chardev-file-in-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc_in), name);
@@ -1304,12 +1305,12 @@ static CharDriverState *qemu_chr_open_fd(const Ch=
arDriver *driver,
     return chr;
 }
=20
-static CharDriverState *qemu_chr_open_pipe(const CharDriver *driver,
-                                           const char *id,
-                                           ChardevBackend *backend,
-                                           ChardevReturn *ret,
-                                           bool *be_opened,
-                                           Error **errp)
+static Chardev *qemu_chr_open_pipe(const CharDriver *driver,
+                                   const char *id,
+                                   ChardevBackend *backend,
+                                   ChardevReturn *ret,
+                                   bool *be_opened,
+                                   Error **errp)
 {
     ChardevHostdev *opts =3D backend->u.pipe.data;
     int fd_in, fd_out;
@@ -1346,7 +1347,7 @@ static bool stdio_in_use;
 static bool stdio_allow_signal;
 static bool stdio_echo_state;
=20
-static void qemu_chr_set_echo_stdio(CharDriverState *chr, bool echo);
+static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo);
=20
 static void term_exit(void)
 {
@@ -1360,7 +1361,7 @@ static void term_stdio_handler(int sig)
     qemu_chr_set_echo_stdio(NULL, stdio_echo_state);
 }
=20
-static void qemu_chr_set_echo_stdio(CharDriverState *chr, bool echo)
+static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo)
 {
     struct termios tty;
=20
@@ -1382,21 +1383,21 @@ static void qemu_chr_set_echo_stdio(CharDriverSta=
te *chr, bool echo)
     tcsetattr (0, TCSANOW, &tty);
 }
=20
-static void qemu_chr_free_stdio(struct CharDriverState *chr)
+static void qemu_chr_free_stdio(struct Chardev *chr)
 {
     term_exit();
     fd_chr_free(chr);
 }
=20
-static CharDriverState *qemu_chr_open_stdio(const CharDriver *driver,
-                                            const char *id,
-                                            ChardevBackend *backend,
-                                            ChardevReturn *ret,
-                                            bool *be_opened,
-                                            Error **errp)
+static Chardev *qemu_chr_open_stdio(const CharDriver *driver,
+                                    const char *id,
+                                    ChardevBackend *backend,
+                                    ChardevReturn *ret,
+                                    bool *be_opened,
+                                    Error **errp)
 {
     ChardevStdio *opts =3D backend->u.stdio.data;
-    CharDriverState *chr;
+    Chardev *chr;
     struct sigaction act;
     ChardevCommon *common =3D qapi_ChardevStdio_base(opts);
=20
@@ -1440,23 +1441,23 @@ static CharDriverState *qemu_chr_open_stdio(const=
 CharDriver *driver,
 #define HAVE_CHARDEV_PTY 1
=20
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
     QIOChannel *ioc;
     int read_bytes;
=20
-    /* Protected by the CharDriverState chr_write_lock.  */
+    /* Protected by the Chardev chr_write_lock.  */
     int connected;
     guint timer_tag;
     guint open_tag;
-} PtyCharDriver;
+} PtyChardev;
=20
-static void pty_chr_update_read_handler_locked(CharDriverState *chr);
-static void pty_chr_state(CharDriverState *chr, int connected);
+static void pty_chr_update_read_handler_locked(Chardev *chr);
+static void pty_chr_state(Chardev *chr, int connected);
=20
 static gboolean pty_chr_timer(gpointer opaque)
 {
-    struct CharDriverState *chr =3D opaque;
-    PtyCharDriver *s =3D opaque;
+    struct Chardev *chr =3D opaque;
+    PtyChardev *s =3D opaque;
=20
     qemu_mutex_lock(&chr->chr_write_lock);
     s->timer_tag =3D 0;
@@ -1470,9 +1471,9 @@ static gboolean pty_chr_timer(gpointer opaque)
 }
=20
 /* Called with chr_write_lock held.  */
-static void pty_chr_rearm_timer(CharDriverState *chr, int ms)
+static void pty_chr_rearm_timer(Chardev *chr, int ms)
 {
-    PtyCharDriver *s =3D (PtyCharDriver *)chr;
+    PtyChardev *s =3D (PtyChardev *)chr;
     char *name;
=20
     if (s->timer_tag) {
@@ -1492,9 +1493,9 @@ static void pty_chr_rearm_timer(CharDriverState *ch=
r, int ms)
 }
=20
 /* Called with chr_write_lock held.  */
-static void pty_chr_update_read_handler_locked(CharDriverState *chr)
+static void pty_chr_update_read_handler_locked(Chardev *chr)
 {
-    PtyCharDriver *s =3D (PtyCharDriver *)chr;
+    PtyChardev *s =3D (PtyChardev *)chr;
     GPollFD pfd;
     int rc;
     QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(s->ioc);
@@ -1514,7 +1515,7 @@ static void pty_chr_update_read_handler_locked(Char=
DriverState *chr)
     }
 }
=20
-static void pty_chr_update_read_handler(CharDriverState *chr,
+static void pty_chr_update_read_handler(Chardev *chr,
                                         GMainContext *context)
 {
     qemu_mutex_lock(&chr->chr_write_lock);
@@ -1523,9 +1524,9 @@ static void pty_chr_update_read_handler(CharDriverS=
tate *chr,
 }
=20
 /* Called with chr_write_lock held.  */
-static int pty_chr_write(CharDriverState *chr, const uint8_t *buf, int l=
en)
+static int pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    PtyCharDriver *s =3D (PtyCharDriver *)chr;
+    PtyChardev *s =3D (PtyChardev *)chr;
=20
     if (!s->connected) {
         /* guest sends data, check for (re-)connect */
@@ -1537,9 +1538,9 @@ static int pty_chr_write(CharDriverState *chr, cons=
t uint8_t *buf, int len)
     return io_channel_send(s->ioc, buf, len);
 }
=20
-static GSource *pty_chr_add_watch(CharDriverState *chr, GIOCondition con=
d)
+static GSource *pty_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    PtyCharDriver *s =3D (PtyCharDriver *)chr;
+    PtyChardev *s =3D (PtyChardev *)chr;
     if (!s->connected) {
         return NULL;
     }
@@ -1548,8 +1549,8 @@ static GSource *pty_chr_add_watch(CharDriverState *=
chr, GIOCondition cond)
=20
 static int pty_chr_read_poll(void *opaque)
 {
-    CharDriverState *chr =3D opaque;
-    PtyCharDriver *s =3D opaque;
+    Chardev *chr =3D opaque;
+    PtyChardev *s =3D opaque;
=20
     s->read_bytes =3D qemu_chr_be_can_write(chr);
     return s->read_bytes;
@@ -1557,8 +1558,8 @@ static int pty_chr_read_poll(void *opaque)
=20
 static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
 {
-    CharDriverState *chr =3D opaque;
-    PtyCharDriver *s =3D opaque;
+    Chardev *chr =3D opaque;
+    PtyChardev *s =3D opaque;
     gsize len;
     uint8_t buf[READ_BUF_LEN];
     ssize_t ret;
@@ -1582,8 +1583,8 @@ static gboolean pty_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
=20
 static gboolean qemu_chr_be_generic_open_func(gpointer opaque)
 {
-    CharDriverState *chr =3D opaque;
-    PtyCharDriver *s =3D opaque;
+    Chardev *chr =3D opaque;
+    PtyChardev *s =3D opaque;
=20
     s->open_tag =3D 0;
     qemu_chr_be_generic_open(chr);
@@ -1591,9 +1592,9 @@ static gboolean qemu_chr_be_generic_open_func(gpoin=
ter opaque)
 }
=20
 /* Called with chr_write_lock held.  */
-static void pty_chr_state(CharDriverState *chr, int connected)
+static void pty_chr_state(Chardev *chr, int connected)
 {
-    PtyCharDriver *s =3D (PtyCharDriver *)chr;
+    PtyChardev *s =3D (PtyChardev *)chr;
=20
     if (!connected) {
         if (s->open_tag) {
@@ -1625,9 +1626,9 @@ static void pty_chr_state(CharDriverState *chr, int=
 connected)
     }
 }
=20
-static void pty_chr_free(struct CharDriverState *chr)
+static void pty_chr_free(struct Chardev *chr)
 {
-    PtyCharDriver *s =3D (PtyCharDriver *)chr;
+    PtyChardev *s =3D (PtyChardev *)chr;
=20
     qemu_mutex_lock(&chr->chr_write_lock);
     pty_chr_state(chr, 0);
@@ -1640,15 +1641,15 @@ static void pty_chr_free(struct CharDriverState *=
chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
-static CharDriverState *qemu_chr_open_pty(const CharDriver *driver,
-                                          const char *id,
-                                          ChardevBackend *backend,
-                                          ChardevReturn *ret,
-                                          bool *be_opened,
-                                          Error **errp)
+static Chardev *qemu_chr_open_pty(const CharDriver *driver,
+                                  const char *id,
+                                  ChardevBackend *backend,
+                                  ChardevReturn *ret,
+                                  bool *be_opened,
+                                  Error **errp)
 {
-    CharDriverState *chr;
-    PtyCharDriver *s;
+    Chardev *chr;
+    PtyChardev *s;
     int master_fd, slave_fd;
     char pty_name[PATH_MAX];
     ChardevCommon *common =3D backend->u.pty.data;
@@ -1676,7 +1677,7 @@ static CharDriverState *qemu_chr_open_pty(const Cha=
rDriver *driver,
     fprintf(stderr, "char device redirected to %s (label %s)\n",
             pty_name, id);
=20
-    s =3D (PtyCharDriver *)chr;
+    s =3D (PtyChardev *)chr;
     s->ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
     name =3D g_strdup_printf("chardev-pty-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc), name);
@@ -1688,7 +1689,7 @@ static CharDriverState *qemu_chr_open_pty(const Cha=
rDriver *driver,
 }
=20
 static const CharDriver pty_driver =3D {
-    .instance_size =3D sizeof(PtyCharDriver),
+    .instance_size =3D sizeof(PtyChardev),
     .kind =3D CHARDEV_BACKEND_KIND_PTY, .create =3D qemu_chr_open_pty,
     .chr_write =3D pty_chr_write,
     .chr_update_read_handler =3D pty_chr_update_read_handler,
@@ -1811,9 +1812,9 @@ static void tty_serial_init(int fd, int speed,
     tcsetattr (fd, TCSANOW, &tty);
 }
=20
-static int tty_serial_ioctl(CharDriverState *chr, int cmd, void *arg)
+static int tty_serial_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    FDCharDriver *s =3D (FDCharDriver *)chr;
+    FDChardev *s =3D (FDChardev *)chr;
     QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(s->ioc_in);
=20
     switch(cmd) {
@@ -1881,7 +1882,7 @@ static int tty_serial_ioctl(CharDriverState *chr, i=
nt cmd, void *arg)
     return 0;
 }
=20
-static void qemu_chr_free_tty(CharDriverState *chr)
+static void qemu_chr_free_tty(Chardev *chr)
 {
     fd_chr_free(chr);
 }
@@ -1892,12 +1893,12 @@ static void qemu_chr_free_tty(CharDriverState *ch=
r)
 #define HAVE_CHARDEV_PARPORT 1
=20
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
     int fd;
     int mode;
-} ParallelCharDriver;
+} ParallelChardev;
=20
-static int pp_hw_mode(ParallelCharDriver *s, uint16_t mode)
+static int pp_hw_mode(ParallelChardev *s, uint16_t mode)
 {
     if (s->mode !=3D mode) {
 	int m =3D mode;
@@ -1908,9 +1909,9 @@ static int pp_hw_mode(ParallelCharDriver *s, uint16=
_t mode)
     return 1;
 }
=20
-static int pp_ioctl(CharDriverState *chr, int cmd, void *arg)
+static int pp_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    ParallelCharDriver *drv =3D (ParallelCharDriver *)chr;
+    ParallelChardev *drv =3D (ParallelChardev *)chr;
     int fd =3D drv->fd;
     uint8_t b;
=20
@@ -1989,9 +1990,9 @@ static int pp_ioctl(CharDriverState *chr, int cmd, =
void *arg)
     return 0;
 }
=20
-static void pp_free(CharDriverState *chr)
+static void pp_free(Chardev *chr)
 {
-    ParallelCharDriver *drv =3D (ParallelCharDriver *)chr;
+    ParallelChardev *drv =3D (ParallelChardev *)chr;
     int fd =3D drv->fd;
=20
     pp_hw_mode(drv, IEEE1284_MODE_COMPAT);
@@ -2000,14 +2001,14 @@ static void pp_free(CharDriverState *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
-static CharDriverState *qemu_chr_open_pp_fd(const CharDriver *driver,
-                                            int fd,
-                                            ChardevCommon *backend,
-                                            bool *be_opened,
-                                            Error **errp)
+static Chardev *qemu_chr_open_pp_fd(const CharDriver *driver,
+                                    int fd,
+                                    ChardevCommon *backend,
+                                    bool *be_opened,
+                                    Error **errp)
 {
-    CharDriverState *chr;
-    ParallelCharDriver *drv;
+    Chardev *chr;
+    ParallelChardev *drv;
=20
     if (ioctl(fd, PPCLAIM) < 0) {
         error_setg_errno(errp, errno, "not a parallel port");
@@ -2020,7 +2021,7 @@ static CharDriverState *qemu_chr_open_pp_fd(const C=
harDriver *driver,
         return NULL;
     }
=20
-    drv =3D (ParallelCharDriver *)chr;
+    drv =3D (ParallelChardev *)chr;
     drv->fd =3D fd;
     drv->mode =3D IEEE1284_MODE_COMPAT;
=20
@@ -2033,13 +2034,13 @@ static CharDriverState *qemu_chr_open_pp_fd(const=
 CharDriver *driver,
 #define HAVE_CHARDEV_PARPORT 1
=20
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
     int fd;
-} ParallelCharDriver;
+} ParallelChardev;
=20
-static int pp_ioctl(CharDriverState *chr, int cmd, void *arg)
+static int pp_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    ParallelCharDriver *drv =3D (ParallelCharDriver *)chr;
+    ParallelChardev *drv =3D (ParallelChardev *)chr;
     uint8_t b;
=20
     switch (cmd) {
@@ -2079,20 +2080,20 @@ static int pp_ioctl(CharDriverState *chr, int cmd=
, void *arg)
     return 0;
 }
=20
-static CharDriverState *qemu_chr_open_pp_fd(const CharDriver *driver,
-                                            int fd,
-                                            ChardevCommon *backend,
-                                            bool *be_opened,
-                                            Error **errp)
+static Chardev *qemu_chr_open_pp_fd(const CharDriver *driver,
+                                    int fd,
+                                    ChardevCommon *backend,
+                                    bool *be_opened,
+                                    Error **errp)
 {
-    CharDriverState *chr;
-    ParallelCharDriver *drv;
+    Chardev *chr;
+    ParallelChardev *drv;
=20
     chr =3D qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
-    drv =3D (ParallelCharDriver *)chr;
+    drv =3D (ParallelChardev *)chr;
     drv->fd =3D fd;
     *be_opened =3D false;
     return chr;
@@ -2104,25 +2105,25 @@ static CharDriverState *qemu_chr_open_pp_fd(const=
 CharDriver *driver,
 #define HAVE_CHARDEV_SERIAL 1
=20
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
     int max_size;
     HANDLE hcom, hrecv, hsend;
     OVERLAPPED orecv;
     BOOL fpipe;
     DWORD len;
=20
-    /* Protected by the CharDriverState chr_write_lock.  */
+    /* Protected by the Chardev chr_write_lock.  */
     OVERLAPPED osend;
-} WinCharState;
+} WinChardev;
=20
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
     HANDLE  hStdIn;
     HANDLE  hInputReadyEvent;
     HANDLE  hInputDoneEvent;
     HANDLE  hInputThread;
     uint8_t win_stdio_buf;
-} WinStdioCharState;
+} WinStdioChardev;
=20
 #define NSENDBUF 2048
 #define NRECVBUF 2048
@@ -2132,9 +2133,9 @@ typedef struct {
 static int win_chr_poll(void *opaque);
 static int win_chr_pipe_poll(void *opaque);
=20
-static void win_chr_free(CharDriverState *chr)
+static void win_chr_free(Chardev *chr)
 {
-    WinCharState *s =3D (WinCharState *)chr;
+    WinChardev *s =3D (WinChardev *)chr;
=20
     if (s->hsend) {
         CloseHandle(s->hsend);
@@ -2156,9 +2157,9 @@ static void win_chr_free(CharDriverState *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
-static int win_chr_init(CharDriverState *chr, const char *filename, Erro=
r **errp)
+static int win_chr_init(Chardev *chr, const char *filename, Error **errp=
)
 {
-    WinCharState *s =3D (WinCharState *)chr;
+    WinChardev *s =3D (WinChardev *)chr;
     COMMCONFIG comcfg;
     COMMTIMEOUTS cto =3D { 0, 0, 0, 0, 0};
     COMSTAT comstat;
@@ -2224,9 +2225,9 @@ static int win_chr_init(CharDriverState *chr, const=
 char *filename, Error **errp
 }
=20
 /* Called with chr_write_lock held.  */
-static int win_chr_write(CharDriverState *chr, const uint8_t *buf, int l=
en1)
+static int win_chr_write(Chardev *chr, const uint8_t *buf, int len1)
 {
-    WinCharState *s =3D (WinCharState *)chr;
+    WinChardev *s =3D (WinChardev *)chr;
     DWORD len, ret, size, err;
=20
     len =3D len1;
@@ -2258,17 +2259,17 @@ static int win_chr_write(CharDriverState *chr, co=
nst uint8_t *buf, int len1)
     return len1 - len;
 }
=20
-static int win_chr_read_poll(CharDriverState *chr)
+static int win_chr_read_poll(Chardev *chr)
 {
-    WinCharState *s =3D (WinCharState *)chr;
+    WinChardev *s =3D (WinChardev *)chr;
=20
     s->max_size =3D qemu_chr_be_can_write(chr);
     return s->max_size;
 }
=20
-static void win_chr_readfile(CharDriverState *chr)
+static void win_chr_readfile(Chardev *chr)
 {
-    WinCharState *s =3D (WinCharState *)chr;
+    WinChardev *s =3D (WinChardev *)chr;
     int ret, err;
     uint8_t buf[READ_BUF_LEN];
     DWORD size;
@@ -2288,9 +2289,9 @@ static void win_chr_readfile(CharDriverState *chr)
     }
 }
=20
-static void win_chr_read(CharDriverState *chr)
+static void win_chr_read(Chardev *chr)
 {
-    WinCharState *s =3D (WinCharState *)chr;
+    WinChardev *s =3D (WinChardev *)chr;
=20
     if (s->len > s->max_size)
         s->len =3D s->max_size;
@@ -2302,8 +2303,8 @@ static void win_chr_read(CharDriverState *chr)
=20
 static int win_chr_poll(void *opaque)
 {
-    CharDriverState *chr =3D opaque;
-    WinCharState *s =3D opaque;
+    Chardev *chr =3D opaque;
+    WinChardev *s =3D opaque;
     COMSTAT status;
     DWORD comerr;
=20
@@ -2319,8 +2320,8 @@ static int win_chr_poll(void *opaque)
=20
 static int win_chr_pipe_poll(void *opaque)
 {
-    CharDriverState *chr =3D opaque;
-    WinCharState *s =3D opaque;
+    Chardev *chr =3D opaque;
+    WinChardev *s =3D opaque;
     DWORD size;
=20
     PeekNamedPipe(s->hcom, NULL, 0, NULL, &size, NULL);
@@ -2333,10 +2334,10 @@ static int win_chr_pipe_poll(void *opaque)
     return 0;
 }
=20
-static int win_chr_pipe_init(CharDriverState *chr, const char *filename,
+static int win_chr_pipe_init(Chardev *chr, const char *filename,
                              Error **errp)
 {
-    WinCharState *s =3D (WinCharState *)chr;
+    WinChardev *s =3D (WinChardev *)chr;
     OVERLAPPED ov;
     int ret;
     DWORD size;
@@ -2398,16 +2399,16 @@ static int win_chr_pipe_init(CharDriverState *chr=
, const char *filename,
 }
=20
=20
-static CharDriverState *qemu_chr_open_pipe(const CharDriver *driver,
-                                           const char *id,
-                                           ChardevBackend *backend,
-                                           ChardevReturn *ret,
-                                           bool *be_opened,
-                                           Error **errp)
+static Chardev *qemu_chr_open_pipe(const CharDriver *driver,
+                                   const char *id,
+                                   ChardevBackend *backend,
+                                   ChardevReturn *ret,
+                                   bool *be_opened,
+                                   Error **errp)
 {
     ChardevHostdev *opts =3D backend->u.pipe.data;
     const char *filename =3D opts->device;
-    CharDriverState *chr;
+    Chardev *chr;
     ChardevCommon *common =3D qapi_ChardevHostdev_base(opts);
=20
     chr =3D qemu_chr_alloc(driver, common, errp);
@@ -2422,29 +2423,29 @@ static CharDriverState *qemu_chr_open_pipe(const =
CharDriver *driver,
     return chr;
 }
=20
-static CharDriverState *qemu_chr_open_win_file(const CharDriver *driver,
-                                               HANDLE fd_out,
-                                               ChardevCommon *backend,
-                                               Error **errp)
+static Chardev *qemu_chr_open_win_file(const CharDriver *driver,
+                                       HANDLE fd_out,
+                                       ChardevCommon *backend,
+                                       Error **errp)
 {
-    CharDriverState *chr;
-    WinCharState *s;
+    Chardev *chr;
+    WinChardev *s;
=20
     chr =3D qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
-    s =3D (WinCharState *)chr;
+    s =3D (WinChardev *)chr;
     s->hcom =3D fd_out;
     return chr;
 }
=20
-static CharDriverState *qemu_chr_open_win_con(const CharDriver *driver,
-                                              const char *id,
-                                              ChardevBackend *backend,
-                                              ChardevReturn *ret,
-                                              bool *be_opened,
-                                              Error **errp)
+static Chardev *qemu_chr_open_win_con(const CharDriver *driver,
+                                      const char *id,
+                                      ChardevBackend *backend,
+                                      ChardevReturn *ret,
+                                      bool *be_opened,
+                                      Error **errp)
 {
     ChardevCommon *common =3D backend->u.console.data;
     return qemu_chr_open_win_file(driver,
@@ -2453,12 +2454,12 @@ static CharDriverState *qemu_chr_open_win_con(con=
st CharDriver *driver,
 }
=20
 static const CharDriver console_driver =3D {
-    .instance_size =3D sizeof(WinCharState),
+    .instance_size =3D sizeof(WinChardev),
     .kind =3D CHARDEV_BACKEND_KIND_CONSOLE, .create =3D qemu_chr_open_wi=
n_con,
     .chr_write =3D win_chr_write,
 };
=20
-static int win_stdio_write(CharDriverState *chr, const uint8_t *buf, int=
 len)
+static int win_stdio_write(Chardev *chr, const uint8_t *buf, int len)
 {
     HANDLE  hStdOut =3D GetStdHandle(STD_OUTPUT_HANDLE);
     DWORD   dwSize;
@@ -2479,8 +2480,8 @@ static int win_stdio_write(CharDriverState *chr, co=
nst uint8_t *buf, int len)
=20
 static void win_stdio_wait_func(void *opaque)
 {
-    CharDriverState   *chr   =3D opaque;
-    WinStdioCharState *stdio =3D opaque;
+    Chardev   *chr   =3D opaque;
+    WinStdioChardev *stdio =3D opaque;
     INPUT_RECORD       buf[4];
     int                ret;
     DWORD              dwSize;
@@ -2513,7 +2514,7 @@ static void win_stdio_wait_func(void *opaque)
=20
 static DWORD WINAPI win_stdio_thread(LPVOID param)
 {
-    WinStdioCharState *stdio =3D param;
+    WinStdioChardev *stdio =3D param;
     int                ret;
     DWORD              dwSize;
=20
@@ -2551,8 +2552,8 @@ static DWORD WINAPI win_stdio_thread(LPVOID param)
=20
 static void win_stdio_thread_wait_func(void *opaque)
 {
-    CharDriverState   *chr   =3D opaque;
-    WinStdioCharState *stdio =3D opaque;
+    Chardev   *chr   =3D opaque;
+    WinStdioChardev *stdio =3D opaque;
=20
     if (qemu_chr_be_can_write(chr)) {
         qemu_chr_be_write(chr, &stdio->win_stdio_buf, 1);
@@ -2561,9 +2562,9 @@ static void win_stdio_thread_wait_func(void *opaque=
)
     SetEvent(stdio->hInputDoneEvent);
 }
=20
-static void qemu_chr_set_echo_win_stdio(CharDriverState *chr, bool echo)
+static void qemu_chr_set_echo_win_stdio(Chardev *chr, bool echo)
 {
-    WinStdioCharState *stdio  =3D (WinStdioCharState *)chr;
+    WinStdioChardev *stdio  =3D (WinStdioChardev *)chr;
     DWORD              dwMode =3D 0;
=20
     GetConsoleMode(stdio->hStdIn, &dwMode);
@@ -2575,9 +2576,9 @@ static void qemu_chr_set_echo_win_stdio(CharDriverS=
tate *chr, bool echo)
     }
 }
=20
-static void win_stdio_free(CharDriverState *chr)
+static void win_stdio_free(Chardev *chr)
 {
-    WinStdioCharState *stdio =3D (WinStdioCharState *)chr;
+    WinStdioChardev *stdio =3D (WinStdioChardev *)chr;
=20
     if (stdio->hInputReadyEvent !=3D INVALID_HANDLE_VALUE) {
         CloseHandle(stdio->hInputReadyEvent);
@@ -2590,15 +2591,15 @@ static void win_stdio_free(CharDriverState *chr)
     }
 }
=20
-static CharDriverState *qemu_chr_open_stdio(const CharDriver *driver,
-                                            const char *id,
-                                            ChardevBackend *backend,
-                                            ChardevReturn *ret,
-                                            bool *be_opened,
-                                            Error **errp)
+static Chardev *qemu_chr_open_stdio(const CharDriver *driver,
+                                    const char *id,
+                                    ChardevBackend *backend,
+                                    ChardevReturn *ret,
+                                    bool *be_opened,
+                                    Error **errp)
 {
-    CharDriverState   *chr;
-    WinStdioCharState *stdio;
+    Chardev   *chr;
+    WinStdioChardev *stdio;
     DWORD              dwMode;
     int                is_console =3D 0;
     ChardevCommon *common =3D qapi_ChardevStdio_base(backend->u.stdio.da=
ta);
@@ -2607,7 +2608,7 @@ static CharDriverState *qemu_chr_open_stdio(const C=
harDriver *driver,
     if (!chr) {
         return NULL;
     }
-    stdio =3D (WinStdioCharState *)chr;
+    stdio =3D (WinStdioChardev *)chr;
=20
     stdio->hStdIn =3D GetStdHandle(STD_INPUT_HANDLE);
     if (stdio->hStdIn =3D=3D INVALID_HANDLE_VALUE) {
@@ -2676,18 +2677,18 @@ err1:
 /* UDP Net console */
=20
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
     QIOChannel *ioc;
     uint8_t buf[READ_BUF_LEN];
     int bufcnt;
     int bufptr;
     int max_size;
-} NetCharDriver;
+} NetChardev;
=20
 /* Called with chr_write_lock held.  */
-static int udp_chr_write(CharDriverState *chr, const uint8_t *buf, int l=
en)
+static int udp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    NetCharDriver *s =3D (NetCharDriver *)chr;
+    NetChardev *s =3D (NetChardev *)chr;
=20
     return qio_channel_write(
         s->ioc, (const char *)buf, len, NULL);
@@ -2695,8 +2696,8 @@ static int udp_chr_write(CharDriverState *chr, cons=
t uint8_t *buf, int len)
=20
 static int udp_chr_read_poll(void *opaque)
 {
-    CharDriverState *chr =3D opaque;
-    NetCharDriver *s =3D opaque;
+    Chardev *chr =3D opaque;
+    NetChardev *s =3D opaque;
=20
     s->max_size =3D qemu_chr_be_can_write(chr);
=20
@@ -2713,8 +2714,8 @@ static int udp_chr_read_poll(void *opaque)
=20
 static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
 {
-    CharDriverState *chr =3D opaque;
-    NetCharDriver *s =3D opaque;
+    Chardev *chr =3D opaque;
+    NetChardev *s =3D opaque;
     ssize_t ret;
=20
     if (s->max_size =3D=3D 0) {
@@ -2738,10 +2739,10 @@ static gboolean udp_chr_read(QIOChannel *chan, GI=
OCondition cond, void *opaque)
     return TRUE;
 }
=20
-static void udp_chr_update_read_handler(CharDriverState *chr,
+static void udp_chr_update_read_handler(Chardev *chr,
                                         GMainContext *context)
 {
-    NetCharDriver *s =3D (NetCharDriver *)chr;
+    NetChardev *s =3D (NetChardev *)chr;
=20
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -2752,9 +2753,9 @@ static void udp_chr_update_read_handler(CharDriverS=
tate *chr,
     }
 }
=20
-static void udp_chr_free(CharDriverState *chr)
+static void udp_chr_free(Chardev *chr)
 {
-    NetCharDriver *s =3D (NetCharDriver *)chr;
+    NetChardev *s =3D (NetChardev *)chr;
=20
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -2767,7 +2768,7 @@ static void udp_chr_free(CharDriverState *chr)
 /* TCP Net console */
=20
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
     QIOChannel *ioc; /* Client I/O channel */
     QIOChannelSocket *sioc; /* Client master channel */
     QIOChannelSocket *listen_ioc;
@@ -2790,13 +2791,13 @@ typedef struct {
     guint reconnect_timer;
     int64_t reconnect_time;
     bool connect_err_reported;
-} TCPCharDriver;
+} TCPChardev;
=20
 static gboolean socket_reconnect_timeout(gpointer opaque);
=20
-static void qemu_chr_socket_restart_timer(CharDriverState *chr)
+static void qemu_chr_socket_restart_timer(Chardev *chr)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
     char *name;
=20
     assert(s->connected =3D=3D 0);
@@ -2807,10 +2808,10 @@ static void qemu_chr_socket_restart_timer(CharDri=
verState *chr)
     g_free(name);
 }
=20
-static void check_report_connect_error(CharDriverState *chr,
+static void check_report_connect_error(Chardev *chr,
                                        Error *err)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
=20
     if (!s->connect_err_reported) {
         error_report("Unable to connect character device %s: %s",
@@ -2825,9 +2826,9 @@ static gboolean tcp_chr_accept(QIOChannel *chan,
                                void *opaque);
=20
 /* Called with chr_write_lock held.  */
-static int tcp_chr_write(CharDriverState *chr, const uint8_t *buf, int l=
en)
+static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
=20
     if (s->connected) {
         int ret =3D  io_channel_send_full(s->ioc, buf, len,
@@ -2850,8 +2851,8 @@ static int tcp_chr_write(CharDriverState *chr, cons=
t uint8_t *buf, int len)
=20
 static int tcp_chr_read_poll(void *opaque)
 {
-    CharDriverState *chr =3D opaque;
-    TCPCharDriver *s =3D opaque;
+    Chardev *chr =3D opaque;
+    TCPChardev *s =3D opaque;
     if (!s->connected)
         return 0;
     s->max_size =3D qemu_chr_be_can_write(chr);
@@ -2860,8 +2861,8 @@ static int tcp_chr_read_poll(void *opaque)
=20
 #define IAC 255
 #define IAC_BREAK 243
-static void tcp_chr_process_IAC_bytes(CharDriverState *chr,
-                                      TCPCharDriver *s,
+static void tcp_chr_process_IAC_bytes(Chardev *chr,
+                                      TCPChardev *s,
                                       uint8_t *buf, int *size)
 {
     /* Handle any telnet client's basic IAC options to satisfy char by
@@ -2908,9 +2909,9 @@ static void tcp_chr_process_IAC_bytes(CharDriverSta=
te *chr,
     *size =3D j;
 }
=20
-static int tcp_get_msgfds(CharDriverState *chr, int *fds, int num)
+static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
=20
     int to_copy =3D (s->read_msgfds_num < num) ? s->read_msgfds_num : nu=
m;
=20
@@ -2934,9 +2935,9 @@ static int tcp_get_msgfds(CharDriverState *chr, int=
 *fds, int num)
     return to_copy;
 }
=20
-static int tcp_set_msgfds(CharDriverState *chr, int *fds, int num)
+static int tcp_set_msgfds(Chardev *chr, int *fds, int num)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
=20
     /* clear old pending fd array */
     g_free(s->write_msgfds);
@@ -2959,9 +2960,9 @@ static int tcp_set_msgfds(CharDriverState *chr, int=
 *fds, int num)
     return 0;
 }
=20
-static ssize_t tcp_chr_recv(CharDriverState *chr, char *buf, size_t len)
+static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
     struct iovec iov =3D { .iov_base =3D buf, .iov_len =3D len };
     int ret;
     size_t i;
@@ -3016,15 +3017,15 @@ static ssize_t tcp_chr_recv(CharDriverState *chr,=
 char *buf, size_t len)
     return ret;
 }
=20
-static GSource *tcp_chr_add_watch(CharDriverState *chr, GIOCondition con=
d)
+static GSource *tcp_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
     return qio_channel_create_watch(s->ioc, cond);
 }
=20
-static void tcp_chr_free_connection(CharDriverState *chr)
+static void tcp_chr_free_connection(Chardev *chr)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
     int i;
=20
     if (!s->connected) {
@@ -3051,9 +3052,9 @@ static void tcp_chr_free_connection(CharDriverState=
 *chr)
     s->connected =3D 0;
 }
=20
-static void tcp_chr_disconnect(CharDriverState *chr)
+static void tcp_chr_disconnect(Chardev *chr)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
=20
     if (!s->connected) {
         return;
@@ -3075,8 +3076,8 @@ static void tcp_chr_disconnect(CharDriverState *chr=
)
=20
 static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
 {
-    CharDriverState *chr =3D opaque;
-    TCPCharDriver *s =3D opaque;
+    Chardev *chr =3D opaque;
+    TCPChardev *s =3D opaque;
     uint8_t buf[READ_BUF_LEN];
     int len, size;
=20
@@ -3100,9 +3101,9 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
     return TRUE;
 }
=20
-static int tcp_chr_sync_read(CharDriverState *chr, const uint8_t *buf, i=
nt len)
+static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
     int size;
=20
     if (!s->connected) {
@@ -3120,8 +3121,8 @@ static int tcp_chr_sync_read(CharDriverState *chr, =
const uint8_t *buf, int len)
=20
 static void tcp_chr_connect(void *opaque)
 {
-    CharDriverState *chr =3D opaque;
-    TCPCharDriver *s =3D opaque;
+    Chardev *chr =3D opaque;
+    TCPChardev *s =3D opaque;
=20
     g_free(chr->filename);
     chr->filename =3D sockaddr_to_str(
@@ -3139,10 +3140,10 @@ static void tcp_chr_connect(void *opaque)
     qemu_chr_be_generic_open(chr);
 }
=20
-static void tcp_chr_update_read_handler(CharDriverState *chr,
+static void tcp_chr_update_read_handler(Chardev *chr,
                                         GMainContext *context)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
=20
     if (!s->connected) {
         return;
@@ -3158,7 +3159,7 @@ static void tcp_chr_update_read_handler(CharDriverS=
tate *chr,
 }
=20
 typedef struct {
-    CharDriverState *chr;
+    Chardev *chr;
     char buf[12];
     size_t buflen;
 } TCPCharDriverTelnetInit;
@@ -3191,9 +3192,9 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *=
ioc,
     return TRUE;
 }
=20
-static void tcp_chr_telnet_init(CharDriverState *chr)
+static void tcp_chr_telnet_init(Chardev *chr)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
     TCPCharDriverTelnetInit *init =3D
         g_new0(TCPCharDriverTelnetInit, 1);
     size_t n =3D 0;
@@ -3228,8 +3229,8 @@ static void tcp_chr_tls_handshake(Object *source,
                                   Error *err,
                                   gpointer user_data)
 {
-    CharDriverState *chr =3D user_data;
-    TCPCharDriver *s =3D user_data;
+    Chardev *chr =3D user_data;
+    TCPChardev *s =3D user_data;
=20
     if (err) {
         tcp_chr_disconnect(chr);
@@ -3243,9 +3244,9 @@ static void tcp_chr_tls_handshake(Object *source,
 }
=20
=20
-static void tcp_chr_tls_init(CharDriverState *chr)
+static void tcp_chr_tls_init(Chardev *chr)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
     QIOChannelTLS *tioc;
     Error *err =3D NULL;
     gchar *name;
@@ -3281,10 +3282,10 @@ static void tcp_chr_tls_init(CharDriverState *chr=
)
 }
=20
=20
-static void tcp_chr_set_client_ioc_name(CharDriverState *chr,
+static void tcp_chr_set_client_ioc_name(Chardev *chr,
                                         QIOChannelSocket *sioc)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
     char *name;
     name =3D g_strdup_printf("chardev-tcp-%s-%s",
                            s->is_listen ? "server" : "client",
@@ -3294,9 +3295,9 @@ static void tcp_chr_set_client_ioc_name(CharDriverS=
tate *chr,
=20
 }
=20
-static int tcp_chr_new_client(CharDriverState *chr, QIOChannelSocket *si=
oc)
+static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
=20
     if (s->ioc !=3D NULL) {
 	return -1;
@@ -3331,7 +3332,7 @@ static int tcp_chr_new_client(CharDriverState *chr,=
 QIOChannelSocket *sioc)
 }
=20
=20
-static int tcp_chr_add_client(CharDriverState *chr, int fd)
+static int tcp_chr_add_client(Chardev *chr, int fd)
 {
     int ret;
     QIOChannelSocket *sioc;
@@ -3350,7 +3351,7 @@ static gboolean tcp_chr_accept(QIOChannel *channel,
                                GIOCondition cond,
                                void *opaque)
 {
-    CharDriverState *chr =3D opaque;
+    Chardev *chr =3D opaque;
     QIOChannelSocket *sioc;
=20
     sioc =3D qio_channel_socket_accept(QIO_CHANNEL_SOCKET(channel),
@@ -3366,9 +3367,9 @@ static gboolean tcp_chr_accept(QIOChannel *channel,
     return TRUE;
 }
=20
-static int tcp_chr_wait_connected(CharDriverState *chr, Error **errp)
+static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
     QIOChannelSocket *sioc;
=20
     /* It can't wait on s->connected, since it is set asynchronously
@@ -3395,7 +3396,7 @@ static int tcp_chr_wait_connected(CharDriverState *=
chr, Error **errp)
     return 0;
 }
=20
-static int qemu_chr_wait_connected(CharDriverState *chr, Error **errp)
+static int qemu_chr_wait_connected(Chardev *chr, Error **errp)
 {
     if (chr->driver->chr_wait_connected) {
         return chr->driver->chr_wait_connected(chr, errp);
@@ -3414,9 +3415,9 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Err=
or **errp)
     return qemu_chr_wait_connected(be->chr, errp);
 }
=20
-static void tcp_chr_free(CharDriverState *chr)
+static void tcp_chr_free(Chardev *chr)
 {
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    TCPChardev *s =3D (TCPChardev *)chr;
=20
     tcp_chr_free_connection(chr);
=20
@@ -3443,8 +3444,8 @@ static void tcp_chr_free(CharDriverState *chr)
 static void qemu_chr_socket_connected(Object *src, Error *err, void *opa=
que)
 {
     QIOChannelSocket *sioc =3D QIO_CHANNEL_SOCKET(src);
-    CharDriverState *chr =3D opaque;
-    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+    Chardev *chr =3D opaque;
+    TCPChardev *s =3D (TCPChardev *)chr;
=20
     if (err) {
         check_report_connect_error(chr, err);
@@ -3462,24 +3463,24 @@ static void qemu_chr_socket_connected(Object *src=
, Error *err, void *opaque)
 /* Ring buffer chardev */
=20
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
     size_t size;
     size_t prod;
     size_t cons;
     uint8_t *cbuf;
-} RingBufCharDriver;
+} RingBufChardev;
=20
-static size_t ringbuf_count(const CharDriverState *chr)
+static size_t ringbuf_count(const Chardev *chr)
 {
-    const RingBufCharDriver *d =3D (RingBufCharDriver *)chr;
+    const RingBufChardev *d =3D (RingBufChardev *)chr;
=20
     return d->prod - d->cons;
 }
=20
 /* Called with chr_write_lock held.  */
-static int ringbuf_chr_write(CharDriverState *chr, const uint8_t *buf, i=
nt len)
+static int ringbuf_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    RingBufCharDriver *d =3D (RingBufCharDriver *)chr;
+    RingBufChardev *d =3D (RingBufChardev *)chr;
     int i;
=20
     if (!buf || (len < 0)) {
@@ -3496,9 +3497,9 @@ static int ringbuf_chr_write(CharDriverState *chr, =
const uint8_t *buf, int len)
     return len;
 }
=20
-static int ringbuf_chr_read(CharDriverState *chr, uint8_t *buf, int len)
+static int ringbuf_chr_read(Chardev *chr, uint8_t *buf, int len)
 {
-    RingBufCharDriver *d =3D (RingBufCharDriver *)chr;
+    RingBufChardev *d =3D (RingBufChardev *)chr;
     int i;
=20
     qemu_mutex_lock(&chr->chr_write_lock);
@@ -3510,30 +3511,30 @@ static int ringbuf_chr_read(CharDriverState *chr,=
 uint8_t *buf, int len)
     return i;
 }
=20
-static void ringbuf_chr_free(struct CharDriverState *chr)
+static void ringbuf_chr_free(struct Chardev *chr)
 {
-    RingBufCharDriver *d =3D (RingBufCharDriver *)chr;
+    RingBufChardev *d =3D (RingBufChardev *)chr;
=20
     g_free(d->cbuf);
 }
=20
-static CharDriverState *qemu_chr_open_ringbuf(const CharDriver *driver,
-                                              const char *id,
-                                              ChardevBackend *backend,
-                                              ChardevReturn *ret,
-                                              bool *be_opened,
-                                              Error **errp)
+static Chardev *qemu_chr_open_ringbuf(const CharDriver *driver,
+                                      const char *id,
+                                      ChardevBackend *backend,
+                                      ChardevReturn *ret,
+                                      bool *be_opened,
+                                      Error **errp)
 {
     ChardevRingbuf *opts =3D backend->u.ringbuf.data;
     ChardevCommon *common =3D qapi_ChardevRingbuf_base(opts);
-    CharDriverState *chr;
-    RingBufCharDriver *d;
+    Chardev *chr;
+    RingBufChardev *d;
=20
     chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
-    d =3D (RingBufCharDriver *)chr;
+    d =3D (RingBufChardev *)chr;
=20
     d->size =3D opts->has_size ? opts->size : 65536;
=20
@@ -3554,7 +3555,7 @@ fail:
     return NULL;
 }
=20
-ChardevBackendKind qemu_chr_get_kind(const CharDriverState *chr)
+ChardevBackendKind qemu_chr_get_kind(const Chardev *chr)
 {
     return chr->driver->kind;
 }
@@ -3563,7 +3564,7 @@ void qmp_ringbuf_write(const char *device, const ch=
ar *data,
                        bool has_format, enum DataFormat format,
                        Error **errp)
 {
-    CharDriverState *chr;
+    Chardev *chr;
     const uint8_t *write_data;
     int ret;
     gsize write_count;
@@ -3607,7 +3608,7 @@ char *qmp_ringbuf_read(const char *device, int64_t =
size,
                        bool has_format, enum DataFormat format,
                        Error **errp)
 {
-    CharDriverState *chr;
+    Chardev *chr;
     uint8_t *read_data;
     size_t count;
     char *data;
@@ -3839,12 +3840,12 @@ static const CharDriver stdio_driver =3D {
     .kind =3D CHARDEV_BACKEND_KIND_STDIO,
     .parse =3D qemu_chr_parse_stdio, .create =3D qemu_chr_open_stdio,
 #ifdef _WIN32
-    sizeof(WinStdioCharState),
+    sizeof(WinStdioChardev),
     .chr_write =3D win_stdio_write,
     .chr_set_echo =3D qemu_chr_set_echo_win_stdio,
     .chr_free =3D win_stdio_free,
 #else
-    sizeof(FDCharDriver),
+    sizeof(FDChardev),
     .chr_add_watch =3D fd_chr_add_watch,
     .chr_write =3D fd_chr_write,
     .chr_update_read_handler =3D fd_chr_update_read_handler,
@@ -3906,11 +3907,11 @@ static const CharDriver pipe_driver =3D {
     .kind =3D CHARDEV_BACKEND_KIND_PIPE,
     .parse =3D qemu_chr_parse_pipe, .create =3D qemu_chr_open_pipe,
 #ifdef _WIN32
-    sizeof(WinCharState),
+    sizeof(WinChardev),
     .chr_write =3D win_chr_write,
     .chr_free =3D win_chr_free,
 #else
-    sizeof(FDCharDriver),
+    sizeof(FDChardev),
     .chr_add_watch =3D fd_chr_add_watch,
     .chr_write =3D fd_chr_write,
     .chr_update_read_handler =3D fd_chr_update_read_handler,
@@ -3935,7 +3936,7 @@ static void qemu_chr_parse_ringbuf(QemuOpts *opts, =
ChardevBackend *backend,
 }
=20
 static const CharDriver ringbuf_driver =3D {
-    .instance_size =3D sizeof(RingBufCharDriver),
+    .instance_size =3D sizeof(RingBufChardev),
     .kind =3D CHARDEV_BACKEND_KIND_RINGBUF,
     .parse =3D qemu_chr_parse_ringbuf, .create =3D qemu_chr_open_ringbuf=
,
     .chr_write =3D ringbuf_chr_write,
@@ -3944,7 +3945,7 @@ static const CharDriver ringbuf_driver =3D {
=20
 /* Bug-compatibility: */
 static const CharDriver memory_driver =3D {
-    .instance_size =3D sizeof(RingBufCharDriver),
+    .instance_size =3D sizeof(RingBufChardev),
     .kind =3D CHARDEV_BACKEND_KIND_MEMORY,
     .parse =3D qemu_chr_parse_ringbuf, .create =3D qemu_chr_open_ringbuf=
,
     .chr_write =3D ringbuf_chr_write,
@@ -3967,7 +3968,7 @@ static void qemu_chr_parse_mux(QemuOpts *opts, Char=
devBackend *backend,
 }
=20
 static const CharDriver mux_driver =3D {
-    .instance_size =3D sizeof(MuxDriver),
+    .instance_size =3D sizeof(MuxChardev),
     .kind =3D CHARDEV_BACKEND_KIND_MUX,
     .parse =3D qemu_chr_parse_mux, .create =3D qemu_chr_open_mux,
     .chr_free =3D mux_chr_free,
@@ -4110,12 +4111,12 @@ void register_char_driver(const CharDriver *drive=
r)
     backends[driver->kind] =3D driver;
 }
=20
-CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
-                                        Error **errp)
+Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
+                                Error **errp)
 {
     Error *local_err =3D NULL;
     const CharDriver *cd;
-    CharDriverState *chr;
+    Chardev *chr;
     int i;
     ChardevReturn *ret =3D NULL;
     ChardevBackend *backend;
@@ -4219,10 +4220,10 @@ err:
     return NULL;
 }
=20
-CharDriverState *qemu_chr_new_noreplay(const char *label, const char *fi=
lename)
+Chardev *qemu_chr_new_noreplay(const char *label, const char *filename)
 {
     const char *p;
-    CharDriverState *chr;
+    Chardev *chr;
     QemuOpts *opts;
     Error *err =3D NULL;
=20
@@ -4245,9 +4246,9 @@ CharDriverState *qemu_chr_new_noreplay(const char *=
label, const char *filename)
     return chr;
 }
=20
-CharDriverState *qemu_chr_new(const char *label, const char *filename)
+Chardev *qemu_chr_new(const char *label, const char *filename)
 {
-    CharDriverState *chr;
+    Chardev *chr;
     chr =3D qemu_chr_new_noreplay(label, filename);
     if (chr) {
         if (replay_mode !=3D REPLAY_MODE_NONE) {
@@ -4264,7 +4265,7 @@ CharDriverState *qemu_chr_new(const char *label, co=
nst char *filename)
=20
 void qemu_chr_fe_set_echo(CharBackend *be, bool echo)
 {
-    CharDriverState *chr =3D be->chr;
+    Chardev *chr =3D be->chr;
=20
     if (chr && chr->driver->chr_set_echo) {
         chr->driver->chr_set_echo(chr, echo);
@@ -4273,7 +4274,7 @@ void qemu_chr_fe_set_echo(CharBackend *be, bool ech=
o)
=20
 void qemu_chr_fe_set_open(CharBackend *be, int fe_open)
 {
-    CharDriverState *chr =3D be->chr;
+    Chardev *chr =3D be->chr;
=20
     if (!chr) {
         return;
@@ -4291,7 +4292,7 @@ void qemu_chr_fe_set_open(CharBackend *be, int fe_o=
pen)
 guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
                             GIOFunc func, void *user_data)
 {
-    CharDriverState *s =3D be->chr;
+    Chardev *s =3D be->chr;
     GSource *src;
     guint tag;
=20
@@ -4313,14 +4314,14 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOC=
ondition cond,
=20
 void qemu_chr_fe_disconnect(CharBackend *be)
 {
-    CharDriverState *chr =3D be->chr;
+    Chardev *chr =3D be->chr;
=20
     if (chr && chr->driver->chr_disconnect) {
         chr->driver->chr_disconnect(chr);
     }
 }
=20
-static void qemu_chr_free_common(CharDriverState *chr)
+static void qemu_chr_free_common(Chardev *chr)
 {
     if (chr->be) {
         chr->be->chr =3D NULL;
@@ -4334,7 +4335,7 @@ static void qemu_chr_free_common(CharDriverState *c=
hr)
     g_free(chr);
 }
=20
-void qemu_chr_free(CharDriverState *chr)
+void qemu_chr_free(Chardev *chr)
 {
     if (chr->driver->chr_free) {
         chr->driver->chr_free(chr);
@@ -4342,7 +4343,7 @@ void qemu_chr_free(CharDriverState *chr)
     qemu_chr_free_common(chr);
 }
=20
-void qemu_chr_delete(CharDriverState *chr)
+void qemu_chr_delete(Chardev *chr)
 {
     QTAILQ_REMOVE(&chardevs, chr, next);
     qemu_chr_free(chr);
@@ -4351,7 +4352,7 @@ void qemu_chr_delete(CharDriverState *chr)
 ChardevInfoList *qmp_query_chardev(Error **errp)
 {
     ChardevInfoList *chr_list =3D NULL;
-    CharDriverState *chr;
+    Chardev *chr;
=20
     QTAILQ_FOREACH(chr, &chardevs, next) {
         ChardevInfoList *info =3D g_malloc0(sizeof(*info));
@@ -4401,9 +4402,9 @@ ChardevBackendInfoList *qmp_query_chardev_backends(=
Error **errp)
     return backend_list;
 }
=20
-CharDriverState *qemu_chr_find(const char *name)
+Chardev *qemu_chr_find(const char *name)
 {
-    CharDriverState *chr;
+    Chardev *chr;
=20
     QTAILQ_FOREACH(chr, &chardevs, next) {
         if (strcmp(chr->label, name) !=3D 0)
@@ -4509,12 +4510,12 @@ QemuOptsList qemu_chardev_opts =3D {
=20
 #ifdef _WIN32
=20
-static CharDriverState *qmp_chardev_open_file(const CharDriver *driver,
-                                              const char *id,
-                                              ChardevBackend *backend,
-                                              ChardevReturn *ret,
-                                              bool *be_opened,
-                                              Error **errp)
+static Chardev *qmp_chardev_open_file(const CharDriver *driver,
+                                      const char *id,
+                                      ChardevBackend *backend,
+                                      ChardevReturn *ret,
+                                      bool *be_opened,
+                                      Error **errp)
 {
     ChardevFile *file =3D backend->u.file.data;
     ChardevCommon *common =3D qapi_ChardevFile_base(file);
@@ -4546,16 +4547,16 @@ static CharDriverState *qmp_chardev_open_file(con=
st CharDriver *driver,
     return qemu_chr_open_win_file(driver, out, common, errp);
 }
=20
-static CharDriverState *qmp_chardev_open_serial(const CharDriver *driver=
,
-                                                const char *id,
-                                                ChardevBackend *backend,
-                                                ChardevReturn *ret,
-                                                bool *be_opened,
-                                                Error **errp)
+static Chardev *qmp_chardev_open_serial(const CharDriver *driver,
+                                        const char *id,
+                                        ChardevBackend *backend,
+                                        ChardevReturn *ret,
+                                        bool *be_opened,
+                                        Error **errp)
 {
     ChardevHostdev *serial =3D backend->u.serial.data;
     ChardevCommon *common =3D qapi_ChardevHostdev_base(serial);
-    CharDriverState *chr;
+    Chardev *chr;
=20
     chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
@@ -4584,12 +4585,12 @@ static int qmp_chardev_open_file_source(char *src=
, int flags,
     return fd;
 }
=20
-static CharDriverState *qmp_chardev_open_file(const CharDriver *driver,
-                                              const char *id,
-                                              ChardevBackend *backend,
-                                              ChardevReturn *ret,
-                                              bool *be_opened,
-                                              Error **errp)
+static Chardev *qmp_chardev_open_file(const CharDriver *driver,
+                                      const char *id,
+                                      ChardevBackend *backend,
+                                      ChardevReturn *ret,
+                                      bool *be_opened,
+                                      Error **errp)
 {
     ChardevFile *file =3D backend->u.file.data;
     ChardevCommon *common =3D qapi_ChardevFile_base(file);
@@ -4620,12 +4621,12 @@ static CharDriverState *qmp_chardev_open_file(con=
st CharDriver *driver,
 }
=20
 #ifdef HAVE_CHARDEV_SERIAL
-static CharDriverState *qmp_chardev_open_serial(const CharDriver *driver=
,
-                                                const char *id,
-                                                ChardevBackend *backend,
-                                                ChardevReturn *ret,
-                                                bool *be_opened,
-                                                Error **errp)
+static Chardev *qmp_chardev_open_serial(const CharDriver *driver,
+                                        const char *id,
+                                        ChardevBackend *backend,
+                                        ChardevReturn *ret,
+                                        bool *be_opened,
+                                        Error **errp)
 {
     ChardevHostdev *serial =3D backend->u.serial.data;
     ChardevCommon *common =3D qapi_ChardevHostdev_base(serial);
@@ -4643,12 +4644,12 @@ static CharDriverState *qmp_chardev_open_serial(c=
onst CharDriver *driver,
 #endif
=20
 #ifdef HAVE_CHARDEV_PARPORT
-static CharDriverState *qmp_chardev_open_parallel(const CharDriver *driv=
er,
-                                                  const char *id,
-                                                  ChardevBackend *backen=
d,
-                                                  ChardevReturn *ret,
-                                                  bool *be_opened,
-                                                  Error **errp)
+static Chardev *qmp_chardev_open_parallel(const CharDriver *driver,
+                                          const char *id,
+                                          ChardevBackend *backend,
+                                          ChardevReturn *ret,
+                                          bool *be_opened,
+                                          Error **errp)
 {
     ChardevHostdev *parallel =3D backend->u.parallel.data;
     ChardevCommon *common =3D qapi_ChardevHostdev_base(parallel);
@@ -4662,7 +4663,7 @@ static CharDriverState *qmp_chardev_open_parallel(c=
onst CharDriver *driver,
 }
=20
 static const CharDriver parallel_driver =3D {
-    .instance_size =3D sizeof(ParallelCharDriver),
+    .instance_size =3D sizeof(ParallelChardev),
     .alias =3D "parport", .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
     .parse =3D qemu_chr_parse_parallel, .create =3D qmp_chardev_open_par=
allel,
 #if defined(__linux__)
@@ -4683,11 +4684,11 @@ static const CharDriver file_driver =3D {
     .kind =3D CHARDEV_BACKEND_KIND_FILE,
     .parse =3D qemu_chr_parse_file_out, .create =3D qmp_chardev_open_fil=
e,
 #ifdef _WIN32
-    sizeof(WinCharState),
+    sizeof(WinChardev),
     .chr_write =3D win_chr_write,
     /* FIXME: no chr_free */
 #else
-    sizeof(FDCharDriver),
+    sizeof(FDChardev),
     .chr_add_watch =3D fd_chr_add_watch,
     .chr_write =3D fd_chr_write,
     .chr_update_read_handler =3D fd_chr_update_read_handler,
@@ -4700,11 +4701,11 @@ static const CharDriver serial_driver =3D {
     .alias =3D "tty", .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
     .parse =3D qemu_chr_parse_serial, .create =3D qmp_chardev_open_seria=
l,
 #ifdef _WIN32
-    sizeof(WinCharState),
+    sizeof(WinChardev),
     .chr_write =3D win_chr_write,
     .chr_free =3D win_chr_free,
 #else
-    sizeof(FDCharDriver),
+    sizeof(FDChardev),
     .chr_add_watch =3D fd_chr_add_watch,
     .chr_write =3D fd_chr_write,
     .chr_update_read_handler =3D fd_chr_update_read_handler,
@@ -4716,8 +4717,8 @@ static const CharDriver serial_driver =3D {
=20
 static gboolean socket_reconnect_timeout(gpointer opaque)
 {
-    CharDriverState *chr =3D opaque;
-    TCPCharDriver *s =3D opaque;
+    Chardev *chr =3D opaque;
+    TCPChardev *s =3D opaque;
     QIOChannelSocket *sioc;
=20
     s->reconnect_timer =3D 0;
@@ -4735,15 +4736,15 @@ static gboolean socket_reconnect_timeout(gpointer=
 opaque)
     return false;
 }
=20
-static CharDriverState *qmp_chardev_open_socket(const CharDriver *driver=
,
-                                                const char *id,
-                                                ChardevBackend *backend,
-                                                ChardevReturn *ret,
-                                                bool *be_opened,
-                                                Error **errp)
+static Chardev *qmp_chardev_open_socket(const CharDriver *driver,
+                                        const char *id,
+                                        ChardevBackend *backend,
+                                        ChardevReturn *ret,
+                                        bool *be_opened,
+                                        Error **errp)
 {
-    CharDriverState *chr;
-    TCPCharDriver *s;
+    Chardev *chr;
+    TCPChardev *s;
     ChardevSocket *sock =3D backend->u.socket.data;
     SocketAddress *addr =3D sock->addr;
     bool do_nodelay     =3D sock->has_nodelay ? sock->nodelay : false;
@@ -4758,7 +4759,7 @@ static CharDriverState *qmp_chardev_open_socket(con=
st CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    s =3D (TCPCharDriver *)chr;
+    s =3D (TCPChardev *)chr;
=20
     s->is_unix =3D addr->type =3D=3D SOCKET_ADDRESS_KIND_UNIX;
     s->is_listen =3D is_listen;
@@ -4865,7 +4866,7 @@ static CharDriverState *qmp_chardev_open_socket(con=
st CharDriver *driver,
 }
=20
 static const CharDriver socket_driver =3D {
-    .instance_size =3D sizeof(TCPCharDriver),
+    .instance_size =3D sizeof(TCPChardev),
     .kind =3D CHARDEV_BACKEND_KIND_SOCKET,
     .parse =3D qemu_chr_parse_socket, .create =3D qmp_chardev_open_socke=
t,
     .chr_wait_connected =3D tcp_chr_wait_connected,
@@ -4880,19 +4881,19 @@ static const CharDriver socket_driver =3D {
     .chr_free =3D tcp_chr_free,
 };
=20
-static CharDriverState *qmp_chardev_open_udp(const CharDriver *driver,
-                                             const char *id,
-                                             ChardevBackend *backend,
-                                             ChardevReturn *ret,
-                                             bool *be_opened,
-                                             Error **errp)
+static Chardev *qmp_chardev_open_udp(const CharDriver *driver,
+                                     const char *id,
+                                     ChardevBackend *backend,
+                                     ChardevReturn *ret,
+                                     bool *be_opened,
+                                     Error **errp)
 {
     ChardevUdp *udp =3D backend->u.udp.data;
     ChardevCommon *common =3D qapi_ChardevUdp_base(udp);
     QIOChannelSocket *sioc =3D qio_channel_socket_new();
     char *name;
-    CharDriverState *chr;
-    NetCharDriver *s;
+    Chardev *chr;
+    NetChardev *s;
=20
     if (qio_channel_socket_dgram_sync(sioc,
                                       udp->local, udp->remote,
@@ -4910,7 +4911,7 @@ static CharDriverState *qmp_chardev_open_udp(const =
CharDriver *driver,
     qio_channel_set_name(QIO_CHANNEL(sioc), name);
     g_free(name);
=20
-    s =3D (NetCharDriver *)chr;
+    s =3D (NetChardev *)chr;
     s->ioc =3D QIO_CHANNEL(sioc);
     s->bufcnt =3D 0;
     s->bufptr =3D 0;
@@ -4921,7 +4922,7 @@ static CharDriverState *qmp_chardev_open_udp(const =
CharDriver *driver,
 }
=20
 static const CharDriver udp_driver =3D {
-    .instance_size =3D sizeof(NetCharDriver),
+    .instance_size =3D sizeof(NetChardev),
     .kind =3D CHARDEV_BACKEND_KIND_UDP,
     .parse =3D qemu_chr_parse_udp, .create =3D qmp_chardev_open_udp,
     .chr_write =3D udp_chr_write,
@@ -4929,13 +4930,13 @@ static const CharDriver udp_driver =3D {
     .chr_free =3D udp_chr_free,
 };
=20
-bool qemu_chr_has_feature(CharDriverState *chr,
+bool qemu_chr_has_feature(Chardev *chr,
                           CharDriverFeature feature)
 {
     return test_bit(feature, chr->features);
 }
=20
-void qemu_chr_set_feature(CharDriverState *chr,
+void qemu_chr_set_feature(Chardev *chr,
                            CharDriverFeature feature)
 {
     return set_bit(feature, chr->features);
@@ -4945,7 +4946,7 @@ ChardevReturn *qmp_chardev_add(const char *id, Char=
devBackend *backend,
                                Error **errp)
 {
     ChardevReturn *ret =3D g_new0(ChardevReturn, 1);
-    CharDriverState *chr =3D NULL;
+    Chardev *chr =3D NULL;
     const CharDriver *cd;
     Error *local_err =3D NULL;
     bool be_opened =3D true;
@@ -4986,7 +4987,7 @@ out_error:
=20
 void qmp_chardev_remove(const char *id, Error **errp)
 {
-    CharDriverState *chr;
+    Chardev *chr;
=20
     chr =3D qemu_chr_find(id);
     if (chr =3D=3D NULL) {
@@ -5007,7 +5008,7 @@ void qmp_chardev_remove(const char *id, Error **err=
p)
=20
 void qemu_chr_cleanup(void)
 {
-    CharDriverState *chr, *tmp;
+    Chardev *chr, *tmp;
=20
     QTAILQ_FOREACH_SAFE(chr, &chardevs, next, tmp) {
         qemu_chr_delete(chr);
diff --git a/qmp.c b/qmp.c
index 0028f0b30e..d9554062ed 100644
--- a/qmp.c
+++ b/qmp.c
@@ -616,7 +616,7 @@ void qmp_add_client(const char *protocol, const char =
*fdname,
                     bool has_skipauth, bool skipauth, bool has_tls, bool=
 tls,
                     Error **errp)
 {
-    CharDriverState *s;
+    Chardev *s;
     int fd;
=20
     fd =3D monitor_get_fd(cur_mon, fdname, errp);
diff --git a/qtest.c b/qtest.c
index 46b99aed52..b307db9ade 100644
--- a/qtest.c
+++ b/qtest.c
@@ -668,7 +668,7 @@ static int qtest_init_accel(MachineState *ms)
=20
 void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error *=
*errp)
 {
-    CharDriverState *chr;
+    Chardev *chr;
=20
     chr =3D qemu_chr_new("qtest", qtest_chrdev);
=20
diff --git a/replay/replay-char.c b/replay/replay-char.c
index edf46ab9df..aa65955942 100755
--- a/replay/replay-char.c
+++ b/replay/replay-char.c
@@ -18,7 +18,7 @@
=20
 /* Char drivers that generate qemu_chr_be_write events
    that should be saved into the log. */
-static CharDriverState **char_drivers;
+static Chardev **char_drivers;
 static int drivers_count;
=20
 /* Char event attributes. */
@@ -28,7 +28,7 @@ typedef struct CharEvent {
     size_t len;
 } CharEvent;
=20
-static int find_char_driver(CharDriverState *chr)
+static int find_char_driver(Chardev *chr)
 {
     int i =3D 0;
     for ( ; i < drivers_count ; ++i) {
@@ -39,7 +39,7 @@ static int find_char_driver(CharDriverState *chr)
     return -1;
 }
=20
-void replay_register_char_driver(CharDriverState *chr)
+void replay_register_char_driver(Chardev *chr)
 {
     if (replay_mode =3D=3D REPLAY_MODE_NONE) {
         return;
@@ -49,7 +49,7 @@ void replay_register_char_driver(CharDriverState *chr)
     char_drivers[drivers_count++] =3D chr;
 }
=20
-void replay_chr_be_write(CharDriverState *s, uint8_t *buf, int len)
+void replay_chr_be_write(Chardev *s, uint8_t *buf, int len)
 {
     CharEvent *event =3D g_malloc0(sizeof(CharEvent));
=20
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 4118059c96..5feb88c1ec 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -6,29 +6,29 @@
 #include <spice/protocol.h>
=20
=20
-typedef struct SpiceCharDriver {
-    CharDriverState       parent;
+typedef struct SpiceChardev {
+    Chardev               parent;
=20
-    SpiceCharDeviceInstance     sin;
+    SpiceCharDeviceInstance sin;
     bool                  active;
     bool                  blocked;
     const uint8_t         *datapos;
     int                   datalen;
-    QLIST_ENTRY(SpiceCharDriver) next;
-} SpiceCharDriver;
+    QLIST_ENTRY(SpiceChardev) next;
+} SpiceChardev;
=20
 typedef struct SpiceCharSource {
     GSource               source;
-    SpiceCharDriver       *scd;
+    SpiceChardev       *scd;
 } SpiceCharSource;
=20
-static QLIST_HEAD(, SpiceCharDriver) spice_chars =3D
+static QLIST_HEAD(, SpiceChardev) spice_chars =3D
     QLIST_HEAD_INITIALIZER(spice_chars);
=20
 static int vmc_write(SpiceCharDeviceInstance *sin, const uint8_t *buf, i=
nt len)
 {
-    SpiceCharDriver *scd =3D container_of(sin, SpiceCharDriver, sin);
-    CharDriverState *chr =3D (CharDriverState *)scd;
+    SpiceChardev *scd =3D container_of(sin, SpiceChardev, sin);
+    Chardev *chr =3D (Chardev *)scd;
     ssize_t out =3D 0;
     ssize_t last_out;
     uint8_t* p =3D (uint8_t*)buf;
@@ -51,7 +51,7 @@ static int vmc_write(SpiceCharDeviceInstance *sin, cons=
t uint8_t *buf, int len)
=20
 static int vmc_read(SpiceCharDeviceInstance *sin, uint8_t *buf, int len)
 {
-    SpiceCharDriver *scd =3D container_of(sin, SpiceCharDriver, sin);
+    SpiceChardev *scd =3D container_of(sin, SpiceChardev, sin);
     int bytes =3D MIN(len, scd->datalen);
=20
     if (bytes > 0) {
@@ -71,8 +71,8 @@ static int vmc_read(SpiceCharDeviceInstance *sin, uint8=
_t *buf, int len)
 #if SPICE_SERVER_VERSION >=3D 0x000c02
 static void vmc_event(SpiceCharDeviceInstance *sin, uint8_t event)
 {
-    SpiceCharDriver *scd =3D container_of(sin, SpiceCharDriver, sin);
-    CharDriverState *chr =3D (CharDriverState *)scd;
+    SpiceChardev *scd =3D container_of(sin, SpiceChardev, sin);
+    Chardev *chr =3D (Chardev *)scd;
     int chr_event;
=20
     switch (event) {
@@ -90,8 +90,8 @@ static void vmc_event(SpiceCharDeviceInstance *sin, uin=
t8_t event)
=20
 static void vmc_state(SpiceCharDeviceInstance *sin, int connected)
 {
-    SpiceCharDriver *scd =3D container_of(sin, SpiceCharDriver, sin);
-    CharDriverState *chr =3D (CharDriverState *)scd;
+    SpiceChardev *scd =3D container_of(sin, SpiceChardev, sin);
+    Chardev *chr =3D (Chardev *)scd;
=20
     if ((chr->be_open && connected) ||
         (!chr->be_open && !connected)) {
@@ -119,7 +119,7 @@ static SpiceCharDeviceInterface vmc_interface =3D {
 };
=20
=20
-static void vmc_register_interface(SpiceCharDriver *scd)
+static void vmc_register_interface(SpiceChardev *scd)
 {
     if (scd->active) {
         return;
@@ -130,7 +130,7 @@ static void vmc_register_interface(SpiceCharDriver *s=
cd)
     trace_spice_vmc_register_interface(scd);
 }
=20
-static void vmc_unregister_interface(SpiceCharDriver *scd)
+static void vmc_unregister_interface(SpiceChardev *scd)
 {
     if (!scd->active) {
         return;
@@ -170,9 +170,9 @@ static GSourceFuncs SpiceCharSourceFuncs =3D {
     .dispatch =3D spice_char_source_dispatch,
 };
=20
-static GSource *spice_chr_add_watch(CharDriverState *chr, GIOCondition c=
ond)
+static GSource *spice_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    SpiceCharDriver *scd =3D (SpiceCharDriver *)chr;
+    SpiceChardev *scd =3D (SpiceChardev *)chr;
     SpiceCharSource *src;
=20
     assert(cond & G_IO_OUT);
@@ -184,9 +184,9 @@ static GSource *spice_chr_add_watch(CharDriverState *=
chr, GIOCondition cond)
     return (GSource *)src;
 }
=20
-static int spice_chr_write(CharDriverState *chr, const uint8_t *buf, int=
 len)
+static int spice_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    SpiceCharDriver *s =3D (SpiceCharDriver *)chr;
+    SpiceChardev *s =3D (SpiceChardev *)chr;
     int read_bytes;
=20
     assert(s->datalen =3D=3D 0);
@@ -203,9 +203,9 @@ static int spice_chr_write(CharDriverState *chr, cons=
t uint8_t *buf, int len)
     return read_bytes;
 }
=20
-static void spice_chr_free(struct CharDriverState *chr)
+static void spice_chr_free(struct Chardev *chr)
 {
-    SpiceCharDriver *s =3D (SpiceCharDriver *)chr;
+    SpiceChardev *s =3D (SpiceChardev *)chr;
=20
     vmc_unregister_interface(s);
     QLIST_REMOVE(s, next);
@@ -216,9 +216,9 @@ static void spice_chr_free(struct CharDriverState *ch=
r)
 #endif
 }
=20
-static void spice_vmc_set_fe_open(struct CharDriverState *chr, int fe_op=
en)
+static void spice_vmc_set_fe_open(struct Chardev *chr, int fe_open)
 {
-    SpiceCharDriver *s =3D (SpiceCharDriver *)chr;
+    SpiceChardev *s =3D (SpiceChardev *)chr;
     if (fe_open) {
         vmc_register_interface(s);
     } else {
@@ -226,10 +226,10 @@ static void spice_vmc_set_fe_open(struct CharDriver=
State *chr, int fe_open)
     }
 }
=20
-static void spice_port_set_fe_open(struct CharDriverState *chr, int fe_o=
pen)
+static void spice_port_set_fe_open(struct Chardev *chr, int fe_open)
 {
 #if SPICE_SERVER_VERSION >=3D 0x000c02
-    SpiceCharDriver *s =3D (SpiceCharDriver *)chr;
+    SpiceChardev *s =3D (SpiceChardev *)chr;
=20
     if (fe_open) {
         spice_server_port_event(&s->sin, SPICE_PORT_EVENT_OPENED);
@@ -256,26 +256,26 @@ static void print_allowed_subtypes(void)
     fprintf(stderr, "\n");
 }
=20
-static void spice_chr_accept_input(struct CharDriverState *chr)
+static void spice_chr_accept_input(struct Chardev *chr)
 {
-    SpiceCharDriver *s =3D (SpiceCharDriver *)chr;
+    SpiceChardev *s =3D (SpiceChardev *)chr;
=20
     spice_server_char_device_wakeup(&s->sin);
 }
=20
-static CharDriverState *chr_open(const CharDriver *driver,
+static Chardev *chr_open(const CharDriver *driver,
                                  const char *subtype,
                                  ChardevCommon *backend,
                                  Error **errp)
 {
-    CharDriverState *chr;
-    SpiceCharDriver *s;
+    Chardev *chr;
+    SpiceChardev *s;
=20
     chr =3D qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
-    s =3D (SpiceCharDriver *)chr;
+    s =3D (SpiceChardev *)chr;
     s->active =3D false;
     s->sin.subtype =3D g_strdup(subtype);
=20
@@ -284,7 +284,7 @@ static CharDriverState *chr_open(const CharDriver *dr=
iver,
     return chr;
 }
=20
-static CharDriverState *qemu_chr_open_spice_vmc(const CharDriver *driver=
,
+static Chardev *qemu_chr_open_spice_vmc(const CharDriver *driver,
                                                 const char *id,
                                                 ChardevBackend *backend,
                                                 ChardevReturn *ret,
@@ -312,7 +312,7 @@ static CharDriverState *qemu_chr_open_spice_vmc(const=
 CharDriver *driver,
 }
=20
 #if SPICE_SERVER_VERSION >=3D 0x000c02
-static CharDriverState *qemu_chr_open_spice_port(const CharDriver *drive=
r,
+static Chardev *qemu_chr_open_spice_port(const CharDriver *driver,
                                                  const char *id,
                                                  ChardevBackend *backend=
,
                                                  ChardevReturn *ret,
@@ -322,8 +322,8 @@ static CharDriverState *qemu_chr_open_spice_port(cons=
t CharDriver *driver,
     ChardevSpicePort *spiceport =3D backend->u.spiceport.data;
     const char *name =3D spiceport->fqdn;
     ChardevCommon *common =3D qapi_ChardevSpicePort_base(spiceport);
-    CharDriverState *chr;
-    SpiceCharDriver *s;
+    Chardev *chr;
+    SpiceChardev *s;
=20
     if (name =3D=3D NULL) {
         fprintf(stderr, "spice-qemu-char: missing name parameter\n");
@@ -335,7 +335,7 @@ static CharDriverState *qemu_chr_open_spice_port(cons=
t CharDriver *driver,
         return NULL;
     }
     *be_opened =3D false;
-    s =3D (SpiceCharDriver *)chr;
+    s =3D (SpiceChardev *)chr;
     s->sin.portname =3D g_strdup(name);
=20
     return chr;
@@ -343,7 +343,7 @@ static CharDriverState *qemu_chr_open_spice_port(cons=
t CharDriver *driver,
=20
 void qemu_spice_register_ports(void)
 {
-    SpiceCharDriver *s;
+    SpiceChardev *s;
=20
     QLIST_FOREACH(s, &spice_chars, next) {
         if (s->sin.portname =3D=3D NULL) {
@@ -387,7 +387,7 @@ static void qemu_chr_parse_spice_port(QemuOpts *opts,=
 ChardevBackend *backend,
 static void register_types(void)
 {
     static const CharDriver vmc_driver =3D {
-        .instance_size =3D sizeof(SpiceCharDriver),
+        .instance_size =3D sizeof(SpiceChardev),
         .kind =3D CHARDEV_BACKEND_KIND_SPICEVMC,
         .parse =3D qemu_chr_parse_spice_vmc, .create =3D qemu_chr_open_s=
pice_vmc,
         .chr_write =3D spice_chr_write,
@@ -397,7 +397,7 @@ static void register_types(void)
         .chr_free =3D spice_chr_free,
     };
     static const CharDriver port_driver =3D {
-        .instance_size =3D sizeof(SpiceCharDriver),
+        .instance_size =3D sizeof(SpiceChardev),
         .kind =3D CHARDEV_BACKEND_KIND_SPICEPORT,
         .parse =3D qemu_chr_parse_spice_port, .create =3D qemu_chr_open_=
spice_port,
         .chr_write =3D spice_chr_write,
diff --git a/stubs/get-next-serial.c b/stubs/get-next-serial.c
index 6ff6a6d3b2..df425e95c7 100644
--- a/stubs/get-next-serial.c
+++ b/stubs/get-next-serial.c
@@ -1,4 +1,4 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
=20
-CharDriverState *serial_hds[0];
+Chardev *serial_hds[0];
diff --git a/stubs/monitor-init.c b/stubs/monitor-init.c
index de1bc7cd54..ebe56c2819 100644
--- a/stubs/monitor-init.c
+++ b/stubs/monitor-init.c
@@ -2,6 +2,6 @@
 #include "qemu-common.h"
 #include "monitor/monitor.h"
=20
-void monitor_init(CharDriverState *chr, int flags)
+void monitor_init(Chardev *chr, int flags)
 {
 }
diff --git a/stubs/replay.c b/stubs/replay.c
index d9a6da99d2..9c8aa48c9c 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -30,11 +30,11 @@ void replay_finish(void)
 {
 }
=20
-void replay_register_char_driver(CharDriverState *chr)
+void replay_register_char_driver(Chardev *chr)
 {
 }
=20
-void replay_chr_be_write(CharDriverState *s, uint8_t *buf, int len)
+void replay_chr_be_write(Chardev *s, uint8_t *buf, int len)
 {
     abort();
 }
diff --git a/tests/test-char.c b/tests/test-char.c
index 241685afbb..da69f110e4 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -40,7 +40,7 @@ static void fe_event(void *opaque, int event)
 #ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
 static void char_stdio_test_subprocess(void)
 {
-    CharDriverState *chr;
+    Chardev *chr;
     CharBackend be;
     int ret;
=20
@@ -68,7 +68,7 @@ static void char_stdio_test(void)
 static void char_ringbuf_test(void)
 {
     QemuOpts *opts;
-    CharDriverState *chr;
+    Chardev *chr;
     CharBackend be;
     char *data;
     int ret;
@@ -109,7 +109,7 @@ static void char_ringbuf_test(void)
 static void char_mux_test(void)
 {
     QemuOpts *opts;
-    CharDriverState *chr, *base;
+    Chardev *chr, *base;
     char *data;
     FeHandler h1 =3D { 0, }, h2 =3D { 0, };
     CharBackend chr_be1, chr_be2;
@@ -185,7 +185,7 @@ static void char_mux_test(void)
 static void char_null_test(void)
 {
     Error *err =3D NULL;
-    CharDriverState *chr;
+    Chardev *chr;
     CharBackend be;
     int ret;
=20
@@ -227,7 +227,7 @@ static void char_null_test(void)
=20
 static void char_invalid_test(void)
 {
-    CharDriverState *chr;
+    Chardev *chr;
=20
     chr =3D qemu_chr_new("label-invalid", "invalid");
     g_assert_null(chr);
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 96bf00eefa..f3ac6ea21a 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -454,7 +454,7 @@ static void chr_event(void *opaque, int event)
 static void test_server_create_chr(TestServer *server, const gchar *opt)
 {
     gchar *chr_path;
-    CharDriverState *chr;
+    Chardev *chr;
=20
     chr_path =3D g_strdup_printf("unix:%s%s", server->socket_path, opt);
     chr =3D qemu_chr_new(server->chr_name, chr_path);
@@ -486,7 +486,7 @@ static inline void test_server_connect(TestServer *se=
rver)
 static gboolean _test_server_free(TestServer *server)
 {
     int i;
-    CharDriverState *chr =3D qemu_chr_fe_get_driver(&server->chr);
+    Chardev *chr =3D qemu_chr_fe_get_driver(&server->chr);
=20
     qemu_chr_fe_deinit(&server->chr);
     qemu_chr_delete(chr);
diff --git a/ui/console.c b/ui/console.c
index cda1b56024..80d10c7a4c 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -157,7 +157,7 @@ struct QemuConsole {
     int esc_params[MAX_ESC_PARAMS];
     int nb_esc_params;
=20
-    CharDriverState *chr;
+    Chardev *chr;
     /* fifo for key pressed */
     QEMUFIFO out_fifo;
     uint8_t out_fifo_buf[16];
@@ -182,7 +182,7 @@ static int nb_consoles =3D 0;
 static bool cursor_visible_phase;
 static QEMUTimer *cursor_timer;
=20
-static void text_console_do_init(CharDriverState *chr, DisplayState *ds)=
;
+static void text_console_do_init(Chardev *chr, DisplayState *ds);
 static void dpy_refresh(DisplayState *s);
 static DisplayState *get_alloc_displaystate(void);
 static void text_console_update_cursor_timer(void);
@@ -1035,14 +1035,14 @@ void console_select(unsigned int index)
     }
 }
=20
-typedef struct VCDriverState {
-    CharDriverState parent;
+typedef struct VCChardev {
+    Chardev parent;
     QemuConsole *console;
-} VCDriverState;
+} VCChardev;
=20
-static int console_puts(CharDriverState *chr, const uint8_t *buf, int le=
n)
+static int console_puts(Chardev *chr, const uint8_t *buf, int len)
 {
-    VCDriverState *drv =3D (VCDriverState *)chr;
+    VCChardev *drv =3D (VCChardev *)chr;
     QemuConsole *s =3D drv->console;
     int i;
=20
@@ -1951,9 +1951,9 @@ int qemu_console_get_height(QemuConsole *con, int f=
allback)
     return con ? surface_height(con->surface) : fallback;
 }
=20
-static void text_console_set_echo(CharDriverState *chr, bool echo)
+static void text_console_set_echo(Chardev *chr, bool echo)
 {
-    VCDriverState *drv =3D (VCDriverState *)chr;
+    VCChardev *drv =3D (VCChardev *)chr;
     QemuConsole *s =3D drv->console;
=20
     s->echo =3D echo;
@@ -1992,9 +1992,9 @@ static const GraphicHwOps text_console_ops =3D {
     .text_update =3D text_console_update,
 };
=20
-static void text_console_do_init(CharDriverState *chr, DisplayState *ds)
+static void text_console_do_init(Chardev *chr, DisplayState *ds)
 {
-    VCDriverState *drv =3D (VCDriverState *)chr;
+    VCChardev *drv =3D (VCChardev *)chr;
     QemuConsole *s =3D drv->console;
     int g_width =3D 80 * FONT_WIDTH;
     int g_height =3D 24 * FONT_HEIGHT;
@@ -2047,11 +2047,11 @@ static void text_console_do_init(CharDriverState =
*chr, DisplayState *ds)
=20
 static const CharDriver vc_driver;
=20
-static CharDriverState *text_console_init(ChardevVC *vc, Error **errp)
+static Chardev *text_console_init(ChardevVC *vc, Error **errp)
 {
     ChardevCommon *common =3D qapi_ChardevVC_base(vc);
-    CharDriverState *chr;
-    VCDriverState *drv;
+    Chardev *chr;
+    VCChardev *drv;
     QemuConsole *s;
     unsigned width =3D 0;
     unsigned height =3D 0;
@@ -2088,7 +2088,7 @@ static CharDriverState *text_console_init(ChardevVC=
 *vc, Error **errp)
     }
=20
     s->chr =3D chr;
-    drv =3D (VCDriverState *)chr;
+    drv =3D (VCChardev *)chr;
     drv->console =3D s;
=20
     if (display_state) {
@@ -2099,10 +2099,10 @@ static CharDriverState *text_console_init(Chardev=
VC *vc, Error **errp)
=20
 static VcHandler *vc_handler =3D text_console_init;
=20
-static CharDriverState *vc_init(const CharDriver *driver,
-                                const char *id, ChardevBackend *backend,
-                                ChardevReturn *ret, bool *be_opened,
-                                Error **errp)
+static Chardev *vc_init(const CharDriver *driver,
+                        const char *id, ChardevBackend *backend,
+                        ChardevReturn *ret, bool *be_opened,
+                        Error **errp)
 {
     /* console/chardev init sometimes completes elsewhere in a 2nd
      * stage, so defer OPENED events until they are fully initialized
@@ -2193,7 +2193,7 @@ static const TypeInfo qemu_console_info =3D {
 };
=20
 static const CharDriver vc_driver =3D {
-    .instance_size =3D sizeof(VCDriverState),
+    .instance_size =3D sizeof(VCChardev),
     .kind =3D CHARDEV_BACKEND_KIND_VC,
     .parse =3D qemu_chr_parse_vc, .create =3D vc_init,
     .chr_write =3D console_puts,
diff --git a/ui/gtk.c b/ui/gtk.c
index feca4047e2..32df26e5d7 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -178,11 +178,11 @@ struct GtkDisplayState {
     bool ignore_keys;
 };
=20
-typedef struct VCDriverState {
-    CharDriverState parent;
+typedef struct VCChardev {
+    Chardev parent;
     VirtualConsole *console;
     bool echo;
-} VCDriverState;
+} VCChardev;
=20
 static void gd_grab_pointer(VirtualConsole *vc, const char *reason);
 static void gd_ungrab_pointer(GtkDisplayState *s);
@@ -1679,18 +1679,18 @@ static void gd_vc_adjustment_changed(GtkAdjustmen=
t *adjustment, void *opaque)
     }
 }
=20
-static int gd_vc_chr_write(CharDriverState *chr, const uint8_t *buf, int=
 len)
+static int gd_vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    VCDriverState *vcd =3D (VCDriverState *)chr;
+    VCChardev *vcd =3D (VCChardev *)chr;
     VirtualConsole *vc =3D vcd->console;
=20
     vte_terminal_feed(VTE_TERMINAL(vc->vte.terminal), (const char *)buf,=
 len);
     return len;
 }
=20
-static void gd_vc_chr_set_echo(CharDriverState *chr, bool echo)
+static void gd_vc_chr_set_echo(Chardev *chr, bool echo)
 {
-    VCDriverState *vcd =3D (VCDriverState *)chr;
+    VCChardev *vcd =3D (VCChardev *)chr;
     VirtualConsole *vc =3D vcd->console;
=20
     if (vc) {
@@ -1701,19 +1701,19 @@ static void gd_vc_chr_set_echo(CharDriverState *c=
hr, bool echo)
 }
=20
 static int nb_vcs;
-static CharDriverState *vcs[MAX_VCS];
+static Chardev *vcs[MAX_VCS];
=20
-static CharDriverState *gd_vc_handler(ChardevVC *vc, Error **errp)
+static Chardev *gd_vc_handler(ChardevVC *vc, Error **errp)
 {
     static const CharDriver gd_vc_driver =3D {
-        .instance_size =3D sizeof(VCDriverState),
+        .instance_size =3D sizeof(VCChardev),
         .kind =3D CHARDEV_BACKEND_KIND_VC,
         .chr_write =3D gd_vc_chr_write,
         .chr_set_echo =3D gd_vc_chr_set_echo,
     };
=20
     ChardevCommon *common =3D qapi_ChardevVC_base(vc);
-    CharDriverState *chr;
+    Chardev *chr;
=20
     if (nb_vcs =3D=3D MAX_VCS) {
         error_setg(errp, "Maximum number of consoles reached");
@@ -1758,14 +1758,14 @@ static gboolean gd_vc_in(VteTerminal *terminal, g=
char *text, guint size,
 }
=20
 static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
-                              CharDriverState *chr, int idx,
+                              Chardev *chr, int idx,
                               GSList *group, GtkWidget *view_menu)
 {
     char buffer[32];
     GtkWidget *box;
     GtkWidget *scrollbar;
     GtkAdjustment *vadjustment;
-    VCDriverState *vcd =3D (VCDriverState *)chr;
+    VCChardev *vcd =3D (VCChardev *)chr;
=20
     vc->s =3D s;
     vc->vte.echo =3D vcd->echo;
diff --git a/vl.c b/vl.c
index d77dd862f9..8296f8da49 100644
--- a/vl.c
+++ b/vl.c
@@ -149,10 +149,10 @@ static int full_screen =3D 0;
 static int no_frame =3D 0;
 int no_quit =3D 0;
 static bool grab_on_hover;
-CharDriverState *serial_hds[MAX_SERIAL_PORTS];
-CharDriverState *parallel_hds[MAX_PARALLEL_PORTS];
-CharDriverState *virtcon_hds[MAX_VIRTIO_CONSOLES];
-CharDriverState *sclp_hds[MAX_SCLP_CONSOLES];
+Chardev *serial_hds[MAX_SERIAL_PORTS];
+Chardev *parallel_hds[MAX_PARALLEL_PORTS];
+Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
+Chardev *sclp_hds[MAX_SCLP_CONSOLES];
 int win2k_install_hack =3D 0;
 int singlestep =3D 0;
 int smp_cpus =3D 1;
@@ -2400,7 +2400,7 @@ static int fsdev_init_func(void *opaque, QemuOpts *=
opts, Error **errp)
=20
 static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
-    CharDriverState *chr;
+    Chardev *chr;
     const char *chardev;
     const char *mode;
     int flags;
diff --git a/xen-common-stub.c b/xen-common-stub.c
index 699c3f1c64..09fce2dd36 100644
--- a/xen-common-stub.c
+++ b/xen-common-stub.c
@@ -9,6 +9,6 @@
 #include "qemu-common.h"
 #include "hw/xen/xen.h"
=20
-void xenstore_store_pv_console_info(int i, CharDriverState *chr)
+void xenstore_store_pv_console_info(int i, Chardev *chr)
 {
 }
diff --git a/xen-common.c b/xen-common.c
index 909976071c..fd2c92847e 100644
--- a/xen-common.c
+++ b/xen-common.c
@@ -25,7 +25,7 @@
     do { } while (0)
 #endif
=20
-static int store_dev_info(int domid, CharDriverState *cs, const char *st=
ring)
+static int store_dev_info(int domid, Chardev *cs, const char *string)
 {
     struct xs_handle *xs =3D NULL;
     char *path =3D NULL;
@@ -74,7 +74,7 @@ out:
     return ret;
 }
=20
-void xenstore_store_pv_console_info(int i, CharDriverState *chr)
+void xenstore_store_pv_console_info(int i, Chardev *chr)
 {
     if (i =3D=3D 0) {
         store_dev_info(xen_domid, chr, "/console");
diff --git a/hw/lm32/lm32.h b/hw/lm32/lm32.h
index db9eb29ea4..d1514a61b3 100644
--- a/hw/lm32/lm32.h
+++ b/hw/lm32/lm32.h
@@ -16,7 +16,7 @@ static inline DeviceState *lm32_pic_init(qemu_irq cpu_i=
rq)
     return dev;
 }
=20
-static inline DeviceState *lm32_juart_init(CharDriverState *chr)
+static inline DeviceState *lm32_juart_init(Chardev *chr)
 {
     DeviceState *dev;
=20
@@ -29,7 +29,7 @@ static inline DeviceState *lm32_juart_init(CharDriverSt=
ate *chr)
=20
 static inline DeviceState *lm32_uart_create(hwaddr addr,
                                             qemu_irq irq,
-                                            CharDriverState *chr)
+                                            Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *s;
diff --git a/hw/lm32/milkymist-hw.h b/hw/lm32/milkymist-hw.h
index 4418b44ca9..d3be0cfb3a 100644
--- a/hw/lm32/milkymist-hw.h
+++ b/hw/lm32/milkymist-hw.h
@@ -6,7 +6,7 @@
=20
 static inline DeviceState *milkymist_uart_create(hwaddr base,
                                                  qemu_irq irq,
-                                                 CharDriverState *chr)
+                                                 Chardev *chr)
 {
     DeviceState *dev;
=20
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index 29fef8bfa1..4f6889dbad 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -131,7 +131,7 @@ void exynos4210_combiner_get_gpioin(Exynos4210Irq *ir=
qs, DeviceState *dev,
 DeviceState *exynos4210_uart_create(hwaddr addr,
                                     int fifo_size,
                                     int channel,
-                                    CharDriverState *chr,
+                                    Chardev *chr,
                                     qemu_irq irq);
=20
 #endif /* EXYNOS4210_H */
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index f026c8df57..80d326ef8a 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -664,14 +664,14 @@ struct omap_uart_s;
 struct omap_uart_s *omap_uart_init(hwaddr base,
                 qemu_irq irq, omap_clk fclk, omap_clk iclk,
                 qemu_irq txdma, qemu_irq rxdma,
-                const char *label, CharDriverState *chr);
+                const char *label, Chardev *chr);
 struct omap_uart_s *omap2_uart_init(MemoryRegion *sysmem,
                 struct omap_target_agent_s *ta,
                 qemu_irq irq, omap_clk fclk, omap_clk iclk,
                 qemu_irq txdma, qemu_irq rxdma,
-                const char *label, CharDriverState *chr);
+                const char *label, Chardev *chr);
 void omap_uart_reset(struct omap_uart_s *s);
-void omap_uart_attach(struct omap_uart_s *s, CharDriverState *chr);
+void omap_uart_attach(struct omap_uart_s *s, Chardev *chr);
=20
 struct omap_mpuio_s;
 qemu_irq *omap_mpuio_in_get(struct omap_mpuio_s *s);
diff --git a/include/hw/bt.h b/include/hw/bt.h
index 2fa22bdab6..b5e11d4d43 100644
--- a/include/hw/bt.h
+++ b/include/hw/bt.h
@@ -127,8 +127,8 @@ enum {
     csrhci_pin_wakeup,
     __csrhci_pins,
 };
-qemu_irq *csrhci_pins_get(CharDriverState *chr);
-CharDriverState *uart_hci_init(void);
+qemu_irq *csrhci_pins_get(Chardev *chr);
+Chardev *uart_hci_init(void);
=20
 /* bt-l2cap.c */
 struct bt_l2cap_device_s;
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uar=
t.h
index ca75eb5e32..c836db4b74 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -51,7 +51,7 @@ typedef struct {
=20
 static inline DeviceState *cadence_uart_create(hwaddr addr,
                                         qemu_irq irq,
-                                        CharDriverState *chr)
+                                        Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *s;
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 297e2ebcda..08ae122386 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -5,7 +5,7 @@
 #define TYPE_ESCC "escc"
 #define ESCC_SIZE 4
 MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq irqB,
-              CharDriverState *chrA, CharDriverState *chrB,
+              Chardev *chrA, Chardev *chrB,
               int clock, int it_shift);
=20
 void slavio_serial_ms_kbd_init(hwaddr base, qemu_irq irq,
diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 0ca7c19410..83649324b6 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -17,7 +17,7 @@
=20
 static inline DeviceState *pl011_create(hwaddr addr,
                                         qemu_irq irq,
-                                        CharDriverState *chr)
+                                        Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -34,7 +34,7 @@ static inline DeviceState *pl011_create(hwaddr addr,
=20
 static inline DeviceState *pl011_luminary_create(hwaddr addr,
                                                  qemu_irq irq,
-                                                 CharDriverState *chr)
+                                                 Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *s;
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index c928d7d907..daebb076c2 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -88,11 +88,11 @@ void serial_set_frequency(SerialState *s, uint32_t fr=
equency);
=20
 /* legacy pre qom */
 SerialState *serial_init(int base, qemu_irq irq, int baudbase,
-                         CharDriverState *chr, MemoryRegion *system_io);
+                         Chardev *chr, MemoryRegion *system_io);
 SerialState *serial_mm_init(MemoryRegion *address_space,
                             hwaddr base, int it_shift,
                             qemu_irq irq, int baudbase,
-                            CharDriverState *chr, enum device_endian end=
);
+                            Chardev *chr, enum device_endian end);
=20
 /* serial-isa.c */
 #define TYPE_ISA_SERIAL "isa-serial"
diff --git a/include/hw/char/xilinx_uartlite.h b/include/hw/char/xilinx_u=
artlite.h
index 8b4fc54953..634086b657 100644
--- a/include/hw/char/xilinx_uartlite.h
+++ b/include/hw/char/xilinx_uartlite.h
@@ -17,7 +17,7 @@
=20
 static inline DeviceState *xilinx_uartlite_create(hwaddr addr,
                                         qemu_irq irq,
-                                        CharDriverState *chr)
+                                        Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *s;
diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
index 723a2753c8..8da965addb 100644
--- a/include/hw/cris/etraxfs.h
+++ b/include/hw/cris/etraxfs.h
@@ -48,7 +48,7 @@ etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
=20
 static inline DeviceState *etraxfs_ser_create(hwaddr addr,
                                               qemu_irq irq,
-                                              CharDriverState *chr)
+                                              Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *s;
diff --git a/include/hw/devices.h b/include/hw/devices.h
index c60bcabae3..7475b714de 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -65,6 +65,6 @@ qemu_irq tc6393xb_l3v_get(TC6393xbState *s);
 /* sm501.c */
 void sm501_init(struct MemoryRegion *address_space_mem, uint32_t base,
                 uint32_t local_mem_bytes, qemu_irq irq,
-                CharDriverState *chr);
+                Chardev *chr);
=20
 #endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4b74130559..a0f5133560 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -175,7 +175,7 @@ void parallel_hds_isa_init(ISABus *bus, int n);
=20
 bool parallel_mm_init(MemoryRegion *address_space,
                       hwaddr base, int it_shift, qemu_irq irq,
-                      CharDriverState *chr);
+                      Chardev *chr);
=20
 /* i8259.c */
=20
diff --git a/include/hw/m68k/mcf.h b/include/hw/m68k/mcf.h
index 0f0d2288e6..08d6af8713 100644
--- a/include/hw/m68k/mcf.h
+++ b/include/hw/m68k/mcf.h
@@ -11,10 +11,10 @@ uint64_t mcf_uart_read(void *opaque, hwaddr addr,
                        unsigned size);
 void mcf_uart_write(void *opaque, hwaddr addr,
                     uint64_t val, unsigned size);
-void *mcf_uart_init(qemu_irq irq, CharDriverState *chr);
+void *mcf_uart_init(qemu_irq irq, Chardev *chr);
 void mcf_uart_mm_init(struct MemoryRegion *sysmem,
                       hwaddr base,
-                      qemu_irq irq, CharDriverState *chr);
+                      qemu_irq irq, Chardev *chr);
=20
 /* mcf_intc.c */
 qemu_irq *mcf_intc_init(struct MemoryRegion *sysmem,
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 14f502240e..fc6f673ea0 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -127,7 +127,7 @@ int spapr_vio_send_crq(VIOsPAPRDevice *dev, uint8_t *=
crq);
=20
 VIOsPAPRDevice *vty_lookup(sPAPRMachineState *spapr, target_ulong reg);
 void vty_putchars(VIOsPAPRDevice *sdev, uint8_t *buf, int len);
-void spapr_vty_create(VIOsPAPRBus *bus, CharDriverState *chardev);
+void spapr_vty_create(VIOsPAPRBus *bus, Chardev *chardev);
 void spapr_vlan_create(VIOsPAPRBus *bus, NICInfo *nd);
 void spapr_vscsi_create(VIOsPAPRBus *bus);
=20
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 306bbab088..7ac315331a 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -184,7 +184,7 @@ void qdev_prop_set_uint32(DeviceState *dev, const cha=
r *name, uint32_t value);
 void qdev_prop_set_int32(DeviceState *dev, const char *name, int32_t val=
ue);
 void qdev_prop_set_uint64(DeviceState *dev, const char *name, uint64_t v=
alue);
 void qdev_prop_set_string(DeviceState *dev, const char *name, const char=
 *value);
-void qdev_prop_set_chr(DeviceState *dev, const char *name, CharDriverSta=
te *value);
+void qdev_prop_set_chr(DeviceState *dev, const char *name, Chardev *valu=
e);
 void qdev_prop_set_netdev(DeviceState *dev, const char *name, NetClientS=
tate *value);
 void qdev_prop_set_drive(DeviceState *dev, const char *name,
                          BlockBackend *value, Error **errp);
diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index 070312d921..1e733a9cde 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -42,7 +42,7 @@ void tmu012_init(struct MemoryRegion *sysmem, hwaddr ba=
se,
 #define SH_SERIAL_FEAT_SCIF (1 << 0)
 void sh_serial_init(MemoryRegion *sysmem,
                     hwaddr base, int feat,
-		     uint32_t freq, CharDriverState *chr,
+                    uint32_t freq, Chardev *chr,
 		     qemu_irq eri_source,
 		     qemu_irq rxi_source,
 		     qemu_irq txi_source,
diff --git a/include/hw/sparc/grlib.h b/include/hw/sparc/grlib.h
index afbb9bc07c..61a345c269 100644
--- a/include/hw/sparc/grlib.h
+++ b/include/hw/sparc/grlib.h
@@ -100,7 +100,7 @@ DeviceState *grlib_gptimer_create(hwaddr  base,
=20
 static inline
 DeviceState *grlib_apbuart_create(hwaddr  base,
-                                  CharDriverState    *serial,
+                                  Chardev    *serial,
                                   qemu_irq            irq)
 {
     DeviceState *dev;
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index a8f3afb03b..09c2ce5170 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -37,7 +37,7 @@ int xen_is_pirq_msi(uint32_t msi_data);
=20
 qemu_irq *xen_interrupt_controller_init(void);
=20
-void xenstore_store_pv_console_info(int i, struct CharDriverState *chr);
+void xenstore_store_pv_console_info(int i, struct Chardev *chr);
=20
 void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory);
=20
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 8cc532ec0e..e64b944d7c 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -16,7 +16,7 @@ extern Monitor *cur_mon;
=20
 bool monitor_cur_is_qmp(void);
=20
-void monitor_init(CharDriverState *chr, int flags);
+void monitor_init(Chardev *chr, int flags);
 void monitor_cleanup(void);
=20
 int monitor_suspend(Monitor *mon);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 1b8c30a7a0..3b54289e5a 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -17,7 +17,7 @@ typedef struct BlockBackendRootState BlockBackendRootSt=
ate;
 typedef struct BlockDriverState BlockDriverState;
 typedef struct BusClass BusClass;
 typedef struct BusState BusState;
-typedef struct CharDriverState CharDriverState;
+typedef struct Chardev Chardev;
 typedef struct CompatProperty CompatProperty;
 typedef struct CPUAddressSpace CPUAddressSpace;
 typedef struct CPUState CPUState;
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 5d8ec982a9..029b14c8b6 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -76,9 +76,9 @@ typedef enum {
 } CharDriverFeature;
=20
 /* This is the backend as seen by frontend, the actual backend is
- * CharDriverState */
+ * Chardev */
 typedef struct CharBackend {
-    CharDriverState *chr;
+    Chardev *chr;
     IOEventHandler *chr_event;
     IOCanReadHandler *chr_can_read;
     IOReadHandler *chr_read;
@@ -89,7 +89,7 @@ typedef struct CharBackend {
=20
 typedef struct CharDriver CharDriver;
=20
-struct CharDriverState {
+struct Chardev {
     const CharDriver *driver;
     QemuMutex chr_write_lock;
     CharBackend *be;
@@ -99,7 +99,7 @@ struct CharDriverState {
     int be_open;
     guint fd_in_tag;
     DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
-    QTAILQ_ENTRY(CharDriverState) next;
+    QTAILQ_ENTRY(Chardev) next;
 };
=20
 /**
@@ -107,12 +107,12 @@ struct CharDriverState {
  * @backend: the common backend config
  * @errp: pointer to a NULL-initialized error object
  *
- * Allocate and initialize a new CharDriverState.
+ * Allocate and initialize a new Chardev.
  *
- * Returns: a newly allocated CharDriverState, or NULL on error.
+ * Returns: a newly allocated Chardev, or NULL on error.
  */
-CharDriverState *qemu_chr_alloc(const CharDriver *driver,
-                                ChardevCommon *backend, Error **errp);
+Chardev *qemu_chr_alloc(const CharDriver *driver,
+                        ChardevCommon *backend, Error **errp);
=20
 /**
  * @qemu_chr_new_from_opts:
@@ -123,8 +123,8 @@ CharDriverState *qemu_chr_alloc(const CharDriver *dri=
ver,
  *
  * Returns: a new character backend
  */
-CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
-                                        Error **errp);
+Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
+                                Error **errp);
=20
 /**
  * @qemu_chr_parse_common:
@@ -146,7 +146,7 @@ void qemu_chr_parse_common(QemuOpts *opts, ChardevCom=
mon *backend);
  *
  * Returns: a new character backend
  */
-CharDriverState *qemu_chr_new(const char *label, const char *filename);
+Chardev *qemu_chr_new(const char *label, const char *filename);
=20
=20
 /**
@@ -184,7 +184,7 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Error=
 **errp);
  *
  * Returns: a new character backend
  */
-CharDriverState *qemu_chr_new_noreplay(const char *label, const char *fi=
lename);
+Chardev *qemu_chr_new_noreplay(const char *label, const char *filename);
=20
 /**
  * @qemu_chr_delete:
@@ -192,14 +192,14 @@ CharDriverState *qemu_chr_new_noreplay(const char *=
label, const char *filename);
  * Destroy a character backend and remove it from the list of
  * identified character backends.
  */
-void qemu_chr_delete(CharDriverState *chr);
+void qemu_chr_delete(Chardev *chr);
=20
 /**
  * @qemu_chr_free:
  *
  * Destroy a character backend.
  */
-void qemu_chr_free(CharDriverState *chr);
+void qemu_chr_free(Chardev *chr);
=20
 /**
  * @qemu_chr_fe_set_echo:
@@ -353,7 +353,7 @@ int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds,=
 int num);
  *
  * Returns: the number of bytes the front end can receive via @qemu_chr_=
be_write
  */
-int qemu_chr_be_can_write(CharDriverState *s);
+int qemu_chr_be_can_write(Chardev *s);
=20
 /**
  * @qemu_chr_be_write:
@@ -365,7 +365,7 @@ int qemu_chr_be_can_write(CharDriverState *s);
  * @buf a buffer to receive data from the front end
  * @len the number of bytes to receive from the front end
  */
-void qemu_chr_be_write(CharDriverState *s, uint8_t *buf, int len);
+void qemu_chr_be_write(Chardev *s, uint8_t *buf, int len);
=20
 /**
  * @qemu_chr_be_write_impl:
@@ -375,7 +375,7 @@ void qemu_chr_be_write(CharDriverState *s, uint8_t *b=
uf, int len);
  * @buf a buffer to receive data from the front end
  * @len the number of bytes to receive from the front end
  */
-void qemu_chr_be_write_impl(CharDriverState *s, uint8_t *buf, int len);
+void qemu_chr_be_write_impl(Chardev *s, uint8_t *buf, int len);
=20
 /**
  * @qemu_chr_be_event:
@@ -384,7 +384,7 @@ void qemu_chr_be_write_impl(CharDriverState *s, uint8=
_t *buf, int len);
  *
  * @event the event to send
  */
-void qemu_chr_be_event(CharDriverState *s, int event);
+void qemu_chr_be_event(Chardev *s, int event);
=20
 /**
  * @qemu_chr_fe_init:
@@ -395,7 +395,7 @@ void qemu_chr_be_event(CharDriverState *s, int event)=
;
  *
  * Returns: false on error.
  */
-bool qemu_chr_fe_init(CharBackend *b, CharDriverState *s, Error **errp);
+bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp);
=20
 /**
  * @qemu_chr_fe_get_driver:
@@ -403,7 +403,7 @@ bool qemu_chr_fe_init(CharBackend *b, CharDriverState=
 *s, Error **errp);
  * Returns the driver associated with a CharBackend or NULL if no
  * associated CharDriver.
  */
-CharDriverState *qemu_chr_fe_get_driver(CharBackend *be);
+Chardev *qemu_chr_fe_get_driver(CharBackend *be);
=20
 /**
  * @qemu_chr_fe_deinit:
@@ -448,27 +448,27 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
  */
 void qemu_chr_fe_take_focus(CharBackend *b);
=20
-void qemu_chr_be_generic_open(CharDriverState *s);
+void qemu_chr_be_generic_open(Chardev *s);
 void qemu_chr_fe_accept_input(CharBackend *be);
-int qemu_chr_add_client(CharDriverState *s, int fd);
-CharDriverState *qemu_chr_find(const char *name);
+int qemu_chr_add_client(Chardev *s, int fd);
+Chardev *qemu_chr_find(const char *name);
=20
 /**
  * @qemu_chr_get_kind:
  *
  * Returns the kind of char backend, or -1 if unspecified.
  */
-ChardevBackendKind qemu_chr_get_kind(const CharDriverState *chr);
+ChardevBackendKind qemu_chr_get_kind(const Chardev *chr);
=20
-static inline bool qemu_chr_is_ringbuf(const CharDriverState *chr)
+static inline bool qemu_chr_is_ringbuf(const Chardev *chr)
 {
     return qemu_chr_get_kind(chr) =3D=3D CHARDEV_BACKEND_KIND_RINGBUF ||
         qemu_chr_get_kind(chr) =3D=3D CHARDEV_BACKEND_KIND_MEMORY;
 }
=20
-bool qemu_chr_has_feature(CharDriverState *chr,
+bool qemu_chr_has_feature(Chardev *chr,
                           CharDriverFeature feature);
-void qemu_chr_set_feature(CharDriverState *chr,
+void qemu_chr_set_feature(Chardev *chr,
                           CharDriverFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)=
;
=20
@@ -476,29 +476,29 @@ struct CharDriver {
     const char *alias;
     ChardevBackendKind kind;
     void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp)=
;
-    CharDriverState *(*create)(const CharDriver *driver,
-                               const char *id,
-                               ChardevBackend *backend,
-                               ChardevReturn *ret, bool *be_opened,
-                               Error **errp);
+    Chardev *(*create)(const CharDriver *driver,
+                       const char *id,
+                       ChardevBackend *backend,
+                       ChardevReturn *ret, bool *be_opened,
+                       Error **errp);
     size_t instance_size;
=20
-    int (*chr_write)(struct CharDriverState *s, const uint8_t *buf, int =
len);
-    int (*chr_sync_read)(struct CharDriverState *s,
+    int (*chr_write)(struct Chardev *s, const uint8_t *buf, int len);
+    int (*chr_sync_read)(struct Chardev *s,
                          const uint8_t *buf, int len);
-    GSource *(*chr_add_watch)(struct CharDriverState *s, GIOCondition co=
nd);
-    void (*chr_update_read_handler)(struct CharDriverState *s,
+    GSource *(*chr_add_watch)(struct Chardev *s, GIOCondition cond);
+    void (*chr_update_read_handler)(struct Chardev *s,
                                     GMainContext *context);
-    int (*chr_ioctl)(struct CharDriverState *s, int cmd, void *arg);
-    int (*get_msgfds)(struct CharDriverState *s, int* fds, int num);
-    int (*set_msgfds)(struct CharDriverState *s, int *fds, int num);
-    int (*chr_add_client)(struct CharDriverState *chr, int fd);
-    int (*chr_wait_connected)(struct CharDriverState *chr, Error **errp)=
;
-    void (*chr_free)(struct CharDriverState *chr);
-    void (*chr_disconnect)(struct CharDriverState *chr);
-    void (*chr_accept_input)(struct CharDriverState *chr);
-    void (*chr_set_echo)(struct CharDriverState *chr, bool echo);
-    void (*chr_set_fe_open)(struct CharDriverState *chr, int fe_open);
+    int (*chr_ioctl)(struct Chardev *s, int cmd, void *arg);
+    int (*get_msgfds)(struct Chardev *s, int* fds, int num);
+    int (*set_msgfds)(struct Chardev *s, int *fds, int num);
+    int (*chr_add_client)(struct Chardev *chr, int fd);
+    int (*chr_wait_connected)(struct Chardev *chr, Error **errp);
+    void (*chr_free)(struct Chardev *chr);
+    void (*chr_disconnect)(struct Chardev *chr);
+    void (*chr_accept_input)(struct Chardev *chr);
+    void (*chr_set_echo)(struct Chardev *chr, bool echo);
+    void (*chr_set_fe_open)(struct Chardev *chr, int fe_open);
 };
=20
 void register_char_driver(const CharDriver *driver);
@@ -507,7 +507,7 @@ extern int term_escape_char;
=20
=20
 /* console.c */
-typedef CharDriverState *(VcHandler)(ChardevVC *vc, Error **errp);
+typedef Chardev *(VcHandler)(ChardevVC *vc, Error **errp);
 void register_vc_handler(VcHandler *handler);
=20
 #endif
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index f80d6d28e8..b4f8d33e3f 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -123,9 +123,9 @@ uint64_t blkreplay_next_id(void);
 /* Character device */
=20
 /*! Registers char driver to save it's events */
-void replay_register_char_driver(struct CharDriverState *chr);
+void replay_register_char_driver(struct Chardev *chr);
 /*! Saves write to char device event to the log */
-void replay_chr_be_write(struct CharDriverState *s, uint8_t *buf, int le=
n);
+void replay_chr_be_write(struct Chardev *s, uint8_t *buf, int len);
 /*! Writes char write return value to the replay log. */
 void replay_char_write_event_save(int res, int offset);
 /*! Reads char write return value from the replay log. */
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 66c6f1577e..3d46e329ec 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -197,13 +197,13 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const =
QDict *qdict);
=20
 #define MAX_SERIAL_PORTS 4
=20
-extern CharDriverState *serial_hds[MAX_SERIAL_PORTS];
+extern Chardev *serial_hds[MAX_SERIAL_PORTS];
=20
 /* parallel ports */
=20
 #define MAX_PARALLEL_PORTS 3
=20
-extern CharDriverState *parallel_hds[MAX_PARALLEL_PORTS];
+extern Chardev *parallel_hds[MAX_PARALLEL_PORTS];
=20
 void hmp_usb_add(Monitor *mon, const QDict *qdict);
 void hmp_usb_del(Monitor *mon, const QDict *qdict);
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 42ca0fea8b..6bbb672615 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -60,7 +60,7 @@ typedef struct VirtualVteConsole {
     GtkWidget *box;
     GtkWidget *scrollbar;
     GtkWidget *terminal;
-    CharDriverState *chr;
+    Chardev *chr;
     bool echo;
 } VirtualVteConsole;
 #endif
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index 75e12396bb..52a9f8808b 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -51,7 +51,7 @@ int qemu_spice_migrate_info(const char *hostname, int p=
ort, int tls_port,
 #if SPICE_SERVER_VERSION >=3D 0x000c02
 void qemu_spice_register_ports(void);
 #else
-static inline CharDriverState *qemu_chr_open_spice_port(const char *name=
)
+static inline Chardev *qemu_chr_open_spice_port(const char *name)
 { return NULL; }
 #endif
=20
--=20
2.11.0
