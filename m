Received: from eggs.gnu.org ([209.51.188.92]:54564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzSG-0001LK-MY
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzSD-0007ru-RV
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:55:07 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Apr 2019 18:54:14 +0200
Message-Id: <20190412165416.7977-11-philmd@redhat.com>
In-Reply-To: <20190412165416.7977-1-philmd@redhat.com>
References: <20190412165416.7977-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 10/12] hw/net/ne2000-isa: Add guards to the
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Jason Wang <jasowang@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/net/ne2000-isa.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
index ff2bed9c95d..527337c4548 100644
--- a/include/hw/net/ne2000-isa.h
+++ b/include/hw/net/ne2000-isa.h
@@ -6,6 +6,10 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
+#ifndef HW_NET_NE2K_ISA_H
+#define HW_NET_NE2K_ISA_H
+
 #include "hw/hw.h"
 #include "hw/qdev.h"
 #include "hw/isa/isa.h"
@@ -31,3 +35,5 @@ static inline ISADevice *isa_ne2000_init(ISABus *bus, i=
nt base, int irq,
     }
     return d;
 }
+
+#endif
--=20
2.20.1
