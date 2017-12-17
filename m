Received: from eggs.gnu.org ([2001:4830:134:3::10]:41349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQm32-0005p3-9w
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQm2z-00014R-A6
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:25:00 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:37 +0300
Message-Id: <7fcd1ffeceac14d56cf6f47f93f0b35114a403e5.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/61] misc: remove duplicated includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

exec: housekeeping (funny since 02d0e095031)

applied using ./scripts/clean-includes

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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
index 02dfa361bb..7736257085 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -31,7 +31,6 @@
 #include "tcg.h"
 #if defined(CONFIG_USER_ONLY)
 #include "qemu.h"
-#include "exec/exec-all.h"
 #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
 #include <sys/param.h>
 #if __FreeBSD_version >=3D 700104
diff --git a/exec.c b/exec.c
index 03238a3449..3e7c57e914 100644
--- a/exec.c
+++ b/exec.c
@@ -18,8 +18,6 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#ifndef _WIN32
-#endif
=20
 #include "qemu/cutils.h"
 #include "cpu.h"
@@ -51,7 +49,6 @@
 #include "trace-root.h"
=20
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
-#include <fcntl.h>
 #include <linux/falloc.h>
 #endif
=20
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
=20
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
=20
 #include <xen/io/console.h>
=20
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
=20
 static char *machine_get_accel(Object *obj, Error **errp)
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index f071e1394b..1c526fd7e2 100644
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
diff --git a/target/openrisc/exception_helper.c b/target/openrisc/excepti=
on_helper.c
index a8a5f69b05..6073a5b21c 100644
--- a/target/openrisc/exception_helper.c
+++ b/target/openrisc/exception_helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
 #include "exception.h"
=20
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
=20
 #include "libqos/malloc-pc.h"
 #include "hw/virtio/virtio-net.h"
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index a1cf47e625..af4f01211a 100644
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
index fc8bd9372f..c1ba52306a 100644
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
--=20
2.11.0
