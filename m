Received: from eggs.gnu.org ([2001:4830:134:3::10]:58473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiW-0006Br-Fo
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiV-00040F-JJ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:24 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiV-0003zY-C0
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:23 -0400
Received: by mail-wr0-x243.google.com with SMTP id z12so2563527wrg.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:59 +0100
Message-Id: <20180313224719.4954-50-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 49/69] hw/alpha/dp264: Add the ISA DMA controller
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
Message-Id: <20180308223946.26784-24-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/alpha-softmmu.mak | 2 ++
 hw/alpha/dp264.c                  | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index e0d75e3058..3740adc5e9 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -4,7 +4,9 @@ include pci.mak
 include usb.mak
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
+CONFIG_I82374=y
 CONFIG_I8254=y
+CONFIG_I8257=y
 CONFIG_PCKBD=y
 CONFIG_VGA_CIRRUS=y
 CONFIG_IDE_CORE=y
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index e13cb576fd..ffad678ea7 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -21,6 +21,7 @@
 #include "hw/timer/i8254.h"
 #include "hw/input/i8042.h"
 #include "hw/char/serial.h"
+#include "hw/dma/i8257.h"
 #include "qemu/cutils.h"
 
 #define MAX_IDE_BUS 2
@@ -95,6 +96,9 @@ static void clipper_init(MachineState *machine)
         pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
     }
 
+    /* 2 82C37 (dma) */
+    isa_create_simple(isa_bus, "i82374");
+
     /* IDE disk setup.  */
     {
         DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-- 
2.14.3
