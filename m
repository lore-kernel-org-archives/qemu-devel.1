Received: from eggs.gnu.org ([209.51.188.92]:53807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCAbM-0007qD-MZ
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCAbL-0006aN-CJ
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:12:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCAbL-0006Zy-1S
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:12:51 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  5 Apr 2019 00:12:35 +0200
Message-Id: <20190404221238.12468-2-philmd@redhat.com>
In-Reply-To: <20190404221238.12468-1-philmd@redhat.com>
References: <20190404221238.12468-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.1 1/4] hw/isa/superio: Rename a variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This patch is purely cosmetic. No functional change.
This will ease the next patch where we re-indent an if() statement.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/isa/isa-superio.c | 69 ++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index d54463bf035..c6845eaf578 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -22,8 +22,8 @@
=20
 static void isa_superio_realize(DeviceState *dev, Error **errp)
 {
-    ISASuperIODevice *sio =3D ISA_SUPERIO(dev);
-    ISASuperIOClass *k =3D ISA_SUPERIO_GET_CLASS(sio);
+    ISASuperIODevice *s =3D ISA_SUPERIO(dev);
+    ISASuperIOClass *k =3D ISA_SUPERIO_GET_CLASS(s);
     ISABus *bus =3D isa_bus_from_device(ISA_DEVICE(dev));
     ISADevice *isa;
     DeviceState *d;
@@ -34,12 +34,12 @@ static void isa_superio_realize(DeviceState *dev, Err=
or **errp)
=20
     /* Parallel port */
     for (i =3D 0; i < k->parallel.count; i++) {
-        if (i >=3D ARRAY_SIZE(sio->parallel)) {
+        if (i >=3D ARRAY_SIZE(s->parallel)) {
             warn_report("superio: ignoring %td parallel controllers",
-                        k->parallel.count - ARRAY_SIZE(sio->parallel));
+                        k->parallel.count - ARRAY_SIZE(s->parallel));
             break;
         }
-        if (!k->parallel.is_enabled || k->parallel.is_enabled(sio, i)) {
+        if (!k->parallel.is_enabled || k->parallel.is_enabled(s, i)) {
             /* FIXME use a qdev chardev prop instead of parallel_hds[] *=
/
             chr =3D parallel_hds[i];
             if (chr =3D=3D NULL) {
@@ -53,33 +53,33 @@ static void isa_superio_realize(DeviceState *dev, Err=
or **errp)
             qdev_prop_set_uint32(d, "index", i);
             if (k->parallel.get_iobase) {
                 qdev_prop_set_uint32(d, "iobase",
-                                     k->parallel.get_iobase(sio, i));
+                                     k->parallel.get_iobase(s, i));
             }
             if (k->parallel.get_irq) {
-                qdev_prop_set_uint32(d, "irq", k->parallel.get_irq(sio, =
i));
+                qdev_prop_set_uint32(d, "irq", k->parallel.get_irq(s, i)=
);
             }
             qdev_prop_set_chr(d, "chardev", chr);
             qdev_init_nofail(d);
-            sio->parallel[i] =3D isa;
+            s->parallel[i] =3D isa;
             trace_superio_create_parallel(i,
                                           k->parallel.get_iobase ?
-                                          k->parallel.get_iobase(sio, i)=
 : -1,
+                                          k->parallel.get_iobase(s, i) :=
 -1,
                                           k->parallel.get_irq ?
-                                          k->parallel.get_irq(sio, i) : =
-1);
+                                          k->parallel.get_irq(s, i) : -1=
);
             object_property_add_child(OBJECT(dev), name,
-                                      OBJECT(sio->parallel[i]), NULL);
+                                      OBJECT(s->parallel[i]), NULL);
             g_free(name);
         }
     }
=20
     /* Serial */
     for (i =3D 0; i < k->serial.count; i++) {
-        if (i >=3D ARRAY_SIZE(sio->serial)) {
+        if (i >=3D ARRAY_SIZE(s->serial)) {
             warn_report("superio: ignoring %td serial controllers",
-                        k->serial.count - ARRAY_SIZE(sio->serial));
+                        k->serial.count - ARRAY_SIZE(s->serial));
             break;
         }
-        if (!k->serial.is_enabled || k->serial.is_enabled(sio, i)) {
+        if (!k->serial.is_enabled || k->serial.is_enabled(s, i)) {
             /* FIXME use a qdev chardev prop instead of serial_hd() */
             chr =3D serial_hd(i);
             if (chr =3D=3D NULL) {
@@ -92,35 +92,34 @@ static void isa_superio_realize(DeviceState *dev, Err=
or **errp)
             d =3D DEVICE(isa);
             qdev_prop_set_uint32(d, "index", i);
             if (k->serial.get_iobase) {
-                qdev_prop_set_uint32(d, "iobase",
-                                     k->serial.get_iobase(sio, i));
+                qdev_prop_set_uint32(d, "iobase", k->serial.get_iobase(s=
, i));
             }
             if (k->serial.get_irq) {
-                qdev_prop_set_uint32(d, "irq", k->serial.get_irq(sio, i)=
);
+                qdev_prop_set_uint32(d, "irq", k->serial.get_irq(s, i));
             }
             qdev_prop_set_chr(d, "chardev", chr);
             qdev_init_nofail(d);
-            sio->serial[i] =3D isa;
+            s->serial[i] =3D isa;
             trace_superio_create_serial(i,
                                         k->serial.get_iobase ?
-                                        k->serial.get_iobase(sio, i) : -=
1,
+                                        k->serial.get_iobase(s, i) : -1,
                                         k->serial.get_irq ?
-                                        k->serial.get_irq(sio, i) : -1);
+                                        k->serial.get_irq(s, i) : -1);
             object_property_add_child(OBJECT(dev), name,
-                                      OBJECT(sio->serial[0]), NULL);
+                                      OBJECT(s->serial[0]), NULL);
             g_free(name);
         }
     }
=20
     /* Floppy disc */
-    if (!k->floppy.is_enabled || k->floppy.is_enabled(sio, 0)) {
+    if (!k->floppy.is_enabled || k->floppy.is_enabled(s, 0)) {
         isa =3D isa_create(bus, "isa-fdc");
         d =3D DEVICE(isa);
         if (k->floppy.get_iobase) {
-            qdev_prop_set_uint32(d, "iobase", k->floppy.get_iobase(sio, =
0));
+            qdev_prop_set_uint32(d, "iobase", k->floppy.get_iobase(s, 0)=
);
         }
         if (k->floppy.get_irq) {
-            qdev_prop_set_uint32(d, "irq", k->floppy.get_irq(sio, 0));
+            qdev_prop_set_uint32(d, "irq", k->floppy.get_irq(s, 0));
         }
         /* FIXME use a qdev drive property instead of drive_get() */
         drive =3D drive_get(IF_FLOPPY, 0, 0);
@@ -135,37 +134,37 @@ static void isa_superio_realize(DeviceState *dev, E=
rror **errp)
                                 &error_fatal);
         }
         qdev_init_nofail(d);
-        sio->floppy =3D isa;
+        s->floppy =3D isa;
         trace_superio_create_floppy(0,
                                     k->floppy.get_iobase ?
-                                    k->floppy.get_iobase(sio, 0) : -1,
+                                    k->floppy.get_iobase(s, 0) : -1,
                                     k->floppy.get_irq ?
-                                    k->floppy.get_irq(sio, 0) : -1);
+                                    k->floppy.get_irq(s, 0) : -1);
     }
=20
     /* Keyboard, mouse */
-    sio->kbc =3D isa_create_simple(bus, TYPE_I8042);
+    s->kbc =3D isa_create_simple(bus, TYPE_I8042);
=20
     /* IDE */
-    if (k->ide.count && (!k->ide.is_enabled || k->ide.is_enabled(sio, 0)=
)) {
+    if (k->ide.count && (!k->ide.is_enabled || k->ide.is_enabled(s, 0)))=
 {
         isa =3D isa_create(bus, "isa-ide");
         d =3D DEVICE(isa);
         if (k->ide.get_iobase) {
-            qdev_prop_set_uint32(d, "iobase", k->ide.get_iobase(sio, 0))=
;
+            qdev_prop_set_uint32(d, "iobase", k->ide.get_iobase(s, 0));
         }
         if (k->ide.get_iobase) {
-            qdev_prop_set_uint32(d, "iobase2", k->ide.get_iobase(sio, 1)=
);
+            qdev_prop_set_uint32(d, "iobase2", k->ide.get_iobase(s, 1));
         }
         if (k->ide.get_irq) {
-            qdev_prop_set_uint32(d, "irq", k->ide.get_irq(sio, 0));
+            qdev_prop_set_uint32(d, "irq", k->ide.get_irq(s, 0));
         }
         qdev_init_nofail(d);
-        sio->ide =3D isa;
+        s->ide =3D isa;
         trace_superio_create_ide(0,
                                  k->ide.get_iobase ?
-                                 k->ide.get_iobase(sio, 0) : -1,
+                                 k->ide.get_iobase(s, 0) : -1,
                                  k->ide.get_irq ?
-                                 k->ide.get_irq(sio, 0) : -1);
+                                 k->ide.get_irq(s, 0) : -1);
     }
 }
=20
--=20
2.20.1
