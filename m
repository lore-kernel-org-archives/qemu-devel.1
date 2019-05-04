Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FEAC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C2D206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssk1T90T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C2D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMtUy-0002Sp-Ee
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 08:10:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQL-0007IS-CZ
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQJ-0001H5-Na
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:49 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hMtQG-0001DN-5K; Sat, 04 May 2019 08:05:46 -0400
Received: by mail-oi1-x241.google.com with SMTP id l203so6417701oia.3;
	Sat, 04 May 2019 05:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=GntLoJ5LAJvOCja8qBYrU8/E9MBsCe+uCkJo7D67Aro=;
	b=ssk1T90TsfNFVKW0T25Xl6zCr1WMuYvbbf6XvbocG+YAzRFZbdfsmVHu31JELrJ9iY
	kdO7swyg8NAeu+SsnO75jkdS1COJQVir6xab43uDT4qK1QfInuvh37t1Q78+3e+aTU3T
	aUPgWW24hJJoWN566UgOtF3xsGMjfxI5i69F0BlgJhV1k0HRzARYQZBUeEvDGY1kwqNX
	i6POMXb9+HF1he5dc4y4XxuYWibhUXMkyCeN/Oa12dbI/nKwBartiGAFetUI0tp+3Q4J
	4KZ3IUrLqaef/vdx89l9PFPzDiziep0E18sm7KZuCHivegDxrlvCgRWuf3WtJg2Gqxcl
	SGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=GntLoJ5LAJvOCja8qBYrU8/E9MBsCe+uCkJo7D67Aro=;
	b=M11jGX6Sq0LP4xC5FA35NjOGvy2HwIDz1T8GhoNkm1mgXtWqJbKg8Og84oGUi2Fq/t
	ptWhWs7JAAncZkW1UR/D0B/QibLfM27B9zf5gzQZnoi4nqTtDf7jcgdbK2eMSHLrMpvG
	8rKIIVfXB0iQZ+sEkUYi33EmM+lARO3sDFhSssILy2Ni+JfQ6qugGJBBMMhnNAcLzpjX
	YQO3j91kwlxi2SQMR0z2/YEIxrTMeqQAWOhUvdGErZFGgzcaBuXoWDEVPv+ukqHt3SyD
	or64OvuBSF4dANM2lfxbfuYEEcmb0JLp4HqxjsxJLEMQlaZ7FMG4NiIBLeEme9myeKEG
	TFOg==
X-Gm-Message-State: APjAAAXaUEIhv5OjuVLZtWQkjknMNL8u8B/MBQ046wu8li7tiR3EqmpX
	srdLVx9eZucWEe5cRrBsRY6A/AGs
X-Google-Smtp-Source: APXvYqzYkYecVBVitWiGe5sxHagGM/N0Bye1cG4nzDbby4noZj7wT0Bp6cVdn1dAgp1wW2m6VDa6kw==
X-Received: by 2002:aca:bb07:: with SMTP id l7mr2385734oif.142.1556971537662; 
	Sat, 04 May 2019 05:05:37 -0700 (PDT)
Received: from localhost.localdomain ([198.59.53.9])
	by smtp.gmail.com with ESMTPSA id
	s26sm1844978otk.24.2019.05.04.05.05.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 05:05:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat,  4 May 2019 06:05:25 -0600
Message-Id: <20190504120528.6389-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: [Qemu-devel] [PATCH 7/9] tcg: add tcg_out_start
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
Cc: peter.maydell@linaro.org, cohuck@redhat.com, richard.henderson@linaro.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504120525.2FlIDrR4zdwjdFjqbNV_7jjwmN3Q47jg5INBhD4_Vjs@z>

This function is called at the beginning of any translation block.  We will
use it to emit ENDBR32 or ENDBR64 annotations for x86 CET.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/aarch64/tcg-target.inc.c | 4 ++++
 tcg/arm/tcg-target.inc.c     | 4 ++++
 tcg/i386/tcg-target.inc.c    | 4 ++++
 tcg/mips/tcg-target.inc.c    | 4 ++++
 tcg/ppc/tcg-target.inc.c     | 4 ++++
 tcg/riscv/tcg-target.inc.c   | 4 ++++
 tcg/s390/tcg-target.inc.c    | 4 ++++
 tcg/sparc/tcg-target.inc.c   | 4 ++++
 tcg/tcg.c                    | 2 ++
 tcg/tci/tcg-target.inc.c     | 4 ++++
 10 files changed, 38 insertions(+)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index eefa929948..c66f3cb857 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2539,6 +2539,10 @@ QEMU_BUILD_BUG_ON(FRAME_SIZE >= (1 << 14));
 /* We're expecting to use a single ADDI insn.  */
 QEMU_BUILD_BUG_ON(FRAME_SIZE - PUSH_SIZE > 0xfff);
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 static void tcg_target_qemu_prologue(TCGContext *s)
 {
     TCGReg r;
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index abf0c444b4..8f919c7641 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -2284,6 +2284,10 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
     }
 }
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 /* Compute frame size via macros, to share between tcg_target_qemu_prologue
    and tcg_register_jit.  */
 
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index d5ed9f1ffd..b210977800 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3510,6 +3510,10 @@ static const int tcg_target_callee_save_regs[] = {
       + TCG_TARGET_STACK_ALIGN - 1) \
      & ~(TCG_TARGET_STACK_ALIGN - 1))
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 /* Generate global QEMU prologue and epilogue code */
 static void tcg_target_qemu_prologue(TCGContext *s)
 {
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 412cacdcb9..2bb976a9a5 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -2471,6 +2471,10 @@ static tcg_insn_unit *align_code_ptr(TCGContext *s)
     return s->code_ptr;
 }
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 /* Stack frame parameters.  */
 #define REG_SIZE   (TCG_TARGET_REG_BITS / 8)
 #define SAVE_SIZE  ((int)ARRAY_SIZE(tcg_target_callee_save_regs) * REG_SIZE)
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 36b4791707..f4efca8f7b 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1904,6 +1904,10 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
     }
 }
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 /* Parameters for function call generation, used in tcg.c.  */
 #define TCG_TARGET_STACK_ALIGN       16
 #define TCG_TARGET_EXTEND_ARGS       1
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 2932505094..5780537b73 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1798,6 +1798,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     }
 }
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 static const int tcg_target_callee_save_regs[] = {
     TCG_REG_S0,       /* used for the global env (TCG_AREG0) */
     TCG_REG_S1,
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 3d6150b10e..924bd01afd 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -2499,6 +2499,10 @@ static void query_s390_facilities(void)
     }
 }
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 static void tcg_target_init(TCGContext *s)
 {
     query_s390_facilities();
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 7a61839dc1..f795e78153 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -1004,6 +1004,10 @@ static void build_trampolines(TCGContext *s)
 }
 #endif
 
+static inline void tcg_out_start(TCGContext *s)
+{
+}
+
 /* Generate global QEMU prologue and epilogue code */
 static void tcg_target_qemu_prologue(TCGContext *s)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f7bef51de8..c8832c3ccf 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -101,6 +101,7 @@ static void tcg_register_jit_int(void *buf, size_t size,
 /* Forward declarations for functions declared and used in tcg-target.inc.c. */
 static const char *target_parse_constraint(TCGArgConstraint *ct,
                                            const char *ct_str, TCGType type);
+static void tcg_out_start(TCGContext *s);
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1,
                        intptr_t arg2);
 static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg);
@@ -3925,6 +3926,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #endif
 
     num_insns = -1;
+    tcg_out_start(s);
     QTAILQ_FOREACH(op, &s->ops, link) {
         TCGOpcode opc = op->opc;
 
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index 0015a98485..cb90012999 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -889,6 +889,10 @@ static void tcg_target_init(TCGContext *s)
                   CPU_TEMP_BUF_NLONGS * sizeof(long));
 }
 
+static inline void tcg_out_start(void)
+{
+}
+
 /* Generate global QEMU prologue and epilogue code. */
 static inline void tcg_target_qemu_prologue(TCGContext *s)
 {
-- 
2.21.0



