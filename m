Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78725C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C922087E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBnWQ0E4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C922087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEC0P-000208-DR
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kEBws-0004tS-3p
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:40:14 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kEBwq-0005f2-2N
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:40:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id u18so6114535wmc.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 06:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6ITqVnKRG6efTEDBxxDrqufzGTL9CoWQ38GxyiPoSjU=;
 b=aBnWQ0E4SPdPlq/yVhKDRj/x5MLVIDmQ00yeCIFlqavSSKyKpH2BcutINTzpaYb5is
 EKOpmKAoTWtng6YQFvqdJqDUpOV9UJ6AFPZlSqHxioIrTuyVCxhAIkQe4ibrXdok20Sb
 EvFb9MUzd18JFZKzLj+jelyV3OxqR3usbBkqIELOBRcTN/BxD3uSdRMYDI0N3HWAT5cz
 x3ELI9b8PDwCtCL6xzSU1xBNniJXqlE3Mv6AK94gmyOBORNiUq+xpoOYxrGyekU91Bd0
 awIxezBtVGO0Sf1wFldaGlu/jOsYHYuwwpgQjrn2Z3t03rfrDSi/ekSx98KV69tA9j3i
 sv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6ITqVnKRG6efTEDBxxDrqufzGTL9CoWQ38GxyiPoSjU=;
 b=SRVa9PqvznNB3LCjTuswzCCpPdq+gCPpFMZAb6Kf6/tVY0702Jp8x20b/rtBJWIymq
 MHJjga1EmUk0bWWqLWXXJkEGjGcZ+C+j82YlrRnjupqCQjxQiowA7awYjen1ASHGPVDo
 Ufi3QWfG24uhj5hkyziM0Z3aTsLDUW/PNyAC2RGJpTynFavrOKQoH8u+pMsJP8hLc40E
 pWUapEt5QykPdW9QAFtEuAZh10XIB9WOas57SkGFUgL4dCD98iKZglRwYetVQJedJTbx
 pa69DpkveglQDikFWXrPABcnlXheES9+oe4G8PebOJbx1SFwlAbptrF5bWSmaCxXTZw8
 +CDg==
X-Gm-Message-State: AOAM5315GRTF9mQE88VSWMTH10Do9+iQdOC8HzLytBbR8nbGDBDd+Pk9
 eT9Is/BRKCwn5H5PBk2Vgw6GlQ==
X-Google-Smtp-Source: ABdhPJwKnu/dhtp312SBK7ahiNtM/qp8vf8a+yZtZb0GbkszM2scbX+q9SYK+ySKnudVjavVohFdQw==
X-Received: by 2002:a1c:2dcc:: with SMTP id t195mr7251321wmt.166.1599226810362; 
 Fri, 04 Sep 2020 06:40:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l19sm11325775wmi.8.2020.09.04.06.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 06:40:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D8A151FF87;
 Fri,  4 Sep 2020 14:40:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/4] hw/virtio/pci: include vdev name in registered PCI
 sections
Date: Fri,  4 Sep 2020 14:40:04 +0100
Message-Id: <20200904134007.4175-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200904134007.4175-1-alex.bennee@linaro.org>
References: <20200904134007.4175-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: robert.foley@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 robhenry@microsoft.com, aaron@os.amperecomputing.com, cota@braap.org,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When viewing/debugging memory regions it is sometimes hard to figure
out which PCI device something belongs to. Make the names unique by
including the vdev name in the name string.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Message-Id: <20200713200415.26214-10-alex.bennee@linaro.org>
---
 hw/virtio/virtio-pci.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5bc769f685c..169d07ba20e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1421,7 +1421,8 @@ static void virtio_pci_device_write(void *opaque, hwaddr addr,
     }
 }
 
-static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
+static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy,
+                                           const char *vdev_name)
 {
     static const MemoryRegionOps common_ops = {
         .read = virtio_pci_common_read,
@@ -1468,36 +1469,41 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
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
                           proxy,
-                          "virtio-pci-device",
+                          name->str,
                           proxy->device.size);
 
+    g_string_printf(name, "virtio-pci-notify-%s", vdev_name);
     memory_region_init_io(&proxy->notify.mr, OBJECT(proxy),
                           &notify_ops,
                           proxy,
-                          "virtio-pci-notify",
+                          name->str,
                           proxy->notify.size);
 
+    g_string_printf(name, "virtio-pci-notify-pio-%s", vdev_name);
     memory_region_init_io(&proxy->notify_pio.mr, OBJECT(proxy),
                           &notify_pio_ops,
                           proxy,
-                          "virtio-pci-notify-pio",
+                          name->str,
                           proxy->notify_pio.size);
 }
 
@@ -1642,7 +1648,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
 
         struct virtio_pci_cfg_cap *cfg_mask;
 
-        virtio_pci_modern_regions_init(proxy);
+        virtio_pci_modern_regions_init(proxy, vdev->name);
 
         virtio_pci_modern_mem_region_map(proxy, &proxy->common, &cap);
         virtio_pci_modern_mem_region_map(proxy, &proxy->isr, &cap);
-- 
2.20.1


