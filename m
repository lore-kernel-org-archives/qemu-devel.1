Received: from eggs.gnu.org ([2001:4830:134:3::10]:59940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dhrc4-00078z-Fy
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dhrbz-0000Nx-M7
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:15:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:38744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dhrbz-0000Lt-Do
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:15:27 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Tue, 15 Aug 2017 20:06:19 -0400
Message-Id: <1502841979-6233-2-git-send-email-tianyu.lan@intel.com>
In-Reply-To: <1502841979-6233-1-git-send-email-tianyu.lan@intel.com>
References: <1502841979-6233-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [PATCH v3 2/2] x86: Increase max vcpu number to 8192
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, berrange@redhat.com, rkrcmar@redhat.com

For HPC usage case, it will create a huge VM with vcpus number as same as host
cpus and this requires more vcpus support in a single VM. This patch is to
increase max vcpu number from 288 to 8192 which is current default maximum cpu
number for Linux kernel.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 hw/i386/pc_q35.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b469d05..3468f5a 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -299,7 +299,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->default_display = "std";
     m->no_floppy = 1;
     m->has_dynamic_sysbus = true;
-    m->max_cpus = 288;
+    m->max_cpus = 8192;
 }
 
 static void pc_q35_2_11_machine_options(MachineClass *m)
@@ -314,6 +314,7 @@ static void pc_q35_2_10_machine_options(MachineClass *m)
 {
     pc_q35_2_11_machine_options(m);
     m->alias = NULL;
+    m->max_cpus = 288;
     m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
 }
-- 
1.8.3.1
