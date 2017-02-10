Received: from eggs.gnu.org ([2001:4830:134:3::10]:49642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFcA-00022X-3z
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc8-0003yq-UB
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:10 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ccFc8-0003xp-MH
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:08 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc7-0007dR-R6
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:08:07 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 18:07:58 +0000
Message-Id: <1486750082-12324-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
References: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/12] hw/arm/virt: Declare fwcfg as dma cache
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

From: Alexander Graf <agraf@suse.de>

Fw-cfg recently learned how to directly access guest memory and does so in
cache coherent fashion. Tell the guest about that fact when it's using DT.

Signed-off-by: Alexander Graf <agraf@suse.de>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Shannon Zhao <shannon.zhao@linaro.org>
Message-id: 1486644810-33181-5-git-send-email-agraf@suse.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d20e627..f3440f2 100644
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
2.7.4
