Received: from eggs.gnu.org ([2001:4830:134:3::10]:46536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCo-0007f4-TP
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCo-0004ss-1S
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:02 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUCn-0004sk-To
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:01 -0500
Received: by mail-qt0-x244.google.com with SMTP id l7so14115600qtd.3
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:01 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:28 -0800
Message-Id: <20170123021748.13170-7-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 06/26] linux-user: Handle more IPV6 sockopts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

All of the ones added have an "int" parameter that
needs no more adjustment to pass on to the host.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/syscall.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11a311f..0b2b283 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2811,10 +2811,35 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
         break;
     case SOL_IPV6:
         switch (optname) {
-        case IPV6_MTU_DISCOVER:
-        case IPV6_MTU:
         case IPV6_V6ONLY:
         case IPV6_RECVPKTINFO:
+        case IPV6_2292PKTINFO:
+        case IPV6_RECVHOPLIMIT:
+        case IPV6_2292HOPLIMIT:
+        case IPV6_RECVRTHDR:
+        case IPV6_2292RTHDR:
+        case IPV6_RECVHOPOPTS:
+        case IPV6_2292HOPOPTS:
+        case IPV6_RECVDSTOPTS:
+        case IPV6_2292DSTOPTS:
+        case IPV6_TCLASS:
+        case IPV6_RECVTCLASS:
+        case IPV6_RECVPATHMTU:
+        case IPV6_TRANSPARENT:
+        case IPV6_RECVORIGDSTADDR:
+        case IPV6_UNICAST_HOPS:
+        case IPV6_MULTICAST_HOPS:
+        case IPV6_MULTICAST_LOOP:
+        case IPV6_UNICAST_IF:
+        case IPV6_MULTICAST_IF:
+        case IPV6_ROUTER_ALERT:
+        case IPV6_MTU_DISCOVER:
+        case IPV6_MTU:
+        case IPV6_RECVERR:
+        case IPV6_ADDR_PREFERENCES:
+        case IPV6_MINHOPCOUNT:
+        case IPV6_DONTFRAG:
+        case IPV6_AUTOFLOWLABEL:
             val = 0;
             if (optlen < sizeof(uint32_t)) {
                 return -TARGET_EINVAL;
-- 
2.9.3
