Received: from eggs.gnu.org ([2001:4830:134:3::10]:50645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7lz-0006QH-Mv
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7ly-0007yQ-QA
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51844 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7ly-0007yI-Ks
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:14 -0400
Date: Tue, 20 Mar 2018 05:17:11 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-9-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 08/50] acpi: move ACPI_PORT_SMI_CMD define to
 header it belongs to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Eric Auger <eric.auger@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

ACPI_PORT_SMI_CMD is alias for APM_CNT_IOPORT,
so make it really one instead of duplicating its value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/isa/apm.h | 3 +++
 hw/i386/acpi-build.c | 2 --
 hw/isa/apm.c         | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/isa/apm.h b/include/hw/isa/apm.h
index 4839ff1..b7098bf 100644
--- a/include/hw/isa/apm.h
+++ b/include/hw/isa/apm.h
@@ -5,6 +5,9 @@
 #include "hw/hw.h"
 #include "exec/memory.h"
 
+#define APM_CNT_IOPORT  0xb2
+#define ACPI_PORT_SMI_CMD APM_CNT_IOPORT
+
 typedef void (*apm_ctrl_changed_t)(uint32_t val, void *arg);
 
 typedef struct APMState {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b85fefe..699f3a0 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -255,8 +255,6 @@ static void acpi_get_pci_holes(Range *hole, Range *hole64)
                                                NULL));
 }
 
-#define ACPI_PORT_SMI_CMD           0x00b2 /* TODO: this is APM_CNT_IOPORT */
-
 static void acpi_align_size(GArray *blob, unsigned align)
 {
     /* Align size to multiple of given size. This reduces the chance
diff --git a/hw/isa/apm.c b/hw/isa/apm.c
index e232b0d..c3101ef 100644
--- a/hw/isa/apm.c
+++ b/hw/isa/apm.c
@@ -34,7 +34,6 @@
 #endif
 
 /* fixed I/O location */
-#define APM_CNT_IOPORT  0xb2
 #define APM_STS_IOPORT  0xb3
 
 static void apm_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
-- 
MST
