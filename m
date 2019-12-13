Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B09BC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 09:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94042073D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 09:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwv+J8Dk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94042073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifhjK-0005D8-1A
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 04:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ifhia-0004oX-LI
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ifhiZ-0004hp-9F
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:58:40 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44307)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ifhiZ-0004eA-1n
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:58:39 -0500
Received: by mail-wr1-x441.google.com with SMTP id q10so5921432wrm.11
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 01:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rc863mpgWMbIDtGydzeePchhIO4jO4tkazPeQWspVtQ=;
 b=rwv+J8Dk8zicF6PQMqfISUo+MB/gNW3NHpuoa/UD3F1fQiJOjK+6uA9DdlDo5Jtsii
 3TWkOvp/UYelHlU4F7VuT41lAxxaJdP01GemAF/LE6mQDt6zlmjygiG5AnzuNoWadlmS
 SlyTyu4p5+VzklyRC5IZCkc1R643iNmFLnEZgma3oLlVrH0jXYe6GNnKgzlnPxqXmxCr
 8ggyYR8JS+PEJrXkPsTozc9BEsBTB43O1T5n2KqyOmHj+VzImrQW0w9c4cYfRkoZGnET
 1Idoo6nxAelW03GjMskxMyTrzmf0wHva4O+3+ed3RMk3MANdw5OwbzY8jfMEBZ/Rb81Z
 O0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rc863mpgWMbIDtGydzeePchhIO4jO4tkazPeQWspVtQ=;
 b=LajIqBdk9+QkU+OvpvdvtvIExMT0BB6btxc9gNqAYXegI1seU0P/ETiqAGc3AhBI91
 OnkHeUgkC1RkcvyDNxRzk12Ir876IX5TrkMCn+UEIQ3q4souPnrQHwfAo5favPZc/jBX
 vH2bhO/wL3m6ZVJt2NyO+tW5KrHMfByfDkZK+GTCXEyayvZ8G35pyJPPsTBTskTaEwKx
 nSIBWDbjdBg0Ff6MFnW01/KWF+yfOFv2K9U3ziTp5LOPMPw6traRhIt66T2BfISRitAM
 pnYsprKeooA1yHOW2oa7wML2D8KqVLhM0jRpvMo6fFGKiJ29YX817cMRJTi+w5kGm04h
 e8tw==
X-Gm-Message-State: APjAAAWgdCR3mEACZLmCQ2L8GIi7J5pgteVgt/KrTIpzmk6MJRYTvUlT
 cFBiZGeakxudtF/xff7n32kcX+ocrUw=
X-Google-Smtp-Source: APXvYqwsPR4Z1FXx6N7sXsXVOVe5BRZ5Qo2q9rpbB1CMI+R47BJQlsnt7oxaHvhPQzqPVAXoRRLhdg==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr10691117wrv.259.1576231116841; 
 Fri, 13 Dec 2019 01:58:36 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch.
 [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id b17sm9417051wrp.49.2019.12.13.01.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 01:58:36 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio-mmio: Clear v2 transport state on soft reset
Date: Fri, 13 Dec 2019 10:54:10 +0100
Message-Id: <20191213095410.1516119-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: slp@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the moment when the guest writes a status of 0, we only reset the
virtio core state but not the virtio-mmio state. The virtio-mmio
specification says (v1.1 cs01, 4.2.2.1 Device Requirements:
MMIO Device Register Layout):

    Upon reset, the device MUST clear all bits in InterruptStatus and
    ready bits in the QueueReady register for all queues in the device.

The core already takes care of InterruptStatus by clearing isr, but we
still need to clear QueueReady.

It would be tempting to clean all registers, but since the specification
doesn't say anything more, guests could rely on the registers keeping
their state across reset. Linux for example, relies on this for
GuestPageSize in the legacy MMIO tranport.

Fixes: 44e687a4d9ab ("virtio-mmio: implement modern (v2) personality (virtio-1)")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
This fixes kexec of a Linux guest that uses the modern virtio-mmio
transport.
---
 hw/virtio/virtio-mmio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 94d934c44b..ef40b7a9b2 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -65,6 +65,19 @@ static void virtio_mmio_stop_ioeventfd(VirtIOMMIOProxy *proxy)
     virtio_bus_stop_ioeventfd(&proxy->bus);
 }
 
+static void virtio_mmio_soft_reset(VirtIOMMIOProxy *proxy)
+{
+    int i;
+
+    if (proxy->legacy) {
+        return;
+    }
+
+    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+        proxy->vqs[i].enabled = 0;
+    }
+}
+
 static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
 {
     VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
@@ -378,6 +391,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
 
         if (vdev->status == 0) {
             virtio_reset(vdev);
+            virtio_mmio_soft_reset(proxy);
         }
         break;
     case VIRTIO_MMIO_QUEUE_DESC_LOW:
-- 
2.24.0


