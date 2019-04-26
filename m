Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A09C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A222146E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYt7CoJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A222146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50012 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4hk-0006gG-DJ
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:32:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aP-0008SO-GE
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aO-0006Qu-Dj
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:33 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:38576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aO-0006N7-7Y
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:32 -0400
Received: by mail-pf1-x429.google.com with SMTP id 10so2048734pfo.5
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6JjAVwk7BIpv9HF8Msby0nLTbhNZ0HuMJj1zmmFBF1A=;
	b=sYt7CoJS9uax5jGRaFfgRoCiYeaT0heMYV+u0zshce81yNuKC9VzVGKoHP5qFHgkY/
	pw21eA33aK3L6dn+a2O6PxMvNezr6U3Ub3mNLv3yPg2vbAZ3zZy3DwAsC/3FkK59beu1
	rmmfsazgA3aROHIVSK845T9y4xbb/0eLGbX4r8u8O/lJnA/ozVGOBPxxtTria/TXXns9
	Yll1+KRF5HUdPSyVuaay4D7fM2crWAh2mUVYeqB/r+XMgpBFHIlsrsslSqBxTZNsI4oF
	K9En1JzbolMbO4co+xRcIXiWD5Y2OXLRTwTUH/KiLr1Cr8RkzADMa2hO5rTR3jPyNsnX
	KpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6JjAVwk7BIpv9HF8Msby0nLTbhNZ0HuMJj1zmmFBF1A=;
	b=COK+bQOlV507R69386/Th9coh+iK4ONoFPQp9INZAW0IdC4MtKhWsJjLCL+e2QbrcL
	zE6xN/wMNbDi4ZV9sPSSqg0Vs3OI0P5Q4d5lrycEDRJZiVdby8XjPS8/lDN3/wySmRAr
	u3os193FrA/lBOIXRm2hU85crPRwKvJbETltNAPOAXsg9bPWI+gMu1RFmiRFIHikDiih
	Rq7qwpufPVaU+P6B/tzehpiaV6SXS0AkLdsvCrdnZ8GZyUn7FtCl+Bq95syNXAKDyZZH
	WVlMYnhTchBWbQOvAk88oPOT9CN+AnF6zzqHzyYxkdG5LYIqxBIVaigpLVFkKyJtVsiL
	lP1Q==
X-Gm-Message-State: APjAAAXPCt5IablE362/P38XM97jz2+ebcjtZzeEvzQ3Qq5bezIMSHe/
	z+bYM3DyCRbzkOOU5xf28OZU6ETzNi4=
X-Google-Smtp-Source: APXvYqwcTdoaNpBWiyUFLC5rWVviOBaSfiJ9yBoK3BxIn0wKlfawYd11nuGCivsw5HqHLkBXGTTPJA==
X-Received: by 2002:a63:d84a:: with SMTP id k10mr44263966pgj.441.1556299470968;
	Fri, 26 Apr 2019 10:24:30 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:12 -0700
Message-Id: <20190426172421.27133-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::429
Subject: [Qemu-devel] [PULL 06/15] tcg/arm: Support INDEX_op_extract2_i32
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
Message-ID: <20190426172412.4ZaQqcrFTngpDPbcdwHKU6fg2PCaCVxx-AD8hsfkyOA@z>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.h     |  2 +-
 tcg/arm/tcg-target.inc.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 4ee6c98958..17e771374d 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -116,7 +116,7 @@ extern bool use_idiv_instructions;
 #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
-#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 2245a8aeb9..6873b0cf95 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -2064,6 +2064,27 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sextract_i32:
         tcg_out_sextract(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
+    case INDEX_op_extract2_i32:
+        /* ??? These optimization vs zero should be generic.  */
+        /* ??? But we can't substitute 2 for 1 in the opcode stream yet.  */
+        if (const_args[1]) {
+            if (const_args[2]) {
+                tcg_out_movi(s, TCG_TYPE_REG, args[0], 0);
+            } else {
+                tcg_out_dat_reg(s, COND_AL, ARITH_MOV, args[0], 0,
+                                args[2], SHIFT_IMM_LSL(32 - args[3]));
+            }
+        } else if (const_args[2]) {
+            tcg_out_dat_reg(s, COND_AL, ARITH_MOV, args[0], 0,
+                            args[1], SHIFT_IMM_LSR(args[3]));
+        } else {
+            /* We can do extract2 in 2 insns, vs the 3 required otherwise.  */
+            tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP, 0,
+                            args[2], SHIFT_IMM_LSL(32 - args[3]));
+            tcg_out_dat_reg(s, COND_AL, ARITH_ORR, args[0], TCG_REG_TMP,
+                            args[1], SHIFT_IMM_LSR(args[3]));
+        }
+        break;
 
     case INDEX_op_div_i32:
         tcg_out_sdiv(s, COND_AL, args[0], args[1], args[2]);
@@ -2108,6 +2129,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "s", "s", "s", "s" } };
     static const TCGTargetOpDef br
         = { .args_ct_str = { "r", "rIN" } };
+    static const TCGTargetOpDef ext2
+        = { .args_ct_str = { "r", "rZ", "rZ" } };
     static const TCGTargetOpDef dep
         = { .args_ct_str = { "r", "0", "rZ" } };
     static const TCGTargetOpDef movc
@@ -2174,6 +2197,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &br;
     case INDEX_op_deposit_i32:
         return &dep;
+    case INDEX_op_extract2_i32:
+        return &ext2;
     case INDEX_op_movcond_i32:
         return &movc;
     case INDEX_op_add2_i32:
-- 
2.17.1


