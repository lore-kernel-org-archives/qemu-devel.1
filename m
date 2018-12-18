Received: from eggs.gnu.org ([2001:4830:134:3::10]:51399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6q4-000608-VJ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6q3-0007rO-Iy
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:36 -0500
Date: Mon, 17 Dec 2018 23:18:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218041625.24969-24-mst@redhat.com>
References: <20181218041625.24969-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218041625.24969-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/31] hw: acpi: The RSDP build API can return
 void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org

From: Samuel Ortiz <sameo@linux.intel.com>

For both x86 and ARM architectures, the internal RSDP build API can
return void as the current return value is unused.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt-acpi-build.c | 4 +---
 hw/i386/acpi-build.c     | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 5785fb697c..fcaa350892 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -367,7 +367,7 @@ static void acpi_dsdt_add_power_button(Aml *scope)
 }
=20
 /* RSDP */
-static GArray *
+static void
 build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_off=
set)
 {
     AcpiRsdpDescriptor *rsdp =3D acpi_data_push(rsdp_table, sizeof *rsdp=
);
@@ -392,8 +392,6 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, un=
signed xsdt_tbl_offset)
     bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
         (char *)rsdp - rsdp_table->data, sizeof *rsdp,
         (char *)&rsdp->checksum - rsdp_table->data);
-
-    return rsdp_table;
 }
=20
 static void
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 236a20eaa8..35f17d0d91 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2547,7 +2547,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *lin=
ker)
                  "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
 }
=20
-static GArray *
+static void
 build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_off=
set)
 {
     AcpiRsdpDescriptor *rsdp =3D acpi_data_push(rsdp_table, sizeof *rsdp=
);
@@ -2569,8 +2569,6 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, =
unsigned rsdt_tbl_offset)
     bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
         (char *)rsdp - rsdp_table->data, sizeof *rsdp,
         (char *)&rsdp->checksum - rsdp_table->data);
-
-    return rsdp_table;
 }
=20
 typedef
--=20
MST
