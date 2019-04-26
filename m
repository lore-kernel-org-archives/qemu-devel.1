Received: from eggs.gnu.org ([209.51.188.92]:60039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0a-0005Uk-7D
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0Y-0004Tj-Lh
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:52 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:09 +1000
Message-Id: <20190426060627.18153-19-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/36] target/ppc: Style fixes for
 mmu-hash32.[ch]
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
 target/ppc/mmu-hash32.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index e8562a7c87..3f4dee835e 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -27,7 +27,7 @@
 #include "mmu-hash32.h"
 #include "exec/log.h"
=20
-//#define DEBUG_BAT
+/* #define DEBUG_BAT */
=20
 #ifdef DEBUG_BATS
 #  define LOG_BATS(...) qemu_log_mask(CPU_LOG_MMU, __VA_ARGS__)
@@ -228,8 +228,10 @@ static int ppc_hash32_direct_store(PowerPCCPU *cpu, =
target_ulong sr,
     qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
=20
     if ((sr & 0x1FF00000) >> 20 =3D=3D 0x07f) {
-        /* Memory-forced I/O controller interface access */
-        /* If T=3D1 and BUID=3Dx'07F', the 601 performs a memory access
+        /*
+         * Memory-forced I/O controller interface access
+         *
+         * If T=3D1 and BUID=3Dx'07F', the 601 performs a memory access
          * to SR[28-31] LA[4-31], bypassing all protection mechanisms.
          */
         *raddr =3D ((sr & 0xF) << 28) | (eaddr & 0x0FFFFFFF);
@@ -265,9 +267,11 @@ static int ppc_hash32_direct_store(PowerPCCPU *cpu, =
target_ulong sr,
         }
         return 1;
     case ACCESS_CACHE:
-        /* dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi */
-        /* Should make the instruction do no-op.
-         * As it already do no-op, it's quite easy :-)
+        /*
+         * dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi
+         *
+         * Should make the instruction do no-op.  As it already do
+         * no-op, it's quite easy :-)
          */
         *raddr =3D eaddr;
         return 0;
@@ -519,8 +523,10 @@ int ppc_hash32_handle_mmu_fault(PowerPCCPU *cpu, vad=
dr eaddr, int rwx,
     if (rwx =3D=3D 1) {
         new_pte1 |=3D HPTE32_R_C; /* set changed (dirty) bit */
     } else {
-        /* Treat the page as read-only for now, so that a later write
-         * will pass through this function again to set the C bit */
+        /*
+         * Treat the page as read-only for now, so that a later write
+         * will pass through this function again to set the C bit
+         */
         prot &=3D ~PAGE_WRITE;
     }
=20
--=20
2.20.1
