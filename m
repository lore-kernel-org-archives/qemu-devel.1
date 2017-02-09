Received: from eggs.gnu.org ([2001:4830:134:3::10]:59190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cboDy-0002bf-TX
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cboDy-0007QD-Ah
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:53:23 -0500
From: Alexander Graf <agraf@suse.de>
Date: Thu,  9 Feb 2017 13:53:30 +0100
Message-Id: <1486644810-33181-5-git-send-email-agraf@suse.de>
In-Reply-To: <1486644810-33181-1-git-send-email-agraf@suse.de>
References: <1486644810-33181-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH v2 4/4] hw/arm/virt: Declare fwcfg as dma cache
 coherent in dt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mst@redhat.com, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Fw-cfg recently learned how to directly access guest memory and does so in
cache coherent fashion. Tell the guest about that fact when it's using DT.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 14881fa..da9622f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -929,6 +929,7 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
                             "compatible", "qemu,fw-cfg-mmio");
     qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                  2, base, 2, size);
+    qemu_fdt_setprop(vms->fdt, nodename, "dma-coherent", NULL, 0);
     g_free(nodename);
     return fw_cfg;
 }
-- 
2.10.0
