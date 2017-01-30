Received: from eggs.gnu.org ([2001:4830:134:3::10]:48221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYAz5-0008Kg-HU
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYAz0-0002t9-Kw
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:22:59 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 30 Jan 2017 13:22:52 +0100
Message-Id: <1485778972-20924-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] hw/core/or-irq: Mark the device with
 cannot_instantiate_with_device_add_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The "or-irq" device needs to be wired up in source code, there is no
way the user can add this device with the "-device" parameter or the
"device_add" monitor command yet.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Changed patch description and comment

 hw/core/or-irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index 1ac090d..808c8d1 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -89,6 +89,9 @@ static void or_irq_class_init(ObjectClass *klass, void *data)
     dc->props = or_irq_properties;
     dc->realize = or_irq_realize;
     dc->vmsd = &vmstate_or_irq;
+
+    /* Reason: Needs to be wired up in source code, e.g. see stm32f205_soc.c */
+    dc->cannot_instantiate_with_device_add_yet = true;
 }
 
 static const TypeInfo or_irq_type_info = {
-- 
1.8.3.1
