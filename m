Received: from eggs.gnu.org ([2001:4830:134:3::10]:44014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoneN-0004R4-5y
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoneK-0006Ia-3L
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:58:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eoneJ-0006IL-Uw
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:58:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C32E28182D0C
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 09:58:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 22 Feb 2018 10:58:37 +0100
Message-Id: <1519293517-19582-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/net: Remove unnecessary header includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

Headers like "hw/loader.h" and "qemu/sockets.h" are not needed in
the hw/net/*.c files. And Some other headers are included via other
headers already, so we can drop them, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/net/e1000.c     | 1 -
 hw/net/lance.c     | 3 ---
 hw/net/ne2000.c    | 2 --
 hw/net/pcnet-pci.c | 1 -
 hw/net/pcnet.c     | 1 -
 hw/net/rtl8139.c   | 2 --
 hw/net/xgmac.c     | 1 -
 7 files changed, 11 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 804ec08..c7f1695 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -30,7 +30,6 @@
 #include "hw/pci/pci.h"
 #include "net/net.h"
 #include "net/checksum.h"
-#include "hw/loader.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
 #include "qemu/iov.h"
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 0028bc5..a08d5ac 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -36,10 +36,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
-#include "net/net.h"
 #include "qemu/timer.h"
-#include "qemu/sockets.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/net/lance.h"
 #include "trace.h"
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 687ef84..3a9fc89 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -23,10 +23,8 @@
  */
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
-#include "net/net.h"
 #include "net/eth.h"
 #include "ne2000.h"
-#include "hw/loader.h"
 #include "sysemu/sysemu.h"
 
 /* debug NE2000 card */
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 0ae5ca4..70dc8b3 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -30,7 +30,6 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
-#include "hw/loader.h"
 #include "qemu/timer.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 606b05c..0c44554 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -40,7 +40,6 @@
 #include "net/net.h"
 #include "net/eth.h"
 #include "qemu/timer.h"
-#include "qemu/sockets.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
 
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 1cc95b8..46daa16 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -58,9 +58,7 @@
 #include "qemu/timer.h"
 #include "net/net.h"
 #include "net/eth.h"
-#include "hw/loader.h"
 #include "sysemu/sysemu.h"
-#include "qemu/iov.h"
 
 /* debug RTL8139 card */
 //#define DEBUG_RTL8139 1
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index 0843bf1..fa00156 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -28,7 +28,6 @@
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "net/net.h"
-#include "net/checksum.h"
 
 #ifdef DEBUG_XGMAC
 #define DEBUGF_BRK(message, args...) do { \
-- 
1.8.3.1
