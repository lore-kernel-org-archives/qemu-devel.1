Received: from eggs.gnu.org ([209.51.188.92]:57720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkn-0004wL-6p
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkm-0002Lx-48
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:35 +1100
Message-Id: <20190226045304.25618-22-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/50] target/ppc: Fix #include guard in
 mmu-book3s-v3.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190215170029.15641-5-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-book3s-v3.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 41b7715862..12ec0054c2 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -17,8 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
-#ifndef MMU_H
-#define MMU_H
+#ifndef MMU_BOOOK3S_V3_H
+#define MMU_BOOOK3S_V3_H
=20
 #ifndef CONFIG_USER_ONLY
=20
@@ -62,4 +62,4 @@ int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr ea=
ddr, int rwx,
=20
 #endif /* CONFIG_USER_ONLY */
=20
-#endif /* MMU_H */
+#endif /* MMU_BOOOK3S_V3_H */
--=20
2.20.1
