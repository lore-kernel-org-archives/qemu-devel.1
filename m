Received: from eggs.gnu.org ([2001:4830:134:3::10]:58450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8O-0003WX-Au
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8M-0008Qw-O2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41458 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8M-0008Qc-IJ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:06 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:12 +0200
Message-Id: <20180531171253.21012-13-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/53] hw: Do not include "exec/ioport.h" if it
 is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Code change produced with:
    $ git grep '#include "exec/ioport.h"' hw | \
      cut -d: -f-1 | \
      xargs egrep -Li "(portio|cpu_(in|out).\()" | \
      xargs sed -i.bak '/#include "exec\/ioport.h"/d'

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180528232719.4721-11-f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
--=20
2.17.0
