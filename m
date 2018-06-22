Received: from eggs.gnu.org ([2001:4830:134:3::10]:47195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWLTL-0007Gb-Ce
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWLTI-00078o-9l
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:47:27 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Jun 2018 09:47:16 -0300
Message-Id: <20180622124716.9179-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/core/register: Log unimplemented access via
 the 'unimp' debug level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/register.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index d2d1636250..8ed7c6b927 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -203,7 +203,7 @@ void register_write_memory(void *opaque, hwaddr addr,
     }
 
     if (!reg) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: write to unimplemented register " \
+        qemu_log_mask(LOG_UNIMP, "%s: write to unimplemented register " \
                       "at address: %#" PRIx64 "\n", reg_array->prefix, addr);
         return;
     }
@@ -232,7 +232,7 @@ uint64_t register_read_memory(void *opaque, hwaddr addr,
     }
 
     if (!reg) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s:  read to unimplemented register " \
+        qemu_log_mask(LOG_UNIMP, "%s:  read to unimplemented register " \
                       "at address: %#" PRIx64 "\n", reg_array->prefix, addr);
         return 0;
     }
-- 
2.18.0.rc2
