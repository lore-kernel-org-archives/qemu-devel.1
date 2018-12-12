Received: from eggs.gnu.org ([2001:4830:134:3::10]:52734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N8-0001NG-9U
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N3-0000e7-5T
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:26 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6N1-0000Tx-15
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:21 -0500
Received: by mail-wr1-x42f.google.com with SMTP id v13so18111224wrw.5
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:24:02 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:23:01 +0100
Message-Id: <1544628195-37728-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 40/54] hw/watchdog/wdt_i6300esb : remove a
 unnecessary comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peng Hao <peng.hao2@zte.com.cn>

From: Peng Hao <peng.hao2@zte.com.cn>

The registered memory region of i6300esb is not suitable for coalesced
mmio, because a write for the region may trigger an immediate action
and can't be delayed.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Message-Id: <1544253511-82742-1-git-send-email-peng.hao2@zte.com.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
