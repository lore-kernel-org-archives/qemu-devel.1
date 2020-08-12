Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08A6C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B19020771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QqrZhlck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B19020771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zVc-0002S0-RS
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQi-0002k9-Ak
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:41:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQc-0005qL-6T
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272062; x=1628808062;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6iYgSEaXu9Bo9J/ZFmcL7Vhvi/0ItyGMY2M76sAZop0=;
 b=QqrZhlckp6QtOwK2Km8KVXFYWU8F+Go+1XOBiucCPc80CkSbijtDrHJq
 sb39OAXCDsjVoSoV9HCwVetjNQjVn6FK627sssnOIRU7m9iVWbi2vHTzy
 CN+J7gvp2cjJqMV9QPxcvb87xDj/nG2g9Wq3OxIwaX1xdaI6HIgU3Opk9
 K+WsMhXDPJfyEP7XUBbkHJWUWN/uZelL3mhyb9jfqWGpamOwHr61NkKYD
 /tKqHopaLLVC6Bpb24FmWkEhAoQf4mwDhG+PD5vQtMmboIsQRq36pCmqZ
 NwIYWgZDV/s+3SDbJ1E0ghlxf2A9sj0LwbG/oo+W4D7y7i6f/WUbnqGiH Q==;
IronPort-SDR: YILx5Sh1yJVdLbCp94Snihma0ZIFD/Ub0w6rP0bZ3z/eXGmqDf6jVzRAD3SDPy1uqwEExIvBvo
 /u9ebsgts+umV8A6K9BeOdcdkKRWdb+C9pmBX4eOewq7C6+zUmB8rV+vAbMmQzBtnnnPycRXR2
 Si1jQMrxaaMu3WqG32Pea9hSpKftGePJLimThaCzglWaQGkSqHs9N9EnX4M4UDU5ivLGXRfQ2g
 rCn6nZ3qDQ9C8+mR6NJjDP46e34CLHyz+fylafBL1FOxgZCfcKf8PLtdpLk5aEHk250KWjS9tc
 5pM=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="144799070"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:53 +0800
IronPort-SDR: RBJAnQxiB7LErrs07pwxM9ejEpsvR9iO1W+aOHZ4AcIHF0KvTZpRaD5xM5ywWizxw2/jbN2jvP
 MnDYISblGuhw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:28:44 -0700
IronPort-SDR: JMkO84N/din34kr6xxx7MmOW+bCtejYQSXuHF8vy6oLBIfNQz9arkF/9zgtGEMMVJcKiUTIOT0
 gw4OekcDYxxQ==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:50 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/20] hw/intc: ibex_plic: Don't allow repeat interrupts on
 claimed lines
Date: Wed, 12 Aug 2020 15:30:44 -0700
Message-Id: <20200812223045.96803-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812223045.96803-1-alistair.francis@wdc.com>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:40:52
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
Cc: Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Once an interrupt has been claimed, but before it has been compelted we
shouldn't receive any more pending interrupts. This patche keeps track
of this to ensure that we don't see any more interrupts until it is
completed.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <394c3f070615ff2b4fab61a1cf9cb48c122913b7.1595655188.git.alistair.francis@wdc.com>
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


