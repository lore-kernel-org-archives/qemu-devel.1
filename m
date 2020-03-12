Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DC2C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D318E206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTUQYuIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D318E206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR0Q-0005dc-V3
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxL-0008D8-Un
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxK-00051L-Fu
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxK-000514-9E
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id 6so8367864wre.4
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/PWbtf8pRZrw4wwB/2VhUgWYgstVtgiipMKB/g1At8o=;
 b=wTUQYuIsqAntuMi3uFoT0i1uV16vdE67N+C7rFUP0l5Inb/a7EEdVX/uLQp3YOZU9M
 2BlDpMIR6Y+jW27o0bOzeXL9N2vMzHIA/L3iyKEJDtl6ywKsFXKEIaoOlKxnkSY6QENi
 K57dCfYxP4Exbz6Ize/BZhKVa8D6OodJ0VDExq0D30ehooxIvA6afBx7ffq/zVNpvsBt
 e9WBkiUi72ECFYXZDyragU1ObPMVGpgvohLnHUNFGxW4w8v0Jg+a4UMk1b8gqLoGFnU4
 hZYx/CecBnFFDX4QM6tcndCAnHb+jreBUaAMUkVdCAlJhea88RxgNfdMoKszkDSd5K/G
 PGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/PWbtf8pRZrw4wwB/2VhUgWYgstVtgiipMKB/g1At8o=;
 b=JNmasdyKK/xuZ/CjlIWUdmX0qKVx7HapUmNVUAw/c2wvDDMF5SFu4KHtdrJ43tnu2s
 2ZmAGFgPcTI7D6c06sQnzGCUgqdkDZdHPHpCfSdqjaJCk2dU0K+AAlMJSpFVDizn4/jw
 lJB+GhN5hnVdEW/BgHGbKpg2oOL3V966AjfGnLZQe9uSK0rNw4faCdKn9UsiZti1g7Oh
 +kMH2Elc80SRK3ziDDEr3pYN2foRM2lx5NaarHCIBz6gX3LLM3X8eBcgKIJj2dhNIpU0
 pddxwxFw7w0W4+++upEoRqnLyLH1RIRzXc7m17rToFW/Xwyu9911EiLzhBEar3dhRvSo
 fBIg==
X-Gm-Message-State: ANhLgQ3uZ4uw/f0YOhZI1mlCWVhaNylmoAcceimnRXl8gmQdQVoMIkn0
 eWWqUc0xMqrJVA2JOVV/XT1624Hh4g0f7g==
X-Google-Smtp-Source: ADFU+vtiCaUOGSg9m15kyJ+XTSoCxa5v8TsSGZTe7ivRcoGHE9U+DnjPSp2fRMj7cH5gNQf4vtvwfg==
X-Received: by 2002:adf:b19d:: with SMTP id q29mr11745218wra.211.1584031508962; 
 Thu, 12 Mar 2020 09:45:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/36] aspeed/smc: Fix User mode select/unselect scheme
Date: Thu, 12 Mar 2020 16:44:29 +0000
Message-Id: <20200312164459.25924-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

The Aspeed SMC Controller can operate in different modes : Read, Fast
Read, Write and User modes. When the User mode is configured, it
selects automatically the SPI slave device until the CE_STOP_ACTIVE
bit is set to 1. When any other modes are configured the device is
unselected. The HW logic handles the chip select automatically when
the flash is accessed through its AHB window.

When configuring the CEx Control Register, the User mode logic to
select and unselect the slave is incorrect and data corruption can be
seen on machines using two chips, witherspoon and romulus.

Rework the handler setting the CEx Control Register to fix this issue.

Fixes: 7c1c69bca43c ("ast2400: add SMC controllers (FMC and SPI)")
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 20200206112645.21275-3-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 39 +++++++++++++++++++++++----------------
 hw/ssi/trace-events |  1 +
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index e5621bf728c..32be2a02b0e 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -639,27 +639,23 @@ static inline int aspeed_smc_flash_is_4byte(const AspeedSMCFlash *fl)
     }
 }
 
-static inline bool aspeed_smc_is_ce_stop_active(const AspeedSMCFlash *fl)
+static void aspeed_smc_flash_do_select(AspeedSMCFlash *fl, bool unselect)
 {
-    const AspeedSMCState *s = fl->controller;
+    AspeedSMCState *s = fl->controller;
 
-    return s->regs[s->r_ctrl0 + fl->id] & CTRL_CE_STOP_ACTIVE;
+    trace_aspeed_smc_flash_select(fl->id, unselect ? "un" : "");
+
+    qemu_set_irq(s->cs_lines[fl->id], unselect);
 }
 
 static void aspeed_smc_flash_select(AspeedSMCFlash *fl)
 {
-    AspeedSMCState *s = fl->controller;
-
-    s->regs[s->r_ctrl0 + fl->id] &= ~CTRL_CE_STOP_ACTIVE;
-    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
+    aspeed_smc_flash_do_select(fl, false);
 }
 
 static void aspeed_smc_flash_unselect(AspeedSMCFlash *fl)
 {
-    AspeedSMCState *s = fl->controller;
-
-    s->regs[s->r_ctrl0 + fl->id] |= CTRL_CE_STOP_ACTIVE;
-    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
+    aspeed_smc_flash_do_select(fl, true);
 }
 
 static uint32_t aspeed_smc_check_segment_addr(const AspeedSMCFlash *fl,
@@ -911,13 +907,25 @@ static const MemoryRegionOps aspeed_smc_flash_ops = {
     },
 };
 
-static void aspeed_smc_flash_update_cs(AspeedSMCFlash *fl)
+static void aspeed_smc_flash_update_ctrl(AspeedSMCFlash *fl, uint32_t value)
 {
     AspeedSMCState *s = fl->controller;
+    bool unselect;
 
-    s->snoop_index = aspeed_smc_is_ce_stop_active(fl) ? SNOOP_OFF : SNOOP_START;
+    /* User mode selects the CS, other modes unselect */
+    unselect = (value & CTRL_CMD_MODE_MASK) != CTRL_USERMODE;
 
-    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
+    /* A change of CTRL_CE_STOP_ACTIVE from 0 to 1, unselects the CS */
+    if (!(s->regs[s->r_ctrl0 + fl->id] & CTRL_CE_STOP_ACTIVE) &&
+        value & CTRL_CE_STOP_ACTIVE) {
+        unselect = true;
+    }
+
+    s->regs[s->r_ctrl0 + fl->id] = value;
+
+    s->snoop_index = unselect ? SNOOP_OFF : SNOOP_START;
+
+    aspeed_smc_flash_do_select(fl, unselect);
 }
 
 static void aspeed_smc_reset(DeviceState *d)
@@ -1249,8 +1257,7 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
         s->regs[addr] = value;
     } else if (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->num_cs) {
         int cs = addr - s->r_ctrl0;
-        s->regs[addr] = value;
-        aspeed_smc_flash_update_cs(&s->flashes[cs]);
+        aspeed_smc_flash_update_ctrl(&s->flashes[cs], value);
     } else if (addr >= R_SEG_ADDR0 &&
                addr < R_SEG_ADDR0 + s->ctrl->max_slaves) {
         int cs = addr - R_SEG_ADDR0;
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index ffe531a500a..0a70629801a 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -7,3 +7,4 @@ aspeed_smc_flash_write(int cs, uint64_t addr,  uint32_t size, uint64_t data, int
 aspeed_smc_read(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
 aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x: 0x%08x"
 aspeed_smc_write(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
+aspeed_smc_flash_select(int cs, const char *prefix) "CS%d %sselect"
-- 
2.20.1


