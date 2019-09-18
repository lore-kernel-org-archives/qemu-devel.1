Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED97BC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E03207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E03207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcMv-0004PA-B1
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsN-00070g-ON
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsM-0006lb-I1
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:15 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:37684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsM-0006l1-Ch
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:14 -0400
Received: by mail-pl1-f170.google.com with SMTP id b10so122732plr.4
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=G7Nvco3Ed4SzCOF6c1+pxFi6zNWbYlWlCIq1YYzo3nE=;
 b=Q0UsdgOINic3Y5K26C17hSl3UHiRDon0WW0zsmrKcLznNa2KSR+eg72VV46gTcL7G6
 1wclXLgqgZGM4MZQr4c9wsl1HRQvDL3OmFt9x84J3rtjGlvMeAQs+0hGSyBe1gUbVZNH
 Hs9TFSg2gcPHPkE6F+SNyTqyqpMBwGpEvq4AFUSAzl/7Blm6P1hKuPeSmF0etwXgJaXA
 DufLJYG34p2znOW/MKxkWxI0klNUYgoVfMoHouce+q2sNr+NAVBGwRNsnQkdUG+/4vZ8
 2pEOAWcCV0VFQb48tLKq0JPTBHX3BwFAjCW/VezL0Wg+ZSvKOTAXJF0bO8OVI346cdv8
 mACw==
X-Gm-Message-State: APjAAAXkeU3uLlNRdBg75QDTJxz4T7sB8ozoIc8uhfVKqnXVKSaIm//K
 BF4dxSm3kJllTp2m9doJP0RFlNjQknQ=
X-Google-Smtp-Source: APXvYqwIOma6cOn7KB0pxWbpMJAZmnQU6FbRlF/vme2tkNn77uuak9fR0IKIgozI8ljAe2uwn3or8w==
X-Received: by 2002:a17:902:7797:: with SMTP id
 o23mr4671797pll.247.1568820493245; 
 Wed, 18 Sep 2019 08:28:13 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id j23sm7217453pfn.75.2019.09.18.08.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:12 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:12 -0700
Message-Id: <20190918145640.17349-21-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.170
Subject: [Qemu-devel] [PULL 20/48] riscv: hw: Remove the unnecessary include
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


