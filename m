Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795CDC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE3320873
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rL0iP2h0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE3320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37621 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4iF-0006xN-Ge
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:09:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4dN-0002qF-OK
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4b5-0002kT-V1
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:20 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4b5-0002je-P6
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:19 -0400
Received: by mail-pg1-x541.google.com with SMTP id n27so2231038pgm.4
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=zqTcnSP07QNrvm+tUagQdKAYnifB03tbX5A/KwjlV2s=;
	b=rL0iP2h0jKW9abc7xAj6Hon9dUs0yXFvg30c/6Z7XNV7VMSaKcZc1OgHJKk9bUBtL4
	/MLkU3fVKKYcWIqeTa5DTseaogjiRQkUqVHcmpJ715R0++r80BxHj+8P9/g/zmxRp0I6
	noJstJ8578xL6C8Q73urzkGYcrxF8zx9cOAIlSPTliH5Ipx3xNJxlSmmz2mjoyHzmoVY
	qS4/AYdK1EsNjWl3FfymAn7fC4DrAb4gMFiEpFeCKO0I06QUPxXj+MWOQQ+GK8UwMEu7
	9CrbII8CLhZIyyT6IF6YckVttRlj2KX2siMWuT/IA/g4p8oezSl16qTDNK6abmgN2Pqg
	LtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=zqTcnSP07QNrvm+tUagQdKAYnifB03tbX5A/KwjlV2s=;
	b=Ewchzj/djHLLY7h1jjJ9n3Pl8fKbzrebMQ86kE2MTDNHagWWZQ3gHY3bgBL49alY8p
	N6QtYS9Dwh7M5cjeTlI8Ach0TFlFgaE1GWYdXCzSMLxDnnneXGL3nAg26UgXmnq9JN61
	+boB7m6/57Qn9d7jj+xfxVKJP9FA70bLTKlX2P+9avSqJqY25ZdLSsOqpz3OUn2sX8RP
	KcuK497Dehi4pjJdCeArNjusa36QxXPAhpLuDEUkVwHQjMc4/mgxJNoxFesIFcZPDQQQ
	PI3geQB5+kq9Kw4ryddxI+HG8I7FHo6dKDFIE5YVImvdkhz/qlyyuYVhfacRNXoPs2lF
	iyFA==
X-Gm-Message-State: APjAAAXX2skti7yzaP3EeRYDocD/UluUkH5ZLPu7JEJI1M11k+Ns5r/H
	G+7JxXHjAqEYq61fEQjLseuGSe/Wtqc=
X-Google-Smtp-Source: APXvYqwQA4Y4gRI1mOksQXXbGkJwesULC3YNQ0FmWfyWFGEYkn39Z3o+YnCtpkc9ArGKKFddDNMWSQ==
X-Received: by 2002:a63:2c14:: with SMTP id s20mr47830203pgs.182.1558206137908;
	Sat, 18 May 2019 12:02:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m9sm2751274pgd.23.2019.05.18.12.02.16
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:02:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:01:55 -0700
Message-Id: <20190518190157.21255-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518190157.21255-1-richard.henderson@linaro.org>
References: <20190518190157.21255-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 14/16] tcg/aarch64: Build vector immediates
 with two insns
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

Use MOVI+ORR or MVNI+BIC in order to build some vector constants,
as opposed to dropping them to the constant pool.  This includes
all 16-bit constants and a similar set of 32-bit constants.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 0b8b733805..52c18074ae 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -273,6 +273,26 @@ static bool is_fimm64(uint64_t v64, int *cmode, int *imm8)
     return false;
 }
 
+/*
+ * Return non-zero if v32 can be formed by MOVI+ORR.
+ * Place the parameters for MOVI in (cmode, imm8).
+ * Return the cmode for ORR; the imm8 can be had via extraction from v32.
+ */
+static int is_shimm32_pair(uint32_t v32, int *cmode, int *imm8)
+{
+    int i;
+
+    for (i = 6; i > 0; i -= 2) {
+        /* Mask out one byte we can add with ORR.  */
+        uint32_t tmp = v32 & ~(0xffu << (i * 4));
+        if (is_shimm32(tmp, cmode, imm8) ||
+            is_soimm32(tmp, cmode, imm8)) {
+            break;
+        }
+    }
+    return i;
+}
+
 static int tcg_target_const_match(tcg_target_long val, TCGType type,
                                   const TCGArgConstraint *arg_ct)
 {
@@ -495,6 +515,8 @@ typedef enum {
     /* AdvSIMD modified immediate */
     I3606_MOVI      = 0x0f000400,
     I3606_MVNI      = 0x2f000400,
+    I3606_BIC       = 0x2f001400,
+    I3606_ORR       = 0x0f001400,
 
     /* AdvSIMD shift by immediate */
     I3614_SSHR      = 0x0f000400,
@@ -843,6 +865,14 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
             tcg_out_insn(s, 3606, MVNI, q, rd, 0, cmode, imm8);
             return;
         }
+
+        /*
+         * Otherwise, all remaining constants can be loaded in two insns:
+         * rd = v16 & 0xff, rd |= v16 & 0xff00.
+         */
+        tcg_out_insn(s, 3606, MOVI, q, rd, 0, 0x8, v16 & 0xff);
+        tcg_out_insn(s, 3606, ORR, q, rd, 0, 0xa, v16 >> 8);
+        return;
     } else if (v64 == dup_const(MO_32, v64)) {
         uint32_t v32 = v64;
         uint32_t n32 = ~v32;
@@ -858,6 +888,23 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
             tcg_out_insn(s, 3606, MVNI, q, rd, 0, cmode, imm8);
             return;
         }
+
+        /*
+         * Restrict the set of constants to those we can load with
+         * two instructions.  Others we load from the pool.
+         */
+        i = is_shimm32_pair(v32, &cmode, &imm8);
+        if (i) {
+            tcg_out_insn(s, 3606, MOVI, q, rd, 0, cmode, imm8);
+            tcg_out_insn(s, 3606, ORR, q, rd, 0, i, extract32(v32, i * 4, 8));
+            return;
+        }
+        i = is_shimm32_pair(n32, &cmode, &imm8);
+        if (i) {
+            tcg_out_insn(s, 3606, MVNI, q, rd, 0, cmode, imm8);
+            tcg_out_insn(s, 3606, BIC, q, rd, 0, i, extract32(n32, i * 4, 8));
+            return;
+        }
     } else if (is_fimm64(v64, &cmode, &imm8)) {
         tcg_out_insn(s, 3606, MOVI, q, rd, 1, cmode, imm8);
         return;
-- 
2.17.1


