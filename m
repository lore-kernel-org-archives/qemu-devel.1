Received: from eggs.gnu.org ([2001:4830:134:3::10]:33381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eC9AC-0008Lv-Cs
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:03:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eC9A9-0006gM-8Y
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:03:56 -0500
Received: from mail-co1nam03on0084.outbound.protection.outlook.com
	([104.47.40.84]:2622
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eC9A8-0006fl-Vj
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:03:53 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 7 Nov 2017 10:59:41 -0800
Message-ID: <bc63082170a982b0a45447134dcbd86b8df80386.1510080103.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510080103.git.alistair.francis@xilinx.com>
References: <cover.1510080103.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 2/2] xlnx-zcu102: Add an info message
 deprecating the EP108
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

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/arm/xlnx-zcu102.c | 3 +++
 1 file changed, 3 insertions(+)

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
 
-- 
2.11.0
