Received: from eggs.gnu.org ([2001:4830:134:3::10]:37801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95z-00042n-Il
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95y-0001pD-Ga
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:55 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:55231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ95y-0001nj-8J
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:54 -0400
Received: by mail-wm0-x22f.google.com with SMTP id i139-v6so4085359wmf.4
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:10:54 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:03 +0200
Message-Id: <20180630061040.6018-11-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/47] hw/ipack: Use the IEC binary prefix
 definitions
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

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20180625124238.25339-9-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ipack/tpci200.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index da05c85..cd3e791 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/ipack/ipack.h"
 #include "hw/pci/pci.h"
 #include "qemu/bitops.h"
@@ -597,9 +598,9 @@ static void tpci200_realize(PCIDevice *pci_dev, Error **errp)
     memory_region_init_io(&s->las1, OBJECT(s), &tpci200_las1_ops,
                           s, "tpci200_las1", 1024);
     memory_region_init_io(&s->las2, OBJECT(s), &tpci200_las2_ops,
-                          s, "tpci200_las2", 1024*1024*32);
+                          s, "tpci200_las2", 32 * MiB);
     memory_region_init_io(&s->las3, OBJECT(s), &tpci200_las3_ops,
-                          s, "tpci200_las3", 1024*1024*16);
+                          s, "tpci200_las3", 16 * MiB);
     pci_register_bar(&s->dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio);
     pci_register_bar(&s->dev, 1, PCI_BASE_ADDRESS_SPACE_IO,     &s->io);
     pci_register_bar(&s->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->las0);
-- 
1.8.3.1
