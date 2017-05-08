Received: from eggs.gnu.org ([2001:4830:134:3::10]:52569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7sFc-0004t2-0z
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7sFb-0002BO-8V
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:39:36 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 20:39:09 -0300
Message-Id: <20170508233918.9043-3-f4bug@amsat.org>
In-Reply-To: <20170508233918.9043-1-f4bug@amsat.org>
References: <20170508233918.9043-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 02/11] hw/pci: define msi_nonbroken in
 pci-stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This field is accessed in hw/intc/arm_gicv[23*].c

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci/pci-stub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index 36d2c430c5..ecad664946 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -24,6 +24,9 @@
 #include "qapi/qmp/qerror.h"
 #include "hw/pci/pci.h"
 #include "qmp-commands.h"
+#include "hw/pci/msi.h"
+
+bool msi_nonbroken;
 
 PciInfoList *qmp_query_pci(Error **errp)
 {
-- 
2.11.0
