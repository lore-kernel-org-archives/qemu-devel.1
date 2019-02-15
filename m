Received: from eggs.gnu.org ([209.51.188.92]:40483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guRnc-0001WG-LC
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guRnb-0001fr-Gh
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:56:16 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:16058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1guRnb-0001f2-AB
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:56:15 -0500
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 15 Feb 2019 01:14:44 +0100
Message-Id: <20190215005614.3AD927456C9@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] ui/cocoa: Make sure app is not starting in the
 background
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Activate app to make sure the window is brought to front e.g. when
started from a terminal window.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
This is on top of Peter's patches.

 ui/cocoa.m | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 201a294ed4..4727f9c392 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1746,7 +1746,8 @@ int main (int argc, const char * argv[]) {
     QemuCocoaAppController *appController = [[QemuCocoaAppController alloc] init];
     [NSApp setDelegate:appController];
 
-    // Start the main event loop
+    // Activate app and start the main event loop
+    [NSApp activateIgnoringOtherApps:YES];
     COCOA_DEBUG("Main thread: entering OSX run loop\n");
     [NSApp run];
     COCOA_DEBUG("Main thread: left OSX run loop, exiting\n");
-- 
2.13.7
