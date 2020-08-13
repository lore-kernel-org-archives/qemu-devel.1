Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D14BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473F620781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="ewSPeLo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473F620781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k67CJ-00042U-Fq
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 02:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1k673e-0006ih-LU
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:50 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231]:42702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1k673c-0004ex-IJ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:50 -0400
Received: by mail-lj1-x231.google.com with SMTP id t6so4957419ljk.9
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o/A8FCyx+K32letLTQoKf/IgU57Dq8E7yF9o2orHsiw=;
 b=ewSPeLo5EhPIN/7AP0I/Y5cOerQRZPGyY3fgNl7lE1vGwfbqwnwuZq8sC74i8ajHNz
 cva0XPmUrihN/7QwKSz16z7mkpqWHZkjnmLO7IuyvveUHbwnpwtCFDuzXEffXtx0QGhO
 sK1JhcI46eq7K/WmSo5E6Y8Wf3vHOPf7BN3FtR4K0unA3pon3I+sD9cQN9tfCY5BBPwg
 vowahzY4gh0Fhp5/5CbFhj/ICPK1koRAVDpMFKiygJlaoA/Hc2u6Sdwm6/6rviL8pONw
 wNAZekmg/AYNQjhX8+7Hn+kBHRogbJpp3WBOUhH/rFk+1Ugb+THP3hAc/rNiHkP2tdwp
 p+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o/A8FCyx+K32letLTQoKf/IgU57Dq8E7yF9o2orHsiw=;
 b=s30OoWOuL4WCcFvU2G42EWhtjkh0YRAP9Sb3yjNnDsIuDcsMBef0bhsDNBAQ4O4MUF
 JTn4FVTyC+mBrk7vWhD6zo07S5q4sgi9xEIrjjZTytlbsBs5rlTtl+KAanmW3XTr9E+m
 aUxBIiO0CZSNuoIATiaPORpDRTPrD5LfDcyLrnOOvVpFtdXRdQJKlURz9Tm378VtROd9
 d3QsY0s5VaRrZONBry28rnf4GCW85irMH8cncXZRHYHLmd/uRrRG2hdKOjbkC9m6znjA
 J46gHf5LkwrpsH0GhgBYykFNeQzWBLS/tfTaiUBWXx2Vym7S9jPXKOSvQTBUCq8Cs3IJ
 /Rng==
X-Gm-Message-State: AOAM5333g8HFGjIrdS47T1iywbs18FF8390f8053tg+p/sKcMAd/TBs8
 w5hykgIpwWzVV6TQ16kA9GHvhOzV35w=
X-Google-Smtp-Source: ABdhPJx3HxbmxRDGLL5YWfUH61KXUxVWONlzRJj2clQ02RdICEzNsoz9Pbw2fxFaajv0b7nKtS8SSw==
X-Received: by 2002:a2e:a54f:: with SMTP id e15mr1182682ljn.115.1597301381288; 
 Wed, 12 Aug 2020 23:49:41 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id e25sm890794ljp.47.2020.08.12.23.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 23:49:40 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/virtio-pci Added AER capability.
Date: Thu, 13 Aug 2020 10:19:31 +0300
Message-Id: <20200813071931.19846-2-andrew@daynix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200813071931.19846-1-andrew@daynix.com>
References: <20200813071931.19846-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::231;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x231.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew <andrew@daynix.com>

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1857668
Added AER capability for virtio-pci devices.
Also added property for devices, by default AER is enabled.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/virtio/virtio-pci.c | 16 ++++++++++++++++
 hw/virtio/virtio-pci.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 8e02709605..646dfb8a0d 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1806,6 +1806,12 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
          */
         pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
 
+        if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
+            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
+                          PCI_ERR_SIZEOF, NULL);
+            last_pcie_cap_offset += PCI_ERR_SIZEOF;
+        }
+
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
             /* Init error enabling flags */
             pcie_cap_deverr_init(pci_dev);
@@ -1847,7 +1853,15 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 
 static void virtio_pci_exit(PCIDevice *pci_dev)
 {
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
+    bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
+                     !pci_bus_is_root(pci_get_bus(pci_dev));
+
     msix_uninit_exclusive_bar(pci_dev);
+    if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
+        pci_is_express(pci_dev)) {
+        pcie_aer_exit(pci_dev);
+    }
 }
 
 static void virtio_pci_reset(DeviceState *qdev)
@@ -1900,6 +1914,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
     DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
+    DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_AER_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index e2eaaa9182..4b2491ff15 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -45,6 +45,7 @@ enum {
     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
     VIRTIO_PCI_FLAG_INIT_PM_BIT,
     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
+    VIRTIO_PCI_FLAG_AER_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -84,6 +85,9 @@ enum {
 /* Init Function Level Reset capability */
 #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
 
+/* Advanced Error Reporting capability */
+#define VIRTIO_PCI_FLAG_AER (1 << VIRTIO_PCI_FLAG_AER_BIT)
+
 typedef struct {
     MSIMessage msg;
     int virq;
-- 
2.27.0


