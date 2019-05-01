Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33024C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C8320866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkWklY4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C8320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36282 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhW1-0001ZE-0P
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:10:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRN-0006Px-SH
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRK-0002qs-Qz
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:57 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRK-0002qg-LO
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:54 -0400
Received: by mail-pf1-x441.google.com with SMTP id b3so8156766pfd.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=rtRPUDY4TdKCbPvS0GzwaINTK6SrdvAgOdsr0QnNjbg=;
	b=YkWklY4MUSrqX7mMOxEnKMMJWvhhNZCYDyRC7u31LuwmDgIlWlmw2PBMVt+YRDn/Pt
	IOHy3fMnuU/x8mecmftZHyoVeOWQuwKsZVZqOvdoCz+NBFhBFmQxz4H1Cz7e8/a63t4U
	RyNRr9D6zDF9oNkqHHUjVaqUd5L+4zZYbTncSgvUn42Ar3tTqrIFqO27e4/G5JahE7q/
	nJT/m4AIJkDE9c/mBeP9NL+984FPEzoIOLKG1IpsiEsO0A4ys+WdPETCeH4GngGJqaYj
	URZNngTccAVIy5FMt568wujRzzK7g2zorpmk90BcycyKmXlp5thWpYsJhu2n72Hf3q46
	1s+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=rtRPUDY4TdKCbPvS0GzwaINTK6SrdvAgOdsr0QnNjbg=;
	b=CobM8vbobNbYuiL5MBb3OZlyIitMXz+WXn+cLQa5yEjS6+yiZkNwuXcSNuZRRr5Xhr
	QrAUKu15hQT+b1kKKdUEK3QnZVqsPGwV/ZEXJvomdOu0WZQD/GGmiDMnS1AeBHfF7CbG
	NRzbWZEhwbWFZbHhHYxXBhCkXWnPhyQRfCCUZhhAGfKtw00X/AMttg5K7n02BEv1C6GX
	t+QZ3kFgIch4HrEEJrjOMTW2sFyXRE1ehm+zauoVB+WG4T4DTJnX6ApvA69/hbUYabPZ
	eIGku9FNDqLL+ADSC6YTyA0E3cGAVkH1CmA/ij2BOq1qQjqP9PvXLNn0WjH9DvXm5Jgp
	NIiA==
X-Gm-Message-State: APjAAAUud0dgF3BA8AA+Q2fiPKWGYBTtE/arTWtgfxfZJy77NnBCU+yj
	g4Bd7z2Isvl3SSIVqAEJi5fnk5NeIOk=
X-Google-Smtp-Source: APXvYqxC7r1jYEgxsU0Z3vcj7q758vN+eD1FePyqcfaZ9cpeXGvvJS2c7Si8fUABmmxnAX94XUmsUA==
X-Received: by 2002:a63:5953:: with SMTP id j19mr71395596pgm.260.1556687153322;
	Tue, 30 Apr 2019 22:05:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.05.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:05:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:15 -0700
Message-Id: <20190501050536.15580-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 08/29] tcg: Promote tcg_out_{dup,
 dupi}_vec to backend interface
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501050515.n0RJQI36rcUBA3cCo2BHv66d2wfeEIg0Hvh6sTLT3S8@z>

The i386 backend already has these functions, and the aarch64
backend could easily split out one.  Nothing is done with these
functions yet, but this will aid register allocation of
INDEX_op_dup_vec in a later patch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 12 ++++++++++--
 tcg/i386/tcg-target.inc.c    |  3 ++-
 tcg/tcg.c                    | 14 ++++++++++++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index ee89734318..e443b5df23 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -799,7 +799,7 @@ static void tcg_out_logicali(TCGContext *s, AArch64Insn insn, TCGType ext,
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
-                             TCGReg rd, uint64_t v64)
+                             TCGReg rd, tcg_target_long v64)
 {
     int op, cmode, imm8;
 
@@ -814,6 +814,14 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
     }
 }
 
+static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+                            TCGReg rd, TCGReg rs)
+{
+    int is_q = type - TCG_TYPE_V64;
+    tcg_out_insn(s, 3605, DUP, is_q, rd, rs, 1 << vece, 0);
+    return true;
+}
+
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
                          tcg_target_long value)
 {
@@ -2201,7 +2209,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a1);
         break;
     case INDEX_op_dup_vec:
-        tcg_out_insn(s, 3605, DUP, is_q, a0, a1, 1 << vece, 0);
+        tcg_out_dup_vec(s, type, vece, a0, a1);
         break;
     case INDEX_op_shli_vec:
         tcg_out_insn(s, 3614, SHL, is_q, a0, a1, a2 + (8 << vece));
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 1198c76392..0d621670c7 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -855,7 +855,7 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     return true;
 }
 
-static void tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg r, TCGReg a)
 {
     if (have_avx2) {
@@ -888,6 +888,7 @@ static void tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
             g_assert_not_reached();
         }
     }
+    return true;
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 68d86361e2..3ef4d3478d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -109,10 +109,24 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
                        const int *const_args);
 #if TCG_TARGET_MAYBE_vec
+static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+                            TCGReg dst, TCGReg src);
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
+                             TCGReg dst, tcg_target_long arg);
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl,
                            unsigned vece, const TCGArg *args,
                            const int *const_args);
 #else
+static inline bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+                                   TCGReg dst, TCGReg src)
+{
+    g_assert_not_reached();
+}
+static inline void tcg_out_dupi_vec(TCGContext *s, TCGType type,
+                                    TCGReg dst, tcg_target_long arg)
+{
+    g_assert_not_reached();
+}
 static inline void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl,
                                   unsigned vece, const TCGArg *args,
                                   const int *const_args)
-- 
2.17.1


