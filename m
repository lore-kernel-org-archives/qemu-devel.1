Received: from eggs.gnu.org ([2001:4830:134:3::10]:36367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396N-0000Yb-92
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396M-0002Zc-BG
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d396M-0002ZF-5n
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27F3A8047A
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:38:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:37:33 +0200
Message-Id: <20170425223739.6703-21-quintela@redhat.com>
In-Reply-To: <20170425223739.6703-1-quintela@redhat.com>
References: <20170425223739.6703-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 20/26] audio: OPLSetIRQHandler is not used
 anywhere
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
 hw/audio/fmopl.c | 5 -----
 hw/audio/fmopl.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 48db828..f91e700 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -1141,11 +1141,6 @@ void OPLSetTimerHandler(FM_OPL *OPL,OPL_TIMERHANDLER TimerHandler,int channelOff
 	OPL->TimerHandler   = TimerHandler;
 	OPL->TimerParam = channelOffset;
 }
-void OPLSetIRQHandler(FM_OPL *OPL,OPL_IRQHANDLER IRQHandler,int param)
-{
-	OPL->IRQHandler     = IRQHandler;
-	OPL->IRQParam = param;
-}
 void OPLSetUpdateHandler(FM_OPL *OPL,OPL_UPDATEHANDLER UpdateHandler,int param)
 {
 	OPL->UpdateHandler = UpdateHandler;
diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index 8730ead..375f971 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -102,7 +102,6 @@ typedef struct fm_opl_f {
 FM_OPL *OPLCreate(int clock, int rate);
 void OPLDestroy(FM_OPL *OPL);
 void OPLSetTimerHandler(FM_OPL *OPL,OPL_TIMERHANDLER TimerHandler,int channelOffset);
-void OPLSetIRQHandler(FM_OPL *OPL,OPL_IRQHANDLER IRQHandler,int param);
 void OPLSetUpdateHandler(FM_OPL *OPL,OPL_UPDATEHANDLER UpdateHandler,int param);
 
 void OPLResetChip(FM_OPL *OPL);
-- 
2.9.3
