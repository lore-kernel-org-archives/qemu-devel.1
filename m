Received: from eggs.gnu.org ([209.51.188.92]:57555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gqOml-000454-Ax
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 15:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gqOiA-0004Jx-NM
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 15:49:55 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54051)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gqOiA-0004JD-Dz
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 15:49:54 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  3 Feb 2019 15:49:50 -0500
Message-Id: <20190203204950.8447-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH] qemu-doc: remove outdated comment about
 full-system SMP support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Steiner <davids@bitmail.cc>

We have had SMP support in TCG for quite a while; remove
the reference to a necessary in-kernel accelerator.

Note that I was tempted to enumerate here the MTTCG-compatible
ISAs, but I decided against it because (1) most popular target ISAs
have been converted, and (2) I doubt we'd do a good job in keeping
the list up to date.

Reported-by: David Steiner <davids@bitmail.cc>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 qemu-doc.texi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 83be010a0a..0c20ec6d6f 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -119,8 +119,7 @@ can be used for talking to external physical peripherals (e.g. a
 webcam, modem or tape drive).
 
 @item
-Symmetric multiprocessing (SMP) support.  Currently, an in-kernel
-accelerator is required to use more than one host CPU for emulation.
+Symmetric multiprocessing (SMP) support.
 
 @end itemize
 
-- 
2.17.1
