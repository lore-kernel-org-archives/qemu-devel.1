Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AB8C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0B22190F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0B22190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpaSM-0003PS-FE
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 11:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52018)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hpaRt-0002bE-Ia
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hpaRj-0002UV-2j
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:42:01 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.76]:4359)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1hpaRi-0002TI-72
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:41:51 -0400
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 BWP09926081.bt.com (10.36.82.112) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Mon, 22
 Jul 2019 16:41:46 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18e.domain1.systemhost.net (10.9.212.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Mon, 22 Jul 2019 16:41:47 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Mon, 22 Jul
 2019 16:41:47 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 03/20] tcg: Replace MO_32 with MO_UL alias
Thread-Index: AQHVQKP47nfq9GamtU2q8ZXtYPwq2Q==
Date: Mon, 22 Jul 2019 15:41:47 +0000
Message-ID: <1563810105644.28725@bt.com>
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
X-Received-From: 213.121.35.76
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v2 03/20] tcg: Replace MO_32 with MO_UL alias
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

Preparation for splitting MO_32 out from TCGMemOp into new accelerator
independent MemOp.

As MO_32 will be a value of MemOp, existing TCGMemOp comparisons and
coercions will trigger -Wenum-compare and -Wenum-conversion.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 target/arm/sve_helper.c             |   6 +-
 target/arm/translate-a64.c          | 148 +++++++++++++++++---------------=
---
 target/arm/translate-sve.c          |  12 +--
 target/arm/translate-vfp.inc.c      |   4 +-
 target/arm/translate.c              |  34 ++++----
 target/i386/translate.c             | 150 ++++++++++++++++++--------------=
----
 target/ppc/translate/vmx-impl.inc.c |  28 +++----
 target/ppc/translate/vsx-impl.inc.c |   4 +-
 target/s390x/translate.c            |   4 +-
 target/s390x/translate_vx.inc.c     |   2 +-
 target/s390x/vec.h                  |   4 +-
 tcg/aarch64/tcg-target.inc.c        |  20 ++---
 tcg/arm/tcg-target.inc.c            |   6 +-
 tcg/i386/tcg-target.inc.c           |  28 +++----
 tcg/mips/tcg-target.inc.c           |   6 +-
 tcg/ppc/tcg-target.inc.c            |   2 +-
 tcg/riscv/tcg-target.inc.c          |   2 +-
 tcg/sparc/tcg-target.inc.c          |   2 +-
 tcg/tcg-op-gvec.c                   |  64 +++++++--------
 tcg/tcg-op-vec.c                    |   6 +-
 tcg/tcg-op.c                        |  18 ++---
 tcg/tcg.h                           |   2 +-
 22 files changed, 276 insertions(+), 276 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index f6bef3d..fa705c4 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1561,7 +1561,7 @@ void HELPER(sve_cpy_m_s)(void *vd, void *vn, void *vg=
,
     uint64_t *d =3D vd, *n =3D vn;
     uint8_t *pg =3D vg;

-    mm =3D dup_const(MO_32, mm);
+    mm =3D dup_const(MO_UL, mm);
     for (i =3D 0; i < opr_sz; i +=3D 1) {
         uint64_t nn =3D n[i];
         uint64_t pp =3D expand_pred_s(pg[H1(i)]);
@@ -1612,7 +1612,7 @@ void HELPER(sve_cpy_z_s)(void *vd, void *vg, uint64_t=
 val, uint32_t desc)
     uint64_t *d =3D vd;
     uint8_t *pg =3D vg;

-    val =3D dup_const(MO_32, val);
+    val =3D dup_const(MO_UL, val);
     for (i =3D 0; i < opr_sz; i +=3D 1) {
         d[i] =3D val & expand_pred_s(pg[H1(i)]);
     }
@@ -5123,7 +5123,7 @@ static inline void sve_ldff1_zs(CPUARMState *env, voi=
d *vd, void *vg, void *vm,
     target_ulong addr;

     /* Skip to the first true predicate.  */
-    reg_off =3D find_next_active(vg, 0, reg_max, MO_32);
+    reg_off =3D find_next_active(vg, 0, reg_max, MO_UL);
     if (likely(reg_off < reg_max)) {
         /* Perform one normal read, which will fault or not.  */
         set_helper_retaddr(ra);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 3acfccb..0b92e6d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -484,7 +484,7 @@ static TCGv_i32 read_fp_sreg(DisasContext *s, int reg)
 {
     TCGv_i32 v =3D tcg_temp_new_i32();

-    tcg_gen_ld_i32(v, cpu_env, fp_reg_offset(s, reg, MO_32));
+    tcg_gen_ld_i32(v, cpu_env, fp_reg_offset(s, reg, MO_UL));
     return v;
 }

@@ -999,7 +999,7 @@ static void read_vec_element(DisasContext *s, TCGv_i64 =
tcg_dest, int srcidx,
     case MO_UW:
         tcg_gen_ld16u_i64(tcg_dest, cpu_env, vect_off);
         break;
-    case MO_32:
+    case MO_UL:
         tcg_gen_ld32u_i64(tcg_dest, cpu_env, vect_off);
         break;
     case MO_SB:
@@ -1008,7 +1008,7 @@ static void read_vec_element(DisasContext *s, TCGv_i6=
4 tcg_dest, int srcidx,
     case MO_SW:
         tcg_gen_ld16s_i64(tcg_dest, cpu_env, vect_off);
         break;
-    case MO_32|MO_SIGN:
+    case MO_SL:
         tcg_gen_ld32s_i64(tcg_dest, cpu_env, vect_off);
         break;
     case MO_64:
@@ -1037,8 +1037,8 @@ static void read_vec_element_i32(DisasContext *s, TCG=
v_i32 tcg_dest, int srcidx,
     case MO_SW:
         tcg_gen_ld16s_i32(tcg_dest, cpu_env, vect_off);
         break;
-    case MO_32:
-    case MO_32|MO_SIGN:
+    case MO_UL:
+    case MO_SL:
         tcg_gen_ld_i32(tcg_dest, cpu_env, vect_off);
         break;
     default:
@@ -1058,7 +1058,7 @@ static void write_vec_element(DisasContext *s, TCGv_i=
64 tcg_src, int destidx,
     case MO_UW:
         tcg_gen_st16_i64(tcg_src, cpu_env, vect_off);
         break;
-    case MO_32:
+    case MO_UL:
         tcg_gen_st32_i64(tcg_src, cpu_env, vect_off);
         break;
     case MO_64:
@@ -1080,7 +1080,7 @@ static void write_vec_element_i32(DisasContext *s, TC=
Gv_i32 tcg_src,
     case MO_UW:
         tcg_gen_st16_i32(tcg_src, cpu_env, vect_off);
         break;
-    case MO_32:
+    case MO_UL:
         tcg_gen_st_i32(tcg_src, cpu_env, vect_off);
         break;
     default:
@@ -5299,7 +5299,7 @@ static void handle_fp_compare(DisasContext *s, int si=
ze,
         }

         switch (size) {
-        case MO_32:
+        case MO_UL:
             if (signal_all_nans) {
                 gen_helper_vfp_cmpes_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
             } else {
@@ -5354,7 +5354,7 @@ static void disas_fp_compare(DisasContext *s, uint32_=
t insn)

     switch (type) {
     case 0:
-        size =3D MO_32;
+        size =3D MO_UL;
         break;
     case 1:
         size =3D MO_64;
@@ -5405,7 +5405,7 @@ static void disas_fp_ccomp(DisasContext *s, uint32_t =
insn)

     switch (type) {
     case 0:
-        size =3D MO_32;
+        size =3D MO_UL;
         break;
     case 1:
         size =3D MO_64;
@@ -5471,7 +5471,7 @@ static void disas_fp_csel(DisasContext *s, uint32_t i=
nsn)

     switch (type) {
     case 0:
-        sz =3D MO_32;
+        sz =3D MO_UL;
         break;
     case 1:
         sz =3D MO_64;
@@ -6276,7 +6276,7 @@ static void disas_fp_imm(DisasContext *s, uint32_t in=
sn)

     switch (type) {
     case 0:
-        sz =3D MO_32;
+        sz =3D MO_UL;
         break;
     case 1:
         sz =3D MO_64;
@@ -6581,7 +6581,7 @@ static void handle_fmov(DisasContext *s, int rd, int =
rn, int type, bool itof)
         switch (type) {
         case 0:
             /* 32 bit */
-            tcg_gen_ld32u_i64(tcg_rd, cpu_env, fp_reg_offset(s, rn, MO_32)=
);
+            tcg_gen_ld32u_i64(tcg_rd, cpu_env, fp_reg_offset(s, rn, MO_UL)=
);
             break;
         case 1:
             /* 64 bit */
@@ -7030,7 +7030,7 @@ static TCGv_i32 do_reduction_op(DisasContext *s, int =
fpopcode, int rn,
 {
     if (esize =3D=3D size) {
         int element;
-        TCGMemOp msize =3D esize =3D=3D 16 ? MO_UW : MO_32;
+        TCGMemOp msize =3D esize =3D=3D 16 ? MO_UW : MO_UL;
         TCGv_i32 tcg_elem;

         /* We should have one register left here */
@@ -7702,7 +7702,7 @@ static void disas_simd_scalar_pairwise(DisasContext *=
s, uint32_t insn)
                 size =3D MO_UW;
             }
         } else {
-            size =3D extract32(size, 0, 1) ? MO_64 : MO_32;
+            size =3D extract32(size, 0, 1) ? MO_64 : MO_UL;
         }

         if (!fp_access_check(s)) {
@@ -8181,7 +8181,7 @@ static void handle_simd_qshl(DisasContext *s, bool sc=
alar, bool is_q,
             }
         };
         NeonGenTwoOpEnvFn *genfn =3D fns[src_unsigned][dst_unsigned][size]=
;
-        TCGMemOp memop =3D scalar ? size : MO_32;
+        TCGMemOp memop =3D scalar ? size : MO_UL;
         int maxpass =3D scalar ? 1 : is_q ? 4 : 2;

         for (pass =3D 0; pass < maxpass; pass++) {
@@ -8204,7 +8204,7 @@ static void handle_simd_qshl(DisasContext *s, bool sc=
alar, bool is_q,
                 }
                 write_fp_sreg(s, rd, tcg_op);
             } else {
-                write_vec_element_i32(s, tcg_op, rd, pass, MO_32);
+                write_vec_element_i32(s, tcg_op, rd, pass, MO_UL);
             }

             tcg_temp_free_i32(tcg_op);
@@ -8264,7 +8264,7 @@ static void handle_simd_intfp_conv(DisasContext *s, i=
nt rd, int rn,
             read_vec_element_i32(s, tcg_int32, rn, pass, mop);

             switch (size) {
-            case MO_32:
+            case MO_UL:
                 if (fracbits) {
                     if (is_signed) {
                         gen_helper_vfp_sltos(tcg_float, tcg_int32,
@@ -8337,7 +8337,7 @@ static void handle_simd_shift_intfp_conv(DisasContext=
 *s, bool is_scalar,
             return;
         }
     } else if (immh & 4) {
-        size =3D MO_32;
+        size =3D MO_UL;
     } else if (immh & 2) {
         size =3D MO_UW;
         if (!dc_isar_feature(aa64_fp16, s)) {
@@ -8382,7 +8382,7 @@ static void handle_simd_shift_fpint_conv(DisasContext=
 *s, bool is_scalar,
             return;
         }
     } else if (immh & 0x4) {
-        size =3D MO_32;
+        size =3D MO_UL;
     } else if (immh & 0x2) {
         size =3D MO_UW;
         if (!dc_isar_feature(aa64_fp16, s)) {
@@ -8436,7 +8436,7 @@ static void handle_simd_shift_fpint_conv(DisasContext=
 *s, bool is_scalar,
                 fn =3D gen_helper_vfp_toshh;
             }
             break;
-        case MO_32:
+        case MO_UL:
             if (is_u) {
                 fn =3D gen_helper_vfp_touls;
             } else {
@@ -8588,8 +8588,8 @@ static void disas_simd_scalar_three_reg_diff(DisasCon=
text *s, uint32_t insn)
         TCGv_i64 tcg_op2 =3D tcg_temp_new_i64();
         TCGv_i64 tcg_res =3D tcg_temp_new_i64();

-        read_vec_element(s, tcg_op1, rn, 0, MO_32 | MO_SIGN);
-        read_vec_element(s, tcg_op2, rm, 0, MO_32 | MO_SIGN);
+        read_vec_element(s, tcg_op1, rn, 0, MO_SL);
+        read_vec_element(s, tcg_op2, rm, 0, MO_SL);

         tcg_gen_mul_i64(tcg_res, tcg_op1, tcg_op2);
         gen_helper_neon_addl_saturate_s64(tcg_res, cpu_env, tcg_res, tcg_r=
es);
@@ -8631,7 +8631,7 @@ static void disas_simd_scalar_three_reg_diff(DisasCon=
text *s, uint32_t insn)
         case 0x9: /* SQDMLAL, SQDMLAL2 */
         {
             TCGv_i64 tcg_op3 =3D tcg_temp_new_i64();
-            read_vec_element(s, tcg_op3, rd, 0, MO_32);
+            read_vec_element(s, tcg_op3, rd, 0, MO_UL);
             gen_helper_neon_addl_saturate_s32(tcg_res, cpu_env,
                                               tcg_res, tcg_op3);
             tcg_temp_free_i64(tcg_op3);
@@ -8831,8 +8831,8 @@ static void handle_3same_float(DisasContext *s, int s=
ize, int elements,
             TCGv_i32 tcg_op2 =3D tcg_temp_new_i32();
             TCGv_i32 tcg_res =3D tcg_temp_new_i32();

-            read_vec_element_i32(s, tcg_op1, rn, pass, MO_32);
-            read_vec_element_i32(s, tcg_op2, rm, pass, MO_32);
+            read_vec_element_i32(s, tcg_op1, rn, pass, MO_UL);
+            read_vec_element_i32(s, tcg_op2, rm, pass, MO_UL);

             switch (fpopcode) {
             case 0x39: /* FMLS */
@@ -8840,7 +8840,7 @@ static void handle_3same_float(DisasContext *s, int s=
ize, int elements,
                 gen_helper_vfp_negs(tcg_op1, tcg_op1);
                 /* fall through */
             case 0x19: /* FMLA */
-                read_vec_element_i32(s, tcg_res, rd, pass, MO_32);
+                read_vec_element_i32(s, tcg_res, rd, pass, MO_UL);
                 gen_helper_vfp_muladds(tcg_res, tcg_op1, tcg_op2,
                                        tcg_res, fpst);
                 break;
@@ -8908,7 +8908,7 @@ static void handle_3same_float(DisasContext *s, int s=
ize, int elements,
                 write_vec_element(s, tcg_tmp, rd, pass, MO_64);
                 tcg_temp_free_i64(tcg_tmp);
             } else {
-                write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
+                write_vec_element_i32(s, tcg_res, rd, pass, MO_UL);
             }

             tcg_temp_free_i32(tcg_res);
@@ -9557,7 +9557,7 @@ static void handle_2misc_reciprocal(DisasContext *s, =
int opcode,
         }

         for (pass =3D 0; pass < maxpasses; pass++) {
-            read_vec_element_i32(s, tcg_op, rn, pass, MO_32);
+            read_vec_element_i32(s, tcg_op, rn, pass, MO_UL);

             switch (opcode) {
             case 0x3c: /* URECPE */
@@ -9579,7 +9579,7 @@ static void handle_2misc_reciprocal(DisasContext *s, =
int opcode,
             if (is_scalar) {
                 write_fp_sreg(s, rd, tcg_res);
             } else {
-                write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
+                write_vec_element_i32(s, tcg_res, rd, pass, MO_UL);
             }
         }
         tcg_temp_free_i32(tcg_res);
@@ -9693,7 +9693,7 @@ static void handle_2misc_narrow(DisasContext *s, bool=
 scalar,
     }

     for (pass =3D 0; pass < 2; pass++) {
-        write_vec_element_i32(s, tcg_res[pass], rd, destelt + pass, MO_32)=
;
+        write_vec_element_i32(s, tcg_res[pass], rd, destelt + pass, MO_UL)=
;
         tcg_temp_free_i32(tcg_res[pass]);
     }
     clear_vec_high(s, is_q, rd);
@@ -9740,8 +9740,8 @@ static void handle_2misc_satacc(DisasContext *s, bool=
 is_scalar, bool is_u,
                 read_vec_element_i32(s, tcg_rn, rn, pass, size);
                 read_vec_element_i32(s, tcg_rd, rd, pass, size);
             } else {
-                read_vec_element_i32(s, tcg_rn, rn, pass, MO_32);
-                read_vec_element_i32(s, tcg_rd, rd, pass, MO_32);
+                read_vec_element_i32(s, tcg_rn, rn, pass, MO_UL);
+                read_vec_element_i32(s, tcg_rd, rd, pass, MO_UL);
             }

             if (is_u) { /* USQADD */
@@ -9779,7 +9779,7 @@ static void handle_2misc_satacc(DisasContext *s, bool=
 is_scalar, bool is_u,
                 write_vec_element(s, tcg_zero, rd, 0, MO_64);
                 tcg_temp_free_i64(tcg_zero);
             }
-            write_vec_element_i32(s, tcg_rd, rd, pass, MO_32);
+            write_vec_element_i32(s, tcg_rd, rd, pass, MO_UL);
         }
         tcg_temp_free_i32(tcg_rd);
         tcg_temp_free_i32(tcg_rn);
@@ -10347,7 +10347,7 @@ static void handle_3rd_widening(DisasContext *s, in=
t is_q, int is_u, int size,
             TCGv_i64 tcg_op1 =3D tcg_temp_new_i64();
             TCGv_i64 tcg_op2 =3D tcg_temp_new_i64();
             TCGv_i64 tcg_passres;
-            TCGMemOp memop =3D MO_32 | (is_u ? 0 : MO_SIGN);
+            TCGMemOp memop =3D is_u ? MO_UL : MO_SL;

             int elt =3D pass + is_q * 2;

@@ -10426,8 +10426,8 @@ static void handle_3rd_widening(DisasContext *s, in=
t is_q, int is_u, int size,
             TCGv_i64 tcg_passres;
             int elt =3D pass + is_q * 2;

-            read_vec_element_i32(s, tcg_op1, rn, elt, MO_32);
-            read_vec_element_i32(s, tcg_op2, rm, elt, MO_32);
+            read_vec_element_i32(s, tcg_op1, rn, elt, MO_UL);
+            read_vec_element_i32(s, tcg_op2, rm, elt, MO_UL);

             if (accop =3D=3D 0) {
                 tcg_passres =3D tcg_res[pass];
@@ -10547,7 +10547,7 @@ static void handle_3rd_wide(DisasContext *s, int is=
_q, int is_u, int size,
         NeonGenWidenFn *widenfn =3D widenfns[size][is_u];

         read_vec_element(s, tcg_op1, rn, pass, MO_64);
-        read_vec_element_i32(s, tcg_op2, rm, part + pass, MO_32);
+        read_vec_element_i32(s, tcg_op2, rm, part + pass, MO_UL);
         widenfn(tcg_op2_wide, tcg_op2);
         tcg_temp_free_i32(tcg_op2);
         tcg_res[pass] =3D tcg_temp_new_i64();
@@ -10603,7 +10603,7 @@ static void handle_3rd_narrowing(DisasContext *s, i=
nt is_q, int is_u, int size,
     }

     for (pass =3D 0; pass < 2; pass++) {
-        write_vec_element_i32(s, tcg_res[pass], rd, pass + part, MO_32);
+        write_vec_element_i32(s, tcg_res[pass], rd, pass + part, MO_UL);
         tcg_temp_free_i32(tcg_res[pass]);
     }
     clear_vec_high(s, is_q, rd);
@@ -10860,8 +10860,8 @@ static void handle_simd_3same_pair(DisasContext *s,=
 int is_q, int u, int opcode,
             int passreg =3D pass < (maxpass / 2) ? rn : rm;
             int passelt =3D (is_q && (pass & 1)) ? 2 : 0;

-            read_vec_element_i32(s, tcg_op1, passreg, passelt, MO_32);
-            read_vec_element_i32(s, tcg_op2, passreg, passelt + 1, MO_32);
+            read_vec_element_i32(s, tcg_op1, passreg, passelt, MO_UL);
+            read_vec_element_i32(s, tcg_op2, passreg, passelt + 1, MO_UL);
             tcg_res[pass] =3D tcg_temp_new_i32();

             switch (opcode) {
@@ -10925,7 +10925,7 @@ static void handle_simd_3same_pair(DisasContext *s,=
 int is_q, int u, int opcode,
         }

         for (pass =3D 0; pass < maxpass; pass++) {
-            write_vec_element_i32(s, tcg_res[pass], rd, pass, MO_32);
+            write_vec_element_i32(s, tcg_res[pass], rd, pass, MO_UL);
             tcg_temp_free_i32(tcg_res[pass]);
         }
         clear_vec_high(s, is_q, rd);
@@ -10971,7 +10971,7 @@ static void disas_simd_3same_float(DisasContext *s,=
 uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        handle_simd_3same_pair(s, is_q, 0, fpopcode, size ? MO_64 : MO_32,
+        handle_simd_3same_pair(s, is_q, 0, fpopcode, size ? MO_64 : MO_UL,
                                rn, rm, rd);
         return;
     case 0x1b: /* FMULX */
@@ -11174,8 +11174,8 @@ static void disas_simd_3same_int(DisasContext *s, u=
int32_t insn)
             NeonGenTwoOpFn *genfn =3D NULL;
             NeonGenTwoOpEnvFn *genenvfn =3D NULL;

-            read_vec_element_i32(s, tcg_op1, rn, pass, MO_32);
-            read_vec_element_i32(s, tcg_op2, rm, pass, MO_32);
+            read_vec_element_i32(s, tcg_op1, rn, pass, MO_UL);
+            read_vec_element_i32(s, tcg_op2, rm, pass, MO_UL);

             switch (opcode) {
             case 0x0: /* SHADD, UHADD */
@@ -11292,11 +11292,11 @@ static void disas_simd_3same_int(DisasContext *s,=
 uint32_t insn)
                     tcg_gen_add_i32,
                 };

-                read_vec_element_i32(s, tcg_op1, rd, pass, MO_32);
+                read_vec_element_i32(s, tcg_op1, rd, pass, MO_UL);
                 fns[size](tcg_res, tcg_op1, tcg_res);
             }

-            write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
+            write_vec_element_i32(s, tcg_res, rd, pass, MO_UL);

             tcg_temp_free_i32(tcg_res);
             tcg_temp_free_i32(tcg_op1);
@@ -11578,7 +11578,7 @@ static void disas_simd_three_reg_same_extra(DisasCo=
ntext *s, uint32_t insn)
         break;
     case 0x02: /* SDOT (vector) */
     case 0x12: /* UDOT (vector) */
-        if (size !=3D MO_32) {
+        if (size !=3D MO_UL) {
             unallocated_encoding(s);
             return;
         }
@@ -11709,7 +11709,7 @@ static void handle_2misc_widening(DisasContext *s, =
int opcode, bool is_q,
             TCGv_i32 tcg_op =3D tcg_temp_new_i32();
             tcg_res[pass] =3D tcg_temp_new_i64();

-            read_vec_element_i32(s, tcg_op, rn, srcelt + pass, MO_32);
+            read_vec_element_i32(s, tcg_op, rn, srcelt + pass, MO_UL);
             gen_helper_vfp_fcvtds(tcg_res[pass], tcg_op, cpu_env);
             tcg_temp_free_i32(tcg_op);
         }
@@ -11732,7 +11732,7 @@ static void handle_2misc_widening(DisasContext *s, =
int opcode, bool is_q,
                                            fpst, ahp);
         }
         for (pass =3D 0; pass < 4; pass++) {
-            write_vec_element_i32(s, tcg_res[pass], rd, pass, MO_32);
+            write_vec_element_i32(s, tcg_res[pass], rd, pass, MO_UL);
             tcg_temp_free_i32(tcg_res[pass]);
         }

@@ -11771,7 +11771,7 @@ static void handle_rev(DisasContext *s, int opcode,=
 bool u,
             case MO_UW:
                 tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
                 break;
-            case MO_32:
+            case MO_UL:
                 tcg_gen_bswap32_i64(tcg_tmp, tcg_tmp);
                 break;
             case MO_64:
@@ -11900,7 +11900,7 @@ static void handle_shll(DisasContext *s, bool is_q,=
 int size, int rn, int rd)
         NeonGenWidenFn *widenfn =3D widenfns[size];
         TCGv_i32 tcg_op =3D tcg_temp_new_i32();

-        read_vec_element_i32(s, tcg_op, rn, part + pass, MO_32);
+        read_vec_element_i32(s, tcg_op, rn, part + pass, MO_UL);
         tcg_res[pass] =3D tcg_temp_new_i64();
         widenfn(tcg_res[pass], tcg_op);
         tcg_gen_shli_i64(tcg_res[pass], tcg_res[pass], 8 << size);
@@ -12251,7 +12251,7 @@ static void disas_simd_two_reg_misc(DisasContext *s=
, uint32_t insn)
             TCGv_i32 tcg_res =3D tcg_temp_new_i32();
             TCGCond cond;

-            read_vec_element_i32(s, tcg_op, rn, pass, MO_32);
+            read_vec_element_i32(s, tcg_op, rn, pass, MO_UL);

             if (size =3D=3D 2) {
                 /* Special cases for 32 bit elements */
@@ -12418,7 +12418,7 @@ static void disas_simd_two_reg_misc(DisasContext *s=
, uint32_t insn)
                 }
             }

-            write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
+            write_vec_element_i32(s, tcg_res, rd, pass, MO_UL);

             tcg_temp_free_i32(tcg_res);
             tcg_temp_free_i32(tcg_op);
@@ -12816,7 +12816,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
         break;
     case 0x0e: /* SDOT */
     case 0x1e: /* UDOT */
-        if (is_scalar || size !=3D MO_32 || !dc_isar_feature(aa64_dp, s)) =
{
+        if (is_scalar || size !=3D MO_UL || !dc_isar_feature(aa64_dp, s)) =
{
             unallocated_encoding(s);
             return;
         }
@@ -12835,7 +12835,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
     case 0x04: /* FMLSL */
     case 0x18: /* FMLAL2 */
     case 0x1c: /* FMLSL2 */
-        if (is_scalar || size !=3D MO_32 || !dc_isar_feature(aa64_fhm, s))=
 {
+        if (is_scalar || size !=3D MO_UL || !dc_isar_feature(aa64_fhm, s))=
 {
             unallocated_encoding(s);
             return;
         }
@@ -12855,7 +12855,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
             size =3D MO_UW;
             is_fp16 =3D true;
             break;
-        case MO_32: /* single precision */
+        case MO_UL: /* single precision */
         case MO_64: /* double precision */
             break;
         default:
@@ -12868,7 +12868,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
         /* Each indexable element is a complex pair.  */
         size +=3D 1;
         switch (size) {
-        case MO_32:
+        case MO_UL:
             if (h && !is_q) {
                 unallocated_encoding(s);
                 return;
@@ -12902,7 +12902,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
     case MO_UW:
         index =3D h << 2 | l << 1 | m;
         break;
-    case MO_32:
+    case MO_UL:
         index =3D h << 1 | l;
         rm |=3D m << 4;
         break;
@@ -13038,7 +13038,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
             TCGv_i32 tcg_op =3D tcg_temp_new_i32();
             TCGv_i32 tcg_res =3D tcg_temp_new_i32();

-            read_vec_element_i32(s, tcg_op, rn, pass, is_scalar ? size : M=
O_32);
+            read_vec_element_i32(s, tcg_op, rn, pass, is_scalar ? size : M=
O_UL);

             switch (16 * u + opcode) {
             case 0x08: /* MUL */
@@ -13060,7 +13060,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
                 if (opcode =3D=3D 0x8) {
                     break;
                 }
-                read_vec_element_i32(s, tcg_op, rd, pass, MO_32);
+                read_vec_element_i32(s, tcg_op, rd, pass, MO_UL);
                 genfn =3D fns[size - 1][is_sub];
                 genfn(tcg_res, tcg_op, tcg_res);
                 break;
@@ -13068,7 +13068,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
             case 0x05: /* FMLS */
             case 0x01: /* FMLA */
                 read_vec_element_i32(s, tcg_res, rd, pass,
-                                     is_scalar ? size : MO_32);
+                                     is_scalar ? size : MO_UL);
                 switch (size) {
                 case 1:
                     if (opcode =3D=3D 0x5) {
@@ -13153,7 +13153,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
                 break;
             case 0x1d: /* SQRDMLAH */
                 read_vec_element_i32(s, tcg_res, rd, pass,
-                                     is_scalar ? size : MO_32);
+                                     is_scalar ? size : MO_UL);
                 if (size =3D=3D 1) {
                     gen_helper_neon_qrdmlah_s16(tcg_res, cpu_env,
                                                 tcg_op, tcg_idx, tcg_res);
@@ -13164,7 +13164,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
                 break;
             case 0x1f: /* SQRDMLSH */
                 read_vec_element_i32(s, tcg_res, rd, pass,
-                                     is_scalar ? size : MO_32);
+                                     is_scalar ? size : MO_UL);
                 if (size =3D=3D 1) {
                     gen_helper_neon_qrdmlsh_s16(tcg_res, cpu_env,
                                                 tcg_op, tcg_idx, tcg_res);
@@ -13180,7 +13180,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
             if (is_scalar) {
                 write_fp_sreg(s, rd, tcg_res);
             } else {
-                write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
+                write_vec_element_i32(s, tcg_res, rd, pass, MO_UL);
             }

             tcg_temp_free_i32(tcg_op);
@@ -13194,7 +13194,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
         TCGv_i64 tcg_res[2];
         int pass;
         bool satop =3D extract32(opcode, 0, 1);
-        TCGMemOp memop =3D MO_32;
+        TCGMemOp memop =3D MO_UL;

         if (satop || !u) {
             memop |=3D MO_SIGN;
@@ -13288,7 +13288,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
                     read_vec_element_i32(s, tcg_op, rn, pass, size);
                 } else {
                     read_vec_element_i32(s, tcg_op, rn,
-                                         pass + (is_q * 2), MO_32);
+                                         pass + (is_q * 2), MO_UL);
                 }

                 tcg_res[pass] =3D tcg_temp_new_i64();
@@ -13780,19 +13780,19 @@ static void disas_crypto_four_reg(DisasContext *s=
, uint32_t insn)
         tcg_res =3D tcg_temp_new_i32();
         tcg_zero =3D tcg_const_i32(0);

-        read_vec_element_i32(s, tcg_op1, rn, 3, MO_32);
-        read_vec_element_i32(s, tcg_op2, rm, 3, MO_32);
-        read_vec_element_i32(s, tcg_op3, ra, 3, MO_32);
+        read_vec_element_i32(s, tcg_op1, rn, 3, MO_UL);
+        read_vec_element_i32(s, tcg_op2, rm, 3, MO_UL);
+        read_vec_element_i32(s, tcg_op3, ra, 3, MO_UL);

         tcg_gen_rotri_i32(tcg_res, tcg_op1, 20);
         tcg_gen_add_i32(tcg_res, tcg_res, tcg_op2);
         tcg_gen_add_i32(tcg_res, tcg_res, tcg_op3);
         tcg_gen_rotri_i32(tcg_res, tcg_res, 25);

-        write_vec_element_i32(s, tcg_zero, rd, 0, MO_32);
-        write_vec_element_i32(s, tcg_zero, rd, 1, MO_32);
-        write_vec_element_i32(s, tcg_zero, rd, 2, MO_32);
-        write_vec_element_i32(s, tcg_res, rd, 3, MO_32);
+        write_vec_element_i32(s, tcg_zero, rd, 0, MO_UL);
+        write_vec_element_i32(s, tcg_zero, rd, 1, MO_UL);
+        write_vec_element_i32(s, tcg_zero, rd, 2, MO_UL);
+        write_vec_element_i32(s, tcg_res, rd, 3, MO_UL);

         tcg_temp_free_i32(tcg_op1);
         tcg_temp_free_i32(tcg_op2);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 2bc1bd1..f7c891d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -1693,7 +1693,7 @@ static void do_sat_addsub_vec(DisasContext *s, int es=
z, int rd, int rn,
         tcg_temp_free_i32(t32);
         break;

-    case MO_32:
+    case MO_UL:
         t64 =3D tcg_temp_new_i64();
         if (d) {
             tcg_gen_neg_i64(t64, val);
@@ -3320,7 +3320,7 @@ static bool trans_SUBR_zzi(DisasContext *s, arg_rri_e=
sz *a)
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_sve_subri_s,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32,
+          .vece =3D MO_UL,
           .scalar_first =3D true },
         { .fni8 =3D tcg_gen_sub_i64,
           .fniv =3D tcg_gen_sub_vec,
@@ -5258,7 +5258,7 @@ static bool trans_LD1_zprz(DisasContext *s, arg_LD1_z=
prz *a)
     }

     switch (a->esz) {
-    case MO_32:
+    case MO_UL:
         fn =3D gather_load_fn32[be][a->ff][a->xs][a->u][a->msz];
         break;
     case MO_64:
@@ -5286,7 +5286,7 @@ static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_z=
piz *a)
     }

     switch (a->esz) {
-    case MO_32:
+    case MO_UL:
         fn =3D gather_load_fn32[be][a->ff][0][a->u][a->msz];
         break;
     case MO_64:
@@ -5364,7 +5364,7 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_z=
prz *a)
         return true;
     }
     switch (a->esz) {
-    case MO_32:
+    case MO_UL:
         fn =3D scatter_store_fn32[be][a->xs][a->msz];
         break;
     case MO_64:
@@ -5392,7 +5392,7 @@ static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_z=
piz *a)
     }

     switch (a->esz) {
-    case MO_32:
+    case MO_UL:
         fn =3D scatter_store_fn32[be][0][a->msz];
         break;
     case MO_64:
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.=
c
index 549874c..5e0cd63 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -46,7 +46,7 @@ uint64_t vfp_expand_imm(int size, uint8_t imm8)
             extract32(imm8, 0, 6);
         imm <<=3D 48;
         break;
-    case MO_32:
+    case MO_UL:
         imm =3D (extract32(imm8, 7, 1) ? 0x8000 : 0) |
             (extract32(imm8, 6, 1) ? 0x3e00 : 0x4000) |
             (extract32(imm8, 0, 6) << 3);
@@ -1901,7 +1901,7 @@ static bool trans_VMOV_imm_sp(DisasContext *s, arg_VM=
OV_imm_sp *a)
         }
     }

-    fd =3D tcg_const_i32(vfp_expand_imm(MO_32, a->imm));
+    fd =3D tcg_const_i32(vfp_expand_imm(MO_UL, a->imm));

     for (;;) {
         neon_store_reg32(fd, vd);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8d10922..5510ecd 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1085,7 +1085,7 @@ static inline TCGv gen_aa32_addr(DisasContext *s, TCG=
v_i32 a32, TCGMemOp op)
     tcg_gen_extu_i32_tl(addr, a32);

     /* Not needed for user-mode BE32, where we use MO_BE instead.  */
-    if (!IS_USER_ONLY && s->sctlr_b && (op & MO_SIZE) < MO_32) {
+    if (!IS_USER_ONLY && s->sctlr_b && (op & MO_SIZE) < MO_UL) {
         tcg_gen_xori_tl(addr, addr, 4 - (1 << (op & MO_SIZE)));
     }
     return addr;
@@ -1480,7 +1480,7 @@ static void neon_store_element(int reg, int ele, TCGM=
emOp size, TCGv_i32 var)
     case MO_UW:
         tcg_gen_st16_i32(var, cpu_env, offset);
         break;
-    case MO_32:
+    case MO_UL:
         tcg_gen_st_i32(var, cpu_env, offset);
         break;
     default:
@@ -1499,7 +1499,7 @@ static void neon_store_element64(int reg, int ele, TC=
GMemOp size, TCGv_i64 var)
     case MO_UW:
         tcg_gen_st16_i64(var, cpu_env, offset);
         break;
-    case MO_32:
+    case MO_UL:
         tcg_gen_st32_i64(var, cpu_env, offset);
         break;
     case MO_64:
@@ -4272,7 +4272,7 @@ const GVecGen2i ssra_op[4] =3D {
       .fniv =3D gen_ssra_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_ssra,
-      .vece =3D MO_32 },
+      .vece =3D MO_UL },
     { .fni8 =3D gen_ssra64_i64,
       .fniv =3D gen_ssra_vec,
       .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
@@ -4330,7 +4330,7 @@ const GVecGen2i usra_op[4] =3D {
       .fniv =3D gen_usra_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_usra,
-      .vece =3D MO_32, },
+      .vece =3D MO_UL, },
     { .fni8 =3D gen_usra64_i64,
       .fniv =3D gen_usra_vec,
       .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
@@ -4410,7 +4410,7 @@ const GVecGen2i sri_op[4] =3D {
       .fniv =3D gen_shr_ins_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_sri,
-      .vece =3D MO_32 },
+      .vece =3D MO_UL },
     { .fni8 =3D gen_shr64_ins_i64,
       .fniv =3D gen_shr_ins_vec,
       .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
@@ -4488,7 +4488,7 @@ const GVecGen2i sli_op[4] =3D {
       .fniv =3D gen_shl_ins_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_sli,
-      .vece =3D MO_32 },
+      .vece =3D MO_UL },
     { .fni8 =3D gen_shl64_ins_i64,
       .fniv =3D gen_shl_ins_vec,
       .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
@@ -4584,7 +4584,7 @@ const GVecGen3 mla_op[4] =3D {
       .fniv =3D gen_mla_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_mla,
-      .vece =3D MO_32 },
+      .vece =3D MO_UL },
     { .fni8 =3D gen_mla64_i64,
       .fniv =3D gen_mla_vec,
       .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
@@ -4608,7 +4608,7 @@ const GVecGen3 mls_op[4] =3D {
       .fniv =3D gen_mls_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_mls,
-      .vece =3D MO_32 },
+      .vece =3D MO_UL },
     { .fni8 =3D gen_mls64_i64,
       .fniv =3D gen_mls_vec,
       .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
@@ -4653,7 +4653,7 @@ const GVecGen3 cmtst_op[4] =3D {
     { .fni4 =3D gen_cmtst_i32,
       .fniv =3D gen_cmtst_vec,
       .opt_opc =3D vecop_list_cmtst,
-      .vece =3D MO_32 },
+      .vece =3D MO_UL },
     { .fni8 =3D gen_cmtst_i64,
       .fniv =3D gen_cmtst_vec,
       .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
@@ -4691,7 +4691,7 @@ const GVecGen4 uqadd_op[4] =3D {
       .fno =3D gen_helper_gvec_uqadd_s,
       .write_aofs =3D true,
       .opt_opc =3D vecop_list_uqadd,
-      .vece =3D MO_32 },
+      .vece =3D MO_UL },
     { .fniv =3D gen_uqadd_vec,
       .fno =3D gen_helper_gvec_uqadd_d,
       .write_aofs =3D true,
@@ -4729,7 +4729,7 @@ const GVecGen4 sqadd_op[4] =3D {
       .fno =3D gen_helper_gvec_sqadd_s,
       .opt_opc =3D vecop_list_sqadd,
       .write_aofs =3D true,
-      .vece =3D MO_32 },
+      .vece =3D MO_UL },
     { .fniv =3D gen_sqadd_vec,
       .fno =3D gen_helper_gvec_sqadd_d,
       .opt_opc =3D vecop_list_sqadd,
@@ -4767,7 +4767,7 @@ const GVecGen4 uqsub_op[4] =3D {
       .fno =3D gen_helper_gvec_uqsub_s,
       .opt_opc =3D vecop_list_uqsub,
       .write_aofs =3D true,
-      .vece =3D MO_32 },
+      .vece =3D MO_UL },
     { .fniv =3D gen_uqsub_vec,
       .fno =3D gen_helper_gvec_uqsub_d,
       .opt_opc =3D vecop_list_uqsub,
@@ -4805,7 +4805,7 @@ const GVecGen4 sqsub_op[4] =3D {
       .fno =3D gen_helper_gvec_sqsub_s,
       .opt_opc =3D vecop_list_sqsub,
       .write_aofs =3D true,
-      .vece =3D MO_32 },
+      .vece =3D MO_UL },
     { .fniv =3D gen_sqsub_vec,
       .fno =3D gen_helper_gvec_sqsub_d,
       .opt_opc =3D vecop_list_sqsub,
@@ -5798,10 +5798,10 @@ static int disas_neon_data_insn(DisasContext *s, ui=
nt32_t insn)
                     /* The immediate value has already been inverted,
                      * so BIC becomes AND.
                      */
-                    tcg_gen_gvec_andi(MO_32, reg_ofs, reg_ofs, imm,
+                    tcg_gen_gvec_andi(MO_UL, reg_ofs, reg_ofs, imm,
                                       vec_size, vec_size);
                 } else {
-                    tcg_gen_gvec_ori(MO_32, reg_ofs, reg_ofs, imm,
+                    tcg_gen_gvec_ori(MO_UL, reg_ofs, reg_ofs, imm,
                                      vec_size, vec_size);
                 }
             } else {
@@ -6879,7 +6879,7 @@ static int disas_neon_data_insn(DisasContext *s, uint=
32_t insn)
                     size =3D MO_UW;
                     element =3D (insn >> 18) & 3;
                 } else {
-                    size =3D MO_32;
+                    size =3D MO_UL;
                     element =3D (insn >> 19) & 1;
                 }
                 tcg_gen_gvec_dup_mem(size, neon_reg_offset(rd, 0),
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 0535bae..0e863d4 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -332,16 +332,16 @@ static inline TCGMemOp mo_pushpop(DisasContext *s, TC=
GMemOp ot)
 /* Select the size of the stack pointer.  */
 static inline TCGMemOp mo_stacksize(DisasContext *s)
 {
-    return CODE64(s) ? MO_64 : s->ss32 ? MO_32 : MO_UW;
+    return CODE64(s) ? MO_64 : s->ss32 ? MO_UL : MO_UW;
 }

 /* Select only size 64 else 32.  Used for SSE operand sizes.  */
 static inline TCGMemOp mo_64_32(TCGMemOp ot)
 {
 #ifdef TARGET_X86_64
-    return ot =3D=3D MO_64 ? MO_64 : MO_32;
+    return ot =3D=3D MO_64 ? MO_64 : MO_UL;
 #else
-    return MO_32;
+    return MO_UL;
 #endif
 }

@@ -356,7 +356,7 @@ static inline TCGMemOp mo_b_d(int b, TCGMemOp ot)
    Used for decoding operand size of port opcodes.  */
 static inline TCGMemOp mo_b_d32(int b, TCGMemOp ot)
 {
-    return b & 1 ? (ot =3D=3D MO_UW ? MO_UW : MO_32) : MO_UB;
+    return b & 1 ? (ot =3D=3D MO_UW ? MO_UW : MO_UL) : MO_UB;
 }

 static void gen_op_mov_reg_v(DisasContext *s, TCGMemOp ot, int reg, TCGv t=
0)
@@ -372,7 +372,7 @@ static void gen_op_mov_reg_v(DisasContext *s, TCGMemOp =
ot, int reg, TCGv t0)
     case MO_UW:
         tcg_gen_deposit_tl(cpu_regs[reg], cpu_regs[reg], t0, 0, 16);
         break;
-    case MO_32:
+    case MO_UL:
         /* For x86_64, this sets the higher half of register to zero.
            For i386, this is equivalent to a mov. */
         tcg_gen_ext32u_tl(cpu_regs[reg], t0);
@@ -463,7 +463,7 @@ static void gen_lea_v_seg(DisasContext *s, TCGMemOp afl=
ag, TCGv a0,
         }
         break;
 #endif
-    case MO_32:
+    case MO_UL:
         /* 32 bit address */
         if (ovr_seg < 0 && s->addseg) {
             ovr_seg =3D def_seg;
@@ -538,7 +538,7 @@ static TCGv gen_ext_tl(TCGv dst, TCGv src, TCGMemOp siz=
e, bool sign)
         }
         return dst;
 #ifdef TARGET_X86_64
-    case MO_32:
+    case MO_UL:
         if (sign) {
             tcg_gen_ext32s_tl(dst, src);
         } else {
@@ -586,7 +586,7 @@ static void gen_helper_in_func(TCGMemOp ot, TCGv v, TCG=
v_i32 n)
     case MO_UW:
         gen_helper_inw(v, cpu_env, n);
         break;
-    case MO_32:
+    case MO_UL:
         gen_helper_inl(v, cpu_env, n);
         break;
     default:
@@ -603,7 +603,7 @@ static void gen_helper_out_func(TCGMemOp ot, TCGv_i32 v=
, TCGv_i32 n)
     case MO_UW:
         gen_helper_outw(cpu_env, v, n);
         break;
-    case MO_32:
+    case MO_UL:
         gen_helper_outl(cpu_env, v, n);
         break;
     default:
@@ -625,7 +625,7 @@ static void gen_check_io(DisasContext *s, TCGMemOp ot, =
target_ulong cur_eip,
         case MO_UW:
             gen_helper_check_iow(cpu_env, s->tmp2_i32);
             break;
-        case MO_32:
+        case MO_UL:
             gen_helper_check_iol(cpu_env, s->tmp2_i32);
             break;
         default:
@@ -1077,7 +1077,7 @@ static TCGLabel *gen_jz_ecx_string(DisasContext *s, t=
arget_ulong next_eip)

 static inline void gen_stos(DisasContext *s, TCGMemOp ot)
 {
-    gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
+    gen_op_mov_v_reg(s, MO_UL, s->T0, R_EAX);
     gen_string_movl_A0_EDI(s);
     gen_op_st_v(s, ot, s->T0, s->A0);
     gen_op_movl_T0_Dshift(s, ot);
@@ -1568,7 +1568,7 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp o=
t, int op1, int is_right)
         goto do_long;
     do_long:
 #ifdef TARGET_X86_64
-    case MO_32:
+    case MO_UL:
         tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
         tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
         if (is_right) {
@@ -1644,7 +1644,7 @@ static void gen_rot_rm_im(DisasContext *s, TCGMemOp o=
t, int op1, int op2,
     if (op2 !=3D 0) {
         switch (ot) {
 #ifdef TARGET_X86_64
-        case MO_32:
+        case MO_UL:
             tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
             if (is_right) {
                 tcg_gen_rotri_i32(s->tmp2_i32, s->tmp2_i32, op2);
@@ -1725,7 +1725,7 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMemOp =
ot, int op1,
         case MO_UW:
             gen_helper_rcrw(s->T0, cpu_env, s->T0, s->T1);
             break;
-        case MO_32:
+        case MO_UL:
             gen_helper_rcrl(s->T0, cpu_env, s->T0, s->T1);
             break;
 #ifdef TARGET_X86_64
@@ -1744,7 +1744,7 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMemOp =
ot, int op1,
         case MO_UW:
             gen_helper_rclw(s->T0, cpu_env, s->T0, s->T1);
             break;
-        case MO_32:
+        case MO_UL:
             gen_helper_rcll(s->T0, cpu_env, s->T0, s->T1);
             break;
 #ifdef TARGET_X86_64
@@ -1791,7 +1791,7 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMemO=
p ot, int op1,
         }
         /* FALLTHRU */
 #ifdef TARGET_X86_64
-    case MO_32:
+    case MO_UL:
         /* Concatenate the two 32-bit values and use a 64-bit shift.  */
         tcg_gen_subi_tl(s->tmp0, count, 1);
         if (is_right) {
@@ -1984,7 +1984,7 @@ static AddressParts gen_lea_modrm_0(CPUX86State *env,=
 DisasContext *s,

     switch (s->aflag) {
     case MO_64:
-    case MO_32:
+    case MO_UL:
         havesib =3D 0;
         if (rm =3D=3D 4) {
             int code =3D x86_ldub_code(env, s);
@@ -2190,7 +2190,7 @@ static inline uint32_t insn_get(CPUX86State *env, Dis=
asContext *s, TCGMemOp ot)
     case MO_UW:
         ret =3D x86_lduw_code(env, s);
         break;
-    case MO_32:
+    case MO_UL:
 #ifdef TARGET_X86_64
     case MO_64:
 #endif
@@ -2204,7 +2204,7 @@ static inline uint32_t insn_get(CPUX86State *env, Dis=
asContext *s, TCGMemOp ot)

 static inline int insn_const_size(TCGMemOp ot)
 {
-    if (ot <=3D MO_32) {
+    if (ot <=3D MO_UL) {
         return 1 << ot;
     } else {
         return 4;
@@ -2400,12 +2400,12 @@ static inline void gen_pop_update(DisasContext *s, =
TCGMemOp ot)

 static inline void gen_stack_A0(DisasContext *s)
 {
-    gen_lea_v_seg(s, s->ss32 ? MO_32 : MO_UW, cpu_regs[R_ESP], R_SS, -1);
+    gen_lea_v_seg(s, s->ss32 ? MO_UL : MO_UW, cpu_regs[R_ESP], R_SS, -1);
 }

 static void gen_pusha(DisasContext *s)
 {
-    TCGMemOp s_ot =3D s->ss32 ? MO_32 : MO_UW;
+    TCGMemOp s_ot =3D s->ss32 ? MO_UL : MO_UW;
     TCGMemOp d_ot =3D s->dflag;
     int size =3D 1 << d_ot;
     int i;
@@ -2421,7 +2421,7 @@ static void gen_pusha(DisasContext *s)

 static void gen_popa(DisasContext *s)
 {
-    TCGMemOp s_ot =3D s->ss32 ? MO_32 : MO_UW;
+    TCGMemOp s_ot =3D s->ss32 ? MO_UL : MO_UW;
     TCGMemOp d_ot =3D s->dflag;
     int size =3D 1 << d_ot;
     int i;
@@ -2443,7 +2443,7 @@ static void gen_popa(DisasContext *s)
 static void gen_enter(DisasContext *s, int esp_addend, int level)
 {
     TCGMemOp d_ot =3D mo_pushpop(s, s->dflag);
-    TCGMemOp a_ot =3D CODE64(s) ? MO_64 : s->ss32 ? MO_32 : MO_UW;
+    TCGMemOp a_ot =3D CODE64(s) ? MO_64 : s->ss32 ? MO_UL : MO_UW;
     int size =3D 1 << d_ot;

     /* Push BP; compute FrameTemp into T1.  */
@@ -3145,7 +3145,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
             } else {
                 tcg_gen_ld32u_tl(s->T0, cpu_env, offsetof(CPUX86State,
                     xmm_regs[reg].ZMM_L(0)));
-                gen_op_st_v(s, MO_32, s->T0, s->A0);
+                gen_op_st_v(s, MO_UL, s->T0, s->A0);
             }
             break;
         case 0x6e: /* movd mm, ea */
@@ -3157,7 +3157,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
             } else
 #endif
             {
-                gen_ldst_modrm(env, s, modrm, MO_32, OR_TMP0, 0);
+                gen_ldst_modrm(env, s, modrm, MO_UL, OR_TMP0, 0);
                 tcg_gen_addi_ptr(s->ptr0, cpu_env,
                                  offsetof(CPUX86State,fpregs[reg].mmx));
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
@@ -3174,7 +3174,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
             } else
 #endif
             {
-                gen_ldst_modrm(env, s, modrm, MO_32, OR_TMP0, 0);
+                gen_ldst_modrm(env, s, modrm, MO_UL, OR_TMP0, 0);
                 tcg_gen_addi_ptr(s->ptr0, cpu_env,
                                  offsetof(CPUX86State,xmm_regs[reg]));
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
@@ -3211,7 +3211,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
         case 0x210: /* movss xmm, ea */
             if (mod !=3D 3) {
                 gen_lea_modrm(env, s, modrm);
-                gen_op_ld_v(s, MO_32, s->T0, s->A0);
+                gen_op_ld_v(s, MO_UL, s->T0, s->A0);
                 tcg_gen_st32_tl(s->T0, cpu_env,
                                 offsetof(CPUX86State, xmm_regs[reg].ZMM_L(=
0)));
                 tcg_gen_movi_tl(s->T0, 0);
@@ -3346,7 +3346,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
             {
                 tcg_gen_ld32u_tl(s->T0, cpu_env,
                                  offsetof(CPUX86State,fpregs[reg].mmx.MMX_=
L(0)));
-                gen_ldst_modrm(env, s, modrm, MO_32, OR_TMP0, 1);
+                gen_ldst_modrm(env, s, modrm, MO_UL, OR_TMP0, 1);
             }
             break;
         case 0x17e: /* movd ea, xmm */
@@ -3360,7 +3360,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
             {
                 tcg_gen_ld32u_tl(s->T0, cpu_env,
                                  offsetof(CPUX86State,xmm_regs[reg].ZMM_L(=
0)));
-                gen_ldst_modrm(env, s, modrm, MO_32, OR_TMP0, 1);
+                gen_ldst_modrm(env, s, modrm, MO_UL, OR_TMP0, 1);
             }
             break;
         case 0x27e: /* movq xmm, ea */
@@ -3405,7 +3405,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                 gen_lea_modrm(env, s, modrm);
                 tcg_gen_ld32u_tl(s->T0, cpu_env,
                                  offsetof(CPUX86State, xmm_regs[reg].ZMM_L=
(0)));
-                gen_op_st_v(s, MO_32, s->T0, s->A0);
+                gen_op_st_v(s, MO_UL, s->T0, s->A0);
             } else {
                 rm =3D (modrm & 7) | REX_B(s);
                 gen_op_movl(s, offsetof(CPUX86State, xmm_regs[rm].ZMM_L(0)=
),
@@ -3530,7 +3530,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
             op1_offset =3D offsetof(CPUX86State,xmm_regs[reg]);
             tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
-            if (ot =3D=3D MO_32) {
+            if (ot =3D=3D MO_UL) {
                 SSEFunc_0_epi sse_fn_epi =3D sse_op_table3ai[(b >> 8) & 1]=
;
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 sse_fn_epi(cpu_env, s->ptr0, s->tmp2_i32);
@@ -3584,7 +3584,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                 if ((b >> 8) & 1) {
                     gen_ldq_env_A0(s, offsetof(CPUX86State, xmm_t0.ZMM_Q(0=
)));
                 } else {
-                    gen_op_ld_v(s, MO_32, s->T0, s->A0);
+                    gen_op_ld_v(s, MO_UL, s->T0, s->A0);
                     tcg_gen_st32_tl(s->T0, cpu_env,
                                     offsetof(CPUX86State, xmm_t0.ZMM_L(0))=
);
                 }
@@ -3594,7 +3594,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                 op2_offset =3D offsetof(CPUX86State,xmm_regs[rm]);
             }
             tcg_gen_addi_ptr(s->ptr0, cpu_env, op2_offset);
-            if (ot =3D=3D MO_32) {
+            if (ot =3D=3D MO_UL) {
                 SSEFunc_i_ep sse_fn_i_ep =3D
                     sse_op_table3bi[((b >> 7) & 2) | (b & 1)];
                 sse_fn_i_ep(s->tmp2_i32, cpu_env, s->ptr0);
@@ -3786,7 +3786,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                 if ((b & 0xff) =3D=3D 0xf0) {
                     ot =3D MO_UB;
                 } else if (s->dflag !=3D MO_64) {
-                    ot =3D (s->prefix & PREFIX_DATA ? MO_UW : MO_32);
+                    ot =3D (s->prefix & PREFIX_DATA ? MO_UW : MO_UL);
                 } else {
                     ot =3D MO_64;
                 }
@@ -3815,7 +3815,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                     goto illegal_op;
                 }
                 if (s->dflag !=3D MO_64) {
-                    ot =3D (s->prefix & PREFIX_DATA ? MO_UW : MO_32);
+                    ot =3D (s->prefix & PREFIX_DATA ? MO_UW : MO_UL);
                 } else {
                     ot =3D MO_64;
                 }
@@ -4026,7 +4026,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,

                     switch (ot) {
 #ifdef TARGET_X86_64
-                    case MO_32:
+                    case MO_UL:
                         /* If we know TL is 64-bit, and we want a 32-bit
                            result, just do everything in 64-bit arithmetic=
.  */
                         tcg_gen_ext32u_i64(cpu_regs[reg], cpu_regs[reg]);
@@ -4172,7 +4172,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                     }
                     break;
                 case 0x16:
-                    if (ot =3D=3D MO_32) { /* pextrd */
+                    if (ot =3D=3D MO_UL) { /* pextrd */
                         tcg_gen_ld_i32(s->tmp2_i32, cpu_env,
                                         offsetof(CPUX86State,
                                                 xmm_regs[reg].ZMM_L(val & =
3)));
@@ -4210,7 +4210,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                     break;
                 case 0x20: /* pinsrb */
                     if (mod =3D=3D 3) {
-                        gen_op_mov_v_reg(s, MO_32, s->T0, rm);
+                        gen_op_mov_v_reg(s, MO_UL, s->T0, rm);
                     } else {
                         tcg_gen_qemu_ld_tl(s->T0, s->A0,
                                            s->mem_index, MO_UB);
@@ -4248,7 +4248,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                                                 xmm_regs[reg].ZMM_L(3)));
                     break;
                 case 0x22:
-                    if (ot =3D=3D MO_32) { /* pinsrd */
+                    if (ot =3D=3D MO_UL) { /* pinsrd */
                         if (mod =3D=3D 3) {
                             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[rm]=
);
                         } else {
@@ -4393,7 +4393,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                 switch (sz) {
                 case 2:
                     /* 32 bit access */
-                    gen_op_ld_v(s, MO_32, s->T0, s->A0);
+                    gen_op_ld_v(s, MO_UL, s->T0, s->A0);
                     tcg_gen_st32_tl(s->T0, cpu_env,
                                     offsetof(CPUX86State,xmm_t0.ZMM_L(0)))=
;
                     break;
@@ -4630,19 +4630,19 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
         /* In 64-bit mode, the default data size is 32-bit.  Select 64-bit
            data with rex_w, and 16-bit data with 0x66; rex_w takes precede=
nce
            over 0x66 if both are present.  */
-        dflag =3D (rex_w > 0 ? MO_64 : prefixes & PREFIX_DATA ? MO_UW : MO=
_32);
+        dflag =3D (rex_w > 0 ? MO_64 : prefixes & PREFIX_DATA ? MO_UW : MO=
_UL);
         /* In 64-bit mode, 0x67 selects 32-bit addressing.  */
-        aflag =3D (prefixes & PREFIX_ADR ? MO_32 : MO_64);
+        aflag =3D (prefixes & PREFIX_ADR ? MO_UL : MO_64);
     } else {
         /* In 16/32-bit mode, 0x66 selects the opposite data size.  */
         if (s->code32 ^ ((prefixes & PREFIX_DATA) !=3D 0)) {
-            dflag =3D MO_32;
+            dflag =3D MO_UL;
         } else {
             dflag =3D MO_UW;
         }
         /* In 16/32-bit mode, 0x67 selects the opposite addressing.  */
         if (s->code32 ^ ((prefixes & PREFIX_ADR) !=3D 0)) {
-            aflag =3D MO_32;
+            aflag =3D MO_UL;
         }  else {
             aflag =3D MO_UW;
         }
@@ -4891,7 +4891,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 set_cc_op(s, CC_OP_MULW);
                 break;
             default:
-            case MO_32:
+            case MO_UL:
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 tcg_gen_trunc_tl_i32(s->tmp3_i32, cpu_regs[R_EAX]);
                 tcg_gen_mulu2_i32(s->tmp2_i32, s->tmp3_i32,
@@ -4942,7 +4942,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 set_cc_op(s, CC_OP_MULW);
                 break;
             default:
-            case MO_32:
+            case MO_UL:
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 tcg_gen_trunc_tl_i32(s->tmp3_i32, cpu_regs[R_EAX]);
                 tcg_gen_muls2_i32(s->tmp2_i32, s->tmp3_i32,
@@ -4976,7 +4976,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 gen_helper_divw_AX(cpu_env, s->T0);
                 break;
             default:
-            case MO_32:
+            case MO_UL:
                 gen_helper_divl_EAX(cpu_env, s->T0);
                 break;
 #ifdef TARGET_X86_64
@@ -4995,7 +4995,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 gen_helper_idivw_AX(cpu_env, s->T0);
                 break;
             default:
-            case MO_32:
+            case MO_UL:
                 gen_helper_idivl_EAX(cpu_env, s->T0);
                 break;
 #ifdef TARGET_X86_64
@@ -5026,7 +5026,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 /* operand size for jumps is 64 bit */
                 ot =3D MO_64;
             } else if (op =3D=3D 3 || op =3D=3D 5) {
-                ot =3D dflag !=3D MO_UW ? MO_32 + (rex_w =3D=3D 1) : MO_UW=
;
+                ot =3D dflag !=3D MO_UW ? MO_UL + (rex_w =3D=3D 1) : MO_UW=
;
             } else if (op =3D=3D 6) {
                 /* default push size is 64 bit */
                 ot =3D mo_pushpop(s, dflag);
@@ -5146,15 +5146,15 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
         switch (dflag) {
 #ifdef TARGET_X86_64
         case MO_64:
-            gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
+            gen_op_mov_v_reg(s, MO_UL, s->T0, R_EAX);
             tcg_gen_ext32s_tl(s->T0, s->T0);
             gen_op_mov_reg_v(s, MO_64, R_EAX, s->T0);
             break;
 #endif
-        case MO_32:
+        case MO_UL:
             gen_op_mov_v_reg(s, MO_UW, s->T0, R_EAX);
             tcg_gen_ext16s_tl(s->T0, s->T0);
-            gen_op_mov_reg_v(s, MO_32, R_EAX, s->T0);
+            gen_op_mov_reg_v(s, MO_UL, R_EAX, s->T0);
             break;
         case MO_UW:
             gen_op_mov_v_reg(s, MO_UB, s->T0, R_EAX);
@@ -5174,11 +5174,11 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
             gen_op_mov_reg_v(s, MO_64, R_EDX, s->T0);
             break;
 #endif
-        case MO_32:
-            gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
+        case MO_UL:
+            gen_op_mov_v_reg(s, MO_UL, s->T0, R_EAX);
             tcg_gen_ext32s_tl(s->T0, s->T0);
             tcg_gen_sari_tl(s->T0, s->T0, 31);
-            gen_op_mov_reg_v(s, MO_32, R_EDX, s->T0);
+            gen_op_mov_reg_v(s, MO_UL, R_EDX, s->T0);
             break;
         case MO_UW:
             gen_op_mov_v_reg(s, MO_UW, s->T0, R_EAX);
@@ -5219,7 +5219,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             tcg_gen_sub_tl(cpu_cc_src, cpu_cc_src, s->T1);
             break;
 #endif
-        case MO_32:
+        case MO_UL:
             tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
             tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
             tcg_gen_muls2_i32(s->tmp2_i32, s->tmp3_i32,
@@ -5394,7 +5394,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         /**************************/
         /* push/pop */
     case 0x50 ... 0x57: /* push */
-        gen_op_mov_v_reg(s, MO_32, s->T0, (b & 7) | REX_B(s));
+        gen_op_mov_v_reg(s, MO_UL, s->T0, (b & 7) | REX_B(s));
         gen_push_v(s, s->T0);
         break;
     case 0x58 ... 0x5f: /* pop */
@@ -5734,7 +5734,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
     case 0x1b5: /* lgs Gv */
         op =3D R_GS;
     do_lxx:
-        ot =3D dflag !=3D MO_UW ? MO_32 : MO_UW;
+        ot =3D dflag !=3D MO_UW ? MO_UL : MO_UW;
         modrm =3D x86_ldub_code(env, s);
         reg =3D ((modrm >> 3) & 7) | rex_r;
         mod =3D (modrm >> 6) & 3;
@@ -6576,7 +6576,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
     case 0xe8: /* call im */
         {
             if (dflag !=3D MO_UW) {
-                tval =3D (int32_t)insn_get(env, s, MO_32);
+                tval =3D (int32_t)insn_get(env, s, MO_UL);
             } else {
                 tval =3D (int16_t)insn_get(env, s, MO_UW);
             }
@@ -6609,7 +6609,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         goto do_lcall;
     case 0xe9: /* jmp im */
         if (dflag !=3D MO_UW) {
-            tval =3D (int32_t)insn_get(env, s, MO_32);
+            tval =3D (int32_t)insn_get(env, s, MO_UL);
         } else {
             tval =3D (int16_t)insn_get(env, s, MO_UW);
         }
@@ -6649,7 +6649,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         goto do_jcc;
     case 0x180 ... 0x18f: /* jcc Jv */
         if (dflag !=3D MO_UW) {
-            tval =3D (int32_t)insn_get(env, s, MO_32);
+            tval =3D (int32_t)insn_get(env, s, MO_UL);
         } else {
             tval =3D (int16_t)insn_get(env, s, MO_UW);
         }
@@ -6827,7 +6827,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         reg =3D ((modrm >> 3) & 7) | rex_r;
         mod =3D (modrm >> 6) & 3;
         rm =3D (modrm & 7) | REX_B(s);
-        gen_op_mov_v_reg(s, MO_32, s->T1, reg);
+        gen_op_mov_v_reg(s, MO_UL, s->T1, reg);
         if (mod !=3D 3) {
             AddressParts a =3D gen_lea_modrm_0(env, s, modrm);
             /* specific case: we need to add a displacement */
@@ -7126,10 +7126,10 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
         } else
 #endif
         {
-            gen_op_mov_v_reg(s, MO_32, s->T0, reg);
+            gen_op_mov_v_reg(s, MO_UL, s->T0, reg);
             tcg_gen_ext32u_tl(s->T0, s->T0);
             tcg_gen_bswap32_tl(s->T0, s->T0);
-            gen_op_mov_reg_v(s, MO_32, reg, s->T0);
+            gen_op_mov_reg_v(s, MO_UL, reg, s->T0);
         }
         break;
     case 0xd6: /* salc */
@@ -7359,7 +7359,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             if (dflag =3D=3D MO_UW) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
-            gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
+            gen_op_st_v(s, CODE64(s) + MO_UL, s->T0, s->A0);
             break;

         case 0xc8: /* monitor */
@@ -7414,7 +7414,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             if (dflag =3D=3D MO_UW) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
-            gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
+            gen_op_st_v(s, CODE64(s) + MO_UL, s->T0, s->A0);
             break;

         case 0xd0: /* xgetbv */
@@ -7560,7 +7560,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             gen_lea_modrm(env, s, modrm);
             gen_op_ld_v(s, MO_UW, s->T1, s->A0);
             gen_add_A0_im(s, 2);
-            gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
+            gen_op_ld_v(s, CODE64(s) + MO_UL, s->T0, s->A0);
             if (dflag =3D=3D MO_UW) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
@@ -7577,7 +7577,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             gen_lea_modrm(env, s, modrm);
             gen_op_ld_v(s, MO_UW, s->T1, s->A0);
             gen_add_A0_im(s, 2);
-            gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
+            gen_op_ld_v(s, CODE64(s) + MO_UL, s->T0, s->A0);
             if (dflag =3D=3D MO_UW) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
@@ -7698,7 +7698,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             rm =3D (modrm & 7) | REX_B(s);

             if (mod =3D=3D 3) {
-                gen_op_mov_v_reg(s, MO_32, s->T0, rm);
+                gen_op_mov_v_reg(s, MO_UL, s->T0, rm);
                 /* sign extend */
                 if (d_ot =3D=3D MO_64) {
                     tcg_gen_ext32s_tl(s->T0, s->T0);
@@ -7706,7 +7706,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 gen_op_mov_reg_v(s, d_ot, reg, s->T0);
             } else {
                 gen_lea_modrm(env, s, modrm);
-                gen_op_ld_v(s, MO_32 | MO_SIGN, s->T0, s->A0);
+                gen_op_ld_v(s, MO_SL, s->T0, s->A0);
                 gen_op_mov_reg_v(s, d_ot, reg, s->T0);
             }
         } else
@@ -7765,7 +7765,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             TCGv t0;
             if (!s->pe || s->vm86)
                 goto illegal_op;
-            ot =3D dflag !=3D MO_UW ? MO_32 : MO_UW;
+            ot =3D dflag !=3D MO_UW ? MO_UL : MO_UW;
             modrm =3D x86_ldub_code(env, s);
             reg =3D ((modrm >> 3) & 7) | rex_r;
             gen_ldst_modrm(env, s, modrm, MO_UW, OR_TMP0, 0);
@@ -8016,7 +8016,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             if (CODE64(s))
                 ot =3D MO_64;
             else
-                ot =3D MO_32;
+                ot =3D MO_UL;
             if ((prefixes & PREFIX_LOCK) && (reg =3D=3D 0) &&
                 (s->cpuid_ext3_features & CPUID_EXT3_CR8LEG)) {
                 reg =3D 8;
@@ -8073,7 +8073,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             if (CODE64(s))
                 ot =3D MO_64;
             else
-                ot =3D MO_32;
+                ot =3D MO_UL;
             if (reg >=3D 8) {
                 goto illegal_op;
             }
@@ -8168,7 +8168,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             }
             gen_lea_modrm(env, s, modrm);
             tcg_gen_ld32u_tl(s->T0, cpu_env, offsetof(CPUX86State, mxcsr))=
;
-            gen_op_st_v(s, MO_32, s->T0, s->A0);
+            gen_op_st_v(s, MO_UL, s->T0, s->A0);
             break;

         CASE_MODRM_MEM_OP(4): /* xsave */
@@ -8268,7 +8268,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                     dst =3D treg, src =3D base;
                 }

-                if (s->dflag =3D=3D MO_32) {
+                if (s->dflag =3D=3D MO_UL) {
                     tcg_gen_ext32u_tl(dst, src);
                 } else {
                     tcg_gen_mov_tl(dst, src);
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx=
-impl.inc.c
index 71efef4..8aa767e 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -409,27 +409,27 @@ GEN_VXFORM_DUAL_EXT(vaddubm, PPC_ALTIVEC, PPC_NONE, 0=
,       \
 GEN_VXFORM_V(vadduhm, MO_UW, tcg_gen_gvec_add, 0, 1);
 GEN_VXFORM_DUAL(vadduhm, PPC_ALTIVEC, PPC_NONE,  \
                 vmul10ecuq, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM_V(vadduwm, MO_32, tcg_gen_gvec_add, 0, 2);
+GEN_VXFORM_V(vadduwm, MO_UL, tcg_gen_gvec_add, 0, 2);
 GEN_VXFORM_V(vaddudm, MO_64, tcg_gen_gvec_add, 0, 3);
 GEN_VXFORM_V(vsububm, MO_UB, tcg_gen_gvec_sub, 0, 16);
 GEN_VXFORM_V(vsubuhm, MO_UW, tcg_gen_gvec_sub, 0, 17);
-GEN_VXFORM_V(vsubuwm, MO_32, tcg_gen_gvec_sub, 0, 18);
+GEN_VXFORM_V(vsubuwm, MO_UL, tcg_gen_gvec_sub, 0, 18);
 GEN_VXFORM_V(vsubudm, MO_64, tcg_gen_gvec_sub, 0, 19);
 GEN_VXFORM_V(vmaxub, MO_UB, tcg_gen_gvec_umax, 1, 0);
 GEN_VXFORM_V(vmaxuh, MO_UW, tcg_gen_gvec_umax, 1, 1);
-GEN_VXFORM_V(vmaxuw, MO_32, tcg_gen_gvec_umax, 1, 2);
+GEN_VXFORM_V(vmaxuw, MO_UL, tcg_gen_gvec_umax, 1, 2);
 GEN_VXFORM_V(vmaxud, MO_64, tcg_gen_gvec_umax, 1, 3);
 GEN_VXFORM_V(vmaxsb, MO_UB, tcg_gen_gvec_smax, 1, 4);
 GEN_VXFORM_V(vmaxsh, MO_UW, tcg_gen_gvec_smax, 1, 5);
-GEN_VXFORM_V(vmaxsw, MO_32, tcg_gen_gvec_smax, 1, 6);
+GEN_VXFORM_V(vmaxsw, MO_UL, tcg_gen_gvec_smax, 1, 6);
 GEN_VXFORM_V(vmaxsd, MO_64, tcg_gen_gvec_smax, 1, 7);
 GEN_VXFORM_V(vminub, MO_UB, tcg_gen_gvec_umin, 1, 8);
 GEN_VXFORM_V(vminuh, MO_UW, tcg_gen_gvec_umin, 1, 9);
-GEN_VXFORM_V(vminuw, MO_32, tcg_gen_gvec_umin, 1, 10);
+GEN_VXFORM_V(vminuw, MO_UL, tcg_gen_gvec_umin, 1, 10);
 GEN_VXFORM_V(vminud, MO_64, tcg_gen_gvec_umin, 1, 11);
 GEN_VXFORM_V(vminsb, MO_UB, tcg_gen_gvec_smin, 1, 12);
 GEN_VXFORM_V(vminsh, MO_UW, tcg_gen_gvec_smin, 1, 13);
-GEN_VXFORM_V(vminsw, MO_32, tcg_gen_gvec_smin, 1, 14);
+GEN_VXFORM_V(vminsw, MO_UL, tcg_gen_gvec_smin, 1, 14);
 GEN_VXFORM_V(vminsd, MO_64, tcg_gen_gvec_smin, 1, 15);
 GEN_VXFORM(vavgub, 1, 16);
 GEN_VXFORM(vabsdub, 1, 16);
@@ -532,18 +532,18 @@ GEN_VXFORM(vmulesh, 4, 13);
 GEN_VXFORM(vmulesw, 4, 14);
 GEN_VXFORM_V(vslb, MO_UB, tcg_gen_gvec_shlv, 2, 4);
 GEN_VXFORM_V(vslh, MO_UW, tcg_gen_gvec_shlv, 2, 5);
-GEN_VXFORM_V(vslw, MO_32, tcg_gen_gvec_shlv, 2, 6);
+GEN_VXFORM_V(vslw, MO_UL, tcg_gen_gvec_shlv, 2, 6);
 GEN_VXFORM(vrlwnm, 2, 6);
 GEN_VXFORM_DUAL(vslw, PPC_ALTIVEC, PPC_NONE, \
                 vrlwnm, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_V(vsld, MO_64, tcg_gen_gvec_shlv, 2, 23);
 GEN_VXFORM_V(vsrb, MO_UB, tcg_gen_gvec_shrv, 2, 8);
 GEN_VXFORM_V(vsrh, MO_UW, tcg_gen_gvec_shrv, 2, 9);
-GEN_VXFORM_V(vsrw, MO_32, tcg_gen_gvec_shrv, 2, 10);
+GEN_VXFORM_V(vsrw, MO_UL, tcg_gen_gvec_shrv, 2, 10);
 GEN_VXFORM_V(vsrd, MO_64, tcg_gen_gvec_shrv, 2, 27);
 GEN_VXFORM_V(vsrab, MO_UB, tcg_gen_gvec_sarv, 2, 12);
 GEN_VXFORM_V(vsrah, MO_UW, tcg_gen_gvec_sarv, 2, 13);
-GEN_VXFORM_V(vsraw, MO_32, tcg_gen_gvec_sarv, 2, 14);
+GEN_VXFORM_V(vsraw, MO_UL, tcg_gen_gvec_sarv, 2, 14);
 GEN_VXFORM_V(vsrad, MO_64, tcg_gen_gvec_sarv, 2, 15);
 GEN_VXFORM(vsrv, 2, 28);
 GEN_VXFORM(vslv, 2, 29);
@@ -595,16 +595,16 @@ GEN_VXFORM_DUAL_EXT(vaddubs, PPC_ALTIVEC, PPC_NONE, 0=
,       \
 GEN_VXFORM_SAT(vadduhs, MO_UW, add, usadd, 0, 9);
 GEN_VXFORM_DUAL(vadduhs, PPC_ALTIVEC, PPC_NONE, \
                 vmul10euq, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM_SAT(vadduws, MO_32, add, usadd, 0, 10);
+GEN_VXFORM_SAT(vadduws, MO_UL, add, usadd, 0, 10);
 GEN_VXFORM_SAT(vaddsbs, MO_UB, add, ssadd, 0, 12);
 GEN_VXFORM_SAT(vaddshs, MO_UW, add, ssadd, 0, 13);
-GEN_VXFORM_SAT(vaddsws, MO_32, add, ssadd, 0, 14);
+GEN_VXFORM_SAT(vaddsws, MO_UL, add, ssadd, 0, 14);
 GEN_VXFORM_SAT(vsububs, MO_UB, sub, ussub, 0, 24);
 GEN_VXFORM_SAT(vsubuhs, MO_UW, sub, ussub, 0, 25);
-GEN_VXFORM_SAT(vsubuws, MO_32, sub, ussub, 0, 26);
+GEN_VXFORM_SAT(vsubuws, MO_UL, sub, ussub, 0, 26);
 GEN_VXFORM_SAT(vsubsbs, MO_UB, sub, sssub, 0, 28);
 GEN_VXFORM_SAT(vsubshs, MO_UW, sub, sssub, 0, 29);
-GEN_VXFORM_SAT(vsubsws, MO_32, sub, sssub, 0, 30);
+GEN_VXFORM_SAT(vsubsws, MO_UL, sub, sssub, 0, 30);
 GEN_VXFORM(vadduqm, 0, 4);
 GEN_VXFORM(vaddcuq, 0, 5);
 GEN_VXFORM3(vaddeuqm, 30, 0);
@@ -914,7 +914,7 @@ static void glue(gen_, name)(DisasContext *ctx)        =
                 \

 GEN_VXFORM_VSPLT(vspltb, MO_UB, 6, 8);
 GEN_VXFORM_VSPLT(vsplth, MO_UW, 6, 9);
-GEN_VXFORM_VSPLT(vspltw, MO_32, 6, 10);
+GEN_VXFORM_VSPLT(vspltw, MO_UL, 6, 10);
 GEN_VXFORM_UIMM_SPLAT(vextractub, 6, 8, 15);
 GEN_VXFORM_UIMM_SPLAT(vextractuh, 6, 9, 14);
 GEN_VXFORM_UIMM_SPLAT(vextractuw, 6, 10, 12);
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx=
-impl.inc.c
index 3922686..212817e 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1553,12 +1553,12 @@ static void gen_xxspltw(DisasContext *ctx)

     tofs =3D vsr_full_offset(rt);
     bofs =3D vsr_full_offset(rb);
-    bofs +=3D uim << MO_32;
+    bofs +=3D uim << MO_UL;
 #ifndef HOST_WORDS_BIG_ENDIAN
     bofs ^=3D 8 | 4;
 #endif

-    tcg_gen_gvec_dup_mem(MO_32, tofs, bofs, 16, 16);
+    tcg_gen_gvec_dup_mem(MO_UL, tofs, bofs, 16, 16);
 }

 #define pattern(x) (((x) & 0xff) * (~(uint64_t)0 / 0xff))
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 415747f..9e646f1 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -196,7 +196,7 @@ static inline int freg64_offset(uint8_t reg)
 static inline int freg32_offset(uint8_t reg)
 {
     g_assert(reg < 16);
-    return vec_reg_offset(reg, 0, MO_32);
+    return vec_reg_offset(reg, 0, MO_UL);
 }

 static TCGv_i64 load_reg(int reg)
@@ -2283,7 +2283,7 @@ static DisasJumpType op_csp(DisasContext *s, DisasOps=
 *o)

     /* Write back the output now, so that it happens before the
        following branch, so that we don't need local temps.  */
-    if ((mop & MO_SIZE) =3D=3D MO_32) {
+    if ((mop & MO_SIZE) =3D=3D MO_UL) {
         tcg_gen_deposit_i64(o->out, o->out, old, 0, 32);
     } else {
         tcg_gen_mov_i64(o->out, old);
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.in=
c.c
index 65da6b3..75d788c 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -48,7 +48,7 @@

 #define ES_8    MO_UB
 #define ES_16   MO_UW
-#define ES_32   MO_32
+#define ES_32   MO_UL
 #define ES_64   MO_64
 #define ES_128  4

diff --git a/target/s390x/vec.h b/target/s390x/vec.h
index 28e1b1d..f67392c 100644
--- a/target/s390x/vec.h
+++ b/target/s390x/vec.h
@@ -80,7 +80,7 @@ static inline uint64_t s390_vec_read_element(const S390Ve=
ctor *v, uint8_t enr,
         return s390_vec_read_element8(v, enr);
     case MO_UW:
         return s390_vec_read_element16(v, enr);
-    case MO_32:
+    case MO_UL:
         return s390_vec_read_element32(v, enr);
     case MO_64:
         return s390_vec_read_element64(v, enr);
@@ -127,7 +127,7 @@ static inline void s390_vec_write_element(S390Vector *v=
, uint8_t enr,
     case MO_UW:
         s390_vec_write_element16(v, enr, data);
         break;
-    case MO_32:
+    case MO_UL:
         s390_vec_write_element32(v, enr, data);
         break;
     case MO_64:
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 3d90c4b..dc4fd21 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -431,12 +431,12 @@ typedef enum {
        that emits them can transform to 3.3.10 or 3.3.13.  */
     I3312_STRB      =3D 0x38000000 | LDST_ST << 22 | MO_UB << 30,
     I3312_STRH      =3D 0x38000000 | LDST_ST << 22 | MO_UW << 30,
-    I3312_STRW      =3D 0x38000000 | LDST_ST << 22 | MO_32 << 30,
+    I3312_STRW      =3D 0x38000000 | LDST_ST << 22 | MO_UL << 30,
     I3312_STRX      =3D 0x38000000 | LDST_ST << 22 | MO_64 << 30,

     I3312_LDRB      =3D 0x38000000 | LDST_LD << 22 | MO_UB << 30,
     I3312_LDRH      =3D 0x38000000 | LDST_LD << 22 | MO_UW << 30,
-    I3312_LDRW      =3D 0x38000000 | LDST_LD << 22 | MO_32 << 30,
+    I3312_LDRW      =3D 0x38000000 | LDST_LD << 22 | MO_UL << 30,
     I3312_LDRX      =3D 0x38000000 | LDST_LD << 22 | MO_64 << 30,

     I3312_LDRSBW    =3D 0x38000000 | LDST_LD_S_W << 22 | MO_UB << 30,
@@ -444,10 +444,10 @@ typedef enum {

     I3312_LDRSBX    =3D 0x38000000 | LDST_LD_S_X << 22 | MO_UB << 30,
     I3312_LDRSHX    =3D 0x38000000 | LDST_LD_S_X << 22 | MO_UW << 30,
-    I3312_LDRSWX    =3D 0x38000000 | LDST_LD_S_X << 22 | MO_32 << 30,
+    I3312_LDRSWX    =3D 0x38000000 | LDST_LD_S_X << 22 | MO_UL << 30,

-    I3312_LDRVS     =3D 0x3c000000 | LDST_LD << 22 | MO_32 << 30,
-    I3312_STRVS     =3D 0x3c000000 | LDST_ST << 22 | MO_32 << 30,
+    I3312_LDRVS     =3D 0x3c000000 | LDST_LD << 22 | MO_UL << 30,
+    I3312_STRVS     =3D 0x3c000000 | LDST_ST << 22 | MO_UL << 30,

     I3312_LDRVD     =3D 0x3c000000 | LDST_LD << 22 | MO_64 << 30,
     I3312_STRVD     =3D 0x3c000000 | LDST_ST << 22 | MO_64 << 30,
@@ -870,7 +870,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType typ=
e,

     /*
      * Test all bytes 0x00 or 0xff second.  This can match cases that
-     * might otherwise take 2 or 3 insns for MO_UW or MO_32 below.
+     * might otherwise take 2 or 3 insns for MO_UW or MO_UL below.
      */
     for (i =3D imm8 =3D 0; i < 8; i++) {
         uint8_t byte =3D v64 >> (i * 8);
@@ -908,7 +908,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType typ=
e,
         tcg_out_insn(s, 3606, MOVI, q, rd, 0, 0x8, v16 & 0xff);
         tcg_out_insn(s, 3606, ORR, q, rd, 0, 0xa, v16 >> 8);
         return;
-    } else if (v64 =3D=3D dup_const(MO_32, v64)) {
+    } else if (v64 =3D=3D dup_const(MO_UL, v64)) {
         uint32_t v32 =3D v64;
         uint32_t n32 =3D ~v32;

@@ -1749,7 +1749,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCG=
MemOp memop, TCGType ext,
         if (bswap) {
             tcg_out_ldst_r(s, I3312_LDRW, data_r, addr_r, otype, off_r);
             tcg_out_rev32(s, data_r, data_r);
-            tcg_out_sxt(s, TCG_TYPE_I64, MO_32, data_r, data_r);
+            tcg_out_sxt(s, TCG_TYPE_I64, MO_UL, data_r, data_r);
         } else {
             tcg_out_ldst_r(s, I3312_LDRSWX, data_r, addr_r, otype, off_r);
         }
@@ -1782,7 +1782,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
MemOp memop,
         }
         tcg_out_ldst_r(s, I3312_STRH, data_r, addr_r, otype, off_r);
         break;
-    case MO_32:
+    case MO_UL:
         if (bswap && data_r !=3D TCG_REG_XZR) {
             tcg_out_rev32(s, TCG_REG_TMP, data_r);
             data_r =3D TCG_REG_TMP;
@@ -2194,7 +2194,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_ext_i32_i64:
     case INDEX_op_ext32s_i64:
-        tcg_out_sxt(s, TCG_TYPE_I64, MO_32, a0, a1);
+        tcg_out_sxt(s, TCG_TYPE_I64, MO_UL, a0, a1);
         break;
     case INDEX_op_ext8u_i64:
     case INDEX_op_ext8u_i32:
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 0bd400e..05560a2 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1435,7 +1435,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
     case MO_UW:
         argreg =3D tcg_out_arg_reg16(s, argreg, datalo);
         break;
-    case MO_32:
+    case MO_UL:
     default:
         argreg =3D tcg_out_arg_reg32(s, argreg, datalo);
         break;
@@ -1632,7 +1632,7 @@ static inline void tcg_out_qemu_st_index(TCGContext *=
s, int cond, TCGMemOp opc,
             tcg_out_st16_r(s, cond, datalo, addrlo, addend);
         }
         break;
-    case MO_32:
+    case MO_UL:
     default:
         if (bswap) {
             tcg_out_bswap32(s, cond, TCG_REG_R0, datalo);
@@ -1677,7 +1677,7 @@ static inline void tcg_out_qemu_st_direct(TCGContext =
*s, TCGMemOp opc,
             tcg_out_st16_8(s, COND_AL, datalo, addrlo, 0);
         }
         break;
-    case MO_32:
+    case MO_UL:
     default:
         if (bswap) {
             tcg_out_bswap32(s, COND_AL, TCG_REG_R0, datalo);
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 31c3664..93e4c63 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -897,7 +897,7 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type=
, unsigned vece,
             tcg_out_vex_modrm(s, OPC_PUNPCKLWD, r, a, a);
             a =3D r;
             /* FALLTHRU */
-        case MO_32:
+        case MO_UL:
             tcg_out_vex_modrm(s, OPC_PSHUFD, r, 0, a);
             /* imm8 operand: all output lanes selected from input lane 0. =
 */
             tcg_out8(s, 0);
@@ -924,7 +924,7 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType typ=
e, unsigned vece,
         case MO_64:
             tcg_out_vex_modrm_offset(s, OPC_MOVDDUP, r, 0, base, offset);
             break;
-        case MO_32:
+        case MO_UL:
             tcg_out_vex_modrm_offset(s, OPC_VBROADCASTSS, r, 0, base, offs=
et);
             break;
         case MO_UW:
@@ -2173,7 +2173,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
Reg datalo, TCGReg datahi,
         tcg_out_modrm_sib_offset(s, movop + P_DATA16 + seg, datalo,
                                  base, index, 0, ofs);
         break;
-    case MO_32:
+    case MO_UL:
         if (bswap) {
             tcg_out_mov(s, TCG_TYPE_I32, scratch, datalo);
             tcg_out_bswap32(s, scratch);
@@ -2927,7 +2927,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode o=
pc,
     case INDEX_op_x86_blend_vec:
         if (vece =3D=3D MO_UW) {
             insn =3D OPC_PBLENDW;
-        } else if (vece =3D=3D MO_32) {
+        } else if (vece =3D=3D MO_UL) {
             insn =3D (have_avx2 ? OPC_VPBLENDD : OPC_BLENDPS);
         } else {
             g_assert_not_reached();
@@ -3292,13 +3292,13 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type=
, unsigned vece)
     case INDEX_op_shrs_vec:
         return vece >=3D MO_UW;
     case INDEX_op_sars_vec:
-        return vece >=3D MO_UW && vece <=3D MO_32;
+        return vece >=3D MO_UW && vece <=3D MO_UL;

     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
-        return have_avx2 && vece >=3D MO_32;
+        return have_avx2 && vece >=3D MO_UL;
     case INDEX_op_sarv_vec:
-        return have_avx2 && vece =3D=3D MO_32;
+        return have_avx2 && vece =3D=3D MO_UL;

     case INDEX_op_mul_vec:
         if (vece =3D=3D MO_UB) {
@@ -3320,7 +3320,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, =
unsigned vece)
     case INDEX_op_umin_vec:
     case INDEX_op_umax_vec:
     case INDEX_op_abs_vec:
-        return vece <=3D MO_32;
+        return vece <=3D MO_UL;

     default:
         return 0;
@@ -3396,9 +3396,9 @@ static void expand_vec_sari(TCGType type, unsigned ve=
ce,
              * shift (note that the ISA says shift of 32 is valid).
              */
             t1 =3D tcg_temp_new_vec(type);
-            tcg_gen_sari_vec(MO_32, t1, v1, imm);
+            tcg_gen_sari_vec(MO_UL, t1, v1, imm);
             tcg_gen_shri_vec(MO_64, v0, v1, imm);
-            vec_gen_4(INDEX_op_x86_blend_vec, type, MO_32,
+            vec_gen_4(INDEX_op_x86_blend_vec, type, MO_UL,
                       tcgv_vec_arg(v0), tcgv_vec_arg(v0),
                       tcgv_vec_arg(t1), 0xaa);
             tcg_temp_free_vec(t1);
@@ -3515,28 +3515,28 @@ static bool expand_vec_cmp_noinv(TCGType type, unsi=
gned vece, TCGv_vec v0,
         fixup =3D NEED_SWAP | NEED_INV;
         break;
     case TCG_COND_LEU:
-        if (vece <=3D MO_32) {
+        if (vece <=3D MO_UL) {
             fixup =3D NEED_UMIN;
         } else {
             fixup =3D NEED_BIAS | NEED_INV;
         }
         break;
     case TCG_COND_GTU:
-        if (vece <=3D MO_32) {
+        if (vece <=3D MO_UL) {
             fixup =3D NEED_UMIN | NEED_INV;
         } else {
             fixup =3D NEED_BIAS;
         }
         break;
     case TCG_COND_GEU:
-        if (vece <=3D MO_32) {
+        if (vece <=3D MO_UL) {
             fixup =3D NEED_UMAX;
         } else {
             fixup =3D NEED_BIAS | NEED_SWAP | NEED_INV;
         }
         break;
     case TCG_COND_LTU:
-        if (vece <=3D MO_32) {
+        if (vece <=3D MO_UL) {
             fixup =3D NEED_UMAX | NEED_INV;
         } else {
             fixup =3D NEED_BIAS | NEED_SWAP;
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 1780cb1..a78fe87 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1386,7 +1386,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
     case MO_UW:
         i =3D tcg_out_call_iarg_reg16(s, i, l->datalo_reg);
         break;
-    case MO_32:
+    case MO_UL:
         i =3D tcg_out_call_iarg_reg(s, i, l->datalo_reg);
         break;
     case MO_64:
@@ -1579,11 +1579,11 @@ static void tcg_out_qemu_st_direct(TCGContext *s, T=
CGReg lo, TCGReg hi,
         tcg_out_opc_imm(s, OPC_SH, lo, base, 0);
         break;

-    case MO_32 | MO_BSWAP:
+    case MO_UL | MO_BSWAP:
         tcg_out_bswap32(s, TCG_TMP3, lo);
         lo =3D TCG_TMP3;
         /* FALLTHRU */
-    case MO_32:
+    case MO_UL:
         tcg_out_opc_imm(s, OPC_SW, lo, base, 0);
         break;

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 852b894..835336a 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1714,7 +1714,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
 #endif
             tcg_out_mov(s, TCG_TYPE_I32, arg++, hi);
             /* FALLTHRU */
-        case MO_32:
+        case MO_UL:
             tcg_out_mov(s, TCG_TYPE_I32, arg++, lo);
             break;
         default:
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 20bc19d..1905986 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1222,7 +1222,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
Reg lo, TCGReg hi,
     case MO_UW:
         tcg_out_opc_store(s, OPC_SH, base, lo, 0);
         break;
-    case MO_32:
+    case MO_UL:
         tcg_out_opc_store(s, OPC_SW, base, lo, 0);
         break;
     case MO_64:
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 85550b5..ac0d3a3 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -889,7 +889,7 @@ static void emit_extend(TCGContext *s, TCGReg r, int op=
)
         tcg_out_arithi(s, r, r, 16, SHIFT_SLL);
         tcg_out_arithi(s, r, r, 16, SHIFT_SRL);
         break;
-    case MO_32:
+    case MO_UL:
         if (SPARC64) {
             tcg_out_arith(s, r, r, 0, SHIFT_SRL);
         }
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index da409f5..e63622c 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -310,7 +310,7 @@ uint64_t (dup_const)(unsigned vece, uint64_t c)
         return 0x0101010101010101ull * (uint8_t)c;
     case MO_UW:
         return 0x0001000100010001ull * (uint16_t)c;
-    case MO_32:
+    case MO_UL:
         return 0x0000000100000001ull * (uint32_t)c;
     case MO_64:
         return c;
@@ -330,7 +330,7 @@ static void gen_dup_i32(unsigned vece, TCGv_i32 out, TC=
Gv_i32 in)
     case MO_UW:
         tcg_gen_deposit_i32(out, in, in, 16, 16);
         break;
-    case MO_32:
+    case MO_UL:
         tcg_gen_mov_i32(out, in);
         break;
     default:
@@ -349,7 +349,7 @@ static void gen_dup_i64(unsigned vece, TCGv_i64 out, TC=
Gv_i64 in)
         tcg_gen_ext16u_i64(out, in);
         tcg_gen_muli_i64(out, out, 0x0001000100010001ull);
         break;
-    case MO_32:
+    case MO_UL:
         tcg_gen_deposit_i64(out, in, in, 32, 32);
         break;
     case MO_64:
@@ -443,7 +443,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32=
_t oprsz,
     TCGv_ptr t_ptr;
     uint32_t i;

-    assert(vece <=3D (in_32 ? MO_32 : MO_64));
+    assert(vece <=3D (in_32 ? MO_UL : MO_64));
     assert(in_32 =3D=3D NULL || in_64 =3D=3D NULL);

     /* If we're storing 0, expand oprsz to maxsz.  */
@@ -485,7 +485,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32=
_t oprsz,
                use a 64-bit operation unless the 32-bit operation would
                be simple enough.  */
             if (TCG_TARGET_REG_BITS =3D=3D 64
-                && (vece !=3D MO_32 || !check_size_impl(oprsz, 4))) {
+                && (vece !=3D MO_UL || !check_size_impl(oprsz, 4))) {
                 t_64 =3D tcg_temp_new_i64();
                 tcg_gen_extu_i32_i64(t_64, in_32);
                 gen_dup_i64(vece, t_64, t_64);
@@ -1430,7 +1430,7 @@ void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dof=
s, uint32_t oprsz,
                           uint32_t maxsz, TCGv_i32 in)
 {
     check_size_align(oprsz, maxsz, dofs);
-    tcg_debug_assert(vece <=3D MO_32);
+    tcg_debug_assert(vece <=3D MO_UL);
     do_dup(vece, dofs, oprsz, maxsz, in, NULL, 0);
 }

@@ -1453,7 +1453,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dof=
s, uint32_t aofs,
             tcg_gen_dup_mem_vec(vece, t_vec, cpu_env, aofs);
             do_dup_store(type, dofs, oprsz, maxsz, t_vec);
             tcg_temp_free_vec(t_vec);
-        } else if (vece <=3D MO_32) {
+        } else if (vece <=3D MO_UL) {
             TCGv_i32 in =3D tcg_temp_new_i32();
             switch (vece) {
             case MO_UB:
@@ -1519,7 +1519,7 @@ void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t oprs=
z,
                          uint32_t maxsz, uint32_t x)
 {
     check_size_align(oprsz, maxsz, dofs);
-    do_dup(MO_32, dofs, oprsz, maxsz, NULL, NULL, x);
+    do_dup(MO_UL, dofs, oprsz, maxsz, NULL, NULL, x);
 }

 void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t oprsz,
@@ -1618,7 +1618,7 @@ void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, u=
int32_t aofs,
           .fniv =3D tcg_gen_add_vec,
           .fno =3D gen_helper_gvec_add32,
           .opt_opc =3D vecop_list_add,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_add_i64,
           .fniv =3D tcg_gen_add_vec,
           .fno =3D gen_helper_gvec_add64,
@@ -1649,7 +1649,7 @@ void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_add_vec,
           .fno =3D gen_helper_gvec_adds32,
           .opt_opc =3D vecop_list_add,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_add_i64,
           .fniv =3D tcg_gen_add_vec,
           .fno =3D gen_helper_gvec_adds64,
@@ -1690,7 +1690,7 @@ void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_gvec_subs32,
           .opt_opc =3D vecop_list_sub,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_sub_i64,
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_gvec_subs64,
@@ -1769,7 +1769,7 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, u=
int32_t aofs,
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_gvec_sub32,
           .opt_opc =3D vecop_list_sub,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_sub_i64,
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_gvec_sub64,
@@ -1800,7 +1800,7 @@ void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, u=
int32_t aofs,
           .fniv =3D tcg_gen_mul_vec,
           .fno =3D gen_helper_gvec_mul32,
           .opt_opc =3D vecop_list_mul,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_mul_i64,
           .fniv =3D tcg_gen_mul_vec,
           .fno =3D gen_helper_gvec_mul64,
@@ -1829,7 +1829,7 @@ void tcg_gen_gvec_muls(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_mul_vec,
           .fno =3D gen_helper_gvec_muls32,
           .opt_opc =3D vecop_list_mul,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_mul_i64,
           .fniv =3D tcg_gen_mul_vec,
           .fno =3D gen_helper_gvec_muls64,
@@ -1866,7 +1866,7 @@ void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
         { .fniv =3D tcg_gen_ssadd_vec,
           .fno =3D gen_helper_gvec_ssadd32,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fniv =3D tcg_gen_ssadd_vec,
           .fno =3D gen_helper_gvec_ssadd64,
           .opt_opc =3D vecop_list,
@@ -1892,7 +1892,7 @@ void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
         { .fniv =3D tcg_gen_sssub_vec,
           .fno =3D gen_helper_gvec_sssub32,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fniv =3D tcg_gen_sssub_vec,
           .fno =3D gen_helper_gvec_sssub64,
           .opt_opc =3D vecop_list,
@@ -1935,7 +1935,7 @@ void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
           .fniv =3D tcg_gen_usadd_vec,
           .fno =3D gen_helper_gvec_usadd32,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_usadd_i64,
           .fniv =3D tcg_gen_usadd_vec,
           .fno =3D gen_helper_gvec_usadd64,
@@ -1979,7 +1979,7 @@ void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
           .fniv =3D tcg_gen_ussub_vec,
           .fno =3D gen_helper_gvec_ussub32,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_ussub_i64,
           .fniv =3D tcg_gen_ussub_vec,
           .fno =3D gen_helper_gvec_ussub64,
@@ -2007,7 +2007,7 @@ void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_smin_vec,
           .fno =3D gen_helper_gvec_smin32,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_smin_i64,
           .fniv =3D tcg_gen_smin_vec,
           .fno =3D gen_helper_gvec_smin64,
@@ -2035,7 +2035,7 @@ void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_umin_vec,
           .fno =3D gen_helper_gvec_umin32,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_umin_i64,
           .fniv =3D tcg_gen_umin_vec,
           .fno =3D gen_helper_gvec_umin64,
@@ -2063,7 +2063,7 @@ void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_smax_vec,
           .fno =3D gen_helper_gvec_smax32,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_smax_i64,
           .fniv =3D tcg_gen_smax_vec,
           .fno =3D gen_helper_gvec_smax64,
@@ -2091,7 +2091,7 @@ void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_umax_vec,
           .fno =3D gen_helper_gvec_umax32,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_umax_i64,
           .fniv =3D tcg_gen_umax_vec,
           .fno =3D gen_helper_gvec_umax64,
@@ -2165,7 +2165,7 @@ void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, u=
int32_t aofs,
           .fniv =3D tcg_gen_neg_vec,
           .fno =3D gen_helper_gvec_neg32,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_neg_i64,
           .fniv =3D tcg_gen_neg_vec,
           .fno =3D gen_helper_gvec_neg64,
@@ -2228,7 +2228,7 @@ void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, u=
int32_t aofs,
           .fniv =3D tcg_gen_abs_vec,
           .fno =3D gen_helper_gvec_abs32,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_abs_i64,
           .fniv =3D tcg_gen_abs_vec,
           .fno =3D gen_helper_gvec_abs64,
@@ -2485,7 +2485,7 @@ void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_shli_vec,
           .fno =3D gen_helper_gvec_shl32i,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_shli_i64,
           .fniv =3D tcg_gen_shli_vec,
           .fno =3D gen_helper_gvec_shl64i,
@@ -2536,7 +2536,7 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_shri_vec,
           .fno =3D gen_helper_gvec_shr32i,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_shri_i64,
           .fniv =3D tcg_gen_shri_vec,
           .fno =3D gen_helper_gvec_shr64i,
@@ -2601,7 +2601,7 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_sari_vec,
           .fno =3D gen_helper_gvec_sar32i,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_sari_i64,
           .fniv =3D tcg_gen_sari_vec,
           .fno =3D gen_helper_gvec_sar64i,
@@ -2736,7 +2736,7 @@ do_gvec_shifts(unsigned vece, uint32_t dofs, uint32_t=
 aofs, TCGv_i32 shift,
     }

     /* Otherwise fall back to integral... */
-    if (vece =3D=3D MO_32 && check_size_impl(oprsz, 4)) {
+    if (vece =3D=3D MO_UL && check_size_impl(oprsz, 4)) {
         expand_2s_i32(dofs, aofs, oprsz, shift, false, g->fni4);
     } else if (vece =3D=3D MO_64 && check_size_impl(oprsz, 8)) {
         TCGv_i64 sh64 =3D tcg_temp_new_i64();
@@ -2889,7 +2889,7 @@ void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_shlv_mod_vec,
           .fno =3D gen_helper_gvec_shl32v,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_shl_mod_i64,
           .fniv =3D tcg_gen_shlv_mod_vec,
           .fno =3D gen_helper_gvec_shl64v,
@@ -2952,7 +2952,7 @@ void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_shrv_mod_vec,
           .fno =3D gen_helper_gvec_shr32v,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_shr_mod_i64,
           .fniv =3D tcg_gen_shrv_mod_vec,
           .fno =3D gen_helper_gvec_shr64v,
@@ -3015,7 +3015,7 @@ void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_sarv_mod_vec,
           .fno =3D gen_helper_gvec_sar32v,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_32 },
+          .vece =3D MO_UL },
         { .fni8 =3D tcg_gen_sar_mod_i64,
           .fniv =3D tcg_gen_sarv_mod_vec,
           .fno =3D gen_helper_gvec_sar64v,
@@ -3168,7 +3168,7 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, ui=
nt32_t dofs,
     case 0:
         if (vece =3D=3D MO_64 && check_size_impl(oprsz, 8)) {
             expand_cmp_i64(dofs, aofs, bofs, oprsz, cond);
-        } else if (vece =3D=3D MO_32 && check_size_impl(oprsz, 4)) {
+        } else if (vece =3D=3D MO_UL && check_size_impl(oprsz, 4)) {
             expand_cmp_i32(dofs, aofs, bofs, oprsz, cond);
         } else {
             gen_helper_gvec_3 * const *fn =3D fns[cond];
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index b0a4d98..ff723ab 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -216,7 +216,7 @@ void tcg_gen_mov_vec(TCGv_vec r, TCGv_vec a)
     }
 }

-#define MO_REG  (TCG_TARGET_REG_BITS =3D=3D 64 ? MO_64 : MO_32)
+#define MO_REG  (TCG_TARGET_REG_BITS =3D=3D 64 ? MO_64 : MO_UL)

 static void do_dupi_vec(TCGv_vec r, unsigned vece, TCGArg a)
 {
@@ -253,7 +253,7 @@ TCGv_vec tcg_const_ones_vec_matching(TCGv_vec m)
 void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)
 {
     if (TCG_TARGET_REG_BITS =3D=3D 32 && a =3D=3D deposit64(a, 32, 32, a))=
 {
-        do_dupi_vec(r, MO_32, a);
+        do_dupi_vec(r, MO_UL, a);
     } else if (TCG_TARGET_REG_BITS =3D=3D 64 || a =3D=3D (uint64_t)(int32_=
t)a) {
         do_dupi_vec(r, MO_64, a);
     } else {
@@ -265,7 +265,7 @@ void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)

 void tcg_gen_dup32i_vec(TCGv_vec r, uint32_t a)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_32, a));
+    do_dupi_vec(r, MO_REG, dup_const(MO_UL, a));
 }

 void tcg_gen_dup16i_vec(TCGv_vec r, uint32_t a)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 21d448c..447683d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2725,7 +2725,7 @@ static inline TCGMemOp tcg_canonicalize_memop(TCGMemO=
p op, bool is64, bool st)
         break;
     case MO_UW:
         break;
-    case MO_32:
+    case MO_UL:
         if (!is64) {
             op &=3D ~MO_SIGN;
         }
@@ -2816,7 +2816,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
                 tcg_gen_ext16s_i32(val, val);
             }
             break;
-        case MO_32:
+        case MO_UL:
             tcg_gen_bswap32_i32(val, val);
             break;
         default:
@@ -2841,7 +2841,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
             tcg_gen_ext16u_i32(swap, val);
             tcg_gen_bswap16_i32(swap, swap);
             break;
-        case MO_32:
+        case MO_UL:
             tcg_gen_bswap32_i32(swap, val);
             break;
         default:
@@ -2896,7 +2896,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
                 tcg_gen_ext16s_i64(val, val);
             }
             break;
-        case MO_32:
+        case MO_UL:
             tcg_gen_bswap32_i64(val, val);
             if (orig_memop & MO_SIGN) {
                 tcg_gen_ext32s_i64(val, val);
@@ -2932,7 +2932,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
             tcg_gen_ext16u_i64(swap, val);
             tcg_gen_bswap16_i64(swap, swap);
             break;
-        case MO_32:
+        case MO_UL:
             tcg_gen_ext32u_i64(swap, val);
             tcg_gen_bswap32_i64(swap, swap);
             break;
@@ -3027,8 +3027,8 @@ static void * const table_cmpxchg[16] =3D {
     [MO_UB] =3D gen_helper_atomic_cmpxchgb,
     [MO_UW | MO_LE] =3D gen_helper_atomic_cmpxchgw_le,
     [MO_UW | MO_BE] =3D gen_helper_atomic_cmpxchgw_be,
-    [MO_32 | MO_LE] =3D gen_helper_atomic_cmpxchgl_le,
-    [MO_32 | MO_BE] =3D gen_helper_atomic_cmpxchgl_be,
+    [MO_UL | MO_LE] =3D gen_helper_atomic_cmpxchgl_le,
+    [MO_UL | MO_BE] =3D gen_helper_atomic_cmpxchgl_be,
     WITH_ATOMIC64([MO_64 | MO_LE] =3D gen_helper_atomic_cmpxchgq_le)
     WITH_ATOMIC64([MO_64 | MO_BE] =3D gen_helper_atomic_cmpxchgq_be)
 };
@@ -3251,8 +3251,8 @@ static void * const table_##NAME[16] =3D {           =
                     \
     [MO_UB] =3D gen_helper_atomic_##NAME##b,                              =
 \
     [MO_UW | MO_LE] =3D gen_helper_atomic_##NAME##w_le,                   =
\
     [MO_UW | MO_BE] =3D gen_helper_atomic_##NAME##w_be,                   =
\
-    [MO_32 | MO_LE] =3D gen_helper_atomic_##NAME##l_le,                   =
\
-    [MO_32 | MO_BE] =3D gen_helper_atomic_##NAME##l_be,                   =
\
+    [MO_UL | MO_LE] =3D gen_helper_atomic_##NAME##l_le,                   =
\
+    [MO_UL | MO_BE] =3D gen_helper_atomic_##NAME##l_be,                   =
\
     WITH_ATOMIC64([MO_64 | MO_LE] =3D gen_helper_atomic_##NAME##q_le)     =
\
     WITH_ATOMIC64([MO_64 | MO_BE] =3D gen_helper_atomic_##NAME##q_be)     =
\
 };                                                                      \
diff --git a/tcg/tcg.h b/tcg/tcg.h
index a378887..4b6ee89 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1304,7 +1304,7 @@ uint64_t dup_const(unsigned vece, uint64_t c);
     (__builtin_constant_p(VECE)                                    \
      ?   ((VECE) =3D=3D MO_UB ? 0x0101010101010101ull * (uint8_t)(C)   \
         : (VECE) =3D=3D MO_UW ? 0x0001000100010001ull * (uint16_t)(C)  \
-        : (VECE) =3D=3D MO_32 ? 0x0000000100000001ull * (uint32_t)(C)  \
+        : (VECE) =3D=3D MO_UL ? 0x0000000100000001ull * (uint32_t)(C)  \
         : dup_const(VECE, C))                                      \
      : dup_const(VECE, C))

--
1.8.3.1



