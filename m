Received: from eggs.gnu.org ([2001:4830:134:3::10]:34754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1w-0001Up-45
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1s-0004cS-NJ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1s-0004aO-Hm
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91DD0C04B948
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:18:10 +0200
Message-Id: <20170504071811.3547-30-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/30] audio: un-export OPLResetChip
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170425223739.6703-26-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 1 -
 hw/audio/fmopl.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index f89af0884d..fc9f16b58a 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -95,7 +95,6 @@ FM_OPL *OPLCreate(int clock, int rate);
 void OPLDestroy(FM_OPL *OPL);
 void OPLSetTimerHandler(FM_OPL *OPL,OPL_TIMERHANDLER TimerHandler,int ch=
annelOffset);
=20
-void OPLResetChip(FM_OPL *OPL);
 int OPLWrite(FM_OPL *OPL,int a,int v);
 unsigned char OPLRead(FM_OPL *OPL,int a);
 int OPLTimerOver(FM_OPL *OPL,int c);
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 99d09c55b3..dc9043c32d 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -1036,7 +1036,7 @@ void YM3812UpdateOne(FM_OPL *OPL, int16_t *buffer, =
int length)
 }
=20
 /* ---------- reset one of chip ---------- */
-void OPLResetChip(FM_OPL *OPL)
+static void OPLResetChip(FM_OPL *OPL)
 {
 	int c,s;
 	int i;
--=20
2.9.3
