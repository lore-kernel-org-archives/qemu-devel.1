Received: from eggs.gnu.org ([2001:4830:134:3::10]:60041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsJ-0001Up-QF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsJ-0000Zu-2A
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:20:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:43 -0300
Message-Id: <20170718061005.29518-8-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/29] ds1338: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alastair D'Silva <alastair@d-silva.org>, Corey Minyard <cminyard@mvista.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/ds1338.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index 3849b74a68..a77fe14514 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -65,7 +65,7 @@ static void capture_current_time(DS1338State *s)
     s->nvram[1] = to_bcd(now.tm_min);
     if (s->nvram[2] & HOURS_12) {
         int tmp = now.tm_hour;
-        if (tmp % 12 == 0) {
+        if (QEMU_IS_ALIGNED(tmp, 12)) {
             tmp += 12;
         }
         if (tmp <= 12) {
@@ -154,7 +154,7 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
                 if (data & HOURS_PM) {
                     tmp += 12;
                 }
-                if (tmp % 12 == 0) {
+                if (QEMU_IS_ALIGNED(tmp, 12)) {
                     tmp -= 12;
                 }
                 now.tm_hour = tmp;
-- 
2.13.2
