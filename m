Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A8ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63CA21D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zp7idPz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63CA21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtlK-0002kQ-FH
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWd-0003Xo-Lm
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWc-0007nN-Dx
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:38635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtWc-0007mT-79
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id 22so674076wms.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WDjpXJj0uBYd5PmXLsk0rGmuclu/FmbPxSWoq/ihEys=;
 b=zp7idPz+dJzqoea/z9N9v+Wji6ytiTbObbMh9fR3+OeUNf/HeYIFCpiudd+y6pbuQY
 O57o62aqDCpGG8ffzDJXY/ihp3plZBics5IVp78+1z5oU/g9HjdWCuvMxjgD7k92cWqt
 t3JZD7ZyCb/UaetUbas2I1f0oV/VOSGDZQQE+UkP3OkK7hheJqRKGyVZejaasG2RdPxJ
 uezz721tJS9eTt/FzXpvhwNjdBYKyAT/Dleo0xY4A4m54b2/iwntRtcJ90LRLIzioWjr
 /oT5irmxaCXmf5r8s1BY+swULZnE1dcLd8cPbSn/o4mErvjQktdngp2cbJn4he3rX7qA
 w6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WDjpXJj0uBYd5PmXLsk0rGmuclu/FmbPxSWoq/ihEys=;
 b=K89uuzuqZMTJsuDDJiY165Bh5Gvf60q/SqDHZTaLGqLjE/QKaP4Uo6nyC5djQ3TBOL
 u4K6VywxWbnRu0seEjzD8XZ0QFOLLDFaE9YX20n30pyuDyoUh4Dw2m4GNo7QHRIFPvkr
 3iJoI5QU/Cp2lhhHWAToo3QfZiLbke3d0Iz9+S1uYM/yUBvtg4ZXB8fOTx11tp6Jk9Dg
 gvo6UgkfpCDZr3do5tFNF+ghraWr6i9Wh7f+AXxnxjfpMRY42rlPL4vZd2KVhin45xvD
 3KObALiQEOMs0unuc+nUroi+BUT8sOT9w1Wb5+WErs5KbfLqETSp8xGzwFuCHZVY0Hgv
 IxBg==
X-Gm-Message-State: APjAAAWbjs8Wnes2bJWz8gC/OkFR6nOvO/rrnHRoWn5Ndnt4vTZqrQeT
 09g6wPT3EGF+m5VqSTbdAw3t9Q==
X-Google-Smtp-Source: APXvYqzdiXYQd9GvaeG/D7xlm8xbynsOsIEjOjJI07/6yK4XDNb6sjKin9Txtv61i5rdg6FrLdmJdg==
X-Received: by 2002:a1c:1f03:: with SMTP id f3mr1894019wmf.131.1571986600989; 
 Thu, 24 Oct 2019 23:56:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r3sm1446173wre.29.2019.10.24.23.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:56:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A78CB1FFC1;
 Fri, 25 Oct 2019 07:37:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 41/73] target/ppc: fetch code with translator_ld
Date: Fri, 25 Oct 2019 07:36:41 +0100
Message-Id: <20191025063713.23374-42-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index adb8fd516f1..f5fe5d06118 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7853,11 +7853,9 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     LOG_DISAS("nip=" TARGET_FMT_lx " super=%d ir=%d\n",
               ctx->base.pc_next, ctx->mem_idx, (int)msr_ir);
 
-    if (unlikely(need_byteswap(ctx))) {
-        ctx->opcode = bswap32(cpu_ldl_code(env, ctx->base.pc_next));
-    } else {
-        ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
-    }
+    ctx->opcode = translator_ldl_swap(env, ctx->base.pc_next,
+                                      need_byteswap(ctx));
+
     LOG_DISAS("translate opcode %08x (%02x %02x %02x %02x) (%s)\n",
               ctx->opcode, opc1(ctx->opcode), opc2(ctx->opcode),
               opc3(ctx->opcode), opc4(ctx->opcode),
-- 
2.20.1


