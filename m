Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F15C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D547F206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZzLQwPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D547F206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQyU-0001hj-0n
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxK-0008AW-Mu
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxJ-00050v-7o
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:10 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:34654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxJ-00050h-0o
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:09 -0400
Received: by mail-wr1-x42e.google.com with SMTP id z15so8380777wrl.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4S8wIrHJy8qFtt3EBjVlgr+BtDAqyjEFLwh2HjaLWUk=;
 b=yZzLQwPSkh5fUXqef84ZglQW0gYEmofXpniD+fsrAcbbjTENf5iD9cKfZZsbi7/TZB
 8QHalJrbYJLILmw1Mk/LGa0ER5vehaUtuzFnnH16bc20fKyVn7Ya+dmBSKhYySOyMYFG
 nt+5b8cIFxmwLa9+cwDWE0ldRiS/1WGsfarnBvIDZwTVEq1/m0Qfvmq/dYoY1oQ4/XGA
 u6IZ/DHqJ+z5ZWphQitxzFlOAzXGZRKPyIjz3cD+ReX2rLleFgNECZuEMpYupFFTR4wG
 hoXGEvhJcQum/4+OP31F4TaY3KqPCAkkfVEITscTFvxTwvyodbZ+GM3j0qkNrFy+ihlp
 PfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4S8wIrHJy8qFtt3EBjVlgr+BtDAqyjEFLwh2HjaLWUk=;
 b=cLB/0VRXXIk7rhM2bLUZ1CeSkoiIvjO70uCvzaN1IEXWawepsrdGsdWzNtp0CPBOII
 BVB6N/FBrYKNxn4hh7rFGAcCmeRanRpzHWr4Hojktb+oSNiPAg0t2GmJHjMcWXEpOz0J
 lXBN3vV0uoSRlwU1VL1eGa/O4tlmW3ebNQkcrm3in7HoAZR6Z3a4r5aIWDhL7iXmAdD9
 gntZCGWbwNgKrvLgpO8FlJi1RpTyXGvgyHVF7Dzg5I9nTYBSRtHMHDi27P4LoGRdIglk
 PY9S24aQf33rSDyqkb2kh2unqMH+jIYzy9reoXTxJ06hhIW/34waQZEfumfaUU0MWqm1
 VBZg==
X-Gm-Message-State: ANhLgQ0PJJIv5iDx9dNImnza+n0LRQgdeFN2Vp9s80Si9GvG8HSHdYxe
 YlTykyZd94wpNfQLrm+BjJ0Fs/rSEw7CzQ==
X-Google-Smtp-Source: ADFU+vv+s6BEVEREgmwT6zlKZl3Pa8RkSXkc9spD+YN1kN8yoT4+W2YAEoKPuDKoj6rfN4gWtJidqQ==
X-Received: by 2002:adf:f0c6:: with SMTP id x6mr11602750wro.273.1584031507673; 
 Thu, 12 Mar 2020 09:45:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/36] aspeed/smc: Add some tracing
Date: Thu, 12 Mar 2020 16:44:28 +0000
Message-Id: <20200312164459.25924-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

From: Cédric Le Goater <clg@kaod.org>

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200206112645.21275-2-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile.objs       |  1 +
 hw/ssi/aspeed_smc.c | 17 +++++++++++++++++
 hw/ssi/trace-events |  9 +++++++++
 3 files changed, 27 insertions(+)
 create mode 100644 hw/ssi/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 40d3a1696cb..a7c967633ac 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -175,6 +175,7 @@ trace-events-subdirs += hw/scsi
 trace-events-subdirs += hw/sd
 trace-events-subdirs += hw/sparc
 trace-events-subdirs += hw/sparc64
+trace-events-subdirs += hw/ssi
 trace-events-subdirs += hw/timer
 trace-events-subdirs += hw/tpm
 trace-events-subdirs += hw/usb
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 23c8d2f0624..e5621bf728c 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -31,6 +31,7 @@
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
 #include "qemu/units.h"
+#include "trace.h"
 
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
@@ -513,6 +514,8 @@ static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
 
     s->ctrl->reg_to_segment(s, new, &seg);
 
+    trace_aspeed_smc_flash_set_segment(cs, new, seg.addr, seg.addr + seg.size);
+
     /* The start address of CS0 is read-only */
     if (cs == 0 && seg.addr != s->ctrl->flash_window_base) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -753,6 +756,8 @@ static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
                       __func__, aspeed_smc_flash_mode(fl));
     }
 
+    trace_aspeed_smc_flash_read(fl->id, addr, size, ret,
+                                aspeed_smc_flash_mode(fl));
     return ret;
 }
 
@@ -808,6 +813,9 @@ static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
     AspeedSMCState *s = fl->controller;
     uint8_t addr_width = aspeed_smc_flash_is_4byte(fl) ? 4 : 3;
 
+    trace_aspeed_smc_do_snoop(fl->id, s->snoop_index, s->snoop_dummies,
+                              (uint8_t) data & 0xff);
+
     if (s->snoop_index == SNOOP_OFF) {
         return false; /* Do nothing */
 
@@ -858,6 +866,9 @@ static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
     AspeedSMCState *s = fl->controller;
     int i;
 
+    trace_aspeed_smc_flash_write(fl->id, addr, size, data,
+                                 aspeed_smc_flash_mode(fl));
+
     if (!aspeed_smc_is_writable(fl)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: flash is not writable at 0x%"
                       HWADDR_PRIx "\n", __func__, addr);
@@ -972,6 +983,9 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
         (s->ctrl->has_dma && addr == R_DMA_CHECKSUM) ||
         (addr >= R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_slaves) ||
         (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_slaves)) {
+
+        trace_aspeed_smc_read(addr, size, s->regs[addr]);
+
         return s->regs[addr];
     } else {
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
@@ -1091,6 +1105,7 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
                           __func__, s->regs[R_DMA_FLASH_ADDR]);
             return;
         }
+        trace_aspeed_smc_dma_checksum(s->regs[R_DMA_FLASH_ADDR], data);
 
         /*
          * When the DMA is on-going, the DMA registers are updated
@@ -1225,6 +1240,8 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
 
     addr >>= 2;
 
+    trace_aspeed_smc_write(addr, size, data);
+
     if (addr == s->r_conf ||
         (addr >= s->r_timings &&
          addr < s->r_timings + s->ctrl->nregs_timings) ||
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
new file mode 100644
index 00000000000..ffe531a500a
--- /dev/null
+++ b/hw/ssi/trace-events
@@ -0,0 +1,9 @@
+# aspeed_smc.c
+
+aspeed_smc_flash_set_segment(int cs, uint64_t reg, uint64_t start, uint64_t end) "CS%d segreg=0x%"PRIx64" [ 0x%"PRIx64" - 0x%"PRIx64" ]"
+aspeed_smc_flash_read(int cs, uint64_t addr,  uint32_t size, uint64_t data, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
+aspeed_smc_do_snoop(int cs, int index, int dummies, int data) "CS%d index:0x%x dummies:%d data:0x%x"
+aspeed_smc_flash_write(int cs, uint64_t addr,  uint32_t size, uint64_t data, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
+aspeed_smc_read(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
+aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x: 0x%08x"
+aspeed_smc_write(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
-- 
2.20.1


