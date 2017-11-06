Received: from eggs.gnu.org ([2001:4830:134:3::10]:39855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKG-0007I9-VY
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKE-0004tH-0X
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmKD-0004sc-Pg
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:45 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:13 +0100
Message-Id: <20171106183925.16747-17-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 16/28] tpm-tis: simplify header inclusion
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
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index c1b738c29f..254f8bd6cb 100644
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
2.15.0.rc0.40.gaefcc5f6f
