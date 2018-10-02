Received: from eggs.gnu.org ([2001:4830:134:3::10]:48015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.guo.simon@linux.alibaba.com>) id 1g7KG1-0004Hn-Il
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.guo.simon@linux.alibaba.com>) id 1g7KFy-0005OW-CJ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:58:33 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:26999)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.guo.simon@linux.alibaba.com>)
	id 1g7KFw-0005Kc-Gf
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:58:30 -0400
From: wei.guo.simon@linux.alibaba.com
Date: Tue,  2 Oct 2018 09:20:53 +0800
Message-Id: <1538443253-6480-1-git-send-email-wei.guo.simon@linux.alibaba.com>
Subject: [Qemu-devel] [PATCH] hw/i386: add legacy cpu hotplug for pc-lite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Chao Peng <chao.p.peng@linux.intel.com>

From: Simon Guo <wei.guo.simon@linux.alibaba.com>

Currently pc-lite cpu hot plug will leads to error like:
"acpi: device plug request for not supported device type: host-x86_64-cpu"

. However pc_lite_machine_options() didn't setup flag legacy_cpu_hotplug
correctly, which will leads to a later mess state, and causes the error
above.

This patch corrects this by initialize legacy_cpu_hotplug flag
correctly at pc_lite_machine_options().

Signed-off-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 hw/i386/pc_lite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/pc_lite.c b/hw/i386/pc_lite.c
index 707f2fd..5fd05b1 100644
--- a/hw/i386/pc_lite.c
+++ b/hw/i386/pc_lite.c
@@ -196,6 +196,7 @@ static void pc_lite_machine_options(MachineClass *m)
     m->units_per_default_bus = 1;
     m->no_floppy = 1;
     pcmc->type = PC_MACHINE_TYPE_LITE;
+	pcmc->legacy_cpu_hotplug = true;
 }
 
 static void pc_lite_2_7_machine_options(MachineClass *m)
-- 
1.8.3.1
