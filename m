Received: from eggs.gnu.org ([2001:4830:134:3::10]:34583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBP-00084W-Fv
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBO-0004B1-OS
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:07 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBO-0004AJ-JV
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:06 -0500
Received: by mail-qt0-x244.google.com with SMTP id q18so10489661qtl.3
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:30:06 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 01:28:49 -0300
Message-Id: <20180215042900.16078-20-f4bug@amsat.org>
In-Reply-To: <20180215042900.16078-1-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 19/30] hw/nios2: use the BYTE-based definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

It ease code review, unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/nios2/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index 771e00267b..911f28c0d8 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -176,7 +176,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
             high = ddr_base + kernel_size;
         }
 
-        high = ROUND_UP(high, 1024 * 1024);
+        high = ROUND_UP(high, 1 * M_BYTE);
 
         /* If initrd is available, it goes after the kernel, aligned to 1M. */
         if (initrd_filename) {
-- 
2.16.1
