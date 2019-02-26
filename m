Received: from eggs.gnu.org ([209.51.188.92]:58264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlN-0005YC-8t
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlL-0002xm-7d
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:41 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:53:04 +1100
Message-Id: <20190226045304.25618-51-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 50/50] ppc/pnv: use IEC binary prefixes to
 represent sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Murilo Opsfelder Araujo <mopsfelder@gmail.com>, Eric Blake <eblake@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Murilo Opsfelder Araujo <mopsfelder@gmail.com>

Using IEC binary prefixes from qemu/units.h provides a more human-friendl=
y value
to size constants.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Message-Id: <20190225170155.1972-4-muriloo@linux.ibm.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0cd6af4669..3d5dfef220 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -47,11 +47,11 @@
=20
 #include <libfdt.h>
=20
-#define FDT_MAX_SIZE            0x00100000
+#define FDT_MAX_SIZE            (1 * MiB)
=20
 #define FW_FILE_NAME            "skiboot.lid"
 #define FW_LOAD_ADDR            0x0
-#define FW_MAX_SIZE             0x00400000
+#define FW_MAX_SIZE             (4 * MiB)
=20
 #define KERNEL_LOAD_ADDR        0x20000000
 #define KERNEL_MAX_SIZE         (256 * MiB)
--=20
2.20.1
