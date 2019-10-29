Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316DFCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073D02086A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073D02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPahX-0005kW-Kt
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaTU-0008BH-9f
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaTO-0003Fg-9h
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaTK-0003A3-6Y
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:20 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 67FA1C056807
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:00:15 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id p68so269473qkf.9
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H3q8OWUdteaAjDBaTxa/GS8RhYWnQs5bsyBylGoVtsE=;
 b=Df9UJb5Uw2CDw9mdbkuTCacSDuFz7VjdMLCtY4wU8LtzwaytvNy9aqAuC/aOXc34gx
 ynGivNjSMeYbtOSEvhl6PNrPs2mPX7a1ipxn1TSwD/ZqkN76UsQlQXZM+iVGGUf8hPQH
 5+OfAY+eHGXYmJuyJDicUt1QELjWjxHRl9zmfpU99EHn9RSV0/I/oJkqi/oKf7NSrr4L
 8CW8dQQ9HGrs5OBq2iCUZk5oVer11u4qwWw68lQeSCkEq+wZRkDC6cVRAsrURdtZmZ3Q
 OWNkGxCCyWwemEUETbpVSdkbpEyI4ugrWoKmLeYRCidiDji+TKgzpoa1JYf3xA3gwllB
 82XA==
X-Gm-Message-State: APjAAAVUcjZyhYcxJCTr0y5ZI0uH4fTNjoFLv34wsAb3wo/YHCxozw8K
 F3GGsP2prKJx1mBrEIGTM8cqbshb4eEqCblsOjqJrqqTdg4+i7Ie2LSgJjtY62RZpMhypCGir7x
 Nrj3PsgDRykZsgXA=
X-Received: by 2002:a05:6214:14ac:: with SMTP id
 bo12mr24832172qvb.67.1572390014352; 
 Tue, 29 Oct 2019 16:00:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwqQjc1abgL7dxAd/q6ukrzDnthCNOQ8JlwXQ/kBuMl0R9gJ0MbIEms4NshxBpdQI9Gmw0bow==
X-Received: by 2002:a05:6214:14ac:: with SMTP id
 bo12mr24832144qvb.67.1572390014076; 
 Tue, 29 Oct 2019 16:00:14 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id k18sm80584qtj.69.2019.10.29.16.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 16:00:13 -0700 (PDT)
Date: Tue, 29 Oct 2019 19:00:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/14] pci: add option for net failover
Message-ID: <20191029225932.14585-3-mst@redhat.com>
References: <20191029225932.14585-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029225932.14585-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jens Freimann <jfreimann@redhat.com>

This patch adds a failover_pair_id property to PCIDev which is
used to link the primary device in a failover pair (the PCI dev) to
a standby (a virtio-net-pci) device.

It only supports ethernet devices. Also currently it only supports
PCIe devices. The requirement for PCIe is because it doesn't support
other hotplug controllers at the moment. The failover functionality can
be added to other hotplug controllers like ACPI, SHCP,... later on.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Message-Id: <20191029114905.6856-3-jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c         | 31 +++++++++++++++++++++++++++++++
 include/hw/pci/pci.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index aa05c2b9b2..824ab4ed7b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -75,6 +75,8 @@ static Property pci_props[] = {
                     QEMU_PCIE_LNKSTA_DLLLA_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-extcap-init", PCIDevice, cap_present,
                     QEMU_PCIE_EXTCAP_INIT_BITNR, true),
+    DEFINE_PROP_STRING("failover_pair_id", PCIDevice,
+                       failover_pair_id),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -2077,6 +2079,7 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     ObjectClass *klass = OBJECT_CLASS(pc);
     Error *local_err = NULL;
     bool is_default_rom;
+    uint16_t class_id;
 
     /* initialize cap_present for pci_is_express() and pci_config_size(),
      * Note that hybrid PCIs are not set automatically and need to manage
@@ -2101,6 +2104,34 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
+    if (pci_dev->failover_pair_id) {
+        if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
+            error_setg(errp, "failover primary device must be on "
+                             "PCIExpress bus");
+            error_propagate(errp, local_err);
+            pci_qdev_unrealize(DEVICE(pci_dev), NULL);
+            return;
+        }
+        class_id = pci_get_word(pci_dev->config + PCI_CLASS_DEVICE);
+        if (class_id != PCI_CLASS_NETWORK_ETHERNET) {
+            error_setg(errp, "failover primary device is not an "
+                             "Ethernet device");
+            error_propagate(errp, local_err);
+            pci_qdev_unrealize(DEVICE(pci_dev), NULL);
+            return;
+        }
+        if (!(pci_dev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION)
+            && (PCI_FUNC(pci_dev->devfn) == 0)) {
+            qdev->allow_unplug_during_migration = true;
+        } else {
+            error_setg(errp, "failover: primary device must be in its own "
+                              "PCI slot");
+            error_propagate(errp, local_err);
+            pci_qdev_unrealize(DEVICE(pci_dev), NULL);
+            return;
+        }
+    }
+
     /* rom loading */
     is_default_rom = false;
     if (pci_dev->romfile == NULL && pc->romfile != NULL) {
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f3f0ffd5fb..69d1f0228b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -352,6 +352,9 @@ struct PCIDevice {
     MSIVectorUseNotifier msix_vector_use_notifier;
     MSIVectorReleaseNotifier msix_vector_release_notifier;
     MSIVectorPollNotifier msix_vector_poll_notifier;
+
+    /* ID of standby device in net_failover pair */
+    char *failover_pair_id;
 };
 
 void pci_register_bar(PCIDevice *pci_dev, int region_num,
-- 
MST


