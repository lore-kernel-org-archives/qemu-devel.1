Received: from eggs.gnu.org ([2001:4830:134:3::10]:34691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1v-0001UW-4e
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1s-0004b7-6s
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1s-0004Zz-0t
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D0B0C04B941
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:59 +0200
Message-Id: <20170504071811.3547-19-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 18/30] audio: Remove unused fields
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

These were used for the remove stuff.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170425223739.6703-15-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index df790a0b7d..8730ead531 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -76,12 +76,6 @@ typedef struct fm_opl_f {
 	int	max_ch;			/* maximum channel                   */
 	/* Rhythm sention */
 	uint8_t rhythm;		/* Rhythm mode , key flag */
-	OPL_PORTHANDLER_R porthandler_r;
-	OPL_PORTHANDLER_W porthandler_w;
-	int port_param;
-	OPL_PORTHANDLER_R keyboardhandler_r;
-	OPL_PORTHANDLER_W keyboardhandler_w;
-	int keyboard_param;
 	/* time tables */
 	int32_t AR_TABLE[75];	/* atttack rate tables */
 	int32_t DR_TABLE[75];	/* decay rate tables   */
-- 
2.9.3
