Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6959ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D6920863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D6920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yBM-0008TK-2H
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xw1-0007qx-0X
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xvz-0006a5-UK
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xvz-0006Zp-Ov
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id p13so2381377wmh.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=G7Nvco3Ed4SzCOF6c1+pxFi6zNWbYlWlCIq1YYzo3nE=;
 b=un0w8ItPBNKr1h3aZQ27I7BJN4HnRrZBbfG7vsW6jb6zmtat/o9KW7uxO4aD/RLXFH
 glCnkoQqCRzEsHs9HlbuymKitdIudBArSyl2VnJiAio/WUrQVUaetVR26ePtOkpbTWQX
 BdMKyAkP5HfkElNxY2UsC+C8C5v16LFoTaAl8JaEdGfP3cUzFy+KuVzFh+E/aG/8LFHU
 EHtCNVyLH9CrIzco/RydU2yOuW6cfX98qe1M3mQ1z20O/ZmUWMrWUWS7yAesSsDm1FvA
 1ETl0xRw0249XtivurpT1JZoVQHeUcqdDCNA5FDh25Bs2z3TUgexYxfu3MeR39CwnY0A
 jzrQ==
X-Gm-Message-State: APjAAAUlXMRjAiPRvIYko3rLF+LBNjq6rEhNKnNrEzUAAdlQDqOXFwxs
 oXHIiu1E8ecDURN9uE2AcsmjYw==
X-Google-Smtp-Source: APXvYqzxKbgwqMTxlGKJx5isQSoFqeEhAIV1/KRpQk9IvBNwmsmFa3kHYM8H2K1HZT6SGTB2sth3jg==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr3095160wmj.25.1568190302679; 
 Wed, 11 Sep 2019 01:25:02 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id l62sm3821040wml.13.2019.09.11.01.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:25:02 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:04:46 -0700
Message-Id: <20190910190513.21160-21-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: [Qemu-devel] [PULL 20/47] riscv: hw: Remove the unnecessary include
 of target/riscv/cpu.h
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

The inclusion of "target/riscv/cpu.h" is unnecessary in various
sifive model drivers.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_prci.c | 1 -
 hw/riscv/sifive_test.c | 1 -
 hw/riscv/sifive_uart.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
index 982fbb26fd..c413f0cb76 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_prci.c
@@ -22,7 +22,6 @@
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "target/riscv/cpu.h"
 #include "hw/hw.h"
 #include "hw/riscv/sifive_prci.h"
 
diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index aa544e7428..339195c6ff 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -23,7 +23,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "sysemu/runstate.h"
-#include "target/riscv/cpu.h"
 #include "hw/hw.h"
 #include "hw/riscv/sifive_test.h"
 
diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index 215990b443..a403ae90f5 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -22,7 +22,6 @@
 #include "hw/sysbus.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
-#include "target/riscv/cpu.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/riscv/sifive_uart.h"
-- 
2.21.0


