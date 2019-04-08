Received: from eggs.gnu.org ([209.51.188.92]:48999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPlc-0008BP-Hq
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPlb-0003gn-KH
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDPlb-0003fV-7t
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8255B308FEFF
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 08:36:34 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Apr 2019 10:36:19 +0200
Message-Id: <20190408083627.7479-8-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-1-armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 07/15] hpet: Report warnings with warn_report(),
 not error_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/timer/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index d97436bc7b..41024f39fb 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -744,7 +744,7 @@ static void hpet_realize(DeviceState *dev, Error **errp)
     HPETTimer *timer;
 
     if (!s->intcap) {
-        error_printf("Hpet's intcap not initialized.\n");
+        warn_report("Hpet's intcap not initialized");
     }
     if (hpet_cfg.count == UINT8_MAX) {
         /* first instance */
-- 
2.17.2
