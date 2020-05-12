Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB01C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC4120736
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3P8zUF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC4120736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYPfK-00018S-8T
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYPeH-0008U6-NU; Tue, 12 May 2020 03:48:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYPeG-0002qY-VH; Tue, 12 May 2020 03:48:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id z72so12511946wmc.2;
 Tue, 12 May 2020 00:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=olrssLZq87JihaVWusLCkJTiP56dPUZ0HwB6S/q6u0w=;
 b=f3P8zUF8nDi60cSsADAjn0HuBAlTyEP3PErsw6ilb8yZZeoiHrQ8/G2mYZECjodLFy
 q1YST3BLB+8KddWsbiStLQaC5BXC8W2j2h98CU17mWxMyU94tnsNEX6pvlt0kAT1vh+M
 0YMkTonu2AkxHMH1j+eoXpikkSF+ljAvgelEy8IhN840MZ98a5GZwcGoC9/LqzyAtlxc
 VeUmTyGlRjtcLvAX/La2LVLWasTKO2RkaCvAqwg8MEoPTm9E+AugmUTWCxQ4tf+mbLPr
 1Vn8SfpUf5xzFEsragBU/AJcxhArOfTYEE/ZiQlmEjJfWm0aSbW+eEF4eD29ecvewv9t
 Bntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=olrssLZq87JihaVWusLCkJTiP56dPUZ0HwB6S/q6u0w=;
 b=rouqVa/v73lnS9n6/Mi12KGpwpvkrI3bfkuH48CaIVA1H6qLwkh+nCfjq9SxnB1cMn
 3wJ7N0eSj8sGcHKA+x6VgIoJH8f2mWXWCGCFzYc3kcjEREL4CRjnbUKP9yAJv87xOW9a
 e8qYUGbb4M2sP6KINvEOeSOQdpr9SOUMIZRoCVVKvlpLxOpzkvTe3Vl4si5ciXKHc1QH
 9TLrLZTEzE6G3NAwfuGa83JBCXGICYKNpbeT1yevqjw08fMkYeTcAzvZYyAlPhHtVIeL
 mLZViZN1D1Ep4Y87b49MG8HhWw1h8mqZ/4ryXL2d0IQmHNmfKy4dg2Ba6ASYLeWGwIt7
 x5Pw==
X-Gm-Message-State: AGi0PubV0rrI/7k23INc6Ks2hvTf9hPifxQHNt2eD21xnQduQAEZvzEN
 nqsLL8eA+iUExzLr8yXg478akf9yIfE=
X-Google-Smtp-Source: APiQypJAar1ayWLmftBaKkWXKHxNbu9HxtuHEMZoRyxJzs16ps5v0/K8/J4yCzSfzCY3+jID8y4ELg==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr25666708wmk.18.1589269698469; 
 Tue, 12 May 2020 00:48:18 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id c7sm7783754wro.80.2020.05.12.00.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 00:48:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] hw/ide/ahci: Use qdev gpio rather than
 qemu_allocate_irqs()
Date: Tue, 12 May 2020 09:48:11 +0200
Message-Id: <20200512074813.29992-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200512074813.29992-1-f4bug@amsat.org>
References: <20200512074813.29992-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Stafford Horne <shorne@gmail.com>,
 John Snow <jsnow@redhat.com>, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When plugging/unplugging devices on a AHCI bus, we might
leak the memory returned by qemu_allocate_irqs(). We can
avoid this leak by switching to using qdev_init_gpio_in();
the base class finalize will free the irqs that this allocates
under the hood.

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ide/ahci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 13d91e109a..991bb7c9c8 100644
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
+    qdev_init_gpio_in(qdev, ahci_irq_set, s->ports);
     for (i = 0; i < s->ports; i++) {
         AHCIDevice *ad = &s->dev[i];
 
         ide_bus_new(&ad->port, sizeof(ad->port), qdev, i, 1);
-        ide_init2(&ad->port, irqs[i]);
+        ide_init2(&ad->port, qdev_get_gpio_in(qdev, i));
 
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
2.21.3


