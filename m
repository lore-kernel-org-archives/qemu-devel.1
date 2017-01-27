Received: from eggs.gnu.org ([2001:4830:134:3::10]:33978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rV-0005ex-OQ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rJ-0004HX-0G
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:45 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6rI-0004Gh-77
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:32 -0500
Received: by mail-wm0-x241.google.com with SMTP id d140so58625027wmd.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:41 +0100
Message-Id: <1485524749-118532-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/41] char: rename CharDriverState Chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Pick a uniform chardev type name.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
 hw/lm32/lm32.h                    |   4 +-
 hw/lm32/milkymist-hw.h            |   2 +-
 hw/mips/mips_malta.c              |   4 +-
 hw/misc/ivshmem.c                 |   2 +-
 hw/misc/milkymist-pfpu.c          |   2 +-
 hw/usb/ccid-card-passthru.c       |   2 +-
 hw/usb/dev-serial.c               |   6 +-
 hw/usb/redirect.c                 |   4 +-
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
 monitor.c                         |   4 +-
 net/colo-compare.c                |   4 +-
 net/filter-mirror.c               |   4 +-
 net/slirp.c                       |   2 +-
 net/vhost-user.c                  |  10 +-
 qemu-char.c                       | 839 +++++++++++++++++++-------------------
 qmp.c                             |   2 +-
 qtest.c                           |   2 +-
 replay/replay-char.c              |   8 +-
 spice-qemu-char.c                 |  80 ++--
 stubs/monitor.c                   |   2 +-
 stubs/replay.c                    |   4 +-
 tests/test-char.c                 |  10 +-
 tests/vhost-user-test.c           |   4 +-
 ui/console.c                      |  40 +-
 ui/gtk.c                          |  26 +-
 vl.c                              |  10 +-
 xen-common-stub.c                 |   2 +-
 xen-common.c                      |   4 +-
 80 files changed, 727 insertions(+), 724 deletions(-)

diff --git a/backends/baum.c b/backends/baum.c
index 4b48cf0..23d3c4a 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -85,7 +85,7 @@
 #define BUF_SIZE 256
 
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
 
     brlapi_handle_t *brlapi;
     int brlapi_fd;
@@ -98,7 +98,7 @@ typedef struct {
     uint8_t out_buf_used, out_buf_ptr;
 
     QEMUTimer *cellCount_timer;
-} BaumDriverState;
+} BaumChardev;
 
 /* Let's assume NABCC by default */
 enum way {
@@ -223,7 +223,7 @@ static const uint8_t nabcc_translation[2][256] = {
 };
 
 /* The guest OS has started discussing with us, finish initializing BrlAPI */
-static int baum_deferred_init(BaumDriverState *baum)
+static int baum_deferred_init(BaumChardev *baum)
 {
     int tty = BRLAPI_TTY_DEFAULT;
     QemuConsole *con;
@@ -253,9 +253,9 @@ static int baum_deferred_init(BaumDriverState *baum)
 }
 
 /* The serial port can receive more of our data */
-static void baum_accept_input(struct CharDriverState *chr)
+static void baum_accept_input(struct Chardev *chr)
 {
-    BaumDriverState *baum = (BaumDriverState *)chr;
+    BaumChardev *baum = (BaumChardev *)chr;
     int room, first;
 
     if (!baum->out_buf_used)
@@ -279,9 +279,9 @@ static void baum_accept_input(struct CharDriverState *chr)
 }
 
 /* We want to send a packet */
-static void baum_write_packet(BaumDriverState *baum, const uint8_t *buf, int len)
+static void baum_write_packet(BaumChardev *baum, const uint8_t *buf, int len)
 {
-    CharDriverState *chr = (CharDriverState *)baum;
+    Chardev *chr = (Chardev *)baum;
     uint8_t io_buf[1 + 2 * len], *cur = io_buf;
     int room;
     *cur++ = ESC;
@@ -322,14 +322,14 @@ static void baum_write_packet(BaumDriverState *baum, const uint8_t *buf, int len
 /* Called when the other end seems to have a wrong idea of our display size */
 static void baum_cellCount_timer_cb(void *opaque)
 {
-    BaumDriverState *baum = opaque;
+    BaumChardev *baum = opaque;
     uint8_t cell_count[] = { BAUM_RSP_CellCount, baum->x * baum->y };
     DPRINTF("Timeout waiting for DisplayData, sending cell count\n");
     baum_write_packet(baum, cell_count, sizeof(cell_count));
 }
 
 /* Try to interpret a whole incoming packet */
-static int baum_eat_packet(BaumDriverState *baum, const uint8_t *buf, int len)
+static int baum_eat_packet(BaumChardev *baum, const uint8_t *buf, int len)
 {
     const uint8_t *cur = buf;
     uint8_t req = 0;
@@ -470,9 +470,9 @@ static int baum_eat_packet(BaumDriverState *baum, const uint8_t *buf, int len)
 }
 
 /* The other end is writing some data.  Store it and try to interpret */
-static int baum_write(CharDriverState *chr, const uint8_t *buf, int len)
+static int baum_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    BaumDriverState *baum = (BaumDriverState *)chr;
+    BaumChardev *baum = (BaumChardev *)chr;
     int tocopy, cur, eaten, orig_len = len;
 
     if (!len)
@@ -511,14 +511,16 @@ static int baum_write(CharDriverState *chr, const uint8_t *buf, int len)
 }
 
 /* Send the key code to the other end */
-static void baum_send_key(BaumDriverState *baum, uint8_t type, uint8_t value) {
+static void baum_send_key(BaumChardev *baum, uint8_t type, uint8_t value)
+{
     uint8_t packet[] = { type, value };
     DPRINTF("writing key %x %x\n", type, value);
     baum_write_packet(baum, packet, sizeof(packet));
 }
 
-static void baum_send_key2(BaumDriverState *baum, uint8_t type, uint8_t value,
-                           uint8_t value2) {
+static void baum_send_key2(BaumChardev *baum, uint8_t type, uint8_t value,
+                           uint8_t value2)
+{
     uint8_t packet[] = { type, value, value2 };
     DPRINTF("writing key %x %x\n", type, value);
     baum_write_packet(baum, packet, sizeof(packet));
@@ -527,7 +529,7 @@ static void baum_send_key2(BaumDriverState *baum, uint8_t type, uint8_t value,
 /* We got some data on the BrlAPI socket */
 static void baum_chr_read(void *opaque)
 {
-    BaumDriverState *baum = opaque;
+    BaumChardev *baum = opaque;
     brlapi_keyCode_t code;
     int ret;
     if (!baum->brlapi)
@@ -611,9 +613,9 @@ static void baum_chr_read(void *opaque)
     }
 }
 
-static void baum_free(struct CharDriverState *chr)
+static void baum_free(struct Chardev *chr)
 {
-    BaumDriverState *baum = (BaumDriverState *)chr;
+    BaumChardev *baum = (BaumChardev *)chr;
 
     timer_free(baum->cellCount_timer);
     if (baum->brlapi) {
@@ -622,23 +624,23 @@ static void baum_free(struct CharDriverState *chr)
     }
 }
 
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
     ChardevCommon *common = backend->u.braille.data;
-    BaumDriverState *baum;
-    CharDriverState *chr;
+    BaumChardev *baum;
+    Chardev *chr;
     brlapi_handle_t *handle;
 
     chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
-    baum = (BaumDriverState *)chr;
+    baum = (BaumChardev *)chr;
 
     handle = g_malloc0(brlapi_getHandleSize());
     baum->brlapi = handle;
@@ -666,7 +668,7 @@ fail_handle:
 static void register_types(void)
 {
     static const CharDriver driver = {
-        .instance_size = sizeof(BaumDriverState),
+        .instance_size = sizeof(BaumChardev),
         .kind = CHARDEV_BACKEND_KIND_BRAILLE,
         .create = chr_baum_init,
         .chr_write = baum_write,
diff --git a/backends/msmouse.c b/backends/msmouse.c
index 30087b3..4e474da 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -31,7 +31,7 @@
 #define MSMOUSE_HI2(n) (((n) & 0xc0) >> 6)
 
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
 
     QemuInputHandlerState *hs;
     int axis[INPUT_AXIS__MAX];
@@ -39,11 +39,11 @@ typedef struct {
     bool btnc[INPUT_BUTTON__MAX];
     uint8_t outbuf[32];
     int outlen;
-} MouseState;
+} MouseChardev;
 
-static void msmouse_chr_accept_input(CharDriverState *chr)
+static void msmouse_chr_accept_input(Chardev *chr)
 {
-    MouseState *mouse = (MouseState *)chr;
+    MouseChardev *mouse = (MouseChardev *)chr;
     int len;
 
     len = qemu_chr_be_can_write(chr);
@@ -61,7 +61,7 @@ static void msmouse_chr_accept_input(CharDriverState *chr)
     }
 }
 
-static void msmouse_queue_event(MouseState *mouse)
+static void msmouse_queue_event(MouseChardev *mouse)
 {
     unsigned char bytes[4] = { 0x40, 0x00, 0x00, 0x00 };
     int dx, dy, count = 3;
@@ -98,7 +98,7 @@ static void msmouse_queue_event(MouseState *mouse)
 static void msmouse_input_event(DeviceState *dev, QemuConsole *src,
                                 InputEvent *evt)
 {
-    MouseState *mouse = (MouseState *)dev;
+    MouseChardev *mouse = (MouseChardev *)dev;
     InputMoveEvent *move;
     InputBtnEvent *btn;
 
@@ -122,22 +122,22 @@ static void msmouse_input_event(DeviceState *dev, QemuConsole *src,
 
 static void msmouse_input_sync(DeviceState *dev)
 {
-    MouseState *mouse = (MouseState *)dev;
-    CharDriverState *chr = (CharDriverState *)dev;
+    MouseChardev *mouse = (MouseChardev *)dev;
+    Chardev *chr = (Chardev *)dev;
 
     msmouse_queue_event(mouse);
     msmouse_chr_accept_input(chr);
 }
 
-static int msmouse_chr_write (struct CharDriverState *s, const uint8_t *buf, int len)
+static int msmouse_chr_write(struct Chardev *s, const uint8_t *buf, int len)
 {
     /* Ignore writes to mouse port */
     return len;
 }
 
-static void msmouse_chr_free(struct CharDriverState *chr)
+static void msmouse_chr_free(struct Chardev *chr)
 {
-    MouseState *mouse = (MouseState *)chr;
+    MouseChardev *mouse = (MouseChardev *)chr;
 
     qemu_input_handler_unregister(mouse->hs);
 }
@@ -149,16 +149,16 @@ static QemuInputHandler msmouse_handler = {
     .sync  = msmouse_input_sync,
 };
 
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
     ChardevCommon *common = backend->u.msmouse.data;
-    MouseState *mouse;
-    CharDriverState *chr;
+    MouseChardev *mouse;
+    Chardev *chr;
 
     chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
@@ -166,7 +166,7 @@ static CharDriverState *qemu_chr_open_msmouse(const CharDriver *driver,
     }
     *be_opened = false;
 
-    mouse = (MouseState *)chr;
+    mouse = (MouseChardev *)chr;
     mouse->hs = qemu_input_handler_register((DeviceState *)mouse,
                                             &msmouse_handler);
 
@@ -177,7 +177,7 @@ static CharDriverState *qemu_chr_open_msmouse(const CharDriver *driver,
 static void register_types(void)
 {
     static const CharDriver driver = {
-        .instance_size = sizeof(MouseState),
+        .instance_size = sizeof(MouseChardev),
         .kind = CHARDEV_BACKEND_KIND_MSMOUSE,
         .create = qemu_chr_open_msmouse,
         .chr_write = msmouse_chr_write,
diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index 69c04b1..380b19a 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -86,7 +86,7 @@ static void rng_egd_chr_read(void *opaque, const uint8_t *buf, int size)
 static void rng_egd_opened(RngBackend *b, Error **errp)
 {
     RngEgd *s = RNG_EGD(b);
-    CharDriverState *chr;
+    Chardev *chr;
 
     if (s->chr_name == NULL) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
@@ -125,7 +125,7 @@ static void rng_egd_set_chardev(Object *obj, const char *value, Error **errp)
 static char *rng_egd_get_chardev(Object *obj, Error **errp)
 {
     RngEgd *s = RNG_EGD(obj);
-    CharDriverState *chr = qemu_chr_fe_get_driver(&s->chr);
+    Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
 
     if (chr && chr->label) {
         return g_strdup(chr->label);
diff --git a/backends/testdev.c b/backends/testdev.c
index dfa4fe1..268b380 100644
--- a/backends/testdev.c
+++ b/backends/testdev.c
@@ -30,14 +30,14 @@
 #define BUF_SIZE 32
 
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
 
     uint8_t in_buf[32];
     int in_buf_used;
-} TestdevCharState;
+} TestdevChardev;
 
 /* Try to interpret a whole incoming packet */
-static int testdev_eat_packet(TestdevCharState *testdev)
+static int testdev_eat_packet(TestdevChardev *testdev)
 {
     const uint8_t *cur = testdev->in_buf;
     int len = testdev->in_buf_used;
@@ -78,9 +78,9 @@ static int testdev_eat_packet(TestdevCharState *testdev)
 }
 
 /* The other end is writing some data.  Store it and try to interpret */
-static int testdev_write(CharDriverState *chr, const uint8_t *buf, int len)
+static int testdev_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    TestdevCharState *testdev = (TestdevCharState *)chr;
+    TestdevChardev *testdev = (TestdevChardev *)chr;
     int tocopy, eaten, orig_len = len;
 
     while (len) {
@@ -103,15 +103,15 @@ static int testdev_write(CharDriverState *chr, const uint8_t *buf, int len)
     return orig_len;
 }
 
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
-    TestdevCharState *testdev = g_new0(TestdevCharState, 1);;
-    CharDriverState *chr = (CharDriverState *)testdev;
+    TestdevChardev *testdev = g_new0(TestdevChardev, 1);;
+    Chardev *chr = (Chardev *)testdev;
 
     chr->driver = driver;
 
@@ -121,7 +121,7 @@ static CharDriverState *chr_testdev_init(const CharDriver *driver,
 static void register_types(void)
 {
     static const CharDriver driver = {
-        .instance_size = sizeof(TestdevCharState),
+        .instance_size = sizeof(TestdevChardev),
         .kind = CHARDEV_BACKEND_KIND_TESTDEV,
         .create = chr_testdev_init,
         .chr_write = testdev_write,
diff --git a/gdbstub.c b/gdbstub.c
index 719e413..396f892 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -304,7 +304,7 @@ typedef struct GDBState {
     int running_state;
 #else
     CharBackend chr;
-    CharDriverState *mon_chr;
+    Chardev *mon_chr;
 #endif
     char syscall_buf[256];
     gdb_syscall_complete_cb current_syscall_cb;
@@ -1472,7 +1472,7 @@ void gdb_exit(CPUArchState *env, int code)
   GDBState *s;
   char buf[4];
 #ifndef CONFIG_USER_ONLY
-  CharDriverState *chr;
+  Chardev *chr;
 #endif
 
   s = gdbserver_state;
@@ -1697,7 +1697,7 @@ static void gdb_monitor_output(GDBState *s, const char *msg, int len)
     put_packet(s, buf);
 }
 
-static int gdb_monitor_write(CharDriverState *chr, const uint8_t *buf, int len)
+static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
 {
     const char *p = (const char *)buf;
     int max_sz;
@@ -1728,11 +1728,11 @@ int gdbserver_start(const char *device)
 {
     GDBState *s;
     char gdbstub_device_name[128];
-    CharDriverState *chr = NULL;
-    CharDriverState *mon_chr;
+    Chardev *chr = NULL;
+    Chardev *mon_chr;
     ChardevCommon common = { 0 };
     static const CharDriver driver = {
-        .instance_size = sizeof(CharDriverState),
+        .instance_size = sizeof(Chardev),
         .kind = -1,
         .chr_write = gdb_monitor_write,
     };
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 7bb7be7..2126f73 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -118,7 +118,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
         };
 
         if (i < MAX_SERIAL_PORTS) {
-            CharDriverState *chr;
+            Chardev *chr;
 
             chr = serial_hds[i];
 
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index f23672b..dd1c713 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -107,7 +107,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
         };
 
         if (i < MAX_SERIAL_PORTS) {
-            CharDriverState *chr;
+            Chardev *chr;
 
             chr = serial_hds[i];
 
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index e93532f..76dd8a4 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -187,7 +187,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         if (i < MAX_SERIAL_PORTS) {
-            CharDriverState *chr;
+            Chardev *chr;
 
             chr = serial_hds[i];
 
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index c86cf80..503a3b6 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -786,7 +786,7 @@ static void n8x0_cbus_setup(struct n800_s *s)
 
 static void n8x0_uart_setup(struct n800_s *s)
 {
-    CharDriverState *radio = uart_hci_init();
+    Chardev *radio = uart_hci_init();
 
     qdev_connect_gpio_out(s->mpu->gpio, N8X0_BT_RESET_GPIO,
                     csrhci_pins_get(radio)[csrhci_pin_reset]);
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 6f05c98..cf1b4ba 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -792,7 +792,7 @@ static const MemoryRegionOps omap_sti_fifo_ops = {
 static struct omap_sti_s *omap_sti_init(struct omap_target_agent_s *ta,
                 MemoryRegion *sysmem,
                 hwaddr channel_base, qemu_irq irq, omap_clk clk,
-                CharDriverState *chr)
+                Chardev *chr)
 {
     struct omap_sti_s *s = g_new0(struct omap_sti_s, 1);
 
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index d31b457..cfee392 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -2024,7 +2024,7 @@ static PXA2xxFIrState *pxa2xx_fir_init(MemoryRegion *sysmem,
                                        hwaddr base,
                                        qemu_irq irq, qemu_irq rx_dma,
                                        qemu_irq tx_dma,
-                                       CharDriverState *chr)
+                                       Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *sbd;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6c9e898..1f216cf 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -613,7 +613,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
 }
 
 static void create_uart(const VirtMachineState *vms, qemu_irq *pic, int uart,
-                        MemoryRegion *mem, CharDriverState *chr)
+                        MemoryRegion *mem, Chardev *chr)
 {
     char *nodename;
     hwaddr base = vms->memmap[uart].base;
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index e2c78b8..153ed2f 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -29,7 +29,7 @@
 #include "qapi/error.h"
 
 struct csrhci_s {
-    CharDriverState parent;
+    Chardev parent;
     int enable;
     qemu_irq *pins;
     int pin_state;
@@ -79,7 +79,7 @@ enum {
 
 static inline void csrhci_fifo_wake(struct csrhci_s *s)
 {
-    CharDriverState *chr = (CharDriverState *)s;
+    Chardev *chr = (Chardev *)s;
     CharBackend *be = chr->be;
 
     if (!s->enable || !s->out_len)
@@ -313,7 +313,7 @@ static void csrhci_ready_for_next_inpkt(struct csrhci_s *s)
     s->in_hdr = INT_MAX;
 }
 
-static int csrhci_write(struct CharDriverState *chr,
+static int csrhci_write(struct Chardev *chr,
                 const uint8_t *buf, int len)
 {
     struct csrhci_s *s = (struct csrhci_s *)chr;
@@ -386,7 +386,7 @@ static void csrhci_out_hci_packet_acl(void *opaque,
     csrhci_fifo_wake(s);
 }
 
-static int csrhci_ioctl(struct CharDriverState *chr, int cmd, void *arg)
+static int csrhci_ioctl(struct Chardev *chr, int cmd, void *arg)
 {
     QEMUSerialSetParams *ssp;
     struct csrhci_s *s = (struct csrhci_s *) chr;
@@ -455,14 +455,14 @@ static void csrhci_pins(void *opaque, int line, int level)
     }
 }
 
-qemu_irq *csrhci_pins_get(CharDriverState *chr)
+qemu_irq *csrhci_pins_get(Chardev *chr)
 {
     struct csrhci_s *s = (struct csrhci_s *) chr;
 
     return s->pins;
 }
 
-CharDriverState *uart_hci_init(void)
+Chardev *uart_hci_init(void)
 {
     static const CharDriver hci_driver = {
         .instance_size = sizeof(struct csrhci_s),
@@ -472,7 +472,7 @@ CharDriverState *uart_hci_init(void)
     };
     Error *err = NULL;
     ChardevCommon common = { 0, };
-    CharDriverState *chr = qemu_chr_alloc(&hci_driver, &common, &err);
+    Chardev *chr = qemu_chr_alloc(&hci_driver, &common, &err);
     struct csrhci_s *s = (struct csrhci_s *)chr;
 
     if (err) {
diff --git a/hw/char/escc.c b/hw/char/escc.c
index d6662dc..9228091 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -689,7 +689,7 @@ static const VMStateDescription vmstate_escc = {
 };
 
 MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq irqB,
-              CharDriverState *chrA, CharDriverState *chrB,
+              Chardev *chrA, Chardev *chrB,
               int clock, int it_shift)
 {
     DeviceState *dev;
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 820d1ab..565b27e 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -586,7 +586,7 @@ static const VMStateDescription vmstate_exynos4210_uart = {
 DeviceState *exynos4210_uart_create(hwaddr addr,
                                     int fifo_size,
                                     int channel,
-                                    CharDriverState *chr,
+                                    Chardev *chr,
                                     qemu_irq irq)
 {
     DeviceState  *dev;
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 99545fc..52e67f8 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -170,7 +170,7 @@ static void imx_serial_write(void *opaque, hwaddr offset,
                              uint64_t value, unsigned size)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
-    CharDriverState *chr = qemu_chr_fe_get_driver(&s->chr);
+    Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
     unsigned char ch;
 
     DPRINTF("write(offset=0x%" HWADDR_PRIx ", value = 0x%x) to %s\n",
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index ecaa091..80c380e 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -275,7 +275,7 @@ static void mcf_uart_receive(void *opaque, const uint8_t *buf, int size)
     mcf_uart_push_byte(s, buf[0]);
 }
 
-void *mcf_uart_init(qemu_irq irq, CharDriverState *chr)
+void *mcf_uart_init(qemu_irq irq, Chardev *chr)
 {
     mcf_uart_state *s;
 
@@ -300,7 +300,7 @@ static const MemoryRegionOps mcf_uart_ops = {
 void mcf_uart_mm_init(MemoryRegion *sysmem,
                       hwaddr base,
                       qemu_irq irq,
-                      CharDriverState *chr)
+                      Chardev *chr)
 {
     mcf_uart_state *s;
 
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index 893ab10..31ebb15 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -54,7 +54,7 @@ void omap_uart_reset(struct omap_uart_s *s)
 struct omap_uart_s *omap_uart_init(hwaddr base,
                 qemu_irq irq, omap_clk fclk, omap_clk iclk,
                 qemu_irq txdma, qemu_irq rxdma,
-                const char *label, CharDriverState *chr)
+                const char *label, Chardev *chr)
 {
     struct omap_uart_s *s = g_new0(struct omap_uart_s, 1);
 
@@ -163,7 +163,7 @@ struct omap_uart_s *omap2_uart_init(MemoryRegion *sysmem,
                 struct omap_target_agent_s *ta,
                 qemu_irq irq, omap_clk fclk, omap_clk iclk,
                 qemu_irq txdma, qemu_irq rxdma,
-                const char *label, CharDriverState *chr)
+                const char *label, Chardev *chr)
 {
     hwaddr base = omap_l4_attach(ta, 0, NULL);
     struct omap_uart_s *s = omap_uart_init(base, irq,
@@ -178,7 +178,7 @@ struct omap_uart_s *omap2_uart_init(MemoryRegion *sysmem,
     return s;
 }
 
-void omap_uart_attach(struct omap_uart_s *s, CharDriverState *chr)
+void omap_uart_attach(struct omap_uart_s *s, Chardev *chr)
 {
     /* TODO: Should reuse or destroy current s->serial */
     s->serial = serial_mm_init(get_system_memory(), s->base, 2, s->irq,
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index f2d5666..c71a4a0 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -603,7 +603,7 @@ static const MemoryRegionOps parallel_mm_ops = {
 /* If fd is zero, it means that the parallel device uses the console */
 bool parallel_mm_init(MemoryRegion *address_space,
                       hwaddr base, int it_shift, qemu_irq irq,
-                      CharDriverState *chr)
+                      Chardev *chr)
 {
     ParallelState *s;
 
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 54d3a12..d7c5cc1 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -121,7 +121,7 @@ static void serial_register_types(void)
 
 type_init(serial_register_types)
 
-static void serial_isa_init(ISABus *bus, int index, CharDriverState *chr)
+static void serial_isa_init(ISABus *bus, int index, Chardev *chr)
 {
     DeviceState *dev;
     ISADevice *isadev;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 67b18ed..03d890c 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -937,7 +937,7 @@ const MemoryRegionOps serial_io_ops = {
 };
 
 SerialState *serial_init(int base, qemu_irq irq, int baudbase,
-                         CharDriverState *chr, MemoryRegion *system_io)
+                         Chardev *chr, MemoryRegion *system_io)
 {
     SerialState *s;
 
@@ -993,7 +993,7 @@ static const MemoryRegionOps serial_mm_ops[3] = {
 SerialState *serial_mm_init(MemoryRegion *address_space,
                             hwaddr base, int it_shift,
                             qemu_irq irq, int baudbase,
-                            CharDriverState *chr, enum device_endian end)
+                            Chardev *chr, enum device_endian end)
 {
     SerialState *s;
 
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 9d35564..303eb0a 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -356,7 +356,7 @@ static const MemoryRegionOps sh_serial_ops = {
 
 void sh_serial_init(MemoryRegion *sysmem,
                     hwaddr base, int feat,
-                    uint32_t freq, CharDriverState *chr,
+                    uint32_t freq, Chardev *chr,
                     qemu_irq eri_source,
                     qemu_irq rxi_source,
                     qemu_irq txi_source,
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 7c22b8b..e30c8da 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -141,7 +141,7 @@ static target_ulong h_get_term_char(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     return H_SUCCESS;
 }
 
-void spapr_vty_create(VIOsPAPRBus *bus, CharDriverState *chardev)
+void spapr_vty_create(VIOsPAPRBus *bus, Chardev *chardev)
 {
     DeviceState *dev;
 
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 776205b..798d9b6 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -168,7 +168,7 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
     VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(dev);
     VirtConsole *vcon = VIRTIO_CONSOLE(dev);
     VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(dev);
-    CharDriverState *chr = qemu_chr_fe_get_driver(&vcon->chr);
+    Chardev *chr = qemu_chr_fe_get_driver(&vcon->chr);
 
     if (port->id == 0 && !k->is_console) {
         error_setg(errp, "Port number 0 on virtio-serial devices reserved "
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1b7ea50..94f4d8b 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -179,7 +179,7 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
     Error *local_err = NULL;
     Property *prop = opaque;
     CharBackend *be = qdev_get_prop_ptr(dev, prop);
-    CharDriverState *s;
+    Chardev *s;
     char *str;
 
     if (dev->realized) {
@@ -411,7 +411,7 @@ void qdev_prop_set_drive(DeviceState *dev, const char *name,
 }
 
 void qdev_prop_set_chr(DeviceState *dev, const char *name,
-                       CharDriverState *value)
+                       Chardev *value)
 {
     assert(!value || value->label);
     object_property_set_str(OBJECT(dev),
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 5c666f9..18f27fc 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -85,7 +85,7 @@ struct MilkymistTMU2State {
     SysBusDevice parent_obj;
 
     MemoryRegion regs_region;
-    CharDriverState *chr;
+    Chardev *chr;
     qemu_irq irq;
 
     uint32_t regs[R_MAX];
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 5f71012..040a0b9 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1392,7 +1392,7 @@ static const GraphicHwOps sm501_ops = {
 };
 
 void sm501_init(MemoryRegion *address_space_mem, uint32_t base,
-                uint32_t local_mem_bytes, qemu_irq irq, CharDriverState *chr)
+                uint32_t local_mem_bytes, qemu_irq irq, Chardev *chr)
 {
     SM501State * s;
     DeviceState *dev;
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 9d07b11..166ac93 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -287,7 +287,7 @@ MemoryRegion *isa_address_space_io(ISADevice *dev)
 
 type_init(isabus_register_types)
 
-static void parallel_init(ISABus *bus, int index, CharDriverState *chr)
+static void parallel_init(ISABus *bus, int index, Chardev *chr)
 {
     DeviceState *dev;
     ISADevice *isadev;
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index b1c1a0a..c707d24 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -268,7 +268,7 @@ static void pc87312_realize(DeviceState *dev, Error **errp)
     DeviceState *d;
     ISADevice *isa;
     ISABus *bus;
-    CharDriverState *chr;
+    Chardev *chr;
     DriveInfo *drive;
     char name[5];
     int i;
diff --git a/hw/lm32/lm32.h b/hw/lm32/lm32.h
index db9eb29..d1514a6 100644
--- a/hw/lm32/lm32.h
+++ b/hw/lm32/lm32.h
@@ -16,7 +16,7 @@ static inline DeviceState *lm32_pic_init(qemu_irq cpu_irq)
     return dev;
 }
 
-static inline DeviceState *lm32_juart_init(CharDriverState *chr)
+static inline DeviceState *lm32_juart_init(Chardev *chr)
 {
     DeviceState *dev;
 
@@ -29,7 +29,7 @@ static inline DeviceState *lm32_juart_init(CharDriverState *chr)
 
 static inline DeviceState *lm32_uart_create(hwaddr addr,
                                             qemu_irq irq,
-                                            CharDriverState *chr)
+                                            Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *s;
diff --git a/hw/lm32/milkymist-hw.h b/hw/lm32/milkymist-hw.h
index 4418b44..d3be0cf 100644
--- a/hw/lm32/milkymist-hw.h
+++ b/hw/lm32/milkymist-hw.h
@@ -6,7 +6,7 @@
 
 static inline DeviceState *milkymist_uart_create(hwaddr base,
                                                  qemu_irq irq,
-                                                 CharDriverState *chr)
+                                                 Chardev *chr)
 {
     DeviceState *dev;
 
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index cf48f42..75877de 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -551,10 +551,10 @@ static void malta_fgpa_display_event(void *opaque, int event)
 }
 
 static MaltaFPGAState *malta_fpga_init(MemoryRegion *address_space,
-         hwaddr base, qemu_irq uart_irq, CharDriverState *uart_chr)
+         hwaddr base, qemu_irq uart_irq, Chardev *uart_chr)
 {
     MaltaFPGAState *s;
-    CharDriverState *chr;
+    Chardev *chr;
 
     s = (MaltaFPGAState *)g_malloc0(sizeof(MaltaFPGAState));
 
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index abeaf3d..c836222 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -868,7 +868,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
         s->ivshmem_bar2 = host_memory_backend_get_memory(s->hostmem,
                                                          &error_abort);
     } else {
-        CharDriverState *chr = qemu_chr_fe_get_driver(&s->server_chr);
+        Chardev *chr = qemu_chr_fe_get_driver(&s->server_chr);
         assert(chr);
 
         IVSHMEM_DPRINTF("using shared memory server (socket = %s)\n",
diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 3ca2589..86f5e38 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -125,7 +125,7 @@ struct MilkymistPFPUState {
     SysBusDevice parent_obj;
 
     MemoryRegion regs_region;
-    CharDriverState *chr;
+    Chardev *chr;
     qemu_irq irq;
 
     uint32_t regs[R_MAX];
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 88cb6d8..daab0d5 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -264,7 +264,7 @@ static void ccid_card_vscard_handle_message(PassthruState *card,
 
 static void ccid_card_vscard_drop_connection(PassthruState *card)
 {
-    CharDriverState *chr = qemu_chr_fe_get_driver(&card->cs);
+    Chardev *chr = qemu_chr_fe_get_driver(&card->cs);
 
     qemu_chr_fe_deinit(&card->cs);
     qemu_chr_delete(chr);
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 6066d9b..6d51373 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -483,7 +483,7 @@ static void usb_serial_realize(USBDevice *dev, Error **errp)
 {
     USBSerialState *s = USB_SERIAL_DEV(dev);
     Error *local_err = NULL;
-    CharDriverState *chr = qemu_chr_fe_get_driver(&s->cs);
+    Chardev *chr = qemu_chr_fe_get_driver(&s->cs);
 
     usb_desc_create_serial(dev);
     usb_desc_init(dev);
@@ -512,7 +512,7 @@ static void usb_serial_realize(USBDevice *dev, Error **errp)
 static USBDevice *usb_serial_init(USBBus *bus, const char *filename)
 {
     USBDevice *dev;
-    CharDriverState *cdrv;
+    Chardev *cdrv;
     uint32_t vendorid = 0, productid = 0;
     char label[32];
     static int index;
@@ -564,7 +564,7 @@ static USBDevice *usb_serial_init(USBBus *bus, const char *filename)
 static USBDevice *usb_braille_init(USBBus *bus, const char *unused)
 {
     USBDevice *dev;
-    CharDriverState *cdrv;
+    Chardev *cdrv;
 
     cdrv = qemu_chr_new("braille", "braille");
     if (!cdrv)
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index a657237..3359e6a 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -284,7 +284,7 @@ static gboolean usbredir_write_unblocked(GIOChannel *chan, GIOCondition cond,
 static int usbredir_write(void *priv, uint8_t *data, int count)
 {
     USBRedirDevice *dev = priv;
-    CharDriverState *chr = qemu_chr_fe_get_driver(&dev->cs);
+    Chardev *chr = qemu_chr_fe_get_driver(&dev->cs);
     int r;
 
     if (!chr->be_open) {
@@ -1430,7 +1430,7 @@ static void usbredir_cleanup_device_queues(USBRedirDevice *dev)
 static void usbredir_handle_destroy(USBDevice *udev)
 {
     USBRedirDevice *dev = USB_REDIRECT(udev);
-    CharDriverState *chr = qemu_chr_fe_get_driver(&dev->cs);
+    Chardev *chr = qemu_chr_fe_get_driver(&dev->cs);
 
     qemu_chr_fe_deinit(&dev->cs);
     qemu_chr_delete(chr);
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index 76bb6d4..d9e0801 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -131,7 +131,7 @@ void exynos4210_combiner_get_gpioin(Exynos4210Irq *irqs, DeviceState *dev,
 DeviceState *exynos4210_uart_create(hwaddr addr,
                                     int fifo_size,
                                     int channel,
-                                    CharDriverState *chr,
+                                    Chardev *chr,
                                     qemu_irq irq);
 
 #endif /* EXYNOS4210_H */
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index f25870b..cac1b2b 100644
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
 
 struct omap_mpuio_s;
 qemu_irq *omap_mpuio_in_get(struct omap_mpuio_s *s);
diff --git a/include/hw/bt.h b/include/hw/bt.h
index 2fa22bd..b5e11d4 100644
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
 
 /* bt-l2cap.c */
 struct bt_l2cap_device_s;
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uart.h
index ca75eb5..c836db4 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -51,7 +51,7 @@ typedef struct {
 
 static inline DeviceState *cadence_uart_create(hwaddr addr,
                                         qemu_irq irq,
-                                        CharDriverState *chr)
+                                        Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *s;
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 297e2eb..08ae122 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -5,7 +5,7 @@
 #define TYPE_ESCC "escc"
 #define ESCC_SIZE 4
 MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq irqB,
-              CharDriverState *chrA, CharDriverState *chrB,
+              Chardev *chrA, Chardev *chrB,
               int clock, int it_shift);
 
 void slavio_serial_ms_kbd_init(hwaddr base, qemu_irq irq,
diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 0ca7c19..8364932 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -17,7 +17,7 @@
 
 static inline DeviceState *pl011_create(hwaddr addr,
                                         qemu_irq irq,
-                                        CharDriverState *chr)
+                                        Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -34,7 +34,7 @@ static inline DeviceState *pl011_create(hwaddr addr,
 
 static inline DeviceState *pl011_luminary_create(hwaddr addr,
                                                  qemu_irq irq,
-                                                 CharDriverState *chr)
+                                                 Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *s;
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index c928d7d..daebb07 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -88,11 +88,11 @@ void serial_set_frequency(SerialState *s, uint32_t frequency);
 
 /* legacy pre qom */
 SerialState *serial_init(int base, qemu_irq irq, int baudbase,
-                         CharDriverState *chr, MemoryRegion *system_io);
+                         Chardev *chr, MemoryRegion *system_io);
 SerialState *serial_mm_init(MemoryRegion *address_space,
                             hwaddr base, int it_shift,
                             qemu_irq irq, int baudbase,
-                            CharDriverState *chr, enum device_endian end);
+                            Chardev *chr, enum device_endian end);
 
 /* serial-isa.c */
 #define TYPE_ISA_SERIAL "isa-serial"
diff --git a/include/hw/char/xilinx_uartlite.h b/include/hw/char/xilinx_uartlite.h
index 8b4fc54..634086b 100644
--- a/include/hw/char/xilinx_uartlite.h
+++ b/include/hw/char/xilinx_uartlite.h
@@ -17,7 +17,7 @@
 
 static inline DeviceState *xilinx_uartlite_create(hwaddr addr,
                                         qemu_irq irq,
-                                        CharDriverState *chr)
+                                        Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *s;
diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
index 723a275..8da965a 100644
--- a/include/hw/cris/etraxfs.h
+++ b/include/hw/cris/etraxfs.h
@@ -48,7 +48,7 @@ etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
 
 static inline DeviceState *etraxfs_ser_create(hwaddr addr,
                                               qemu_irq irq,
-                                              CharDriverState *chr)
+                                              Chardev *chr)
 {
     DeviceState *dev;
     SysBusDevice *s;
diff --git a/include/hw/devices.h b/include/hw/devices.h
index c60bcab..7475b71 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -65,6 +65,6 @@ qemu_irq tc6393xb_l3v_get(TC6393xbState *s);
 /* sm501.c */
 void sm501_init(struct MemoryRegion *address_space_mem, uint32_t base,
                 uint32_t local_mem_bytes, qemu_irq irq,
-                CharDriverState *chr);
+                Chardev *chr);
 
 #endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e34ab30..c016059 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -181,7 +181,7 @@ void parallel_hds_isa_init(ISABus *bus, int n);
 
 bool parallel_mm_init(MemoryRegion *address_space,
                       hwaddr base, int it_shift, qemu_irq irq,
-                      CharDriverState *chr);
+                      Chardev *chr);
 
 /* i8259.c */
 
diff --git a/include/hw/m68k/mcf.h b/include/hw/m68k/mcf.h
index bf43998..9a0bcfa 100644
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
 
 /* mcf_intc.c */
 qemu_irq *mcf_intc_init(struct MemoryRegion *sysmem,
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 14f5022..fc6f673 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -127,7 +127,7 @@ int spapr_vio_send_crq(VIOsPAPRDevice *dev, uint8_t *crq);
 
 VIOsPAPRDevice *vty_lookup(sPAPRMachineState *spapr, target_ulong reg);
 void vty_putchars(VIOsPAPRDevice *sdev, uint8_t *buf, int len);
-void spapr_vty_create(VIOsPAPRBus *bus, CharDriverState *chardev);
+void spapr_vty_create(VIOsPAPRBus *bus, Chardev *chardev);
 void spapr_vlan_create(VIOsPAPRBus *bus, NICInfo *nd);
 void spapr_vscsi_create(VIOsPAPRBus *bus);
 
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 306bbab..7ac3153 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -184,7 +184,7 @@ void qdev_prop_set_uint32(DeviceState *dev, const char *name, uint32_t value);
 void qdev_prop_set_int32(DeviceState *dev, const char *name, int32_t value);
 void qdev_prop_set_uint64(DeviceState *dev, const char *name, uint64_t value);
 void qdev_prop_set_string(DeviceState *dev, const char *name, const char *value);
-void qdev_prop_set_chr(DeviceState *dev, const char *name, CharDriverState *value);
+void qdev_prop_set_chr(DeviceState *dev, const char *name, Chardev *value);
 void qdev_prop_set_netdev(DeviceState *dev, const char *name, NetClientState *value);
 void qdev_prop_set_drive(DeviceState *dev, const char *name,
                          BlockBackend *value, Error **errp);
diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index e59b9e7..767a2df 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -42,7 +42,7 @@ void tmu012_init(struct MemoryRegion *sysmem, hwaddr base,
 #define SH_SERIAL_FEAT_SCIF (1 << 0)
 void sh_serial_init(MemoryRegion *sysmem,
                     hwaddr base, int feat,
-		     uint32_t freq, CharDriverState *chr,
+                    uint32_t freq, Chardev *chr,
 		     qemu_irq eri_source,
 		     qemu_irq rxi_source,
 		     qemu_irq txi_source,
diff --git a/include/hw/sparc/grlib.h b/include/hw/sparc/grlib.h
index afbb9bc..61a345c 100644
--- a/include/hw/sparc/grlib.h
+++ b/include/hw/sparc/grlib.h
@@ -100,7 +100,7 @@ DeviceState *grlib_gptimer_create(hwaddr  base,
 
 static inline
 DeviceState *grlib_apbuart_create(hwaddr  base,
-                                  CharDriverState    *serial,
+                                  Chardev    *serial,
                                   qemu_irq            irq)
 {
     DeviceState *dev;
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index a8f3afb..09c2ce5 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -37,7 +37,7 @@ int xen_is_pirq_msi(uint32_t msi_data);
 
 qemu_irq *xen_interrupt_controller_init(void);
 
-void xenstore_store_pv_console_info(int i, struct CharDriverState *chr);
+void xenstore_store_pv_console_info(int i, struct Chardev *chr);
 
 void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory);
 
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 8cc532e..e64b944 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -16,7 +16,7 @@ extern Monitor *cur_mon;
 
 bool monitor_cur_is_qmp(void);
 
-void monitor_init(CharDriverState *chr, int flags);
+void monitor_init(Chardev *chr, int flags);
 void monitor_cleanup(void);
 
 int monitor_suspend(Monitor *mon);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 9a8bcbd..e95f28c 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -17,7 +17,7 @@ typedef struct BlockBackendRootState BlockBackendRootState;
 typedef struct BlockDriverState BlockDriverState;
 typedef struct BusClass BusClass;
 typedef struct BusState BusState;
-typedef struct CharDriverState CharDriverState;
+typedef struct Chardev Chardev;
 typedef struct CompatProperty CompatProperty;
 typedef struct CPUAddressSpace CPUAddressSpace;
 typedef struct CPUState CPUState;
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 8bb94e5..3a82d80 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -76,9 +76,9 @@ typedef enum {
 } CharDriverFeature;
 
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
 
 typedef struct CharDriver CharDriver;
 
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
 
 /**
  * @qemu_chr_new_from_opts:
@@ -123,8 +123,8 @@ CharDriverState *qemu_chr_alloc(const CharDriver *driver,
  *
  * Returns: a new character backend
  */
-CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
-                                        Error **errp);
+Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
+                                Error **errp);
 
 /**
  * @qemu_chr_parse_common:
@@ -146,7 +146,7 @@ void qemu_chr_parse_common(QemuOpts *opts, ChardevCommon *backend);
  *
  * Returns: a new character backend
  */
-CharDriverState *qemu_chr_new(const char *label, const char *filename);
+Chardev *qemu_chr_new(const char *label, const char *filename);
 
 
 /**
@@ -184,7 +184,7 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp);
  *
  * Returns: a new character backend
  */
-CharDriverState *qemu_chr_new_noreplay(const char *label, const char *filename);
+Chardev *qemu_chr_new_noreplay(const char *label, const char *filename);
 
 /**
  * @qemu_chr_delete:
@@ -192,14 +192,14 @@ CharDriverState *qemu_chr_new_noreplay(const char *label, const char *filename);
  * Destroy a character backend and remove it from the list of
  * identified character backends.
  */
-void qemu_chr_delete(CharDriverState *chr);
+void qemu_chr_delete(Chardev *chr);
 
 /**
  * @qemu_chr_free:
  *
  * Destroy a character backend.
  */
-void qemu_chr_free(CharDriverState *chr);
+void qemu_chr_free(Chardev *chr);
 
 /**
  * @qemu_chr_fe_set_echo:
@@ -355,7 +355,7 @@ int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num);
  *
  * Returns: the number of bytes the front end can receive via @qemu_chr_be_write
  */
-int qemu_chr_be_can_write(CharDriverState *s);
+int qemu_chr_be_can_write(Chardev *s);
 
 /**
  * @qemu_chr_be_write:
@@ -367,7 +367,7 @@ int qemu_chr_be_can_write(CharDriverState *s);
  * @buf a buffer to receive data from the front end
  * @len the number of bytes to receive from the front end
  */
-void qemu_chr_be_write(CharDriverState *s, uint8_t *buf, int len);
+void qemu_chr_be_write(Chardev *s, uint8_t *buf, int len);
 
 /**
  * @qemu_chr_be_write_impl:
@@ -377,7 +377,7 @@ void qemu_chr_be_write(CharDriverState *s, uint8_t *buf, int len);
  * @buf a buffer to receive data from the front end
  * @len the number of bytes to receive from the front end
  */
-void qemu_chr_be_write_impl(CharDriverState *s, uint8_t *buf, int len);
+void qemu_chr_be_write_impl(Chardev *s, uint8_t *buf, int len);
 
 /**
  * @qemu_chr_be_event:
@@ -386,7 +386,7 @@ void qemu_chr_be_write_impl(CharDriverState *s, uint8_t *buf, int len);
  *
  * @event the event to send
  */
-void qemu_chr_be_event(CharDriverState *s, int event);
+void qemu_chr_be_event(Chardev *s, int event);
 
 /**
  * @qemu_chr_fe_init:
@@ -397,7 +397,7 @@ void qemu_chr_be_event(CharDriverState *s, int event);
  *
  * Returns: false on error.
  */
-bool qemu_chr_fe_init(CharBackend *b, CharDriverState *s, Error **errp);
+bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp);
 
 /**
  * @qemu_chr_fe_get_driver:
@@ -405,7 +405,7 @@ bool qemu_chr_fe_init(CharBackend *b, CharDriverState *s, Error **errp);
  * Returns the driver associated with a CharBackend or NULL if no
  * associated CharDriver.
  */
-CharDriverState *qemu_chr_fe_get_driver(CharBackend *be);
+Chardev *qemu_chr_fe_get_driver(CharBackend *be);
 
 /**
  * @qemu_chr_fe_deinit:
@@ -450,27 +450,27 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
  */
 void qemu_chr_fe_take_focus(CharBackend *b);
 
-void qemu_chr_be_generic_open(CharDriverState *s);
+void qemu_chr_be_generic_open(Chardev *s);
 void qemu_chr_fe_accept_input(CharBackend *be);
-int qemu_chr_add_client(CharDriverState *s, int fd);
-CharDriverState *qemu_chr_find(const char *name);
+int qemu_chr_add_client(Chardev *s, int fd);
+Chardev *qemu_chr_find(const char *name);
 
 /**
  * @qemu_chr_get_kind:
  *
  * Returns the kind of char backend, or -1 if unspecified.
  */
-ChardevBackendKind qemu_chr_get_kind(const CharDriverState *chr);
+ChardevBackendKind qemu_chr_get_kind(const Chardev *chr);
 
-static inline bool qemu_chr_is_ringbuf(const CharDriverState *chr)
+static inline bool qemu_chr_is_ringbuf(const Chardev *chr)
 {
     return qemu_chr_get_kind(chr) == CHARDEV_BACKEND_KIND_RINGBUF ||
         qemu_chr_get_kind(chr) == CHARDEV_BACKEND_KIND_MEMORY;
 }
 
-bool qemu_chr_has_feature(CharDriverState *chr,
+bool qemu_chr_has_feature(Chardev *chr,
                           CharDriverFeature feature);
-void qemu_chr_set_feature(CharDriverState *chr,
+void qemu_chr_set_feature(Chardev *chr,
                           CharDriverFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename);
 
@@ -478,29 +478,29 @@ struct CharDriver {
     ChardevBackendKind kind;
     const char *alias;
     void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
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
 
-    int (*chr_write)(struct CharDriverState *s, const uint8_t *buf, int len);
-    int (*chr_sync_read)(struct CharDriverState *s,
+    int (*chr_write)(struct Chardev *s, const uint8_t *buf, int len);
+    int (*chr_sync_read)(struct Chardev *s,
                          const uint8_t *buf, int len);
-    GSource *(*chr_add_watch)(struct CharDriverState *s, GIOCondition cond);
-    void (*chr_update_read_handler)(struct CharDriverState *s,
+    GSource *(*chr_add_watch)(struct Chardev *s, GIOCondition cond);
+    void (*chr_update_read_handler)(struct Chardev *s,
                                     GMainContext *context);
-    int (*chr_ioctl)(struct CharDriverState *s, int cmd, void *arg);
-    int (*get_msgfds)(struct CharDriverState *s, int* fds, int num);
-    int (*set_msgfds)(struct CharDriverState *s, int *fds, int num);
-    int (*chr_add_client)(struct CharDriverState *chr, int fd);
-    int (*chr_wait_connected)(struct CharDriverState *chr, Error **errp);
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
 
 void register_char_driver(const CharDriver *driver);
@@ -509,7 +509,7 @@ extern int term_escape_char;
 
 
 /* console.c */
-typedef CharDriverState *(VcHandler)(ChardevVC *vc, Error **errp);
+typedef Chardev *(VcHandler)(ChardevVC *vc, Error **errp);
 void register_vc_handler(VcHandler *handler);
 
 #endif
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 740b425..7aad20b 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -128,9 +128,9 @@ uint64_t blkreplay_next_id(void);
 /* Character device */
 
 /*! Registers char driver to save it's events */
-void replay_register_char_driver(struct CharDriverState *chr);
+void replay_register_char_driver(struct Chardev *chr);
 /*! Saves write to char device event to the log */
-void replay_chr_be_write(struct CharDriverState *s, uint8_t *buf, int len);
+void replay_chr_be_write(struct Chardev *s, uint8_t *buf, int len);
 /*! Writes char write return value to the replay log. */
 void replay_char_write_event_save(int res, int offset);
 /*! Reads char write return value from the replay log. */
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 4ef2eb0..4d50694 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -190,13 +190,13 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
 
 #define MAX_SERIAL_PORTS 4
 
-extern CharDriverState *serial_hds[MAX_SERIAL_PORTS];
+extern Chardev *serial_hds[MAX_SERIAL_PORTS];
 
 /* parallel ports */
 
 #define MAX_PARALLEL_PORTS 3
 
-extern CharDriverState *parallel_hds[MAX_PARALLEL_PORTS];
+extern Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 
 void hmp_usb_add(Monitor *mon, const QDict *qdict);
 void hmp_usb_del(Monitor *mon, const QDict *qdict);
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index b3b5005..47ffddb 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -64,7 +64,7 @@ typedef struct VirtualVteConsole {
     GtkWidget *box;
     GtkWidget *scrollbar;
     GtkWidget *terminal;
-    CharDriverState *chr;
+    Chardev *chr;
     bool echo;
 } VirtualVteConsole;
 #endif
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index 75e1239..52a9f88 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -51,7 +51,7 @@ int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
 #if SPICE_SERVER_VERSION >= 0x000c02
 void qemu_spice_register_ports(void);
 #else
-static inline CharDriverState *qemu_chr_open_spice_port(const char *name)
+static inline Chardev *qemu_chr_open_spice_port(const char *name)
 { return NULL; }
 #endif
 
diff --git a/monitor.c b/monitor.c
index 24add02..065f659 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3195,7 +3195,7 @@ static void ringbuf_completion(ReadLineState *rs, const char *str)
         ChardevInfo *chr_info = list->value;
 
         if (!strncmp(chr_info->label, str, len)) {
-            CharDriverState *chr = qemu_chr_find(chr_info->label);
+            Chardev *chr = qemu_chr_find(chr_info->label);
             if (chr && qemu_chr_is_ringbuf(chr)) {
                 readline_add_completion(rs, chr_info->label);
             }
@@ -3985,7 +3985,7 @@ static void __attribute__((constructor)) monitor_lock_init(void)
     qemu_mutex_init(&monitor_lock);
 }
 
-void monitor_init(CharDriverState *chr, int flags)
+void monitor_init(Chardev *chr, int flags)
 {
     static int is_first_init = 1;
     Monitor *mon;
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 9bfc736..4962976 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -564,7 +564,7 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
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
     CompareState *s = COLO_COMPARE(uc);
-    CharDriverState *chr;
+    Chardev *chr;
     char thread_name[64];
     static int compare_id;
 
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index b7d6456..aa0aa98 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -191,7 +191,7 @@ static void filter_redirector_cleanup(NetFilterState *nf)
 static void filter_mirror_setup(NetFilterState *nf, Error **errp)
 {
     MirrorState *s = FILTER_MIRROR(nf);
-    CharDriverState *chr;
+    Chardev *chr;
 
     if (!s->outdev) {
         error_setg(errp, "filter mirror needs 'outdev' "
@@ -220,7 +220,7 @@ static void redirector_rs_finalize(SocketReadState *rs)
 static void filter_redirector_setup(NetFilterState *nf, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(nf);
-    CharDriverState *chr;
+    Chardev *chr;
 
     if (!s->indev && !s->outdev) {
         error_setg(errp, "filter redirector needs 'indev' or "
diff --git a/net/slirp.c b/net/slirp.c
index bcd1c5f..f97ec23 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -748,7 +748,7 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str,
         }
     } else {
         Error *err = NULL;
-        CharDriverState *chr = qemu_chr_new(buf, p);
+        Chardev *chr = qemu_chr_new(buf, p);
 
         if (!chr) {
             error_report("could not open guest forwarding device '%s'", buf);
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 7aff77e..b0f0ab6 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -195,7 +195,7 @@ static void net_vhost_user_event(void *opaque, int event)
     const char *name = opaque;
     NetClientState *ncs[MAX_QUEUE_NUM];
     VhostUserState *s;
-    CharDriverState *chr;
+    Chardev *chr;
     Error *err = NULL;
     int queues;
 
@@ -232,7 +232,7 @@ static void net_vhost_user_event(void *opaque, int event)
 }
 
 static int net_vhost_user_init(NetClientState *peer, const char *device,
-                               const char *name, CharDriverState *chr,
+                               const char *name, Chardev *chr,
                                int queues)
 {
     Error *err = NULL;
@@ -274,10 +274,10 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
     return 0;
 }
 
-static CharDriverState *net_vhost_claim_chardev(
+static Chardev *net_vhost_claim_chardev(
     const NetdevVhostUserOptions *opts, Error **errp)
 {
-    CharDriverState *chr = qemu_chr_find(opts->chardev);
+    Chardev *chr = qemu_chr_find(opts->chardev);
 
     if (chr == NULL) {
         error_setg(errp, "chardev \"%s\" not found", opts->chardev);
@@ -324,7 +324,7 @@ int net_init_vhost_user(const Netdev *netdev, const char *name,
 {
     int queues;
     const NetdevVhostUserOptions *vhost_user_opts;
-    CharDriverState *chr;
+    Chardev *chr;
 
     assert(netdev->type == NET_CLIENT_DRIVER_VHOST_USER);
     vhost_user_opts = &netdev->u.vhost_user;
diff --git a/qemu-char.c b/qemu-char.c
index dfd1b4c..f828e61 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -89,7 +89,7 @@
 #define READ_RETRIES 10
 #define TCP_MAX_FDS 16
 
-typedef struct MuxDriver MuxDriver;
+typedef struct MuxChardev MuxChardev;
 
 /***********************************************************/
 /* Socket address helpers */
@@ -157,19 +157,19 @@ static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss_len,
 /***********************************************************/
 /* character device */
 
-static QTAILQ_HEAD(CharDriverStateHead, CharDriverState) chardevs =
+static QTAILQ_HEAD(ChardevHead, Chardev) chardevs =
     QTAILQ_HEAD_INITIALIZER(chardevs);
 
-static void qemu_chr_free_common(CharDriverState *chr);
+static void qemu_chr_free_common(Chardev *chr);
 
-CharDriverState *qemu_chr_alloc(const CharDriver *driver,
+Chardev *qemu_chr_alloc(const CharDriver *driver,
                                 ChardevCommon *backend, Error **errp)
 {
-    CharDriverState *chr;
+    Chardev *chr;
 
     assert(driver);
     assert(driver->chr_write);
-    assert(driver->instance_size >= sizeof(CharDriverState));
+    assert(driver->instance_size >= sizeof(Chardev));
 
     chr = g_malloc0(driver->instance_size);
     qemu_mutex_init(&chr->chr_write_lock);
@@ -197,7 +197,7 @@ CharDriverState *qemu_chr_alloc(const CharDriver *driver,
     return chr;
 }
 
-void qemu_chr_be_event(CharDriverState *s, int event)
+void qemu_chr_be_event(Chardev *s, int event)
 {
     CharBackend *be = s->be;
 
@@ -218,7 +218,7 @@ void qemu_chr_be_event(CharDriverState *s, int event)
     be->chr_event(be->opaque, event);
 }
 
-void qemu_chr_be_generic_open(CharDriverState *s)
+void qemu_chr_be_generic_open(Chardev *s)
 {
     qemu_chr_be_event(s, CHR_EVENT_OPENED);
 }
@@ -226,7 +226,7 @@ void qemu_chr_be_generic_open(CharDriverState *s)
 
 /* Not reporting errors from writing to logfile, as logs are
  * defined to be "best effort" only */
-static void qemu_chr_fe_write_log(CharDriverState *s,
+static void qemu_chr_fe_write_log(Chardev *s,
                                   const uint8_t *buf, size_t len)
 {
     size_t done = 0;
@@ -251,7 +251,8 @@ static void qemu_chr_fe_write_log(CharDriverState *s,
     }
 }
 
-static int qemu_chr_fe_write_buffer(CharDriverState *s, const uint8_t *buf, int len, int *offset)
+static int qemu_chr_fe_write_buffer(Chardev *s,
+                                    const uint8_t *buf, int len, int *offset)
 {
     int res = 0;
     *offset = 0;
@@ -279,14 +280,14 @@ static int qemu_chr_fe_write_buffer(CharDriverState *s, const uint8_t *buf, int
     return res;
 }
 
-static bool qemu_chr_replay(CharDriverState *chr)
+static bool qemu_chr_replay(Chardev *chr)
 {
     return qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
 }
 
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
 {
-    CharDriverState *s = be->chr;
+    Chardev *s = be->chr;
     int ret;
 
     if (!s) {
@@ -317,7 +318,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
     return ret;
 }
 
-static int qemu_chr_write_all(CharDriverState *s, const uint8_t *buf, int len)
+static int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len)
 {
     int offset;
     int res;
@@ -343,7 +344,7 @@ static int qemu_chr_write_all(CharDriverState *s, const uint8_t *buf, int len)
 
 int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
 {
-    CharDriverState *s = be->chr;
+    Chardev *s = be->chr;
 
     if (!s) {
         return 0;
@@ -354,7 +355,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
 
 int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
 {
-    CharDriverState *s = be->chr;
+    Chardev *s = be->chr;
     int offset = 0, counter = 10;
     int res;
 
@@ -400,7 +401,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
 
 int qemu_chr_fe_ioctl(CharBackend *be, int cmd, void *arg)
 {
-    CharDriverState *s = be->chr;
+    Chardev *s = be->chr;
     int res;
 
     if (!s || !s->driver->chr_ioctl || qemu_chr_replay(s)) {
@@ -412,7 +413,7 @@ int qemu_chr_fe_ioctl(CharBackend *be, int cmd, void *arg)
     return res;
 }
 
-int qemu_chr_be_can_write(CharDriverState *s)
+int qemu_chr_be_can_write(Chardev *s)
 {
     CharBackend *be = s->be;
 
@@ -423,7 +424,7 @@ int qemu_chr_be_can_write(CharDriverState *s)
     return be->chr_can_read(be->opaque);
 }
 
-void qemu_chr_be_write_impl(CharDriverState *s, uint8_t *buf, int len)
+void qemu_chr_be_write_impl(Chardev *s, uint8_t *buf, int len)
 {
     CharBackend *be = s->be;
 
@@ -432,7 +433,7 @@ void qemu_chr_be_write_impl(CharDriverState *s, uint8_t *buf, int len)
     }
 }
 
-void qemu_chr_be_write(CharDriverState *s, uint8_t *buf, int len)
+void qemu_chr_be_write(Chardev *s, uint8_t *buf, int len)
 {
     if (qemu_chr_replay(s)) {
         if (replay_mode == REPLAY_MODE_PLAY) {
@@ -446,7 +447,7 @@ void qemu_chr_be_write(CharDriverState *s, uint8_t *buf, int len)
 
 int qemu_chr_fe_get_msgfd(CharBackend *be)
 {
-    CharDriverState *s = be->chr;
+    Chardev *s = be->chr;
     int fd;
     int res = (qemu_chr_fe_get_msgfds(be, &fd, 1) == 1) ? fd : -1;
     if (s && qemu_chr_replay(s)) {
@@ -459,7 +460,7 @@ int qemu_chr_fe_get_msgfd(CharBackend *be)
 
 int qemu_chr_fe_get_msgfds(CharBackend *be, int *fds, int len)
 {
-    CharDriverState *s = be->chr;
+    Chardev *s = be->chr;
 
     if (!s) {
         return -1;
@@ -470,7 +471,7 @@ int qemu_chr_fe_get_msgfds(CharBackend *be, int *fds, int len)
 
 int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num)
 {
-    CharDriverState *s = be->chr;
+    Chardev *s = be->chr;
 
     if (!s) {
         return -1;
@@ -479,14 +480,14 @@ int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num)
     return s->driver->set_msgfds ? s->driver->set_msgfds(s, fds, num) : -1;
 }
 
-int qemu_chr_add_client(CharDriverState *s, int fd)
+int qemu_chr_add_client(Chardev *s, int fd)
 {
     return s->driver->chr_add_client ? s->driver->chr_add_client(s, fd) : -1;
 }
 
 void qemu_chr_fe_accept_input(CharBackend *be)
 {
-    CharDriverState *s = be->chr;
+    Chardev *s = be->chr;
 
     if (!s) {
         return;
@@ -510,23 +511,23 @@ void qemu_chr_fe_printf(CharBackend *be, const char *fmt, ...)
     va_end(ap);
 }
 
-static void remove_fd_in_watch(CharDriverState *chr);
-static void mux_chr_set_handlers(CharDriverState *chr, GMainContext *context);
-static void mux_set_focus(CharDriverState *chr, int focus);
+static void remove_fd_in_watch(Chardev *chr);
+static void mux_chr_set_handlers(Chardev *chr, GMainContext *context);
+static void mux_set_focus(Chardev *chr, int focus);
 
-static int null_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
+static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     return len;
 }
 
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
     ChardevCommon *common = backend->u.null.data;
 
     chr = qemu_chr_alloc(driver, common, errp);
@@ -538,7 +539,7 @@ static CharDriverState *qemu_chr_open_null(const CharDriver *driver,
 }
 
 static const CharDriver null_driver = {
-    .instance_size = sizeof(CharDriverState),
+    .instance_size = sizeof(Chardev),
     .kind = CHARDEV_BACKEND_KIND_NULL,
     .create = qemu_chr_open_null,
     .chr_write = null_chr_write,
@@ -548,8 +549,8 @@ static const CharDriver null_driver = {
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
@@ -564,15 +565,15 @@ struct MuxDriver {
     int cons[MAX_MUX];
     int timestamps;
 
-    /* Protected by the CharDriverState chr_write_lock.  */
+    /* Protected by the Chardev chr_write_lock.  */
     int linestart;
     int64_t timestamps_start;
 };
 
 /* Called with chr_write_lock held.  */
-static int mux_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
+static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    MuxDriver *d = (MuxDriver *)chr;
+    MuxChardev *d = (MuxChardev *)chr;
     int ret;
     if (!d->timestamps) {
         ret = qemu_chr_fe_write(&d->chr, buf, len);
@@ -624,7 +625,7 @@ static const char * const mux_help[] = {
 };
 
 int term_escape_char = 0x01; /* ctrl-a is used for escape */
-static void mux_print_help(CharDriverState *chr)
+static void mux_print_help(Chardev *chr)
 {
     int i, j;
     char ebuf[15] = "Escape-Char";
@@ -651,7 +652,7 @@ static void mux_print_help(CharDriverState *chr)
     }
 }
 
-static void mux_chr_send_event(MuxDriver *d, int mux_nr, int event)
+static void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
 {
     CharBackend *be = d->backends[mux_nr];
 
@@ -660,7 +661,7 @@ static void mux_chr_send_event(MuxDriver *d, int mux_nr, int event)
     }
 }
 
-static int mux_proc_byte(CharDriverState *chr, MuxDriver *d, int ch)
+static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
 {
     if (d->term_got_escape) {
         d->term_got_escape = 0;
@@ -704,9 +705,9 @@ static int mux_proc_byte(CharDriverState *chr, MuxDriver *d, int ch)
     return 0;
 }
 
-static void mux_chr_accept_input(CharDriverState *chr)
+static void mux_chr_accept_input(Chardev *chr)
 {
-    MuxDriver *d = (MuxDriver *)chr;
+    MuxChardev *d = (MuxChardev *)chr;
     int m = d->focus;
     CharBackend *be = d->backends[m];
 
@@ -719,7 +720,7 @@ static void mux_chr_accept_input(CharDriverState *chr)
 
 static int mux_chr_can_read(void *opaque)
 {
-    MuxDriver *d = opaque;
+    MuxChardev *d = opaque;
     int m = d->focus;
     CharBackend *be = d->backends[m];
 
@@ -736,8 +737,8 @@ static int mux_chr_can_read(void *opaque)
 
 static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
 {
-    CharDriverState *chr = opaque;
-    MuxDriver *d = opaque;
+    Chardev *chr = opaque;
+    MuxChardev *d = opaque;
     int m = d->focus;
     CharBackend *be = d->backends[m];
     int i;
@@ -759,7 +760,7 @@ static bool muxes_realized;
 
 static void mux_chr_event(void *opaque, int event)
 {
-    MuxDriver *d = opaque;
+    MuxChardev *d = opaque;
     int i;
 
     if (!muxes_realized) {
@@ -785,11 +786,11 @@ static void mux_chr_event(void *opaque, int event)
  */
 static void muxes_realize_done(Notifier *notifier, void *unused)
 {
-    CharDriverState *chr;
+    Chardev *chr;
 
     QTAILQ_FOREACH(chr, &chardevs, next) {
         if (qemu_chr_get_kind(chr) == CHARDEV_BACKEND_KIND_MUX) {
-            MuxDriver *d = (MuxDriver *)chr;
+            MuxChardev *d = (MuxChardev *)chr;
             int i;
 
             /* send OPENED to all already-attached FEs */
@@ -809,10 +810,10 @@ static Notifier muxes_realize_notify = {
     .notify = muxes_realize_done,
 };
 
-static GSource *mux_chr_add_watch(CharDriverState *s, GIOCondition cond)
+static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 {
-    MuxDriver *d = (MuxDriver *)s;
-    CharDriverState *chr = qemu_chr_fe_get_driver(&d->chr);
+    MuxChardev *d = (MuxChardev *)s;
+    Chardev *chr = qemu_chr_fe_get_driver(&d->chr);
 
     if (!chr->driver->chr_add_watch) {
         return NULL;
@@ -821,9 +822,9 @@ static GSource *mux_chr_add_watch(CharDriverState *s, GIOCondition cond)
     return chr->driver->chr_add_watch(chr, cond);
 }
 
-static void mux_chr_free(struct CharDriverState *chr)
+static void mux_chr_free(struct Chardev *chr)
 {
-    MuxDriver *d = (MuxDriver *)chr;
+    MuxChardev *d = (MuxChardev *)chr;
     int i;
 
     for (i = 0; i < d->mux_cnt; i++) {
@@ -835,9 +836,9 @@ static void mux_chr_free(struct CharDriverState *chr)
     qemu_chr_fe_deinit(&d->chr);
 }
 
-static void mux_chr_set_handlers(CharDriverState *chr, GMainContext *context)
+static void mux_chr_set_handlers(Chardev *chr, GMainContext *context)
 {
-    MuxDriver *d = (MuxDriver *)chr;
+    MuxChardev *d = (MuxChardev *)chr;
 
     /* Fix up the real driver with mux routines */
     qemu_chr_fe_set_handlers(&d->chr,
@@ -848,9 +849,9 @@ static void mux_chr_set_handlers(CharDriverState *chr, GMainContext *context)
                              context, true);
 }
 
-static void mux_set_focus(CharDriverState *chr, int focus)
+static void mux_set_focus(Chardev *chr, int focus)
 {
-    MuxDriver *d = (MuxDriver *)chr;
+    MuxChardev *d = (MuxChardev *)chr;
 
     assert(focus >= 0);
     assert(focus < d->mux_cnt);
@@ -864,16 +865,16 @@ static void mux_set_focus(CharDriverState *chr, int focus)
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
 
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
     ChardevMux *mux = backend->u.mux.data;
-    CharDriverState *chr, *drv;
-    MuxDriver *d;
+    Chardev *chr, *drv;
+    MuxChardev *d;
     ChardevCommon *common = qapi_ChardevMux_base(mux);
 
     drv = qemu_chr_find(mux->chardev);
@@ -886,7 +887,7 @@ static CharDriverState *qemu_chr_open_mux(const CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    d = (MuxDriver *)chr;
+    d = (MuxChardev *)chr;
     d->focus = -1;
     /* only default to opened state if we've realized the initial
      * set of muxes
@@ -900,17 +901,17 @@ static CharDriverState *qemu_chr_open_mux(const CharDriver *driver,
     return chr;
 }
 
-CharDriverState *qemu_chr_fe_get_driver(CharBackend *be)
+Chardev *qemu_chr_fe_get_driver(CharBackend *be)
 {
     return be->chr;
 }
 
-bool qemu_chr_fe_init(CharBackend *b, CharDriverState *s, Error **errp)
+bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
 {
     int tag = 0;
 
     if (qemu_chr_get_kind(s) == CHARDEV_BACKEND_KIND_MUX) {
-        MuxDriver *d = (MuxDriver *)s;
+        MuxChardev *d = (MuxChardev *)s;
 
         if (d->mux_cnt >= MAX_MUX) {
             goto unavailable;
@@ -934,10 +935,10 @@ unavailable:
     return false;
 }
 
-static bool qemu_chr_is_busy(CharDriverState *s)
+static bool qemu_chr_is_busy(Chardev *s)
 {
     if (qemu_chr_get_kind(s) == CHARDEV_BACKEND_KIND_MUX) {
-        MuxDriver *d = (MuxDriver *)s;
+        MuxChardev *d = (MuxChardev *)s;
         return d->mux_cnt >= 0;
     } else {
         return s->be != NULL;
@@ -954,7 +955,7 @@ void qemu_chr_fe_deinit(CharBackend *b)
             b->chr->be = NULL;
         }
         if (qemu_chr_get_kind(b->chr) == CHARDEV_BACKEND_KIND_MUX) {
-            MuxDriver *d = (MuxDriver *)b->chr;
+            MuxChardev *d = (MuxChardev *)b->chr;
             d->backends[b->tag] = NULL;
         }
         b->chr = NULL;
@@ -969,7 +970,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
                               GMainContext *context,
                               bool set_open)
 {
-    CharDriverState *s;
+    Chardev *s;
     int fe_open;
 
     s = b->chr;
@@ -1096,7 +1097,7 @@ static GSourceFuncs io_watch_poll_funcs = {
 };
 
 /* Can only be used for read */
-static guint io_add_watch_poll(CharDriverState *chr,
+static guint io_add_watch_poll(Chardev *chr,
                                QIOChannel *ioc,
                                IOCanReadHandler *fd_can_read,
                                QIOChannelFunc fd_read,
@@ -1144,7 +1145,7 @@ static void io_remove_watch_poll(guint tag)
     g_source_destroy(&iwp->parent);
 }
 
-static void remove_fd_in_watch(CharDriverState *chr)
+static void remove_fd_in_watch(Chardev *chr)
 {
     if (chr->fd_in_tag) {
         io_remove_watch_poll(chr->fd_in_tag);
@@ -1193,25 +1194,25 @@ static int io_channel_send(QIOChannel *ioc, const void *buf, size_t len)
 }
 
 
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
 
 /* Called with chr_write_lock held.  */
-static int fd_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
+static int fd_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    FDCharDriver *s = (FDCharDriver *)chr;
+    FDChardev *s = (FDChardev *)chr;
 
     return io_channel_send(s->ioc_out, buf, len);
 }
 
 static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
-    CharDriverState *chr = opaque;
-    FDCharDriver *s = opaque;
+    Chardev *chr = opaque;
+    FDChardev *s = opaque;
     int len;
     uint8_t buf[READ_BUF_LEN];
     ssize_t ret;
@@ -1240,23 +1241,23 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 
 static int fd_chr_read_poll(void *opaque)
 {
-    CharDriverState *chr = opaque;
-    FDCharDriver *s = opaque;
+    Chardev *chr = opaque;
+    FDChardev *s = opaque;
 
     s->max_size = qemu_chr_be_can_write(chr);
     return s->max_size;
 }
 
-static GSource *fd_chr_add_watch(CharDriverState *chr, GIOCondition cond)
+static GSource *fd_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    FDCharDriver *s = (FDCharDriver *)chr;
+    FDChardev *s = (FDChardev *)chr;
     return qio_channel_create_watch(s->ioc_out, cond);
 }
 
-static void fd_chr_update_read_handler(CharDriverState *chr,
+static void fd_chr_update_read_handler(Chardev *chr,
                                        GMainContext *context)
 {
-    FDCharDriver *s = (FDCharDriver *)chr;
+    FDChardev *s = (FDChardev *)chr;
 
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -1267,9 +1268,9 @@ static void fd_chr_update_read_handler(CharDriverState *chr,
     }
 }
 
-static void fd_chr_free(struct CharDriverState *chr)
+static void fd_chr_free(struct Chardev *chr)
 {
-    FDCharDriver *s = (FDCharDriver *)chr;
+    FDChardev *s = (FDChardev *)chr;
 
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -1283,19 +1284,19 @@ static void fd_chr_free(struct CharDriverState *chr)
 }
 
 /* open a character device to a unix fd */
-static CharDriverState *qemu_chr_open_fd(const CharDriver *driver,
-                                         int fd_in, int fd_out,
-                                         ChardevCommon *backend, Error **errp)
+static Chardev *qemu_chr_open_fd(const CharDriver *driver,
+                                 int fd_in, int fd_out,
+                                 ChardevCommon *backend, Error **errp)
 {
-    CharDriverState *chr;
-    FDCharDriver *s;
+    Chardev *chr;
+    FDChardev *s;
     char *name;
 
     chr = qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
-    s = (FDCharDriver *)chr;
+    s = (FDChardev *)chr;
     s->ioc_in = QIO_CHANNEL(qio_channel_file_new_fd(fd_in));
     name = g_strdup_printf("chardev-file-in-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc_in), name);
@@ -1310,12 +1311,12 @@ static CharDriverState *qemu_chr_open_fd(const CharDriver *driver,
     return chr;
 }
 
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
     ChardevHostdev *opts = backend->u.pipe.data;
     int fd_in, fd_out;
@@ -1352,7 +1353,7 @@ static bool stdio_in_use;
 static bool stdio_allow_signal;
 static bool stdio_echo_state;
 
-static void qemu_chr_set_echo_stdio(CharDriverState *chr, bool echo);
+static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo);
 
 static void term_exit(void)
 {
@@ -1366,7 +1367,7 @@ static void term_stdio_handler(int sig)
     qemu_chr_set_echo_stdio(NULL, stdio_echo_state);
 }
 
-static void qemu_chr_set_echo_stdio(CharDriverState *chr, bool echo)
+static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo)
 {
     struct termios tty;
 
@@ -1388,21 +1389,21 @@ static void qemu_chr_set_echo_stdio(CharDriverState *chr, bool echo)
     tcsetattr (0, TCSANOW, &tty);
 }
 
-static void qemu_chr_free_stdio(struct CharDriverState *chr)
+static void qemu_chr_free_stdio(struct Chardev *chr)
 {
     term_exit();
     fd_chr_free(chr);
 }
 
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
     ChardevStdio *opts = backend->u.stdio.data;
-    CharDriverState *chr;
+    Chardev *chr;
     struct sigaction act;
     ChardevCommon *common = qapi_ChardevStdio_base(opts);
 
@@ -1446,23 +1447,23 @@ static CharDriverState *qemu_chr_open_stdio(const CharDriver *driver,
 #define HAVE_CHARDEV_PTY 1
 
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
     QIOChannel *ioc;
     int read_bytes;
 
-    /* Protected by the CharDriverState chr_write_lock.  */
+    /* Protected by the Chardev chr_write_lock.  */
     int connected;
     guint timer_tag;
     guint open_tag;
-} PtyCharDriver;
+} PtyChardev;
 
-static void pty_chr_update_read_handler_locked(CharDriverState *chr);
-static void pty_chr_state(CharDriverState *chr, int connected);
+static void pty_chr_update_read_handler_locked(Chardev *chr);
+static void pty_chr_state(Chardev *chr, int connected);
 
 static gboolean pty_chr_timer(gpointer opaque)
 {
-    struct CharDriverState *chr = opaque;
-    PtyCharDriver *s = opaque;
+    struct Chardev *chr = opaque;
+    PtyChardev *s = opaque;
 
     qemu_mutex_lock(&chr->chr_write_lock);
     s->timer_tag = 0;
@@ -1476,9 +1477,9 @@ static gboolean pty_chr_timer(gpointer opaque)
 }
 
 /* Called with chr_write_lock held.  */
-static void pty_chr_rearm_timer(CharDriverState *chr, int ms)
+static void pty_chr_rearm_timer(Chardev *chr, int ms)
 {
-    PtyCharDriver *s = (PtyCharDriver *)chr;
+    PtyChardev *s = (PtyChardev *)chr;
     char *name;
 
     if (s->timer_tag) {
@@ -1498,9 +1499,9 @@ static void pty_chr_rearm_timer(CharDriverState *chr, int ms)
 }
 
 /* Called with chr_write_lock held.  */
-static void pty_chr_update_read_handler_locked(CharDriverState *chr)
+static void pty_chr_update_read_handler_locked(Chardev *chr)
 {
-    PtyCharDriver *s = (PtyCharDriver *)chr;
+    PtyChardev *s = (PtyChardev *)chr;
     GPollFD pfd;
     int rc;
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(s->ioc);
@@ -1520,7 +1521,7 @@ static void pty_chr_update_read_handler_locked(CharDriverState *chr)
     }
 }
 
-static void pty_chr_update_read_handler(CharDriverState *chr,
+static void pty_chr_update_read_handler(Chardev *chr,
                                         GMainContext *context)
 {
     qemu_mutex_lock(&chr->chr_write_lock);
@@ -1529,9 +1530,9 @@ static void pty_chr_update_read_handler(CharDriverState *chr,
 }
 
 /* Called with chr_write_lock held.  */
-static int pty_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
+static int pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    PtyCharDriver *s = (PtyCharDriver *)chr;
+    PtyChardev *s = (PtyChardev *)chr;
 
     if (!s->connected) {
         /* guest sends data, check for (re-)connect */
@@ -1543,9 +1544,9 @@ static int pty_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
     return io_channel_send(s->ioc, buf, len);
 }
 
-static GSource *pty_chr_add_watch(CharDriverState *chr, GIOCondition cond)
+static GSource *pty_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    PtyCharDriver *s = (PtyCharDriver *)chr;
+    PtyChardev *s = (PtyChardev *)chr;
     if (!s->connected) {
         return NULL;
     }
@@ -1554,8 +1555,8 @@ static GSource *pty_chr_add_watch(CharDriverState *chr, GIOCondition cond)
 
 static int pty_chr_read_poll(void *opaque)
 {
-    CharDriverState *chr = opaque;
-    PtyCharDriver *s = opaque;
+    Chardev *chr = opaque;
+    PtyChardev *s = opaque;
 
     s->read_bytes = qemu_chr_be_can_write(chr);
     return s->read_bytes;
@@ -1563,8 +1564,8 @@ static int pty_chr_read_poll(void *opaque)
 
 static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
-    CharDriverState *chr = opaque;
-    PtyCharDriver *s = opaque;
+    Chardev *chr = opaque;
+    PtyChardev *s = opaque;
     gsize len;
     uint8_t buf[READ_BUF_LEN];
     ssize_t ret;
@@ -1588,8 +1589,8 @@ static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 
 static gboolean qemu_chr_be_generic_open_func(gpointer opaque)
 {
-    CharDriverState *chr = opaque;
-    PtyCharDriver *s = opaque;
+    Chardev *chr = opaque;
+    PtyChardev *s = opaque;
 
     s->open_tag = 0;
     qemu_chr_be_generic_open(chr);
@@ -1597,9 +1598,9 @@ static gboolean qemu_chr_be_generic_open_func(gpointer opaque)
 }
 
 /* Called with chr_write_lock held.  */
-static void pty_chr_state(CharDriverState *chr, int connected)
+static void pty_chr_state(Chardev *chr, int connected)
 {
-    PtyCharDriver *s = (PtyCharDriver *)chr;
+    PtyChardev *s = (PtyChardev *)chr;
 
     if (!connected) {
         if (s->open_tag) {
@@ -1631,9 +1632,9 @@ static void pty_chr_state(CharDriverState *chr, int connected)
     }
 }
 
-static void pty_chr_free(struct CharDriverState *chr)
+static void pty_chr_free(struct Chardev *chr)
 {
-    PtyCharDriver *s = (PtyCharDriver *)chr;
+    PtyChardev *s = (PtyChardev *)chr;
 
     qemu_mutex_lock(&chr->chr_write_lock);
     pty_chr_state(chr, 0);
@@ -1646,15 +1647,15 @@ static void pty_chr_free(struct CharDriverState *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
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
     ChardevCommon *common = backend->u.pty.data;
@@ -1682,7 +1683,7 @@ static CharDriverState *qemu_chr_open_pty(const CharDriver *driver,
     fprintf(stderr, "char device redirected to %s (label %s)\n",
             pty_name, id);
 
-    s = (PtyCharDriver *)chr;
+    s = (PtyChardev *)chr;
     s->ioc = QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
     name = g_strdup_printf("chardev-pty-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc), name);
@@ -1694,7 +1695,7 @@ static CharDriverState *qemu_chr_open_pty(const CharDriver *driver,
 }
 
 static const CharDriver pty_driver = {
-    .instance_size = sizeof(PtyCharDriver),
+    .instance_size = sizeof(PtyChardev),
     .kind = CHARDEV_BACKEND_KIND_PTY,
     .create = qemu_chr_open_pty,
     .chr_write = pty_chr_write,
@@ -1818,9 +1819,9 @@ static void tty_serial_init(int fd, int speed,
     tcsetattr (fd, TCSANOW, &tty);
 }
 
-static int tty_serial_ioctl(CharDriverState *chr, int cmd, void *arg)
+static int tty_serial_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    FDCharDriver *s = (FDCharDriver *)chr;
+    FDChardev *s = (FDChardev *)chr;
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(s->ioc_in);
 
     switch(cmd) {
@@ -1888,7 +1889,7 @@ static int tty_serial_ioctl(CharDriverState *chr, int cmd, void *arg)
     return 0;
 }
 
-static void qemu_chr_free_tty(CharDriverState *chr)
+static void qemu_chr_free_tty(Chardev *chr)
 {
     fd_chr_free(chr);
 }
@@ -1899,12 +1900,12 @@ static void qemu_chr_free_tty(CharDriverState *chr)
 #define HAVE_CHARDEV_PARPORT 1
 
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
     int fd;
     int mode;
-} ParallelCharDriver;
+} ParallelChardev;
 
-static int pp_hw_mode(ParallelCharDriver *s, uint16_t mode)
+static int pp_hw_mode(ParallelChardev *s, uint16_t mode)
 {
     if (s->mode != mode) {
 	int m = mode;
@@ -1915,9 +1916,9 @@ static int pp_hw_mode(ParallelCharDriver *s, uint16_t mode)
     return 1;
 }
 
-static int pp_ioctl(CharDriverState *chr, int cmd, void *arg)
+static int pp_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    ParallelCharDriver *drv = (ParallelCharDriver *)chr;
+    ParallelChardev *drv = (ParallelChardev *)chr;
     int fd = drv->fd;
     uint8_t b;
 
@@ -1996,9 +1997,9 @@ static int pp_ioctl(CharDriverState *chr, int cmd, void *arg)
     return 0;
 }
 
-static void pp_free(CharDriverState *chr)
+static void pp_free(Chardev *chr)
 {
-    ParallelCharDriver *drv = (ParallelCharDriver *)chr;
+    ParallelChardev *drv = (ParallelChardev *)chr;
     int fd = drv->fd;
 
     pp_hw_mode(drv, IEEE1284_MODE_COMPAT);
@@ -2007,14 +2008,14 @@ static void pp_free(CharDriverState *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
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
 
     if (ioctl(fd, PPCLAIM) < 0) {
         error_setg_errno(errp, errno, "not a parallel port");
@@ -2027,7 +2028,7 @@ static CharDriverState *qemu_chr_open_pp_fd(const CharDriver *driver,
         return NULL;
     }
 
-    drv = (ParallelCharDriver *)chr;
+    drv = (ParallelChardev *)chr;
     drv->fd = fd;
     drv->mode = IEEE1284_MODE_COMPAT;
 
@@ -2040,13 +2041,13 @@ static CharDriverState *qemu_chr_open_pp_fd(const CharDriver *driver,
 #define HAVE_CHARDEV_PARPORT 1
 
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
     int fd;
-} ParallelCharDriver;
+} ParallelChardev;
 
-static int pp_ioctl(CharDriverState *chr, int cmd, void *arg)
+static int pp_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    ParallelCharDriver *drv = (ParallelCharDriver *)chr;
+    ParallelChardev *drv = (ParallelChardev *)chr;
     uint8_t b;
 
     switch (cmd) {
@@ -2086,20 +2087,20 @@ static int pp_ioctl(CharDriverState *chr, int cmd, void *arg)
     return 0;
 }
 
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
 
     chr = qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
-    drv = (ParallelCharDriver *)chr;
+    drv = (ParallelChardev *)chr;
     drv->fd = fd;
     *be_opened = false;
     return chr;
@@ -2111,25 +2112,25 @@ static CharDriverState *qemu_chr_open_pp_fd(const CharDriver *driver,
 #define HAVE_CHARDEV_SERIAL 1
 
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
     int max_size;
     HANDLE hcom, hrecv, hsend;
     OVERLAPPED orecv;
     BOOL fpipe;
     DWORD len;
 
-    /* Protected by the CharDriverState chr_write_lock.  */
+    /* Protected by the Chardev chr_write_lock.  */
     OVERLAPPED osend;
-} WinCharState;
+} WinChardev;
 
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
 
 #define NSENDBUF 2048
 #define NRECVBUF 2048
@@ -2139,9 +2140,9 @@ typedef struct {
 static int win_chr_poll(void *opaque);
 static int win_chr_pipe_poll(void *opaque);
 
-static void win_chr_free(CharDriverState *chr)
+static void win_chr_free(Chardev *chr)
 {
-    WinCharState *s = (WinCharState *)chr;
+    WinChardev *s = (WinChardev *)chr;
 
     if (s->hsend) {
         CloseHandle(s->hsend);
@@ -2163,9 +2164,9 @@ static void win_chr_free(CharDriverState *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
-static int win_chr_init(CharDriverState *chr, const char *filename, Error **errp)
+static int win_chr_init(Chardev *chr, const char *filename, Error **errp)
 {
-    WinCharState *s = (WinCharState *)chr;
+    WinChardev *s = (WinChardev *)chr;
     COMMCONFIG comcfg;
     COMMTIMEOUTS cto = { 0, 0, 0, 0, 0};
     COMSTAT comstat;
@@ -2231,9 +2232,9 @@ static int win_chr_init(CharDriverState *chr, const char *filename, Error **errp
 }
 
 /* Called with chr_write_lock held.  */
-static int win_chr_write(CharDriverState *chr, const uint8_t *buf, int len1)
+static int win_chr_write(Chardev *chr, const uint8_t *buf, int len1)
 {
-    WinCharState *s = (WinCharState *)chr;
+    WinChardev *s = (WinChardev *)chr;
     DWORD len, ret, size, err;
 
     len = len1;
@@ -2265,17 +2266,17 @@ static int win_chr_write(CharDriverState *chr, const uint8_t *buf, int len1)
     return len1 - len;
 }
 
-static int win_chr_read_poll(CharDriverState *chr)
+static int win_chr_read_poll(Chardev *chr)
 {
-    WinCharState *s = (WinCharState *)chr;
+    WinChardev *s = (WinChardev *)chr;
 
     s->max_size = qemu_chr_be_can_write(chr);
     return s->max_size;
 }
 
-static void win_chr_readfile(CharDriverState *chr)
+static void win_chr_readfile(Chardev *chr)
 {
-    WinCharState *s = (WinCharState *)chr;
+    WinChardev *s = (WinChardev *)chr;
     int ret, err;
     uint8_t buf[READ_BUF_LEN];
     DWORD size;
@@ -2295,9 +2296,9 @@ static void win_chr_readfile(CharDriverState *chr)
     }
 }
 
-static void win_chr_read(CharDriverState *chr)
+static void win_chr_read(Chardev *chr)
 {
-    WinCharState *s = (WinCharState *)chr;
+    WinChardev *s = (WinChardev *)chr;
 
     if (s->len > s->max_size)
         s->len = s->max_size;
@@ -2309,8 +2310,8 @@ static void win_chr_read(CharDriverState *chr)
 
 static int win_chr_poll(void *opaque)
 {
-    CharDriverState *chr = opaque;
-    WinCharState *s = opaque;
+    Chardev *chr = opaque;
+    WinChardev *s = opaque;
     COMSTAT status;
     DWORD comerr;
 
@@ -2326,8 +2327,8 @@ static int win_chr_poll(void *opaque)
 
 static int win_chr_pipe_poll(void *opaque)
 {
-    CharDriverState *chr = opaque;
-    WinCharState *s = opaque;
+    Chardev *chr = opaque;
+    WinChardev *s = opaque;
     DWORD size;
 
     PeekNamedPipe(s->hcom, NULL, 0, NULL, &size, NULL);
@@ -2340,10 +2341,10 @@ static int win_chr_pipe_poll(void *opaque)
     return 0;
 }
 
-static int win_chr_pipe_init(CharDriverState *chr, const char *filename,
+static int win_chr_pipe_init(Chardev *chr, const char *filename,
                              Error **errp)
 {
-    WinCharState *s = (WinCharState *)chr;
+    WinChardev *s = (WinChardev *)chr;
     OVERLAPPED ov;
     int ret;
     DWORD size;
@@ -2405,16 +2406,16 @@ static int win_chr_pipe_init(CharDriverState *chr, const char *filename,
 }
 
 
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
     ChardevHostdev *opts = backend->u.pipe.data;
     const char *filename = opts->device;
-    CharDriverState *chr;
+    Chardev *chr;
     ChardevCommon *common = qapi_ChardevHostdev_base(opts);
 
     chr = qemu_chr_alloc(driver, common, errp);
@@ -2429,29 +2430,29 @@ static CharDriverState *qemu_chr_open_pipe(const CharDriver *driver,
     return chr;
 }
 
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
 
     chr = qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
-    s = (WinCharState *)chr;
+    s = (WinChardev *)chr;
     s->hcom = fd_out;
     return chr;
 }
 
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
     ChardevCommon *common = backend->u.console.data;
     return qemu_chr_open_win_file(driver,
@@ -2460,13 +2461,13 @@ static CharDriverState *qemu_chr_open_win_con(const CharDriver *driver,
 }
 
 static const CharDriver console_driver = {
-    .instance_size = sizeof(WinCharState),
+    .instance_size = sizeof(WinChardev),
     .kind = CHARDEV_BACKEND_KIND_CONSOLE,
     .create = qemu_chr_open_win_con,
     .chr_write = win_chr_write,
 };
 
-static int win_stdio_write(CharDriverState *chr, const uint8_t *buf, int len)
+static int win_stdio_write(Chardev *chr, const uint8_t *buf, int len)
 {
     HANDLE  hStdOut = GetStdHandle(STD_OUTPUT_HANDLE);
     DWORD   dwSize;
@@ -2487,8 +2488,8 @@ static int win_stdio_write(CharDriverState *chr, const uint8_t *buf, int len)
 
 static void win_stdio_wait_func(void *opaque)
 {
-    CharDriverState   *chr   = opaque;
-    WinStdioCharState *stdio = opaque;
+    Chardev   *chr   = opaque;
+    WinStdioChardev *stdio = opaque;
     INPUT_RECORD       buf[4];
     int                ret;
     DWORD              dwSize;
@@ -2521,7 +2522,7 @@ static void win_stdio_wait_func(void *opaque)
 
 static DWORD WINAPI win_stdio_thread(LPVOID param)
 {
-    WinStdioCharState *stdio = param;
+    WinStdioChardev *stdio = param;
     int                ret;
     DWORD              dwSize;
 
@@ -2559,8 +2560,8 @@ static DWORD WINAPI win_stdio_thread(LPVOID param)
 
 static void win_stdio_thread_wait_func(void *opaque)
 {
-    CharDriverState   *chr   = opaque;
-    WinStdioCharState *stdio = opaque;
+    Chardev   *chr   = opaque;
+    WinStdioChardev *stdio = opaque;
 
     if (qemu_chr_be_can_write(chr)) {
         qemu_chr_be_write(chr, &stdio->win_stdio_buf, 1);
@@ -2569,9 +2570,9 @@ static void win_stdio_thread_wait_func(void *opaque)
     SetEvent(stdio->hInputDoneEvent);
 }
 
-static void qemu_chr_set_echo_win_stdio(CharDriverState *chr, bool echo)
+static void qemu_chr_set_echo_win_stdio(Chardev *chr, bool echo)
 {
-    WinStdioCharState *stdio  = (WinStdioCharState *)chr;
+    WinStdioChardev *stdio  = (WinStdioChardev *)chr;
     DWORD              dwMode = 0;
 
     GetConsoleMode(stdio->hStdIn, &dwMode);
@@ -2583,9 +2584,9 @@ static void qemu_chr_set_echo_win_stdio(CharDriverState *chr, bool echo)
     }
 }
 
-static void win_stdio_free(CharDriverState *chr)
+static void win_stdio_free(Chardev *chr)
 {
-    WinStdioCharState *stdio = (WinStdioCharState *)chr;
+    WinStdioChardev *stdio = (WinStdioChardev *)chr;
 
     if (stdio->hInputReadyEvent != INVALID_HANDLE_VALUE) {
         CloseHandle(stdio->hInputReadyEvent);
@@ -2598,15 +2599,15 @@ static void win_stdio_free(CharDriverState *chr)
     }
 }
 
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
     int                is_console = 0;
     ChardevCommon *common = qapi_ChardevStdio_base(backend->u.stdio.data);
@@ -2615,7 +2616,7 @@ static CharDriverState *qemu_chr_open_stdio(const CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    stdio = (WinStdioCharState *)chr;
+    stdio = (WinStdioChardev *)chr;
 
     stdio->hStdIn = GetStdHandle(STD_INPUT_HANDLE);
     if (stdio->hStdIn == INVALID_HANDLE_VALUE) {
@@ -2684,18 +2685,18 @@ err1:
 /* UDP Net console */
 
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
 
 /* Called with chr_write_lock held.  */
-static int udp_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
+static int udp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    NetCharDriver *s = (NetCharDriver *)chr;
+    NetChardev *s = (NetChardev *)chr;
 
     return qio_channel_write(
         s->ioc, (const char *)buf, len, NULL);
@@ -2703,8 +2704,8 @@ static int udp_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 
 static int udp_chr_read_poll(void *opaque)
 {
-    CharDriverState *chr = opaque;
-    NetCharDriver *s = opaque;
+    Chardev *chr = opaque;
+    NetChardev *s = opaque;
 
     s->max_size = qemu_chr_be_can_write(chr);
 
@@ -2721,8 +2722,8 @@ static int udp_chr_read_poll(void *opaque)
 
 static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
-    CharDriverState *chr = opaque;
-    NetCharDriver *s = opaque;
+    Chardev *chr = opaque;
+    NetChardev *s = opaque;
     ssize_t ret;
 
     if (s->max_size == 0) {
@@ -2746,10 +2747,10 @@ static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
     return TRUE;
 }
 
-static void udp_chr_update_read_handler(CharDriverState *chr,
+static void udp_chr_update_read_handler(Chardev *chr,
                                         GMainContext *context)
 {
-    NetCharDriver *s = (NetCharDriver *)chr;
+    NetChardev *s = (NetChardev *)chr;
 
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -2760,9 +2761,9 @@ static void udp_chr_update_read_handler(CharDriverState *chr,
     }
 }
 
-static void udp_chr_free(CharDriverState *chr)
+static void udp_chr_free(Chardev *chr)
 {
-    NetCharDriver *s = (NetCharDriver *)chr;
+    NetChardev *s = (NetChardev *)chr;
 
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -2775,7 +2776,7 @@ static void udp_chr_free(CharDriverState *chr)
 /* TCP Net console */
 
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
     QIOChannel *ioc; /* Client I/O channel */
     QIOChannelSocket *sioc; /* Client master channel */
     QIOChannelSocket *listen_ioc;
@@ -2798,13 +2799,13 @@ typedef struct {
     guint reconnect_timer;
     int64_t reconnect_time;
     bool connect_err_reported;
-} TCPCharDriver;
+} TCPChardev;
 
 static gboolean socket_reconnect_timeout(gpointer opaque);
 
-static void qemu_chr_socket_restart_timer(CharDriverState *chr)
+static void qemu_chr_socket_restart_timer(Chardev *chr)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
     char *name;
 
     assert(s->connected == 0);
@@ -2815,10 +2816,10 @@ static void qemu_chr_socket_restart_timer(CharDriverState *chr)
     g_free(name);
 }
 
-static void check_report_connect_error(CharDriverState *chr,
+static void check_report_connect_error(Chardev *chr,
                                        Error *err)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
 
     if (!s->connect_err_reported) {
         error_report("Unable to connect character device %s: %s",
@@ -2833,9 +2834,9 @@ static gboolean tcp_chr_accept(QIOChannel *chan,
                                void *opaque);
 
 /* Called with chr_write_lock held.  */
-static int tcp_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
+static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
 
     if (s->connected) {
         int ret =  io_channel_send_full(s->ioc, buf, len,
@@ -2858,8 +2859,8 @@ static int tcp_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 
 static int tcp_chr_read_poll(void *opaque)
 {
-    CharDriverState *chr = opaque;
-    TCPCharDriver *s = opaque;
+    Chardev *chr = opaque;
+    TCPChardev *s = opaque;
     if (!s->connected)
         return 0;
     s->max_size = qemu_chr_be_can_write(chr);
@@ -2868,8 +2869,8 @@ static int tcp_chr_read_poll(void *opaque)
 
 #define IAC 255
 #define IAC_BREAK 243
-static void tcp_chr_process_IAC_bytes(CharDriverState *chr,
-                                      TCPCharDriver *s,
+static void tcp_chr_process_IAC_bytes(Chardev *chr,
+                                      TCPChardev *s,
                                       uint8_t *buf, int *size)
 {
     /* Handle any telnet client's basic IAC options to satisfy char by
@@ -2916,9 +2917,9 @@ static void tcp_chr_process_IAC_bytes(CharDriverState *chr,
     *size = j;
 }
 
-static int tcp_get_msgfds(CharDriverState *chr, int *fds, int num)
+static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
 
     int to_copy = (s->read_msgfds_num < num) ? s->read_msgfds_num : num;
 
@@ -2942,9 +2943,9 @@ static int tcp_get_msgfds(CharDriverState *chr, int *fds, int num)
     return to_copy;
 }
 
-static int tcp_set_msgfds(CharDriverState *chr, int *fds, int num)
+static int tcp_set_msgfds(Chardev *chr, int *fds, int num)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
 
     /* clear old pending fd array */
     g_free(s->write_msgfds);
@@ -2967,9 +2968,9 @@ static int tcp_set_msgfds(CharDriverState *chr, int *fds, int num)
     return 0;
 }
 
-static ssize_t tcp_chr_recv(CharDriverState *chr, char *buf, size_t len)
+static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
     struct iovec iov = { .iov_base = buf, .iov_len = len };
     int ret;
     size_t i;
@@ -3024,15 +3025,15 @@ static ssize_t tcp_chr_recv(CharDriverState *chr, char *buf, size_t len)
     return ret;
 }
 
-static GSource *tcp_chr_add_watch(CharDriverState *chr, GIOCondition cond)
+static GSource *tcp_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
     return qio_channel_create_watch(s->ioc, cond);
 }
 
-static void tcp_chr_free_connection(CharDriverState *chr)
+static void tcp_chr_free_connection(Chardev *chr)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
     int i;
 
     if (!s->connected) {
@@ -3059,9 +3060,9 @@ static void tcp_chr_free_connection(CharDriverState *chr)
     s->connected = 0;
 }
 
-static void tcp_chr_disconnect(CharDriverState *chr)
+static void tcp_chr_disconnect(Chardev *chr)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
 
     if (!s->connected) {
         return;
@@ -3083,8 +3084,8 @@ static void tcp_chr_disconnect(CharDriverState *chr)
 
 static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
-    CharDriverState *chr = opaque;
-    TCPCharDriver *s = opaque;
+    Chardev *chr = opaque;
+    TCPChardev *s = opaque;
     uint8_t buf[READ_BUF_LEN];
     int len, size;
 
@@ -3108,9 +3109,9 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
     return TRUE;
 }
 
-static int tcp_chr_sync_read(CharDriverState *chr, const uint8_t *buf, int len)
+static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
     int size;
 
     if (!s->connected) {
@@ -3128,8 +3129,8 @@ static int tcp_chr_sync_read(CharDriverState *chr, const uint8_t *buf, int len)
 
 static void tcp_chr_connect(void *opaque)
 {
-    CharDriverState *chr = opaque;
-    TCPCharDriver *s = opaque;
+    Chardev *chr = opaque;
+    TCPChardev *s = opaque;
 
     g_free(chr->filename);
     chr->filename = sockaddr_to_str(
@@ -3147,10 +3148,10 @@ static void tcp_chr_connect(void *opaque)
     qemu_chr_be_generic_open(chr);
 }
 
-static void tcp_chr_update_read_handler(CharDriverState *chr,
+static void tcp_chr_update_read_handler(Chardev *chr,
                                         GMainContext *context)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
 
     if (!s->connected) {
         return;
@@ -3166,7 +3167,7 @@ static void tcp_chr_update_read_handler(CharDriverState *chr,
 }
 
 typedef struct {
-    CharDriverState *chr;
+    Chardev *chr;
     char buf[12];
     size_t buflen;
 } TCPCharDriverTelnetInit;
@@ -3199,9 +3200,9 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
     return TRUE;
 }
 
-static void tcp_chr_telnet_init(CharDriverState *chr)
+static void tcp_chr_telnet_init(Chardev *chr)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
     TCPCharDriverTelnetInit *init =
         g_new0(TCPCharDriverTelnetInit, 1);
     size_t n = 0;
@@ -3235,8 +3236,8 @@ static void tcp_chr_telnet_init(CharDriverState *chr)
 static void tcp_chr_tls_handshake(QIOTask *task,
                                   gpointer user_data)
 {
-    CharDriverState *chr = user_data;
-    TCPCharDriver *s = user_data;
+    Chardev *chr = user_data;
+    TCPChardev *s = user_data;
 
     if (qio_task_propagate_error(task, NULL)) {
         tcp_chr_disconnect(chr);
@@ -3250,9 +3251,9 @@ static void tcp_chr_tls_handshake(QIOTask *task,
 }
 
 
-static void tcp_chr_tls_init(CharDriverState *chr)
+static void tcp_chr_tls_init(Chardev *chr)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
     QIOChannelTLS *tioc;
     Error *err = NULL;
     gchar *name;
@@ -3288,10 +3289,10 @@ static void tcp_chr_tls_init(CharDriverState *chr)
 }
 
 
-static void tcp_chr_set_client_ioc_name(CharDriverState *chr,
+static void tcp_chr_set_client_ioc_name(Chardev *chr,
                                         QIOChannelSocket *sioc)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
     char *name;
     name = g_strdup_printf("chardev-tcp-%s-%s",
                            s->is_listen ? "server" : "client",
@@ -3301,9 +3302,9 @@ static void tcp_chr_set_client_ioc_name(CharDriverState *chr,
 
 }
 
-static int tcp_chr_new_client(CharDriverState *chr, QIOChannelSocket *sioc)
+static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
 
     if (s->ioc != NULL) {
 	return -1;
@@ -3338,7 +3339,7 @@ static int tcp_chr_new_client(CharDriverState *chr, QIOChannelSocket *sioc)
 }
 
 
-static int tcp_chr_add_client(CharDriverState *chr, int fd)
+static int tcp_chr_add_client(Chardev *chr, int fd)
 {
     int ret;
     QIOChannelSocket *sioc;
@@ -3357,7 +3358,7 @@ static gboolean tcp_chr_accept(QIOChannel *channel,
                                GIOCondition cond,
                                void *opaque)
 {
-    CharDriverState *chr = opaque;
+    Chardev *chr = opaque;
     QIOChannelSocket *sioc;
 
     sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(channel),
@@ -3373,9 +3374,9 @@ static gboolean tcp_chr_accept(QIOChannel *channel,
     return TRUE;
 }
 
-static int tcp_chr_wait_connected(CharDriverState *chr, Error **errp)
+static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
     QIOChannelSocket *sioc;
 
     /* It can't wait on s->connected, since it is set asynchronously
@@ -3402,7 +3403,7 @@ static int tcp_chr_wait_connected(CharDriverState *chr, Error **errp)
     return 0;
 }
 
-static int qemu_chr_wait_connected(CharDriverState *chr, Error **errp)
+static int qemu_chr_wait_connected(Chardev *chr, Error **errp)
 {
     if (chr->driver->chr_wait_connected) {
         return chr->driver->chr_wait_connected(chr, errp);
@@ -3421,9 +3422,9 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp)
     return qemu_chr_wait_connected(be->chr, errp);
 }
 
-static void tcp_chr_free(CharDriverState *chr)
+static void tcp_chr_free(Chardev *chr)
 {
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    TCPChardev *s = (TCPChardev *)chr;
 
     tcp_chr_free_connection(chr);
 
@@ -3450,8 +3451,8 @@ static void tcp_chr_free(CharDriverState *chr)
 static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
-    CharDriverState *chr = opaque;
-    TCPCharDriver *s = (TCPCharDriver *)chr;
+    Chardev *chr = opaque;
+    TCPChardev *s = (TCPChardev *)chr;
     Error *err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
@@ -3472,24 +3473,24 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
 /* Ring buffer chardev */
 
 typedef struct {
-    CharDriverState parent;
+    Chardev parent;
     size_t size;
     size_t prod;
     size_t cons;
     uint8_t *cbuf;
-} RingBufCharDriver;
+} RingBufChardev;
 
-static size_t ringbuf_count(const CharDriverState *chr)
+static size_t ringbuf_count(const Chardev *chr)
 {
-    const RingBufCharDriver *d = (RingBufCharDriver *)chr;
+    const RingBufChardev *d = (RingBufChardev *)chr;
 
     return d->prod - d->cons;
 }
 
 /* Called with chr_write_lock held.  */
-static int ringbuf_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
+static int ringbuf_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    RingBufCharDriver *d = (RingBufCharDriver *)chr;
+    RingBufChardev *d = (RingBufChardev *)chr;
     int i;
 
     if (!buf || (len < 0)) {
@@ -3506,9 +3507,9 @@ static int ringbuf_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
     return len;
 }
 
-static int ringbuf_chr_read(CharDriverState *chr, uint8_t *buf, int len)
+static int ringbuf_chr_read(Chardev *chr, uint8_t *buf, int len)
 {
-    RingBufCharDriver *d = (RingBufCharDriver *)chr;
+    RingBufChardev *d = (RingBufChardev *)chr;
     int i;
 
     qemu_mutex_lock(&chr->chr_write_lock);
@@ -3520,30 +3521,30 @@ static int ringbuf_chr_read(CharDriverState *chr, uint8_t *buf, int len)
     return i;
 }
 
-static void ringbuf_chr_free(struct CharDriverState *chr)
+static void ringbuf_chr_free(struct Chardev *chr)
 {
-    RingBufCharDriver *d = (RingBufCharDriver *)chr;
+    RingBufChardev *d = (RingBufChardev *)chr;
 
     g_free(d->cbuf);
 }
 
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
     ChardevRingbuf *opts = backend->u.ringbuf.data;
     ChardevCommon *common = qapi_ChardevRingbuf_base(opts);
-    CharDriverState *chr;
-    RingBufCharDriver *d;
+    Chardev *chr;
+    RingBufChardev *d;
 
     chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
-    d = (RingBufCharDriver *)chr;
+    d = (RingBufChardev *)chr;
 
     d->size = opts->has_size ? opts->size : 65536;
 
@@ -3564,7 +3565,7 @@ fail:
     return NULL;
 }
 
-ChardevBackendKind qemu_chr_get_kind(const CharDriverState *chr)
+ChardevBackendKind qemu_chr_get_kind(const Chardev *chr)
 {
     return chr->driver->kind;
 }
@@ -3573,7 +3574,7 @@ void qmp_ringbuf_write(const char *device, const char *data,
                        bool has_format, enum DataFormat format,
                        Error **errp)
 {
-    CharDriverState *chr;
+    Chardev *chr;
     const uint8_t *write_data;
     int ret;
     gsize write_count;
@@ -3617,7 +3618,7 @@ char *qmp_ringbuf_read(const char *device, int64_t size,
                        bool has_format, enum DataFormat format,
                        Error **errp)
 {
-    CharDriverState *chr;
+    Chardev *chr;
     uint8_t *read_data;
     size_t count;
     char *data;
@@ -3850,12 +3851,12 @@ static const CharDriver stdio_driver = {
     .parse = qemu_chr_parse_stdio,
     .create = qemu_chr_open_stdio,
 #ifdef _WIN32
-    sizeof(WinStdioCharState),
+    sizeof(WinStdioChardev),
     .chr_write = win_stdio_write,
     .chr_set_echo = qemu_chr_set_echo_win_stdio,
     .chr_free = win_stdio_free,
 #else
-    sizeof(FDCharDriver),
+    sizeof(FDChardev),
     .chr_add_watch = fd_chr_add_watch,
     .chr_write = fd_chr_write,
     .chr_update_read_handler = fd_chr_update_read_handler,
@@ -3918,11 +3919,11 @@ static const CharDriver pipe_driver = {
     .parse = qemu_chr_parse_pipe,
     .create = qemu_chr_open_pipe,
 #ifdef _WIN32
-    sizeof(WinCharState),
+    sizeof(WinChardev),
     .chr_write = win_chr_write,
     .chr_free = win_chr_free,
 #else
-    sizeof(FDCharDriver),
+    sizeof(FDChardev),
     .chr_add_watch = fd_chr_add_watch,
     .chr_write = fd_chr_write,
     .chr_update_read_handler = fd_chr_update_read_handler,
@@ -3947,7 +3948,7 @@ static void qemu_chr_parse_ringbuf(QemuOpts *opts, ChardevBackend *backend,
 }
 
 static const CharDriver ringbuf_driver = {
-    .instance_size = sizeof(RingBufCharDriver),
+    .instance_size = sizeof(RingBufChardev),
     .kind = CHARDEV_BACKEND_KIND_RINGBUF,
     .parse = qemu_chr_parse_ringbuf,
     .create = qemu_chr_open_ringbuf,
@@ -3957,7 +3958,7 @@ static const CharDriver ringbuf_driver = {
 
 /* Bug-compatibility: */
 static const CharDriver memory_driver = {
-    .instance_size = sizeof(RingBufCharDriver),
+    .instance_size = sizeof(RingBufChardev),
     .kind = CHARDEV_BACKEND_KIND_MEMORY,
     .parse = qemu_chr_parse_ringbuf,
     .create = qemu_chr_open_ringbuf,
@@ -3981,7 +3982,7 @@ static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
 }
 
 static const CharDriver mux_driver = {
-    .instance_size = sizeof(MuxDriver),
+    .instance_size = sizeof(MuxChardev),
     .kind = CHARDEV_BACKEND_KIND_MUX,
     .parse = qemu_chr_parse_mux,
     .create = qemu_chr_open_mux,
@@ -4125,12 +4126,12 @@ void register_char_driver(const CharDriver *driver)
     backends[driver->kind] = driver;
 }
 
-CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
-                                        Error **errp)
+Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
+                                Error **errp)
 {
     Error *local_err = NULL;
     const CharDriver *cd = NULL;
-    CharDriverState *chr;
+    Chardev *chr;
     int i;
     ChardevReturn *ret = NULL;
     ChardevBackend *backend;
@@ -4231,10 +4232,10 @@ err:
     return NULL;
 }
 
-CharDriverState *qemu_chr_new_noreplay(const char *label, const char *filename)
+Chardev *qemu_chr_new_noreplay(const char *label, const char *filename)
 {
     const char *p;
-    CharDriverState *chr;
+    Chardev *chr;
     QemuOpts *opts;
     Error *err = NULL;
 
@@ -4257,9 +4258,9 @@ CharDriverState *qemu_chr_new_noreplay(const char *label, const char *filename)
     return chr;
 }
 
-CharDriverState *qemu_chr_new(const char *label, const char *filename)
+Chardev *qemu_chr_new(const char *label, const char *filename)
 {
-    CharDriverState *chr;
+    Chardev *chr;
     chr = qemu_chr_new_noreplay(label, filename);
     if (chr) {
         if (replay_mode != REPLAY_MODE_NONE) {
@@ -4276,7 +4277,7 @@ CharDriverState *qemu_chr_new(const char *label, const char *filename)
 
 void qemu_chr_fe_set_echo(CharBackend *be, bool echo)
 {
-    CharDriverState *chr = be->chr;
+    Chardev *chr = be->chr;
 
     if (chr && chr->driver->chr_set_echo) {
         chr->driver->chr_set_echo(chr, echo);
@@ -4285,7 +4286,7 @@ void qemu_chr_fe_set_echo(CharBackend *be, bool echo)
 
 void qemu_chr_fe_set_open(CharBackend *be, int fe_open)
 {
-    CharDriverState *chr = be->chr;
+    Chardev *chr = be->chr;
 
     if (!chr) {
         return;
@@ -4303,7 +4304,7 @@ void qemu_chr_fe_set_open(CharBackend *be, int fe_open)
 guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
                             GIOFunc func, void *user_data)
 {
-    CharDriverState *s = be->chr;
+    Chardev *s = be->chr;
     GSource *src;
     guint tag;
 
@@ -4325,14 +4326,14 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
 
 void qemu_chr_fe_disconnect(CharBackend *be)
 {
-    CharDriverState *chr = be->chr;
+    Chardev *chr = be->chr;
 
     if (chr && chr->driver->chr_disconnect) {
         chr->driver->chr_disconnect(chr);
     }
 }
 
-static void qemu_chr_free_common(CharDriverState *chr)
+static void qemu_chr_free_common(Chardev *chr)
 {
     if (chr->be) {
         chr->be->chr = NULL;
@@ -4346,7 +4347,7 @@ static void qemu_chr_free_common(CharDriverState *chr)
     g_free(chr);
 }
 
-void qemu_chr_free(CharDriverState *chr)
+void qemu_chr_free(Chardev *chr)
 {
     if (chr->driver->chr_free) {
         chr->driver->chr_free(chr);
@@ -4354,7 +4355,7 @@ void qemu_chr_free(CharDriverState *chr)
     qemu_chr_free_common(chr);
 }
 
-void qemu_chr_delete(CharDriverState *chr)
+void qemu_chr_delete(Chardev *chr)
 {
     QTAILQ_REMOVE(&chardevs, chr, next);
     qemu_chr_free(chr);
@@ -4363,7 +4364,7 @@ void qemu_chr_delete(CharDriverState *chr)
 ChardevInfoList *qmp_query_chardev(Error **errp)
 {
     ChardevInfoList *chr_list = NULL;
-    CharDriverState *chr;
+    Chardev *chr;
 
     QTAILQ_FOREACH(chr, &chardevs, next) {
         ChardevInfoList *info = g_malloc0(sizeof(*info));
@@ -4411,9 +4412,9 @@ ChardevBackendInfoList *qmp_query_chardev_backends(Error **errp)
     return backend_list;
 }
 
-CharDriverState *qemu_chr_find(const char *name)
+Chardev *qemu_chr_find(const char *name)
 {
-    CharDriverState *chr;
+    Chardev *chr;
 
     QTAILQ_FOREACH(chr, &chardevs, next) {
         if (strcmp(chr->label, name) != 0)
@@ -4519,12 +4520,12 @@ QemuOptsList qemu_chardev_opts = {
 
 #ifdef _WIN32
 
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
     ChardevFile *file = backend->u.file.data;
     ChardevCommon *common = qapi_ChardevFile_base(file);
@@ -4556,16 +4557,16 @@ static CharDriverState *qmp_chardev_open_file(const CharDriver *driver,
     return qemu_chr_open_win_file(driver, out, common, errp);
 }
 
-static CharDriverState *qmp_chardev_open_serial(const CharDriver *driver,
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
     ChardevHostdev *serial = backend->u.serial.data;
     ChardevCommon *common = qapi_ChardevHostdev_base(serial);
-    CharDriverState *chr;
+    Chardev *chr;
 
     chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
@@ -4594,12 +4595,12 @@ static int qmp_chardev_open_file_source(char *src, int flags,
     return fd;
 }
 
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
     ChardevFile *file = backend->u.file.data;
     ChardevCommon *common = qapi_ChardevFile_base(file);
@@ -4630,12 +4631,12 @@ static CharDriverState *qmp_chardev_open_file(const CharDriver *driver,
 }
 
 #ifdef HAVE_CHARDEV_SERIAL
-static CharDriverState *qmp_chardev_open_serial(const CharDriver *driver,
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
     ChardevHostdev *serial = backend->u.serial.data;
     ChardevCommon *common = qapi_ChardevHostdev_base(serial);
@@ -4653,12 +4654,12 @@ static CharDriverState *qmp_chardev_open_serial(const CharDriver *driver,
 #endif
 
 #ifdef HAVE_CHARDEV_PARPORT
-static CharDriverState *qmp_chardev_open_parallel(const CharDriver *driver,
-                                                  const char *id,
-                                                  ChardevBackend *backend,
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
     ChardevHostdev *parallel = backend->u.parallel.data;
     ChardevCommon *common = qapi_ChardevHostdev_base(parallel);
@@ -4672,7 +4673,7 @@ static CharDriverState *qmp_chardev_open_parallel(const CharDriver *driver,
 }
 
 static const CharDriver parallel_driver = {
-    .instance_size = sizeof(ParallelCharDriver),
+    .instance_size = sizeof(ParallelChardev),
     .kind = CHARDEV_BACKEND_KIND_PARALLEL,
     .alias = "parport",
     .parse = qemu_chr_parse_parallel,
@@ -4696,11 +4697,11 @@ static const CharDriver file_driver = {
     .parse = qemu_chr_parse_file_out,
     .create = qmp_chardev_open_file,
 #ifdef _WIN32
-    sizeof(WinCharState),
+    sizeof(WinChardev),
     .chr_write = win_chr_write,
     /* FIXME: no chr_free */
 #else
-    sizeof(FDCharDriver),
+    sizeof(FDChardev),
     .chr_add_watch = fd_chr_add_watch,
     .chr_write = fd_chr_write,
     .chr_update_read_handler = fd_chr_update_read_handler,
@@ -4715,11 +4716,11 @@ static const CharDriver serial_driver = {
     .parse = qemu_chr_parse_serial,
     .create = qmp_chardev_open_serial,
 #ifdef _WIN32
-    sizeof(WinCharState),
+    sizeof(WinChardev),
     .chr_write = win_chr_write,
     .chr_free = win_chr_free,
 #else
-    sizeof(FDCharDriver),
+    sizeof(FDChardev),
     .chr_add_watch = fd_chr_add_watch,
     .chr_write = fd_chr_write,
     .chr_update_read_handler = fd_chr_update_read_handler,
@@ -4731,8 +4732,8 @@ static const CharDriver serial_driver = {
 
 static gboolean socket_reconnect_timeout(gpointer opaque)
 {
-    CharDriverState *chr = opaque;
-    TCPCharDriver *s = opaque;
+    Chardev *chr = opaque;
+    TCPChardev *s = opaque;
     QIOChannelSocket *sioc;
 
     s->reconnect_timer = 0;
@@ -4750,15 +4751,15 @@ static gboolean socket_reconnect_timeout(gpointer opaque)
     return false;
 }
 
-static CharDriverState *qmp_chardev_open_socket(const CharDriver *driver,
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
     ChardevSocket *sock = backend->u.socket.data;
     SocketAddress *addr = sock->addr;
     bool do_nodelay     = sock->has_nodelay ? sock->nodelay : false;
@@ -4773,7 +4774,7 @@ static CharDriverState *qmp_chardev_open_socket(const CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    s = (TCPCharDriver *)chr;
+    s = (TCPChardev *)chr;
 
     s->is_unix = addr->type == SOCKET_ADDRESS_KIND_UNIX;
     s->is_listen = is_listen;
@@ -4880,7 +4881,7 @@ static CharDriverState *qmp_chardev_open_socket(const CharDriver *driver,
 }
 
 static const CharDriver socket_driver = {
-    .instance_size = sizeof(TCPCharDriver),
+    .instance_size = sizeof(TCPChardev),
     .kind = CHARDEV_BACKEND_KIND_SOCKET,
     .parse = qemu_chr_parse_socket,
     .create = qmp_chardev_open_socket,
@@ -4896,19 +4897,19 @@ static const CharDriver socket_driver = {
     .chr_free = tcp_chr_free,
 };
 
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
     ChardevUdp *udp = backend->u.udp.data;
     ChardevCommon *common = qapi_ChardevUdp_base(udp);
     QIOChannelSocket *sioc = qio_channel_socket_new();
     char *name;
-    CharDriverState *chr;
-    NetCharDriver *s;
+    Chardev *chr;
+    NetChardev *s;
 
     if (qio_channel_socket_dgram_sync(sioc,
                                       udp->local, udp->remote,
@@ -4926,7 +4927,7 @@ static CharDriverState *qmp_chardev_open_udp(const CharDriver *driver,
     qio_channel_set_name(QIO_CHANNEL(sioc), name);
     g_free(name);
 
-    s = (NetCharDriver *)chr;
+    s = (NetChardev *)chr;
     s->ioc = QIO_CHANNEL(sioc);
     /* be isn't opened until we get a connection */
     *be_opened = false;
@@ -4935,7 +4936,7 @@ static CharDriverState *qmp_chardev_open_udp(const CharDriver *driver,
 }
 
 static const CharDriver udp_driver = {
-    .instance_size = sizeof(NetCharDriver),
+    .instance_size = sizeof(NetChardev),
     .kind = CHARDEV_BACKEND_KIND_UDP,
     .parse = qemu_chr_parse_udp,
     .create = qmp_chardev_open_udp,
@@ -4944,13 +4945,13 @@ static const CharDriver udp_driver = {
     .chr_free = udp_chr_free,
 };
 
-bool qemu_chr_has_feature(CharDriverState *chr,
+bool qemu_chr_has_feature(Chardev *chr,
                           CharDriverFeature feature)
 {
     return test_bit(feature, chr->features);
 }
 
-void qemu_chr_set_feature(CharDriverState *chr,
+void qemu_chr_set_feature(Chardev *chr,
                            CharDriverFeature feature)
 {
     return set_bit(feature, chr->features);
@@ -4960,7 +4961,7 @@ ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
                                Error **errp)
 {
     ChardevReturn *ret = g_new0(ChardevReturn, 1);
-    CharDriverState *chr = NULL;
+    Chardev *chr = NULL;
     const CharDriver *cd;
     Error *local_err = NULL;
     bool be_opened = true;
@@ -5001,7 +5002,7 @@ out_error:
 
 void qmp_chardev_remove(const char *id, Error **errp)
 {
-    CharDriverState *chr;
+    Chardev *chr;
 
     chr = qemu_chr_find(id);
     if (chr == NULL) {
@@ -5022,7 +5023,7 @@ void qmp_chardev_remove(const char *id, Error **errp)
 
 void qemu_chr_cleanup(void)
 {
-    CharDriverState *chr, *tmp;
+    Chardev *chr, *tmp;
 
     QTAILQ_FOREACH_SAFE(chr, &chardevs, next, tmp) {
         qemu_chr_delete(chr);
diff --git a/qmp.c b/qmp.c
index 0028f0b..d955406 100644
--- a/qmp.c
+++ b/qmp.c
@@ -616,7 +616,7 @@ void qmp_add_client(const char *protocol, const char *fdname,
                     bool has_skipauth, bool skipauth, bool has_tls, bool tls,
                     Error **errp)
 {
-    CharDriverState *s;
+    Chardev *s;
     int fd;
 
     fd = monitor_get_fd(cur_mon, fdname, errp);
diff --git a/qtest.c b/qtest.c
index bd9d417..1446719 100644
--- a/qtest.c
+++ b/qtest.c
@@ -670,7 +670,7 @@ static int qtest_init_accel(MachineState *ms)
 
 void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **errp)
 {
-    CharDriverState *chr;
+    Chardev *chr;
 
     chr = qemu_chr_new("qtest", qtest_chrdev);
 
diff --git a/replay/replay-char.c b/replay/replay-char.c
index edf46ab..aa65955 100755
--- a/replay/replay-char.c
+++ b/replay/replay-char.c
@@ -18,7 +18,7 @@
 
 /* Char drivers that generate qemu_chr_be_write events
    that should be saved into the log. */
-static CharDriverState **char_drivers;
+static Chardev **char_drivers;
 static int drivers_count;
 
 /* Char event attributes. */
@@ -28,7 +28,7 @@ typedef struct CharEvent {
     size_t len;
 } CharEvent;
 
-static int find_char_driver(CharDriverState *chr)
+static int find_char_driver(Chardev *chr)
 {
     int i = 0;
     for ( ; i < drivers_count ; ++i) {
@@ -39,7 +39,7 @@ static int find_char_driver(CharDriverState *chr)
     return -1;
 }
 
-void replay_register_char_driver(CharDriverState *chr)
+void replay_register_char_driver(Chardev *chr)
 {
     if (replay_mode == REPLAY_MODE_NONE) {
         return;
@@ -49,7 +49,7 @@ void replay_register_char_driver(CharDriverState *chr)
     char_drivers[drivers_count++] = chr;
 }
 
-void replay_chr_be_write(CharDriverState *s, uint8_t *buf, int len)
+void replay_chr_be_write(Chardev *s, uint8_t *buf, int len)
 {
     CharEvent *event = g_malloc0(sizeof(CharEvent));
 
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 1aed451..38b1f6c 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -6,29 +6,29 @@
 #include <spice/protocol.h>
 
 
-typedef struct SpiceCharDriver {
-    CharDriverState       parent;
+typedef struct SpiceChardev {
+    Chardev               parent;
 
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
 
 typedef struct SpiceCharSource {
     GSource               source;
-    SpiceCharDriver       *scd;
+    SpiceChardev       *scd;
 } SpiceCharSource;
 
-static QLIST_HEAD(, SpiceCharDriver) spice_chars =
+static QLIST_HEAD(, SpiceChardev) spice_chars =
     QLIST_HEAD_INITIALIZER(spice_chars);
 
 static int vmc_write(SpiceCharDeviceInstance *sin, const uint8_t *buf, int len)
 {
-    SpiceCharDriver *scd = container_of(sin, SpiceCharDriver, sin);
-    CharDriverState *chr = (CharDriverState *)scd;
+    SpiceChardev *scd = container_of(sin, SpiceChardev, sin);
+    Chardev *chr = (Chardev *)scd;
     ssize_t out = 0;
     ssize_t last_out;
     uint8_t* p = (uint8_t*)buf;
@@ -51,7 +51,7 @@ static int vmc_write(SpiceCharDeviceInstance *sin, const uint8_t *buf, int len)
 
 static int vmc_read(SpiceCharDeviceInstance *sin, uint8_t *buf, int len)
 {
-    SpiceCharDriver *scd = container_of(sin, SpiceCharDriver, sin);
+    SpiceChardev *scd = container_of(sin, SpiceChardev, sin);
     int bytes = MIN(len, scd->datalen);
 
     if (bytes > 0) {
@@ -71,8 +71,8 @@ static int vmc_read(SpiceCharDeviceInstance *sin, uint8_t *buf, int len)
 #if SPICE_SERVER_VERSION >= 0x000c02
 static void vmc_event(SpiceCharDeviceInstance *sin, uint8_t event)
 {
-    SpiceCharDriver *scd = container_of(sin, SpiceCharDriver, sin);
-    CharDriverState *chr = (CharDriverState *)scd;
+    SpiceChardev *scd = container_of(sin, SpiceChardev, sin);
+    Chardev *chr = (Chardev *)scd;
     int chr_event;
 
     switch (event) {
@@ -90,8 +90,8 @@ static void vmc_event(SpiceCharDeviceInstance *sin, uint8_t event)
 
 static void vmc_state(SpiceCharDeviceInstance *sin, int connected)
 {
-    SpiceCharDriver *scd = container_of(sin, SpiceCharDriver, sin);
-    CharDriverState *chr = (CharDriverState *)scd;
+    SpiceChardev *scd = container_of(sin, SpiceChardev, sin);
+    Chardev *chr = (Chardev *)scd;
 
     if ((chr->be_open && connected) ||
         (!chr->be_open && !connected)) {
@@ -119,7 +119,7 @@ static SpiceCharDeviceInterface vmc_interface = {
 };
 
 
-static void vmc_register_interface(SpiceCharDriver *scd)
+static void vmc_register_interface(SpiceChardev *scd)
 {
     if (scd->active) {
         return;
@@ -130,7 +130,7 @@ static void vmc_register_interface(SpiceCharDriver *scd)
     trace_spice_vmc_register_interface(scd);
 }
 
-static void vmc_unregister_interface(SpiceCharDriver *scd)
+static void vmc_unregister_interface(SpiceChardev *scd)
 {
     if (!scd->active) {
         return;
@@ -170,9 +170,9 @@ static GSourceFuncs SpiceCharSourceFuncs = {
     .dispatch = spice_char_source_dispatch,
 };
 
-static GSource *spice_chr_add_watch(CharDriverState *chr, GIOCondition cond)
+static GSource *spice_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    SpiceCharDriver *scd = (SpiceCharDriver *)chr;
+    SpiceChardev *scd = (SpiceChardev *)chr;
     SpiceCharSource *src;
 
     assert(cond & G_IO_OUT);
@@ -184,9 +184,9 @@ static GSource *spice_chr_add_watch(CharDriverState *chr, GIOCondition cond)
     return (GSource *)src;
 }
 
-static int spice_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
+static int spice_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    SpiceCharDriver *s = (SpiceCharDriver *)chr;
+    SpiceChardev *s = (SpiceChardev *)chr;
     int read_bytes;
 
     assert(s->datalen == 0);
@@ -203,9 +203,9 @@ static int spice_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
     return read_bytes;
 }
 
-static void spice_chr_free(struct CharDriverState *chr)
+static void spice_chr_free(struct Chardev *chr)
 {
-    SpiceCharDriver *s = (SpiceCharDriver *)chr;
+    SpiceChardev *s = (SpiceChardev *)chr;
 
     vmc_unregister_interface(s);
     QLIST_REMOVE(s, next);
@@ -216,9 +216,9 @@ static void spice_chr_free(struct CharDriverState *chr)
 #endif
 }
 
-static void spice_vmc_set_fe_open(struct CharDriverState *chr, int fe_open)
+static void spice_vmc_set_fe_open(struct Chardev *chr, int fe_open)
 {
-    SpiceCharDriver *s = (SpiceCharDriver *)chr;
+    SpiceChardev *s = (SpiceChardev *)chr;
     if (fe_open) {
         vmc_register_interface(s);
     } else {
@@ -226,10 +226,10 @@ static void spice_vmc_set_fe_open(struct CharDriverState *chr, int fe_open)
     }
 }
 
-static void spice_port_set_fe_open(struct CharDriverState *chr, int fe_open)
+static void spice_port_set_fe_open(struct Chardev *chr, int fe_open)
 {
 #if SPICE_SERVER_VERSION >= 0x000c02
-    SpiceCharDriver *s = (SpiceCharDriver *)chr;
+    SpiceChardev *s = (SpiceChardev *)chr;
 
     if (fe_open) {
         spice_server_port_event(&s->sin, SPICE_PORT_EVENT_OPENED);
@@ -256,26 +256,26 @@ static void print_allowed_subtypes(void)
     fprintf(stderr, "\n");
 }
 
-static void spice_chr_accept_input(struct CharDriverState *chr)
+static void spice_chr_accept_input(struct Chardev *chr)
 {
-    SpiceCharDriver *s = (SpiceCharDriver *)chr;
+    SpiceChardev *s = (SpiceChardev *)chr;
 
     spice_server_char_device_wakeup(&s->sin);
 }
 
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
 
     chr = qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
-    s = (SpiceCharDriver *)chr;
+    s = (SpiceChardev *)chr;
     s->active = false;
     s->sin.subtype = g_strdup(subtype);
 
@@ -284,7 +284,7 @@ static CharDriverState *chr_open(const CharDriver *driver,
     return chr;
 }
 
-static CharDriverState *qemu_chr_open_spice_vmc(const CharDriver *driver,
+static Chardev *qemu_chr_open_spice_vmc(const CharDriver *driver,
                                                 const char *id,
                                                 ChardevBackend *backend,
                                                 ChardevReturn *ret,
@@ -312,7 +312,7 @@ static CharDriverState *qemu_chr_open_spice_vmc(const CharDriver *driver,
 }
 
 #if SPICE_SERVER_VERSION >= 0x000c02
-static CharDriverState *qemu_chr_open_spice_port(const CharDriver *driver,
+static Chardev *qemu_chr_open_spice_port(const CharDriver *driver,
                                                  const char *id,
                                                  ChardevBackend *backend,
                                                  ChardevReturn *ret,
@@ -322,8 +322,8 @@ static CharDriverState *qemu_chr_open_spice_port(const CharDriver *driver,
     ChardevSpicePort *spiceport = backend->u.spiceport.data;
     const char *name = spiceport->fqdn;
     ChardevCommon *common = qapi_ChardevSpicePort_base(spiceport);
-    CharDriverState *chr;
-    SpiceCharDriver *s;
+    Chardev *chr;
+    SpiceChardev *s;
 
     if (name == NULL) {
         fprintf(stderr, "spice-qemu-char: missing name parameter\n");
@@ -335,7 +335,7 @@ static CharDriverState *qemu_chr_open_spice_port(const CharDriver *driver,
         return NULL;
     }
     *be_opened = false;
-    s = (SpiceCharDriver *)chr;
+    s = (SpiceChardev *)chr;
     s->sin.portname = g_strdup(name);
 
     return chr;
@@ -343,7 +343,7 @@ static CharDriverState *qemu_chr_open_spice_port(const CharDriver *driver,
 
 void qemu_spice_register_ports(void)
 {
-    SpiceCharDriver *s;
+    SpiceChardev *s;
 
     QLIST_FOREACH(s, &spice_chars, next) {
         if (s->sin.portname == NULL) {
@@ -387,7 +387,7 @@ static void qemu_chr_parse_spice_port(QemuOpts *opts, ChardevBackend *backend,
 static void register_types(void)
 {
     static const CharDriver vmc_driver = {
-        .instance_size = sizeof(SpiceCharDriver),
+        .instance_size = sizeof(SpiceChardev),
         .kind = CHARDEV_BACKEND_KIND_SPICEVMC,
         .parse = qemu_chr_parse_spice_vmc,
         .create = qemu_chr_open_spice_vmc,
@@ -398,7 +398,7 @@ static void register_types(void)
         .chr_free = spice_chr_free,
     };
     static const CharDriver port_driver = {
-        .instance_size = sizeof(SpiceCharDriver),
+        .instance_size = sizeof(SpiceChardev),
         .kind = CHARDEV_BACKEND_KIND_SPICEPORT,
         .parse = qemu_chr_parse_spice_port,
         .create = qemu_chr_open_spice_port,
diff --git a/stubs/monitor.c b/stubs/monitor.c
index 1d574b1..e018c8f 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -11,6 +11,6 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
     return -1;
 }
 
-void monitor_init(CharDriverState *chr, int flags)
+void monitor_init(Chardev *chr, int flags)
 {
 }
diff --git a/stubs/replay.c b/stubs/replay.c
index d9a6da9..9c8aa48 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -30,11 +30,11 @@ void replay_finish(void)
 {
 }
 
-void replay_register_char_driver(CharDriverState *chr)
+void replay_register_char_driver(Chardev *chr)
 {
 }
 
-void replay_chr_be_write(CharDriverState *s, uint8_t *buf, int len)
+void replay_chr_be_write(Chardev *s, uint8_t *buf, int len)
 {
     abort();
 }
diff --git a/tests/test-char.c b/tests/test-char.c
index 241685a..da69f11 100644
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
     FeHandler h1 = { 0, }, h2 = { 0, };
     CharBackend chr_be1, chr_be2;
@@ -185,7 +185,7 @@ static void char_mux_test(void)
 static void char_null_test(void)
 {
     Error *err = NULL;
-    CharDriverState *chr;
+    Chardev *chr;
     CharBackend be;
     int ret;
 
@@ -227,7 +227,7 @@ static void char_null_test(void)
 
 static void char_invalid_test(void)
 {
-    CharDriverState *chr;
+    Chardev *chr;
 
     chr = qemu_chr_new("label-invalid", "invalid");
     g_assert_null(chr);
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 96bf00e..f3ac6ea 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -454,7 +454,7 @@ static void chr_event(void *opaque, int event)
 static void test_server_create_chr(TestServer *server, const gchar *opt)
 {
     gchar *chr_path;
-    CharDriverState *chr;
+    Chardev *chr;
 
     chr_path = g_strdup_printf("unix:%s%s", server->socket_path, opt);
     chr = qemu_chr_new(server->chr_name, chr_path);
@@ -486,7 +486,7 @@ static inline void test_server_connect(TestServer *server)
 static gboolean _test_server_free(TestServer *server)
 {
     int i;
-    CharDriverState *chr = qemu_chr_fe_get_driver(&server->chr);
+    Chardev *chr = qemu_chr_fe_get_driver(&server->chr);
 
     qemu_chr_fe_deinit(&server->chr);
     qemu_chr_delete(chr);
diff --git a/ui/console.c b/ui/console.c
index 495d5a2..7420f28 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -158,7 +158,7 @@ struct QemuConsole {
     int esc_params[MAX_ESC_PARAMS];
     int nb_esc_params;
 
-    CharDriverState *chr;
+    Chardev *chr;
     /* fifo for key pressed */
     QEMUFIFO out_fifo;
     uint8_t out_fifo_buf[16];
@@ -183,7 +183,7 @@ static int nb_consoles = 0;
 static bool cursor_visible_phase;
 static QEMUTimer *cursor_timer;
 
-static void text_console_do_init(CharDriverState *chr, DisplayState *ds);
+static void text_console_do_init(Chardev *chr, DisplayState *ds);
 static void dpy_refresh(DisplayState *s);
 static DisplayState *get_alloc_displaystate(void);
 static void text_console_update_cursor_timer(void);
@@ -1046,14 +1046,14 @@ void console_select(unsigned int index)
     }
 }
 
-typedef struct VCDriverState {
-    CharDriverState parent;
+typedef struct VCChardev {
+    Chardev parent;
     QemuConsole *console;
-} VCDriverState;
+} VCChardev;
 
-static int console_puts(CharDriverState *chr, const uint8_t *buf, int len)
+static int console_puts(Chardev *chr, const uint8_t *buf, int len)
 {
-    VCDriverState *drv = (VCDriverState *)chr;
+    VCChardev *drv = (VCChardev *)chr;
     QemuConsole *s = drv->console;
     int i;
 
@@ -1962,9 +1962,9 @@ int qemu_console_get_height(QemuConsole *con, int fallback)
     return con ? surface_height(con->surface) : fallback;
 }
 
-static void text_console_set_echo(CharDriverState *chr, bool echo)
+static void text_console_set_echo(Chardev *chr, bool echo)
 {
-    VCDriverState *drv = (VCDriverState *)chr;
+    VCChardev *drv = (VCChardev *)chr;
     QemuConsole *s = drv->console;
 
     s->echo = echo;
@@ -2003,9 +2003,9 @@ static const GraphicHwOps text_console_ops = {
     .text_update = text_console_update,
 };
 
-static void text_console_do_init(CharDriverState *chr, DisplayState *ds)
+static void text_console_do_init(Chardev *chr, DisplayState *ds)
 {
-    VCDriverState *drv = (VCDriverState *)chr;
+    VCChardev *drv = (VCChardev *)chr;
     QemuConsole *s = drv->console;
     int g_width = 80 * FONT_WIDTH;
     int g_height = 24 * FONT_HEIGHT;
@@ -2058,11 +2058,11 @@ static void text_console_do_init(CharDriverState *chr, DisplayState *ds)
 
 static const CharDriver vc_driver;
 
-static CharDriverState *text_console_init(ChardevVC *vc, Error **errp)
+static Chardev *text_console_init(ChardevVC *vc, Error **errp)
 {
     ChardevCommon *common = qapi_ChardevVC_base(vc);
-    CharDriverState *chr;
-    VCDriverState *drv;
+    Chardev *chr;
+    VCChardev *drv;
     QemuConsole *s;
     unsigned width = 0;
     unsigned height = 0;
@@ -2099,7 +2099,7 @@ static CharDriverState *text_console_init(ChardevVC *vc, Error **errp)
     }
 
     s->chr = chr;
-    drv = (VCDriverState *)chr;
+    drv = (VCChardev *)chr;
     drv->console = s;
 
     if (display_state) {
@@ -2110,10 +2110,10 @@ static CharDriverState *text_console_init(ChardevVC *vc, Error **errp)
 
 static VcHandler *vc_handler = text_console_init;
 
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
@@ -2204,7 +2204,7 @@ static const TypeInfo qemu_console_info = {
 };
 
 static const CharDriver vc_driver = {
-    .instance_size = sizeof(VCDriverState),
+    .instance_size = sizeof(VCChardev),
     .kind = CHARDEV_BACKEND_KIND_VC,
     .parse = qemu_chr_parse_vc,
     .create = vc_init,
diff --git a/ui/gtk.c b/ui/gtk.c
index 90cf4d5..175871a 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -181,11 +181,11 @@ struct GtkDisplayState {
     bool ignore_keys;
 };
 
-typedef struct VCDriverState {
-    CharDriverState parent;
+typedef struct VCChardev {
+    Chardev parent;
     VirtualConsole *console;
     bool echo;
-} VCDriverState;
+} VCChardev;
 
 static void gd_grab_pointer(VirtualConsole *vc, const char *reason);
 static void gd_ungrab_pointer(GtkDisplayState *s);
@@ -1689,18 +1689,18 @@ static void gd_vc_adjustment_changed(GtkAdjustment *adjustment, void *opaque)
     }
 }
 
-static int gd_vc_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
+static int gd_vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    VCDriverState *vcd = (VCDriverState *)chr;
+    VCChardev *vcd = (VCChardev *)chr;
     VirtualConsole *vc = vcd->console;
 
     vte_terminal_feed(VTE_TERMINAL(vc->vte.terminal), (const char *)buf, len);
     return len;
 }
 
-static void gd_vc_chr_set_echo(CharDriverState *chr, bool echo)
+static void gd_vc_chr_set_echo(Chardev *chr, bool echo)
 {
-    VCDriverState *vcd = (VCDriverState *)chr;
+    VCChardev *vcd = (VCChardev *)chr;
     VirtualConsole *vc = vcd->console;
 
     if (vc) {
@@ -1711,19 +1711,19 @@ static void gd_vc_chr_set_echo(CharDriverState *chr, bool echo)
 }
 
 static int nb_vcs;
-static CharDriverState *vcs[MAX_VCS];
+static Chardev *vcs[MAX_VCS];
 
-static CharDriverState *gd_vc_handler(ChardevVC *vc, Error **errp)
+static Chardev *gd_vc_handler(ChardevVC *vc, Error **errp)
 {
     static const CharDriver gd_vc_driver = {
-        .instance_size = sizeof(VCDriverState),
+        .instance_size = sizeof(VCChardev),
         .kind = CHARDEV_BACKEND_KIND_VC,
         .chr_write = gd_vc_chr_write,
         .chr_set_echo = gd_vc_chr_set_echo,
     };
 
     ChardevCommon *common = qapi_ChardevVC_base(vc);
-    CharDriverState *chr;
+    Chardev *chr;
 
     if (nb_vcs == MAX_VCS) {
         error_setg(errp, "Maximum number of consoles reached");
@@ -1768,14 +1768,14 @@ static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
 }
 
 static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
-                              CharDriverState *chr, int idx,
+                              Chardev *chr, int idx,
                               GSList *group, GtkWidget *view_menu)
 {
     char buffer[32];
     GtkWidget *box;
     GtkWidget *scrollbar;
     GtkAdjustment *vadjustment;
-    VCDriverState *vcd = (VCDriverState *)chr;
+    VCChardev *vcd = (VCChardev *)chr;
 
     vc->s = s;
     vc->vte.echo = vcd->echo;
diff --git a/vl.c b/vl.c
index bc8e837..41be59f 100644
--- a/vl.c
+++ b/vl.c
@@ -151,10 +151,10 @@ static int full_screen = 0;
 static int no_frame = 0;
 int no_quit = 0;
 static bool grab_on_hover;
-CharDriverState *serial_hds[MAX_SERIAL_PORTS];
-CharDriverState *parallel_hds[MAX_PARALLEL_PORTS];
-CharDriverState *virtcon_hds[MAX_VIRTIO_CONSOLES];
-CharDriverState *sclp_hds[MAX_SCLP_CONSOLES];
+Chardev *serial_hds[MAX_SERIAL_PORTS];
+Chardev *parallel_hds[MAX_PARALLEL_PORTS];
+Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
+Chardev *sclp_hds[MAX_SCLP_CONSOLES];
 int win2k_install_hack = 0;
 int singlestep = 0;
 int smp_cpus = 1;
@@ -2321,7 +2321,7 @@ static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 
 static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
-    CharDriverState *chr;
+    Chardev *chr;
     const char *chardev;
     const char *mode;
     int flags;
diff --git a/xen-common-stub.c b/xen-common-stub.c
index 699c3f1..09fce2d 100644
--- a/xen-common-stub.c
+++ b/xen-common-stub.c
@@ -9,6 +9,6 @@
 #include "qemu-common.h"
 #include "hw/xen/xen.h"
 
-void xenstore_store_pv_console_info(int i, CharDriverState *chr)
+void xenstore_store_pv_console_info(int i, Chardev *chr)
 {
 }
diff --git a/xen-common.c b/xen-common.c
index 9099760..fd2c928 100644
--- a/xen-common.c
+++ b/xen-common.c
@@ -25,7 +25,7 @@
     do { } while (0)
 #endif
 
-static int store_dev_info(int domid, CharDriverState *cs, const char *string)
+static int store_dev_info(int domid, Chardev *cs, const char *string)
 {
     struct xs_handle *xs = NULL;
     char *path = NULL;
@@ -74,7 +74,7 @@ out:
     return ret;
 }
 
-void xenstore_store_pv_console_info(int i, CharDriverState *chr)
+void xenstore_store_pv_console_info(int i, Chardev *chr)
 {
     if (i == 0) {
         store_dev_info(xen_domid, chr, "/console");
-- 
1.8.3.1
