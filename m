Received: from eggs.gnu.org ([209.51.188.92]:58441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09F-0006Mc-CD
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09E-00072g-JV
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:01 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:58 +1100
Message-Id: <20190108224600.23125-28-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/29] ppc/xics: allow ICSState to have an
 offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

commit 15ed653fa49a ("ppc/xics: An ICS with offset 0 is assumed to be
uninitialized") introduced an extra check on the ICS offset which is
not strictly necessary.

Revert the change to be able to map the XICS IRQ number space on the
XIVE IRQ number space.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/xics.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 7668c381a8..07508cbd21 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -139,8 +139,7 @@ struct ICSState {
=20
 static inline bool ics_valid_irq(ICSState *ics, uint32_t nr)
 {
-    return (ics->offset !=3D 0) && (nr >=3D ics->offset)
-        && (nr < (ics->offset + ics->nr_irqs));
+    return (nr >=3D ics->offset) && (nr < (ics->offset + ics->nr_irqs));
 }
=20
 struct ICSIRQState {
--=20
2.20.1
