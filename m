Received: from eggs.gnu.org ([2001:4830:134:3::10]:50864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cic8w-0003tR-LV
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 02:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cic8s-0005ID-7u
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 02:24:18 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 28 Feb 2017 09:44:46 +0300
Message-Id: <a70716eb2c766d80f605abd42115b923fedaa1f7.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 03/14] hw/core/or-irq: Mark the device with
 cannot_instantiate_with_device_add_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Thomas Huth <thuth@redhat.com>

The "or-irq" device needs to be wired up in source code, there is no
way the user can make any real use of this device with the "-device"
parameter or the "device_add" monitor command yet.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/core/or-irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index 1ac090d..1485d5b 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -89,6 +89,9 @@ static void or_irq_class_init(ObjectClass *klass, void *data)
     dc->props = or_irq_properties;
     dc->realize = or_irq_realize;
     dc->vmsd = &vmstate_or_irq;
+
+    /* Reason: Needs to be wired up to work, e.g. see stm32f205_soc.c */
+    dc->cannot_instantiate_with_device_add_yet = true;
 }
 
 static const TypeInfo or_irq_type_info = {
-- 
2.1.4
