Received: from eggs.gnu.org ([209.51.188.92]:59984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0X-0005SY-Oj
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0W-0004Pa-Dp
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:03 +1000
Message-Id: <20190426060627.18153-13-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/36] target/ppc: Style fixes for helper_regs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/helper_regs.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index c863abc0bf..922da76c6c 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -44,10 +44,11 @@ static inline void hreg_swap_gpr_tgpr(CPUPPCState *en=
v)
=20
 static inline void hreg_compute_mem_idx(CPUPPCState *env)
 {
-    /* This is our encoding for server processors. The architecture
+    /*
+     * This is our encoding for server processors. The architecture
      * specifies that there is no such thing as userspace with
-     * translation off, however it appears that MacOS does it and
-     * some 32-bit CPUs support it. Weird...
+     * translation off, however it appears that MacOS does it and some
+     * 32-bit CPUs support it. Weird...
      *
      *   0 =3D Guest User space virtual mode
      *   1 =3D Guest Kernel space virtual mode
@@ -143,7 +144,8 @@ static inline int hreg_store_msr(CPUPPCState *env, ta=
rget_ulong value,
         /* Change the exception prefix on PowerPC 601 */
         env->excp_prefix =3D ((value >> MSR_EP) & 1) * 0xFFF00000;
     }
-    /* If PR=3D1 then EE, IR and DR must be 1
+    /*
+     * If PR=3D1 then EE, IR and DR must be 1
      *
      * Note: We only enforce this on 64-bit server processors.
      * It appears that:
--=20
2.20.1
