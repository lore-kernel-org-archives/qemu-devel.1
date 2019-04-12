Received: from eggs.gnu.org ([209.51.188.92]:54287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzRm-0000rs-NT
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzRk-0006fK-5K
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:54:38 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Apr 2019 18:54:06 +0200
Message-Id: <20190412165416.7977-3-philmd@redhat.com>
In-Reply-To: <20190412165416.7977-1-philmd@redhat.com>
References: <20190412165416.7977-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 02/12] hw/arm/nseries: Use TYPE_TMP105
 instead of hardcoded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/nseries.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 906b7ca22d4..2b710c3d49f 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -31,6 +31,7 @@
 #include "hw/boards.h"
 #include "hw/i2c/i2c.h"
 #include "hw/devices.h"
+#include "hw/misc/tmp105.h"
 #include "hw/block/flash.h"
 #include "hw/hw.h"
 #include "hw/bt.h"
@@ -218,7 +219,7 @@ static void n8x0_i2c_setup(struct n800_s *s)
     qemu_register_powerdown_notifier(&n8x0_system_powerdown_notifier);
=20
     /* Attach a TMP105 PM chip (A0 wired to ground) */
-    dev =3D i2c_create_slave(i2c, "tmp105", N8X0_TMP105_ADDR);
+    dev =3D i2c_create_slave(i2c, TYPE_TMP105, N8X0_TMP105_ADDR);
     qdev_connect_gpio_out(dev, 0, tmp_irq);
 }
=20
--=20
2.20.1
