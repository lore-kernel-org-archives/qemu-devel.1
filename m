Received: from eggs.gnu.org ([2001:4830:134:3::10]:47113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRz-0003z8-SL
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRy-0006gO-QZ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:11 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:47 +1000
Message-Id: <20170609052652.23200-16-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/20] hw/cpu: core.c can be compiled as common
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

There does not seem to be any target specific code in core.c, so we can
put it into "common-obj" instead of "obj" to compile it only once for
all targets.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/cpu/Makefile.objs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/cpu/Makefile.objs b/hw/cpu/Makefile.objs
index 942a4bb..cd52d20 100644
--- a/hw/cpu/Makefile.objs
+++ b/hw/cpu/Makefile.objs
@@ -2,5 +2,4 @@ obj-$(CONFIG_ARM11MPCORE) += arm11mpcore.o
 obj-$(CONFIG_REALVIEW) += realview_mpcore.o
 obj-$(CONFIG_A9MPCORE) += a9mpcore.o
 obj-$(CONFIG_A15MPCORE) += a15mpcore.o
-obj-y += core.o
-
+common-obj-y += core.o
-- 
2.9.4
