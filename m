Received: from eggs.gnu.org ([209.51.188.92]:60031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0Z-0005UE-Lh
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0V-0004OG-Qh
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:51 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:05:59 +1000
Message-Id: <20190426060627.18153-9-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/36] target/ppc: Style fixes for fpu_helper.c
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
 target/ppc/fpu_helper.c | 134 +++++++++++++++++++++++++---------------
 1 file changed, 83 insertions(+), 51 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 2ed4f42275..0b7308f539 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -90,10 +90,12 @@ uint32_t helper_tosingle(uint64_t arg)
         ret  =3D extract64(arg, 62, 2) << 30;
         ret |=3D extract64(arg, 29, 30);
     } else {
-        /* Zero or Denormal result.  If the exponent is in bounds for
-         * a single-precision denormal result, extract the proper bits.
-         * If the input is not zero, and the exponent is out of bounds,
-         * then the result is undefined; this underflows to zero.
+        /*
+         * Zero or Denormal result.  If the exponent is in bounds for
+         * a single-precision denormal result, extract the proper
+         * bits.  If the input is not zero, and the exponent is out of
+         * bounds, then the result is undefined; this underflows to
+         * zero.
          */
         ret =3D extract64(arg, 63, 1) << 31;
         if (unlikely(exp >=3D 874)) {
@@ -1090,7 +1092,7 @@ uint32_t helper_ftsqrt(uint64_t frb)
             fe_flag =3D 1;
         } else if (unlikely(float64_is_neg(frb))) {
             fe_flag =3D 1;
-        } else if (!float64_is_zero(frb) && (e_b <=3D (-1022+52))) {
+        } else if (!float64_is_zero(frb) && (e_b <=3D (-1022 + 52))) {
             fe_flag =3D 1;
         }
=20
@@ -1789,7 +1791,8 @@ uint32_t helper_efdcmpeq(CPUPPCState *env, uint64_t=
 op1, uint64_t op2)
 #define float64_to_float64(x, env) x
=20
=20
-/* VSX_ADD_SUB - VSX floating point add/subract
+/*
+ * VSX_ADD_SUB - VSX floating point add/subract
  *   name  - instruction mnemonic
  *   op    - operation (add or sub)
  *   nels  - number of elements (1, 2 or 4)
@@ -1872,7 +1875,8 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opco=
de)
     do_float_check_status(env, GETPC());
 }
=20
-/* VSX_MUL - VSX floating point multiply
+/*
+ * VSX_MUL - VSX floating point multiply
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   tp    - type (float32 or float64)
@@ -1950,7 +1954,8 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t opco=
de)
     do_float_check_status(env, GETPC());
 }
=20
-/* VSX_DIV - VSX floating point divide
+/*
+ * VSX_DIV - VSX floating point divide
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   tp    - type (float32 or float64)
@@ -2034,7 +2039,8 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opco=
de)
     do_float_check_status(env, GETPC());
 }
=20
-/* VSX_RE  - VSX floating point reciprocal estimate
+/*
+ * VSX_RE  - VSX floating point reciprocal estimate
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   tp    - type (float32 or float64)
@@ -2075,7 +2081,8 @@ VSX_RE(xsresp, 1, float64, VsrD(0), 1, 1)
 VSX_RE(xvredp, 2, float64, VsrD(i), 0, 0)
 VSX_RE(xvresp, 4, float32, VsrW(i), 0, 0)
=20
-/* VSX_SQRT - VSX floating point square root
+/*
+ * VSX_SQRT - VSX floating point square root
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   tp    - type (float32 or float64)
@@ -2124,7 +2131,8 @@ VSX_SQRT(xssqrtsp, 1, float64, VsrD(0), 1, 1)
 VSX_SQRT(xvsqrtdp, 2, float64, VsrD(i), 0, 0)
 VSX_SQRT(xvsqrtsp, 4, float32, VsrW(i), 0, 0)
=20
-/* VSX_RSQRTE - VSX floating point reciprocal square root estimate
+/*
+ *VSX_RSQRTE - VSX floating point reciprocal square root estimate
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   tp    - type (float32 or float64)
@@ -2174,7 +2182,8 @@ VSX_RSQRTE(xsrsqrtesp, 1, float64, VsrD(0), 1, 1)
 VSX_RSQRTE(xvrsqrtedp, 2, float64, VsrD(i), 0, 0)
 VSX_RSQRTE(xvrsqrtesp, 4, float32, VsrW(i), 0, 0)
=20
-/* VSX_TDIV - VSX floating point test for divide
+/*
+ * VSX_TDIV - VSX floating point test for divide
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   tp    - type (float32 or float64)
@@ -2207,18 +2216,20 @@ void helper_##op(CPUPPCState *env, uint32_t opcod=
e)                     \
             if (unlikely(tp##_is_any_nan(xa.fld) ||                     =
\
                          tp##_is_any_nan(xb.fld))) {                    =
\
                 fe_flag =3D 1;                                          =
  \
-            } else if ((e_b <=3D emin) || (e_b >=3D (emax-2))) {        =
    \
+            } else if ((e_b <=3D emin) || (e_b >=3D (emax - 2))) {      =
    \
                 fe_flag =3D 1;                                          =
  \
             } else if (!tp##_is_zero(xa.fld) &&                         =
\
                        (((e_a - e_b) >=3D emax) ||                      =
  \
-                        ((e_a - e_b) <=3D (emin+1)) ||                  =
  \
-                         (e_a <=3D (emin+nbits)))) {                    =
  \
+                        ((e_a - e_b) <=3D (emin + 1)) ||                =
  \
+                        (e_a <=3D (emin + nbits)))) {                   =
  \
                 fe_flag =3D 1;                                          =
  \
             }                                                           =
\
                                                                         =
\
             if (unlikely(tp##_is_zero_or_denormal(xb.fld))) {           =
\
-                /* XB is not zero because of the above check and */     =
\
-                /* so must be denormalized.                      */     =
\
+                /*                                                      =
\
+                 * XB is not zero because of the above check and so     =
\
+                 * must be denormalized.                                =
\
+                 */                                                     =
\
                 fg_flag =3D 1;                                          =
  \
             }                                                           =
\
         }                                                               =
\
@@ -2231,7 +2242,8 @@ VSX_TDIV(xstdivdp, 1, float64, VsrD(0), -1022, 1023=
, 52)
 VSX_TDIV(xvtdivdp, 2, float64, VsrD(i), -1022, 1023, 52)
 VSX_TDIV(xvtdivsp, 4, float32, VsrW(i), -126, 127, 23)
=20
-/* VSX_TSQRT - VSX floating point test for square root
+/*
+ * VSX_TSQRT - VSX floating point test for square root
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   tp    - type (float32 or float64)
@@ -2266,13 +2278,15 @@ void helper_##op(CPUPPCState *env, uint32_t opcod=
e)                     \
             } else if (unlikely(tp##_is_neg(xb.fld))) {                 =
\
                 fe_flag =3D 1;                                          =
  \
             } else if (!tp##_is_zero(xb.fld) &&                         =
\
-                      (e_b <=3D (emin+nbits))) {                        =
  \
+                       (e_b <=3D (emin + nbits))) {                     =
  \
                 fe_flag =3D 1;                                          =
  \
             }                                                           =
\
                                                                         =
\
             if (unlikely(tp##_is_zero_or_denormal(xb.fld))) {           =
\
-                /* XB is not zero because of the above check and */     =
\
-                /* therefore must be denormalized.               */     =
\
+                /*                                                      =
\
+                 * XB is not zero because of the above check and        =
\
+                 * therefore must be denormalized.                      =
\
+                 */                                                     =
\
                 fg_flag =3D 1;                                          =
  \
             }                                                           =
\
         }                                                               =
\
@@ -2285,7 +2299,8 @@ VSX_TSQRT(xstsqrtdp, 1, float64, VsrD(0), -1022, 52=
)
 VSX_TSQRT(xvtsqrtdp, 2, float64, VsrD(i), -1022, 52)
 VSX_TSQRT(xvtsqrtsp, 4, float32, VsrW(i), -126, 23)
=20
-/* VSX_MADD - VSX floating point muliply/add variations
+/*
+ * VSX_MADD - VSX floating point muliply/add variations
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   tp    - type (float32 or float64)
@@ -2322,8 +2337,10 @@ void helper_##op(CPUPPCState *env, uint32_t opcode=
)                           \
         float_status tstat =3D env->fp_status;                          =
        \
         set_float_exception_flags(0, &tstat);                           =
      \
         if (r2sp && (tstat.float_rounding_mode =3D=3D float_round_neares=
t_even)) {\
-            /* Avoid double rounding errors by rounding the intermediate=
 */   \
-            /* result to odd.                                           =
 */   \
+            /*                                                          =
      \
+             * Avoid double rounding errors by rounding the intermediate=
      \
+             * result to odd.                                           =
      \
+             */                                                         =
      \
             set_float_rounding_mode(float_round_to_zero, &tstat);       =
      \
             xt_out.fld =3D tp##_muladd(xa.fld, b->fld, c->fld,          =
        \
                                        maddflgs, &tstat);               =
      \
@@ -2388,7 +2405,8 @@ VSX_MADD(xvnmaddmsp, 4, float32, VsrW(i), NMADD_FLG=
S, 0, 0, 0)
 VSX_MADD(xvnmsubasp, 4, float32, VsrW(i), NMSUB_FLGS, 1, 0, 0)
 VSX_MADD(xvnmsubmsp, 4, float32, VsrW(i), NMSUB_FLGS, 0, 0, 0)
=20
-/* VSX_SCALAR_CMP_DP - VSX scalar floating point compare double precisio=
n
+/*
+ * VSX_SCALAR_CMP_DP - VSX scalar floating point compare double precisio=
n
  *   op    - instruction mnemonic
  *   cmp   - comparison operation
  *   exp   - expected result of comparison
@@ -2604,7 +2622,8 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)=
                     \
 VSX_SCALAR_CMPQ(xscmpoqp, 1)
 VSX_SCALAR_CMPQ(xscmpuqp, 0)
=20
-/* VSX_MAX_MIN - VSX floating point maximum/minimum
+/*
+ * VSX_MAX_MIN - VSX floating point maximum/minimum
  *   name  - instruction mnemonic
  *   op    - operation (max or min)
  *   nels  - number of elements (1, 2 or 4)
@@ -2733,7 +2752,8 @@ void helper_##name(CPUPPCState *env, uint32_t opcod=
e)                         \
 VSX_MAX_MINJ(xsmaxjdp, 1);
 VSX_MAX_MINJ(xsminjdp, 0);
=20
-/* VSX_CMP - VSX floating point compare
+/*
+ * VSX_CMP - VSX floating point compare
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   tp    - type (float32 or float64)
@@ -2778,7 +2798,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)=
                       \
     }                                                                   =
  \
                                                                         =
  \
     putVSR(xT(opcode), &xt, env);                                       =
  \
-    if ((opcode >> (31-21)) & 1) {                                      =
  \
+    if ((opcode >> (31 - 21)) & 1) {                                    =
  \
         env->crf[6] =3D (all_true ? 0x8 : 0) | (all_false ? 0x2 : 0);   =
    \
     }                                                                   =
  \
     do_float_check_status(env, GETPC());                                =
  \
@@ -2793,7 +2813,8 @@ VSX_CMP(xvcmpgesp, 4, float32, VsrW(i), le, 1, 1)
 VSX_CMP(xvcmpgtsp, 4, float32, VsrW(i), lt, 1, 1)
 VSX_CMP(xvcmpnesp, 4, float32, VsrW(i), eq, 0, 0)
=20
-/* VSX_CVT_FP_TO_FP - VSX floating point/floating point conversion
+/*
+ * VSX_CVT_FP_TO_FP - VSX floating point/floating point conversion
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   stp   - source type (float32 or float64)
@@ -2829,10 +2850,11 @@ void helper_##op(CPUPPCState *env, uint32_t opcod=
e)                \
=20
 VSX_CVT_FP_TO_FP(xscvdpsp, 1, float64, float32, VsrD(0), VsrW(0), 1)
 VSX_CVT_FP_TO_FP(xscvspdp, 1, float32, float64, VsrW(0), VsrD(0), 1)
-VSX_CVT_FP_TO_FP(xvcvdpsp, 2, float64, float32, VsrD(i), VsrW(2*i), 0)
-VSX_CVT_FP_TO_FP(xvcvspdp, 2, float32, float64, VsrW(2*i), VsrD(i), 0)
+VSX_CVT_FP_TO_FP(xvcvdpsp, 2, float64, float32, VsrD(i), VsrW(2 * i), 0)
+VSX_CVT_FP_TO_FP(xvcvspdp, 2, float32, float64, VsrW(2 * i), VsrD(i), 0)
=20
-/* VSX_CVT_FP_TO_FP_VECTOR - VSX floating point/floating point conversio=
n
+/*
+ * VSX_CVT_FP_TO_FP_VECTOR - VSX floating point/floating point conversio=
n
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   stp   - source type (float32 or float64)
@@ -2868,7 +2890,8 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)=
                       \
=20
 VSX_CVT_FP_TO_FP_VECTOR(xscvdpqp, 1, float64, float128, VsrD(0), f128, 1=
)
=20
-/* VSX_CVT_FP_TO_FP_HP - VSX floating point/floating point conversion
+/*
+ * VSX_CVT_FP_TO_FP_HP - VSX floating point/floating point conversion
  *                       involving one half precision value
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
@@ -2953,7 +2976,8 @@ uint64_t helper_xscvspdpn(CPUPPCState *env, uint64_=
t xb)
     return float32_to_float64(xb >> 32, &tstat);
 }
=20
-/* VSX_CVT_FP_TO_INT - VSX floating point to integer conversion
+/*
+ * VSX_CVT_FP_TO_INT - VSX floating point to integer conversion
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   stp   - source type (float32 or float64)
@@ -2996,17 +3020,18 @@ VSX_CVT_FP_TO_INT(xscvdpuxds, 1, float64, uint64,=
 VsrD(0), VsrD(0), 0ULL)
 VSX_CVT_FP_TO_INT(xscvdpuxws, 1, float64, uint32, VsrD(0), VsrW(1), 0U)
 VSX_CVT_FP_TO_INT(xvcvdpsxds, 2, float64, int64, VsrD(i), VsrD(i), \
                   0x8000000000000000ULL)
-VSX_CVT_FP_TO_INT(xvcvdpsxws, 2, float64, int32, VsrD(i), VsrW(2*i), \
+VSX_CVT_FP_TO_INT(xvcvdpsxws, 2, float64, int32, VsrD(i), VsrW(2 * i), \
                   0x80000000U)
 VSX_CVT_FP_TO_INT(xvcvdpuxds, 2, float64, uint64, VsrD(i), VsrD(i), 0ULL=
)
-VSX_CVT_FP_TO_INT(xvcvdpuxws, 2, float64, uint32, VsrD(i), VsrW(2*i), 0U=
)
-VSX_CVT_FP_TO_INT(xvcvspsxds, 2, float32, int64, VsrW(2*i), VsrD(i), \
+VSX_CVT_FP_TO_INT(xvcvdpuxws, 2, float64, uint32, VsrD(i), VsrW(2 * i), =
0U)
+VSX_CVT_FP_TO_INT(xvcvspsxds, 2, float32, int64, VsrW(2 * i), VsrD(i), \
                   0x8000000000000000ULL)
 VSX_CVT_FP_TO_INT(xvcvspsxws, 4, float32, int32, VsrW(i), VsrW(i), 0x800=
00000U)
-VSX_CVT_FP_TO_INT(xvcvspuxds, 2, float32, uint64, VsrW(2*i), VsrD(i), 0U=
LL)
+VSX_CVT_FP_TO_INT(xvcvspuxds, 2, float32, uint64, VsrW(2 * i), VsrD(i), =
0ULL)
 VSX_CVT_FP_TO_INT(xvcvspuxws, 4, float32, uint32, VsrW(i), VsrW(i), 0U)
=20
-/* VSX_CVT_FP_TO_INT_VECTOR - VSX floating point to integer conversion
+/*
+ * VSX_CVT_FP_TO_INT_VECTOR - VSX floating point to integer conversion
  *   op    - instruction mnemonic
  *   stp   - source type (float32 or float64)
  *   ttp   - target type (int32, uint32, int64 or uint64)
@@ -3040,7 +3065,8 @@ VSX_CVT_FP_TO_INT_VECTOR(xscvqpswz, float128, int32=
, f128, VsrD(0),          \
 VSX_CVT_FP_TO_INT_VECTOR(xscvqpudz, float128, uint64, f128, VsrD(0), 0x0=
ULL)
 VSX_CVT_FP_TO_INT_VECTOR(xscvqpuwz, float128, uint32, f128, VsrD(0), 0x0=
ULL)
=20
-/* VSX_CVT_INT_TO_FP - VSX integer to floating point conversion
+/*
+ * VSX_CVT_INT_TO_FP - VSX integer to floating point conversion
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   stp   - source type (int32, uint32, int64 or uint64)
@@ -3079,14 +3105,15 @@ VSX_CVT_INT_TO_FP(xscvsxdsp, 1, int64, float64, V=
srD(0), VsrD(0), 1, 1)
 VSX_CVT_INT_TO_FP(xscvuxdsp, 1, uint64, float64, VsrD(0), VsrD(0), 1, 1)
 VSX_CVT_INT_TO_FP(xvcvsxddp, 2, int64, float64, VsrD(i), VsrD(i), 0, 0)
 VSX_CVT_INT_TO_FP(xvcvuxddp, 2, uint64, float64, VsrD(i), VsrD(i), 0, 0)
-VSX_CVT_INT_TO_FP(xvcvsxwdp, 2, int32, float64, VsrW(2*i), VsrD(i), 0, 0=
)
-VSX_CVT_INT_TO_FP(xvcvuxwdp, 2, uint64, float64, VsrW(2*i), VsrD(i), 0, =
0)
-VSX_CVT_INT_TO_FP(xvcvsxdsp, 2, int64, float32, VsrD(i), VsrW(2*i), 0, 0=
)
-VSX_CVT_INT_TO_FP(xvcvuxdsp, 2, uint64, float32, VsrD(i), VsrW(2*i), 0, =
0)
+VSX_CVT_INT_TO_FP(xvcvsxwdp, 2, int32, float64, VsrW(2 * i), VsrD(i), 0,=
 0)
+VSX_CVT_INT_TO_FP(xvcvuxwdp, 2, uint64, float64, VsrW(2 * i), VsrD(i), 0=
, 0)
+VSX_CVT_INT_TO_FP(xvcvsxdsp, 2, int64, float32, VsrD(i), VsrW(2 * i), 0,=
 0)
+VSX_CVT_INT_TO_FP(xvcvuxdsp, 2, uint64, float32, VsrD(i), VsrW(2 * i), 0=
, 0)
 VSX_CVT_INT_TO_FP(xvcvsxwsp, 4, int32, float32, VsrW(i), VsrW(i), 0, 0)
 VSX_CVT_INT_TO_FP(xvcvuxwsp, 4, uint32, float32, VsrW(i), VsrW(i), 0, 0)
=20
-/* VSX_CVT_INT_TO_FP_VECTOR - VSX integer to floating point conversion
+/*
+ * VSX_CVT_INT_TO_FP_VECTOR - VSX integer to floating point conversion
  *   op    - instruction mnemonic
  *   stp   - source type (int32, uint32, int64 or uint64)
  *   ttp   - target type (float32 or float64)
@@ -3111,13 +3138,15 @@ void helper_##op(CPUPPCState *env, uint32_t opcod=
e)                     \
 VSX_CVT_INT_TO_FP_VECTOR(xscvsdqp, int64, float128, VsrD(0), f128)
 VSX_CVT_INT_TO_FP_VECTOR(xscvudqp, uint64, float128, VsrD(0), f128)
=20
-/* For "use current rounding mode", define a value that will not be one =
of
- * the existing rounding model enums.
+/*
+ * For "use current rounding mode", define a value that will not be
+ * one of the existing rounding model enums.
  */
 #define FLOAT_ROUND_CURRENT (float_round_nearest_even + float_round_down=
 + \
   float_round_up + float_round_to_zero)
=20
-/* VSX_ROUND - VSX floating point round
+/*
+ * VSX_ROUND - VSX floating point round
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   tp    - type (float32 or float64)
@@ -3150,9 +3179,11 @@ void helper_##op(CPUPPCState *env, uint32_t opcode=
)                    \
         }                                                              \
     }                                                                  \
                                                                        \
-    /* If this is not a "use current rounding mode" instruction,       \
+    /*                                                                 \
+     * If this is not a "use current rounding mode" instruction,       \
      * then inhibit setting of the XX bit and restore rounding         \
-     * mode from FPSCR */                                              \
+     * mode from FPSCR                                                 \
+     */                                                                \
     if (rmode !=3D FLOAT_ROUND_CURRENT) {                               =
 \
         fpscr_set_rounding_mode(env);                                  \
         env->fp_status.float_exception_flags &=3D ~float_flag_inexact;  =
 \
@@ -3234,7 +3265,8 @@ void helper_xvxsigsp(CPUPPCState *env, uint32_t opc=
ode)
     putVSR(xT(opcode), &xt, env);
 }
=20
-/* VSX_TEST_DC - VSX floating point test data class
+/*
+ * VSX_TEST_DC - VSX floating point test data class
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
  *   xbn   - VSR register number
--=20
2.20.1
