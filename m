Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B849C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7677208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7677208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnd3s-0001BM-3A
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 02:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hnd3Q-0000Sm-JF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hnd3H-00041X-FM
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:04:40 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.80]:23532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1hnd3G-00040I-Se
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:04:31 -0400
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 BWP09926085.bt.com (10.36.82.116) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Wed, 17
 Jul 2019 07:04:39 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18e.domain1.systemhost.net (10.9.212.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 17 Jul 2019 07:04:27 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Wed, 17 Jul
 2019 07:04:27 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 1/4] tcg: TCGMemOp is now accelerator
 independent MemOp
Thread-Index: AQHVPGV9FmWJ7D2TfEqNiYAUk5qJhA==
Date: Wed, 17 Jul 2019 06:04:27 +0000
Message-ID: <1563343465306.78816@bt.com>
References: <a5f7f8854af046c18c6342035662a193@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <a5f7f8854af046c18c6342035662a193@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.80
Subject: [Qemu-devel] [PATCH 1/4] tcg: TCGMemOp is now accelerator
 independent MemOp
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
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Preparation for collapsing the two byte swaps, adjust_endianness and=0A=
handle_bswap, along the I/O path.=0A=
=0A=
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>=0A=
---=0A=
 MAINTAINERS                             |   1 +=0A=
 accel/tcg/cputlb.c                      |   2 +-=0A=
 include/exec/memop.h                    | 103 ++++++++++++++++++=0A=
 target/alpha/translate.c                |   2 +-=0A=
 target/arm/translate-a64.c              |  48 ++++-----=0A=
 target/arm/translate-a64.h              |   2 +-=0A=
 target/arm/translate-sve.c              |   2 +-=0A=
 target/arm/translate.c                  |  32 +++---=0A=
 target/arm/translate.h                  |   2 +-=0A=
 target/hppa/translate.c                 |  14 +--=0A=
 target/i386/translate.c                 | 132 ++++++++++++------------=0A=
 target/m68k/translate.c                 |   2 +-=0A=
 target/microblaze/translate.c           |   4 +-=0A=
 target/mips/translate.c                 |   8 +-=0A=
 target/openrisc/translate.c             |   4 +-=0A=
 target/ppc/translate.c                  |  12 +--=0A=
 target/riscv/insn_trans/trans_rva.inc.c |   8 +-=0A=
 target/riscv/insn_trans/trans_rvi.inc.c |   4 +-=0A=
 target/s390x/translate.c                |   6 +-=0A=
 target/s390x/translate_vx.inc.c         |  10 +-=0A=
 target/sparc/translate.c                |  14 +--=0A=
 target/tilegx/translate.c               |  10 +-=0A=
 target/tricore/translate.c              |   8 +-=0A=
 tcg/README                              |   2 +-=0A=
 tcg/aarch64/tcg-target.inc.c            |  26 ++---=0A=
 tcg/arm/tcg-target.inc.c                |  26 ++---=0A=
 tcg/i386/tcg-target.inc.c               |  24 ++---=0A=
 tcg/mips/tcg-target.inc.c               |  16 +--=0A=
 tcg/optimize.c                          |   2 +-=0A=
 tcg/ppc/tcg-target.inc.c                |  12 +--=0A=
 tcg/riscv/tcg-target.inc.c              |  20 ++--=0A=
 tcg/s390/tcg-target.inc.c               |  14 +--=0A=
 tcg/sparc/tcg-target.inc.c              |   6 +-=0A=
 tcg/tcg-op.c                            |  38 +++----=0A=
 tcg/tcg-op.h                            |  86 +++++++--------=0A=
 tcg/tcg.c                               |   2 +-=0A=
 tcg/tcg.h                               |  99 ++----------------=0A=
 trace/mem-internal.h                    |   4 +-=0A=
 trace/mem.h                             |   4 +-=0A=
 39 files changed, 414 insertions(+), 397 deletions(-)=0A=
 create mode 100644 include/exec/memop.h=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index cc9636b43a..3f148cd52b 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -1890,6 +1890,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>=0A=
 S: Supported=0A=
 F: include/exec/ioport.h=0A=
 F: ioport.c=0A=
+F: include/exec/memop.h=0A=
 F: include/exec/memory.h=0A=
 F: include/exec/ram_addr.h=0A=
 F: memory.c=0A=
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c=0A=
index bb9897b25a..523be4c848 100644=0A=
--- a/accel/tcg/cputlb.c=0A=
+++ b/accel/tcg/cputlb.c=0A=
@@ -1133,7 +1133,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, tar=
get_ulong addr,=0A=
     uintptr_t index =3D tlb_index(env, mmu_idx, addr);=0A=
     CPUTLBEntry *tlbe =3D tlb_entry(env, mmu_idx, addr);=0A=
     target_ulong tlb_addr =3D tlb_addr_write(tlbe);=0A=
-    TCGMemOp mop =3D get_memop(oi);=0A=
+    MemOp mop =3D get_memop(oi);=0A=
     int a_bits =3D get_alignment_bits(mop);=0A=
     int s_bits =3D mop & MO_SIZE;=0A=
     void *hostaddr;=0A=
diff --git a/include/exec/memop.h b/include/exec/memop.h=0A=
new file mode 100644=0A=
index 0000000000..54a75053ae=0A=
--- /dev/null=0A=
+++ b/include/exec/memop.h=0A=
@@ -0,0 +1,103 @@=0A=
+/*=0A=
+ * Constants for memory operations=0A=
+ *=0A=
+ * Authors:=0A=
+ *  Richard Henderson <rth@twiddle.net>=0A=
+ *=0A=
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.=0A=
+ * See the COPYING file in the top-level directory.=0A=
+ *=0A=
+ */=0A=
+=0A=
+#ifndef MEMOP_H=0A=
+#define MEMOP_H=0A=
+=0A=
+typedef enum MemOp {=0A=
+    MO_8     =3D 0,=0A=
+    MO_16    =3D 1,=0A=
+    MO_32    =3D 2,=0A=
+    MO_64    =3D 3,=0A=
+    MO_SIZE  =3D 3,   /* Mask for the above.  */=0A=
+=0A=
+    MO_SIGN  =3D 4,   /* Sign-extended, otherwise zero-extended.  */=0A=
+=0A=
+    MO_BSWAP =3D 8,   /* Host reverse endian.  */=0A=
+#ifdef HOST_WORDS_BIGENDIAN=0A=
+    MO_LE    =3D MO_BSWAP,=0A=
+    MO_BE    =3D 0,=0A=
+#else=0A=
+    MO_LE    =3D 0,=0A=
+    MO_BE    =3D MO_BSWAP,=0A=
+#endif=0A=
+#ifdef TARGET_WORDS_BIGENDIAN=0A=
+    MO_TE    =3D MO_BE,=0A=
+#else=0A=
+    MO_TE    =3D MO_LE,=0A=
+#endif=0A=
+=0A=
+    /*=0A=
+     * MO_UNALN accesses are never checked for alignment.=0A=
+     * MO_ALIGN accesses will result in a call to the CPU's=0A=
+     * do_unaligned_access hook if the guest address is not aligned.=0A=
+     * The default depends on whether the target CPU defines ALIGNED_ONLY.=
=0A=
+     *=0A=
+     * Some architectures (e.g. ARMv8) need the address which is aligned=
=0A=
+     * to a size more than the size of the memory access.=0A=
+     * Some architectures (e.g. SPARCv9) need an address which is aligned,=
=0A=
+     * but less strictly than the natural alignment.=0A=
+     *=0A=
+     * MO_ALIGN supposes the alignment size is the size of a memory access=
.=0A=
+     *=0A=
+     * There are three options:=0A=
+     * - unaligned access permitted (MO_UNALN).=0A=
+     * - an alignment to the size of an access (MO_ALIGN);=0A=
+     * - an alignment to a specified size, which may be more or less than=
=0A=
+     *   the access size (MO_ALIGN_x where 'x' is a size in bytes);=0A=
+     */=0A=
+    MO_ASHIFT =3D 4,=0A=
+    MO_AMASK =3D 7 << MO_ASHIFT,=0A=
+#ifdef ALIGNED_ONLY=0A=
+    MO_ALIGN =3D 0,=0A=
+    MO_UNALN =3D MO_AMASK,=0A=
+#else=0A=
+    MO_ALIGN =3D MO_AMASK,=0A=
+    MO_UNALN =3D 0,=0A=
+#endif=0A=
+    MO_ALIGN_2  =3D 1 << MO_ASHIFT,=0A=
+    MO_ALIGN_4  =3D 2 << MO_ASHIFT,=0A=
+    MO_ALIGN_8  =3D 3 << MO_ASHIFT,=0A=
+    MO_ALIGN_16 =3D 4 << MO_ASHIFT,=0A=
+    MO_ALIGN_32 =3D 5 << MO_ASHIFT,=0A=
+    MO_ALIGN_64 =3D 6 << MO_ASHIFT,=0A=
+=0A=
+    /* Combinations of the above, for ease of use.  */=0A=
+    MO_UB    =3D MO_8,=0A=
+    MO_UW    =3D MO_16,=0A=
+    MO_UL    =3D MO_32,=0A=
+    MO_SB    =3D MO_SIGN | MO_8,=0A=
+    MO_SW    =3D MO_SIGN | MO_16,=0A=
+    MO_SL    =3D MO_SIGN | MO_32,=0A=
+    MO_Q     =3D MO_64,=0A=
+=0A=
+    MO_LEUW  =3D MO_LE | MO_UW,=0A=
+    MO_LEUL  =3D MO_LE | MO_UL,=0A=
+    MO_LESW  =3D MO_LE | MO_SW,=0A=
+    MO_LESL  =3D MO_LE | MO_SL,=0A=
+    MO_LEQ   =3D MO_LE | MO_Q,=0A=
+=0A=
+    MO_BEUW  =3D MO_BE | MO_UW,=0A=
+    MO_BEUL  =3D MO_BE | MO_UL,=0A=
+    MO_BESW  =3D MO_BE | MO_SW,=0A=
+    MO_BESL  =3D MO_BE | MO_SL,=0A=
+    MO_BEQ   =3D MO_BE | MO_Q,=0A=
+=0A=
+    MO_TEUW  =3D MO_TE | MO_UW,=0A=
+    MO_TEUL  =3D MO_TE | MO_UL,=0A=
+    MO_TESW  =3D MO_TE | MO_SW,=0A=
+    MO_TESL  =3D MO_TE | MO_SL,=0A=
+    MO_TEQ   =3D MO_TE | MO_Q,=0A=
+=0A=
+    MO_SSIZE =3D MO_SIZE | MO_SIGN,=0A=
+} MemOp;=0A=
+=0A=
+#endif=0A=
diff --git a/target/alpha/translate.c b/target/alpha/translate.c=0A=
index 2c9cccf6c1..d5d48882c6 100644=0A=
--- a/target/alpha/translate.c=0A=
+++ b/target/alpha/translate.c=0A=
@@ -403,7 +403,7 @@ static inline void gen_store_mem(DisasContext *ctx,=0A=
 =0A=
 static DisasJumpType gen_store_conditional(DisasContext *ctx, int ra, int =
rb,=0A=
                                            int32_t disp16, int mem_idx,=0A=
-                                           TCGMemOp op)=0A=
+                                           MemOp op)=0A=
 {=0A=
     TCGLabel *lab_fail, *lab_done;=0A=
     TCGv addr, val;=0A=
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c=0A=
index d3231477a2..b6c07d6cb2 100644=0A=
--- a/target/arm/translate-a64.c=0A=
+++ b/target/arm/translate-a64.c=0A=
@@ -85,7 +85,7 @@ typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);=0A=
 typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);=0A=
 typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);=0A=
 typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);=0A=
-typedef void AtomicThreeOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGArg, TCGMemO=
p);=0A=
+typedef void AtomicThreeOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGArg, MemOp);=
=0A=
 =0A=
 /* initialize TCG globals.  */=0A=
 void a64_translate_init(void)=0A=
@@ -455,7 +455,7 @@ TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int =
sf)=0A=
  * Dn, Sn, Hn or Bn).=0A=
  * (Note that this is not the same mapping as for A32; see cpu.h)=0A=
  */=0A=
-static inline int fp_reg_offset(DisasContext *s, int regno, TCGMemOp size)=
=0A=
+static inline int fp_reg_offset(DisasContext *s, int regno, MemOp size)=0A=
 {=0A=
     return vec_reg_offset(s, regno, 0, size);=0A=
 }=0A=
@@ -871,7 +871,7 @@ static void do_gpr_ld_memidx(DisasContext *s,=0A=
                              bool iss_valid, unsigned int iss_srt,=0A=
                              bool iss_sf, bool iss_ar)=0A=
 {=0A=
-    TCGMemOp memop =3D s->be_data + size;=0A=
+    MemOp memop =3D s->be_data + size;=0A=
 =0A=
     g_assert(size <=3D 3);=0A=
 =0A=
@@ -948,7 +948,7 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv=
_i64 tcg_addr, int size)=0A=
     TCGv_i64 tmphi;=0A=
 =0A=
     if (size < 4) {=0A=
-        TCGMemOp memop =3D s->be_data + size;=0A=
+        MemOp memop =3D s->be_data + size;=0A=
         tmphi =3D tcg_const_i64(0);=0A=
         tcg_gen_qemu_ld_i64(tmplo, tcg_addr, get_mem_index(s), memop);=0A=
     } else {=0A=
@@ -989,7 +989,7 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv=
_i64 tcg_addr, int size)=0A=
 =0A=
 /* Get value of an element within a vector register */=0A=
 static void read_vec_element(DisasContext *s, TCGv_i64 tcg_dest, int srcid=
x,=0A=
-                             int element, TCGMemOp memop)=0A=
+                             int element, MemOp memop)=0A=
 {=0A=
     int vect_off =3D vec_reg_offset(s, srcidx, element, memop & MO_SIZE);=
=0A=
     switch (memop) {=0A=
@@ -1021,7 +1021,7 @@ static void read_vec_element(DisasContext *s, TCGv_i6=
4 tcg_dest, int srcidx,=0A=
 }=0A=
 =0A=
 static void read_vec_element_i32(DisasContext *s, TCGv_i32 tcg_dest, int s=
rcidx,=0A=
-                                 int element, TCGMemOp memop)=0A=
+                                 int element, MemOp memop)=0A=
 {=0A=
     int vect_off =3D vec_reg_offset(s, srcidx, element, memop & MO_SIZE);=
=0A=
     switch (memop) {=0A=
@@ -1048,7 +1048,7 @@ static void read_vec_element_i32(DisasContext *s, TCG=
v_i32 tcg_dest, int srcidx,=0A=
 =0A=
 /* Set value of an element within a vector register */=0A=
 static void write_vec_element(DisasContext *s, TCGv_i64 tcg_src, int desti=
dx,=0A=
-                              int element, TCGMemOp memop)=0A=
+                              int element, MemOp memop)=0A=
 {=0A=
     int vect_off =3D vec_reg_offset(s, destidx, element, memop & MO_SIZE);=
=0A=
     switch (memop) {=0A=
@@ -1070,7 +1070,7 @@ static void write_vec_element(DisasContext *s, TCGv_i=
64 tcg_src, int destidx,=0A=
 }=0A=
 =0A=
 static void write_vec_element_i32(DisasContext *s, TCGv_i32 tcg_src,=0A=
-                                  int destidx, int element, TCGMemOp memop=
)=0A=
+                                  int destidx, int element, MemOp memop)=
=0A=
 {=0A=
     int vect_off =3D vec_reg_offset(s, destidx, element, memop & MO_SIZE);=
=0A=
     switch (memop) {=0A=
@@ -1090,7 +1090,7 @@ static void write_vec_element_i32(DisasContext *s, TC=
Gv_i32 tcg_src,=0A=
 =0A=
 /* Store from vector register to memory */=0A=
 static void do_vec_st(DisasContext *s, int srcidx, int element,=0A=
-                      TCGv_i64 tcg_addr, int size, TCGMemOp endian)=0A=
+                      TCGv_i64 tcg_addr, int size, MemOp endian)=0A=
 {=0A=
     TCGv_i64 tcg_tmp =3D tcg_temp_new_i64();=0A=
 =0A=
@@ -1102,7 +1102,7 @@ static void do_vec_st(DisasContext *s, int srcidx, in=
t element,=0A=
 =0A=
 /* Load from memory to vector register */=0A=
 static void do_vec_ld(DisasContext *s, int destidx, int element,=0A=
-                      TCGv_i64 tcg_addr, int size, TCGMemOp endian)=0A=
+                      TCGv_i64 tcg_addr, int size, MemOp endian)=0A=
 {=0A=
     TCGv_i64 tcg_tmp =3D tcg_temp_new_i64();=0A=
 =0A=
@@ -2200,7 +2200,7 @@ static void gen_load_exclusive(DisasContext *s, int r=
t, int rt2,=0A=
                                TCGv_i64 addr, int size, bool is_pair)=0A=
 {=0A=
     int idx =3D get_mem_index(s);=0A=
-    TCGMemOp memop =3D s->be_data;=0A=
+    MemOp memop =3D s->be_data;=0A=
 =0A=
     g_assert(size <=3D 3);=0A=
     if (is_pair) {=0A=
@@ -3286,7 +3286,7 @@ static void disas_ldst_multiple_struct(DisasContext *=
s, uint32_t insn)=0A=
     bool is_postidx =3D extract32(insn, 23, 1);=0A=
     bool is_q =3D extract32(insn, 30, 1);=0A=
     TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;=0A=
-    TCGMemOp endian =3D s->be_data;=0A=
+    MemOp endian =3D s->be_data;=0A=
 =0A=
     int ebytes;   /* bytes per element */=0A=
     int elements; /* elements per vector */=0A=
@@ -5455,7 +5455,7 @@ static void disas_fp_csel(DisasContext *s, uint32_t i=
nsn)=0A=
     unsigned int mos, type, rm, cond, rn, rd;=0A=
     TCGv_i64 t_true, t_false, t_zero;=0A=
     DisasCompare64 c;=0A=
-    TCGMemOp sz;=0A=
+    MemOp sz;=0A=
 =0A=
     mos =3D extract32(insn, 29, 3);=0A=
     type =3D extract32(insn, 22, 2);=0A=
@@ -6267,7 +6267,7 @@ static void disas_fp_imm(DisasContext *s, uint32_t in=
sn)=0A=
     int mos =3D extract32(insn, 29, 3);=0A=
     uint64_t imm;=0A=
     TCGv_i64 tcg_res;=0A=
-    TCGMemOp sz;=0A=
+    MemOp sz;=0A=
 =0A=
     if (mos || imm5) {=0A=
         unallocated_encoding(s);=0A=
@@ -7030,7 +7030,7 @@ static TCGv_i32 do_reduction_op(DisasContext *s, int =
fpopcode, int rn,=0A=
 {=0A=
     if (esize =3D=3D size) {=0A=
         int element;=0A=
-        TCGMemOp msize =3D esize =3D=3D 16 ? MO_16 : MO_32;=0A=
+        MemOp msize =3D esize =3D=3D 16 ? MO_16 : MO_32;=0A=
         TCGv_i32 tcg_elem;=0A=
 =0A=
         /* We should have one register left here */=0A=
@@ -8022,7 +8022,7 @@ static void handle_vec_simd_sqshrn(DisasContext *s, b=
ool is_scalar, bool is_q,=0A=
     int shift =3D (2 * esize) - immhb;=0A=
     int elements =3D is_scalar ? 1 : (64 / esize);=0A=
     bool round =3D extract32(opcode, 0, 1);=0A=
-    TCGMemOp ldop =3D (size + 1) | (is_u_shift ? 0 : MO_SIGN);=0A=
+    MemOp ldop =3D (size + 1) | (is_u_shift ? 0 : MO_SIGN);=0A=
     TCGv_i64 tcg_rn, tcg_rd, tcg_round;=0A=
     TCGv_i32 tcg_rd_narrowed;=0A=
     TCGv_i64 tcg_final;=0A=
@@ -8181,7 +8181,7 @@ static void handle_simd_qshl(DisasContext *s, bool sc=
alar, bool is_q,=0A=
             }=0A=
         };=0A=
         NeonGenTwoOpEnvFn *genfn =3D fns[src_unsigned][dst_unsigned][size]=
;=0A=
-        TCGMemOp memop =3D scalar ? size : MO_32;=0A=
+        MemOp memop =3D scalar ? size : MO_32;=0A=
         int maxpass =3D scalar ? 1 : is_q ? 4 : 2;=0A=
 =0A=
         for (pass =3D 0; pass < maxpass; pass++) {=0A=
@@ -8225,7 +8225,7 @@ static void handle_simd_intfp_conv(DisasContext *s, i=
nt rd, int rn,=0A=
     TCGv_ptr tcg_fpst =3D get_fpstatus_ptr(size =3D=3D MO_16);=0A=
     TCGv_i32 tcg_shift =3D NULL;=0A=
 =0A=
-    TCGMemOp mop =3D size | (is_signed ? MO_SIGN : 0);=0A=
+    MemOp mop =3D size | (is_signed ? MO_SIGN : 0);=0A=
     int pass;=0A=
 =0A=
     if (fracbits || size =3D=3D MO_64) {=0A=
@@ -10004,7 +10004,7 @@ static void handle_vec_simd_shri(DisasContext *s, b=
ool is_q, bool is_u,=0A=
     int dsize =3D is_q ? 128 : 64;=0A=
     int esize =3D 8 << size;=0A=
     int elements =3D dsize/esize;=0A=
-    TCGMemOp memop =3D size | (is_u ? 0 : MO_SIGN);=0A=
+    MemOp memop =3D size | (is_u ? 0 : MO_SIGN);=0A=
     TCGv_i64 tcg_rn =3D new_tmp_a64(s);=0A=
     TCGv_i64 tcg_rd =3D new_tmp_a64(s);=0A=
     TCGv_i64 tcg_round;=0A=
@@ -10347,7 +10347,7 @@ static void handle_3rd_widening(DisasContext *s, in=
t is_q, int is_u, int size,=0A=
             TCGv_i64 tcg_op1 =3D tcg_temp_new_i64();=0A=
             TCGv_i64 tcg_op2 =3D tcg_temp_new_i64();=0A=
             TCGv_i64 tcg_passres;=0A=
-            TCGMemOp memop =3D MO_32 | (is_u ? 0 : MO_SIGN);=0A=
+            MemOp memop =3D MO_32 | (is_u ? 0 : MO_SIGN);=0A=
 =0A=
             int elt =3D pass + is_q * 2;=0A=
 =0A=
@@ -11827,7 +11827,7 @@ static void handle_2misc_pairwise(DisasContext *s, =
int opcode, bool u,=0A=
 =0A=
     if (size =3D=3D 2) {=0A=
         /* 32 + 32 -> 64 op */=0A=
-        TCGMemOp memop =3D size + (u ? 0 : MO_SIGN);=0A=
+        MemOp memop =3D size + (u ? 0 : MO_SIGN);=0A=
 =0A=
         for (pass =3D 0; pass < maxpass; pass++) {=0A=
             TCGv_i64 tcg_op1 =3D tcg_temp_new_i64();=0A=
@@ -12849,7 +12849,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)=0A=
 =0A=
     switch (is_fp) {=0A=
     case 1: /* normal fp */=0A=
-        /* convert insn encoded size to TCGMemOp size */=0A=
+        /* convert insn encoded size to MemOp size */=0A=
         switch (size) {=0A=
         case 0: /* half-precision */=0A=
             size =3D MO_16;=0A=
@@ -12897,7 +12897,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)=0A=
         return;=0A=
     }=0A=
 =0A=
-    /* Given TCGMemOp size, adjust register and indexing.  */=0A=
+    /* Given MemOp size, adjust register and indexing.  */=0A=
     switch (size) {=0A=
     case MO_16:=0A=
         index =3D h << 2 | l << 1 | m;=0A=
@@ -13194,7 +13194,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)=0A=
         TCGv_i64 tcg_res[2];=0A=
         int pass;=0A=
         bool satop =3D extract32(opcode, 0, 1);=0A=
-        TCGMemOp memop =3D MO_32;=0A=
+        MemOp memop =3D MO_32;=0A=
 =0A=
         if (satop || !u) {=0A=
             memop |=3D MO_SIGN;=0A=
diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h=0A=
index 9ab40872d8..f1246b7013 100644=0A=
--- a/target/arm/translate-a64.h=0A=
+++ b/target/arm/translate-a64.h=0A=
@@ -64,7 +64,7 @@ static inline void assert_fp_access_checked(DisasContext =
*s)=0A=
  * the FP/vector register Qn.=0A=
  */=0A=
 static inline int vec_reg_offset(DisasContext *s, int regno,=0A=
-                                 int element, TCGMemOp size)=0A=
+                                 int element, MemOp size)=0A=
 {=0A=
     int element_size =3D 1 << size;=0A=
     int offs =3D element * element_size;=0A=
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c=0A=
index fa068b0e47..5d7edd0907 100644=0A=
--- a/target/arm/translate-sve.c=0A=
+++ b/target/arm/translate-sve.c=0A=
@@ -4567,7 +4567,7 @@ static bool trans_STR_pri(DisasContext *s, arg_rri *a=
)=0A=
  */=0A=
 =0A=
 /* The memory mode of the dtype.  */=0A=
-static const TCGMemOp dtype_mop[16] =3D {=0A=
+static const MemOp dtype_mop[16] =3D {=0A=
     MO_UB, MO_UB, MO_UB, MO_UB,=0A=
     MO_SL, MO_UW, MO_UW, MO_UW,=0A=
     MO_SW, MO_SW, MO_UL, MO_UL,=0A=
diff --git a/target/arm/translate.c b/target/arm/translate.c=0A=
index 7853462b21..d116c8cdf3 100644=0A=
--- a/target/arm/translate.c=0A=
+++ b/target/arm/translate.c=0A=
@@ -114,7 +114,7 @@ typedef enum ISSInfo {=0A=
 } ISSInfo;=0A=
 =0A=
 /* Save the syndrome information for a Data Abort */=0A=
-static void disas_set_da_iss(DisasContext *s, TCGMemOp memop, ISSInfo issi=
nfo)=0A=
+static void disas_set_da_iss(DisasContext *s, MemOp memop, ISSInfo issinfo=
)=0A=
 {=0A=
     uint32_t syn;=0A=
     int sas =3D memop & MO_SIZE;=0A=
@@ -1079,7 +1079,7 @@ static inline void store_reg_from_load(DisasContext *=
s, int reg, TCGv_i32 var)=0A=
  * that the address argument is TCGv_i32 rather than TCGv.=0A=
  */=0A=
 =0A=
-static inline TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, TCGMemOp o=
p)=0A=
+static inline TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)=
=0A=
 {=0A=
     TCGv addr =3D tcg_temp_new();=0A=
     tcg_gen_extu_i32_tl(addr, a32);=0A=
@@ -1092,7 +1092,7 @@ static inline TCGv gen_aa32_addr(DisasContext *s, TCG=
v_i32 a32, TCGMemOp op)=0A=
 }=0A=
 =0A=
 static void gen_aa32_ld_i32(DisasContext *s, TCGv_i32 val, TCGv_i32 a32,=
=0A=
-                            int index, TCGMemOp opc)=0A=
+                            int index, MemOp opc)=0A=
 {=0A=
     TCGv addr;=0A=
 =0A=
@@ -1107,7 +1107,7 @@ static void gen_aa32_ld_i32(DisasContext *s, TCGv_i32=
 val, TCGv_i32 a32,=0A=
 }=0A=
 =0A=
 static void gen_aa32_st_i32(DisasContext *s, TCGv_i32 val, TCGv_i32 a32,=
=0A=
-                            int index, TCGMemOp opc)=0A=
+                            int index, MemOp opc)=0A=
 {=0A=
     TCGv addr;=0A=
 =0A=
@@ -1160,7 +1160,7 @@ static inline void gen_aa32_frob64(DisasContext *s, T=
CGv_i64 val)=0A=
 }=0A=
 =0A=
 static void gen_aa32_ld_i64(DisasContext *s, TCGv_i64 val, TCGv_i32 a32,=
=0A=
-                            int index, TCGMemOp opc)=0A=
+                            int index, MemOp opc)=0A=
 {=0A=
     TCGv addr =3D gen_aa32_addr(s, a32, opc);=0A=
     tcg_gen_qemu_ld_i64(val, addr, index, opc);=0A=
@@ -1175,7 +1175,7 @@ static inline void gen_aa32_ld64(DisasContext *s, TCG=
v_i64 val,=0A=
 }=0A=
 =0A=
 static void gen_aa32_st_i64(DisasContext *s, TCGv_i64 val, TCGv_i32 a32,=
=0A=
-                            int index, TCGMemOp opc)=0A=
+                            int index, MemOp opc)=0A=
 {=0A=
     TCGv addr =3D gen_aa32_addr(s, a32, opc);=0A=
 =0A=
@@ -1400,7 +1400,7 @@ neon_reg_offset (int reg, int n)=0A=
  * where 0 is the least significant end of the register.=0A=
  */=0A=
 static inline long=0A=
-neon_element_offset(int reg, int element, TCGMemOp size)=0A=
+neon_element_offset(int reg, int element, MemOp size)=0A=
 {=0A=
     int element_size =3D 1 << size;=0A=
     int ofs =3D element * element_size;=0A=
@@ -1422,7 +1422,7 @@ static TCGv_i32 neon_load_reg(int reg, int pass)=0A=
     return tmp;=0A=
 }=0A=
 =0A=
-static void neon_load_element(TCGv_i32 var, int reg, int ele, TCGMemOp mop=
)=0A=
+static void neon_load_element(TCGv_i32 var, int reg, int ele, MemOp mop)=
=0A=
 {=0A=
     long offset =3D neon_element_offset(reg, ele, mop & MO_SIZE);=0A=
 =0A=
@@ -1441,7 +1441,7 @@ static void neon_load_element(TCGv_i32 var, int reg, =
int ele, TCGMemOp mop)=0A=
     }=0A=
 }=0A=
 =0A=
-static void neon_load_element64(TCGv_i64 var, int reg, int ele, TCGMemOp m=
op)=0A=
+static void neon_load_element64(TCGv_i64 var, int reg, int ele, MemOp mop)=
=0A=
 {=0A=
     long offset =3D neon_element_offset(reg, ele, mop & MO_SIZE);=0A=
 =0A=
@@ -1469,7 +1469,7 @@ static void neon_store_reg(int reg, int pass, TCGv_i3=
2 var)=0A=
     tcg_temp_free_i32(var);=0A=
 }=0A=
 =0A=
-static void neon_store_element(int reg, int ele, TCGMemOp size, TCGv_i32 v=
ar)=0A=
+static void neon_store_element(int reg, int ele, MemOp size, TCGv_i32 var)=
=0A=
 {=0A=
     long offset =3D neon_element_offset(reg, ele, size);=0A=
 =0A=
@@ -1488,7 +1488,7 @@ static void neon_store_element(int reg, int ele, TCGM=
emOp size, TCGv_i32 var)=0A=
     }=0A=
 }=0A=
 =0A=
-static void neon_store_element64(int reg, int ele, TCGMemOp size, TCGv_i64=
 var)=0A=
+static void neon_store_element64(int reg, int ele, MemOp size, TCGv_i64 va=
r)=0A=
 {=0A=
     long offset =3D neon_element_offset(reg, ele, size);=0A=
 =0A=
@@ -3558,7 +3558,7 @@ static int disas_neon_ls_insn(DisasContext *s, uint32=
_t insn)=0A=
     int n;=0A=
     int vec_size;=0A=
     int mmu_idx;=0A=
-    TCGMemOp endian;=0A=
+    MemOp endian;=0A=
     TCGv_i32 addr;=0A=
     TCGv_i32 tmp;=0A=
     TCGv_i32 tmp2;=0A=
@@ -6867,7 +6867,7 @@ static int disas_neon_data_insn(DisasContext *s, uint=
32_t insn)=0A=
             } else if ((insn & 0x380) =3D=3D 0) {=0A=
                 /* VDUP */=0A=
                 int element;=0A=
-                TCGMemOp size;=0A=
+                MemOp size;=0A=
 =0A=
                 if ((insn & (7 << 16)) =3D=3D 0 || (q && (rd & 1))) {=0A=
                     return 1;=0A=
@@ -7435,7 +7435,7 @@ static void gen_load_exclusive(DisasContext *s, int r=
t, int rt2,=0A=
                                TCGv_i32 addr, int size)=0A=
 {=0A=
     TCGv_i32 tmp =3D tcg_temp_new_i32();=0A=
-    TCGMemOp opc =3D size | MO_ALIGN | s->be_data;=0A=
+    MemOp opc =3D size | MO_ALIGN | s->be_data;=0A=
 =0A=
     s->is_ldex =3D true;=0A=
 =0A=
@@ -7489,7 +7489,7 @@ static void gen_store_exclusive(DisasContext *s, int =
rd, int rt, int rt2,=0A=
     TCGv taddr;=0A=
     TCGLabel *done_label;=0A=
     TCGLabel *fail_label;=0A=
-    TCGMemOp opc =3D size | MO_ALIGN | s->be_data;=0A=
+    MemOp opc =3D size | MO_ALIGN | s->be_data;=0A=
 =0A=
     /* if (env->exclusive_addr =3D=3D addr && env->exclusive_val =3D=3D [a=
ddr]) {=0A=
          [addr] =3D {Rt};=0A=
@@ -8603,7 +8603,7 @@ static void disas_arm_insn(DisasContext *s, unsigned =
int insn)=0A=
                         */=0A=
 =0A=
                         TCGv taddr;=0A=
-                        TCGMemOp opc =3D s->be_data;=0A=
+                        MemOp opc =3D s->be_data;=0A=
 =0A=
                         rm =3D (insn) & 0xf;=0A=
 =0A=
diff --git a/target/arm/translate.h b/target/arm/translate.h=0A=
index a20f6e2056..284c510694 100644=0A=
--- a/target/arm/translate.h=0A=
+++ b/target/arm/translate.h=0A=
@@ -21,7 +21,7 @@ typedef struct DisasContext {=0A=
     int condexec_cond;=0A=
     int thumb;=0A=
     int sctlr_b;=0A=
-    TCGMemOp be_data;=0A=
+    MemOp be_data;=0A=
 #if !defined(CONFIG_USER_ONLY)=0A=
     int user;=0A=
 #endif=0A=
diff --git a/target/hppa/translate.c b/target/hppa/translate.c=0A=
index 188fe688cb..ff4802abae 100644=0A=
--- a/target/hppa/translate.c=0A=
+++ b/target/hppa/translate.c=0A=
@@ -1500,7 +1500,7 @@ static void form_gva(DisasContext *ctx, TCGv_tl *pgva=
, TCGv_reg *pofs,=0A=
  */=0A=
 static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,=0A=
                        unsigned rx, int scale, target_sreg disp,=0A=
-                       unsigned sp, int modify, TCGMemOp mop)=0A=
+                       unsigned sp, int modify, MemOp mop)=0A=
 {=0A=
     TCGv_reg ofs;=0A=
     TCGv_tl addr;=0A=
@@ -1518,7 +1518,7 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 de=
st, unsigned rb,=0A=
 =0A=
 static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,=0A=
                        unsigned rx, int scale, target_sreg disp,=0A=
-                       unsigned sp, int modify, TCGMemOp mop)=0A=
+                       unsigned sp, int modify, MemOp mop)=0A=
 {=0A=
     TCGv_reg ofs;=0A=
     TCGv_tl addr;=0A=
@@ -1536,7 +1536,7 @@ static void do_load_64(DisasContext *ctx, TCGv_i64 de=
st, unsigned rb,=0A=
 =0A=
 static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,=0A=
                         unsigned rx, int scale, target_sreg disp,=0A=
-                        unsigned sp, int modify, TCGMemOp mop)=0A=
+                        unsigned sp, int modify, MemOp mop)=0A=
 {=0A=
     TCGv_reg ofs;=0A=
     TCGv_tl addr;=0A=
@@ -1554,7 +1554,7 @@ static void do_store_32(DisasContext *ctx, TCGv_i32 s=
rc, unsigned rb,=0A=
 =0A=
 static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,=0A=
                         unsigned rx, int scale, target_sreg disp,=0A=
-                        unsigned sp, int modify, TCGMemOp mop)=0A=
+                        unsigned sp, int modify, MemOp mop)=0A=
 {=0A=
     TCGv_reg ofs;=0A=
     TCGv_tl addr;=0A=
@@ -1580,7 +1580,7 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 s=
rc, unsigned rb,=0A=
 =0A=
 static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,=0A=
                     unsigned rx, int scale, target_sreg disp,=0A=
-                    unsigned sp, int modify, TCGMemOp mop)=0A=
+                    unsigned sp, int modify, MemOp mop)=0A=
 {=0A=
     TCGv_reg dest;=0A=
 =0A=
@@ -1653,7 +1653,7 @@ static bool trans_fldd(DisasContext *ctx, arg_ldst *a=
)=0A=
 =0A=
 static bool do_store(DisasContext *ctx, unsigned rt, unsigned rb,=0A=
                      target_sreg disp, unsigned sp,=0A=
-                     int modify, TCGMemOp mop)=0A=
+                     int modify, MemOp mop)=0A=
 {=0A=
     nullify_over(ctx);=0A=
     do_store_reg(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, mop);=
=0A=
@@ -2940,7 +2940,7 @@ static bool trans_st(DisasContext *ctx, arg_ldst *a)=
=0A=
 =0A=
 static bool trans_ldc(DisasContext *ctx, arg_ldst *a)=0A=
 {=0A=
-    TCGMemOp mop =3D MO_TEUL | MO_ALIGN_16 | a->size;=0A=
+    MemOp mop =3D MO_TEUL | MO_ALIGN_16 | a->size;=0A=
     TCGv_reg zero, dest, ofs;=0A=
     TCGv_tl addr;=0A=
 =0A=
diff --git a/target/i386/translate.c b/target/i386/translate.c=0A=
index 03150a86e2..def9867bd2 100644=0A=
--- a/target/i386/translate.c=0A=
+++ b/target/i386/translate.c=0A=
@@ -87,8 +87,8 @@ typedef struct DisasContext {=0A=
     /* current insn context */=0A=
     int override; /* -1 if no override */=0A=
     int prefix;=0A=
-    TCGMemOp aflag;=0A=
-    TCGMemOp dflag;=0A=
+    MemOp aflag;=0A=
+    MemOp dflag;=0A=
     target_ulong pc_start;=0A=
     target_ulong pc; /* pc =3D eip + cs_base */=0A=
     /* current block context */=0A=
@@ -149,7 +149,7 @@ static void gen_eob(DisasContext *s);=0A=
 static void gen_jr(DisasContext *s, TCGv dest);=0A=
 static void gen_jmp(DisasContext *s, target_ulong eip);=0A=
 static void gen_jmp_tb(DisasContext *s, target_ulong eip, int tb_num);=0A=
-static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d);=0A=
+static void gen_op(DisasContext *s1, int op, MemOp ot, int d);=0A=
 =0A=
 /* i386 arith/logic operations */=0A=
 enum {=0A=
@@ -320,7 +320,7 @@ static inline bool byte_reg_is_xH(DisasContext *s, int =
reg)=0A=
 }=0A=
 =0A=
 /* Select the size of a push/pop operation.  */=0A=
-static inline TCGMemOp mo_pushpop(DisasContext *s, TCGMemOp ot)=0A=
+static inline MemOp mo_pushpop(DisasContext *s, MemOp ot)=0A=
 {=0A=
     if (CODE64(s)) {=0A=
         return ot =3D=3D MO_16 ? MO_16 : MO_64;=0A=
@@ -330,13 +330,13 @@ static inline TCGMemOp mo_pushpop(DisasContext *s, TC=
GMemOp ot)=0A=
 }=0A=
 =0A=
 /* Select the size of the stack pointer.  */=0A=
-static inline TCGMemOp mo_stacksize(DisasContext *s)=0A=
+static inline MemOp mo_stacksize(DisasContext *s)=0A=
 {=0A=
     return CODE64(s) ? MO_64 : s->ss32 ? MO_32 : MO_16;=0A=
 }=0A=
 =0A=
 /* Select only size 64 else 32.  Used for SSE operand sizes.  */=0A=
-static inline TCGMemOp mo_64_32(TCGMemOp ot)=0A=
+static inline MemOp mo_64_32(MemOp ot)=0A=
 {=0A=
 #ifdef TARGET_X86_64=0A=
     return ot =3D=3D MO_64 ? MO_64 : MO_32;=0A=
@@ -347,19 +347,19 @@ static inline TCGMemOp mo_64_32(TCGMemOp ot)=0A=
 =0A=
 /* Select size 8 if lsb of B is clear, else OT.  Used for decoding=0A=
    byte vs word opcodes.  */=0A=
-static inline TCGMemOp mo_b_d(int b, TCGMemOp ot)=0A=
+static inline MemOp mo_b_d(int b, MemOp ot)=0A=
 {=0A=
     return b & 1 ? ot : MO_8;=0A=
 }=0A=
 =0A=
 /* Select size 8 if lsb of B is clear, else OT capped at 32.=0A=
    Used for decoding operand size of port opcodes.  */=0A=
-static inline TCGMemOp mo_b_d32(int b, TCGMemOp ot)=0A=
+static inline MemOp mo_b_d32(int b, MemOp ot)=0A=
 {=0A=
     return b & 1 ? (ot =3D=3D MO_16 ? MO_16 : MO_32) : MO_8;=0A=
 }=0A=
 =0A=
-static void gen_op_mov_reg_v(DisasContext *s, TCGMemOp ot, int reg, TCGv t=
0)=0A=
+static void gen_op_mov_reg_v(DisasContext *s, MemOp ot, int reg, TCGv t0)=
=0A=
 {=0A=
     switch(ot) {=0A=
     case MO_8:=0A=
@@ -388,7 +388,7 @@ static void gen_op_mov_reg_v(DisasContext *s, TCGMemOp =
ot, int reg, TCGv t0)=0A=
 }=0A=
 =0A=
 static inline=0A=
-void gen_op_mov_v_reg(DisasContext *s, TCGMemOp ot, TCGv t0, int reg)=0A=
+void gen_op_mov_v_reg(DisasContext *s, MemOp ot, TCGv t0, int reg)=0A=
 {=0A=
     if (ot =3D=3D MO_8 && byte_reg_is_xH(s, reg)) {=0A=
         tcg_gen_extract_tl(t0, cpu_regs[reg - 4], 8, 8);=0A=
@@ -411,13 +411,13 @@ static inline void gen_op_jmp_v(TCGv dest)=0A=
 }=0A=
 =0A=
 static inline=0A=
-void gen_op_add_reg_im(DisasContext *s, TCGMemOp size, int reg, int32_t va=
l)=0A=
+void gen_op_add_reg_im(DisasContext *s, MemOp size, int reg, int32_t val)=
=0A=
 {=0A=
     tcg_gen_addi_tl(s->tmp0, cpu_regs[reg], val);=0A=
     gen_op_mov_reg_v(s, size, reg, s->tmp0);=0A=
 }=0A=
 =0A=
-static inline void gen_op_add_reg_T0(DisasContext *s, TCGMemOp size, int r=
eg)=0A=
+static inline void gen_op_add_reg_T0(DisasContext *s, MemOp size, int reg)=
=0A=
 {=0A=
     tcg_gen_add_tl(s->tmp0, cpu_regs[reg], s->T0);=0A=
     gen_op_mov_reg_v(s, size, reg, s->tmp0);=0A=
@@ -451,7 +451,7 @@ static inline void gen_jmp_im(DisasContext *s, target_u=
long pc)=0A=
 /* Compute SEG:REG into A0.  SEG is selected from the override segment=0A=
    (OVR_SEG) and the default segment (DEF_SEG).  OVR_SEG may be -1 to=0A=
    indicate no override.  */=0A=
-static void gen_lea_v_seg(DisasContext *s, TCGMemOp aflag, TCGv a0,=0A=
+static void gen_lea_v_seg(DisasContext *s, MemOp aflag, TCGv a0,=0A=
                           int def_seg, int ovr_seg)=0A=
 {=0A=
     switch (aflag) {=0A=
@@ -514,13 +514,13 @@ static inline void gen_string_movl_A0_EDI(DisasContex=
t *s)=0A=
     gen_lea_v_seg(s, s->aflag, cpu_regs[R_EDI], R_ES, -1);=0A=
 }=0A=
 =0A=
-static inline void gen_op_movl_T0_Dshift(DisasContext *s, TCGMemOp ot)=0A=
+static inline void gen_op_movl_T0_Dshift(DisasContext *s, MemOp ot)=0A=
 {=0A=
     tcg_gen_ld32s_tl(s->T0, cpu_env, offsetof(CPUX86State, df));=0A=
     tcg_gen_shli_tl(s->T0, s->T0, ot);=0A=
 };=0A=
 =0A=
-static TCGv gen_ext_tl(TCGv dst, TCGv src, TCGMemOp size, bool sign)=0A=
+static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)=0A=
 {=0A=
     switch (size) {=0A=
     case MO_8:=0A=
@@ -551,18 +551,18 @@ static TCGv gen_ext_tl(TCGv dst, TCGv src, TCGMemOp s=
ize, bool sign)=0A=
     }=0A=
 }=0A=
 =0A=
-static void gen_extu(TCGMemOp ot, TCGv reg)=0A=
+static void gen_extu(MemOp ot, TCGv reg)=0A=
 {=0A=
     gen_ext_tl(reg, reg, ot, false);=0A=
 }=0A=
 =0A=
-static void gen_exts(TCGMemOp ot, TCGv reg)=0A=
+static void gen_exts(MemOp ot, TCGv reg)=0A=
 {=0A=
     gen_ext_tl(reg, reg, ot, true);=0A=
 }=0A=
 =0A=
 static inline=0A=
-void gen_op_jnz_ecx(DisasContext *s, TCGMemOp size, TCGLabel *label1)=0A=
+void gen_op_jnz_ecx(DisasContext *s, MemOp size, TCGLabel *label1)=0A=
 {=0A=
     tcg_gen_mov_tl(s->tmp0, cpu_regs[R_ECX]);=0A=
     gen_extu(size, s->tmp0);=0A=
@@ -570,14 +570,14 @@ void gen_op_jnz_ecx(DisasContext *s, TCGMemOp size, T=
CGLabel *label1)=0A=
 }=0A=
 =0A=
 static inline=0A=
-void gen_op_jz_ecx(DisasContext *s, TCGMemOp size, TCGLabel *label1)=0A=
+void gen_op_jz_ecx(DisasContext *s, MemOp size, TCGLabel *label1)=0A=
 {=0A=
     tcg_gen_mov_tl(s->tmp0, cpu_regs[R_ECX]);=0A=
     gen_extu(size, s->tmp0);=0A=
     tcg_gen_brcondi_tl(TCG_COND_EQ, s->tmp0, 0, label1);=0A=
 }=0A=
 =0A=
-static void gen_helper_in_func(TCGMemOp ot, TCGv v, TCGv_i32 n)=0A=
+static void gen_helper_in_func(MemOp ot, TCGv v, TCGv_i32 n)=0A=
 {=0A=
     switch (ot) {=0A=
     case MO_8:=0A=
@@ -594,7 +594,7 @@ static void gen_helper_in_func(TCGMemOp ot, TCGv v, TCG=
v_i32 n)=0A=
     }=0A=
 }=0A=
 =0A=
-static void gen_helper_out_func(TCGMemOp ot, TCGv_i32 v, TCGv_i32 n)=0A=
+static void gen_helper_out_func(MemOp ot, TCGv_i32 v, TCGv_i32 n)=0A=
 {=0A=
     switch (ot) {=0A=
     case MO_8:=0A=
@@ -611,7 +611,7 @@ static void gen_helper_out_func(TCGMemOp ot, TCGv_i32 v=
, TCGv_i32 n)=0A=
     }=0A=
 }=0A=
 =0A=
-static void gen_check_io(DisasContext *s, TCGMemOp ot, target_ulong cur_ei=
p,=0A=
+static void gen_check_io(DisasContext *s, MemOp ot, target_ulong cur_eip,=
=0A=
                          uint32_t svm_flags)=0A=
 {=0A=
     target_ulong next_eip;=0A=
@@ -644,7 +644,7 @@ static void gen_check_io(DisasContext *s, TCGMemOp ot, =
target_ulong cur_eip,=0A=
     }=0A=
 }=0A=
 =0A=
-static inline void gen_movs(DisasContext *s, TCGMemOp ot)=0A=
+static inline void gen_movs(DisasContext *s, MemOp ot)=0A=
 {=0A=
     gen_string_movl_A0_ESI(s);=0A=
     gen_op_ld_v(s, ot, s->T0, s->A0);=0A=
@@ -840,7 +840,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, =
TCGv reg)=0A=
         return (CCPrepare) { .cond =3D TCG_COND_NEVER, .mask =3D -1 };=0A=
     default:=0A=
         {=0A=
-            TCGMemOp size =3D (s->cc_op - CC_OP_ADDB) & 3;=0A=
+            MemOp size =3D (s->cc_op - CC_OP_ADDB) & 3;=0A=
             TCGv t0 =3D gen_ext_tl(reg, cpu_cc_dst, size, true);=0A=
             return (CCPrepare) { .cond =3D TCG_COND_LT, .reg =3D t0, .mask=
 =3D -1 };=0A=
         }=0A=
@@ -885,7 +885,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, =
TCGv reg)=0A=
                              .mask =3D -1 };=0A=
     default:=0A=
         {=0A=
-            TCGMemOp size =3D (s->cc_op - CC_OP_ADDB) & 3;=0A=
+            MemOp size =3D (s->cc_op - CC_OP_ADDB) & 3;=0A=
             TCGv t0 =3D gen_ext_tl(reg, cpu_cc_dst, size, false);=0A=
             return (CCPrepare) { .cond =3D TCG_COND_EQ, .reg =3D t0, .mask=
 =3D -1 };=0A=
         }=0A=
@@ -897,7 +897,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, =
TCGv reg)=0A=
 static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)=0A=
 {=0A=
     int inv, jcc_op, cond;=0A=
-    TCGMemOp size;=0A=
+    MemOp size;=0A=
     CCPrepare cc;=0A=
     TCGv t0;=0A=
 =0A=
@@ -1075,7 +1075,7 @@ static TCGLabel *gen_jz_ecx_string(DisasContext *s, t=
arget_ulong next_eip)=0A=
     return l2;=0A=
 }=0A=
 =0A=
-static inline void gen_stos(DisasContext *s, TCGMemOp ot)=0A=
+static inline void gen_stos(DisasContext *s, MemOp ot)=0A=
 {=0A=
     gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);=0A=
     gen_string_movl_A0_EDI(s);=0A=
@@ -1084,7 +1084,7 @@ static inline void gen_stos(DisasContext *s, TCGMemOp=
 ot)=0A=
     gen_op_add_reg_T0(s, s->aflag, R_EDI);=0A=
 }=0A=
 =0A=
-static inline void gen_lods(DisasContext *s, TCGMemOp ot)=0A=
+static inline void gen_lods(DisasContext *s, MemOp ot)=0A=
 {=0A=
     gen_string_movl_A0_ESI(s);=0A=
     gen_op_ld_v(s, ot, s->T0, s->A0);=0A=
@@ -1093,7 +1093,7 @@ static inline void gen_lods(DisasContext *s, TCGMemOp=
 ot)=0A=
     gen_op_add_reg_T0(s, s->aflag, R_ESI);=0A=
 }=0A=
 =0A=
-static inline void gen_scas(DisasContext *s, TCGMemOp ot)=0A=
+static inline void gen_scas(DisasContext *s, MemOp ot)=0A=
 {=0A=
     gen_string_movl_A0_EDI(s);=0A=
     gen_op_ld_v(s, ot, s->T1, s->A0);=0A=
@@ -1102,7 +1102,7 @@ static inline void gen_scas(DisasContext *s, TCGMemOp=
 ot)=0A=
     gen_op_add_reg_T0(s, s->aflag, R_EDI);=0A=
 }=0A=
 =0A=
-static inline void gen_cmps(DisasContext *s, TCGMemOp ot)=0A=
+static inline void gen_cmps(DisasContext *s, MemOp ot)=0A=
 {=0A=
     gen_string_movl_A0_EDI(s);=0A=
     gen_op_ld_v(s, ot, s->T1, s->A0);=0A=
@@ -1126,7 +1126,7 @@ static void gen_bpt_io(DisasContext *s, TCGv_i32 t_po=
rt, int ot)=0A=
 }=0A=
 =0A=
 =0A=
-static inline void gen_ins(DisasContext *s, TCGMemOp ot)=0A=
+static inline void gen_ins(DisasContext *s, MemOp ot)=0A=
 {=0A=
     if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {=0A=
         gen_io_start();=0A=
@@ -1148,7 +1148,7 @@ static inline void gen_ins(DisasContext *s, TCGMemOp =
ot)=0A=
     }=0A=
 }=0A=
 =0A=
-static inline void gen_outs(DisasContext *s, TCGMemOp ot)=0A=
+static inline void gen_outs(DisasContext *s, MemOp ot)=0A=
 {=0A=
     if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {=0A=
         gen_io_start();=0A=
@@ -1171,7 +1171,7 @@ static inline void gen_outs(DisasContext *s, TCGMemOp=
 ot)=0A=
 /* same method as Valgrind : we generate jumps to current or next=0A=
    instruction */=0A=
 #define GEN_REPZ(op)                                                      =
    \=0A=
-static inline void gen_repz_ ## op(DisasContext *s, TCGMemOp ot,          =
    \=0A=
+static inline void gen_repz_ ## op(DisasContext *s, MemOp ot,             =
 \=0A=
                                  target_ulong cur_eip, target_ulong next_e=
ip) \=0A=
 {                                                                         =
    \=0A=
     TCGLabel *l2;                                                         =
    \=0A=
@@ -1187,7 +1187,7 @@ static inline void gen_repz_ ## op(DisasContext *s, T=
CGMemOp ot,              \=0A=
 }=0A=
 =0A=
 #define GEN_REPZ2(op)                                                     =
    \=0A=
-static inline void gen_repz_ ## op(DisasContext *s, TCGMemOp ot,          =
    \=0A=
+static inline void gen_repz_ ## op(DisasContext *s, MemOp ot,             =
 \=0A=
                                    target_ulong cur_eip,                  =
    \=0A=
                                    target_ulong next_eip,                 =
    \=0A=
                                    int nz)                                =
    \=0A=
@@ -1284,7 +1284,7 @@ static void gen_illegal_opcode(DisasContext *s)=0A=
 }=0A=
 =0A=
 /* if d =3D=3D OR_TMP0, it means memory operand (address in A0) */=0A=
-static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)=0A=
+static void gen_op(DisasContext *s1, int op, MemOp ot, int d)=0A=
 {=0A=
     if (d !=3D OR_TMP0) {=0A=
         if (s1->prefix & PREFIX_LOCK) {=0A=
@@ -1395,7 +1395,7 @@ static void gen_op(DisasContext *s1, int op, TCGMemOp=
 ot, int d)=0A=
 }=0A=
 =0A=
 /* if d =3D=3D OR_TMP0, it means memory operand (address in A0) */=0A=
-static void gen_inc(DisasContext *s1, TCGMemOp ot, int d, int c)=0A=
+static void gen_inc(DisasContext *s1, MemOp ot, int d, int c)=0A=
 {=0A=
     if (s1->prefix & PREFIX_LOCK) {=0A=
         if (d !=3D OR_TMP0) {=0A=
@@ -1421,7 +1421,7 @@ static void gen_inc(DisasContext *s1, TCGMemOp ot, in=
t d, int c)=0A=
     set_cc_op(s1, (c > 0 ? CC_OP_INCB : CC_OP_DECB) + ot);=0A=
 }=0A=
 =0A=
-static void gen_shift_flags(DisasContext *s, TCGMemOp ot, TCGv result,=0A=
+static void gen_shift_flags(DisasContext *s, MemOp ot, TCGv result,=0A=
                             TCGv shm1, TCGv count, bool is_right)=0A=
 {=0A=
     TCGv_i32 z32, s32, oldop;=0A=
@@ -1466,7 +1466,7 @@ static void gen_shift_flags(DisasContext *s, TCGMemOp=
 ot, TCGv result,=0A=
     set_cc_op(s, CC_OP_DYNAMIC);=0A=
 }=0A=
 =0A=
-static void gen_shift_rm_T1(DisasContext *s, TCGMemOp ot, int op1,=0A=
+static void gen_shift_rm_T1(DisasContext *s, MemOp ot, int op1,=0A=
                             int is_right, int is_arith)=0A=
 {=0A=
     target_ulong mask =3D (ot =3D=3D MO_64 ? 0x3f : 0x1f);=0A=
@@ -1502,7 +1502,7 @@ static void gen_shift_rm_T1(DisasContext *s, TCGMemOp=
 ot, int op1,=0A=
     gen_shift_flags(s, ot, s->T0, s->tmp0, s->T1, is_right);=0A=
 }=0A=
 =0A=
-static void gen_shift_rm_im(DisasContext *s, TCGMemOp ot, int op1, int op2=
,=0A=
+static void gen_shift_rm_im(DisasContext *s, MemOp ot, int op1, int op2,=
=0A=
                             int is_right, int is_arith)=0A=
 {=0A=
     int mask =3D (ot =3D=3D MO_64 ? 0x3f : 0x1f);=0A=
@@ -1542,7 +1542,7 @@ static void gen_shift_rm_im(DisasContext *s, TCGMemOp=
 ot, int op1, int op2,=0A=
     }=0A=
 }=0A=
 =0A=
-static void gen_rot_rm_T1(DisasContext *s, TCGMemOp ot, int op1, int is_ri=
ght)=0A=
+static void gen_rot_rm_T1(DisasContext *s, MemOp ot, int op1, int is_right=
)=0A=
 {=0A=
     target_ulong mask =3D (ot =3D=3D MO_64 ? 0x3f : 0x1f);=0A=
     TCGv_i32 t0, t1;=0A=
@@ -1627,7 +1627,7 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp o=
t, int op1, int is_right)=0A=
     set_cc_op(s, CC_OP_DYNAMIC);=0A=
 }=0A=
 =0A=
-static void gen_rot_rm_im(DisasContext *s, TCGMemOp ot, int op1, int op2,=
=0A=
+static void gen_rot_rm_im(DisasContext *s, MemOp ot, int op1, int op2,=0A=
                           int is_right)=0A=
 {=0A=
     int mask =3D (ot =3D=3D MO_64 ? 0x3f : 0x1f);=0A=
@@ -1705,7 +1705,7 @@ static void gen_rot_rm_im(DisasContext *s, TCGMemOp o=
t, int op1, int op2,=0A=
 }=0A=
 =0A=
 /* XXX: add faster immediate =3D 1 case */=0A=
-static void gen_rotc_rm_T1(DisasContext *s, TCGMemOp ot, int op1,=0A=
+static void gen_rotc_rm_T1(DisasContext *s, MemOp ot, int op1,=0A=
                            int is_right)=0A=
 {=0A=
     gen_compute_eflags(s);=0A=
@@ -1761,7 +1761,7 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMemOp =
ot, int op1,=0A=
 }=0A=
 =0A=
 /* XXX: add faster immediate case */=0A=
-static void gen_shiftd_rm_T1(DisasContext *s, TCGMemOp ot, int op1,=0A=
+static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot, int op1,=0A=
                              bool is_right, TCGv count_in)=0A=
 {=0A=
     target_ulong mask =3D (ot =3D=3D MO_64 ? 63 : 31);=0A=
@@ -1842,7 +1842,7 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMemO=
p ot, int op1,=0A=
     tcg_temp_free(count);=0A=
 }=0A=
 =0A=
-static void gen_shift(DisasContext *s1, int op, TCGMemOp ot, int d, int s)=
=0A=
+static void gen_shift(DisasContext *s1, int op, MemOp ot, int d, int s)=0A=
 {=0A=
     if (s !=3D OR_TMP1)=0A=
         gen_op_mov_v_reg(s1, ot, s1->T1, s);=0A=
@@ -1872,7 +1872,7 @@ static void gen_shift(DisasContext *s1, int op, TCGMe=
mOp ot, int d, int s)=0A=
     }=0A=
 }=0A=
 =0A=
-static void gen_shifti(DisasContext *s1, int op, TCGMemOp ot, int d, int c=
)=0A=
+static void gen_shifti(DisasContext *s1, int op, MemOp ot, int d, int c)=
=0A=
 {=0A=
     switch(op) {=0A=
     case OP_ROL:=0A=
@@ -2149,7 +2149,7 @@ static void gen_add_A0_ds_seg(DisasContext *s)=0A=
 /* generate modrm memory load or store of 'reg'. TMP0 is used if reg =3D=
=3D=0A=
    OR_TMP0 */=0A=
 static void gen_ldst_modrm(CPUX86State *env, DisasContext *s, int modrm,=
=0A=
-                           TCGMemOp ot, int reg, int is_store)=0A=
+                           MemOp ot, int reg, int is_store)=0A=
 {=0A=
     int mod, rm;=0A=
 =0A=
@@ -2179,7 +2179,7 @@ static void gen_ldst_modrm(CPUX86State *env, DisasCon=
text *s, int modrm,=0A=
     }=0A=
 }=0A=
 =0A=
-static inline uint32_t insn_get(CPUX86State *env, DisasContext *s, TCGMemO=
p ot)=0A=
+static inline uint32_t insn_get(CPUX86State *env, DisasContext *s, MemOp o=
t)=0A=
 {=0A=
     uint32_t ret;=0A=
 =0A=
@@ -2202,7 +2202,7 @@ static inline uint32_t insn_get(CPUX86State *env, Dis=
asContext *s, TCGMemOp ot)=0A=
     return ret;=0A=
 }=0A=
 =0A=
-static inline int insn_const_size(TCGMemOp ot)=0A=
+static inline int insn_const_size(MemOp ot)=0A=
 {=0A=
     if (ot <=3D MO_32) {=0A=
         return 1 << ot;=0A=
@@ -2266,7 +2266,7 @@ static inline void gen_jcc(DisasContext *s, int b,=0A=
     }=0A=
 }=0A=
 =0A=
-static void gen_cmovcc1(CPUX86State *env, DisasContext *s, TCGMemOp ot, in=
t b,=0A=
+static void gen_cmovcc1(CPUX86State *env, DisasContext *s, MemOp ot, int b=
,=0A=
                         int modrm, int reg)=0A=
 {=0A=
     CCPrepare cc;=0A=
@@ -2363,8 +2363,8 @@ static inline void gen_stack_update(DisasContext *s, =
int addend)=0A=
 /* Generate a push. It depends on ss32, addseg and dflag.  */=0A=
 static void gen_push_v(DisasContext *s, TCGv val)=0A=
 {=0A=
-    TCGMemOp d_ot =3D mo_pushpop(s, s->dflag);=0A=
-    TCGMemOp a_ot =3D mo_stacksize(s);=0A=
+    MemOp d_ot =3D mo_pushpop(s, s->dflag);=0A=
+    MemOp a_ot =3D mo_stacksize(s);=0A=
     int size =3D 1 << d_ot;=0A=
     TCGv new_esp =3D s->A0;=0A=
 =0A=
@@ -2383,9 +2383,9 @@ static void gen_push_v(DisasContext *s, TCGv val)=0A=
 }=0A=
 =0A=
 /* two step pop is necessary for precise exceptions */=0A=
-static TCGMemOp gen_pop_T0(DisasContext *s)=0A=
+static MemOp gen_pop_T0(DisasContext *s)=0A=
 {=0A=
-    TCGMemOp d_ot =3D mo_pushpop(s, s->dflag);=0A=
+    MemOp d_ot =3D mo_pushpop(s, s->dflag);=0A=
 =0A=
     gen_lea_v_seg(s, mo_stacksize(s), cpu_regs[R_ESP], R_SS, -1);=0A=
     gen_op_ld_v(s, d_ot, s->T0, s->A0);=0A=
@@ -2393,7 +2393,7 @@ static TCGMemOp gen_pop_T0(DisasContext *s)=0A=
     return d_ot;=0A=
 }=0A=
 =0A=
-static inline void gen_pop_update(DisasContext *s, TCGMemOp ot)=0A=
+static inline void gen_pop_update(DisasContext *s, MemOp ot)=0A=
 {=0A=
     gen_stack_update(s, 1 << ot);=0A=
 }=0A=
@@ -2405,8 +2405,8 @@ static inline void gen_stack_A0(DisasContext *s)=0A=
 =0A=
 static void gen_pusha(DisasContext *s)=0A=
 {=0A=
-    TCGMemOp s_ot =3D s->ss32 ? MO_32 : MO_16;=0A=
-    TCGMemOp d_ot =3D s->dflag;=0A=
+    MemOp s_ot =3D s->ss32 ? MO_32 : MO_16;=0A=
+    MemOp d_ot =3D s->dflag;=0A=
     int size =3D 1 << d_ot;=0A=
     int i;=0A=
 =0A=
@@ -2421,8 +2421,8 @@ static void gen_pusha(DisasContext *s)=0A=
 =0A=
 static void gen_popa(DisasContext *s)=0A=
 {=0A=
-    TCGMemOp s_ot =3D s->ss32 ? MO_32 : MO_16;=0A=
-    TCGMemOp d_ot =3D s->dflag;=0A=
+    MemOp s_ot =3D s->ss32 ? MO_32 : MO_16;=0A=
+    MemOp d_ot =3D s->dflag;=0A=
     int size =3D 1 << d_ot;=0A=
     int i;=0A=
 =0A=
@@ -2442,8 +2442,8 @@ static void gen_popa(DisasContext *s)=0A=
 =0A=
 static void gen_enter(DisasContext *s, int esp_addend, int level)=0A=
 {=0A=
-    TCGMemOp d_ot =3D mo_pushpop(s, s->dflag);=0A=
-    TCGMemOp a_ot =3D CODE64(s) ? MO_64 : s->ss32 ? MO_32 : MO_16;=0A=
+    MemOp d_ot =3D mo_pushpop(s, s->dflag);=0A=
+    MemOp a_ot =3D CODE64(s) ? MO_64 : s->ss32 ? MO_32 : MO_16;=0A=
     int size =3D 1 << d_ot;=0A=
 =0A=
     /* Push BP; compute FrameTemp into T1.  */=0A=
@@ -2482,8 +2482,8 @@ static void gen_enter(DisasContext *s, int esp_addend=
, int level)=0A=
 =0A=
 static void gen_leave(DisasContext *s)=0A=
 {=0A=
-    TCGMemOp d_ot =3D mo_pushpop(s, s->dflag);=0A=
-    TCGMemOp a_ot =3D mo_stacksize(s);=0A=
+    MemOp d_ot =3D mo_pushpop(s, s->dflag);=0A=
+    MemOp a_ot =3D mo_stacksize(s);=0A=
 =0A=
     gen_lea_v_seg(s, a_ot, cpu_regs[R_EBP], R_SS, -1);=0A=
     gen_op_ld_v(s, d_ot, s->T0, s->A0);=0A=
@@ -3045,7 +3045,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,=0A=
     SSEFunc_0_eppi sse_fn_eppi;=0A=
     SSEFunc_0_ppi sse_fn_ppi;=0A=
     SSEFunc_0_eppt sse_fn_eppt;=0A=
-    TCGMemOp ot;=0A=
+    MemOp ot;=0A=
 =0A=
     b &=3D 0xff;=0A=
     if (s->prefix & PREFIX_DATA)=0A=
@@ -4488,7 +4488,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)=0A=
     CPUX86State *env =3D cpu->env_ptr;=0A=
     int b, prefixes;=0A=
     int shift;=0A=
-    TCGMemOp ot, aflag, dflag;=0A=
+    MemOp ot, aflag, dflag;=0A=
     int modrm, reg, rm, mod, op, opreg, val;=0A=
     target_ulong next_eip, tval;=0A=
     int rex_w, rex_r;=0A=
@@ -5567,8 +5567,8 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)=0A=
     case 0x1be: /* movsbS Gv, Eb */=0A=
     case 0x1bf: /* movswS Gv, Eb */=0A=
         {=0A=
-            TCGMemOp d_ot;=0A=
-            TCGMemOp s_ot;=0A=
+            MemOp d_ot;=0A=
+            MemOp s_ot;=0A=
 =0A=
             /* d_ot is the size of destination */=0A=
             d_ot =3D dflag;=0A=
diff --git a/target/m68k/translate.c b/target/m68k/translate.c=0A=
index 60bcfb7bd0..24c1dd3408 100644=0A=
--- a/target/m68k/translate.c=0A=
+++ b/target/m68k/translate.c=0A=
@@ -2414,7 +2414,7 @@ DISAS_INSN(cas)=0A=
     uint16_t ext;=0A=
     TCGv load;=0A=
     TCGv cmp;=0A=
-    TCGMemOp opc;=0A=
+    MemOp opc;=0A=
 =0A=
     switch ((insn >> 9) & 3) {=0A=
     case 1:=0A=
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c=
=0A=
index 9ce65f3bcf..41d1b8b73d 100644=0A=
--- a/target/microblaze/translate.c=0A=
+++ b/target/microblaze/translate.c=0A=
@@ -919,7 +919,7 @@ static void dec_load(DisasContext *dc)=0A=
     unsigned int size;=0A=
     bool rev =3D false, ex =3D false, ea =3D false;=0A=
     int mem_index =3D cpu_mmu_index(&dc->cpu->env, false);=0A=
-    TCGMemOp mop;=0A=
+    MemOp mop;=0A=
 =0A=
     mop =3D dc->opcode & 3;=0A=
     size =3D 1 << mop;=0A=
@@ -1035,7 +1035,7 @@ static void dec_store(DisasContext *dc)=0A=
     unsigned int size;=0A=
     bool rev =3D false, ex =3D false, ea =3D false;=0A=
     int mem_index =3D cpu_mmu_index(&dc->cpu->env, false);=0A=
-    TCGMemOp mop;=0A=
+    MemOp mop;=0A=
 =0A=
     mop =3D dc->opcode & 3;=0A=
     size =3D 1 << mop;=0A=
diff --git a/target/mips/translate.c b/target/mips/translate.c=0A=
index 3575eff0ae..f4938fc221 100644=0A=
--- a/target/mips/translate.c=0A=
+++ b/target/mips/translate.c=0A=
@@ -2526,7 +2526,7 @@ typedef struct DisasContext {=0A=
     int32_t CP0_Config5;=0A=
     /* Routine used to access memory */=0A=
     int mem_idx;=0A=
-    TCGMemOp default_tcg_memop_mask;=0A=
+    MemOp default_tcg_memop_mask;=0A=
     uint32_t hflags, saved_hflags;=0A=
     target_ulong btarget;=0A=
     bool ulri;=0A=
@@ -3706,7 +3706,7 @@ static void gen_st(DisasContext *ctx, uint32_t opc, i=
nt rt,=0A=
 =0A=
 /* Store conditional */=0A=
 static void gen_st_cond(DisasContext *ctx, int rt, int base, int offset,=
=0A=
-                        TCGMemOp tcg_mo, bool eva)=0A=
+                        MemOp tcg_mo, bool eva)=0A=
 {=0A=
     TCGv addr, t0, val;=0A=
     TCGLabel *l1 =3D gen_new_label();=0A=
@@ -4546,7 +4546,7 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc,=
 int acc, int reg)=0A=
 }=0A=
 =0A=
 static inline void gen_r6_ld(target_long addr, int reg, int memidx,=0A=
-                             TCGMemOp memop)=0A=
+                             MemOp memop)=0A=
 {=0A=
     TCGv t0 =3D tcg_const_tl(addr);=0A=
     tcg_gen_qemu_ld_tl(t0, t0, memidx, memop);=0A=
@@ -21826,7 +21826,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *=
env, DisasContext *ctx)=0A=
                              extract32(ctx->opcode, 0, 8);=0A=
                     TCGv va =3D tcg_temp_new();=0A=
                     TCGv t1 =3D tcg_temp_new();=0A=
-                    TCGMemOp memop =3D (extract32(ctx->opcode, 8, 3)) =3D=
=3D=0A=
+                    MemOp memop =3D (extract32(ctx->opcode, 8, 3)) =3D=3D=
=0A=
                                       NM_P_LS_UAWM ? MO_UNALN : 0;=0A=
 =0A=
                     count =3D (count =3D=3D 0) ? 8 : count;=0A=
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c=0A=
index 4360ce4045..b189c506c5 100644=0A=
--- a/target/openrisc/translate.c=0A=
+++ b/target/openrisc/translate.c=0A=
@@ -681,7 +681,7 @@ static bool trans_l_lwa(DisasContext *dc, arg_load *a)=
=0A=
     return true;=0A=
 }=0A=
 =0A=
-static void do_load(DisasContext *dc, arg_load *a, TCGMemOp mop)=0A=
+static void do_load(DisasContext *dc, arg_load *a, MemOp mop)=0A=
 {=0A=
     TCGv ea;=0A=
 =0A=
@@ -763,7 +763,7 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)=
=0A=
     return true;=0A=
 }=0A=
 =0A=
-static void do_store(DisasContext *dc, arg_store *a, TCGMemOp mop)=0A=
+static void do_store(DisasContext *dc, arg_store *a, MemOp mop)=0A=
 {=0A=
     TCGv t0 =3D tcg_temp_new();=0A=
     tcg_gen_addi_tl(t0, cpu_R[a->a], a->i);=0A=
diff --git a/target/ppc/translate.c b/target/ppc/translate.c=0A=
index 4a5de28036..31800ed654 100644=0A=
--- a/target/ppc/translate.c=0A=
+++ b/target/ppc/translate.c=0A=
@@ -162,7 +162,7 @@ struct DisasContext {=0A=
     int mem_idx;=0A=
     int access_type;=0A=
     /* Translation flags */=0A=
-    TCGMemOp default_tcg_memop_mask;=0A=
+    MemOp default_tcg_memop_mask;=0A=
 #if defined(TARGET_PPC64)=0A=
     bool sf_mode;=0A=
     bool has_cfar;=0A=
@@ -3142,7 +3142,7 @@ static void gen_isync(DisasContext *ctx)=0A=
 =0A=
 #define MEMOP_GET_SIZE(x)  (1 << ((x) & MO_SIZE))=0A=
 =0A=
-static void gen_load_locked(DisasContext *ctx, TCGMemOp memop)=0A=
+static void gen_load_locked(DisasContext *ctx, MemOp memop)=0A=
 {=0A=
     TCGv gpr =3D cpu_gpr[rD(ctx->opcode)];=0A=
     TCGv t0 =3D tcg_temp_new();=0A=
@@ -3167,7 +3167,7 @@ LARX(lbarx, DEF_MEMOP(MO_UB))=0A=
 LARX(lharx, DEF_MEMOP(MO_UW))=0A=
 LARX(lwarx, DEF_MEMOP(MO_UL))=0A=
 =0A=
-static void gen_fetch_inc_conditional(DisasContext *ctx, TCGMemOp memop,=
=0A=
+static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,=0A=
                                       TCGv EA, TCGCond cond, int addend)=
=0A=
 {=0A=
     TCGv t =3D tcg_temp_new();=0A=
@@ -3193,7 +3193,7 @@ static void gen_fetch_inc_conditional(DisasContext *c=
tx, TCGMemOp memop,=0A=
     tcg_temp_free(u);=0A=
 }=0A=
 =0A=
-static void gen_ld_atomic(DisasContext *ctx, TCGMemOp memop)=0A=
+static void gen_ld_atomic(DisasContext *ctx, MemOp memop)=0A=
 {=0A=
     uint32_t gpr_FC =3D FC(ctx->opcode);=0A=
     TCGv EA =3D tcg_temp_new();=0A=
@@ -3306,7 +3306,7 @@ static void gen_ldat(DisasContext *ctx)=0A=
 }=0A=
 #endif=0A=
 =0A=
-static void gen_st_atomic(DisasContext *ctx, TCGMemOp memop)=0A=
+static void gen_st_atomic(DisasContext *ctx, MemOp memop)=0A=
 {=0A=
     uint32_t gpr_FC =3D FC(ctx->opcode);=0A=
     TCGv EA =3D tcg_temp_new();=0A=
@@ -3389,7 +3389,7 @@ static void gen_stdat(DisasContext *ctx)=0A=
 }=0A=
 #endif=0A=
 =0A=
-static void gen_conditional_store(DisasContext *ctx, TCGMemOp memop)=0A=
+static void gen_conditional_store(DisasContext *ctx, MemOp memop)=0A=
 {=0A=
     TCGLabel *l1 =3D gen_new_label();=0A=
     TCGLabel *l2 =3D gen_new_label();=0A=
diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_tr=
ans/trans_rva.inc.c=0A=
index fadd88849e..be8a9f06dd 100644=0A=
--- a/target/riscv/insn_trans/trans_rva.inc.c=0A=
+++ b/target/riscv/insn_trans/trans_rva.inc.c=0A=
@@ -18,7 +18,7 @@=0A=
  * this program.  If not, see <http://www.gnu.org/licenses/>.=0A=
  */=0A=
 =0A=
-static inline bool gen_lr(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)=
=0A=
+static inline bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)=0A=
 {=0A=
     TCGv src1 =3D tcg_temp_new();=0A=
     /* Put addr in load_res, data in load_val.  */=0A=
@@ -37,7 +37,7 @@ static inline bool gen_lr(DisasContext *ctx, arg_atomic *=
a, TCGMemOp mop)=0A=
     return true;=0A=
 }=0A=
 =0A=
-static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)=
=0A=
+static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)=0A=
 {=0A=
     TCGv src1 =3D tcg_temp_new();=0A=
     TCGv src2 =3D tcg_temp_new();=0A=
@@ -82,8 +82,8 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *=
a, TCGMemOp mop)=0A=
 }=0A=
 =0A=
 static bool gen_amo(DisasContext *ctx, arg_atomic *a,=0A=
-                    void(*func)(TCGv, TCGv, TCGv, TCGArg, TCGMemOp),=0A=
-                    TCGMemOp mop)=0A=
+                    void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),=0A=
+                    MemOp mop)=0A=
 {=0A=
     TCGv src1 =3D tcg_temp_new();=0A=
     TCGv src2 =3D tcg_temp_new();=0A=
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_tr=
ans/trans_rvi.inc.c=0A=
index ea6473111c..cf440d147e 100644=0A=
--- a/target/riscv/insn_trans/trans_rvi.inc.c=0A=
+++ b/target/riscv/insn_trans/trans_rvi.inc.c=0A=
@@ -135,7 +135,7 @@ static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a)=
=0A=
     return gen_branch(ctx, a, TCG_COND_GEU);=0A=
 }=0A=
 =0A=
-static bool gen_load(DisasContext *ctx, arg_lb *a, TCGMemOp memop)=0A=
+static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)=0A=
 {=0A=
     TCGv t0 =3D tcg_temp_new();=0A=
     TCGv t1 =3D tcg_temp_new();=0A=
@@ -174,7 +174,7 @@ static bool trans_lhu(DisasContext *ctx, arg_lhu *a)=0A=
     return gen_load(ctx, a, MO_TEUW);=0A=
 }=0A=
 =0A=
-static bool gen_store(DisasContext *ctx, arg_sb *a, TCGMemOp memop)=0A=
+static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)=0A=
 {=0A=
     TCGv t0 =3D tcg_temp_new();=0A=
     TCGv dat =3D tcg_temp_new();=0A=
diff --git a/target/s390x/translate.c b/target/s390x/translate.c=0A=
index ac0d8b6410..2927247c82 100644=0A=
--- a/target/s390x/translate.c=0A=
+++ b/target/s390x/translate.c=0A=
@@ -152,7 +152,7 @@ static inline int vec_full_reg_offset(uint8_t reg)=0A=
     return offsetof(CPUS390XState, vregs[reg][0]);=0A=
 }=0A=
 =0A=
-static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp es)=0A=
+static inline int vec_reg_offset(uint8_t reg, uint8_t enr, MemOp es)=0A=
 {=0A=
     /* Convert element size (es) - e.g. MO_8 - to bytes */=0A=
     const uint8_t bytes =3D 1 << es;=0A=
@@ -2262,7 +2262,7 @@ static DisasJumpType op_csst(DisasContext *s, DisasOp=
s *o)=0A=
 #ifndef CONFIG_USER_ONLY=0A=
 static DisasJumpType op_csp(DisasContext *s, DisasOps *o)=0A=
 {=0A=
-    TCGMemOp mop =3D s->insn->data;=0A=
+    MemOp mop =3D s->insn->data;=0A=
     TCGv_i64 addr, old, cc;=0A=
     TCGLabel *lab =3D gen_new_label();=0A=
 =0A=
@@ -3228,7 +3228,7 @@ static DisasJumpType op_lm64(DisasContext *s, DisasOp=
s *o)=0A=
 static DisasJumpType op_lpd(DisasContext *s, DisasOps *o)=0A=
 {=0A=
     TCGv_i64 a1, a2;=0A=
-    TCGMemOp mop =3D s->insn->data;=0A=
+    MemOp mop =3D s->insn->data;=0A=
 =0A=
     /* In a parallel context, stop the world and single step.  */=0A=
     if (tb_cflags(s->base.tb) & CF_PARALLEL) {=0A=
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.in=
c.c=0A=
index 41d5cf869f..4c56bbbbe8 100644=0A=
--- a/target/s390x/translate_vx.inc.c=0A=
+++ b/target/s390x/translate_vx.inc.c=0A=
@@ -57,13 +57,13 @@=0A=
 #define FPF_LONG        3=0A=
 #define FPF_EXT         4=0A=
 =0A=
-static inline bool valid_vec_element(uint8_t enr, TCGMemOp es)=0A=
+static inline bool valid_vec_element(uint8_t enr, MemOp es)=0A=
 {=0A=
     return !(enr & ~(NUM_VEC_ELEMENTS(es) - 1));=0A=
 }=0A=
 =0A=
 static void read_vec_element_i64(TCGv_i64 dst, uint8_t reg, uint8_t enr,=
=0A=
-                                 TCGMemOp memop)=0A=
+                                 MemOp memop)=0A=
 {=0A=
     const int offs =3D vec_reg_offset(reg, enr, memop & MO_SIZE);=0A=
 =0A=
@@ -96,7 +96,7 @@ static void read_vec_element_i64(TCGv_i64 dst, uint8_t re=
g, uint8_t enr,=0A=
 }=0A=
 =0A=
 static void read_vec_element_i32(TCGv_i32 dst, uint8_t reg, uint8_t enr,=
=0A=
-                                 TCGMemOp memop)=0A=
+                                 MemOp memop)=0A=
 {=0A=
     const int offs =3D vec_reg_offset(reg, enr, memop & MO_SIZE);=0A=
 =0A=
@@ -123,7 +123,7 @@ static void read_vec_element_i32(TCGv_i32 dst, uint8_t =
reg, uint8_t enr,=0A=
 }=0A=
 =0A=
 static void write_vec_element_i64(TCGv_i64 src, int reg, uint8_t enr,=0A=
-                                  TCGMemOp memop)=0A=
+                                  MemOp memop)=0A=
 {=0A=
     const int offs =3D vec_reg_offset(reg, enr, memop & MO_SIZE);=0A=
 =0A=
@@ -146,7 +146,7 @@ static void write_vec_element_i64(TCGv_i64 src, int reg=
, uint8_t enr,=0A=
 }=0A=
 =0A=
 static void write_vec_element_i32(TCGv_i32 src, int reg, uint8_t enr,=0A=
-                                  TCGMemOp memop)=0A=
+                                  MemOp memop)=0A=
 {=0A=
     const int offs =3D vec_reg_offset(reg, enr, memop & MO_SIZE);=0A=
 =0A=
diff --git a/target/sparc/translate.c b/target/sparc/translate.c=0A=
index 091bab53af..bef9ce6f36 100644=0A=
--- a/target/sparc/translate.c=0A=
+++ b/target/sparc/translate.c=0A=
@@ -2019,7 +2019,7 @@ static inline void gen_ne_fop_QD(DisasContext *dc, in=
t rd, int rs,=0A=
 }=0A=
 =0A=
 static void gen_swap(DisasContext *dc, TCGv dst, TCGv src,=0A=
-                     TCGv addr, int mmu_idx, TCGMemOp memop)=0A=
+                     TCGv addr, int mmu_idx, MemOp memop)=0A=
 {=0A=
     gen_address_mask(dc, addr);=0A=
     tcg_gen_atomic_xchg_tl(dst, addr, src, mmu_idx, memop);=0A=
@@ -2050,10 +2050,10 @@ typedef struct {=0A=
     ASIType type;=0A=
     int asi;=0A=
     int mem_idx;=0A=
-    TCGMemOp memop;=0A=
+    MemOp memop;=0A=
 } DisasASI;=0A=
 =0A=
-static DisasASI get_asi(DisasContext *dc, int insn, TCGMemOp memop)=0A=
+static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)=0A=
 {=0A=
     int asi =3D GET_FIELD(insn, 19, 26);=0A=
     ASIType type =3D GET_ASI_HELPER;=0A=
@@ -2267,7 +2267,7 @@ static DisasASI get_asi(DisasContext *dc, int insn, T=
CGMemOp memop)=0A=
 }=0A=
 =0A=
 static void gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr,=0A=
-                       int insn, TCGMemOp memop)=0A=
+                       int insn, MemOp memop)=0A=
 {=0A=
     DisasASI da =3D get_asi(dc, insn, memop);=0A=
 =0A=
@@ -2305,7 +2305,7 @@ static void gen_ld_asi(DisasContext *dc, TCGv dst, TC=
Gv addr,=0A=
 }=0A=
 =0A=
 static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,=0A=
-                       int insn, TCGMemOp memop)=0A=
+                       int insn, MemOp memop)=0A=
 {=0A=
     DisasASI da =3D get_asi(dc, insn, memop);=0A=
 =0A=
@@ -2511,7 +2511,7 @@ static void gen_ldf_asi(DisasContext *dc, TCGv addr,=
=0A=
     case GET_ASI_BLOCK:=0A=
         /* Valid for lddfa on aligned registers only.  */=0A=
         if (size =3D=3D 8 && (rd & 7) =3D=3D 0) {=0A=
-            TCGMemOp memop;=0A=
+            MemOp memop;=0A=
             TCGv eight;=0A=
             int i;=0A=
 =0A=
@@ -2625,7 +2625,7 @@ static void gen_stf_asi(DisasContext *dc, TCGv addr,=
=0A=
     case GET_ASI_BLOCK:=0A=
         /* Valid for stdfa on aligned registers only.  */=0A=
         if (size =3D=3D 8 && (rd & 7) =3D=3D 0) {=0A=
-            TCGMemOp memop;=0A=
+            MemOp memop;=0A=
             TCGv eight;=0A=
             int i;=0A=
 =0A=
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c=0A=
index c46a4ab151..68dd4aa2d8 100644=0A=
--- a/target/tilegx/translate.c=0A=
+++ b/target/tilegx/translate.c=0A=
@@ -290,7 +290,7 @@ static void gen_cmul2(TCGv tdest, TCGv tsrca, TCGv tsrc=
b, int sh, int rd)=0A=
 }=0A=
 =0A=
 static TileExcp gen_st_opcode(DisasContext *dc, unsigned dest, unsigned sr=
ca,=0A=
-                              unsigned srcb, TCGMemOp memop, const char *n=
ame)=0A=
+                              unsigned srcb, MemOp memop, const char *name=
)=0A=
 {=0A=
     if (dest) {=0A=
         return TILEGX_EXCP_OPCODE_UNKNOWN;=0A=
@@ -305,7 +305,7 @@ static TileExcp gen_st_opcode(DisasContext *dc, unsigne=
d dest, unsigned srca,=0A=
 }=0A=
 =0A=
 static TileExcp gen_st_add_opcode(DisasContext *dc, unsigned srca, unsigne=
d srcb,=0A=
-                                  int imm, TCGMemOp memop, const char *nam=
e)=0A=
+                                  int imm, MemOp memop, const char *name)=
=0A=
 {=0A=
     TCGv tsrca =3D load_gr(dc, srca);=0A=
     TCGv tsrcb =3D load_gr(dc, srcb);=0A=
@@ -496,7 +496,7 @@ static TileExcp gen_rr_opcode(DisasContext *dc, unsigne=
d opext,=0A=
 {=0A=
     TCGv tdest, tsrca;=0A=
     const char *mnemonic;=0A=
-    TCGMemOp memop;=0A=
+    MemOp memop;=0A=
     TileExcp ret =3D TILEGX_EXCP_NONE;=0A=
     bool prefetch_nofault =3D false;=0A=
 =0A=
@@ -1478,7 +1478,7 @@ static TileExcp gen_rri_opcode(DisasContext *dc, unsi=
gned opext,=0A=
     TCGv tsrca =3D load_gr(dc, srca);=0A=
     bool prefetch_nofault =3D false;=0A=
     const char *mnemonic;=0A=
-    TCGMemOp memop;=0A=
+    MemOp memop;=0A=
     int i2, i3;=0A=
     TCGv t0;=0A=
 =0A=
@@ -2106,7 +2106,7 @@ static TileExcp decode_y2(DisasContext *dc, tilegx_bu=
ndle_bits bundle)=0A=
     unsigned srca =3D get_SrcA_Y2(bundle);=0A=
     unsigned srcbdest =3D get_SrcBDest_Y2(bundle);=0A=
     const char *mnemonic;=0A=
-    TCGMemOp memop;=0A=
+    MemOp memop;=0A=
     bool prefetch_nofault =3D false;=0A=
 =0A=
     switch (OEY2(opc, mode)) {=0A=
diff --git a/target/tricore/translate.c b/target/tricore/translate.c=0A=
index dc2a65f3f9..87a5f5090a 100644=0A=
--- a/target/tricore/translate.c=0A=
+++ b/target/tricore/translate.c=0A=
@@ -227,7 +227,7 @@ static inline void generate_trap(DisasContext *ctx, int=
 class, int tin);=0A=
 /* Functions for load/save to/from memory */=0A=
 =0A=
 static inline void gen_offset_ld(DisasContext *ctx, TCGv r1, TCGv r2,=0A=
-                                 int16_t con, TCGMemOp mop)=0A=
+                                 int16_t con, MemOp mop)=0A=
 {=0A=
     TCGv temp =3D tcg_temp_new();=0A=
     tcg_gen_addi_tl(temp, r2, con);=0A=
@@ -236,7 +236,7 @@ static inline void gen_offset_ld(DisasContext *ctx, TCG=
v r1, TCGv r2,=0A=
 }=0A=
 =0A=
 static inline void gen_offset_st(DisasContext *ctx, TCGv r1, TCGv r2,=0A=
-                                 int16_t con, TCGMemOp mop)=0A=
+                                 int16_t con, MemOp mop)=0A=
 {=0A=
     TCGv temp =3D tcg_temp_new();=0A=
     tcg_gen_addi_tl(temp, r2, con);=0A=
@@ -284,7 +284,7 @@ static void gen_offset_ld_2regs(TCGv rh, TCGv rl, TCGv =
base, int16_t con,=0A=
 }=0A=
 =0A=
 static void gen_st_preincr(DisasContext *ctx, TCGv r1, TCGv r2, int16_t of=
f,=0A=
-                           TCGMemOp mop)=0A=
+                           MemOp mop)=0A=
 {=0A=
     TCGv temp =3D tcg_temp_new();=0A=
     tcg_gen_addi_tl(temp, r2, off);=0A=
@@ -294,7 +294,7 @@ static void gen_st_preincr(DisasContext *ctx, TCGv r1, =
TCGv r2, int16_t off,=0A=
 }=0A=
 =0A=
 static void gen_ld_preincr(DisasContext *ctx, TCGv r1, TCGv r2, int16_t of=
f,=0A=
-                           TCGMemOp mop)=0A=
+                           MemOp mop)=0A=
 {=0A=
     TCGv temp =3D tcg_temp_new();=0A=
     tcg_gen_addi_tl(temp, r2, off);=0A=
diff --git a/tcg/README b/tcg/README=0A=
index 21fcdf737f..b4382fa8b5 100644=0A=
--- a/tcg/README=0A=
+++ b/tcg/README=0A=
@@ -512,7 +512,7 @@ Both t0 and t1 may be split into little-endian ordered =
pairs of registers=0A=
 if dealing with 64-bit quantities on a 32-bit host.=0A=
 =0A=
 The memidx selects the qemu tlb index to use (e.g. user or kernel access).=
=0A=
-The flags are the TCGMemOp bits, selecting the sign, width, and endianness=
=0A=
+The flags are the MemOp bits, selecting the sign, width, and endianness=0A=
 of the memory access.=0A=
 =0A=
 For a 32-bit host, qemu_ld/st_i64 is guaranteed to only be used with a=0A=
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c=0A=
index 0713448bf5..3f921015d3 100644=0A=
--- a/tcg/aarch64/tcg-target.inc.c=0A=
+++ b/tcg/aarch64/tcg-target.inc.c=0A=
@@ -1423,7 +1423,7 @@ static inline void tcg_out_rev16(TCGContext *s, TCGRe=
g rd, TCGReg rn)=0A=
     tcg_out_insn(s, 3507, REV16, TCG_TYPE_I32, rd, rn);=0A=
 }=0A=
 =0A=
-static inline void tcg_out_sxt(TCGContext *s, TCGType ext, TCGMemOp s_bits=
,=0A=
+static inline void tcg_out_sxt(TCGContext *s, TCGType ext, MemOp s_bits,=
=0A=
                                TCGReg rd, TCGReg rn)=0A=
 {=0A=
     /* Using ALIASes SXTB, SXTH, SXTW, of SBFM Xd, Xn, #0, #7|15|31 */=0A=
@@ -1431,7 +1431,7 @@ static inline void tcg_out_sxt(TCGContext *s, TCGType=
 ext, TCGMemOp s_bits,=0A=
     tcg_out_sbfm(s, ext, rd, rn, 0, bits);=0A=
 }=0A=
 =0A=
-static inline void tcg_out_uxt(TCGContext *s, TCGMemOp s_bits,=0A=
+static inline void tcg_out_uxt(TCGContext *s, MemOp s_bits,=0A=
                                TCGReg rd, TCGReg rn)=0A=
 {=0A=
     /* Using ALIASes UXTB, UXTH of UBFM Wd, Wn, #0, #7|15 */=0A=
@@ -1580,8 +1580,8 @@ static inline void tcg_out_adr(TCGContext *s, TCGReg =
rd, void *target)=0A=
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)=
=0A=
 {=0A=
     TCGMemOpIdx oi =3D lb->oi;=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
-    TCGMemOp size =3D opc & MO_SIZE;=0A=
+    MemOp opc =3D get_memop(oi);=0A=
+    MemOp size =3D opc & MO_SIZE;=0A=
 =0A=
     if (!reloc_pc19(lb->label_ptr[0], s->code_ptr)) {=0A=
         return false;=0A=
@@ -1605,8 +1605,8 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)=0A=
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)=
=0A=
 {=0A=
     TCGMemOpIdx oi =3D lb->oi;=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
-    TCGMemOp size =3D opc & MO_SIZE;=0A=
+    MemOp opc =3D get_memop(oi);=0A=
+    MemOp size =3D opc & MO_SIZE;=0A=
 =0A=
     if (!reloc_pc19(lb->label_ptr[0], s->code_ptr)) {=0A=
         return false;=0A=
@@ -1649,7 +1649,7 @@ QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) !=
=3D 8);=0A=
    slow path for the failure case, which will be patched later when finali=
zing=0A=
    the slow path. Generated code returns the host addend in X1,=0A=
    clobbers X0,X2,X3,TMP. */=0A=
-static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,=
=0A=
+static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, MemOp opc,=0A=
                              tcg_insn_unit **label_ptr, int mem_index,=0A=
                              bool is_read)=0A=
 {=0A=
@@ -1709,11 +1709,11 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg =
addr_reg, TCGMemOp opc,=0A=
 =0A=
 #endif /* CONFIG_SOFTMMU */=0A=
 =0A=
-static void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp memop, TCGType =
ext,=0A=
+static void tcg_out_qemu_ld_direct(TCGContext *s, MemOp memop, TCGType ext=
,=0A=
                                    TCGReg data_r, TCGReg addr_r,=0A=
                                    TCGType otype, TCGReg off_r)=0A=
 {=0A=
-    const TCGMemOp bswap =3D memop & MO_BSWAP;=0A=
+    const MemOp bswap =3D memop & MO_BSWAP;=0A=
 =0A=
     switch (memop & MO_SSIZE) {=0A=
     case MO_UB:=0A=
@@ -1765,11 +1765,11 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, T=
CGMemOp memop, TCGType ext,=0A=
     }=0A=
 }=0A=
 =0A=
-static void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp memop,=0A=
+static void tcg_out_qemu_st_direct(TCGContext *s, MemOp memop,=0A=
                                    TCGReg data_r, TCGReg addr_r,=0A=
                                    TCGType otype, TCGReg off_r)=0A=
 {=0A=
-    const TCGMemOp bswap =3D memop & MO_BSWAP;=0A=
+    const MemOp bswap =3D memop & MO_BSWAP;=0A=
 =0A=
     switch (memop & MO_SIZE) {=0A=
     case MO_8:=0A=
@@ -1804,7 +1804,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
MemOp memop,=0A=
 static void tcg_out_qemu_ld(TCGContext *s, TCGReg data_reg, TCGReg addr_re=
g,=0A=
                             TCGMemOpIdx oi, TCGType ext)=0A=
 {=0A=
-    TCGMemOp memop =3D get_memop(oi);=0A=
+    MemOp memop =3D get_memop(oi);=0A=
     const TCGType otype =3D TARGET_LONG_BITS =3D=3D 64 ? TCG_TYPE_I64 : TC=
G_TYPE_I32;=0A=
 #ifdef CONFIG_SOFTMMU=0A=
     unsigned mem_index =3D get_mmuidx(oi);=0A=
@@ -1829,7 +1829,7 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg dat=
a_reg, TCGReg addr_reg,=0A=
 static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_re=
g,=0A=
                             TCGMemOpIdx oi)=0A=
 {=0A=
-    TCGMemOp memop =3D get_memop(oi);=0A=
+    MemOp memop =3D get_memop(oi);=0A=
     const TCGType otype =3D TARGET_LONG_BITS =3D=3D 64 ? TCG_TYPE_I64 : TC=
G_TYPE_I32;=0A=
 #ifdef CONFIG_SOFTMMU=0A=
     unsigned mem_index =3D get_mmuidx(oi);=0A=
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c=0A=
index ece88dc2eb..94d80d79d1 100644=0A=
--- a/tcg/arm/tcg-target.inc.c=0A=
+++ b/tcg/arm/tcg-target.inc.c=0A=
@@ -1233,7 +1233,7 @@ QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) !=
=3D 4);=0A=
    containing the addend of the tlb entry.  Clobbers R0, R1, R2, TMP.  */=
=0A=
 =0A=
 static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi=
,=0A=
-                               TCGMemOp opc, int mem_index, bool is_load)=
=0A=
+                               MemOp opc, int mem_index, bool is_load)=0A=
 {=0A=
     int cmp_off =3D (is_load ? offsetof(CPUTLBEntry, addr_read)=0A=
                    : offsetof(CPUTLBEntry, addr_write));=0A=
@@ -1348,7 +1348,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)=0A=
 {=0A=
     TCGReg argreg, datalo, datahi;=0A=
     TCGMemOpIdx oi =3D lb->oi;=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
+    MemOp opc =3D get_memop(oi);=0A=
     void *func;=0A=
 =0A=
     if (!reloc_pc24(lb->label_ptr[0], s->code_ptr)) {=0A=
@@ -1412,7 +1412,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)=0A=
 {=0A=
     TCGReg argreg, datalo, datahi;=0A=
     TCGMemOpIdx oi =3D lb->oi;=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
+    MemOp opc =3D get_memop(oi);=0A=
 =0A=
     if (!reloc_pc24(lb->label_ptr[0], s->code_ptr)) {=0A=
         return false;=0A=
@@ -1453,11 +1453,11 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s=
, TCGLabelQemuLdst *lb)=0A=
 }=0A=
 #endif /* SOFTMMU */=0A=
 =0A=
-static inline void tcg_out_qemu_ld_index(TCGContext *s, TCGMemOp opc,=0A=
+static inline void tcg_out_qemu_ld_index(TCGContext *s, MemOp opc,=0A=
                                          TCGReg datalo, TCGReg datahi,=0A=
                                          TCGReg addrlo, TCGReg addend)=0A=
 {=0A=
-    TCGMemOp bswap =3D opc & MO_BSWAP;=0A=
+    MemOp bswap =3D opc & MO_BSWAP;=0A=
 =0A=
     switch (opc & MO_SSIZE) {=0A=
     case MO_UB:=0A=
@@ -1514,11 +1514,11 @@ static inline void tcg_out_qemu_ld_index(TCGContext=
 *s, TCGMemOp opc,=0A=
     }=0A=
 }=0A=
 =0A=
-static inline void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp opc,=0A=
+static inline void tcg_out_qemu_ld_direct(TCGContext *s, MemOp opc,=0A=
                                           TCGReg datalo, TCGReg datahi,=0A=
                                           TCGReg addrlo)=0A=
 {=0A=
-    TCGMemOp bswap =3D opc & MO_BSWAP;=0A=
+    MemOp bswap =3D opc & MO_BSWAP;=0A=
 =0A=
     switch (opc & MO_SSIZE) {=0A=
     case MO_UB:=0A=
@@ -1577,7 +1577,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is64)=0A=
 {=0A=
     TCGReg addrlo, datalo, datahi, addrhi __attribute__((unused));=0A=
     TCGMemOpIdx oi;=0A=
-    TCGMemOp opc;=0A=
+    MemOp opc;=0A=
 #ifdef CONFIG_SOFTMMU=0A=
     int mem_index;=0A=
     TCGReg addend;=0A=
@@ -1614,11 +1614,11 @@ static void tcg_out_qemu_ld(TCGContext *s, const TC=
GArg *args, bool is64)=0A=
 #endif=0A=
 }=0A=
 =0A=
-static inline void tcg_out_qemu_st_index(TCGContext *s, int cond, TCGMemOp=
 opc,=0A=
+static inline void tcg_out_qemu_st_index(TCGContext *s, int cond, MemOp op=
c,=0A=
                                          TCGReg datalo, TCGReg datahi,=0A=
                                          TCGReg addrlo, TCGReg addend)=0A=
 {=0A=
-    TCGMemOp bswap =3D opc & MO_BSWAP;=0A=
+    MemOp bswap =3D opc & MO_BSWAP;=0A=
 =0A=
     switch (opc & MO_SIZE) {=0A=
     case MO_8:=0A=
@@ -1659,11 +1659,11 @@ static inline void tcg_out_qemu_st_index(TCGContext=
 *s, int cond, TCGMemOp opc,=0A=
     }=0A=
 }=0A=
 =0A=
-static inline void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp opc,=0A=
+static inline void tcg_out_qemu_st_direct(TCGContext *s, MemOp opc,=0A=
                                           TCGReg datalo, TCGReg datahi,=0A=
                                           TCGReg addrlo)=0A=
 {=0A=
-    TCGMemOp bswap =3D opc & MO_BSWAP;=0A=
+    MemOp bswap =3D opc & MO_BSWAP;=0A=
 =0A=
     switch (opc & MO_SIZE) {=0A=
     case MO_8:=0A=
@@ -1708,7 +1708,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is64)=0A=
 {=0A=
     TCGReg addrlo, datalo, datahi, addrhi __attribute__((unused));=0A=
     TCGMemOpIdx oi;=0A=
-    TCGMemOp opc;=0A=
+    MemOp opc;=0A=
 #ifdef CONFIG_SOFTMMU=0A=
     int mem_index;=0A=
     TCGReg addend;=0A=
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c=0A=
index 6ddeebf4bc..9d8ed974e0 100644=0A=
--- a/tcg/i386/tcg-target.inc.c=0A=
+++ b/tcg/i386/tcg-target.inc.c=0A=
@@ -1697,7 +1697,7 @@ static void * const qemu_st_helpers[16] =3D {=0A=
    First argument register is clobbered.  */=0A=
 =0A=
 static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg a=
ddrhi,=0A=
-                                    int mem_index, TCGMemOp opc,=0A=
+                                    int mem_index, MemOp opc,=0A=
                                     tcg_insn_unit **label_ptr, int which)=
=0A=
 {=0A=
     const TCGReg r0 =3D TCG_REG_L0;=0A=
@@ -1810,7 +1810,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool i=
s_ld, bool is_64,=0A=
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)=
=0A=
 {=0A=
     TCGMemOpIdx oi =3D l->oi;=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
+    MemOp opc =3D get_memop(oi);=0A=
     TCGReg data_reg;=0A=
     tcg_insn_unit **label_ptr =3D &l->label_ptr[0];=0A=
     int rexw =3D (l->type =3D=3D TCG_TYPE_I64 ? P_REXW : 0);=0A=
@@ -1895,8 +1895,8 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)=0A=
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)=
=0A=
 {=0A=
     TCGMemOpIdx oi =3D l->oi;=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
-    TCGMemOp s_bits =3D opc & MO_SIZE;=0A=
+    MemOp opc =3D get_memop(oi);=0A=
+    MemOp s_bits =3D opc & MO_SIZE;=0A=
     tcg_insn_unit **label_ptr =3D &l->label_ptr[0];=0A=
     TCGReg retaddr;=0A=
 =0A=
@@ -1995,10 +1995,10 @@ static inline int setup_guest_base_seg(void)=0A=
 =0A=
 static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg da=
tahi,=0A=
                                    TCGReg base, int index, intptr_t ofs,=
=0A=
-                                   int seg, bool is64, TCGMemOp memop)=0A=
+                                   int seg, bool is64, MemOp memop)=0A=
 {=0A=
-    const TCGMemOp real_bswap =3D memop & MO_BSWAP;=0A=
-    TCGMemOp bswap =3D real_bswap;=0A=
+    const MemOp real_bswap =3D memop & MO_BSWAP;=0A=
+    MemOp bswap =3D real_bswap;=0A=
     int rexw =3D is64 * P_REXW;=0A=
     int movop =3D OPC_MOVL_GvEv;=0A=
 =0A=
@@ -2103,7 +2103,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is64)=0A=
     TCGReg datalo, datahi, addrlo;=0A=
     TCGReg addrhi __attribute__((unused));=0A=
     TCGMemOpIdx oi;=0A=
-    TCGMemOp opc;=0A=
+    MemOp opc;=0A=
 #if defined(CONFIG_SOFTMMU)=0A=
     int mem_index;=0A=
     tcg_insn_unit *label_ptr[2];=0A=
@@ -2137,15 +2137,15 @@ static void tcg_out_qemu_ld(TCGContext *s, const TC=
GArg *args, bool is64)=0A=
 =0A=
 static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg da=
tahi,=0A=
                                    TCGReg base, int index, intptr_t ofs,=
=0A=
-                                   int seg, TCGMemOp memop)=0A=
+                                   int seg, MemOp memop)=0A=
 {=0A=
     /* ??? Ideally we wouldn't need a scratch register.  For user-only,=0A=
        we could perform the bswap twice to restore the original value=0A=
        instead of moving to the scratch.  But as it is, the L constraint=
=0A=
        means that TCG_REG_L0 is definitely free here.  */=0A=
     const TCGReg scratch =3D TCG_REG_L0;=0A=
-    const TCGMemOp real_bswap =3D memop & MO_BSWAP;=0A=
-    TCGMemOp bswap =3D real_bswap;=0A=
+    const MemOp real_bswap =3D memop & MO_BSWAP;=0A=
+    MemOp bswap =3D real_bswap;=0A=
     int movop =3D OPC_MOVL_EvGv;=0A=
 =0A=
     if (have_movbe && real_bswap) {=0A=
@@ -2221,7 +2221,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is64)=0A=
     TCGReg datalo, datahi, addrlo;=0A=
     TCGReg addrhi __attribute__((unused));=0A=
     TCGMemOpIdx oi;=0A=
-    TCGMemOp opc;=0A=
+    MemOp opc;=0A=
 #if defined(CONFIG_SOFTMMU)=0A=
     int mem_index;=0A=
     tcg_insn_unit *label_ptr[2];=0A=
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c=0A=
index 41bff32fb4..5442167045 100644=0A=
--- a/tcg/mips/tcg-target.inc.c=0A=
+++ b/tcg/mips/tcg-target.inc.c=0A=
@@ -1215,7 +1215,7 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg ba=
se, TCGReg addrl,=0A=
                              TCGReg addrh, TCGMemOpIdx oi,=0A=
                              tcg_insn_unit *label_ptr[2], bool is_load)=0A=
 {=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
+    MemOp opc =3D get_memop(oi);=0A=
     unsigned s_bits =3D opc & MO_SIZE;=0A=
     unsigned a_bits =3D get_alignment_bits(opc);=0A=
     int mem_index =3D get_mmuidx(oi);=0A=
@@ -1313,7 +1313,7 @@ static void add_qemu_ldst_label(TCGContext *s, int is=
_ld, TCGMemOpIdx oi,=0A=
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)=
=0A=
 {=0A=
     TCGMemOpIdx oi =3D l->oi;=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
+    MemOp opc =3D get_memop(oi);=0A=
     TCGReg v0;=0A=
     int i;=0A=
 =0A=
@@ -1363,8 +1363,8 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)=0A=
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)=
=0A=
 {=0A=
     TCGMemOpIdx oi =3D l->oi;=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
-    TCGMemOp s_bits =3D opc & MO_SIZE;=0A=
+    MemOp opc =3D get_memop(oi);=0A=
+    MemOp s_bits =3D opc & MO_SIZE;=0A=
     int i;=0A=
 =0A=
     /* resolve label address */=0A=
@@ -1413,7 +1413,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)=0A=
 #endif=0A=
 =0A=
 static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,=0A=
-                                   TCGReg base, TCGMemOp opc, bool is_64)=
=0A=
+                                   TCGReg base, MemOp opc, bool is_64)=0A=
 {=0A=
     switch (opc & (MO_SSIZE | MO_BSWAP)) {=0A=
     case MO_UB:=0A=
@@ -1521,7 +1521,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is_64)=0A=
     TCGReg addr_regl, addr_regh __attribute__((unused));=0A=
     TCGReg data_regl, data_regh;=0A=
     TCGMemOpIdx oi;=0A=
-    TCGMemOp opc;=0A=
+    MemOp opc;=0A=
 #if defined(CONFIG_SOFTMMU)=0A=
     tcg_insn_unit *label_ptr[2];=0A=
 #endif=0A=
@@ -1558,7 +1558,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is_64)=0A=
 }=0A=
 =0A=
 static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,=0A=
-                                   TCGReg base, TCGMemOp opc)=0A=
+                                   TCGReg base, MemOp opc)=0A=
 {=0A=
     /* Don't clutter the code below with checks to avoid bswapping ZERO.  =
*/=0A=
     if ((lo | hi) =3D=3D 0) {=0A=
@@ -1624,7 +1624,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is_64)=0A=
     TCGReg addr_regl, addr_regh __attribute__((unused));=0A=
     TCGReg data_regl, data_regh;=0A=
     TCGMemOpIdx oi;=0A=
-    TCGMemOp opc;=0A=
+    MemOp opc;=0A=
 #if defined(CONFIG_SOFTMMU)=0A=
     tcg_insn_unit *label_ptr[2];=0A=
 #endif=0A=
diff --git a/tcg/optimize.c b/tcg/optimize.c=0A=
index d2424de4af..a89ffda81a 100644=0A=
--- a/tcg/optimize.c=0A=
+++ b/tcg/optimize.c=0A=
@@ -1014,7 +1014,7 @@ void tcg_optimize(TCGContext *s)=0A=
         CASE_OP_32_64(qemu_ld):=0A=
             {=0A=
                 TCGMemOpIdx oi =3D op->args[nb_oargs + nb_iargs];=0A=
-                TCGMemOp mop =3D get_memop(oi);=0A=
+                MemOp mop =3D get_memop(oi);=0A=
                 if (!(mop & MO_SIGN)) {=0A=
                     mask =3D (2ULL << ((8 << (mop & MO_SIZE)) - 1)) - 1;=
=0A=
                 }=0A=
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c=0A=
index 852b8940fb..815edac077 100644=0A=
--- a/tcg/ppc/tcg-target.inc.c=0A=
+++ b/tcg/ppc/tcg-target.inc.c=0A=
@@ -1506,7 +1506,7 @@ QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -32768);=0A=
    in CR7, loads the addend of the TLB into R3, and returns the register=
=0A=
    containing the guest address (zero-extended into R4).  Clobbers R0 and =
R2. */=0A=
 =0A=
-static TCGReg tcg_out_tlb_read(TCGContext *s, TCGMemOp opc,=0A=
+static TCGReg tcg_out_tlb_read(TCGContext *s, MemOp opc,=0A=
                                TCGReg addrlo, TCGReg addrhi,=0A=
                                int mem_index, bool is_read)=0A=
 {=0A=
@@ -1633,7 +1633,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool i=
s_ld, TCGMemOpIdx oi,=0A=
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)=
=0A=
 {=0A=
     TCGMemOpIdx oi =3D lb->oi;=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
+    MemOp opc =3D get_memop(oi);=0A=
     TCGReg hi, lo, arg =3D TCG_REG_R3;=0A=
 =0A=
     if (!reloc_pc14(lb->label_ptr[0], s->code_ptr)) {=0A=
@@ -1680,8 +1680,8 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)=0A=
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)=
=0A=
 {=0A=
     TCGMemOpIdx oi =3D lb->oi;=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
-    TCGMemOp s_bits =3D opc & MO_SIZE;=0A=
+    MemOp opc =3D get_memop(oi);=0A=
+    MemOp s_bits =3D opc & MO_SIZE;=0A=
     TCGReg hi, lo, arg =3D TCG_REG_R3;=0A=
 =0A=
     if (!reloc_pc14(lb->label_ptr[0], s->code_ptr)) {=0A=
@@ -1744,7 +1744,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is_64)=0A=
     TCGReg datalo, datahi, addrlo, rbase;=0A=
     TCGReg addrhi __attribute__((unused));=0A=
     TCGMemOpIdx oi;=0A=
-    TCGMemOp opc, s_bits;=0A=
+    MemOp opc, s_bits;=0A=
 #ifdef CONFIG_SOFTMMU=0A=
     int mem_index;=0A=
     tcg_insn_unit *label_ptr;=0A=
@@ -1819,7 +1819,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is_64)=0A=
     TCGReg datalo, datahi, addrlo, rbase;=0A=
     TCGReg addrhi __attribute__((unused));=0A=
     TCGMemOpIdx oi;=0A=
-    TCGMemOp opc, s_bits;=0A=
+    MemOp opc, s_bits;=0A=
 #ifdef CONFIG_SOFTMMU=0A=
     int mem_index;=0A=
     tcg_insn_unit *label_ptr;=0A=
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c=0A=
index 3e76bf5738..7018509693 100644=0A=
--- a/tcg/riscv/tcg-target.inc.c=0A=
+++ b/tcg/riscv/tcg-target.inc.c=0A=
@@ -970,7 +970,7 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg addr=
l,=0A=
                              TCGReg addrh, TCGMemOpIdx oi,=0A=
                              tcg_insn_unit **label_ptr, bool is_load)=0A=
 {=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
+    MemOp opc =3D get_memop(oi);=0A=
     unsigned s_bits =3D opc & MO_SIZE;=0A=
     unsigned a_bits =3D get_alignment_bits(opc);=0A=
     tcg_target_long compare_mask;=0A=
@@ -1044,7 +1044,7 @@ static void add_qemu_ldst_label(TCGContext *s, int is=
_ld, TCGMemOpIdx oi,=0A=
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)=
=0A=
 {=0A=
     TCGMemOpIdx oi =3D l->oi;=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
+    MemOp opc =3D get_memop(oi);=0A=
     TCGReg a0 =3D tcg_target_call_iarg_regs[0];=0A=
     TCGReg a1 =3D tcg_target_call_iarg_regs[1];=0A=
     TCGReg a2 =3D tcg_target_call_iarg_regs[2];=0A=
@@ -1077,8 +1077,8 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)=0A=
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)=
=0A=
 {=0A=
     TCGMemOpIdx oi =3D l->oi;=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
-    TCGMemOp s_bits =3D opc & MO_SIZE;=0A=
+    MemOp opc =3D get_memop(oi);=0A=
+    MemOp s_bits =3D opc & MO_SIZE;=0A=
     TCGReg a0 =3D tcg_target_call_iarg_regs[0];=0A=
     TCGReg a1 =3D tcg_target_call_iarg_regs[1];=0A=
     TCGReg a2 =3D tcg_target_call_iarg_regs[2];=0A=
@@ -1121,9 +1121,9 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)=0A=
 #endif /* CONFIG_SOFTMMU */=0A=
 =0A=
 static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,=0A=
-                                   TCGReg base, TCGMemOp opc, bool is_64)=
=0A=
+                                   TCGReg base, MemOp opc, bool is_64)=0A=
 {=0A=
-    const TCGMemOp bswap =3D opc & MO_BSWAP;=0A=
+    const MemOp bswap =3D opc & MO_BSWAP;=0A=
 =0A=
     /* We don't yet handle byteswapping, assert */=0A=
     g_assert(!bswap);=0A=
@@ -1172,7 +1172,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is_64)=0A=
     TCGReg addr_regl, addr_regh __attribute__((unused));=0A=
     TCGReg data_regl, data_regh;=0A=
     TCGMemOpIdx oi;=0A=
-    TCGMemOp opc;=0A=
+    MemOp opc;=0A=
 #if defined(CONFIG_SOFTMMU)=0A=
     tcg_insn_unit *label_ptr[1];=0A=
 #endif=0A=
@@ -1208,9 +1208,9 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is_64)=0A=
 }=0A=
 =0A=
 static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,=0A=
-                                   TCGReg base, TCGMemOp opc)=0A=
+                                   TCGReg base, MemOp opc)=0A=
 {=0A=
-    const TCGMemOp bswap =3D opc & MO_BSWAP;=0A=
+    const MemOp bswap =3D opc & MO_BSWAP;=0A=
 =0A=
     /* We don't yet handle byteswapping, assert */=0A=
     g_assert(!bswap);=0A=
@@ -1243,7 +1243,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is_64)=0A=
     TCGReg addr_regl, addr_regh __attribute__((unused));=0A=
     TCGReg data_regl, data_regh;=0A=
     TCGMemOpIdx oi;=0A=
-    TCGMemOp opc;=0A=
+    MemOp opc;=0A=
 #if defined(CONFIG_SOFTMMU)=0A=
     tcg_insn_unit *label_ptr[1];=0A=
 #endif=0A=
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c=0A=
index fe42939d98..8aaa4cebe8 100644=0A=
--- a/tcg/s390/tcg-target.inc.c=0A=
+++ b/tcg/s390/tcg-target.inc.c=0A=
@@ -1430,7 +1430,7 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit=
 *dest)=0A=
     }=0A=
 }=0A=
 =0A=
-static void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp opc, TCGReg dat=
a,=0A=
+static void tcg_out_qemu_ld_direct(TCGContext *s, MemOp opc, TCGReg data,=
=0A=
                                    TCGReg base, TCGReg index, int disp)=0A=
 {=0A=
     switch (opc & (MO_SSIZE | MO_BSWAP)) {=0A=
@@ -1489,7 +1489,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCG=
MemOp opc, TCGReg data,=0A=
     }=0A=
 }=0A=
 =0A=
-static void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp opc, TCGReg dat=
a,=0A=
+static void tcg_out_qemu_st_direct(TCGContext *s, MemOp opc, TCGReg data,=
=0A=
                                    TCGReg base, TCGReg index, int disp)=0A=
 {=0A=
     switch (opc & (MO_SIZE | MO_BSWAP)) {=0A=
@@ -1544,7 +1544,7 @@ QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -(1 << 19))=
;=0A=
 =0A=
 /* Load and compare a TLB entry, leaving the flags set.  Loads the TLB=0A=
    addend into R2.  Returns a register with the santitized guest address. =
 */=0A=
-static TCGReg tcg_out_tlb_read(TCGContext* s, TCGReg addr_reg, TCGMemOp op=
c,=0A=
+static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, MemOp opc,=
=0A=
                                int mem_index, bool is_ld)=0A=
 {=0A=
     unsigned s_bits =3D opc & MO_SIZE;=0A=
@@ -1614,7 +1614,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)=0A=
     TCGReg addr_reg =3D lb->addrlo_reg;=0A=
     TCGReg data_reg =3D lb->datalo_reg;=0A=
     TCGMemOpIdx oi =3D lb->oi;=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
+    MemOp opc =3D get_memop(oi);=0A=
 =0A=
     if (!patch_reloc(lb->label_ptr[0], R_390_PC16DBL,=0A=
                      (intptr_t)s->code_ptr, 2)) {=0A=
@@ -1639,7 +1639,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)=0A=
     TCGReg addr_reg =3D lb->addrlo_reg;=0A=
     TCGReg data_reg =3D lb->datalo_reg;=0A=
     TCGMemOpIdx oi =3D lb->oi;=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
+    MemOp opc =3D get_memop(oi);=0A=
 =0A=
     if (!patch_reloc(lb->label_ptr[0], R_390_PC16DBL,=0A=
                      (intptr_t)s->code_ptr, 2)) {=0A=
@@ -1694,7 +1694,7 @@ static void tcg_prepare_user_ldst(TCGContext *s, TCGR=
eg *addr_reg,=0A=
 static void tcg_out_qemu_ld(TCGContext* s, TCGReg data_reg, TCGReg addr_re=
g,=0A=
                             TCGMemOpIdx oi)=0A=
 {=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
+    MemOp opc =3D get_memop(oi);=0A=
 #ifdef CONFIG_SOFTMMU=0A=
     unsigned mem_index =3D get_mmuidx(oi);=0A=
     tcg_insn_unit *label_ptr;=0A=
@@ -1721,7 +1721,7 @@ static void tcg_out_qemu_ld(TCGContext* s, TCGReg dat=
a_reg, TCGReg addr_reg,=0A=
 static void tcg_out_qemu_st(TCGContext* s, TCGReg data_reg, TCGReg addr_re=
g,=0A=
                             TCGMemOpIdx oi)=0A=
 {=0A=
-    TCGMemOp opc =3D get_memop(oi);=0A=
+    MemOp opc =3D get_memop(oi);=0A=
 #ifdef CONFIG_SOFTMMU=0A=
     unsigned mem_index =3D get_mmuidx(oi);=0A=
     tcg_insn_unit *label_ptr;=0A=
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c=0A=
index 10b1cea63b..d7986cda5c 100644=0A=
--- a/tcg/sparc/tcg-target.inc.c=0A=
+++ b/tcg/sparc/tcg-target.inc.c=0A=
@@ -1081,7 +1081,7 @@ QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -(1 << 12))=
;=0A=
    is in the returned register, maybe %o0.  The TLB addend is in %o1.  */=
=0A=
 =0A=
 static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addr, int mem_index,=
=0A=
-                               TCGMemOp opc, int which)=0A=
+                               MemOp opc, int which)=0A=
 {=0A=
     int fast_off =3D TLB_MASK_TABLE_OFS(mem_index);=0A=
     int mask_off =3D fast_off + offsetof(CPUTLBDescFast, mask);=0A=
@@ -1164,7 +1164,7 @@ static const int qemu_st_opc[16] =3D {=0A=
 static void tcg_out_qemu_ld(TCGContext *s, TCGReg data, TCGReg addr,=0A=
                             TCGMemOpIdx oi, bool is_64)=0A=
 {=0A=
-    TCGMemOp memop =3D get_memop(oi);=0A=
+    MemOp memop =3D get_memop(oi);=0A=
 #ifdef CONFIG_SOFTMMU=0A=
     unsigned memi =3D get_mmuidx(oi);=0A=
     TCGReg addrz, param;=0A=
@@ -1246,7 +1246,7 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg dat=
a, TCGReg addr,=0A=
 static void tcg_out_qemu_st(TCGContext *s, TCGReg data, TCGReg addr,=0A=
                             TCGMemOpIdx oi)=0A=
 {=0A=
-    TCGMemOp memop =3D get_memop(oi);=0A=
+    MemOp memop =3D get_memop(oi);=0A=
 #ifdef CONFIG_SOFTMMU=0A=
     unsigned memi =3D get_mmuidx(oi);=0A=
     TCGReg addrz, param;=0A=
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c=0A=
index 587d092238..e91254cf7a 100644=0A=
--- a/tcg/tcg-op.c=0A=
+++ b/tcg/tcg-op.c=0A=
@@ -2714,7 +2714,7 @@ void tcg_gen_lookup_and_goto_ptr(void)=0A=
     }=0A=
 }=0A=
 =0A=
-static inline TCGMemOp tcg_canonicalize_memop(TCGMemOp op, bool is64, bool=
 st)=0A=
+static inline MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)=
=0A=
 {=0A=
     /* Trigger the asserts within as early as possible.  */=0A=
     (void)get_alignment_bits(op);=0A=
@@ -2743,7 +2743,7 @@ static inline TCGMemOp tcg_canonicalize_memop(TCGMemO=
p op, bool is64, bool st)=0A=
 }=0A=
 =0A=
 static void gen_ldst_i32(TCGOpcode opc, TCGv_i32 val, TCGv addr,=0A=
-                         TCGMemOp memop, TCGArg idx)=0A=
+                         MemOp memop, TCGArg idx)=0A=
 {=0A=
     TCGMemOpIdx oi =3D make_memop_idx(memop, idx);=0A=
 #if TARGET_LONG_BITS =3D=3D 32=0A=
@@ -2758,7 +2758,7 @@ static void gen_ldst_i32(TCGOpcode opc, TCGv_i32 val,=
 TCGv addr,=0A=
 }=0A=
 =0A=
 static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 val, TCGv addr,=0A=
-                         TCGMemOp memop, TCGArg idx)=0A=
+                         MemOp memop, TCGArg idx)=0A=
 {=0A=
     TCGMemOpIdx oi =3D make_memop_idx(memop, idx);=0A=
 #if TARGET_LONG_BITS =3D=3D 32=0A=
@@ -2788,9 +2788,9 @@ static void tcg_gen_req_mo(TCGBar type)=0A=
     }=0A=
 }=0A=
 =0A=
-void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp mem=
op)=0A=
+void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)=
=0A=
 {=0A=
-    TCGMemOp orig_memop;=0A=
+    MemOp orig_memop;=0A=
 =0A=
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);=0A=
     memop =3D tcg_canonicalize_memop(memop, 0, 0);=0A=
@@ -2825,7 +2825,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)=0A=
     }=0A=
 }=0A=
 =0A=
-void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp mem=
op)=0A=
+void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)=
=0A=
 {=0A=
     TCGv_i32 swap =3D NULL;=0A=
 =0A=
@@ -2858,9 +2858,9 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)=0A=
     }=0A=
 }=0A=
 =0A=
-void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp mem=
op)=0A=
+void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)=
=0A=
 {=0A=
-    TCGMemOp orig_memop;=0A=
+    MemOp orig_memop;=0A=
 =0A=
     if (TCG_TARGET_REG_BITS =3D=3D 32 && (memop & MO_SIZE) < MO_64) {=0A=
         tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);=0A=
@@ -2911,7 +2911,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)=0A=
     }=0A=
 }=0A=
 =0A=
-void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp mem=
op)=0A=
+void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)=
=0A=
 {=0A=
     TCGv_i64 swap =3D NULL;=0A=
 =0A=
@@ -2953,7 +2953,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)=0A=
     }=0A=
 }=0A=
 =0A=
-static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, TCGMemOp opc)=0A=
+static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc)=0A=
 {=0A=
     switch (opc & MO_SSIZE) {=0A=
     case MO_SB:=0A=
@@ -2974,7 +2974,7 @@ static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 va=
l, TCGMemOp opc)=0A=
     }=0A=
 }=0A=
 =0A=
-static void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, TCGMemOp opc)=0A=
+static void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc)=0A=
 {=0A=
     switch (opc & MO_SSIZE) {=0A=
     case MO_SB:=0A=
@@ -3034,7 +3034,7 @@ static void * const table_cmpxchg[16] =3D {=0A=
 };=0A=
 =0A=
 void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,=
=0A=
-                                TCGv_i32 newv, TCGArg idx, TCGMemOp memop)=
=0A=
+                                TCGv_i32 newv, TCGArg idx, MemOp memop)=0A=
 {=0A=
     memop =3D tcg_canonicalize_memop(memop, 0, 0);=0A=
 =0A=
@@ -3078,7 +3078,7 @@ void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv a=
ddr, TCGv_i32 cmpv,=0A=
 }=0A=
 =0A=
 void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,=
=0A=
-                                TCGv_i64 newv, TCGArg idx, TCGMemOp memop)=
=0A=
+                                TCGv_i64 newv, TCGArg idx, MemOp memop)=0A=
 {=0A=
     memop =3D tcg_canonicalize_memop(memop, 1, 0);=0A=
 =0A=
@@ -3142,7 +3142,7 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv a=
ddr, TCGv_i64 cmpv,=0A=
 }=0A=
 =0A=
 static void do_nonatomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,=0A=
-                                TCGArg idx, TCGMemOp memop, bool new_val,=
=0A=
+                                TCGArg idx, MemOp memop, bool new_val,=0A=
                                 void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32))=
=0A=
 {=0A=
     TCGv_i32 t1 =3D tcg_temp_new_i32();=0A=
@@ -3160,7 +3160,7 @@ static void do_nonatomic_op_i32(TCGv_i32 ret, TCGv ad=
dr, TCGv_i32 val,=0A=
 }=0A=
 =0A=
 static void do_atomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,=0A=
-                             TCGArg idx, TCGMemOp memop, void * const tabl=
e[])=0A=
+                             TCGArg idx, MemOp memop, void * const table[]=
)=0A=
 {=0A=
     gen_atomic_op_i32 gen;=0A=
 =0A=
@@ -3185,7 +3185,7 @@ static void do_atomic_op_i32(TCGv_i32 ret, TCGv addr,=
 TCGv_i32 val,=0A=
 }=0A=
 =0A=
 static void do_nonatomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,=0A=
-                                TCGArg idx, TCGMemOp memop, bool new_val,=
=0A=
+                                TCGArg idx, MemOp memop, bool new_val,=0A=
                                 void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64))=
=0A=
 {=0A=
     TCGv_i64 t1 =3D tcg_temp_new_i64();=0A=
@@ -3203,7 +3203,7 @@ static void do_nonatomic_op_i64(TCGv_i64 ret, TCGv ad=
dr, TCGv_i64 val,=0A=
 }=0A=
 =0A=
 static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,=0A=
-                             TCGArg idx, TCGMemOp memop, void * const tabl=
e[])=0A=
+                             TCGArg idx, MemOp memop, void * const table[]=
)=0A=
 {=0A=
     memop =3D tcg_canonicalize_memop(memop, 1, 0);=0A=
 =0A=
@@ -3257,7 +3257,7 @@ static void * const table_##NAME[16] =3D {           =
                     \=0A=
     WITH_ATOMIC64([MO_64 | MO_BE] =3D gen_helper_atomic_##NAME##q_be)     =
\=0A=
 };                                                                      \=
=0A=
 void tcg_gen_atomic_##NAME##_i32                                        \=
=0A=
-    (TCGv_i32 ret, TCGv addr, TCGv_i32 val, TCGArg idx, TCGMemOp memop) \=
=0A=
+    (TCGv_i32 ret, TCGv addr, TCGv_i32 val, TCGArg idx, MemOp memop) \=0A=
 {                                                                       \=
=0A=
     if (tcg_ctx->tb_cflags & CF_PARALLEL) {                             \=
=0A=
         do_atomic_op_i32(ret, addr, val, idx, memop, table_##NAME);     \=
=0A=
@@ -3267,7 +3267,7 @@ void tcg_gen_atomic_##NAME##_i32                     =
                   \=0A=
     }                                                                   \=
=0A=
 }                                                                       \=
=0A=
 void tcg_gen_atomic_##NAME##_i64                                        \=
=0A=
-    (TCGv_i64 ret, TCGv addr, TCGv_i64 val, TCGArg idx, TCGMemOp memop) \=
=0A=
+    (TCGv_i64 ret, TCGv addr, TCGv_i64 val, TCGArg idx, MemOp memop) \=0A=
 {                                                                       \=
=0A=
     if (tcg_ctx->tb_cflags & CF_PARALLEL) {                             \=
=0A=
         do_atomic_op_i64(ret, addr, val, idx, memop, table_##NAME);     \=
=0A=
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h=0A=
index 2d4dd5cd7d..e9cf172762 100644=0A=
--- a/tcg/tcg-op.h=0A=
+++ b/tcg/tcg-op.h=0A=
@@ -851,10 +851,10 @@ void tcg_gen_lookup_and_goto_ptr(void);=0A=
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64=0A=
 #endif=0A=
 =0A=
-void tcg_gen_qemu_ld_i32(TCGv_i32, TCGv, TCGArg, TCGMemOp);=0A=
-void tcg_gen_qemu_st_i32(TCGv_i32, TCGv, TCGArg, TCGMemOp);=0A=
-void tcg_gen_qemu_ld_i64(TCGv_i64, TCGv, TCGArg, TCGMemOp);=0A=
-void tcg_gen_qemu_st_i64(TCGv_i64, TCGv, TCGArg, TCGMemOp);=0A=
+void tcg_gen_qemu_ld_i32(TCGv_i32, TCGv, TCGArg, MemOp);=0A=
+void tcg_gen_qemu_st_i32(TCGv_i32, TCGv, TCGArg, MemOp);=0A=
+void tcg_gen_qemu_ld_i64(TCGv_i64, TCGv, TCGArg, MemOp);=0A=
+void tcg_gen_qemu_st_i64(TCGv_i64, TCGv, TCGArg, MemOp);=0A=
 =0A=
 static inline void tcg_gen_qemu_ld8u(TCGv ret, TCGv addr, int mem_index)=
=0A=
 {=0A=
@@ -912,46 +912,46 @@ static inline void tcg_gen_qemu_st64(TCGv_i64 arg, TC=
Gv addr, int mem_index)=0A=
 }=0A=
 =0A=
 void tcg_gen_atomic_cmpxchg_i32(TCGv_i32, TCGv, TCGv_i32, TCGv_i32,=0A=
-                                TCGArg, TCGMemOp);=0A=
+                                TCGArg, MemOp);=0A=
 void tcg_gen_atomic_cmpxchg_i64(TCGv_i64, TCGv, TCGv_i64, TCGv_i64,=0A=
-                                TCGArg, TCGMemOp);=0A=
-=0A=
-void tcg_gen_atomic_xchg_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);=
=0A=
-void tcg_gen_atomic_xchg_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);=
=0A=
-=0A=
-void tcg_gen_atomic_fetch_add_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMem=
Op);=0A=
-void tcg_gen_atomic_fetch_add_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMem=
Op);=0A=
-void tcg_gen_atomic_fetch_and_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMem=
Op);=0A=
-void tcg_gen_atomic_fetch_and_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMem=
Op);=0A=
-void tcg_gen_atomic_fetch_or_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemO=
p);=0A=
-void tcg_gen_atomic_fetch_or_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemO=
p);=0A=
-void tcg_gen_atomic_fetch_xor_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMem=
Op);=0A=
-void tcg_gen_atomic_fetch_xor_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMem=
Op);=0A=
-void tcg_gen_atomic_fetch_smin_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);=0A=
-void tcg_gen_atomic_fetch_smin_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);=0A=
-void tcg_gen_atomic_fetch_umin_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);=0A=
-void tcg_gen_atomic_fetch_umin_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);=0A=
-void tcg_gen_atomic_fetch_smax_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);=0A=
-void tcg_gen_atomic_fetch_smax_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);=0A=
-void tcg_gen_atomic_fetch_umax_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);=0A=
-void tcg_gen_atomic_fetch_umax_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);=0A=
-=0A=
-void tcg_gen_atomic_add_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMem=
Op);=0A=
-void tcg_gen_atomic_add_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMem=
Op);=0A=
-void tcg_gen_atomic_and_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMem=
Op);=0A=
-void tcg_gen_atomic_and_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMem=
Op);=0A=
-void tcg_gen_atomic_or_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemO=
p);=0A=
-void tcg_gen_atomic_or_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemO=
p);=0A=
-void tcg_gen_atomic_xor_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMem=
Op);=0A=
-void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMem=
Op);=0A=
-void tcg_gen_atomic_smin_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);=0A=
-void tcg_gen_atomic_smin_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);=0A=
-void tcg_gen_atomic_umin_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);=0A=
-void tcg_gen_atomic_umin_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);=0A=
-void tcg_gen_atomic_smax_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);=0A=
-void tcg_gen_atomic_smax_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);=0A=
-void tcg_gen_atomic_umax_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);=0A=
-void tcg_gen_atomic_umax_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);=0A=
+                                TCGArg, MemOp);=0A=
+=0A=
+void tcg_gen_atomic_xchg_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);=0A=
+void tcg_gen_atomic_xchg_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);=0A=
+=0A=
+void tcg_gen_atomic_fetch_add_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp)=
;=0A=
+void tcg_gen_atomic_fetch_add_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp)=
;=0A=
+void tcg_gen_atomic_fetch_and_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp)=
;=0A=
+void tcg_gen_atomic_fetch_and_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp)=
;=0A=
+void tcg_gen_atomic_fetch_or_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);=
=0A=
+void tcg_gen_atomic_fetch_or_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);=
=0A=
+void tcg_gen_atomic_fetch_xor_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp)=
;=0A=
+void tcg_gen_atomic_fetch_xor_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp)=
;=0A=
+void tcg_gen_atomic_fetch_smin_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);=0A=
+void tcg_gen_atomic_fetch_smin_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);=0A=
+void tcg_gen_atomic_fetch_umin_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);=0A=
+void tcg_gen_atomic_fetch_umin_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);=0A=
+void tcg_gen_atomic_fetch_smax_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);=0A=
+void tcg_gen_atomic_fetch_smax_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);=0A=
+void tcg_gen_atomic_fetch_umax_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);=0A=
+void tcg_gen_atomic_fetch_umax_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);=0A=
+=0A=
+void tcg_gen_atomic_add_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp)=
;=0A=
+void tcg_gen_atomic_add_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp)=
;=0A=
+void tcg_gen_atomic_and_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp)=
;=0A=
+void tcg_gen_atomic_and_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp)=
;=0A=
+void tcg_gen_atomic_or_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);=
=0A=
+void tcg_gen_atomic_or_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);=
=0A=
+void tcg_gen_atomic_xor_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp)=
;=0A=
+void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp)=
;=0A=
+void tcg_gen_atomic_smin_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);=0A=
+void tcg_gen_atomic_smin_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);=0A=
+void tcg_gen_atomic_umin_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);=0A=
+void tcg_gen_atomic_umin_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);=0A=
+void tcg_gen_atomic_smax_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);=0A=
+void tcg_gen_atomic_smax_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);=0A=
+void tcg_gen_atomic_umax_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);=0A=
+void tcg_gen_atomic_umax_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);=0A=
 =0A=
 void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);=0A=
 void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);=0A=
diff --git a/tcg/tcg.c b/tcg/tcg.c=0A=
index be2c33c400..aa9931feb9 100644=0A=
--- a/tcg/tcg.c=0A=
+++ b/tcg/tcg.c=0A=
@@ -2056,7 +2056,7 @@ static void tcg_dump_ops(TCGContext *s, bool have_pre=
fs)=0A=
             case INDEX_op_qemu_st_i64:=0A=
                 {=0A=
                     TCGMemOpIdx oi =3D op->args[k++];=0A=
-                    TCGMemOp op =3D get_memop(oi);=0A=
+                    MemOp op =3D get_memop(oi);=0A=
                     unsigned ix =3D get_mmuidx(oi);=0A=
 =0A=
                     if (op & ~(MO_AMASK | MO_BSWAP | MO_SSIZE)) {=0A=
diff --git a/tcg/tcg.h b/tcg/tcg.h=0A=
index b411e17a28..a37181c899 100644=0A=
--- a/tcg/tcg.h=0A=
+++ b/tcg/tcg.h=0A=
@@ -26,6 +26,7 @@=0A=
 #define TCG_H=0A=
 =0A=
 #include "cpu.h"=0A=
+#include "exec/memop.h"=0A=
 #include "exec/tb-context.h"=0A=
 #include "qemu/bitops.h"=0A=
 #include "qemu/queue.h"=0A=
@@ -309,101 +310,13 @@ typedef enum TCGType {=0A=
 #endif=0A=
 } TCGType;=0A=
 =0A=
-/* Constants for qemu_ld and qemu_st for the Memory Operation field.  */=
=0A=
-typedef enum TCGMemOp {=0A=
-    MO_8     =3D 0,=0A=
-    MO_16    =3D 1,=0A=
-    MO_32    =3D 2,=0A=
-    MO_64    =3D 3,=0A=
-    MO_SIZE  =3D 3,   /* Mask for the above.  */=0A=
-=0A=
-    MO_SIGN  =3D 4,   /* Sign-extended, otherwise zero-extended.  */=0A=
-=0A=
-    MO_BSWAP =3D 8,   /* Host reverse endian.  */=0A=
-#ifdef HOST_WORDS_BIGENDIAN=0A=
-    MO_LE    =3D MO_BSWAP,=0A=
-    MO_BE    =3D 0,=0A=
-#else=0A=
-    MO_LE    =3D 0,=0A=
-    MO_BE    =3D MO_BSWAP,=0A=
-#endif=0A=
-#ifdef TARGET_WORDS_BIGENDIAN=0A=
-    MO_TE    =3D MO_BE,=0A=
-#else=0A=
-    MO_TE    =3D MO_LE,=0A=
-#endif=0A=
-=0A=
-    /* MO_UNALN accesses are never checked for alignment.=0A=
-     * MO_ALIGN accesses will result in a call to the CPU's=0A=
-     * do_unaligned_access hook if the guest address is not aligned.=0A=
-     * The default depends on whether the target CPU defines ALIGNED_ONLY.=
=0A=
-     *=0A=
-     * Some architectures (e.g. ARMv8) need the address which is aligned=
=0A=
-     * to a size more than the size of the memory access.=0A=
-     * Some architectures (e.g. SPARCv9) need an address which is aligned,=
=0A=
-     * but less strictly than the natural alignment.=0A=
-     *=0A=
-     * MO_ALIGN supposes the alignment size is the size of a memory access=
.=0A=
-     *=0A=
-     * There are three options:=0A=
-     * - unaligned access permitted (MO_UNALN).=0A=
-     * - an alignment to the size of an access (MO_ALIGN);=0A=
-     * - an alignment to a specified size, which may be more or less than=
=0A=
-     *   the access size (MO_ALIGN_x where 'x' is a size in bytes);=0A=
-     */=0A=
-    MO_ASHIFT =3D 4,=0A=
-    MO_AMASK =3D 7 << MO_ASHIFT,=0A=
-#ifdef ALIGNED_ONLY=0A=
-    MO_ALIGN =3D 0,=0A=
-    MO_UNALN =3D MO_AMASK,=0A=
-#else=0A=
-    MO_ALIGN =3D MO_AMASK,=0A=
-    MO_UNALN =3D 0,=0A=
-#endif=0A=
-    MO_ALIGN_2  =3D 1 << MO_ASHIFT,=0A=
-    MO_ALIGN_4  =3D 2 << MO_ASHIFT,=0A=
-    MO_ALIGN_8  =3D 3 << MO_ASHIFT,=0A=
-    MO_ALIGN_16 =3D 4 << MO_ASHIFT,=0A=
-    MO_ALIGN_32 =3D 5 << MO_ASHIFT,=0A=
-    MO_ALIGN_64 =3D 6 << MO_ASHIFT,=0A=
-=0A=
-    /* Combinations of the above, for ease of use.  */=0A=
-    MO_UB    =3D MO_8,=0A=
-    MO_UW    =3D MO_16,=0A=
-    MO_UL    =3D MO_32,=0A=
-    MO_SB    =3D MO_SIGN | MO_8,=0A=
-    MO_SW    =3D MO_SIGN | MO_16,=0A=
-    MO_SL    =3D MO_SIGN | MO_32,=0A=
-    MO_Q     =3D MO_64,=0A=
-=0A=
-    MO_LEUW  =3D MO_LE | MO_UW,=0A=
-    MO_LEUL  =3D MO_LE | MO_UL,=0A=
-    MO_LESW  =3D MO_LE | MO_SW,=0A=
-    MO_LESL  =3D MO_LE | MO_SL,=0A=
-    MO_LEQ   =3D MO_LE | MO_Q,=0A=
-=0A=
-    MO_BEUW  =3D MO_BE | MO_UW,=0A=
-    MO_BEUL  =3D MO_BE | MO_UL,=0A=
-    MO_BESW  =3D MO_BE | MO_SW,=0A=
-    MO_BESL  =3D MO_BE | MO_SL,=0A=
-    MO_BEQ   =3D MO_BE | MO_Q,=0A=
-=0A=
-    MO_TEUW  =3D MO_TE | MO_UW,=0A=
-    MO_TEUL  =3D MO_TE | MO_UL,=0A=
-    MO_TESW  =3D MO_TE | MO_SW,=0A=
-    MO_TESL  =3D MO_TE | MO_SL,=0A=
-    MO_TEQ   =3D MO_TE | MO_Q,=0A=
-=0A=
-    MO_SSIZE =3D MO_SIZE | MO_SIGN,=0A=
-} TCGMemOp;=0A=
-=0A=
 /**=0A=
  * get_alignment_bits=0A=
- * @memop: TCGMemOp value=0A=
+ * @memop: MemOp value=0A=
  *=0A=
  * Extract the alignment size from the memop.=0A=
  */=0A=
-static inline unsigned get_alignment_bits(TCGMemOp memop)=0A=
+static inline unsigned get_alignment_bits(MemOp memop)=0A=
 {=0A=
     unsigned a =3D memop & MO_AMASK;=0A=
 =0A=
@@ -1184,7 +1097,7 @@ static inline size_t tcg_current_code_size(TCGContext=
 *s)=0A=
     return tcg_ptr_byte_diff(s->code_ptr, s->code_buf);=0A=
 }=0A=
 =0A=
-/* Combine the TCGMemOp and mmu_idx parameters into a single value.  */=0A=
+/* Combine the MemOp and mmu_idx parameters into a single value.  */=0A=
 typedef uint32_t TCGMemOpIdx;=0A=
 =0A=
 /**=0A=
@@ -1194,7 +1107,7 @@ typedef uint32_t TCGMemOpIdx;=0A=
  *=0A=
  * Encode these values into a single parameter.=0A=
  */=0A=
-static inline TCGMemOpIdx make_memop_idx(TCGMemOp op, unsigned idx)=0A=
+static inline TCGMemOpIdx make_memop_idx(MemOp op, unsigned idx)=0A=
 {=0A=
     tcg_debug_assert(idx <=3D 15);=0A=
     return (op << 4) | idx;=0A=
@@ -1206,7 +1119,7 @@ static inline TCGMemOpIdx make_memop_idx(TCGMemOp op,=
 unsigned idx)=0A=
  *=0A=
  * Extract the memory operation from the combined value.=0A=
  */=0A=
-static inline TCGMemOp get_memop(TCGMemOpIdx oi)=0A=
+static inline MemOp get_memop(TCGMemOpIdx oi)=0A=
 {=0A=
     return oi >> 4;=0A=
 }=0A=
diff --git a/trace/mem-internal.h b/trace/mem-internal.h=0A=
index f6efaf6d6b..3444fbc596 100644=0A=
--- a/trace/mem-internal.h=0A=
+++ b/trace/mem-internal.h=0A=
@@ -16,7 +16,7 @@=0A=
 #define TRACE_MEM_ST (1ULL << 5)    /* store (y/n) */=0A=
 =0A=
 static inline uint8_t trace_mem_build_info(=0A=
-    int size_shift, bool sign_extend, TCGMemOp endianness, bool store)=0A=
+    int size_shift, bool sign_extend, MemOp endianness, bool store)=0A=
 {=0A=
     uint8_t res;=0A=
 =0A=
@@ -33,7 +33,7 @@ static inline uint8_t trace_mem_build_info(=0A=
     return res;=0A=
 }=0A=
 =0A=
-static inline uint8_t trace_mem_get_info(TCGMemOp op, bool store)=0A=
+static inline uint8_t trace_mem_get_info(MemOp op, bool store)=0A=
 {=0A=
     return trace_mem_build_info(op & MO_SIZE, !!(op & MO_SIGN),=0A=
                                 op & MO_BSWAP, store);=0A=
diff --git a/trace/mem.h b/trace/mem.h=0A=
index 2b58196e53..8cf213d85b 100644=0A=
--- a/trace/mem.h=0A=
+++ b/trace/mem.h=0A=
@@ -18,7 +18,7 @@=0A=
  *=0A=
  * Return a value for the 'info' argument in guest memory access traces.=
=0A=
  */=0A=
-static uint8_t trace_mem_get_info(TCGMemOp op, bool store);=0A=
+static uint8_t trace_mem_get_info(MemOp op, bool store);=0A=
 =0A=
 /**=0A=
  * trace_mem_build_info:=0A=
@@ -26,7 +26,7 @@ static uint8_t trace_mem_get_info(TCGMemOp op, bool store=
);=0A=
  * Return a value for the 'info' argument in guest memory access traces.=
=0A=
  */=0A=
 static uint8_t trace_mem_build_info(int size_shift, bool sign_extend,=0A=
-                                    TCGMemOp endianness, bool store);=0A=
+                                    MemOp endianness, bool store);=0A=
 =0A=
 =0A=
 #include "trace/mem-internal.h"=0A=
-- =0A=
2.17.2=0A=

