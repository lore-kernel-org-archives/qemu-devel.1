Received: from eggs.gnu.org ([2001:4830:134:3::10]:41336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ4b-0004Xq-2z
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ4X-00039E-Vd
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:01 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 12:39:47 -0300
Message-Id: <20170922154014.29350-8-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/34] i386/hax: remove duplicated includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yu Ning <yu.ning@linux.intel.com>, Vincent Palatin <vpalatin@chromium.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

applied using ./scripts/clean-includes

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/sysemu/hax.h      | 1 -
 target/i386/hax-darwin.h  | 3 ---
 target/i386/hax-windows.h | 2 --
 target/i386/hax-darwin.c  | 8 ++------
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/sysemu/hax.h b/include/sysemu/hax.h
index 232a68ab1b..f252399623 100644
--- a/include/sysemu/hax.h
+++ b/include/sysemu/hax.h
@@ -22,7 +22,6 @@
 #ifndef QEMU_HAX_H
 #define QEMU_HAX_H
 
-#include "config-host.h"
 #include "qemu-common.h"
 
 int hax_sync_vcpus(void);
diff --git a/target/i386/hax-darwin.h b/target/i386/hax-darwin.h
index 0c0968b77d..fb8e25a096 100644
--- a/target/i386/hax-darwin.h
+++ b/target/i386/hax-darwin.h
@@ -15,10 +15,7 @@
 #ifndef TARGET_I386_HAX_DARWIN_H
 #define TARGET_I386_HAX_DARWIN_H
 
-#include <sys/types.h>
 #include <sys/ioctl.h>
-#include <sys/mman.h>
-#include <stdarg.h>
 
 #define HAX_INVALID_FD  (-1)
 static inline int hax_invalid_fd(hax_fd fd)
diff --git a/target/i386/hax-windows.h b/target/i386/hax-windows.h
index 1d8f68de91..f7c3e99246 100644
--- a/target/i386/hax-windows.h
+++ b/target/i386/hax-windows.h
@@ -24,8 +24,6 @@
 #include <memory.h>
 #include <malloc.h>
 #include <winioctl.h>
-#include <string.h>
-#include <stdio.h>
 #include <windef.h>
 
 #define HAX_INVALID_FD INVALID_HANDLE_VALUE
diff --git a/target/i386/hax-darwin.c b/target/i386/hax-darwin.c
index 1c5bbd0a2d..ee9417454c 100644
--- a/target/i386/hax-darwin.c
+++ b/target/i386/hax-darwin.c
@@ -11,13 +11,9 @@
  */
 
 /* HAX module interface - darwin version */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <sys/ioctl.h>
-
 #include "qemu/osdep.h"
+#include <sys/ioctl.h>
+
 #include "target/i386/hax-i386.h"
 
 hax_fd hax_mod_open(void)
-- 
2.14.1
