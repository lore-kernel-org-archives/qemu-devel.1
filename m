Received: from eggs.gnu.org ([2001:4830:134:3::10]:60336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQHT-0007JU-Lc
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQHR-0003Hl-0d
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:13:07 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 10 Feb 2018 10:54:59 +0300
Message-Id: <38272f2d02fb855a2f76c510d4386f699b88cae5.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/17] Drop unneeded system header includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Eric Blake <eblake@redhat.com>

<memory.h> is a non-standard obsolete header that was long ago
replaced by <string.h>.

<malloc.h> is a non-standard header; it is not obsolete (we must
use it for malloc_trim, for example), but generally should not
be used in files that just need malloc() and friends, where
<stdlib.h> is the standard header.

And since osdep.h already guarantees string.h and stdlib.h, we
can drop these unusual system header includes as redundant
rather than replacing them.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/hax-windows.h | 2 --
 target/i386/hvf/x86_mmu.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/target/i386/hax-windows.h b/target/i386/hax-windows.h
index 004f867694..20e2f85407 100644
--- a/target/i386/hax-windows.h
+++ b/target/i386/hax-windows.h
@@ -20,8 +20,6 @@
 #ifndef TARGET_I386_HAX_WINDOWS_H
 #define TARGET_I386_HAX_WINDOWS_H
=20
-#include <memory.h>
-#include <malloc.h>
 #include <winioctl.h>
 #include <windef.h>
=20
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index c6be2cca35..d5a0efe718 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -17,7 +17,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include <memory.h>
 #include "panic.h"
 #include "qemu-common.h"
 #include "cpu.h"
--=20
2.11.0
