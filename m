Received: from eggs.gnu.org ([2001:4830:134:3::10]:36372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWsRQ-0003Yd-1h
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 19:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWsRP-0007IR-FH
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 19:31:56 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 22:31:47 -0200
Message-Id: <20181212003147.29604-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] virt: Fix broken indentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

I introduced indentation using tabs instead of spaces in another
commit.  Peter reported the problem, and I failed to fix that
before sending my pull request.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 951597607696 ("virt: Eliminate separate instance_init functions")
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 17f1b49d11..5b678237b7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1854,7 +1854,7 @@ static const TypeInfo virt_machine_info = {
     .instance_size = sizeof(VirtMachineState),
     .class_size    = sizeof(VirtMachineClass),
     .class_init    = virt_machine_class_init,
-	.instance_init = virt_instance_init,
+    .instance_init = virt_instance_init,
     .interfaces = (InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
-- 
2.18.0.rc1.1.g3f1ff2140
