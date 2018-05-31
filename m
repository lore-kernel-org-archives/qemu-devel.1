Received: from eggs.gnu.org ([2001:4830:134:3::10]:37057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOTdD-0002xL-6q
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOTd9-0007Wl-AQ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:53:07 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:50676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fOTd9-0007Vk-3g
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:53:03 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 31 May 2018 21:52:58 +0200
Message-Id: <20180531195258.22795-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCH] slirp: fix domainname version availability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, eblake@redhat.com, armbru@redhat.com

The change missed the 2.12 deadline.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 qapi/net.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/net.json b/qapi/net.json
index 32681a1af7..6b7d93cb59 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -161,7 +161,7 @@
 #             to the guest
 #
 # @domainname: guest-visible domain name of the virtual nameserver
-#              (since 2.12)
+#              (since 3.0)
 #
 # @ipv6-prefix: IPv6 network prefix (default is fec0::) (since
 #               2.6). The network prefix is given in the usual
-- 
2.17.0
