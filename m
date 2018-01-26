Received: from eggs.gnu.org ([2001:4830:134:3::10]:40421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ef5UW-00039D-Hq
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ef5US-00053Q-AC
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:00:32 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:37358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1ef5US-000533-37
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:00:28 -0500
Received: by mail-lf0-x244.google.com with SMTP id 63so1046270lfv.4
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 07:00:27 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 26 Jan 2018 11:22:34 +0100
Message-Id: <1516962162-25680-2-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1516962162-25680-1-git-send-email-edgar.iglesias@gmail.com>
References: <1516962162-25680-1-git-send-email-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 1/9] microblaze: boot.c: Don't try to find
 NULL file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: Alistair Francis <alistair.francis@xilinx.com>

Previously if no device tree was passed to microblaze_load_kernel() then
qemu_find_file() would try to find a NULL pointer. To avoid this put a
check around qemu_find_file().

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/microblaze/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 457a08a..35bfeda 100644
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
2.7.4
