Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1895C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677A4218C3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qNuvcvhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677A4218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55565 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIxXY-0002Nm-Lb
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 11:41:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVi-0001BV-9X
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVh-0006zj-9P
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:06 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIxVh-0006z8-2q
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:05 -0400
Received: by mail-pf1-x444.google.com with SMTP id 10so7684970pfo.5
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=57LLTjI1nQcm9nBGSTBf3sb093E20lD7cyEUFj3ghB4=;
	b=qNuvcvhNnhZbx/yd/VUCDX//HI1BfjWUrDj+M8bOpioUZDA2dP4FCuMIXWb1iqxM7E
	GOcPJ5Q5fwbChkuX2/cNpOz5jiH9+eX/rO4D8ScTiq6fvT3CHu5L1Af3Rns6s9j5BqB1
	Sk1ThWAiXdtl5leI85xLIch9DmbWPrCf4IoH9KQz+NnvGup6TmbOBesQnOen+gepWpKJ
	scH4Q/PYbkYZdb1ux8brs0g55QZCHxTY5MylEGwa4ZuOUMoCdoXUxEs4SxuIzb08mGAo
	wohYa3gQjP9H7xQj0LVp7V2lIBiU3nMsIK7cGwsWC75TaYt26LapEYEulSijB7i/iEfC
	IaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=57LLTjI1nQcm9nBGSTBf3sb093E20lD7cyEUFj3ghB4=;
	b=mRq/WDcS02Qfbuw+xcrwuYNQu5Rb6vS9ZbuoHlAhDYnMqZJg9P0FTZvjIoEGlMS7qD
	CaY78cN0kQrpcs13ZO3Dpf0HjtIBzFwTZfzkLZqwP1D/WFT3Xinkn9THmotH433xYDHy
	qd1wU+JeH3G7BQ4JyK+qGdYCRT0uOqT4//49N8BvGU6BJPt8TYK6lhFaiPaXD7an5Cxp
	q8q+sVZsIEYavu1SwC4lxOyYHC5ThHj53NWPdRlsWOLE+nK7t27muBSPEWW/EDflO0s6
	WCgimJeYW7EXgjU37OzHqjSNedRIRiHqJQ/zUceGOKsB9nd+0wWX3AwhXumztfhqqF9A
	i48A==
X-Gm-Message-State: APjAAAUtkSN8F6AHAv0Lf4sj//HY8CtWvUhPphSpP1CDF7unRvh+k83a
	M3qPQpAaSaIxEGD0t6ayvGCgysjy9Pk=
X-Google-Smtp-Source: APXvYqw4adtsohSSdcizms8bvo2IsuIXBOSeO+RGpGkRcTFOiAYGmZAK7dh2Rl4E34+/xq4voFRTWg==
X-Received: by 2002:a63:e048:: with SMTP id n8mr25323272pgj.41.1556033943708; 
	Tue, 23 Apr 2019 08:39:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	c25sm24366591pfo.69.2019.04.23.08.39.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 08:39:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 08:38:52 -0700
Message-Id: <20190423153853.19790-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423153853.19790-1-richard.henderson@linaro.org>
References: <20190423153853.19790-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 6/7] tcg/ppc: Allow the constant pool to
 overflow at 32k
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423153852.zYlJJrmn84LtZjOj96PcJ3LvfGYwWGcsMFS9Mf2JoMg@z>

There is no point in coding for a 2GB offset when the max TB size
is already limited to 64k.  If we further restrict to 32k then we
can eliminate the extra ADDIS instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index c0923ced4f..36b4791707 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -529,7 +529,6 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
     tcg_insn_unit *target;
-    tcg_insn_unit old;
 
     value += addend;
     target = (tcg_insn_unit *)value;
@@ -540,22 +539,16 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     case R_PPC_REL24:
         return reloc_pc24(code_ptr, target);
     case R_PPC_ADDR16:
-        /* We are abusing this relocation type.  This points to a pair
-           of insns, addis + load.  If the displacement is small, we
-           can nop out the addis.  */
-        if (value == (int16_t)value) {
-            code_ptr[0] = NOP;
-            old = deposit32(code_ptr[1], 0, 16, value);
-            code_ptr[1] = deposit32(old, 16, 5, TCG_REG_TB);
-        } else {
-            int16_t lo = value;
-            int hi = value - lo;
-            if (hi + lo != value) {
-                return false;
-            }
-            code_ptr[0] = deposit32(code_ptr[0], 0, 16, hi >> 16);
-            code_ptr[1] = deposit32(code_ptr[1], 0, 16, lo);
+        /*
+         * We are (slightly) abusing this relocation type.  In particular,
+         * assert that the low 2 bits are zero, and do not modify them.
+         * That way we can use this with LD et al that have opcode bits
+         * in the low 2 bits of the insn.
+         */
+        if ((value & 3) || value != (int16_t)value) {
+            return false;
         }
+        *code_ptr = (*code_ptr & ~0xfffc) | (value & 0xfffc);
         break;
     default:
         g_assert_not_reached();
@@ -701,8 +694,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     if (!in_prologue && USE_REG_TB) {
         new_pool_label(s, arg, R_PPC_ADDR16, s->code_ptr,
                        -(intptr_t)s->code_gen_ptr);
-        tcg_out32(s, ADDIS | TAI(ret, TCG_REG_TB, 0));
-        tcg_out32(s, LD | TAI(ret, ret, 0));
+        tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
         return;
     }
 
-- 
2.17.1


