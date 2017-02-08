Received: from eggs.gnu.org ([2001:4830:134:3::10]:59393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cbX2B-00061Y-AU
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cbX28-0004o8-7w
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:32:03 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  8 Feb 2017 19:31:57 +0100
Message-Id: <1486578717-30324-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/pnv: Remove superfluous "qemu" prefix
 from error strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

error_report() already puts a prefix with the program name in front
of the error strings, so the "qemu:" prefix is not necessary here
anymore.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/pnv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 4fab5c0..09f0d22 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -381,7 +381,7 @@ static void ppc_powernv_init(MachineState *machine)
 
     fw_size = load_image_targphys(fw_filename, FW_LOAD_ADDR, FW_MAX_SIZE);
     if (fw_size < 0) {
-        error_report("qemu: could not load OPAL '%s'", fw_filename);
+        error_report("Could not load OPAL '%s'", fw_filename);
         exit(1);
     }
     g_free(fw_filename);
@@ -393,7 +393,7 @@ static void ppc_powernv_init(MachineState *machine)
         kernel_size = load_image_targphys(machine->kernel_filename,
                                           KERNEL_LOAD_ADDR, 0x2000000);
         if (kernel_size < 0) {
-            error_report("qemu: could not load kernel'%s'",
+            error_report("Could not load kernel '%s'",
                          machine->kernel_filename);
             exit(1);
         }
@@ -405,7 +405,7 @@ static void ppc_powernv_init(MachineState *machine)
         pnv->initrd_size = load_image_targphys(machine->initrd_filename,
                                   pnv->initrd_base, 0x10000000); /* 128MB max */
         if (pnv->initrd_size < 0) {
-            error_report("qemu: could not load initial ram disk '%s'",
+            error_report("Could not load initial ram disk '%s'",
                          machine->initrd_filename);
             exit(1);
         }
-- 
1.8.3.1
