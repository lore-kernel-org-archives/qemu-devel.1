Received: from eggs.gnu.org ([2001:4830:134:3::10]:39311)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1d9MOd-000481-HK
	for qemu-devel@nongnu.org; Fri, 12 May 2017 22:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1d9MOY-0004Fr-Mp
	for qemu-devel@nongnu.org; Fri, 12 May 2017 22:03:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:57215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1d9MOY-0004EU-Cz
	for qemu-devel@nongnu.org; Fri, 12 May 2017 22:02:58 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Sat, 13 May 2017 03:54:49 +0200
Message-Id: <20170513015449.24061-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH] libvixl: Correct ordering of includes and fix
 NetBSD build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, claudio.fontana@huawei.com, Kamil Rytarowski <n54@gmx.com>

The __STDC_CONSTANT_MACROS symbol must be defined before including
directly or indirectly <stdint.h> in order to get support for macros
for integer constants like INT8_C().

The vixl/globals.h headers defines __STDC_CONSTANT_MACROS and must be
included before other system headers.

This change fixes build failures on NetBSD.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 disas/libvixl/vixl/a64/disasm-a64.cc | 2 +-
 disas/libvixl/vixl/utils.h           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/disas/libvixl/vixl/a64/disasm-a64.cc b/disas/libvixl/vixl/a64/disasm-a64.cc
index 7a58a5c087..fc87306893 100644
--- a/disas/libvixl/vixl/a64/disasm-a64.cc
+++ b/disas/libvixl/vixl/a64/disasm-a64.cc
@@ -24,8 +24,8 @@
 // OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
-#include <cstdlib>
 #include "vixl/a64/disasm-a64.h"
+#include <cstdlib>
 
 namespace vixl {
 
diff --git a/disas/libvixl/vixl/utils.h b/disas/libvixl/vixl/utils.h
index 5ab134e240..17034addbc 100644
--- a/disas/libvixl/vixl/utils.h
+++ b/disas/libvixl/vixl/utils.h
@@ -27,10 +27,10 @@
 #ifndef VIXL_UTILS_H
 #define VIXL_UTILS_H
 
-#include <string.h>
-#include <cmath>
 #include "vixl/globals.h"
 #include "vixl/compiler-intrinsics.h"
+#include <string.h>
+#include <cmath>
 
 namespace vixl {
 
-- 
2.12.2
