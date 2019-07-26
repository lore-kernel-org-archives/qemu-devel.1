Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7CFC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BE422BF5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLloNoZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BE422BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4O2-0007LJ-GH
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57120)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Md-0001pV-Up
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mc-0007Ok-Rt
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:43 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43171)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Mc-0007Hs-Lk
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:42 -0400
Received: by mail-pl1-x643.google.com with SMTP id 4so18030133pld.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hX3AW17o2PIgWW1hwgb4F4i9rjNSXrxFa91FWtRbpGo=;
 b=gLloNoZOxtLByK/MTAwGv6CqokWdIJ7gMXXF9egTgTBWUsY6ZOo5ryePADqYcs71y4
 GEmlszug5YpaT4L+LTC6lFAofXr2J8Vnb1w+80oi8P0WfwcFBLeMN95dIr7IHKsSp5QU
 dXi5YcfuRUs3UvRJamcM+bSv72P9koioiekJg1/5gI+mzfdDCHLJA7KIMvDbC2IOAhI4
 ldJRiPTDMBoynB2mBsKBu+y79Ro2DUABd4M2m6s2K3TceLQh2f9FVJOiWcwfYUl2qIf6
 KDE4rvwKc78uHf8ygfhD+xBBpBDuTbFiYKSVZkKRiC0FmGRgHkHcSnmVBH/tl6nwonq8
 vWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hX3AW17o2PIgWW1hwgb4F4i9rjNSXrxFa91FWtRbpGo=;
 b=OUOVDFhwx8TnD3ugpGTKkhYl1m1UCMxP2wiB+bY9bW4qv7YA7Tz4z5wLtBrpsHsAoL
 BXqsj/o2H5BZqq83A757iGh1z4xYsrL35MKLcCSYkTuXjAGc/hqK1ia1eDwECd6qzVzA
 FyhYOL/NjHOzqOZaFHRCpObvgtQ+ku/EWrUbFlaUkFZbK56llwuGiRo3jG2D97n0AoNj
 Xa0+BnC2m/73LPsnOpZCdEsG58ZHxoRL2VTR39aLCeL1MMFuokztTd/pNrKtawxrRsom
 cNbsH3UmqxSNm6laVvaaTkmrYYh6g89EHkoyJCBGOxZiT2kdpK60jMs/p0ePM6LB03G5
 sljA==
X-Gm-Message-State: APjAAAVTZlUNyWz37rbj7HhmSu7mnT3i8qwo0u3rInjD1QzSZkvM8yQj
 /M+QdWZ+aHGFjPbLjzho+/jwgfWk6C4=
X-Google-Smtp-Source: APXvYqz/OoR1VHD8vyYiMB/yal0X+HBsVEoIEs9z2KKuafOWq7xy8mxS8eP4/Fsp4gntkB9nr0RnFQ==
X-Received: by 2002:a17:902:2ac8:: with SMTP id
 j66mr93064289plb.273.1564163439414; 
 Fri, 26 Jul 2019 10:50:39 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:29 -0700
Message-Id: <20190726175032.6769-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH 04/67] target/arm: Remove offset argument to
 gen_exception_internal_insn
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The actual argument is 0 for all callers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 19b126d4f3..0848fb933a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1239,10 +1239,10 @@ static inline void gen_smc(DisasContext *s)
     s->base.is_jmp = DISAS_SMC;
 }
 
-static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
+static void gen_exception_internal_insn(DisasContext *s, int excp)
 {
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - offset);
+    gen_set_pc_im(s, s->pc);
     gen_exception_internal(excp);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1294,7 +1294,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
         s->current_el != 0 &&
 #endif
         (imm == (s->thumb ? 0x3c : 0xf000))) {
-        gen_exception_internal_insn(s, 0, EXCP_SEMIHOST);
+        gen_exception_internal_insn(s, EXCP_SEMIHOST);
         return;
     }
 
@@ -11984,7 +11984,7 @@ static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
         /* End the TB early; it's likely not going to be executed */
         dc->base.is_jmp = DISAS_TOO_MANY;
     } else {
-        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
+        gen_exception_internal_insn(dc, EXCP_DEBUG);
         /* The address covered by the breakpoint must be
            included in [tb->pc, tb->pc + tb->size) in order
            to for it to be properly cleared -- thus we
-- 
2.17.1


