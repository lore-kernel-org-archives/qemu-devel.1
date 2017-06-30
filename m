Received: from eggs.gnu.org ([2001:4830:134:3::10]:34292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRh-0008Rt-2W
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRg-0007s0-0r
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:12 +1000
Message-Id: <20170630104632.27942-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/21] hw/ppc/prep: Remove superfluous call to
 soundhw_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

When using the 40p machine, soundhw_init() is currently called twice,
one time from vl.c and one time from ibm_40p_init(). The call in
ibm_40p_init() was likely just a copy-and-paste from a old version
of the prep machine - but there the call to audio_init() (which was
the previous name of this function) has been removed many years ago
already, with commit b3e6d591b05538056d665572f3e3bbfb3cbb70e7
("audio: enable PCI audio cards for all PCI-enabled targets"), so
we certainly also do not need the soundhw_init() in the 40p function
anymore nowadays.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Sahid Ferdjaoui <sferdjao@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/prep.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index d16646c..36d3dcd 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -36,7 +36,6 @@
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/ppc.h"
 #include "hw/boards.h"
-#include "hw/audio/soundhw.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "hw/ide.h"
@@ -782,9 +781,6 @@ static void ibm_40p_init(MachineState *machine)
     qbus_walk_children(BUS(isa_bus), prep_set_cmos_checksum, NULL, NULL,=
 NULL,
                        &cmos_checksum);
=20
-    /* initialize audio subsystem */
-    soundhw_init();
-
     /* add some more devices */
     if (defaults_enabled()) {
         isa_create_simple(isa_bus, "i8042");
--=20
2.9.4
