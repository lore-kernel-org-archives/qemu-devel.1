Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD728C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E7A2190F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E7A2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpaOk-0008Gr-ON
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 11:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51327)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hpaON-0007oy-B6
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hpaOD-0007eb-LQ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:38:23 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.74]:32149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1hpaOC-0007dO-U8
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:38:13 -0400
Received: from tpw09926dag18f.domain1.systemhost.net (10.9.212.26) by
 BWP09926079.bt.com (10.36.82.110) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Mon, 22
 Jul 2019 16:38:09 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18f.domain1.systemhost.net (10.9.212.26) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Mon, 22 Jul 2019 16:38:09 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Mon, 22 Jul
 2019 16:38:09 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 01/20] tcg: Replace MO_8 with MO_UB alias
Thread-Index: AQHVQKNq0Qv9Y9yzaki71enBtb4N6w==
Date: Mon, 22 Jul 2019 15:38:09 +0000
Message-ID: <1563809888089.57547@bt.com>
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
X-Received-From: 213.121.35.74
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel]  [PATCH v2 01/20] tcg: Replace MO_8 with MO_UB alias
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

Preparation for splitting MO_8 out from TCGMemOp into new accelerator
independent MemOp.

As MO_8 will be a value of MemOp, existing TCGMemOp comparisons and
coercions will trigger -Wenum-compare and -Wenum-conversion.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 target/arm/sve_helper.c             |  4 +-
 target/arm/translate-a64.c          | 14 +++----
 target/arm/translate-sve.c          |  4 +-
 target/arm/translate.c              | 38 +++++++++----------
 target/i386/translate.c             | 72 +++++++++++++++++----------------=
--
 target/mips/translate.c             |  4 +-
 target/ppc/translate/vmx-impl.inc.c | 28 +++++++-------
 target/s390x/translate.c            |  2 +-
 target/s390x/translate_vx.inc.c     |  4 +-
 target/s390x/vec.h                  |  4 +-
 tcg/aarch64/tcg-target.inc.c        | 16 ++++----
 tcg/arm/tcg-target.inc.c            |  6 +--
 tcg/i386/tcg-target.inc.c           | 54 +++++++++++++-------------
 tcg/mips/tcg-target.inc.c           |  4 +-
 tcg/riscv/tcg-target.inc.c          |  4 +-
 tcg/sparc/tcg-target.inc.c          |  2 +-
 tcg/tcg-op-gvec.c                   | 76 ++++++++++++++++++---------------=
----
 tcg/tcg-op-vec.c                    | 10 ++---
 tcg/tcg-op.c                        |  6 +--
 tcg/tcg.h                           |  2 +-
 20 files changed, 177 insertions(+), 177 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index fc0c175..4c7e11f 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1531,7 +1531,7 @@ void HELPER(sve_cpy_m_b)(void *vd, void *vn, void *vg=
,
     uint64_t *d =3D vd, *n =3D vn;
     uint8_t *pg =3D vg;

-    mm =3D dup_const(MO_8, mm);
+    mm =3D dup_const(MO_UB, mm);
     for (i =3D 0; i < opr_sz; i +=3D 1) {
         uint64_t nn =3D n[i];
         uint64_t pp =3D expand_pred_b(pg[H1(i)]);
@@ -1588,7 +1588,7 @@ void HELPER(sve_cpy_z_b)(void *vd, void *vg, uint64_t=
 val, uint32_t desc)
     uint64_t *d =3D vd;
     uint8_t *pg =3D vg;

-    val =3D dup_const(MO_8, val);
+    val =3D dup_const(MO_UB, val);
     for (i =3D 0; i < opr_sz; i +=3D 1) {
         d[i] =3D val & expand_pred_b(pg[H1(i)]);
     }
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d323147..f840b43 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -993,7 +993,7 @@ static void read_vec_element(DisasContext *s, TCGv_i64 =
tcg_dest, int srcidx,
 {
     int vect_off =3D vec_reg_offset(s, srcidx, element, memop & MO_SIZE);
     switch (memop) {
-    case MO_8:
+    case MO_UB:
         tcg_gen_ld8u_i64(tcg_dest, cpu_env, vect_off);
         break;
     case MO_16:
@@ -1002,7 +1002,7 @@ static void read_vec_element(DisasContext *s, TCGv_i6=
4 tcg_dest, int srcidx,
     case MO_32:
         tcg_gen_ld32u_i64(tcg_dest, cpu_env, vect_off);
         break;
-    case MO_8|MO_SIGN:
+    case MO_SB:
         tcg_gen_ld8s_i64(tcg_dest, cpu_env, vect_off);
         break;
     case MO_16|MO_SIGN:
@@ -1025,13 +1025,13 @@ static void read_vec_element_i32(DisasContext *s, T=
CGv_i32 tcg_dest, int srcidx,
 {
     int vect_off =3D vec_reg_offset(s, srcidx, element, memop & MO_SIZE);
     switch (memop) {
-    case MO_8:
+    case MO_UB:
         tcg_gen_ld8u_i32(tcg_dest, cpu_env, vect_off);
         break;
     case MO_16:
         tcg_gen_ld16u_i32(tcg_dest, cpu_env, vect_off);
         break;
-    case MO_8|MO_SIGN:
+    case MO_SB:
         tcg_gen_ld8s_i32(tcg_dest, cpu_env, vect_off);
         break;
     case MO_16|MO_SIGN:
@@ -1052,7 +1052,7 @@ static void write_vec_element(DisasContext *s, TCGv_i=
64 tcg_src, int destidx,
 {
     int vect_off =3D vec_reg_offset(s, destidx, element, memop & MO_SIZE);
     switch (memop) {
-    case MO_8:
+    case MO_UB:
         tcg_gen_st8_i64(tcg_src, cpu_env, vect_off);
         break;
     case MO_16:
@@ -1074,7 +1074,7 @@ static void write_vec_element_i32(DisasContext *s, TC=
Gv_i32 tcg_src,
 {
     int vect_off =3D vec_reg_offset(s, destidx, element, memop & MO_SIZE);
     switch (memop) {
-    case MO_8:
+    case MO_UB:
         tcg_gen_st8_i32(tcg_src, cpu_env, vect_off);
         break;
     case MO_16:
@@ -12885,7 +12885,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)

     default: /* integer */
         switch (size) {
-        case MO_8:
+        case MO_UB:
         case MO_64:
             unallocated_encoding(s);
             return;
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index fa068b0..ec5fb11 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -1665,7 +1665,7 @@ static void do_sat_addsub_vec(DisasContext *s, int es=
z, int rd, int rn,
     desc =3D tcg_const_i32(simd_desc(vsz, vsz, 0));

     switch (esz) {
-    case MO_8:
+    case MO_UB:
         t32 =3D tcg_temp_new_i32();
         tcg_gen_extrl_i64_i32(t32, val);
         if (d) {
@@ -3308,7 +3308,7 @@ static bool trans_SUBR_zzi(DisasContext *s, arg_rri_e=
sz *a)
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_sve_subri_b,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8,
+          .vece =3D MO_UB,
           .scalar_first =3D true },
         { .fni8 =3D tcg_gen_vec_sub16_i64,
           .fniv =3D tcg_gen_sub_vec,
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7853462..39266cf 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1474,7 +1474,7 @@ static void neon_store_element(int reg, int ele, TCGM=
emOp size, TCGv_i32 var)
     long offset =3D neon_element_offset(reg, ele, size);

     switch (size) {
-    case MO_8:
+    case MO_UB:
         tcg_gen_st8_i32(var, cpu_env, offset);
         break;
     case MO_16:
@@ -1493,7 +1493,7 @@ static void neon_store_element64(int reg, int ele, TC=
GMemOp size, TCGv_i64 var)
     long offset =3D neon_element_offset(reg, ele, size);

     switch (size) {
-    case MO_8:
+    case MO_UB:
         tcg_gen_st8_i64(var, cpu_env, offset);
         break;
     case MO_16:
@@ -4262,7 +4262,7 @@ const GVecGen2i ssra_op[4] =3D {
       .fniv =3D gen_ssra_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_ssra,
-      .vece =3D MO_8 },
+      .vece =3D MO_UB },
     { .fni8 =3D gen_ssra16_i64,
       .fniv =3D gen_ssra_vec,
       .load_dest =3D true,
@@ -4320,7 +4320,7 @@ const GVecGen2i usra_op[4] =3D {
       .fniv =3D gen_usra_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_usra,
-      .vece =3D MO_8, },
+      .vece =3D MO_UB, },
     { .fni8 =3D gen_usra16_i64,
       .fniv =3D gen_usra_vec,
       .load_dest =3D true,
@@ -4341,7 +4341,7 @@ const GVecGen2i usra_op[4] =3D {

 static void gen_shr8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
-    uint64_t mask =3D dup_const(MO_8, 0xff >> shift);
+    uint64_t mask =3D dup_const(MO_UB, 0xff >> shift);
     TCGv_i64 t =3D tcg_temp_new_i64();

     tcg_gen_shri_i64(t, a, shift);
@@ -4400,7 +4400,7 @@ const GVecGen2i sri_op[4] =3D {
       .fniv =3D gen_shr_ins_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_sri,
-      .vece =3D MO_8 },
+      .vece =3D MO_UB },
     { .fni8 =3D gen_shr16_ins_i64,
       .fniv =3D gen_shr_ins_vec,
       .load_dest =3D true,
@@ -4421,7 +4421,7 @@ const GVecGen2i sri_op[4] =3D {

 static void gen_shl8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
-    uint64_t mask =3D dup_const(MO_8, 0xff << shift);
+    uint64_t mask =3D dup_const(MO_UB, 0xff << shift);
     TCGv_i64 t =3D tcg_temp_new_i64();

     tcg_gen_shli_i64(t, a, shift);
@@ -4478,7 +4478,7 @@ const GVecGen2i sli_op[4] =3D {
       .fniv =3D gen_shl_ins_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_sli,
-      .vece =3D MO_8 },
+      .vece =3D MO_UB },
     { .fni8 =3D gen_shl16_ins_i64,
       .fniv =3D gen_shl_ins_vec,
       .load_dest =3D true,
@@ -4574,7 +4574,7 @@ const GVecGen3 mla_op[4] =3D {
       .fniv =3D gen_mla_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_mla,
-      .vece =3D MO_8 },
+      .vece =3D MO_UB },
     { .fni4 =3D gen_mla16_i32,
       .fniv =3D gen_mla_vec,
       .load_dest =3D true,
@@ -4598,7 +4598,7 @@ const GVecGen3 mls_op[4] =3D {
       .fniv =3D gen_mls_vec,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_mls,
-      .vece =3D MO_8 },
+      .vece =3D MO_UB },
     { .fni4 =3D gen_mls16_i32,
       .fniv =3D gen_mls_vec,
       .load_dest =3D true,
@@ -4645,7 +4645,7 @@ const GVecGen3 cmtst_op[4] =3D {
     { .fni4 =3D gen_helper_neon_tst_u8,
       .fniv =3D gen_cmtst_vec,
       .opt_opc =3D vecop_list_cmtst,
-      .vece =3D MO_8 },
+      .vece =3D MO_UB },
     { .fni4 =3D gen_helper_neon_tst_u16,
       .fniv =3D gen_cmtst_vec,
       .opt_opc =3D vecop_list_cmtst,
@@ -4681,7 +4681,7 @@ const GVecGen4 uqadd_op[4] =3D {
       .fno =3D gen_helper_gvec_uqadd_b,
       .write_aofs =3D true,
       .opt_opc =3D vecop_list_uqadd,
-      .vece =3D MO_8 },
+      .vece =3D MO_UB },
     { .fniv =3D gen_uqadd_vec,
       .fno =3D gen_helper_gvec_uqadd_h,
       .write_aofs =3D true,
@@ -4719,7 +4719,7 @@ const GVecGen4 sqadd_op[4] =3D {
       .fno =3D gen_helper_gvec_sqadd_b,
       .opt_opc =3D vecop_list_sqadd,
       .write_aofs =3D true,
-      .vece =3D MO_8 },
+      .vece =3D MO_UB },
     { .fniv =3D gen_sqadd_vec,
       .fno =3D gen_helper_gvec_sqadd_h,
       .opt_opc =3D vecop_list_sqadd,
@@ -4757,7 +4757,7 @@ const GVecGen4 uqsub_op[4] =3D {
       .fno =3D gen_helper_gvec_uqsub_b,
       .opt_opc =3D vecop_list_uqsub,
       .write_aofs =3D true,
-      .vece =3D MO_8 },
+      .vece =3D MO_UB },
     { .fniv =3D gen_uqsub_vec,
       .fno =3D gen_helper_gvec_uqsub_h,
       .opt_opc =3D vecop_list_uqsub,
@@ -4795,7 +4795,7 @@ const GVecGen4 sqsub_op[4] =3D {
       .fno =3D gen_helper_gvec_sqsub_b,
       .opt_opc =3D vecop_list_sqsub,
       .write_aofs =3D true,
-      .vece =3D MO_8 },
+      .vece =3D MO_UB },
     { .fniv =3D gen_sqsub_vec,
       .fno =3D gen_helper_gvec_sqsub_h,
       .opt_opc =3D vecop_list_sqsub,
@@ -4972,15 +4972,15 @@ static int disas_neon_data_insn(DisasContext *s, ui=
nt32_t insn)
                                  vec_size, vec_size);
                 break;
             case 5: /* VBSL */
-                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rd_ofs, rn_ofs, rm_ofs,
+                tcg_gen_gvec_bitsel(MO_UB, rd_ofs, rd_ofs, rn_ofs, rm_ofs,
                                     vec_size, vec_size);
                 break;
             case 6: /* VBIT */
-                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rm_ofs, rn_ofs, rd_ofs,
+                tcg_gen_gvec_bitsel(MO_UB, rd_ofs, rm_ofs, rn_ofs, rd_ofs,
                                     vec_size, vec_size);
                 break;
             case 7: /* VBIF */
-                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rm_ofs, rd_ofs, rn_ofs,
+                tcg_gen_gvec_bitsel(MO_UB, rd_ofs, rm_ofs, rd_ofs, rn_ofs,
                                     vec_size, vec_size);
                 break;
             }
@@ -6873,7 +6873,7 @@ static int disas_neon_data_insn(DisasContext *s, uint=
32_t insn)
                     return 1;
                 }
                 if (insn & (1 << 16)) {
-                    size =3D MO_8;
+                    size =3D MO_UB;
                     element =3D (insn >> 17) & 7;
                 } else if (insn & (1 << 17)) {
                     size =3D MO_16;
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 03150a8..0e45300 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -349,20 +349,20 @@ static inline TCGMemOp mo_64_32(TCGMemOp ot)
    byte vs word opcodes.  */
 static inline TCGMemOp mo_b_d(int b, TCGMemOp ot)
 {
-    return b & 1 ? ot : MO_8;
+    return b & 1 ? ot : MO_UB;
 }

 /* Select size 8 if lsb of B is clear, else OT capped at 32.
    Used for decoding operand size of port opcodes.  */
 static inline TCGMemOp mo_b_d32(int b, TCGMemOp ot)
 {
-    return b & 1 ? (ot =3D=3D MO_16 ? MO_16 : MO_32) : MO_8;
+    return b & 1 ? (ot =3D=3D MO_16 ? MO_16 : MO_32) : MO_UB;
 }

 static void gen_op_mov_reg_v(DisasContext *s, TCGMemOp ot, int reg, TCGv t=
0)
 {
     switch(ot) {
-    case MO_8:
+    case MO_UB:
         if (!byte_reg_is_xH(s, reg)) {
             tcg_gen_deposit_tl(cpu_regs[reg], cpu_regs[reg], t0, 0, 8);
         } else {
@@ -390,7 +390,7 @@ static void gen_op_mov_reg_v(DisasContext *s, TCGMemOp =
ot, int reg, TCGv t0)
 static inline
 void gen_op_mov_v_reg(DisasContext *s, TCGMemOp ot, TCGv t0, int reg)
 {
-    if (ot =3D=3D MO_8 && byte_reg_is_xH(s, reg)) {
+    if (ot =3D=3D MO_UB && byte_reg_is_xH(s, reg)) {
         tcg_gen_extract_tl(t0, cpu_regs[reg - 4], 8, 8);
     } else {
         tcg_gen_mov_tl(t0, cpu_regs[reg]);
@@ -523,7 +523,7 @@ static inline void gen_op_movl_T0_Dshift(DisasContext *=
s, TCGMemOp ot)
 static TCGv gen_ext_tl(TCGv dst, TCGv src, TCGMemOp size, bool sign)
 {
     switch (size) {
-    case MO_8:
+    case MO_UB:
         if (sign) {
             tcg_gen_ext8s_tl(dst, src);
         } else {
@@ -580,7 +580,7 @@ void gen_op_jz_ecx(DisasContext *s, TCGMemOp size, TCGL=
abel *label1)
 static void gen_helper_in_func(TCGMemOp ot, TCGv v, TCGv_i32 n)
 {
     switch (ot) {
-    case MO_8:
+    case MO_UB:
         gen_helper_inb(v, cpu_env, n);
         break;
     case MO_16:
@@ -597,7 +597,7 @@ static void gen_helper_in_func(TCGMemOp ot, TCGv v, TCG=
v_i32 n)
 static void gen_helper_out_func(TCGMemOp ot, TCGv_i32 v, TCGv_i32 n)
 {
     switch (ot) {
-    case MO_8:
+    case MO_UB:
         gen_helper_outb(cpu_env, v, n);
         break;
     case MO_16:
@@ -619,7 +619,7 @@ static void gen_check_io(DisasContext *s, TCGMemOp ot, =
target_ulong cur_eip,
     if (s->pe && (s->cpl > s->iopl || s->vm86)) {
         tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
         switch (ot) {
-        case MO_8:
+        case MO_UB:
             gen_helper_check_iob(cpu_env, s->tmp2_i32);
             break;
         case MO_16:
@@ -1557,7 +1557,7 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp o=
t, int op1, int is_right)
     tcg_gen_andi_tl(s->T1, s->T1, mask);

     switch (ot) {
-    case MO_8:
+    case MO_UB:
         /* Replicate the 8-bit input so that a 32-bit rotate works.  */
         tcg_gen_ext8u_tl(s->T0, s->T0);
         tcg_gen_muli_tl(s->T0, s->T0, 0x01010101);
@@ -1661,7 +1661,7 @@ static void gen_rot_rm_im(DisasContext *s, TCGMemOp o=
t, int op1, int op2,
                 tcg_gen_rotli_tl(s->T0, s->T0, op2);
             }
             break;
-        case MO_8:
+        case MO_UB:
             mask =3D 7;
             goto do_shifts;
         case MO_16:
@@ -1719,7 +1719,7 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMemOp =
ot, int op1,

     if (is_right) {
         switch (ot) {
-        case MO_8:
+        case MO_UB:
             gen_helper_rcrb(s->T0, cpu_env, s->T0, s->T1);
             break;
         case MO_16:
@@ -1738,7 +1738,7 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMemOp =
ot, int op1,
         }
     } else {
         switch (ot) {
-        case MO_8:
+        case MO_UB:
             gen_helper_rclb(s->T0, cpu_env, s->T0, s->T1);
             break;
         case MO_16:
@@ -2184,7 +2184,7 @@ static inline uint32_t insn_get(CPUX86State *env, Dis=
asContext *s, TCGMemOp ot)
     uint32_t ret;

     switch (ot) {
-    case MO_8:
+    case MO_UB:
         ret =3D x86_ldub_code(env, s);
         break;
     case MO_16:
@@ -3784,7 +3784,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                     goto illegal_op;
                 }
                 if ((b & 0xff) =3D=3D 0xf0) {
-                    ot =3D MO_8;
+                    ot =3D MO_UB;
                 } else if (s->dflag !=3D MO_64) {
                     ot =3D (s->prefix & PREFIX_DATA ? MO_16 : MO_32);
                 } else {
@@ -4760,7 +4760,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 val =3D insn_get(env, s, ot);
                 break;
             case 0x83:
-                val =3D (int8_t)insn_get(env, s, MO_8);
+                val =3D (int8_t)insn_get(env, s, MO_UB);
                 break;
             }
             tcg_gen_movi_tl(s->T1, val);
@@ -4866,8 +4866,8 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             break;
         case 4: /* mul */
             switch(ot) {
-            case MO_8:
-                gen_op_mov_v_reg(s, MO_8, s->T1, R_EAX);
+            case MO_UB:
+                gen_op_mov_v_reg(s, MO_UB, s->T1, R_EAX);
                 tcg_gen_ext8u_tl(s->T0, s->T0);
                 tcg_gen_ext8u_tl(s->T1, s->T1);
                 /* XXX: use 32 bit mul which could be faster */
@@ -4915,8 +4915,8 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             break;
         case 5: /* imul */
             switch(ot) {
-            case MO_8:
-                gen_op_mov_v_reg(s, MO_8, s->T1, R_EAX);
+            case MO_UB:
+                gen_op_mov_v_reg(s, MO_UB, s->T1, R_EAX);
                 tcg_gen_ext8s_tl(s->T0, s->T0);
                 tcg_gen_ext8s_tl(s->T1, s->T1);
                 /* XXX: use 32 bit mul which could be faster */
@@ -4969,7 +4969,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             break;
         case 6: /* div */
             switch(ot) {
-            case MO_8:
+            case MO_UB:
                 gen_helper_divb_AL(cpu_env, s->T0);
                 break;
             case MO_16:
@@ -4988,7 +4988,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             break;
         case 7: /* idiv */
             switch(ot) {
-            case MO_8:
+            case MO_UB:
                 gen_helper_idivb_AL(cpu_env, s->T0);
                 break;
             case MO_16:
@@ -5157,7 +5157,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             gen_op_mov_reg_v(s, MO_32, R_EAX, s->T0);
             break;
         case MO_16:
-            gen_op_mov_v_reg(s, MO_8, s->T0, R_EAX);
+            gen_op_mov_v_reg(s, MO_UB, s->T0, R_EAX);
             tcg_gen_ext8s_tl(s->T0, s->T0);
             gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
             break;
@@ -5205,7 +5205,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             val =3D insn_get(env, s, ot);
             tcg_gen_movi_tl(s->T1, val);
         } else if (b =3D=3D 0x6b) {
-            val =3D (int8_t)insn_get(env, s, MO_8);
+            val =3D (int8_t)insn_get(env, s, MO_UB);
             tcg_gen_movi_tl(s->T1, val);
         } else {
             gen_op_mov_v_reg(s, ot, s->T1, reg);
@@ -5419,7 +5419,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         if (b =3D=3D 0x68)
             val =3D insn_get(env, s, ot);
         else
-            val =3D (int8_t)insn_get(env, s, MO_8);
+            val =3D (int8_t)insn_get(env, s, MO_UB);
         tcg_gen_movi_tl(s->T0, val);
         gen_push_v(s, s->T0);
         break;
@@ -5573,7 +5573,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             /* d_ot is the size of destination */
             d_ot =3D dflag;
             /* ot is the size of source */
-            ot =3D (b & 1) + MO_8;
+            ot =3D (b & 1) + MO_UB;
             /* s_ot is the sign+size of source */
             s_ot =3D b & 8 ? MO_SIGN | ot : ot;

@@ -5661,13 +5661,13 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
         tcg_gen_add_tl(s->A0, s->A0, s->T0);
         gen_extu(s->aflag, s->A0);
         gen_add_A0_ds_seg(s);
-        gen_op_ld_v(s, MO_8, s->T0, s->A0);
-        gen_op_mov_reg_v(s, MO_8, R_EAX, s->T0);
+        gen_op_ld_v(s, MO_UB, s->T0, s->A0);
+        gen_op_mov_reg_v(s, MO_UB, R_EAX, s->T0);
         break;
     case 0xb0 ... 0xb7: /* mov R, Ib */
-        val =3D insn_get(env, s, MO_8);
+        val =3D insn_get(env, s, MO_UB);
         tcg_gen_movi_tl(s->T0, val);
-        gen_op_mov_reg_v(s, MO_8, (b & 7) | REX_B(s), s->T0);
+        gen_op_mov_reg_v(s, MO_UB, (b & 7) | REX_B(s), s->T0);
         break;
     case 0xb8 ... 0xbf: /* mov R, Iv */
 #ifdef TARGET_X86_64
@@ -6637,7 +6637,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         }
         goto do_ljmp;
     case 0xeb: /* jmp Jb */
-        tval =3D (int8_t)insn_get(env, s, MO_8);
+        tval =3D (int8_t)insn_get(env, s, MO_UB);
         tval +=3D s->pc - s->cs_base;
         if (dflag =3D=3D MO_16) {
             tval &=3D 0xffff;
@@ -6645,7 +6645,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         gen_jmp(s, tval);
         break;
     case 0x70 ... 0x7f: /* jcc Jb */
-        tval =3D (int8_t)insn_get(env, s, MO_8);
+        tval =3D (int8_t)insn_get(env, s, MO_UB);
         goto do_jcc;
     case 0x180 ... 0x18f: /* jcc Jv */
         if (dflag !=3D MO_16) {
@@ -6666,7 +6666,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
     case 0x190 ... 0x19f: /* setcc Gv */
         modrm =3D x86_ldub_code(env, s);
         gen_setcc1(s, b, s->T0);
-        gen_ldst_modrm(env, s, modrm, MO_8, OR_TMP0, 1);
+        gen_ldst_modrm(env, s, modrm, MO_UB, OR_TMP0, 1);
         break;
     case 0x140 ... 0x14f: /* cmov Gv, Ev */
         if (!(s->cpuid_features & CPUID_CMOV)) {
@@ -6751,7 +6751,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
     case 0x9e: /* sahf */
         if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM))
             goto illegal_op;
-        gen_op_mov_v_reg(s, MO_8, s->T0, R_AH);
+        gen_op_mov_v_reg(s, MO_UB, s->T0, R_AH);
         gen_compute_eflags(s);
         tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
         tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
@@ -6763,7 +6763,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         gen_compute_eflags(s);
         /* Note: gen_compute_eflags() only gives the condition codes */
         tcg_gen_ori_tl(s->T0, cpu_cc_src, 0x02);
-        gen_op_mov_reg_v(s, MO_8, R_AH, s->T0);
+        gen_op_mov_reg_v(s, MO_UB, R_AH, s->T0);
         break;
     case 0xf5: /* cmc */
         gen_compute_eflags(s);
@@ -7137,7 +7137,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             goto illegal_op;
         gen_compute_eflags_c(s, s->T0);
         tcg_gen_neg_tl(s->T0, s->T0);
-        gen_op_mov_reg_v(s, MO_8, R_EAX, s->T0);
+        gen_op_mov_reg_v(s, MO_UB, R_EAX, s->T0);
         break;
     case 0xe0: /* loopnz */
     case 0xe1: /* loopz */
@@ -7146,7 +7146,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         {
             TCGLabel *l1, *l2, *l3;

-            tval =3D (int8_t)insn_get(env, s, MO_8);
+            tval =3D (int8_t)insn_get(env, s, MO_UB);
             next_eip =3D s->pc - s->cs_base;
             tval +=3D next_eip;
             if (dflag =3D=3D MO_16) {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3575eff..20a9777 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -3684,7 +3684,7 @@ static void gen_st(DisasContext *ctx, uint32_t opc, i=
nt rt,
         mem_idx =3D MIPS_HFLAG_UM;
         /* fall through */
     case OPC_SB:
-        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_8);
+        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_UB);
         break;
     case OPC_SWLE:
         mem_idx =3D MIPS_HFLAG_UM;
@@ -20193,7 +20193,7 @@ static void gen_p_lsx(DisasContext *ctx, int rd, in=
t rs, int rt)
         check_nms(ctx);
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
-                           MO_8);
+                           MO_UB);
         break;
     case NM_SHX:
     /*case NM_SHXS:*/
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx=
-impl.inc.c
index 663275b..4130dd1 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -403,7 +403,7 @@ static void glue(gen_, name)(DisasContext *ctx)        =
                 \
     tcg_temp_free_ptr(rb);                                              \
 }

-GEN_VXFORM_V(vaddubm, MO_8, tcg_gen_gvec_add, 0, 0);
+GEN_VXFORM_V(vaddubm, MO_UB, tcg_gen_gvec_add, 0, 0);
 GEN_VXFORM_DUAL_EXT(vaddubm, PPC_ALTIVEC, PPC_NONE, 0,       \
                     vmul10cuq, PPC_NONE, PPC2_ISA300, 0x0000F800)
 GEN_VXFORM_V(vadduhm, MO_16, tcg_gen_gvec_add, 0, 1);
@@ -411,23 +411,23 @@ GEN_VXFORM_DUAL(vadduhm, PPC_ALTIVEC, PPC_NONE,  \
                 vmul10ecuq, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_V(vadduwm, MO_32, tcg_gen_gvec_add, 0, 2);
 GEN_VXFORM_V(vaddudm, MO_64, tcg_gen_gvec_add, 0, 3);
-GEN_VXFORM_V(vsububm, MO_8, tcg_gen_gvec_sub, 0, 16);
+GEN_VXFORM_V(vsububm, MO_UB, tcg_gen_gvec_sub, 0, 16);
 GEN_VXFORM_V(vsubuhm, MO_16, tcg_gen_gvec_sub, 0, 17);
 GEN_VXFORM_V(vsubuwm, MO_32, tcg_gen_gvec_sub, 0, 18);
 GEN_VXFORM_V(vsubudm, MO_64, tcg_gen_gvec_sub, 0, 19);
-GEN_VXFORM_V(vmaxub, MO_8, tcg_gen_gvec_umax, 1, 0);
+GEN_VXFORM_V(vmaxub, MO_UB, tcg_gen_gvec_umax, 1, 0);
 GEN_VXFORM_V(vmaxuh, MO_16, tcg_gen_gvec_umax, 1, 1);
 GEN_VXFORM_V(vmaxuw, MO_32, tcg_gen_gvec_umax, 1, 2);
 GEN_VXFORM_V(vmaxud, MO_64, tcg_gen_gvec_umax, 1, 3);
-GEN_VXFORM_V(vmaxsb, MO_8, tcg_gen_gvec_smax, 1, 4);
+GEN_VXFORM_V(vmaxsb, MO_UB, tcg_gen_gvec_smax, 1, 4);
 GEN_VXFORM_V(vmaxsh, MO_16, tcg_gen_gvec_smax, 1, 5);
 GEN_VXFORM_V(vmaxsw, MO_32, tcg_gen_gvec_smax, 1, 6);
 GEN_VXFORM_V(vmaxsd, MO_64, tcg_gen_gvec_smax, 1, 7);
-GEN_VXFORM_V(vminub, MO_8, tcg_gen_gvec_umin, 1, 8);
+GEN_VXFORM_V(vminub, MO_UB, tcg_gen_gvec_umin, 1, 8);
 GEN_VXFORM_V(vminuh, MO_16, tcg_gen_gvec_umin, 1, 9);
 GEN_VXFORM_V(vminuw, MO_32, tcg_gen_gvec_umin, 1, 10);
 GEN_VXFORM_V(vminud, MO_64, tcg_gen_gvec_umin, 1, 11);
-GEN_VXFORM_V(vminsb, MO_8, tcg_gen_gvec_smin, 1, 12);
+GEN_VXFORM_V(vminsb, MO_UB, tcg_gen_gvec_smin, 1, 12);
 GEN_VXFORM_V(vminsh, MO_16, tcg_gen_gvec_smin, 1, 13);
 GEN_VXFORM_V(vminsw, MO_32, tcg_gen_gvec_smin, 1, 14);
 GEN_VXFORM_V(vminsd, MO_64, tcg_gen_gvec_smin, 1, 15);
@@ -530,18 +530,18 @@ GEN_VXFORM(vmuleuw, 4, 10);
 GEN_VXFORM(vmulesb, 4, 12);
 GEN_VXFORM(vmulesh, 4, 13);
 GEN_VXFORM(vmulesw, 4, 14);
-GEN_VXFORM_V(vslb, MO_8, tcg_gen_gvec_shlv, 2, 4);
+GEN_VXFORM_V(vslb, MO_UB, tcg_gen_gvec_shlv, 2, 4);
 GEN_VXFORM_V(vslh, MO_16, tcg_gen_gvec_shlv, 2, 5);
 GEN_VXFORM_V(vslw, MO_32, tcg_gen_gvec_shlv, 2, 6);
 GEN_VXFORM(vrlwnm, 2, 6);
 GEN_VXFORM_DUAL(vslw, PPC_ALTIVEC, PPC_NONE, \
                 vrlwnm, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_V(vsld, MO_64, tcg_gen_gvec_shlv, 2, 23);
-GEN_VXFORM_V(vsrb, MO_8, tcg_gen_gvec_shrv, 2, 8);
+GEN_VXFORM_V(vsrb, MO_UB, tcg_gen_gvec_shrv, 2, 8);
 GEN_VXFORM_V(vsrh, MO_16, tcg_gen_gvec_shrv, 2, 9);
 GEN_VXFORM_V(vsrw, MO_32, tcg_gen_gvec_shrv, 2, 10);
 GEN_VXFORM_V(vsrd, MO_64, tcg_gen_gvec_shrv, 2, 27);
-GEN_VXFORM_V(vsrab, MO_8, tcg_gen_gvec_sarv, 2, 12);
+GEN_VXFORM_V(vsrab, MO_UB, tcg_gen_gvec_sarv, 2, 12);
 GEN_VXFORM_V(vsrah, MO_16, tcg_gen_gvec_sarv, 2, 13);
 GEN_VXFORM_V(vsraw, MO_32, tcg_gen_gvec_sarv, 2, 14);
 GEN_VXFORM_V(vsrad, MO_64, tcg_gen_gvec_sarv, 2, 15);
@@ -589,20 +589,20 @@ static void glue(gen_, NAME)(DisasContext *ctx)      =
                   \
                    16, 16, &g);                                         \
 }

-GEN_VXFORM_SAT(vaddubs, MO_8, add, usadd, 0, 8);
+GEN_VXFORM_SAT(vaddubs, MO_UB, add, usadd, 0, 8);
 GEN_VXFORM_DUAL_EXT(vaddubs, PPC_ALTIVEC, PPC_NONE, 0,       \
                     vmul10uq, PPC_NONE, PPC2_ISA300, 0x0000F800)
 GEN_VXFORM_SAT(vadduhs, MO_16, add, usadd, 0, 9);
 GEN_VXFORM_DUAL(vadduhs, PPC_ALTIVEC, PPC_NONE, \
                 vmul10euq, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_SAT(vadduws, MO_32, add, usadd, 0, 10);
-GEN_VXFORM_SAT(vaddsbs, MO_8, add, ssadd, 0, 12);
+GEN_VXFORM_SAT(vaddsbs, MO_UB, add, ssadd, 0, 12);
 GEN_VXFORM_SAT(vaddshs, MO_16, add, ssadd, 0, 13);
 GEN_VXFORM_SAT(vaddsws, MO_32, add, ssadd, 0, 14);
-GEN_VXFORM_SAT(vsububs, MO_8, sub, ussub, 0, 24);
+GEN_VXFORM_SAT(vsububs, MO_UB, sub, ussub, 0, 24);
 GEN_VXFORM_SAT(vsubuhs, MO_16, sub, ussub, 0, 25);
 GEN_VXFORM_SAT(vsubuws, MO_32, sub, ussub, 0, 26);
-GEN_VXFORM_SAT(vsubsbs, MO_8, sub, sssub, 0, 28);
+GEN_VXFORM_SAT(vsubsbs, MO_UB, sub, sssub, 0, 28);
 GEN_VXFORM_SAT(vsubshs, MO_16, sub, sssub, 0, 29);
 GEN_VXFORM_SAT(vsubsws, MO_32, sub, sssub, 0, 30);
 GEN_VXFORM(vadduqm, 0, 4);
@@ -912,7 +912,7 @@ static void glue(gen_, name)(DisasContext *ctx)        =
                 \
         tcg_temp_free_ptr(rd);                                          \
     }

-GEN_VXFORM_VSPLT(vspltb, MO_8, 6, 8);
+GEN_VXFORM_VSPLT(vspltb, MO_UB, 6, 8);
 GEN_VXFORM_VSPLT(vsplth, MO_16, 6, 9);
 GEN_VXFORM_VSPLT(vspltw, MO_32, 6, 10);
 GEN_VXFORM_UIMM_SPLAT(vextractub, 6, 8, 15);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index ac0d8b6..415747f 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -154,7 +154,7 @@ static inline int vec_full_reg_offset(uint8_t reg)

 static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp es)
 {
-    /* Convert element size (es) - e.g. MO_8 - to bytes */
+    /* Convert element size (es) - e.g. MO_UB - to bytes */
     const uint8_t bytes =3D 1 << es;
     int offs =3D enr * bytes;

diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.in=
c.c
index 41d5cf8..bb424c8 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -30,7 +30,7 @@
  * Sizes:
  *  On s390x, the operand size (oprsz) and the maximum size (maxsz) are
  *  always 16 (128 bit). What gvec code calls "vece", s390x calls "es",
- *  a.k.a. "element size". These values nicely map to MO_8 ... MO_64. Only
+ *  a.k.a. "element size". These values nicely map to MO_UB ... MO_64. Onl=
y
  *  128 bit element size has to be treated in a special way (MO_64 + 1).
  *  We will use ES_* instead of MO_* for this reason in this file.
  *
@@ -46,7 +46,7 @@
 #define NUM_VEC_ELEMENTS(es) (16 / NUM_VEC_ELEMENT_BYTES(es))
 #define NUM_VEC_ELEMENT_BITS(es) (NUM_VEC_ELEMENT_BYTES(es) * BITS_PER_BYT=
E)

-#define ES_8    MO_8
+#define ES_8    MO_UB
 #define ES_16   MO_16
 #define ES_32   MO_32
 #define ES_64   MO_64
diff --git a/target/s390x/vec.h b/target/s390x/vec.h
index a6e3618..b813054 100644
--- a/target/s390x/vec.h
+++ b/target/s390x/vec.h
@@ -76,7 +76,7 @@ static inline uint64_t s390_vec_read_element(const S390Ve=
ctor *v, uint8_t enr,
                                              uint8_t es)
 {
     switch (es) {
-    case MO_8:
+    case MO_UB:
         return s390_vec_read_element8(v, enr);
     case MO_16:
         return s390_vec_read_element16(v, enr);
@@ -121,7 +121,7 @@ static inline void s390_vec_write_element(S390Vector *v=
, uint8_t enr,
                                           uint8_t es, uint64_t data)
 {
     switch (es) {
-    case MO_8:
+    case MO_UB:
         s390_vec_write_element8(v, enr, data);
         break;
     case MO_16:
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 0713448..e4e0845 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -429,20 +429,20 @@ typedef enum {

     /* Load/store register.  Described here as 3.3.12, but the helper
        that emits them can transform to 3.3.10 or 3.3.13.  */
-    I3312_STRB      =3D 0x38000000 | LDST_ST << 22 | MO_8 << 30,
+    I3312_STRB      =3D 0x38000000 | LDST_ST << 22 | MO_UB << 30,
     I3312_STRH      =3D 0x38000000 | LDST_ST << 22 | MO_16 << 30,
     I3312_STRW      =3D 0x38000000 | LDST_ST << 22 | MO_32 << 30,
     I3312_STRX      =3D 0x38000000 | LDST_ST << 22 | MO_64 << 30,

-    I3312_LDRB      =3D 0x38000000 | LDST_LD << 22 | MO_8 << 30,
+    I3312_LDRB      =3D 0x38000000 | LDST_LD << 22 | MO_UB << 30,
     I3312_LDRH      =3D 0x38000000 | LDST_LD << 22 | MO_16 << 30,
     I3312_LDRW      =3D 0x38000000 | LDST_LD << 22 | MO_32 << 30,
     I3312_LDRX      =3D 0x38000000 | LDST_LD << 22 | MO_64 << 30,

-    I3312_LDRSBW    =3D 0x38000000 | LDST_LD_S_W << 22 | MO_8 << 30,
+    I3312_LDRSBW    =3D 0x38000000 | LDST_LD_S_W << 22 | MO_UB << 30,
     I3312_LDRSHW    =3D 0x38000000 | LDST_LD_S_W << 22 | MO_16 << 30,

-    I3312_LDRSBX    =3D 0x38000000 | LDST_LD_S_X << 22 | MO_8 << 30,
+    I3312_LDRSBX    =3D 0x38000000 | LDST_LD_S_X << 22 | MO_UB << 30,
     I3312_LDRSHX    =3D 0x38000000 | LDST_LD_S_X << 22 | MO_16 << 30,
     I3312_LDRSWX    =3D 0x38000000 | LDST_LD_S_X << 22 | MO_32 << 30,

@@ -862,7 +862,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType typ=
e,
     int cmode, imm8, i;

     /* Test all bytes equal first.  */
-    if (v64 =3D=3D dup_const(MO_8, v64)) {
+    if (v64 =3D=3D dup_const(MO_UB, v64)) {
         imm8 =3D (uint8_t)v64;
         tcg_out_insn(s, 3606, MOVI, q, rd, 0, 0xe, imm8);
         return;
@@ -1772,7 +1772,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
MemOp memop,
     const TCGMemOp bswap =3D memop & MO_BSWAP;

     switch (memop & MO_SIZE) {
-    case MO_8:
+    case MO_UB:
         tcg_out_ldst_r(s, I3312_STRB, data_r, addr_r, otype, off_r);
         break;
     case MO_16:
@@ -2186,7 +2186,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,

     case INDEX_op_ext8s_i64:
     case INDEX_op_ext8s_i32:
-        tcg_out_sxt(s, ext, MO_8, a0, a1);
+        tcg_out_sxt(s, ext, MO_UB, a0, a1);
         break;
     case INDEX_op_ext16s_i64:
     case INDEX_op_ext16s_i32:
@@ -2198,7 +2198,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_ext8u_i64:
     case INDEX_op_ext8u_i32:
-        tcg_out_uxt(s, MO_8, a0, a1);
+        tcg_out_uxt(s, MO_UB, a0, a1);
         break;
     case INDEX_op_ext16u_i64:
     case INDEX_op_ext16u_i32:
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index ece88dc..542ffa8 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1429,7 +1429,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
     datalo =3D lb->datalo_reg;
     datahi =3D lb->datahi_reg;
     switch (opc & MO_SIZE) {
-    case MO_8:
+    case MO_UB:
         argreg =3D tcg_out_arg_reg8(s, argreg, datalo);
         break;
     case MO_16:
@@ -1621,7 +1621,7 @@ static inline void tcg_out_qemu_st_index(TCGContext *=
s, int cond, TCGMemOp opc,
     TCGMemOp bswap =3D opc & MO_BSWAP;

     switch (opc & MO_SIZE) {
-    case MO_8:
+    case MO_UB:
         tcg_out_st8_r(s, cond, datalo, addrlo, addend);
         break;
     case MO_16:
@@ -1666,7 +1666,7 @@ static inline void tcg_out_qemu_st_direct(TCGContext =
*s, TCGMemOp opc,
     TCGMemOp bswap =3D opc & MO_BSWAP;

     switch (opc & MO_SIZE) {
-    case MO_8:
+    case MO_UB:
         tcg_out_st8_12(s, COND_AL, datalo, addrlo, 0);
         break;
     case MO_16:
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 6ddeebf..0d68ba4 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -888,7 +888,7 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type=
, unsigned vece,
         tcg_out_vex_modrm(s, avx2_dup_insn[vece] + vex_l, r, 0, a);
     } else {
         switch (vece) {
-        case MO_8:
+        case MO_UB:
             /* ??? With zero in a register, use PSHUFB.  */
             tcg_out_vex_modrm(s, OPC_PUNPCKLBW, r, a, a);
             a =3D r;
@@ -932,7 +932,7 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType typ=
e, unsigned vece,
             tcg_out8(s, 0); /* imm8 */
             tcg_out_dup_vec(s, type, vece, r, r);
             break;
-        case MO_8:
+        case MO_UB:
             tcg_out_vex_modrm_offset(s, OPC_VPINSRB, r, r, base, offset);
             tcg_out8(s, 0); /* imm8 */
             tcg_out_dup_vec(s, type, vece, r, r);
@@ -2154,7 +2154,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
Reg datalo, TCGReg datahi,
     }

     switch (memop & MO_SIZE) {
-    case MO_8:
+    case MO_UB:
         /* In 32-bit mode, 8-bit stores can only happen from [abcd]x.
            Use the scratch register if necessary.  */
         if (TCG_TARGET_REG_BITS =3D=3D 32 && datalo >=3D 4) {
@@ -2901,7 +2901,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode o=
pc,
         tcg_debug_assert(vece !=3D MO_64);
         sub =3D 4;
     gen_shift:
-        tcg_debug_assert(vece !=3D MO_8);
+        tcg_debug_assert(vece !=3D MO_UB);
         insn =3D shift_imm_insn[vece];
         if (type =3D=3D TCG_TYPE_V256) {
             insn |=3D P_VEXL;
@@ -3273,12 +3273,12 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type=
, unsigned vece)

     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
-        /* We must expand the operation for MO_8.  */
-        return vece =3D=3D MO_8 ? -1 : 1;
+        /* We must expand the operation for MO_UB.  */
+        return vece =3D=3D MO_UB ? -1 : 1;

     case INDEX_op_sari_vec:
-        /* We must expand the operation for MO_8.  */
-        if (vece =3D=3D MO_8) {
+        /* We must expand the operation for MO_UB.  */
+        if (vece =3D=3D MO_UB) {
             return -1;
         }
         /* We can emulate this for MO_64, but it does not pay off
@@ -3301,8 +3301,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, =
unsigned vece)
         return have_avx2 && vece =3D=3D MO_32;

     case INDEX_op_mul_vec:
-        if (vece =3D=3D MO_8) {
-            /* We can expand the operation for MO_8.  */
+        if (vece =3D=3D MO_UB) {
+            /* We can expand the operation for MO_UB.  */
             return -1;
         }
         if (vece =3D=3D MO_64) {
@@ -3332,7 +3332,7 @@ static void expand_vec_shi(TCGType type, unsigned vec=
e, bool shr,
 {
     TCGv_vec t1, t2;

-    tcg_debug_assert(vece =3D=3D MO_8);
+    tcg_debug_assert(vece =3D=3D MO_UB);

     t1 =3D tcg_temp_new_vec(type);
     t2 =3D tcg_temp_new_vec(type);
@@ -3346,9 +3346,9 @@ static void expand_vec_shi(TCGType type, unsigned vec=
e, bool shr,
        (3) Step 2 leaves high half zero such that PACKUSWB
            (pack with unsigned saturation) does not modify
            the quantity.  */
-    vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
+    vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_UB,
               tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
-    vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
+    vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_UB,
               tcgv_vec_arg(t2), tcgv_vec_arg(v1), tcgv_vec_arg(v1));

     if (shr) {
@@ -3361,7 +3361,7 @@ static void expand_vec_shi(TCGType type, unsigned vec=
e, bool shr,
         tcg_gen_shri_vec(MO_16, t2, t2, 8);
     }

-    vec_gen_3(INDEX_op_x86_packus_vec, type, MO_8,
+    vec_gen_3(INDEX_op_x86_packus_vec, type, MO_UB,
               tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(t2));
     tcg_temp_free_vec(t1);
     tcg_temp_free_vec(t2);
@@ -3373,17 +3373,17 @@ static void expand_vec_sari(TCGType type, unsigned =
vece,
     TCGv_vec t1, t2;

     switch (vece) {
-    case MO_8:
+    case MO_UB:
         /* Unpack to W, shift, and repack, as in expand_vec_shi.  */
         t1 =3D tcg_temp_new_vec(type);
         t2 =3D tcg_temp_new_vec(type);
-        vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
+        vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_UB,
                   tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
-        vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
+        vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_UB,
                   tcgv_vec_arg(t2), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
         tcg_gen_sari_vec(MO_16, t1, t1, imm + 8);
         tcg_gen_sari_vec(MO_16, t2, t2, imm + 8);
-        vec_gen_3(INDEX_op_x86_packss_vec, type, MO_8,
+        vec_gen_3(INDEX_op_x86_packss_vec, type, MO_UB,
                   tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(t2));
         tcg_temp_free_vec(t1);
         tcg_temp_free_vec(t2);
@@ -3425,7 +3425,7 @@ static void expand_vec_mul(TCGType type, unsigned vec=
e,
 {
     TCGv_vec t1, t2, t3, t4;

-    tcg_debug_assert(vece =3D=3D MO_8);
+    tcg_debug_assert(vece =3D=3D MO_UB);

     /*
      * Unpack v1 bytes to words, 0 | x.
@@ -3442,13 +3442,13 @@ static void expand_vec_mul(TCGType type, unsigned v=
ece,
         t1 =3D tcg_temp_new_vec(TCG_TYPE_V128);
         t2 =3D tcg_temp_new_vec(TCG_TYPE_V128);
         tcg_gen_dup16i_vec(t2, 0);
-        vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_8,
+        vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_UB,
                   tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(t2));
-        vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_8,
+        vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_UB,
                   tcgv_vec_arg(t2), tcgv_vec_arg(t2), tcgv_vec_arg(v2));
         tcg_gen_mul_vec(MO_16, t1, t1, t2);
         tcg_gen_shri_vec(MO_16, t1, t1, 8);
-        vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
+        vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_UB,
                   tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(t1));
         tcg_temp_free_vec(t1);
         tcg_temp_free_vec(t2);
@@ -3461,19 +3461,19 @@ static void expand_vec_mul(TCGType type, unsigned v=
ece,
         t3 =3D tcg_temp_new_vec(type);
         t4 =3D tcg_temp_new_vec(type);
         tcg_gen_dup16i_vec(t4, 0);
-        vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
+        vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_UB,
                   tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(t4));
-        vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
+        vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_UB,
                   tcgv_vec_arg(t2), tcgv_vec_arg(t4), tcgv_vec_arg(v2));
-        vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
+        vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_UB,
                   tcgv_vec_arg(t3), tcgv_vec_arg(v1), tcgv_vec_arg(t4));
-        vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
+        vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_UB,
                   tcgv_vec_arg(t4), tcgv_vec_arg(t4), tcgv_vec_arg(v2));
         tcg_gen_mul_vec(MO_16, t1, t1, t2);
         tcg_gen_mul_vec(MO_16, t3, t3, t4);
         tcg_gen_shri_vec(MO_16, t1, t1, 8);
         tcg_gen_shri_vec(MO_16, t3, t3, 8);
-        vec_gen_3(INDEX_op_x86_packus_vec, type, MO_8,
+        vec_gen_3(INDEX_op_x86_packus_vec, type, MO_UB,
                   tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(t3));
         tcg_temp_free_vec(t1);
         tcg_temp_free_vec(t2);
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 41bff32..c6d13ea 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1380,7 +1380,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
         i =3D tcg_out_call_iarg_reg(s, i, l->addrlo_reg);
     }
     switch (s_bits) {
-    case MO_8:
+    case MO_UB:
         i =3D tcg_out_call_iarg_reg8(s, i, l->datalo_reg);
         break;
     case MO_16:
@@ -1566,7 +1566,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
Reg lo, TCGReg hi,
     }

     switch (opc & (MO_SIZE | MO_BSWAP)) {
-    case MO_8:
+    case MO_UB:
         tcg_out_opc_imm(s, OPC_SB, lo, base, 0);
         break;

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 3e76bf5..9c60c0f 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1101,7 +1101,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
     tcg_out_mov(s, TCG_TYPE_PTR, a1, l->addrlo_reg);
     tcg_out_mov(s, TCG_TYPE_PTR, a2, l->datalo_reg);
     switch (s_bits) {
-    case MO_8:
+    case MO_UB:
         tcg_out_ext8u(s, a2, a2);
         break;
     case MO_16:
@@ -1216,7 +1216,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
Reg lo, TCGReg hi,
     g_assert(!bswap);

     switch (opc & (MO_SSIZE)) {
-    case MO_8:
+    case MO_UB:
         tcg_out_opc_store(s, OPC_SB, base, lo, 0);
         break;
     case MO_16:
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 10b1cea..479ee2e 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -882,7 +882,7 @@ static void emit_extend(TCGContext *s, TCGReg r, int op=
)
      * required by the MO_* value op; do nothing for 64 bit.
      */
     switch (op & MO_SIZE) {
-    case MO_8:
+    case MO_UB:
         tcg_out_arithi(s, r, r, 0xff, ARITH_AND);
         break;
     case MO_16:
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 17679b6..9658c36 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -306,7 +306,7 @@ static void expand_clr(uint32_t dofs, uint32_t maxsz);
 uint64_t (dup_const)(unsigned vece, uint64_t c)
 {
     switch (vece) {
-    case MO_8:
+    case MO_UB:
         return 0x0101010101010101ull * (uint8_t)c;
     case MO_16:
         return 0x0001000100010001ull * (uint16_t)c;
@@ -323,7 +323,7 @@ uint64_t (dup_const)(unsigned vece, uint64_t c)
 static void gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in)
 {
     switch (vece) {
-    case MO_8:
+    case MO_UB:
         tcg_gen_ext8u_i32(out, in);
         tcg_gen_muli_i32(out, out, 0x01010101);
         break;
@@ -341,7 +341,7 @@ static void gen_dup_i32(unsigned vece, TCGv_i32 out, TC=
Gv_i32 in)
 static void gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in)
 {
     switch (vece) {
-    case MO_8:
+    case MO_UB:
         tcg_gen_ext8u_i64(out, in);
         tcg_gen_muli_i64(out, out, 0x0101010101010101ull);
         break;
@@ -556,7 +556,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32=
_t oprsz,
             t_32 =3D tcg_temp_new_i32();
             if (in_64) {
                 tcg_gen_extrl_i64_i32(t_32, in_64);
-            } else if (vece =3D=3D MO_8) {
+            } else if (vece =3D=3D MO_UB) {
                 tcg_gen_movi_i32(t_32, in_c & 0xff);
             } else if (vece =3D=3D MO_16) {
                 tcg_gen_movi_i32(t_32, in_c & 0xffff);
@@ -581,7 +581,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32=
_t oprsz,
 /* Likewise, but with zero.  */
 static void expand_clr(uint32_t dofs, uint32_t maxsz)
 {
-    do_dup(MO_8, dofs, maxsz, maxsz, NULL, NULL, 0);
+    do_dup(MO_UB, dofs, maxsz, maxsz, NULL, NULL, 0);
 }

 /* Expand OPSZ bytes worth of two-operand operations using i32 elements.  =
*/
@@ -1456,7 +1456,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dof=
s, uint32_t aofs,
         } else if (vece <=3D MO_32) {
             TCGv_i32 in =3D tcg_temp_new_i32();
             switch (vece) {
-            case MO_8:
+            case MO_UB:
                 tcg_gen_ld8u_i32(in, cpu_env, aofs);
                 break;
             case MO_16:
@@ -1533,7 +1533,7 @@ void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t oprsz=
,
                          uint32_t maxsz, uint8_t x)
 {
     check_size_align(oprsz, maxsz, dofs);
-    do_dup(MO_8, dofs, oprsz, maxsz, NULL, NULL, x);
+    do_dup(MO_UB, dofs, oprsz, maxsz, NULL, NULL, x);
 }

 void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -1572,7 +1572,7 @@ static void gen_addv_mask(TCGv_i64 d, TCGv_i64 a, TCG=
v_i64 b, TCGv_i64 m)

 void tcg_gen_vec_add8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_8, 0x80));
+    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_UB, 0x80));
     gen_addv_mask(d, a, b, m);
     tcg_temp_free_i64(m);
 }
@@ -1608,7 +1608,7 @@ void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, u=
int32_t aofs,
           .fniv =3D tcg_gen_add_vec,
           .fno =3D gen_helper_gvec_add8,
           .opt_opc =3D vecop_list_add,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fni8 =3D tcg_gen_vec_add16_i64,
           .fniv =3D tcg_gen_add_vec,
           .fno =3D gen_helper_gvec_add16,
@@ -1639,7 +1639,7 @@ void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_add_vec,
           .fno =3D gen_helper_gvec_adds8,
           .opt_opc =3D vecop_list_add,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fni8 =3D tcg_gen_vec_add16_i64,
           .fniv =3D tcg_gen_add_vec,
           .fno =3D gen_helper_gvec_adds16,
@@ -1680,7 +1680,7 @@ void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_gvec_subs8,
           .opt_opc =3D vecop_list_sub,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fni8 =3D tcg_gen_vec_sub16_i64,
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_gvec_subs16,
@@ -1725,7 +1725,7 @@ static void gen_subv_mask(TCGv_i64 d, TCGv_i64 a, TCG=
v_i64 b, TCGv_i64 m)

 void tcg_gen_vec_sub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_8, 0x80));
+    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_UB, 0x80));
     gen_subv_mask(d, a, b, m);
     tcg_temp_free_i64(m);
 }
@@ -1759,7 +1759,7 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, u=
int32_t aofs,
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_gvec_sub8,
           .opt_opc =3D vecop_list_sub,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fni8 =3D tcg_gen_vec_sub16_i64,
           .fniv =3D tcg_gen_sub_vec,
           .fno =3D gen_helper_gvec_sub16,
@@ -1791,7 +1791,7 @@ void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, u=
int32_t aofs,
         { .fniv =3D tcg_gen_mul_vec,
           .fno =3D gen_helper_gvec_mul8,
           .opt_opc =3D vecop_list_mul,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fniv =3D tcg_gen_mul_vec,
           .fno =3D gen_helper_gvec_mul16,
           .opt_opc =3D vecop_list_mul,
@@ -1820,7 +1820,7 @@ void tcg_gen_gvec_muls(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_mul_vec,
           .fno =3D gen_helper_gvec_muls8,
           .opt_opc =3D vecop_list_mul,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fniv =3D tcg_gen_mul_vec,
           .fno =3D gen_helper_gvec_muls16,
           .opt_opc =3D vecop_list_mul,
@@ -1858,7 +1858,7 @@ void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
         { .fniv =3D tcg_gen_ssadd_vec,
           .fno =3D gen_helper_gvec_ssadd8,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fniv =3D tcg_gen_ssadd_vec,
           .fno =3D gen_helper_gvec_ssadd16,
           .opt_opc =3D vecop_list,
@@ -1884,7 +1884,7 @@ void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
         { .fniv =3D tcg_gen_sssub_vec,
           .fno =3D gen_helper_gvec_sssub8,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fniv =3D tcg_gen_sssub_vec,
           .fno =3D gen_helper_gvec_sssub16,
           .opt_opc =3D vecop_list,
@@ -1926,7 +1926,7 @@ void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
         { .fniv =3D tcg_gen_usadd_vec,
           .fno =3D gen_helper_gvec_usadd8,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fniv =3D tcg_gen_usadd_vec,
           .fno =3D gen_helper_gvec_usadd16,
           .opt_opc =3D vecop_list,
@@ -1970,7 +1970,7 @@ void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
         { .fniv =3D tcg_gen_ussub_vec,
           .fno =3D gen_helper_gvec_ussub8,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fniv =3D tcg_gen_ussub_vec,
           .fno =3D gen_helper_gvec_ussub16,
           .opt_opc =3D vecop_list,
@@ -1998,7 +1998,7 @@ void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_smin_vec,
           .fno =3D gen_helper_gvec_smin8,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fniv =3D tcg_gen_smin_vec,
           .fno =3D gen_helper_gvec_smin16,
           .opt_opc =3D vecop_list,
@@ -2026,7 +2026,7 @@ void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_umin_vec,
           .fno =3D gen_helper_gvec_umin8,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fniv =3D tcg_gen_umin_vec,
           .fno =3D gen_helper_gvec_umin16,
           .opt_opc =3D vecop_list,
@@ -2054,7 +2054,7 @@ void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_smax_vec,
           .fno =3D gen_helper_gvec_smax8,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fniv =3D tcg_gen_smax_vec,
           .fno =3D gen_helper_gvec_smax16,
           .opt_opc =3D vecop_list,
@@ -2082,7 +2082,7 @@ void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_umax_vec,
           .fno =3D gen_helper_gvec_umax8,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fniv =3D tcg_gen_umax_vec,
           .fno =3D gen_helper_gvec_umax16,
           .opt_opc =3D vecop_list,
@@ -2120,7 +2120,7 @@ static void gen_negv_mask(TCGv_i64 d, TCGv_i64 b, TCG=
v_i64 m)

 void tcg_gen_vec_neg8_i64(TCGv_i64 d, TCGv_i64 b)
 {
-    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_8, 0x80));
+    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_UB, 0x80));
     gen_negv_mask(d, b, m);
     tcg_temp_free_i64(m);
 }
@@ -2155,7 +2155,7 @@ void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, u=
int32_t aofs,
           .fniv =3D tcg_gen_neg_vec,
           .fno =3D gen_helper_gvec_neg8,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fni8 =3D tcg_gen_vec_neg16_i64,
           .fniv =3D tcg_gen_neg_vec,
           .fno =3D gen_helper_gvec_neg16,
@@ -2201,7 +2201,7 @@ static void gen_absv_mask(TCGv_i64 d, TCGv_i64 b, uns=
igned vece)

 static void tcg_gen_vec_abs8_i64(TCGv_i64 d, TCGv_i64 b)
 {
-    gen_absv_mask(d, b, MO_8);
+    gen_absv_mask(d, b, MO_UB);
 }

 static void tcg_gen_vec_abs16_i64(TCGv_i64 d, TCGv_i64 b)
@@ -2218,7 +2218,7 @@ void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, u=
int32_t aofs,
           .fniv =3D tcg_gen_abs_vec,
           .fno =3D gen_helper_gvec_abs8,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fni8 =3D tcg_gen_vec_abs16_i64,
           .fniv =3D tcg_gen_abs_vec,
           .fno =3D gen_helper_gvec_abs16,
@@ -2454,7 +2454,7 @@ void tcg_gen_gvec_ori(unsigned vece, uint32_t dofs, u=
int32_t aofs,

 void tcg_gen_vec_shl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
 {
-    uint64_t mask =3D dup_const(MO_8, 0xff << c);
+    uint64_t mask =3D dup_const(MO_UB, 0xff << c);
     tcg_gen_shli_i64(d, a, c);
     tcg_gen_andi_i64(d, d, mask);
 }
@@ -2475,7 +2475,7 @@ void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_shli_vec,
           .fno =3D gen_helper_gvec_shl8i,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fni8 =3D tcg_gen_vec_shl16i_i64,
           .fniv =3D tcg_gen_shli_vec,
           .fno =3D gen_helper_gvec_shl16i,
@@ -2505,7 +2505,7 @@ void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, =
uint32_t aofs,

 void tcg_gen_vec_shr8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
 {
-    uint64_t mask =3D dup_const(MO_8, 0xff >> c);
+    uint64_t mask =3D dup_const(MO_UB, 0xff >> c);
     tcg_gen_shri_i64(d, a, c);
     tcg_gen_andi_i64(d, d, mask);
 }
@@ -2526,7 +2526,7 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_shri_vec,
           .fno =3D gen_helper_gvec_shr8i,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fni8 =3D tcg_gen_vec_shr16i_i64,
           .fniv =3D tcg_gen_shri_vec,
           .fno =3D gen_helper_gvec_shr16i,
@@ -2556,8 +2556,8 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, =
uint32_t aofs,

 void tcg_gen_vec_sar8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
 {
-    uint64_t s_mask =3D dup_const(MO_8, 0x80 >> c);
-    uint64_t c_mask =3D dup_const(MO_8, 0xff >> c);
+    uint64_t s_mask =3D dup_const(MO_UB, 0x80 >> c);
+    uint64_t c_mask =3D dup_const(MO_UB, 0xff >> c);
     TCGv_i64 s =3D tcg_temp_new_i64();

     tcg_gen_shri_i64(d, a, c);
@@ -2591,7 +2591,7 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_sari_vec,
           .fno =3D gen_helper_gvec_sar8i,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fni8 =3D tcg_gen_vec_sar16i_i64,
           .fniv =3D tcg_gen_sari_vec,
           .fno =3D gen_helper_gvec_sar16i,
@@ -2880,7 +2880,7 @@ void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_shlv_mod_vec,
           .fno =3D gen_helper_gvec_shl8v,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fniv =3D tcg_gen_shlv_mod_vec,
           .fno =3D gen_helper_gvec_shl16v,
           .opt_opc =3D vecop_list,
@@ -2943,7 +2943,7 @@ void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_shrv_mod_vec,
           .fno =3D gen_helper_gvec_shr8v,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fniv =3D tcg_gen_shrv_mod_vec,
           .fno =3D gen_helper_gvec_shr16v,
           .opt_opc =3D vecop_list,
@@ -3006,7 +3006,7 @@ void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         { .fniv =3D tcg_gen_sarv_mod_vec,
           .fno =3D gen_helper_gvec_sar8v,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_8 },
+          .vece =3D MO_UB },
         { .fniv =3D tcg_gen_sarv_mod_vec,
           .fno =3D gen_helper_gvec_sar16v,
           .opt_opc =3D vecop_list,
@@ -3129,7 +3129,7 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, ui=
nt32_t dofs,
     check_overlap_3(dofs, aofs, bofs, maxsz);

     if (cond =3D=3D TCG_COND_NEVER || cond =3D=3D TCG_COND_ALWAYS) {
-        do_dup(MO_8, dofs, oprsz, maxsz,
+        do_dup(MO_UB, dofs, oprsz, maxsz,
                NULL, NULL, -(cond =3D=3D TCG_COND_ALWAYS));
         return;
     }
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 6714991..d7ffc9e 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -275,7 +275,7 @@ void tcg_gen_dup16i_vec(TCGv_vec r, uint32_t a)

 void tcg_gen_dup8i_vec(TCGv_vec r, uint32_t a)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_8, a));
+    do_dupi_vec(r, MO_REG, dup_const(MO_UB, a));
 }

 void tcg_gen_dupi_vec(unsigned vece, TCGv_vec r, uint64_t a)
@@ -752,13 +752,13 @@ void tcg_gen_bitsel_vec(unsigned vece, TCGv_vec r, TC=
Gv_vec a,
     tcg_debug_assert(ct->base_type >=3D type);

     if (TCG_TARGET_HAS_bitsel_vec) {
-        vec_gen_4(INDEX_op_bitsel_vec, type, MO_8,
+        vec_gen_4(INDEX_op_bitsel_vec, type, MO_UB,
                   temp_arg(rt), temp_arg(at), temp_arg(bt), temp_arg(ct));
     } else {
         TCGv_vec t =3D tcg_temp_new_vec(type);
-        tcg_gen_and_vec(MO_8, t, a, b);
-        tcg_gen_andc_vec(MO_8, r, c, a);
-        tcg_gen_or_vec(MO_8, r, r, t);
+        tcg_gen_and_vec(MO_UB, t, a, b);
+        tcg_gen_andc_vec(MO_UB, r, c, a);
+        tcg_gen_or_vec(MO_UB, r, r, t);
         tcg_temp_free_vec(t);
     }
 }
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 587d092..61eda33 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2720,7 +2720,7 @@ static inline TCGMemOp tcg_canonicalize_memop(TCGMemO=
p op, bool is64, bool st)
     (void)get_alignment_bits(op);

     switch (op & MO_SIZE) {
-    case MO_8:
+    case MO_UB:
         op &=3D ~MO_BSWAP;
         break;
     case MO_16:
@@ -3024,7 +3024,7 @@ typedef void (*gen_atomic_op_i64)(TCGv_i64, TCGv_env,=
 TCGv, TCGv_i64);
 #endif

 static void * const table_cmpxchg[16] =3D {
-    [MO_8] =3D gen_helper_atomic_cmpxchgb,
+    [MO_UB] =3D gen_helper_atomic_cmpxchgb,
     [MO_16 | MO_LE] =3D gen_helper_atomic_cmpxchgw_le,
     [MO_16 | MO_BE] =3D gen_helper_atomic_cmpxchgw_be,
     [MO_32 | MO_LE] =3D gen_helper_atomic_cmpxchgl_le,
@@ -3248,7 +3248,7 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr,=
 TCGv_i64 val,

 #define GEN_ATOMIC_HELPER(NAME, OP, NEW)                                \
 static void * const table_##NAME[16] =3D {                                =
\
-    [MO_8] =3D gen_helper_atomic_##NAME##b,                               =
\
+    [MO_UB] =3D gen_helper_atomic_##NAME##b,                              =
 \
     [MO_16 | MO_LE] =3D gen_helper_atomic_##NAME##w_le,                   =
\
     [MO_16 | MO_BE] =3D gen_helper_atomic_##NAME##w_be,                   =
\
     [MO_32 | MO_LE] =3D gen_helper_atomic_##NAME##l_le,                   =
\
diff --git a/tcg/tcg.h b/tcg/tcg.h
index b411e17..5636d6b 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1302,7 +1302,7 @@ uint64_t dup_const(unsigned vece, uint64_t c);

 #define dup_const(VECE, C)                                         \
     (__builtin_constant_p(VECE)                                    \
-     ? (  (VECE) =3D=3D MO_8  ? 0x0101010101010101ull * (uint8_t)(C)   \
+     ?   ((VECE) =3D=3D MO_UB ? 0x0101010101010101ull * (uint8_t)(C)   \
         : (VECE) =3D=3D MO_16 ? 0x0001000100010001ull * (uint16_t)(C)  \
         : (VECE) =3D=3D MO_32 ? 0x0000000100000001ull * (uint32_t)(C)  \
         : dup_const(VECE, C))                                      \
--
1.8.3.1



