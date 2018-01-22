Received: from eggs.gnu.org ([2001:4830:134:3::10]:47814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1edi4F-0006li-AO
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1edi4E-0005kQ-Dp
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:47:43 -0500
Sender: Alistair Francis <alistair23@gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 22 Jan 2018 11:43:16 -0800
Message-Id: <dc02ea064f789c5120db0f0a00b45c6ad45d61b6.1516650109.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1516650109.git.alistair.francis@xilinx.com>
References: <cover.1516650109.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 1/9] microblaze: boot.c: Don't try to find
 NULL file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, qemu-arm@nongnu.org

Previously if no device tree was passed to microblaze_load_kernel() then
qemu_find_file() would try to find a NULL pointer. To avoid this put a
check around qemu_find_file().

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---

 hw/microblaze/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 457a08a2fe..35bfeda7aa 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -124,7 +124,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
     kernel_cmdline = qemu_opt_get(machine_opts, "append");
     dtb_arg = qemu_opt_get(machine_opts, "dtb");
     /* default to pcbios dtb as passed by machine_init */
-    if (!dtb_arg) {
+    if (!dtb_arg && dtb_filename) {
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, dtb_filename);
     }
 
-- 
2.14.1
