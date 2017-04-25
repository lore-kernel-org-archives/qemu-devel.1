Received: from eggs.gnu.org ([2001:4830:134:3::10]:36073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d395l-0008Q5-On
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d395k-0002JM-Uy
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:37:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d395k-0002Ia-Oq
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:37:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8AD78051F
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:37:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:37:16 +0200
Message-Id: <20170425223739.6703-4-quintela@redhat.com>
In-Reply-To: <20170425223739.6703-1-quintela@redhat.com>
References: <20170425223739.6703-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 03/26] audio: Remove YM3526 support
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

It was never compiled in.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/audio/fmopl.c | 4 ++--
 hw/audio/fmopl.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 29f6d3c..1e05efc 100644
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
diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index 96d958a..b254968 100644
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
-- 
2.9.3
