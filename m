Received: from eggs.gnu.org ([2001:4830:134:3::10]:32864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRYh-0007Cl-BA
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRYg-00017D-Jr
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:28:11 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 28 May 2018 20:27:08 -0300
Message-Id: <20180528232719.4721-11-f4bug@amsat.org>
In-Reply-To: <20180528232719.4721-1-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 10/21] hw: Do not include "exec/ioport.h" if
 it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Code change produced with:
    $ git grep '#include "exec/ioport.h"' hw | \
      cut -d: -f-1 | \
      xargs egrep -Li "(portio|cpu_(in|out).\()" | \
      xargs sed -i.bak '/#include "exec\/ioport.h"/d'

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/acpi/pcihp.c | 1 -
 hw/acpi/piix4.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 91c82fdc7a..80d42e12ff 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -32,7 +32,6 @@
 #include "hw/pci/pci.h"
 #include "hw/acpi/acpi.h"
 #include "sysemu/sysemu.h"
-#include "exec/ioport.h"
 #include "exec/address-spaces.h"
 #include "hw/pci/pci_bus.h"
 #include "qapi/error.h"
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 8b703455b7..6404af5f33 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -28,7 +28,6 @@
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qemu/range.h"
-#include "exec/ioport.h"
 #include "hw/nvram/fw_cfg.h"
 #include "exec/address-spaces.h"
 #include "hw/acpi/piix4.h"
-- 
2.17.0
