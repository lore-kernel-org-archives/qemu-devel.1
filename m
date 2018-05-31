Received: from eggs.gnu.org ([2001:4830:134:3::10]:59509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOT9q-00041k-GH
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOT9n-0008Om-CC
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:46 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:55030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fOT9n-0008Nm-5Y
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:43 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 31 May 2018 21:22:33 +0200
Message-Id: <20180531192237.3994-6-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
References: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 5/9] net/slirp: Convert atoi to qemu_strtoi to
 allow error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nia Alarie <nia.alarie@gmail.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Nia Alarie <nia.alarie@gmail.com>

Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/slirp.c b/net/slirp.c
index 005c2675e6..1e14318b4d 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -492,7 +492,9 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
         goto fail_syntax;
     }
 
-    host_port = atoi(p);
+    if (qemu_strtoi(p, NULL, 10, &host_port)) {
+        goto fail_syntax;
+    }
 
     err = slirp_remove_hostfwd(s->slirp, is_udp, host_addr, host_port);
 
-- 
2.17.0
