Received: from eggs.gnu.org ([2001:4830:134:3::10]:34467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBB-0007sQ-AF
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBA-00044C-Fa
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:53 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBA-00043u-C5
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:52 -0500
Received: by mail-qt0-x243.google.com with SMTP id d14so10486165qtg.1
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:29:52 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 01:28:43 -0300
Message-Id: <20180215042900.16078-14-f4bug@amsat.org>
In-Reply-To: <20180215042900.16078-1-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 13/30] hw/xtensa: use the BYTE-based definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Max Filippov <jcmvbkbc@gmail.com>

It ease code review, unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/xtensa/xtfpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 70686a2eb1..922417af15 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -230,7 +230,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     const char *kernel_cmdline = qemu_opt_get(machine_opts, "append");
     const char *dtb_filename = qemu_opt_get(machine_opts, "dtb");
     const char *initrd_filename = qemu_opt_get(machine_opts, "initrd");
-    const unsigned system_io_size = 224 * 1024 * 1024;
+    const unsigned system_io_size = 224 * M_BYTE;
     int n;
 
     for (n = 0; n < smp_cpus; n++) {
-- 
2.16.1
