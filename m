Received: from eggs.gnu.org ([2001:4830:134:3::10]:35509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgjl-0003NW-4R
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgjk-0006R2-FA
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:32:37 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:30:07 -0300
Message-Id: <20171215033015.738-36-f4bug@amsat.org>
In-Reply-To: <20171215033015.738-1-f4bug@amsat.org>
References: <20171215033015.738-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 35/43] hw/display/vga: "vga.h" only contains
 registers defs, rename it "vga_regs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/{vga.h => vga_regs.h} | 0
 hw/display/vga.c                 | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/display/{vga.h => vga_regs.h} (100%)

diff --git a/hw/display/vga.h b/hw/display/vga_regs.h
similarity index 100%
rename from hw/display/vga.h
rename to hw/display/vga_regs.h
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
-- 
2.15.1
