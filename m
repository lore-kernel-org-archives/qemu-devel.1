Received: from eggs.gnu.org ([2001:4830:134:3::10]:40954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xypron.glpk@gmx.de>) id 1gAJdT-00059g-AR
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xypron.glpk@gmx.de>) id 1gAJdP-00067D-Vw
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:55:07 -0400
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Date: Wed, 10 Oct 2018 20:54:45 +0200
Message-Id: <20181010185445.10290-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/1] hw/arm/virt: provide a model property in
 the fdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Heinrich Schuchardt <xypron.glpk@gmx.de>

Device trees in the Linux kernel generally provide a model property. Some
software like the Debian flash-kernel package rely on this property to
identify boards.

The patch sets the model property for the virt boards to 'QEMU virt'.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 281ddcdf6e..abe366895a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -200,6 +200,7 @@ static void create_fdt(VirtMachineState *vms)
     vms->fdt = fdt;
 
     /* Header */
+    qemu_fdt_setprop_string(fdt, "/", "model", "QEMU virt");
     qemu_fdt_setprop_string(fdt, "/", "compatible", "linux,dummy-virt");
     qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
-- 
2.19.1
