Received: from eggs.gnu.org ([209.51.188.92]:35808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gnhWd-00044u-Um
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 05:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gnhWd-0008Ru-EC
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 05:18:51 -0500
From: kumar sourav <sourav.jb1988@gmail.com>
Date: Sun, 27 Jan 2019 15:48:36 +0530
Message-Id: <20190127101836.15451-1-sourav.jb1988@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/input/lm832x: set device category of lm832x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: balrogg@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Sets the category of lm832x as DEVICE_CATEGORY_INPUT
Devices should be assigned to one of DEVICE_CATEGORY_XXXX

Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
---
 hw/input/lm832x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index cffbf586d4..07ae5e0aee 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -509,6 +509,7 @@ static void lm8323_class_init(ObjectClass *klass, void *data)
     k->recv = lm_i2c_rx;
     k->send = lm_i2c_tx;
     dc->vmsd = &vmstate_lm_kbd;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
 static const TypeInfo lm8323_info = {
-- 
2.17.1
