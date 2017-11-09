Received: from eggs.gnu.org ([2001:4830:134:3::10]:33098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCuli-0008QH-3R
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 16:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCuld-0002FL-8k
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 16:53:50 -0500
Received: from mail-bl2nam02on0066.outbound.protection.outlook.com
	([104.47.38.66]:41169
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCuld-0002Ep-30
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 16:53:45 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 9 Nov 2017 13:49:35 -0800
Message-ID: <b2df555986423d225a0a79fb58e2a93054ac5300.1510263731.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510263731.git.alistair.francis@xilinx.com>
References: <cover.1510263731.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for 2.11 v2 2/2] xlnx-zcu102: Add an info
 message deprecating the EP108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, ehabkost@redhat.com, cota@braap.org, f4bug@amsat.org

The EP108 was an early access development board that is no longer used.
Add an info message to convert any users to the ZCU102 instead. On QEMU
they are both identical.

This patch also updated the qemu-doc.texi file to indicate that the
EP108 has been deprecated.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---
V2:
 - Update the qemu-doc.texi file

 hw/arm/xlnx-zcu102.c | 3 +++
 qemu-doc.texi        | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 7ec03dad42..adddd234a1 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -164,6 +164,9 @@ static void xlnx_ep108_init(MachineState *machine)
 {
     XlnxZCU102 *s = EP108_MACHINE(machine);
 
+    info_report("The Xilinx EP108 machine is deprecated, please use the "
+                "ZCU102 machine instead. It has the same features supported.");
+
     xlnx_zynqmp_init(s, machine);
 }
 
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 8c10956a66..d383ac44d4 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2537,6 +2537,13 @@ or ``ivshmem-doorbell`` device types.
 The ``spapr-pci-vfio-host-bridge'' device type is replaced by
 the ``spapr-pci-host-bridge'' device type.
 
+@section System emulator machines
+
+@subsection Xilinx EP108 (since 2.11.0)
+
+The ``xlnx-ep108'' machine has been replaced by the ``xlnx-zcu102'' machine.
+The ``xlnx-zcu102'' machine has the same features and capabilites in QEMU.
+
 @node License
 @appendix License
 
-- 
2.14.1
