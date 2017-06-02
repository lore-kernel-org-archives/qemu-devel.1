Received: from eggs.gnu.org ([2001:4830:134:3::10]:35271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dGpZB-0001EX-5r
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dGpZA-0007j3-EC
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:36:49 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri,  2 Jun 2017 18:36:16 +0200
Message-Id: <20170602163618.6369-7-krzk@kernel.org>
In-Reply-To: <20170602163618.6369-1-krzk@kernel.org>
References: <20170602162857.6065-1-krzk@kernel.org>
	<20170602163618.6369-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 7/9] hw/arm/exynos: Use type define instead
 of hard-coded a9mpcore_priv string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Krzysztof Kozlowski <krzk@kernel.org>

Use a define for a9mpcore_priv device type name instead of hard-coded
string.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/arm/exynos4210.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 27a7bf28a5a9..0050626a6967 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -26,6 +26,7 @@
 #include "qemu-common.h"
 #include "qemu/log.h"
 #include "cpu.h"
+#include "hw/cpu/a9mpcore.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
@@ -211,7 +212,7 @@ Exynos4210State *exynos4210_init(MemoryRegion *system=
_mem)
     }
=20
     /* Private memory region and Internal GIC */
-    dev =3D qdev_create(NULL, "a9mpcore_priv");
+    dev =3D qdev_create(NULL, TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", EXYNOS4210_NCPUS);
     qdev_init_nofail(dev);
     busdev =3D SYS_BUS_DEVICE(dev);
--=20
2.9.3
