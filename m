Received: from eggs.gnu.org ([2001:4830:134:3::10]:38781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtW-0002MP-51
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtT-0007LW-JL
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59548 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmtT-0007LD-Ea
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:11 -0400
Date: Fri, 1 Jun 2018 19:27:10 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-17-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/31] ioapic: fix up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>

include files shouldn't have the "include/" part, that is implied.

Also, drop an unused include.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/intc/ioapic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 36139a4db6..c45f073271 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -28,9 +28,8 @@
 #include "hw/i386/apic.h"
 #include "hw/i386/ioapic.h"
 #include "hw/i386/ioapic_internal.h"
-#include "include/hw/pci/msi.h"
+#include "hw/pci/msi.h"
 #include "sysemu/kvm.h"
-#include "target/i386/cpu.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/x86-iommu.h"
 #include "trace.h"
--=20
MST
