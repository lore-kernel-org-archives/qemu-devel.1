Received: from eggs.gnu.org ([209.51.188.92]:59994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0Y-0005Sb-CG
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0V-0004NI-EZ
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:50 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:05:58 +1000
Message-Id: <20190426060627.18153-8-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/36] target/ppc: Style fixes for int_helper.c
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
 target/ppc/int_helper.c | 70 +++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 162add561e..f6a088ac08 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -137,7 +137,8 @@ uint64_t helper_divde(CPUPPCState *env, uint64_t rau,=
 uint64_t rbu, uint32_t oe)
 /* if x =3D 0xab, returns 0xababababababababa */
 #define pattern(x) (((x) & 0xff) * (~(target_ulong)0 / 0xff))
=20
-/* substract 1 from each byte, and with inverse, check if MSB is set at =
each
+/*
+ * subtract 1 from each byte, and with inverse, check if MSB is set at e=
ach
  * byte.
  * i.e. ((0x00 - 0x01) & ~(0x00)) & 0x80
  *      (0xFF & 0xFF) & 0x80 =3D 0x80 (zero found)
@@ -156,7 +157,8 @@ uint32_t helper_cmpeqb(target_ulong ra, target_ulong =
rb)
 #undef haszero
 #undef hasvalue
=20
-/* Return invalid random number.
+/*
+ * Return invalid random number.
  *
  * FIXME: Add rng backend or other mechanism to get cryptographically su=
itable
  * random number
@@ -181,7 +183,7 @@ uint64_t helper_bpermd(uint64_t rs, uint64_t rb)
     uint64_t ra =3D 0;
=20
     for (i =3D 0; i < 8; i++) {
-        int index =3D (rs >> (i*8)) & 0xFF;
+        int index =3D (rs >> (i * 8)) & 0xFF;
         if (index < 64) {
             if (rb & PPC_BIT(index)) {
                 ra |=3D 1 << i;
@@ -370,7 +372,8 @@ target_ulong helper_divso(CPUPPCState *env, target_ul=
ong arg1,
 /* 602 specific instructions */
 /* mfrom is the most crazy instruction ever seen, imho ! */
 /* Real implementation uses a ROM table. Do the same */
-/* Extremely decomposed:
+/*
+ * Extremely decomposed:
  *                      -arg / 256
  * return 256 * log10(10           + 1.0) + 0.5
  */
@@ -393,7 +396,7 @@ target_ulong helper_602_mfrom(target_ulong arg)
     for (index =3D 0; index < ARRAY_SIZE(r->element); index++)
 #else
 #define VECTOR_FOR_INORDER_I(index, element)                    \
-    for (index =3D ARRAY_SIZE(r->element)-1; index >=3D 0; index--)
+    for (index =3D ARRAY_SIZE(r->element) - 1; index >=3D 0; index--)
 #endif
=20
 /* Saturating arithmetic helpers.  */
@@ -634,7 +637,8 @@ void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_a=
vr_t *b)           \
     }                                                                   =
\
 }
=20
-/* VABSDU - Vector absolute difference unsigned
+/*
+ * VABSDU - Vector absolute difference unsigned
  *   name    - instruction mnemonic suffix (b: byte, h: halfword, w: wor=
d)
  *   element - element type to access from vector
  */
@@ -739,7 +743,8 @@ void helper_vcmpne##suffix(CPUPPCState *env, ppc_avr_=
t *r,              \
     }                                                                   =
\
 }
=20
-/* VCMPNEZ - Vector compare not equal to zero
+/*
+ * VCMPNEZ - Vector compare not equal to zero
  *   suffix  - instruction mnemonic suffix (b: byte, h: halfword, w: wor=
d)
  *   element - element type to access from vector
  */
@@ -1138,7 +1143,7 @@ void helper_vpermr(CPUPPCState *env, ppc_avr_t *r, =
ppc_avr_t *a, ppc_avr_t *b,
 #define VBPERMQ_DW(index) (((index) & 0x40) !=3D 0)
 #define EXTRACT_BIT(avr, i, index) (extract64((avr)->u64[i], index, 1))
 #else
-#define VBPERMQ_INDEX(avr, i) ((avr)->u8[15-(i)])
+#define VBPERMQ_INDEX(avr, i) ((avr)->u8[15 - (i)])
 #define VBPERMD_INDEX(i) (1 - i)
 #define VBPERMQ_DW(index) (((index) & 0x40) =3D=3D 0)
 #define EXTRACT_BIT(avr, i, index) \
@@ -1169,7 +1174,7 @@ void helper_vbpermq(ppc_avr_t *r, ppc_avr_t *a, ppc=
_avr_t *b)
         int index =3D VBPERMQ_INDEX(b, i);
=20
         if (index < 128) {
-            uint64_t mask =3D (1ull << (63-(index & 0x3F)));
+            uint64_t mask =3D (1ull << (63 - (index & 0x3F)));
             if (a->u64[VBPERMQ_DW(index)] & mask) {
                 perm |=3D (0x8000 >> i);
             }
@@ -1449,9 +1454,9 @@ void helper_vgbbd(ppc_avr_t *r, ppc_avr_t *b)
=20
     VECTOR_FOR_INORDER_I(i, u8) {
 #if defined(HOST_WORDS_BIGENDIAN)
-        t[i>>3] |=3D VGBBD_MASKS[b->u8[i]] >> (i & 7);
+        t[i >> 3] |=3D VGBBD_MASKS[b->u8[i]] >> (i & 7);
 #else
-        t[i>>3] |=3D VGBBD_MASKS[b->u8[i]] >> (7-(i & 7));
+        t[i >> 3] |=3D VGBBD_MASKS[b->u8[i]] >> (7 - (i & 7));
 #endif
     }
=20
@@ -1463,19 +1468,19 @@ void helper_vgbbd(ppc_avr_t *r, ppc_avr_t *b)
 void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
 {                                                             \
     int i, j;                                                 \
-    trgtyp prod[sizeof(ppc_avr_t)/sizeof(a->srcfld[0])];      \
+    trgtyp prod[sizeof(ppc_avr_t) / sizeof(a->srcfld[0])];    \
                                                               \
     VECTOR_FOR_INORDER_I(i, srcfld) {                         \
         prod[i] =3D 0;                                          \
         for (j =3D 0; j < sizeof(a->srcfld[0]) * 8; j++) {      \
-            if (a->srcfld[i] & (1ull<<j)) {                   \
+            if (a->srcfld[i] & (1ull << j)) {                 \
                 prod[i] ^=3D ((trgtyp)b->srcfld[i] << j);       \
             }                                                 \
         }                                                     \
     }                                                         \
                                                               \
     VECTOR_FOR_INORDER_I(i, trgfld) {                         \
-        r->trgfld[i] =3D prod[2*i] ^ prod[2*i+1];               \
+        r->trgfld[i] =3D prod[2 * i] ^ prod[2 * i + 1];         \
     }                                                         \
 }
=20
@@ -1493,7 +1498,7 @@ void helper_vpmsumd(ppc_avr_t *r, ppc_avr_t *a, ppc=
_avr_t *b)
     VECTOR_FOR_INORDER_I(i, u64) {
         prod[i] =3D 0;
         for (j =3D 0; j < 64; j++) {
-            if (a->u64[i] & (1ull<<j)) {
+            if (a->u64[i] & (1ull << j)) {
                 prod[i] ^=3D (((__uint128_t)b->u64[i]) << j);
             }
         }
@@ -1508,7 +1513,7 @@ void helper_vpmsumd(ppc_avr_t *r, ppc_avr_t *a, ppc=
_avr_t *b)
     VECTOR_FOR_INORDER_I(i, u64) {
         prod[i].VsrD(1) =3D prod[i].VsrD(0) =3D 0;
         for (j =3D 0; j < 64; j++) {
-            if (a->u64[i] & (1ull<<j)) {
+            if (a->u64[i] & (1ull << j)) {
                 ppc_avr_t bshift;
                 if (j =3D=3D 0) {
                     bshift.VsrD(0) =3D 0;
@@ -1548,9 +1553,9 @@ void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_a=
vr_t *b)
         VECTOR_FOR_INORDER_I(j, u32) {
             uint32_t e =3D x[i]->u32[j];
=20
-            result.u16[4*i+j] =3D (((e >> 9) & 0xfc00) |
-                                 ((e >> 6) & 0x3e0) |
-                                 ((e >> 3) & 0x1f));
+            result.u16[4 * i + j] =3D (((e >> 9) & 0xfc00) |
+                                     ((e >> 6) & 0x3e0) |
+                                     ((e >> 3) & 0x1f));
         }
     }
     *r =3D result;
@@ -1568,7 +1573,7 @@ void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_a=
vr_t *b)
                                                                         =
\
         VECTOR_FOR_INORDER_I(i, from) {                                 =
\
             result.to[i] =3D cvt(a0->from[i], &sat);                    =
  \
-            result.to[i+ARRAY_SIZE(r->from)] =3D cvt(a1->from[i], &sat);=
  \
+            result.to[i + ARRAY_SIZE(r->from)] =3D cvt(a1->from[i], &sat=
);\
         }                                                               =
\
         *r =3D result;                                                  =
  \
         if (dosat && sat) {                                             =
\
@@ -1736,9 +1741,11 @@ VEXTU_X_DO(vextuhrx, 16, 0)
 VEXTU_X_DO(vextuwrx, 32, 0)
 #undef VEXTU_X_DO
=20
-/* The specification says that the results are undefined if all of the
- * shift counts are not identical.  We check to make sure that they are
- * to conform to what real hardware appears to do.  */
+/*
+ * The specification says that the results are undefined if all of the
+ * shift counts are not identical.  We check to make sure that they
+ * are to conform to what real hardware appears to do.
+ */
 #define VSHIFT(suffix, leftp)                                           =
\
     void helper_vs##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)    =
\
     {                                                                   =
\
@@ -1805,9 +1812,10 @@ void helper_vsrv(ppc_avr_t *r, ppc_avr_t *a, ppc_a=
vr_t *b)
     int i;
     unsigned int shift, bytes;
=20
-    /* Use reverse order, as destination and source register can be same=
. Its
-     * being modified in place saving temporary, reverse order will guar=
antee
-     * that computed result is not fed back.
+    /*
+     * Use reverse order, as destination and source register can be
+     * same. Its being modified in place saving temporary, reverse
+     * order will guarantee that computed result is not fed back.
      */
     for (i =3D ARRAY_SIZE(r->u8) - 1; i >=3D 0; i--) {
         shift =3D b->u8[i] & 0x7;                 /* extract shift value=
 */
@@ -1840,7 +1848,7 @@ void helper_vslo(ppc_avr_t *r, ppc_avr_t *a, ppc_av=
r_t *b)
=20
 #if defined(HOST_WORDS_BIGENDIAN)
     memmove(&r->u8[0], &a->u8[sh], 16 - sh);
-    memset(&r->u8[16-sh], 0, sh);
+    memset(&r->u8[16 - sh], 0, sh);
 #else
     memmove(&r->u8[sh], &a->u8[0], 16 - sh);
     memset(&r->u8[0], 0, sh);
@@ -2112,7 +2120,7 @@ void helper_vsum4ubs(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a, ppc_avr_t *b)
         ppc_avr_t result;                                               =
\
                                                                         =
\
         for (i =3D 0; i < ARRAY_SIZE(r->u32); i++) {                    =
  \
-            uint16_t e =3D b->u16[hi ? i : i+4];                        =
  \
+            uint16_t e =3D b->u16[hi ? i : i + 4];                      =
  \
             uint8_t a =3D (e >> 15) ? 0xff : 0;                         =
  \
             uint8_t r =3D (e >> 10) & 0x1f;                             =
  \
             uint8_t g =3D (e >> 5) & 0x1f;                              =
  \
@@ -2463,7 +2471,7 @@ static void bcd_put_digit(ppc_avr_t *bcd, uint8_t d=
igit, int n)
 {
     if (n & 1) {
         bcd->u8[BCD_DIG_BYTE(n)] &=3D 0x0F;
-        bcd->u8[BCD_DIG_BYTE(n)] |=3D (digit<<4);
+        bcd->u8[BCD_DIG_BYTE(n)] |=3D (digit << 4);
     } else {
         bcd->u8[BCD_DIG_BYTE(n)] &=3D 0xF0;
         bcd->u8[BCD_DIG_BYTE(n)] |=3D digit;
@@ -3220,7 +3228,7 @@ void helper_vshasigmad(ppc_avr_t *r,  ppc_avr_t *a,=
 uint32_t st_six)
=20
     for (i =3D 0; i < ARRAY_SIZE(r->u64); i++) {
         if (st =3D=3D 0) {
-            if ((six & (0x8 >> (2*i))) =3D=3D 0) {
+            if ((six & (0x8 >> (2 * i))) =3D=3D 0) {
                 r->VsrD(i) =3D ror64(a->VsrD(i), 1) ^
                              ror64(a->VsrD(i), 8) ^
                              (a->VsrD(i) >> 7);
@@ -3230,7 +3238,7 @@ void helper_vshasigmad(ppc_avr_t *r,  ppc_avr_t *a,=
 uint32_t st_six)
                              (a->VsrD(i) >> 6);
             }
         } else { /* st =3D=3D 1 */
-            if ((six & (0x8 >> (2*i))) =3D=3D 0) {
+            if ((six & (0x8 >> (2 * i))) =3D=3D 0) {
                 r->VsrD(i) =3D ror64(a->VsrD(i), 28) ^
                              ror64(a->VsrD(i), 34) ^
                              ror64(a->VsrD(i), 39);
--=20
2.20.1
