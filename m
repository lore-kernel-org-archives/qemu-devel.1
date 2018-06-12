Received: from eggs.gnu.org ([2001:4830:134:3::10]:58957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3p-0002mM-8J
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3m-0001tm-7P
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:47 +1000
Message-Id: <20180612064503.14282-18-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 17/33] ppc: add missing FW_CFG_PPC_NVRAM_FLAT
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is used in OpenBIOS to define the memory layout of the NVRAM device. Whilst
currently left at its default value, add the missing definition to ensure it is
reserved.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/ppc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index ff0ac306be..b18ef3eefb 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -100,6 +100,7 @@ enum {
 #define FW_CFG_PPC_KVM_PID      (FW_CFG_ARCH_LOCAL + 0x07)
 #define FW_CFG_PPC_NVRAM_ADDR   (FW_CFG_ARCH_LOCAL + 0x08)
 #define FW_CFG_PPC_BUSFREQ      (FW_CFG_ARCH_LOCAL + 0x09)
+#define FW_CFG_PPC_NVRAM_FLAT   (FW_CFG_ARCH_LOCAL + 0x0a)
 
 #define PPC_SERIAL_MM_BAUDBASE 399193
 
-- 
2.17.1
