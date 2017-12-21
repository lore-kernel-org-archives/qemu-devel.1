Received: from eggs.gnu.org ([2001:4830:134:3::10]:60844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS88W-0005Qb-6G
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:12:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS88R-0001Ug-4A
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:12:16 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:49743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eS88Q-0001Ty-Qt
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:12:11 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 21 Dec 2017 22:11:03 +0100
Message-Id: <20171221211103.30311-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] hw/i386/vmport: fix missing definitions with
 x86_64-w64-mingw32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>

When compiled with x86_64-w64-mingw32, we have:

   error: implicit declaration of function 'qemu_log_mask'
   error: 'LOG_UNIMP' undeclared (first use in this function)

This patch adds the missing include.

Fixes: 7299e1a411
       ("hw/i386/vmport: replace fprintf() by trace events or LOG_UNIMP")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/i386/vmport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 9b8c68806e..116aa09819 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -27,6 +27,7 @@
 #include "hw/i386/pc.h"
 #include "sysemu/hw_accel.h"
 #include "hw/qdev.h"
+#include "qemu/log.h"
 #include "trace.h"
 
 #define VMPORT_CMD_GETVERSION 0x0a
-- 
2.14.3
