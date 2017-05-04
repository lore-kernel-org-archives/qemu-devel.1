Received: from eggs.gnu.org ([2001:4830:134:3::10]:34728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1v-0001UZ-JC
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1s-0004at-3h
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1r-0004Zx-Up
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FCD023E6C0
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:18:08 +0200
Message-Id: <20170504071811.3547-28-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 27/30] audio: UpdateHandler is not used anymore
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
Message-id: 20170425223739.6703-24-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 2 --
 hw/audio/fmopl.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index b1641f56de..8410275dc3 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -92,8 +92,6 @@ typedef struct fm_opl_f {
 	/* external event callback handler */
 	OPL_TIMERHANDLER  TimerHandler;		/* TIMER handler   */
 	int TimerParam;						/* TIMER parameter */
-	OPL_UPDATEHANDLER UpdateHandler;	/* stream update handler   */
-	int UpdateParam;					/* stream update parameter */
 } FM_OPL;
 
 /* ---------- Generic interface section ---------- */
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 5b8a884a59..99d09c55b3 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -1147,7 +1147,6 @@ int OPLWrite(FM_OPL *OPL,int a,int v)
 	}
 	else
 	{	/* data port */
-		if(OPL->UpdateHandler) OPL->UpdateHandler(OPL->UpdateParam,0);
 #ifdef OPL_OUTPUT_LOG
 	if(opl_dbg_fp)
 	{
@@ -1197,7 +1196,6 @@ int OPLTimerOver(FM_OPL *OPL,int c)
 		if( OPL->mode & 0x80 )
 		{	/* CSM mode total level latch and auto key on */
 			int ch;
-			if(OPL->UpdateHandler) OPL->UpdateHandler(OPL->UpdateParam,0);
 			for(ch=0;ch<9;ch++)
 				CSMKeyControll( &OPL->P_CH[ch] );
 		}
-- 
2.9.3
