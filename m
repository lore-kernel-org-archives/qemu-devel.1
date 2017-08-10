Received: from eggs.gnu.org ([2001:4830:134:3::10]:35996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dfkQj-0001Xu-R1
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 06:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dfkQe-0000Lz-A1
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 06:11:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:65320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dfkQe-0000Lk-1I
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 06:11:00 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Thu, 10 Aug 2017 18:08:07 +0800
Message-Id: <1502359687-25370-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [PATCH] x86: Increase max vcpu number to 352
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

Intel Xeon phi chip will support 352 logical threads. For HPC
usage case, it will create a huge VM with vcpus number as same as host
cpus. This patch is to increase max vcpu number to 352.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 hw/i386/pc_q35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 169a214..5e93749 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -299,7 +299,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->default_display = "std";
     m->no_floppy = 1;
     m->has_dynamic_sysbus = true;
-    m->max_cpus = 288;
+    m->max_cpus = 352;
 }
 
 static void pc_q35_2_10_machine_options(MachineClass *m)
-- 
1.8.3.1
