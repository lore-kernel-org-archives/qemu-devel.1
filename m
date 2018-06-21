Received: from eggs.gnu.org ([2001:4830:134:3::10]:50180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW390-0004gP-F6
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW38z-000228-Gk
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 14:12:48 -0300
Message-Id: <20180621171257.14897-3-f4bug@amsat.org>
In-Reply-To: <20180621171257.14897-1-f4bug@amsat.org>
References: <20180621171257.14897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/11] sdcard: Reduce sdcard_set_blocklen()
 trace digits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Per the Physical Layer Simplified Spec. "5.3 CSD Register":

  "The maximum block length might therefore be in the range 512...2048 bytes"

Therefore 3 hexdigits are enough to report the block length.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index bfd1d62efc..d7880bcea5 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -37,7 +37,7 @@ sdcard_powerup(void) ""
 sdcard_inquiry_cmd41(void) ""
 sdcard_set_enable(bool current_state, bool new_state) "%u -> %u"
 sdcard_reset(void) ""
-sdcard_set_blocklen(uint16_t length) "0x%04x"
+sdcard_set_blocklen(uint16_t length) "0x%03x"
 sdcard_inserted(bool readonly) "read_only: %u"
 sdcard_ejected(void) ""
 sdcard_erase(void) ""
-- 
2.18.0.rc2
