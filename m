Received: from eggs.gnu.org ([209.51.188.92]:59964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0X-0005Rm-45
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0V-0004NO-FE
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:02 +1000
Message-Id: <20190426060627.18153-12-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/36] target/ppc: Style fixes for gdbstub.c
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
 target/ppc/gdbstub.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index fbf3821f4b..ce3625f44e 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -33,14 +33,14 @@ static int ppc_gdb_register_len_apple(int n)
         return 8;
     case 64 ... 95:
         return 16;
-    case 64+32: /* nip */
-    case 65+32: /* msr */
-    case 67+32: /* lr */
-    case 68+32: /* ctr */
-    case 70+32: /* fpscr */
+    case 64 + 32: /* nip */
+    case 65 + 32: /* msr */
+    case 67 + 32: /* lr */
+    case 68 + 32: /* ctr */
+    case 70 + 32: /* fpscr */
         return 8;
-    case 66+32: /* cr */
-    case 69+32: /* xer */
+    case 66 + 32: /* cr */
+    case 69 + 32: /* xer */
         return 4;
     default:
         return 0;
@@ -84,11 +84,14 @@ static int ppc_gdb_register_len(int n)
     }
 }
=20
-/* We need to present the registers to gdb in the "current" memory order=
ing.
-   For user-only mode we get this for free; TARGET_WORDS_BIGENDIAN is se=
t to
-   the proper ordering for the binary, and cannot be changed.
-   For system mode, TARGET_WORDS_BIGENDIAN is always set, and we must ch=
eck
-   the current mode of the chip to see if we're running in little-endian=
.  */
+/*
+ * We need to present the registers to gdb in the "current" memory
+ * ordering.  For user-only mode we get this for free;
+ * TARGET_WORDS_BIGENDIAN is set to the proper ordering for the
+ * binary, and cannot be changed.  For system mode,
+ * TARGET_WORDS_BIGENDIAN is always set, and we must check the current
+ * mode of the chip to see if we're running in little-endian.
+ */
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int le=
n)
 {
 #ifndef CONFIG_USER_ONLY
@@ -104,11 +107,12 @@ void ppc_maybe_bswap_register(CPUPPCState *env, uin=
t8_t *mem_buf, int len)
 #endif
 }
=20
-/* Old gdb always expects FP registers.  Newer (xml-aware) gdb only
+/*
+ * Old gdb always expects FP registers.  Newer (xml-aware) gdb only
  * expects whatever the target description contains.  Due to a
  * historical mishap the FP registers appear in between core integer
- * regs and PC, MSR, CR, and so forth.  We hack round this by giving the
- * FP regs zero size when talking to a newer gdb.
+ * regs and PC, MSR, CR, and so forth.  We hack round this by giving
+ * the FP regs zero size when talking to a newer gdb.
  */
=20
 int ppc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
--=20
2.20.1
