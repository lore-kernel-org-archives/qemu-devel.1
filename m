Received: from eggs.gnu.org ([2001:4830:134:3::10]:55101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGyd-0002cA-Gf
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGyc-0003KY-Gg
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGGyc-0003KG-Bg
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:30 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 12 Dec 2016 11:08:07 +0800
Message-Id: <1481512100-10380-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1481512100-10380-1-git-send-email-peterx@redhat.com>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v8 01/14] pci: fix missing
 extern for pci_testdev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: drjones@redhat.com, agordeev@redhat.com, jan.kiszka@web.de, rkrcmar@redhat.com, pbonzini@redhat.com, peterx@redhat.com

Suggested-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/pci.h b/lib/pci.h
index 30f5381..86d6b42 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -43,7 +43,7 @@ extern bool pci_bar_is_valid(pcidevaddr_t dev, int bar_num);
 extern void pci_bar_print(pcidevaddr_t dev, int bar_num);
 extern void pci_dev_print_id(pcidevaddr_t dev);
 
-int pci_testdev(void);
+extern int pci_testdev(void);
 
 /*
  * pci-testdev is a driver for the pci-testdev qemu pci device. The
-- 
2.7.4
