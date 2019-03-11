Received: from eggs.gnu.org ([209.51.188.92]:60122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3QL5-0005NN-CH
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3QL4-0003W6-L9
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:11:55 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 11 Mar 2019 20:11:26 +0100
Message-Id: <20190311191128.30562-4-laurent@vivier.eu>
In-Reply-To: <20190311191128.30562-1-laurent@vivier.eu>
References: <20190311191128.30562-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/5] hw/i386: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Laszlo Ersek <lersek@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190308013222.12524-3-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/acpi/piix4.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 8fd25a59269a..7b98121070f6 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -28,7 +28,6 @@
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qemu/range.h"
-#include "hw/nvram/fw_cfg.h"
 #include "exec/address-spaces.h"
 #include "hw/acpi/piix4.h"
 #include "hw/acpi/pcihp.h"
-- 
2.20.1
