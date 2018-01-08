Received: from eggs.gnu.org ([2001:4830:134:3::10]:51885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTc-0007rn-Cs
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTZ-0003Qx-BH
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:52 -0500
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:41417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTZ-0003Ql-6P
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:49 -0500
Received: by mail-qk0-x22a.google.com with SMTP id a8so12538367qkb.8
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:47:49 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:58 -0300
Message-Id: <20180108024558.17983-30-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [NOTFORMERGE PATCH 29/29] piix4: add isa_superio_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

For Hervé to test his VirtualPC2007.

 hw/southbridge/piix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/southbridge/piix.c b/hw/southbridge/piix.c
index 53ee177866..b800d538da 100644
--- a/hw/southbridge/piix.c
+++ b/hw/southbridge/piix.c
@@ -32,6 +32,7 @@
 #include "hw/dma/i8257.h"
 #include "hw/audio/pcspk.h"
 #include "hw/timer/i8254.h"
+#include "hw/isa/superio.h"
 #include "hw/xen/xen.h"
 
 #define PIIX_NUM_PIC_IRQS       16      /* i8259 * 2 */
@@ -538,6 +539,8 @@ static void piix4_realize(PCIDevice *pci_dev, Error **errp)
     /* DMA */
     i8257_dma_init(s->isa_bus, 0);
 
+    isa_superio_init(s->isa_bus, 2, 1, 1);
+
     piix4_dev = pci_dev;
 }
 
-- 
2.15.1
