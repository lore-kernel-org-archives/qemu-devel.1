Received: from eggs.gnu.org ([2001:4830:134:3::10]:48796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYHtF-0007Zd-9K
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 17:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYHtB-0005eY-9u
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 17:22:13 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:49363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fYHtB-0005dH-0E
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 17:22:09 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 27 Jun 2018 23:21:52 +0200
Message-Id: <20180627212152.26525-3-laurent@vivier.eu>
In-Reply-To: <20180627212152.26525-1-laurent@vivier.eu>
References: <20180627212152.26525-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 2/2] linux-user: update do_setsockopt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

add IPV6_MULTICAST_HOPS and IPV6_MULTICAST_LOOP that need
32bit value conversion

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 4460f1e39a..50e20fb659 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3019,6 +3019,8 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
         case IPV6_V6ONLY:
         case IPV6_RECVPKTINFO:
         case IPV6_UNICAST_HOPS:
+        case IPV6_MULTICAST_HOPS:
+        case IPV6_MULTICAST_LOOP:
         case IPV6_RECVERR:
         case IPV6_RECVHOPLIMIT:
         case IPV6_2292HOPLIMIT:
-- 
2.14.4
