Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43D9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705EA20702
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN09WyT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705EA20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshc3-0007ZW-My
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshah-00064k-1i
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:00:31 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshaf-0002eO-Fw
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:00:30 -0400
Received: by mail-wr1-x443.google.com with SMTP id k6so43965257wrn.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a5MgrqzC2j1JrtNr8erhFYvekzCWdPEqkZHuGtykIIg=;
 b=nN09WyT99UK2pikA1PQ+Zw1eR6b4vo7QjNq2+4T9ODHTwCFcrpUnUFaTq2LwcSdU+z
 ZAh/adPSekLjJwmVhxuTtPtVtrp9FUyhQbA32hcvNZ60XyV5ixBo1/FLTc1NXwht5xY7
 6TWRQfzyO/hap/vjD6nJ63Uuo6Rdphrbq36VURhz9cqEwYEBV0M5QDirIHZJA6wbvtfM
 8XkqRL7J7Fv92Evv617mmCddWFa14CplVjqSi2US2XYl2b6D+nW/ITuxxg5g4XnCMSBu
 RFzNXqoju0+2TSwxd92s+7s5o26vXoLCvR+FxvOAe4ecBlbfL+MHDF7RKmx+/cNrNLLy
 585A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=a5MgrqzC2j1JrtNr8erhFYvekzCWdPEqkZHuGtykIIg=;
 b=Frx6nfJ+b1g4f+as6j3EegPq/fqPis3QLM2kxoTKaSNcNPl6LE0a5RljzLk/g1q/pS
 g2LtA5zSp1HfEczaLdN7N4gz+c5F/cnV4s+0XQoCoTTj7dd0utGT4zQFRfwTzmzMkPxO
 nveebncjUSssOHWxrzTkJTjDKRZbmJXxNYXla3jfqWn+5KC9m/xW2r5kTao90Hurq9lg
 eXHuWut3yMJpuLAK8LsmsCIErCS+8tiM86v/6P9bMinrWjO37Gnd9RCSDQxspkUNNX+h
 Qs+FDanHESrgu9xTCEMycm2k59LXE8S8x5gFzbXHZ5YkEwUe7p3ZYNEdren+/UWu56Hl
 PlYg==
X-Gm-Message-State: AOAM5330uYrcgGmTyy2vrwhgJ8tlzC9Ohas2Ni1OwE6rJ/E+42IsFjMz
 MhBtWH11GDH42CGArzUv+h92NzPV
X-Google-Smtp-Source: ABdhPJxAdcNEEclM0ge116U4jeobjXnmgwlbTmhwy0hNpMxphwr/CZ6xnoFUQRKQqHJ/DXFQJtxwvA==
X-Received: by 2002:adf:e801:: with SMTP id o1mr53302655wrm.54.1594105227895; 
 Tue, 07 Jul 2020 00:00:27 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id r3sm30763634wrg.70.2020.07.07.00.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:00:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] target/avr/disas: Fix store instructions display order
Date: Tue,  7 Jul 2020 09:00:20 +0200
Message-Id: <20200707070021.10031-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707070021.10031-1-f4bug@amsat.org>
References: <20200707070021.10031-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While LOAD instructions use the target register as first
argument, STORE instructions use it as second argument:

  LD Rd, X        // Rd <- (X)

  ST Y, Rd        // (Y) <- Rr

Reported-by: Joaquin de Andres <me@xcancerberox.com.ar>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/disas.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/avr/disas.c b/target/avr/disas.c
index 23bd9919ed..7fa6e8711b 100644
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


