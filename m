Received: from eggs.gnu.org ([2001:4830:134:3::10]:34626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1t-0001U8-VD
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1q-0004Yf-9t
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1q-0004Y2-2y
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28840C04B950
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:21 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:48 +0200
Message-Id: <20170504071811.3547-8-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 07/30] audio: Remove YM3526 support
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

It was never compiled in.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170425223739.6703-4-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 2 --
 hw/audio/fmopl.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index 96d958ac72..b254968b6a 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -3,7 +3,6 @@
 
 /* --- select emulation chips --- */
 #define BUILD_YM3812 (HAS_YM3812)
-//#define BUILD_YM3526 (HAS_YM3526)
 
 /* --- system optimize --- */
 /* select bit size of output : 8 or 16 */
@@ -135,7 +134,6 @@ typedef struct fm_opl_f {
 } FM_OPL;
 
 /* ---------- Generic interface section ---------- */
-#define OPL_TYPE_YM3526 (0)
 #define OPL_TYPE_YM3812 (OPL_TYPE_WAVESEL)
 
 FM_OPL *OPLCreate(int type, int clock, int rate);
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 29f6d3c5a4..1e05efca8a 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -981,7 +981,7 @@ static void OPL_UnLockTable(void)
 	OPLCloseTable();
 }
 
-#if (BUILD_YM3812 || BUILD_YM3526)
+#if BUILD_YM3812
 /*******************************************************************************/
 /*		YM3812 local section                                                   */
 /*******************************************************************************/
@@ -1044,7 +1044,7 @@ void YM3812UpdateOne(FM_OPL *OPL, INT16 *buffer, int length)
 	}
 #endif
 }
-#endif /* (BUILD_YM3812 || BUILD_YM3526) */
+#endif /* BUILD_YM3812 */
 
 /* ---------- reset one of chip ---------- */
 void OPLResetChip(FM_OPL *OPL)
-- 
2.9.3
