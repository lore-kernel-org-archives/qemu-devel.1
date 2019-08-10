Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB17C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A420A217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnyR5VBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A420A217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwItr-0003Gn-V3
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34902)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl5-0006JQ-9e
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl4-0004TB-CE
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:35 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIl4-0004T2-7z
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:34 -0400
Received: by mail-ot1-x343.google.com with SMTP id r21so134537625otq.6
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=15iM45DlpSKZArUqDXfgNusnAitpl/Ar5JV1uBV+dQo=;
 b=YnyR5VBVAnub7UmY9hv2BK2U8LTUIqdS6B4ggYmssHOSJ+gh8nvA8+Ia1HO0G9Lqlg
 ymb2YDOwQmUaF1QUcK25PqIhol66CWBK6ohR+r+Ag4dJTJmYLMNVi00+JPT1TuPnz1wx
 0o0taWRaZ3TP5RlBj8XrDjeIu7jZTXYQNsLkOVsge0FaUs8eb0UV5lXh+6S5978di08E
 lrydPJOaRgq6xg3SVaGltatUZIO9CRnRqjVBcnS9p0sZgEWil/NDEqaoq4nWtwIoxFoj
 PqXQlSaV+cbj1KRmtfrApcscNjvANywdCt4jDksRFr/pHIIbMV+gALJlG1WEpPYJwmZa
 hBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=15iM45DlpSKZArUqDXfgNusnAitpl/Ar5JV1uBV+dQo=;
 b=aFDFaapTpjwpaAtvGZNstHSHmyPHgpVSlXxUUehqXPFvP4/Hdqt3oxdh2ssf42pOvl
 vfc7Pn9WeiIsBKiWn+NYV09evLils9sD5nZQgGF3xY4TbjN7QYLG0epNKcbKyghEorsP
 LK+kh1TF2FZyiO3G1wH+H8JLHStNfmQ45aVWuLy2RzXggcgC0NgT7k313v36aJrqvuPN
 MacEp8JRbbYP8jx2WpVVZ+t+CpQQMHSIHHb1jdam5a6swt1WtjyParxJvoGg2oyn5zjk
 yCsm2BytHljAfGHpKupyW3LBJ5gZAORhQwzDcWWkzs/cpqBDDkltvng2yNXpNfBhlSKF
 Yl4Q==
X-Gm-Message-State: APjAAAXFzNQKoSSbfQRawYMw+eu0lPdwCBDWwo54pmJQJkxrR/7vxC8o
 7CF3AzEmdbyh3JcxBUGqYkf6XAHw
X-Google-Smtp-Source: APXvYqydqc16jOCYu2/uxBQOIN+Tb9UzSdM/MJnUT8g3E5dDzNk6sGl7hbdjSECjTkbg0sc20yd+ww==
X-Received: by 2002:a9d:4b0b:: with SMTP id q11mr21619292otf.69.1565410413531; 
 Fri, 09 Aug 2019 21:13:33 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:33 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:43 -0400
Message-Id: <20190810041255.6820-28-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [RFC PATCH v2 27/39] target/i386: introduce RdMw
 operand
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PINSRW family of instructions have a peculiar second operand:
32-bit general-purpose register file is addressed, but if the operand
is indirect, only 16 bits are loaded from memory. Reflect this by the
RdMw operand.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 0e57d5f049..9896f1c99e 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4777,6 +4777,9 @@ INSNOP(Rq, TCGv_i64, INSNOP_INIT_FAIL,
 #endif /* !TARGET_X86_64 */
 
 #ifdef TARGET_X86_64
+INSNOP_LDST(RdMw, Rd, Mw, s->tmp3_i32,
+            tcg_gen_qemu_ld_i32(reg, ptr, s->mem_index, MO_LEUW),
+            tcg_gen_qemu_st_i32(reg, ptr, s->mem_index, MO_LEUW))
 INSNOP_LDST(RdMd, Rd, Md, s->tmp3_i32,
             tcg_gen_qemu_ld_i32(reg, ptr, s->mem_index, MO_LEUL),
             tcg_gen_qemu_st_i32(reg, ptr, s->mem_index, MO_LEUL))
@@ -4784,6 +4787,9 @@ INSNOP_LDST(RqMq, Rq, Mq, s->T0,
             tcg_gen_qemu_ld_i64(reg, ptr, s->mem_index, MO_LEQ),
             tcg_gen_qemu_st_i64(reg, ptr, s->mem_index, MO_LEQ))
 #else /* !TARGET_X86_64 */
+INSNOP_LDST(RdMw, Rd, Md, s->T0,
+            tcg_gen_qemu_ld_i32(reg, ptr, s->mem_index, MO_LEUW),
+            tcg_gen_qemu_st_i32(reg, ptr, s->mem_index, MO_LEUW))
 INSNOP_LDST(RdMd, Rd, Md, s->T0,
             tcg_gen_qemu_ld_i32(reg, ptr, s->mem_index, MO_LEUL),
             tcg_gen_qemu_st_i32(reg, ptr, s->mem_index, MO_LEUL))
-- 
2.20.1


