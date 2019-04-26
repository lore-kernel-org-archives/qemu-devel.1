Received: from eggs.gnu.org ([209.51.188.92]:59959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0X-0005Rl-23
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0V-0004Na-HS
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:00 +1000
Message-Id: <20190426060627.18153-10-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/36] target/ppc: Style fixes for dfp_helper.c
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
 target/ppc/dfp_helper.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index 9164fe701b..f102177572 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -1104,19 +1104,19 @@ void helper_##op(CPUPPCState *env, uint64_t *t, u=
int64_t *b, uint32_t s)     \
         }                                                               =
     \
         }                                                               =
     \
                                                                         =
     \
-    while (offset < (size)/4) {                                         =
     \
+    while (offset < (size) / 4) {                                       =
     \
         n++;                                                            =
     \
-        digits[(size)/4-n] =3D dfp_get_bcd_digit_##size(dfp.b64, offset+=
+);    \
-        if (digits[(size)/4-n] > 10) {                                  =
     \
+        digits[(size) / 4 - n] =3D dfp_get_bcd_digit_##size(dfp.b64, off=
set++); \
+        if (digits[(size) / 4 - n] > 10) {                              =
     \
             dfp_set_FPSCR_flag(&dfp, FP_VX | FP_VXCVI, FPSCR_VE);       =
     \
             return;                                                     =
     \
         } else {                                                        =
     \
-            nonzero |=3D (digits[(size)/4-n] > 0);                      =
       \
+            nonzero |=3D (digits[(size) / 4 - n] > 0);                  =
       \
         }                                                               =
     \
     }                                                                   =
     \
                                                                         =
     \
     if (nonzero) {                                                      =
     \
-        decNumberSetBCD(&dfp.t, digits+((size)/4)-n, n);                =
     \
+        decNumberSetBCD(&dfp.t, digits + ((size) / 4) - n, n);          =
     \
     }                                                                   =
     \
                                                                         =
     \
     if (s && sgn)  {                                                    =
     \
@@ -1170,13 +1170,13 @@ DFP_HELPER_XEX(dxexq, 128)
 static void dfp_set_raw_exp_64(uint64_t *t, uint64_t raw)
 {
     *t &=3D 0x8003ffffffffffffULL;
-    *t |=3D (raw << (63-13));
+    *t |=3D (raw << (63 - 13));
 }
=20
 static void dfp_set_raw_exp_128(uint64_t *t, uint64_t raw)
 {
     t[HI_IDX] &=3D 0x80003fffffffffffULL;
-    t[HI_IDX] |=3D (raw << (63-17));
+    t[HI_IDX] |=3D (raw << (63 - 17));
 }
=20
 #define DFP_HELPER_IEX(op, size)                                        =
  \
--=20
2.20.1
