Received: from eggs.gnu.org ([2001:4830:134:3::10]:36506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396Y-0000jK-SP
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396W-0002cq-7U
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d396W-0002cX-1g
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0774D4E4FC
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:38:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:37:38 +0200
Message-Id: <20170425223739.6703-26-quintela@redhat.com>
In-Reply-To: <20170425223739.6703-1-quintela@redhat.com>
References: <20170425223739.6703-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 25/26] audio: un-export OPLResetChip
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
 hw/audio/fmopl.c | 2 +-
 hw/audio/fmopl.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 99d09c5..dc9043c 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -1036,7 +1036,7 @@ void YM3812UpdateOne(FM_OPL *OPL, int16_t *buffer, int length)
 }
 
 /* ---------- reset one of chip ---------- */
-void OPLResetChip(FM_OPL *OPL)
+static void OPLResetChip(FM_OPL *OPL)
 {
 	int c,s;
 	int i;
diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index f89af08..fc9f16b 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -95,7 +95,6 @@ FM_OPL *OPLCreate(int clock, int rate);
 void OPLDestroy(FM_OPL *OPL);
 void OPLSetTimerHandler(FM_OPL *OPL,OPL_TIMERHANDLER TimerHandler,int channelOffset);
 
-void OPLResetChip(FM_OPL *OPL);
 int OPLWrite(FM_OPL *OPL,int a,int v);
 unsigned char OPLRead(FM_OPL *OPL,int a);
 int OPLTimerOver(FM_OPL *OPL,int c);
-- 
2.9.3
