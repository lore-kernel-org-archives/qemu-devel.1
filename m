Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425A4C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0422120848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0422120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53771 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFOv-0002g9-Cg
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:22:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFKa-0007nJ-8Y
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFKX-0000tM-7g
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:17:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFKX-0000sp-1Q
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:17:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so3560483qth.5
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=Mwj59QAF+ETU+yRYVN8P1wjLxiufoyyiRXyVtu+O3hU=;
	b=D5o6RnuvCZlEbU0//CIrio5fZdO2Os/enu1/BiCFK7R2xE5+ZF6BdoY+MgStiaPlFV
	r2kc7oyivc/iTvafjT56T6v6MUd6fwkdW+iq4cdmEmZAkmaRzogzCECDOOzw1JqWJtPK
	YJQ1uGirQz03yRXnMV4qUvyBk3D+n4NDsAJ8LSeUojgea0dn8BAyb9wRZT+gVSvkbrWB
	2ddwyQTS7KoK3c0j2Z+azcyO5Uxe9FdAi0P4YIUT9Yuclpv6gbZrDD3RUwa0yfgxXqeW
	RB+btI6NX8GOe8v8OQrkbAYYnFCsyaSbXQY4uCaJSNLkO9BxqWp/F+vnw+we0/fYnDAS
	i+Kg==
X-Gm-Message-State: APjAAAWzHeG3qW0V/mgBpvu98nT2J6fuBFIH7zCvpssSbkZMu2x6u5BH
	4QpsaJafEDskOa/+84xiHiUJdeFNqhQ=
X-Google-Smtp-Source: APXvYqxlAwbxfneZwEj8zmYzxPGkBcum8jVBEl0sc9jBTZsqdD0hCJ9k8pUfyhrHG89E+g9d4SfO7A==
X-Received: by 2002:a0c:c14d:: with SMTP id i13mr23632494qvh.244.1558009068065;
	Thu, 16 May 2019 05:17:48 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	y12sm2911083qtk.51.2019.05.16.05.17.45
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:17:47 -0700 (PDT)
Date: Thu, 16 May 2019 08:17:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190215103239.28640-2-berrange@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
Subject: [Qemu-devel] [PULL 01/37] hw: report invalid disable-legacy|modern
 usage for virtio-1-only devs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, Gonglei <arei.gonglei@huawei.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190516121743.sVIz6I2NXll-SI0cpXohH85cMnoD6UeCmJWOE4570N8@z>

From: Daniel P. Berrangé <berrange@redhat.com>

A number of virtio devices (gpu, crypto, mouse, keyboard, tablet) only
support the virtio-1 (aka modern) mode. Currently if the user launches
QEMU, setting those devices to enable legacy mode, QEMU will silently
create them in modern mode, ignoring the user's (mistaken) request.

This patch introduces proper data validation so that an attempt to
configure a virtio-1-only devices in legacy mode gets reported as an
error to the user.

Checking this required introduction of a new field to explicitly track
what operating model is to be used for a device, separately from the
disable_modern and disable_legacy fields that record the user's
requested configuration.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20190215103239.28640-2-berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.h        | 31 +++++++++++++++++++++++++------
 hw/core/machine.c             | 23 ++++++++++++++++++++---
 hw/display/virtio-gpu-pci.c   |  4 +++-
 hw/display/virtio-vga.c       |  4 +++-
 hw/virtio/virtio-crypto-pci.c |  4 +++-
 hw/virtio/virtio-input-pci.c  |  4 +++-
 hw/virtio/virtio-pci.c        | 26 ++++++++++++++++----------
 7 files changed, 73 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 18581854ca..bfea2892a5 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -15,6 +15,7 @@
 #ifndef QEMU_VIRTIO_PCI_H
 #define QEMU_VIRTIO_PCI_H
 
+#include "qapi/error.h"
 #include "hw/pci/msi.h"
 #include "hw/virtio/virtio-bus.h"
 
@@ -118,6 +119,12 @@ typedef struct VirtIOPCIQueue {
   uint32_t used[2];
 } VirtIOPCIQueue;
 
+typedef enum {
+    VIRTIO_PCI_MODE_LEGACY,
+    VIRTIO_PCI_MODE_TRANSITIONAL,
+    VIRTIO_PCI_MODE_MODERN,
+} VirtIOPCIMode;
+
 struct VirtIOPCIProxy {
     PCIDevice pci_dev;
     MemoryRegion bar;
@@ -142,6 +149,7 @@ struct VirtIOPCIProxy {
     bool disable_modern;
     bool ignore_backend_features;
     OnOffAuto disable_legacy;
+    VirtIOPCIMode mode;
     uint32_t class_code;
     uint32_t nvectors;
     uint32_t dfselect;
@@ -156,23 +164,34 @@ struct VirtIOPCIProxy {
 
 static inline bool virtio_pci_modern(VirtIOPCIProxy *proxy)
 {
-    return !proxy->disable_modern;
+    return proxy->mode != VIRTIO_PCI_MODE_LEGACY;
 }
 
 static inline bool virtio_pci_legacy(VirtIOPCIProxy *proxy)
 {
-    return proxy->disable_legacy == ON_OFF_AUTO_OFF;
+    return proxy->mode != VIRTIO_PCI_MODE_MODERN;
 }
 
-static inline void virtio_pci_force_virtio_1(VirtIOPCIProxy *proxy)
+static inline bool virtio_pci_force_virtio_1(VirtIOPCIProxy *proxy,
+                                             Error **errp)
 {
-    proxy->disable_modern = false;
-    proxy->disable_legacy = ON_OFF_AUTO_ON;
+    if (proxy->disable_legacy == ON_OFF_AUTO_OFF) {
+        error_setg(errp, "Unable to set disable-legacy=off on a virtio-1.0 "
+                   "only device");
+        return false;
+    }
+    if (proxy->disable_modern == true) {
+        error_setg(errp, "Unable to set disable-modern=on on a virtio-1.0 "
+                   "only device");
+        return false;
+    }
+    proxy->mode = VIRTIO_PCI_MODE_MODERN;
+    return true;
 }
 
 static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
 {
-    proxy->disable_modern = true;
+    proxy->mode = VIRTIO_PCI_MODE_LEGACY;
 }
 
 /*
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 5d046a43e3..934c1bcceb 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -102,9 +102,26 @@ const size_t hw_compat_2_7_len = G_N_ELEMENTS(hw_compat_2_7);
 
 GlobalProperty hw_compat_2_6[] = {
     { "virtio-mmio", "format_transport_address", "off" },
-    /* Optional because not all virtio-pci devices support legacy mode */
-    { "virtio-pci", "disable-modern", "on",  .optional = true },
-    { "virtio-pci", "disable-legacy", "off", .optional = true },
+    /*
+     * don't include devices which are modern-only
+     * ie keyboard, mouse, tablet, gpu, vga & crypto
+     */
+    { "virtio-9p-pci", "disable-modern", "on" },
+    { "virtio-9p-pci", "disable-legacy", "off" },
+    { "virtio-balloon-pci", "disable-modern", "on" },
+    { "virtio-balloon-pci", "disable-legacy", "off" },
+    { "virtio-blk-pci", "disable-modern", "on" },
+    { "virtio-blk-pci", "disable-legacy", "off" },
+    { "virtio-input-host-pci", "disable-modern", "on" },
+    { "virtio-input-host-pci", "disable-legacy", "off" },
+    { "virtio-net-pci", "disable-modern", "on" },
+    { "virtio-net-pci", "disable-legacy", "off" },
+    { "virtio-rng-pci", "disable-modern", "on" },
+    { "virtio-rng-pci", "disable-legacy", "off" },
+    { "virtio-scsi-pci", "disable-modern", "on" },
+    { "virtio-scsi-pci", "disable-legacy", "off" },
+    { "virtio-serial-pci", "disable-modern", "on" },
+    { "virtio-serial-pci", "disable-legacy", "off" },
 };
 const size_t hw_compat_2_6_len = G_N_ELEMENTS(hw_compat_2_6);
 
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index bdcd33c925..0bc4d9d424 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -47,7 +47,9 @@ static void virtio_gpu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     Error *local_error = NULL;
 
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    virtio_pci_force_virtio_1(vpci_dev);
+    if (!virtio_pci_force_virtio_1(vpci_dev, errp)) {
+        return;
+    }
     object_property_set_bool(OBJECT(vdev), true, "realized", &local_error);
 
     if (local_error) {
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index a2b803b75f..5d57bf5b0c 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -154,7 +154,9 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 
     /* init virtio bits */
     qdev_set_parent_bus(DEVICE(g), BUS(&vpci_dev->bus));
-    virtio_pci_force_virtio_1(vpci_dev);
+    if (!virtio_pci_force_virtio_1(vpci_dev, errp)) {
+        return;
+    }
     object_property_set_bool(OBJECT(g), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index 90a6e0dc2e..13807e538b 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -51,7 +51,9 @@ static void virtio_crypto_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     }
 
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    virtio_pci_force_virtio_1(vpci_dev);
+    if (!virtio_pci_force_virtio_1(vpci_dev, errp)) {
+        return;
+    }
     object_property_set_bool(OBJECT(vdev), true, "realized", errp);
     object_property_set_link(OBJECT(vcrypto),
                  OBJECT(vcrypto->vdev.conf.cryptodev), "cryptodev",
diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
index 2c1397842b..28477729a3 100644
--- a/hw/virtio/virtio-input-pci.c
+++ b/hw/virtio/virtio-input-pci.c
@@ -48,7 +48,9 @@ static void virtio_input_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     DeviceState *vdev = DEVICE(&vinput->vdev);
 
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    virtio_pci_force_virtio_1(vpci_dev);
+    if (!virtio_pci_force_virtio_1(vpci_dev, errp)) {
+        return;
+    }
     object_property_set_bool(OBJECT(vdev), true, "realized", errp);
 }
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index cb44e19b67..509c1ff555 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1721,16 +1721,22 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
                        /* PCI BAR regions must be powers of 2 */
                        pow2ceil(proxy->notify.offset + proxy->notify.size));
 
-    if (proxy->disable_legacy == ON_OFF_AUTO_AUTO) {
-        proxy->disable_legacy = pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
-    }
-
-    if (!virtio_pci_modern(proxy) && !virtio_pci_legacy(proxy)) {
-        error_setg(errp, "device cannot work as neither modern nor legacy mode"
-                   " is enabled");
-        error_append_hint(errp, "Set either disable-modern or disable-legacy"
-                          " to off\n");
-        return;
+    if ((proxy->disable_legacy == ON_OFF_AUTO_ON) ||
+        ((proxy->disable_legacy == ON_OFF_AUTO_AUTO) && pcie_port)) {
+        if (proxy->disable_modern) {
+            error_setg(errp, "device cannot work as neither modern nor "
+                       "legacy mode is enabled");
+            error_append_hint(errp, "Set either disable-modern or "
+                              "disable-legacy to off\n");
+            return;
+        }
+        proxy->mode = VIRTIO_PCI_MODE_MODERN;
+    } else {
+        if (proxy->disable_modern) {
+            proxy->mode = VIRTIO_PCI_MODE_LEGACY;
+        } else {
+            proxy->mode = VIRTIO_PCI_MODE_TRANSITIONAL;
+        }
     }
 
     if (pcie_port && pci_is_express(pci_dev)) {
-- 
MST


