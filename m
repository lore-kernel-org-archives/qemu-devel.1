Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40597C282DE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6ACC2173C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEiP8vmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6ACC2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52635 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZu2-000332-1q
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:40:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZj5-0003AX-8J
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZj3-0007Rh-Pe
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:47 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:35999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZj3-0007Na-ID
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:45 -0400
Received: by mail-yb1-xb42.google.com with SMTP id v66so1503158ybb.3
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/D6aLozHwnS1sPI8iNsL3pMxewPkp4IUhb3tHD+DOe4=;
	b=VEiP8vmV0RQmXxrJLn9yHrrDOSw7ynQuiJjAXkCBfBYy5hVPFpV5oWV5XuSZ4ulvrw
	bFtpqLHkf/rqLsFgBBUc0pPCAcu69fluT8reEb21Hi4R+POKpF7uxrLaawzGnlTHAxCe
	TSHXvO9CdAHZEGXz69pL4Mer3UqPFgDi+BieA6CZePaR3OTL0vv4G936QudEWJ1FoNHH
	FETQljC/D7AA8+ZKK2ynOAcbXY1LZdal6Nor4E+SEx9tmASHrmqMTgCDmb28QAf3wGuC
	ZSgNpJEOgHdQXpCeLJVrixzwOd1pLNHdNgW1P2Fco/31ZcJVL1RFOH6Xt5aTahRYL+IH
	/Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=/D6aLozHwnS1sPI8iNsL3pMxewPkp4IUhb3tHD+DOe4=;
	b=tauFOc4VjM6o/U74eXOvgxWcLvEuPNi5WHiqo2oig2CoDh0NtlfFw5LTGP0bBLoVst
	DUz3lPbhllmo4XHYUhczBLYIlfFiMw5RYo1m0HlDBJ77En6jOLtUBzM84mkTmOida2kA
	tHwvnCer9f6AO6PLLJ8gXK6efJnMNtGEOWtBGI+YkStf5n5OB1cV5L7dCFuFMaVM2q0Y
	egXbvZA0PJVLUlNP+vvixITSxr1MbWUOMKBdnZTG8MfOULGaMAuXrhX5U5WuJzT5J0QW
	XafNA5AfXq4WwALLGldzGNoFVPTsbaM+BYivnvVonmLw8Gl89qy20PpEFBp+23/Ng8+w
	OFIw==
X-Gm-Message-State: APjAAAUGVmXytf8sAS4xrMOU0DS0xgkNXRs3nVpfwCS66YUBYXwBmRhR
	7fSH377kXJm2msJwDSI2ltT5TR2Lslo=
X-Google-Smtp-Source: APXvYqyCnKDJ782uXZmeLRRL7u5DUwn+Tkgko7As4VUQ4FcN/G7NJCfC2CZEmvv/r/ZsvL5YLqL5dg==
X-Received: by 2002:a25:77c8:: with SMTP id
	s191mr20720580ybc.152.1558564116955; 
	Wed, 22 May 2019 15:28:36 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:17 -0400
Message-Id: <20190522222821.23850-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [PULL 12/16] tcg/aarch64: Split up is_fimm
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are several sub-classes of vector immediate, and only MOVI
can use them all.  This will enable usage of MVNI and ORRI, which
use progressively fewer sub-classes.

This patch adds no new functionality, merely splits the function
and moves part of the logic into tcg_out_dupi_vec.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 205 ++++++++++++++++++++---------------
 1 file changed, 120 insertions(+), 85 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index e99149cda7..1422dfebe2 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -190,103 +190,86 @@ static inline bool is_limm(uint64_t val)
     return (val & (val - 1)) == 0;
 }
 
-/* Match a constant that is valid for vectors.  */
-static bool is_fimm(uint64_t v64, int *op, int *cmode, int *imm8)
+/* Return true if v16 is a valid 16-bit shifted immediate.  */
+static bool is_shimm16(uint16_t v16, int *cmode, int *imm8)
 {
-    int i;
-
-    *op = 0;
-    /* Match replication across 8 bits.  */
-    if (v64 == dup_const(MO_8, v64)) {
-        *cmode = 0xe;
-        *imm8 = v64 & 0xff;
+    if (v16 == (v16 & 0xff)) {
+        *cmode = 0x8;
+        *imm8 = v16 & 0xff;
+        return true;
+    } else if (v16 == (v16 & 0xff00)) {
+        *cmode = 0xa;
+        *imm8 = v16 >> 8;
         return true;
     }
-    /* Match replication across 16 bits.  */
-    if (v64 == dup_const(MO_16, v64)) {
-        uint16_t v16 = v64;
+    return false;
+}
 
-        if (v16 == (v16 & 0xff)) {
-            *cmode = 0x8;
-            *imm8 = v16 & 0xff;
-            return true;
-        } else if (v16 == (v16 & 0xff00)) {
-            *cmode = 0xa;
-            *imm8 = v16 >> 8;
-            return true;
-        }
+/* Return true if v32 is a valid 32-bit shifted immediate.  */
+static bool is_shimm32(uint32_t v32, int *cmode, int *imm8)
+{
+    if (v32 == (v32 & 0xff)) {
+        *cmode = 0x0;
+        *imm8 = v32 & 0xff;
+        return true;
+    } else if (v32 == (v32 & 0xff00)) {
+        *cmode = 0x2;
+        *imm8 = (v32 >> 8) & 0xff;
+        return true;
+    } else if (v32 == (v32 & 0xff0000)) {
+        *cmode = 0x4;
+        *imm8 = (v32 >> 16) & 0xff;
+        return true;
+    } else if (v32 == (v32 & 0xff000000)) {
+        *cmode = 0x6;
+        *imm8 = v32 >> 24;
+        return true;
     }
-    /* Match replication across 32 bits.  */
-    if (v64 == dup_const(MO_32, v64)) {
-        uint32_t v32 = v64;
+    return false;
+}
 
-        if (v32 == (v32 & 0xff)) {
-            *cmode = 0x0;
-            *imm8 = v32 & 0xff;
-            return true;
-        } else if (v32 == (v32 & 0xff00)) {
-            *cmode = 0x2;
-            *imm8 = (v32 >> 8) & 0xff;
-            return true;
-        } else if (v32 == (v32 & 0xff0000)) {
-            *cmode = 0x4;
-            *imm8 = (v32 >> 16) & 0xff;
-            return true;
-        } else if (v32 == (v32 & 0xff000000)) {
-            *cmode = 0x6;
-            *imm8 = v32 >> 24;
-            return true;
-        } else if ((v32 & 0xffff00ff) == 0xff) {
-            *cmode = 0xc;
-            *imm8 = (v32 >> 8) & 0xff;
-            return true;
-        } else if ((v32 & 0xff00ffff) == 0xffff) {
-            *cmode = 0xd;
-            *imm8 = (v32 >> 16) & 0xff;
-            return true;
-        }
-        /* Match forms of a float32.  */
-        if (extract32(v32, 0, 19) == 0
-            && (extract32(v32, 25, 6) == 0x20
-                || extract32(v32, 25, 6) == 0x1f)) {
-            *cmode = 0xf;
-            *imm8 = (extract32(v32, 31, 1) << 7)
-                  | (extract32(v32, 25, 1) << 6)
-                  | extract32(v32, 19, 6);
-            return true;
-        }
+/* Return true if v32 is a valid 32-bit shifting ones immediate.  */
+static bool is_soimm32(uint32_t v32, int *cmode, int *imm8)
+{
+    if ((v32 & 0xffff00ff) == 0xff) {
+        *cmode = 0xc;
+        *imm8 = (v32 >> 8) & 0xff;
+        return true;
+    } else if ((v32 & 0xff00ffff) == 0xffff) {
+        *cmode = 0xd;
+        *imm8 = (v32 >> 16) & 0xff;
+        return true;
     }
-    /* Match forms of a float64.  */
+    return false;
+}
+
+/* Return true if v32 is a valid float32 immediate.  */
+static bool is_fimm32(uint32_t v32, int *cmode, int *imm8)
+{
+    if (extract32(v32, 0, 19) == 0
+        && (extract32(v32, 25, 6) == 0x20
+            || extract32(v32, 25, 6) == 0x1f)) {
+        *cmode = 0xf;
+        *imm8 = (extract32(v32, 31, 1) << 7)
+              | (extract32(v32, 25, 1) << 6)
+              | extract32(v32, 19, 6);
+        return true;
+    }
+    return false;
+}
+
+/* Return true if v64 is a valid float64 immediate.  */
+static bool is_fimm64(uint64_t v64, int *cmode, int *imm8)
+{
     if (extract64(v64, 0, 48) == 0
         && (extract64(v64, 54, 9) == 0x100
             || extract64(v64, 54, 9) == 0x0ff)) {
         *cmode = 0xf;
-        *op = 1;
         *imm8 = (extract64(v64, 63, 1) << 7)
               | (extract64(v64, 54, 1) << 6)
               | extract64(v64, 48, 6);
         return true;
     }
-    /* Match bytes of 0x00 and 0xff.  */
-    for (i = 0; i < 64; i += 8) {
-        uint64_t byte = extract64(v64, i, 8);
-        if (byte != 0 && byte != 0xff) {
-            break;
-        }
-    }
-    if (i == 64) {
-        *cmode = 0xe;
-        *op = 1;
-        *imm8 = (extract64(v64, 0, 1) << 0)
-              | (extract64(v64, 8, 1) << 1)
-              | (extract64(v64, 16, 1) << 2)
-              | (extract64(v64, 24, 1) << 3)
-              | (extract64(v64, 32, 1) << 4)
-              | (extract64(v64, 40, 1) << 5)
-              | (extract64(v64, 48, 1) << 6)
-              | (extract64(v64, 56, 1) << 7);
-        return true;
-    }
     return false;
 }
 
@@ -817,11 +800,63 @@ static void tcg_out_logicali(TCGContext *s, AArch64Insn insn, TCGType ext,
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
                              TCGReg rd, tcg_target_long v64)
 {
-    int op, cmode, imm8;
+    bool q = type == TCG_TYPE_V128;
+    int cmode, imm8, i;
 
-    if (is_fimm(v64, &op, &cmode, &imm8)) {
-        tcg_out_insn(s, 3606, MOVI, type == TCG_TYPE_V128, rd, op, cmode, imm8);
-    } else if (type == TCG_TYPE_V128) {
+    /* Test all bytes equal first.  */
+    if (v64 == dup_const(MO_8, v64)) {
+        imm8 = (uint8_t)v64;
+        tcg_out_insn(s, 3606, MOVI, q, rd, 0, 0xe, imm8);
+        return;
+    }
+
+    /*
+     * Test all bytes 0x00 or 0xff second.  This can match cases that
+     * might otherwise take 2 or 3 insns for MO_16 or MO_32 below.
+     */
+    for (i = imm8 = 0; i < 8; i++) {
+        uint8_t byte = v64 >> (i * 8);
+        if (byte == 0xff) {
+            imm8 |= 1 << i;
+        } else if (byte != 0) {
+            goto fail_bytes;
+        }
+    }
+    tcg_out_insn(s, 3606, MOVI, q, rd, 1, 0xe, imm8);
+    return;
+ fail_bytes:
+
+    /*
+     * Tests for various replications.  For each element width, if we
+     * cannot find an expansion there's no point checking a larger
+     * width because we already know by replication it cannot match.
+     */
+    if (v64 == dup_const(MO_16, v64)) {
+        uint16_t v16 = v64;
+
+        if (is_shimm16(v16, &cmode, &imm8)) {
+            tcg_out_insn(s, 3606, MOVI, q, rd, 0, cmode, imm8);
+            return;
+        }
+    } else if (v64 == dup_const(MO_32, v64)) {
+        uint32_t v32 = v64;
+
+        if (is_shimm32(v32, &cmode, &imm8) ||
+            is_soimm32(v32, &cmode, &imm8) ||
+            is_fimm32(v32, &cmode, &imm8)) {
+            tcg_out_insn(s, 3606, MOVI, q, rd, 0, cmode, imm8);
+            return;
+        }
+    } else if (is_fimm64(v64, &cmode, &imm8)) {
+        tcg_out_insn(s, 3606, MOVI, q, rd, 1, cmode, imm8);
+        return;
+    }
+
+    /*
+     * As a last resort, load from the constant pool.  Sadly there
+     * is no LD1R (literal), so store the full 16-byte vector.
+     */
+    if (type == TCG_TYPE_V128) {
         new_pool_l2(s, R_AARCH64_CONDBR19, s->code_ptr, 0, v64, v64);
         tcg_out_insn(s, 3305, LDR_v128, 0, rd);
     } else {
-- 
2.17.1


