Received: from eggs.gnu.org ([2001:4830:134:3::10]:35716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVHyP-0006ku-QB
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVHyL-0003PM-Ch
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:46:37 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Wed, 12 Jul 2017 16:38:01 +0300
Message-Id: <667675623dc20b8d2f9ec2eff8a1c7eafcc86e19.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/13] hw/pci: define msi_nonbroken in pci-stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The kludged field 'msi_nonbroken' is declared in "hw/pci/msi.h" and defin=
ed in
hw/pci/msi.c.
When using an ARM config with CONFIG_PCI disabled, hw/pci/msi.c is not in=
cluded.
Without being PCI-related, the files hw/intc/arm_gicv[23*].c do access th=
is
field (to enable the kludge if PCI is enabled).
The final link fails since hw/pci/msi.c is not included.
Defining this field in pci-stub is safe enough for configs without CONFIG=
_PCI.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
=20
 PciInfoList *qmp_query_pci(Error **errp)
 {
--=20
2.11.0
