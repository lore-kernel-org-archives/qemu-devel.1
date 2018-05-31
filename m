Received: from eggs.gnu.org ([2001:4830:134:3::10]:59537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOT9s-00042B-2H
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOT9r-0008RM-4S
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:48 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:55080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fOT9q-0008Qe-Tx
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:47 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 31 May 2018 21:22:32 +0200
Message-Id: <20180531192237.3994-5-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
References: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 4/9] slirp/debug: Print IP addresses in human
 readable form
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/arp_table.c | 4 ++--
 slirp/socket.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/slirp/arp_table.c b/slirp/arp_table.c
index bac608f97f..f81963bb88 100644
--- a/slirp/arp_table.c
+++ b/slirp/arp_table.c
@@ -33,7 +33,7 @@ void arp_table_add(Slirp *slirp, uint32_t ip_addr, uint8_t ethaddr[ETH_ALEN])
     int i;
 
     DEBUG_CALL("arp_table_add");
-    DEBUG_ARG("ip = %s", inet_ntoa(*(struct in_addr *)&ip_addr));
+    DEBUG_ARG("ip = %s", inet_ntoa((struct in_addr){.s_addr = ip_addr}));
     DEBUG_ARGS((dfd, " hw addr = %02x:%02x:%02x:%02x:%02x:%02x\n",
                 ethaddr[0], ethaddr[1], ethaddr[2],
                 ethaddr[3], ethaddr[4], ethaddr[5]));
@@ -67,7 +67,7 @@ bool arp_table_search(Slirp *slirp, uint32_t ip_addr,
     int i;
 
     DEBUG_CALL("arp_table_search");
-    DEBUG_ARG("ip = %s", inet_ntoa(*(struct in_addr *)&ip_addr));
+    DEBUG_ARG("ip = %s", inet_ntoa((struct in_addr){.s_addr = ip_addr}));
 
     /* If broadcast address */
     if (ip_addr == 0xffffffff || ip_addr == broadcast_addr) {
diff --git a/slirp/socket.c b/slirp/socket.c
index 6f18e157a5..e2a71c9b04 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -701,9 +701,9 @@ tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
 	memset(&addr, 0, addrlen);
 
 	DEBUG_CALL("tcp_listen");
-	DEBUG_ARG("haddr = %s", inet_ntoa(*(struct in_addr *)&haddr));
+	DEBUG_ARG("haddr = %s", inet_ntoa((struct in_addr){.s_addr = haddr}));
 	DEBUG_ARG("hport = %d", ntohs(hport));
-	DEBUG_ARG("laddr = %s", inet_ntoa(*(struct in_addr *)&laddr));
+	DEBUG_ARG("laddr = %s", inet_ntoa((struct in_addr){.s_addr = laddr}));
 	DEBUG_ARG("lport = %d", ntohs(lport));
 	DEBUG_ARG("flags = %x", flags);
 
-- 
2.17.0
