Received: from eggs.gnu.org ([2001:4830:134:3::10]:34087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eIx6A-0000QU-Rc
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eIx69-0006dD-RL
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:35:54 -0500
Received: from chuckie.co.uk ([82.165.15.123]:48797
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eIx69-0006co-Lh
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:35:53 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 26 Nov 2017 13:35:21 +0000
Message-Id: <1511703326-25325-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/8] sun4m: remove include/hw/sparc/sun4m.h and
 all references to it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

With the previous commit there is now nothing left in sun4m.h so it can be
removed, along with all remaining references to it.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/dma/sparc32_dma.c     |    1 -
 hw/intc/slavio_intctl.c  |    1 -
 hw/net/lance.c           |    2 +-
 hw/sparc/sun4m.c         |    1 -
 hw/sparc/sun4m_iommu.c   |    1 -
 hw/timer/slavio_timer.c  |    1 -
 include/hw/sparc/sun4m.h |   14 --------------
 7 files changed, 1 insertion(+), 20 deletions(-)
 delete mode 100644 include/hw/sparc/sun4m.h

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index c04ad79..7b00a27 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -28,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sparc/sparc32_dma.h"
-#include "hw/sparc/sun4m.h"
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
 #include "sysemu/dma.h"
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index 84e0bee..817e026 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sparc/sun4m.h"
 #include "monitor/monitor.h"
 #include "hw/sysbus.h"
 #include "hw/intc/intc.h"
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 23929fd..0028bc5 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -40,7 +40,7 @@
 #include "net/net.h"
 #include "qemu/timer.h"
 #include "qemu/sockets.h"
-#include "hw/sparc/sun4m.h"
+#include "hw/sparc/sparc32_dma.h"
 #include "hw/net/lance.h"
 #include "trace.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index a3ba92f..9723d6f 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -28,7 +28,6 @@
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
-#include "hw/sparc/sun4m.h"
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/timer/m48t59.h"
 #include "hw/sparc/sparc32_dma.h"
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 311c82d..b677601 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sparc/sun4m.h"
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index a8cc9c0..4694b65 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sparc/sun4m.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "hw/sysbus.h"
diff --git a/include/hw/sparc/sun4m.h b/include/hw/sparc/sun4m.h
deleted file mode 100644
index 9e06467..0000000
--- a/include/hw/sparc/sun4m.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef SUN4M_H
-#define SUN4M_H
-
-#include "qemu-common.h"
-#include "exec/hwaddr.h"
-#include "qapi/qmp/types.h"
-#include "hw/sysbus.h"
-
-/* Devices used by sparc32 system.  */
-
-/* sparc32_dma.c */
-#include "hw/sparc/sparc32_dma.h"
-
-#endif
-- 
1.7.10.4
