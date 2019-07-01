Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16B7C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97591208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97591208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhsmH-0008Qx-TF
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 05:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50352)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hhsiI-0003ah-B9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hhsiD-0003T8-Am
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:35:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hhsiD-0003SD-5Q
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:35:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so13899313qtk.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 02:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:in-reply-to;
 bh=19SIfXORG8YqIOH0n+CjUrcRgKw9ikRCvTr7pih/Br8=;
 b=sFu+eY1d75cMl0CR8jdaZrQ1ngkKkpl1jxMbxvc6V//hik8jZMfCOcw8nG2z+MHCP6
 YmM4dmzXdlx5gfCVYuWuxQpXgzHD9VkqobrBmEQtfbgB+glGRltASGmN9dAHch5fswv7
 mxc8ZHmkJ29tZy9Kvhkt+cNytoJdgc3R47DKyaMcr1D9QKrq9IWFGB+vBJ3SRCpP4egk
 Yfy/aLbHYHEmRO4nJkFm0t/mBpgUCTx5RZWd2On9ixYcK7L5el+ZtmrrE4zEcMTfvQX6
 dYVMdnZt9zCDijR27IG/VAqdCyXO7/Hyv362C2CA+gUiLSI1wRK4C75P9Vg/eX9oL6Lt
 RX/w==
X-Gm-Message-State: APjAAAXB2uWmuVv6N7e2hLlBUGOp+IOUTHdqZ08e7suBM54Jw3tQ9qEp
 Hg7M6iATafwg/2nB0oBqfTPuy14vDkMkWw==
X-Google-Smtp-Source: APXvYqzO5Gh9d6TZ5b5CxDDD/WOERZmv7mJr0B77y1BfvKTusRRWppLmJJIFYymdwBqVQpEEHIq/Fw==
X-Received: by 2002:aed:3a24:: with SMTP id n33mr19094772qte.361.1561973700050; 
 Mon, 01 Jul 2019 02:35:00 -0700 (PDT)
Received: from redhat.com ([37.26.146.159])
 by smtp.gmail.com with ESMTPSA id j22sm4512839qtp.0.2019.07.01.02.34.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 02:34:59 -0700 (PDT)
Date: Mon, 1 Jul 2019 05:34:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190701093232.28575-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621064615.20099-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.193
Subject: [Qemu-devel] [PATCH 4/3] pcie: minor cleanups for slot
 control/status
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename function arguments to make intent clearer.
Better documentation for slot control logic.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---


 include/hw/pci/pcie.h |  3 ++-
 hw/pci/pcie.c         | 17 +++++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 8d90c0e193..34f277735c 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -108,7 +108,8 @@ void pcie_cap_lnkctl_reset(PCIDevice *dev);
 void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot);
 void pcie_cap_slot_reset(PCIDevice *dev);
 void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slot_ctl, uint16_t *slt_sta);
-void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slot_ctl, uint16_t slt_sta,
+void pcie_cap_slot_write_config(PCIDevice *dev,
+                                uint16_t old_slot_ctl, uint16_t old_slt_sta,
                                 uint32_t addr, uint32_t val, int len);
 int pcie_cap_slot_post_load(void *opaque, int version_id);
 void pcie_cap_slot_push_attention_button(PCIDevice *dev);
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index c605d32dd4..a6beb567bd 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -602,7 +602,8 @@ void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_sta)
     *slt_sta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
 }
 
-void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slt_ctl, uint16_t slt_sta,
+void pcie_cap_slot_write_config(PCIDevice *dev,
+                                uint16_t old_slt_ctl, uint16_t old_slt_sta,
                                 uint32_t addr, uint32_t val, int len)
 {
     uint32_t pos = dev->exp.exp_cap;
@@ -625,8 +626,8 @@ void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slt_ctl, uint16_t slt_s
                           PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC | \
                           PCI_EXP_SLTSTA_CC)
 
-        if (val & ~slt_sta & PCIE_SLOT_EVENTS) {
-            sltsta = (sltsta & ~PCIE_SLOT_EVENTS) | (slt_sta & PCIE_SLOT_EVENTS);
+        if (val & ~old_slt_sta & PCIE_SLOT_EVENTS) {
+            sltsta = (sltsta & ~PCIE_SLOT_EVENTS) | (old_slt_sta & PCIE_SLOT_EVENTS);
             pci_set_word(exp_cap + PCI_EXP_SLTSTA, sltsta);
         }
         hotplug_event_clear(dev);
@@ -646,13 +647,17 @@ void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slt_ctl, uint16_t slt_s
     }
 
     /*
-     * If the slot is polulated, power indicator is off and power
+     * If the slot is populated, power indicator is off and power
      * controller is off, it is safe to detach the devices.
+     *
+     * Note: don't detach if condition was already true:
+     * this is a work around for guests that overwrite
+     * control of powered off slots before powering them on.
      */
     if ((sltsta & PCI_EXP_SLTSTA_PDS) && (val & PCI_EXP_SLTCTL_PCC) &&
         (val & PCI_EXP_SLTCTL_PIC_OFF) == PCI_EXP_SLTCTL_PIC_OFF &&
-        (!(slt_ctl & PCI_EXP_SLTCTL_PCC) ||
-        (slt_ctl & PCI_EXP_SLTCTL_PIC_OFF) != PCI_EXP_SLTCTL_PIC_OFF)) {
+        (!(old_slt_ctl & PCI_EXP_SLTCTL_PCC) ||
+        (old_slt_ctl & PCI_EXP_SLTCTL_PIC_OFF) != PCI_EXP_SLTCTL_PIC_OFF)) {
         PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
         pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
                             pcie_unplug_device, NULL);
-- 
MST

