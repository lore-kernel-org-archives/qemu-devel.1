Received: from eggs.gnu.org ([2001:4830:134:3::10]:57912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fQyGu-0003Oe-FF
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fQyGq-0005ua-VJ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:00:24 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Jun 2018 17:59:55 +0100
Message-Id: <20180607165955.10232-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180607165955.10232-1-mark.cave-ayland@ilande.co.uk>
References: <20180607165955.10232-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/3] ppc: add missing FW_CFG_PPC_NVRAM_FLAT
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This is used in OpenBIOS to define the memory layout of the NVRAM device. Whilst
currently left at its default value, add the missing definition to ensure it is
reserved.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
2.11.0
