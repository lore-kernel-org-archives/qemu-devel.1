Received: from eggs.gnu.org ([2001:4830:134:3::10]:34737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1v-0001Ub-Pt
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1s-0004cc-RN
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1s-0004ae-Kd
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F08A80C1C
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:18:05 +0200
Message-Id: <20170504071811.3547-25-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 24/30] audio: OPLSetIRQHandler is not used
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
Cc: Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Juan Quintela <quintela@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170425223739.6703-21-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 1 -
 hw/audio/fmopl.c | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index 8730ead531..375f971b4d 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -102,7 +102,6 @@ typedef struct fm_opl_f {
 FM_OPL *OPLCreate(int clock, int rate);
 void OPLDestroy(FM_OPL *OPL);
 void OPLSetTimerHandler(FM_OPL *OPL,OPL_TIMERHANDLER TimerHandler,int channelOffset);
-void OPLSetIRQHandler(FM_OPL *OPL,OPL_IRQHANDLER IRQHandler,int param);
 void OPLSetUpdateHandler(FM_OPL *OPL,OPL_UPDATEHANDLER UpdateHandler,int param);
 
 void OPLResetChip(FM_OPL *OPL);
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 48db828a49..f91e700bf9 100644
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
-- 
2.9.3
