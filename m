Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21983C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D858E206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZHOFS8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D858E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnqY-0002rL-1R
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:08:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbs-0007nO-DJ
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbr-0004JF-Ef
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:20 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbr-0004IS-8d
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:19 -0400
Received: by mail-pg1-x542.google.com with SMTP id z3so59981pgp.8
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=6HfRdIIOg5JaMDEH2+axpi9/LlfDFn1av6lWaEWwguc=;
	b=NZHOFS8XL83XUlNnyhAf37j8XiHQd7sgTb3xADe6zItsKBtF2ijJa9Sa3xbLGL1Pfb
	8+XyWzY3w92wKhrxZWVnYITglNfmtfl7wkYKwOMNcSKWqMGLdeYcZg+eWmUuvj1ryvQN
	d5hYDuOx/2J4iJRszl2+RxJqDpaYO2VMSYjNBA03+VytkMbz5p4rOQJK4Gl6UaBy+r3Q
	7OlNyuRwUq6ZPusklelcyuAh+51i0f6qQelodzYHAknLcbrWlkDnFYbu/NZwTLLu4zeK
	T46uttT1/kH7DsI3hV6r7ACV5gokjnFuwBuXjgs39L0HEE78vqquEoo1GFhl+0FzNtZb
	hZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=6HfRdIIOg5JaMDEH2+axpi9/LlfDFn1av6lWaEWwguc=;
	b=j1oCBbAmkOuxSPYaFVtWDTwbnt/cOAG6v4yhDaqyWxU8QvZLans8j2YPfyIwBIMeal
	UX2Q3L5tUE59Km9BYYF78FuYzgy9ZOVgnYWr2B2juAKc02PwzV5HsnEx3mZsddcNpfiD
	MENnApqt0eU/43aCaS6hXuye7FJW43kXXOxS6FBtkZszuyIWLYfSBtOLYmjZOCyM47XY
	Z/XBd5WddgGeL96Dfjc3PmcEZcJ1sBZIPl+IuiKQK+g5s+QFYelVeKd2mEix/Xi9M0FQ
	sYrPGceJas1rteDeLrE/QWVD/cnxNNE66kL9wKhHC/UTXszjzIvLccjtgVr5/UiL4OSl
	osgA==
X-Gm-Message-State: APjAAAVIPgDJhNF1V/D0D8w9/Jm+vSjLIlMMdH8Sk5UWCT5gFCDhvS/2
	+/OmSqOmmq5okrEuccV8drHjjOK6l8o=
X-Google-Smtp-Source: APXvYqyr3Yx91bgd6467tRxh/+/6vSrvJtlT/XhbkQD+OAHB9K1zYxqhdjVvmebc2PV9Xe492rKfRQ==
X-Received: by 2002:a63:4ce:: with SMTP id 197mr16170912pge.309.1556949197939; 
	Fri, 03 May 2019 22:53:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:42 -0700
Message-Id: <20190504055300.18426-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v3 13/31] tcg/aarch64: Implement
 tcg_out_dupm_vec
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504055242.g_sh_CAPIStDx38XkvsTYYPMshsQUiwuTZ3IxZeOyuk@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 4a3cfa778a..e8cf4e4044 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -381,6 +381,9 @@ typedef enum {
     I3207_BLR       = 0xd63f0000,
     I3207_RET       = 0xd65f0000,
 
+    /* AdvSIMD load/store single structure.  */
+    I3303_LD1R      = 0x0d40c000,
+
     /* Load literal for loading the address at pc-relative offset */
     I3305_LDR       = 0x58000000,
     I3305_LDR_v64   = 0x5c000000,
@@ -566,7 +569,14 @@ static inline uint32_t tcg_in32(TCGContext *s)
 #define tcg_out_insn(S, FMT, OP, ...) \
     glue(tcg_out_insn_,FMT)(S, glue(glue(glue(I,FMT),_),OP), ## __VA_ARGS__)
 
-static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn, int imm19, TCGReg rt)
+static void tcg_out_insn_3303(TCGContext *s, AArch64Insn insn, bool q,
+                              TCGReg rt, TCGReg rn, unsigned size)
+{
+    tcg_out32(s, insn | (rt & 0x1f) | (rn << 5) | (size << 10) | (q << 30));
+}
+
+static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn,
+                              int imm19, TCGReg rt)
 {
     tcg_out32(s, insn | (imm19 & 0x7ffff) << 5 | rt);
 }
@@ -825,7 +835,29 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                              TCGReg r, TCGReg base, intptr_t offset)
 {
-    return false;
+    if (offset != 0) {
+        AArch64Insn add_insn = I3401_ADDI;
+        TCGReg temp = TCG_REG_TMP;
+
+        if (offset < 0) {
+            add_insn = I3401_SUBI;
+            offset = -offset;
+        }
+        if (offset <= 0xfff) {
+            tcg_out_insn_3401(s, add_insn, 1, temp, base, offset);
+        } else if (offset <= 0xffffff) {
+            tcg_out_insn_3401(s, add_insn, 1, temp, base, offset & 0xfff000);
+            if (offset & 0xfff) {
+                tcg_out_insn_3401(s, add_insn, 1, temp, base, offset & 0xfff);
+            }
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, temp, offset);
+            tcg_out_insn(s, 3502, ADD, 1, temp, temp, base);
+        }
+        base = temp;
+    }
+    tcg_out_insn(s, 3303, LD1R, type == TCG_TYPE_V128, r, base, vece);
+    return true;
 }
 
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
-- 
2.17.1


