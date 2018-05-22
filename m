Received: from eggs.gnu.org ([2001:4830:134:3::10]:41842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fL4xL-000218-UP
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fL4xL-00039V-AP
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:55:52 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 11:39:57 +0100
Message-Id: <20180522104000.9044-3-peter.maydell@linaro.org>
In-Reply-To: <20180522104000.9044-1-peter.maydell@linaro.org>
References: <20180522104000.9044-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/5] hw/i386: Rename 2.13 machine types to 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

Rename the 2.13 machine types to match what we're going to
use as our next release number.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/pc_piix.c | 8 ++++----
 hw/i386/pc_q35.c  | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e36c7bbb40..b4c5b03274 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -425,19 +425,19 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_display = "std";
 }
 
-static void pc_i440fx_2_13_machine_options(MachineClass *m)
+static void pc_i440fx_3_0_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
 }
 
-DEFINE_I440FX_MACHINE(v2_13, "pc-i440fx-2.13", NULL,
-                      pc_i440fx_2_13_machine_options);
+DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
+                      pc_i440fx_3_0_machine_options);
 
 static void pc_i440fx_2_12_machine_options(MachineClass *m)
 {
-    pc_i440fx_2_13_machine_options(m);
+    pc_i440fx_3_0_machine_options(m);
     m->is_default = 0;
     m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 2372457c6a..83d6d75efa 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -308,18 +308,18 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_2_13_machine_options(MachineClass *m)
+static void pc_q35_3_0_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
-DEFINE_Q35_MACHINE(v2_13, "pc-q35-2.13", NULL,
-                    pc_q35_2_13_machine_options);
+DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
+                    pc_q35_3_0_machine_options);
 
 static void pc_q35_2_12_machine_options(MachineClass *m)
 {
-    pc_q35_2_13_machine_options(m);
+    pc_q35_3_0_machine_options(m);
     m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
 }
-- 
2.17.0
