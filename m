Received: from eggs.gnu.org ([2001:4830:134:3::10]:53562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e0BSL-0000tE-Lq
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e0BSF-0003kF-Ly
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:05:13 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:56134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1e0BSF-0003jl-Gm
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:05:07 -0400
Received: by mail-it0-x244.google.com with SMTP id p185so2532196itc.4
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 12:05:07 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Thu,  5 Oct 2017 15:04:49 -0400
Message-Id: <20171005190449.15591-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] ui/cocoa.m: Fix console selection keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Fix console selection keys so that the right console is selected. 

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 93e56d0518..2794f60b27 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -631,7 +631,7 @@ - (void) handleEvent:(NSEvent *)event
 
                     // enable graphic console
                     case Q_KEY_CODE_1 ... Q_KEY_CODE_9: // '1' to '9' keys
-                        console_select(keycode - 11);
+                        console_select(keycode - Q_KEY_CODE_1);
                         break;
                 }
 
-- 
2.13.5 (Apple Git-94)
