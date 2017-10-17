Received: from eggs.gnu.org ([2001:4830:134:3::10]:46750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4V0G-0001qC-Fr
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4V0F-0003Ko-Rk
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:46:04 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 17 Oct 2017 13:44:00 -0300
Message-Id: <20171017164426.25277-17-f4bug@amsat.org>
In-Reply-To: <20171017164426.25277-1-f4bug@amsat.org>
References: <20171017164426.25277-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 16/42] i386/hax: remove duplicated include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yu Ning <yu.ning@linux.intel.com>, Vincent Palatin <vpalatin@chromium.org>, Corey Minyard <cminyard@mvista.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

this file in include in "target/i386/hax-i386.h":

    #ifdef CONFIG_WIN32
    #include "target/i386/hax-windows.h"
    #endif

which guaranty than sysemu/os-win32.h is previously included (CONFIG_WIN32)

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
2.15.0.rc0
