Received: from eggs.gnu.org ([209.51.188.92]:48167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxe0-0005cg-N6
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxWA-0003Rm-Uk
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:10:39 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:08:48 +0100
Message-Id: <20190111140857.4211-7-philmd@redhat.com>
In-Reply-To: <20190111140857.4211-1-philmd@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/15] hw/i2c/smbus: Remove SMBusDevice from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

Files requiring SMBusDevice already include "hw/i2c/smbus.h".

To clean "qemu/typedefs.h", move the forward declaration
to "hw/i2c/smbus.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/i2c/smbus.h  | 2 ++
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
index d8b1b9ee81..5c61c05999 100644
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
index 1c294c296c..4524e14d03 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -102,7 +102,6 @@ typedef struct RAMBlock RAMBlock;
 typedef struct Range Range;
 typedef struct SerialState SerialState;
 typedef struct SHPCDevice SHPCDevice;
-typedef struct SMBusDevice SMBusDevice;
 typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
--=20
2.17.2
