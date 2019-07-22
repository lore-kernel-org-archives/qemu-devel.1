Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D013C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C3B2190F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C3B2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpaPj-0000mN-ER
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 11:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51516)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hpaPJ-0000I5-Ab
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hpaP7-0000Np-7E
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:39:20 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.72]:50223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1hpaP6-0000MY-96
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:39:09 -0400
Received: from tpw09926dag18f.domain1.systemhost.net (10.9.212.26) by
 BWP09926077.bt.com (10.36.82.108) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Mon, 22
 Jul 2019 16:39:00 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18f.domain1.systemhost.net (10.9.212.26) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Mon, 22 Jul 2019 16:39:04 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Mon, 22 Jul
 2019 16:39:04 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 02/20] tcg: Replace MO_16 with MO_UW alias
Thread-Index: AQHVQKOXy8JsjxHtAEearhhy+6Tk1w==
Date: Mon, 22 Jul 2019 15:39:04 +0000
Message-ID: <1563809943304.38271@bt.com>
References: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.37]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.72
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 02/20] tcg: Replace MO_16 with MO_UW
 alias
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, mst@redhat.com,
 palmer@sifive.com, mark.cave-ayland@ilande.co.uk, Alistair.Francis@wdc.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, sw@weilnetz.de, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, david@gibson.dropbear.id.au, qemu-riscv@nongnu.org,
 cohuck@redhat.com, claudio.fontana@huawei.com, alex.williamson@redhat.com,
 qemu-ppc@nongnu.org, amarkovic@wavecomp.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Preparation for splitting MO_16 out from TCGMemOp into new accelerator
independent MemOp.

As MO_16 will be a value of MemOp, existing TCGMemOp comparisons and
coercions will trigger -Wenum-compare and -Wenum-conversion.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 target/arm/sve_helper.c             |   4 +-
 target/arm/translate-a64.c          |  90 ++++++++--------
 target/arm/translate-sve.c          |  40 ++++----
 target/arm/translate-vfp.inc.c      |   2 +-
 target/arm/translate.c              |  32 +++---
 target/i386/translate.c             | 200 ++++++++++++++++++--------------=
----
 target/mips/translate.c             |   2 +-
 target/ppc/translate/vmx-impl.inc.c |  28 ++---
 target/s390x/translate_vx.inc.c     |   2 +-
 target/s390x/vec.h                  |   4 +-
 tcg/aarch64/tcg-target.inc.c        |  20 ++--
 tcg/arm/tcg-target.inc.c            |   6 +-
 tcg/i386/tcg-target.inc.c           |  48 ++++-----
 tcg/mips/tcg-target.inc.c           |   6 +-
 tcg/riscv/tcg-target.inc.c          |   4 +-
 tcg/sparc/tcg-target.inc.c          |   2 +-
 tcg/tcg-op-gvec.c                   |  72 ++++++-------
 tcg/tcg-op-vec.c                    |   2 +-
 tcg/tcg-op.c                        |  18 ++--
 tcg/tcg.h                           |   2 +-
 20 files changed, 292 insertions(+), 292 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4c7e11f..f6bef3d 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1546,7 +1546,7 @@ void HELPER(sve_cpy_m_h)(void *vd, void *vn, void *vg=
,
     uint64_t *d =3D vd, *n =3D vn;
     uint8_t *pg =3D vg;

-    mm =3D dup_const(MO_16, mm);
+    mm =3D dup_const(MO_UW, mm);
     for (i =3D 0; i < opr_sz; i +=3D 1) {
         uint64_t nn =3D n[i];
         uint64_t pp =3D expand_pred_h(pg[H1(i)]);
@@ -1600,7 +1600,7 @@ void HELPER(sve_cpy_z_h)(void *vd, void *vg, uint64_t=
 val, uint32_t desc)
     uint64_t *d =3D vd;
     uint8_t *pg =3D vg;

-    val =3D dup_const(MO_16, val);
+    val =3D dup_const(MO_UW, val);
     for (i =3D 0; i < opr_sz; i +=3D 1) {
         d[i] =3D val & expand_pred_h(pg[H1(i)]);
     }
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f840b43..3acfccb 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -492,7 +492,7 @@ static TCGv_i32 read_fp_hreg(DisasContext *s, int reg)
 {
     TCGv_i32 v =3D tcg_temp_new_i32();

-    tcg_gen_ld16u_i32(v, cpu_env, fp_reg_offset(s, reg, MO_16));
+    tcg_gen_ld16u_i32(v, cpu_env, fp_reg_offset(s, reg, MO_UW));
     return v;
 }

@@ -996,7 +996,7 @@ static void read_vec_element(DisasContext *s, TCGv_i64 =
tcg_dest, int srcidx,
     case MO_UB:
         tcg_gen_ld8u_i64(tcg_dest, cpu_env, vect_off);
         break;
-    case MO_16:
+    case MO_UW:
         tcg_gen_ld16u_i64(tcg_dest, cpu_env, vect_off);
         break;
     case MO_32:
@@ -1005,7 +1005,7 @@ static void read_vec_element(DisasContext *s, TCGv_i6=
4 tcg_dest, int srcidx,
     case MO_SB:
         tcg_gen_ld8s_i64(tcg_dest, cpu_env, vect_off);
         break;
-    case MO_16|MO_SIGN:
+    case MO_SW:
         tcg_gen_ld16s_i64(tcg_dest, cpu_env, vect_off);
         break;
     case MO_32|MO_SIGN:
@@ -1028,13 +1028,13 @@ static void read_vec_element_i32(DisasContext *s, T=
CGv_i32 tcg_dest, int srcidx,
     case MO_UB:
         tcg_gen_ld8u_i32(tcg_dest, cpu_env, vect_off);
         break;
-    case MO_16:
+    case MO_UW:
         tcg_gen_ld16u_i32(tcg_dest, cpu_env, vect_off);
         break;
     case MO_SB:
         tcg_gen_ld8s_i32(tcg_dest, cpu_env, vect_off);
         break;
-    case MO_16|MO_SIGN:
+    case MO_SW:
         tcg_gen_ld16s_i32(tcg_dest, cpu_env, vect_off);
         break;
     case MO_32:
@@ -1055,7 +1055,7 @@ static void write_vec_element(DisasContext *s, TCGv_i=
64 tcg_src, int destidx,
     case MO_UB:
         tcg_gen_st8_i64(tcg_src, cpu_env, vect_off);
         break;
-    case MO_16:
+    case MO_UW:
         tcg_gen_st16_i64(tcg_src, cpu_env, vect_off);
         break;
     case MO_32:
@@ -1077,7 +1077,7 @@ static void write_vec_element_i32(DisasContext *s, TC=
Gv_i32 tcg_src,
     case MO_UB:
         tcg_gen_st8_i32(tcg_src, cpu_env, vect_off);
         break;
-    case MO_16:
+    case MO_UW:
         tcg_gen_st16_i32(tcg_src, cpu_env, vect_off);
         break;
     case MO_32:
@@ -5269,7 +5269,7 @@ static void handle_fp_compare(DisasContext *s, int si=
ze,
                               bool cmp_with_zero, bool signal_all_nans)
 {
     TCGv_i64 tcg_flags =3D tcg_temp_new_i64();
-    TCGv_ptr fpst =3D get_fpstatus_ptr(size =3D=3D MO_16);
+    TCGv_ptr fpst =3D get_fpstatus_ptr(size =3D=3D MO_UW);

     if (size =3D=3D MO_64) {
         TCGv_i64 tcg_vn, tcg_vm;
@@ -5306,7 +5306,7 @@ static void handle_fp_compare(DisasContext *s, int si=
ze,
                 gen_helper_vfp_cmps_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
             }
             break;
-        case MO_16:
+        case MO_UW:
             if (signal_all_nans) {
                 gen_helper_vfp_cmpeh_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
             } else {
@@ -5360,7 +5360,7 @@ static void disas_fp_compare(DisasContext *s, uint32_=
t insn)
         size =3D MO_64;
         break;
     case 3:
-        size =3D MO_16;
+        size =3D MO_UW;
         if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
@@ -5411,7 +5411,7 @@ static void disas_fp_ccomp(DisasContext *s, uint32_t =
insn)
         size =3D MO_64;
         break;
     case 3:
-        size =3D MO_16;
+        size =3D MO_UW;
         if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
@@ -5477,7 +5477,7 @@ static void disas_fp_csel(DisasContext *s, uint32_t i=
nsn)
         sz =3D MO_64;
         break;
     case 3:
-        sz =3D MO_16;
+        sz =3D MO_UW;
         if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
@@ -6282,7 +6282,7 @@ static void disas_fp_imm(DisasContext *s, uint32_t in=
sn)
         sz =3D MO_64;
         break;
     case 3:
-        sz =3D MO_16;
+        sz =3D MO_UW;
         if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
@@ -6593,7 +6593,7 @@ static void handle_fmov(DisasContext *s, int rd, int =
rn, int type, bool itof)
             break;
         case 3:
             /* 16 bit */
-            tcg_gen_ld16u_i64(tcg_rd, cpu_env, fp_reg_offset(s, rn, MO_16)=
);
+            tcg_gen_ld16u_i64(tcg_rd, cpu_env, fp_reg_offset(s, rn, MO_UW)=
);
             break;
         default:
             g_assert_not_reached();
@@ -7030,7 +7030,7 @@ static TCGv_i32 do_reduction_op(DisasContext *s, int =
fpopcode, int rn,
 {
     if (esize =3D=3D size) {
         int element;
-        TCGMemOp msize =3D esize =3D=3D 16 ? MO_16 : MO_32;
+        TCGMemOp msize =3D esize =3D=3D 16 ? MO_UW : MO_32;
         TCGv_i32 tcg_elem;

         /* We should have one register left here */
@@ -7204,7 +7204,7 @@ static void disas_simd_across_lanes(DisasContext *s, =
uint32_t insn)
          * Note that correct NaN propagation requires that we do these
          * operations in exactly the order specified by the pseudocode.
          */
-        TCGv_ptr fpst =3D get_fpstatus_ptr(size =3D=3D MO_16);
+        TCGv_ptr fpst =3D get_fpstatus_ptr(size =3D=3D MO_UW);
         int fpopcode =3D opcode | is_min << 4 | is_u << 5;
         int vmap =3D (1 << elements) - 1;
         TCGv_i32 tcg_res32 =3D do_reduction_op(s, fpopcode, rn, esize,
@@ -7591,7 +7591,7 @@ static void disas_simd_mod_imm(DisasContext *s, uint3=
2_t insn)
             } else {
                 if (o2) {
                     /* FMOV (vector, immediate) - half-precision */
-                    imm =3D vfp_expand_imm(MO_16, abcdefgh);
+                    imm =3D vfp_expand_imm(MO_UW, abcdefgh);
                     /* now duplicate across the lanes */
                     imm =3D bitfield_replicate(imm, 16);
                 } else {
@@ -7699,7 +7699,7 @@ static void disas_simd_scalar_pairwise(DisasContext *=
s, uint32_t insn)
                 unallocated_encoding(s);
                 return;
             } else {
-                size =3D MO_16;
+                size =3D MO_UW;
             }
         } else {
             size =3D extract32(size, 0, 1) ? MO_64 : MO_32;
@@ -7709,7 +7709,7 @@ static void disas_simd_scalar_pairwise(DisasContext *=
s, uint32_t insn)
             return;
         }

-        fpst =3D get_fpstatus_ptr(size =3D=3D MO_16);
+        fpst =3D get_fpstatus_ptr(size =3D=3D MO_UW);
         break;
     default:
         unallocated_encoding(s);
@@ -7760,7 +7760,7 @@ static void disas_simd_scalar_pairwise(DisasContext *=
s, uint32_t insn)
         read_vec_element_i32(s, tcg_op1, rn, 0, size);
         read_vec_element_i32(s, tcg_op2, rn, 1, size);

-        if (size =3D=3D MO_16) {
+        if (size =3D=3D MO_UW) {
             switch (opcode) {
             case 0xc: /* FMAXNMP */
                 gen_helper_advsimd_maxnumh(tcg_res, tcg_op1, tcg_op2, fpst=
);
@@ -8222,7 +8222,7 @@ static void handle_simd_intfp_conv(DisasContext *s, i=
nt rd, int rn,
                                    int elements, int is_signed,
                                    int fracbits, int size)
 {
-    TCGv_ptr tcg_fpst =3D get_fpstatus_ptr(size =3D=3D MO_16);
+    TCGv_ptr tcg_fpst =3D get_fpstatus_ptr(size =3D=3D MO_UW);
     TCGv_i32 tcg_shift =3D NULL;

     TCGMemOp mop =3D size | (is_signed ? MO_SIGN : 0);
@@ -8281,7 +8281,7 @@ static void handle_simd_intfp_conv(DisasContext *s, i=
nt rd, int rn,
                     }
                 }
                 break;
-            case MO_16:
+            case MO_UW:
                 if (fracbits) {
                     if (is_signed) {
                         gen_helper_vfp_sltoh(tcg_float, tcg_int32,
@@ -8339,7 +8339,7 @@ static void handle_simd_shift_intfp_conv(DisasContext=
 *s, bool is_scalar,
     } else if (immh & 4) {
         size =3D MO_32;
     } else if (immh & 2) {
-        size =3D MO_16;
+        size =3D MO_UW;
         if (!dc_isar_feature(aa64_fp16, s)) {
             unallocated_encoding(s);
             return;
@@ -8384,7 +8384,7 @@ static void handle_simd_shift_fpint_conv(DisasContext=
 *s, bool is_scalar,
     } else if (immh & 0x4) {
         size =3D MO_32;
     } else if (immh & 0x2) {
-        size =3D MO_16;
+        size =3D MO_UW;
         if (!dc_isar_feature(aa64_fp16, s)) {
             unallocated_encoding(s);
             return;
@@ -8403,7 +8403,7 @@ static void handle_simd_shift_fpint_conv(DisasContext=
 *s, bool is_scalar,
     assert(!(is_scalar && is_q));

     tcg_rmode =3D tcg_const_i32(arm_rmode_to_sf(FPROUNDING_ZERO));
-    tcg_fpstatus =3D get_fpstatus_ptr(size =3D=3D MO_16);
+    tcg_fpstatus =3D get_fpstatus_ptr(size =3D=3D MO_UW);
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
     fracbits =3D (16 << size) - immhb;
     tcg_shift =3D tcg_const_i32(fracbits);
@@ -8429,7 +8429,7 @@ static void handle_simd_shift_fpint_conv(DisasContext=
 *s, bool is_scalar,
         int maxpass =3D is_scalar ? 1 : ((8 << is_q) >> size);

         switch (size) {
-        case MO_16:
+        case MO_UW:
             if (is_u) {
                 fn =3D gen_helper_vfp_touhh;
             } else {
@@ -9388,7 +9388,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, i=
nt opcode,
         return;
     }

-    fpst =3D get_fpstatus_ptr(size =3D=3D MO_16);
+    fpst =3D get_fpstatus_ptr(size =3D=3D MO_UW);

     if (is_double) {
         TCGv_i64 tcg_op =3D tcg_temp_new_i64();
@@ -9440,7 +9440,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, i=
nt opcode,
         bool swap =3D false;
         int pass, maxpasses;

-        if (size =3D=3D MO_16) {
+        if (size =3D=3D MO_UW) {
             switch (opcode) {
             case 0x2e: /* FCMLT (zero) */
                 swap =3D true;
@@ -11422,8 +11422,8 @@ static void disas_simd_three_reg_same_fp16(DisasCon=
text *s, uint32_t insn)
             int passreg =3D pass < (maxpass / 2) ? rn : rm;
             int passelt =3D (pass << 1) & (maxpass - 1);

-            read_vec_element_i32(s, tcg_op1, passreg, passelt, MO_16);
-            read_vec_element_i32(s, tcg_op2, passreg, passelt + 1, MO_16);
+            read_vec_element_i32(s, tcg_op1, passreg, passelt, MO_UW);
+            read_vec_element_i32(s, tcg_op2, passreg, passelt + 1, MO_UW);
             tcg_res[pass] =3D tcg_temp_new_i32();

             switch (fpopcode) {
@@ -11450,7 +11450,7 @@ static void disas_simd_three_reg_same_fp16(DisasCon=
text *s, uint32_t insn)
         }

         for (pass =3D 0; pass < maxpass; pass++) {
-            write_vec_element_i32(s, tcg_res[pass], rd, pass, MO_16);
+            write_vec_element_i32(s, tcg_res[pass], rd, pass, MO_UW);
             tcg_temp_free_i32(tcg_res[pass]);
         }

@@ -11463,15 +11463,15 @@ static void disas_simd_three_reg_same_fp16(DisasC=
ontext *s, uint32_t insn)
             TCGv_i32 tcg_op2 =3D tcg_temp_new_i32();
             TCGv_i32 tcg_res =3D tcg_temp_new_i32();

-            read_vec_element_i32(s, tcg_op1, rn, pass, MO_16);
-            read_vec_element_i32(s, tcg_op2, rm, pass, MO_16);
+            read_vec_element_i32(s, tcg_op1, rn, pass, MO_UW);
+            read_vec_element_i32(s, tcg_op2, rm, pass, MO_UW);

             switch (fpopcode) {
             case 0x0: /* FMAXNM */
                 gen_helper_advsimd_maxnumh(tcg_res, tcg_op1, tcg_op2, fpst=
);
                 break;
             case 0x1: /* FMLA */
-                read_vec_element_i32(s, tcg_res, rd, pass, MO_16);
+                read_vec_element_i32(s, tcg_res, rd, pass, MO_UW);
                 gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_=
res,
                                            fpst);
                 break;
@@ -11496,7 +11496,7 @@ static void disas_simd_three_reg_same_fp16(DisasCon=
text *s, uint32_t insn)
             case 0x9: /* FMLS */
                 /* As usual for ARM, separate negation for fused multiply-=
add */
                 tcg_gen_xori_i32(tcg_op1, tcg_op1, 0x8000);
-                read_vec_element_i32(s, tcg_res, rd, pass, MO_16);
+                read_vec_element_i32(s, tcg_res, rd, pass, MO_UW);
                 gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_=
res,
                                            fpst);
                 break;
@@ -11537,7 +11537,7 @@ static void disas_simd_three_reg_same_fp16(DisasCon=
text *s, uint32_t insn)
                 g_assert_not_reached();
             }

-            write_vec_element_i32(s, tcg_res, rd, pass, MO_16);
+            write_vec_element_i32(s, tcg_res, rd, pass, MO_UW);
             tcg_temp_free_i32(tcg_res);
             tcg_temp_free_i32(tcg_op1);
             tcg_temp_free_i32(tcg_op2);
@@ -11727,7 +11727,7 @@ static void handle_2misc_widening(DisasContext *s, =
int opcode, bool is_q,
         for (pass =3D 0; pass < 4; pass++) {
             tcg_res[pass] =3D tcg_temp_new_i32();

-            read_vec_element_i32(s, tcg_res[pass], rn, srcelt + pass, MO_1=
6);
+            read_vec_element_i32(s, tcg_res[pass], rn, srcelt + pass, MO_U=
W);
             gen_helper_vfp_fcvt_f16_to_f32(tcg_res[pass], tcg_res[pass],
                                            fpst, ahp);
         }
@@ -11768,7 +11768,7 @@ static void handle_rev(DisasContext *s, int opcode,=
 bool u,

             read_vec_element(s, tcg_tmp, rn, i, grp_size);
             switch (grp_size) {
-            case MO_16:
+            case MO_UW:
                 tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
                 break;
             case MO_32:
@@ -12499,7 +12499,7 @@ static void disas_simd_two_reg_misc_fp16(DisasConte=
xt *s, uint32_t insn)
         if (!fp_access_check(s)) {
             return;
         }
-        handle_simd_intfp_conv(s, rd, rn, elements, !u, 0, MO_16);
+        handle_simd_intfp_conv(s, rd, rn, elements, !u, 0, MO_UW);
         return;
     }
     break;
@@ -12508,7 +12508,7 @@ static void disas_simd_two_reg_misc_fp16(DisasConte=
xt *s, uint32_t insn)
     case 0x2e: /* FCMLT (zero) */
     case 0x6c: /* FCMGE (zero) */
     case 0x6d: /* FCMLE (zero) */
-        handle_2misc_fcmp_zero(s, fpop, is_scalar, 0, is_q, MO_16, rn, rd)=
;
+        handle_2misc_fcmp_zero(s, fpop, is_scalar, 0, is_q, MO_UW, rn, rd)=
;
         return;
     case 0x3d: /* FRECPE */
     case 0x3f: /* FRECPX */
@@ -12668,7 +12668,7 @@ static void disas_simd_two_reg_misc_fp16(DisasConte=
xt *s, uint32_t insn)
             TCGv_i32 tcg_op =3D tcg_temp_new_i32();
             TCGv_i32 tcg_res =3D tcg_temp_new_i32();

-            read_vec_element_i32(s, tcg_op, rn, pass, MO_16);
+            read_vec_element_i32(s, tcg_op, rn, pass, MO_UW);

             switch (fpop) {
             case 0x1a: /* FCVTNS */
@@ -12715,7 +12715,7 @@ static void disas_simd_two_reg_misc_fp16(DisasConte=
xt *s, uint32_t insn)
                 g_assert_not_reached();
             }

-            write_vec_element_i32(s, tcg_res, rd, pass, MO_16);
+            write_vec_element_i32(s, tcg_res, rd, pass, MO_UW);

             tcg_temp_free_i32(tcg_res);
             tcg_temp_free_i32(tcg_op);
@@ -12839,7 +12839,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
             unallocated_encoding(s);
             return;
         }
-        size =3D MO_16;
+        size =3D MO_UW;
         /* is_fp, but we pass cpu_env not fp_status.  */
         break;
     default:
@@ -12852,7 +12852,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
         /* convert insn encoded size to TCGMemOp size */
         switch (size) {
         case 0: /* half-precision */
-            size =3D MO_16;
+            size =3D MO_UW;
             is_fp16 =3D true;
             break;
         case MO_32: /* single precision */
@@ -12899,7 +12899,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)

     /* Given TCGMemOp size, adjust register and indexing.  */
     switch (size) {
-    case MO_16:
+    case MO_UW:
         index =3D h << 2 | l << 1 | m;
         break;
     case MO_32:
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ec5fb11..2bc1bd1 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -1679,7 +1679,7 @@ static void do_sat_addsub_vec(DisasContext *s, int es=
z, int rd, int rn,
         tcg_temp_free_i32(t32);
         break;

-    case MO_16:
+    case MO_UW:
         t32 =3D tcg_temp_new_i32();
         tcg_gen_extrl_i64_i32(t32, val);
         if (d) {
@@ -3314,7 +3314,7 @@ static bool trans_SUBR_zzi(DisasContext *s, arg_rri_e=
sz *a)
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_sve_subri_h,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16,
+          .vece =3D MO_UW,
           .scalar_first =3D true },
         { .fni4 =3D tcg_gen_sub_i32,
           .fniv =3D tcg_gen_sub_vec,
@@ -3468,7 +3468,7 @@ static bool trans_FMLA_zzxz(DisasContext *s, arg_FMLA=
_zzxz *a)

     if (sve_access_check(s)) {
         unsigned vsz =3D vec_full_reg_size(s);
-        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
+        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_UW);
         tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3494,7 +3494,7 @@ static bool trans_FMUL_zzx(DisasContext *s, arg_FMUL_=
zzx *a)

     if (sve_access_check(s)) {
         unsigned vsz =3D vec_full_reg_size(s);
-        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
+        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_UW);
         tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3526,7 +3526,7 @@ static void do_reduce(DisasContext *s, arg_rpr_esz *a=
,

     tcg_gen_addi_ptr(t_zn, cpu_env, vec_full_reg_offset(s, a->rn));
     tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, a->pg));
-    status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
+    status =3D get_fpstatus_ptr(a->esz =3D=3D MO_UW);

     fn(temp, t_zn, t_pg, status, t_desc);
     tcg_temp_free_ptr(t_zn);
@@ -3568,7 +3568,7 @@ DO_VPZ(FMAXV, fmaxv)
 static void do_zz_fp(DisasContext *s, arg_rr_esz *a, gen_helper_gvec_2_ptr=
 *fn)
 {
     unsigned vsz =3D vec_full_reg_size(s);
-    TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
+    TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_UW);

     tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->rd),
                        vec_full_reg_offset(s, a->rn),
@@ -3616,7 +3616,7 @@ static void do_ppz_fp(DisasContext *s, arg_rpr_esz *a=
,
                       gen_helper_gvec_3_ptr *fn)
 {
     unsigned vsz =3D vec_full_reg_size(s);
-    TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
+    TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_UW);

     tcg_gen_gvec_3_ptr(pred_full_reg_offset(s, a->rd),
                        vec_full_reg_offset(s, a->rn),
@@ -3668,7 +3668,7 @@ static bool trans_FTMAD(DisasContext *s, arg_FTMAD *a=
)
     }
     if (sve_access_check(s)) {
         unsigned vsz =3D vec_full_reg_size(s);
-        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
+        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_UW);
         tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3708,7 +3708,7 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz=
 *a)
     t_pg =3D tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_rm, cpu_env, vec_full_reg_offset(s, a->rm));
     tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, a->pg));
-    t_fpst =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
+    t_fpst =3D get_fpstatus_ptr(a->esz =3D=3D MO_UW);
     t_desc =3D tcg_const_i32(simd_desc(vsz, vsz, 0));

     fns[a->esz - 1](t_val, t_val, t_rm, t_pg, t_fpst, t_desc);
@@ -3735,7 +3735,7 @@ static bool do_zzz_fp(DisasContext *s, arg_rrr_esz *a=
,
     }
     if (sve_access_check(s)) {
         unsigned vsz =3D vec_full_reg_size(s);
-        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
+        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_UW);
         tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3777,7 +3777,7 @@ static bool do_zpzz_fp(DisasContext *s, arg_rprr_esz =
*a,
     }
     if (sve_access_check(s)) {
         unsigned vsz =3D vec_full_reg_size(s);
-        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
+        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_UW);
         tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3844,7 +3844,7 @@ static void do_fp_imm(DisasContext *s, arg_rpri_esz *=
a, uint64_t imm,
                       gen_helper_sve_fp2scalar *fn)
 {
     TCGv_i64 temp =3D tcg_const_i64(imm);
-    do_fp_scalar(s, a->rd, a->rn, a->pg, a->esz =3D=3D MO_16, temp, fn);
+    do_fp_scalar(s, a->rd, a->rn, a->pg, a->esz =3D=3D MO_UW, temp, fn);
     tcg_temp_free_i64(temp);
 }

@@ -3893,7 +3893,7 @@ static bool do_fp_cmp(DisasContext *s, arg_rprr_esz *=
a,
     }
     if (sve_access_check(s)) {
         unsigned vsz =3D vec_full_reg_size(s);
-        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
+        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_UW);
         tcg_gen_gvec_4_ptr(pred_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3937,7 +3937,7 @@ static bool trans_FCADD(DisasContext *s, arg_FCADD *a=
)
     }
     if (sve_access_check(s)) {
         unsigned vsz =3D vec_full_reg_size(s);
-        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
+        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_UW);
         tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -4044,7 +4044,7 @@ static bool trans_FCMLA_zzxz(DisasContext *s, arg_FCM=
LA_zzxz *a)
     tcg_debug_assert(a->rd =3D=3D a->ra);
     if (sve_access_check(s)) {
         unsigned vsz =3D vec_full_reg_size(s);
-        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
+        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_UW);
         tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -4186,7 +4186,7 @@ static bool trans_FRINTI(DisasContext *s, arg_rpr_esz=
 *a)
     if (a->esz =3D=3D 0) {
         return false;
     }
-    return do_zpz_ptr(s, a->rd, a->rn, a->pg, a->esz =3D=3D MO_16,
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, a->esz =3D=3D MO_UW,
                       frint_fns[a->esz - 1]);
 }

@@ -4200,7 +4200,7 @@ static bool trans_FRINTX(DisasContext *s, arg_rpr_esz=
 *a)
     if (a->esz =3D=3D 0) {
         return false;
     }
-    return do_zpz_ptr(s, a->rd, a->rn, a->pg, a->esz =3D=3D MO_16, fns[a->=
esz - 1]);
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, a->esz =3D=3D MO_UW, fns[a->=
esz - 1]);
 }

 static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a, int mode)
@@ -4211,7 +4211,7 @@ static bool do_frint_mode(DisasContext *s, arg_rpr_es=
z *a, int mode)
     if (sve_access_check(s)) {
         unsigned vsz =3D vec_full_reg_size(s);
         TCGv_i32 tmode =3D tcg_const_i32(mode);
-        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
+        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_UW);

         gen_helper_set_rmode(tmode, tmode, status);

@@ -4262,7 +4262,7 @@ static bool trans_FRECPX(DisasContext *s, arg_rpr_esz=
 *a)
     if (a->esz =3D=3D 0) {
         return false;
     }
-    return do_zpz_ptr(s, a->rd, a->rn, a->pg, a->esz =3D=3D MO_16, fns[a->=
esz - 1]);
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, a->esz =3D=3D MO_UW, fns[a->=
esz - 1]);
 }

 static bool trans_FSQRT(DisasContext *s, arg_rpr_esz *a)
@@ -4275,7 +4275,7 @@ static bool trans_FSQRT(DisasContext *s, arg_rpr_esz =
*a)
     if (a->esz =3D=3D 0) {
         return false;
     }
-    return do_zpz_ptr(s, a->rd, a->rn, a->pg, a->esz =3D=3D MO_16, fns[a->=
esz - 1]);
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, a->esz =3D=3D MO_UW, fns[a->=
esz - 1]);
 }

 static bool trans_SCVTF_hh(DisasContext *s, arg_rpr_esz *a)
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.=
c
index 092eb5e..549874c 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -52,7 +52,7 @@ uint64_t vfp_expand_imm(int size, uint8_t imm8)
             (extract32(imm8, 0, 6) << 3);
         imm <<=3D 16;
         break;
-    case MO_16:
+    case MO_UW:
         imm =3D (extract32(imm8, 7, 1) ? 0x8000 : 0) |
             (extract32(imm8, 6, 1) ? 0x3000 : 0x4000) |
             (extract32(imm8, 0, 6) << 6);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 39266cf..8d10922 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1477,7 +1477,7 @@ static void neon_store_element(int reg, int ele, TCGM=
emOp size, TCGv_i32 var)
     case MO_UB:
         tcg_gen_st8_i32(var, cpu_env, offset);
         break;
-    case MO_16:
+    case MO_UW:
         tcg_gen_st16_i32(var, cpu_env, offset);
         break;
     case MO_32:
@@ -1496,7 +1496,7 @@ static void neon_store_element64(int reg, int ele, TC=
GMemOp size, TCGv_i64 var)
     case MO_UB:
         tcg_gen_st8_i64(var, cpu_env, offset);
         break;
-    case MO_16:
+    case MO_UW:
         tcg_gen_st16_i64(var, cpu_env, offset);
         break;
     case MO_32:
@@ -4267,7 +4267,7 @@ const GVecGen2i ssra_op[4] =3D {
       .fniv =3D gen_ssra_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_ssra,
-      .vece =3D MO_16 },
+      .vece =3D MO_UW },
     { .fni4 =3D gen_ssra32_i32,
       .fniv =3D gen_ssra_vec,
       .load_dest =3D true,
@@ -4325,7 +4325,7 @@ const GVecGen2i usra_op[4] =3D {
       .fniv =3D gen_usra_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_usra,
-      .vece =3D MO_16, },
+      .vece =3D MO_UW, },
     { .fni4 =3D gen_usra32_i32,
       .fniv =3D gen_usra_vec,
       .load_dest =3D true,
@@ -4353,7 +4353,7 @@ static void gen_shr8_ins_i64(TCGv_i64 d, TCGv_i64 a, =
int64_t shift)

 static void gen_shr16_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
-    uint64_t mask =3D dup_const(MO_16, 0xffff >> shift);
+    uint64_t mask =3D dup_const(MO_UW, 0xffff >> shift);
     TCGv_i64 t =3D tcg_temp_new_i64();

     tcg_gen_shri_i64(t, a, shift);
@@ -4405,7 +4405,7 @@ const GVecGen2i sri_op[4] =3D {
       .fniv =3D gen_shr_ins_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_sri,
-      .vece =3D MO_16 },
+      .vece =3D MO_UW },
     { .fni4 =3D gen_shr32_ins_i32,
       .fniv =3D gen_shr_ins_vec,
       .load_dest =3D true,
@@ -4433,7 +4433,7 @@ static void gen_shl8_ins_i64(TCGv_i64 d, TCGv_i64 a, =
int64_t shift)

 static void gen_shl16_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
-    uint64_t mask =3D dup_const(MO_16, 0xffff << shift);
+    uint64_t mask =3D dup_const(MO_UW, 0xffff << shift);
     TCGv_i64 t =3D tcg_temp_new_i64();

     tcg_gen_shli_i64(t, a, shift);
@@ -4483,7 +4483,7 @@ const GVecGen2i sli_op[4] =3D {
       .fniv =3D gen_shl_ins_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_sli,
-      .vece =3D MO_16 },
+      .vece =3D MO_UW },
     { .fni4 =3D gen_shl32_ins_i32,
       .fniv =3D gen_shl_ins_vec,
       .load_dest =3D true,
@@ -4579,7 +4579,7 @@ const GVecGen3 mla_op[4] =3D {
       .fniv =3D gen_mla_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_mla,
-      .vece =3D MO_16 },
+      .vece =3D MO_UW },
     { .fni4 =3D gen_mla32_i32,
       .fniv =3D gen_mla_vec,
       .load_dest =3D true,
@@ -4603,7 +4603,7 @@ const GVecGen3 mls_op[4] =3D {
       .fniv =3D gen_mls_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_mls,
-      .vece =3D MO_16 },
+      .vece =3D MO_UW },
     { .fni4 =3D gen_mls32_i32,
       .fniv =3D gen_mls_vec,
       .load_dest =3D true,
@@ -4649,7 +4649,7 @@ const GVecGen3 cmtst_op[4] =3D {
     { .fni4 =3D gen_helper_neon_tst_u16,
       .fniv =3D gen_cmtst_vec,
       .opt_opc =3D vecop_list_cmtst,
-      .vece =3D MO_16 },
+      .vece =3D MO_UW },
     { .fni4 =3D gen_cmtst_i32,
       .fniv =3D gen_cmtst_vec,
       .opt_opc =3D vecop_list_cmtst,
@@ -4686,7 +4686,7 @@ const GVecGen4 uqadd_op[4] =3D {
       .fno =3D gen_helper_gvec_uqadd_h,
       .write_aofs =3D true,
       .opt_opc =3D vecop_list_uqadd,
-      .vece =3D MO_16 },
+      .vece =3D MO_UW },
     { .fniv =3D gen_uqadd_vec,
       .fno =3D gen_helper_gvec_uqadd_s,
       .write_aofs =3D true,
@@ -4724,7 +4724,7 @@ const GVecGen4 sqadd_op[4] =3D {
       .fno =3D gen_helper_gvec_sqadd_h,
       .opt_opc =3D vecop_list_sqadd,
       .write_aofs =3D true,
-      .vece =3D MO_16 },
+      .vece =3D MO_UW },
     { .fniv =3D gen_sqadd_vec,
       .fno =3D gen_helper_gvec_sqadd_s,
       .opt_opc =3D vecop_list_sqadd,
@@ -4762,7 +4762,7 @@ const GVecGen4 uqsub_op[4] =3D {
       .fno =3D gen_helper_gvec_uqsub_h,
       .opt_opc =3D vecop_list_uqsub,
       .write_aofs =3D true,
-      .vece =3D MO_16 },
+      .vece =3D MO_UW },
     { .fniv =3D gen_uqsub_vec,
       .fno =3D gen_helper_gvec_uqsub_s,
       .opt_opc =3D vecop_list_uqsub,
@@ -4800,7 +4800,7 @@ const GVecGen4 sqsub_op[4] =3D {
       .fno =3D gen_helper_gvec_sqsub_h,
       .opt_opc =3D vecop_list_sqsub,
       .write_aofs =3D true,
-      .vece =3D MO_16 },
+      .vece =3D MO_UW },
     { .fniv =3D gen_sqsub_vec,
       .fno =3D gen_helper_gvec_sqsub_s,
       .opt_opc =3D vecop_list_sqsub,
@@ -6876,7 +6876,7 @@ static int disas_neon_data_insn(DisasContext *s, uint=
32_t insn)
                     size =3D MO_UB;
                     element =3D (insn >> 17) & 7;
                 } else if (insn & (1 << 17)) {
-                    size =3D MO_16;
+                    size =3D MO_UW;
                     element =3D (insn >> 18) & 3;
                 } else {
                     size =3D MO_32;
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 0e45300..0535bae 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -323,7 +323,7 @@ static inline bool byte_reg_is_xH(DisasContext *s, int =
reg)
 static inline TCGMemOp mo_pushpop(DisasContext *s, TCGMemOp ot)
 {
     if (CODE64(s)) {
-        return ot =3D=3D MO_16 ? MO_16 : MO_64;
+        return ot =3D=3D MO_UW ? MO_UW : MO_64;
     } else {
         return ot;
     }
@@ -332,7 +332,7 @@ static inline TCGMemOp mo_pushpop(DisasContext *s, TCGM=
emOp ot)
 /* Select the size of the stack pointer.  */
 static inline TCGMemOp mo_stacksize(DisasContext *s)
 {
-    return CODE64(s) ? MO_64 : s->ss32 ? MO_32 : MO_16;
+    return CODE64(s) ? MO_64 : s->ss32 ? MO_32 : MO_UW;
 }

 /* Select only size 64 else 32.  Used for SSE operand sizes.  */
@@ -356,7 +356,7 @@ static inline TCGMemOp mo_b_d(int b, TCGMemOp ot)
    Used for decoding operand size of port opcodes.  */
 static inline TCGMemOp mo_b_d32(int b, TCGMemOp ot)
 {
-    return b & 1 ? (ot =3D=3D MO_16 ? MO_16 : MO_32) : MO_UB;
+    return b & 1 ? (ot =3D=3D MO_UW ? MO_UW : MO_32) : MO_UB;
 }

 static void gen_op_mov_reg_v(DisasContext *s, TCGMemOp ot, int reg, TCGv t=
0)
@@ -369,7 +369,7 @@ static void gen_op_mov_reg_v(DisasContext *s, TCGMemOp =
ot, int reg, TCGv t0)
             tcg_gen_deposit_tl(cpu_regs[reg - 4], cpu_regs[reg - 4], t0, 8=
, 8);
         }
         break;
-    case MO_16:
+    case MO_UW:
         tcg_gen_deposit_tl(cpu_regs[reg], cpu_regs[reg], t0, 0, 16);
         break;
     case MO_32:
@@ -473,7 +473,7 @@ static void gen_lea_v_seg(DisasContext *s, TCGMemOp afl=
ag, TCGv a0,
             return;
         }
         break;
-    case MO_16:
+    case MO_UW:
         /* 16 bit address */
         tcg_gen_ext16u_tl(s->A0, a0);
         a0 =3D s->A0;
@@ -530,7 +530,7 @@ static TCGv gen_ext_tl(TCGv dst, TCGv src, TCGMemOp siz=
e, bool sign)
             tcg_gen_ext8u_tl(dst, src);
         }
         return dst;
-    case MO_16:
+    case MO_UW:
         if (sign) {
             tcg_gen_ext16s_tl(dst, src);
         } else {
@@ -583,7 +583,7 @@ static void gen_helper_in_func(TCGMemOp ot, TCGv v, TCG=
v_i32 n)
     case MO_UB:
         gen_helper_inb(v, cpu_env, n);
         break;
-    case MO_16:
+    case MO_UW:
         gen_helper_inw(v, cpu_env, n);
         break;
     case MO_32:
@@ -600,7 +600,7 @@ static void gen_helper_out_func(TCGMemOp ot, TCGv_i32 v=
, TCGv_i32 n)
     case MO_UB:
         gen_helper_outb(cpu_env, v, n);
         break;
-    case MO_16:
+    case MO_UW:
         gen_helper_outw(cpu_env, v, n);
         break;
     case MO_32:
@@ -622,7 +622,7 @@ static void gen_check_io(DisasContext *s, TCGMemOp ot, =
target_ulong cur_eip,
         case MO_UB:
             gen_helper_check_iob(cpu_env, s->tmp2_i32);
             break;
-        case MO_16:
+        case MO_UW:
             gen_helper_check_iow(cpu_env, s->tmp2_i32);
             break;
         case MO_32:
@@ -1562,7 +1562,7 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp o=
t, int op1, int is_right)
         tcg_gen_ext8u_tl(s->T0, s->T0);
         tcg_gen_muli_tl(s->T0, s->T0, 0x01010101);
         goto do_long;
-    case MO_16:
+    case MO_UW:
         /* Replicate the 16-bit input so that a 32-bit rotate works.  */
         tcg_gen_deposit_tl(s->T0, s->T0, s->T0, 16, 16);
         goto do_long;
@@ -1664,7 +1664,7 @@ static void gen_rot_rm_im(DisasContext *s, TCGMemOp o=
t, int op1, int op2,
         case MO_UB:
             mask =3D 7;
             goto do_shifts;
-        case MO_16:
+        case MO_UW:
             mask =3D 15;
         do_shifts:
             shift =3D op2 & mask;
@@ -1722,7 +1722,7 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMemOp =
ot, int op1,
         case MO_UB:
             gen_helper_rcrb(s->T0, cpu_env, s->T0, s->T1);
             break;
-        case MO_16:
+        case MO_UW:
             gen_helper_rcrw(s->T0, cpu_env, s->T0, s->T1);
             break;
         case MO_32:
@@ -1741,7 +1741,7 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMemOp =
ot, int op1,
         case MO_UB:
             gen_helper_rclb(s->T0, cpu_env, s->T0, s->T1);
             break;
-        case MO_16:
+        case MO_UW:
             gen_helper_rclw(s->T0, cpu_env, s->T0, s->T1);
             break;
         case MO_32:
@@ -1778,7 +1778,7 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMemO=
p ot, int op1,
     tcg_gen_andi_tl(count, count_in, mask);

     switch (ot) {
-    case MO_16:
+    case MO_UW:
         /* Note: we implement the Intel behaviour for shift count > 16.
            This means "shrdw C, B, A" shifts A:B:A >> C.  Build the B:A
            portion by constructing it as a 32-bit value.  */
@@ -1817,7 +1817,7 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMemO=
p ot, int op1,
             tcg_gen_shl_tl(s->T1, s->T1, s->tmp4);
         } else {
             tcg_gen_shl_tl(s->tmp0, s->T0, s->tmp0);
-            if (ot =3D=3D MO_16) {
+            if (ot =3D=3D MO_UW) {
                 /* Only needed if count > 16, for Intel behaviour.  */
                 tcg_gen_subfi_tl(s->tmp4, 33, count);
                 tcg_gen_shr_tl(s->tmp4, s->T1, s->tmp4);
@@ -2026,7 +2026,7 @@ static AddressParts gen_lea_modrm_0(CPUX86State *env,=
 DisasContext *s,
         }
         break;

-    case MO_16:
+    case MO_UW:
         if (mod =3D=3D 0) {
             if (rm =3D=3D 6) {
                 base =3D -1;
@@ -2187,7 +2187,7 @@ static inline uint32_t insn_get(CPUX86State *env, Dis=
asContext *s, TCGMemOp ot)
     case MO_UB:
         ret =3D x86_ldub_code(env, s);
         break;
-    case MO_16:
+    case MO_UW:
         ret =3D x86_lduw_code(env, s);
         break;
     case MO_32:
@@ -2400,12 +2400,12 @@ static inline void gen_pop_update(DisasContext *s, =
TCGMemOp ot)

 static inline void gen_stack_A0(DisasContext *s)
 {
-    gen_lea_v_seg(s, s->ss32 ? MO_32 : MO_16, cpu_regs[R_ESP], R_SS, -1);
+    gen_lea_v_seg(s, s->ss32 ? MO_32 : MO_UW, cpu_regs[R_ESP], R_SS, -1);
 }

 static void gen_pusha(DisasContext *s)
 {
-    TCGMemOp s_ot =3D s->ss32 ? MO_32 : MO_16;
+    TCGMemOp s_ot =3D s->ss32 ? MO_32 : MO_UW;
     TCGMemOp d_ot =3D s->dflag;
     int size =3D 1 << d_ot;
     int i;
@@ -2421,7 +2421,7 @@ static void gen_pusha(DisasContext *s)

 static void gen_popa(DisasContext *s)
 {
-    TCGMemOp s_ot =3D s->ss32 ? MO_32 : MO_16;
+    TCGMemOp s_ot =3D s->ss32 ? MO_32 : MO_UW;
     TCGMemOp d_ot =3D s->dflag;
     int size =3D 1 << d_ot;
     int i;
@@ -2443,7 +2443,7 @@ static void gen_popa(DisasContext *s)
 static void gen_enter(DisasContext *s, int esp_addend, int level)
 {
     TCGMemOp d_ot =3D mo_pushpop(s, s->dflag);
-    TCGMemOp a_ot =3D CODE64(s) ? MO_64 : s->ss32 ? MO_32 : MO_16;
+    TCGMemOp a_ot =3D CODE64(s) ? MO_64 : s->ss32 ? MO_32 : MO_UW;
     int size =3D 1 << d_ot;

     /* Push BP; compute FrameTemp into T1.  */
@@ -3613,7 +3613,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
         case 0xc4: /* pinsrw */
         case 0x1c4:
             s->rip_offset =3D 1;
-            gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+            gen_ldst_modrm(env, s, modrm, MO_UW, OR_TMP0, 0);
             val =3D x86_ldub_code(env, s);
             if (b1) {
                 val &=3D 7;
@@ -3786,7 +3786,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                 if ((b & 0xff) =3D=3D 0xf0) {
                     ot =3D MO_UB;
                 } else if (s->dflag !=3D MO_64) {
-                    ot =3D (s->prefix & PREFIX_DATA ? MO_16 : MO_32);
+                    ot =3D (s->prefix & PREFIX_DATA ? MO_UW : MO_32);
                 } else {
                     ot =3D MO_64;
                 }
@@ -3815,7 +3815,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                     goto illegal_op;
                 }
                 if (s->dflag !=3D MO_64) {
-                    ot =3D (s->prefix & PREFIX_DATA ? MO_16 : MO_32);
+                    ot =3D (s->prefix & PREFIX_DATA ? MO_UW : MO_32);
                 } else {
                     ot =3D MO_64;
                 }
@@ -4630,7 +4630,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         /* In 64-bit mode, the default data size is 32-bit.  Select 64-bit
            data with rex_w, and 16-bit data with 0x66; rex_w takes precede=
nce
            over 0x66 if both are present.  */
-        dflag =3D (rex_w > 0 ? MO_64 : prefixes & PREFIX_DATA ? MO_16 : MO=
_32);
+        dflag =3D (rex_w > 0 ? MO_64 : prefixes & PREFIX_DATA ? MO_UW : MO=
_32);
         /* In 64-bit mode, 0x67 selects 32-bit addressing.  */
         aflag =3D (prefixes & PREFIX_ADR ? MO_32 : MO_64);
     } else {
@@ -4638,13 +4638,13 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
         if (s->code32 ^ ((prefixes & PREFIX_DATA) !=3D 0)) {
             dflag =3D MO_32;
         } else {
-            dflag =3D MO_16;
+            dflag =3D MO_UW;
         }
         /* In 16/32-bit mode, 0x67 selects the opposite addressing.  */
         if (s->code32 ^ ((prefixes & PREFIX_ADR) !=3D 0)) {
             aflag =3D MO_32;
         }  else {
-            aflag =3D MO_16;
+            aflag =3D MO_UW;
         }
     }

@@ -4872,21 +4872,21 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
                 tcg_gen_ext8u_tl(s->T1, s->T1);
                 /* XXX: use 32 bit mul which could be faster */
                 tcg_gen_mul_tl(s->T0, s->T0, s->T1);
-                gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
+                gen_op_mov_reg_v(s, MO_UW, R_EAX, s->T0);
                 tcg_gen_mov_tl(cpu_cc_dst, s->T0);
                 tcg_gen_andi_tl(cpu_cc_src, s->T0, 0xff00);
                 set_cc_op(s, CC_OP_MULB);
                 break;
-            case MO_16:
-                gen_op_mov_v_reg(s, MO_16, s->T1, R_EAX);
+            case MO_UW:
+                gen_op_mov_v_reg(s, MO_UW, s->T1, R_EAX);
                 tcg_gen_ext16u_tl(s->T0, s->T0);
                 tcg_gen_ext16u_tl(s->T1, s->T1);
                 /* XXX: use 32 bit mul which could be faster */
                 tcg_gen_mul_tl(s->T0, s->T0, s->T1);
-                gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
+                gen_op_mov_reg_v(s, MO_UW, R_EAX, s->T0);
                 tcg_gen_mov_tl(cpu_cc_dst, s->T0);
                 tcg_gen_shri_tl(s->T0, s->T0, 16);
-                gen_op_mov_reg_v(s, MO_16, R_EDX, s->T0);
+                gen_op_mov_reg_v(s, MO_UW, R_EDX, s->T0);
                 tcg_gen_mov_tl(cpu_cc_src, s->T0);
                 set_cc_op(s, CC_OP_MULW);
                 break;
@@ -4921,24 +4921,24 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
                 tcg_gen_ext8s_tl(s->T1, s->T1);
                 /* XXX: use 32 bit mul which could be faster */
                 tcg_gen_mul_tl(s->T0, s->T0, s->T1);
-                gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
+                gen_op_mov_reg_v(s, MO_UW, R_EAX, s->T0);
                 tcg_gen_mov_tl(cpu_cc_dst, s->T0);
                 tcg_gen_ext8s_tl(s->tmp0, s->T0);
                 tcg_gen_sub_tl(cpu_cc_src, s->T0, s->tmp0);
                 set_cc_op(s, CC_OP_MULB);
                 break;
-            case MO_16:
-                gen_op_mov_v_reg(s, MO_16, s->T1, R_EAX);
+            case MO_UW:
+                gen_op_mov_v_reg(s, MO_UW, s->T1, R_EAX);
                 tcg_gen_ext16s_tl(s->T0, s->T0);
                 tcg_gen_ext16s_tl(s->T1, s->T1);
                 /* XXX: use 32 bit mul which could be faster */
                 tcg_gen_mul_tl(s->T0, s->T0, s->T1);
-                gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
+                gen_op_mov_reg_v(s, MO_UW, R_EAX, s->T0);
                 tcg_gen_mov_tl(cpu_cc_dst, s->T0);
                 tcg_gen_ext16s_tl(s->tmp0, s->T0);
                 tcg_gen_sub_tl(cpu_cc_src, s->T0, s->tmp0);
                 tcg_gen_shri_tl(s->T0, s->T0, 16);
-                gen_op_mov_reg_v(s, MO_16, R_EDX, s->T0);
+                gen_op_mov_reg_v(s, MO_UW, R_EDX, s->T0);
                 set_cc_op(s, CC_OP_MULW);
                 break;
             default:
@@ -4972,7 +4972,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             case MO_UB:
                 gen_helper_divb_AL(cpu_env, s->T0);
                 break;
-            case MO_16:
+            case MO_UW:
                 gen_helper_divw_AX(cpu_env, s->T0);
                 break;
             default:
@@ -4991,7 +4991,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             case MO_UB:
                 gen_helper_idivb_AL(cpu_env, s->T0);
                 break;
-            case MO_16:
+            case MO_UW:
                 gen_helper_idivw_AX(cpu_env, s->T0);
                 break;
             default:
@@ -5026,7 +5026,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 /* operand size for jumps is 64 bit */
                 ot =3D MO_64;
             } else if (op =3D=3D 3 || op =3D=3D 5) {
-                ot =3D dflag !=3D MO_16 ? MO_32 + (rex_w =3D=3D 1) : MO_16=
;
+                ot =3D dflag !=3D MO_UW ? MO_32 + (rex_w =3D=3D 1) : MO_UW=
;
             } else if (op =3D=3D 6) {
                 /* default push size is 64 bit */
                 ot =3D mo_pushpop(s, dflag);
@@ -5057,7 +5057,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             break;
         case 2: /* call Ev */
             /* XXX: optimize if memory (no 'and' is necessary) */
-            if (dflag =3D=3D MO_16) {
+            if (dflag =3D=3D MO_UW) {
                 tcg_gen_ext16u_tl(s->T0, s->T0);
             }
             next_eip =3D s->pc - s->cs_base;
@@ -5070,7 +5070,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         case 3: /* lcall Ev */
             gen_op_ld_v(s, ot, s->T1, s->A0);
             gen_add_A0_im(s, 1 << ot);
-            gen_op_ld_v(s, MO_16, s->T0, s->A0);
+            gen_op_ld_v(s, MO_UW, s->T0, s->A0);
         do_lcall:
             if (s->pe && !s->vm86) {
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
@@ -5087,7 +5087,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             gen_jr(s, s->tmp4);
             break;
         case 4: /* jmp Ev */
-            if (dflag =3D=3D MO_16) {
+            if (dflag =3D=3D MO_UW) {
                 tcg_gen_ext16u_tl(s->T0, s->T0);
             }
             gen_op_jmp_v(s->T0);
@@ -5097,7 +5097,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         case 5: /* ljmp Ev */
             gen_op_ld_v(s, ot, s->T1, s->A0);
             gen_add_A0_im(s, 1 << ot);
-            gen_op_ld_v(s, MO_16, s->T0, s->A0);
+            gen_op_ld_v(s, MO_UW, s->T0, s->A0);
         do_ljmp:
             if (s->pe && !s->vm86) {
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
@@ -5152,14 +5152,14 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
             break;
 #endif
         case MO_32:
-            gen_op_mov_v_reg(s, MO_16, s->T0, R_EAX);
+            gen_op_mov_v_reg(s, MO_UW, s->T0, R_EAX);
             tcg_gen_ext16s_tl(s->T0, s->T0);
             gen_op_mov_reg_v(s, MO_32, R_EAX, s->T0);
             break;
-        case MO_16:
+        case MO_UW:
             gen_op_mov_v_reg(s, MO_UB, s->T0, R_EAX);
             tcg_gen_ext8s_tl(s->T0, s->T0);
-            gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
+            gen_op_mov_reg_v(s, MO_UW, R_EAX, s->T0);
             break;
         default:
             tcg_abort();
@@ -5180,11 +5180,11 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
             tcg_gen_sari_tl(s->T0, s->T0, 31);
             gen_op_mov_reg_v(s, MO_32, R_EDX, s->T0);
             break;
-        case MO_16:
-            gen_op_mov_v_reg(s, MO_16, s->T0, R_EAX);
+        case MO_UW:
+            gen_op_mov_v_reg(s, MO_UW, s->T0, R_EAX);
             tcg_gen_ext16s_tl(s->T0, s->T0);
             tcg_gen_sari_tl(s->T0, s->T0, 15);
-            gen_op_mov_reg_v(s, MO_16, R_EDX, s->T0);
+            gen_op_mov_reg_v(s, MO_UW, R_EDX, s->T0);
             break;
         default:
             tcg_abort();
@@ -5538,7 +5538,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         reg =3D (modrm >> 3) & 7;
         if (reg >=3D 6 || reg =3D=3D R_CS)
             goto illegal_op;
-        gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+        gen_ldst_modrm(env, s, modrm, MO_UW, OR_TMP0, 0);
         gen_movl_seg_T0(s, reg);
         /* Note that reg =3D=3D R_SS in gen_movl_seg_T0 always sets is_jmp=
.  */
         if (s->base.is_jmp) {
@@ -5558,7 +5558,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         if (reg >=3D 6)
             goto illegal_op;
         gen_op_movl_T0_seg(s, reg);
-        ot =3D mod =3D=3D 3 ? dflag : MO_16;
+        ot =3D mod =3D=3D 3 ? dflag : MO_UW;
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
         break;

@@ -5734,7 +5734,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
     case 0x1b5: /* lgs Gv */
         op =3D R_GS;
     do_lxx:
-        ot =3D dflag !=3D MO_16 ? MO_32 : MO_16;
+        ot =3D dflag !=3D MO_UW ? MO_32 : MO_UW;
         modrm =3D x86_ldub_code(env, s);
         reg =3D ((modrm >> 3) & 7) | rex_r;
         mod =3D (modrm >> 6) & 3;
@@ -5744,7 +5744,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         gen_op_ld_v(s, ot, s->T1, s->A0);
         gen_add_A0_im(s, 1 << ot);
         /* load the segment first to handle exceptions properly */
-        gen_op_ld_v(s, MO_16, s->T0, s->A0);
+        gen_op_ld_v(s, MO_UW, s->T0, s->A0);
         gen_movl_seg_T0(s, op);
         /* then put the data */
         gen_op_mov_reg_v(s, ot, reg, s->T1);
@@ -6287,7 +6287,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 case 0:
                     gen_helper_fnstsw(s->tmp2_i32, cpu_env);
                     tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
-                    gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
+                    gen_op_mov_reg_v(s, MO_UW, R_EAX, s->T0);
                     break;
                 default:
                     goto unknown_op;
@@ -6575,14 +6575,14 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
         break;
     case 0xe8: /* call im */
         {
-            if (dflag !=3D MO_16) {
+            if (dflag !=3D MO_UW) {
                 tval =3D (int32_t)insn_get(env, s, MO_32);
             } else {
-                tval =3D (int16_t)insn_get(env, s, MO_16);
+                tval =3D (int16_t)insn_get(env, s, MO_UW);
             }
             next_eip =3D s->pc - s->cs_base;
             tval +=3D next_eip;
-            if (dflag =3D=3D MO_16) {
+            if (dflag =3D=3D MO_UW) {
                 tval &=3D 0xffff;
             } else if (!CODE64(s)) {
                 tval &=3D 0xffffffff;
@@ -6601,20 +6601,20 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
                 goto illegal_op;
             ot =3D dflag;
             offset =3D insn_get(env, s, ot);
-            selector =3D insn_get(env, s, MO_16);
+            selector =3D insn_get(env, s, MO_UW);

             tcg_gen_movi_tl(s->T0, selector);
             tcg_gen_movi_tl(s->T1, offset);
         }
         goto do_lcall;
     case 0xe9: /* jmp im */
-        if (dflag !=3D MO_16) {
+        if (dflag !=3D MO_UW) {
             tval =3D (int32_t)insn_get(env, s, MO_32);
         } else {
-            tval =3D (int16_t)insn_get(env, s, MO_16);
+            tval =3D (int16_t)insn_get(env, s, MO_UW);
         }
         tval +=3D s->pc - s->cs_base;
-        if (dflag =3D=3D MO_16) {
+        if (dflag =3D=3D MO_UW) {
             tval &=3D 0xffff;
         } else if (!CODE64(s)) {
             tval &=3D 0xffffffff;
@@ -6630,7 +6630,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 goto illegal_op;
             ot =3D dflag;
             offset =3D insn_get(env, s, ot);
-            selector =3D insn_get(env, s, MO_16);
+            selector =3D insn_get(env, s, MO_UW);

             tcg_gen_movi_tl(s->T0, selector);
             tcg_gen_movi_tl(s->T1, offset);
@@ -6639,7 +6639,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
     case 0xeb: /* jmp Jb */
         tval =3D (int8_t)insn_get(env, s, MO_UB);
         tval +=3D s->pc - s->cs_base;
-        if (dflag =3D=3D MO_16) {
+        if (dflag =3D=3D MO_UW) {
             tval &=3D 0xffff;
         }
         gen_jmp(s, tval);
@@ -6648,15 +6648,15 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
         tval =3D (int8_t)insn_get(env, s, MO_UB);
         goto do_jcc;
     case 0x180 ... 0x18f: /* jcc Jv */
-        if (dflag !=3D MO_16) {
+        if (dflag !=3D MO_UW) {
             tval =3D (int32_t)insn_get(env, s, MO_32);
         } else {
-            tval =3D (int16_t)insn_get(env, s, MO_16);
+            tval =3D (int16_t)insn_get(env, s, MO_UW);
         }
     do_jcc:
         next_eip =3D s->pc - s->cs_base;
         tval +=3D next_eip;
-        if (dflag =3D=3D MO_16) {
+        if (dflag =3D=3D MO_UW) {
             tval &=3D 0xffff;
         }
         gen_bnd_jmp(s);
@@ -6697,7 +6697,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         } else {
             ot =3D gen_pop_T0(s);
             if (s->cpl =3D=3D 0) {
-                if (dflag !=3D MO_16) {
+                if (dflag !=3D MO_UW) {
                     gen_helper_write_eflags(cpu_env, s->T0,
                                             tcg_const_i32((TF_MASK | AC_MA=
SK |
                                                            ID_MASK | NT_MA=
SK |
@@ -6712,7 +6712,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 }
             } else {
                 if (s->cpl <=3D s->iopl) {
-                    if (dflag !=3D MO_16) {
+                    if (dflag !=3D MO_UW) {
                         gen_helper_write_eflags(cpu_env, s->T0,
                                                 tcg_const_i32((TF_MASK |
                                                                AC_MASK |
@@ -6729,7 +6729,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                                                               & 0xffff));
                     }
                 } else {
-                    if (dflag !=3D MO_16) {
+                    if (dflag !=3D MO_UW) {
                         gen_helper_write_eflags(cpu_env, s->T0,
                                            tcg_const_i32((TF_MASK | AC_MAS=
K |
                                                           ID_MASK | NT_MAS=
K)));
@@ -7110,7 +7110,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         gen_op_mov_v_reg(s, ot, s->T0, reg);
         gen_lea_modrm(env, s, modrm);
         tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-        if (ot =3D=3D MO_16) {
+        if (ot =3D=3D MO_UW) {
             gen_helper_boundw(cpu_env, s->A0, s->tmp2_i32);
         } else {
             gen_helper_boundl(cpu_env, s->A0, s->tmp2_i32);
@@ -7149,7 +7149,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             tval =3D (int8_t)insn_get(env, s, MO_UB);
             next_eip =3D s->pc - s->cs_base;
             tval +=3D next_eip;
-            if (dflag =3D=3D MO_16) {
+            if (dflag =3D=3D MO_UW) {
                 tval &=3D 0xffff;
             }

@@ -7291,7 +7291,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_LDTR_READ);
             tcg_gen_ld32u_tl(s->T0, cpu_env,
                              offsetof(CPUX86State, ldt.selector));
-            ot =3D mod =3D=3D 3 ? dflag : MO_16;
+            ot =3D mod =3D=3D 3 ? dflag : MO_UW;
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             break;
         case 2: /* lldt */
@@ -7301,7 +7301,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
             } else {
                 gen_svm_check_intercept(s, pc_start, SVM_EXIT_LDTR_WRITE);
-                gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+                gen_ldst_modrm(env, s, modrm, MO_UW, OR_TMP0, 0);
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_lldt(cpu_env, s->tmp2_i32);
             }
@@ -7312,7 +7312,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_TR_READ);
             tcg_gen_ld32u_tl(s->T0, cpu_env,
                              offsetof(CPUX86State, tr.selector));
-            ot =3D mod =3D=3D 3 ? dflag : MO_16;
+            ot =3D mod =3D=3D 3 ? dflag : MO_UW;
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             break;
         case 3: /* ltr */
@@ -7322,7 +7322,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
             } else {
                 gen_svm_check_intercept(s, pc_start, SVM_EXIT_TR_WRITE);
-                gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+                gen_ldst_modrm(env, s, modrm, MO_UW, OR_TMP0, 0);
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_ltr(cpu_env, s->tmp2_i32);
             }
@@ -7331,7 +7331,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         case 5: /* verw */
             if (!s->pe || s->vm86)
                 goto illegal_op;
-            gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+            gen_ldst_modrm(env, s, modrm, MO_UW, OR_TMP0, 0);
             gen_update_cc_op(s);
             if (op =3D=3D 4) {
                 gen_helper_verr(cpu_env, s->T0);
@@ -7353,10 +7353,10 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
             gen_lea_modrm(env, s, modrm);
             tcg_gen_ld32u_tl(s->T0,
                              cpu_env, offsetof(CPUX86State, gdt.limit));
-            gen_op_st_v(s, MO_16, s->T0, s->A0);
+            gen_op_st_v(s, MO_UW, s->T0, s->A0);
             gen_add_A0_im(s, 2);
             tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, gdt.base))=
;
-            if (dflag =3D=3D MO_16) {
+            if (dflag =3D=3D MO_UW) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
@@ -7408,10 +7408,10 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_IDTR_READ);
             gen_lea_modrm(env, s, modrm);
             tcg_gen_ld32u_tl(s->T0, cpu_env, offsetof(CPUX86State, idt.lim=
it));
-            gen_op_st_v(s, MO_16, s->T0, s->A0);
+            gen_op_st_v(s, MO_UW, s->T0, s->A0);
             gen_add_A0_im(s, 2);
             tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, idt.base))=
;
-            if (dflag =3D=3D MO_16) {
+            if (dflag =3D=3D MO_UW) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
@@ -7558,10 +7558,10 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
             }
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_GDTR_WRITE);
             gen_lea_modrm(env, s, modrm);
-            gen_op_ld_v(s, MO_16, s->T1, s->A0);
+            gen_op_ld_v(s, MO_UW, s->T1, s->A0);
             gen_add_A0_im(s, 2);
             gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
-            if (dflag =3D=3D MO_16) {
+            if (dflag =3D=3D MO_UW) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             tcg_gen_st_tl(s->T0, cpu_env, offsetof(CPUX86State, gdt.base))=
;
@@ -7575,10 +7575,10 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
             }
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_IDTR_WRITE);
             gen_lea_modrm(env, s, modrm);
-            gen_op_ld_v(s, MO_16, s->T1, s->A0);
+            gen_op_ld_v(s, MO_UW, s->T1, s->A0);
             gen_add_A0_im(s, 2);
             gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
-            if (dflag =3D=3D MO_16) {
+            if (dflag =3D=3D MO_UW) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             tcg_gen_st_tl(s->T0, cpu_env, offsetof(CPUX86State, idt.base))=
;
@@ -7590,9 +7590,9 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, cr[0]));
             if (CODE64(s)) {
                 mod =3D (modrm >> 6) & 3;
-                ot =3D (mod !=3D 3 ? MO_16 : s->dflag);
+                ot =3D (mod !=3D 3 ? MO_UW : s->dflag);
             } else {
-                ot =3D MO_16;
+                ot =3D MO_UW;
             }
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             break;
@@ -7619,7 +7619,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 break;
             }
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_CR0);
-            gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+            gen_ldst_modrm(env, s, modrm, MO_UW, OR_TMP0, 0);
             gen_helper_lmsw(cpu_env, s->T0);
             gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob(s);
@@ -7720,7 +7720,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             t0 =3D tcg_temp_local_new();
             t1 =3D tcg_temp_local_new();
             t2 =3D tcg_temp_local_new();
-            ot =3D MO_16;
+            ot =3D MO_UW;
             modrm =3D x86_ldub_code(env, s);
             reg =3D (modrm >> 3) & 7;
             mod =3D (modrm >> 6) & 3;
@@ -7765,10 +7765,10 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
             TCGv t0;
             if (!s->pe || s->vm86)
                 goto illegal_op;
-            ot =3D dflag !=3D MO_16 ? MO_32 : MO_16;
+            ot =3D dflag !=3D MO_UW ? MO_32 : MO_UW;
             modrm =3D x86_ldub_code(env, s);
             reg =3D ((modrm >> 3) & 7) | rex_r;
-            gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+            gen_ldst_modrm(env, s, modrm, MO_UW, OR_TMP0, 0);
             t0 =3D tcg_temp_local_new();
             gen_update_cc_op(s);
             if (b =3D=3D 0x102) {
@@ -7813,7 +7813,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 /* bndcl */
                 if (reg >=3D 4
                     || (prefixes & PREFIX_LOCK)
-                    || s->aflag =3D=3D MO_16) {
+                    || s->aflag =3D=3D MO_UW) {
                     goto illegal_op;
                 }
                 gen_bndck(env, s, modrm, TCG_COND_LTU, cpu_bndl[reg]);
@@ -7821,7 +7821,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 /* bndcu */
                 if (reg >=3D 4
                     || (prefixes & PREFIX_LOCK)
-                    || s->aflag =3D=3D MO_16) {
+                    || s->aflag =3D=3D MO_UW) {
                     goto illegal_op;
                 }
                 TCGv_i64 notu =3D tcg_temp_new_i64();
@@ -7830,7 +7830,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 tcg_temp_free_i64(notu);
             } else if (prefixes & PREFIX_DATA) {
                 /* bndmov -- from reg/mem */
-                if (reg >=3D 4 || s->aflag =3D=3D MO_16) {
+                if (reg >=3D 4 || s->aflag =3D=3D MO_UW) {
                     goto illegal_op;
                 }
                 if (mod =3D=3D 3) {
@@ -7865,7 +7865,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 AddressParts a =3D gen_lea_modrm_0(env, s, modrm);
                 if (reg >=3D 4
                     || (prefixes & PREFIX_LOCK)
-                    || s->aflag =3D=3D MO_16
+                    || s->aflag =3D=3D MO_UW
                     || a.base < -1) {
                     goto illegal_op;
                 }
@@ -7903,7 +7903,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 /* bndmk */
                 if (reg >=3D 4
                     || (prefixes & PREFIX_LOCK)
-                    || s->aflag =3D=3D MO_16) {
+                    || s->aflag =3D=3D MO_UW) {
                     goto illegal_op;
                 }
                 AddressParts a =3D gen_lea_modrm_0(env, s, modrm);
@@ -7931,13 +7931,13 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
                 /* bndcn */
                 if (reg >=3D 4
                     || (prefixes & PREFIX_LOCK)
-                    || s->aflag =3D=3D MO_16) {
+                    || s->aflag =3D=3D MO_UW) {
                     goto illegal_op;
                 }
                 gen_bndck(env, s, modrm, TCG_COND_GTU, cpu_bndu[reg]);
             } else if (prefixes & PREFIX_DATA) {
                 /* bndmov -- to reg/mem */
-                if (reg >=3D 4 || s->aflag =3D=3D MO_16) {
+                if (reg >=3D 4 || s->aflag =3D=3D MO_UW) {
                     goto illegal_op;
                 }
                 if (mod =3D=3D 3) {
@@ -7970,7 +7970,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 AddressParts a =3D gen_lea_modrm_0(env, s, modrm);
                 if (reg >=3D 4
                     || (prefixes & PREFIX_LOCK)
-                    || s->aflag =3D=3D MO_16
+                    || s->aflag =3D=3D MO_UW
                     || a.base < -1) {
                     goto illegal_op;
                 }
@@ -8341,7 +8341,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         reg =3D ((modrm >> 3) & 7) | rex_r;

         if (s->prefix & PREFIX_DATA) {
-            ot =3D MO_16;
+            ot =3D MO_UW;
         } else {
             ot =3D mo_64_32(dflag);
         }
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 20a9777..525c7fe 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -21087,7 +21087,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext=
 *ctx, int opc,
             imm =3D sextract32(ctx->opcode, 11, 11);
             imm =3D (int16_t)(imm << 6) >> 6;
             if (rt !=3D 0) {
-                tcg_gen_movi_tl(cpu_gpr[rt], dup_const(MO_16, imm));
+                tcg_gen_movi_tl(cpu_gpr[rt], dup_const(MO_UW, imm));
             }
         }
         break;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx=
-impl.inc.c
index 4130dd1..71efef4 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -406,29 +406,29 @@ static void glue(gen_, name)(DisasContext *ctx)      =
                   \
 GEN_VXFORM_V(vaddubm, MO_UB, tcg_gen_gvec_add, 0, 0);
 GEN_VXFORM_DUAL_EXT(vaddubm, PPC_ALTIVEC, PPC_NONE, 0,       \
                     vmul10cuq, PPC_NONE, PPC2_ISA300, 0x0000F800)
-GEN_VXFORM_V(vadduhm, MO_16, tcg_gen_gvec_add, 0, 1);
+GEN_VXFORM_V(vadduhm, MO_UW, tcg_gen_gvec_add, 0, 1);
 GEN_VXFORM_DUAL(vadduhm, PPC_ALTIVEC, PPC_NONE,  \
                 vmul10ecuq, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_V(vadduwm, MO_32, tcg_gen_gvec_add, 0, 2);
 GEN_VXFORM_V(vaddudm, MO_64, tcg_gen_gvec_add, 0, 3);
 GEN_VXFORM_V(vsububm, MO_UB, tcg_gen_gvec_sub, 0, 16);
-GEN_VXFORM_V(vsubuhm, MO_16, tcg_gen_gvec_sub, 0, 17);
+GEN_VXFORM_V(vsubuhm, MO_UW, tcg_gen_gvec_sub, 0, 17);
 GEN_VXFORM_V(vsubuwm, MO_32, tcg_gen_gvec_sub, 0, 18);
 GEN_VXFORM_V(vsubudm, MO_64, tcg_gen_gvec_sub, 0, 19);
 GEN_VXFORM_V(vmaxub, MO_UB, tcg_gen_gvec_umax, 1, 0);
-GEN_VXFORM_V(vmaxuh, MO_16, tcg_gen_gvec_umax, 1, 1);
+GEN_VXFORM_V(vmaxuh, MO_UW, tcg_gen_gvec_umax, 1, 1);
 GEN_VXFORM_V(vmaxuw, MO_32, tcg_gen_gvec_umax, 1, 2);
 GEN_VXFORM_V(vmaxud, MO_64, tcg_gen_gvec_umax, 1, 3);
 GEN_VXFORM_V(vmaxsb, MO_UB, tcg_gen_gvec_smax, 1, 4);
-GEN_VXFORM_V(vmaxsh, MO_16, tcg_gen_gvec_smax, 1, 5);
+GEN_VXFORM_V(vmaxsh, MO_UW, tcg_gen_gvec_smax, 1, 5);
 GEN_VXFORM_V(vmaxsw, MO_32, tcg_gen_gvec_smax, 1, 6);
 GEN_VXFORM_V(vmaxsd, MO_64, tcg_gen_gvec_smax, 1, 7);
 GEN_VXFORM_V(vminub, MO_UB, tcg_gen_gvec_umin, 1, 8);
-GEN_VXFORM_V(vminuh, MO_16, tcg_gen_gvec_umin, 1, 9);
+GEN_VXFORM_V(vminuh, MO_UW, tcg_gen_gvec_umin, 1, 9);
 GEN_VXFORM_V(vminuw, MO_32, tcg_gen_gvec_umin, 1, 10);
 GEN_VXFORM_V(vminud, MO_64, tcg_gen_gvec_umin, 1, 11);
 GEN_VXFORM_V(vminsb, MO_UB, tcg_gen_gvec_smin, 1, 12);
-GEN_VXFORM_V(vminsh, MO_16, tcg_gen_gvec_smin, 1, 13);
+GEN_VXFORM_V(vminsh, MO_UW, tcg_gen_gvec_smin, 1, 13);
 GEN_VXFORM_V(vminsw, MO_32, tcg_gen_gvec_smin, 1, 14);
 GEN_VXFORM_V(vminsd, MO_64, tcg_gen_gvec_smin, 1, 15);
 GEN_VXFORM(vavgub, 1, 16);
@@ -531,18 +531,18 @@ GEN_VXFORM(vmulesb, 4, 12);
 GEN_VXFORM(vmulesh, 4, 13);
 GEN_VXFORM(vmulesw, 4, 14);
 GEN_VXFORM_V(vslb, MO_UB, tcg_gen_gvec_shlv, 2, 4);
-GEN_VXFORM_V(vslh, MO_16, tcg_gen_gvec_shlv, 2, 5);
+GEN_VXFORM_V(vslh, MO_UW, tcg_gen_gvec_shlv, 2, 5);
 GEN_VXFORM_V(vslw, MO_32, tcg_gen_gvec_shlv, 2, 6);
 GEN_VXFORM(vrlwnm, 2, 6);
 GEN_VXFORM_DUAL(vslw, PPC_ALTIVEC, PPC_NONE, \
                 vrlwnm, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_V(vsld, MO_64, tcg_gen_gvec_shlv, 2, 23);
 GEN_VXFORM_V(vsrb, MO_UB, tcg_gen_gvec_shrv, 2, 8);
-GEN_VXFORM_V(vsrh, MO_16, tcg_gen_gvec_shrv, 2, 9);
+GEN_VXFORM_V(vsrh, MO_UW, tcg_gen_gvec_shrv, 2, 9);
 GEN_VXFORM_V(vsrw, MO_32, tcg_gen_gvec_shrv, 2, 10);
 GEN_VXFORM_V(vsrd, MO_64, tcg_gen_gvec_shrv, 2, 27);
 GEN_VXFORM_V(vsrab, MO_UB, tcg_gen_gvec_sarv, 2, 12);
-GEN_VXFORM_V(vsrah, MO_16, tcg_gen_gvec_sarv, 2, 13);
+GEN_VXFORM_V(vsrah, MO_UW, tcg_gen_gvec_sarv, 2, 13);
 GEN_VXFORM_V(vsraw, MO_32, tcg_gen_gvec_sarv, 2, 14);
 GEN_VXFORM_V(vsrad, MO_64, tcg_gen_gvec_sarv, 2, 15);
 GEN_VXFORM(vsrv, 2, 28);
@@ -592,18 +592,18 @@ static void glue(gen_, NAME)(DisasContext *ctx)      =
                   \
 GEN_VXFORM_SAT(vaddubs, MO_UB, add, usadd, 0, 8);
 GEN_VXFORM_DUAL_EXT(vaddubs, PPC_ALTIVEC, PPC_NONE, 0,       \
                     vmul10uq, PPC_NONE, PPC2_ISA300, 0x0000F800)
-GEN_VXFORM_SAT(vadduhs, MO_16, add, usadd, 0, 9);
+GEN_VXFORM_SAT(vadduhs, MO_UW, add, usadd, 0, 9);
 GEN_VXFORM_DUAL(vadduhs, PPC_ALTIVEC, PPC_NONE, \
                 vmul10euq, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_SAT(vadduws, MO_32, add, usadd, 0, 10);
 GEN_VXFORM_SAT(vaddsbs, MO_UB, add, ssadd, 0, 12);
-GEN_VXFORM_SAT(vaddshs, MO_16, add, ssadd, 0, 13);
+GEN_VXFORM_SAT(vaddshs, MO_UW, add, ssadd, 0, 13);
 GEN_VXFORM_SAT(vaddsws, MO_32, add, ssadd, 0, 14);
 GEN_VXFORM_SAT(vsububs, MO_UB, sub, ussub, 0, 24);
-GEN_VXFORM_SAT(vsubuhs, MO_16, sub, ussub, 0, 25);
+GEN_VXFORM_SAT(vsubuhs, MO_UW, sub, ussub, 0, 25);
 GEN_VXFORM_SAT(vsubuws, MO_32, sub, ussub, 0, 26);
 GEN_VXFORM_SAT(vsubsbs, MO_UB, sub, sssub, 0, 28);
-GEN_VXFORM_SAT(vsubshs, MO_16, sub, sssub, 0, 29);
+GEN_VXFORM_SAT(vsubshs, MO_UW, sub, sssub, 0, 29);
 GEN_VXFORM_SAT(vsubsws, MO_32, sub, sssub, 0, 30);
 GEN_VXFORM(vadduqm, 0, 4);
 GEN_VXFORM(vaddcuq, 0, 5);
@@ -913,7 +913,7 @@ static void glue(gen_, name)(DisasContext *ctx)        =
                 \
     }

 GEN_VXFORM_VSPLT(vspltb, MO_UB, 6, 8);
-GEN_VXFORM_VSPLT(vsplth, MO_16, 6, 9);
+GEN_VXFORM_VSPLT(vsplth, MO_UW, 6, 9);
 GEN_VXFORM_VSPLT(vspltw, MO_32, 6, 10);
 GEN_VXFORM_UIMM_SPLAT(vextractub, 6, 8, 15);
 GEN_VXFORM_UIMM_SPLAT(vextractuh, 6, 9, 14);
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.in=
c.c
index bb424c8..65da6b3 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -47,7 +47,7 @@
 #define NUM_VEC_ELEMENT_BITS(es) (NUM_VEC_ELEMENT_BYTES(es) * BITS_PER_BYT=
E)

 #define ES_8    MO_UB
-#define ES_16   MO_16
+#define ES_16   MO_UW
 #define ES_32   MO_32
 #define ES_64   MO_64
 #define ES_128  4
diff --git a/target/s390x/vec.h b/target/s390x/vec.h
index b813054..28e1b1d 100644
--- a/target/s390x/vec.h
+++ b/target/s390x/vec.h
@@ -78,7 +78,7 @@ static inline uint64_t s390_vec_read_element(const S390Ve=
ctor *v, uint8_t enr,
     switch (es) {
     case MO_UB:
         return s390_vec_read_element8(v, enr);
-    case MO_16:
+    case MO_UW:
         return s390_vec_read_element16(v, enr);
     case MO_32:
         return s390_vec_read_element32(v, enr);
@@ -124,7 +124,7 @@ static inline void s390_vec_write_element(S390Vector *v=
, uint8_t enr,
     case MO_UB:
         s390_vec_write_element8(v, enr, data);
         break;
-    case MO_16:
+    case MO_UW:
         s390_vec_write_element16(v, enr, data);
         break;
     case MO_32:
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index e4e0845..3d90c4b 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -430,20 +430,20 @@ typedef enum {
     /* Load/store register.  Described here as 3.3.12, but the helper
        that emits them can transform to 3.3.10 or 3.3.13.  */
     I3312_STRB      =3D 0x38000000 | LDST_ST << 22 | MO_UB << 30,
-    I3312_STRH      =3D 0x38000000 | LDST_ST << 22 | MO_16 << 30,
+    I3312_STRH      =3D 0x38000000 | LDST_ST << 22 | MO_UW << 30,
     I3312_STRW      =3D 0x38000000 | LDST_ST << 22 | MO_32 << 30,
     I3312_STRX      =3D 0x38000000 | LDST_ST << 22 | MO_64 << 30,

     I3312_LDRB      =3D 0x38000000 | LDST_LD << 22 | MO_UB << 30,
-    I3312_LDRH      =3D 0x38000000 | LDST_LD << 22 | MO_16 << 30,
+    I3312_LDRH      =3D 0x38000000 | LDST_LD << 22 | MO_UW << 30,
     I3312_LDRW      =3D 0x38000000 | LDST_LD << 22 | MO_32 << 30,
     I3312_LDRX      =3D 0x38000000 | LDST_LD << 22 | MO_64 << 30,

     I3312_LDRSBW    =3D 0x38000000 | LDST_LD_S_W << 22 | MO_UB << 30,
-    I3312_LDRSHW    =3D 0x38000000 | LDST_LD_S_W << 22 | MO_16 << 30,
+    I3312_LDRSHW    =3D 0x38000000 | LDST_LD_S_W << 22 | MO_UW << 30,

     I3312_LDRSBX    =3D 0x38000000 | LDST_LD_S_X << 22 | MO_UB << 30,
-    I3312_LDRSHX    =3D 0x38000000 | LDST_LD_S_X << 22 | MO_16 << 30,
+    I3312_LDRSHX    =3D 0x38000000 | LDST_LD_S_X << 22 | MO_UW << 30,
     I3312_LDRSWX    =3D 0x38000000 | LDST_LD_S_X << 22 | MO_32 << 30,

     I3312_LDRVS     =3D 0x3c000000 | LDST_LD << 22 | MO_32 << 30,
@@ -870,7 +870,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType typ=
e,

     /*
      * Test all bytes 0x00 or 0xff second.  This can match cases that
-     * might otherwise take 2 or 3 insns for MO_16 or MO_32 below.
+     * might otherwise take 2 or 3 insns for MO_UW or MO_32 below.
      */
     for (i =3D imm8 =3D 0; i < 8; i++) {
         uint8_t byte =3D v64 >> (i * 8);
@@ -889,7 +889,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType typ=
e,
      * cannot find an expansion there's no point checking a larger
      * width because we already know by replication it cannot match.
      */
-    if (v64 =3D=3D dup_const(MO_16, v64)) {
+    if (v64 =3D=3D dup_const(MO_UW, v64)) {
         uint16_t v16 =3D v64;

         if (is_shimm16(v16, &cmode, &imm8)) {
@@ -1733,7 +1733,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCG=
MemOp memop, TCGType ext,
         if (bswap) {
             tcg_out_ldst_r(s, I3312_LDRH, data_r, addr_r, otype, off_r);
             tcg_out_rev16(s, data_r, data_r);
-            tcg_out_sxt(s, ext, MO_16, data_r, data_r);
+            tcg_out_sxt(s, ext, MO_UW, data_r, data_r);
         } else {
             tcg_out_ldst_r(s, (ext ? I3312_LDRSHX : I3312_LDRSHW),
                            data_r, addr_r, otype, off_r);
@@ -1775,7 +1775,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
MemOp memop,
     case MO_UB:
         tcg_out_ldst_r(s, I3312_STRB, data_r, addr_r, otype, off_r);
         break;
-    case MO_16:
+    case MO_UW:
         if (bswap && data_r !=3D TCG_REG_XZR) {
             tcg_out_rev16(s, TCG_REG_TMP, data_r);
             data_r =3D TCG_REG_TMP;
@@ -2190,7 +2190,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_ext16s_i64:
     case INDEX_op_ext16s_i32:
-        tcg_out_sxt(s, ext, MO_16, a0, a1);
+        tcg_out_sxt(s, ext, MO_UW, a0, a1);
         break;
     case INDEX_op_ext_i32_i64:
     case INDEX_op_ext32s_i64:
@@ -2202,7 +2202,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_ext16u_i64:
     case INDEX_op_ext16u_i32:
-        tcg_out_uxt(s, MO_16, a0, a1);
+        tcg_out_uxt(s, MO_UW, a0, a1);
         break;
     case INDEX_op_extu_i32_i64:
     case INDEX_op_ext32u_i64:
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 542ffa8..0bd400e 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1432,7 +1432,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
     case MO_UB:
         argreg =3D tcg_out_arg_reg8(s, argreg, datalo);
         break;
-    case MO_16:
+    case MO_UW:
         argreg =3D tcg_out_arg_reg16(s, argreg, datalo);
         break;
     case MO_32:
@@ -1624,7 +1624,7 @@ static inline void tcg_out_qemu_st_index(TCGContext *=
s, int cond, TCGMemOp opc,
     case MO_UB:
         tcg_out_st8_r(s, cond, datalo, addrlo, addend);
         break;
-    case MO_16:
+    case MO_UW:
         if (bswap) {
             tcg_out_bswap16st(s, cond, TCG_REG_R0, datalo);
             tcg_out_st16_r(s, cond, TCG_REG_R0, addrlo, addend);
@@ -1669,7 +1669,7 @@ static inline void tcg_out_qemu_st_direct(TCGContext =
*s, TCGMemOp opc,
     case MO_UB:
         tcg_out_st8_12(s, COND_AL, datalo, addrlo, 0);
         break;
-    case MO_16:
+    case MO_UW:
         if (bswap) {
             tcg_out_bswap16st(s, COND_AL, TCG_REG_R0, datalo);
             tcg_out_st16_8(s, COND_AL, TCG_REG_R0, addrlo, 0);
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 0d68ba4..31c3664 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -893,7 +893,7 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type=
, unsigned vece,
             tcg_out_vex_modrm(s, OPC_PUNPCKLBW, r, a, a);
             a =3D r;
             /* FALLTHRU */
-        case MO_16:
+        case MO_UW:
             tcg_out_vex_modrm(s, OPC_PUNPCKLWD, r, a, a);
             a =3D r;
             /* FALLTHRU */
@@ -927,7 +927,7 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType typ=
e, unsigned vece,
         case MO_32:
             tcg_out_vex_modrm_offset(s, OPC_VBROADCASTSS, r, 0, base, offs=
et);
             break;
-        case MO_16:
+        case MO_UW:
             tcg_out_vex_modrm_offset(s, OPC_VPINSRW, r, r, base, offset);
             tcg_out8(s, 0); /* imm8 */
             tcg_out_dup_vec(s, type, vece, r, r);
@@ -2164,7 +2164,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
Reg datalo, TCGReg datahi,
         tcg_out_modrm_sib_offset(s, OPC_MOVB_EvGv + P_REXB_R + seg,
                                  datalo, base, index, 0, ofs);
         break;
-    case MO_16:
+    case MO_UW:
         if (bswap) {
             tcg_out_mov(s, TCG_TYPE_I32, scratch, datalo);
             tcg_out_rolw_8(s, scratch);
@@ -2747,15 +2747,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode=
 opc,
         OPC_PMAXUB, OPC_PMAXUW, OPC_PMAXUD, OPC_UD2
     };
     static int const shlv_insn[4] =3D {
-        /* TODO: AVX512 adds support for MO_16.  */
+        /* TODO: AVX512 adds support for MO_UW.  */
         OPC_UD2, OPC_UD2, OPC_VPSLLVD, OPC_VPSLLVQ
     };
     static int const shrv_insn[4] =3D {
-        /* TODO: AVX512 adds support for MO_16.  */
+        /* TODO: AVX512 adds support for MO_UW.  */
         OPC_UD2, OPC_UD2, OPC_VPSRLVD, OPC_VPSRLVQ
     };
     static int const sarv_insn[4] =3D {
-        /* TODO: AVX512 adds support for MO_16, MO_64.  */
+        /* TODO: AVX512 adds support for MO_UW, MO_64.  */
         OPC_UD2, OPC_UD2, OPC_VPSRAVD, OPC_UD2
     };
     static int const shls_insn[4] =3D {
@@ -2925,7 +2925,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode o=
pc,
         sub =3D args[3];
         goto gen_simd_imm8;
     case INDEX_op_x86_blend_vec:
-        if (vece =3D=3D MO_16) {
+        if (vece =3D=3D MO_UW) {
             insn =3D OPC_PBLENDW;
         } else if (vece =3D=3D MO_32) {
             insn =3D (have_avx2 ? OPC_VPBLENDD : OPC_BLENDPS);
@@ -3290,9 +3290,9 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, =
unsigned vece)

     case INDEX_op_shls_vec:
     case INDEX_op_shrs_vec:
-        return vece >=3D MO_16;
+        return vece >=3D MO_UW;
     case INDEX_op_sars_vec:
-        return vece >=3D MO_16 && vece <=3D MO_32;
+        return vece >=3D MO_UW && vece <=3D MO_32;

     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
@@ -3314,7 +3314,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, =
unsigned vece)
     case INDEX_op_usadd_vec:
     case INDEX_op_sssub_vec:
     case INDEX_op_ussub_vec:
-        return vece <=3D MO_16;
+        return vece <=3D MO_UW;
     case INDEX_op_smin_vec:
     case INDEX_op_smax_vec:
     case INDEX_op_umin_vec:
@@ -3352,13 +3352,13 @@ static void expand_vec_shi(TCGType type, unsigned v=
ece, bool shr,
               tcgv_vec_arg(t2), tcgv_vec_arg(v1), tcgv_vec_arg(v1));

     if (shr) {
-        tcg_gen_shri_vec(MO_16, t1, t1, imm + 8);
-        tcg_gen_shri_vec(MO_16, t2, t2, imm + 8);
+        tcg_gen_shri_vec(MO_UW, t1, t1, imm + 8);
+        tcg_gen_shri_vec(MO_UW, t2, t2, imm + 8);
     } else {
-        tcg_gen_shli_vec(MO_16, t1, t1, imm + 8);
-        tcg_gen_shli_vec(MO_16, t2, t2, imm + 8);
-        tcg_gen_shri_vec(MO_16, t1, t1, 8);
-        tcg_gen_shri_vec(MO_16, t2, t2, 8);
+        tcg_gen_shli_vec(MO_UW, t1, t1, imm + 8);
+        tcg_gen_shli_vec(MO_UW, t2, t2, imm + 8);
+        tcg_gen_shri_vec(MO_UW, t1, t1, 8);
+        tcg_gen_shri_vec(MO_UW, t2, t2, 8);
     }

     vec_gen_3(INDEX_op_x86_packus_vec, type, MO_UB,
@@ -3381,8 +3381,8 @@ static void expand_vec_sari(TCGType type, unsigned ve=
ce,
                   tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
         vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_UB,
                   tcgv_vec_arg(t2), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
-        tcg_gen_sari_vec(MO_16, t1, t1, imm + 8);
-        tcg_gen_sari_vec(MO_16, t2, t2, imm + 8);
+        tcg_gen_sari_vec(MO_UW, t1, t1, imm + 8);
+        tcg_gen_sari_vec(MO_UW, t2, t2, imm + 8);
         vec_gen_3(INDEX_op_x86_packss_vec, type, MO_UB,
                   tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(t2));
         tcg_temp_free_vec(t1);
@@ -3446,8 +3446,8 @@ static void expand_vec_mul(TCGType type, unsigned vec=
e,
                   tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(t2));
         vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_UB,
                   tcgv_vec_arg(t2), tcgv_vec_arg(t2), tcgv_vec_arg(v2));
-        tcg_gen_mul_vec(MO_16, t1, t1, t2);
-        tcg_gen_shri_vec(MO_16, t1, t1, 8);
+        tcg_gen_mul_vec(MO_UW, t1, t1, t2);
+        tcg_gen_shri_vec(MO_UW, t1, t1, 8);
         vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_UB,
                   tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(t1));
         tcg_temp_free_vec(t1);
@@ -3469,10 +3469,10 @@ static void expand_vec_mul(TCGType type, unsigned v=
ece,
                   tcgv_vec_arg(t3), tcgv_vec_arg(v1), tcgv_vec_arg(t4));
         vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_UB,
                   tcgv_vec_arg(t4), tcgv_vec_arg(t4), tcgv_vec_arg(v2));
-        tcg_gen_mul_vec(MO_16, t1, t1, t2);
-        tcg_gen_mul_vec(MO_16, t3, t3, t4);
-        tcg_gen_shri_vec(MO_16, t1, t1, 8);
-        tcg_gen_shri_vec(MO_16, t3, t3, 8);
+        tcg_gen_mul_vec(MO_UW, t1, t1, t2);
+        tcg_gen_mul_vec(MO_UW, t3, t3, t4);
+        tcg_gen_shri_vec(MO_UW, t1, t1, 8);
+        tcg_gen_shri_vec(MO_UW, t3, t3, 8);
         vec_gen_3(INDEX_op_x86_packus_vec, type, MO_UB,
                   tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(t3));
         tcg_temp_free_vec(t1);
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index c6d13ea..1780cb1 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1383,7 +1383,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
     case MO_UB:
         i =3D tcg_out_call_iarg_reg8(s, i, l->datalo_reg);
         break;
-    case MO_16:
+    case MO_UW:
         i =3D tcg_out_call_iarg_reg16(s, i, l->datalo_reg);
         break;
     case MO_32:
@@ -1570,12 +1570,12 @@ static void tcg_out_qemu_st_direct(TCGContext *s, T=
CGReg lo, TCGReg hi,
         tcg_out_opc_imm(s, OPC_SB, lo, base, 0);
         break;

-    case MO_16 | MO_BSWAP:
+    case MO_UW | MO_BSWAP:
         tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP1, lo, 0xffff);
         tcg_out_bswap16(s, TCG_TMP1, TCG_TMP1);
         lo =3D TCG_TMP1;
         /* FALLTHRU */
-    case MO_16:
+    case MO_UW:
         tcg_out_opc_imm(s, OPC_SH, lo, base, 0);
         break;

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 9c60c0f..20bc19d 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1104,7 +1104,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
     case MO_UB:
         tcg_out_ext8u(s, a2, a2);
         break;
-    case MO_16:
+    case MO_UW:
         tcg_out_ext16u(s, a2, a2);
         break;
     default:
@@ -1219,7 +1219,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
Reg lo, TCGReg hi,
     case MO_UB:
         tcg_out_opc_store(s, OPC_SB, base, lo, 0);
         break;
-    case MO_16:
+    case MO_UW:
         tcg_out_opc_store(s, OPC_SH, base, lo, 0);
         break;
     case MO_32:
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 479ee2e..85550b5 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -885,7 +885,7 @@ static void emit_extend(TCGContext *s, TCGReg r, int op=
)
     case MO_UB:
         tcg_out_arithi(s, r, r, 0xff, ARITH_AND);
         break;
-    case MO_16:
+    case MO_UW:
         tcg_out_arithi(s, r, r, 16, SHIFT_SLL);
         tcg_out_arithi(s, r, r, 16, SHIFT_SRL);
         break;
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 9658c36..da409f5 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -308,7 +308,7 @@ uint64_t (dup_const)(unsigned vece, uint64_t c)
     switch (vece) {
     case MO_UB:
         return 0x0101010101010101ull * (uint8_t)c;
-    case MO_16:
+    case MO_UW:
         return 0x0001000100010001ull * (uint16_t)c;
     case MO_32:
         return 0x0000000100000001ull * (uint32_t)c;
@@ -327,7 +327,7 @@ static void gen_dup_i32(unsigned vece, TCGv_i32 out, TC=
Gv_i32 in)
         tcg_gen_ext8u_i32(out, in);
         tcg_gen_muli_i32(out, out, 0x01010101);
         break;
-    case MO_16:
+    case MO_UW:
         tcg_gen_deposit_i32(out, in, in, 16, 16);
         break;
     case MO_32:
@@ -345,7 +345,7 @@ static void gen_dup_i64(unsigned vece, TCGv_i64 out, TC=
Gv_i64 in)
         tcg_gen_ext8u_i64(out, in);
         tcg_gen_muli_i64(out, out, 0x0101010101010101ull);
         break;
-    case MO_16:
+    case MO_UW:
         tcg_gen_ext16u_i64(out, in);
         tcg_gen_muli_i64(out, out, 0x0001000100010001ull);
         break;
@@ -558,7 +558,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32=
_t oprsz,
                 tcg_gen_extrl_i64_i32(t_32, in_64);
             } else if (vece =3D=3D MO_UB) {
                 tcg_gen_movi_i32(t_32, in_c & 0xff);
-            } else if (vece =3D=3D MO_16) {
+            } else if (vece =3D=3D MO_UW) {
                 tcg_gen_movi_i32(t_32, in_c & 0xffff);
             } else {
                 tcg_gen_movi_i32(t_32, in_c);
@@ -1459,7 +1459,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dof=
s, uint32_t aofs,
             case MO_UB:
                 tcg_gen_ld8u_i32(in, cpu_env, aofs);
                 break;
-            case MO_16:
+            case MO_UW:
                 tcg_gen_ld16u_i32(in, cpu_env, aofs);
                 break;
             default:
@@ -1526,7 +1526,7 @@ void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t oprs=
z,
                          uint32_t maxsz, uint16_t x)
 {
     check_size_align(oprsz, maxsz, dofs);
-    do_dup(MO_16, dofs, oprsz, maxsz, NULL, NULL, x);
+    do_dup(MO_UW, dofs, oprsz, maxsz, NULL, NULL, x);
 }

 void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t oprsz,
@@ -1579,7 +1579,7 @@ void tcg_gen_vec_add8_i64(TCGv_i64 d, TCGv_i64 a, TCG=
v_i64 b)

 void tcg_gen_vec_add16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_16, 0x8000));
+    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_UW, 0x8000));
     gen_addv_mask(d, a, b, m);
     tcg_temp_free_i64(m);
 }
@@ -1613,7 +1613,7 @@ void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, u=
int32_t aofs,
           .fniv =3D tcg_gen_add_vec,
           .fno =3D gen_helper_gvec_add16,
           .opt_opc =3D vecop_list_add,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_add_i32,
           .fniv =3D tcg_gen_add_vec,
           .fno =3D gen_helper_gvec_add32,
@@ -1644,7 +1644,7 @@ void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_add_vec,
           .fno =3D gen_helper_gvec_adds16,
           .opt_opc =3D vecop_list_add,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_add_i32,
           .fniv =3D tcg_gen_add_vec,
           .fno =3D gen_helper_gvec_adds32,
@@ -1685,7 +1685,7 @@ void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_gvec_subs16,
           .opt_opc =3D vecop_list_sub,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_sub_i32,
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_gvec_subs32,
@@ -1732,7 +1732,7 @@ void tcg_gen_vec_sub8_i64(TCGv_i64 d, TCGv_i64 a, TCG=
v_i64 b)

 void tcg_gen_vec_sub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_16, 0x8000));
+    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_UW, 0x8000));
     gen_subv_mask(d, a, b, m);
     tcg_temp_free_i64(m);
 }
@@ -1764,7 +1764,7 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, u=
int32_t aofs,
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_gvec_sub16,
           .opt_opc =3D vecop_list_sub,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_sub_i32,
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_gvec_sub32,
@@ -1795,7 +1795,7 @@ void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, u=
int32_t aofs,
         { .fniv =3D tcg_gen_mul_vec,
           .fno =3D gen_helper_gvec_mul16,
           .opt_opc =3D vecop_list_mul,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_mul_i32,
           .fniv =3D tcg_gen_mul_vec,
           .fno =3D gen_helper_gvec_mul32,
@@ -1824,7 +1824,7 @@ void tcg_gen_gvec_muls(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_mul_vec,
           .fno =3D gen_helper_gvec_muls16,
           .opt_opc =3D vecop_list_mul,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_mul_i32,
           .fniv =3D tcg_gen_mul_vec,
           .fno =3D gen_helper_gvec_muls32,
@@ -1862,7 +1862,7 @@ void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
         { .fniv =3D tcg_gen_ssadd_vec,
           .fno =3D gen_helper_gvec_ssadd16,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fniv =3D tcg_gen_ssadd_vec,
           .fno =3D gen_helper_gvec_ssadd32,
           .opt_opc =3D vecop_list,
@@ -1888,7 +1888,7 @@ void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
         { .fniv =3D tcg_gen_sssub_vec,
           .fno =3D gen_helper_gvec_sssub16,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fniv =3D tcg_gen_sssub_vec,
           .fno =3D gen_helper_gvec_sssub32,
           .opt_opc =3D vecop_list,
@@ -1930,7 +1930,7 @@ void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
         { .fniv =3D tcg_gen_usadd_vec,
           .fno =3D gen_helper_gvec_usadd16,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_usadd_i32,
           .fniv =3D tcg_gen_usadd_vec,
           .fno =3D gen_helper_gvec_usadd32,
@@ -1974,7 +1974,7 @@ void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
         { .fniv =3D tcg_gen_ussub_vec,
           .fno =3D gen_helper_gvec_ussub16,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_ussub_i32,
           .fniv =3D tcg_gen_ussub_vec,
           .fno =3D gen_helper_gvec_ussub32,
@@ -2002,7 +2002,7 @@ void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_smin_vec,
           .fno =3D gen_helper_gvec_smin16,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_smin_i32,
           .fniv =3D tcg_gen_smin_vec,
           .fno =3D gen_helper_gvec_smin32,
@@ -2030,7 +2030,7 @@ void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_umin_vec,
           .fno =3D gen_helper_gvec_umin16,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_umin_i32,
           .fniv =3D tcg_gen_umin_vec,
           .fno =3D gen_helper_gvec_umin32,
@@ -2058,7 +2058,7 @@ void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_smax_vec,
           .fno =3D gen_helper_gvec_smax16,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_smax_i32,
           .fniv =3D tcg_gen_smax_vec,
           .fno =3D gen_helper_gvec_smax32,
@@ -2086,7 +2086,7 @@ void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_umax_vec,
           .fno =3D gen_helper_gvec_umax16,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_umax_i32,
           .fniv =3D tcg_gen_umax_vec,
           .fno =3D gen_helper_gvec_umax32,
@@ -2127,7 +2127,7 @@ void tcg_gen_vec_neg8_i64(TCGv_i64 d, TCGv_i64 b)

 void tcg_gen_vec_neg16_i64(TCGv_i64 d, TCGv_i64 b)
 {
-    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_16, 0x8000));
+    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_UW, 0x8000));
     gen_negv_mask(d, b, m);
     tcg_temp_free_i64(m);
 }
@@ -2160,7 +2160,7 @@ void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, u=
int32_t aofs,
           .fniv =3D tcg_gen_neg_vec,
           .fno =3D gen_helper_gvec_neg16,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_neg_i32,
           .fniv =3D tcg_gen_neg_vec,
           .fno =3D gen_helper_gvec_neg32,
@@ -2206,7 +2206,7 @@ static void tcg_gen_vec_abs8_i64(TCGv_i64 d, TCGv_i64=
 b)

 static void tcg_gen_vec_abs16_i64(TCGv_i64 d, TCGv_i64 b)
 {
-    gen_absv_mask(d, b, MO_16);
+    gen_absv_mask(d, b, MO_UW);
 }

 void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -2223,7 +2223,7 @@ void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, u=
int32_t aofs,
           .fniv =3D tcg_gen_abs_vec,
           .fno =3D gen_helper_gvec_abs16,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_abs_i32,
           .fniv =3D tcg_gen_abs_vec,
           .fno =3D gen_helper_gvec_abs32,
@@ -2461,7 +2461,7 @@ void tcg_gen_vec_shl8i_i64(TCGv_i64 d, TCGv_i64 a, in=
t64_t c)

 void tcg_gen_vec_shl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
 {
-    uint64_t mask =3D dup_const(MO_16, 0xffff << c);
+    uint64_t mask =3D dup_const(MO_UW, 0xffff << c);
     tcg_gen_shli_i64(d, a, c);
     tcg_gen_andi_i64(d, d, mask);
 }
@@ -2480,7 +2480,7 @@ void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_shli_vec,
           .fno =3D gen_helper_gvec_shl16i,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_shli_i32,
           .fniv =3D tcg_gen_shli_vec,
           .fno =3D gen_helper_gvec_shl32i,
@@ -2512,7 +2512,7 @@ void tcg_gen_vec_shr8i_i64(TCGv_i64 d, TCGv_i64 a, in=
t64_t c)

 void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
 {
-    uint64_t mask =3D dup_const(MO_16, 0xffff >> c);
+    uint64_t mask =3D dup_const(MO_UW, 0xffff >> c);
     tcg_gen_shri_i64(d, a, c);
     tcg_gen_andi_i64(d, d, mask);
 }
@@ -2531,7 +2531,7 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_shri_vec,
           .fno =3D gen_helper_gvec_shr16i,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_shri_i32,
           .fniv =3D tcg_gen_shri_vec,
           .fno =3D gen_helper_gvec_shr32i,
@@ -2570,8 +2570,8 @@ void tcg_gen_vec_sar8i_i64(TCGv_i64 d, TCGv_i64 a, in=
t64_t c)

 void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
 {
-    uint64_t s_mask =3D dup_const(MO_16, 0x8000 >> c);
-    uint64_t c_mask =3D dup_const(MO_16, 0xffff >> c);
+    uint64_t s_mask =3D dup_const(MO_UW, 0x8000 >> c);
+    uint64_t c_mask =3D dup_const(MO_UW, 0xffff >> c);
     TCGv_i64 s =3D tcg_temp_new_i64();

     tcg_gen_shri_i64(d, a, c);
@@ -2596,7 +2596,7 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_sari_vec,
           .fno =3D gen_helper_gvec_sar16i,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_sari_i32,
           .fniv =3D tcg_gen_sari_vec,
           .fno =3D gen_helper_gvec_sar32i,
@@ -2884,7 +2884,7 @@ void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_shlv_mod_vec,
           .fno =3D gen_helper_gvec_shl16v,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_shl_mod_i32,
           .fniv =3D tcg_gen_shlv_mod_vec,
           .fno =3D gen_helper_gvec_shl32v,
@@ -2947,7 +2947,7 @@ void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_shrv_mod_vec,
           .fno =3D gen_helper_gvec_shr16v,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_shr_mod_i32,
           .fniv =3D tcg_gen_shrv_mod_vec,
           .fno =3D gen_helper_gvec_shr32v,
@@ -3010,7 +3010,7 @@ void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_sarv_mod_vec,
           .fno =3D gen_helper_gvec_sar16v,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_16 },
+          .vece =3D MO_UW },
         { .fni4 =3D tcg_gen_sar_mod_i32,
           .fniv =3D tcg_gen_sarv_mod_vec,
           .fno =3D gen_helper_gvec_sar32v,
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index d7ffc9e..b0a4d98 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -270,7 +270,7 @@ void tcg_gen_dup32i_vec(TCGv_vec r, uint32_t a)

 void tcg_gen_dup16i_vec(TCGv_vec r, uint32_t a)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_16, a));
+    do_dupi_vec(r, MO_REG, dup_const(MO_UW, a));
 }

 void tcg_gen_dup8i_vec(TCGv_vec r, uint32_t a)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 61eda33..21d448c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2723,7 +2723,7 @@ static inline TCGMemOp tcg_canonicalize_memop(TCGMemO=
p op, bool is64, bool st)
     case MO_UB:
         op &=3D ~MO_BSWAP;
         break;
-    case MO_16:
+    case MO_UW:
         break;
     case MO_32:
         if (!is64) {
@@ -2810,7 +2810,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)

     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
-        case MO_16:
+        case MO_UW:
             tcg_gen_bswap16_i32(val, val);
             if (orig_memop & MO_SIGN) {
                 tcg_gen_ext16s_i32(val, val);
@@ -2837,7 +2837,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         swap =3D tcg_temp_new_i32();
         switch (memop & MO_SIZE) {
-        case MO_16:
+        case MO_UW:
             tcg_gen_ext16u_i32(swap, val);
             tcg_gen_bswap16_i32(swap, swap);
             break;
@@ -2890,7 +2890,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)

     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
-        case MO_16:
+        case MO_UW:
             tcg_gen_bswap16_i64(val, val);
             if (orig_memop & MO_SIGN) {
                 tcg_gen_ext16s_i64(val, val);
@@ -2928,7 +2928,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         swap =3D tcg_temp_new_i64();
         switch (memop & MO_SIZE) {
-        case MO_16:
+        case MO_UW:
             tcg_gen_ext16u_i64(swap, val);
             tcg_gen_bswap16_i64(swap, swap);
             break;
@@ -3025,8 +3025,8 @@ typedef void (*gen_atomic_op_i64)(TCGv_i64, TCGv_env,=
 TCGv, TCGv_i64);

 static void * const table_cmpxchg[16] =3D {
     [MO_UB] =3D gen_helper_atomic_cmpxchgb,
-    [MO_16 | MO_LE] =3D gen_helper_atomic_cmpxchgw_le,
-    [MO_16 | MO_BE] =3D gen_helper_atomic_cmpxchgw_be,
+    [MO_UW | MO_LE] =3D gen_helper_atomic_cmpxchgw_le,
+    [MO_UW | MO_BE] =3D gen_helper_atomic_cmpxchgw_be,
     [MO_32 | MO_LE] =3D gen_helper_atomic_cmpxchgl_le,
     [MO_32 | MO_BE] =3D gen_helper_atomic_cmpxchgl_be,
     WITH_ATOMIC64([MO_64 | MO_LE] =3D gen_helper_atomic_cmpxchgq_le)
@@ -3249,8 +3249,8 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr,=
 TCGv_i64 val,
 #define GEN_ATOMIC_HELPER(NAME, OP, NEW)                                \
 static void * const table_##NAME[16] =3D {                                =
\
     [MO_UB] =3D gen_helper_atomic_##NAME##b,                              =
 \
-    [MO_16 | MO_LE] =3D gen_helper_atomic_##NAME##w_le,                   =
\
-    [MO_16 | MO_BE] =3D gen_helper_atomic_##NAME##w_be,                   =
\
+    [MO_UW | MO_LE] =3D gen_helper_atomic_##NAME##w_le,                   =
\
+    [MO_UW | MO_BE] =3D gen_helper_atomic_##NAME##w_be,                   =
\
     [MO_32 | MO_LE] =3D gen_helper_atomic_##NAME##l_le,                   =
\
     [MO_32 | MO_BE] =3D gen_helper_atomic_##NAME##l_be,                   =
\
     WITH_ATOMIC64([MO_64 | MO_LE] =3D gen_helper_atomic_##NAME##q_le)     =
\
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 5636d6b..a378887 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1303,7 +1303,7 @@ uint64_t dup_const(unsigned vece, uint64_t c);
 #define dup_const(VECE, C)                                         \
     (__builtin_constant_p(VECE)                                    \
      ?   ((VECE) =3D=3D MO_UB ? 0x0101010101010101ull * (uint8_t)(C)   \
-        : (VECE) =3D=3D MO_16 ? 0x0001000100010001ull * (uint16_t)(C)  \
+        : (VECE) =3D=3D MO_UW ? 0x0001000100010001ull * (uint16_t)(C)  \
         : (VECE) =3D=3D MO_32 ? 0x0000000100000001ull * (uint32_t)(C)  \
         : dup_const(VECE, C))                                      \
      : dup_const(VECE, C))
--
1.8.3.1



