Received: from eggs.gnu.org ([2001:4830:134:3::10]:43377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBSF-0005uy-EU
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBSD-0003RF-BU
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:17:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Jun 2018 22:14:50 -0300
Message-Id: <20180611011501.10235-30-f4bug@amsat.org>
In-Reply-To: <20180611011501.10235-1-f4bug@amsat.org>
References: <20180611011501.10235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 29/40] hw/mips/r4k: Constify params_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_r4k.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index e5cf8ed1a3..fc38b4bf99 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -79,8 +79,9 @@ typedef struct ResetData {
 
 static int64_t load_kernel(void)
 {
+    const size_t params_size = 264;
     int64_t entry, kernel_high;
-    long kernel_size, initrd_size, params_size;
+    long kernel_size, initrd_size;
     ram_addr_t initrd_offset;
     uint32_t *params_buf;
     int big_endian;
@@ -128,7 +129,6 @@ static int64_t load_kernel(void)
     }
 
     /* Store command line.  */
-    params_size = 264;
     params_buf = g_malloc(params_size);
 
     params_buf[0] = tswap32(ram_size);
@@ -143,7 +143,7 @@ static int64_t load_kernel(void)
     }
 
     rom_add_blob_fixed("params", params_buf, params_size,
-                       (16 << 20) - 264);
+                       (16 << 20) - params_size);
 
     g_free(params_buf);
     return entry;
-- 
2.17.1
