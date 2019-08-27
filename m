Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E5FC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78E42070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH4dydZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78E42070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2d9G-0000GA-Ju
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cvu-0003Cl-CD
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cvs-0003OQ-1z
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:58:54 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i2cvr-0003Mf-RH; Tue, 27 Aug 2019 10:58:51 -0400
Received: by mail-pg1-x541.google.com with SMTP id e11so12843144pga.5;
 Tue, 27 Aug 2019 07:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=sVgQU9XDhEv7Fcmdko40+vQFZ7rK+wy/NH0Vxuc5IEM=;
 b=DH4dydZdp9Hp/p5AMsTk+aBVUODtsfX3enwvY1eQ+2I3zhjaHrZcxQpPVqL5PnZ+21
 D1GT7opClbPR1n7AFXlYORH5eBmAj8LraqeX8EBzehDac49XPcxNgIW7kS6LSSnxxzav
 sDl1UY8Xip5MDZbK5pQOvIXhdvDreSaO3+Pe7IuZjQdFNObb5BZg3GQUWE90oH73U+YD
 /niNzLlIsgoKRxlQnnElxLVroNZpX1gMadWB1co1j9HeXo12fVivd/HfDW2Fbp0OFhWX
 11lAJbwD0GPvH01ACL3kAy1+j7XlaoSegdSHpWt+wZHEpN/eyxDqA158saihJvSqEMsq
 RWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=sVgQU9XDhEv7Fcmdko40+vQFZ7rK+wy/NH0Vxuc5IEM=;
 b=DMp2Fj/0W33s382dalauik4lb3sYDsqMEweV63MGidr4DV/KXhz2akcIV9v9LE/jNN
 mjOgTAZ+U4CgtWjqtRa3ukhlP6z7xAFi2fda5MkOVkH5ztCWYihytU0W1DkjRkLfh67H
 FriwUizuMUGmo7a+TLnhFICFHvCcZueSY5B9lPvLBGAd4Thdo8KvKGaDPCWlg+3gp0aV
 xpwjyUTyzr+Cl9v/iEJDrzSCFGikXzJ75BIIu+a6P4WsEWn+tpiG1tJQGn8Tu3LNJ9BS
 HEA/12F9eE9yw4WtLMPXlrIg310zaDHy2BdloF/cNcv4d5ey16a1VEa50uNTry3NTCwF
 Zuxw==
X-Gm-Message-State: APjAAAW5QdIcAeU17dGQbGmaJkGVSgRg0B8sV1h8IS7Td73thiQ1N7Sd
 lySgGjvNsFsuzInYOkIWrVjgnDR9
X-Google-Smtp-Source: APXvYqxnXIYCrh7Ar5cM6FhTxLD1kwde6jsg/meCpMSV71+hAT9J6qBcQF/QfuhrOz1MUKRusb2WJA==
X-Received: by 2002:a17:90a:3266:: with SMTP id
 k93mr26209056pjb.46.1566917930627; 
 Tue, 27 Aug 2019 07:58:50 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id j15sm14839344pfr.146.2019.08.27.07.58.49
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Tue, 27 Aug 2019 07:58:49 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Tue, 27 Aug 2019 07:58:14 -0700
Message-Id: <1566917919-25381-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
References: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v6 05/30] riscv: hw: Change to use
 qemu_log_mask(LOG_GUEST_ERROR, ...) instead
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the call to hw_error() with qemu_log_mask(LOG_GUEST_ERROR,...)
in various sifive models.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v6: None
Changes in v5:
- new patch to change to use qemu_log_mask(LOG_GUEST_ERROR,...) instead
  in various sifive models

Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_prci.c | 8 +++++---
 hw/riscv/sifive_test.c | 5 +++--
 hw/riscv/sifive_uart.c | 9 +++++----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
index f406682..1ab98d4 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_prci.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/sifive_prci.h"
@@ -37,7 +38,8 @@ static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int size)
     case SIFIVE_PRCI_PLLOUTDIV:
         return s->plloutdiv;
     }
-    hw_error("%s: read: addr=0x%x\n", __func__, (int)addr);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: read: addr=0x%x\n",
+                  __func__, (int)addr);
     return 0;
 }
 
@@ -65,8 +67,8 @@ static void sifive_prci_write(void *opaque, hwaddr addr,
         s->plloutdiv = (uint32_t) val64;
         break;
     default:
-        hw_error("%s: bad write: addr=0x%x v=0x%x\n",
-                 __func__, (int)addr, (int)val64);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%x v=0x%x\n",
+                      __func__, (int)addr, (int)val64);
     }
 }
 
diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index cd86831..655a3d7 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "target/riscv/cpu.h"
@@ -48,8 +49,8 @@ static void sifive_test_write(void *opaque, hwaddr addr,
             break;
         }
     }
-    hw_error("%s: write: addr=0x%x val=0x%016" PRIx64 "\n",
-        __func__, (int)addr, val64);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: write: addr=0x%x val=0x%016" PRIx64 "\n",
+                  __func__, (int)addr, val64);
 }
 
 static const MemoryRegionOps sifive_test_ops = {
diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index 3b3f94f..cd74043 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 #include "hw/sysbus.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
@@ -93,8 +94,8 @@ uart_read(void *opaque, hwaddr addr, unsigned int size)
         return s->div;
     }
 
-    hw_error("%s: bad read: addr=0x%x\n",
-        __func__, (int)addr);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read: addr=0x%x\n",
+                  __func__, (int)addr);
     return 0;
 }
 
@@ -125,8 +126,8 @@ uart_write(void *opaque, hwaddr addr,
         s->div = val64;
         return;
     }
-    hw_error("%s: bad write: addr=0x%x v=0x%x\n",
-        __func__, (int)addr, (int)value);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%x v=0x%x\n",
+                  __func__, (int)addr, (int)value);
 }
 
 static const MemoryRegionOps uart_ops = {
-- 
2.7.4


