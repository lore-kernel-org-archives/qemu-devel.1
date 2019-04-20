Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE18C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43002208C0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyv87db6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43002208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38105 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkbB-0003o3-FY
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:39:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWY-0008Q6-Dg
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWX-0007qX-91
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:58 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWX-0007pt-2f
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:57 -0400
Received: by mail-pg1-x541.google.com with SMTP id k19so3604414pgh.0
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=TZV1ulrf0nOxaaoYwAiOAuzczUUGNeQajyWxzhn5VlI=;
	b=iyv87db64nfsC1gEQSDC8yrSzILDZA7ZB7wPOCOJJ6CfpFNBScbUSazRXyB9csI+3L
	YJPFGeumcLYsFggJLxY7mg46ddZxLyobp6DvC2A1lr/ls6juKYnzL9hquANvcxJaTjAJ
	NR0ygqM9FEzXHBcQLL1MAT9Mak23+RPn/uBea6h3zdHN4XJBXJGCD8atYPwd6rRstbZ3
	AWL05mEigLtJzkeh83kbcelAASh43SnnTDR7U9jdHtEai8X+IX5fVy2hIzckQhb5jSxY
	nLBsN4RA+5qOJlHK+UhvBc7PEyFGe12cRnbwgk/HEJXDNRBSHHu2rdb1lpVfXJzXh/Sw
	KxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=TZV1ulrf0nOxaaoYwAiOAuzczUUGNeQajyWxzhn5VlI=;
	b=W5kvcgPPC3EkvCqsYHWsiffmiMYWoQzY0eiHvj7wX3aLO697Q/MShqdIqsgbxMT0LO
	GsA3qs3tFgBsKLW6GsuGAwfnBn5UelyOHuOQRkVjH2NM7BIZ/hKV8h0H3KJTXwGSUKiC
	tAA9xbAt/BJPZJvlhG4fErS9IrhrMEn9dGbUaL7P0hhBzeA1fFgCVX8DR6HeyRB0Sh4B
	PuYxbYWFYAN0N2nVPDbniby4q3zN8T1Zv7GJmO0Z/UHF59xK1tZy7HxNGfwJ5uQXYR6J
	3H05K1bDlXzjyg0cTI5u52zPHlFAg7gmj3vB95q6DeDhqs0dutjXd9r5SLSWuR7fc7GI
	JF0w==
X-Gm-Message-State: APjAAAUp8SJnJmPnf2lM3hC4G+gs/UqbBhZK/drcG7P97by5kxXVcMUH
	n5elAHq11e1a82Gmz1XwNFA9zN5Uaxc=
X-Google-Smtp-Source: APXvYqzWQznkqmK5LpdsrdQJj1mYSuoAumAQOmW7bDNhBHV/R/nCWn8cMwumJisPa4hvJyuWzEekYQ==
X-Received: by 2002:aa7:8083:: with SMTP id v3mr8680326pff.135.1555745695732; 
	Sat, 20 Apr 2019 00:34:55 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.34.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:34:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:10 -1000
Message-Id: <20190420073442.7488-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 06/38] tcg: Promote tcg_out_{dup,
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073410.GVmHaNvMzCzNFpjIz5ve04f3dTX_m6WK5u0ORlWm-60@z>

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
index b2d3f9c0a5..116ebd8c1a 100644
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
@@ -2197,7 +2205,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a1);
         break;
     case INDEX_op_dup_vec:
-        tcg_out_insn(s, 3605, DUP, is_q, a0, a1, 1 << vece, 0);
+        tcg_out_dup_vec(s, type, vece, a0, a1);
         break;
     case INDEX_op_shli_vec:
         tcg_out_insn(s, 3614, SHL, is_q, a0, a1, a2 + (8 << vece));
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 817a167767..04e3d37b05 100644
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
index d3dcfe3dca..5ed9c7bee5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -108,10 +108,24 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
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


