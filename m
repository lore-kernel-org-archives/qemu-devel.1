Received: from eggs.gnu.org ([209.51.188.92]:55602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukasstraub2@web.de>) id 1hHU7i-0003ld-28
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 10:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukasstraub2@web.de>) id 1hHU00-000731-F8
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 09:56:17 -0400
Received: from mout.web.de ([212.227.17.11]:44585)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hHU00-0006wy-4H
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 09:56:16 -0400
Date: Fri, 19 Apr 2019 15:56:05 +0200
From: Lukas Straub <lukasstraub2@web.de>
Message-ID: <20190419155605.5349857a@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] net/colo-compare.c: Fix a crash in COLO
 Primary.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Zhang, Chen" <chen.zhang@intel.com>

From: Lukas Straub <lukasstraub2@web.de>
Fixes the following bug: https://bugs.launchpad.net/qemu/+bug/1824622

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 net/colo-compare.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index bf10526f05..fcb491121b 100644
=2D-- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -813,9 +813,8 @@ static void colo_compare_handle_event(void *opaque)
         break;
     }

-    assert(event_unhandled_count > 0);
-
     qemu_mutex_lock(&event_mtx);
+    assert(event_unhandled_count > 0);
     event_unhandled_count--;
     qemu_cond_broadcast(&event_complete_cond);
     qemu_mutex_unlock(&event_mtx);
=2D-
2.20.1
