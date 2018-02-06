Received: from eggs.gnu.org ([2001:4830:134:3::10]:45208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uY-0001hc-7D
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uU-0003Y1-Tv
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:32:14 -0500
Received: from mail-eopbgr00091.outbound.protection.outlook.com
	([40.107.0.91]:41696
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9uU-0003Wi-KP
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:32:10 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:48 +0300
Message-Id: <20180206203048.11096-35-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 34/34] hv-net: define default rom file name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 hw/net/hv-net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/hv-net.c b/hw/net/hv-net.c
index 3d719458ea..b44ab20b0f 100644
--- a/hw/net/hv-net.c
+++ b/hw/net/hv-net.c
@@ -1423,6 +1423,7 @@ static void hv_net_class_init(ObjectClass *klass, void *data)
     vdc->num_channels = hv_net_num_channels;
     vdc->close_channel = hv_net_close_channel;
     vdc->chan_notify_cb = hv_net_notify_cb;
+    vdc->romfile = "efi-hyperv.rom";
 }
 
 static void hv_net_instance_init(Object *obj)
-- 
2.14.3
