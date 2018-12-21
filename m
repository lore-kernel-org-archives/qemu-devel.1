Received: from eggs.gnu.org ([2001:4830:134:3::10]:60301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDdp-0000bE-7f
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDdo-0007Jy-DY
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:46:33 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 21 Dec 2018 16:45:49 +1100
Message-Id: <20181221054606.22007-24-david@gibson.dropbear.id.au>
In-Reply-To: <20181221054606.22007-1-david@gibson.dropbear.id.au>
References: <20181221054606.22007-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/40] Changes requirement for "vsubsbs"
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, gkurz@redhat.com, lvivier@redhat.com, clg@kaod.org, "Paul A. Clarke" <pc@us.ibm.com>, Leonardo Bras <leonardo@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: "Paul A. Clarke" <pc@us.ibm.com>

Changes requirement for "vsubsbs" instruction, which has been supported
since ISA 2.03. (Please see section 5.9.1.2 of ISA 2.03)

Reported-by: Paul A. Clarke <pc@us.ibm.com>
Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
Signed-off-by: Leonardo Bras <leonardo@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vmx-ops.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vm=
x-ops.inc.c
index 139f80cb24..84e05fb827 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -143,7 +143,7 @@ GEN_VXFORM(vaddsws, 0, 14),
 GEN_VXFORM_DUAL(vsububs, bcdadd, 0, 24, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_DUAL(vsubuhs, bcdsub, 0, 25, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM(vsubuws, 0, 26),
-GEN_VXFORM_DUAL(vsubsbs, bcdtrunc, 0, 28, PPC_NONE, PPC2_ISA300),
+GEN_VXFORM_DUAL(vsubsbs, bcdtrunc, 0, 28, PPC_ALTIVEC, PPC2_ISA300),
 GEN_VXFORM(vsubshs, 0, 29),
 GEN_VXFORM_DUAL(vsubsws, xpnd04_2, 0, 30, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_207(vadduqm, 0, 4),
--=20
2.19.2
