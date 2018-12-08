Received: from eggs.gnu.org ([2001:4830:134:3::10]:57053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gVWXc-0001ui-Va
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 01:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gVWXZ-00082x-Ra
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 01:56:44 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:63032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1gVWXZ-00081a-GZ
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 01:56:41 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Sat, 8 Dec 2018 15:18:31 +0800
Message-Id: <1544253511-82742-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] hw/watchdog/wdt_i6300esb : remove a
 unnecessary comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

The registered memory region of i6300esb is not suitable for coalesced
mmio, because a write for the region may trigger an immediate action
and can't be delayed.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 hw/watchdog/wdt_i6300esb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 7b59469..1c6eddf 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -449,7 +449,6 @@ static void i6300esb_realize(PCIDevice *dev, Error **errp)
     memory_region_init_io(&d->io_mem, OBJECT(d), &i6300esb_ops, d,
                           "i6300esb", 0x10);
     pci_register_bar(&d->dev, 0, 0, &d->io_mem);
-    /* qemu_register_coalesced_mmio (addr, 0x10); ? */
 }
 
 static void i6300esb_exit(PCIDevice *dev)
-- 
1.8.3.1
