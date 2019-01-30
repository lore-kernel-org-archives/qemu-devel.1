Received: from eggs.gnu.org ([209.51.188.92]:55943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gosty-0000pa-Tg
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gostx-0002V8-Sc
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:39:50 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 30 Jan 2019 17:39:42 +0100
Message-Id: <1548866382-14488-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ppc: Don't include m48t59.h if it is not
 necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

These files don't use anything from m48t59.h, so no need to include
this header here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/mac_newworld.c | 1 -
 hw/ppc/mac_oldworld.c | 1 -
 hw/ppc/ppc.c          | 2 --
 hw/ppc/ppc_booke.c    | 1 -
 4 files changed, 5 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index bb19eab..f1c8400 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -53,7 +53,6 @@
 #include "hw/ppc/mac.h"
 #include "hw/input/adb.h"
 #include "hw/ppc/mac_dbdma.h"
-#include "hw/timer/m48t59.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 817f70e..98d531d 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -30,7 +30,6 @@
 #include "hw/ppc/ppc.h"
 #include "mac.h"
 #include "hw/input/adb.h"
-#include "hw/timer/m48t59.h"
 #include "sysemu/sysemu.h"
 #include "net/net.h"
 #include "hw/isa/isa.h"
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 98b409f..cffdc39 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -30,10 +30,8 @@
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/cpus.h"
-#include "hw/timer/m48t59.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "hw/loader.h"
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
 #include "trace.h"
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 23bcf1b..4f11e00 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -28,7 +28,6 @@
 #include "hw/ppc/ppc.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
-#include "hw/timer/m48t59.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
 #include "kvm_ppc.h"
-- 
1.8.3.1
