Received: from eggs.gnu.org ([2001:4830:134:3::10]:33178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8o7-0001en-LQ
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8o5-0003qz-0e
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:11 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Mon,  2 Jan 2017 21:01:41 +0100
Message-Id: <20170102200153.28864-5-drjones@redhat.com>
In-Reply-To: <20170102200153.28864-1-drjones@redhat.com>
References: <20170102200153.28864-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/16] hw/arm/virt-acpi-build: fadt: improve
 flag naming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: imammedo@redhat.com, peter.maydell@linaro.org, zhaoshenglong@huawei.com, shannon.zhao@linaro.org, mst@redhat.com, ehabkost@redhat.com

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt-acpi-build.c    | 4 ++--
 include/hw/acpi/acpi-defs.h | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b6b64296f119..a6c6180f4bce 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -642,8 +642,8 @@ build_fadt(GArray *table_data, BIOSLinker *linker, unsigned dsdt_tbl_offset)
 
     /* Hardware Reduced = 1 and use PSCI 0.2+ and with HVC */
     fadt->flags = cpu_to_le32(1 << ACPI_FADT_F_HW_REDUCED_ACPI);
-    fadt->arm_boot_flags = cpu_to_le16((1 << ACPI_FADT_ARM_USE_PSCI_G_0_2) |
-                                       (1 << ACPI_FADT_ARM_PSCI_USE_HVC));
+    fadt->arm_boot_flags = cpu_to_le16(ACPI_FADT_ARM_PSCI_COMPLIANT |
+                                       ACPI_FADT_ARM_PSCI_USE_HVC);
 
     /* ACPI v5.1 (fadt->revision.fadt->minor_revision) */
     fadt->minor_revision = 0x1;
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 8fe0996e15fb..d15b7e5cd39a 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -191,10 +191,8 @@ struct AcpiFadtDescriptorRev5_1 {
 
 typedef struct AcpiFadtDescriptorRev5_1 AcpiFadtDescriptorRev5_1;
 
-enum {
-    ACPI_FADT_ARM_USE_PSCI_G_0_2 = 0,
-    ACPI_FADT_ARM_PSCI_USE_HVC = 1,
-};
+#define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
+#define ACPI_FADT_ARM_PSCI_USE_HVC    (1 << 1)
 
 /*
  * Serial Port Console Redirection Table (SPCR), Rev. 1.02
-- 
2.9.3
