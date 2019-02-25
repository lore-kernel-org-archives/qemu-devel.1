Received: from eggs.gnu.org ([209.51.188.92]:53579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mopsfelder@gmail.com>) id 1gyHBT-0006Id-RV
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mopsfelder@gmail.com>) id 1gyHBT-0001Mi-6F
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:24:43 -0500
From: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Date: Mon, 25 Feb 2019 11:24:07 -0300
Message-Id: <20190225142407.9477-3-muriloo@linux.ibm.com>
In-Reply-To: <20190225142407.9477-1-muriloo@linux.ibm.com>
References: <20190225142407.9477-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] ppc/pnv: add INITRD_MAX_SIZE constant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mopsfelder@gmail.com, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

The current 0x10000000 value is actually 256MiB, not 128MB as the comment
suggests. Move it to a constant and fix the comment (no change in the size
value).

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 hw/ppc/pnv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 000707164e..514439db20 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -56,6 +56,7 @@
 #define KERNEL_LOAD_ADDR        0x20000000
 #define KERNEL_MAX_SIZE         0x10000000    /* 256MiB */
 #define INITRD_LOAD_ADDR        0x60000000
+#define INITRD_MAX_SIZE         0x10000000    /* 256MiB */
 
 static const char *pnv_chip_core_typename(const PnvChip *o)
 {
@@ -601,7 +602,7 @@ static void pnv_init(MachineState *machine)
     if (machine->initrd_filename) {
         pnv->initrd_base = INITRD_LOAD_ADDR;
         pnv->initrd_size = load_image_targphys(machine->initrd_filename,
-                                  pnv->initrd_base, 0x10000000); /* 128MB max */
+                                  pnv->initrd_base, INITRD_MAX_SIZE);
         if (pnv->initrd_size < 0) {
             error_report("Could not load initial ram disk '%s'",
                          machine->initrd_filename);
-- 
2.20.1
