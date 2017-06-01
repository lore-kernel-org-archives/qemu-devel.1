Received: from eggs.gnu.org ([2001:4830:134:3::10]:35340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dGMo2-0002De-Kn
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dGMnx-0003dB-QG
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:54:14 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  1 Jun 2017 11:54:03 +0200
Message-Id: <1496310843-28771-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/core: nmi.c can be compiled as common-obj
 nowadays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Bandan Das <bsd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>, Juan Quintela <quintela@redhat.com>

The target-specific code in nmi.c has been removed with this commit:

	commit f7e981f29548fe4af7812f5920304fe607e5bf0d
	nmi: remove x86 specific nmi handling

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 91450b2..f8d7a4a 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -5,7 +5,7 @@ common-obj-y += fw-path-provider.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y += irq.o
 common-obj-y += hotplug.o
-obj-y += nmi.o
+common-obj-y += nmi.o
 
 common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
 common-obj-$(CONFIG_XILINX_AXI) += stream.o
-- 
1.8.3.1
