Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAD1C433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 05:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADE02065F
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 05:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GKMTMLG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADE02065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzD0O-0005HW-10
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 01:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=46842bc30=alistair.francis@wdc.com>)
 id 1jzCz1-0003qs-Ut; Sat, 25 Jul 2020 01:44:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=46842bc30=alistair.francis@wdc.com>)
 id 1jzCz0-00054k-B9; Sat, 25 Jul 2020 01:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595655871; x=1627191871;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=symM9OcV3Ro4YwQkOr8XQ+ZcMCfyE7hQKHdGXa20AGE=;
 b=GKMTMLG9dvyoy4q2fogAvkAxUxDADNw7+Kl/WIboDT6bE01IadIlHRjw
 xd38HF2v9Hh2KnNwanRfcl3u9u9GZ+UuGgTAnlsXcW/U7jglwXkuiRcd1
 qbDhblf/mL8dsxF8omS6k2MBwIZA7xFcZbSyeMFvWW/GpKKl/xmTNyX2/
 eqv5jbjSEv4ZtUbYaqnGnKifi0pU/woZYbvL9+1t3g89LLyJSvP/RTRZT
 +4ZJb+GQwHbRopkyO+O8Nf/yMtL7krnPldrva+lzmERGHRnG11bZON8Lv
 ebeHRjvfyF2q/Ln5ZkGZNXaJ6xg3lm/w0z6AcdVGDl7HZvnOM2wxx4Bf7 g==;
IronPort-SDR: 1jCgPdO5yA3uSOcDdFmoJDN7Ji/ZX+dgf12xRhwM/TQZIVUZjuQrc84ftaWuZX+SWleXHCrsah
 bBjc9+vfhW6zUawmJ+Mk3JtDY1j7YgLpi9aMcqQSNdgxsT2DQQEUHpSUSeVEI7tMExsFqYRXoX
 ZHvW4EkYZkZkKPU19mOdIzT+oeR/9cPYZAHw3Da5J/X4hTdrXwsgXZU/lUw6kaTdZ0wwEE5Ay5
 4UMbTkyRLFLeICFOjFH/vkASulAiuI5TRHFUj6OUblV2/T8mt3xm9LZYm4bJ/+n+eDt9Ty5qAi
 1hc=
X-IronPort-AV: E=Sophos;i="5.75,392,1589212800"; d="scan'208";a="144611250"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jul 2020 13:44:29 +0800
IronPort-SDR: WngzsZ6TUJ8WOI1epQ5TKeBDMZ6CfnjfIc7hBGhWM21ZzCUjQdspJUS6dxT2guStA5suiqGxQU
 2L2sOdKxXkyX3EJViqoA4VUFgmE/EHqx8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2020 22:32:42 -0700
IronPort-SDR: 7PJ7UA+/9lDBhvq8olHRBHUUI5zwAIBjZlBITqehmqsXirPhuFfbZbw4+HUlybH0HtE/+2ViJl
 wzsR3PTZxJqQ==
WDCIronportException: Internal
Received: from cnf007830.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.124])
 by uls-op-cesaip02.wdc.com with ESMTP; 24 Jul 2020 22:44:28 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 2/3] hw/intc: ibex_plic: Don't allow repeat interrupts on
 claimed lines
Date: Fri, 24 Jul 2020 22:34:43 -0700
Message-Id: <394c3f070615ff2b4fab61a1cf9cb48c122913b7.1595655188.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595655188.git.alistair.francis@wdc.com>
References: <cover.1595655188.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=46842bc30=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/25 01:44:23
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Once an interrupt has been claimed, but before it has been compelted we
shouldn't receive any more pending interrupts. This patche keeps track
of this to ensure that we don't see any more interrupts until it is
completed.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/intc/ibex_plic.h |  1 +
 hw/intc/ibex_plic.c         | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/intc/ibex_plic.h b/include/hw/intc/ibex_plic.h
index ddc7909903..d8eb09b258 100644
--- a/include/hw/intc/ibex_plic.h
+++ b/include/hw/intc/ibex_plic.h
@@ -33,6 +33,7 @@ typedef struct IbexPlicState {
     MemoryRegion mmio;
 
     uint32_t *pending;
+    uint32_t *claimed;
     uint32_t *source;
     uint32_t *priority;
     uint32_t *enable;
diff --git a/hw/intc/ibex_plic.c b/hw/intc/ibex_plic.c
index 578edd2ce0..669247ef08 100644
--- a/hw/intc/ibex_plic.c
+++ b/hw/intc/ibex_plic.c
@@ -43,6 +43,14 @@ static void ibex_plic_irqs_set_pending(IbexPlicState *s, int irq, bool level)
 {
     int pending_num = irq / 32;
 
+    if (s->claimed[pending_num] & 1 << (irq % 32)) {
+        /*
+         * The interrupt has been claimed, but not compelted.
+         * The pending bit can't be set.
+         */
+        return;
+    }
+
     s->pending[pending_num] |= level << (irq % 32);
 }
 
@@ -120,6 +128,10 @@ static uint64_t ibex_plic_read(void *opaque, hwaddr addr,
         int pending_num = s->claim / 32;
         s->pending[pending_num] &= ~(1 << (s->claim % 32));
 
+        /* Set the interrupt as claimed, but not compelted */
+        s->claimed[pending_num] |= 1 << (s->claim % 32);
+
+        /* Return the current claimed interrupt */
         ret = s->claim;
 
         /* Update the interrupt status after the claim */
@@ -155,6 +167,10 @@ static void ibex_plic_write(void *opaque, hwaddr addr,
             /* Interrupt was completed */
             s->claim = 0;
         }
+        if (s->claimed[value / 32] & 1 << (value % 32)) {
+            /* This value was already claimed, clear it. */
+            s->claimed[value / 32] &= ~(1 << (value % 32));
+        }
     }
 
     ibex_plic_update(s);
@@ -215,6 +231,7 @@ static void ibex_plic_realize(DeviceState *dev, Error **errp)
     int i;
 
     s->pending = g_new0(uint32_t, s->pending_num);
+    s->claimed = g_new0(uint32_t, s->pending_num);
     s->source = g_new0(uint32_t, s->source_num);
     s->priority = g_new0(uint32_t, s->priority_num);
     s->enable = g_new0(uint32_t, s->enable_num);
-- 
2.27.0


