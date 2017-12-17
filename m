Received: from eggs.gnu.org ([2001:4830:134:3::10]:37304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQilr-0005Fq-15
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 18:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQiln-0005sW-5Y
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 18:55:03 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:23 +0300
Message-Id: <ebff8f4d7aadd8a6d3e575fa0340056f29afe5b6.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/61] hw/registerfields: add missing include
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

This allows to use this header in qtests.

This fixes:
    CC      tests/test.o
  include/hw/registerfields.h:32:41: error: implicit declaration of funct=
ion =E2=80=98MAKE_64BIT_MASK=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]
              MAKE_64BIT_MASK(shift, length)};
              ^
  include/hw/registerfields.h:39:5: error: implicit declaration of functi=
on =E2=80=98extract64=E2=80=99; [-Werror=3Dimplicit-function-declaration]
       extract64((storage), R_ ## reg ## _ ## field ## _SHIFT,
       ^

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/hw/registerfields.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
index f59e7f47bd..44e0b94edf 100644
--- a/include/hw/registerfields.h
+++ b/include/hw/registerfields.h
@@ -11,6 +11,8 @@
 #ifndef REGISTERFIELDS_H
 #define REGISTERFIELDS_H
=20
+#include <qemu/bitops.h>
+
 /* Define constants for a 32 bit register */
=20
 /* This macro will define A_FOO, for the byte address of a register
--=20
2.11.0
