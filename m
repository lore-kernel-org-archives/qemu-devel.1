Received: from eggs.gnu.org ([2001:4830:134:3::10]:52242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQPE-0006e2-FV
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQPA-0000My-T4
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:02:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 13:01:10 -0300
Message-Id: <20170922160111.31885-11-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 33/34] hw/alpha: remove old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/alpha/alpha_sys.h | 2 --
 hw/alpha/pci.c       | 2 ++
 hw/alpha/typhoon.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index b6d8369ed7..ac685c1c46 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -5,8 +5,6 @@
 
 #include "target/alpha/cpu-qom.h"
 #include "hw/pci/pci.h"
-#include "hw/pci/pci_host.h"
-#include "hw/ide.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
 
diff --git a/hw/alpha/pci.c b/hw/alpha/pci.c
index 8dde637bfe..c370762ea6 100644
--- a/hw/alpha/pci.c
+++ b/hw/alpha/pci.c
@@ -8,6 +8,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
 #include "alpha_sys.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index ae11e012c7..75ac4ed354 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -11,9 +11,9 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/devices.h"
+#include "hw/pci/pci_host.h"
 #include "sysemu/sysemu.h"
 #include "alpha_sys.h"
-#include "exec/address-spaces.h"
 
 
 #define TYPE_TYPHOON_PCI_HOST_BRIDGE "typhoon-pcihost"
-- 
2.14.1
