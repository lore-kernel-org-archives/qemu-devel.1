Received: from eggs.gnu.org ([2001:4830:134:3::10]:41045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIxL5-0005m1-A0
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIxL2-0003Id-05
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:19:03 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  8 Jun 2017 15:18:54 +0200
Message-Id: <1496927934-21815-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/cpu: core.c can be compiled as common object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Juan Quintela <quintela@redhat.com>, Andrew Jones <drjones@redhat.com>

There does not seem to be any target specific code in core.c, so we can
put it into "common-obj" instead of "obj" to compile it only once for
all targets.

Signed-off-by: Thomas Huth <thuth@redhat.com>
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
1.8.3.1
