Received: from eggs.gnu.org ([2001:4830:134:3::10]:36127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d395q-0008Vg-SF
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d395q-0002PX-4Z
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:37:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d395p-0002Ow-U8
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:37:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBC02C04B310
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:37:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:37:19 +0200
Message-Id: <20170425223739.6703-7-quintela@redhat.com>
In-Reply-To: <20170425223739.6703-1-quintela@redhat.com>
References: <20170425223739.6703-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 06/26] audio: remove UINT16
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

More modernitation.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/audio/fmopl.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index 3df8942..1891a22 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -10,7 +10,6 @@
 /* compiler dependence */
 #ifndef OSD_CPU_H
 #define OSD_CPU_H
-typedef unsigned short	UINT16;  /* unsigned 16bit */
 typedef unsigned int	UINT32;  /* unsigned 32bit */
 typedef signed char		INT8;    /* signed  8bit   */
 typedef signed short	INT16;   /* signed 16bit   */
-- 
2.9.3
