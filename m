Received: from eggs.gnu.org ([2001:4830:134:3::10]:40593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1csQIC-0000Ap-82
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1csQI9-0004A7-3X
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:46:24 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1csQI8-00049i-PN
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:46:21 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 27 Mar 2017 10:46:12 +0200
Message-Id: <20170327084612.8998-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] slirp: fix compilation errors with DEBUG set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

slirp/slirp.c: In function 'get_dns_addr_resolv_conf':
slirp/slirp.c:202:29: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
                 char *res = inet_ntop(af, tmp_addr, s, sizeof(s));
                             ^~~~~~~~~
slirp/slirp.c:204:25: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
                     res = "(string conversion error)";

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 slirp/slirp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 60539de..5a94b06 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -198,7 +198,7 @@ static int get_dns_addr_resolv_conf(int af, void *pdns_addr, void *cached_addr,
 #ifdef DEBUG
             else {
                 char s[INET6_ADDRSTRLEN];
-                char *res = inet_ntop(af, tmp_addr, s, sizeof(s));
+                const char *res = inet_ntop(af, tmp_addr, s, sizeof(s));
                 if (!res) {
                     res = "(string conversion error)";
                 }
-- 
2.9.3
