Received: from eggs.gnu.org ([2001:4830:134:3::10]:35484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fskY7-0001vu-Ff
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fskY4-0000rj-TR
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:00:59 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:45404 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1fskY4-0000mg-J7
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:00:56 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Fri, 24 Aug 2018 00:14:49 +0800
Message-Id: <1535040889-52782-5-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1535040889-52782-1-git-send-email-peng.hao2@zte.com.cn>
References: <1535040889-52782-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V3 4/4] target-i386: add i440fx 0xcf8 port as
 coalesced_pio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, ehabkost@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, zhong.weidong@zte.com.cn, Peng Hao <peng.hao2@zte.com.cn>

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
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
