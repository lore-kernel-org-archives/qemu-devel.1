Received: from eggs.gnu.org ([2001:4830:134:3::10]:55417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1h0G-0006w4-SX
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1h0F-0005al-Qd
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1h0F-0005aX-L5
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:27 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:16 +0200
Message-Id: <20171009225623.29232-36-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 35/42] tpm-tis: simplify header inclusion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 3c8d246ac8..e7e8b112e8 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -24,17 +24,12 @@
=20
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
-#include "sysemu/tpm_backend.h"
-#include "tpm_int.h"
-#include "sysemu/block-backend.h"
-#include "exec/address-spaces.h"
-#include "hw/hw.h"
-#include "hw/i386/pc.h"
-#include "hw/pci/pci_ids.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
-#include "qemu/main-loop.h"
+
 #include "hw/acpi/tpm.h"
+#include "hw/pci/pci_ids.h"
+#include "sysemu/tpm_backend.h"
+#include "tpm_int.h"
=20
 #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
 #define TPM_TIS_LOCALITY_SHIFT      12
--=20
2.14.1.146.gd35faa819
