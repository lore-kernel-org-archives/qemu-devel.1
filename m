Received: from eggs.gnu.org ([2001:4830:134:3::10]:37514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjongsma@redhat.com>) id 1d8Y5u-0008Px-Sh
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjongsma@redhat.com>) id 1d8Y5r-0003Ag-Oq
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:20:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjongsma@redhat.com>) id 1d8Y5r-0003AH-IV
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:20:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11A59804F1
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 20:20:17 +0000 (UTC)
Received: from aegolius.redhat.com (ovpn-121-192.rdu2.redhat.com
	[10.10.121.192])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B686D7E87D
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 20:20:16 +0000 (UTC)
From: Jonathon Jongsma <jjongsma@redhat.com>
Date: Wed, 10 May 2017 15:20:06 -0500
Message-Id: <20170510202006.31737-1-jjongsma@redhat.com>
Subject: [Qemu-devel] [PATCH] spice: Use proper enum type for kbd led state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Although the Qemu and spice flags currently have the same value, it
seems more correct to pass the spice flag values to
spice_server_kbd_leds(), especially considering that this function
already makes an effort to convert between the QEMU_*_LED and
SPICE_KEYBOARD_MODIFIER_* values.

Signed-off-by: Jonathon Jongsma <jjongsma@redhat.com>
---
 ui/spice-input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/spice-input.c b/ui/spice-input.c
index 8eeebdb..7fd283b 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -87,7 +87,7 @@ static void kbd_leds(void *opaque, int ledstate)
     if (ledstate & QEMU_CAPS_LOCK_LED) {
         kbd->ledstate |= SPICE_KEYBOARD_MODIFIER_FLAGS_CAPS_LOCK;
     }
-    spice_server_kbd_leds(&kbd->sin, ledstate);
+    spice_server_kbd_leds(&kbd->sin, kbd->ledstate);
 }
 
 /* mouse bits */
-- 
2.9.3
