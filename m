Received: from eggs.gnu.org ([2001:4830:134:3::10]:35051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgjK-0002wo-Bg
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgjJ-0005hn-Gb
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:32:10 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:30:00 -0300
Message-Id: <20171215033015.738-29-f4bug@amsat.org>
In-Reply-To: <20171215033015.738-1-f4bug@amsat.org>
References: <20171215033015.738-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 28/43] hw/tpm: remove old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_passthrough.c | 1 -
 hw/tpm/tpm_tis.c         | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index c440aff4b2..d904d8e33f 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -29,7 +29,6 @@
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "qapi/clone-visitor.h"
 #include "tpm_util.h"
 
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 42d647d363..3c38fd8b2c 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -29,7 +29,6 @@
 #include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/pci/pci_ids.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-- 
2.15.1
