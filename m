Received: from eggs.gnu.org ([209.51.188.92]:36773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goppj-0001Na-U3
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goppf-0006PZ-SC
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:13 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 30 Jan 2019 14:22:03 +0100
Message-Id: <20190130132214.25493-3-laurent@vivier.eu>
In-Reply-To: <20190130132214.25493-1-laurent@vivier.eu>
References: <20190130132214.25493-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/13] typo: apci->acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Stefan Hajnoczi <stefanha@redhat.com>, Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

apci_1_compatible should be acpi_1_compatible.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190125094047.22276-1-dgilbert@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/acpi/cpu.c         | 2 +-
 hw/i386/acpi-build.c  | 2 +-
 include/hw/acpi/cpu.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index f10b190019..a0a43fe6b5 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -508,7 +508,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
             GArray *madt_buf = g_array_new(0, 1, 1);
             int arch_id = arch_ids->cpus[i].arch_id;
 
-            if (opts.apci_1_compatible && arch_id < 255) {
+            if (opts.acpi_1_compatible && arch_id < 255) {
                 dev = aml_processor(i, 0, 0, CPU_NAME_FMT, i);
             } else {
                 dev = aml_device(CPU_NAME_FMT, i);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2e21a31f82..d60603abd7 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1847,7 +1847,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
         CPUHotplugFeatures opts = {
-            .apci_1_compatible = true, .has_legacy_cphp = true
+            .acpi_1_compatible = true, .has_legacy_cphp = true
         };
         build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
                        "\\_SB.PCI0", "\\_GPE._E02");
diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 89ce172941..62f0278ba2 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -48,7 +48,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
                          CPUHotplugState *state, hwaddr base_addr);
 
 typedef struct CPUHotplugFeatures {
-    bool apci_1_compatible;
+    bool acpi_1_compatible;
     bool has_legacy_cphp;
 } CPUHotplugFeatures;
 
-- 
2.20.1
