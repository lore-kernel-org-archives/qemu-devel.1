Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F32ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59EB20673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w/nWkjRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59EB20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyQj-0000Op-LO
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy27-0006Xd-RV
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy26-00055v-Na
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:56:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJy26-00052L-HR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:56:58 -0400
Received: by mail-wm1-x341.google.com with SMTP id 7so16780402wme.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s/Kxt0sJmOqiRHlmaA5zdwUg0XEvdkyMNiTJ70WsIM0=;
 b=w/nWkjRNXKlnA+PYL6hBeRzOc+3Ky3RofHHqHE406V4pk+mEUUiA5AFqwUdM7JACJX
 4ZNbkPdNSRSk5bwnQa2yBQxQgLFZo8UQFE1t5FTKYwPMu9wcQzdlEdEgiWylLRKH5V0f
 uLu/1Ts2TuW6EemTH4uq1WAsDjRmDsVNbR156i372GuBenrSQFWQB547XlJQYpT74Ejv
 V/w6IGOAKathLXkVE7f9Ko6a6N/Iv3uKD4X+28kpsLJaOK1FLK96aykdGwQ2uDUnBxfg
 UWRku/qhC5qASK14P0BK3Kri7/9MITx7Zl9STBVDrZKWsOWr9onum0Tb5uZOWSmW1k4j
 PGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s/Kxt0sJmOqiRHlmaA5zdwUg0XEvdkyMNiTJ70WsIM0=;
 b=EzryneJ3Lbkp6Hrfydba3Ey1iKMROJPdqyZigfKwrEZul+5BHxSNV5qdip0n7k4lSl
 LSF2wSdgvUn2+4Ij5XmnRQm2Ocd52fLQ4blyjF2mWhz3g8KjgbMEUJbAJmnGTXLCa/rU
 3tLJsDMXWhnqkXplytEFou9EWBZif7OYtoTDt9HsTjX8aJMAD0YaYPsB6wrSK5ATNua/
 /A5ThiZANBtj7woxkNjCPIbsWV7cX1XXFWSXntPSJrA7R7pPhvq4rKFHRDRviC1oEZiU
 BiCBHIpDaOZy/LqhfIVmOrQOyk7149xeLv55J+vGExFFARizzyCAWI0Vrx0DAJGDNUph
 8Q6A==
X-Gm-Message-State: APjAAAWAfJjT6BU0N+DJOMh3VXvZQ6mcSTntGxx1t7SYJwiX/10GtF9w
 KLkS4KxnrKKvSCfGqQ136tSL1Q==
X-Google-Smtp-Source: APXvYqy77rtFZ8wDB2lzlGhzkmDmMjKJEvFv8hIcC9vk5mwo5FfpLPpH73GUE17oI6bYLOmGWLYLPw==
X-Received: by 2002:a7b:cab1:: with SMTP id r17mr14135756wml.106.1571050615326; 
 Mon, 14 Oct 2019 03:56:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c132sm26763719wme.27.2019.10.14.03.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:56:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 688701FFBD;
 Mon, 14 Oct 2019 11:49:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 32/55] target/sparc: fetch code with translator_ld
Date: Mon, 14 Oct 2019 11:49:25 +0100
Message-Id: <20191014104948.4291-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 robert.foley@futurewei.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.puhov@futurewei.com, aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c68bf4a2e4..edc23a7c40 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5884,7 +5884,7 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     CPUSPARCState *env = cs->env_ptr;
     unsigned int insn;
 
-    insn = cpu_ldl_code(env, dc->pc);
+    insn = translator_ldl(env, dc->pc);
     dc->base.pc_next += 4;
     disas_sparc_insn(dc, insn);
 
-- 
2.20.1


