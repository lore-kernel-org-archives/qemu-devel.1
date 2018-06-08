Received: from eggs.gnu.org ([2001:4830:134:3::10]:45112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fRAeL-0007dP-Sy
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fRAeI-0004IP-Kp
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:25 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:53392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fRAeI-0004Hu-Ei
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:22 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Fri,  8 Jun 2018 09:13:14 +0300
Message-Id: <20180608061316.4909-4-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180608061316.4909-1-samuel.thibault@ens-lyon.org>
References: <20180608061316.4909-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 3/5] slirp: fix domainname version availability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

The change missed the 2.12 deadline.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
2.17.1
