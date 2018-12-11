Received: from eggs.gnu.org ([2001:4830:134:3::10]:43022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPG-0008En-3w
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPC-0007YA-Jr
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:17 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 11 Dec 2018 19:03:23 +0100
Message-Id: <20181211180352.19644-2-laurent@vivier.eu>
In-Reply-To: <20181211180352.19644-1-laurent@vivier.eu>
References: <20181211180352.19644-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/30] hw: qdev: fix error in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@163.com>

From: Li Qiang <liq3ea@163.com>

Cc: qemu-trivial@nongnu.org

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20181030151637.37207-1-liq3ea@163.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/qdev-core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index a24d0dd566..92851e55df 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -197,7 +197,7 @@ typedef struct BusChild {
 
 /**
  * BusState:
- * @hotplug_device: link to a hotplug device associated with bus.
+ * @hotplug_handler: link to a hotplug handler associated with bus.
  */
 struct BusState {
     Object obj;
-- 
2.19.2
