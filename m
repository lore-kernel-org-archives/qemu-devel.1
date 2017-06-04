Received: from eggs.gnu.org ([2001:4830:134:3::10]:39338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHYIb-00021Z-GX
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 12:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHYIW-0004Qg-LQ
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 12:22:41 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:13 +0300
Message-Id: <f85d66f47feffc1a223d8336022b17a3c7aafd47.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 09/22] block: Correct documentation for
 BLOCK_WRITE_THRESHOLD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Eric Blake <eblake@redhat.com>

Use the correct command name.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qapi/block-core.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ea0b3e8b13..309b1df214 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3624,7 +3624,7 @@
 # means the device should be extended to avoid pausing for
 # disk exhaustion.
 # The event is one shot. Once triggered, it needs to be
-# re-registered with another block-set-threshold command.
+# re-registered with another block-set-write-threshold command.
 #
 # @node-name: graph node name on which the threshold was exceeded.
 #
-- 
2.11.0
