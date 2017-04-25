Received: from eggs.gnu.org ([2001:4830:134:3::10]:36459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396T-0000et-Ov
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396T-0002c3-2j
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d396S-0002bu-SG
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC17481F01
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:38:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:37:37 +0200
Message-Id: <20170425223739.6703-25-quintela@redhat.com>
In-Reply-To: <20170425223739.6703-1-quintela@redhat.com>
References: <20170425223739.6703-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 24/26] audio: Remove unused typedefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/audio/fmopl.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index 8410275..f89af08 100644
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
