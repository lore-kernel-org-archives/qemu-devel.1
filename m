Received: from eggs.gnu.org ([209.51.188.92]:50985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmxyp-0004wJ-Vy
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmxyn-0001Rb-UQ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:40:55 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 25 Jan 2019 09:40:46 +0000
Message-Id: <20190125094047.22276-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] typo: apci->acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: qemu-trivial@nongnu.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

apci_1_compatible should be acpi_1_compatible.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/acpi/cpu.c         | 2 +-
 hw/i386/acpi-build.c  | 2 +-
 include/hw/acpi/cpu.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index f10b190019..a0a43fe6b5 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -508,7 +508,7 @@ void build_cpus_aml(Aml *table, MachineState *machine=
, CPUHotplugFeatures opts,
             GArray *madt_buf =3D g_array_new(0, 1, 1);
             int arch_id =3D arch_ids->cpus[i].arch_id;
=20
-            if (opts.apci_1_compatible && arch_id < 255) {
+            if (opts.acpi_1_compatible && arch_id < 255) {
                 dev =3D aml_processor(i, 0, 0, CPU_NAME_FMT, i);
             } else {
                 dev =3D aml_device(CPU_NAME_FMT, i);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2e21a31f82..d60603abd7 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1847,7 +1847,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
         CPUHotplugFeatures opts =3D {
-            .apci_1_compatible =3D true, .has_legacy_cphp =3D true
+            .acpi_1_compatible =3D true, .has_legacy_cphp =3D true
         };
         build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
                        "\\_SB.PCI0", "\\_GPE._E02");
diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 89ce172941..62f0278ba2 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -48,7 +48,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owne=
r,
                          CPUHotplugState *state, hwaddr base_addr);
=20
 typedef struct CPUHotplugFeatures {
-    bool apci_1_compatible;
+    bool acpi_1_compatible;
     bool has_legacy_cphp;
 } CPUHotplugFeatures;
=20
--=20
2.20.1
