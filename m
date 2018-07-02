Received: from eggs.gnu.org ([2001:4830:134:3::10]:36021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fa8YL-0008U8-Et
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 19:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fa8YK-0007GD-CL
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 19:48:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fa8YK-0007Fv-7V
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 19:48:16 -0400
Date: Tue, 3 Jul 2018 02:48:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180702234631.12268-2-mst@redhat.com>
References: <20180702234631.12268-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702234631.12268-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] hw/i386: Fix IVHD entry length for AMD IOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Counting from the IVHD ID field to the all-devices entry, we have 28
bytes, not 36.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9bc6d97ea1..fff1059a31 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2537,7 +2537,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
                              (1UL << 7),  /* PPRSup       */
                              1);
     /* IVHD length */
-    build_append_int_noprefix(table_data, 0x24, 2);
+    build_append_int_noprefix(table_data, 28, 2);
     /* DeviceID */
     build_append_int_noprefix(table_data, s->devid, 2);
     /* Capability offset */
-- 
MST
