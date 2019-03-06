Received: from eggs.gnu.org ([209.51.188.92]:35676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1UPb-0005GN-GG
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1UPX-0002Pa-Gw
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:08:33 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  6 Mar 2019 12:07:03 +0100
Message-Id: <20190306110711.309-3-laurent@vivier.eu>
In-Reply-To: <20190306110711.309-1-laurent@vivier.eu>
References: <20190306110711.309-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/10] hw/i386/pc.c: remove unused function
 pc_acpi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, John Snow <jsnow@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-s390x@nongnu.org, Corey Minyard <minyard@acm.org>, Pierre Morel <pmorel@linux.ibm.com>, Wei Yang <richardw.yang@linux.intel.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Wei Yang <richardw.yang@linux.intel.com>

Function pc_acpi_init() is not used anymore.

Remove the definition and declaration.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190214084939.20640-2-richardw.yang@linux.intel.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/i386/pc.c         | 27 ---------------------------
 include/hw/i386/pc.h |  1 -
 2 files changed, 28 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3889eccdc322..578f772e7ce2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1688,33 +1688,6 @@ void pc_pci_as_mapping_init(Object *owner, MemoryRegion *system_memory,
                                         pci_address_space, -1);
 }
 
-void pc_acpi_init(const char *default_dsdt)
-{
-    char *filename;
-
-    if (acpi_tables != NULL) {
-        /* manually set via -acpitable, leave it alone */
-        return;
-    }
-
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, default_dsdt);
-    if (filename == NULL) {
-        warn_report("failed to find %s", default_dsdt);
-    } else {
-        QemuOpts *opts = qemu_opts_create(qemu_find_opts("acpi"), NULL, 0,
-                                          &error_abort);
-        Error *err = NULL;
-
-        qemu_opt_set(opts, "file", filename, &error_abort);
-
-        acpi_table_add_builtin(opts, &err);
-        if (err) {
-            warn_reportf_err(err, "failed to load %s: ", filename);
-        }
-        g_free(filename);
-    }
-}
-
 void xen_load_linux(PCMachineState *pcms)
 {
     int i;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 3ff127ebd037..54222a202d33 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -189,7 +189,6 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
 void pc_cpus_init(PCMachineState *pcms);
 void pc_hot_add_cpu(const int64_t id, Error **errp);
-void pc_acpi_init(const char *default_dsdt);
 
 void pc_guest_info_init(PCMachineState *pcms);
 
-- 
2.20.1
