Received: from eggs.gnu.org ([2001:4830:134:3::10]:49394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1faOG4-0007TB-FP
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1faOG0-0005Go-Hv
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:28 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:57010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1faOG0-0005GE-7d
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:24 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  3 Jul 2018 18:34:49 +0200
Message-Id: <20180703163451.16936-6-laurent@vivier.eu>
In-Reply-To: <20180703163451.16936-1-laurent@vivier.eu>
References: <20180703163451.16936-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 5/7] linux-user: update do_setsockopt()
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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180627212152.26525-3-laurent@vivier.eu>
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
2.17.1
