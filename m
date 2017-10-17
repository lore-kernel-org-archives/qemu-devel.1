Received: from eggs.gnu.org ([2001:4830:134:3::10]:46582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4V06-0001fi-Sb
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4V05-0003FS-Kt
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:45:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 17 Oct 2017 13:43:57 -0300
Message-Id: <20171017164426.25277-14-f4bug@amsat.org>
In-Reply-To: <20171017164426.25277-1-f4bug@amsat.org>
References: <20171017164426.25277-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 13/42] misc: remove duplicated includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org

exec: housekeeping (funny since 02d0e095031)

applied using ./scripts/clean-includes

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
---
 accel/tcg/translate-all.c          | 1 -
 exec.c                             | 3 ---
 hw/arm/spitz.c                     | 1 -
 hw/char/xen_console.c              | 1 -
 hw/core/machine.c                  | 1 -
 hw/s390x/css.c                     | 1 -
 target/openrisc/exception_helper.c | 1 -
 tests/vhost-user-test.c            | 1 -
 util/qemu-sockets.c                | 1 -
 vl.c                               | 1 -
 10 files changed, 12 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c5ce99d549..f81afb87e6 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -31,7 +31,6 @@
 #include "tcg.h"
 #if defined(CONFIG_USER_ONLY)
 #include "qemu.h"
-#include "exec/exec-all.h"
 #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
 #include <sys/param.h>
 #if __FreeBSD_version >= 700104
diff --git a/exec.c b/exec.c
index 6378714a2b..c19061465f 100644
--- a/exec.c
+++ b/exec.c
@@ -18,8 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#ifndef _WIN32
-#endif
 
 #include "qemu/cutils.h"
 #include "cpu.h"
@@ -51,7 +49,6 @@
 #include "trace-root.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
-#include <fcntl.h>
 #include <linux/falloc.h>
 #endif
 
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index feccdb00d3..ac1e15cbbc 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -29,7 +29,6 @@
 #include "sysemu/block-backend.h"
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
-#include "sysemu/sysemu.h"
 #include "cpu.h"
 
 #undef REG_FMT
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 3643dfe067..5e68326c19 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -27,7 +27,6 @@
 #include "hw/hw.h"
 #include "chardev/char-fe.h"
 #include "hw/xen/xen_backend.h"
-#include "qapi/error.h"
 
 #include <xen/io/console.h>
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 36c2fb069c..c857f3f934 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -20,7 +20,6 @@
 #include "sysemu/numa.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
-#include "sysemu/numa.h"
 #include "sysemu/qtest.h"
 
 static char *machine_get_accel(Object *obj, Error **errp)
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 35683d7954..2f4d40a5fb 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -13,7 +13,6 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/qdev.h"
-#include "qemu/error-report.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
diff --git a/target/openrisc/exception_helper.c b/target/openrisc/exception_helper.c
index a8a5f69b05..6073a5b21c 100644
--- a/target/openrisc/exception_helper.c
+++ b/target/openrisc/exception_helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "exception.h"
 
 void HELPER(exception)(CPUOpenRISCState *env, uint32_t excp)
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 4b98018478..e2c89ed376 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -21,7 +21,6 @@
 #include "libqos/libqos.h"
 #include "libqos/pci-pc.h"
 #include "libqos/virtio-pci.h"
-#include "qapi/error.h"
 
 #include "libqos/malloc-pc.h"
 #include "hw/virtio/virtio-net.h"
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index d149383bb9..d700caef45 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -26,7 +26,6 @@
 #include "qapi/error.h"
 #include "qemu/sockets.h"
 #include "qemu/main-loop.h"
-#include "qapi/clone-visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi-visit.h"
diff --git a/vl.c b/vl.c
index 0723835bbf..0d1f612629 100644
--- a/vl.c
+++ b/vl.c
@@ -95,7 +95,6 @@ int main(int argc, char **argv)
 #include "sysemu/kvm.h"
 #include "sysemu/hax.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qobject-input-visitor.h"
 #include "qapi-visit.h"
 #include "qapi/qmp/qjson.h"
 #include "qemu/option.h"
-- 
2.15.0.rc0
