Received: from eggs.gnu.org ([2001:4830:134:3::10]:52571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ennEp-00038q-E6
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ennEo-0008Up-F6
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:20:19 -0500
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 19 Feb 2018 09:20:05 -0600
Message-Id: <1519053606-9817-2-git-send-email-minyard@acm.org>
In-Reply-To: <1519053606-9817-1-git-send-email-minyard@acm.org>
References: <CACRpkda9B=frmS0QF429p-q+KoCKG=5NON-kQ0Rt-nba2powRA@mail.gmail.com>
	<1519053606-9817-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 1/2] i2c: Fix some brace style issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/core.c        | 3 +--
 include/hw/i2c/i2c.h | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 59068f1..9a54b61 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -19,8 +19,7 @@ struct I2CNode {
 
 #define I2C_BROADCAST 0x00
 
-struct I2CBus
-{
+struct I2CBus {
     BusState qbus;
     QLIST_HEAD(, I2CNode) current_devs;
     uint8_t saved_address;
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 24e95d0..8fd449f 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -25,8 +25,7 @@ typedef struct I2CSlave I2CSlave;
 #define I2C_SLAVE_GET_CLASS(obj) \
      OBJECT_GET_CLASS(I2CSlaveClass, (obj), TYPE_I2C_SLAVE)
 
-typedef struct I2CSlaveClass
-{
+typedef struct I2CSlaveClass {
     DeviceClass parent_class;
 
     /* Callbacks provided by the device.  */
@@ -50,8 +49,7 @@ typedef struct I2CSlaveClass
     int (*event)(I2CSlave *s, enum i2c_event event);
 } I2CSlaveClass;
 
-struct I2CSlave
-{
+struct I2CSlave {
     DeviceState qdev;
 
     /* Remaining fields for internal use by the I2C code.  */
-- 
2.7.4
