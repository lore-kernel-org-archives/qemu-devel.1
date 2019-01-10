Received: from eggs.gnu.org ([209.51.188.92]:55154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghW3J-0008SQ-2d
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghW0R-00061I-Go
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:48:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghW0Q-00060r-V9
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:48:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A133A457A
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:48:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 10 Jan 2019 09:47:51 +0100
Message-Id: <20190110084752.30510-8-kraxel@redhat.com>
In-Reply-To: <20190110084752.30510-1-kraxel@redhat.com>
References: <20190110084752.30510-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 7/8] keymaps: drop support for include files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-id: 20181116104319.10329-5-kraxel@redhat.com
---
 ui/keymaps.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/ui/keymaps.c b/ui/keymaps.c
index 085889b555..6e44f738ed 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -115,10 +115,9 @@ static int parse_keyboard_layout(kbd_layout_t *k,
             continue;
         }
         if (!strncmp(line, "include ", 8)) {
-            if (parse_keyboard_layout(k, table, line + 8, errp) < 0) {
-                ret = -1;
-                goto out;
-            }
+            error_setg(errp, "keymap include files are not supported any more");
+            ret = -1;
+            goto out;
         } else {
             int offset = 0;
             while (line[offset] != 0 &&
-- 
2.9.3
