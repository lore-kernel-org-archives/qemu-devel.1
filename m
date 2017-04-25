Received: from eggs.gnu.org ([2001:4830:134:3::10]:36277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396A-0000N2-Iy
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3968-0002Vs-0M
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d3967-0002Ve-QO
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C07DB624B3
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:38:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:37:27 +0200
Message-Id: <20170425223739.6703-15-quintela@redhat.com>
In-Reply-To: <20170425223739.6703-1-quintela@redhat.com>
References: <20170425223739.6703-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 14/26] audio: Remove unused fields
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

These were used for the remove stuff.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/audio/fmopl.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index df790a0..8730ead 100644
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
