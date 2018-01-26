Received: from eggs.gnu.org ([2001:4830:134:3::10]:53016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ef0Bi-0000Ow-8f
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ef0Bf-0004Yd-4q
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:20:46 -0500
Received: from chuckie.co.uk ([82.165.15.123]:58601
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ef0Be-0004YN-V9
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:20:43 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 26 Jan 2018 09:20:29 +0000
Message-Id: <20180126092029.20737-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180126092029.20737-1-mark.cave-ayland@ilande.co.uk>
References: <20180126092029.20737-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/3] input: add missing newline from
 trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au

This was accidentally omitted from 77cb0f5aaf "Split adb.c into adb.c, adb-mouse.c
and adb-kbd.c".

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/input/trace-events | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/input/trace-events b/hw/input/trace-events
index a8d46cb766..5affabc81d 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -4,6 +4,7 @@
 adb_kbd_no_key(void) "Ignoring NO_KEY"
 adb_kbd_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
 adb_kbd_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
+
 # hw/input/adb-mouse.c
 adb_mouse_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
 adb_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
-- 
2.11.0
