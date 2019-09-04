Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10616C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEFF22DBF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEFF22DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5U18-0007Qv-P1
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 08:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i5TyS-0006AZ-Nb
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i5TyQ-0002QO-9B
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i5TyP-0002K6-SY
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:18 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C0349C034E71
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 12:01:09 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id o133so22807529qke.4
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 05:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X9XmHG9IenejdNjceVKSVG6airvhvIr2qQFz1tJGSd0=;
 b=J9Gdgza+VRFxqpSASq2lQ3NOmIzTCsVSCWZUL4DxMqTnoqj/WIa7DtFUVKbVmAvAef
 j/jbcLEqCnUB8sikN2buZMPwYf5xHjW51FNiOwX4FCBnVK4swPDVC01JTWZO6oUvSOPX
 4bLm0Nd1n7FZgdc55sz49htgyZWM7jx4SO31XLf0XWNaFz4OqX8kjNGpyf2mlQ6RCR35
 brJJ5VUNZJH++l0j95v0skB7F3A8aybD7UDiXpeWEK+m5e9zkN7/dtKsFAMZDWmwsbl4
 MayY1Od80JOOhE3WfEFZ1kvjZI0Ze+ICX8m3v8DTZAaS32K/HNruMx1oyfD0QeHVWPrN
 GQRQ==
X-Gm-Message-State: APjAAAVSg6MfaV1aiTmsUd0PNwZ3phc3W+QhoH/jpldVfx/hgxDpjozq
 XziW9dVCElLKEutcoPLjS3xl6NdsGMc1uqzqC0lUTx7n1qH9qbRvGW/TagLk58e13AWJJrZz4Ou
 93bSqqJlWyVwtilE=
X-Received: by 2002:a37:ef17:: with SMTP id j23mr10993842qkk.426.1567598468543; 
 Wed, 04 Sep 2019 05:01:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxBS/ElY7imbNqpgfKMgIzTfl7so2XQ9nZ5HW9eTjBYQZC3o3c/X0/VXbut+xJn3VEgJRpmdA==
X-Received: by 2002:a37:ef17:: with SMTP id j23mr10993822qkk.426.1567598468376; 
 Wed, 04 Sep 2019 05:01:08 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id d19sm2023498qkk.101.2019.09.04.05.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 05:01:07 -0700 (PDT)
Date: Wed, 4 Sep 2019 08:01:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190820163005.1880-1-jusual@redhat.com>
References: <20190904120026.3220-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190904120026.3220-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/6] virtio-pci: Add Function Level Reset support
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
 Julia Suvorova <jusual@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190904120103.n65AHfxkqLCwWXYPslgMzvDspXGb0bpnl5TEognppNw@z>

From: Julia Suvorova <jusual@redhat.com>

Using FLR becomes convenient in cases where resetting the bus is
impractical, for example, when debugging the behavior of individual
functions.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
Message-Id: <20190820163005.1880-1-jusual@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/core/machine.c      |  4 +++-
 hw/virtio/virtio-pci.c | 10 ++++++++++
 hw/virtio/virtio-pci.h |  4 ++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 83cd1bfeec..829ada099e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -27,7 +27,9 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 
-GlobalProperty hw_compat_4_1[] = {};
+GlobalProperty hw_compat_4_1[] = {
+    { "virtio-pci", "x-pcie-flr-init", "off" },
+};
 const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);
 
 GlobalProperty hw_compat_4_0[] = {
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 8babd92e59..0075b3e2af 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -601,6 +601,10 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
 
     pci_default_write_config(pci_dev, address, val, len);
 
+    if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
+        pcie_cap_flr_write_config(pci_dev, address, val, len);
+    }
+
     if (range_covers_byte(address, len, PCI_COMMAND) &&
         !(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
         virtio_pci_stop_ioeventfd(proxy);
@@ -1777,6 +1781,10 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
             pcie_ats_init(pci_dev, 256);
         }
 
+        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
+            /* Set Function Level Reset capability bit */
+            pcie_cap_flr_init(pci_dev);
+        }
     } else {
         /*
          * make future invocations of pci_is_express() return false
@@ -1844,6 +1852,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
+    DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 292275acb1..e2eaaa9182 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -44,6 +44,7 @@ enum {
     VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
     VIRTIO_PCI_FLAG_INIT_PM_BIT,
+    VIRTIO_PCI_FLAG_INIT_FLR_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -80,6 +81,9 @@ enum {
 /* Init Power Management */
 #define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
 
+/* Init Function Level Reset capability */
+#define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
+
 typedef struct {
     MSIMessage msg;
     int virq;
-- 
MST


