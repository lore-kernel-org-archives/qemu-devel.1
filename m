Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7690CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47230206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvsUNK7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47230206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssP2-00070F-JP
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAR-0000LA-2o
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:18:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:53838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAP-0002yI-3p
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:18:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id j18so87563wmi.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6apVHmUX1sQghDEgspgrVs7hzcpsE7H69LE8xMVMmLI=;
 b=rvsUNK7hb4jkAQs932RGdgy0Nckme/sSAkINr4yGbWNMvnS7GUti9XPAeJW4dL0yb8
 9+Hl3eNFAzpJ03BQ9CXpdNCxQ2nlLf1+uSXjtmQVlGtnxMLXUkXpGeGoILisjRUlG4Pl
 nfF+lfkLfUZDXLnsXeyPSMlkg4qoq8MvgCB4NP4D14NJynRBCA+3AcG6UUok/bo/3G4y
 g4ZPXopYyI7J3a4BQhsdQmYY5Bq5zm1fKbBVfmyjzB4ThZ0bUlre4Xh/Ft4HdUeEgOzg
 vIycJSesClib3PMF11iIeFbXO2U4849aqBm040CCvzEn0JgLQ29iAIGEhzm6TdnyzUGa
 7vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6apVHmUX1sQghDEgspgrVs7hzcpsE7H69LE8xMVMmLI=;
 b=VGSaY6dW0JCwCbQ18WJnAAXvK1ou/HZq9xXSn1qpag99UNRArIoOGDSoemhpW5Q3NX
 yDsBJUnNaGb1qZBxDz0HZ4ZTuBtr/ADVlcsATRnIg7Wa7+tFXZvmVaC6xD4zo2U3Cweq
 60FHAmXolJOhwrfCyhldTOoqj5IFEXSr+1/NN9fE6t+xgvRxlAS9zWbT1oaxuR5MYM7Z
 ibdXyWJeN3RGVhKj91Z8zw4dtbTTHwDFDpPqE76VXpHC4RZ2Z92O2WtLpIae47wPuQ6m
 MdGGPxMW6KWXKtUBRjidiSFYX39sbDj7pqrIH4Q6PbU4JTxRiyfV9aHR9jUMmcZfM0cI
 G6NQ==
X-Gm-Message-State: AOAM532FR8hnGKOA60mOjAUSrrJC8qYrXv/nMXxRktMwnpIvhY8ziWyL
 slfF/Y1UMvVzYxwb0M9ATGwHXU/M
X-Google-Smtp-Source: ABdhPJzTNOzfjJGiH5Xrs98K59eB/5JIWy9kOe/45ez+trsNSuo8nisIYenWbdSf2SL/L9i1NADaGg==
X-Received: by 2002:a1c:3954:: with SMTP id g81mr5383259wma.73.1594145883518; 
 Tue, 07 Jul 2020 11:18:03 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:18:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/32] target/avr/disas: Fix store instructions display order
Date: Tue,  7 Jul 2020 20:17:10 +0200
Message-Id: <20200707181710.30950-33-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While LOAD instructions use the target register as first
argument, STORE instructions use it as second argument:

  LD Rd, X        // Rd <- (X)

  ST Y, Rd        // (Y) <- Rr

Reported-by: Joaquin de Andres <me@xcancerberox.com.ar>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200707070021.10031-4-f4bug@amsat.org>
---
 target/avr/disas.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/avr/disas.c b/target/avr/disas.c
index 8c11509ce8..70d65ea4b2 100644
--- a/target/avr/disas.c
+++ b/target/avr/disas.c
@@ -196,16 +196,16 @@ INSN(LDZ2,   "r%d, Z+", a->rd)
 INSN(LDZ3,   "r%d, -Z", a->rd)
 INSN(LDDY,   "r%d, Y+%d", a->rd, a->imm)
 INSN(LDDZ,   "r%d, Z+%d", a->rd, a->imm)
-INSN(STS,    "r%d, %d", a->rd, a->imm)
-INSN(STX1,   "r%d, X", a->rr)
-INSN(STX2,   "r%d, X+", a->rr)
-INSN(STX3,   "r%d, -X", a->rr)
-INSN(STY2,   "r%d, Y+", a->rd)
-INSN(STY3,   "r%d, -Y", a->rd)
-INSN(STZ2,   "r%d, Z+", a->rd)
-INSN(STZ3,   "r%d, -Z", a->rd)
-INSN(STDY,   "r%d, Y+%d", a->rd, a->imm)
-INSN(STDZ,   "r%d, Z+%d", a->rd, a->imm)
+INSN(STS,    "%d, r%d", a->imm, a->rd)
+INSN(STX1,   "X, r%d", a->rr)
+INSN(STX2,   "X+, r%d", a->rr)
+INSN(STX3,   "-X, r%d", a->rr)
+INSN(STY2,   "Y+, r%d", a->rd)
+INSN(STY3,   "-Y, r%d", a->rd)
+INSN(STZ2,   "Z+, r%d", a->rd)
+INSN(STZ3,   "-Z, r%d", a->rd)
+INSN(STDY,   "Y+%d, r%d", a->imm, a->rd)
+INSN(STDZ,   "Z+%d, r%d", a->imm, a->rd)
 INSN(LPM1,   "")
 INSN(LPM2,   "r%d, Z", a->rd)
 INSN(LPMX,   "r%d, Z+", a->rd)
-- 
2.21.3


