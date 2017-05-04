Received: from eggs.gnu.org ([2001:4830:134:3::10]:34631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1u-0001UC-00
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1q-0004Z7-MN
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1q-0004YG-Gz
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86AF761971
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:21 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:53 +0200
Message-Id: <20170504071811.3547-13-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 12/30] audio: Remove INT8
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
Message-id: 20170425223739.6703-9-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index b52f0392cb..bede6717ae 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -10,7 +10,6 @@
 /* compiler dependence */
 #ifndef OSD_CPU_H
 #define OSD_CPU_H
-typedef signed char		INT8;    /* signed  8bit   */
 typedef signed short	INT16;   /* signed 16bit   */
 typedef signed int		INT32;   /* signed 32bit   */
 #endif
-- 
2.9.3
