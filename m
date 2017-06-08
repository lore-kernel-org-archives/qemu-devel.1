Received: from eggs.gnu.org ([2001:4830:134:3::10]:59960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIyGH-0008JD-JP
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIyGE-0002Lj-Fx
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:18:09 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  8 Jun 2017 16:18:02 +0200
Message-Id: <1496931482-29914-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] Makefile: Move balloon.o,
 numa.o and bootdevice.o to common-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrew Jones <drjones@redhat.com>

There does not seem to be any target specific code in these files, so
we can put them into "common-obj" instead of "obj" to compile them only
once for all targets.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Makefile.objs   | 1 +
 Makefile.target | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 0575802..a949502 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -40,6 +40,7 @@ io-obj-y = io/
 
 ifeq ($(CONFIG_SOFTMMU),y)
 common-obj-y = blockdev.o blockdev-nbd.o block/
+common-obj-y += balloon.o numa.o bootdevice.o
 common-obj-y += iothread.o
 common-obj-y += net/
 common-obj-y += qdev-monitor.o device-hotplug.o
diff --git a/Makefile.target b/Makefile.target
index ce8dfe4..da37258 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -139,8 +139,7 @@ endif #CONFIG_BSD_USER
 #########################################################
 # System emulator target
 ifdef CONFIG_SOFTMMU
-obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
-obj-y += qtest.o bootdevice.o
+obj-y += arch_init.o cpus.o monitor.o gdbstub.o ioport.o qtest.o
 obj-y += hw/
 obj-$(CONFIG_KVM) += kvm-all.o
 obj-y += memory.o cputlb.o
-- 
1.8.3.1
