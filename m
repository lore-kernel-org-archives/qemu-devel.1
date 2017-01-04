Received: from eggs.gnu.org ([2001:4830:134:3::10]:52449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOjdN-0001lm-3z
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOjdJ-0001u3-N7
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOjdJ-0001t9-Dq
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:29 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A811F4F639
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 11:21:29 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  4 Jan 2017 12:21:21 +0100
Message-Id: <1483528883-1753-10-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
References: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 09/11] ui: drop unused MOUSE_EVENT_WHEEL{UP,
 DN} defines
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

Also update comment to make clear this
is for legacy mouse emulation only.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 1480409632-6163-1-git-send-email-kraxel@redhat.com
---
 include/ui/console.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index ee8c407..753ae93 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -13,13 +13,10 @@
 # include <epoxy/gl.h>
 #endif
 
-/* keyboard/mouse support */
-
+/* mouse buttons, used by legacy handlers (qemu_add_mouse_event_handler) */
 #define MOUSE_EVENT_LBUTTON 0x01
 #define MOUSE_EVENT_RBUTTON 0x02
 #define MOUSE_EVENT_MBUTTON 0x04
-#define MOUSE_EVENT_WHEELUP 0x08
-#define MOUSE_EVENT_WHEELDN 0x10
 
 /* identical to the ps/2 keyboard bits */
 #define QEMU_SCROLL_LOCK_LED (1 << 0)
-- 
1.8.3.1
