Received: from eggs.gnu.org ([2001:4830:134:3::10]:58183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiB-0005sW-Oo
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiA-0003X4-LB
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:03 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:45855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiA-0003VO-Dd
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:02 -0400
Received: by mail-wr0-x243.google.com with SMTP id h2so2479921wre.12
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:02 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:41 +0100
Message-Id: <20180313224719.4954-32-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/69] hw/isa/pc87312: Rename the device type as
 TYPE_PC87312_SUPERIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au> (hw/ppc)
Message-Id: <20180308223946.26784-6-f4bug@amsat.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/pc87312.c         | 2 +-
 hw/ppc/prep.c            | 2 +-
 include/hw/isa/pc87312.h | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 48b29e3c3c..e9edbc6c50 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -391,7 +391,7 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo pc87312_type_info = {
-    .name          = TYPE_PC87312,
+    .name          = TYPE_PC87312_SUPERIO,
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(PC87312State),
     .instance_init = pc87312_initfn,
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 85b4fae3c7..df774bd384 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -612,7 +612,7 @@ static void ppc_prep_init(MachineState *machine)
     isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci), "isa.0"));
 
     /* Super I/O (parallel + serial ports) */
-    isa = isa_create(isa_bus, TYPE_PC87312);
+    isa = isa_create(isa_bus, TYPE_PC87312_SUPERIO);
     dev = DEVICE(isa);
     qdev_prop_set_uint8(dev, "config", 13); /* fdc, ser0, ser1, par0 */
     qdev_init_nofail(dev);
diff --git a/include/hw/isa/pc87312.h b/include/hw/isa/pc87312.h
index bf74470d40..710eb1c807 100644
--- a/include/hw/isa/pc87312.h
+++ b/include/hw/isa/pc87312.h
@@ -28,8 +28,8 @@
 #include "hw/isa/isa.h"
 
 
-#define TYPE_PC87312 "pc87312"
-#define PC87312(obj) OBJECT_CHECK(PC87312State, (obj), TYPE_PC87312)
+#define TYPE_PC87312_SUPERIO "pc87312"
+#define PC87312(obj) OBJECT_CHECK(PC87312State, (obj), TYPE_PC87312_SUPERIO)
 
 typedef struct PC87312State {
     ISADevice dev;
-- 
2.14.3
