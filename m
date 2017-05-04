Received: from eggs.gnu.org ([2001:4830:134:3::10]:34638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1u-0001UF-1W
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1r-0004Ze-2z
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1q-0004Ya-TF
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB2F661BA5
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:21 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:54 +0200
Message-Id: <20170504071811.3547-14-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 13/30] audio: remove INT16
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
Message-id: 20170425223739.6703-10-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 5 ++---
 hw/audio/fmopl.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index bede6717ae..0bc3415cd3 100644
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
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 47754e86b2..ebd3dbbf80 100644
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
-- 
2.9.3
