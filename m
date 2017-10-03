Received: from eggs.gnu.org ([2001:4830:134:3::10]:49208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dzTV9-0000Ho-2n
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dzTV5-0006Oa-Sx
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:09:11 -0400
Received: from mail-dm3nam03on0045.outbound.protection.outlook.com
	([104.47.41.45]:5536
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dzTV5-0006OE-Lp
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:09:07 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 3 Oct 2017 13:05:16 -0700
Message-ID: <ea095f0e516828d978bf2e7344100c20d89788f7.1507059418.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1507059418.git.alistair.francis@xilinx.com>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 4/5] xilinx_zynq: : Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com, f4bug@amsat.org

List all possible valid CPU options.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/arm/xilinx_zynq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 1836a4ed45..de1e0bbce1 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -313,6 +313,10 @@ static void zynq_init(MachineState *machine)
     arm_load_kernel(ARM_CPU(first_cpu), &zynq_binfo);
 }
 
+const char *xlnx_zynq_7000_valid_cpus[] = { ARM_CPU_TYPE_NAME("cortex-a9"),
+                                            NULL
+                                          };
+
 static void zynq_machine_init(MachineClass *mc)
 {
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
@@ -321,6 +325,7 @@ static void zynq_machine_init(MachineClass *mc)
     mc->no_sdcard = 1;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->valid_cpu_types = xlnx_zynq_7000_valid_cpus;
 }
 
 DEFINE_MACHINE("xilinx-zynq-a9", zynq_machine_init)
-- 
2.11.0
