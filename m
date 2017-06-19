Received: from eggs.gnu.org ([2001:4830:134:3::10]:34824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dN07K-00045v-7f
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 13:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dN07G-0000M1-0E
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 13:05:34 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 19 Jun 2017 19:05:26 +0200
Message-Id: <1497891926-25299-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/misc/edu: Compile the edu device as common
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jiri Slaby <jslaby@suse.cz>
Cc: qemu-trivial@nongnu.org

edu.c seems not to contain any target-specific code, so we can
put it into common-obj-y to compile it only once for all targets.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 2019846..7fc4e41 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-$(CONFIG_ISA_DEBUG) += debugexit.o
 common-obj-$(CONFIG_SGA) += sga.o
 common-obj-$(CONFIG_ISA_TESTDEV) += pc-testdev.o
 common-obj-$(CONFIG_PCI_TESTDEV) += pci-testdev.o
+common-obj-$(CONFIG_EDU) += edu.o
 
 common-obj-y += unimp.o
 
@@ -53,7 +54,6 @@ obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
 obj-$(CONFIG_MIPS_ITU) += mips_itu.o
 
 obj-$(CONFIG_PVPANIC) += pvpanic.o
-obj-$(CONFIG_EDU) += edu.o
 obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
 obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
-- 
1.8.3.1
