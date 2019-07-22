Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34992C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD542171F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD542171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpaUn-0006jn-9C
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 11:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52686)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hpaUZ-0006Ke-DM
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hpaUV-0004fC-KI
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:44:47 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.236]:37940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hpaUF-0004Ux-Jz; Mon, 22 Jul 2019 11:44:28 -0400
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 RDW083A009ED65.bt.com (10.187.98.35) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 22 Jul 2019 16:40:47 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18e.domain1.systemhost.net (10.9.212.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Mon, 22 Jul 2019 16:44:24 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Mon, 22 Jul
 2019 16:44:24 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 06/20] tcg: Rename get_memop to
 get_tcgmemop
Thread-Index: AQHVQKRWuilU/GWOfUKTTPphRrvupQ==
Date: Mon, 22 Jul 2019 15:44:24 +0000
Message-ID: <1563810264064.38406@bt.com>
References: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.37]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.236
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v2 06/20] tcg: Rename get_memop to get_tcgmemop
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

Correct naming as there is now both MemOp and TCGMemOp.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 accel/tcg/cputlb.c           |  6 +++---
 tcg/aarch64/tcg-target.inc.c |  8 ++++----
 tcg/arm/tcg-target.inc.c     |  8 ++++----
 tcg/i386/tcg-target.inc.c    |  8 ++++----
 tcg/mips/tcg-target.inc.c    | 10 +++++-----
 tcg/optimize.c               |  2 +-
 tcg/ppc/tcg-target.inc.c     |  8 ++++----
 tcg/riscv/tcg-target.inc.c   | 10 +++++-----
 tcg/s390/tcg-target.inc.c    |  8 ++++----
 tcg/sparc/tcg-target.inc.c   |  4 ++--
 tcg/tcg.c                    |  2 +-
 tcg/tcg.h                    |  4 ++--
 tcg/tci.c                    |  8 ++++----
 13 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index bb9897b..184fc54 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1133,7 +1133,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, tar=
get_ulong addr,
     uintptr_t index =3D tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *tlbe =3D tlb_entry(env, mmu_idx, addr);
     target_ulong tlb_addr =3D tlb_addr_write(tlbe);
-    TCGMemOp mop =3D get_memop(oi);
+    TCGMemOp mop =3D get_tcgmemop(oi);
     int a_bits =3D get_alignment_bits(mop);
     int s_bits =3D mop & MO_SIZE;
     void *hostaddr;
@@ -1257,7 +1257,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCG=
MemOpIdx oi,
         offsetof(CPUTLBEntry, addr_code) : offsetof(CPUTLBEntry, addr_read=
);
     const MMUAccessType access_type =3D
         code_read ? MMU_INST_FETCH : MMU_DATA_LOAD;
-    unsigned a_bits =3D get_alignment_bits(get_memop(oi));
+    unsigned a_bits =3D get_alignment_bits(get_tcgmemop(oi));
     void *haddr;
     uint64_t res;

@@ -1506,7 +1506,7 @@ store_helper(CPUArchState *env, target_ulong addr, ui=
nt64_t val,
     CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
     target_ulong tlb_addr =3D tlb_addr_write(entry);
     const size_t tlb_off =3D offsetof(CPUTLBEntry, addr_write);
-    unsigned a_bits =3D get_alignment_bits(get_memop(oi));
+    unsigned a_bits =3D get_alignment_bits(get_tcgmemop(oi));
     void *haddr;

     /* Handle CPU specific unaligned behaviour */
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index d14afa9..886da51 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1580,7 +1580,7 @@ static inline void tcg_out_adr(TCGContext *s, TCGReg =
rd, void *target)
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
     TCGMemOp size =3D opc & MO_SIZE;

     if (!reloc_pc19(lb->label_ptr[0], s->code_ptr)) {
@@ -1605,7 +1605,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
     TCGMemOp size =3D opc & MO_SIZE;

     if (!reloc_pc19(lb->label_ptr[0], s->code_ptr)) {
@@ -1804,7 +1804,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
MemOp memop,
 static void tcg_out_qemu_ld(TCGContext *s, TCGReg data_reg, TCGReg addr_re=
g,
                             TCGMemOpIdx oi, TCGType ext)
 {
-    TCGMemOp memop =3D get_memop(oi);
+    TCGMemOp memop =3D get_tcgmemop(oi);
     const TCGType otype =3D TARGET_LONG_BITS =3D=3D 64 ? TCG_TYPE_I64 : TC=
G_TYPE_I32;
 #ifdef CONFIG_SOFTMMU
     unsigned mem_index =3D get_mmuidx(oi);
@@ -1829,7 +1829,7 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg dat=
a_reg, TCGReg addr_reg,
 static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_re=
g,
                             TCGMemOpIdx oi)
 {
-    TCGMemOp memop =3D get_memop(oi);
+    TCGMemOp memop =3D get_tcgmemop(oi);
     const TCGType otype =3D TARGET_LONG_BITS =3D=3D 64 ? TCG_TYPE_I64 : TC=
G_TYPE_I32;
 #ifdef CONFIG_SOFTMMU
     unsigned mem_index =3D get_mmuidx(oi);
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 70eeb8a..98c5b47 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1348,7 +1348,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
 {
     TCGReg argreg, datalo, datahi;
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
     void *func;

     if (!reloc_pc24(lb->label_ptr[0], s->code_ptr)) {
@@ -1412,7 +1412,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
 {
     TCGReg argreg, datalo, datahi;
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);

     if (!reloc_pc24(lb->label_ptr[0], s->code_ptr)) {
         return false;
@@ -1589,7 +1589,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is64)
     addrlo =3D *args++;
     addrhi =3D (TARGET_LONG_BITS =3D=3D 64 ? *args++ : 0);
     oi =3D *args++;
-    opc =3D get_memop(oi);
+    opc =3D get_tcgmemop(oi);

 #ifdef CONFIG_SOFTMMU
     mem_index =3D get_mmuidx(oi);
@@ -1720,7 +1720,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is64)
     addrlo =3D *args++;
     addrhi =3D (TARGET_LONG_BITS =3D=3D 64 ? *args++ : 0);
     oi =3D *args++;
-    opc =3D get_memop(oi);
+    opc =3D get_tcgmemop(oi);

 #ifdef CONFIG_SOFTMMU
     mem_index =3D get_mmuidx(oi);
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 3a73334..e4525ca 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1810,7 +1810,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool i=
s_ld, bool is_64,
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi =3D l->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
     TCGReg data_reg;
     tcg_insn_unit **label_ptr =3D &l->label_ptr[0];
     int rexw =3D (l->type =3D=3D TCG_TYPE_I64 ? P_REXW : 0);
@@ -1895,7 +1895,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi =3D l->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
     TCGMemOp s_bits =3D opc & MO_SIZE;
     tcg_insn_unit **label_ptr =3D &l->label_ptr[0];
     TCGReg retaddr;
@@ -2114,7 +2114,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is64)
     addrlo =3D *args++;
     addrhi =3D (TARGET_LONG_BITS > TCG_TARGET_REG_BITS ? *args++ : 0);
     oi =3D *args++;
-    opc =3D get_memop(oi);
+    opc =3D get_tcgmemop(oi);

 #if defined(CONFIG_SOFTMMU)
     mem_index =3D get_mmuidx(oi);
@@ -2232,7 +2232,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is64)
     addrlo =3D *args++;
     addrhi =3D (TARGET_LONG_BITS > TCG_TARGET_REG_BITS ? *args++ : 0);
     oi =3D *args++;
-    opc =3D get_memop(oi);
+    opc =3D get_tcgmemop(oi);

 #if defined(CONFIG_SOFTMMU)
     mem_index =3D get_mmuidx(oi);
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index ef31fc8..010afd0 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1215,7 +1215,7 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg ba=
se, TCGReg addrl,
                              TCGReg addrh, TCGMemOpIdx oi,
                              tcg_insn_unit *label_ptr[2], bool is_load)
 {
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
     unsigned s_bits =3D opc & MO_SIZE;
     unsigned a_bits =3D get_alignment_bits(opc);
     int mem_index =3D get_mmuidx(oi);
@@ -1313,7 +1313,7 @@ static void add_qemu_ldst_label(TCGContext *s, int is=
_ld, TCGMemOpIdx oi,
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi =3D l->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
     TCGReg v0;
     int i;

@@ -1363,7 +1363,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi =3D l->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
     TCGMemOp s_bits =3D opc & MO_SIZE;
     int i;

@@ -1532,7 +1532,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is_64)
     addr_regl =3D *args++;
     addr_regh =3D (TCG_TARGET_REG_BITS < TARGET_LONG_BITS ? *args++ : 0);
     oi =3D *args++;
-    opc =3D get_memop(oi);
+    opc =3D get_tcgmemop(oi);

 #if defined(CONFIG_SOFTMMU)
     tcg_out_tlb_load(s, base, addr_regl, addr_regh, oi, label_ptr, 1);
@@ -1635,7 +1635,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is_64)
     addr_regl =3D *args++;
     addr_regh =3D (TCG_TARGET_REG_BITS < TARGET_LONG_BITS ? *args++ : 0);
     oi =3D *args++;
-    opc =3D get_memop(oi);
+    opc =3D get_tcgmemop(oi);

 #if defined(CONFIG_SOFTMMU)
     tcg_out_tlb_load(s, base, addr_regl, addr_regh, oi, label_ptr, 0);
diff --git a/tcg/optimize.c b/tcg/optimize.c
index d2424de..422bcbb 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1014,7 +1014,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(qemu_ld):
             {
                 TCGMemOpIdx oi =3D op->args[nb_oargs + nb_iargs];
-                TCGMemOp mop =3D get_memop(oi);
+                TCGMemOp mop =3D get_tcgmemop(oi);
                 if (!(mop & MO_SIGN)) {
                     mask =3D (2ULL << ((8 << (mop & MO_SIZE)) - 1)) - 1;
                 }
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 13a2437..0ab4faa 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1633,7 +1633,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool i=
s_ld, TCGMemOpIdx oi,
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
     TCGReg hi, lo, arg =3D TCG_REG_R3;

     if (!reloc_pc14(lb->label_ptr[0], s->code_ptr)) {
@@ -1680,7 +1680,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
     TCGMemOp s_bits =3D opc & MO_SIZE;
     TCGReg hi, lo, arg =3D TCG_REG_R3;

@@ -1755,7 +1755,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is_64)
     addrlo =3D *args++;
     addrhi =3D (TCG_TARGET_REG_BITS < TARGET_LONG_BITS ? *args++ : 0);
     oi =3D *args++;
-    opc =3D get_memop(oi);
+    opc =3D get_tcgmemop(oi);
     s_bits =3D opc & MO_SIZE;

 #ifdef CONFIG_SOFTMMU
@@ -1830,7 +1830,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is_64)
     addrlo =3D *args++;
     addrhi =3D (TCG_TARGET_REG_BITS < TARGET_LONG_BITS ? *args++ : 0);
     oi =3D *args++;
-    opc =3D get_memop(oi);
+    opc =3D get_tcgmemop(oi);
     s_bits =3D opc & MO_SIZE;

 #ifdef CONFIG_SOFTMMU
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 90363df..ab4e035 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -970,7 +970,7 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg addr=
l,
                              TCGReg addrh, TCGMemOpIdx oi,
                              tcg_insn_unit **label_ptr, bool is_load)
 {
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
     unsigned s_bits =3D opc & MO_SIZE;
     unsigned a_bits =3D get_alignment_bits(opc);
     tcg_target_long compare_mask;
@@ -1044,7 +1044,7 @@ static void add_qemu_ldst_label(TCGContext *s, int is=
_ld, TCGMemOpIdx oi,
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi =3D l->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
     TCGReg a0 =3D tcg_target_call_iarg_regs[0];
     TCGReg a1 =3D tcg_target_call_iarg_regs[1];
     TCGReg a2 =3D tcg_target_call_iarg_regs[2];
@@ -1077,7 +1077,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi =3D l->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
     TCGMemOp s_bits =3D opc & MO_SIZE;
     TCGReg a0 =3D tcg_target_call_iarg_regs[0];
     TCGReg a1 =3D tcg_target_call_iarg_regs[1];
@@ -1183,7 +1183,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is_64)
     addr_regl =3D *args++;
     addr_regh =3D (TCG_TARGET_REG_BITS < TARGET_LONG_BITS ? *args++ : 0);
     oi =3D *args++;
-    opc =3D get_memop(oi);
+    opc =3D get_tcgmemop(oi);

 #if defined(CONFIG_SOFTMMU)
     tcg_out_tlb_load(s, addr_regl, addr_regh, oi, label_ptr, 1);
@@ -1254,7 +1254,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is_64)
     addr_regl =3D *args++;
     addr_regh =3D (TCG_TARGET_REG_BITS < TARGET_LONG_BITS ? *args++ : 0);
     oi =3D *args++;
-    opc =3D get_memop(oi);
+    opc =3D get_tcgmemop(oi);

 #if defined(CONFIG_SOFTMMU)
     tcg_out_tlb_load(s, addr_regl, addr_regh, oi, label_ptr, 0);
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index db1102e..4d8078b 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -1614,7 +1614,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
     TCGReg addr_reg =3D lb->addrlo_reg;
     TCGReg data_reg =3D lb->datalo_reg;
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);

     if (!patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
                      (intptr_t)s->code_ptr, 2)) {
@@ -1639,7 +1639,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
     TCGReg addr_reg =3D lb->addrlo_reg;
     TCGReg data_reg =3D lb->datalo_reg;
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);

     if (!patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
                      (intptr_t)s->code_ptr, 2)) {
@@ -1694,7 +1694,7 @@ static void tcg_prepare_user_ldst(TCGContext *s, TCGR=
eg *addr_reg,
 static void tcg_out_qemu_ld(TCGContext* s, TCGReg data_reg, TCGReg addr_re=
g,
                             TCGMemOpIdx oi)
 {
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
 #ifdef CONFIG_SOFTMMU
     unsigned mem_index =3D get_mmuidx(oi);
     tcg_insn_unit *label_ptr;
@@ -1721,7 +1721,7 @@ static void tcg_out_qemu_ld(TCGContext* s, TCGReg dat=
a_reg, TCGReg addr_reg,
 static void tcg_out_qemu_st(TCGContext* s, TCGReg data_reg, TCGReg addr_re=
g,
                             TCGMemOpIdx oi)
 {
-    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp opc =3D get_tcgmemop(oi);
 #ifdef CONFIG_SOFTMMU
     unsigned mem_index =3D get_mmuidx(oi);
     tcg_insn_unit *label_ptr;
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 7c50118..e6cf2c4 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -1164,7 +1164,7 @@ static const int qemu_st_opc[16] =3D {
 static void tcg_out_qemu_ld(TCGContext *s, TCGReg data, TCGReg addr,
                             TCGMemOpIdx oi, bool is_64)
 {
-    TCGMemOp memop =3D get_memop(oi);
+    TCGMemOp memop =3D get_tcgmemop(oi);
 #ifdef CONFIG_SOFTMMU
     unsigned memi =3D get_mmuidx(oi);
     TCGReg addrz, param;
@@ -1246,7 +1246,7 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg dat=
a, TCGReg addr,
 static void tcg_out_qemu_st(TCGContext *s, TCGReg data, TCGReg addr,
                             TCGMemOpIdx oi)
 {
-    TCGMemOp memop =3D get_memop(oi);
+    TCGMemOp memop =3D get_tcgmemop(oi);
 #ifdef CONFIG_SOFTMMU
     unsigned memi =3D get_mmuidx(oi);
     TCGReg addrz, param;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index be2c33c..492d7c6 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2056,7 +2056,7 @@ static void tcg_dump_ops(TCGContext *s, bool have_pre=
fs)
             case INDEX_op_qemu_st_i64:
                 {
                     TCGMemOpIdx oi =3D op->args[k++];
-                    TCGMemOp op =3D get_memop(oi);
+                    TCGMemOp op =3D get_tcgmemop(oi);
                     unsigned ix =3D get_mmuidx(oi);

                     if (op & ~(MO_AMASK | MO_BSWAP | MO_SSIZE)) {
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 18b91fe..8a3f912 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1197,12 +1197,12 @@ static inline TCGMemOpIdx make_memop_idx(TCGMemOp o=
p, unsigned idx)
 }

 /**
- * get_memop
+ * get_tcgmemop
  * @oi: combined op/idx parameter
  *
  * Extract the memory operation from the combined value.
  */
-static inline TCGMemOp get_memop(TCGMemOpIdx oi)
+static inline TCGMemOp get_tcgmemop(TCGMemOpIdx oi)
 {
     return oi >> 4;
 }
diff --git a/tcg/tci.c b/tcg/tci.c
index 33edca1..b3c5795 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -1109,7 +1109,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t=
 *tb_ptr)
             t0 =3D *tb_ptr++;
             taddr =3D tci_read_ulong(regs, &tb_ptr);
             oi =3D tci_read_i(&tb_ptr);
-            switch (get_memop(oi) & (MO_BSWAP | MO_SSIZE)) {
+            switch (get_tcgmemop(oi) & (MO_BSWAP | MO_SSIZE)) {
             case MO_UB:
                 tmp32 =3D qemu_ld_ub;
                 break;
@@ -1146,7 +1146,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t=
 *tb_ptr)
             }
             taddr =3D tci_read_ulong(regs, &tb_ptr);
             oi =3D tci_read_i(&tb_ptr);
-            switch (get_memop(oi) & (MO_BSWAP | MO_SSIZE)) {
+            switch (get_tcgmemop(oi) & (MO_BSWAP | MO_SSIZE)) {
             case MO_UB:
                 tmp64 =3D qemu_ld_ub;
                 break;
@@ -1195,7 +1195,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t=
 *tb_ptr)
             t0 =3D tci_read_r(regs, &tb_ptr);
             taddr =3D tci_read_ulong(regs, &tb_ptr);
             oi =3D tci_read_i(&tb_ptr);
-            switch (get_memop(oi) & (MO_BSWAP | MO_SIZE)) {
+            switch (get_tcgmemop(oi) & (MO_BSWAP | MO_SIZE)) {
             case MO_UB:
                 qemu_st_b(t0);
                 break;
@@ -1219,7 +1219,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t=
 *tb_ptr)
             tmp64 =3D tci_read_r64(regs, &tb_ptr);
             taddr =3D tci_read_ulong(regs, &tb_ptr);
             oi =3D tci_read_i(&tb_ptr);
-            switch (get_memop(oi) & (MO_BSWAP | MO_SIZE)) {
+            switch (get_tcgmemop(oi) & (MO_BSWAP | MO_SIZE)) {
             case MO_UB:
                 qemu_st_b(tmp64);
                 break;
--
1.8.3.1



