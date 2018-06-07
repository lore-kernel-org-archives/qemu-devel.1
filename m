Received: from eggs.gnu.org ([2001:4830:134:3::10]:36964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fR3RJ-00012V-7w
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fR3RG-00052K-UL
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:31:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:60811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fR3RG-00050W-L2
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:31:26 -0400
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Thu,  7 Jun 2018 16:31:10 -0600
Message-Id: <20180607223111.27792-4-ross.zwisler@linux.intel.com>
In-Reply-To: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
Subject: [Qemu-devel] [qemu PATCH 4/5] machine: fix some misspelled words
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Normally this might not be worth fixing, but several of these are strings
which are displayed to users.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 hw/core/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 617e5f8d75..a21269fa39 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -609,7 +609,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
         machine_get_igd_gfx_passthru, machine_set_igd_gfx_passthru,
         &error_abort);
     object_class_property_set_description(oc, "igd-passthru",
-        "Set on/off to enable/disable igd passthrou", &error_abort);
+        "Set on/off to enable/disable igd passthru", &error_abort);
 
     object_class_property_add_str(oc, "firmware",
         machine_get_firmware, machine_set_firmware,
@@ -633,7 +633,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
         machine_get_memory_encryption, machine_set_memory_encryption,
         &error_abort);
     object_class_property_set_description(oc, "memory-encryption",
-        "Set memory encyption object to use", &error_abort);
+        "Set memory encryption object to use", &error_abort);
 }
 
 static void machine_class_base_init(ObjectClass *oc, void *data)
@@ -806,7 +806,7 @@ void machine_run_board_init(MachineState *machine)
         for (i = 0; machine_class->valid_cpu_types[i]; i++) {
             if (object_class_dynamic_cast(class,
                                           machine_class->valid_cpu_types[i])) {
-                /* The user specificed CPU is in the valid field, we are
+                /* The user specified CPU is in the valid field, we are
                  * good to go.
                  */
                 break;
-- 
2.14.4
