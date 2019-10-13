Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3599C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647AB206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7fNyZx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647AB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmOX-0003Ql-99
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJI-0006dd-68
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJH-0000qz-4M
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:56 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:33187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJG-0000qj-VH
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:55 -0400
Received: by mail-pg1-x532.google.com with SMTP id i76so8944549pgc.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=F5Jk4BgYV+IrFiQYLiTJ8dyG7O5cI5KoMzGTShZaza4=;
 b=O7fNyZx5vHo7PrJt3DpbLgUc/P7v8pPgy0WHGvBFVJ+TxJ/kYDxZDjmCDJXKyB0aez
 W69vZIK6QVdgzcr73TjL5WjSK/XewLQRuHbJOPiJ368FB+uolYvcRsXkAfZgxi9dwQSu
 EQrZe3g4XOOm/gP1XdRfm3WNeUjH795frF2Tp+BfNqvZKDEBGWjipCofkh9ImXVYnV7w
 gwMJpqWWdiFRIQXlgiJXgzCc3EBVWXB1VucXHVqRFIMGOeglBaLgkTLfTHgVyc2WafAA
 m9qlaexgAxrecz5C6m1Mykt7ZQok+IlVYr3EJSLSw4njFDTR88a2MT7QJYKCUmbvZTFZ
 y+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=F5Jk4BgYV+IrFiQYLiTJ8dyG7O5cI5KoMzGTShZaza4=;
 b=bByoSOCKrWKuqdihS0CgCwlDHD1cwMQ5zOfuBGk13ib8vUBOX+tssqscSdEzMjDo1W
 d/VAPPQOvLVtwI/dsyuKBAGZ+y/WDZLbShf4I0ZWJIR+HqV2EqE9Rvkl5SnUOVdcb11U
 PLesFZ7BqQDpN3mAGx9CLMRL7oTKXTyEde5/27cRjgXz1T5Mzv8Yg4TocWCgIzk8ImrH
 65asWggp948Ce+yXD/0HBF0AMDVMc6qwjfjfEIoDrS1zYVBihidjPnEvgLQsPvFyPLOe
 xYQ4wpKiPjFROuqYeubj/Q/iLDW/M/nZJAw06uCHqrPjIZ5a3CIDskCJLF24VgOHHOdl
 rYDQ==
X-Gm-Message-State: APjAAAUC48+A5nabA0RIXyO4VBgfrAZbBWs/Tc7Xqn0M4wkNkoDdu9K/
 T++r8x6W+KCgbn3RQlexII6zhoBWoio=
X-Google-Smtp-Source: APXvYqxhqCvDr4qkiGAd5UGzO3u/U8SkBGCtvHra+5hO//EeICqlhG+V4DcXnMJSZuhOJyzukNkB5A==
X-Received: by 2002:a63:ff1c:: with SMTP id k28mr30201635pgi.281.1571005553566; 
 Sun, 13 Oct 2019 15:25:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:25:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/23] tcg/ppc: Replace HAVE_ISA_2_06
Date: Sun, 13 Oct 2019 15:25:26 -0700
Message-Id: <20191013222544.3679-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::532
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is identical to have_isa_2_06, so replace it.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 0bfaef9418..7cb0002c14 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -66,7 +66,6 @@ static tcg_insn_unit *tb_ret_addr;
 
 TCGPowerISA have_isa;
 
-#define HAVE_ISA_2_06  have_isa_2_06
 #define HAVE_ISEL      have_isa_2_06
 
 #ifndef CONFIG_SOFTMMU
@@ -1797,7 +1796,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
         }
     } else {
         uint32_t insn = qemu_ldx_opc[opc & (MO_BSWAP | MO_SSIZE)];
-        if (!HAVE_ISA_2_06 && insn == LDBRX) {
+        if (!have_isa_2_06 && insn == LDBRX) {
             tcg_out32(s, ADDI | TAI(TCG_REG_R0, addrlo, 4));
             tcg_out32(s, LWBRX | TAB(datalo, rbase, addrlo));
             tcg_out32(s, LWBRX | TAB(TCG_REG_R0, rbase, TCG_REG_R0));
@@ -1869,7 +1868,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
         }
     } else {
         uint32_t insn = qemu_stx_opc[opc & (MO_BSWAP | MO_SIZE)];
-        if (!HAVE_ISA_2_06 && insn == STDBRX) {
+        if (!have_isa_2_06 && insn == STDBRX) {
             tcg_out32(s, STWBRX | SAB(datalo, rbase, addrlo));
             tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, addrlo, 4));
             tcg_out_shri64(s, TCG_REG_R0, datalo, 32);
-- 
2.17.1


