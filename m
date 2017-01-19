Received: from eggs.gnu.org ([2001:4830:134:3::10]:36682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxd-0000PW-GE
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxc-00084p-DR
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:33 -0500
Received: from mail.kernel.org ([198.145.29.136]:56726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxc-000834-3C
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:32 -0500
Date: Thu, 19 Jan 2017 23:09:26 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484860116-25361-8-git-send-email-mst@redhat.com>
References: <1484860116-25361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484860116-25361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 07/17] pc: Add 2.9 machine-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gabriel Somlo <somlo@cmu.edu>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

From: Eduardo Habkost <ehabkost@redhat.com>

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gabriel Somlo <somlo@cmu.edu>
Tested-by: Gabriel Somlo <somlo@cmu.edu>
Cc: Gabriel Somlo <somlo@cmu.edu>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h |  2 ++
 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index b22e699..230e9e7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -375,6 +375,8 @@ int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_2_8 \
+    HW_COMPAT_2_8 \
+
 
 #define PC_COMPAT_2_7 \
     HW_COMPAT_2_7 \
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5e1adbe..9f102aa 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -437,13 +437,24 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_display = "std";
 }
 
-static void pc_i440fx_2_8_machine_options(MachineClass *m)
+static void pc_i440fx_2_9_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
 }
 
+DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
+                      pc_i440fx_2_9_machine_options);
+
+static void pc_i440fx_2_8_machine_options(MachineClass *m)
+{
+    pc_i440fx_2_9_machine_options(m);
+    m->is_default = 0;
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
+}
+
 DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
                       pc_i440fx_2_8_machine_options);
 
@@ -451,8 +462,6 @@ DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
 static void pc_i440fx_2_7_machine_options(MachineClass *m)
 {
     pc_i440fx_2_8_machine_options(m);
-    m->is_default = 0;
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_7);
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d042fe0..dd792a8 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -301,19 +301,28 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_2_8_machine_options(MachineClass *m)
+static void pc_q35_2_9_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
+                   pc_q35_2_9_machine_options);
+
+static void pc_q35_2_8_machine_options(MachineClass *m)
+{
+    pc_q35_2_9_machine_options(m);
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
+}
+
 DEFINE_Q35_MACHINE(v2_8, "pc-q35-2.8", NULL,
                    pc_q35_2_8_machine_options);
 
 static void pc_q35_2_7_machine_options(MachineClass *m)
 {
     pc_q35_2_8_machine_options(m);
-    m->alias = NULL;
     m->max_cpus = 255;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_7);
 }
-- 
MST
