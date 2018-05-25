Received: from eggs.gnu.org ([2001:4830:134:3::10]:58331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFse-0003kS-Iv
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFsc-0002iM-7D
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMFsc-0002iB-3b
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:50 -0400
Date: Fri, 25 May 2018 19:47:49 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527266793-301361-9-git-send-email-mst@redhat.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527266793-301361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/20] ioapic: fix up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

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
