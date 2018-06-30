Received: from eggs.gnu.org ([2001:4830:134:3::10]:37767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95x-00040i-O9
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95w-0001lq-Ij
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:53 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:34561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ95w-0001kF-Ay
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:52 -0400
Received: by mail-wm0-x233.google.com with SMTP id l15-v6so3502204wmc.1
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:10:52 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:01 +0200
Message-Id: <20180630061040.6018-9-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/47] hw: Directly use "qemu/units.h" instead
 of "qemu/cutils.h"
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

These files don't use anything exposed by "qemu/cutils.h",
simplify preprocessing including directly "qemu/units.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au> (ppc parts)
Message-Id: <20180625124238.25339-7-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/msf2-soc.c  | 2 +-
 hw/arm/msf2-som.c  | 2 +-
 hw/core/machine.c  | 2 +-
 hw/display/sm501.c | 2 +-
 hw/mips/boston.c   | 2 +-
 hw/ppc/pnv.c       | 2 +-
 hw/ppc/ppc440_uc.c | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 530e461..edb3ba8 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -23,13 +23,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "hw/arm/arm.h"
 #include "exec/address-spaces.h"
 #include "hw/char/serial.h"
 #include "hw/boards.h"
-#include "qemu/cutils.h"
 #include "hw/arm/msf2-soc.h"
 #include "hw/misc/unimp.h"
 
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index ed533bb..2432b5e 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -23,12 +23,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
 #include "exec/address-spaces.h"
-#include "qemu/cutils.h"
 #include "hw/arm/msf2-soc.h"
 #include "cpu.h"
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ccf3a4b..2077328 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-common.h"
@@ -19,7 +20,6 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "qemu/error-report.h"
-#include "qemu/cutils.h"
 #include "sysemu/qtest.h"
 
 static char *machine_get_accel(Object *obj, Error **errp)
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 3bd8716..9dec0d3 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/cutils.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 939cef5..6c9c20a 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu-common.h"
 
 #include "exec/address-spaces.h"
@@ -32,7 +33,6 @@
 #include "hw/mips/cpudevs.h"
 #include "hw/pci-host/xilinx-pcie.h"
 #include "qapi/error.h"
-#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "chardev/char.h"
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 5fdac62..346f5e7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
@@ -31,7 +32,6 @@
 #include "hw/ppc/pnv_core.h"
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
-#include "qemu/cutils.h"
 #include "qapi/visitor.h"
 #include "monitor/monitor.h"
 #include "hw/intc/intc.h"
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index b5b31b4..1ab2235 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -9,8 +9,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu-common.h"
-#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "cpu.h"
-- 
1.8.3.1
