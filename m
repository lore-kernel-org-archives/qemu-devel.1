Received: from eggs.gnu.org ([2001:4830:134:3::10]:43033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQwAg-0005Us-T0
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:13:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQwAc-0007yt-RB
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:13:34 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 17:13:27 +0300
Message-Id: <4c22db44859af80dfca946070d155f5dd43e5492.1513606137.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513606137.git.mjt@msgid.tls.msk.ru>
References: <cover.1513606137.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513606137.git.mjt@msgid.tls.msk.ru>
References: <cover.1513606137.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 46/60] hw/tpm: remove old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/tpm/tpm_emulator.c    | 1 -
 hw/tpm/tpm_passthrough.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 3ae8bf6c5a..38b6f175a1 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -33,7 +33,6 @@
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "tpm_util.h"
 #include "tpm_ioctl.h"
 #include "migration/blocker.h"
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 487aae2043..149fae63e6 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -29,7 +29,6 @@
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "qapi/clone-visitor.h"
 #include "tpm_util.h"
=20
--=20
2.11.0
