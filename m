Received: from eggs.gnu.org ([2001:4830:134:3::10]:47727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQh3R-0002xo-Be
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 17:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQh3O-00066s-5Q
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 17:05:05 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:40 +0300
Message-Id: <b0dff39d4e47c1d358b97a45b74a0510c80342eb.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 35/61] i386/hax: remove duplicated include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

this file in include in "target/i386/hax-i386.h":

    #ifdef CONFIG_WIN32
    #include "target/i386/hax-windows.h"
    #endif

which guaranties that sysemu/os-win32.h is previously included (CONFIG_WI=
N32)

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/i386/hax-windows.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/i386/hax-windows.h b/target/i386/hax-windows.h
index f7c3e99246..004f867694 100644
--- a/target/i386/hax-windows.h
+++ b/target/i386/hax-windows.h
@@ -20,7 +20,6 @@
 #ifndef TARGET_I386_HAX_WINDOWS_H
 #define TARGET_I386_HAX_WINDOWS_H
=20
-#include <windows.h>
 #include <memory.h>
 #include <malloc.h>
 #include <winioctl.h>
--=20
2.11.0
