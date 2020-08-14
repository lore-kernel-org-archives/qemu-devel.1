Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202DCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2540207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="puhPthOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2540207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bYp-0001vd-4v
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQW-0003ps-Qu
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:28 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQV-0007mz-0j
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597418126; x=1628954126;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ecw+uUu8ObD0NK1lt/f/vE+UcPdy47ApeZdTtie3FrA=;
 b=puhPthOfHE4Ex/QL0RxfssZlYzoCxflkFakDEjQ06AqIVc4CgFzPSZih
 LfdOy8nS4FTGdqUUo/ORv0ANyzAtL2TQryrcdd5vtqXjXhxE6F9GlzusH
 3TSzAkF3XbRtCB9A4Q/PIl0zLOGmSZ4CgyX0jLm5JKWMkEl/QGB6GeFON
 ofxswONtNTPYxYy1tzCqlyCjfzNUiOcirFteb7iH97iIgYahGygeFjhAP
 mWWScJhbV2jkJlsSZ4ifBx4UakzzGXGsNLkIHgz04DILq2rBhJqnFVnG3
 jzyZerNeJmnfhLYBtMViPdAztpycPMIWCaXzl5PtfnDXkMNAGisWUxuFR g==;
IronPort-SDR: hn86VZwWg/MDDCWv3LxfsHM10Fhn0jc/E9jE+DzSonCgcn6isbxymME6jBZrkkWCwSsTPktfhB
 1r7u11ZS9bm8YW6r1Iz/70uhAk9pvjVuAwxXnYj2fojfASLMsfq8IL87CDpsBZzgSj1dULS7vL
 xxbwYsUeE9X+Afxg6jJJp4IMcHM2Aw1X2iYkUzLK/KNO+Hh046VoARwe+WrJLHVEm/86Rc9MqJ
 RqgdZT7wtEMQMUMCdbDwGVW+G/2e1CfnDfM8TTdlK4ymwf8OF2s/CBMsWZIXKxI0cb9Si4ICBa
 PX0=
X-IronPort-AV: E=Sophos;i="5.76,312,1592841600"; d="scan'208";a="254369421"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2020 23:15:16 +0800
IronPort-SDR: 0XJIA9NwW8hVWThXABktL6Yx/tJvaEr18tXEEZDhVDYh4oG5RNN8qddoU4PohMnMfEcF/FZUxN
 6WQmW1bTgYew==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 08:02:22 -0700
IronPort-SDR: GSEr9/Xf1gSPWaenqC6Qg4l85q/oEzh8zU593PezpQdDXrQLZkVKdUQXpYgphiOA8Dq1yr8+ye
 7a1JFSrgdChw==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Aug 2020 08:15:17 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 20/20] hw/intc: ibex_plic: Honour source priorities
Date: Fri, 14 Aug 2020 08:05:06 -0700
Message-Id: <20200814150506.2070566-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814150506.2070566-1-alistair.francis@wdc.com>
References: <20200814150506.2070566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=4887bfbec=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 11:15:16
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Jessica Clarke <jrtc27@jrtc27.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch follows what commit aa4d30f6618dc "riscv: plic: Honour source
priorities" does and ensures that the highest priority interrupt will be
serviced first.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <a697ca8a31eff8eb18a88e09a28206063cf85d48.1595655188.git.alistair.francis@wdc.com>
---
 hw/intc/ibex_plic.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/intc/ibex_plic.c b/hw/intc/ibex_plic.c
index 669247ef08..f49fa67c91 100644
--- a/hw/intc/ibex_plic.c
+++ b/hw/intc/ibex_plic.c
@@ -57,6 +57,8 @@ static void ibex_plic_irqs_set_pending(IbexPlicState *s, int irq, bool level)
 static bool ibex_plic_irqs_pending(IbexPlicState *s, uint32_t context)
 {
     int i;
+    uint32_t max_irq = 0;
+    uint32_t max_prio = s->threshold;
 
     for (i = 0; i < s->pending_num; i++) {
         uint32_t irq_num = ctz64(s->pending[i]) + (i * 32);
@@ -66,14 +68,17 @@ static bool ibex_plic_irqs_pending(IbexPlicState *s, uint32_t context)
             continue;
         }
 
-        if (s->priority[irq_num] > s->threshold) {
-            if (!s->claim) {
-                s->claim = irq_num;
-            }
-            return true;
+        if (s->priority[irq_num] > max_prio) {
+            max_irq = irq_num;
+            max_prio = s->priority[irq_num];
         }
     }
 
+    if (max_irq) {
+        s->claim = max_irq;
+        return true;
+    }
+
     return false;
 }
 
-- 
2.27.0


