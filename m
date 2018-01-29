Received: from eggs.gnu.org ([2001:4830:134:3::10]:34863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07a-0004T1-DP
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07Z-0001ew-LC
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 29 Jan 2018 14:28:19 +1100
Message-Id: <20180129032826.16876-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180129032826.16876-1-david@gibson.dropbear.id.au>
References: <20180129032826.16876-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/12] input: add missing newline from
 trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, surajjs@au1.ibm.com, groug@kaod.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This was accidentally omitted from 77cb0f5aaf "Split adb.c into adb.c, adb-mouse.c
and adb-kbd.c".

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
2.14.3
