Received: from eggs.gnu.org ([2001:4830:134:3::10]:47360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eDFNC-0005Nn-Pt
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 14:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eDFNB-0006EZ-BH
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 14:53:54 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 10 Nov 2017 14:53:44 -0500
Message-Id: <1510343626-25861-4-git-send-email-cota@braap.org>
In-Reply-To: <1510343626-25861-1-git-send-email-cota@braap.org>
References: <1510343626-25861-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH for 2.11 3/5] xlnx-zcu102: Add an info message
 deprecating the EP108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

From: Alistair Francis <alistair.francis@xilinx.com>

The EP108 was an early access development board that is no longer used.
Add an info message to convert any users to the ZCU102 instead. On QEMU
they are both identical.

This patch also updated the qemu-doc.texi file to indicate that the
EP108 has been deprecated.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Emilio G. Cota <cota@braap.org>
---
 qemu-doc.texi        | 7 +++++++
 hw/arm/xlnx-zcu102.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 8c10956..d383ac4 100644
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
 
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 7ec03da..adddd23 100644
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
 
-- 
2.7.4
