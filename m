Received: from eggs.gnu.org ([2001:4830:134:3::10]:59580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA9q-00051w-1P
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA9l-0003GI-1T
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:61528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gIA9i-00032x-4p
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:52 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu,  1 Nov 2018 11:22:54 +0100
Message-Id: <20181101102303.16439-15-sameo@linux.intel.com>
In-Reply-To: <20181101102303.16439-1-sameo@linux.intel.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 14/23] hw: i386: Export the i386 ACPI SRAT
 build method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

This is the standard way of building SRAT on x86 platfoms. But future
machine types could decide to define their own custom SRAT build method
through the ACPI builder methods.
Moreover, we will also need to reach build_srat() from outside of
acpi-build in order to use it as the ACPI builder SRAT build method.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/i386/acpi-build.c | 2 +-
 hw/i386/acpi-build.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1ef1a38441..673c5dfafc 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1615,7 +1615,7 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
 #define HOLE_640K_START  (640 * KiB)
 #define HOLE_640K_END   (1 * MiB)
 
-static void
+void
 build_srat(GArray *table_data, BIOSLinker *linker,
            MachineState *machine, AcpiConfiguration *acpi_conf)
 {
diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 065a1d8250..d73c41fe8f 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -4,6 +4,11 @@
 
 #include "hw/acpi/acpi.h"
 
+/* ACPI SRAT (Static Resource Affinity Table) build method for x86 */
+void
+build_srat(GArray *table_data, BIOSLinker *linker,
+           MachineState *machine, AcpiConfiguration *acpi_conf);
+
 void acpi_setup(MachineState *machine, AcpiConfiguration *acpi_conf);
 
 #endif
-- 
2.19.1
