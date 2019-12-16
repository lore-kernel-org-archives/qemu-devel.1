Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8D4C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD5C7206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D91lpF6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5C7206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igu5T-00063L-ES
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFj-0005xe-03
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFh-0000Z7-8L
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:46 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:53209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFg-0000U8-Uw
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:45 -0500
Received: by mail-wm1-x334.google.com with SMTP id p9so7444714wmc.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uHPnz/CuhNDw7Q8yQgUAYEh1mPj3Ixi1rl2oxYokSDY=;
 b=D91lpF6xCIs2UwubdoVbaMhMcJUquR5iq9fKhXDSIxdqXz+j8CmGQyCAd786XV8Xiu
 lqfHbzyWrthj1omOEfxPQBPpP8b89JQHWqm/GMWnpNdSL9bavjEP5uW3+42p3tN9sqWD
 tgmmg9eR15imc7DW489Ko6+GJrY5SSp5R3kjgZD+GHimT5PfewcUYMR5m39Lam5XrsCH
 8jgTeNWJ9GPE/g7+5x454X5Lsq1UuBKYVVJi6iSFNVqtj1TmlBI9uHrGnwe08c5TqEBI
 Tyg44tVceGWIh6JPicEb6BaAwfOtd7sDWYEMvDjkv8PKXWS+tDJC+ddqbko7Z/RT1dJU
 t3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uHPnz/CuhNDw7Q8yQgUAYEh1mPj3Ixi1rl2oxYokSDY=;
 b=uA+IJfD7bxDUI2XYnYraRZLTACN8MRRCZ2CjctIOPocIwIEvFZMuDu//HMo2kthvAr
 hpDJKnK4tFbiSDalUbs6CsEaLrM+sZoX68obegcdkklvdGoL8UvvArn4itFzC2x3D090
 yC98MZciyMWxZhssHv8M6mBwUXVnw7zKeFOGodRp2UqJgRLFkGPeX7mXS4Ag6QksBxcV
 d5xQEWJXXG2Tg5G9SttESTd2TUTzpU9cDJT6pD5v6PEGHkf0n2puW2n2oBIeaD+wVQgg
 ArLATccRs4qxwcdSdC5QzUDLOUcaLR5WdYpqyQYvnMGE4VyVj0fbUo3U1ePfqJpSza9V
 O5kA==
X-Gm-Message-State: APjAAAXpyHmoy3Wk2pzJf7qMXwFDtp3GrQ39c0Buhws8CuN6YL9Zy4LW
 cuM7CqS6VyZ0GPrPhPRFagwHDJ8l
X-Google-Smtp-Source: APXvYqxlNkhMRGRSG5eg4Xb4h3Pazx89IawPB0tefPb4zoIoepgnLNIzxI8LbZztjcwhCH5fbUwkfQ==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr32501204wma.159.1576513782919; 
 Mon, 16 Dec 2019 08:29:42 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 55/62] hw/isa/isa-bus: cleanup irq functions
Date: Mon, 16 Dec 2019 17:28:39 +0100
Message-Id: <1576513726-53700-56-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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

The irq number is unsigned; we reject negative values.  But -1
is used for the isairq array, which is declared unsigned!  And
since we have a definition for the number of ISA IRQs, use it.

Based on a patch by Philippe Mathieu-Daudé.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/isa-bus.c     | 11 +++++++----
 include/hw/isa/isa.h |  8 ++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 3888006..798dd91 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -82,24 +82,27 @@ void isa_bus_irqs(ISABus *bus, qemu_irq *irqs)
  * This function is only for special cases such as the 'ferr', and
  * temporary use for normal devices until they are converted to qdev.
  */
-qemu_irq isa_get_irq(ISADevice *dev, int isairq)
+qemu_irq isa_get_irq(ISADevice *dev, unsigned isairq)
 {
     assert(!dev || ISA_BUS(qdev_get_parent_bus(DEVICE(dev))) == isabus);
-    if (isairq < 0 || isairq > 15) {
+    if (isairq >= ISA_NUM_IRQS) {
         hw_error("isa irq %d invalid", isairq);
     }
     return isabus->irqs[isairq];
 }
 
-void isa_init_irq(ISADevice *dev, qemu_irq *p, int isairq)
+void isa_init_irq(ISADevice *dev, qemu_irq *p, unsigned isairq)
 {
     assert(dev->nirqs < ARRAY_SIZE(dev->isairq));
+    if (isairq >= ISA_NUM_IRQS) {
+        hw_error("isa irq %d invalid", isairq);
+    }
     dev->isairq[dev->nirqs] = isairq;
     *p = isa_get_irq(dev, isairq);
     dev->nirqs++;
 }
 
-void isa_connect_gpio_out(ISADevice *isadev, int gpioirq, int isairq)
+void isa_connect_gpio_out(ISADevice *isadev, int gpioirq, unsigned isairq)
 {
     qemu_irq irq;
     isa_init_irq(isadev, &irq, isairq);
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 79f703f..e9ac1f1 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -88,7 +88,7 @@ struct ISADevice {
     DeviceState parent_obj;
     /*< public >*/
 
-    uint32_t isairq[2];
+    int8_t isairq[2];      /* -1 = unassigned */
     int nirqs;
     int ioport_id;
 };
@@ -96,9 +96,9 @@ struct ISADevice {
 ISABus *isa_bus_new(DeviceState *dev, MemoryRegion *address_space,
                     MemoryRegion *address_space_io, Error **errp);
 void isa_bus_irqs(ISABus *bus, qemu_irq *irqs);
-qemu_irq isa_get_irq(ISADevice *dev, int isairq);
-void isa_init_irq(ISADevice *dev, qemu_irq *p, int isairq);
-void isa_connect_gpio_out(ISADevice *isadev, int gpioirq, int isairq);
+qemu_irq isa_get_irq(ISADevice *dev, unsigned isairq);
+void isa_init_irq(ISADevice *dev, qemu_irq *p, unsigned isairq);
+void isa_connect_gpio_out(ISADevice *isadev, int gpioirq, unsigned isairq);
 void isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16);
 IsaDma *isa_get_dma(ISABus *bus, int nchan);
 MemoryRegion *isa_address_space(ISADevice *dev);
-- 
1.8.3.1



