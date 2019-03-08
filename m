Received: from eggs.gnu.org ([209.51.188.92]:43238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2C5C-0002L7-F4
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2C5A-0006Iq-RU
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:46:26 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Mar 2019 10:45:59 +0100
Message-Id: <20190308094610.21210-5-armbru@redhat.com>
In-Reply-To: <20190308094610.21210-1-armbru@redhat.com>
References: <20190308094610.21210-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 04/15] pflash: Rename *CFI_PFLASH* to
 *PFLASH_CFI*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, philmd@redhat.com, balaton@eik.bme.hu

pflash_cfi01.c and pflash_cfi02.c start their identifiers with
pflash_cfi01_ and pflash_cfi02_ respectively, except for
CFI_PFLASH01(), TYPE_CFI_PFLASH01, CFI_PFLASH02(), TYPE_CFI_PFLASH02.
Rename for consistency.

Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 hw/block/pflash_cfi01.c  | 12 ++++++------
 hw/block/pflash_cfi02.c  | 14 +++++++-------
 include/hw/block/flash.h |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index d381f14e3c..f75f0a6998 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -59,8 +59,8 @@ do {                                                   =
     \
 #define DPRINTF(fmt, ...) do { } while (0)
 #endif
=20
-#define CFI_PFLASH01(obj) \
-    OBJECT_CHECK(PFlashCFI01, (obj), TYPE_CFI_PFLASH01)
+#define PFLASH_CFI01(obj) \
+    OBJECT_CHECK(PFlashCFI01, (obj), TYPE_PFLASH_CFI01)
=20
 #define PFLASH_BE          0
 #define PFLASH_SECURE      1
@@ -698,7 +698,7 @@ static const MemoryRegionOps pflash_cfi01_ops =3D {
=20
 static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
 {
-    PFlashCFI01 *pfl =3D CFI_PFLASH01(dev);
+    PFlashCFI01 *pfl =3D PFLASH_CFI01(dev);
     uint64_t total_len;
     int ret;
     uint64_t blocks_per_device, sector_len_per_device, device_len;
@@ -926,7 +926,7 @@ static void pflash_cfi01_class_init(ObjectClass *klas=
s, void *data)
=20
=20
 static const TypeInfo pflash_cfi01_info =3D {
-    .name           =3D TYPE_CFI_PFLASH01,
+    .name           =3D TYPE_PFLASH_CFI01,
     .parent         =3D TYPE_SYS_BUS_DEVICE,
     .instance_size  =3D sizeof(PFlashCFI01),
     .class_init     =3D pflash_cfi01_class_init,
@@ -949,7 +949,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
                                    uint16_t id2, uint16_t id3,
                                    int be)
 {
-    DeviceState *dev =3D qdev_create(NULL, TYPE_CFI_PFLASH01);
+    DeviceState *dev =3D qdev_create(NULL, TYPE_PFLASH_CFI01);
=20
     if (blk) {
         qdev_prop_set_drive(dev, "drive", blk, &error_abort);
@@ -966,7 +966,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
     qdev_init_nofail(dev);
=20
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-    return CFI_PFLASH01(dev);
+    return PFLASH_CFI01(dev);
 }
=20
 MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl)
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index df32e20bd7..933de99d6a 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -57,8 +57,8 @@ do {                                                   =
    \
=20
 #define PFLASH_LAZY_ROMD_THRESHOLD 42
=20
-#define CFI_PFLASH02(obj) \
-    OBJECT_CHECK(PFlashCFI02, (obj), TYPE_CFI_PFLASH02)
+#define PFLASH_CFI02(obj) \
+    OBJECT_CHECK(PFlashCFI02, (obj), TYPE_PFLASH_CFI02)
=20
 struct PFlashCFI02 {
     /*< private >*/
@@ -534,7 +534,7 @@ static const MemoryRegionOps pflash_cfi02_ops_le =3D =
{
=20
 static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
 {
-    PFlashCFI02 *pfl =3D CFI_PFLASH02(dev);
+    PFlashCFI02 *pfl =3D PFLASH_CFI02(dev);
     uint32_t chip_len;
     int ret;
     Error *local_err =3D NULL;
@@ -698,7 +698,7 @@ static Property pflash_cfi02_properties[] =3D {
=20
 static void pflash_cfi02_unrealize(DeviceState *dev, Error **errp)
 {
-    PFlashCFI02 *pfl =3D CFI_PFLASH02(dev);
+    PFlashCFI02 *pfl =3D PFLASH_CFI02(dev);
     timer_del(&pfl->timer);
 }
=20
@@ -713,7 +713,7 @@ static void pflash_cfi02_class_init(ObjectClass *klas=
s, void *data)
 }
=20
 static const TypeInfo pflash_cfi02_info =3D {
-    .name           =3D TYPE_CFI_PFLASH02,
+    .name           =3D TYPE_PFLASH_CFI02,
     .parent         =3D TYPE_SYS_BUS_DEVICE,
     .instance_size  =3D sizeof(PFlashCFI02),
     .class_init     =3D pflash_cfi02_class_init,
@@ -738,7 +738,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
                                    uint16_t unlock_addr1,
                                    int be)
 {
-    DeviceState *dev =3D qdev_create(NULL, TYPE_CFI_PFLASH02);
+    DeviceState *dev =3D qdev_create(NULL, TYPE_PFLASH_CFI02);
=20
     if (blk) {
         qdev_prop_set_drive(dev, "drive", blk, &error_abort);
@@ -758,5 +758,5 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
     qdev_init_nofail(dev);
=20
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-    return CFI_PFLASH02(dev);
+    return PFLASH_CFI02(dev);
 }
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 51d8f60c65..333005d9ff 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -7,7 +7,7 @@
=20
 /* pflash_cfi01.c */
=20
-#define TYPE_CFI_PFLASH01 "cfi.pflash01"
+#define TYPE_PFLASH_CFI01 "cfi.pflash01"
=20
 typedef struct PFlashCFI01 PFlashCFI01;
=20
@@ -24,7 +24,7 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
=20
 /* pflash_cfi02.c */
=20
-#define TYPE_CFI_PFLASH02 "cfi.pflash02"
+#define TYPE_PFLASH_CFI02 "cfi.pflash02"
=20
 typedef struct PFlashCFI02 PFlashCFI02;
=20
--=20
2.17.2
