Received: from eggs.gnu.org ([2001:4830:134:3::10]:43246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0O-0002Gl-Qd
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0L-0000D0-SU
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:04 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cMz0L-0000Cf-MU
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:01 -0500
Received: by mail-pg0-x242.google.com with SMTP id n5so22380611pgh.3
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 07:22:01 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri, 30 Dec 2016 09:21:33 -0600
Message-Id: <1483111310-24808-3-git-send-email-minyard@acm.org>
In-Reply-To: <1483111310-24808-1-git-send-email-minyard@acm.org>
References: <1483111310-24808-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 02/19] i2c-smbus: Use a int for return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: minyard@acm.org, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The return value from getting the data may be an error, so
use an integer to hold it.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
index 2d1b79a..c631a1c 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -222,7 +222,7 @@ int smbus_quick_command(I2CBus *bus, uint8_t addr, int read)
 
 int smbus_receive_byte(I2CBus *bus, uint8_t addr)
 {
-    uint8_t data;
+    int data;
 
     if (i2c_start_transfer(bus, addr, 1)) {
         return -1;
-- 
2.7.4
