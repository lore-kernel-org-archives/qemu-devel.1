Received: from eggs.gnu.org ([2001:4830:134:3::10]:59388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa2AJ-0007nt-58
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa2AF-00042J-B3
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:03 -0400
Received: from mail-db5eur01on0093.outbound.protection.outlook.com
	([104.47.2.93]:14944
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fa2AF-00041L-0b
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:58:59 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon,  2 Jul 2018 19:58:38 +0300
Message-Id: <20180702165842.11423-3-rkagan@virtuozzo.com>
In-Reply-To: <20180702165842.11423-1-rkagan@virtuozzo.com>
References: <20180702165842.11423-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/6] hyperv: cosmetic: g_malloc -> g_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liran Alon <liran.alon@oracle.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 3065d765ed..47368b77c0 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -88,7 +88,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
     HvSintRoute *sint_route;
     int r, gsi;
 
-    sint_route = g_malloc0(sizeof(*sint_route));
+    sint_route = g_new0(HvSintRoute, 1);
     r = event_notifier_init(&sint_route->sint_set_notifier, false);
     if (r) {
         goto err;
-- 
2.17.1
