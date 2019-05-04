Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F885C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80E620675
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GF6inBIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80E620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51709 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnjC-00056J-3E
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:00:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbo-0007kp-6q
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbn-0004C2-1j
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:16 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbm-0004BP-Rz
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:14 -0400
Received: by mail-pl1-x642.google.com with SMTP id e92so3730810plb.6
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=vlsz3mBJLHv925hZ117IYDgBd7E32bASu3EG/5gz9gQ=;
	b=GF6inBISMAYTZATq54aHQ1fUwfGkZ/GsyN0zwUP5vvGvEXqfsraqvNEBGjclTCgKQJ
	OLPP0FB8iloq2xcpZJnoyrKQ5IlYJmo28tZeb0nM6LqPrsiCsgeCnkjd0BW6OoXpcRuZ
	ny7axcbZ9x1qN8/tlqCuDnIP9jRL862h0fIIF/F+t2ixIfskuRpwFpayXDDCQ8CBn7E0
	eT3/3SS14inU0a3Sz2IfMFV/7rtDaHsvoUbrq8nuTkYQfIzCtttj/X6C09+yLJT3qZOg
	oekhIVyYJb0yDoyOvyhfuXj77CVJOBDR1t5pNnCxndBG+Z5yc+RYq6PeeiGI1yPl1omS
	sXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=vlsz3mBJLHv925hZ117IYDgBd7E32bASu3EG/5gz9gQ=;
	b=mmcDNHKGJT328IFIlrzJXBqagaCTaPTg3UuzFUF1i88j8QXciy2dzEZzE+Jxr6pP3z
	dlL5y1O6lmj+OvARL4HYRjMUzokRxQSsvPBv3LRyz4DNwNuxsmvHRWZt377ycDSJBFsH
	EK7aR6KDDYrK88T3NVMB4fUtpIsm/3KRufQoB+g5Mgnis+Jcb3buoBiU5W4jt4n2NNMZ
	Tx9R3HoU7Ru535KM40Kk5ebnK02t2lOR5bC2tvtKoC+NIKQT2poyVy0qyN8sNc0UiUzS
	RzLA7Lj+jS8vGLhwFzXCtCh0tUDm/AJpcf8w1VWpNh+zO7v6cvN4SHWu98lf95tNmbsY
	M7/A==
X-Gm-Message-State: APjAAAVkY+rJg03RifKhoS02ukYT5hmpTk2dxeIMWtDfGfG88rU90QLx
	zpzzNotYU5oJeLS7A34mjwUFaOfq1ys=
X-Google-Smtp-Source: APXvYqwz6a8VSuBJwfgp3UCA+13gjM/Y9NRsptcgqlXymRNUYunG3aBZAQhiMZ9Ch2w/wioTodvzZQ==
X-Received: by 2002:a17:902:42a5:: with SMTP id
	h34mr10507298pld.146.1556949193550; 
	Fri, 03 May 2019 22:53:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:38 -0700
Message-Id: <20190504055300.18426-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v3 09/31] tcg: Promote tcg_out_{dup,
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504055238.tdLluD-jZHE0VC9xGZGWb5oNq-w0LOyo6VjmvplSdE8@z>

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


