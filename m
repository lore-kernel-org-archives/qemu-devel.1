Received: from eggs.gnu.org ([2001:4830:134:3::10]:56821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1coqBq-0003mM-QR
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1coqBl-000733-US
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:37:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:35779)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1coqBl-00071r-Jn
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:36:57 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Fri, 17 Mar 2017 19:29:14 +0800
Message-Id: <1489750157-17401-2-git-send-email-tianyu.lan@intel.com>
In-Reply-To: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [RFC PATCH 1/4] I440: Allow adding sysbus devices with
 -device on I440
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: chao.gao@intel.com, kevin.tian@intel.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, Lan Tianyu <tianyu.lan@intel.com>

From: Chao Gao <chao.gao@intel.com>

xen-viommu will be a sysbus device and the device model will
be enabled via "-device" parameter.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 hw/i386/pc_piix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a07dc81..3289593 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -436,6 +436,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->hot_add_cpu = pc_hot_add_cpu;
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
+    m->has_dynamic_sysbus = true;
 }
 
 static void pc_i440fx_2_7_machine_options(MachineClass *m)
-- 
1.8.3.1
