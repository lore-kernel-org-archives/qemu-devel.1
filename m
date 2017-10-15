Received: from eggs.gnu.org ([2001:4830:134:3::10]:49380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZX4-00037I-Mw
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZX3-0007Dz-Ql
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZX3-0007DU-J8
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:05 -0400
Date: Sun, 15 Oct 2017 06:24:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-26-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 25/26] pc: remove useless hot_add_cpu
 initialisation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

From: Laurent Vivier <lvivier@redhat.com>

Since 4458fb3a79 (pc: Eliminate pc_default_machine_options()),
hot_add_cpu is set in pc_machine_class_init(), so we don't
need to set it in pc_q35_machine_options(), pc_i440fx_machine_options()
and xenfv_machine_options(), except to clear it in
pc_i440fx_1_4_machine_opt().

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 2 --
 hw/i386/pc_q35.c  | 1 -
 2 files changed, 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9dbcbcd..f79d5cb 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -426,7 +426,6 @@ static void pc_i440fx_machine_options(MachineClass *m)
 {
     m->family = "pc_piix";
     m->desc = "Standard PC (i440FX + PIIX, 1996)";
-    m->hot_add_cpu = pc_hot_add_cpu;
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
 }
@@ -1125,7 +1124,6 @@ static void xenfv_machine_options(MachineClass *m)
     m->desc = "Xen Fully-virtualized PC";
     m->max_cpus = HVM_MAX_VCPUS;
     m->default_machine_opts = "accel=xen";
-    m->hot_add_cpu = pc_hot_add_cpu;
 }
 
 DEFINE_PC_MACHINE(xenfv, "xenfv", pc_xen_hvm_init,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6c4ec4b..da3ea60 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -295,7 +295,6 @@ static void pc_q35_machine_options(MachineClass *m)
 {
     m->family = "pc_q35";
     m->desc = "Standard PC (Q35 + ICH9, 2009)";
-    m->hot_add_cpu = pc_hot_add_cpu;
     m->units_per_default_bus = 1;
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
-- 
MST
