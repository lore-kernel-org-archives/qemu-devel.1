Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5747C76195
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E8A21993
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E8A21993
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpaTI-0004bk-M6
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 11:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hpaSq-0003zg-IT
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hpaSf-0003Bl-T0
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:43:00 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.73]:33614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1hpaSd-00039a-78
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:42:48 -0400
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 BWP09926078.bt.com (10.36.82.109) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Mon, 22
 Jul 2019 16:42:35 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18e.domain1.systemhost.net (10.9.212.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Mon, 22 Jul 2019 16:42:43 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Mon, 22 Jul
 2019 16:42:43 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 04/20] tcg: Replace MO_64 with MO_UQ alias
Thread-Index: AQHVQKQaj8jO5oIE+Ea78kyYQQqgwA==
Date: Mon, 22 Jul 2019 15:42:43 +0000
Message-ID: <1563810162081.40323@bt.com>
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
X-Received-From: 213.121.35.73
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v2 04/20] tcg: Replace MO_64 with MO_UQ alias
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

Preparation for splitting MO_64 out from TCGMemOp into new accelerator
independent MemOp.

As MO_64 will be a value of MemOp, existing TCGMemOp comparisons and
coercions will trigger -Wenum-compare and -Wenum-conversion.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 target/arm/sve_helper.c             |   2 +-
 target/arm/translate-a64.c          | 270 ++++++++++++++++++--------------=
----
 target/arm/translate-sve.c          |  18 +--
 target/arm/translate-vfp.inc.c      |   4 +-
 target/arm/translate.c              |  30 ++--
 target/i386/translate.c             | 122 ++++++++--------
 target/mips/translate.c             |   2 +-
 target/ppc/translate.c              |  28 ++--
 target/ppc/translate/fp-impl.inc.c  |   4 +-
 target/ppc/translate/vmx-impl.inc.c |  34 ++---
 target/ppc/translate/vsx-impl.inc.c |  18 +--
 target/s390x/translate.c            |   4 +-
 target/s390x/translate_vx.inc.c     |   6 +-
 target/s390x/vec.h                  |   4 +-
 target/sparc/translate.c            |   4 +-
 tcg/aarch64/tcg-target.inc.c        |  20 +--
 tcg/arm/tcg-target.inc.c            |  12 +-
 tcg/i386/tcg-target.inc.c           |  42 +++---
 tcg/mips/tcg-target.inc.c           |  12 +-
 tcg/ppc/tcg-target.inc.c            |  18 +--
 tcg/riscv/tcg-target.inc.c          |   6 +-
 tcg/s390/tcg-target.inc.c           |  10 +-
 tcg/sparc/tcg-target.inc.c          |   8 +-
 tcg/tcg-op-gvec.c                   | 132 +++++++++---------
 tcg/tcg-op-vec.c                    |  14 +-
 tcg/tcg-op.c                        |  24 ++--
 tcg/tcg.h                           |   9 +-
 27 files changed, 430 insertions(+), 427 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index fa705c4..1cfd746 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -5165,7 +5165,7 @@ static inline void sve_ldff1_zd(CPUARMState *env, voi=
d *vd, void *vg, void *vm,
     target_ulong addr;

     /* Skip to the first true predicate.  */
-    reg_off =3D find_next_active(vg, 0, reg_max, MO_64);
+    reg_off =3D find_next_active(vg, 0, reg_max, MO_UQ);
     if (likely(reg_off < reg_max)) {
         /* Perform one normal read, which will fault or not.  */
         set_helper_retaddr(ra);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 0b92e6d..3f9d103 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -463,7 +463,7 @@ static inline int fp_reg_offset(DisasContext *s, int re=
gno, TCGMemOp size)
 /* Offset of the high half of the 128 bit vector Qn */
 static inline int fp_reg_hi_offset(DisasContext *s, int regno)
 {
-    return vec_reg_offset(s, regno, 1, MO_64);
+    return vec_reg_offset(s, regno, 1, MO_UQ);
 }

 /* Convenience accessors for reading and writing single and double
@@ -476,7 +476,7 @@ static TCGv_i64 read_fp_dreg(DisasContext *s, int reg)
 {
     TCGv_i64 v =3D tcg_temp_new_i64();

-    tcg_gen_ld_i64(v, cpu_env, fp_reg_offset(s, reg, MO_64));
+    tcg_gen_ld_i64(v, cpu_env, fp_reg_offset(s, reg, MO_UQ));
     return v;
 }

@@ -501,7 +501,7 @@ static TCGv_i32 read_fp_hreg(DisasContext *s, int reg)
  */
 static void clear_vec_high(DisasContext *s, bool is_q, int rd)
 {
-    unsigned ofs =3D fp_reg_offset(s, rd, MO_64);
+    unsigned ofs =3D fp_reg_offset(s, rd, MO_UQ);
     unsigned vsz =3D vec_full_reg_size(s);

     if (!is_q) {
@@ -516,7 +516,7 @@ static void clear_vec_high(DisasContext *s, bool is_q, =
int rd)

 void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v)
 {
-    unsigned ofs =3D fp_reg_offset(s, reg, MO_64);
+    unsigned ofs =3D fp_reg_offset(s, reg, MO_UQ);

     tcg_gen_st_i64(v, cpu_env, ofs);
     clear_vec_high(s, false, reg);
@@ -918,7 +918,7 @@ static void do_fp_st(DisasContext *s, int srcidx, TCGv_=
i64 tcg_addr, int size)
 {
     /* This writes the bottom N bits of a 128 bit wide vector to memory */
     TCGv_i64 tmp =3D tcg_temp_new_i64();
-    tcg_gen_ld_i64(tmp, cpu_env, fp_reg_offset(s, srcidx, MO_64));
+    tcg_gen_ld_i64(tmp, cpu_env, fp_reg_offset(s, srcidx, MO_UQ));
     if (size < 4) {
         tcg_gen_qemu_st_i64(tmp, tcg_addr, get_mem_index(s),
                             s->be_data + size);
@@ -928,10 +928,10 @@ static void do_fp_st(DisasContext *s, int srcidx, TCG=
v_i64 tcg_addr, int size)

         tcg_gen_addi_i64(tcg_hiaddr, tcg_addr, 8);
         tcg_gen_qemu_st_i64(tmp, be ? tcg_hiaddr : tcg_addr, get_mem_index=
(s),
-                            s->be_data | MO_Q);
+                            s->be_data | MO_UQ);
         tcg_gen_ld_i64(tmp, cpu_env, fp_reg_hi_offset(s, srcidx));
         tcg_gen_qemu_st_i64(tmp, be ? tcg_addr : tcg_hiaddr, get_mem_index=
(s),
-                            s->be_data | MO_Q);
+                            s->be_data | MO_UQ);
         tcg_temp_free_i64(tcg_hiaddr);
     }

@@ -960,13 +960,13 @@ static void do_fp_ld(DisasContext *s, int destidx, TC=
Gv_i64 tcg_addr, int size)

         tcg_gen_addi_i64(tcg_hiaddr, tcg_addr, 8);
         tcg_gen_qemu_ld_i64(tmplo, be ? tcg_hiaddr : tcg_addr, get_mem_ind=
ex(s),
-                            s->be_data | MO_Q);
+                            s->be_data | MO_UQ);
         tcg_gen_qemu_ld_i64(tmphi, be ? tcg_addr : tcg_hiaddr, get_mem_ind=
ex(s),
-                            s->be_data | MO_Q);
+                            s->be_data | MO_UQ);
         tcg_temp_free_i64(tcg_hiaddr);
     }

-    tcg_gen_st_i64(tmplo, cpu_env, fp_reg_offset(s, destidx, MO_64));
+    tcg_gen_st_i64(tmplo, cpu_env, fp_reg_offset(s, destidx, MO_UQ));
     tcg_gen_st_i64(tmphi, cpu_env, fp_reg_hi_offset(s, destidx));

     tcg_temp_free_i64(tmplo);
@@ -1011,8 +1011,8 @@ static void read_vec_element(DisasContext *s, TCGv_i6=
4 tcg_dest, int srcidx,
     case MO_SL:
         tcg_gen_ld32s_i64(tcg_dest, cpu_env, vect_off);
         break;
-    case MO_64:
-    case MO_64|MO_SIGN:
+    case MO_UQ:
+    case MO_SQ:
         tcg_gen_ld_i64(tcg_dest, cpu_env, vect_off);
         break;
     default:
@@ -1061,7 +1061,7 @@ static void write_vec_element(DisasContext *s, TCGv_i=
64 tcg_src, int destidx,
     case MO_UL:
         tcg_gen_st32_i64(tcg_src, cpu_env, vect_off);
         break;
-    case MO_64:
+    case MO_UQ:
         tcg_gen_st_i64(tcg_src, cpu_env, vect_off);
         break;
     default:
@@ -2207,7 +2207,7 @@ static void gen_load_exclusive(DisasContext *s, int r=
t, int rt2,
         g_assert(size >=3D 2);
         if (size =3D=3D 2) {
             /* The pair must be single-copy atomic for the doubleword.  */
-            memop |=3D MO_64 | MO_ALIGN;
+            memop |=3D MO_UQ | MO_ALIGN;
             tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
             if (s->be_data =3D=3D MO_LE) {
                 tcg_gen_extract_i64(cpu_reg(s, rt), cpu_exclusive_val, 0, =
32);
@@ -2219,7 +2219,7 @@ static void gen_load_exclusive(DisasContext *s, int r=
t, int rt2,
         } else {
             /* The pair must be single-copy atomic for *each* doubleword, =
not
                the entire quadword, however it must be quadword aligned.  =
*/
-            memop |=3D MO_64;
+            memop |=3D MO_UQ;
             tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx,
                                 memop | MO_ALIGN_16);

@@ -2271,7 +2271,7 @@ static void gen_store_exclusive(DisasContext *s, int =
rd, int rt, int rt2,
             tcg_gen_atomic_cmpxchg_i64(tmp, cpu_exclusive_addr,
                                        cpu_exclusive_val, tmp,
                                        get_mem_index(s),
-                                       MO_64 | MO_ALIGN | s->be_data);
+                                       MO_UQ | MO_ALIGN | s->be_data);
             tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
         } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
             if (!HAVE_CMPXCHG128) {
@@ -2355,7 +2355,7 @@ static void gen_compare_and_swap_pair(DisasContext *s=
, int rs, int rt,
         }

         tcg_gen_atomic_cmpxchg_i64(cmp, clean_addr, cmp, val, memidx,
-                                   MO_64 | MO_ALIGN | s->be_data);
+                                   MO_UQ | MO_ALIGN | s->be_data);
         tcg_temp_free_i64(val);

         if (s->be_data =3D=3D MO_LE) {
@@ -2389,9 +2389,9 @@ static void gen_compare_and_swap_pair(DisasContext *s=
, int rs, int rt,

         /* Load the two words, in memory order.  */
         tcg_gen_qemu_ld_i64(d1, clean_addr, memidx,
-                            MO_64 | MO_ALIGN_16 | s->be_data);
+                            MO_UQ | MO_ALIGN_16 | s->be_data);
         tcg_gen_addi_i64(a2, clean_addr, 8);
-        tcg_gen_qemu_ld_i64(d2, a2, memidx, MO_64 | s->be_data);
+        tcg_gen_qemu_ld_i64(d2, a2, memidx, MO_UQ | s->be_data);

         /* Compare the two words, also in memory order.  */
         tcg_gen_setcond_i64(TCG_COND_EQ, c1, d1, s1);
@@ -2401,8 +2401,8 @@ static void gen_compare_and_swap_pair(DisasContext *s=
, int rs, int rt,
         /* If compare equal, write back new data, else write back old data=
.  */
         tcg_gen_movcond_i64(TCG_COND_NE, c1, c2, zero, t1, d1);
         tcg_gen_movcond_i64(TCG_COND_NE, c2, c2, zero, t2, d2);
-        tcg_gen_qemu_st_i64(c1, clean_addr, memidx, MO_64 | s->be_data);
-        tcg_gen_qemu_st_i64(c2, a2, memidx, MO_64 | s->be_data);
+        tcg_gen_qemu_st_i64(c1, clean_addr, memidx, MO_UQ | s->be_data);
+        tcg_gen_qemu_st_i64(c2, a2, memidx, MO_UQ | s->be_data);
         tcg_temp_free_i64(a2);
         tcg_temp_free_i64(c1);
         tcg_temp_free_i64(c2);
@@ -5271,7 +5271,7 @@ static void handle_fp_compare(DisasContext *s, int si=
ze,
     TCGv_i64 tcg_flags =3D tcg_temp_new_i64();
     TCGv_ptr fpst =3D get_fpstatus_ptr(size =3D=3D MO_UW);

-    if (size =3D=3D MO_64) {
+    if (size =3D=3D MO_UQ) {
         TCGv_i64 tcg_vn, tcg_vm;

         tcg_vn =3D read_fp_dreg(s, rn);
@@ -5357,7 +5357,7 @@ static void disas_fp_compare(DisasContext *s, uint32_=
t insn)
         size =3D MO_UL;
         break;
     case 1:
-        size =3D MO_64;
+        size =3D MO_UQ;
         break;
     case 3:
         size =3D MO_UW;
@@ -5408,7 +5408,7 @@ static void disas_fp_ccomp(DisasContext *s, uint32_t =
insn)
         size =3D MO_UL;
         break;
     case 1:
-        size =3D MO_64;
+        size =3D MO_UQ;
         break;
     case 3:
         size =3D MO_UW;
@@ -5474,7 +5474,7 @@ static void disas_fp_csel(DisasContext *s, uint32_t i=
nsn)
         sz =3D MO_UL;
         break;
     case 1:
-        sz =3D MO_64;
+        sz =3D MO_UQ;
         break;
     case 3:
         sz =3D MO_UW;
@@ -6279,7 +6279,7 @@ static void disas_fp_imm(DisasContext *s, uint32_t in=
sn)
         sz =3D MO_UL;
         break;
     case 1:
-        sz =3D MO_64;
+        sz =3D MO_UQ;
         break;
     case 3:
         sz =3D MO_UW;
@@ -6585,7 +6585,7 @@ static void handle_fmov(DisasContext *s, int rd, int =
rn, int type, bool itof)
             break;
         case 1:
             /* 64 bit */
-            tcg_gen_ld_i64(tcg_rd, cpu_env, fp_reg_offset(s, rn, MO_64));
+            tcg_gen_ld_i64(tcg_rd, cpu_env, fp_reg_offset(s, rn, MO_UQ));
             break;
         case 2:
             /* 64 bits from top half */
@@ -6819,9 +6819,9 @@ static void disas_simd_ext(DisasContext *s, uint32_t =
insn)
      * extracting 64 bits from a 64:64 concatenation.
      */
     if (!is_q) {
-        read_vec_element(s, tcg_resl, rn, 0, MO_64);
+        read_vec_element(s, tcg_resl, rn, 0, MO_UQ);
         if (pos !=3D 0) {
-            read_vec_element(s, tcg_resh, rm, 0, MO_64);
+            read_vec_element(s, tcg_resh, rm, 0, MO_UQ);
             do_ext64(s, tcg_resh, tcg_resl, pos);
         }
         tcg_gen_movi_i64(tcg_resh, 0);
@@ -6839,22 +6839,22 @@ static void disas_simd_ext(DisasContext *s, uint32_=
t insn)
             pos -=3D 64;
         }

-        read_vec_element(s, tcg_resl, elt->reg, elt->elt, MO_64);
+        read_vec_element(s, tcg_resl, elt->reg, elt->elt, MO_UQ);
         elt++;
-        read_vec_element(s, tcg_resh, elt->reg, elt->elt, MO_64);
+        read_vec_element(s, tcg_resh, elt->reg, elt->elt, MO_UQ);
         elt++;
         if (pos !=3D 0) {
             do_ext64(s, tcg_resh, tcg_resl, pos);
             tcg_hh =3D tcg_temp_new_i64();
-            read_vec_element(s, tcg_hh, elt->reg, elt->elt, MO_64);
+            read_vec_element(s, tcg_hh, elt->reg, elt->elt, MO_UQ);
             do_ext64(s, tcg_hh, tcg_resh, pos);
             tcg_temp_free_i64(tcg_hh);
         }
     }

-    write_vec_element(s, tcg_resl, rd, 0, MO_64);
+    write_vec_element(s, tcg_resl, rd, 0, MO_UQ);
     tcg_temp_free_i64(tcg_resl);
-    write_vec_element(s, tcg_resh, rd, 1, MO_64);
+    write_vec_element(s, tcg_resh, rd, 1, MO_UQ);
     tcg_temp_free_i64(tcg_resh);
 }

@@ -6895,12 +6895,12 @@ static void disas_simd_tb(DisasContext *s, uint32_t=
 insn)
     tcg_resh =3D tcg_temp_new_i64();

     if (is_tblx) {
-        read_vec_element(s, tcg_resl, rd, 0, MO_64);
+        read_vec_element(s, tcg_resl, rd, 0, MO_UQ);
     } else {
         tcg_gen_movi_i64(tcg_resl, 0);
     }
     if (is_tblx && is_q) {
-        read_vec_element(s, tcg_resh, rd, 1, MO_64);
+        read_vec_element(s, tcg_resh, rd, 1, MO_UQ);
     } else {
         tcg_gen_movi_i64(tcg_resh, 0);
     }
@@ -6908,11 +6908,11 @@ static void disas_simd_tb(DisasContext *s, uint32_t=
 insn)
     tcg_idx =3D tcg_temp_new_i64();
     tcg_regno =3D tcg_const_i32(rn);
     tcg_numregs =3D tcg_const_i32(len + 1);
-    read_vec_element(s, tcg_idx, rm, 0, MO_64);
+    read_vec_element(s, tcg_idx, rm, 0, MO_UQ);
     gen_helper_simd_tbl(tcg_resl, cpu_env, tcg_resl, tcg_idx,
                         tcg_regno, tcg_numregs);
     if (is_q) {
-        read_vec_element(s, tcg_idx, rm, 1, MO_64);
+        read_vec_element(s, tcg_idx, rm, 1, MO_UQ);
         gen_helper_simd_tbl(tcg_resh, cpu_env, tcg_resh, tcg_idx,
                             tcg_regno, tcg_numregs);
     }
@@ -6920,9 +6920,9 @@ static void disas_simd_tb(DisasContext *s, uint32_t i=
nsn)
     tcg_temp_free_i32(tcg_regno);
     tcg_temp_free_i32(tcg_numregs);

-    write_vec_element(s, tcg_resl, rd, 0, MO_64);
+    write_vec_element(s, tcg_resl, rd, 0, MO_UQ);
     tcg_temp_free_i64(tcg_resl);
-    write_vec_element(s, tcg_resh, rd, 1, MO_64);
+    write_vec_element(s, tcg_resh, rd, 1, MO_UQ);
     tcg_temp_free_i64(tcg_resh);
 }

@@ -7009,9 +7009,9 @@ static void disas_simd_zip_trn(DisasContext *s, uint3=
2_t insn)

     tcg_temp_free_i64(tcg_res);

-    write_vec_element(s, tcg_resl, rd, 0, MO_64);
+    write_vec_element(s, tcg_resl, rd, 0, MO_UQ);
     tcg_temp_free_i64(tcg_resl);
-    write_vec_element(s, tcg_resh, rd, 1, MO_64);
+    write_vec_element(s, tcg_resh, rd, 1, MO_UQ);
     tcg_temp_free_i64(tcg_resh);
 }

@@ -7625,9 +7625,9 @@ static void disas_simd_mod_imm(DisasContext *s, uint3=
2_t insn)
     } else {
         /* ORR or BIC, with BIC negation to AND handled above.  */
         if (is_neg) {
-            gen_gvec_fn2i(s, is_q, rd, rd, imm, tcg_gen_gvec_andi, MO_64);
+            gen_gvec_fn2i(s, is_q, rd, rd, imm, tcg_gen_gvec_andi, MO_UQ);
         } else {
-            gen_gvec_fn2i(s, is_q, rd, rd, imm, tcg_gen_gvec_ori, MO_64);
+            gen_gvec_fn2i(s, is_q, rd, rd, imm, tcg_gen_gvec_ori, MO_UQ);
         }
     }
 }
@@ -7702,7 +7702,7 @@ static void disas_simd_scalar_pairwise(DisasContext *=
s, uint32_t insn)
                 size =3D MO_UW;
             }
         } else {
-            size =3D extract32(size, 0, 1) ? MO_64 : MO_UL;
+            size =3D extract32(size, 0, 1) ? MO_UQ : MO_UL;
         }

         if (!fp_access_check(s)) {
@@ -7716,13 +7716,13 @@ static void disas_simd_scalar_pairwise(DisasContext=
 *s, uint32_t insn)
         return;
     }

-    if (size =3D=3D MO_64) {
+    if (size =3D=3D MO_UQ) {
         TCGv_i64 tcg_op1 =3D tcg_temp_new_i64();
         TCGv_i64 tcg_op2 =3D tcg_temp_new_i64();
         TCGv_i64 tcg_res =3D tcg_temp_new_i64();

-        read_vec_element(s, tcg_op1, rn, 0, MO_64);
-        read_vec_element(s, tcg_op2, rn, 1, MO_64);
+        read_vec_element(s, tcg_op1, rn, 0, MO_UQ);
+        read_vec_element(s, tcg_op2, rn, 1, MO_UQ);

         switch (opcode) {
         case 0x3b: /* ADDP */
@@ -8085,9 +8085,9 @@ static void handle_vec_simd_sqshrn(DisasContext *s, b=
ool is_scalar, bool is_q,
     }

     if (!is_q) {
-        write_vec_element(s, tcg_final, rd, 0, MO_64);
+        write_vec_element(s, tcg_final, rd, 0, MO_UQ);
     } else {
-        write_vec_element(s, tcg_final, rd, 1, MO_64);
+        write_vec_element(s, tcg_final, rd, 1, MO_UQ);
     }

     if (round) {
@@ -8155,9 +8155,9 @@ static void handle_simd_qshl(DisasContext *s, bool sc=
alar, bool is_q,
         for (pass =3D 0; pass < maxpass; pass++) {
             TCGv_i64 tcg_op =3D tcg_temp_new_i64();

-            read_vec_element(s, tcg_op, rn, pass, MO_64);
+            read_vec_element(s, tcg_op, rn, pass, MO_UQ);
             genfn(tcg_op, cpu_env, tcg_op, tcg_shift);
-            write_vec_element(s, tcg_op, rd, pass, MO_64);
+            write_vec_element(s, tcg_op, rd, pass, MO_UQ);

             tcg_temp_free_i64(tcg_op);
         }
@@ -8228,11 +8228,11 @@ static void handle_simd_intfp_conv(DisasContext *s,=
 int rd, int rn,
     TCGMemOp mop =3D size | (is_signed ? MO_SIGN : 0);
     int pass;

-    if (fracbits || size =3D=3D MO_64) {
+    if (fracbits || size =3D=3D MO_UQ) {
         tcg_shift =3D tcg_const_i32(fracbits);
     }

-    if (size =3D=3D MO_64) {
+    if (size =3D=3D MO_UQ) {
         TCGv_i64 tcg_int64 =3D tcg_temp_new_i64();
         TCGv_i64 tcg_double =3D tcg_temp_new_i64();

@@ -8249,7 +8249,7 @@ static void handle_simd_intfp_conv(DisasContext *s, i=
nt rd, int rn,
             if (elements =3D=3D 1) {
                 write_fp_dreg(s, rd, tcg_double);
             } else {
-                write_vec_element(s, tcg_double, rd, pass, MO_64);
+                write_vec_element(s, tcg_double, rd, pass, MO_UQ);
             }
         }

@@ -8331,7 +8331,7 @@ static void handle_simd_shift_intfp_conv(DisasContext=
 *s, bool is_scalar,
     int immhb =3D immh << 3 | immb;

     if (immh & 8) {
-        size =3D MO_64;
+        size =3D MO_UQ;
         if (!is_scalar && !is_q) {
             unallocated_encoding(s);
             return;
@@ -8376,7 +8376,7 @@ static void handle_simd_shift_fpint_conv(DisasContext=
 *s, bool is_scalar,
     TCGv_i32 tcg_rmode, tcg_shift;

     if (immh & 0x8) {
-        size =3D MO_64;
+        size =3D MO_UQ;
         if (!is_scalar && !is_q) {
             unallocated_encoding(s);
             return;
@@ -8408,19 +8408,19 @@ static void handle_simd_shift_fpint_conv(DisasConte=
xt *s, bool is_scalar,
     fracbits =3D (16 << size) - immhb;
     tcg_shift =3D tcg_const_i32(fracbits);

-    if (size =3D=3D MO_64) {
+    if (size =3D=3D MO_UQ) {
         int maxpass =3D is_scalar ? 1 : 2;

         for (pass =3D 0; pass < maxpass; pass++) {
             TCGv_i64 tcg_op =3D tcg_temp_new_i64();

-            read_vec_element(s, tcg_op, rn, pass, MO_64);
+            read_vec_element(s, tcg_op, rn, pass, MO_UQ);
             if (is_u) {
                 gen_helper_vfp_touqd(tcg_op, tcg_op, tcg_shift, tcg_fpstat=
us);
             } else {
                 gen_helper_vfp_tosqd(tcg_op, tcg_op, tcg_shift, tcg_fpstat=
us);
             }
-            write_vec_element(s, tcg_op, rd, pass, MO_64);
+            write_vec_element(s, tcg_op, rd, pass, MO_UQ);
             tcg_temp_free_i64(tcg_op);
         }
         clear_vec_high(s, is_q, rd);
@@ -8601,7 +8601,7 @@ static void disas_simd_scalar_three_reg_diff(DisasCon=
text *s, uint32_t insn)
             tcg_gen_neg_i64(tcg_res, tcg_res);
             /* fall through */
         case 0x9: /* SQDMLAL, SQDMLAL2 */
-            read_vec_element(s, tcg_op1, rd, 0, MO_64);
+            read_vec_element(s, tcg_op1, rd, 0, MO_UQ);
             gen_helper_neon_addl_saturate_s64(tcg_res, cpu_env,
                                               tcg_res, tcg_op1);
             break;
@@ -8751,8 +8751,8 @@ static void handle_3same_float(DisasContext *s, int s=
ize, int elements,
             TCGv_i64 tcg_op2 =3D tcg_temp_new_i64();
             TCGv_i64 tcg_res =3D tcg_temp_new_i64();

-            read_vec_element(s, tcg_op1, rn, pass, MO_64);
-            read_vec_element(s, tcg_op2, rm, pass, MO_64);
+            read_vec_element(s, tcg_op1, rn, pass, MO_UQ);
+            read_vec_element(s, tcg_op2, rm, pass, MO_UQ);

             switch (fpopcode) {
             case 0x39: /* FMLS */
@@ -8760,7 +8760,7 @@ static void handle_3same_float(DisasContext *s, int s=
ize, int elements,
                 gen_helper_vfp_negd(tcg_op1, tcg_op1);
                 /* fall through */
             case 0x19: /* FMLA */
-                read_vec_element(s, tcg_res, rd, pass, MO_64);
+                read_vec_element(s, tcg_res, rd, pass, MO_UQ);
                 gen_helper_vfp_muladdd(tcg_res, tcg_op1, tcg_op2,
                                        tcg_res, fpst);
                 break;
@@ -8820,7 +8820,7 @@ static void handle_3same_float(DisasContext *s, int s=
ize, int elements,
                 g_assert_not_reached();
             }

-            write_vec_element(s, tcg_res, rd, pass, MO_64);
+            write_vec_element(s, tcg_res, rd, pass, MO_UQ);

             tcg_temp_free_i64(tcg_res);
             tcg_temp_free_i64(tcg_op1);
@@ -8905,7 +8905,7 @@ static void handle_3same_float(DisasContext *s, int s=
ize, int elements,
                 TCGv_i64 tcg_tmp =3D tcg_temp_new_i64();

                 tcg_gen_extu_i32_i64(tcg_tmp, tcg_res);
-                write_vec_element(s, tcg_tmp, rd, pass, MO_64);
+                write_vec_element(s, tcg_tmp, rd, pass, MO_UQ);
                 tcg_temp_free_i64(tcg_tmp);
             } else {
                 write_vec_element_i32(s, tcg_res, rd, pass, MO_UL);
@@ -9381,7 +9381,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, i=
nt opcode,
                                    bool is_scalar, bool is_u, bool is_q,
                                    int size, int rn, int rd)
 {
-    bool is_double =3D (size =3D=3D MO_64);
+    bool is_double =3D (size =3D=3D MO_UQ);
     TCGv_ptr fpst;

     if (!fp_access_check(s)) {
@@ -9419,13 +9419,13 @@ static void handle_2misc_fcmp_zero(DisasContext *s,=
 int opcode,
         }

         for (pass =3D 0; pass < (is_scalar ? 1 : 2); pass++) {
-            read_vec_element(s, tcg_op, rn, pass, MO_64);
+            read_vec_element(s, tcg_op, rn, pass, MO_UQ);
             if (swap) {
                 genfn(tcg_res, tcg_zero, tcg_op, fpst);
             } else {
                 genfn(tcg_res, tcg_op, tcg_zero, fpst);
             }
-            write_vec_element(s, tcg_res, rd, pass, MO_64);
+            write_vec_element(s, tcg_res, rd, pass, MO_UQ);
         }
         tcg_temp_free_i64(tcg_res);
         tcg_temp_free_i64(tcg_zero);
@@ -9526,7 +9526,7 @@ static void handle_2misc_reciprocal(DisasContext *s, =
int opcode,
         int pass;

         for (pass =3D 0; pass < (is_scalar ? 1 : 2); pass++) {
-            read_vec_element(s, tcg_op, rn, pass, MO_64);
+            read_vec_element(s, tcg_op, rn, pass, MO_UQ);
             switch (opcode) {
             case 0x3d: /* FRECPE */
                 gen_helper_recpe_f64(tcg_res, tcg_op, fpst);
@@ -9540,7 +9540,7 @@ static void handle_2misc_reciprocal(DisasContext *s, =
int opcode,
             default:
                 g_assert_not_reached();
             }
-            write_vec_element(s, tcg_res, rd, pass, MO_64);
+            write_vec_element(s, tcg_res, rd, pass, MO_UQ);
         }
         tcg_temp_free_i64(tcg_res);
         tcg_temp_free_i64(tcg_op);
@@ -9615,7 +9615,7 @@ static void handle_2misc_narrow(DisasContext *s, bool=
 scalar,
         if (scalar) {
             read_vec_element(s, tcg_op, rn, pass, size + 1);
         } else {
-            read_vec_element(s, tcg_op, rn, pass, MO_64);
+            read_vec_element(s, tcg_op, rn, pass, MO_UQ);
         }
         tcg_res[pass] =3D tcg_temp_new_i32();

@@ -9711,15 +9711,15 @@ static void handle_2misc_satacc(DisasContext *s, bo=
ol is_scalar, bool is_u,
         int pass;

         for (pass =3D 0; pass < (is_scalar ? 1 : 2); pass++) {
-            read_vec_element(s, tcg_rn, rn, pass, MO_64);
-            read_vec_element(s, tcg_rd, rd, pass, MO_64);
+            read_vec_element(s, tcg_rn, rn, pass, MO_UQ);
+            read_vec_element(s, tcg_rd, rd, pass, MO_UQ);

             if (is_u) { /* USQADD */
                 gen_helper_neon_uqadd_s64(tcg_rd, cpu_env, tcg_rn, tcg_rd)=
;
             } else { /* SUQADD */
                 gen_helper_neon_sqadd_u64(tcg_rd, cpu_env, tcg_rn, tcg_rd)=
;
             }
-            write_vec_element(s, tcg_rd, rd, pass, MO_64);
+            write_vec_element(s, tcg_rd, rd, pass, MO_UQ);
         }
         tcg_temp_free_i64(tcg_rd);
         tcg_temp_free_i64(tcg_rn);
@@ -9776,7 +9776,7 @@ static void handle_2misc_satacc(DisasContext *s, bool=
 is_scalar, bool is_u,

             if (is_scalar) {
                 TCGv_i64 tcg_zero =3D tcg_const_i64(0);
-                write_vec_element(s, tcg_zero, rd, 0, MO_64);
+                write_vec_element(s, tcg_zero, rd, 0, MO_UQ);
                 tcg_temp_free_i64(tcg_zero);
             }
             write_vec_element_i32(s, tcg_rd, rd, pass, MO_UL);
@@ -10146,7 +10146,7 @@ static void handle_vec_simd_wshli(DisasContext *s, =
bool is_q, bool is_u,
      * so if rd =3D=3D rn we would overwrite parts of our input.
      * So load everything right now and use shifts in the main loop.
      */
-    read_vec_element(s, tcg_rn, rn, is_q ? 1 : 0, MO_64);
+    read_vec_element(s, tcg_rn, rn, is_q ? 1 : 0, MO_UQ);

     for (i =3D 0; i < elements; i++) {
         tcg_gen_shri_i64(tcg_rd, tcg_rn, i * esize);
@@ -10183,7 +10183,7 @@ static void handle_vec_simd_shrn(DisasContext *s, b=
ool is_q,
     tcg_rn =3D tcg_temp_new_i64();
     tcg_rd =3D tcg_temp_new_i64();
     tcg_final =3D tcg_temp_new_i64();
-    read_vec_element(s, tcg_final, rd, is_q ? 1 : 0, MO_64);
+    read_vec_element(s, tcg_final, rd, is_q ? 1 : 0, MO_UQ);

     if (round) {
         uint64_t round_const =3D 1ULL << (shift - 1);
@@ -10201,9 +10201,9 @@ static void handle_vec_simd_shrn(DisasContext *s, b=
ool is_q,
     }

     if (!is_q) {
-        write_vec_element(s, tcg_final, rd, 0, MO_64);
+        write_vec_element(s, tcg_final, rd, 0, MO_UQ);
     } else {
-        write_vec_element(s, tcg_final, rd, 1, MO_64);
+        write_vec_element(s, tcg_final, rd, 1, MO_UQ);
     }
     if (round) {
         tcg_temp_free_i64(tcg_round);
@@ -10335,8 +10335,8 @@ static void handle_3rd_widening(DisasContext *s, in=
t is_q, int is_u, int size,
     }

     if (accop !=3D 0) {
-        read_vec_element(s, tcg_res[0], rd, 0, MO_64);
-        read_vec_element(s, tcg_res[1], rd, 1, MO_64);
+        read_vec_element(s, tcg_res[0], rd, 0, MO_UQ);
+        read_vec_element(s, tcg_res[1], rd, 1, MO_UQ);
     }

     /* size =3D=3D 2 means two 32x32->64 operations; this is worth special
@@ -10522,8 +10522,8 @@ static void handle_3rd_widening(DisasContext *s, in=
t is_q, int is_u, int size,
         }
     }

-    write_vec_element(s, tcg_res[0], rd, 0, MO_64);
-    write_vec_element(s, tcg_res[1], rd, 1, MO_64);
+    write_vec_element(s, tcg_res[0], rd, 0, MO_UQ);
+    write_vec_element(s, tcg_res[1], rd, 1, MO_UQ);
     tcg_temp_free_i64(tcg_res[0]);
     tcg_temp_free_i64(tcg_res[1]);
 }
@@ -10546,7 +10546,7 @@ static void handle_3rd_wide(DisasContext *s, int is=
_q, int is_u, int size,
         };
         NeonGenWidenFn *widenfn =3D widenfns[size][is_u];

-        read_vec_element(s, tcg_op1, rn, pass, MO_64);
+        read_vec_element(s, tcg_op1, rn, pass, MO_UQ);
         read_vec_element_i32(s, tcg_op2, rm, part + pass, MO_UL);
         widenfn(tcg_op2_wide, tcg_op2);
         tcg_temp_free_i32(tcg_op2);
@@ -10558,7 +10558,7 @@ static void handle_3rd_wide(DisasContext *s, int is=
_q, int is_u, int size,
     }

     for (pass =3D 0; pass < 2; pass++) {
-        write_vec_element(s, tcg_res[pass], rd, pass, MO_64);
+        write_vec_element(s, tcg_res[pass], rd, pass, MO_UQ);
         tcg_temp_free_i64(tcg_res[pass]);
     }
 }
@@ -10589,8 +10589,8 @@ static void handle_3rd_narrowing(DisasContext *s, i=
nt is_q, int is_u, int size,
         };
         NeonGenNarrowFn *gennarrow =3D narrowfns[size][is_u];

-        read_vec_element(s, tcg_op1, rn, pass, MO_64);
-        read_vec_element(s, tcg_op2, rm, pass, MO_64);
+        read_vec_element(s, tcg_op1, rn, pass, MO_UQ);
+        read_vec_element(s, tcg_op2, rm, pass, MO_UQ);

         gen_neon_addl(size, (opcode =3D=3D 6), tcg_wideres, tcg_op1, tcg_o=
p2);

@@ -10621,12 +10621,12 @@ static void handle_pmull_64(DisasContext *s, int =
is_q, int rd, int rn, int rm)
     TCGv_i64 tcg_op2 =3D tcg_temp_new_i64();
     TCGv_i64 tcg_res =3D tcg_temp_new_i64();

-    read_vec_element(s, tcg_op1, rn, is_q, MO_64);
-    read_vec_element(s, tcg_op2, rm, is_q, MO_64);
+    read_vec_element(s, tcg_op1, rn, is_q, MO_UQ);
+    read_vec_element(s, tcg_op2, rm, is_q, MO_UQ);
     gen_helper_neon_pmull_64_lo(tcg_res, tcg_op1, tcg_op2);
-    write_vec_element(s, tcg_res, rd, 0, MO_64);
+    write_vec_element(s, tcg_res, rd, 0, MO_UQ);
     gen_helper_neon_pmull_64_hi(tcg_res, tcg_op1, tcg_op2);
-    write_vec_element(s, tcg_res, rd, 1, MO_64);
+    write_vec_element(s, tcg_res, rd, 1, MO_UQ);

     tcg_temp_free_i64(tcg_op1);
     tcg_temp_free_i64(tcg_op2);
@@ -10814,8 +10814,8 @@ static void handle_simd_3same_pair(DisasContext *s,=
 int is_q, int u, int opcode,
             TCGv_i64 tcg_op2 =3D tcg_temp_new_i64();
             int passreg =3D (pass =3D=3D 0) ? rn : rm;

-            read_vec_element(s, tcg_op1, passreg, 0, MO_64);
-            read_vec_element(s, tcg_op2, passreg, 1, MO_64);
+            read_vec_element(s, tcg_op1, passreg, 0, MO_UQ);
+            read_vec_element(s, tcg_op2, passreg, 1, MO_UQ);
             tcg_res[pass] =3D tcg_temp_new_i64();

             switch (opcode) {
@@ -10846,7 +10846,7 @@ static void handle_simd_3same_pair(DisasContext *s,=
 int is_q, int u, int opcode,
         }

         for (pass =3D 0; pass < 2; pass++) {
-            write_vec_element(s, tcg_res[pass], rd, pass, MO_64);
+            write_vec_element(s, tcg_res[pass], rd, pass, MO_UQ);
             tcg_temp_free_i64(tcg_res[pass]);
         }
     } else {
@@ -10971,7 +10971,7 @@ static void disas_simd_3same_float(DisasContext *s,=
 uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        handle_simd_3same_pair(s, is_q, 0, fpopcode, size ? MO_64 : MO_UL,
+        handle_simd_3same_pair(s, is_q, 0, fpopcode, size ? MO_UQ : MO_UL,
                                rn, rm, rd);
         return;
     case 0x1b: /* FMULX */
@@ -11155,12 +11155,12 @@ static void disas_simd_3same_int(DisasContext *s,=
 uint32_t insn)
             TCGv_i64 tcg_op2 =3D tcg_temp_new_i64();
             TCGv_i64 tcg_res =3D tcg_temp_new_i64();

-            read_vec_element(s, tcg_op1, rn, pass, MO_64);
-            read_vec_element(s, tcg_op2, rm, pass, MO_64);
+            read_vec_element(s, tcg_op1, rn, pass, MO_UQ);
+            read_vec_element(s, tcg_op2, rm, pass, MO_UQ);

             handle_3same_64(s, opcode, u, tcg_res, tcg_op1, tcg_op2);

-            write_vec_element(s, tcg_res, rd, pass, MO_64);
+            write_vec_element(s, tcg_res, rd, pass, MO_UQ);

             tcg_temp_free_i64(tcg_res);
             tcg_temp_free_i64(tcg_op1);
@@ -11714,7 +11714,7 @@ static void handle_2misc_widening(DisasContext *s, =
int opcode, bool is_q,
             tcg_temp_free_i32(tcg_op);
         }
         for (pass =3D 0; pass < 2; pass++) {
-            write_vec_element(s, tcg_res[pass], rd, pass, MO_64);
+            write_vec_element(s, tcg_res[pass], rd, pass, MO_UQ);
             tcg_temp_free_i64(tcg_res[pass]);
         }
     } else {
@@ -11774,7 +11774,7 @@ static void handle_rev(DisasContext *s, int opcode,=
 bool u,
             case MO_UL:
                 tcg_gen_bswap32_i64(tcg_tmp, tcg_tmp);
                 break;
-            case MO_64:
+            case MO_UQ:
                 tcg_gen_bswap64_i64(tcg_tmp, tcg_tmp);
                 break;
             default:
@@ -11803,8 +11803,8 @@ static void handle_rev(DisasContext *s, int opcode,=
 bool u,
                 tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_rn, off, esize);
             }
         }
-        write_vec_element(s, tcg_rd, rd, 0, MO_64);
-        write_vec_element(s, tcg_rd_hi, rd, 1, MO_64);
+        write_vec_element(s, tcg_rd, rd, 0, MO_UQ);
+        write_vec_element(s, tcg_rd_hi, rd, 1, MO_UQ);

         tcg_temp_free_i64(tcg_rd_hi);
         tcg_temp_free_i64(tcg_rd);
@@ -11839,7 +11839,7 @@ static void handle_2misc_pairwise(DisasContext *s, =
int opcode, bool u,
             read_vec_element(s, tcg_op2, rn, pass * 2 + 1, memop);
             tcg_gen_add_i64(tcg_res[pass], tcg_op1, tcg_op2);
             if (accum) {
-                read_vec_element(s, tcg_op1, rd, pass, MO_64);
+                read_vec_element(s, tcg_op1, rd, pass, MO_UQ);
                 tcg_gen_add_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
             }

@@ -11859,11 +11859,11 @@ static void handle_2misc_pairwise(DisasContext *s=
, int opcode, bool u,

             tcg_res[pass] =3D tcg_temp_new_i64();

-            read_vec_element(s, tcg_op, rn, pass, MO_64);
+            read_vec_element(s, tcg_op, rn, pass, MO_UQ);
             genfn(tcg_res[pass], tcg_op);

             if (accum) {
-                read_vec_element(s, tcg_op, rd, pass, MO_64);
+                read_vec_element(s, tcg_op, rd, pass, MO_UQ);
                 if (size =3D=3D 0) {
                     gen_helper_neon_addl_u16(tcg_res[pass],
                                              tcg_res[pass], tcg_op);
@@ -11879,7 +11879,7 @@ static void handle_2misc_pairwise(DisasContext *s, =
int opcode, bool u,
         tcg_res[1] =3D tcg_const_i64(0);
     }
     for (pass =3D 0; pass < 2; pass++) {
-        write_vec_element(s, tcg_res[pass], rd, pass, MO_64);
+        write_vec_element(s, tcg_res[pass], rd, pass, MO_UQ);
         tcg_temp_free_i64(tcg_res[pass]);
     }
 }
@@ -11909,7 +11909,7 @@ static void handle_shll(DisasContext *s, bool is_q,=
 int size, int rn, int rd)
     }

     for (pass =3D 0; pass < 2; pass++) {
-        write_vec_element(s, tcg_res[pass], rd, pass, MO_64);
+        write_vec_element(s, tcg_res[pass], rd, pass, MO_UQ);
         tcg_temp_free_i64(tcg_res[pass]);
     }
 }
@@ -12233,12 +12233,12 @@ static void disas_simd_two_reg_misc(DisasContext =
*s, uint32_t insn)
             TCGv_i64 tcg_op =3D tcg_temp_new_i64();
             TCGv_i64 tcg_res =3D tcg_temp_new_i64();

-            read_vec_element(s, tcg_op, rn, pass, MO_64);
+            read_vec_element(s, tcg_op, rn, pass, MO_UQ);

             handle_2misc_64(s, opcode, u, tcg_res, tcg_op,
                             tcg_rmode, tcg_fpstatus);

-            write_vec_element(s, tcg_res, rd, pass, MO_64);
+            write_vec_element(s, tcg_res, rd, pass, MO_UQ);

             tcg_temp_free_i64(tcg_res);
             tcg_temp_free_i64(tcg_op);
@@ -12856,7 +12856,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
             is_fp16 =3D true;
             break;
         case MO_UL: /* single precision */
-        case MO_64: /* double precision */
+        case MO_UQ: /* double precision */
             break;
         default:
             unallocated_encoding(s);
@@ -12875,7 +12875,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
             }
             is_fp16 =3D true;
             break;
-        case MO_64:
+        case MO_UQ:
             break;
         default:
             unallocated_encoding(s);
@@ -12886,7 +12886,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
     default: /* integer */
         switch (size) {
         case MO_UB:
-        case MO_64:
+        case MO_UQ:
             unallocated_encoding(s);
             return;
         }
@@ -12906,7 +12906,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
         index =3D h << 1 | l;
         rm |=3D m << 4;
         break;
-    case MO_64:
+    case MO_UQ:
         if (l || !is_q) {
             unallocated_encoding(s);
             return;
@@ -12946,7 +12946,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
                                vec_full_reg_offset(s, rn),
                                vec_full_reg_offset(s, rm), fpst,
                                is_q ? 16 : 8, vec_full_reg_size(s), data,
-                               size =3D=3D MO_64
+                               size =3D=3D MO_UQ
                                ? gen_helper_gvec_fcmlas_idx
                                : gen_helper_gvec_fcmlah_idx);
             tcg_temp_free_ptr(fpst);
@@ -12976,13 +12976,13 @@ static void disas_simd_indexed(DisasContext *s, u=
int32_t insn)

         assert(is_fp && is_q && !is_long);

-        read_vec_element(s, tcg_idx, rm, index, MO_64);
+        read_vec_element(s, tcg_idx, rm, index, MO_UQ);

         for (pass =3D 0; pass < (is_scalar ? 1 : 2); pass++) {
             TCGv_i64 tcg_op =3D tcg_temp_new_i64();
             TCGv_i64 tcg_res =3D tcg_temp_new_i64();

-            read_vec_element(s, tcg_op, rn, pass, MO_64);
+            read_vec_element(s, tcg_op, rn, pass, MO_UQ);

             switch (16 * u + opcode) {
             case 0x05: /* FMLS */
@@ -12990,7 +12990,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
                 gen_helper_vfp_negd(tcg_op, tcg_op);
                 /* fall through */
             case 0x01: /* FMLA */
-                read_vec_element(s, tcg_res, rd, pass, MO_64);
+                read_vec_element(s, tcg_res, rd, pass, MO_UQ);
                 gen_helper_vfp_muladdd(tcg_res, tcg_op, tcg_idx, tcg_res, =
fpst);
                 break;
             case 0x09: /* FMUL */
@@ -13003,7 +13003,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
                 g_assert_not_reached();
             }

-            write_vec_element(s, tcg_res, rd, pass, MO_64);
+            write_vec_element(s, tcg_res, rd, pass, MO_UQ);
             tcg_temp_free_i64(tcg_op);
             tcg_temp_free_i64(tcg_res);
         }
@@ -13241,7 +13241,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
                 }

                 /* Accumulating op: handle accumulate step */
-                read_vec_element(s, tcg_res[pass], rd, pass, MO_64);
+                read_vec_element(s, tcg_res[pass], rd, pass, MO_UQ);

                 switch (opcode) {
                 case 0x2: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
@@ -13316,7 +13316,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
                 }

                 /* Accumulating op: handle accumulate step */
-                read_vec_element(s, tcg_res[pass], rd, pass, MO_64);
+                read_vec_element(s, tcg_res[pass], rd, pass, MO_UQ);

                 switch (opcode) {
                 case 0x2: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
@@ -13352,7 +13352,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
         }

         for (pass =3D 0; pass < 2; pass++) {
-            write_vec_element(s, tcg_res[pass], rd, pass, MO_64);
+            write_vec_element(s, tcg_res[pass], rd, pass, MO_UQ);
             tcg_temp_free_i64(tcg_res[pass]);
         }
     }
@@ -13639,14 +13639,14 @@ static void disas_crypto_three_reg_sha512(DisasCo=
ntext *s, uint32_t insn)
         tcg_res[1] =3D tcg_temp_new_i64();

         for (pass =3D 0; pass < 2; pass++) {
-            read_vec_element(s, tcg_op1, rn, pass, MO_64);
-            read_vec_element(s, tcg_op2, rm, pass, MO_64);
+            read_vec_element(s, tcg_op1, rn, pass, MO_UQ);
+            read_vec_element(s, tcg_op2, rm, pass, MO_UQ);

             tcg_gen_rotli_i64(tcg_res[pass], tcg_op2, 1);
             tcg_gen_xor_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
         }
-        write_vec_element(s, tcg_res[0], rd, 0, MO_64);
-        write_vec_element(s, tcg_res[1], rd, 1, MO_64);
+        write_vec_element(s, tcg_res[0], rd, 0, MO_UQ);
+        write_vec_element(s, tcg_res[1], rd, 1, MO_UQ);

         tcg_temp_free_i64(tcg_op1);
         tcg_temp_free_i64(tcg_op2);
@@ -13750,9 +13750,9 @@ static void disas_crypto_four_reg(DisasContext *s, =
uint32_t insn)
         tcg_res[1] =3D tcg_temp_new_i64();

         for (pass =3D 0; pass < 2; pass++) {
-            read_vec_element(s, tcg_op1, rn, pass, MO_64);
-            read_vec_element(s, tcg_op2, rm, pass, MO_64);
-            read_vec_element(s, tcg_op3, ra, pass, MO_64);
+            read_vec_element(s, tcg_op1, rn, pass, MO_UQ);
+            read_vec_element(s, tcg_op2, rm, pass, MO_UQ);
+            read_vec_element(s, tcg_op3, ra, pass, MO_UQ);

             if (op0 =3D=3D 0) {
                 /* EOR3 */
@@ -13763,8 +13763,8 @@ static void disas_crypto_four_reg(DisasContext *s, =
uint32_t insn)
             }
             tcg_gen_xor_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
         }
-        write_vec_element(s, tcg_res[0], rd, 0, MO_64);
-        write_vec_element(s, tcg_res[1], rd, 1, MO_64);
+        write_vec_element(s, tcg_res[0], rd, 0, MO_UQ);
+        write_vec_element(s, tcg_res[1], rd, 1, MO_UQ);

         tcg_temp_free_i64(tcg_op1);
         tcg_temp_free_i64(tcg_op2);
@@ -13832,14 +13832,14 @@ static void disas_crypto_xar(DisasContext *s, uin=
t32_t insn)
     tcg_res[1] =3D tcg_temp_new_i64();

     for (pass =3D 0; pass < 2; pass++) {
-        read_vec_element(s, tcg_op1, rn, pass, MO_64);
-        read_vec_element(s, tcg_op2, rm, pass, MO_64);
+        read_vec_element(s, tcg_op1, rn, pass, MO_UQ);
+        read_vec_element(s, tcg_op2, rm, pass, MO_UQ);

         tcg_gen_xor_i64(tcg_res[pass], tcg_op1, tcg_op2);
         tcg_gen_rotri_i64(tcg_res[pass], tcg_res[pass], imm6);
     }
-    write_vec_element(s, tcg_res[0], rd, 0, MO_64);
-    write_vec_element(s, tcg_res[1], rd, 1, MO_64);
+    write_vec_element(s, tcg_res[0], rd, 0, MO_UQ);
+    write_vec_element(s, tcg_res[1], rd, 1, MO_UQ);

     tcg_temp_free_i64(tcg_op1);
     tcg_temp_free_i64(tcg_op2);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f7c891d..423c461 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -1708,7 +1708,7 @@ static void do_sat_addsub_vec(DisasContext *s, int es=
z, int rd, int rn,
         tcg_temp_free_i64(t64);
         break;

-    case MO_64:
+    case MO_UQ:
         if (u) {
             if (d) {
                 gen_helper_sve_uqsubi_d(dptr, nptr, val, desc);
@@ -1862,7 +1862,7 @@ static bool do_zz_dbm(DisasContext *s, arg_rr_dbm *a,=
 GVecGen2iFn *gvec_fn)
     }
     if (sve_access_check(s)) {
         unsigned vsz =3D vec_full_reg_size(s);
-        gvec_fn(MO_64, vec_full_reg_offset(s, a->rd),
+        gvec_fn(MO_UQ, vec_full_reg_offset(s, a->rd),
                 vec_full_reg_offset(s, a->rn), imm, vsz, vsz);
     }
     return true;
@@ -2076,7 +2076,7 @@ static bool trans_INSR_f(DisasContext *s, arg_rrr_esz=
 *a)
 {
     if (sve_access_check(s)) {
         TCGv_i64 t =3D tcg_temp_new_i64();
-        tcg_gen_ld_i64(t, cpu_env, vec_reg_offset(s, a->rm, 0, MO_64));
+        tcg_gen_ld_i64(t, cpu_env, vec_reg_offset(s, a->rm, 0, MO_UQ));
         do_insr_i64(s, a, t);
         tcg_temp_free_i64(t);
     }
@@ -3327,7 +3327,7 @@ static bool trans_SUBR_zzi(DisasContext *s, arg_rri_e=
sz *a)
           .fno =3D gen_helper_sve_subri_d,
           .opt_opc =3D vecop_list,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64,
+          .vece =3D MO_UQ,
           .scalar_first =3D true }
     };

@@ -4571,7 +4571,7 @@ static const TCGMemOp dtype_mop[16] =3D {
     MO_UB, MO_UB, MO_UB, MO_UB,
     MO_SL, MO_UW, MO_UW, MO_UW,
     MO_SW, MO_SW, MO_UL, MO_UL,
-    MO_SB, MO_SB, MO_SB, MO_Q
+    MO_SB, MO_SB, MO_SB, MO_UQ
 };

 #define dtype_msz(x)  (dtype_mop[x] & MO_SIZE)
@@ -5261,7 +5261,7 @@ static bool trans_LD1_zprz(DisasContext *s, arg_LD1_z=
prz *a)
     case MO_UL:
         fn =3D gather_load_fn32[be][a->ff][a->xs][a->u][a->msz];
         break;
-    case MO_64:
+    case MO_UQ:
         fn =3D gather_load_fn64[be][a->ff][a->xs][a->u][a->msz];
         break;
     }
@@ -5289,7 +5289,7 @@ static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_z=
piz *a)
     case MO_UL:
         fn =3D gather_load_fn32[be][a->ff][0][a->u][a->msz];
         break;
-    case MO_64:
+    case MO_UQ:
         fn =3D gather_load_fn64[be][a->ff][2][a->u][a->msz];
         break;
     }
@@ -5367,7 +5367,7 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_z=
prz *a)
     case MO_UL:
         fn =3D scatter_store_fn32[be][a->xs][a->msz];
         break;
-    case MO_64:
+    case MO_UQ:
         fn =3D scatter_store_fn64[be][a->xs][a->msz];
         break;
     default:
@@ -5395,7 +5395,7 @@ static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_z=
piz *a)
     case MO_UL:
         fn =3D scatter_store_fn32[be][0][a->msz];
         break;
-    case MO_64:
+    case MO_UQ:
         fn =3D scatter_store_fn64[be][2][a->msz];
         break;
     }
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.=
c
index 5e0cd63..d71944d 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -40,7 +40,7 @@ uint64_t vfp_expand_imm(int size, uint8_t imm8)
     uint64_t imm;

     switch (size) {
-    case MO_64:
+    case MO_UQ:
         imm =3D (extract32(imm8, 7, 1) ? 0x8000 : 0) |
             (extract32(imm8, 6, 1) ? 0x3fc0 : 0x4000) |
             extract32(imm8, 0, 6);
@@ -1960,7 +1960,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VM=
OV_imm_dp *a)
         }
     }

-    fd =3D tcg_const_i64(vfp_expand_imm(MO_64, a->imm));
+    fd =3D tcg_const_i64(vfp_expand_imm(MO_UQ, a->imm));

     for (;;) {
         neon_store_reg64(fd, vd);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5510ecd..306ef24 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1171,7 +1171,7 @@ static void gen_aa32_ld_i64(DisasContext *s, TCGv_i64=
 val, TCGv_i32 a32,
 static inline void gen_aa32_ld64(DisasContext *s, TCGv_i64 val,
                                  TCGv_i32 a32, int index)
 {
-    gen_aa32_ld_i64(s, val, a32, index, MO_Q | s->be_data);
+    gen_aa32_ld_i64(s, val, a32, index, MO_UQ | s->be_data);
 }

 static void gen_aa32_st_i64(DisasContext *s, TCGv_i64 val, TCGv_i32 a32,
@@ -1194,7 +1194,7 @@ static void gen_aa32_st_i64(DisasContext *s, TCGv_i64=
 val, TCGv_i32 a32,
 static inline void gen_aa32_st64(DisasContext *s, TCGv_i64 val,
                                  TCGv_i32 a32, int index)
 {
-    gen_aa32_st_i64(s, val, a32, index, MO_Q | s->be_data);
+    gen_aa32_st_i64(s, val, a32, index, MO_UQ | s->be_data);
 }

 DO_GEN_LD(8s, MO_SB)
@@ -1455,7 +1455,7 @@ static void neon_load_element64(TCGv_i64 var, int reg=
, int ele, TCGMemOp mop)
     case MO_UL:
         tcg_gen_ld32u_i64(var, cpu_env, offset);
         break;
-    case MO_Q:
+    case MO_UQ:
         tcg_gen_ld_i64(var, cpu_env, offset);
         break;
     default:
@@ -1502,7 +1502,7 @@ static void neon_store_element64(int reg, int ele, TC=
GMemOp size, TCGv_i64 var)
     case MO_UL:
         tcg_gen_st32_i64(var, cpu_env, offset);
         break;
-    case MO_64:
+    case MO_UQ:
         tcg_gen_st_i64(var, cpu_env, offset);
         break;
     default:
@@ -4278,7 +4278,7 @@ const GVecGen2i ssra_op[4] =3D {
       .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
       .opt_opc =3D vecop_list_ssra,
       .load_dest =3D true,
-      .vece =3D MO_64 },
+      .vece =3D MO_UQ },
 };

 static void gen_usra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
@@ -4336,7 +4336,7 @@ const GVecGen2i usra_op[4] =3D {
       .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_usra,
-      .vece =3D MO_64, },
+      .vece =3D MO_UQ, },
 };

 static void gen_shr8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
@@ -4416,7 +4416,7 @@ const GVecGen2i sri_op[4] =3D {
       .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_sri,
-      .vece =3D MO_64 },
+      .vece =3D MO_UQ },
 };

 static void gen_shl8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
@@ -4494,7 +4494,7 @@ const GVecGen2i sli_op[4] =3D {
       .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_sli,
-      .vece =3D MO_64 },
+      .vece =3D MO_UQ },
 };

 static void gen_mla8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
@@ -4590,7 +4590,7 @@ const GVecGen3 mla_op[4] =3D {
       .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_mla,
-      .vece =3D MO_64 },
+      .vece =3D MO_UQ },
 };

 const GVecGen3 mls_op[4] =3D {
@@ -4614,7 +4614,7 @@ const GVecGen3 mls_op[4] =3D {
       .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
       .load_dest =3D true,
       .opt_opc =3D vecop_list_mls,
-      .vece =3D MO_64 },
+      .vece =3D MO_UQ },
 };

 /* CMTST : test is "if (X & Y !=3D 0)". */
@@ -4658,7 +4658,7 @@ const GVecGen3 cmtst_op[4] =3D {
       .fniv =3D gen_cmtst_vec,
       .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
       .opt_opc =3D vecop_list_cmtst,
-      .vece =3D MO_64 },
+      .vece =3D MO_UQ },
 };

 static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
@@ -4696,7 +4696,7 @@ const GVecGen4 uqadd_op[4] =3D {
       .fno =3D gen_helper_gvec_uqadd_d,
       .write_aofs =3D true,
       .opt_opc =3D vecop_list_uqadd,
-      .vece =3D MO_64 },
+      .vece =3D MO_UQ },
 };

 static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
@@ -4734,7 +4734,7 @@ const GVecGen4 sqadd_op[4] =3D {
       .fno =3D gen_helper_gvec_sqadd_d,
       .opt_opc =3D vecop_list_sqadd,
       .write_aofs =3D true,
-      .vece =3D MO_64 },
+      .vece =3D MO_UQ },
 };

 static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
@@ -4772,7 +4772,7 @@ const GVecGen4 uqsub_op[4] =3D {
       .fno =3D gen_helper_gvec_uqsub_d,
       .opt_opc =3D vecop_list_uqsub,
       .write_aofs =3D true,
-      .vece =3D MO_64 },
+      .vece =3D MO_UQ },
 };

 static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
@@ -4810,7 +4810,7 @@ const GVecGen4 sqsub_op[4] =3D {
       .fno =3D gen_helper_gvec_sqsub_d,
       .opt_opc =3D vecop_list_sqsub,
       .write_aofs =3D true,
-      .vece =3D MO_64 },
+      .vece =3D MO_UQ },
 };

 /* Translate a NEON data processing instruction.  Return nonzero if the
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 0e863d4..8d62b37 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -323,7 +323,7 @@ static inline bool byte_reg_is_xH(DisasContext *s, int =
reg)
 static inline TCGMemOp mo_pushpop(DisasContext *s, TCGMemOp ot)
 {
     if (CODE64(s)) {
-        return ot =3D=3D MO_UW ? MO_UW : MO_64;
+        return ot =3D=3D MO_UW ? MO_UW : MO_UQ;
     } else {
         return ot;
     }
@@ -332,14 +332,14 @@ static inline TCGMemOp mo_pushpop(DisasContext *s, TC=
GMemOp ot)
 /* Select the size of the stack pointer.  */
 static inline TCGMemOp mo_stacksize(DisasContext *s)
 {
-    return CODE64(s) ? MO_64 : s->ss32 ? MO_UL : MO_UW;
+    return CODE64(s) ? MO_UQ : s->ss32 ? MO_UL : MO_UW;
 }

 /* Select only size 64 else 32.  Used for SSE operand sizes.  */
 static inline TCGMemOp mo_64_32(TCGMemOp ot)
 {
 #ifdef TARGET_X86_64
-    return ot =3D=3D MO_64 ? MO_64 : MO_UL;
+    return ot =3D=3D MO_UQ ? MO_UQ : MO_UL;
 #else
     return MO_UL;
 #endif
@@ -378,7 +378,7 @@ static void gen_op_mov_reg_v(DisasContext *s, TCGMemOp =
ot, int reg, TCGv t0)
         tcg_gen_ext32u_tl(cpu_regs[reg], t0);
         break;
 #ifdef TARGET_X86_64
-    case MO_64:
+    case MO_UQ:
         tcg_gen_mov_tl(cpu_regs[reg], t0);
         break;
 #endif
@@ -456,7 +456,7 @@ static void gen_lea_v_seg(DisasContext *s, TCGMemOp afl=
ag, TCGv a0,
 {
     switch (aflag) {
 #ifdef TARGET_X86_64
-    case MO_64:
+    case MO_UQ:
         if (ovr_seg < 0) {
             tcg_gen_mov_tl(s->A0, a0);
             return;
@@ -492,7 +492,7 @@ static void gen_lea_v_seg(DisasContext *s, TCGMemOp afl=
ag, TCGv a0,
     if (ovr_seg >=3D 0) {
         TCGv seg =3D cpu_seg_base[ovr_seg];

-        if (aflag =3D=3D MO_64) {
+        if (aflag =3D=3D MO_UQ) {
             tcg_gen_add_tl(s->A0, a0, seg);
         } else if (CODE64(s)) {
             tcg_gen_ext32u_tl(s->A0, a0);
@@ -1469,7 +1469,7 @@ static void gen_shift_flags(DisasContext *s, TCGMemOp=
 ot, TCGv result,
 static void gen_shift_rm_T1(DisasContext *s, TCGMemOp ot, int op1,
                             int is_right, int is_arith)
 {
-    target_ulong mask =3D (ot =3D=3D MO_64 ? 0x3f : 0x1f);
+    target_ulong mask =3D (ot =3D=3D MO_UQ ? 0x3f : 0x1f);

     /* load */
     if (op1 =3D=3D OR_TMP0) {
@@ -1505,7 +1505,7 @@ static void gen_shift_rm_T1(DisasContext *s, TCGMemOp=
 ot, int op1,
 static void gen_shift_rm_im(DisasContext *s, TCGMemOp ot, int op1, int op2=
,
                             int is_right, int is_arith)
 {
-    int mask =3D (ot =3D=3D MO_64 ? 0x3f : 0x1f);
+    int mask =3D (ot =3D=3D MO_UQ ? 0x3f : 0x1f);

     /* load */
     if (op1 =3D=3D OR_TMP0)
@@ -1544,7 +1544,7 @@ static void gen_shift_rm_im(DisasContext *s, TCGMemOp=
 ot, int op1, int op2,

 static void gen_rot_rm_T1(DisasContext *s, TCGMemOp ot, int op1, int is_ri=
ght)
 {
-    target_ulong mask =3D (ot =3D=3D MO_64 ? 0x3f : 0x1f);
+    target_ulong mask =3D (ot =3D=3D MO_UQ ? 0x3f : 0x1f);
     TCGv_i32 t0, t1;

     /* load */
@@ -1630,7 +1630,7 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp o=
t, int op1, int is_right)
 static void gen_rot_rm_im(DisasContext *s, TCGMemOp ot, int op1, int op2,
                           int is_right)
 {
-    int mask =3D (ot =3D=3D MO_64 ? 0x3f : 0x1f);
+    int mask =3D (ot =3D=3D MO_UQ ? 0x3f : 0x1f);
     int shift;

     /* load */
@@ -1729,7 +1729,7 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMemOp =
ot, int op1,
             gen_helper_rcrl(s->T0, cpu_env, s->T0, s->T1);
             break;
 #ifdef TARGET_X86_64
-        case MO_64:
+        case MO_UQ:
             gen_helper_rcrq(s->T0, cpu_env, s->T0, s->T1);
             break;
 #endif
@@ -1748,7 +1748,7 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMemOp =
ot, int op1,
             gen_helper_rcll(s->T0, cpu_env, s->T0, s->T1);
             break;
 #ifdef TARGET_X86_64
-        case MO_64:
+        case MO_UQ:
             gen_helper_rclq(s->T0, cpu_env, s->T0, s->T1);
             break;
 #endif
@@ -1764,7 +1764,7 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMemOp =
ot, int op1,
 static void gen_shiftd_rm_T1(DisasContext *s, TCGMemOp ot, int op1,
                              bool is_right, TCGv count_in)
 {
-    target_ulong mask =3D (ot =3D=3D MO_64 ? 63 : 31);
+    target_ulong mask =3D (ot =3D=3D MO_UQ ? 63 : 31);
     TCGv count;

     /* load */
@@ -1983,7 +1983,7 @@ static AddressParts gen_lea_modrm_0(CPUX86State *env,=
 DisasContext *s,
     }

     switch (s->aflag) {
-    case MO_64:
+    case MO_UQ:
     case MO_UL:
         havesib =3D 0;
         if (rm =3D=3D 4) {
@@ -2192,7 +2192,7 @@ static inline uint32_t insn_get(CPUX86State *env, Dis=
asContext *s, TCGMemOp ot)
         break;
     case MO_UL:
 #ifdef TARGET_X86_64
-    case MO_64:
+    case MO_UQ:
 #endif
         ret =3D x86_ldl_code(env, s);
         break;
@@ -2443,7 +2443,7 @@ static void gen_popa(DisasContext *s)
 static void gen_enter(DisasContext *s, int esp_addend, int level)
 {
     TCGMemOp d_ot =3D mo_pushpop(s, s->dflag);
-    TCGMemOp a_ot =3D CODE64(s) ? MO_64 : s->ss32 ? MO_UL : MO_UW;
+    TCGMemOp a_ot =3D CODE64(s) ? MO_UQ : s->ss32 ? MO_UL : MO_UW;
     int size =3D 1 << d_ot;

     /* Push BP; compute FrameTemp into T1.  */
@@ -3150,8 +3150,8 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
             break;
         case 0x6e: /* movd mm, ea */
 #ifdef TARGET_X86_64
-            if (s->dflag =3D=3D MO_64) {
-                gen_ldst_modrm(env, s, modrm, MO_64, OR_TMP0, 0);
+            if (s->dflag =3D=3D MO_UQ) {
+                gen_ldst_modrm(env, s, modrm, MO_UQ, OR_TMP0, 0);
                 tcg_gen_st_tl(s->T0, cpu_env,
                               offsetof(CPUX86State, fpregs[reg].mmx));
             } else
@@ -3166,8 +3166,8 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
             break;
         case 0x16e: /* movd xmm, ea */
 #ifdef TARGET_X86_64
-            if (s->dflag =3D=3D MO_64) {
-                gen_ldst_modrm(env, s, modrm, MO_64, OR_TMP0, 0);
+            if (s->dflag =3D=3D MO_UQ) {
+                gen_ldst_modrm(env, s, modrm, MO_UQ, OR_TMP0, 0);
                 tcg_gen_addi_ptr(s->ptr0, cpu_env,
                                  offsetof(CPUX86State,xmm_regs[reg]));
                 gen_helper_movq_mm_T0_xmm(s->ptr0, s->T0);
@@ -3337,10 +3337,10 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
             break;
         case 0x7e: /* movd ea, mm */
 #ifdef TARGET_X86_64
-            if (s->dflag =3D=3D MO_64) {
+            if (s->dflag =3D=3D MO_UQ) {
                 tcg_gen_ld_i64(s->T0, cpu_env,
                                offsetof(CPUX86State,fpregs[reg].mmx));
-                gen_ldst_modrm(env, s, modrm, MO_64, OR_TMP0, 1);
+                gen_ldst_modrm(env, s, modrm, MO_UQ, OR_TMP0, 1);
             } else
 #endif
             {
@@ -3351,10 +3351,10 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
             break;
         case 0x17e: /* movd ea, xmm */
 #ifdef TARGET_X86_64
-            if (s->dflag =3D=3D MO_64) {
+            if (s->dflag =3D=3D MO_UQ) {
                 tcg_gen_ld_i64(s->T0, cpu_env,
                                offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(0)=
));
-                gen_ldst_modrm(env, s, modrm, MO_64, OR_TMP0, 1);
+                gen_ldst_modrm(env, s, modrm, MO_UQ, OR_TMP0, 1);
             } else
 #endif
             {
@@ -3785,10 +3785,10 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
                 }
                 if ((b & 0xff) =3D=3D 0xf0) {
                     ot =3D MO_UB;
-                } else if (s->dflag !=3D MO_64) {
+                } else if (s->dflag !=3D MO_UQ) {
                     ot =3D (s->prefix & PREFIX_DATA ? MO_UW : MO_UL);
                 } else {
-                    ot =3D MO_64;
+                    ot =3D MO_UQ;
                 }

                 tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[reg]);
@@ -3814,10 +3814,10 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
                 if (!(s->cpuid_ext_features & CPUID_EXT_MOVBE)) {
                     goto illegal_op;
                 }
-                if (s->dflag !=3D MO_64) {
+                if (s->dflag !=3D MO_UQ) {
                     ot =3D (s->prefix & PREFIX_DATA ? MO_UW : MO_UL);
                 } else {
-                    ot =3D MO_64;
+                    ot =3D MO_UQ;
                 }

                 gen_lea_modrm(env, s, modrm);
@@ -3861,7 +3861,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                     tcg_gen_ext8u_tl(s->A0, cpu_regs[s->vex_v]);
                     tcg_gen_shr_tl(s->T0, s->T0, s->A0);

-                    bound =3D tcg_const_tl(ot =3D=3D MO_64 ? 63 : 31);
+                    bound =3D tcg_const_tl(ot =3D=3D MO_UQ ? 63 : 31);
                     zero =3D tcg_const_tl(0);
                     tcg_gen_movcond_tl(TCG_COND_LEU, s->T0, s->A0, bound,
                                        s->T0, zero);
@@ -3894,7 +3894,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                 gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
                 tcg_gen_ext8u_tl(s->T1, cpu_regs[s->vex_v]);
                 {
-                    TCGv bound =3D tcg_const_tl(ot =3D=3D MO_64 ? 63 : 31)=
;
+                    TCGv bound =3D tcg_const_tl(ot =3D=3D MO_UQ ? 63 : 31)=
;
                     /* Note that since we're using BMILG (in order to get =
O
                        cleared) we need to store the inverse into C.  */
                     tcg_gen_setcond_tl(TCG_COND_LT, cpu_cc_src,
@@ -3929,7 +3929,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                     tcg_gen_extu_i32_tl(cpu_regs[reg], s->tmp3_i32);
                     break;
 #ifdef TARGET_X86_64
-                case MO_64:
+                case MO_UQ:
                     tcg_gen_mulu2_i64(s->T0, s->T1,
                                       s->T0, cpu_regs[R_EDX]);
                     tcg_gen_mov_i64(cpu_regs[s->vex_v], s->T0);
@@ -3949,7 +3949,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                 gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
                 /* Note that by zero-extending the mask operand, we
                    automatically handle zero-extending the result.  */
-                if (ot =3D=3D MO_64) {
+                if (ot =3D=3D MO_UQ) {
                     tcg_gen_mov_tl(s->T1, cpu_regs[s->vex_v]);
                 } else {
                     tcg_gen_ext32u_tl(s->T1, cpu_regs[s->vex_v]);
@@ -3967,7 +3967,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                 gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
                 /* Note that by zero-extending the mask operand, we
                    automatically handle zero-extending the result.  */
-                if (ot =3D=3D MO_64) {
+                if (ot =3D=3D MO_UQ) {
                     tcg_gen_mov_tl(s->T1, cpu_regs[s->vex_v]);
                 } else {
                     tcg_gen_ext32u_tl(s->T1, cpu_regs[s->vex_v]);
@@ -4063,7 +4063,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                 }
                 ot =3D mo_64_32(s->dflag);
                 gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-                if (ot =3D=3D MO_64) {
+                if (ot =3D=3D MO_UQ) {
                     tcg_gen_andi_tl(s->T1, cpu_regs[s->vex_v], 63);
                 } else {
                     tcg_gen_andi_tl(s->T1, cpu_regs[s->vex_v], 31);
@@ -4071,12 +4071,12 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
                 if (b =3D=3D 0x1f7) {
                     tcg_gen_shl_tl(s->T0, s->T0, s->T1);
                 } else if (b =3D=3D 0x2f7) {
-                    if (ot !=3D MO_64) {
+                    if (ot !=3D MO_UQ) {
                         tcg_gen_ext32s_tl(s->T0, s->T0);
                     }
                     tcg_gen_sar_tl(s->T0, s->T0, s->T1);
                 } else {
-                    if (ot !=3D MO_64) {
+                    if (ot !=3D MO_UQ) {
                         tcg_gen_ext32u_tl(s->T0, s->T0);
                     }
                     tcg_gen_shr_tl(s->T0, s->T0, s->T1);
@@ -4302,7 +4302,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
             if ((b & 0xfc) =3D=3D 0x60) { /* pcmpXstrX */
                 set_cc_op(s, CC_OP_EFLAGS);

-                if (s->dflag =3D=3D MO_64) {
+                if (s->dflag =3D=3D MO_UQ) {
                     /* The helper must use entire 64-bit gp registers */
                     val |=3D 1 << 8;
                 }
@@ -4329,7 +4329,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
                 ot =3D mo_64_32(s->dflag);
                 gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
                 b =3D x86_ldub_code(env, s);
-                if (ot =3D=3D MO_64) {
+                if (ot =3D=3D MO_UQ) {
                     tcg_gen_rotri_tl(s->T0, s->T0, b & 63);
                 } else {
                     tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
@@ -4630,9 +4630,9 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         /* In 64-bit mode, the default data size is 32-bit.  Select 64-bit
            data with rex_w, and 16-bit data with 0x66; rex_w takes precede=
nce
            over 0x66 if both are present.  */
-        dflag =3D (rex_w > 0 ? MO_64 : prefixes & PREFIX_DATA ? MO_UW : MO=
_UL);
+        dflag =3D (rex_w > 0 ? MO_UQ : prefixes & PREFIX_DATA ? MO_UW : MO=
_UL);
         /* In 64-bit mode, 0x67 selects 32-bit addressing.  */
-        aflag =3D (prefixes & PREFIX_ADR ? MO_UL : MO_64);
+        aflag =3D (prefixes & PREFIX_ADR ? MO_UL : MO_UQ);
     } else {
         /* In 16/32-bit mode, 0x66 selects the opposite data size.  */
         if (s->code32 ^ ((prefixes & PREFIX_DATA) !=3D 0)) {
@@ -4903,7 +4903,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 set_cc_op(s, CC_OP_MULL);
                 break;
 #ifdef TARGET_X86_64
-            case MO_64:
+            case MO_UQ:
                 tcg_gen_mulu2_i64(cpu_regs[R_EAX], cpu_regs[R_EDX],
                                   s->T0, cpu_regs[R_EAX]);
                 tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
@@ -4956,7 +4956,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 set_cc_op(s, CC_OP_MULL);
                 break;
 #ifdef TARGET_X86_64
-            case MO_64:
+            case MO_UQ:
                 tcg_gen_muls2_i64(cpu_regs[R_EAX], cpu_regs[R_EDX],
                                   s->T0, cpu_regs[R_EAX]);
                 tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
@@ -4980,7 +4980,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 gen_helper_divl_EAX(cpu_env, s->T0);
                 break;
 #ifdef TARGET_X86_64
-            case MO_64:
+            case MO_UQ:
                 gen_helper_divq_EAX(cpu_env, s->T0);
                 break;
 #endif
@@ -4999,7 +4999,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 gen_helper_idivl_EAX(cpu_env, s->T0);
                 break;
 #ifdef TARGET_X86_64
-            case MO_64:
+            case MO_UQ:
                 gen_helper_idivq_EAX(cpu_env, s->T0);
                 break;
 #endif
@@ -5024,7 +5024,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         if (CODE64(s)) {
             if (op =3D=3D 2 || op =3D=3D 4) {
                 /* operand size for jumps is 64 bit */
-                ot =3D MO_64;
+                ot =3D MO_UQ;
             } else if (op =3D=3D 3 || op =3D=3D 5) {
                 ot =3D dflag !=3D MO_UW ? MO_UL + (rex_w =3D=3D 1) : MO_UW=
;
             } else if (op =3D=3D 6) {
@@ -5145,10 +5145,10 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
     case 0x98: /* CWDE/CBW */
         switch (dflag) {
 #ifdef TARGET_X86_64
-        case MO_64:
+        case MO_UQ:
             gen_op_mov_v_reg(s, MO_UL, s->T0, R_EAX);
             tcg_gen_ext32s_tl(s->T0, s->T0);
-            gen_op_mov_reg_v(s, MO_64, R_EAX, s->T0);
+            gen_op_mov_reg_v(s, MO_UQ, R_EAX, s->T0);
             break;
 #endif
         case MO_UL:
@@ -5168,10 +5168,10 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
     case 0x99: /* CDQ/CWD */
         switch (dflag) {
 #ifdef TARGET_X86_64
-        case MO_64:
-            gen_op_mov_v_reg(s, MO_64, s->T0, R_EAX);
+        case MO_UQ:
+            gen_op_mov_v_reg(s, MO_UQ, s->T0, R_EAX);
             tcg_gen_sari_tl(s->T0, s->T0, 63);
-            gen_op_mov_reg_v(s, MO_64, R_EDX, s->T0);
+            gen_op_mov_reg_v(s, MO_UQ, R_EDX, s->T0);
             break;
 #endif
         case MO_UL:
@@ -5212,7 +5212,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
         }
         switch (ot) {
 #ifdef TARGET_X86_64
-        case MO_64:
+        case MO_UQ:
             tcg_gen_muls2_i64(cpu_regs[reg], s->T1, s->T0, s->T1);
             tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[reg]);
             tcg_gen_sari_tl(cpu_cc_src, cpu_cc_dst, 63);
@@ -5338,7 +5338,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
                 goto illegal_op;
             }
 #ifdef TARGET_X86_64
-            if (dflag =3D=3D MO_64) {
+            if (dflag =3D=3D MO_UQ) {
                 if (!(s->cpuid_ext_features & CPUID_EXT_CX16)) {
                     goto illegal_op;
                 }
@@ -5636,7 +5636,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             ot =3D mo_b_d(b, dflag);
             switch (s->aflag) {
 #ifdef TARGET_X86_64
-            case MO_64:
+            case MO_UQ:
                 offset_addr =3D x86_ldq_code(env, s);
                 break;
 #endif
@@ -5671,13 +5671,13 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
         break;
     case 0xb8 ... 0xbf: /* mov R, Iv */
 #ifdef TARGET_X86_64
-        if (dflag =3D=3D MO_64) {
+        if (dflag =3D=3D MO_UQ) {
             uint64_t tmp;
             /* 64 bit case */
             tmp =3D x86_ldq_code(env, s);
             reg =3D (b & 7) | REX_B(s);
             tcg_gen_movi_tl(s->T0, tmp);
-            gen_op_mov_reg_v(s, MO_64, reg, s->T0);
+            gen_op_mov_reg_v(s, MO_UQ, reg, s->T0);
         } else
 #endif
         {
@@ -7119,10 +7119,10 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
     case 0x1c8 ... 0x1cf: /* bswap reg */
         reg =3D (b & 7) | REX_B(s);
 #ifdef TARGET_X86_64
-        if (dflag =3D=3D MO_64) {
-            gen_op_mov_v_reg(s, MO_64, s->T0, reg);
+        if (dflag =3D=3D MO_UQ) {
+            gen_op_mov_v_reg(s, MO_UQ, s->T0, reg);
             tcg_gen_bswap64_i64(s->T0, s->T0);
-            gen_op_mov_reg_v(s, MO_64, reg, s->T0);
+            gen_op_mov_reg_v(s, MO_UQ, reg, s->T0);
         } else
 #endif
         {
@@ -7700,7 +7700,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             if (mod =3D=3D 3) {
                 gen_op_mov_v_reg(s, MO_UL, s->T0, rm);
                 /* sign extend */
-                if (d_ot =3D=3D MO_64) {
+                if (d_ot =3D=3D MO_UQ) {
                     tcg_gen_ext32s_tl(s->T0, s->T0);
                 }
                 gen_op_mov_reg_v(s, d_ot, reg, s->T0);
@@ -8014,7 +8014,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             rm =3D (modrm & 7) | REX_B(s);
             reg =3D ((modrm >> 3) & 7) | rex_r;
             if (CODE64(s))
-                ot =3D MO_64;
+                ot =3D MO_UQ;
             else
                 ot =3D MO_UL;
             if ((prefixes & PREFIX_LOCK) && (reg =3D=3D 0) &&
@@ -8071,7 +8071,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
             rm =3D (modrm & 7) | REX_B(s);
             reg =3D ((modrm >> 3) & 7) | rex_r;
             if (CODE64(s))
-                ot =3D MO_64;
+                ot =3D MO_UQ;
             else
                 ot =3D MO_UL;
             if (reg >=3D 8) {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 525c7fe..1023f68 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -3766,7 +3766,7 @@ static void gen_scwp(DisasContext *ctx, uint32_t base=
, int16_t offset,

     tcg_gen_ld_i64(llval, cpu_env, offsetof(CPUMIPSState, llval_wp));
     tcg_gen_atomic_cmpxchg_i64(val, taddr, llval, tval,
-                               eva ? MIPS_HFLAG_UM : ctx->mem_idx, MO_64);
+                               eva ? MIPS_HFLAG_UM : ctx->mem_idx, MO_UQ);
     if (reg1 !=3D 0) {
         tcg_gen_movi_tl(cpu_gpr[reg1], 1);
     }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4a5de28..f39dd94 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2470,10 +2470,10 @@ GEN_QEMU_LOAD_64(ld8u,  DEF_MEMOP(MO_UB))
 GEN_QEMU_LOAD_64(ld16u, DEF_MEMOP(MO_UW))
 GEN_QEMU_LOAD_64(ld32u, DEF_MEMOP(MO_UL))
 GEN_QEMU_LOAD_64(ld32s, DEF_MEMOP(MO_SL))
-GEN_QEMU_LOAD_64(ld64,  DEF_MEMOP(MO_Q))
+GEN_QEMU_LOAD_64(ld64,  DEF_MEMOP(MO_UQ))

 #if defined(TARGET_PPC64)
-GEN_QEMU_LOAD_64(ld64ur, BSWAP_MEMOP(MO_Q))
+GEN_QEMU_LOAD_64(ld64ur, BSWAP_MEMOP(MO_UQ))
 #endif

 #define GEN_QEMU_STORE_TL(stop, op)                                     \
@@ -2502,10 +2502,10 @@ static void glue(gen_qemu_, glue(stop, _i64))(Disas=
Context *ctx,  \
 GEN_QEMU_STORE_64(st8,  DEF_MEMOP(MO_UB))
 GEN_QEMU_STORE_64(st16, DEF_MEMOP(MO_UW))
 GEN_QEMU_STORE_64(st32, DEF_MEMOP(MO_UL))
-GEN_QEMU_STORE_64(st64, DEF_MEMOP(MO_Q))
+GEN_QEMU_STORE_64(st64, DEF_MEMOP(MO_UQ))

 #if defined(TARGET_PPC64)
-GEN_QEMU_STORE_64(st64r, BSWAP_MEMOP(MO_Q))
+GEN_QEMU_STORE_64(st64r, BSWAP_MEMOP(MO_UQ))
 #endif

 #define GEN_LD(name, ldop, opc, type)                                     =
    \
@@ -2605,7 +2605,7 @@ GEN_LDEPX(lb, DEF_MEMOP(MO_UB), 0x1F, 0x02)
 GEN_LDEPX(lh, DEF_MEMOP(MO_UW), 0x1F, 0x08)
 GEN_LDEPX(lw, DEF_MEMOP(MO_UL), 0x1F, 0x00)
 #if defined(TARGET_PPC64)
-GEN_LDEPX(ld, DEF_MEMOP(MO_Q), 0x1D, 0x00)
+GEN_LDEPX(ld, DEF_MEMOP(MO_UQ), 0x1D, 0x00)
 #endif

 #if defined(TARGET_PPC64)
@@ -2808,7 +2808,7 @@ GEN_STEPX(stb, DEF_MEMOP(MO_UB), 0x1F, 0x06)
 GEN_STEPX(sth, DEF_MEMOP(MO_UW), 0x1F, 0x0C)
 GEN_STEPX(stw, DEF_MEMOP(MO_UL), 0x1F, 0x04)
 #if defined(TARGET_PPC64)
-GEN_STEPX(std, DEF_MEMOP(MO_Q), 0x1d, 0x04)
+GEN_STEPX(std, DEF_MEMOP(MO_UQ), 0x1d, 0x04)
 #endif

 #if defined(TARGET_PPC64)
@@ -3244,7 +3244,7 @@ static void gen_ld_atomic(DisasContext *ctx, TCGMemOp=
 memop)
             TCGv t1 =3D tcg_temp_new();

             tcg_gen_qemu_ld_tl(t0, EA, ctx->mem_idx, memop);
-            if ((memop & MO_SIZE) =3D=3D MO_64 || TARGET_LONG_BITS =3D=3D =
32) {
+            if ((memop & MO_SIZE) =3D=3D MO_UQ || TARGET_LONG_BITS =3D=3D =
32) {
                 tcg_gen_mov_tl(t1, src);
             } else {
                 tcg_gen_ext32u_tl(t1, src);
@@ -3302,7 +3302,7 @@ static void gen_lwat(DisasContext *ctx)
 #ifdef TARGET_PPC64
 static void gen_ldat(DisasContext *ctx)
 {
-    gen_ld_atomic(ctx, DEF_MEMOP(MO_Q));
+    gen_ld_atomic(ctx, DEF_MEMOP(MO_UQ));
 }
 #endif

@@ -3385,7 +3385,7 @@ static void gen_stwat(DisasContext *ctx)
 #ifdef TARGET_PPC64
 static void gen_stdat(DisasContext *ctx)
 {
-    gen_st_atomic(ctx, DEF_MEMOP(MO_Q));
+    gen_st_atomic(ctx, DEF_MEMOP(MO_UQ));
 }
 #endif

@@ -3437,9 +3437,9 @@ STCX(stwcx_, DEF_MEMOP(MO_UL))

 #if defined(TARGET_PPC64)
 /* ldarx */
-LARX(ldarx, DEF_MEMOP(MO_Q))
+LARX(ldarx, DEF_MEMOP(MO_UQ))
 /* stdcx. */
-STCX(stdcx_, DEF_MEMOP(MO_Q))
+STCX(stdcx_, DEF_MEMOP(MO_UQ))

 /* lqarx */
 static void gen_lqarx(DisasContext *ctx)
@@ -3520,7 +3520,7 @@ static void gen_stqcx_(DisasContext *ctx)

     if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
         if (HAVE_CMPXCHG128) {
-            TCGv_i32 oi =3D tcg_const_i32(DEF_MEMOP(MO_Q) | MO_ALIGN_16);
+            TCGv_i32 oi =3D tcg_const_i32(DEF_MEMOP(MO_UQ) | MO_ALIGN_16);
             if (ctx->le_mode) {
                 gen_helper_stqcx_le_parallel(cpu_crf[0], cpu_env,
                                              EA, lo, hi, oi);
@@ -7366,7 +7366,7 @@ GEN_LDEPX(lb, DEF_MEMOP(MO_UB), 0x1F, 0x02)
 GEN_LDEPX(lh, DEF_MEMOP(MO_UW), 0x1F, 0x08)
 GEN_LDEPX(lw, DEF_MEMOP(MO_UL), 0x1F, 0x00)
 #if defined(TARGET_PPC64)
-GEN_LDEPX(ld, DEF_MEMOP(MO_Q), 0x1D, 0x00)
+GEN_LDEPX(ld, DEF_MEMOP(MO_UQ), 0x1D, 0x00)
 #endif

 #undef GEN_ST
@@ -7412,7 +7412,7 @@ GEN_STEPX(stb, DEF_MEMOP(MO_UB), 0x1F, 0x06)
 GEN_STEPX(sth, DEF_MEMOP(MO_UW), 0x1F, 0x0C)
 GEN_STEPX(stw, DEF_MEMOP(MO_UL), 0x1F, 0x04)
 #if defined(TARGET_PPC64)
-GEN_STEPX(std, DEF_MEMOP(MO_Q), 0x1D, 0x04)
+GEN_STEPX(std, DEF_MEMOP(MO_UQ), 0x1D, 0x04)
 #endif

 #undef GEN_CRLOGIC
diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp-i=
mpl.inc.c
index 9dcff94..3fd54ac 100644
--- a/target/ppc/translate/fp-impl.inc.c
+++ b/target/ppc/translate/fp-impl.inc.c
@@ -855,7 +855,7 @@ static void gen_lfdepx(DisasContext *ctx)
     EA =3D tcg_temp_new();
     t0 =3D tcg_temp_new_i64();
     gen_addr_reg_index(ctx, EA);
-    tcg_gen_qemu_ld_i64(t0, EA, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_Q));
+    tcg_gen_qemu_ld_i64(t0, EA, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UQ));
     set_fpr(rD(ctx->opcode), t0);
     tcg_temp_free(EA);
     tcg_temp_free_i64(t0);
@@ -1091,7 +1091,7 @@ static void gen_stfdepx(DisasContext *ctx)
     t0 =3D tcg_temp_new_i64();
     gen_addr_reg_index(ctx, EA);
     get_fpr(t0, rD(ctx->opcode));
-    tcg_gen_qemu_st_i64(t0, EA, PPC_TLB_EPID_STORE, DEF_MEMOP(MO_Q));
+    tcg_gen_qemu_st_i64(t0, EA, PPC_TLB_EPID_STORE, DEF_MEMOP(MO_UQ));
     tcg_temp_free(EA);
     tcg_temp_free_i64(t0);
 }
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx=
-impl.inc.c
index 8aa767e..867dc52 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -290,14 +290,14 @@ static void glue(gen_, name)(DisasContext *ctx)      =
                   \
 }

 /* Logical operations */
-GEN_VXFORM_V(vand, MO_64, tcg_gen_gvec_and, 2, 16);
-GEN_VXFORM_V(vandc, MO_64, tcg_gen_gvec_andc, 2, 17);
-GEN_VXFORM_V(vor, MO_64, tcg_gen_gvec_or, 2, 18);
-GEN_VXFORM_V(vxor, MO_64, tcg_gen_gvec_xor, 2, 19);
-GEN_VXFORM_V(vnor, MO_64, tcg_gen_gvec_nor, 2, 20);
-GEN_VXFORM_V(veqv, MO_64, tcg_gen_gvec_eqv, 2, 26);
-GEN_VXFORM_V(vnand, MO_64, tcg_gen_gvec_nand, 2, 22);
-GEN_VXFORM_V(vorc, MO_64, tcg_gen_gvec_orc, 2, 21);
+GEN_VXFORM_V(vand, MO_UQ, tcg_gen_gvec_and, 2, 16);
+GEN_VXFORM_V(vandc, MO_UQ, tcg_gen_gvec_andc, 2, 17);
+GEN_VXFORM_V(vor, MO_UQ, tcg_gen_gvec_or, 2, 18);
+GEN_VXFORM_V(vxor, MO_UQ, tcg_gen_gvec_xor, 2, 19);
+GEN_VXFORM_V(vnor, MO_UQ, tcg_gen_gvec_nor, 2, 20);
+GEN_VXFORM_V(veqv, MO_UQ, tcg_gen_gvec_eqv, 2, 26);
+GEN_VXFORM_V(vnand, MO_UQ, tcg_gen_gvec_nand, 2, 22);
+GEN_VXFORM_V(vorc, MO_UQ, tcg_gen_gvec_orc, 2, 21);

 #define GEN_VXFORM(name, opc2, opc3)                                    \
 static void glue(gen_, name)(DisasContext *ctx)                         \
@@ -410,27 +410,27 @@ GEN_VXFORM_V(vadduhm, MO_UW, tcg_gen_gvec_add, 0, 1);
 GEN_VXFORM_DUAL(vadduhm, PPC_ALTIVEC, PPC_NONE,  \
                 vmul10ecuq, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_V(vadduwm, MO_UL, tcg_gen_gvec_add, 0, 2);
-GEN_VXFORM_V(vaddudm, MO_64, tcg_gen_gvec_add, 0, 3);
+GEN_VXFORM_V(vaddudm, MO_UQ, tcg_gen_gvec_add, 0, 3);
 GEN_VXFORM_V(vsububm, MO_UB, tcg_gen_gvec_sub, 0, 16);
 GEN_VXFORM_V(vsubuhm, MO_UW, tcg_gen_gvec_sub, 0, 17);
 GEN_VXFORM_V(vsubuwm, MO_UL, tcg_gen_gvec_sub, 0, 18);
-GEN_VXFORM_V(vsubudm, MO_64, tcg_gen_gvec_sub, 0, 19);
+GEN_VXFORM_V(vsubudm, MO_UQ, tcg_gen_gvec_sub, 0, 19);
 GEN_VXFORM_V(vmaxub, MO_UB, tcg_gen_gvec_umax, 1, 0);
 GEN_VXFORM_V(vmaxuh, MO_UW, tcg_gen_gvec_umax, 1, 1);
 GEN_VXFORM_V(vmaxuw, MO_UL, tcg_gen_gvec_umax, 1, 2);
-GEN_VXFORM_V(vmaxud, MO_64, tcg_gen_gvec_umax, 1, 3);
+GEN_VXFORM_V(vmaxud, MO_UQ, tcg_gen_gvec_umax, 1, 3);
 GEN_VXFORM_V(vmaxsb, MO_UB, tcg_gen_gvec_smax, 1, 4);
 GEN_VXFORM_V(vmaxsh, MO_UW, tcg_gen_gvec_smax, 1, 5);
 GEN_VXFORM_V(vmaxsw, MO_UL, tcg_gen_gvec_smax, 1, 6);
-GEN_VXFORM_V(vmaxsd, MO_64, tcg_gen_gvec_smax, 1, 7);
+GEN_VXFORM_V(vmaxsd, MO_UQ, tcg_gen_gvec_smax, 1, 7);
 GEN_VXFORM_V(vminub, MO_UB, tcg_gen_gvec_umin, 1, 8);
 GEN_VXFORM_V(vminuh, MO_UW, tcg_gen_gvec_umin, 1, 9);
 GEN_VXFORM_V(vminuw, MO_UL, tcg_gen_gvec_umin, 1, 10);
-GEN_VXFORM_V(vminud, MO_64, tcg_gen_gvec_umin, 1, 11);
+GEN_VXFORM_V(vminud, MO_UQ, tcg_gen_gvec_umin, 1, 11);
 GEN_VXFORM_V(vminsb, MO_UB, tcg_gen_gvec_smin, 1, 12);
 GEN_VXFORM_V(vminsh, MO_UW, tcg_gen_gvec_smin, 1, 13);
 GEN_VXFORM_V(vminsw, MO_UL, tcg_gen_gvec_smin, 1, 14);
-GEN_VXFORM_V(vminsd, MO_64, tcg_gen_gvec_smin, 1, 15);
+GEN_VXFORM_V(vminsd, MO_UQ, tcg_gen_gvec_smin, 1, 15);
 GEN_VXFORM(vavgub, 1, 16);
 GEN_VXFORM(vabsdub, 1, 16);
 GEN_VXFORM_DUAL(vavgub, PPC_ALTIVEC, PPC_NONE, \
@@ -536,15 +536,15 @@ GEN_VXFORM_V(vslw, MO_UL, tcg_gen_gvec_shlv, 2, 6);
 GEN_VXFORM(vrlwnm, 2, 6);
 GEN_VXFORM_DUAL(vslw, PPC_ALTIVEC, PPC_NONE, \
                 vrlwnm, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM_V(vsld, MO_64, tcg_gen_gvec_shlv, 2, 23);
+GEN_VXFORM_V(vsld, MO_UQ, tcg_gen_gvec_shlv, 2, 23);
 GEN_VXFORM_V(vsrb, MO_UB, tcg_gen_gvec_shrv, 2, 8);
 GEN_VXFORM_V(vsrh, MO_UW, tcg_gen_gvec_shrv, 2, 9);
 GEN_VXFORM_V(vsrw, MO_UL, tcg_gen_gvec_shrv, 2, 10);
-GEN_VXFORM_V(vsrd, MO_64, tcg_gen_gvec_shrv, 2, 27);
+GEN_VXFORM_V(vsrd, MO_UQ, tcg_gen_gvec_shrv, 2, 27);
 GEN_VXFORM_V(vsrab, MO_UB, tcg_gen_gvec_sarv, 2, 12);
 GEN_VXFORM_V(vsrah, MO_UW, tcg_gen_gvec_sarv, 2, 13);
 GEN_VXFORM_V(vsraw, MO_UL, tcg_gen_gvec_sarv, 2, 14);
-GEN_VXFORM_V(vsrad, MO_64, tcg_gen_gvec_sarv, 2, 15);
+GEN_VXFORM_V(vsrad, MO_UQ, tcg_gen_gvec_sarv, 2, 15);
 GEN_VXFORM(vsrv, 2, 28);
 GEN_VXFORM(vslv, 2, 29);
 GEN_VXFORM(vslo, 6, 16);
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx=
-impl.inc.c
index 212817e..d607974 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1475,14 +1475,14 @@ static void glue(gen_, name)(DisasContext *ctx)    =
                  \
                vsr_full_offset(xB(ctx->opcode)), 16, 16);            \
     }

-VSX_LOGICAL(xxland, MO_64, tcg_gen_gvec_and)
-VSX_LOGICAL(xxlandc, MO_64, tcg_gen_gvec_andc)
-VSX_LOGICAL(xxlor, MO_64, tcg_gen_gvec_or)
-VSX_LOGICAL(xxlxor, MO_64, tcg_gen_gvec_xor)
-VSX_LOGICAL(xxlnor, MO_64, tcg_gen_gvec_nor)
-VSX_LOGICAL(xxleqv, MO_64, tcg_gen_gvec_eqv)
-VSX_LOGICAL(xxlnand, MO_64, tcg_gen_gvec_nand)
-VSX_LOGICAL(xxlorc, MO_64, tcg_gen_gvec_orc)
+VSX_LOGICAL(xxland, MO_UQ, tcg_gen_gvec_and)
+VSX_LOGICAL(xxlandc, MO_UQ, tcg_gen_gvec_andc)
+VSX_LOGICAL(xxlor, MO_UQ, tcg_gen_gvec_or)
+VSX_LOGICAL(xxlxor, MO_UQ, tcg_gen_gvec_xor)
+VSX_LOGICAL(xxlnor, MO_UQ, tcg_gen_gvec_nor)
+VSX_LOGICAL(xxleqv, MO_UQ, tcg_gen_gvec_eqv)
+VSX_LOGICAL(xxlnand, MO_UQ, tcg_gen_gvec_nand)
+VSX_LOGICAL(xxlorc, MO_UQ, tcg_gen_gvec_orc)

 #define VSX_XXMRG(name, high)                               \
 static void glue(gen_, name)(DisasContext *ctx)             \
@@ -1535,7 +1535,7 @@ static void gen_xxsel(DisasContext *ctx)
         gen_exception(ctx, POWERPC_EXCP_VSXU);
         return;
     }
-    tcg_gen_gvec_bitsel(MO_64, vsr_full_offset(rt), vsr_full_offset(rc),
+    tcg_gen_gvec_bitsel(MO_UQ, vsr_full_offset(rt), vsr_full_offset(rc),
                         vsr_full_offset(rb), vsr_full_offset(ra), 16, 16);
 }

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 9e646f1..5c72db1 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -180,7 +180,7 @@ static inline int vec_reg_offset(uint8_t reg, uint8_t e=
nr, TCGMemOp es)
      * the two 8 byte elements have to be loaded separately. Let's force a=
ll
      * 16 byte operations to handle it in a special way.
      */
-    g_assert(es <=3D MO_64);
+    g_assert(es <=3D MO_UQ);
 #ifndef HOST_WORDS_BIGENDIAN
     offs ^=3D (8 - bytes);
 #endif
@@ -190,7 +190,7 @@ static inline int vec_reg_offset(uint8_t reg, uint8_t e=
nr, TCGMemOp es)
 static inline int freg64_offset(uint8_t reg)
 {
     g_assert(reg < 16);
-    return vec_reg_offset(reg, 0, MO_64);
+    return vec_reg_offset(reg, 0, MO_UQ);
 }

 static inline int freg32_offset(uint8_t reg)
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.in=
c.c
index 75d788c..6252262 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -30,8 +30,8 @@
  * Sizes:
  *  On s390x, the operand size (oprsz) and the maximum size (maxsz) are
  *  always 16 (128 bit). What gvec code calls "vece", s390x calls "es",
- *  a.k.a. "element size". These values nicely map to MO_UB ... MO_64. Onl=
y
- *  128 bit element size has to be treated in a special way (MO_64 + 1).
+ *  a.k.a. "element size". These values nicely map to MO_UB ... MO_UQ. Onl=
y
+ *  128 bit element size has to be treated in a special way (MO_UQ + 1).
  *  We will use ES_* instead of MO_* for this reason in this file.
  *
  * CC handling:
@@ -49,7 +49,7 @@
 #define ES_8    MO_UB
 #define ES_16   MO_UW
 #define ES_32   MO_UL
-#define ES_64   MO_64
+#define ES_64   MO_UQ
 #define ES_128  4

 /* Floating-Point Format */
diff --git a/target/s390x/vec.h b/target/s390x/vec.h
index f67392c..b59da65 100644
--- a/target/s390x/vec.h
+++ b/target/s390x/vec.h
@@ -82,7 +82,7 @@ static inline uint64_t s390_vec_read_element(const S390Ve=
ctor *v, uint8_t enr,
         return s390_vec_read_element16(v, enr);
     case MO_UL:
         return s390_vec_read_element32(v, enr);
-    case MO_64:
+    case MO_UQ:
         return s390_vec_read_element64(v, enr);
     default:
         g_assert_not_reached();
@@ -130,7 +130,7 @@ static inline void s390_vec_write_element(S390Vector *v=
, uint8_t enr,
     case MO_UL:
         s390_vec_write_element32(v, enr, data);
         break;
-    case MO_64:
+    case MO_UQ:
         s390_vec_write_element64(v, enr, data);
         break;
     default:
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 091bab5..499622b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2840,7 +2840,7 @@ static void gen_ldda_asi(DisasContext *dc, TCGv addr,=
 int insn, int rd)
     default:
         {
             TCGv_i32 r_asi =3D tcg_const_i32(da.asi);
-            TCGv_i32 r_mop =3D tcg_const_i32(MO_Q);
+            TCGv_i32 r_mop =3D tcg_const_i32(MO_UQ);

             save_state(dc);
             gen_helper_ld_asi(t64, cpu_env, addr, r_asi, r_mop);
@@ -2896,7 +2896,7 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, T=
CGv addr,
     default:
         {
             TCGv_i32 r_asi =3D tcg_const_i32(da.asi);
-            TCGv_i32 r_mop =3D tcg_const_i32(MO_Q);
+            TCGv_i32 r_mop =3D tcg_const_i32(MO_UQ);

             save_state(dc);
             gen_helper_st_asi(cpu_env, addr, t64, r_asi, r_mop);
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index dc4fd21..d14afa9 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -432,12 +432,12 @@ typedef enum {
     I3312_STRB      =3D 0x38000000 | LDST_ST << 22 | MO_UB << 30,
     I3312_STRH      =3D 0x38000000 | LDST_ST << 22 | MO_UW << 30,
     I3312_STRW      =3D 0x38000000 | LDST_ST << 22 | MO_UL << 30,
-    I3312_STRX      =3D 0x38000000 | LDST_ST << 22 | MO_64 << 30,
+    I3312_STRX      =3D 0x38000000 | LDST_ST << 22 | MO_UQ << 30,

     I3312_LDRB      =3D 0x38000000 | LDST_LD << 22 | MO_UB << 30,
     I3312_LDRH      =3D 0x38000000 | LDST_LD << 22 | MO_UW << 30,
     I3312_LDRW      =3D 0x38000000 | LDST_LD << 22 | MO_UL << 30,
-    I3312_LDRX      =3D 0x38000000 | LDST_LD << 22 | MO_64 << 30,
+    I3312_LDRX      =3D 0x38000000 | LDST_LD << 22 | MO_UQ << 30,

     I3312_LDRSBW    =3D 0x38000000 | LDST_LD_S_W << 22 | MO_UB << 30,
     I3312_LDRSHW    =3D 0x38000000 | LDST_LD_S_W << 22 | MO_UW << 30,
@@ -449,8 +449,8 @@ typedef enum {
     I3312_LDRVS     =3D 0x3c000000 | LDST_LD << 22 | MO_UL << 30,
     I3312_STRVS     =3D 0x3c000000 | LDST_ST << 22 | MO_UL << 30,

-    I3312_LDRVD     =3D 0x3c000000 | LDST_LD << 22 | MO_64 << 30,
-    I3312_STRVD     =3D 0x3c000000 | LDST_ST << 22 | MO_64 << 30,
+    I3312_LDRVD     =3D 0x3c000000 | LDST_LD << 22 | MO_UQ << 30,
+    I3312_STRVD     =3D 0x3c000000 | LDST_ST << 22 | MO_UQ << 30,

     I3312_LDRVQ     =3D 0x3c000000 | 3 << 22 | 0 << 30,
     I3312_STRVQ     =3D 0x3c000000 | 2 << 22 | 0 << 30,
@@ -1595,7 +1595,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
     if (opc & MO_SIGN) {
         tcg_out_sxt(s, lb->type, size, lb->datalo_reg, TCG_REG_X0);
     } else {
-        tcg_out_mov(s, size =3D=3D MO_64, lb->datalo_reg, TCG_REG_X0);
+        tcg_out_mov(s, size =3D=3D MO_UQ, lb->datalo_reg, TCG_REG_X0);
     }

     tcg_out_goto(s, lb->raddr);
@@ -1614,7 +1614,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)

     tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_X0, TCG_AREG0);
     tcg_out_mov(s, TARGET_LONG_BITS =3D=3D 64, TCG_REG_X1, lb->addrlo_reg)=
;
-    tcg_out_mov(s, size =3D=3D MO_64, TCG_REG_X2, lb->datalo_reg);
+    tcg_out_mov(s, size =3D=3D MO_UQ, TCG_REG_X2, lb->datalo_reg);
     tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_X3, oi);
     tcg_out_adr(s, TCG_REG_X4, lb->raddr);
     tcg_out_call(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
@@ -1754,7 +1754,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCG=
MemOp memop, TCGType ext,
             tcg_out_ldst_r(s, I3312_LDRSWX, data_r, addr_r, otype, off_r);
         }
         break;
-    case MO_Q:
+    case MO_UQ:
         tcg_out_ldst_r(s, I3312_LDRX, data_r, addr_r, otype, off_r);
         if (bswap) {
             tcg_out_rev64(s, data_r, data_r);
@@ -1789,7 +1789,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
MemOp memop,
         }
         tcg_out_ldst_r(s, I3312_STRW, data_r, addr_r, otype, off_r);
         break;
-    case MO_64:
+    case MO_UQ:
         if (bswap && data_r !=3D TCG_REG_XZR) {
             tcg_out_rev64(s, TCG_REG_TMP, data_r);
             data_r =3D TCG_REG_TMP;
@@ -1838,7 +1838,7 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg dat=
a_reg, TCGReg addr_reg,
     tcg_out_tlb_read(s, addr_reg, memop, &label_ptr, mem_index, 0);
     tcg_out_qemu_st_direct(s, memop, data_reg,
                            TCG_REG_X1, otype, addr_reg);
-    add_qemu_ldst_label(s, false, oi, (memop & MO_SIZE)=3D=3D MO_64,
+    add_qemu_ldst_label(s, false, oi, (memop & MO_SIZE) =3D=3D MO_UQ,
                         data_reg, addr_reg, s->code_ptr, label_ptr);
 #else /* !CONFIG_SOFTMMU */
     if (USE_GUEST_BASE) {
@@ -2506,7 +2506,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, =
unsigned vece)
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
     case INDEX_op_umin_vec:
-        return vece < MO_64;
+        return vece < MO_UQ;

     default:
         return 0;
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 05560a2..70eeb8a 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1389,7 +1389,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
     default:
         tcg_out_mov_reg(s, COND_AL, datalo, TCG_REG_R0);
         break;
-    case MO_Q:
+    case MO_UQ:
         if (datalo !=3D TCG_REG_R1) {
             tcg_out_mov_reg(s, COND_AL, datalo, TCG_REG_R0);
             tcg_out_mov_reg(s, COND_AL, datahi, TCG_REG_R1);
@@ -1439,7 +1439,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
     default:
         argreg =3D tcg_out_arg_reg32(s, argreg, datalo);
         break;
-    case MO_64:
+    case MO_UQ:
         argreg =3D tcg_out_arg_reg64(s, argreg, datalo, datahi);
         break;
     }
@@ -1487,7 +1487,7 @@ static inline void tcg_out_qemu_ld_index(TCGContext *=
s, TCGMemOp opc,
             tcg_out_bswap32(s, COND_AL, datalo, datalo);
         }
         break;
-    case MO_Q:
+    case MO_UQ:
         {
             TCGReg dl =3D (bswap ? datahi : datalo);
             TCGReg dh =3D (bswap ? datalo : datahi);
@@ -1548,7 +1548,7 @@ static inline void tcg_out_qemu_ld_direct(TCGContext =
*s, TCGMemOp opc,
             tcg_out_bswap32(s, COND_AL, datalo, datalo);
         }
         break;
-    case MO_Q:
+    case MO_UQ:
         {
             TCGReg dl =3D (bswap ? datahi : datalo);
             TCGReg dh =3D (bswap ? datalo : datahi);
@@ -1641,7 +1641,7 @@ static inline void tcg_out_qemu_st_index(TCGContext *=
s, int cond, TCGMemOp opc,
             tcg_out_st32_r(s, cond, datalo, addrlo, addend);
         }
         break;
-    case MO_64:
+    case MO_UQ:
         /* Avoid strd for user-only emulation, to handle unaligned.  */
         if (bswap) {
             tcg_out_bswap32(s, cond, TCG_REG_R0, datahi);
@@ -1686,7 +1686,7 @@ static inline void tcg_out_qemu_st_direct(TCGContext =
*s, TCGMemOp opc,
             tcg_out_st32_12(s, COND_AL, datalo, addrlo, 0);
         }
         break;
-    case MO_64:
+    case MO_UQ:
         /* Avoid strd for user-only emulation, to handle unaligned.  */
         if (bswap) {
             tcg_out_bswap32(s, COND_AL, TCG_REG_R0, datahi);
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 93e4c63..3a73334 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -902,7 +902,7 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type=
, unsigned vece,
             /* imm8 operand: all output lanes selected from input lane 0. =
 */
             tcg_out8(s, 0);
             break;
-        case MO_64:
+        case MO_UQ:
             tcg_out_vex_modrm(s, OPC_PUNPCKLQDQ, r, a, a);
             break;
         default:
@@ -921,7 +921,7 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType typ=
e, unsigned vece,
                                  r, 0, base, offset);
     } else {
         switch (vece) {
-        case MO_64:
+        case MO_UQ:
             tcg_out_vex_modrm_offset(s, OPC_MOVDDUP, r, 0, base, offset);
             break;
         case MO_UL:
@@ -1868,7 +1868,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
     case MO_UL:
         tcg_out_mov(s, TCG_TYPE_I32, data_reg, TCG_REG_EAX);
         break;
-    case MO_Q:
+    case MO_UQ:
         if (TCG_TARGET_REG_BITS =3D=3D 64) {
             tcg_out_mov(s, TCG_TYPE_I64, data_reg, TCG_REG_RAX);
         } else if (data_reg =3D=3D TCG_REG_EDX) {
@@ -1923,7 +1923,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
         tcg_out_st(s, TCG_TYPE_I32, l->datalo_reg, TCG_REG_ESP, ofs);
         ofs +=3D 4;

-        if (s_bits =3D=3D MO_64) {
+        if (s_bits =3D=3D MO_UQ) {
             tcg_out_st(s, TCG_TYPE_I32, l->datahi_reg, TCG_REG_ESP, ofs);
             ofs +=3D 4;
         }
@@ -1937,7 +1937,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
     } else {
         tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_ARE=
G0);
         /* The second argument is already loaded with addrlo.  */
-        tcg_out_mov(s, (s_bits =3D=3D MO_64 ? TCG_TYPE_I64 : TCG_TYPE_I32)=
,
+        tcg_out_mov(s, (s_bits =3D=3D MO_UQ ? TCG_TYPE_I64 : TCG_TYPE_I32)=
,
                     tcg_target_call_iarg_regs[2], l->datalo_reg);
         tcg_out_movi(s, TCG_TYPE_I32, tcg_target_call_iarg_regs[3], oi);

@@ -2060,7 +2060,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCG=
Reg datalo, TCGReg datahi,
         }
         break;
 #endif
-    case MO_Q:
+    case MO_UQ:
         if (TCG_TARGET_REG_BITS =3D=3D 64) {
             tcg_out_modrm_sib_offset(s, movop + P_REXW + seg, datalo,
                                      base, index, 0, ofs);
@@ -2181,7 +2181,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
Reg datalo, TCGReg datahi,
         }
         tcg_out_modrm_sib_offset(s, movop + seg, datalo, base, index, 0, o=
fs);
         break;
-    case MO_64:
+    case MO_UQ:
         if (TCG_TARGET_REG_BITS =3D=3D 64) {
             if (bswap) {
                 tcg_out_mov(s, TCG_TYPE_I64, scratch, datalo);
@@ -2755,7 +2755,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode o=
pc,
         OPC_UD2, OPC_UD2, OPC_VPSRLVD, OPC_VPSRLVQ
     };
     static int const sarv_insn[4] =3D {
-        /* TODO: AVX512 adds support for MO_UW, MO_64.  */
+        /* TODO: AVX512 adds support for MO_UW, MO_UQ.  */
         OPC_UD2, OPC_UD2, OPC_VPSRAVD, OPC_UD2
     };
     static int const shls_insn[4] =3D {
@@ -2768,7 +2768,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode o=
pc,
         OPC_UD2, OPC_PSRAW, OPC_PSRAD, OPC_UD2
     };
     static int const abs_insn[4] =3D {
-        /* TODO: AVX512 adds support for MO_64.  */
+        /* TODO: AVX512 adds support for MO_UQ.  */
         OPC_PABSB, OPC_PABSW, OPC_PABSD, OPC_UD2
     };

@@ -2898,7 +2898,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode o=
pc,
         sub =3D 2;
         goto gen_shift;
     case INDEX_op_sari_vec:
-        tcg_debug_assert(vece !=3D MO_64);
+        tcg_debug_assert(vece !=3D MO_UQ);
         sub =3D 4;
     gen_shift:
         tcg_debug_assert(vece !=3D MO_UB);
@@ -3281,9 +3281,11 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type,=
 unsigned vece)
         if (vece =3D=3D MO_UB) {
             return -1;
         }
-        /* We can emulate this for MO_64, but it does not pay off
-           unless we're producing at least 4 values.  */
-        if (vece =3D=3D MO_64) {
+        /*
+         * We can emulate this for MO_UQ, but it does not pay off
+         * unless we're producing at least 4 values.
+         */
+        if (vece =3D=3D MO_UQ) {
             return type >=3D TCG_TYPE_V256 ? -1 : 0;
         }
         return 1;
@@ -3305,7 +3307,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, =
unsigned vece)
             /* We can expand the operation for MO_UB.  */
             return -1;
         }
-        if (vece =3D=3D MO_64) {
+        if (vece =3D=3D MO_UQ) {
             return 0;
         }
         return 1;
@@ -3389,7 +3391,7 @@ static void expand_vec_sari(TCGType type, unsigned ve=
ce,
         tcg_temp_free_vec(t2);
         break;

-    case MO_64:
+    case MO_UQ:
         if (imm <=3D 32) {
             /* We can emulate a small sign extend by performing an arithme=
tic
              * 32-bit shift and overwriting the high half of a 64-bit logi=
cal
@@ -3397,7 +3399,7 @@ static void expand_vec_sari(TCGType type, unsigned ve=
ce,
              */
             t1 =3D tcg_temp_new_vec(type);
             tcg_gen_sari_vec(MO_UL, t1, v1, imm);
-            tcg_gen_shri_vec(MO_64, v0, v1, imm);
+            tcg_gen_shri_vec(MO_UQ, v0, v1, imm);
             vec_gen_4(INDEX_op_x86_blend_vec, type, MO_UL,
                       tcgv_vec_arg(v0), tcgv_vec_arg(v0),
                       tcgv_vec_arg(t1), 0xaa);
@@ -3407,10 +3409,10 @@ static void expand_vec_sari(TCGType type, unsigned =
vece,
              * the sign-extend, shift and merge.
              */
             t1 =3D tcg_const_zeros_vec(type);
-            tcg_gen_cmp_vec(TCG_COND_GT, MO_64, t1, t1, v1);
-            tcg_gen_shri_vec(MO_64, v0, v1, imm);
-            tcg_gen_shli_vec(MO_64, t1, t1, 64 - imm);
-            tcg_gen_or_vec(MO_64, v0, v0, t1);
+            tcg_gen_cmp_vec(TCG_COND_GT, MO_UQ, t1, t1, v1);
+            tcg_gen_shri_vec(MO_UQ, v0, v1, imm);
+            tcg_gen_shli_vec(MO_UQ, t1, t1, 64 - imm);
+            tcg_gen_or_vec(MO_UQ, v0, v0, t1);
             tcg_temp_free_vec(t1);
         }
         break;
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index a78fe87..ef31fc8 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1336,7 +1336,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
     tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_AREG0);

     v0 =3D l->datalo_reg;
-    if (TCG_TARGET_REG_BITS =3D=3D 32 && (opc & MO_SIZE) =3D=3D MO_64) {
+    if (TCG_TARGET_REG_BITS =3D=3D 32 && (opc & MO_SIZE) =3D=3D MO_UQ) {
         /* We eliminated V0 from the possible output registers, so it
            cannot be clobbered here.  So we must move V1 first.  */
         if (MIPS_BE) {
@@ -1389,7 +1389,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
     case MO_UL:
         i =3D tcg_out_call_iarg_reg(s, i, l->datalo_reg);
         break;
-    case MO_64:
+    case MO_UQ:
         if (TCG_TARGET_REG_BITS =3D=3D 32) {
             i =3D tcg_out_call_iarg_reg2(s, i, l->datalo_reg, l->datahi_re=
g);
         } else {
@@ -1470,7 +1470,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCG=
Reg lo, TCGReg hi,
     case MO_SL:
         tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
         break;
-    case MO_Q | MO_BSWAP:
+    case MO_UQ | MO_BSWAP:
         if (TCG_TARGET_REG_BITS =3D=3D 64) {
             if (use_mips32r2_instructions) {
                 tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
@@ -1499,7 +1499,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCG=
Reg lo, TCGReg hi,
             tcg_out_mov(s, TCG_TYPE_I32, MIPS_BE ? hi : lo, TCG_TMP3);
         }
         break;
-    case MO_Q:
+    case MO_UQ:
         /* Prefer to load from offset 0 first, but allow for overlap.  */
         if (TCG_TARGET_REG_BITS =3D=3D 64) {
             tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
@@ -1587,7 +1587,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
Reg lo, TCGReg hi,
         tcg_out_opc_imm(s, OPC_SW, lo, base, 0);
         break;

-    case MO_64 | MO_BSWAP:
+    case MO_UQ | MO_BSWAP:
         if (TCG_TARGET_REG_BITS =3D=3D 64) {
             tcg_out_bswap64(s, TCG_TMP3, lo);
             tcg_out_opc_imm(s, OPC_SD, TCG_TMP3, base, 0);
@@ -1605,7 +1605,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
Reg lo, TCGReg hi,
             tcg_out_opc_imm(s, OPC_SW, TCG_TMP3, base, 4);
         }
         break;
-    case MO_64:
+    case MO_UQ:
         if (TCG_TARGET_REG_BITS =3D=3D 64) {
             tcg_out_opc_imm(s, OPC_SD, lo, base, 0);
         } else {
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 835336a..13a2437 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1445,24 +1445,24 @@ static const uint32_t qemu_ldx_opc[16] =3D {
     [MO_UB] =3D LBZX,
     [MO_UW] =3D LHZX,
     [MO_UL] =3D LWZX,
-    [MO_Q]  =3D LDX,
+    [MO_UQ]  =3D LDX,
     [MO_SW] =3D LHAX,
     [MO_SL] =3D LWAX,
     [MO_BSWAP | MO_UB] =3D LBZX,
     [MO_BSWAP | MO_UW] =3D LHBRX,
     [MO_BSWAP | MO_UL] =3D LWBRX,
-    [MO_BSWAP | MO_Q]  =3D LDBRX,
+    [MO_BSWAP | MO_UQ]  =3D LDBRX,
 };

 static const uint32_t qemu_stx_opc[16] =3D {
     [MO_UB] =3D STBX,
     [MO_UW] =3D STHX,
     [MO_UL] =3D STWX,
-    [MO_Q]  =3D STDX,
+    [MO_UQ]  =3D STDX,
     [MO_BSWAP | MO_UB] =3D STBX,
     [MO_BSWAP | MO_UW] =3D STHBRX,
     [MO_BSWAP | MO_UL] =3D STWBRX,
-    [MO_BSWAP | MO_Q]  =3D STDBRX,
+    [MO_BSWAP | MO_UQ]  =3D STDBRX,
 };

 static const uint32_t qemu_exts_opc[4] =3D {
@@ -1663,7 +1663,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)

     lo =3D lb->datalo_reg;
     hi =3D lb->datahi_reg;
-    if (TCG_TARGET_REG_BITS =3D=3D 32 && (opc & MO_SIZE) =3D=3D MO_64) {
+    if (TCG_TARGET_REG_BITS =3D=3D 32 && (opc & MO_SIZE) =3D=3D MO_UQ) {
         tcg_out_mov(s, TCG_TYPE_I32, lo, TCG_REG_R4);
         tcg_out_mov(s, TCG_TYPE_I32, hi, TCG_REG_R3);
     } else if (opc & MO_SIGN) {
@@ -1708,7 +1708,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
     hi =3D lb->datahi_reg;
     if (TCG_TARGET_REG_BITS =3D=3D 32) {
         switch (s_bits) {
-        case MO_64:
+        case MO_UQ:
 #ifdef TCG_TARGET_CALL_ALIGN_ARGS
             arg |=3D 1;
 #endif
@@ -1722,7 +1722,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
             break;
         }
     } else {
-        if (s_bits =3D=3D MO_64) {
+        if (s_bits =3D=3D MO_UQ) {
             tcg_out_mov(s, TCG_TYPE_I64, arg++, lo);
         } else {
             tcg_out_rld(s, RLDICL, arg++, lo, 0, 64 - (8 << s_bits));
@@ -1775,7 +1775,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is_64)
     }
 #endif

-    if (TCG_TARGET_REG_BITS =3D=3D 32 && s_bits =3D=3D MO_64) {
+    if (TCG_TARGET_REG_BITS =3D=3D 32 && s_bits =3D=3D MO_UQ) {
         if (opc & MO_BSWAP) {
             tcg_out32(s, ADDI | TAI(TCG_REG_R0, addrlo, 4));
             tcg_out32(s, LWBRX | TAB(datalo, rbase, addrlo));
@@ -1850,7 +1850,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is_64)
     }
 #endif

-    if (TCG_TARGET_REG_BITS =3D=3D 32 && s_bits =3D=3D MO_64) {
+    if (TCG_TARGET_REG_BITS =3D=3D 32 && s_bits =3D=3D MO_UQ) {
         if (opc & MO_BSWAP) {
             tcg_out32(s, ADDI | TAI(TCG_REG_R0, addrlo, 4));
             tcg_out32(s, STWBRX | SAB(datalo, rbase, addrlo));
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 1905986..90363df 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1068,7 +1068,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
     tcg_out_movi(s, TCG_TYPE_PTR, a3, (tcg_target_long)l->raddr);

     tcg_out_call(s, qemu_ld_helpers[opc & (MO_BSWAP | MO_SSIZE)]);
-    tcg_out_mov(s, (opc & MO_SIZE) =3D=3D MO_64, l->datalo_reg, a0);
+    tcg_out_mov(s, (opc & MO_SIZE) =3D=3D MO_UQ, l->datalo_reg, a0);

     tcg_out_goto(s, l->raddr);
     return true;
@@ -1150,7 +1150,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCG=
Reg lo, TCGReg hi,
     case MO_SL:
         tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
         break;
-    case MO_Q:
+    case MO_UQ:
         /* Prefer to load from offset 0 first, but allow for overlap.  */
         if (TCG_TARGET_REG_BITS =3D=3D 64) {
             tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
@@ -1225,7 +1225,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
Reg lo, TCGReg hi,
     case MO_UL:
         tcg_out_opc_store(s, OPC_SW, base, lo, 0);
         break;
-    case MO_64:
+    case MO_UQ:
         if (TCG_TARGET_REG_BITS =3D=3D 64) {
             tcg_out_opc_store(s, OPC_SD, base, lo, 0);
         } else {
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index fe42939..db1102e 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -1477,10 +1477,10 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, T=
CGMemOp opc, TCGReg data,
         tcg_out_insn(s, RXY, LGF, data, base, index, disp);
         break;

-    case MO_Q | MO_BSWAP:
+    case MO_UQ | MO_BSWAP:
         tcg_out_insn(s, RXY, LRVG, data, base, index, disp);
         break;
-    case MO_Q:
+    case MO_UQ:
         tcg_out_insn(s, RXY, LG, data, base, index, disp);
         break;

@@ -1523,10 +1523,10 @@ static void tcg_out_qemu_st_direct(TCGContext *s, T=
CGMemOp opc, TCGReg data,
         }
         break;

-    case MO_Q | MO_BSWAP:
+    case MO_UQ | MO_BSWAP:
         tcg_out_insn(s, RXY, STRVG, data, base, index, disp);
         break;
-    case MO_Q:
+    case MO_UQ:
         tcg_out_insn(s, RXY, STG, data, base, index, disp);
         break;

@@ -1660,7 +1660,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
     case MO_UL:
         tgen_ext32u(s, TCG_REG_R4, data_reg);
         break;
-    case MO_Q:
+    case MO_UQ:
         tcg_out_mov(s, TCG_TYPE_I64, TCG_REG_R4, data_reg);
         break;
     default:
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index ac0d3a3..7c50118 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -894,7 +894,7 @@ static void emit_extend(TCGContext *s, TCGReg r, int op=
)
             tcg_out_arith(s, r, r, 0, SHIFT_SRL);
         }
         break;
-    case MO_64:
+    case MO_UQ:
         break;
     }
 }
@@ -977,7 +977,7 @@ static void build_trampolines(TCGContext *s)
             } else {
                 ra +=3D 1;
             }
-            if ((i & MO_SIZE) =3D=3D MO_64) {
+            if ((i & MO_SIZE) =3D=3D MO_UQ) {
                 /* Install the high part of the data.  */
                 tcg_out_arithi(s, ra, ra + 1, 32, SHIFT_SRLX);
                 ra +=3D 2;
@@ -1217,7 +1217,7 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg dat=
a, TCGReg addr,
             tcg_out_mov(s, TCG_TYPE_REG, data, TCG_REG_O0);
         }
     } else {
-        if ((memop & MO_SIZE) =3D=3D MO_64) {
+        if ((memop & MO_SIZE) =3D=3D MO_UQ) {
             tcg_out_arithi(s, TCG_REG_O0, TCG_REG_O0, 32, SHIFT_SLLX);
             tcg_out_arithi(s, TCG_REG_O1, TCG_REG_O1, 0, SHIFT_SRL);
             tcg_out_arith(s, data, TCG_REG_O0, TCG_REG_O1, ARITH_OR);
@@ -1274,7 +1274,7 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg dat=
a, TCGReg addr,
         param++;
     }
     tcg_out_mov(s, TCG_TYPE_REG, param++, addrz);
-    if (!SPARC64 && (memop & MO_SIZE) =3D=3D MO_64) {
+    if (!SPARC64 && (memop & MO_SIZE) =3D=3D MO_UQ) {
         /* Skip the high-part; we'll perform the extract in the trampoline=
.  */
         param++;
     }
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index e63622c..0c0eea5 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -312,7 +312,7 @@ uint64_t (dup_const)(unsigned vece, uint64_t c)
         return 0x0001000100010001ull * (uint16_t)c;
     case MO_UL:
         return 0x0000000100000001ull * (uint32_t)c;
-    case MO_64:
+    case MO_UQ:
         return c;
     default:
         g_assert_not_reached();
@@ -352,7 +352,7 @@ static void gen_dup_i64(unsigned vece, TCGv_i64 out, TC=
Gv_i64 in)
     case MO_UL:
         tcg_gen_deposit_i64(out, in, in, 32, 32);
         break;
-    case MO_64:
+    case MO_UQ:
         tcg_gen_mov_i64(out, in);
         break;
     default:
@@ -443,7 +443,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32=
_t oprsz,
     TCGv_ptr t_ptr;
     uint32_t i;

-    assert(vece <=3D (in_32 ? MO_UL : MO_64));
+    assert(vece <=3D (in_32 ? MO_UL : MO_UQ));
     assert(in_32 =3D=3D NULL || in_64 =3D=3D NULL);

     /* If we're storing 0, expand oprsz to maxsz.  */
@@ -459,7 +459,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32=
_t oprsz,
      */
     type =3D choose_vector_type(NULL, vece, oprsz,
                               (TCG_TARGET_REG_BITS =3D=3D 64 && in_32 =3D=
=3D NULL
-                               && (in_64 =3D=3D NULL || vece =3D=3D MO_64)=
));
+                               && (in_64 =3D=3D NULL || vece =3D=3D MO_UQ)=
));
     if (type !=3D 0) {
         TCGv_vec t_vec =3D tcg_temp_new_vec(type);

@@ -502,7 +502,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32=
_t oprsz,
             /* For 64-bit hosts, use 64-bit constants for "simple" constan=
ts
                or when we'd need too many 32-bit stores, or when a 64-bit
                constant is really required.  */
-            if (vece =3D=3D MO_64
+            if (vece =3D=3D MO_UQ
                 || (TCG_TARGET_REG_BITS =3D=3D 64
                     && (in_c =3D=3D 0 || in_c =3D=3D -1
                         || !check_size_impl(oprsz, 4)))) {
@@ -534,7 +534,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32=
_t oprsz,
     tcg_gen_addi_ptr(t_ptr, cpu_env, dofs);
     t_desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, 0));

-    if (vece =3D=3D MO_64) {
+    if (vece =3D=3D MO_UQ) {
         if (in_64) {
             gen_helper_gvec_dup64(t_ptr, t_desc, in_64);
         } else {
@@ -1438,7 +1438,7 @@ void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dof=
s, uint32_t oprsz,
                           uint32_t maxsz, TCGv_i64 in)
 {
     check_size_align(oprsz, maxsz, dofs);
-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);
 }

@@ -1446,7 +1446,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dof=
s, uint32_t aofs,
                           uint32_t oprsz, uint32_t maxsz)
 {
     check_size_align(oprsz, maxsz, dofs);
-    if (vece <=3D MO_64) {
+    if (vece <=3D MO_UQ) {
         TCGType type =3D choose_vector_type(NULL, vece, oprsz, 0);
         if (type !=3D 0) {
             TCGv_vec t_vec =3D tcg_temp_new_vec(type);
@@ -1512,7 +1512,7 @@ void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t oprs=
z,
                          uint32_t maxsz, uint64_t x)
 {
     check_size_align(oprsz, maxsz, dofs);
-    do_dup(MO_64, dofs, oprsz, maxsz, NULL, NULL, x);
+    do_dup(MO_UQ, dofs, oprsz, maxsz, NULL, NULL, x);
 }

 void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t oprsz,
@@ -1624,10 +1624,10 @@ void tcg_gen_gvec_add(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
           .fno =3D gen_helper_gvec_add64,
           .opt_opc =3D vecop_list_add,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }

@@ -1655,10 +1655,10 @@ void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs=
, uint32_t aofs,
           .fno =3D gen_helper_gvec_adds64,
           .opt_opc =3D vecop_list_add,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g[vece]);
 }

@@ -1696,10 +1696,10 @@ void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs=
, uint32_t aofs,
           .fno =3D gen_helper_gvec_subs64,
           .opt_opc =3D vecop_list_sub,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g[vece]);
 }

@@ -1775,10 +1775,10 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
           .fno =3D gen_helper_gvec_sub64,
           .opt_opc =3D vecop_list_sub,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }

@@ -1806,10 +1806,10 @@ void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
           .fno =3D gen_helper_gvec_mul64,
           .opt_opc =3D vecop_list_mul,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }

@@ -1835,10 +1835,10 @@ void tcg_gen_gvec_muls(unsigned vece, uint32_t dofs=
, uint32_t aofs,
           .fno =3D gen_helper_gvec_muls64,
           .opt_opc =3D vecop_list_mul,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g[vece]);
 }

@@ -1870,9 +1870,9 @@ void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
         { .fniv =3D tcg_gen_ssadd_vec,
           .fno =3D gen_helper_gvec_ssadd64,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };
-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }

@@ -1896,9 +1896,9 @@ void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
         { .fniv =3D tcg_gen_sssub_vec,
           .fno =3D gen_helper_gvec_sssub64,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };
-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }

@@ -1940,9 +1940,9 @@ void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
           .fniv =3D tcg_gen_usadd_vec,
           .fno =3D gen_helper_gvec_usadd64,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_64 }
+          .vece =3D MO_UQ }
     };
-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }

@@ -1984,9 +1984,9 @@ void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
           .fniv =3D tcg_gen_ussub_vec,
           .fno =3D gen_helper_gvec_ussub64,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_64 }
+          .vece =3D MO_UQ }
     };
-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }

@@ -2012,9 +2012,9 @@ void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_smin_vec,
           .fno =3D gen_helper_gvec_smin64,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_64 }
+          .vece =3D MO_UQ }
     };
-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }

@@ -2040,9 +2040,9 @@ void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_umin_vec,
           .fno =3D gen_helper_gvec_umin64,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_64 }
+          .vece =3D MO_UQ }
     };
-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }

@@ -2068,9 +2068,9 @@ void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_smax_vec,
           .fno =3D gen_helper_gvec_smax64,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_64 }
+          .vece =3D MO_UQ }
     };
-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }

@@ -2096,9 +2096,9 @@ void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, =
uint32_t aofs,
           .fniv =3D tcg_gen_umax_vec,
           .fno =3D gen_helper_gvec_umax64,
           .opt_opc =3D vecop_list,
-          .vece =3D MO_64 }
+          .vece =3D MO_UQ }
     };
-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }

@@ -2171,10 +2171,10 @@ void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
           .fno =3D gen_helper_gvec_neg64,
           .opt_opc =3D vecop_list,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g[vece]);
 }

@@ -2234,10 +2234,10 @@ void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
           .fno =3D gen_helper_gvec_abs64,
           .opt_opc =3D vecop_list,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g[vece]);
 }

@@ -2382,7 +2382,7 @@ static const GVecGen2s gop_ands =3D {
     .fniv =3D tcg_gen_and_vec,
     .fno =3D gen_helper_gvec_ands,
     .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    .vece =3D MO_64
+    .vece =3D MO_UQ
 };

 void tcg_gen_gvec_ands(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -2407,7 +2407,7 @@ static const GVecGen2s gop_xors =3D {
     .fniv =3D tcg_gen_xor_vec,
     .fno =3D gen_helper_gvec_xors,
     .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    .vece =3D MO_64
+    .vece =3D MO_UQ
 };

 void tcg_gen_gvec_xors(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -2432,7 +2432,7 @@ static const GVecGen2s gop_ors =3D {
     .fniv =3D tcg_gen_or_vec,
     .fno =3D gen_helper_gvec_ors,
     .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    .vece =3D MO_64
+    .vece =3D MO_UQ
 };

 void tcg_gen_gvec_ors(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -2491,10 +2491,10 @@ void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs=
, uint32_t aofs,
           .fno =3D gen_helper_gvec_shl64i,
           .opt_opc =3D vecop_list,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));
     if (shift =3D=3D 0) {
         tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
@@ -2542,10 +2542,10 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs=
, uint32_t aofs,
           .fno =3D gen_helper_gvec_shr64i,
           .opt_opc =3D vecop_list,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));
     if (shift =3D=3D 0) {
         tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
@@ -2607,10 +2607,10 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs=
, uint32_t aofs,
           .fno =3D gen_helper_gvec_sar64i,
           .opt_opc =3D vecop_list,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));
     if (shift =3D=3D 0) {
         tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
@@ -2660,7 +2660,7 @@ do_gvec_shifts(unsigned vece, uint32_t dofs, uint32_t=
 aofs, TCGv_i32 shift,
     check_overlap_2(dofs, aofs, maxsz);

     /* If the backend has a scalar expansion, great.  */
-    type =3D choose_vector_type(g->s_list, vece, oprsz, vece =3D=3D MO_64)=
;
+    type =3D choose_vector_type(g->s_list, vece, oprsz, vece =3D=3D MO_UQ)=
;
     if (type) {
         const TCGOpcode *hold_list =3D tcg_swap_vecop_list(NULL);
         switch (type) {
@@ -2692,15 +2692,15 @@ do_gvec_shifts(unsigned vece, uint32_t dofs, uint32=
_t aofs, TCGv_i32 shift,
     }

     /* If the backend supports variable vector shifts, also cool.  */
-    type =3D choose_vector_type(g->v_list, vece, oprsz, vece =3D=3D MO_64)=
;
+    type =3D choose_vector_type(g->v_list, vece, oprsz, vece =3D=3D MO_UQ)=
;
     if (type) {
         const TCGOpcode *hold_list =3D tcg_swap_vecop_list(NULL);
         TCGv_vec v_shift =3D tcg_temp_new_vec(type);

-        if (vece =3D=3D MO_64) {
+        if (vece =3D=3D MO_UQ) {
             TCGv_i64 sh64 =3D tcg_temp_new_i64();
             tcg_gen_extu_i32_i64(sh64, shift);
-            tcg_gen_dup_i64_vec(MO_64, v_shift, sh64);
+            tcg_gen_dup_i64_vec(MO_UQ, v_shift, sh64);
             tcg_temp_free_i64(sh64);
         } else {
             tcg_gen_dup_i32_vec(vece, v_shift, shift);
@@ -2738,7 +2738,7 @@ do_gvec_shifts(unsigned vece, uint32_t dofs, uint32_t=
 aofs, TCGv_i32 shift,
     /* Otherwise fall back to integral... */
     if (vece =3D=3D MO_UL && check_size_impl(oprsz, 4)) {
         expand_2s_i32(dofs, aofs, oprsz, shift, false, g->fni4);
-    } else if (vece =3D=3D MO_64 && check_size_impl(oprsz, 8)) {
+    } else if (vece =3D=3D MO_UQ && check_size_impl(oprsz, 8)) {
         TCGv_i64 sh64 =3D tcg_temp_new_i64();
         tcg_gen_extu_i32_i64(sh64, shift);
         expand_2s_i64(dofs, aofs, oprsz, sh64, false, g->fni8);
@@ -2785,7 +2785,7 @@ void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         .v_list =3D { INDEX_op_shlv_vec, 0 },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);
 }

@@ -2807,7 +2807,7 @@ void tcg_gen_gvec_shrs(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         .v_list =3D { INDEX_op_shrv_vec, 0 },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);
 }

@@ -2829,7 +2829,7 @@ void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, =
uint32_t aofs,
         .v_list =3D { INDEX_op_sarv_vec, 0 },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);
 }

@@ -2895,10 +2895,10 @@ void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs=
, uint32_t aofs,
           .fno =3D gen_helper_gvec_shl64v,
           .opt_opc =3D vecop_list,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }

@@ -2958,10 +2958,10 @@ void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs=
, uint32_t aofs,
           .fno =3D gen_helper_gvec_shr64v,
           .opt_opc =3D vecop_list,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }

@@ -3021,10 +3021,10 @@ void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs=
, uint32_t aofs,
           .fno =3D gen_helper_gvec_sar64v,
           .opt_opc =3D vecop_list,
           .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-          .vece =3D MO_64 },
+          .vece =3D MO_UQ },
     };

-    tcg_debug_assert(vece <=3D MO_64);
+    tcg_debug_assert(vece <=3D MO_UQ);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }

@@ -3140,7 +3140,7 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, ui=
nt32_t dofs,
      */
     hold_list =3D tcg_swap_vecop_list(cmp_list);
     type =3D choose_vector_type(cmp_list, vece, oprsz,
-                              TCG_TARGET_REG_BITS =3D=3D 64 && vece =3D=3D=
 MO_64);
+                              TCG_TARGET_REG_BITS =3D=3D 64 && vece =3D=3D=
 MO_UQ);
     switch (type) {
     case TCG_TYPE_V256:
         /* Recall that ARM SVE allows vector sizes that are not a
@@ -3166,7 +3166,7 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, ui=
nt32_t dofs,
         break;

     case 0:
-        if (vece =3D=3D MO_64 && check_size_impl(oprsz, 8)) {
+        if (vece =3D=3D MO_UQ && check_size_impl(oprsz, 8)) {
             expand_cmp_i64(dofs, aofs, bofs, oprsz, cond);
         } else if (vece =3D=3D MO_UL && check_size_impl(oprsz, 4)) {
             expand_cmp_i32(dofs, aofs, bofs, oprsz, cond);
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index ff723ab..e8aea38 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -216,7 +216,7 @@ void tcg_gen_mov_vec(TCGv_vec r, TCGv_vec a)
     }
 }

-#define MO_REG  (TCG_TARGET_REG_BITS =3D=3D 64 ? MO_64 : MO_UL)
+#define MO_REG  (TCG_TARGET_REG_BITS =3D=3D 64 ? MO_UQ : MO_UL)

 static void do_dupi_vec(TCGv_vec r, unsigned vece, TCGArg a)
 {
@@ -255,10 +255,10 @@ void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)
     if (TCG_TARGET_REG_BITS =3D=3D 32 && a =3D=3D deposit64(a, 32, 32, a))=
 {
         do_dupi_vec(r, MO_UL, a);
     } else if (TCG_TARGET_REG_BITS =3D=3D 64 || a =3D=3D (uint64_t)(int32_=
t)a) {
-        do_dupi_vec(r, MO_64, a);
+        do_dupi_vec(r, MO_UQ, a);
     } else {
         TCGv_i64 c =3D tcg_const_i64(a);
-        tcg_gen_dup_i64_vec(MO_64, r, c);
+        tcg_gen_dup_i64_vec(MO_UQ, r, c);
         tcg_temp_free_i64(c);
     }
 }
@@ -292,10 +292,10 @@ void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, T=
CGv_i64 a)
     if (TCG_TARGET_REG_BITS =3D=3D 64) {
         TCGArg ai =3D tcgv_i64_arg(a);
         vec_gen_2(INDEX_op_dup_vec, type, vece, ri, ai);
-    } else if (vece =3D=3D MO_64) {
+    } else if (vece =3D=3D MO_UQ) {
         TCGArg al =3D tcgv_i32_arg(TCGV_LOW(a));
         TCGArg ah =3D tcgv_i32_arg(TCGV_HIGH(a));
-        vec_gen_3(INDEX_op_dup2_vec, type, MO_64, ri, al, ah);
+        vec_gen_3(INDEX_op_dup2_vec, type, MO_UQ, ri, al, ah);
     } else {
         TCGArg ai =3D tcgv_i32_arg(TCGV_LOW(a));
         vec_gen_2(INDEX_op_dup_vec, type, vece, ri, ai);
@@ -709,10 +709,10 @@ static void do_shifts(unsigned vece, TCGv_vec r, TCGv=
_vec a,
     } else {
         TCGv_vec vec_s =3D tcg_temp_new_vec(type);

-        if (vece =3D=3D MO_64) {
+        if (vece =3D=3D MO_UQ) {
             TCGv_i64 s64 =3D tcg_temp_new_i64();
             tcg_gen_extu_i32_i64(s64, s);
-            tcg_gen_dup_i64_vec(MO_64, vec_s, s64);
+            tcg_gen_dup_i64_vec(MO_UQ, vec_s, s64);
             tcg_temp_free_i64(s64);
         } else {
             tcg_gen_dup_i32_vec(vece, vec_s, s);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 447683d..a9f3e13 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2730,7 +2730,7 @@ static inline TCGMemOp tcg_canonicalize_memop(TCGMemO=
p op, bool is64, bool st)
             op &=3D ~MO_SIGN;
         }
         break;
-    case MO_64:
+    case MO_UQ:
         if (!is64) {
             tcg_abort();
         }
@@ -2862,7 +2862,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
 {
     TCGMemOp orig_memop;

-    if (TCG_TARGET_REG_BITS =3D=3D 32 && (memop & MO_SIZE) < MO_64) {
+    if (TCG_TARGET_REG_BITS =3D=3D 32 && (memop & MO_SIZE) < MO_UQ) {
         tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
         if (memop & MO_SIGN) {
             tcg_gen_sari_i32(TCGV_HIGH(val), TCGV_LOW(val), 31);
@@ -2881,7 +2881,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         memop &=3D ~MO_BSWAP;
         /* The bswap primitive requires zero-extended input.  */
-        if ((memop & MO_SIGN) && (memop & MO_SIZE) < MO_64) {
+        if ((memop & MO_SIGN) && (memop & MO_SIZE) < MO_UQ) {
             memop &=3D ~MO_SIGN;
         }
     }
@@ -2902,7 +2902,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
                 tcg_gen_ext32s_i64(val, val);
             }
             break;
-        case MO_64:
+        case MO_UQ:
             tcg_gen_bswap64_i64(val, val);
             break;
         default:
@@ -2915,7 +2915,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
 {
     TCGv_i64 swap =3D NULL;

-    if (TCG_TARGET_REG_BITS =3D=3D 32 && (memop & MO_SIZE) < MO_64) {
+    if (TCG_TARGET_REG_BITS =3D=3D 32 && (memop & MO_SIZE) < MO_UQ) {
         tcg_gen_qemu_st_i32(TCGV_LOW(val), addr, idx, memop);
         return;
     }
@@ -2936,7 +2936,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
             tcg_gen_ext32u_i64(swap, val);
             tcg_gen_bswap32_i64(swap, swap);
             break;
-        case MO_64:
+        case MO_UQ:
             tcg_gen_bswap64_i64(swap, val);
             break;
         default:
@@ -3029,8 +3029,8 @@ static void * const table_cmpxchg[16] =3D {
     [MO_UW | MO_BE] =3D gen_helper_atomic_cmpxchgw_be,
     [MO_UL | MO_LE] =3D gen_helper_atomic_cmpxchgl_le,
     [MO_UL | MO_BE] =3D gen_helper_atomic_cmpxchgl_be,
-    WITH_ATOMIC64([MO_64 | MO_LE] =3D gen_helper_atomic_cmpxchgq_le)
-    WITH_ATOMIC64([MO_64 | MO_BE] =3D gen_helper_atomic_cmpxchgq_be)
+    WITH_ATOMIC64([MO_UQ | MO_LE] =3D gen_helper_atomic_cmpxchgq_le)
+    WITH_ATOMIC64([MO_UQ | MO_BE] =3D gen_helper_atomic_cmpxchgq_be)
 };

 void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
@@ -3099,7 +3099,7 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv a=
ddr, TCGv_i64 cmpv,
             tcg_gen_mov_i64(retv, t1);
         }
         tcg_temp_free_i64(t1);
-    } else if ((memop & MO_SIZE) =3D=3D MO_64) {
+    } else if ((memop & MO_SIZE) =3D=3D MO_UQ) {
 #ifdef CONFIG_ATOMIC64
         gen_atomic_cx_i64 gen;

@@ -3207,7 +3207,7 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr,=
 TCGv_i64 val,
 {
     memop =3D tcg_canonicalize_memop(memop, 1, 0);

-    if ((memop & MO_SIZE) =3D=3D MO_64) {
+    if ((memop & MO_SIZE) =3D=3D MO_UQ) {
 #ifdef CONFIG_ATOMIC64
         gen_atomic_op_i64 gen;

@@ -3253,8 +3253,8 @@ static void * const table_##NAME[16] =3D {           =
                     \
     [MO_UW | MO_BE] =3D gen_helper_atomic_##NAME##w_be,                   =
\
     [MO_UL | MO_LE] =3D gen_helper_atomic_##NAME##l_le,                   =
\
     [MO_UL | MO_BE] =3D gen_helper_atomic_##NAME##l_be,                   =
\
-    WITH_ATOMIC64([MO_64 | MO_LE] =3D gen_helper_atomic_##NAME##q_le)     =
\
-    WITH_ATOMIC64([MO_64 | MO_BE] =3D gen_helper_atomic_##NAME##q_be)     =
\
+    WITH_ATOMIC64([MO_UQ | MO_LE] =3D gen_helper_atomic_##NAME##q_le)     =
\
+    WITH_ATOMIC64([MO_UQ | MO_BE] =3D gen_helper_atomic_##NAME##q_be)     =
\
 };                                                                      \
 void tcg_gen_atomic_##NAME##_i32                                        \
     (TCGv_i32 ret, TCGv addr, TCGv_i32 val, TCGArg idx, TCGMemOp memop) \
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 4b6ee89..63e9897 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -371,28 +371,29 @@ typedef enum TCGMemOp {
     MO_UB    =3D MO_8,
     MO_UW    =3D MO_16,
     MO_UL    =3D MO_32,
+    MO_UQ    =3D MO_64,
     MO_SB    =3D MO_SIGN | MO_8,
     MO_SW    =3D MO_SIGN | MO_16,
     MO_SL    =3D MO_SIGN | MO_32,
-    MO_Q     =3D MO_64,
+    MO_SQ    =3D MO_SIGN | MO_64,

     MO_LEUW  =3D MO_LE | MO_UW,
     MO_LEUL  =3D MO_LE | MO_UL,
     MO_LESW  =3D MO_LE | MO_SW,
     MO_LESL  =3D MO_LE | MO_SL,
-    MO_LEQ   =3D MO_LE | MO_Q,
+    MO_LEQ   =3D MO_LE | MO_UQ,

     MO_BEUW  =3D MO_BE | MO_UW,
     MO_BEUL  =3D MO_BE | MO_UL,
     MO_BESW  =3D MO_BE | MO_SW,
     MO_BESL  =3D MO_BE | MO_SL,
-    MO_BEQ   =3D MO_BE | MO_Q,
+    MO_BEQ   =3D MO_BE | MO_UQ,

     MO_TEUW  =3D MO_TE | MO_UW,
     MO_TEUL  =3D MO_TE | MO_UL,
     MO_TESW  =3D MO_TE | MO_SW,
     MO_TESL  =3D MO_TE | MO_SL,
-    MO_TEQ   =3D MO_TE | MO_Q,
+    MO_TEQ   =3D MO_TE | MO_UQ,

     MO_SSIZE =3D MO_SIZE | MO_SIGN,
 } TCGMemOp;
--
1.8.3.1



