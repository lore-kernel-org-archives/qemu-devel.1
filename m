Received: from eggs.gnu.org ([2001:4830:134:3::10]:38223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyIxh-0002YO-Lx
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyIxd-0006Xs-Dx
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:14:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50272 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eyIxd-0006XT-9i
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:14:01 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 20 Mar 2018 16:13:55 +0100
Message-Id: <20180320151355.25854-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] sdhci: fix incorrect use of Error *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, f4bug@amsat.org

Detected by Coverity (CID 1386072, 1386073, 1386076, 1386077).  local_err
was unused, and this made the static analyzer unhappy.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
