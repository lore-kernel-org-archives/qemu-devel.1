Received: from eggs.gnu.org ([2001:4830:134:3::10]:56306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eKncJ-0005ze-IA
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:53:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eKnbF-0005ct-Qn
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:52:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eKnbF-0005Zr-Jc
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:51:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CFDF6016F
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 08:46:12 +0000 (UTC)
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri,  1 Dec 2017 09:46:06 +0100
Message-Id: <20171201084606.9889-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio-input: add missing KEY_COMPOSE mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

This key tends to be located somewhere between right Alt and right
Ctrl and is usually used for opening context menus.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/input/virtio-input-hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index e78faec0b1..387a026e10 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -139,6 +139,7 @@ static const unsigned int keymap_qcode[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_META_L]              = KEY_LEFTMETA,
     [Q_KEY_CODE_META_R]              = KEY_RIGHTMETA,
     [Q_KEY_CODE_MENU]                = KEY_MENU,
+    [Q_KEY_CODE_COMPOSE]             = KEY_COMPOSE,
 };
 
 static const unsigned int keymap_button[INPUT_BUTTON__MAX] = {
-- 
2.13.6
