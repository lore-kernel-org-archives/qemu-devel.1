Received: from eggs.gnu.org ([2001:4830:134:3::10]:47439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4V13-0002l6-2V
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4V12-0003kD-D0
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:46:53 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 17 Oct 2017 13:44:19 -0300
Message-Id: <20171017164426.25277-36-f4bug@amsat.org>
In-Reply-To: <20171017164426.25277-1-f4bug@amsat.org>
References: <20171017164426.25277-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 35/42] hw/display/vga: "vga.h" only contains
 registers defs, rename it "vga_regs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
index ed24ef7076..35696b6fdd 100644
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
2.15.0.rc0
