Received: from eggs.gnu.org ([2001:4830:134:3::10]:45557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQjrZ-000436-FL
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 20:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQjrU-0007RS-RG
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 20:05:01 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:55 +0300
Message-Id: <9814e95fcf4568b6b0be5ae1e1d38db4dd5aa5c2.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 50/61] hw/timer/i8254: rename pit_init() ->
 i8254_pit_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

and remove the old i386/pc dependency

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 hw/alpha/dp264.c                  | 2 +-
 hw/i386/pc.c                      | 2 +-
 hw/isa/i82378.c                   | 2 +-
 hw/mips/mips_fulong2e.c           | 2 +-
 hw/mips/mips_jazz.c               | 2 +-
 hw/mips/mips_malta.c              | 2 +-
 hw/mips/mips_r4k.c                | 2 +-
 hw/timer/i8254.c                  | 1 -
 hw/timer/i8254_common.c           | 1 -
 include/hw/timer/i8254.h          | 5 +++--
 include/hw/timer/i8254_internal.h | 2 +-
 11 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index babd6ea514..887a7401f1 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -80,7 +80,7 @@ static void clipper_init(MachineState *machine)
     /* Since we have an SRM-compatible PALcode, use the SRM epoch.  */
     rtc_init(isa_bus, 1900, rtc_irq);
=20
-    pit_init(isa_bus, 0x40, 0, NULL);
+    i8254_pit_init(isa_bus, 0x40, 0, NULL);
     isa_create_simple(isa_bus, "i8042");
=20
     /* VGA setup.  Don't bother loading the bios.  */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 186545d2a4..6a6041573f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1573,7 +1573,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq=
 *gsi,
         if (kvm_pit_in_kernel()) {
             pit =3D kvm_pit_init(isa_bus, 0x40);
         } else {
-            pit =3D pit_init(isa_bus, 0x40, pit_isa_irq, pit_alt_irq);
+            pit =3D i8254_pit_init(isa_bus, 0x40, pit_isa_irq, pit_alt_i=
rq);
         }
         if (hpet) {
             /* connect PIT to output control line of the HPET */
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index d20ea4c2ee..a9c15f858d 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -97,7 +97,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp=
)
     isa_bus_irqs(isabus, s->i8259);
=20
     /* 1 82C54 (pit) */
-    isa =3D pit_init(isabus, 0x40, 0, NULL);
+    isa =3D i8254_pit_init(isabus, 0x40, 0, NULL);
=20
     /* speaker */
     pcspk_init(isabus, isa);
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 146cf0fccd..2a2a09c9de 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -359,7 +359,7 @@ static void mips_fulong2e_init(MachineState *machine)
     smbus_eeprom_init(smbus, 1, eeprom_spd, sizeof(eeprom_spd));
=20
     /* init other devices */
-    pit =3D pit_init(isa_bus, 0x40, 0, NULL);
+    pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
     DMA_init(isa_bus, 0);
=20
     /* Super I/O */
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index fe4f17389f..995419344d 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -218,7 +218,7 @@ static void mips_jazz_init(MachineState *machine,
     i8259 =3D i8259_init(isa_bus, env->irq[4]);
     isa_bus_irqs(isa_bus, i8259);
     DMA_init(isa_bus, 0);
-    pit =3D pit_init(isa_bus, 0x40, 0, NULL);
+    pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
     pcspk_init(isa_bus, pit);
=20
     /* Video card */
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index ec6af4a277..88b4733743 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1208,7 +1208,7 @@ void mips_malta_init(MachineState *machine)
                           isa_get_irq(NULL, 9), NULL, 0, NULL);
     smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
     g_free(smbus_eeprom_buf);
-    pit =3D pit_init(isa_bus, 0x40, 0, NULL);
+    pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
     DMA_init(isa_bus, 0);
=20
     /* Super I/O */
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 3bbb1827e1..58d7bac18b 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -272,7 +272,7 @@ void mips_r4k_init(MachineState *machine)
=20
     rtc_init(isa_bus, 2000, NULL);
=20
-    pit =3D pit_init(isa_bus, 0x40, 0, NULL);
+    pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
=20
     serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
=20
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index 5e61ad50a8..dbc4a0baec 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -23,7 +23,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "qemu/timer.h"
 #include "hw/timer/i8254.h"
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index b623c96198..6190b6fc5d 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -24,7 +24,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "qemu/timer.h"
 #include "hw/timer/i8254.h"
diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
index 5adae9fa44..5b12eb918e 100644
--- a/include/hw/timer/i8254.h
+++ b/include/hw/timer/i8254.h
@@ -26,6 +26,7 @@
 #define HW_I8254_H
=20
 #include "hw/hw.h"
+#include "hw/qdev.h"
 #include "hw/isa/isa.h"
=20
 #define PIT_FREQ 1193182
@@ -48,8 +49,8 @@ typedef struct PITChannelInfo {
 #define TYPE_I8254 "isa-pit"
 #define TYPE_KVM_I8254 "kvm-pit"
=20
-static inline ISADevice *pit_init(ISABus *bus, int base, int isa_irq,
-                                  qemu_irq alt_irq)
+static inline ISADevice *i8254_pit_init(ISABus *bus, int base, int isa_i=
rq,
+                                        qemu_irq alt_irq)
 {
     DeviceState *dev;
     ISADevice *d;
diff --git a/include/hw/timer/i8254_internal.h b/include/hw/timer/i8254_i=
nternal.h
index dc09cc0467..c37a438f82 100644
--- a/include/hw/timer/i8254_internal.h
+++ b/include/hw/timer/i8254_internal.h
@@ -26,8 +26,8 @@
 #define QEMU_I8254_INTERNAL_H
=20
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
+#include "qemu/timer.h"
=20
 typedef struct PITChannelState {
     int count; /* can be 65536 */
--=20
2.11.0
