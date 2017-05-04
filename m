Received: from eggs.gnu.org ([2001:4830:134:3::10]:34734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1v-0001Ua-Mb
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1t-0004cr-52
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1s-0004bK-VA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 023D064CF
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:24 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:18:09 +0200
Message-Id: <20170504071811.3547-29-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 28/30] audio: Remove unused typedefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Juan Quintela <quintela@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170425223739.6703-25-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index 8410275dc3..f89af0884d 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -4,10 +4,6 @@
 #include <stdint.h>
 
 typedef void (*OPL_TIMERHANDLER)(int channel,double interval_Sec);
-typedef void (*OPL_IRQHANDLER)(int param,int irq);
-typedef void (*OPL_UPDATEHANDLER)(int param,int min_interval_us);
-typedef void (*OPL_PORTHANDLER_W)(int param,unsigned char data);
-typedef unsigned char (*OPL_PORTHANDLER_R)(int param);
 
 /* !!!!! here is private section , do not access there member direct !!!!! */
 
-- 
2.9.3
