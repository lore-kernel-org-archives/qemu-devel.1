Received: from eggs.gnu.org ([2001:4830:134:3::10]:35582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csWGK-0007tQ-PL
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csWGH-0000Al-Hn
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:08:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1csWGH-0000AF-C4
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:08:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90A00C0528A9
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 15:08:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Mar 2017 15:28:35 +0200
Message-Id: <1490621317-25483-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1490621317-25483-1-git-send-email-kraxel@redhat.com>
References: <1490621317-25483-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 3/5] cirrus: fix PUTPIXEL macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Should be "c" not "col".  The macro is used with "col" as third parameter
everywhere, so this tyops doesn't break something.

Fixes: 026aeffcb4752054830ba203020ed6eb05bcaba8
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-id: 1490168303-24588-1-git-send-email-kraxel@redhat.com
---
 hw/display/cirrus_vga_rop2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/cirrus_vga_rop2.h b/hw/display/cirrus_vga_rop2.h
index b86bcd6..b208b73 100644
--- a/hw/display/cirrus_vga_rop2.h
+++ b/hw/display/cirrus_vga_rop2.h
@@ -29,8 +29,8 @@
 #elif DEPTH == 24
 #define PUTPIXEL(s, a, c)    do {          \
         ROP_OP(s, a,     c);               \
-        ROP_OP(s, a + 1, (col >> 8));      \
-        ROP_OP(s, a + 2, (col >> 16));     \
+        ROP_OP(s, a + 1, (c >> 8));        \
+        ROP_OP(s, a + 2, (c >> 16));       \
     } while (0)
 #elif DEPTH == 32
 #define PUTPIXEL(s, a, c)    ROP_OP_32(s, a, c)
-- 
1.8.3.1
