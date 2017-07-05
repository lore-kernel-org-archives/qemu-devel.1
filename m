Received: from eggs.gnu.org ([2001:4830:134:3::10]:46502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWi-0004Z7-W4
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWe-0007YJ-0h
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:08 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:34834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWd-0007Xx-QI
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:03 -0400
Received: by mail-wm0-x22d.google.com with SMTP id w126so212850804wme.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:03 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:14 +0200
Message-Id: <1499238885-26161-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/42] Makefile: Move bootdevice.o to
 common-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

There does not seem to be any target specific code in this file, so
we can put it into "common-obj" instead of "obj" to compile it only
once for all targets.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1498454578-18709-7-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs   | 2 +-
 Makefile.target | 2 +-
 bootdevice.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index b2e6322..756644c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -40,7 +40,7 @@ io-obj-y = io/
 
 ifeq ($(CONFIG_SOFTMMU),y)
 common-obj-y = blockdev.o blockdev-nbd.o block/
-common-obj-y += iothread.o
+common-obj-y += bootdevice.o iothread.o
 common-obj-y += net/
 common-obj-y += qdev-monitor.o device-hotplug.o
 common-obj-$(CONFIG_WIN32) += os-win32.o
diff --git a/Makefile.target b/Makefile.target
index 0066579..ffa7a8f 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -137,7 +137,7 @@ endif #CONFIG_BSD_USER
 # System emulator target
 ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
-obj-y += qtest.o bootdevice.o
+obj-y += qtest.o
 obj-y += hw/
 obj-y += memory.o
 obj-y += memory_mapping.o
diff --git a/bootdevice.c b/bootdevice.c
index 33e3029..1141009 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -27,7 +27,7 @@
 #include "sysemu/sysemu.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
-#include "hw/hw.h"
+#include "sysemu/reset.h"
 #include "hw/qdev-core.h"
 
 typedef struct FWBootEntry FWBootEntry;
-- 
1.8.3.1
