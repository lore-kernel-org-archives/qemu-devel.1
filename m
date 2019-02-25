Received: from eggs.gnu.org ([209.51.188.92]:38488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mopsfelder@gmail.com>) id 1gyJeP-0007Mf-Ej
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mopsfelder@gmail.com>) id 1gyJeJ-00080l-Kw
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:02:45 -0500
From: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Date: Mon, 25 Feb 2019 14:01:55 -0300
Message-Id: <20190225170155.1972-4-muriloo@linux.ibm.com>
In-Reply-To: <20190225170155.1972-1-muriloo@linux.ibm.com>
References: <20190225170155.1972-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/3] ppc/pnv: use IEC binary prefixes to
 represent sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mopsfelder@gmail.com, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org

Using IEC binary prefixes from qemu/units.h provides a more human-friendly value
to size constants.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 hw/ppc/pnv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c308ae423a..b6c5d1eff9 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -47,11 +47,11 @@
 
 #include <libfdt.h>
 
-#define FDT_MAX_SIZE            0x00100000
+#define FDT_MAX_SIZE            (1 * MiB)
 
 #define FW_FILE_NAME            "skiboot.lid"
 #define FW_LOAD_ADDR            0x0
-#define FW_MAX_SIZE             0x00400000
+#define FW_MAX_SIZE             (4 * MiB)
 
 #define KERNEL_LOAD_ADDR        0x20000000
 #define KERNEL_MAX_SIZE         (256 * MiB)
-- 
2.20.1
