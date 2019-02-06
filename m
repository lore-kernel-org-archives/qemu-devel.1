Received: from eggs.gnu.org ([209.51.188.92]:56041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grP8A-0000Ii-S4
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grP88-0004Wo-Or
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:28:54 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  6 Feb 2019 16:28:04 +0100
Message-Id: <20190206152807.31896-5-laurent@vivier.eu>
In-Reply-To: <20190206152807.31896-1-laurent@vivier.eu>
References: <20190206152807.31896-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 4/7] hw/sparc64/sun4u: Drop useless inclusion of
 "hw/i386/pc.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Anthony Green <green@moxielogic.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In 47973a2dbf we split the last generic chipset out of the PC
board, but forgot to remove the include of "hw/i386/pc.h".
Since it is now unused, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20190204210433.26088-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/sparc64/sun4u.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index f76b19e4e9..fdf3f14a29 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -33,7 +33,6 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci-host/sabre.h"
-#include "hw/i386/pc.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
 #include "hw/timer/m48t59.h"
-- 
2.20.1
