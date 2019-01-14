Received: from eggs.gnu.org ([209.51.188.92]:44821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4z-0005dX-Hd
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4y-0007Y4-3k
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30379)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz4x-0007Wu-TN
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:48 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:09 +0100
Message-Id: <1547460140-1473-15-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/25] hw/i2c/smbus: Remove SMBusDevice from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Files requiring SMBusDevice already include "hw/i2c/smbus.h".

To clean "qemu/typedefs.h", move the forward declaration
to "hw/i2c/smbus.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/i2c/smbus.h  | 2 ++
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
index d8b1b9e..5c61c05 100644
--- a/include/hw/i2c/smbus.h
+++ b/include/hw/i2c/smbus.h
@@ -35,6 +35,8 @@
 #define SMBUS_DEVICE_GET_CLASS(obj) \
      OBJECT_GET_CLASS(SMBusDeviceClass, (obj), TYPE_SMBUS_DEVICE)
=20
+typedef struct SMBusDevice SMBusDevice;
+
 typedef struct SMBusDeviceClass
 {
     I2CSlaveClass parent_class;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 3a5ca74..26e40fd 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -106,7 +106,6 @@ typedef struct RAMBlock RAMBlock;
 typedef struct Range Range;
 typedef struct SerialState SerialState;
 typedef struct SHPCDevice SHPCDevice;
-typedef struct SMBusDevice SMBusDevice;
 typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
--=20
1.8.3.1
