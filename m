Received: from eggs.gnu.org ([2001:4830:134:3::10]:50074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejSBx-0002cI-PH
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejSBt-0003hC-SU
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:03:25 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed,  7 Feb 2018 10:03:02 -0600
Message-Id: <20180207160302.15651-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] Drop unneeded system header includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

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
---

Based-on: <20180207124009.12376-1-armbru@redhat.com>
([PULL 00/20] Miscellaneous patches for 2018-02-07)

 target/i386/hax-windows.h | 2 --
 target/i386/hvf/x86_mmu.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/target/i386/hax-windows.h b/target/i386/hax-windows.h
index 004f8676949..20e2f85407b 100644
--- a/target/i386/hax-windows.h
+++ b/target/i386/hax-windows.h
@@ -20,8 +20,6 @@
 #ifndef TARGET_I386_HAX_WINDOWS_H
 #define TARGET_I386_HAX_WINDOWS_H

-#include <memory.h>
-#include <malloc.h>
 #include <winioctl.h>
 #include <windef.h>

diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index c6be2cca357..d5a0efe7188 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -17,7 +17,6 @@
  */

 #include "qemu/osdep.h"
-#include <memory.h>
 #include "panic.h"
 #include "qemu-common.h"
 #include "cpu.h"
-- 
2.14.3
