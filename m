Received: from eggs.gnu.org ([2001:4830:134:3::10]:51323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSR-0006mt-Av
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSP-0002P4-Br
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:39 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:39486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSP-0002Ov-7R
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:37 -0500
Received: by mail-qt0-x242.google.com with SMTP id k19so12087600qtj.6
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:46:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:37 -0300
Message-Id: <20180108024558.17983-9-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/29] hw/mips/fulong2e: use isa_superio_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_fulong2e.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 8660d078c8..2f4cc5d05e 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -23,13 +23,10 @@
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/dma/i8257.h"
-#include "hw/char/serial.h"
-#include "hw/char/parallel.h"
-#include "hw/block/fdc.h"
+#include "hw/isa/superio.h"
 #include "net/net.h"
 #include "hw/boards.h"
 #include "hw/i2c/smbus.h"
-#include "sysemu/block-backend.h"
 #include "hw/block/flash.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
@@ -44,7 +41,6 @@
 #include "hw/isa/vt82c686.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/timer/i8254.h"
-#include "hw/input/i8042.h"
 #include "sysemu/blockdev.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
@@ -366,13 +362,10 @@ static void mips_fulong2e_init(MachineState *machine)
     i8257_dma_init(isa_bus, 0);
 
     /* Super I/O */
-    isa_create_simple(isa_bus, TYPE_I8042);
+    isa_superio_init(isa_bus, MAX_SERIAL_PORTS, 1, 0);
 
     mc146818_rtc_init(isa_bus, 2000, NULL);
 
-    serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
-    parallel_hds_isa_init(isa_bus, 1);
-
     /* Sound card */
     audio_init(pci_bus);
     /* Network card */
-- 
2.15.1
