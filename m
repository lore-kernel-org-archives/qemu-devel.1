Received: from eggs.gnu.org ([2001:4830:134:3::10]:49006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dpO0U-0007Fn-N8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 20:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dpO0P-00006v-Ts
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 20:15:50 -0400
Received: from mail-co1nam03on0046.outbound.protection.outlook.com
	([104.47.40.46]:30160
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dpO0P-00005z-Gr
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 20:15:45 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 5 Sep 2017 17:12:03 -0700
Message-ID: <16cf589bc0c0431fbba6bbed8d1a50b49d24e867.1504656490.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1504656490.git.alistair.francis@xilinx.com>
References: <cover.1504656490.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 2/2] netduino2: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/arm/netduino2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 3cfe332dd1..accca344fd 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -43,8 +43,13 @@ static void netduino2_init(MachineState *machine)
 
 static void netduino2_machine_init(MachineClass *mc)
 {
+    const char *val = "cortex-m3";
+
     mc->desc = "Netduino 2 Machine";
     mc->init = netduino2_init;
+
+    mc->valid_cpu_types = g_array_new(false, false, sizeof(char *));
+    g_array_append_val(mc->valid_cpu_types, val);
 }
 
 DEFINE_MACHINE("netduino2", netduino2_machine_init)
-- 
2.11.0
