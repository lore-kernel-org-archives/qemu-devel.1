Received: from eggs.gnu.org ([2001:4830:134:3::10]:50563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlq-00036Z-BO
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlp-0004Ir-DX
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:34 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlp-0004G0-54
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:33 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGln-0003i6-Qd
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:31 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:04 +0100
Message-Id: <20180608124517.29475-19-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/31] ppc/pnv: Add trailing '\n' to qemu_log()
 calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-id: 20180606152128.449-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ppc/pnv_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index cbb64ad9e7e..13ad7d9e047 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -97,7 +97,7 @@ static uint64_t pnv_core_xscom_read(void *opaque, hwaddr addr,
         val = 0x24f000000000000ull;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx,
+        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
                   addr);
     }
 
@@ -107,7 +107,7 @@ static uint64_t pnv_core_xscom_read(void *opaque, hwaddr addr,
 static void pnv_core_xscom_write(void *opaque, hwaddr addr, uint64_t val,
                                  unsigned int width)
 {
-    qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx,
+    qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
                   addr);
 }
 
-- 
2.17.1
