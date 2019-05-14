Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CD2C04AAA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972E52084F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uGgMSdBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972E52084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36599 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQL0L-0002fr-Pc
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:09:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKy5-0001d8-L5
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxJ-0003JU-F3
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:52 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxH-0003Cy-4K
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:05 -0400
Received: by mail-pf1-x441.google.com with SMTP id n19so8073427pfa.1
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=NDeQiI120O8qPLtGObyt0DUpB7btZP10JZcwXpqFkfc=;
	b=uGgMSdBuP7yJnGqjk468tLkGVcdYB2nHjveFzgw1rNh0ivSnoV5R4lD23s9sfWva82
	kea6pKiDOO0WB6K3hUIpVWip/OBkWel1jept3Iup0P/UPbnQcYaDx8b39CbI7BYBoNFu
	RR9cOuaqsNqJ4DcwRidvEo89xNchDVdRq9MO/BE1X32jDJlcRJ/fF9BqX1bxkjX9kBb9
	gKVv0jH7FoUQUV7HhHV/XXpEojl20AqZ0yjE+V5Vwa2zYzb230l1kxc+pY2ePemnrU8C
	546cMuIZum0ei3jjyCYorIzIJIPKW0GAvzwSkVt0yUawJ6r+3mNzHJirOh4KuTH1KWs1
	ncRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=NDeQiI120O8qPLtGObyt0DUpB7btZP10JZcwXpqFkfc=;
	b=niceH6m2TE9xkvjU3NLxWM6CgulOfLS3P5PNbVuzUSwQ8T7mfTLo8okdIhxQjZ6A8W
	9qRQ5Uoo6DA+7ot914G++uh8gUyLwbhnWQxCU4lOCvfwOFhnV3SOT1ZzRmPx2nvPr+O9
	IO0JNPPUkLmoJkjKgA0UozAs9lQJtz9fLKSXDuLrjXIuTPB2bLWh2WJi9R38QmfNJVN2
	c77YEPmmMpUR8u4Ngnd370YJMxBeOQPmChKObV24Doc6nfolmMnVBeFxxtiUFRuJ+/gb
	LsucBQEGxWC/hvm6hzVddHiaWTapqTWcgvpGticHRFcbzLDRRekrliTyMj3X8yBlr2Md
	cX+w==
X-Gm-Message-State: APjAAAXjezj83vrGBIhKED2GZo1LDCy3NHzfA50r0RicdtZmJxMmhsFZ
	33C2nKJb4vtIJArfCS3t2IFeBYxKcaM=
X-Google-Smtp-Source: APXvYqxI36PtdpwnOn5hl4hNmV1nlT91riTpfyV2zLayFoiEuXpYKVovxJbcp3KOgxwzwHvnNec7qg==
X-Received: by 2002:a63:4a66:: with SMTP id j38mr15912424pgl.199.1557792360613;
	Mon, 13 May 2019 17:06:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.05.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:05:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:22 -0700
Message-Id: <20190514000540.4313-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PULL 13/31] tcg/aarch64: Implement tcg_out_dupm_vec
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

The LD1R instruction does all the work.  Note that the only
useful addressing mode is a base register with no offset.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 37 ++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 4a3cfa778a..b4585724d3 100644
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
@@ -825,7 +835,30 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                              TCGReg r, TCGReg base, intptr_t offset)
 {
-    return false;
+    TCGReg temp = TCG_REG_TMP;
+
+    if (offset < -0xffffff || offset > 0xffffff) {
+        tcg_out_movi(s, TCG_TYPE_PTR, temp, offset);
+        tcg_out_insn(s, 3502, ADD, 1, temp, temp, base);
+        base = temp;
+    } else {
+        AArch64Insn add_insn = I3401_ADDI;
+
+        if (offset < 0) {
+            add_insn = I3401_SUBI;
+            offset = -offset;
+        }
+        if (offset & 0xfff000) {
+            tcg_out_insn_3401(s, add_insn, 1, temp, base, offset & 0xfff000);
+            base = temp;
+        }
+        if (offset & 0xfff) {
+            tcg_out_insn_3401(s, add_insn, 1, temp, base, offset & 0xfff);
+            base = temp;
+        }
+    }
+    tcg_out_insn(s, 3303, LD1R, type == TCG_TYPE_V128, r, base, vece);
+    return true;
 }
 
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
-- 
2.17.1


