Received: from eggs.gnu.org ([2001:4830:134:3::10]:34261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgie-0002IT-3f
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgid-0004i5-Bf
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:31:28 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:29:48 -0300
Message-Id: <20171215033015.738-17-f4bug@amsat.org>
In-Reply-To: <20171215033015.738-1-f4bug@amsat.org>
References: <20171215033015.738-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 16/43] i386/hax: remove duplicated include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>

this file in include in "target/i386/hax-i386.h":

    #ifdef CONFIG_WIN32
    #include "target/i386/hax-windows.h"
    #endif

which guaranties that sysemu/os-win32.h is previously included (CONFIG_WIN32)

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
 
-#include <windows.h>
 #include <memory.h>
 #include <malloc.h>
 #include <winioctl.h>
-- 
2.15.1
