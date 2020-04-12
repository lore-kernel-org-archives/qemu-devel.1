Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E8CC2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF5D206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vX0sjzwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF5D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNkBk-00038t-GM
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 17:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNkAo-0001lJ-1m
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNkAn-0006hf-0P
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:29:49 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNkAm-0006h2-QB; Sun, 12 Apr 2020 17:29:48 -0400
Received: by mail-wm1-x342.google.com with SMTP id x4so7853013wmj.1;
 Sun, 12 Apr 2020 14:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ewcdrwwo68JETPKwOfBhBSt7cYAb7QAPUwIknRsZlp4=;
 b=vX0sjzwtOM9T7Ze0kYcABZ/EWM/ZC/zt4fuE50j4Vdhv7A45UVToTZ0CINzUjUYwzi
 3aCmO9A0Wbc+Qsr6wT8TFNVlSWrCeHfrvO4xXrlZt67vluWBM7KQ18BTRR69ty7VFkQe
 jxMV5RVZ0ivkhVIQH/DdI5VGIgvJ9UHi06zY3/F8sAN7BWmjl0RsTmfg5o3kB844edv+
 RztWzWdNT2Gy30ApPyoq8Sq9tQgxG+os9e7JT48j1cyyEsaeveOGyRdYwPHZ0EpTeChD
 y7MGA04jLKv/7jIgBLFW48Koc52+do/tMLCrndduyQ8Y1JpeWgKNAYzSey3RtPGU3g6l
 qFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Ewcdrwwo68JETPKwOfBhBSt7cYAb7QAPUwIknRsZlp4=;
 b=GLNyUsfDAyO12sB06RYQLgzY/VTVz/SsymYPm7WbNLA0rBwl5Ur0ohjV/ajmmavCC4
 bYcJYmU7DpOQsC+JqlQpnMOIn5Jn+7jOFDm7jFou0SsKqZF3IlCco/sNpokEDaItDIST
 zXF0yPxL9XQBxatM/zBCvderqHt4/Pw+A6RqZdG7G1PK748K+qseefGObmNyI8iTwlZi
 c/jQO6lvM/EtUFFvXX3LBOcPq8Umw28EwpvklWUJF+VVzxL9id2XqQz+FG5Y8EBr4Z2i
 ggaz0LnfxB05+U4Y8AST464nV0aVw8VQ1VYFaXTP/g8AsvWPL2ssG0GnrcLt6sekztVE
 hQCw==
X-Gm-Message-State: AGi0Pua94bZie3CL/tH+G45HDXTnR26qfvG/LtEGzeKCJWTIZsn6AmWC
 RPL20HyBNK6/guT3kyQ12gURLkey5t8=
X-Google-Smtp-Source: APiQypJ7uvY1OfKHnmfgVuIPmfFeQR4KiuWpFQe4z5ivqtk1ziDss6t2u2jp1uojtDSXLJWN8NhGbw==
X-Received: by 2002:a7b:c931:: with SMTP id h17mr16703572wml.105.1586726987497; 
 Sun, 12 Apr 2020 14:29:47 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id r3sm12797798wrm.35.2020.04.12.14.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 14:29:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 1/3] hw/ide/ahci: Use qdev gpio rather than
 qemu_allocate_irqs()
Date: Sun, 12 Apr 2020 23:29:41 +0200
Message-Id: <20200412212943.4117-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412212943.4117-1-f4bug@amsat.org>
References: <20200412212943.4117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stafford Horne <shorne@gmail.com>, John Snow <jsnow@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch to using the qdev gpio API which is preferred over
qemu_allocate_irqs(). One step to eventually deprecate and
remove qemu_allocate_irqs() one day.

Patch created mechanically using spatch with this script
inspired from commit d6ef883d9d7:

  @@
  typedef qemu_irq;
  identifier irqs, handler;
  expression opaque, count, i;
  @@
  -   qemu_irq *irqs;
      ...
  -   irqs = qemu_allocate_irqs(handler, opaque, count);
  +   qdev_init_gpio_in(DEVICE(opaque), handler, count);
      <+...
  -   irqs[i]
  +   qdev_get_gpio_in(DEVICE(opaque), i)
      ...+>
  ?-  g_free(irqs);

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ide/ahci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 13d91e109a..ef0a0a22ee 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1534,19 +1534,18 @@ void ahci_init(AHCIState *s, DeviceState *qdev)
 
 void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as, int ports)
 {
-    qemu_irq *irqs;
     int i;
 
     s->as = as;
     s->ports = ports;
     s->dev = g_new0(AHCIDevice, ports);
     ahci_reg_init(s);
-    irqs = qemu_allocate_irqs(ahci_irq_set, s, s->ports);
+    qdev_init_gpio_in(DEVICE(s), ahci_irq_set, s->ports);
     for (i = 0; i < s->ports; i++) {
         AHCIDevice *ad = &s->dev[i];
 
         ide_bus_new(&ad->port, sizeof(ad->port), qdev, i, 1);
-        ide_init2(&ad->port, irqs[i]);
+        ide_init2(&ad->port, qdev_get_gpio_in(DEVICE(s), i));
 
         ad->hba = s;
         ad->port_no = i;
@@ -1554,7 +1553,6 @@ void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as, int ports)
         ad->port.dma->ops = &ahci_dma_ops;
         ide_register_restart_cb(&ad->port);
     }
-    g_free(irqs);
 }
 
 void ahci_uninit(AHCIState *s)
-- 
2.21.1


