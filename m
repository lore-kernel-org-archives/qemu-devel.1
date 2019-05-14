Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FDDC04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245022084F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3lHCTYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245022084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQL34-0005QN-A8
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:12:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKz6-00020x-JK
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxL-0003NX-Np
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:07:56 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:43858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxJ-00036P-7N
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:05 -0400
Received: by mail-pg1-x530.google.com with SMTP id t22so7591157pgi.10
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=vlsz3mBJLHv925hZ117IYDgBd7E32bASu3EG/5gz9gQ=;
	b=U3lHCTYaWj6/bj3g9F9SoDzJWXOQY9zVP9wYQEU8umW2l7quU5KpaaRDg0iVtT4nLh
	0D0FmS7AB343OVF/jCr5t5hembYiwNZGIWlHXamBFXSK6vRjPenG6BbZySeDJCQCJhtI
	bLTb013hxrB60ZmLVtj6iwwa8vOVLLPZXxEKFuHw3Tm0n6kOSXVvk/HKab18w2/Y2J23
	q8Nv3Kqqtz/mW08MMp8M61ys3IAiGbtv/QcsmZWB60oNH0Rl4WtMsvpP1jNznHBNI2kw
	sV4oCu/CUb9XVeaLBdWplA+c9NMx/AnmDdFfzxUPOhQ86/Mg0kOixJ5kKMQpFbNeRL2m
	b8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=vlsz3mBJLHv925hZ117IYDgBd7E32bASu3EG/5gz9gQ=;
	b=FqaDLyIa36Y+lJxJv8wMdLMXvNof5MGWe1ykH5TLskrACxRE1xnTyt+Ze6xFsMSJk3
	n4OO1RMPKt8AdW/yWX5SBkBLkrg/KasvtwMNFB9dFXqc2zhw0RBbaJiFzoIhPDlsWWsw
	egfi0AlgqTz0YVjUYHNPHlPAfTSqJ7JTObiFqvXcvZplevZDjXW4nh80AbjOHrD5/aa0
	Q/p0ckolBd9GW7jGEP5+ewpX3mm7QWwwVQn82/HDGacekVmtnvJnyAv2QisplCJjNm+S
	khbgRVKN7Yx55yqK7BYo/6KDfdFvBrmkC0NryOhdxLLu5ex9GEyL8AOmmjMxQR49ov5z
	U85Q==
X-Gm-Message-State: APjAAAVvk77+nE6BldQ5i7207Jx6gAs8jkkn+y8bZGn5jMscg6xi9Sdx
	TOk6w0PvSxYxcQtswYZhuCkOggdbbBk=
X-Google-Smtp-Source: APXvYqzNXcfyWzJ+kjIUFZkknH+ShFtnbYvWGYG+7g5kFbuFEJLZjxq64gPB0AX4wAZk7qiy/w4DAw==
X-Received: by 2002:aa7:8252:: with SMTP id e18mr37038185pfn.105.1557792355560;
	Mon, 13 May 2019 17:05:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.05.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:05:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:18 -0700
Message-Id: <20190514000540.4313-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::530
Subject: [Qemu-devel] [PULL 09/31] tcg: Promote tcg_out_{dup,
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The i386 backend already has these functions, and the aarch64 backend
could easily split out one.  Nothing is done with these functions yet,
but this will aid register allocation of INDEX_op_dup_vec in a later patch.

Adjust the aarch64 tcg_out_dupi_vec signature to match the new interface.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


