Received: from eggs.gnu.org ([2001:4830:134:3::10]:44695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1ewqWE-0002uV-7X
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1ewqWA-0006L1-BC
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:39:42 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nia.alarie@gmail.com>)
	id 1ewqWA-0006Kj-51
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:39:38 -0400
Received: by mail-wm0-x243.google.com with SMTP id w128so3492278wmw.0
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 07:39:37 -0700 (PDT)
From: Nia Alarie <nia.alarie@gmail.com>
Date: Fri, 16 Mar 2018 14:39:21 +0000
Message-Id: <20180316143921.30780-1-nia.alarie@gmail.com>
Subject: [Qemu-devel] [PATCH] net/slirp: Convert atoi to qemu_strtoi to
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
Cc: stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, jasowang@redhat.com, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, Nia Alarie <nia.alarie@gmail.com>

Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
---
 net/slirp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/slirp.c b/net/slirp.c
index 8991816bbf..e938944bd4 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -486,7 +486,9 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
         goto fail_syntax;
     }
 
-    host_port = atoi(p);
+    if (qemu_strtoi(p, NULL, 10, &host_port)) {
+        goto fail_syntax;
+    }
 
     err = slirp_remove_hostfwd(s->slirp, is_udp, host_addr, host_port);
 
-- 
2.16.2
