Received: from eggs.gnu.org ([2001:4830:134:3::10]:42405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmOI-0007QY-BZ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmOH-0006x7-GY
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:04:18 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 11 Dec 2018 19:03:26 +0100
Message-Id: <20181211180352.19644-5-laurent@vivier.eu>
In-Reply-To: <20181211180352.19644-1-laurent@vivier.eu>
References: <20181211180352.19644-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/30] hw: set_netdev: remove useless code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

In set_netdev(), the peers[i] is initialized
qemu_find_net_clients_except() when i is in
0 between 'queues' it can't be NULL.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1541751214-17515-1-git-send-email-liq3ea@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/core/qdev-properties-system.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 8b22fb51c9..b45a7ef54b 100644
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
2.19.2
