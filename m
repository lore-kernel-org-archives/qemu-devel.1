Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7300C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FEC3217D9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzgbkHif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEC3217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55628 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIxbp-0006CU-SO
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 11:45:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVk-0001D4-3X
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVi-00071F-Rn
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:08 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIxVi-00070M-LA
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:06 -0400
Received: by mail-pg1-x541.google.com with SMTP id y3so7786198pgk.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=etFJ/jJqxo/gX9AJnnw5VNXWmGywWB8mmeO93OmpSSU=;
	b=jzgbkHifc0abmPHiZtAeTm0bryfoAm5kvYT9Xolo5gyj//anWu2C4KsJNQ+7/2GqC3
	0yxKduAVuxgBgqG2Hqa0hUjf9dXNyqbo9xyl+TkR/5JoEErIyJKxHjPLNNMdyhCbvAWB
	5it/q0YkaOdyN3W+inI+cta48J0A7VyCBpwY51HvfNilamCfCLxxIyMf1zbk2I20bf7r
	2UZmSdyPIEx1IEqK84gXxJoZ+OLBx1PkODd3rX6ekFKgq5qDkmwStd2DSbfWCP8Yr515
	Oywszf182Dio3MYL8LkJ7uChvTxZdN0R61TSoJZOBRvnoSIyn+sRHuwQprFUQNqJ9FlO
	W0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=etFJ/jJqxo/gX9AJnnw5VNXWmGywWB8mmeO93OmpSSU=;
	b=I2kp3eKxEw72pZW2qNr78XvGEV2HYQJJMKPkjdnLg0pruU7WeKq6b0uXNqv3CfsiUV
	m3KHYrV7hrsv//RMW6ILgpkqndGCts4rxIWkz0XKSGYttaWn+5ITemaOpPfiEvjyz5kF
	E+4Udv85IuezR5td1bJKHMgEQHDdrEXSJyhkayZfNRBv3SCH7T528slwkMci9Z799vMP
	AGgBrWeabq/B2KLy/8ktDl+o5O60fu312JH82lfA9yJOeXd/kUg4lONiYNYA7OYyUT+X
	jOMEf2paQBQEYFpmL9vtan7Y0lCiR836W43OovQ1BYJ2ADI3dQXy1BqeioGo4uxulUiO
	ApOw==
X-Gm-Message-State: APjAAAU0or1R0DR0asQ+oRFWUQEZWRRDPFomWzP52cPhamXAHC45J/9x
	RUpMEfik8cOpWEhVvaHxxrlVnQzYFwI=
X-Google-Smtp-Source: APXvYqwmhZ/mifNyiO5vzOGyhy5H+UEd+42htPFUp8TLCozTMxdl45DRdhGpVo8CgGbWbIPoNGbO6g==
X-Received: by 2002:a65:638f:: with SMTP id h15mr25225228pgv.147.1556033945214;
	Tue, 23 Apr 2019 08:39:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	c25sm24366591pfo.69.2019.04.23.08.39.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 08:39:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 08:38:53 -0700
Message-Id: <20190423153853.19790-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423153853.19790-1-richard.henderson@linaro.org>
References: <20190423153853.19790-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 7/7] tcg/arm: Restrict constant pool
 displacement to 12 bits
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alistair23@gmail.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423153853.jLCQBmItrBaOmYy9KU2mfof6qhKicKp8fbcD6fZAxC0@z>

From: Richard Henderson <rth@twiddle.net>

This will not necessarily restrict the size of the TB, since for v7
the majority of constant pool usage is for calls from the out-of-line
ldst code, which is already at the end of the TB.  But this does
allow us to save one insn per reference on the off-chance.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 57 +++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 0514b0ac25..5515728295 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -197,6 +197,24 @@ static inline bool reloc_pc24(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
     return false;
 }
 
+static inline bool reloc_pc13(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    ptrdiff_t offset = tcg_ptr_byte_diff(target, code_ptr) - 8;
+
+    if (offset >= -0xfff && offset <= 0xfff) {
+        tcg_insn_unit insn = *code_ptr;
+        bool u = (offset >= 0);
+        if (!u) {
+            offset = -offset;
+        }
+        insn = deposit32(insn, 23, 1, u);
+        insn = deposit32(insn, 0, 12, offset);
+        *code_ptr = insn;
+        return true;
+    }
+    return false;
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -205,39 +223,10 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     if (type == R_ARM_PC24) {
         return reloc_pc24(code_ptr, (tcg_insn_unit *)value);
     } else if (type == R_ARM_PC13) {
-        intptr_t diff = value - (uintptr_t)(code_ptr + 2);
-        tcg_insn_unit insn = *code_ptr;
-        bool u;
-
-        if (diff >= -0xfff && diff <= 0xfff) {
-            u = (diff >= 0);
-            if (!u) {
-                diff = -diff;
-            }
-        } else {
-            int rd = extract32(insn, 12, 4);
-            int rt = rd == TCG_REG_PC ? TCG_REG_TMP : rd;
-
-            if (diff < 0x1000 || diff >= 0x100000) {
-                return false;
-            }
-
-            /* add rt, pc, #high */
-            *code_ptr++ = ((insn & 0xf0000000) | (1 << 25) | ARITH_ADD
-                           | (TCG_REG_PC << 16) | (rt << 12)
-                           | (20 << 7) | (diff >> 12));
-            /* ldr rd, [rt, #low] */
-            insn = deposit32(insn, 12, 4, rt);
-            diff &= 0xfff;
-            u = 1;
-        }
-        insn = deposit32(insn, 23, 1, u);
-        insn = deposit32(insn, 0, 12, diff);
-        *code_ptr = insn;
+        return reloc_pc13(code_ptr, (tcg_insn_unit *)value);
     } else {
         g_assert_not_reached();
     }
-    return true;
 }
 
 #define TCG_CT_CONST_ARM  0x100
@@ -605,12 +594,8 @@ static inline void tcg_out_ld8s_r(TCGContext *s, int cond, TCGReg rt,
 
 static void tcg_out_movi_pool(TCGContext *s, int cond, int rd, uint32_t arg)
 {
-    /* The 12-bit range on the ldr insn is sometimes a bit too small.
-       In order to get around that we require two insns, one of which
-       will usually be a nop, but may be replaced in patch_reloc.  */
     new_pool_label(s, arg, R_ARM_PC13, s->code_ptr, 0);
     tcg_out_ld32_12(s, cond, rd, TCG_REG_PC, 0);
-    tcg_out_nop(s);
 }
 
 static void tcg_out_movi32(TCGContext *s, int cond, int rd, uint32_t arg)
@@ -1069,8 +1054,8 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit *addr)
         tcg_out_movi32(s, COND_AL, TCG_REG_TMP, addri);
         tcg_out_blx(s, COND_AL, TCG_REG_TMP);
     } else {
-        /* ??? Know that movi_pool emits exactly 2 insns.  */
-        tcg_out_dat_imm(s, COND_AL, ARITH_ADD, TCG_REG_R14, TCG_REG_PC, 4);
+        /* ??? Know that movi_pool emits exactly 1 insn.  */
+        tcg_out_dat_imm(s, COND_AL, ARITH_ADD, TCG_REG_R14, TCG_REG_PC, 0);
         tcg_out_movi_pool(s, COND_AL, TCG_REG_PC, addri);
     }
 }
-- 
2.17.1


