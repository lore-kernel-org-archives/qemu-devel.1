Received: from eggs.gnu.org ([2001:4830:134:3::10]:56176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFP-000290-H3
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFO-00024D-TO
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34170 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKFO-00023k-MW
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:34 -0400
Date: Thu, 3 May 2018 22:50:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-10-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 09/67] ioapic: fix up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

include files shouldn't have the "include/" part,
that is implied.

Also, drop an unused include.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/intc/ioapic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 36139a4..c45f073 100644
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
-- 
MST
