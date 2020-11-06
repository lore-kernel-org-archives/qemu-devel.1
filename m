Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF599C55179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C0BD20729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrixGB18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0BD20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasVZ-0001L9-1P
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRU-0004XF-09
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:36 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRQ-0006uh-S5
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:35 -0500
Received: by mail-pg1-x542.google.com with SMTP id 62so2858697pgg.12
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=umlTSoDWsL7GMFuN8NYGzjEz6Eu8noAzDLdtJRqQ4Ig=;
 b=DrixGB18CuU/9aIYd3avoWoo18nA0RUNEU1IUUP82Gj+Uwzo9q7TP1jM/F6NddADji
 +i7P+/LezZaRFEvmfjguKjn9mSCBgW84Z7kf8LkQdiHD4U08MYyrcqDk7TNsvEjRkyTi
 EjtuWj1iytmoXfhjxgHGmisMhElSyTrFg9SUIR5U6UrNb9YIeXJiAdDwNiZNclbND747
 AcR4pHv26Db2r32V+glAdjCBFhVsGhDkWS3/Tv+5344viwPZZ8p7g2PiYvAk3ojS+CzP
 zLT2WMcJhRgyXd70Ert1y4p30F+8ZXF1CUE/M1nEr5hYHHZ/zb9Nslqsn07QO1ocKGY4
 axHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=umlTSoDWsL7GMFuN8NYGzjEz6Eu8noAzDLdtJRqQ4Ig=;
 b=rQHnz4bRaaUVllYpQdb1hC5szbkL6Pk58kwPtjWnssbwExVPHCKDYn7ZH04PE4+2sv
 h/z+nye6J8KCe0eEkJ3nVRkcJ3KX41SckuC0wsEIzbc3likbCcV2wLmZLr51cQCjGTio
 mIcnNUKMDnrUxLOQX6uL87+5rk8qvRii1D0pakpYpt/r688M1NiOZ230NeuSaVvgGlfX
 GPO1lijTK7ZyaW0urRKCGgDDFFeowpsBmEO/DpQ1vLaaB46zMR6ihhdIlEBrSy5+DqKd
 y7310Uf7hc/e4Ja9IGPqycmMCQVg70edb/7BQETJ5wf+1zVTy+IzdEDVvz4M6PimnJaP
 ZCBQ==
X-Gm-Message-State: AOAM531H59CnfDmbwJeWYfNKqwBtDEZrSQ1vslQ9TekV3HlUtckVOnDE
 nXlpKBo8laEM4BqFdZIyaZjZUBz52tw0vA==
X-Google-Smtp-Source: ABdhPJzBaG8+Iwbdm/A1Z+EzeK2lBRnJ+TI6RjU1hjfD/T0SJvn9aKGOsoP9RQD1bnc/HRM0TwytqA==
X-Received: by 2002:a17:90a:17ad:: with SMTP id
 q42mr187342pja.36.1604633371216; 
 Thu, 05 Nov 2020 19:29:31 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/41] tcg: Adjust TCGLabel for const
Date: Thu,  5 Nov 2020 19:28:46 -0800
Message-Id: <20201106032921.600200-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Change TCGLabel.u.value_ptr to const, and initialize it with
tcg_splitwx_to_rx.  Propagate const through tcg/host/ only
as far as needed to avoid errors from the value_ptr change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h            | 2 +-
 tcg/tcg.c                    | 2 +-
 tcg/aarch64/tcg-target.c.inc | 2 +-
 tcg/arm/tcg-target.c.inc     | 2 +-
 tcg/mips/tcg-target.c.inc    | 5 +++--
 tcg/ppc/tcg-target.c.inc     | 4 ++--
 tcg/s390/tcg-target.c.inc    | 2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 249f83be72..b2ba16ea8c 100644
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
diff --git a/tcg/tcg.c b/tcg/tcg.c
index cea3a4e4f2..a88b314e97 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -305,7 +305,7 @@ static void tcg_out_label(TCGContext *s, TCGLabel *l, tcg_insn_unit *ptr)
 {
     tcg_debug_assert(!l->has_value);
     l->has_value = 1;
-    l->u.value_ptr = ptr;
+    l->u.value_ptr = tcg_splitwx_to_rx(ptr);
 }
 
 TCGLabel *gen_new_label(void)
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 76f8ae48ad..96dc9f4d0b 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1306,7 +1306,7 @@ static void tcg_out_cmp(TCGContext *s, TCGType ext, TCGReg a,
     }
 }
 
-static inline void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
+static void tcg_out_goto(TCGContext *s, const tcg_insn_unit *target)
 {
     ptrdiff_t offset = target - s->code_ptr;
     tcg_debug_assert(offset == sextract64(offset, 0, 26));
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 1e32bf42b8..f8f485d807 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1019,7 +1019,7 @@ static inline void tcg_out_st8(TCGContext *s, int cond,
  * with the code buffer limited to 16MB we wouldn't need the long case.
  * But we also use it for the tail-call to the qemu_ld/st helpers, which does.
  */
-static void tcg_out_goto(TCGContext *s, int cond, tcg_insn_unit *addr)
+static void tcg_out_goto(TCGContext *s, int cond, const tcg_insn_unit *addr)
 {
     intptr_t addri = (intptr_t)addr;
     ptrdiff_t disp = tcg_pcrel_diff(s, addr);
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index f641105f9a..a3f838fa51 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -144,7 +144,8 @@ static tcg_insn_unit *bswap32_addr;
 static tcg_insn_unit *bswap32u_addr;
 static tcg_insn_unit *bswap64_addr;
 
-static inline uint32_t reloc_pc16_val(tcg_insn_unit *pc, tcg_insn_unit *target)
+static inline uint32_t reloc_pc16_val(tcg_insn_unit *pc,
+                                      const tcg_insn_unit *target)
 {
     /* Let the compiler perform the right-shift as part of the arithmetic.  */
     ptrdiff_t disp = target - (pc + 1);
@@ -152,7 +153,7 @@ static inline uint32_t reloc_pc16_val(tcg_insn_unit *pc, tcg_insn_unit *target)
     return disp & 0xffff;
 }
 
-static inline void reloc_pc16(tcg_insn_unit *pc, tcg_insn_unit *target)
+static inline void reloc_pc16(tcg_insn_unit *pc, const tcg_insn_unit *target)
 {
     *pc = deposit32(*pc, 0, 16, reloc_pc16_val(pc, target));
 }
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index be116c6164..8a0b20a86b 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -184,7 +184,7 @@ static inline bool in_range_b(tcg_target_long target)
     return target == sextract64(target, 0, 26);
 }
 
-static uint32_t reloc_pc24_val(tcg_insn_unit *pc, tcg_insn_unit *target)
+static uint32_t reloc_pc24_val(tcg_insn_unit *pc, const tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
     tcg_debug_assert(in_range_b(disp));
@@ -201,7 +201,7 @@ static bool reloc_pc24(tcg_insn_unit *pc, tcg_insn_unit *target)
     return false;
 }
 
-static uint16_t reloc_pc14_val(tcg_insn_unit *pc, tcg_insn_unit *target)
+static uint16_t reloc_pc14_val(tcg_insn_unit *pc, const tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
     tcg_debug_assert(disp == (int16_t) disp);
diff --git a/tcg/s390/tcg-target.c.inc b/tcg/s390/tcg-target.c.inc
index ac99ccea73..1b5c4f0ab0 100644
--- a/tcg/s390/tcg-target.c.inc
+++ b/tcg/s390/tcg-target.c.inc
@@ -1302,7 +1302,7 @@ static void tgen_extract(TCGContext *s, TCGReg dest, TCGReg src,
     tcg_out_risbg(s, dest, src, 64 - len, 63, 64 - ofs, 1);
 }
 
-static void tgen_gotoi(TCGContext *s, int cc, tcg_insn_unit *dest)
+static void tgen_gotoi(TCGContext *s, int cc, const tcg_insn_unit *dest)
 {
     ptrdiff_t off = dest - s->code_ptr;
     if (off == (int16_t)off) {
-- 
2.25.1


