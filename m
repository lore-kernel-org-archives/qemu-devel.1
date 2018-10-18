Received: from eggs.gnu.org ([2001:4830:134:3::10]:48098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyJ-0007JL-Ck
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyF-0006Ji-GW
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:43 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:43225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEy9-0006AR-Gz
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:37 -0400
Received: by mail-wr1-x434.google.com with SMTP id n1-v6so35101387wrt.10
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:29 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:37 +0200
Message-Id: <1539894735-14232-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/48] target-i386: add i440fx 0xcf8 port as
 coalesced_pio
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

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Message-Id: <1539795177-21038-5-git-send-email-peng.hao2@zte.com.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci-host/piix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 0e60834..da73743 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -327,6 +327,10 @@ static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
 
     sysbus_add_io(sbd, 0xcfc, &s->data_mem);
     sysbus_init_ioports(sbd, 0xcfc, 4);
+
+    /* register i440fx 0xcf8 port as coalesced pio */
+    memory_region_set_flush_coalesced(&s->data_mem);
+    memory_region_add_coalescing(&s->conf_mem, 0, 4);
 }
 
 static void i440fx_realize(PCIDevice *dev, Error **errp)
-- 
1.8.3.1
