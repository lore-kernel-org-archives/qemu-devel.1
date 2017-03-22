Received: from eggs.gnu.org ([2001:4830:134:3::10]:45205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cqWci-0001oD-JT
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 23:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cqWce-0003uT-K1
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 23:07:44 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Mar 2017 11:07:32 +0800
Message-Id: <1490152052-9660-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH] e1000: disable debug by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Leonid Bloch <leonid.bloch@ravellosystems.com>, Dmitry Fleytman <dmitry.fleytman@ravellosystems.com>, qemu-stable@nongnu.org

Disable debug output by default, the information were not needed for
release.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Leonid Bloch <leonid.bloch@ravellosystems.com>
Cc: Dmitry Fleytman <dmitry.fleytman@ravellosystems.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 9324949..f2e5072 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -40,7 +40,7 @@
 
 static const uint8_t bcast[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-#define E1000_DEBUG
+/* #define E1000_DEBUG */
 
 #ifdef E1000_DEBUG
 enum {
-- 
2.7.4
