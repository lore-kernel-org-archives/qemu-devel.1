Received: from eggs.gnu.org ([209.51.188.92]:59881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0T-0005Mw-Kz
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0S-0004GK-Em
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:05:53 +1000
Message-Id: <20190426060627.18153-3-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/36] hw/ppc/prep: Drop useless inclusion of
 "hw/input/i8042.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

In commit 47973a2dbf we split the last generic chipset out of
the PC board, but missed to remove the i8042 keyboard controller.
This omission was later fixed in commit 7cb00357c1, but here we
forgot to remove the "i8042.h" include. Do it now.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190316201528.9140-1-philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/prep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 847d320465..b7f459d475 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -40,7 +40,6 @@
 #include "hw/ide.h"
 #include "hw/loader.h"
 #include "hw/timer/mc146818rtc.h"
-#include "hw/input/i8042.h"
 #include "hw/isa/pc87312.h"
 #include "hw/net/ne2000-isa.h"
 #include "sysemu/arch_init.h"
--=20
2.20.1
