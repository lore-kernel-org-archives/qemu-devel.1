Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B5AC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B2A2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkOVweFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B2A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYk8-0000T9-2w
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3e-00071u-Ey
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3d-0002VA-5A
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:02 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:53450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3c-0002RN-RP
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:00 -0500
Received: by mail-wm1-x335.google.com with SMTP id m24so1554173wmc.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uHPnz/CuhNDw7Q8yQgUAYEh1mPj3Ixi1rl2oxYokSDY=;
 b=hkOVweFoN9gpvN537B2OCzUpld8kUSUm5LFQtqVmKZvp88Mf45kf1fHiorV3ww4Kot
 cmyUHJQIvRqKl6WjPckEjWTvze95HRyldCW+OGsYnox2SLEBJmtQkAWNjxFhko095xxm
 ucQuFlCbQB31ziVETFpNi/pYpZ2WmsUzY4mdKj7fGIBhSmPOp5jWOwItkP0y6idNNPKX
 NCNDYwFFhjOHi5ywlWdJKwCXpfiC/96Hx6gGy2Cb5gaSqsAi9qd87rfM2JK/N1oux4/s
 WUhaQH1a2YWDNK6iG2JXhv7R0Bmqn54LkALHS1kw7AG5rjZDIP2BfKgos1xIU7SxVFJf
 es7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uHPnz/CuhNDw7Q8yQgUAYEh1mPj3Ixi1rl2oxYokSDY=;
 b=B8g3XuEQH8RHTta4iJroCoMi0iKokmDWHBFNbZZSFSDZfp0SphrcuVn7E+b0TXaaEh
 p25hj7ZV+CxXzOInIwMCg/b6LrzAWXvie+N6reAwjcYDLIlB97P+ioAiT7inV9sQnvKS
 8F282Ji2JJjZHQba94E1BRVva0hMKvU3O6Tp76yo1y+hD085538wOq7a/PvGgQp6tTrE
 v9tnpQEgcggQKFSDdJ4m/IMC840bS+68pmAyjPNEV/RvSYKz2jOpC+meduNF3JBw5n7+
 VYfPxjCvrMz4j1Wt4S4ZyOYvpsq6SFvwraRAYaE9mIEn7eQICJ8oSsT0KpiYr4bCcoqo
 7+Bw==
X-Gm-Message-State: APjAAAUVVLZ89Z0Iv5XXZEjawmNHsf2h+RrPvWBaiXk3Io4MbAuip2KR
 tP218yE1voGa4xC0kdNwCy0mdVnD
X-Google-Smtp-Source: APXvYqyGG9+wogbJwc0Juvg9Z0UHi7JNdevRmz1Ds+t5VLs58Lm7D9I6mkG948uvv/X14IGhnVdNNA==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr2994613wma.89.1576670639267; 
 Wed, 18 Dec 2019 04:03:59 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 55/87] hw/isa/isa-bus: cleanup irq functions
Date: Wed, 18 Dec 2019 13:02:21 +0100
Message-Id: <1576670573-48048-56-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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



