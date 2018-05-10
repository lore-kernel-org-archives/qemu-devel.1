Received: from eggs.gnu.org ([2001:4830:134:3::10]:44627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fGhtj-00052r-VB
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fGhtf-0007jY-3V
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:30:03 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fGhte-0007j7-Qj
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:29:59 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 10 May 2018 11:29:35 +0200
Message-Id: <20180510092935.29088-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] linux-user: move thunk.c to linux-user/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

thunk.c is part of linux-user and only used by it,
so move it to the linux-user directory.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 Makefile.target               | 2 +-
 linux-user/Makefile.objs      | 2 +-
 thunk.c => linux-user/thunk.c | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename thunk.c => linux-user/thunk.c (100%)

diff --git a/Makefile.target b/Makefile.target
index d0ec77a307..98f25c91c7 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -112,7 +112,7 @@ QEMU_CFLAGS+=-I$(SRC_PATH)/linux-user/$(TARGET_ABI_DIR) \
              -I$(SRC_PATH)/linux-user
 
 obj-y += linux-user/
-obj-y += gdbstub.o thunk.o
+obj-y += gdbstub.o
 
 endif #CONFIG_LINUX_USER
 
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 59a5c17354..1fc1dd2762 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -1,7 +1,7 @@
 obj-y = main.o syscall.o strace.o mmap.o signal.o \
 	elfload.o linuxload.o uaccess.o uname.o \
 	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
-        $(TARGET_ABI_DIR)/cpu_loop.o
+        $(TARGET_ABI_DIR)/cpu_loop.o thunk.o
 
 obj-$(TARGET_HAS_BFLT) += flatload.o
 obj-$(TARGET_I386) += vm86.o
diff --git a/thunk.c b/linux-user/thunk.c
similarity index 100%
rename from thunk.c
rename to linux-user/thunk.c
-- 
2.14.3
