Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A652EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 724E720674
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3kHQID1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724E720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4kK-0006pt-OV
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4gi-0008DC-2T
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:32 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4gg-0006JE-Bs
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:31 -0400
Received: by mail-wm1-x342.google.com with SMTP id f18so1072171wml.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 13:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VUrwUV80rymMTitCKofJuTKzmFLE1QgsXWLHHkxkAO0=;
 b=v3kHQID186Zb0rR2a71SzKHJMUiOt3xJpXHR8c6ygLWqa6vdNG1rnOojXPNBO1O89f
 7jKGC/4IoNP9ZWdLWLWFJkky9QiPlCzAgfvf5gM8nfaC+dbEfkCQJVWWgF+vi+fO2yj3
 KReYQa+04R/an/VJyVz1TmGFkc5cCpRW63NcEsPjkv/4K37P9sRuMurf2jTshytTyo9k
 FrAZ3vnQXmNn868AlQafCGuKJvDt1uzOMrdaOjmSYgDz+J4lDAwnVo5V3ALJNIvc2+Zt
 zOTFb4wjxEYtuavM+uenFk1WkyeXHeiFo8s2fR0DOfXzbjaEFu6rSiU82dXzMYD70lQT
 sjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VUrwUV80rymMTitCKofJuTKzmFLE1QgsXWLHHkxkAO0=;
 b=GNwDMzaVRx34zrwahzzKs1lMI2kX7sOtXDeh5CODP/lz8veyaOjDI1NjNrT01ZH5Qu
 P6pYVJP1gVAb2H9bwiObYeHPkf4Go0DR/3WvveukmI7Hg+AP4asPn3tLkfHnY1Bw8Nsn
 rlwKOKozVci6GhLD6fivquzBUEHeaX6vDvq5e+Y82FFU+3fBe5+IS9+qJPs5oUwzrLVu
 zCfIoBn73g3SfVbdEY1uzO7LnMWJA2sLJ4WTtYB4UBWnHFZ3C42Z2MUxQJ/wonUv1F7/
 IYVtepxlcv2quIAw7MBF0vwwo1oedh/jmZeZ8jHblj0oF3OKRJ/mn2XZjPu1OxbulQ9d
 1e3g==
X-Gm-Message-State: AOAM531xu+FtzCW4gv72rBTRJ5SrLkG0ZRxicFLCxqTD1PP1mbWEUE1n
 VacJfnOr1E7E8SJDaCeaGTG+4w==
X-Google-Smtp-Source: ABdhPJz6jPJJswR/XcQVzF+bTcXWjgYeqpw8dI1E3iDnGaZ7KQQ4o0vZuYBqIMVVMeb+LUz63+5YLg==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr1066343wmi.83.1594670669046; 
 Mon, 13 Jul 2020 13:04:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h23sm872362wmb.3.2020.07.13.13.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 13:04:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 713781FF98;
 Mon, 13 Jul 2020 21:04:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/11] hw/virtio/pci: include vdev name in registered PCI
 sections
Date: Mon, 13 Jul 2020 21:04:13 +0100
Message-Id: <20200713200415.26214-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713200415.26214-1-alex.bennee@linaro.org>
References: <20200713200415.26214-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When viewing/debugging memory regions it is sometimes hard to figure
out which PCI device something belongs to. Make the names unique by
including the vdev name in the name string.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

---
v2
  - swap ()'s for an extra -
---
 hw/virtio/virtio-pci.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 8554cf2a03..215e680c71 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1406,7 +1406,8 @@ static void virtio_pci_device_write(void *opaque, hwaddr addr,
     }
 }
 
-static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
+static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy,
+                                           const char *vdev_name)
 {
     static const MemoryRegionOps common_ops = {
         .read = virtio_pci_common_read,
@@ -1453,36 +1454,41 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
         },
         .endianness = DEVICE_LITTLE_ENDIAN,
     };
+    g_autoptr(GString) name = g_string_new(NULL);
 
-
+    g_string_printf(name, "virtio-pci-common-%s", vdev_name);
     memory_region_init_io(&proxy->common.mr, OBJECT(proxy),
                           &common_ops,
                           proxy,
-                          "virtio-pci-common",
+                          name->str,
                           proxy->common.size);
 
+    g_string_printf(name, "virtio-pci-isr-%s", vdev_name);
     memory_region_init_io(&proxy->isr.mr, OBJECT(proxy),
                           &isr_ops,
                           proxy,
-                          "virtio-pci-isr",
+                          name->str,
                           proxy->isr.size);
 
+    g_string_printf(name, "virtio-pci-device-%s", vdev_name);
     memory_region_init_io(&proxy->device.mr, OBJECT(proxy),
                           &device_ops,
                           virtio_bus_get_device(&proxy->bus),
-                          "virtio-pci-device",
+                          name->str,
                           proxy->device.size);
 
+    g_string_printf(name, "virtio-pci-notify-%s", vdev_name);
     memory_region_init_io(&proxy->notify.mr, OBJECT(proxy),
                           &notify_ops,
                           virtio_bus_get_device(&proxy->bus),
-                          "virtio-pci-notify",
+                          name->str,
                           proxy->notify.size);
 
+    g_string_printf(name, "virtio-pci-notify-pio-%s", vdev_name);
     memory_region_init_io(&proxy->notify_pio.mr, OBJECT(proxy),
                           &notify_pio_ops,
                           virtio_bus_get_device(&proxy->bus),
-                          "virtio-pci-notify-pio",
+                          name->str,
                           proxy->notify_pio.size);
 }
 
@@ -1623,7 +1629,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
 
         struct virtio_pci_cfg_cap *cfg_mask;
 
-        virtio_pci_modern_regions_init(proxy);
+        virtio_pci_modern_regions_init(proxy, vdev->name);
 
         virtio_pci_modern_mem_region_map(proxy, &proxy->common, &cap);
         virtio_pci_modern_mem_region_map(proxy, &proxy->isr, &cap);
-- 
2.20.1


