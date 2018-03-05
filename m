Received: from eggs.gnu.org ([2001:4830:134:3::10]:49232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWL-0004FZ-4v
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWK-0001Ux-7P
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:19:45 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 18:19:10 -0300
Message-Id: <20180305211928.466-5-f4bug@amsat.org>
In-Reply-To: <20180305211928.466-1-f4bug@amsat.org>
References: <20180305211928.466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 04/22] hw/isa/pc87312: Rename the device
 type as TYPE_PC87312_SUPERIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:PReP" <qemu-ppc@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/pc87312.h | 4 ++--
 hw/isa/pc87312.c         | 2 +-
 hw/ppc/prep.c            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

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
index ae724b0613..610ec7ec32 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -613,7 +613,7 @@ static void ppc_prep_init(MachineState *machine)
     isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci), "isa.0"));
 
     /* Super I/O (parallel + serial ports) */
-    isa = isa_create(isa_bus, TYPE_PC87312);
+    isa = isa_create(isa_bus, TYPE_PC87312_SUPERIO);
     dev = DEVICE(isa);
     qdev_prop_set_uint8(dev, "config", 13); /* fdc, ser0, ser1, par0 */
     qdev_init_nofail(dev);
-- 
2.16.2
