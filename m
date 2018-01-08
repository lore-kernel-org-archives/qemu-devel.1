Received: from eggs.gnu.org ([2001:4830:134:3::10]:51175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNRy-0006S2-Rq
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNRy-00026J-22
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:10 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNRx-000266-U2
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:09 -0500
Received: by mail-qk0-x242.google.com with SMTP id j185so1737680qkc.5
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:46:09 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:30 -0300
Message-Id: <20180108024558.17983-2-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/29] hw/acpi: add mem/nvdimm.h dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Keith Busch <keith.busch@intel.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/acpi/ich9.c  | 1 +
 hw/acpi/piix4.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index c5d8646abc..26aa87fa1a 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -37,6 +37,7 @@
 
 #include "hw/i386/ich9.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/nvdimm.h"
 
 //#define DEBUG
 
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index a0fb1ce037..32caa4f0fc 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -37,6 +37,7 @@
 #include "hw/acpi/cpu.h"
 #include "hw/hotplug.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/nvdimm.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/xen/xen.h"
-- 
2.15.1
