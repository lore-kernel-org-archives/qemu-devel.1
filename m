Received: from eggs.gnu.org ([209.51.188.92]:38580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjwm-0005TA-IW
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjwk-0002aR-R1
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:04 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:07 +1100
Message-Id: <20190218143049.17142-2-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/43] hw/ppc/prep: Drop useless inclusion of
 "hw/i386/pc.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

In 47973a2dbf we split the last generic chipset out of the PC
board, but forgot to remove the include of "hw/i386/pc.h".
Since it is now unused, remove it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/prep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 7bda86a7d0..847d320465 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -26,7 +26,6 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/timer/m48t59.h"
-#include "hw/i386/pc.h"
 #include "hw/char/serial.h"
 #include "hw/block/fdc.h"
 #include "net/net.h"
--=20
2.20.1
