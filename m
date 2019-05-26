Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E81C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7774520644
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7774520644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49175 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUi3V-0000PY-NQ
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:34:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxH-0003GC-S2
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhgD-0006Ly-V5
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:30 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:35890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhgD-0006Lf-Pw
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:29 -0400
Received: by mail-pl1-f170.google.com with SMTP id d21so5639863plr.3
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=BTaUXZm+zZcGuocJwfwd9IYolW9o//6NewFr+61BWes=;
	b=UPZsAp/S+XcUQAYWZQaHRMMR3dNN0XCqvDJa4owIwZL4Yxp51wNygBkwsLtwDwGeQi
	1rWXNXrsw/6+lbJmlDBp67YxONz9xU7WOV1T7tHCGxJvtBvO1uqg6AsQ0jI5AXtuE6P9
	Cmu67zZmWptzyysK/nNq416Ob3FNNHQ8+TKm9AFwJR+QTYXKhGp8c66/DbaW0Ztj49DG
	Ktnr88m8unrU+O/CZ+Kak4tu6i1CUg3dAqhvXPTP0xYHC+Is3TgIdL3uY6UU1mycOzmg
	nP8jWxLkrtS24xDPnbO8HgGafb6bTIoPE+/kAxX9ccDFCTyl7D+mCg74vLPl777D9EJ/
	0Gmw==
X-Gm-Message-State: APjAAAUoSOvUQlFguUecvYclhcmuKv7lBo9zjup2o9Di6FfH+LWQwTi5
	CMhuBG+Cp9Etl4jz3At3JLJwAw==
X-Google-Smtp-Source: APXvYqzNAIeNn1+g/9+01HJ4cuHxiP4CXSVE8S861SvPlpp8t+oyUaQPeY2NU5QIdeL6VyQOoAM3kQ==
X-Received: by 2002:a17:902:2e81:: with SMTP id
	r1mr101419159plb.0.1558833028528; 
	Sat, 25 May 2019 18:10:28 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	q12sm5694910pjp.17.2019.05.25.18.10.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:27 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:38 -0700
Message-Id: <20190526010948.3923-20-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.214.170
Subject: [Qemu-devel] [PULL 19/29] target/riscv: Mark privilege level 2 as
 reserved
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_bits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 7180fccf54f9..945aa8dbb851 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -383,7 +383,7 @@
 /* Privilege modes */
 #define PRV_U 0
 #define PRV_S 1
-#define PRV_H 2
+#define PRV_H 2 /* Reserved */
 #define PRV_M 3
 
 /* RV32 satp CSR field masks */
-- 
2.21.0


