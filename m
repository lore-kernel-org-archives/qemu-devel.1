Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E237ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723EE20863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723EE20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7y8t-00055f-U8
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xvr-0007bp-T8
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xvq-0006UR-Pn
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xvq-0006U4-Jt
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so2327074wmp.4
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=3hJQGoN/dkKnxfz2wZzkBe8IK9Gek4+jV7PzGIOzZB8=;
 b=B9kSOAPoPI/6z6HnRPOZdNJ7MCo8fBD4xbCjMCg+mn4MoAE6h6vflj4i2RXQn5y+OV
 /5As0I72YJ9z+c6Gkbzr9bhNjCiNt/rAUNmVlX1cKSg1cVqvVxHIyQ7tGzByX2/rCbzG
 9XkhUrpsTnF2T9zUfec5OM5ynF2G+pktey+1urxdw2aBySfiKH0aoKoYNMXz7uQCk+4C
 Bq2NH5Mz3s9558qbMoSriqo2qjU3MHPlBG+Euu64qmSPbhuu+86P9VUXC1kSaomr+8LW
 DdRhyXFF27V9GWrPnpQ0lHFx/fA8JuGzmIo8H4IwzSkgOa977kVcveLQIalRlTQWh+TP
 QbAg==
X-Gm-Message-State: APjAAAU2LtsLySz/bz1r5gzy5QQjlozQPOHaKfaL7fWlNvqE/W1eW91V
 tsOOFklPiJEslUk28onK4ORZYQ==
X-Google-Smtp-Source: APXvYqy4OOqHjWu2bFFeY9E1qUXYpCK7loKq9UIfr+RugRSB4B5heRLAh7wJY48pHiTOkjy7vcJXcQ==
X-Received: by 2002:a7b:cf11:: with SMTP id l17mr2799594wmg.162.1568190293264; 
 Wed, 11 Sep 2019 01:24:53 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id s12sm29134876wra.82.2019.09.11.01.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:24:52 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:04:39 -0700
Message-Id: <20190910190513.21160-14-palmer@sifive.com>
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
Subject: [Qemu-devel] [PULL 13/47] riscv: sifive_test: Add reset
 functionality
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
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

This adds a reset opcode for sifive_test device to trigger a system
reset for testing purpose.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_test.c         | 4 ++++
 include/hw/riscv/sifive_test.h | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index afbb3aaf34..3557e16701 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -22,6 +22,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
+#include "sysemu/runstate.h"
 #include "target/riscv/cpu.h"
 #include "hw/hw.h"
 #include "hw/riscv/sifive_test.h"
@@ -42,6 +43,9 @@ static void sifive_test_write(void *opaque, hwaddr addr,
             exit(code);
         case FINISHER_PASS:
             exit(0);
+        case FINISHER_RESET:
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            return;
         default:
             break;
         }
diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_test.h
index 3a603a6ead..1ec416ac1b 100644
--- a/include/hw/riscv/sifive_test.h
+++ b/include/hw/riscv/sifive_test.h
@@ -36,7 +36,8 @@ typedef struct SiFiveTestState {
 
 enum {
     FINISHER_FAIL = 0x3333,
-    FINISHER_PASS = 0x5555
+    FINISHER_PASS = 0x5555,
+    FINISHER_RESET = 0x7777
 };
 
 DeviceState *sifive_test_create(hwaddr addr);
-- 
2.21.0


