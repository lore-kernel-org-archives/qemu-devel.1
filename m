Received: from eggs.gnu.org ([2001:4830:134:3::10]:53599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1faChZ-0003gE-Ta
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 00:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1faChU-0004Yx-UZ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 00:14:05 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:54625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1faChU-0004Ye-QF
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 00:14:00 -0400
Received: by mail-it0-x243.google.com with SMTP id s7-v6so1257412itb.4
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 21:14:00 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Tue,  3 Jul 2018 00:13:43 -0400
Message-Id: <20180703041343.2014-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] ui/cocoa.m: replace scrollingDeltaY with deltaY
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

The NSEvent class method scrollingDeltaY is available for Mac OS 10.7 and newer. Since QEMU supports Mac OS 10.5 and up, we need to be using a method that is available on these version of Mac OS X. The deltaY method is a method that does the same thing as scrollingDeltaY and is available on Mac OS 10.5 and up. So we simply replace scrollingDeltaY with deltaY.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 2991ed4f19..e34714081d 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -803,7 +803,7 @@ - (void) handleEvent:(NSEvent *)event
              */
 
             /* Determine if this is a scroll up or scroll down event */
-            buttons = ([event scrollingDeltaY] > 0) ?
+            buttons = ([event deltaY] > 0) ?
                 INPUT_BUTTON_WHEEL_UP : INPUT_BUTTON_WHEEL_DOWN;
             qemu_input_queue_btn(dcl->con, buttons, true);
             qemu_input_event_sync();
-- 
2.14.3 (Apple Git-98)
