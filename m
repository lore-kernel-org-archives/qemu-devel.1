Received: from eggs.gnu.org ([2001:4830:134:3::10]:43445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPS-0006Ql-Rd
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPS-0007tw-6W
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f9XPS-0007mN-08
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:10 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:52:41 +0100
Message-Id: <20180420145249.32435-6-peter.maydell@linaro.org>
In-Reply-To: <20180420145249.32435-1-peter.maydell@linaro.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 05/13] hw/xtensa/xtfpga.c: Don't create "null"
 chardevs for serial devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Following commit 12051d82f004024, UART devices should handle
being passed a NULL pointer chardev, so we don't need to
create "null" backends in board code. Remove the code that
does this and updates serial_hds[].

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/xtensa/xtfpga.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 70686a2eb1..9db99e1f7e 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -278,10 +278,6 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
                 xtensa_get_extint(env, 1), nd_table);
     }
 
-    if (!serial_hds[0]) {
-        serial_hds[0] = qemu_chr_new("serial0", "null");
-    }
-
     serial_mm_init(system_io, 0x0d050020, 2, xtensa_get_extint(env, 0),
             115200, serial_hds[0], DEVICE_NATIVE_ENDIAN);
 
-- 
2.17.0
