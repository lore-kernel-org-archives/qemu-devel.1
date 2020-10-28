Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689CFC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66B42463F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66B42463F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXgv0-00055u-LP
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 04:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXglk-0004Ms-Ih
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:25:20 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:51736
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXglg-0004M2-Nk
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:25:20 -0400
Received: from host81-158-111-11.range81-158.btcentralplus.com
 ([81.158.111.11] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXglj-0006Q8-J3; Wed, 28 Oct 2020 08:25:25 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Wed, 28 Oct 2020 08:23:58 +0000
Message-Id: <20201028082358.23761-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201028082358.23761-1-mark.cave-ayland@ilande.co.uk>
References: <20201028082358.23761-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.158.111.11
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 10/10] hw/pci-host/sabre: Simplify code initializing variable
 once
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We only need to zero-initialize 'val' once.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20201012170950.3491912-4-f4bug@amsat.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/sabre.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index f678a3eefc..f41a0cc301 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -195,32 +195,25 @@ static uint64_t sabre_config_read(void *opaque,
                                   hwaddr addr, unsigned size)
 {
     SabreState *s = opaque;
-    uint32_t val;
+    uint32_t val = 0;
 
     switch (addr) {
     case 0x30 ... 0x4f: /* DMA error registers */
-        val = 0;
         /* XXX: not implemented yet */
         break;
     case 0xc00 ... 0xc3f: /* PCI interrupt control */
         if (addr & 4) {
             val = s->pci_irq_map[(addr & 0x3f) >> 3];
-        } else {
-            val = 0;
         }
         break;
     case 0x1000 ... 0x107f: /* OBIO interrupt control */
         if (addr & 4) {
             val = s->obio_irq_map[(addr & 0xff) >> 3];
-        } else {
-            val = 0;
         }
         break;
     case 0x1080 ... 0x108f: /* PCI bus error */
         if (addr & 4) {
             val = s->pci_err_irq_map[(addr & 0xf) >> 3];
-        } else {
-            val = 0;
         }
         break;
     case 0x2000 ... 0x202f: /* PCI control */
@@ -229,8 +222,6 @@ static uint64_t sabre_config_read(void *opaque,
     case 0xf020 ... 0xf027: /* Reset control */
         if (addr & 4) {
             val = s->reset_control;
-        } else {
-            val = 0;
         }
         break;
     case 0x5000 ... 0x51cf: /* PIO/DMA diagnostics */
@@ -239,7 +230,6 @@ static uint64_t sabre_config_read(void *opaque,
     case 0xf000 ... 0xf01f: /* FFB config, memory control */
         /* we don't care */
     default:
-        val = 0;
         break;
     }
     trace_sabre_config_read(addr, val);
-- 
2.20.1


