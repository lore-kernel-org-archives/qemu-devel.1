Received: from eggs.gnu.org ([2001:4830:134:3::10]:36190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3962-0000EH-2m
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d395z-0002Tc-GO
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d395z-0002TU-A3
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EA5D7E9E6
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:38:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:37:22 +0200
Message-Id: <20170425223739.6703-10-quintela@redhat.com>
In-Reply-To: <20170425223739.6703-1-quintela@redhat.com>
References: <20170425223739.6703-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 09/26] audio: remove INT16
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
 hw/audio/fmopl.h | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 47754e8..ebd3dbb 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -984,7 +984,7 @@ static void OPL_UnLockTable(void)
 /*******************************************************************************/
 
 /* ---------- update one of chip ----------- */
-void YM3812UpdateOne(FM_OPL *OPL, INT16 *buffer, int length)
+void YM3812UpdateOne(FM_OPL *OPL, int16_t *buffer, int length)
 {
     int i;
 	int data;
diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index bede671..0bc3415 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -10,12 +10,11 @@
 /* compiler dependence */
 #ifndef OSD_CPU_H
 #define OSD_CPU_H
-typedef signed short	INT16;   /* signed 16bit   */
 typedef signed int		INT32;   /* signed 32bit   */
 #endif
 
 #if (OPL_OUTPUT_BIT==16)
-typedef INT16 OPLSAMPLE;
+typedef int16_t OPLSAMPLE;
 #endif
 #if (OPL_OUTPUT_BIT==8)
 typedef unsigned char  OPLSAMPLE;
@@ -142,5 +141,5 @@ int OPLWrite(FM_OPL *OPL,int a,int v);
 unsigned char OPLRead(FM_OPL *OPL,int a);
 int OPLTimerOver(FM_OPL *OPL,int c);
 
-void YM3812UpdateOne(FM_OPL *OPL, INT16 *buffer, int length);
+void YM3812UpdateOne(FM_OPL *OPL, int16_t *buffer, int length);
 #endif
-- 
2.9.3
