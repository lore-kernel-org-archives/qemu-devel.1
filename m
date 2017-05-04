Received: from eggs.gnu.org ([2001:4830:134:3::10]:34747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1v-0001Uj-Uw
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1s-0004bY-Em
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1s-0004a6-8S
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C14DC059726
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:49 +0200
Message-Id: <20170504071811.3547-9-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 08/30] audio: YM3812 was always defined
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

So, remove the ifdefs.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170425223739.6703-5-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 4 ----
 hw/audio/fmopl.c | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index b254968b6a..e476497275 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -1,9 +1,6 @@
 #ifndef FMOPL_H
 #define FMOPL_H
 
-/* --- select emulation chips --- */
-#define BUILD_YM3812 (HAS_YM3812)
-
 /* --- system optimize --- */
 /* select bit size of output : 8 or 16 */
 #define OPL_OUTPUT_BIT 16
@@ -147,6 +144,5 @@ int OPLWrite(FM_OPL *OPL,int a,int v);
 unsigned char OPLRead(FM_OPL *OPL,int a);
 int OPLTimerOver(FM_OPL *OPL,int c);
 
-/* YM3626/YM3812 local section */
 void YM3812UpdateOne(FM_OPL *OPL, INT16 *buffer, int length);
 #endif
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 1e05efca8a..282662a858 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -30,8 +30,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#define HAS_YM3812	1
-
 #include "qemu/osdep.h"
 #include <math.h>
 //#include "driver.h"		/* use M.A.M.E. */
@@ -981,7 +979,6 @@ static void OPL_UnLockTable(void)
 	OPLCloseTable();
 }
 
-#if BUILD_YM3812
 /*******************************************************************************/
 /*		YM3812 local section                                                   */
 /*******************************************************************************/
@@ -1044,7 +1041,6 @@ void YM3812UpdateOne(FM_OPL *OPL, INT16 *buffer, int length)
 	}
 #endif
 }
-#endif /* BUILD_YM3812 */
 
 /* ---------- reset one of chip ---------- */
 void OPLResetChip(FM_OPL *OPL)
-- 
2.9.3
