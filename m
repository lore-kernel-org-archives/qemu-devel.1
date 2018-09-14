Received: from eggs.gnu.org ([2001:4830:134:3::10]:52646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g0gO5-0005to-1H
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 01:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g0gO1-00059A-R8
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 01:11:24 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1g0gO1-00057s-AB
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 01:11:21 -0400
Received: by mail-pf1-x443.google.com with SMTP id s13-v6so3717118pfi.7
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 22:11:20 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 13 Sep 2018 22:11:11 -0700
Message-Id: <1536901871-2729-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] hw: edu: replace device name with macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jslaby@suse.cz, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Just as other devices do.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/misc/edu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index df26a4d046..0687ffd343 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -30,7 +30,8 @@
 #include "qemu/main-loop.h" /* iothread mutex */
 #include "qapi/visitor.h"
 
-#define EDU(obj)        OBJECT_CHECK(EduState, obj, "edu")
+#define TYPE_PCI_EDU_DEVICE "edu"
+#define EDU(obj)        OBJECT_CHECK(EduState, obj, TYPE_PCI_EDU_DEVICE)
 
 #define FACT_IRQ        0x00000001
 #define DMA_IRQ         0x00000100
@@ -414,7 +415,7 @@ static void pci_edu_register_types(void)
         { },
     };
     static const TypeInfo edu_info = {
-        .name          = "edu",
+        .name          = TYPE_PCI_EDU_DEVICE,
         .parent        = TYPE_PCI_DEVICE,
         .instance_size = sizeof(EduState),
         .instance_init = edu_instance_init,
-- 
2.11.0
