Received: from eggs.gnu.org ([2001:4830:134:3::10]:49099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlL-00017O-Bg
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlK-0004DZ-Fw
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:03 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ezRlK-0004CA-9S
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:02 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlI-0007e8-R0
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:50:00 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 18:49:50 +0000
Message-Id: <20180323184958.14252-3-peter.maydell@linaro.org>
In-Reply-To: <20180323184958.14252-1-peter.maydell@linaro.org>
References: <20180323184958.14252-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/10] sdhci: fix incorrect use of Error *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Detected by Coverity (CID 1386072, 1386073, 1386076, 1386077).  local_err
was unused, and this made the static analyzer unhappy.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20180320151355.25854-1-pbonzini@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1b828b104d..63c44a4ee8 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1474,7 +1474,7 @@ static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
     Error *local_err = NULL;
 
     sdhci_initfn(s);
-    sdhci_common_realize(s, errp);
+    sdhci_common_realize(s, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1556,7 +1556,7 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     Error *local_err = NULL;
 
-    sdhci_common_realize(s, errp);
+    sdhci_common_realize(s, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
-- 
2.16.2
