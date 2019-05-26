Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721C1C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47CE420815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CE420815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUiEH-0001t0-HP
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:45:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxM-0003HK-Ef
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhg6-0005zq-1x
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:23 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:41330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhg4-0005rT-36
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:21 -0400
Received: by mail-pf1-f178.google.com with SMTP id q17so2651154pfq.8
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=wFaos8LfgCUNeyF5mCTB+VZebrOrlkwKLg03H+AhURg=;
	b=M5R0jxQjooNt1DqR/qWIA9cy/FrIrfLhS4OoeStCY8V4cpPzYGeb+KajdlnSpjOt0G
	u70BD0Ed1KAHQLfWeTzEQamrk/RlUtXsgEJFhWMOG/I5eAM7sieTiBbFfbzXLjmroLJX
	222l8NVFnxH87eaTYevFzfab5pciWupcV4yBtOl3c44xkR+QidCd/dsq5f9X3nEFALaq
	+YshDsX70oFXyhYXcD9Kiy9GkehJaoCq6nifJb54v/dLNgUcAXEwDcjtW1lgpR5cbo2U
	RFugR3oYVTDtFqLdrWDjdgJwaXZzEYuKMtAdCOCAW6u+vAQGm9Ql1al3+2P//eG894Y2
	5UqQ==
X-Gm-Message-State: APjAAAV4IQ+joKbXyrAAGayxPRSUhAAMXAdWKfPJrbuTXM5VubpKmfEd
	L1RYr8DMGrRyZ+KxS5iXIP8qnA==
X-Google-Smtp-Source: APXvYqwktkR2TST2Q+9uDr24BRvVLcGngfY7/UDg7gkqELQ7uOJA5Kk3ATa85CFbsVyrwz9AH1/vcw==
X-Received: by 2002:a63:2c4a:: with SMTP id s71mr99074975pgs.343.1558833016754;
	Sat, 25 May 2019 18:10:16 -0700 (PDT)
Received: from localhost ([12.206.222.5])
	by smtp.gmail.com with ESMTPSA id x7sm6918429pfm.82.2019.05.25.18.10.15
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:15 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:30 -0700
Message-Id: <20190526010948.3923-12-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.178
Subject: [Qemu-devel] [PULL 11/29] target/riscv: Remove spaces from register
 names
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

These extra spaces make the "-d op" dump look weird.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b7675707e0fe..6a58bc9e9d90 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -30,17 +30,17 @@
 static const char riscv_exts[26] = "IEMAFDQCLBJTPVNSUHKORWXYZG";
 
 const char * const riscv_int_regnames[] = {
-  "zero", "ra  ", "sp  ", "gp  ", "tp  ", "t0  ", "t1  ", "t2  ",
-  "s0  ", "s1  ", "a0  ", "a1  ", "a2  ", "a3  ", "a4  ", "a5  ",
-  "a6  ", "a7  ", "s2  ", "s3  ", "s4  ", "s5  ", "s6  ", "s7  ",
-  "s8  ", "s9  ", "s10 ", "s11 ", "t3  ", "t4  ", "t5  ", "t6  "
+  "zero", "ra", "sp",  "gp",  "tp", "t0", "t1", "t2",
+  "s0",   "s1", "a0",  "a1",  "a2", "a3", "a4", "a5",
+  "a6",   "a7", "s2",  "s3",  "s4", "s5", "s6", "s7",
+  "s8",   "s9", "s10", "s11", "t3", "t4", "t5", "t6"
 };
 
 const char * const riscv_fpr_regnames[] = {
-  "ft0 ", "ft1 ", "ft2 ", "ft3 ", "ft4 ", "ft5 ", "ft6 ",  "ft7 ",
-  "fs0 ", "fs1 ", "fa0 ", "fa1 ", "fa2 ", "fa3 ", "fa4 ",  "fa5 ",
-  "fa6 ", "fa7 ", "fs2 ", "fs3 ", "fs4 ", "fs5 ", "fs6 ",  "fs7 ",
-  "fs8 ", "fs9 ", "fs10", "fs11", "ft8 ", "ft9 ", "ft10",  "ft11"
+  "ft0", "ft1", "ft2",  "ft3",  "ft4", "ft5", "ft6",  "ft7",
+  "fs0", "fs1", "fa0",  "fa1",  "fa2", "fa3", "fa4",  "fa5",
+  "fa6", "fa7", "fs2",  "fs3",  "fs4", "fs5", "fs6",  "fs7",
+  "fs8", "fs9", "fs10", "fs11", "ft8", "ft9", "ft10", "ft11"
 };
 
 const char * const riscv_excp_names[] = {
-- 
2.21.0


