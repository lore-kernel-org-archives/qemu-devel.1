Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933DACA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623C321655
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623C321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOUX4-0006hW-Fu
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iOTzP-0006H1-JO
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iOTzO-0003bL-6V
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:52:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iOTzN-0003bD-UK
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:52:50 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E11FC049E12
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 21:52:49 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id g65so6336265qkf.19
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 14:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KFQvXXlh3AUO8PkJPwkcMnBMnk/jbSrzCNkhQl517ZU=;
 b=mE7LjRH4vBWgFqiqDPEHhkLWiyhh6ZGKXpn5O6cwryvB0gsUCw4N6SPwoKoxZQ4mZq
 K76BWfhl9gBaFIP6Fnw8DU7tuoNxKJX/uqpWlQTjujwdTFiP/XJNFUybOEaC8Yhyz53k
 VgFCkODI9pI43FtQKO41jm+IQWgTA1qc2JRn+Rs0Tt2tq4CvtBXtJj9nt1JVhzCe0a7o
 3svsJNgtjYHteUYJWRQG1+BqYmZDkH8eVlFAMq3tmPmFWNO8seQFfMHDyjuIv9Gu56cb
 YrxWd7Ib/PiYpXxyYXcQmaOsPyI10Jc3rjqN2WnN34jpoTy3PkgcfjK24ODwhIXP64e9
 q32Q==
X-Gm-Message-State: APjAAAVVPyGp2V0eYTTcjSj3zbv8HoR9+3w7uWZ2mcTSzNYup4qfghiN
 wYZ2oMZ4DxvfiI6LaaCQCAOsYjEbgvPLErfWUGK7sX5OuUFybLsmLItKLtsvZDWuBw9zBEiBsUa
 pugNLfDRb7ZuD8do=
X-Received: by 2002:aed:3c67:: with SMTP id u36mr10296162qte.142.1572126768036; 
 Sat, 26 Oct 2019 14:52:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxbYJmyL89+EriRcJtmaK7c0yit0OyMYeO+9vkjvtrWpYZTsVxfCRKk1HZnGhkK9TIxmawGFQ==
X-Received: by 2002:aed:3c67:: with SMTP id u36mr10296153qte.142.1572126767842; 
 Sat, 26 Oct 2019 14:52:47 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 x8sm3484675qkx.77.2019.10.26.14.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 14:52:47 -0700 (PDT)
Date: Sat, 26 Oct 2019 17:52:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/25] libqos: add iteration support to qpci_find_capability()
Message-ID: <20191026193824.11926-19-mst@redhat.com>
References: <20191026193824.11926-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026193824.11926-1-mst@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

VIRTIO 1.0 PCI devices have multiple PCI_CAP_ID_VNDR capabilities so we
need a way to iterate over them.  Extend qpci_find_capability() to take
the last address.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
--
v3:
 * Document qpci_find_capability()
Message-Id: <20191023100425.12168-11-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/libqos/pci.c | 30 ++++++++++++++++++++++++------
 tests/libqos/pci.h |  2 +-
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
index 662ee7a517..2309a724e4 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -115,10 +115,28 @@ void qpci_device_enable(QPCIDevice *dev)
     g_assert_cmphex(cmd & PCI_COMMAND_MASTER, ==, PCI_COMMAND_MASTER);
 }
 
-uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id)
+/**
+ * qpci_find_capability:
+ * @dev: the PCI device
+ * @id: the PCI Capability ID (PCI_CAP_ID_*)
+ * @start_addr: 0 to begin iteration or the last return value to continue
+ *              iteration
+ *
+ * Iterate over the PCI Capabilities List.
+ *
+ * Returns: PCI Configuration Space offset of the capabililty structure or
+ *          0 if no further matching capability is found
+ */
+uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_addr)
 {
     uint8_t cap;
-    uint8_t addr = qpci_config_readb(dev, PCI_CAPABILITY_LIST);
+    uint8_t addr;
+
+    if (start_addr) {
+        addr = qpci_config_readb(dev, start_addr + PCI_CAP_LIST_NEXT);
+    } else {
+        addr = qpci_config_readb(dev, PCI_CAPABILITY_LIST);
+    }
 
     do {
         cap = qpci_config_readb(dev, addr);
@@ -138,7 +156,7 @@ void qpci_msix_enable(QPCIDevice *dev)
     uint8_t bir_table;
     uint8_t bir_pba;
 
-    addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX);
+    addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=, 0);
 
     val = qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
@@ -167,7 +185,7 @@ void qpci_msix_disable(QPCIDevice *dev)
     uint16_t val;
 
     g_assert(dev->msix_enabled);
-    addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX);
+    addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=, 0);
     val = qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
     qpci_config_writew(dev, addr + PCI_MSIX_FLAGS,
@@ -203,7 +221,7 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
     uint64_t vector_off = dev->msix_table_off + entry * PCI_MSIX_ENTRY_SIZE;
 
     g_assert(dev->msix_enabled);
-    addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX);
+    addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=, 0);
     val = qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
 
@@ -221,7 +239,7 @@ uint16_t qpci_msix_table_size(QPCIDevice *dev)
     uint8_t addr;
     uint16_t control;
 
-    addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX);
+    addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=, 0);
 
     control = qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
index a5389a5845..590c175190 100644
--- a/tests/libqos/pci.h
+++ b/tests/libqos/pci.h
@@ -86,7 +86,7 @@ bool qpci_has_buggy_msi(QPCIDevice *dev);
 bool qpci_check_buggy_msi(QPCIDevice *dev);
 
 void qpci_device_enable(QPCIDevice *dev);
-uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id);
+uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_addr);
 void qpci_msix_enable(QPCIDevice *dev);
 void qpci_msix_disable(QPCIDevice *dev);
 bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry);
-- 
MST


