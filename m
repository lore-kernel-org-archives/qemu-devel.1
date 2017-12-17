Received: from eggs.gnu.org ([2001:4830:134:3::10]:47724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQh3R-0002xk-BG
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 17:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQh3O-00067R-Se
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 17:05:05 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:38 +0300
Message-Id: <0ea07192c4cb4238a00c7d0df62ebc8344cdbe4f.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/61] ppc: remove duplicated includes
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

applied using ./scripts/clean-includes

not needed since 7ebaf795560

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 1 -
 target/ppc/kvm.c     | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index be22a6b289..51eba52e86 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -13,7 +13,6 @@
 #include "trace.h"
 #include "kvm_ppc.h"
 #include "hw/ppc/spapr_ovec.h"
-#include "qemu/error-report.h"
 #include "mmu-book3s-v3.h"
=20
 struct SPRSyncState {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9d57debf0e..4664a3ce9d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -47,9 +47,6 @@
 #include "sysemu/hostmem.h"
 #include "qemu/cutils.h"
 #include "qemu/mmap-alloc.h"
-#if defined(TARGET_PPC64)
-#include "hw/ppc/spapr_cpu_core.h"
-#endif
 #include "elf.h"
 #include "sysemu/kvm_int.h"
=20
--=20
2.11.0
