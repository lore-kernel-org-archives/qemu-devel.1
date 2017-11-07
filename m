Received: from eggs.gnu.org ([2001:4830:134:3::10]:52451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC0uu-0000Om-RH
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:15:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC0ur-0007qi-0W
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:15:36 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eC0uq-0007lV-Pp
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:15:32 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Nov 2017 10:16:02 +0000
Message-Id: <1510049762-4609-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510049762-4609-1-git-send-email-peter.maydell@linaro.org>
References: <1510049762-4609-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 3/3] ui/cocoa.m: Send ctrl-alt key combos to
 guest if QEMU isn't using them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: programmingkidx@gmail.com

Send those ctrl-alt key combos that QEMU doesn't treat specially to
the guest rather than ignoring them.

All the case where we do special handling of ctrl-alt-X exit the
event handling using a "return" statement, so we can simply allow
the rest to fall through into the normal key handling by deleting
the now-spurious "else".

We take the opportunity to clean up some oddly-formatted and
now rather uninformative comments by removing them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index f39c792..330cceb 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -704,12 +704,10 @@ QemuCocoaView *cocoaView;
                             return;
                     }
                 }
+            }
 
-            // handle keys for graphic console
-            } else if (qemu_console_is_graphic(NULL)) {
+            if (qemu_console_is_graphic(NULL)) {
                 qemu_input_event_send_key_qcode(dcl->con, keycode, true);
-
-            // handlekeys for Monitor
             } else {
                 [self handleMonitorInput: event];
             }
-- 
2.7.4
