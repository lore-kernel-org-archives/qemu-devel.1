Received: from eggs.gnu.org ([2001:4830:134:3::10]:60927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXpW-0006qj-9Y
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXpS-0004zZ-Fp
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:52:38 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:18 +0300
Message-Id: <2283adfb0aa1ccc70c4a4a951423343dcb9e94d9.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/22] hw/mips: add missing include
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
Acked-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/hw/mips/mips.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
index e0065ce808..16412dc150 100644
--- a/include/hw/mips/mips.h
+++ b/include/hw/mips/mips.h
@@ -6,6 +6,7 @@
 #define INITRD_PAGE_MASK (~((1 << 16) - 1))
=20
 #include "exec/memory.h"
+#include "hw/irq.h"
=20
 /* gt64xxx.c */
 PCIBus *gt64120_register(qemu_irq *pic);
--=20
2.11.0
