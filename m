Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65357C5B57F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 17:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4141E2089C
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 17:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4141E2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhdmk-0004QU-Ba
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 13:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58347)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hhdjY-0000R7-Cx
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 13:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hhdjX-0000YT-9b
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 13:35:24 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:40198
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hhdjX-000826-3v
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 13:35:23 -0400
Received: from host109-146-132-17.range109-146.btcentralplus.com
 ([109.146.132.17] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hhdfr-0001xd-5d
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 18:31:35 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Sun, 30 Jun 2019 18:31:59 +0100
Message-Id: <20190630173203.9620-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190630173203.9620-1-mark.cave-ayland@ilande.co.uk>
References: <20190630173203.9620-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 109.146.132.17
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH 1/5] sunhme: add trace event for logging PCI IRQ
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/net/sunhme.c     | 2 ++
 hw/net/trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 1ebaee3c82..6d660a8238 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -209,6 +209,8 @@ static void sunhme_update_irq(SunHMEState *s)
     }
 
     level = (seb ? 1 : 0);
+    trace_sunhme_update_irq(mifmask, mif, sebmask, seb, level);
+
     pci_set_irq(d, level);
 }
 
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 3cd9e122df..d16273c579 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -359,6 +359,7 @@ sunhme_rx_filter_reject(void) "rejecting incoming frame"
 sunhme_rx_filter_accept(void) "accepting incoming frame"
 sunhme_rx_desc(uint32_t addr, int offset, uint32_t status, int len, int cr, int nr) "addr 0x%"PRIx32"(+0x%x) status 0x%"PRIx32 " len %d (ring %d/%d)"
 sunhme_rx_xsum_calc(uint16_t xsum) "calculated incoming xsum as 0x%x"
+sunhme_update_irq(uint32_t mifmask, uint32_t mif, uint32_t sebmask, uint32_t seb, int level) "mifmask: 0x%x  mif: 0x%x  sebmask: 0x%x  seb: 0x%x  level: %d"
 
 # virtio-net.c
 virtio_net_announce_notify(void) ""
-- 
2.11.0


