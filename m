Received: from eggs.gnu.org ([2001:4830:134:3::10]:36229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3965-0000Hz-HU
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3964-0002Ur-Lu
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d3964-0002Ud-Gi
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74033624A9
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:38:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:37:25 +0200
Message-Id: <20170425223739.6703-13-quintela@redhat.com>
In-Reply-To: <20170425223739.6703-1-quintela@redhat.com>
References: <20170425223739.6703-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 12/26] audio: Remove Unused OPL_TYPE_*
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

Since we removed the previous unused devices, they are not used anymore.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/audio/fmopl.c | 16 ----------------
 hw/audio/fmopl.h |  3 ---
 2 files changed, 19 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index b1cb4b4..9171001 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -1188,28 +1188,12 @@ unsigned char OPLRead(FM_OPL *OPL,int a)
 	switch(OPL->address)
 	{
 	case 0x05: /* KeyBoard IN */
-		if(OPL->type&OPL_TYPE_KEYBOARD)
-		{
-			if(OPL->keyboardhandler_r)
-				return OPL->keyboardhandler_r(OPL->keyboard_param);
-			else {
-				LOG(LOG_WAR,("OPL:read unmapped KEYBOARD port\n"));
-			}
-		}
 		return 0;
 #if 0
 	case 0x0f: /* ADPCM-DATA  */
 		return 0;
 #endif
 	case 0x19: /* I/O DATA    */
-		if(OPL->type&OPL_TYPE_IO)
-		{
-			if(OPL->porthandler_r)
-				return OPL->porthandler_r(OPL->port_param);
-			else {
-				LOG(LOG_WAR,("OPL:read unmapped I/O port\n"));
-			}
-		}
 		return 0;
 	case 0x1a: /* PCM-DATA    */
 		return 0;
diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index c236287..8ef0b3e 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -12,9 +12,6 @@ typedef unsigned char (*OPL_PORTHANDLER_R)(int param);
 /* !!!!! here is private section , do not access there member direct !!!!! */
 
 #define OPL_TYPE_WAVESEL   0x01  /* waveform select    */
-#define OPL_TYPE_ADPCM     0x02  /* DELTA-T ADPCM unit */
-#define OPL_TYPE_KEYBOARD  0x04  /* keyboard interface */
-#define OPL_TYPE_IO        0x08  /* I/O port */
 
 /* Saving is necessary for member of the 'R' mark for suspend/resume */
 /* ---------- OPL one of slot  ---------- */
-- 
2.9.3
