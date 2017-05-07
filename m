Received: from eggs.gnu.org ([2001:4830:134:3::10]:54091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GJj-0005jO-5C
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GJg-0000Hq-6m
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:09:19 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:04 +0300
Message-Id: <d0e31a105e2a353a2ac148c8f0044cfa8939f645.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 01/23] Remove reduntant qemu: from error
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Ishani Chugh <chugh.ishani@research.iiit.ac.in>

This patch removes redundant "qemu:" from error functions. The link to the bitesized task is:
http://wiki.qemu-project.org/Contribute/BiteSizedTasks#Error_checking

Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/microblaze/boot.c           | 2 +-
 hw/nios2/boot.c                | 2 +-
 hw/ppc/pnv.c                   | 2 +-
 hw/s390x/sclp.c                | 4 ++--
 hw/tricore/tricore_testboard.c | 2 +-
 numa.c                         | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 1834d22a61..457a08a2fe 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -189,7 +189,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
                                                   ram_size - initrd_offset);
             }
             if (initrd_size < 0) {
-                error_report("qemu: could not load initrd '%s'",
+                error_report("could not load initrd '%s'",
                              initrd_filename);
                 exit(EXIT_FAILURE);
             }
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index e0a9aff2f4..2b31f5b844 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -197,7 +197,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
                                                   ram_size - initrd_offset);
             }
             if (initrd_size < 0) {
-                error_report("qemu: could not load initrd '%s'",
+                error_report("could not load initrd '%s'",
                              initrd_filename);
                 exit(EXIT_FAILURE);
             }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d4bcdb027f..6a498565c7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -610,7 +610,7 @@ static void ppc_powernv_init(MachineState *machine)
     /* Create the processor chips */
     chip_typename = g_strdup_printf(TYPE_PNV_CHIP "-%s", machine->cpu_model);
     if (!object_class_by_name(chip_typename)) {
-        error_report("qemu: invalid CPU model '%s' for %s machine",
+        error_report("invalid CPU model '%s' for %s machine",
                      machine->cpu_model, MACHINE_GET_CLASS(machine)->name);
         exit(1);
     }
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index e741da1141..6996088584 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -496,10 +496,10 @@ static void sclp_realize(DeviceState *dev, Error **errp)
 
     ret = s390_set_memory_limit(machine->maxram_size, &hw_limit);
     if (ret == -E2BIG) {
-        error_setg(&err, "qemu: host supports a maximum of %" PRIu64 " GB",
+        error_setg(&err, "host supports a maximum of %" PRIu64 " GB",
                    hw_limit >> 30);
     } else if (ret) {
-        error_setg(&err, "qemu: setting the guest size failed");
+        error_setg(&err, "setting the guest size failed");
     }
 
 out:
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 19dd587207..8910bf0f27 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -50,7 +50,7 @@ static void tricore_load_kernel(CPUTriCoreState *env)
                            NULL, 0,
                            EM_TRICORE, 1, 0);
     if (kernel_size <= 0) {
-        error_report("qemu: no kernel file '%s'",
+        error_report("no kernel file '%s'",
                 tricoretb_binfo.kernel_filename);
         exit(1);
     }
diff --git a/numa.c b/numa.c
index 6fc2393ddd..39b743bd94 100644
--- a/numa.c
+++ b/numa.c
@@ -174,7 +174,7 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
     }
 
     if (node->has_mem && node->has_memdev) {
-        error_setg(errp, "qemu: cannot specify both mem= and memdev=");
+        error_setg(errp, "cannot specify both mem= and memdev=");
         return;
     }
 
@@ -182,7 +182,7 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
         have_memdevs = node->has_memdev;
     }
     if (node->has_memdev != have_memdevs) {
-        error_setg(errp, "qemu: memdev option must be specified for either "
+        error_setg(errp, "memdev option must be specified for either "
                    "all or no nodes");
         return;
     }
-- 
2.11.0
