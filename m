Received: from eggs.gnu.org ([2001:4830:134:3::10]:47280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gL1vT-0003I4-AL
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gL1vK-0003J1-Tr
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:13:57 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gL1vK-0003BN-23
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:13:50 -0500
Received: by mail-pg1-x542.google.com with SMTP id f8-v6so540903pgq.5
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 00:13:40 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Fri,  9 Nov 2018 00:13:34 -0800
Message-Id: <1541751214-17515-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] hw: set_netdev: remove useless code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, marcandre.lureau@redhat.com, lvivier@redhat.com, thuth@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

In set_netdev(), the peers[i] is initialized
qemu_find_net_clients_except() when i is in
0 between 'queues' it can't be NULL.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/core/qdev-properties-system.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 8b22fb5..b45a7ef 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -288,10 +288,6 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
     }
 
     for (i = 0; i < queues; i++) {
-        if (peers[i] == NULL) {
-            err = -ENOENT;
-            goto out;
-        }
 
         if (peers[i]->peer) {
             err = -EEXIST;
-- 
1.8.3.1
