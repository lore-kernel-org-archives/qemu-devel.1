Received: from eggs.gnu.org ([2001:4830:134:3::10]:54275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7oIy-00088h-IC
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 16:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7oIu-0001Ps-JX
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 16:31:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 17:31:06 -0300
Message-Id: <20180415203106.24333-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.12?] m25p80: Correct the
 at25128a/at25256a eeproms size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marcin=20Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org

>From the datasheet (3368J–SEEPR) description:
    The AT25128A/256A provides 131,072/262,144 bits of serial
    electrically-erasable programmable read only memory (EEPROM)
    organized as 16,384/32,768 words of 8 bits each.

However QEMU models the flash size in bytes.
Correct the at25128a/at25256a entries to reflect the datasheet size.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
This is not a regression, so can now wait for 2.13.

 hw/block/m25p80.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index b49c8e9caa..d0b9fbfc50 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -196,8 +196,8 @@ static const FlashPartInfo known_devices[] = {
     /* Atmel EEPROMS - it is assumed, that don't care bit in command
      * is set to 0. Block protection is not supported.
      */
-    { INFO("at25128a-nonjedec", 0x0,     0,         1, 131072, EEPROM) },
-    { INFO("at25256a-nonjedec", 0x0,     0,         1, 262144, EEPROM) },
+    { INFO("at25128a-nonjedec", 0x0,     0,         1, 16384, EEPROM) },
+    { INFO("at25256a-nonjedec", 0x0,     0,         1, 32768, EEPROM) },
 
     /* EON -- en25xxx */
     { INFO("en25f32",     0x1c3116,      0,  64 << 10,  64, ER_4K) },
-- 
2.17.0
