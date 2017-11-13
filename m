Received: from eggs.gnu.org ([2001:4830:134:3::10]:47266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSE-00044P-T3
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSD-0007fD-Sc
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:14 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eEFSD-0007Yd-LN
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:13 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFS7-00024K-0O
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:11:07 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 14:11:41 +0000
Message-Id: <1510582304-27058-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
References: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 6/9] xlnx-zcu102: Add an info message
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

From: Alistair Francis <alistair.francis@xilinx.com>

The EP108 was an early access development board that is no longer used.
Add an info message to convert any users to the ZCU102 instead. On QEMU
they are both identical.

This patch also updated the qemu-doc.texi file to indicate that the
EP108 has been deprecated.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Message-id: 1510343626-25861-4-git-send-email-cota@braap.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zcu102.c | 3 +++
 qemu-doc.texi        | 7 +++++++
 2 files changed, 10 insertions(+)

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
 
-- 
2.7.4
