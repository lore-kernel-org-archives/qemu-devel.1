Received: from eggs.gnu.org ([2001:4830:134:3::10]:52777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7sFu-00059d-HL
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7sFt-0002QC-Pi
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:39:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 20:39:17 -0300
Message-Id: <20170508233918.9043-11-f4bug@amsat.org>
In-Reply-To: <20170508233918.9043-1-f4bug@amsat.org>
References: <20170508233918.9043-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/11] register: display register prefix (name)
 since it is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/register.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index dc335a79a9..b5988c9cc3 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -195,8 +195,8 @@ void register_write_memory(void *opaque, hwaddr addr,
     }
 
     if (!reg) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Write to unimplemented register at " \
-                      "address: %#" PRIx64 "\n", addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write to unimplemented register " \
+                      "at address: %#" PRIx64 "\n", reg_array->prefix, addr);
         return;
     }
 
@@ -224,8 +224,8 @@ uint64_t register_read_memory(void *opaque, hwaddr addr,
     }
 
     if (!reg) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Read to unimplemented register at " \
-                      "address: %#" PRIx64 "\n", addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s:  read to unimplemented register " \
+                      "at address: %#" PRIx64 "\n", reg_array->prefix, addr);
         return 0;
     }
 
-- 
2.11.0
