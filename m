Received: from eggs.gnu.org ([2001:4830:134:3::10]:35840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO6-000415-9s
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO5-00076F-Gn
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:54 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSO5-0006zA-5I
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:53 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSNy-0007FB-F6
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:46 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:09 +0000
Message-Id: <20181213145445.17935-2-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/37] hw: arm: musicpal: drop TYPE_WM8750 in
 object_property_set_link()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Li Qiang <liq3ea@gmail.com>

The third argument of object_property_set_link() is the name of
property, not related with the QOM type name, using the constant
string instead.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 1542880825-2604-1-git-send-email-liq3ea@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/musicpal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 9648b3af44e..726ae29394e 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1696,7 +1696,7 @@ static void musicpal_init(MachineState *machine)
     dev = qdev_create(NULL, TYPE_MV88W8618_AUDIO);
     s = SYS_BUS_DEVICE(dev);
     object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
-                             TYPE_WM8750, NULL);
+                             "wm8750", NULL);
     qdev_init_nofail(dev);
     sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
     sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
-- 
2.19.2
