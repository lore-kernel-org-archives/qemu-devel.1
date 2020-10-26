Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7499C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D59222C8
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D59222C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6m8-0007eF-4a
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kX6Ff-0000Q0-GR; Mon, 26 Oct 2020 13:25:48 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:35455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kX6Fc-0001A1-51; Mon, 26 Oct 2020 13:25:47 -0400
Received: by mail-pl1-f171.google.com with SMTP id 1so5058198ple.2;
 Mon, 26 Oct 2020 10:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lp3eQ5dfl7ZGrGdgAQ5O3x1+MzT+FnaKHiyhmFXcTNw=;
 b=l4mc4uNrw8+b/xPhLm/VNrQKr3VbutpNuDmKBW0LTdXCFaQgYvlVLO2PX3JGU5AY8c
 FOkiUZb8BDnDmZoJ3Dp0e6IBGM1jZauj3I3qYkX7aTnsQTmBPXpOqGC4CWuz6kPCF0RU
 bLucvDvf3T90QGz0u1P+OclahPT6ewWzbX5SjW815/Rb9yd48/fI7jZOppkvDLKtz2L4
 13bX9yqI0Mu2TBdOo1Lbi2Fn12yWiLXOb0gnS82Nf+UPNaB32Oo1T6gIfUpCVxpMb5U4
 +ylihz7KV9Hg/zUeRW4RjcVYHrcm6Q7OfHfUJtex23dWn8hCGJy7ZrexLTyTYklCNPXb
 Bc4A==
X-Gm-Message-State: AOAM533Fmi8dXYcmQ0qjWrJl6Na+mqxuZXGN+s4bGgii9GyyVYkFoG1K
 swYD394kUj0s3D9sC9I49qfZlnp8yUM=
X-Google-Smtp-Source: ABdhPJyuEzydS2T4QNp4sNp4o7UoAUdSXd7LfJywH2MuXVZEB26Bmnvf6b39uffB22ohoZNbPU6/qg==
X-Received: by 2002:a17:90a:66cc:: with SMTP id
 z12mr21537428pjl.145.1603733140300; 
 Mon, 26 Oct 2020 10:25:40 -0700 (PDT)
Received: from localhost.localdomain ([73.93.154.188])
 by smtp.gmail.com with ESMTPSA id j20sm12723075pfd.40.2020.10.26.10.25.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Oct 2020 10:25:39 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] tcg: add const hints for code pointers
Date: Mon, 26 Oct 2020 10:25:32 -0700
Message-Id: <20201026172535.10419-2-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026172535.10419-1-j@getutm.app>
References: <20201026172535.10419-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.171;
 envelope-from=osy86github@gmail.com; helo=mail-pl1-f171.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:25:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "open list:S390 TCG target" <qemu-s390x@nongnu.org>,
 "open list:AArch64 TCG target" <qemu-arm@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Joelle van Dyne <j@getutm.app>,
 Huacai Chen <chenhc@lemote.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will introduce mirror mapping for JIT segment with separate RX and RW
access. Adding 'const' hints will make it easier to identify read-only
accesses and allow us to easier catch bugs at compile time in the future.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 include/tcg/tcg.h            |  8 ++++----
 tcg/tcg.c                    |  4 ++--
 tcg/aarch64/tcg-target.c.inc | 19 +++++++++++--------
 tcg/arm/tcg-target.c.inc     | 12 +++++++-----
 tcg/i386/tcg-target.c.inc    | 10 +++++-----
 tcg/mips/tcg-target.c.inc    | 33 +++++++++++++++++++--------------
 tcg/ppc/tcg-target.c.inc     | 23 ++++++++++++++---------
 tcg/riscv/tcg-target.c.inc   | 11 ++++++-----
 tcg/s390/tcg-target.c.inc    |  9 +++++----
 tcg/sparc/tcg-target.c.inc   | 10 +++++-----
 tcg/tcg-ldst.c.inc           |  2 +-
 tcg/tci/tcg-target.c.inc     |  2 +-
 12 files changed, 80 insertions(+), 63 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 8804a8c4a2..79c5ff8dab 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -261,7 +261,7 @@ struct TCGLabel {
     unsigned refs : 16;
     union {
         uintptr_t value;
-        tcg_insn_unit *value_ptr;
+        const tcg_insn_unit *value_ptr;
     } u;
     QSIMPLEQ_HEAD(, TCGRelocation) relocs;
     QSIMPLEQ_ENTRY(TCGLabel) next;
@@ -593,7 +593,7 @@ struct TCGContext {
     int nb_ops;
 
     /* goto_tb support */
-    tcg_insn_unit *code_buf;
+    const tcg_insn_unit *code_buf;
     uint16_t *tb_jmp_reset_offset; /* tb->jmp_reset_offset */
     uintptr_t *tb_jmp_insn_offset; /* tb->jmp_target_arg if direct_jump */
     uintptr_t *tb_jmp_target_addr; /* tb->jmp_target_arg if !direct_jump */
@@ -1099,7 +1099,7 @@ static inline TCGLabel *arg_label(TCGArg i)
  * correct result.
  */
 
-static inline ptrdiff_t tcg_ptr_byte_diff(void *a, void *b)
+static inline ptrdiff_t tcg_ptr_byte_diff(const void *a, const void *b)
 {
     return a - b;
 }
@@ -1113,7 +1113,7 @@ static inline ptrdiff_t tcg_ptr_byte_diff(void *a, void *b)
  * to the destination address.
  */
 
-static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, void *target)
+static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, const void *target)
 {
     return tcg_ptr_byte_diff(target, s->code_ptr);
 }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a8c28440e2..bb890c506d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -148,7 +148,7 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg, TCGReg arg1,
                        intptr_t arg2);
 static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
                         TCGReg base, intptr_t ofs);
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *target);
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target);
 static int tcg_target_const_match(tcg_target_long val, TCGType type,
                                   const TCGArgConstraint *arg_ct);
 #ifdef TCG_TARGET_NEED_LDST_LABELS
@@ -295,7 +295,7 @@ static void tcg_out_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
     QSIMPLEQ_INSERT_TAIL(&l->relocs, r, next);
 }
 
-static void tcg_out_label(TCGContext *s, TCGLabel *l, tcg_insn_unit *ptr)
+static void tcg_out_label(TCGContext *s, TCGLabel *l, const tcg_insn_unit *ptr)
 {
     tcg_debug_assert(!l->has_value);
     l->has_value = 1;
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 26f71cb599..1aa5f37fc6 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -78,7 +78,8 @@ static const int tcg_target_call_oarg_regs[1] = {
 #define TCG_REG_GUEST_BASE TCG_REG_X28
 #endif
 
-static inline bool reloc_pc26(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static inline bool reloc_pc26(tcg_insn_unit *code_ptr,
+                              const tcg_insn_unit *target)
 {
     ptrdiff_t offset = target - code_ptr;
     if (offset == sextract64(offset, 0, 26)) {
@@ -90,7 +91,8 @@ static inline bool reloc_pc26(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
     return false;
 }
 
-static inline bool reloc_pc19(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static inline bool reloc_pc19(tcg_insn_unit *code_ptr,
+                              const tcg_insn_unit *target)
 {
     ptrdiff_t offset = target - code_ptr;
     if (offset == sextract64(offset, 0, 19)) {
@@ -1306,14 +1308,14 @@ static void tcg_out_cmp(TCGContext *s, TCGType ext, TCGReg a,
     }
 }
 
-static inline void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
+static inline void tcg_out_goto(TCGContext *s, const tcg_insn_unit *target)
 {
     ptrdiff_t offset = target - s->code_ptr;
     tcg_debug_assert(offset == sextract64(offset, 0, 26));
     tcg_out_insn(s, 3206, B, offset);
 }
 
-static inline void tcg_out_goto_long(TCGContext *s, tcg_insn_unit *target)
+static inline void tcg_out_goto_long(TCGContext *s, const tcg_insn_unit *target)
 {
     ptrdiff_t offset = target - s->code_ptr;
     if (offset == sextract64(offset, 0, 26)) {
@@ -1329,7 +1331,7 @@ static inline void tcg_out_callr(TCGContext *s, TCGReg reg)
     tcg_out_insn(s, 3207, BLR, reg);
 }
 
-static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
+static inline void tcg_out_call(TCGContext *s, const tcg_insn_unit *target)
 {
     ptrdiff_t offset = target - s->code_ptr;
     if (offset == sextract64(offset, 0, 26)) {
@@ -1568,7 +1570,7 @@ static void * const qemu_st_helpers[16] = {
     [MO_BEQ]  = helper_be_stq_mmu,
 };
 
-static inline void tcg_out_adr(TCGContext *s, TCGReg rd, void *target)
+static inline void tcg_out_adr(TCGContext *s, TCGReg rd, const void *target)
 {
     ptrdiff_t offset = tcg_pcrel_diff(s, target);
     tcg_debug_assert(offset == sextract64(offset, 0, 21));
@@ -1622,7 +1624,8 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 
 static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
                                 TCGType ext, TCGReg data_reg, TCGReg addr_reg,
-                                tcg_insn_unit *raddr, tcg_insn_unit *label_ptr)
+                                const tcg_insn_unit *raddr,
+                                tcg_insn_unit *label_ptr)
 {
     TCGLabelQemuLdst *label = new_ldst_label(s);
 
@@ -1849,7 +1852,7 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
 #endif /* CONFIG_SOFTMMU */
 }
 
-static tcg_insn_unit *tb_ret_addr;
+static const tcg_insn_unit *tb_ret_addr;
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                        const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 62c37a954b..5ceb06a971 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -187,7 +187,8 @@ static const uint8_t tcg_cond_to_arm_cond[] = {
     [TCG_COND_GTU] = COND_HI,
 };
 
-static inline bool reloc_pc24(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static inline bool reloc_pc24(tcg_insn_unit *code_ptr,
+                              const tcg_insn_unit *target)
 {
     ptrdiff_t offset = (tcg_ptr_byte_diff(target, code_ptr) - 8) >> 2;
     if (offset == sextract32(offset, 0, 24)) {
@@ -197,7 +198,8 @@ static inline bool reloc_pc24(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
     return false;
 }
 
-static inline bool reloc_pc13(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static inline bool reloc_pc13(tcg_insn_unit *code_ptr,
+                              const tcg_insn_unit *target)
 {
     ptrdiff_t offset = tcg_ptr_byte_diff(target, code_ptr) - 8;
 
@@ -1019,7 +1021,7 @@ static inline void tcg_out_st8(TCGContext *s, int cond,
  * with the code buffer limited to 16MB we wouldn't need the long case.
  * But we also use it for the tail-call to the qemu_ld/st helpers, which does.
  */
-static void tcg_out_goto(TCGContext *s, int cond, tcg_insn_unit *addr)
+static void tcg_out_goto(TCGContext *s, int cond, const tcg_insn_unit *addr)
 {
     intptr_t addri = (intptr_t)addr;
     ptrdiff_t disp = tcg_pcrel_diff(s, addr);
@@ -1033,7 +1035,7 @@ static void tcg_out_goto(TCGContext *s, int cond, tcg_insn_unit *addr)
 
 /* The call case is mostly used for helpers - so it's not unreasonable
  * for them to be beyond branch range */
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *addr)
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *addr)
 {
     intptr_t addri = (intptr_t)addr;
     ptrdiff_t disp = tcg_pcrel_diff(s, addr);
@@ -1326,7 +1328,7 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
    helper code.  */
 static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
                                 TCGReg datalo, TCGReg datahi, TCGReg addrlo,
-                                TCGReg addrhi, tcg_insn_unit *raddr,
+                                TCGReg addrhi, const tcg_insn_unit *raddr,
                                 tcg_insn_unit *label_ptr)
 {
     TCGLabelQemuLdst *label = new_ldst_label(s);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index d8797ed398..69acb51f5d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -165,7 +165,7 @@ static bool have_lzcnt;
 # define have_lzcnt 0
 #endif
 
-static tcg_insn_unit *tb_ret_addr;
+static const tcg_insn_unit *tb_ret_addr;
 
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
@@ -1591,7 +1591,7 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
     }
 }
 
-static void tcg_out_branch(TCGContext *s, int call, tcg_insn_unit *dest)
+static void tcg_out_branch(TCGContext *s, int call, const tcg_insn_unit *dest)
 {
     intptr_t disp = tcg_pcrel_diff(s, dest) - 5;
 
@@ -1610,12 +1610,12 @@ static void tcg_out_branch(TCGContext *s, int call, tcg_insn_unit *dest)
     }
 }
 
-static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *dest)
+static inline void tcg_out_call(TCGContext *s, const tcg_insn_unit *dest)
 {
     tcg_out_branch(s, 1, dest);
 }
 
-static void tcg_out_jmp(TCGContext *s, tcg_insn_unit *dest)
+static void tcg_out_jmp(TCGContext *s, const tcg_insn_unit *dest)
 {
     tcg_out_branch(s, 0, dest);
 }
@@ -1774,7 +1774,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, bool is_64,
                                 TCGMemOpIdx oi,
                                 TCGReg datalo, TCGReg datahi,
                                 TCGReg addrlo, TCGReg addrhi,
-                                tcg_insn_unit *raddr,
+                                const tcg_insn_unit *raddr,
                                 tcg_insn_unit **label_ptr)
 {
     TCGLabelQemuLdst *label = new_ldst_label(s);
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 41be574e89..ace413afde 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -139,12 +139,13 @@ static const TCGReg tcg_target_call_oarg_regs[2] = {
     TCG_REG_V1
 };
 
-static tcg_insn_unit *tb_ret_addr;
-static tcg_insn_unit *bswap32_addr;
-static tcg_insn_unit *bswap32u_addr;
-static tcg_insn_unit *bswap64_addr;
+static const tcg_insn_unit *tb_ret_addr;
+static const tcg_insn_unit *bswap32_addr;
+static const tcg_insn_unit *bswap32u_addr;
+static const tcg_insn_unit *bswap64_addr;
 
-static inline uint32_t reloc_pc16_val(tcg_insn_unit *pc, tcg_insn_unit *target)
+static inline uint32_t reloc_pc16_val(const tcg_insn_unit *pc,
+                                      const tcg_insn_unit *target)
 {
     /* Let the compiler perform the right-shift as part of the arithmetic.  */
     ptrdiff_t disp = target - (pc + 1);
@@ -152,18 +153,21 @@ static inline uint32_t reloc_pc16_val(tcg_insn_unit *pc, tcg_insn_unit *target)
     return disp & 0xffff;
 }
 
-static inline void reloc_pc16(tcg_insn_unit *pc, tcg_insn_unit *target)
+static inline void reloc_pc16(tcg_insn_unit *pc,
+                              const tcg_insn_unit *target)
 {
     *pc = deposit32(*pc, 0, 16, reloc_pc16_val(pc, target));
 }
 
-static inline uint32_t reloc_26_val(tcg_insn_unit *pc, tcg_insn_unit *target)
+static inline uint32_t reloc_26_val(const tcg_insn_unit *pc,
+                                    const tcg_insn_unit *target)
 {
     tcg_debug_assert((((uintptr_t)pc ^ (uintptr_t)target) & 0xf0000000) == 0);
     return ((uintptr_t)target >> 2) & 0x3ffffff;
 }
 
-static inline void reloc_26(tcg_insn_unit *pc, tcg_insn_unit *target)
+static inline void reloc_26(tcg_insn_unit *pc,
+                            const tcg_insn_unit *target)
 {
     *pc = deposit32(*pc, 0, 26, reloc_26_val(pc, target));
 }
@@ -516,7 +520,7 @@ static void tcg_out_opc_sa64(TCGContext *s, MIPSInsn opc1, MIPSInsn opc2,
  * Type jump.
  * Returns true if the branch was in range and the insn was emitted.
  */
-static bool tcg_out_opc_jmp(TCGContext *s, MIPSInsn opc, void *target)
+static bool tcg_out_opc_jmp(TCGContext *s, MIPSInsn opc, const void *target)
 {
     uintptr_t dest = (uintptr_t)target;
     uintptr_t from = (uintptr_t)s->code_ptr + 4;
@@ -631,7 +635,7 @@ static inline void tcg_out_bswap16s(TCGContext *s, TCGReg ret, TCGReg arg)
     }
 }
 
-static void tcg_out_bswap_subr(TCGContext *s, tcg_insn_unit *sub)
+static void tcg_out_bswap_subr(TCGContext *s, const tcg_insn_unit *sub)
 {
     bool ok = tcg_out_opc_jmp(s, OPC_JAL, sub);
     tcg_debug_assert(ok);
@@ -1079,7 +1083,7 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
-static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
+static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
     /* Note that the ABI requires the called function's address to be
        loaded into T9, even if a direct branch is in range.  */
@@ -1097,7 +1101,7 @@ static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
     }
 }
 
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *arg)
 {
     tcg_out_call_int(s, arg, false);
     tcg_out_nop(s);
@@ -1289,7 +1293,8 @@ static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
                                 TCGType ext,
                                 TCGReg datalo, TCGReg datahi,
                                 TCGReg addrlo, TCGReg addrhi,
-                                void *raddr, tcg_insn_unit *label_ptr[2])
+                                const tcg_insn_unit *raddr,
+                                tcg_insn_unit *label_ptr[2])
 {
     TCGLabelQemuLdst *label = new_ldst_label(s);
 
@@ -2430,7 +2435,7 @@ static void tcg_target_detect_isa(void)
     sigaction(SIGILL, &sa_old, NULL);
 }
 
-static tcg_insn_unit *align_code_ptr(TCGContext *s)
+static const tcg_insn_unit *align_code_ptr(TCGContext *s)
 {
     uintptr_t p = (uintptr_t)s->code_ptr;
     if (p & 15) {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 18ee989f95..945ff2fba1 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -62,7 +62,7 @@
 #define TCG_CT_CONST_MONE 0x2000
 #define TCG_CT_CONST_WSZ  0x4000
 
-static tcg_insn_unit *tb_ret_addr;
+static const tcg_insn_unit *tb_ret_addr;
 
 TCGPowerISA have_isa;
 static bool have_isel;
@@ -184,14 +184,16 @@ static inline bool in_range_b(tcg_target_long target)
     return target == sextract64(target, 0, 26);
 }
 
-static uint32_t reloc_pc24_val(tcg_insn_unit *pc, tcg_insn_unit *target)
+static uint32_t reloc_pc24_val(const tcg_insn_unit *pc,
+                               const tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
     tcg_debug_assert(in_range_b(disp));
     return disp & 0x3fffffc;
 }
 
-static bool reloc_pc24(tcg_insn_unit *pc, tcg_insn_unit *target)
+static bool reloc_pc24(tcg_insn_unit *pc,
+                       const tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
     if (in_range_b(disp)) {
@@ -201,14 +203,16 @@ static bool reloc_pc24(tcg_insn_unit *pc, tcg_insn_unit *target)
     return false;
 }
 
-static uint16_t reloc_pc14_val(tcg_insn_unit *pc, tcg_insn_unit *target)
+static uint16_t reloc_pc14_val(const tcg_insn_unit *pc,
+                               const tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
     tcg_debug_assert(disp == (int16_t) disp);
     return disp & 0xfffc;
 }
 
-static bool reloc_pc14(tcg_insn_unit *pc, tcg_insn_unit *target)
+static bool reloc_pc14(tcg_insn_unit *pc,
+                       const tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
     if (disp == (int16_t) disp) {
@@ -1106,7 +1110,7 @@ static void tcg_out_xori32(TCGContext *s, TCGReg dst, TCGReg src, uint32_t c)
     tcg_out_zori32(s, dst, src, c, XORI, XORIS);
 }
 
-static void tcg_out_b(TCGContext *s, int mask, tcg_insn_unit *target)
+static void tcg_out_b(TCGContext *s, int mask, const tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_pcrel_diff(s, target);
     if (in_range_b(disp)) {
@@ -1762,7 +1766,7 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
     }
 }
 
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target)
 {
 #ifdef _CALL_AIX
     /* Look through the descriptor.  If the branch is in range, and we
@@ -1987,7 +1991,8 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, MemOp opc,
 static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
                                 TCGReg datalo_reg, TCGReg datahi_reg,
                                 TCGReg addrlo_reg, TCGReg addrhi_reg,
-                                tcg_insn_unit *raddr, tcg_insn_unit *lptr)
+                                const tcg_insn_unit *raddr,
+                                tcg_insn_unit *lptr)
 {
     TCGLabelQemuLdst *label = new_ldst_label(s);
 
@@ -2341,7 +2346,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out32(s, BCCTR | BO_ALWAYS);
 
     /* Epilogue */
-    s->code_gen_epilogue = tb_ret_addr = s->code_ptr;
+    tb_ret_addr = s->code_gen_epilogue = s->code_ptr;
 
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R0, TCG_REG_R1, FRAME_SIZE+LR_OFFSET);
     for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); ++i) {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index d536f3ccc1..5432ee89db 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -854,14 +854,14 @@ static void tcg_out_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
     g_assert_not_reached();
 }
 
-static inline void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
+static inline void tcg_out_goto(TCGContext *s, const tcg_insn_unit *target)
 {
     ptrdiff_t offset = tcg_pcrel_diff(s, target);
     tcg_debug_assert(offset == sextreg(offset, 1, 20) << 1);
     tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, offset);
 }
 
-static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
+static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
     TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
     ptrdiff_t offset = tcg_pcrel_diff(s, arg);
@@ -888,7 +888,7 @@ static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
     }
 }
 
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *arg)
 {
     tcg_out_call_int(s, arg, false);
 }
@@ -1022,7 +1022,8 @@ static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
                                 TCGType ext,
                                 TCGReg datalo, TCGReg datahi,
                                 TCGReg addrlo, TCGReg addrhi,
-                                void *raddr, tcg_insn_unit **label_ptr)
+                                const tcg_insn_unit *raddr,
+                                tcg_insn_unit **label_ptr)
 {
     TCGLabelQemuLdst *label = new_ldst_label(s);
 
@@ -1274,7 +1275,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
 #endif
 }
 
-static tcg_insn_unit *tb_ret_addr;
+static const tcg_insn_unit *tb_ret_addr;
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                        const TCGArg *args, const int *const_args)
diff --git a/tcg/s390/tcg-target.c.inc b/tcg/s390/tcg-target.c.inc
index c5e096449b..7c6917f3c4 100644
--- a/tcg/s390/tcg-target.c.inc
+++ b/tcg/s390/tcg-target.c.inc
@@ -363,7 +363,7 @@ static void * const qemu_st_helpers[16] = {
 };
 #endif
 
-static tcg_insn_unit *tb_ret_addr;
+static const tcg_insn_unit *tb_ret_addr;
 uint64_t s390_facilities;
 
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
@@ -1302,7 +1302,7 @@ static void tgen_extract(TCGContext *s, TCGReg dest, TCGReg src,
     tcg_out_risbg(s, dest, src, 64 - len, 63, 64 - ofs, 1);
 }
 
-static void tgen_gotoi(TCGContext *s, int cc, tcg_insn_unit *dest)
+static void tgen_gotoi(TCGContext *s, int cc, const tcg_insn_unit *dest)
 {
     ptrdiff_t off = dest - s->code_ptr;
     if (off == (int16_t)off) {
@@ -1415,7 +1415,7 @@ static void tgen_brcond(TCGContext *s, TCGType type, TCGCond c,
     tgen_branch(s, cc, l);
 }
 
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *dest)
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *dest)
 {
     ptrdiff_t off = dest - s->code_ptr;
     if (off == (int32_t)off) {
@@ -1593,7 +1593,8 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, MemOp opc,
 
 static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
                                 TCGReg data, TCGReg addr,
-                                tcg_insn_unit *raddr, tcg_insn_unit *label_ptr)
+                                const tcg_insn_unit *raddr,
+                                tcg_insn_unit *label_ptr)
 {
     TCGLabelQemuLdst *label = new_ldst_label(s);
 
diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
index 6775bd30fc..5eac18b719 100644
--- a/tcg/sparc/tcg-target.c.inc
+++ b/tcg/sparc/tcg-target.c.inc
@@ -840,7 +840,7 @@ static void tcg_out_addsub2_i64(TCGContext *s, TCGReg rl, TCGReg rh,
     tcg_out_mov(s, TCG_TYPE_I64, rl, tmp);
 }
 
-static void tcg_out_call_nodelay(TCGContext *s, tcg_insn_unit *dest,
+static void tcg_out_call_nodelay(TCGContext *s, const tcg_insn_unit *dest,
                                  bool in_prologue)
 {
     ptrdiff_t disp = tcg_pcrel_diff(s, dest);
@@ -855,7 +855,7 @@ static void tcg_out_call_nodelay(TCGContext *s, tcg_insn_unit *dest,
     }
 }
 
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *dest)
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *dest)
 {
     tcg_out_call_nodelay(s, dest, false);
     tcg_out_nop(s);
@@ -868,8 +868,8 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
 }
 
 #ifdef CONFIG_SOFTMMU
-static tcg_insn_unit *qemu_ld_trampoline[16];
-static tcg_insn_unit *qemu_st_trampoline[16];
+static const tcg_insn_unit *qemu_ld_trampoline[16];
+static const tcg_insn_unit *qemu_st_trampoline[16];
 
 static void emit_extend(TCGContext *s, TCGReg r, int op)
 {
@@ -1163,7 +1163,7 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg data, TCGReg addr,
 #ifdef CONFIG_SOFTMMU
     unsigned memi = get_mmuidx(oi);
     TCGReg addrz, param;
-    tcg_insn_unit *func;
+    const tcg_insn_unit *func;
     tcg_insn_unit *label_ptr;
 
     addrz = tcg_out_tlb_load(s, addr, memi, memop,
diff --git a/tcg/tcg-ldst.c.inc b/tcg/tcg-ldst.c.inc
index 05f9b3ccd6..eaba08700e 100644
--- a/tcg/tcg-ldst.c.inc
+++ b/tcg/tcg-ldst.c.inc
@@ -28,7 +28,7 @@ typedef struct TCGLabelQemuLdst {
     TCGReg addrhi_reg;      /* reg index for high word of guest virtual addr */
     TCGReg datalo_reg;      /* reg index for low word to be loaded or stored */
     TCGReg datahi_reg;      /* reg index for high word to be loaded or stored */
-    tcg_insn_unit *raddr;   /* gen code addr of the next IR of qemu_ld/st IR */
+    const tcg_insn_unit *raddr; /* gen code addr of the next IR of qemu_ld/st */
     tcg_insn_unit *label_ptr[2]; /* label pointers to be updated */
     QSIMPLEQ_ENTRY(TCGLabelQemuLdst) next;
 } TCGLabelQemuLdst;
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 231b9b1775..d5a4d9d37c 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -545,7 +545,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     old_code_ptr[1] = s->code_ptr - old_code_ptr;
 }
 
-static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
+static inline void tcg_out_call(TCGContext *s, const tcg_insn_unit *arg)
 {
     uint8_t *old_code_ptr = s->code_ptr;
     tcg_out_op_t(s, INDEX_op_call);
-- 
2.28.0


