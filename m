Received: from eggs.gnu.org ([2001:4830:134:3::10]:34289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBAm-0007WT-RF
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBAm-0003wF-3L
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:28 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:45465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBAl-0003w9-V6
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:28 -0500
Received: by mail-qk0-x244.google.com with SMTP id g2so8416536qkd.12
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:29:27 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 01:28:35 -0300
Message-Id: <20180215042900.16078-6-f4bug@amsat.org>
In-Reply-To: <20180215042900.16078-1-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/30] hw/mips/r4k: constify params_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_r4k.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 830ee7732c..5a74c44b9a 100644
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
@@ -144,7 +144,6 @@ static int64_t load_kernel(void)
 
     rom_add_blob_fixed("params", params_buf, params_size,
                        (16 << 20) - 264);
-
     g_free(params_buf);
     return entry;
 }
-- 
2.16.1
