Received: from eggs.gnu.org ([209.51.188.92]:39147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEb4n-0003WG-4l
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEb4l-0000sT-2O
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hEb4i-0000oh-Tv
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74CE931028C4
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 14:53:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 11 Apr 2019 16:52:48 +0200
Message-Id: <20190411145256.8614-8-armbru@redhat.com>
In-Reply-To: <20190411145256.8614-1-armbru@redhat.com>
References: <20190411145256.8614-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/15] hpet: Report warnings with
 warn_report(), not error_printf()
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
