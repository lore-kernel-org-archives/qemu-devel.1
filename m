Received: from eggs.gnu.org ([2001:4830:134:3::10]:41351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQm32-0005p4-AY
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQm2z-000143-5Q
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:25:00 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:59 +0300
Message-Id: <f31f9e279129d6ddb11921e95a5c1b7558304489.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 54/61] hw/display/vga: "vga.h" only contains
 registers defs, rename it "vga_regs.h"
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/vga.c                 | 2 +-
 hw/display/{vga.h =3D> vga_regs.h} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/display/{vga.h =3D> vga_regs.h} (100%)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index a64a0942da..ce95b40e5c 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -24,11 +24,11 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
-#include "vga.h"
 #include "ui/console.h"
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "vga_int.h"
+#include "vga_regs.h"
 #include "ui/pixel_ops.h"
 #include "qemu/timer.h"
 #include "hw/xen/xen.h"
diff --git a/hw/display/vga.h b/hw/display/vga_regs.h
similarity index 100%
rename from hw/display/vga.h
rename to hw/display/vga_regs.h
--=20
2.11.0
