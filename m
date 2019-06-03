Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2581C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C4127134
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C4127134
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrWJ-0000M9-Po
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:17:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrNw-0001pS-9x
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrNu-000860-PF
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:08:40 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:39362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hXrNu-00084h-K1
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:08:38 -0400
Received: by mail-qt1-f175.google.com with SMTP id i34so10516749qta.6
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 11:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=10gtUgNWokHnuKVb5ifGU0dmysJTncLIbTvLdgrqOEs=;
	b=mPsf4dA6I9zArmRG/i6/8UTT961QfocQ+5LZZNOiXaScHlnWAmlHF0peWYE+vKp9Tc
	NUMbBti6gCiC/oq9DocPpCuuN9CrudxYDLKDyYJ+j2zSIp5arncpYLhoJpQbG6d9qGQV
	QvK8yAObDT+Aug5WGui72yaChjj4xiFgNK8QCDAnbY2VUfjgcjM2Pqkx76ljEUIADExJ
	Za4P1VQgbUwBZFSYbtioMDWybNLANIAihqz61vYlydCJbE6AaJngamDyZfThMmliO6OD
	TH0UWIYehpI2HTNiAKKtFhoYqdpxrCALbD7gg/jHJnxZDX8E7c6o0RoPF+lYirFX7tiW
	INWw==
X-Gm-Message-State: APjAAAVWGJ81n2IJWjT1dUxk0+fjtFNWzhAwuX3joF4+SuFCS7oB/T33
	7wwqAokKhdB1niNSqoEUxx1YXReDKNM=
X-Google-Smtp-Source: APXvYqwD7+LESQYvG8i7SV89WYnmTuk76kKgcMdlNIgPeRCYdTnFIKJaHQWv+/cLnHBSyXjAcQB5aQ==
X-Received: by 2002:aed:3a23:: with SMTP id n32mr25070699qte.360.1559585317692;
	Mon, 03 Jun 2019 11:08:37 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	j26sm10101019qtj.70.2019.06.03.11.08.36
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 11:08:36 -0700 (PDT)
Date: Mon, 3 Jun 2019 14:08:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190513061939.3464-5-david@gibson.dropbear.id.au>
References: <20190603180807.16140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190603180807.16140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.175
Subject: [Qemu-devel] [PULL v2 04/14] pci: Make is_bridge a bool
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
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190603180834.hDQN_MHfJIE2uolWeHOWBZSo2c0xlk5an4wz9W1DARM@z>

From: David Gibson <david@gibson.dropbear.id.au>

The is_bridge field in PCIDevice acts as a bool, but is declared as an int.
Declare it as a bool for clarity, and change everything that writes it to
use true/false instead of 0/1 to match.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20190513061939.3464-5-david@gibson.dropbear.id.au>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h               | 2 +-
 hw/pci-bridge/dec.c                | 4 ++--
 hw/pci-bridge/i82801b11.c          | 2 +-
 hw/pci-bridge/pci_bridge_dev.c     | 2 +-
 hw/pci-bridge/pcie_pci_bridge.c    | 2 +-
 hw/pci-bridge/pcie_root_port.c     | 2 +-
 hw/pci-bridge/simba.c              | 2 +-
 hw/pci-bridge/xio3130_downstream.c | 2 +-
 hw/pci-bridge/xio3130_upstream.c   | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index da20c915ef..d082707dfa 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -234,7 +234,7 @@ typedef struct PCIDeviceClass {
      * This doesn't mean pci host switch.
      * When card bus bridge is supported, this would be enhanced.
      */
-    int is_bridge;
+    bool is_bridge;
 
     /* rom bar */
     const char *romfile;
diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
index 8484bfd434..ca40253730 100644
--- a/hw/pci-bridge/dec.c
+++ b/hw/pci-bridge/dec.c
@@ -68,7 +68,7 @@ static void dec_21154_pci_bridge_class_init(ObjectClass *klass, void *data)
     k->vendor_id = PCI_VENDOR_ID_DEC;
     k->device_id = PCI_DEVICE_ID_DEC_21154;
     k->config_write = pci_bridge_write_config;
-    k->is_bridge = 1;
+    k->is_bridge = true;
     dc->desc = "DEC 21154 PCI-PCI bridge";
     dc->reset = pci_bridge_reset;
     dc->vmsd = &vmstate_pci_device;
@@ -129,7 +129,7 @@ static void dec_21154_pci_host_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_DEC_21154;
     k->revision = 0x02;
     k->class_id = PCI_CLASS_BRIDGE_PCI;
-    k->is_bridge = 1;
+    k->is_bridge = true;
     /*
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index 10e590e5c6..6d8b0f54a7 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -90,7 +90,7 @@ static void i82801b11_bridge_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    k->is_bridge = 1;
+    k->is_bridge = true;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_82801BA_11;
     k->revision = ICH9_D2P_A2_REVISION;
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index ff6b8323da..c56ed1f52f 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -253,7 +253,7 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_BRIDGE;
     k->class_id = PCI_CLASS_BRIDGE_PCI;
-    k->is_bridge = 1,
+    k->is_bridge = true;
     dc->desc = "Standard PCI Bridge";
     dc->reset = qdev_pci_bridge_dev_reset;
     dc->props = pci_bridge_dev_properties;
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index d491b40d04..9a4fba413a 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -143,7 +143,7 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
-    k->is_bridge = 1;
+    k->is_bridge = true;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE;
     k->realize = pcie_pci_bridge_realize;
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index e94d918b6d..be3f4d5e03 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -162,7 +162,7 @@ static void rp_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->is_bridge = 1;
+    k->is_bridge = true;
     k->config_write = rp_write_config;
     k->realize = rp_realize;
     k->exit = rp_exit;
diff --git a/hw/pci-bridge/simba.c b/hw/pci-bridge/simba.c
index dea4c8c5e7..7cf0d6e047 100644
--- a/hw/pci-bridge/simba.c
+++ b/hw/pci-bridge/simba.c
@@ -76,7 +76,7 @@ static void simba_pci_bridge_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_SUN_SIMBA;
     k->revision = 0x11;
     k->config_write = pci_bridge_write_config;
-    k->is_bridge = 1;
+    k->is_bridge = true;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->reset = pci_bridge_reset;
     dc->vmsd = &vmstate_pci_device;
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 467bbabe4c..ab2a51e15d 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -152,7 +152,7 @@ static void xio3130_downstream_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->is_bridge = 1;
+    k->is_bridge = true;
     k->config_write = xio3130_downstream_write_config;
     k->realize = xio3130_downstream_realize;
     k->exit = xio3130_downstream_exitfn;
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index b524908cf1..1d41a49ab0 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -126,7 +126,7 @@ static void xio3130_upstream_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->is_bridge = 1;
+    k->is_bridge = true;
     k->config_write = xio3130_upstream_write_config;
     k->realize = xio3130_upstream_realize;
     k->exit = xio3130_upstream_exitfn;
-- 
MST


