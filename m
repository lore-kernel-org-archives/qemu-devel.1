Received: from eggs.gnu.org ([209.51.188.92]:60385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0u-0005w8-BN
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0t-00050I-5S
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:12 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:06 +1000
Message-Id: <20190426060627.18153-16-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/36] target/ppc: Style fixes for mem_helper.c
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
 target/ppc/mem_helper.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 9c5a68579e..5b0f9ee50d 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -27,7 +27,7 @@
 #include "internal.h"
 #include "qemu/atomic128.h"
=20
-//#define DEBUG_OP
+/* #define DEBUG_OP */
=20
 static inline bool needs_byteswap(const CPUPPCState *env)
 {
@@ -103,10 +103,11 @@ void helper_lsw(CPUPPCState *env, target_ulong addr=
, uint32_t nb, uint32_t reg)
     do_lsw(env, addr, nb, reg, GETPC());
 }
=20
-/* PPC32 specification says we must generate an exception if
- * rA is in the range of registers to be loaded.
- * In an other hand, IBM says this is valid, but rA won't be loaded.
- * For now, I'll follow the spec...
+/*
+ * PPC32 specification says we must generate an exception if rA is in
+ * the range of registers to be loaded.  In an other hand, IBM says
+ * this is valid, but rA won't be loaded.  For now, I'll follow the
+ * spec...
  */
 void helper_lswx(CPUPPCState *env, target_ulong addr, uint32_t reg,
                  uint32_t ra, uint32_t rb)
@@ -199,7 +200,8 @@ void helper_dcbzep(CPUPPCState *env, target_ulong add=
r, uint32_t opcode)
 void helper_icbi(CPUPPCState *env, target_ulong addr)
 {
     addr &=3D ~(env->dcache_line_size - 1);
-    /* Invalidate one cache line :
+    /*
+     * Invalidate one cache line :
      * PowerPC specification says this is to be treated like a load
      * (not a fetch) by the MMU. To be sure it will be so,
      * do the load "by hand".
@@ -346,17 +348,19 @@ uint32_t helper_stqcx_be_parallel(CPUPPCState *env,=
 target_ulong addr,
 #define LO_IDX 0
 #endif
=20
-/* We use msr_le to determine index ordering in a vector.  However,
-   byteswapping is not simply controlled by msr_le.  We also need to tak=
e
-   into account endianness of the target.  This is done for the little-e=
ndian
-   PPC64 user-mode target. */
+/*
+ * We use msr_le to determine index ordering in a vector.  However,
+ * byteswapping is not simply controlled by msr_le.  We also need to
+ * take into account endianness of the target.  This is done for the
+ * little-endian PPC64 user-mode target.
+ */
=20
 #define LVE(name, access, swap, element)                        \
     void helper_##name(CPUPPCState *env, ppc_avr_t *r,          \
                        target_ulong addr)                       \
     {                                                           \
         size_t n_elems =3D ARRAY_SIZE(r->element);                \
-        int adjust =3D HI_IDX*(n_elems - 1);                      \
+        int adjust =3D HI_IDX * (n_elems - 1);                    \
         int sh =3D sizeof(r->element[0]) >> 1;                    \
         int index =3D (addr & 0xf) >> sh;                         \
         if (msr_le) {                                           \
@@ -476,12 +480,13 @@ VSX_STXVL(stxvll, 1)
=20
 void helper_tbegin(CPUPPCState *env)
 {
-    /* As a degenerate implementation, always fail tbegin.  The reason
+    /*
+     * As a degenerate implementation, always fail tbegin.  The reason
      * given is "Nesting overflow".  The "persistent" bit is set,
      * providing a hint to the error handler to not retry.  The TFIAR
      * captures the address of the failure, which is this tbegin
-     * instruction.  Instruction execution will continue with the
-     * next instruction in memory, which is precisely what we want.
+     * instruction.  Instruction execution will continue with the next
+     * instruction in memory, which is precisely what we want.
      */
=20
     env->spr[SPR_TEXASR] =3D
--=20
2.20.1
