Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D74C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F39A206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+p2PaWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F39A206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4pe-0005cQ-8y
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:40:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aZ-0000AT-6c
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aY-0007Dd-0W
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:43 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:38580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aX-00079R-QY
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:41 -0400
Received: by mail-pf1-x42d.google.com with SMTP id 10so2048898pfo.5
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=XRGr1vGdXRhAkonMl1KqLt6XzNg6ocnHD4vlzm1YL7E=;
	b=U+p2PaWsYnx2vEwrmFNjKbdHbobetC7W9bmwxh+MBgnyiCxzl7lsBjvJ2u+7dH8z4l
	WMINZsetqTDorWDSSHNRqlG/goLw6HRBMH3B4LpzxBTY3RnIcFJrCyvWcMw9F9Tufiq1
	3WtZYEOUMG08w4G2NkNzK81S13pu7LGAlawtvmaL0K681Q2E4M0DWsl5hQDZ062qWhgG
	xa4LTTUO3zgnxWPuN3f0rQTj3gtiyu+yjjDDUxgeEfQF2UZ/Pn8nkv8yp3pYvGGzMqQk
	+AtmzcyQlsa1RONKmVRV/oPHe+j5c+NjH8bWV6uEf0oi8bUV19EBjoP+j81+oxBq1oQx
	4SJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=XRGr1vGdXRhAkonMl1KqLt6XzNg6ocnHD4vlzm1YL7E=;
	b=I1HpMl4fiAx4uZw2hQVsmWo7TthcQnlNQkRMg8ztArRT6EGgeY4W9FQm92O/2v6Esi
	2GBTy/ZqNt7hL0X7pj2wIaphjl5fS6whvzpKV0nYAT6K6QKABM/5ajbPezoZniOJsPBT
	2DrdBiHOD5iyWNwkoUkwm9PW5RmHuP9IFoE9JXw90ye4E+E2LKugoRw9kgHufYIbHXLt
	mPK1E4+Veg3EXWBCYevBMtWgSN4QC4tONmQgdoZeFQiQm4gnq4r9bi4WaEGQ+2hZTllC
	9yHN3L/i0J1bFDtp+3MZAiF1Cwr9KtYxQiAkJNjsPIgdWcbyma34ItkEsGO6yYTqsErC
	iVCw==
X-Gm-Message-State: APjAAAVdikFWyw6GC+AE1RuaJ5J98HT5QrLnpd4IjPbwEY3Rp6LrHIM9
	tI9oKkAn6rtH1jGU/uz+/UgSqumNFJE=
X-Google-Smtp-Source: APXvYqxQYBHbPVE6gWlU1L1PvABBff/fZJ9xsuVB34oX+fSuxL3V2IRYqTn5QxXlEJFcdcQ7HS190g==
X-Received: by 2002:aa7:8092:: with SMTP id v18mr47460728pff.35.1556299480465; 
	Fri, 26 Apr 2019 10:24:40 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:20 -0700
Message-Id: <20190426172421.27133-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42d
Subject: [Qemu-devel] [PULL 14/15] tcg/arm: Restrict constant pool
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426172420.JXKdbCLWmAwQg319IAR3eBt3-50w4L9BUXj3YlOvMpM@z>

This will not necessarily restrict the size of the TB, since for v7
the majority of constant pool usage is for calls from the out-of-line
ldst code, which is already at the end of the TB.  But this does
allow us to save one insn per reference on the off-chance.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 57 +++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 12a65cc9a6..abf0c444b4 100644
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


