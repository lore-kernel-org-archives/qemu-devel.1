Received: from eggs.gnu.org ([2001:4830:134:3::10]:53067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixJ-0003a3-1P
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixI-0004am-A5
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:45 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:13 +1100
Message-Id: <20171215055435.24204-3-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/24] ppc/xics: remove useless if condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The previous code section uses a 'first < 0' test and returns. Therefore,
there is no need to test the 'first' variable against '>=3D 0' afterwards=
.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_spapr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index d98ea8b130..e8c0a1b3e9 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -329,10 +329,8 @@ int spapr_ics_alloc_block(ICSState *ics, int num, bo=
ol lsi,
         return -1;
     }
=20
-    if (first >=3D 0) {
-        for (i =3D first; i < first + num; ++i) {
-            ics_set_irq_type(ics, i, lsi);
-        }
+    for (i =3D first; i < first + num; ++i) {
+        ics_set_irq_type(ics, i, lsi);
     }
     first +=3D ics->offset;
=20
--=20
2.14.3
