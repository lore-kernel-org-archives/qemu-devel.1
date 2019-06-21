Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F425C48BE3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585802084E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585802084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55092 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heDNc-0001oM-HM
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 02:50:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1heDKe-00084e-8U
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1heDJy-0005U3-Sl
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:46:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1heDJy-0005T5-PP
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:46:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so5858181qta.6
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 23:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vBZ5OU12c4PDiqrs3EsUx7W7QPqh2FB4ggafxVecKE4=;
 b=f9FFB2pFUEHaGhbSPyvsyUp/23fr4xElUspRyD0P9EcULGlXgQHzGbtuX+LhYP19rq
 C3+QwfND9oW1Y4raTxRuN8pM3Ns77wZXmW2jeVoN+H0xTTuFQe7poIwHL4lQ9lMmL1rE
 TXnqntP6Xzxfzp6SpFqEpbJo+vMQv7eGm6OmleUe00bpyGm32E2ETp0NlHVNy6Qbekw7
 sKv0AmBRms3RiaC3DqlhS5OonwnifkVca+D8R9vw2yO+GDUoaMA4VZe9WuvYsw2rmYO9
 8FpRhgrxnrIhQobLs7bs2lwKDiUOpftK/YrM+kBBf68ZFG9d/my6orq/yhe+RTfC4b6G
 yF4Q==
X-Gm-Message-State: APjAAAXIopgLlvFlMjEd4naEVNzqG4PRUdg/Gj5dpy8XVXKbXTVKfT4A
 iEVUtKxGFeOif4Cv7YmEmM4aLHoHrTQ=
X-Google-Smtp-Source: APXvYqwm/UfF/0MXl4pAvq0KXwJ9aIUfRCi1imN5H+ectUjrNq4aCn477i89XCKmHAbOj+KjZXoU4Q==
X-Received: by 2002:a0c:81f0:: with SMTP id 45mr44168802qve.13.1561099609897; 
 Thu, 20 Jun 2019 23:46:49 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id z50sm1595758qtz.36.2019.06.20.23.46.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 20 Jun 2019 23:46:49 -0700 (PDT)
Date: Fri, 21 Jun 2019 02:46:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190621064615.20099-3-mst@redhat.com>
References: <20190621064615.20099-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621064615.20099-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.196
Subject: [Qemu-devel] [PATCH 2/3] pcie: check that slt ctrl changed before
 deleting
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

During boot, linux would sometimes overwrites control of a powered off
slot before powering it on. Unfortunately QEMU interprets that as a
power off request and ejects the device.

For example:

/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -S -machine q35  \
    -device pcie-root-port,id=pcie_root_port_0,slot=2,chassis=2,addr=0x2,bus=pcie.0 \
    -monitor stdio disk.qcow2
(qemu)device_add virtio-balloon-pci,id=balloon,bus=pcie_root_port_0
(qemu)cont

Balloon is deleted during guest boot.

To fix, save control beforehand and check that power
or led state actually change before ejecting.

Note: this is more a hack than a solution, ideally we'd
find a better way to detect ejects, or move away
from ejects completely and instead monitor whether
it's safe to delete device due to e.g. its power state.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie.h              |  3 ++-
 hw/pci-bridge/pcie_root_port.c     |  5 ++++-
 hw/pci-bridge/xio3130_downstream.c |  5 ++++-
 hw/pci/pcie.c                      | 14 ++++++++++++--
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index e30334d74d..8d90c0e193 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -107,7 +107,8 @@ void pcie_cap_lnkctl_reset(PCIDevice *dev);
 
 void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot);
 void pcie_cap_slot_reset(PCIDevice *dev);
-void pcie_cap_slot_write_config(PCIDevice *dev,
+void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slot_ctl, uint16_t *slt_sta);
+void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slot_ctl, uint16_t slt_sta,
                                 uint32_t addr, uint32_t val, int len);
 int pcie_cap_slot_post_load(void *opaque, int version_id);
 void pcie_cap_slot_push_attention_button(PCIDevice *dev);
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 92f253c924..09019ca05d 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -31,10 +31,13 @@ static void rp_write_config(PCIDevice *d, uint32_t address,
 {
     uint32_t root_cmd =
         pci_get_long(d->config + d->exp.aer_cap + PCI_ERR_ROOT_COMMAND);
+    uint16_t slt_ctl, slt_sta;
+
+    pcie_cap_slot_get(d, &slt_ctl, &slt_sta);
 
     pci_bridge_write_config(d, address, val, len);
     rp_aer_vector_update(d);
-    pcie_cap_slot_write_config(d, address, val, len);
+    pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
     pcie_aer_write_config(d, address, val, len);
     pcie_aer_root_write_config(d, address, val, len, root_cmd);
 }
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 264e37d6a6..899b0fd6c9 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -41,9 +41,12 @@
 static void xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
                                          uint32_t val, int len)
 {
+    uint16_t slt_ctl, slt_sta;
+
+    pcie_cap_slot_get(d, &slt_sta, &slt_ctl);
     pci_bridge_write_config(d, address, val, len);
     pcie_cap_flr_write_config(d, address, val, len);
-    pcie_cap_slot_write_config(d, address, val, len);
+    pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
     pcie_aer_write_config(d, address, val, len);
 }
 
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b22527000d..f8490a00de 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -594,7 +594,15 @@ void pcie_cap_slot_reset(PCIDevice *dev)
     hotplug_event_update_event_status(dev);
 }
 
-void pcie_cap_slot_write_config(PCIDevice *dev,
+void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_sta)
+{
+    uint32_t pos = dev->exp.exp_cap;
+    uint8_t *exp_cap = dev->config + pos;
+    *slt_ctl = pci_get_word(exp_cap + PCI_EXP_SLTCTL);
+    *slt_sta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
+}
+
+void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slt_ctl, uint16_t slt_sta,
                                 uint32_t addr, uint32_t val, int len)
 {
     uint32_t pos = dev->exp.exp_cap;
@@ -623,7 +631,9 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
      * controller is off, it is safe to detach the devices.
      */
     if ((sltsta & PCI_EXP_SLTSTA_PDS) && (val & PCI_EXP_SLTCTL_PCC) &&
-        ((val & PCI_EXP_SLTCTL_PIC_OFF) == PCI_EXP_SLTCTL_PIC_OFF)) {
+        (val & PCI_EXP_SLTCTL_PIC_OFF) == PCI_EXP_SLTCTL_PIC_OFF &&
+        (!(slt_ctl & PCI_EXP_SLTCTL_PCC) ||
+        (slt_ctl & PCI_EXP_SLTCTL_PIC_OFF) != PCI_EXP_SLTCTL_PIC_OFF)) {
         PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
         pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
                             pcie_unplug_device, NULL);
-- 
MST


