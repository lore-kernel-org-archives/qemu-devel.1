Received: from eggs.gnu.org ([2001:4830:134:3::10]:55638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXu-0000o8-IT
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXt-0006cj-IB
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:34 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:37215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXt-0006cW-EL
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:33 -0400
Received: by mail-qk0-x242.google.com with SMTP id a21so24332qkg.4
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 20:53:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 31 Aug 2017 00:53:06 -0300
Message-Id: <20170831035306.29170-8-f4bug@amsat.org>
In-Reply-To: <20170831035306.29170-1-f4bug@amsat.org>
References: <20170831035306.29170-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 7/7] hw/xtensa: serial_mm_init() already check
 for null chr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/xtensa/xtfpga.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 635a4d4ec3..223f396902 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -263,10 +263,6 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
                 xtensa_get_extint(env, 1), nd_table);
     }
 
-    if (!serial_hds[0]) {
-        serial_hds[0] = qemu_chr_new("serial0", "null");
-    }
-
     serial_mm_init(system_io, 0x0d050020, 2, xtensa_get_extint(env, 0),
             115200, serial_hds[0], DEVICE_NATIVE_ENDIAN);
 
-- 
2.14.1
