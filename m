Received: from eggs.gnu.org ([2001:4830:134:3::10]:48222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyO-0007Pt-6m
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyL-0006P2-IG
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:46 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyL-0006LH-3O
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id z204-v6so1611065wmc.5
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:48 +0200
Message-Id: <1539894735-14232-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 21/48] hw: edu: drop DO_UPCAST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liq3ea@163.com>

From: Li Qiang <liq3ea@163.com>

Signed-off-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/edu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 0687ffd..cdcf550 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -342,7 +342,7 @@ static void *edu_fact_thread(void *opaque)
 
 static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 {
-    EduState *edu = DO_UPCAST(EduState, pdev, pdev);
+    EduState *edu = EDU(pdev);
     uint8_t *pci_conf = pdev->config;
 
     pci_config_set_interrupt_pin(pci_conf, 1);
@@ -365,7 +365,7 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 
 static void pci_edu_uninit(PCIDevice *pdev)
 {
-    EduState *edu = DO_UPCAST(EduState, pdev, pdev);
+    EduState *edu = EDU(pdev);
 
     qemu_mutex_lock(&edu->thr_mutex);
     edu->stopping = true;
-- 
1.8.3.1
